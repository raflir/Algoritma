program PasienRawatInap;
uses crt,sysutils;

const
  //nama_file = 'E:\DataMahasiswa\Tugas\Alpro\tugas_besar\data_pasien.txt';
  nama_file = 'datapasien.txt' ;
  Maks_pasien = 200;
type
  dt_pasien = record
    id_pasien, Nama_pasien : string;
    kelas, kamar           : string;
    harga,total            : integer;
  end;

  arr_pasien = array [1..Maks_pasien] of dt_pasien;

var
  Pasien           : arr_pasien;
  N,Menu,pilihan   : integer;
  file_pasien      : file of dt_pasien;
  NmP,NmK          : string; //NmP = Nama pasien, NmK = Nama kamar
  i,jumlah         : integer;

//fungsi kamar
function kamar(kelas:string):string;
{I.S. : kelas sudah terdefinisi}
{F.S. : menghasilkan fungsi Kamar}
begin
  if (uppercase(kelas) = 'VIP')
  then
    kamar := 'Anggrek'
  else
    if (kelas = '1')
    then
      kamar := 'Sakura'
    else
      if (kelas = '2')
      then
        kamar := 'Mawar'
      else
        if (kelas = '3')
        then
          kamar := 'Flamboyan';
end;

//fungsi harga
function harga(kelas:string):integer;
{I.S. : kelas sudah terdefinisi}
{F.S. : menghasilkan fungsi Harga kamar per hari}
begin
  if (uppercase(kelas) = 'VIP')
  then
    harga := 200000
  else
    if (kelas = '1')
    then
      harga := 125000
    else
      if (kelas = '2')
      then
        harga := 75000
      else
        if (kelas = '3')
        then
          harga := 35000;
end;

//prosedure Menu Pilihan
procedure MenuPilihan (var Menu: integer);
{I.S. : User memilih salah satu menu}
{F.S. : Menampilkan hasil sesuai menu yang dipilih}
begin
    gotoxy(14,4);write('|=================================================|');
    gotoxy(14,5);write('|============== PROGRAM RAWAT INAP ===============|');
    gotoxy(14,6);write('|=================================================|');
    gotoxy(14,7);write('|                  MENU PILIHAN                   |');
    gotoxy(14,8);write('|-------------------------------------------------|');
    gotoxy(14,9);write('|  1. ISI DATA PASIEN                             |');
    gotoxy(14,10);write('|  2. CARI BERDASARKAN ID                         |');
    gotoxy(14,11);write('|  3. CARI BERDASARKAN NAMA                       |');
    gotoxy(14,12);write('|  4. CARI BERDASARKAN KAMAR                      |');
    gotoxy(14,13);write('|  5. TAMPIL DATA KESELURUHAN YANG SUDAH TERURUT  |');
    gotoxy(14,14);write('|  0. Keluar                                      |');
    gotoxy(14,15);write('|-------------------------------------------------|');
    gotoxy(14,16);write('|  PILIHAN ANDA?                                  |');
    gotoxy(14,17);write('|=================================================|');
    gotoxy(30,16);readln(Menu);
    //validasi Menu Pilihan
    while (Menu < 0) or (menu > 5) do
    begin
       gotoxy(14,18);
       write('Pilihan Hanya Boleh 0/1/2/3/4/5 ulangi Tekan Enter !');
       readln;
       gotoxy(30,16);clreol;
       gotoxy(14,16);
       write('|  PILIHAN ANDA?                                  |');
       gotoxy(14,18);clreol;
       gotoxy(30,16);readln(Menu);
    end;
end;

//prosedure buka file
procedure buka_file;
var
  i: integer;
begin
 assign(file_pasien, Nama_file);
 {$I-}
 reset(file_pasien);
 {$I+}
 if (ioresult <> 0) then begin
    writeln('Terjadi Kesalahan File!!');
    rewrite(file_Pasien);
  end
  else
  begin
    i:=1;
    n:=filesize(file_pasien);
    seek(file_Pasien,0);
    while not eof(file_pasien) do
    begin
      seek(file_pasien,i-1);
      read(file_pasien,pasien[i]);
      i:=i+1;
  end;
  end;
end;

//prosedure Memasukan data pasien
procedure IsiDataPasien (var jumlah:integer; var pasien:arr_pasien);
{I.S. : User mamasukan Jumlah pasien & array pasien (1:Jumlah)}
{F.S. : Menghasilakan array pasien (1:jumlah)}
var
  i : integer;
begin
  clrscr;
  buka_file; //memanggil prosedur buka file
  rewrite(file_pasien);
  writeln('Maksimal data = ',Maks_pasien);
  write('Banyaknya Data Pasien : '); readln(jumlah);
  while (jumlah<1) or (jumlah>Maks_pasien) do
  begin
    write('Banyaknya Data Pasien Hanya Boleh Antara 1-200 !');
    readln;
    gotoxy(1,3);clreol;
    gotoxy(25,2);clreol;
    readln(jumlah);
  end;
  clrscr;
  gotoxy(34,1);Write('DAFTAR PASIEN');
  gotoxy(33,2);Write('===============');
  gotoxy(13,3);
  write('======================================================');
  gotoxy(13,4);
  write('|  ID  |       NAMA PASIEN       | KELAS |   KAMAR   |');
  gotoxy(13,5);
  write('------------------------------------------------------');
  for i := 1 to jumlah do
  begin
    gotoxy(13,i+5);
    write('|      |                         |       |           |');
    gotoxy(13,i+15);writeln('Petunjuk Pengisian ID Pasien:');
    gotoxy(13,i+16);writeln('- ID pasien terdiri 4 digit gabungan antara huruf & angka');
    gotoxy(13,i+17);writeln('- Contoh : B135');
    gotoxy(15,i+5);readln(Pasien[i].id_pasien);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    gotoxy(13,i+17);clreol;
    gotoxy(13,i+15);writeln('Petunjuk Pengisian Nama:');
    gotoxy(13,i+16);writeln('- Harap tidak mengisi nama melebihi batas');
    gotoxy(22,i+5);readln(Pasien[i].Nama_pasien);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    gotoxy(13,i+15);writeln('Petunjuk Pengisian Kelas:');
    gotoxy(13,i+16);writeln('- kelas hanya boleh diisi dengan VIP/1/2/3');
    gotoxy(48,i+5);readln(pasien[i].kelas);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    while (uppercase(pasien[i].kelas) <> 'VIP') and (pasien[i].kelas <> '1') and
          (pasien[i].kelas <> '2') and (pasien[i].kelas <> '3') do
    begin
      gotoxy(13,i+6);
      write('Kelas hanya boleh tersedia VIP/1/2/3, ulangi tekan Enter!');
      readln;
      gotoxy(13,i+6);clreol;
      gotoxy(46,i+5);clreol;
      write('|       |           |');
      gotoxy(48,i+5);readln(pasien[i].kelas);
    end;
    pasien[i].kamar := kamar(pasien[i].kelas);
    gotoxy(56,i+5);writeln(pasien[i].kamar);
    seek(file_pasien, filesize(file_pasien));
    write(file_pasien,Pasien[i]);
  end;
  gotoxy(13,i+6);
  writeln('======================================================');
  gotoxy(13,i+7);writeln('Lanjutkan tekan Enter..');
  close(file_pasien);
end;

//prosedure Memasukan data pasien
procedure tambahDataPasien (var n:integer; var pasien:arr_pasien);
{I.S. : User mamasukan Jumlah pasien & array pasien (1:Jumlah)}
{F.S. : Menghasilakan array pasien (1:jumlah)}
var
  i,batas : integer;
begin
  clrscr;
  buka_file; //memanggil prosedur buka file
  batas := Maks_pasien - n;
  writeln('Maksimal data yg bisa ditambahkan = ',batas);
  write('Banyaknya Data Pasien : '); readln(jumlah);
  while (jumlah<1) or (jumlah>batas) do
  begin
    write('Banyaknya Data Pasien Hanya Boleh Antara 1-',batas,'!');
    readln;
    gotoxy(1,3);clreol;
    gotoxy(25,2);clreol;
    readln(jumlah);
  end;
  clrscr;
  gotoxy(34,1);Write('DAFTAR PASIEN');
  gotoxy(33,2);Write('===============');
  gotoxy(13,3);
  write('======================================================');
  gotoxy(13,4);
  write('|  ID  |       NAMA PASIEN       | KELAS |   KAMAR   |');
  gotoxy(13,5);
  write('------------------------------------------------------');
  for i := 1 to jumlah do
  begin
    gotoxy(13,i+5);
    write('|      |                         |       |           |');
    gotoxy(13,i+15);writeln('Petunjuk Pengisian ID Pasien:');
    gotoxy(13,i+16);writeln('- ID pasien terdiri 4 digit gabungan antara huruf & angka');
    gotoxy(13,i+17);writeln('- Contoh : B135');
    gotoxy(15,i+5);readln(Pasien[i].id_pasien);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    gotoxy(13,i+17);clreol;
    gotoxy(13,i+15);writeln('Petunjuk Pengisian Nama:');
    gotoxy(13,i+16);writeln('- Harap tidak mengisi nama melebihi batas');
    gotoxy(22,i+5);readln(Pasien[i].Nama_pasien);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    gotoxy(13,i+15);writeln('Petunjuk Pengisian Kelas:');
    gotoxy(13,i+16);writeln('- kelas hanya boleh diisi dengan VIP/1/2/3');
    gotoxy(48,i+5);readln(pasien[i].kelas);
    gotoxy(13,i+15);clreol;
    gotoxy(13,i+16);clreol;
    while (uppercase(pasien[i].kelas) <> 'VIP') and (pasien[i].kelas <> '1') and
          (pasien[i].kelas <> '2') and (pasien[i].kelas <> '3') do
    begin
      gotoxy(13,i+6);
      write('Kelas hanya boleh tersedia VIP/1/2/3, ulangi tekan Enter!');
      readln;
      gotoxy(13,i+6);clreol;
      gotoxy(46,i+5);clreol;
      write('|       |           |');
      gotoxy(48,i+5);readln(pasien[i].kelas);
    end;
    pasien[i].kamar := kamar(pasien[i].kelas);
    gotoxy(56,i+5);writeln(pasien[i].kamar);
    seek(file_pasien, filesize(file_pasien));
    write(file_pasien,Pasien[i]);
  end;
  gotoxy(13,i+6);
  writeln('======================================================');
  gotoxy(13,i+7);writeln('Lanjutkan tekan Enter..');
  close(file_pasien);
end;

//menu isi data
procedure menu_isi_data(pilihan : integer);
{I.S. : User memilih salah satu menu}
{F.S. : Menampilkan hasil sesuai menu yang dipilih}
begin
  writeln('Menu Isi Data');
  writeln('=============');
  writeln('1. Isi Data (Mengulang dari awal)');
  writeln('2. Tambah Data');
  writeln('0. Kembali');
  write('Pilihan Anda?');readln(pilihan);
  //validasi pilihan
  while (pilihan<0) or (pilihan>2) do
  begin
    writeln('pilihan hanya 1/2, ulangi tekan Enter!!');
    readln;
    gotoxy(1,6);clreol;
    gotoxy(14,5);clreol;
    readln(pilihan);
  end;
  case(pilihan) of
    1: begin
       clrscr;
       isidatapasien(n,pasien);
       readln;
       end;
    2: begin
       clrscr;
       tambahdatapasien(n,pasien);
       readln;
       end;
    0: begin
       clrscr;
       menupilihan(menu);
       end;
  end;
end;

//prosedure Mengurutkan data berdasarkan id dengan minimum sort secara ascending
procedure UrutID_asc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara ascending}
var
  i,j,min : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i := 1 to (N-1) do
  begin
    min := i;
      for j := i + 1 to N do
      begin
        if(Pasien[j].id_pasien < pasien[min].id_pasien)
        then
          min := j;
      end;
      temp        := Pasien[i];
      Pasien[i]   := Pasien[min];
      Pasien[min] := temp;
  end;
  close(file_pasien);
end;

//prosedure Mengurutkan data berdasarkan id dengan minimum sort secara descending
procedure UrutID_dsc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara descending}
var
  i,j,min : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i := 1 to (N-1) do
  begin
    min := i;
      for j := i + 1 to N do
      begin
        if(Pasien[j].id_pasien > pasien[min].id_pasien)
        then
          min := j;
      end;
      temp        := Pasien[i];
      Pasien[i]   := Pasien[min];
      Pasien[min] := temp;
  end;
  close(file_pasien);
end;

//prosedure Mengurutkan data berdasarkan nama dengan maximum sort (ascending)
procedure UrutNama_asc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara ascending}
var
  i,j,max : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i := 1 to (N-1) do
  begin
    max := i;
      for j := i + 1 to N do
      begin
        if(Pasien[j].nama_pasien < pasien[max].nama_pasien)
        then
          max := j;
      end;
      temp        := Pasien[i];
      Pasien[i]   := Pasien[max];
      Pasien[max] := temp;
  end;
  close(file_pasien);
end;

//prosedure Mengurutkan data berdasarkan nama dengan maximum sort (descending)
procedure UrutNama_dsc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara descending}
var
  i,j,max : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i := 1 to (N-1) do
  begin
    max := i;
      for j := i + 1 to N do
      begin
        if(Pasien[j].nama_pasien > pasien[max].nama_pasien)
        then
          max := j;
      end;
      temp        := Pasien[i];
      Pasien[i]   := Pasien[max];
      Pasien[max] := temp;
  end;
  close(file_pasien);
end;

//prosedure mengurutkan data berdasarkan Kelas dengan bubble sort (ascending)
procedure UrutKelas_asc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara ascending}
var
  i,j     : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i:=1 to N-1 do
  begin
    for j:=N downto (i+1) do
    begin
      if (Pasien[j].kelas <  pasien[j-1].kelas)
      then
      begin
        temp := pasien[j];
        pasien[j]:= pasien[j-1];
        pasien[j-1]:= temp;
      end;
    end;
  end;
  close(file_pasien);
end;

//prosedure mengurutkan data berdasarkan Kelas dengan bubble sort (descending)
procedure UrutKelas_dsc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara descending}
var
  i,j     : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i:=1 to N-1 do
  begin
    for j:=N downto (i+1) do
    begin
      if (Pasien[j].kelas >  pasien[j-1].kelas)
      then
      begin
        temp := pasien[j];
        pasien[j]:= pasien[j-1];
        pasien[j-1]:= temp;
      end;
    end;
  end;
  close(file_pasien);
end;

//prosedure mengurutkan data berdasarkan Kamar dengan bubble sort (ascending)
procedure UrutKamar_asc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara ascending}
var
  i,j     : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i:=1 to N-1 do
  begin
    for j:=N downto (i+1) do
    begin
      if (Pasien[j].kamar <  pasien[j-1].kamar)
      then
      begin
        temp := pasien[j];
        pasien[j]:= pasien[j-1];
        pasien[j-1]:= temp;
      end;
    end;
  end;
  close(file_pasien);
end;

//prosedure mengurutkan data berdasarkan Kamar dengan bubble sort (descending)
procedure UrutKamar_dsc (N:integer; var Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menghasilkan array pasien yang sudah tersusun secara descending}
var
  i,j     : integer;
  temp    : dt_pasien;
begin
  buka_file; // memanggil prosedur buka file
  for i:=1 to N-1 do
  begin
    for j:=N downto (i+1) do
    begin
      if (Pasien[j].kamar >  pasien[j-1].kamar)
      then
      begin
        temp := pasien[j];
        pasien[j]:= pasien[j-1];
        pasien[j-1]:= temp;
      end;
    end;
  end;
  close(file_pasien);
end;

//prosedure Menampilkan data pasien
procedure TampilDataPasien (N:integer; Pasien:arr_pasien);
{I.S. : Jumlah pasien & array pasien sudah terdefinisi}
{F.S. : Menampilkan data-data pasien}
var
  i:integer;
begin
  buka_file; // memanggil prosedur buka file
  clrscr;
  gotoxy(34,1);Write('DAFTAR PASIEN');
  gotoxy(33,2);Write('===============');
  gotoxy(5,3);
  write('======================================================================');
  gotoxy(5,4);
  write('|  ID  |       NAMA PASIEN       | KELAS |   KAMAR   |  HARGA KAMAR  |');
  gotoxy(5,5);
  write('----------------------------------------------------------------------');
  for i := 1 to N do
  begin
    gotoxy(5,i+5);
    write('|      |                         |       |           |               |');
    gotoxy(7,i+5);writeln(Pasien[i].id_pasien);
    gotoxy(14,i+5);writeln(pasien[i].Nama_pasien);
    gotoxy(40,i+5);writeln(pasien[i].kelas);
    gotoxy(48,i+5);writeln(pasien[i].kamar);
    pasien[i].harga := harga(pasien[i].kelas);
    gotoxy(61,i+5);writeln(pasien[i].harga,' /hari');
  end;
  gotoxy(5,i+6);
  write('======================================================================');
end;

procedure Menu_Urut_asc(pilihan:integer);
{I.S. : User memilih salah satu menu}
{F.S. : Menampilkan hasil sesuai menu yang dipilih}
begin
  writeln('Menu Urut');
  writeln('=========');
  writeln('1. Urut Berdasar ID');
  writeln('2. Urut Berdasar Nama');
  writeln('3. Urut Berdasar Kelas');
  writeln('4. Urut Berdasar Kamar');
  writeln('0. Kembali');
  write('Pilihan Anda?');readln(pilihan);
  //validasi pilihan
  while (pilihan<0) or (pilihan>4) do
  begin
    writeln('pilihan hanya 1/2/3/4, ulangi tekan Enter!!');
    readln;
    gotoxy(1,9);clreol;
    gotoxy(14,8);clreol;
    readln(pilihan);
  end;
  case(pilihan) of
    1: begin
       clrscr;
       UrutID_asc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    2: begin
       clrscr;
       UrutNama_asc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    3: begin
       clrscr;
       UrutKelas_asc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    4: begin
       clrscr;
       UrutKamar_asc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    0: begin
       clrscr;
       menupilihan(menu);
       end;
  end;
end;

procedure Menu_Urut_dsc(pilihan:integer);
{I.S. : User memilih salah satu menu}
{F.S. : Menampilkan hasil sesuai menu yang dipilih}
begin
  writeln('Menu Urut');
  writeln('=========');
  writeln('1. Urut Berdasar ID');
  writeln('2. Urut Berdasar Nama');
  writeln('3. Urut Berdasar Kelas');
  writeln('4. Urut Berdasar Kamar');
  writeln('0. Kembali');
  write('Pilihan Anda?');readln(pilihan);
  //validasi pilihan
  while (pilihan<0) or (pilihan>4) do
  begin
    writeln('pilihan hanya 1/2/3/4, ulangi tekan Enter!!');
    readln;
    gotoxy(1,9);clreol;
    gotoxy(14,8);clreol;
    readln(pilihan);
  end;
  case(pilihan) of
    1: begin
       clrscr;
       UrutID_dsc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    2: begin
       clrscr;
       UrutNama_dsc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    3: begin
       clrscr;
       UrutKelas_dsc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    4: begin
       clrscr;
       UrutKamar_dsc(n,pasien);
       tampildatapasien(n,pasien);
       readln;
       end;
    0: begin
       clrscr;
       menupilihan(menu);
       end;
  end;
end;

procedure Menu_Urut(pilihan:integer);
{I.S. : User memilih salah satu menu}
{F.S. : Menampilkan hasil sesuai menu yang dipilih}
begin
  writeln('Menu Urut');
  writeln('=========');
  writeln('1. Urut Secara Ascending(kecil ke besar)');
  writeln('2. Urut Secara Descending(besar ke kecil)');
  writeln('0. Kembali');
  write('Pilihan Anda?');readln(pilihan);
  //validasi pilihan
  while (pilihan<0) or (pilihan>2) do
  begin
    writeln('pilihan hanya 1/2, ulangi tekan Enter!!');
    readln;
    gotoxy(1,7);clreol;
    gotoxy(14,6);clreol;
    readln(pilihan);
  end;
  case(pilihan) of
    1: begin
       clrscr;
       Menu_urut_asc(pilihan);
       end;
    2: begin
       clrscr;
       menu_Urut_dsc(pilihan);
       end;
    0: begin
       clrscr;
       menupilihan(menu);
       end;
  end;
end;

//prosedure menyimpan ke file
procedure simpan_file;
var
  i : integer;
begin
  rewrite(file_pasien);
  for i:= 1 to N do
  begin
    seek(file_pasien,i-1);
    write(file_pasien,pasien[i]);
  end;
  close(file_pasien)
end;



procedure Cariid (N : integer; pasien : arr_pasien);
{I.S. : Elemen array yg terurut sudah terdefinisi}
{F.S. : Menampilkan data yang di cari ditemukan atau tidak ditemukan}
var
  ia,ib,k : integer;
  ketemu  : boolean;
  id      : string;
begin
  buka_file; // memanggil prosedur buka file
  write('id Pasien yang Dicari : ');readln(id);
  Ia := 1;
  Ib := N;
  Ketemu := false;
  while (not ketemu) and (Ia <= Ib) do
  begin
    K := (Ia + Ib) div 2;
    if (Pasien[K].id_pasien = id)
    then
      ketemu := true
    else
      if (pasien[K].id_pasien < id)
        then
          Ia := K + 1  //pencarian dilanjutkan ke kanan
        else
          Ib := K - 1; //pencarian dilanjutkan ke kiri
  end;
  if (ketemu)
  then
    begin
      clrscr;
      gotoxy(34,1);Write('DAFTAR PASIEN');
      gotoxy(33,2);Write('===============');
      gotoxy(13,4);
      write('Pasien dengan ID : ',id);
      gotoxy(13,5);
      write('======================================================');
      gotoxy(13,6);
      write('|  ID  |       Nama Pasien       | Kelas |   Kamar   |');
      gotoxy(13,7);
      write('------------------------------------------------------');
      gotoxy(13,8);
      write('|      |                         |       |           |');
      gotoxy(15,8);writeln(id);
      gotoxy(22,8);writeln(Pasien[k].Nama_pasien);
      gotoxy(48,8);writeln(Pasien[k].kelas);
      gotoxy(56,8);writeln(pasien[k].kamar);
      gotoxy(13,9);
      write('======================================================');
      pasien[k].harga := harga(pasien[k].kelas);
    end
    else
      writeln('id Pasien ',id,' tidak ada!');
  close(file_pasien);
end;

//precedure cari berdasarkan nama
Procedure CariNama (N:integer; pasien:arr_pasien; NmP:string);
{I.S. : Elemen array sudah terdefinisi}
{F.S. : Menampilkan data yang di cari ditemukan atau tidak ditemukan}
var
  i,j,baris  : integer;
  temp       : arr_pasien;
begin
  buka_file; // memanggil prosedur buka file
  write('Nama Pengarang yang dicari: ');readln(Nmp);
  i := 1;
  j := 0;
  while (i<=N) do
  begin
    if (pos(lowercase(NmP),lowercase(Pasien[i].Nama_pasien)) > 0 )
    then
    begin
      j:= J + 1;
      Temp[j]:= Pasien[i];
    end;
    i := i+1;
  end; //endwhile
  if (j>0)
  then
  begin
    clrscr;
    gotoxy(34,1);Write('DATA PASIEN');
    gotoxy(33,2);Write('=============');
    gotoxy(13,5);
    write('Pasien dengan Nama : ',NmP);
    gotoxy(13,6);
    write('==========================================================');
    gotoxy(13,7);
    write('|NO |       Nama Pasien       |  ID  | Kelas |   Kamar   |');
    gotoxy(13,8);
    write('----------------------------------------------------------');
    baris := 8;
    for i := 1 to J do
    begin
      gotoxy(13,baris+1);
      write('|   |                         |      |       |           |');
      gotoxy(15,baris+1);writeln(i);
      gotoxy(19,baris+1);writeln(temp[i].Nama_pasien);
      gotoxy(45,baris+1);writeln(temp[i].id_pasien);
      gotoxy(52,baris+1);writeln(temp[i].kelas);
      gotoxy(60,baris+1);writeln(temp[i].kamar);
      baris := baris + 1;
    end;
      gotoxy(13,baris+1);
      write('==========================================================');
  end
  else
    writeln('Pasien dengan Nama ',Nmp,' tidak ditemukan!');
end;

//prosedure cari berdasarkan kamar
procedure carikamar(N:integer; pasien:arr_pasien;NmK:string);
{I.S. : Elemen array sudah terdefinisi}
{F.S. : Menampilkan data yang di cari ditemukan atau tidak ditemukan}
var
  i,j,baris  : integer;
  temp       : arr_pasien;
begin
  buka_file; // memanggil prosedur buka file
  write('Nama Kamar yang dicari: ');readln(NmK);
  i := 1;
  j := 0;
  while(i<=N) do
  begin
    if (pos(lowercase(NmK),lowercase(Pasien[i].Kamar)) > 0 )
    then
    begin
      j:= J + 1;
      Temp[j]:= Pasien[i];
    end;
    i := i+1;
  end; //endwhile
  if (j>0)
  then
  begin
    clrscr;
    gotoxy(34,1);Write('DATA PASIEN');
    gotoxy(33,2);Write('=============');
    gotoxy(13,5);
    write('Kamar dengan Nama : ',NmK);
    gotoxy(13,6);
    write('==========================================================');
    gotoxy(13,7);
    write('|NO |   Kamar   |       Nama Pasien       |  ID  | Kelas |');
    gotoxy(13,8);
    write('----------------------------------------------------------');
    baris := 8;
    for i := 1 to J do
    begin
      gotoxy(13,baris+1);
      write('|   |           |                         |      |       |');
      gotoxy(15,baris+1);writeln(i);
      gotoxy(19,baris+1);writeln(temp[i].kamar);
      gotoxy(31,baris+1);writeln(temp[i].Nama_pasien);
      gotoxy(57,baris+1);writeln(temp[i].id_pasien);
      gotoxy(64,baris+1);writeln(temp[i].kelas);
      baris := baris + 1;
    end;
      gotoxy(13,baris+1);
      write('==========================================================');
  end
  else
    writeln('Kamar ',Nmk,' tidak ada!');
end;

begin
    textbackground(7);
    textcolor(16);
    n := 0;
    repeat
    buka_file;
    simpan_file;
    clrscr;
    menupilihan(menu);
    case (menu) of
    1: begin
       clrscr;
       menu_isi_data(pilihan);
       end;
    2: begin
       clrscr;
       urutID_asc(n, pasien);
       simpan_file;
       cariid(n, pasien);
       readln;
       end;
    3: begin
       clrscr;
       carinama(n,pasien,nmp);
       close(file_pasien);
       readln;
       end;
    4: begin
       clrscr;
       carikamar(n,pasien,nmk);
       close(file_pasien);
       readln;
       end;
    5: begin
       clrscr;
       menu_urut(pilihan);
       simpan_file;
       end;
    end;
    until (menu = 0);textcolor(yellow);
    gotoxy(17,19);writeln('Terima Kasih Telah Menggunakan Program Ini');
    readln;
end.
