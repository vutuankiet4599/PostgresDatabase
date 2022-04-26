drop function if exists info_tai_khoan;
drop function if exists his_chuyen_tien;
drop function if exists his_nap_rut;
drop function if exists his_thanh_toan;

create or replace function info_tai_khoan(id_tai_khoan int)
returns table(ten_nguoi_dung varchar(50), gioi_tinh varchar(3), ngay_sinh date, dia_chi varchar(100), cccd char(12), so_dien_thoai varchar(12), tai_khoan int, ngay_dang_ky_tk date, tien_du numeric)
language plpgsql
as
$$
begin
	return query
	select kh.ho_ten, kh.gioi_tinh, kh.ngay_sinh, kh.dia_chi, kh.cccd, kh.sdt, tk.id_tai_khoan, tk.ngay_dang_ky, tk.tien_du
	from tai_khoan tk, khach_hang kh
	where tk.id_tai_khoan = $1 and tk.id_khach = kh.id_khach;
end;
$$;

create or replace function his_chuyen_tien(id_tai_khoan int)
returns table(tai_khoan_gui int, tai_khoan_nhan int, so_tien_chuyen numeric, ngay_giao_dich timestamp)
language plpgsql
as
$$
begin
	return query
	select id_tk_gui, id_tk_nhan, l.so_tien_chuyen, thoi_gian
	from log_chuyen_tien l
	where id_tk_gui = $1 or id_tk_nhan = $1;
end;
$$;

create or replace function his_nap_rut(id_tai_khoan int)
returns table(tai_khoan int, so_tien numeric, ngay_giao_dich timestamp, hinh_thuc char(3))
language plpgsql
as
$$
begin
	return query
	select l.id_tai_khoan, l.so_tien, thoi_gian, ghi_chu
	from log_nap_rut l
	where l.id_tai_khoan = $1;
end;
$$;

create or replace function his_thanh_toan(id_tai_khoan int)
returns table(tai_khoan int, ten_dich_vu varchar(50), so_luong int, ngay_giao_dich timestamp, tong_tien numeric)
language plpgsql
as
$$
begin
	return query
	select l.id_tai_khoan, d.mo_ta, l.so_luong, l.thoi_gian, l.tong_tien
	from log_dich_vu l, dich_vu d
	where l.id_tai_khoan = $1 and l.id_dich_vu = d.id_dich_vu;
end;
$$;