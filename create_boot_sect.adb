with Ada.Streams.Stream_IO;
with Ada.Text_IO;
with Interfaces;

procedure create_boot_sect is
  use Ada.Streams.Stream_IO;

  File_Name : constant String := "boot_sect.bin";
  F : File_Type;
  S : stream_access;

  type byte_buffer is array (1 .. 512) of Interfaces.Unsigned_8;
  boot_sec : byte_buffer := (
    1 => 16#e9#,
    2 => 16#fd#,
    3 => 16#ff#,
    4 .. 510 => 16#00#,
    511 => 16#55#,
    512 => 16#aa#
  );
  
begin
  create(f, out_file, file_name);
  s := stream(f);

  byte_buffer'write(s, boot_sec);

  close(f);
end create_boot_sect;
