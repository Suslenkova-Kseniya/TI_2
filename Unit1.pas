unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    Memo2: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  a = 31;
  buff = 256;

type
  Bits = Array of byte;

type
  Buffer = Array [1 .. 1024 * buff] of byte;

type
  Registers = Array [1 .. a] of boolean;

var
  Form1: TForm1;
  FileIn, FileEx, FileKey: File;
  PlainFile, Shifr, s, reg: string;
  M: TextFile;
  c, c1, c2: Buffer;
  x: integer;
  Key: Bits;

implementation

{$R *.dfm}

procedure TForm1.Memo2KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0', '1', #8]) then
  begin
    Key := #0;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Text := '';
  if OpenDialog1.Execute then
  begin
    Memo1.Text := OpenDialog1.FileName;
    PlainFile := OpenDialog1.FileName;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Shifr := SaveDialog1.FileName;
end;

function getreg(s: string): Registers;
var
  i: integer;
begin
  for i := 1 to a do
    if s[i] = '1' then
      Result[i] := true
    else
      Result[i] := false
end;

function getbyte(s: string): byte;
var
  i: byte;
  T: word;
begin
  Result := 0;
  T := 1;
  for i := 8 downto 1 do
  begin
    if s[i] = '1' then
      Result := Result + T;
    T := T * 2;
  end;
end;

function printbit(c: byte): string;
var
  T, i: word;
begin
  Result := '';
  T := c;
  for i := 1 to 8 do
  begin
    T := T * 2;
    if T > 255 then
    begin
      Result := Result + '1';
      T := T - 255;
    end
    else
      Result := Result + '0';
  end;
end;

function PrintStr(c: Buffer; num: integer): String;
var
  i: integer;
begin
  for i := 1 to num do
    Result := Result + printbit(c[i]) + ' ';
end;

function GetKey(regist, s: string; amount: integer): Bits;
var
  T: Registers;
  n, i, j, index, ind: integer;
  x: boolean;
  Key: array [1 .. a] of byte;
  res: string;
begin
  SetLength(Result, amount);
  index := 1;
  while (pos('1', s) > 0) do
  begin
    i := pos('1', s);
    s[i] := '0';
    Key[index] := a + 1 - i;
    index := index + 1;
  end;
  index := index - 1;
  T := getreg(regist);
  for ind := 0 to amount - 1 do
  begin
    res := '';
    for j := 1 to 8 do
    begin
      x := false;
      for n := 1 to index do
        x := x xor T[Key[n]];
      if T[a] then
        res := res + '1'
      else
        res := res + '0';
      for i := a downto 2 do
        T[i] := T[i - 1];
      T[1] := x;
    end;
    Result[ind] := getbyte(res);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Flags: TReplaceFlags;
  i: int64;
  ind, succ: integer;
begin
  If Length(Memo2.Text) <> a then
  begin
    ShowMessage('Недостаточно символов. Попробуйте снова');
    Memo2.Text := '';
  end
  else if Shifr = '' then
    MessageBox(handle, 'Невозможно определить путь сохранения', 'Error!', 0)
  else if PlainFile = '' then
    MessageBox(handle, 'Невозможно определить путь чтения', 'Error!', 0)
  else
  begin
    AssignFile(FileIn, PlainFile);
    AssignFile(FileKey,
      'D:\Учеба\4sem\ТИ_2022\Задание №2_потоковое_шифрование\TI_2\Win32\Debug\key.txt');
    AssignFile(FileEx, Shifr);
    Rewrite(FileEx, 1);
    Reset(FileIn, 1);
    Rewrite(FileKey, 1);
    s := '1000000000000000000000000000100';
    reg := Memo2.Text;
    Key := GetKey(reg, s, FileSize(FileIn));
    i := 0;

    while (i < FileSize(FileIn)) do
    begin
      ind := 1;
      while ((i < FileSize(FileIn)) and (ind <= buff * 1024)) do
      begin
        c[ind] := Key[i];
        ind := ind + 1;
        i := i + 1;
      end;
      if ind - 1 <> 0 then
        BlockWrite(FileKey, c, ind - 1);
    end;
    closefile(FileKey);
    AssignFile(FileKey,
      'D:\Учеба\4sem\ТИ_2022\Задание №2_потоковое_шифрование\TI_2\Win32\Debug\key.txt');
    Reset(FileKey, 1);
    while not EOF(FileIn) do
    begin
      BlockRead(FileIn, c, buff * 1024, succ);
      BlockRead(FileKey, c1, buff * 1024, succ);
      for i := 1 to succ do
        c2[i] := c1[i] xor c[i];
      BlockWrite(FileEx, c2, succ);
    end;
    Reset(FileKey, 1);
    Reset(FileIn, 1);
    Reset(FileEx, 1);
    BlockRead(FileIn, c, 100, succ);
    Memo4.Text := PrintStr(c, succ);
    BlockRead(FileEx, c, 100, succ);
    Memo5.Text := PrintStr(c, succ);
    BlockRead(FileKey, c, 100, succ);
    Memo3.Text := PrintStr(c, succ);

    Reset(FileKey, 1);
    Reset(FileIn, 1);
    Reset(FileEx, 1);

    AssignFile(M, 'Plaintext.txt');
    Rewrite(M);
    while not EOF(FileIn) do
    begin
      BlockRead(FileIn, c, buff * 1024, succ);
      for i := 1 to succ do
      begin
        write(M, printbit(c[i]), ' ');
      end;
    end;
    closefile(M);
    AssignFile(M, 'Key1.txt');
    Rewrite(M);
    while not EOF(FileKey) do
    begin
      BlockRead(FileKey, c, buff * 1024, succ);
      for i := 1 to succ do
      begin
        write(M, printbit(c[i]), ' ');
      end;
    end;
    closefile(M);

    AssignFile(M, 'Shifr.txt');
    Rewrite(M);
    while not EOF(FileEx) do
    begin
      BlockRead(FileEx, c, buff * 1024, succ);
      for i := 1 to succ do
      begin
        write(M, printbit(c[i]), ' ');
      end;
    end;
    closefile(M);
    closefile(FileIn);
    closefile(FileKey);
    closefile(FileEx);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Text := '';
  Memo2.Text := '';
  Memo4.Text := '';
  Memo3.Text := '';
  Memo5.Text := '';
end;

end.
