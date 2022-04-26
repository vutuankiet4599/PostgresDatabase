alter table tai_khoan disable trigger all;
alter table khach_hang disable trigger all;
alter table log_chuyen_tien disable trigger all;
alter table log_nap_rut disable trigger all;
alter table log_dich_vu disable trigger all;
alter table dich_vu disable trigger all;

delete from khach_hang;
delete from tai_khoan;
delete from log_chuyen_tien;
delete from log_dich_vu;
delete from log_nap_rut;
delete from dich_vu;

alter table tai_khoan enable trigger all;
alter table khach_hang enable trigger all;
alter table log_chuyen_tien enable trigger all;
alter table log_nap_rut enable trigger all;
alter table log_dich_vu enable trigger all;
alter table dich_vu enable trigger all;