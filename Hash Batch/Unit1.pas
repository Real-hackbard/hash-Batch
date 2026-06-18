{******************************************************************************}
{* DCPcrypt v2.0 written by David Barton (crypto@cityinthesky.co.uk) **********}
{******************************************************************************}
{* A file hashing demo ********************************************************}
{******************************************************************************}
{* Copyright (c) 2003 David Barton                                            *}
{* Permission is hereby granted, free of charge, to any person obtaining a    *}
{* copy of this software and associated documentation files (the "Software"), *}
{* to deal in the Software without restriction, including without limitation  *}
{* the rights to use, copy, modify, merge, publish, distribute, sublicense,   *}
{* and/or sell copies of the Software, and to permit persons to whom the      *}
{* Software is furnished to do so, subject to the following conditions:       *}
{*                                                                            *}
{* The above copyright notice and this permission notice shall be included in *}
{* all copies or substantial portions of the Software.                        *}
{*                                                                            *}
{* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *}
{* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   *}
{* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    *}
{* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *}
{* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    *}
{* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        *}
{* DEALINGS IN THE SOFTWARE.                                                  *}
{******************************************************************************}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DCPcrypt2, DCPsha256, DCPsha1, DCPsha512,
  DCPblockciphers, DCPmd4, DCPmd5, DCPhaval, DCPripemd128, DCPripemd160,
  DCPtiger, ShellApi, FileCtrl, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  RichEdit, SHDocVw, MSHTML, IniFiles;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Panel1: TPanel;
    Open1: TMenuItem;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    hash1: TMenuItem;
    Calculate1: TMenuItem;
    Panel3: TPanel;
    ListBox1: TListBox;
    RichEdit1: TRichEdit;
    Splitter1: TSplitter;
    ProgressBar1: TProgressBar;
    Options1: TMenuItem;
    Font1: TMenuItem;
    FontDialog1: TFontDialog;
    N1: TMenuItem;
    About1: TMenuItem;
    LowerCase1: TMenuItem;
    UpperCase1: TMenuItem;
    N2: TMenuItem;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Exit1: TMenuItem;
    N3: TMenuItem;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    Selectall1: TMenuItem;
    Save1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ExportHtml1: TMenuItem;
    SaveDialog2: TSaveDialog;
    N4: TMenuItem;
    N5: TMenuItem;
    StayTop1: TMenuItem;
    UnicodeExportonlyTXTfile1: TMenuItem;
    UTF81: TMenuItem;
    UTF8Boom1: TMenuItem;
    UTF16LE1: TMenuItem;
    UTF16BE1: TMenuItem;
    ANSI1: TMenuItem;
    ASCII1: TMenuItem;
    Default1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Highlight1: TMenuItem;
    FindDialog1: TFindDialog;
    Search1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Remove1: TMenuItem;
    Clear1: TMenuItem;
    N8: TMenuItem;
    Clear2: TMenuItem;
    Label1: TLabel;
    Calculate2: TMenuItem;
    N9: TMenuItem;
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Open1Click(Sender: TObject);
    procedure Calculate1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure LowerCase1Click(Sender: TObject);
    procedure UpperCase1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure ExportHtml1Click(Sender: TObject);
    procedure StayTop1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Highlight1Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Clear2Click(Sender: TObject);
    procedure Calculate2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  Directory: string;
  TIF : TIniFile;

implementation

{$R *.dfm}
// get MainPath
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'md4',CheckBox1.Checked);
    WriteBool(OPT,'md5',CheckBox2.Checked);
    WriteBool(OPT,'sha1',CheckBox3.Checked);
    WriteBool(OPT,'sha256',CheckBox4.Checked);
    WriteBool(OPT,'sha384',CheckBox5.Checked);
    WriteBool(OPT,'sha512',CheckBox6.Checked);
    WriteBool(OPT,'haval',CheckBox7.Checked);
    WriteBool(OPT,'tiger',CheckBox8.Checked);
    WriteBool(OPT,'Ripemd128',CheckBox9.Checked);
    WriteBool(OPT,'Ripemd160',CheckBox10.Checked);
    WriteBool(OPT,'Default1',Default1.Checked);
    WriteBool(OPT,'UTF81',UTF81.Checked);
    WriteBool(OPT,'UTF8Boom1',UTF8Boom1.Checked);
    WriteBool(OPT,'UTF16LE1',UTF16LE1.Checked);
    WriteBool(OPT,'UTF16BE1',UTF16BE1.Checked);
    WriteBool(OPT,'ANSI1',ANSI1.Checked);
    WriteBool(OPT,'ASCII1',ASCII1.Checked);
    WriteBool(OPT,'LowerCase1',LowerCase1.Checked);
    WriteBool(OPT,'UpperCase1',UpperCase1.Checked);
    WriteBool(OPT,'StayTop1',StayTop1.Checked);
    WriteBool(OPT,'Highlight1',Highlight1.Checked);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      CheckBox1.Checked:=ReadBool(OPT,'md4',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'md5',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'sha1',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'sha256',CheckBox4.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'sha384',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'sha512',CheckBox6.Checked);
      CheckBox7.Checked:=ReadBool(OPT,'haval',CheckBox7.Checked);
      CheckBox8.Checked:=ReadBool(OPT,'tiger',CheckBox8.Checked);
      CheckBox9.Checked:=ReadBool(OPT,'Ripemd128',CheckBox9.Checked);
      CheckBox10.Checked:=ReadBool(OPT,'Ripemd160',CheckBox10.Checked);
      Default1.Checked:=ReadBool(OPT,'Default1',Default1.Checked);
      UTF81.Checked:=ReadBool(OPT,'UTF81',UTF81.Checked);
      UTF8Boom1.Checked:=ReadBool(OPT,'UTF8Boom1',UTF8Boom1.Checked);
      UTF16LE1.Checked:=ReadBool(OPT,'UTF16LE1',UTF16LE1.Checked);
      UTF16BE1.Checked:=ReadBool(OPT,'UTF16BE1',UTF16BE1.Checked);
      ANSI1.Checked:=ReadBool(OPT,'ANSI1',ANSI1.Checked);
      ASCII1.Checked:=ReadBool(OPT,'ASCII1',ASCII1.Checked);
      LowerCase1.Checked:=ReadBool(OPT,'LowerCase1',LowerCase1.Checked);
      UpperCase1.Checked:=ReadBool(OPT,'UpperCase1',UpperCase1.Checked);
      StayTop1.Checked:=ReadBool(OPT,'StayTop1',StayTop1.Checked);
      Highlight1.Checked:=ReadBool(OPT,'Highlight1',Highlight1.Checked);
      Free;
  end;
  end;
end;

procedure TForm1.Remove1Click(Sender: TObject);
var
  I : Integer;
begin
  ListBox1.Items.BeginUpdate; // Prevents the UI from flickering
  try
    for I := ListBox1.Items.Count - 1 downto 0 do
    begin
      if ListBox1.Selected[I] then
        ListBox1.Items.Delete(I);
    end;
  finally
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
    ListBox1.Items.EndUpdate; // Re-enables UI rendering
  end;
end;

procedure TForm1.RichEdit1Change(Sender: TObject);
begin
  if RichEdit1.Text > '' then
  begin
    Save1.Enabled := true;
    ExportHtml1.Enabled := true;
    Copy1.Enabled := true;
    Selectall1.Enabled := true;
    Clear2.Enabled := true;
  end else begin
    Save1.Enabled := false;
    ExportHtml1.Enabled := false;
    Copy1.Enabled := false;
    Selectall1.Enabled := false;
    Clear2.Enabled := false;
  end;
end;

// copy hashes to clipboard
function ClipboardToHTML(AParent: TWinControl): WideString;
var
  wb: TWebBrowser;

  function WaitDocumentReady: Boolean;
  var
    StartTime: DWORD;
  begin
    StartTime := GetTickCount;
    while wb.ReadyState <> READYSTATE_COMPLETE do
    begin
      Application.HandleMessage;
      if GetTickCount >= StartTime + 2000 then // time-out of max 2 sec
      begin
        Result := False; // time-out
        Exit;
      end;
    end;
    Result := True;
  end;
begin
  Result := '';
  wb := TWebBrowser.Create(nil);
  try
    wb.Silent := True;
    wb.Width := 0;
    wb.Height := 0;
    wb.Visible := False;
    TWinControl(wb).Parent := AParent;
    wb.HandleNeeded;
    if wb.HandleAllocated then
    begin
      wb.Navigate('about:blank');
      (wb.Document as IHTMLDocument2).designMode := 'on';
      if WaitDocumentReady then
      begin
        (wb.Document as IHTMLDocument2).execCommand('Paste', False, 0);
        Result := (wb.Document as IHTMLDocument2).body.innerHTML;
      end;
    end;
  finally
    wb.Free;
  end;
end;

// Determine the total size of all files in the loaded folder.
function GetDirectorySize(const Path: string): Int64;
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  SearchPath: string;
begin
  Result := 0;
  // built-in function that ensures a file path string ends with the
  // correct trailing path delimiter character.
  SearchPath := IncludeTrailingPathDelimiter(Path);
  // Search for all files and folders
  FindResult := FindFirst(SearchPath + '*.*', faAnyFile, SearchRec);
  try
    while FindResult = 0 do
    begin
      // Ignore special directories
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        if (SearchRec.Attr and faDirectory) <> 0 then
        begin
          // If it's a subfolder, call the function recursively.
          Inc(Result, GetDirectorySize(SearchPath + SearchRec.Name));
        end
        else
        begin
          // Add the file size to the total.
          Inc(Result, SearchRec.Size);
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

// Determine the size of each file
function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  // find exists file
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh; // calculating file sizes over 2GB
      Result := Result shl 32;    // if Result is a 32-bit integer
      Result := Result + FD.nFileSizeLow; // It contains the lower 32 bits of a file's size.
    finally
      //CloseHandle(FH);
    end;
end;

procedure HightLight_Syntax(ARE : TRichEdit);
//{$REGION 'Sub-functions'}
// A sub-function only visible within Highlight_Syntax and which has access to ARE
procedure HighLight_Others(AStart, AEnd : String; AColor : TColor);
var
  iNext, iPos, iPos_End : Integer;
begin
  iNext := 0;
  iPos := ARE.FindText(AStart, iNext, Length(ARE.Text), [stMatchCase]);
  // FindText returns -1 if it did not find AStart in the RichEdit
  while iPos <> -1 do
  begin
    // We reduce the text to be scanned so as not to keep looping on the same word.
    iNext := iPos + Length(AStart);
    // We initialize the starting position of the RichEdit
    ARE.SelStart := iPos;
    // We are looking for the position of the second character that should stop the coloring
    iPos_End := ARE.FindText(AEnd, iNext, Length(ARE.Text), [stMatchCase]);
    if iPos_End = -1 then
      if AStart = '''' then
        // When it comes to a string opening ('), the coloring ends at the end of the line
        iPos_End := ARE.FindText(#13, iNext, Length(ARE.Text), [stMatchCase])
      else
        // By default, if the end character is missing, the coloring stops at the end of the text.
        iPos_End := Length(ARE.Text);

    // We define the point up to which the text should be colored
    ARE.SelLength := (iPos_End  - iPos) + Length(AEnd);
    // And we color
    ARE.SelAttributes.Color := AColor;
    if AStart = '''' then
      // When it comes to opening a chain, the position of the next chain must
      // begin after the closing of the last chain.
      iPos := ARE.FindText('''', iNext + iPos_End, Length(ARE.Text), [stMatchCase])
    else
      iPos := ARE.FindText(AStart, iNext, Length(ARE.Text), [stMatchCase]);
  end;
end;
//{$ENDREGION}

var
  SL_Key_Word : TStringList;
  i, iPos, iNext, iPos_Symb_Start, iPos_Symb_End, iTest : Integer;
  C_Path : string;
begin
  // path of highlight keywords
  // This is the file where standard highlighted, colored names are entered.
  C_Path := MainDir + 'Data\Keywords\KeyWords.txt';
  ARE.SelectAll;
  ARE.SelAttributes.Color := clBlack;
  SL_Key_Word := TStringList.Create;
  try
    SL_Key_Word.LoadFromFile(C_Path);
    i := 0;
    while i < SL_Key_Word.Count do
    begin
      iNext := 0;
      // We only search for WHOLE words that match a keyword
      iPos := ARE.FindText(SL_Key_Word[i], iNext, Length(ARE.Text), [stWholeWord]);
      while iPos <> -1 do
      begin
        // To prevent words preceded by "_" from also being colored (FindText doesn't handle that)
        iPos_Symb_Start := ARE.FindText('_', iPos - 1, 1, [stMatchCase]);
        // If the position is equal to 0, it means there must be no
        // underscore (_) before it. This prevents iPos - iPos_Symb_Start from equaling 1.
        if iPos = 0 then
          iTest := 0
        else
          iTest := iPos - iPos_Symb_Start;

        // To prevent words followed by "_" from also being colored
        iPos_Symb_End := ARE.FindText('_', iPos, Length(SL_Key_Word[i]) + 1, [stMatchCase]);
        // If the word is not surrounded by "_"
        if (iTest <> 1) and (((Length(SL_Key_Word[i]) + iPos) - iPos_Symb_End) + 1 <> 1) then
        begin
          // The next search is performed starting from the end of the last keyword found.
          iNext := iPos + Length(SL_Key_Word[i]);
          ARE.SelStart := iPos;
          ARE.SelLength := Length(SL_Key_Word[i]);
          ARE.SelAttributes.Color := clNavy;
        end
        else
          // This is not a keyword.
          iNext := iPos + Length(SL_Key_Word[i]) - 1;

        // Searching for the next keyword
        iPos := ARE.FindText(SL_Key_Word[i], iNext, Length(ARE.Text), [stWholeWord]);
      end;
      inc(i);
    end;

    { Here you specify the characters to be colored that are entered in
      the "Keywords.txt" file. }
    HighLight_Others('(', ')', clGreen);           // everything between brackets
    //HighLight_Others('File', 'File', clMaroon);  // everything between the names "File"
    //HighLight_Others('//', #13, clGreen);        // everything after the double backslash
    //HighLight_Others('{', '}', clGreen);         // everything between the curly brace
    //HighLight_Others('{$', '}', clTeal);         // everything between the characters "{$" and "}"
    //HighLight_Others('''', '''', clBlue);        // everything between the high commas
    HighLight_Others(':', #13, clNavy);            // #13 represents the line break
  finally
    SL_Key_Word.Free;
  end;

end;

// Find all the files in a folder and load them into the component.
procedure GetAllFilesExtra(List: TStrings);
var
  Path: String;
  Search: TSearchRec;
begin
  //Path := ExtractFilePath(ParamStr(0)); // If main path is needed
  Path := Directory + '\';

  // search for all file (*.*)
  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      // identify or filter directory (folder) entries.
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        List.Add(Path + Search.Name);

    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var
  WH: Byte; // Width and Height
begin
  with Bmp do
  begin
    //Canvas.Brush.Color := clFuchsia;  // Exact color specification if needed.
    TransparentColor := clFuchsia;      // set icons transparent

    Width := 16; Height := 16; // icon // Width and Height
    Canvas.Draw(0, 0, Ico);    // draw

    if SmallIcon then
      WH := 16
    else
      WH := 32;
    // adjust the size
    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp);
    Width := WH; Height := WH;
    Transparent :=  true;
  end;
end;

{ The GetIconFromFile function is not a standard Delphi routine;
  it is typically a custom wrapper around the Windows API function
  ExtractAssociatedIcon or SHGetFileInfo to extract a file’s
  system icon. }
procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var
  sfi: TSHFILEINFO;  //  record structure defined in the Winapi.ShellAPI
const
  // determine the dimensions of the file or folder icon retrieved from the Windows Shell.
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON);
begin
  // Retrieve information about an object in the file system (files, folders, directories).
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then
    Icon.Handle := sfi.hIcon; // Hand over what you found to the Handler
end;

// draw windows shell icons to the ListBox items
procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  // VCL/LCL system color constant in Delphi
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do  // This is typically used in generic event handlers
  begin
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then
        Canvas.Font.Color := clCaptionText
      else
      begin
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      // get windows shell32 icon
      GetIconFromFileB(Items[Index], Icon, True);
      // convert into bitmap
      IcoToBmpA(Icon, Bmp, True);
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 2, Rect.Top + 2, Items[Index]);
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

(* ---------- TIGER file hash ----------*)
function GetTigerFileHash(const FileName: string): string;
const
  BUFFER_SIZE = 1024 * 64; // 64 KB buffer
var
  FileStream: TFileStream;
  TigerHash: TDCP_tiger;
  Buffer: array of Byte;
  BytesRead: Integer;
  Digest: array[0..23] of Byte; // Tiger produces a 24-byte (192-bit) digest
  i: Integer;
begin
  Result := '';
  if not FileExists(FileName) then Exit;
  // Initialize stream and buffer
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  SetLength(Buffer, BUFFER_SIZE);
  TigerHash := TDCP_tiger.Create(nil);
  try
    TigerHash.Init;
    // Read and hash in chunks
    repeat
      BytesRead := FileStream.Read(Buffer[0], BUFFER_SIZE);
      if BytesRead > 0 then
        TigerHash.Update(Buffer[0], BytesRead);
    until BytesRead = 0;
    TigerHash.Final(Digest);
    // Convert binary array to hex string
    for i := Low(Digest) to High(Digest) do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    FileStream.Free;
    TigerHash.Free;
    SetLength(Buffer, 0);
  end;
end;

(* ---------- RIPEMD160 file hash ----------*)
function GetRIPEMD160FileHash(const AFileName: string): string;
var
  Hash: TDCP_ripemd160;
  FileStream: TFileStream;
  Buffer: array[0 .. 1024 * 64] of Byte; // 64KB buffer
  BytesRead: Integer;
  Digest: array[0 .. 19] of Byte; // RIPEMD-160 produces a 20-byte digest
  i: Integer;
begin
  Result := '';
  if not FileExists(AFileName) then
    raise Exception.Create('File not found: ' + AFileName);
  Hash := TDCP_ripemd160.Create(nil);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    // Read and feed the hash algorithm in chunks
    repeat
      BytesRead := FileStream.Read(Buffer[0], SizeOf(Buffer));
      if BytesRead > 0 then
        Hash.Update(Buffer[0], BytesRead);
    until BytesRead = 0;
    Hash.Final(Digest);
    // Convert the 20-byte binary array into a 40-digit Hex string
    for i := 0 to 19 do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    Hash.Free;
    FileStream.Free;
  end;
end;

(* ---------- RIPEMD128 file hash ----------*)
function GetRipemd128FileHash(const AFileName: string): string;
var
  Hash: TDCP_ripemd128;
  FileStream: TFileStream;
  Buffer: array[0..8191] of Byte; // 8KB buffer
  BytesRead: Integer;
  Digest: array[0..15] of Byte; // RIPEMD-128 yields a 16-byte digest
  i: Integer;
begin
  Result := '';
  Hash := TDCP_ripemd128.Create(nil);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    try
      repeat
        BytesRead := FileStream.Read(Buffer, SizeOf(Buffer));
        if BytesRead > 0 then
          Hash.Update(Buffer, BytesRead);
      until BytesRead = 0;
      Hash.Final(Digest);
      // Convert the binary digest to a readable Hex string
      for i := Low(Digest) to High(Digest) do
        Result := Result + IntToHex(Digest[i], 2);
    finally
      Hash.Burn; // Clear sensitive data from memory
    end;
  finally
    FileStream.Free;
    Hash.Free;
  end;
end;

(* ---------- HAVAL file hash ----------*)
function GetHavalFileHash(const AFileName: string): string;
var
  Hash: TDCP_haval;
  FileStream: TFileStream;
  Buffer: array[0..1024 * 64] of Byte; // 64KB Buffer
  BytesRead: Integer;
  Digest: array[0..31] of Byte; // HAVAL supports up to 256-bit (32 bytes)
  DigestSize: Integer;
  i: Integer;
begin
  Result := '';
  if not FileExists(AFileName) then
    raise Exception.Create('File not found: ' + AFileName);
  // Initialize DCP_haval
  Hash := TDCP_haval.Create(nil);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    // Read file in chunks
    repeat
      BytesRead := FileStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        Hash.Update(Buffer[0], BytesRead);
    until BytesRead = 0;
    Hash.Final(Digest);
    DigestSize := Hash.GetHashSize div 8;
    // Convert the binary digest to a Hex string
    for i := 0 to DigestSize - 1 do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    Hash.Free;
    FileStream.Free;
  end;
end;

(* ---------- MD5 file hash ----------*)
function GetDCPMD5FileHash(const FileName: string): string;
var
  MD5: TDCP_md5;
  FS: TFileStream;
  Buffer: array[0..8191] of Byte; // 8KB buffer
  BytesRead: Integer;
  Digest: array[0..15] of Byte;
  i: Integer;
begin
  Result := '';
  if not FileExists(FileName) then
    raise Exception.Create('File not found: ' + FileName);
  MD5 := TDCP_md5.Create(nil);
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    MD5.Init;
    repeat
      BytesRead := FS.Read(Buffer[0], SizeOf(Buffer));
      if BytesRead > 0 then
        MD5.Update(Buffer[0], BytesRead);
    until BytesRead = 0;
    MD5.Final(Digest);
    // Convert binary digest to Hex string
    for i := 0 to 15 do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    FS.Free;
    MD5.Free;
  end;
end;

(* ---------- MD4 file hash ----------*)
function GetMD4FileHash(const FileName: string): string;
var
  Hash: TDCP_md4;
  FileStream: TFileStream;
  Buffer: array[0..8191] of Byte;
  BytesRead: Integer;
  Digest: array[0..15] of Byte; // MD4 uses a 16-byte (128-bit) digest
  I: Integer;
begin
  Result := '';
  if not FileExists(FileName) then
    Exit;
  Hash := TDCP_md4.Create(nil);
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    // Read and hash file in chunks
    repeat
      BytesRead := FileStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        Hash.Update(Buffer, BytesRead);
    until BytesRead = 0;
    Hash.Final(Digest);
    // Convert the raw byte digest to a hex string
    for I := 0 to SizeOf(Digest) - 1 do
      Result := Result + IntToHex(Digest[I], 2);
  finally
    FileStream.Free;
    Hash.Free;
  end;
end;

(* ---------- SHA512 file hash ----------*)
function GetSHA512FileHash(const FileName: string): string;
var
  Hash: TDCP_sha512;
  FStream: TFileStream;
  Buffer: array[0..4095] of Byte; // 4KB buffer
  BytesRead: Integer;
  Digest: array[0..63] of Byte; // SHA-512 is 64 bytes (512 bits)
  I: Integer;
begin
  Result := '';
  Hash := TDCP_sha512.Create(nil);
  FStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    // Read the file in chunks to handle large files
    repeat
      BytesRead := FStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        Hash.Update(Buffer, BytesRead);
    until BytesRead = 0;
    Hash.Final(Digest);
    // Convert the 64-byte binary digest into a 128-char hex string
    for I := 0 to High(Digest) do
      Result := Result + IntToHex(Digest[I], 2);
  finally
    Hash.Burn;
    Hash.Free;
    FStream.Free;
  end;
end;

(* ---------- SHA384 file hash ----------*)
function GetSHA384FileHash(const AFileName: string): string;
var
  Hash: TDCP_sha384;
  FileStream: TFileStream;
  Buffer: array[0..4095] of Byte; // 4KB chunks
  BytesRead: Integer;
  Digest: array[0..47] of Byte; // SHA-384 is 48 bytes (384 bits)
  i: Integer;
begin
  Result := '';
  Hash := TDCP_sha384.Create(nil);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Hash.Init;
    // Read file in chunks
    repeat
      BytesRead := FileStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        Hash.Update(Buffer, BytesRead);
    until BytesRead = 0;
    Hash.Final(Digest);
    // Convert binary digest to Hex string
    for i := Low(Digest) to High(Digest) do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    Hash.Free;
    FileStream.Free;
  end;
end;

(* ---------- SHA1 file hash ----------*)
function GetSHA1DCP(const FileName: string): string;
var
  SHA1: TDCP_sha1;
  FStream: TFileStream;
  Buffer: array[0..4095] of Byte;
  BytesRead: Integer;
  Digest: array[0..19] of Byte; // SHA-1 is 20 bytes (160 bits)
  i: Integer;
begin
  SHA1 := TDCP_sha1.Create(nil);
  FStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SHA1.Init;
    repeat
      BytesRead := FStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        SHA1.Update(Buffer, BytesRead);
    until BytesRead = 0;
    SHA1.Final(Digest);
    Result := '';
    for i := 0 to SizeOf(Digest) - 1 do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    FStream.Free;
    SHA1.Free;
  end;
end;

(* ---------- SHA256 file hash ----------*)
function GetFileSHA256(const AFileName: string): string;
var
  DCP_sha256: TDCP_sha256;
  FileStream: TFileStream;
  Buffer: array[0..8191] of Byte; // 8KB buffer
  BytesRead: Integer;
  Digest: array[0..31] of Byte; // SHA-256 digest is 32 bytes (256 bits)
  i: Integer;
begin
  Result := '';
  DCP_sha256 := TDCP_sha256.Create(nil);
  FileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    DCP_sha256.Init;
    // Read and update in chunks for memory efficiency
    repeat
      BytesRead := FileStream.Read(Buffer, SizeOf(Buffer));
      if BytesRead > 0 then
        DCP_sha256.Update(Buffer, BytesRead);
    until BytesRead = 0;
    DCP_sha256.Final(Digest);
    // Convert the 32-byte array to a 64-character Hex string
    for i := 0 to 31 do
      Result := Result + IntToHex(Digest[i], 2);
  finally
    FileStream.Free;
    DCP_sha256.Free;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageDlg('hash Batch v1.0' +chr(10)+ chr(10)+
             'DCPcrypt Cryptographic Component Library v2.1' +chr(10)+
             'Copyright © 1999-2009 David Barton' +chr(10)+
             'crypto@cityinthesky.co.uk' +chr(10)+chr(10)+
             'Code by hackbard' +chr(10)+
             'github.com | Release 2026' +chr(10)
             ,mtInformation, [mbOK], 0);
end;

// calculate the hash batch
procedure TForm1.Calculate1Click(Sender: TObject);
var
  i : integer;
begin
  if ListBox1.Items.Count = 0 then
  begin
    MessageDlg('Load a folder to calculate the hashes!',mtInformation, [mbOK], 0);
    Exit;    // go out when ListBox is clear
  end;

  Screen.Cursor := crHourGlass;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ListBox1.Items.Count;
  RichEdit1.Clear;

  (* ---------- MD4 file hash calculating ----------*)
  if CheckBox1.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' MD4 hash results');
    RichEdit1.Lines.Add(' ----------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetMD4FileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, md4..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- MD5 file hash calculating ----------*)
  if CheckBox2.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' MD5 hash results');
    RichEdit1.Lines.Add(' ----------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetSHA1DCP(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, md5..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- SHA1 file hash calculating ----------*)
  if CheckBox3.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' SHA1 hash results');
    RichEdit1.Lines.Add(' -----------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetSHA1DCP(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, sha1..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- SHA256 file hash calculating ----------*)
  if CheckBox4.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' SHA256 hash results');
    RichEdit1.Lines.Add(' ------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetFileSHA256(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, sha256..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- SHA384 file hash calculating ----------*)
  if CheckBox5.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' SHA384 hash results');
    RichEdit1.Lines.Add(' ------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetSHA384FileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, sha384..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- SHA512 file hash calculating ----------*)
  if CheckBox6.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' SHA512 hash results');
    RichEdit1.Lines.Add(' ------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetSHA512FileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, sha512..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- HAVAl file hash calculating ----------*)
  if CheckBox7.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' Haval hash results');
    RichEdit1.Lines.Add(' -----------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetHavalFileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, Haval..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- TIGER file hash calculating ----------*)
  if CheckBox8.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' Tiger hash results');
    RichEdit1.Lines.Add(' ----------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetTigerFileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, Tiger..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- RIPEMD128 file hash calculating ----------*)
  if CheckBox9.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' Ripemd128 hash results');
    RichEdit1.Lines.Add(' ----------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetRipemd128FileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, Ripemd128..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  (* ---------- RIPEMD160 file hash calculating ----------*)
  if CheckBox10.Checked = true then
  begin
    RichEdit1.Lines.Add('');
    RichEdit1.Lines.Add(' Ripemd160 hash results');
    RichEdit1.Lines.Add(' ----------------------');
    for i := 0 to ListBox1.Items.Count -1 do
    begin
      RichEdit1.Lines.Add(' File ' + IntToStr(i) + ' - ' +
                          ExtractFileName(ListBox1.Items.Strings[i]) +
                          ' (' + IntToStr(Get_File_Size4(ListBox1.Items.Strings[i])) +
                          ' bytes)' + ' : ' +
                          GetRIPEMD160FileHash(ListBox1.Items.Strings[i]));
      StatusBar1.Panels[5].Text := IntToStr(i);
      StatusBar1.Panels[6].Text := 'calculating, Ripemd160..';
      ProgressBar1.Position := i;
      Application.ProcessMessages;
    end;
  end;

  // Write everything in lowercase.
  if LowerCase1.Checked = true then
    RichEdit1.Text := AnsiLowerCase(RichEdit1.Text);

  // Tell the ProgressBar to climb to the end of the bar.
  ProgressBar1.Position := ProgressBar1.Max;

  // colored all strings in RichEdit
  if Highlight1.Checked = true then
    HightLight_Syntax(RichEdit1);

  // This needs to happen twice because the colorization process
  // converts the strings if it is enabled.
  if LowerCase1.Checked = true then
    RichEdit1.Text := AnsiLowerCase(RichEdit1.Text);

  StatusBar1.Panels[6].Text := 'finish.';
  Screen.Cursor := crDefault;
end;


procedure TForm1.Calculate2Click(Sender: TObject);
begin
  Calculate1.OnClick(self);
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ListBox1.Clear;
end;

procedure TForm1.Clear2Click(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  RichEdit1.Perform(WM_COPY,0,0);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close();
end;

// export hashes to html with RichEdit format
procedure TForm1.ExportHtml1Click(Sender: TObject);
var
  html : TStringList;
  RE : TRichEdit;
  ms: TStream;
begin
  if SaveDialog2.Execute then
  begin
    RE := TRichEdit.Create(Self); // dynamic richedit
    try
      RE.Parent := Self;          // Associates it with the Form
      RE.Align := alClient;       // Fits the window
      RE.Visible := false;        // hide dynamic RE(RichEdit)
      ms:=TMemoryStream.Create;   // create memora stream
      try
        RichEdit1.Lines.SaveToStream(ms); // copy RichEdit to stream
        ms.Position:=0;                   // jump to first sel position
        RE.Lines.LoadFromStream(ms);      // load RE(RichEdit) from memory
      finally
        ms.Free;                          // destry stream in memory
      end;
      RE.SelectAll;                       // select strings in RE(RichEdit)
      RE.PlainText := false;              // be sure copy format
      RE.CopyToClipboard;                 // copy html code to clipboard
      html := TStringList.Create;         // create string list in memory [html]
      html.Add('<!DOCTYPE html>');
      html.Add('<html lang="en">');
      html.Add('<head>');
      html.Add('<meta charset="UTF-8">');
      html.Add('<title>MovieBase Product v1.0</title>');
      html.Add('</head>');
      html.Add('<body>');
      html.Add(ClipboardToHTML(Self));    // copy html code to stringlist [html]
      html.Add('</body>');
      html.Add('</html>');

      html.SaveToFile(SaveDialog2.FileName + '.html'); // save it
    except
      RE.Free;
      html.Free; // Free the stinglist from RAM
    end;
  end;
end;

// search dialog for RichEdit
procedure TForm1.FindDialog1Find(Sender: TObject);
const
  TWordSeperators: set of Char = ['A'..'Z', 'a'..'z', 'ö', 'Ö', 'Ä', 'ä', 'ü', 'Ü', 'ß',
  '´', '`', '@', '0'..'9'];
var
  Buffer: String;
  CmpText: String;
  Position: Integer;
  Counter: Integer;
  Left, Right: Boolean;
  Hit: Boolean;
begin
  if not (frMatchCase in Finddialog1.Options) then
  begin
    CmpText:= AnsiUpperCase(Finddialog1.FindText);
    Buffer := AnsiUpperCase(Copy(RichEdit1.Text,
                                 RichEdit1.SelStart+
                                 RichEdit1.SelLength+1,
                                 Length(RichEdit1.Text)))
  end
  else
  begin
    CmpText := Finddialog1.FindText;
    Buffer:=Copy(RichEdit1.Text,
                 RichEdit1.SelStart+
                 RichEdit1.SelLength+1,
                 Length(RichEdit1.Text));
  end;

  Position := AnsiPos(CmpText, Buffer);

  if Position > 0 then
  begin
    if frWholeWord in FindDialog1.Options then
    begin
      Counter:=0;
      Position := AnsiPos(CmpText, Buffer);
      Hit:=False;
      while (Position > 0) and not Hit do
      begin
        // Character set in user-defined functions
        Left:=(Position = 1) or (not (Buffer[Position-1] in TWordSeperators));
        Right:=(Position+Length(Finddialog1.FindText) >= Length(Buffer)) or
          (not (Buffer[Position+Length(Finddialog1.FindText)] in TWordSeperators));
        Hit:=Left and Right;
        // increased the current value of Position.
        Inc(Counter, Position);
        // deletes the subset from the string (dynamic array)
        Delete(Buffer, 1, Position);
        // searches for the first occurrence of the search string (CmpText)
        // within the main string (buffer).
        Position:=Pos(CmpText, Buffer);
      end;

      if Hit then
      begin
        RichEdit1.SelStart:= RichEdit1.SelStart+RichEdit1.SelLength+Counter-1;
        RichEdit1.SelLength:= Length(Finddialog1.FindText);
      end
      else
        FindDialog1.CloseDialog;
    end
    else
    begin
      RichEdit1.SelStart:= RichEdit1.SelStart+RichEdit1.SelLength+Position-1;
      RichEdit1.SelLength:= Length(Finddialog1.FindText);
    end;
  end
  else
    FindDialog1.CloseDialog;
  RichEdit1.SetFocus;
end;

{ This only replaces the font name and style; the colors are ignored
  because colorization has a higher priority, unless you disable
  text highlighting. }
procedure TForm1.Font1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    RichEdit1.SelectAll;
    Richedit1.SelAttributes.Name := FontDialog1.Font.Name;
    Richedit1.SelAttributes.Size := FontDialog1.Font.Size;
    Richedit1.SelAttributes.Style := FontDialog1.Font.Style;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  // create both scroll bars to RichEdit
  ScrollBarA: array[0..3] of TScrollStyle = (ssBoth,
                                             ssHorizontal,
                                             ssNone,
                                             ssVertical);
begin
  ListBox1.Style := lbOwnerDrawFixed;
  SendMessage(ListBox1.Handle,LB_SetHorizontalExtent,1000,0);
  ListBox1.ItemHeight := 16;

  //RichEdit1.ScrollBars := ssBoth;     // Displays both scroll bars
  //RichEdit1.ScrollBars := ssVertical; // Displays only the vertical scrollbar
  //RichEdit1.ScrollBars := ssNone;     // Hides all scrollbars
  RichEdit1.ScrollBars := ScrollBarA[0];

  { The WordWrap property in Delphi's TRichEdit determines whether text
    automatically wraps to fit the width of the control. When set to True,
    soft carriage returns are inserted cosmetically, and the text
    automatically flows to the next line at the component's right margin. }
  RichEdit1.WordWrap := False;

  // Significantly increases the text length and memory capacity of RichEdit,
  // allowing for extremely long texts.
  SendMessage(RichEdit1.Handle, EM_EXLIMITTEXT, 0, $7FFFFFF0);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
  StayTop1.OnClick(sender);
end;

procedure TForm1.Highlight1Click(Sender: TObject);
begin
  HightLight_Syntax(RichEdit1);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  if ListBox1.Items.Count <= 0 then
  begin
    Remove1.Enabled := false;
    Calculate2.Enabled := false;
  end else begin
    Remove1.Enabled := true;
    Calculate2.Enabled := true;
  end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  DrawListBoxExtra(Control, Index, Rect, State);
end;

// highlight RichEdit lower case
procedure TForm1.LowerCase1Click(Sender: TObject);
begin
  RichEdit1.Text := AnsiLowerCase(RichEdit1.Text);

  if Highlight1.Checked = true then
    HightLight_Syntax(RichEdit1);

  RichEdit1.Text := AnsiLowerCase(RichEdit1.Text);
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if SelectDirectory('Select directory', '', Directory) then
  begin
    ListBox1.Clear;
    RichEdit1.Clear;
    // Load all found files into the ListBox as system path
    GetAllFilesExtra(ListBox1.Items);
    // scroll the LIstBox to the last item
    Listbox1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
    // get path counts
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
    // The total file size of all files in the loaded folder.
    StatusBar1.Panels[3].Text := IntToStr(GetDirectorySize(Directory) div 1000) + 'kb';
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
var
  { To write text and characters in a structured manner and with a defined
    character encoding into a data stream or directly into a file. }
  LWriter: TStreamWriter;
  i: Integer;
begin
  if SaveDialog1.Execute then
  begin
    if SaveDialog1.FilterIndex = 1 then
    begin
      RichEdit1.PlainText := true ; // loads/saves with RTF tags

      // unicode export
      if Default1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.Default);
      if UTF81.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.UTF8);
      if UTF8Boom1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.UTF8);
      if UTF16LE1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.Unicode);
      if UTF16BE1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.BigEndianUnicode);
      if ANSI1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.ANSI);
      if ASCII1.Checked = true then
      LWriter := TStreamWriter.Create(SaveDialog1.FileName + '.txt', False, TEncoding.ASCII);

      try
        for i := 0 to RichEdit1.Lines.Count - 1 do
          LWriter.WriteLine(RichEdit1.Lines[i]);  // save textdocument
      finally
        LWriter.Free;
      end;
    end;

    // save rtf file format
    if SaveDialog1.FilterIndex = 2 then
    begin
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName + '.rtf');
    end;

    // save windows office document
    if SaveDialog1.FilterIndex = 3 then
    begin
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName + '.doc');
    end;
  end;
end;

procedure TForm1.Search1Click(Sender: TObject);
begin
  RichEdit1.SelStart := 0;
  FindDialog1.Execute;
end;

procedure TForm1.Selectall1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
end;

procedure TForm1.StayTop1Click(Sender: TObject);
begin
  if StayTop1.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

// highlight RichEdit upper case
procedure TForm1.UpperCase1Click(Sender: TObject);
begin
  RichEdit1.Text := AnsiUpperCase(RichEdit1.Text);
  HightLight_Syntax(RichEdit1);
  RichEdit1.Text := AnsiUpperCase(RichEdit1.Text);
end;

end.
