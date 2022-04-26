alter table tai_khoan disable trigger all;
alter table khach_hang disable trigger all;
alter table log_chuyen_tien disable trigger all;
alter table log_nap_rut disable trigger all;
alter table log_dich_vu disable trigger all;
alter table dich_vu disable trigger all;

drop table if exists khach_hang cascade;
drop table if exists tai_khoan cascade;
drop table if exists log_chuyen_tien cascade;
drop table if exists log_nap_rut cascade;
drop table if exists log_dich_vu cascade;
drop table if exists dich_vu cascade;

drop trigger if exists update_chuyen_tien on log_chuyen_tien cascade;
drop trigger if exists update_nap_rut on log_nap_rut cascade;
drop trigger if exists update_dich_vu on log_dich_vu cascade;
drop function if exists update_chuyen_tien;
drop function if exists update_nap_rut;
drop function if exists update_dich_vu;

drop function if exists chuyen_tien;
drop function if exists nap_rut;
drop function if exists thanh_toan;
