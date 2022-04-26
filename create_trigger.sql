drop trigger if exists update_chuyen_tien on log_chuyen_tien cascade;
drop trigger if exists update_nap_rut on log_nap_rut cascade;
drop trigger if exists update_dich_vu on log_dich_vu cascade;
drop function if exists update_chuyen_tien;
drop function if exists update_nap_rut;
drop function if exists update_dich_vu;

create or replace function update_chuyen_tien()
returns trigger
language plpgsql
as
$$
begin
	update tai_khoan
	set tien_du = tien_du + new.so_tien_chuyen
	where id_tai_khoan = new.id_tk_nhan;
	
	update tai_khoan
	set tien_du = tien_du - new.so_tien_chuyen
	where id_tai_khoan = new.id_tk_gui;
	return null;
end;
$$;

create or replace trigger update_chuyen_tien
after insert on log_chuyen_tien 
for each row
execute procedure update_chuyen_tien();

create or replace function update_nap_rut()
returns trigger
language plpgsql
as
$$
begin
	if (new.ghi_chu = 'Nạp')
	then
		update tai_khoan
		set tien_du = tien_du + new.so_tien
		where id_tai_khoan = new.id_tai_khoan;
	end if;
	if (new.ghi_chu = 'Rút')
	then
		update tai_khoan
		set tien_du = tien_du - new.so_tien
		where id_tai_khoan = new.id_tai_khoan;
	end if;
	return null;
end;
$$;

create or replace trigger update_nap_rut
after insert on log_nap_rut
for each row
execute procedure update_nap_rut();

create or replace function update_dich_vu()
returns trigger
language plpgsql
as
$$
begin
	update tai_khoan
	set tien_du = tien_du - new.tong_tien
	where id_tai_khoan = new.id_tai_khoan;
	return null;
end;
$$;

create or replace trigger update_dich_vu
after insert on log_dich_vu
for each row
execute procedure update_dich_vu();