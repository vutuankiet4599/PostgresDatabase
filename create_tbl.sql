create table khach_hang(
	id_khach serial,
	ho_ten varchar(50),
	ngay_sinh date,
	gioi_tinh varchar(3),
	dia_chi varchar(100),
	CCCD char(12),
	sdt varchar(12),
	constraint pk_khach primary key(id_khach)
);
create table tai_khoan(
	id_tai_khoan serial,
	id_khach serial,
	ngay_dang_ky date,
	tien_du numeric default 0,
	constraint pk_tai_khoan primary key(id_tai_khoan),
	constraint fk_tk_kh foreign key (id_khach) references khach_hang(id_khach)
);
create table log_chuyen_tien(
	id_luot_chuyen serial,
	id_tk_gui serial,
	id_tk_nhan serial,
	thoi_gian timestamp,
	so_tien_chuyen numeric,
	constraint pk_chuyen_tien primary key(id_luot_chuyen),
	constraint fk_ct_tk foreign key (id_tk_gui) references tai_khoan(id_tai_khoan),
	constraint fk_nt_tk foreign key (id_tk_nhan) references tai_khoan(id_tai_khoan)
);
create table log_nap_rut(
	id_gui_rut serial,
	id_tai_khoan serial,
	thoi_gian timestamp,
	so_tien numeric,
	ghi_chu char(3),
	constraint pk_gui_rut primary key(id_gui_rut),
	constraint chk_gui_rut check (ghi_chu in ('Nạp', 'Rút')),
	constraint fk_gr_tk foreign key (id_tai_khoan) references tai_khoan(id_tai_khoan)
);
create table dich_vu(
	id_dich_vu serial,
	mo_ta varchar(50),
	don_gia numeric default 0,
	constraint pk_dich_vu primary key (id_dich_vu)
);
create table log_dich_vu(
	id_don_hang serial,
	id_tai_khoan serial,
	id_dich_vu serial,
	thoi_gian timestamp,
	so_luong int,
	tong_tien numeric,
	constraint pk_log_dv primary key(id_don_hang),
	constraint fk_dv_tk foreign key (id_tai_khoan) references tai_khoan(id_tai_khoan),
	constraint fk_log_dv foreign key (id_dich_vu) references dich_vu(id_dich_vu)
);