drop function if exists chuyen_tien;
drop function if exists nap_rut;
drop function if exists thanh_toan;


create or replace function chuyen_tien(id_gui int, id_nhan int, tien_chuyen numeric)
returns void
as
$$
declare
	time_now timestamp := current_timestamp(0);
begin
	if 
	(select tien_du
	from tai_khoan
	where id_tai_khoan = $1) >= tien_chuyen 
	AND EXISTS(
	select id_tai_khoan
	from tai_khoan
	where id_tai_khoan = $2)
	then
		insert into log_chuyen_tien(id_tk_gui,id_tk_nhan,thoi_gian,so_tien_chuyen)
		values($1,$2,time_now,$3);
	end if;
	return;
end;
$$ language plpgsql;

create or replace function nap_rut(id_thuc_hien int, so_tien numeric, ghi_chu text)
returns void
as
$$
declare
	time_now timestamp := current_timestamp(0);
begin
	if ghi_chu = 'Nạp' then
		insert into log_nap_rut(id_tai_khoan,thoi_gian,so_tien,ghi_chu)
		values($1,time_now,$2,$3);
	end if;
	if ghi_chu = 'Rút' AND
	(select tien_du
	from tai_khoan
	where id_tai_khoan = $1) >= $2 then
		insert into log_nap_rut(id_tai_khoan,thoi_gian,so_tien,ghi_chu)
		values($1,time_now,$2,$3);
	end if;
	return;
end;
$$ language plpgsql;

create or replace function thanh_toan(id_tk_thuc_hien int, id_dv_thuc_hien int, number int)
returns void
as
$$
declare
	time_now timestamp := current_timestamp(0);
	tong_tien int := $3 * (select don_gia
	from dich_vu
	where id_dich_vu = $2);
begin
	if (select tien_du
	from tai_khoan
	where id_tai_khoan = $1) >= tong_tien then
		insert into log_dich_vu(id_tai_khoan,id_dich_vu,thoi_gian,so_luong,tong_tien)
		values($1,$2,time_now,$3,tong_tien);
	end if;
	return;
end;
$$ language plpgsql;