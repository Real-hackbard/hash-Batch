object Form1: TForm1
  Left = 224
  Top = 110
  Caption = 'hash Batch'
  ClientHeight = 509
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = 'hash Batch'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 672
    object Label1: TLabel
      Left = 24
      Top = 26
      Width = 113
      Height = 13
      Caption = 'Multi file hash calculator'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 490
    Width = 676
    Height = 19
    Panels = <
      item
        Text = 'Files :'
        Width = 40
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Folder :'
        Width = 50
      end
      item
        Text = '0 kb'
        Width = 100
      end
      item
        Text = 'Hash :'
        Width = 45
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 489
    ExplicitWidth = 672
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 676
    Height = 96
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 672
    object GroupBox1: TGroupBox
      Left = 8
      Top = 6
      Width = 457
      Height = 83
      Caption = ' hash '
      TabOrder = 0
      object CheckBox1: TCheckBox
        Left = 16
        Top = 24
        Width = 47
        Height = 17
        TabStop = False
        Caption = 'MD4'
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 16
        Top = 47
        Width = 47
        Height = 17
        TabStop = False
        Caption = 'MD5'
        TabOrder = 1
      end
      object CheckBox3: TCheckBox
        Left = 87
        Top = 24
        Width = 51
        Height = 17
        TabStop = False
        Caption = 'SHA1'
        TabOrder = 2
      end
      object CheckBox4: TCheckBox
        Left = 87
        Top = 47
        Width = 64
        Height = 17
        TabStop = False
        Caption = 'SHA256'
        TabOrder = 3
      end
      object CheckBox5: TCheckBox
        Left = 174
        Top = 24
        Width = 64
        Height = 17
        TabStop = False
        Caption = 'SHA384'
        TabOrder = 4
      end
      object CheckBox6: TCheckBox
        Left = 174
        Top = 47
        Width = 64
        Height = 17
        TabStop = False
        Caption = 'SHA512'
        TabOrder = 5
      end
      object CheckBox7: TCheckBox
        Left = 277
        Top = 24
        Width = 52
        Height = 17
        TabStop = False
        Caption = 'Haval'
        TabOrder = 6
      end
      object CheckBox8: TCheckBox
        Left = 277
        Top = 47
        Width = 44
        Height = 17
        TabStop = False
        Caption = 'Tiger'
        TabOrder = 7
      end
      object CheckBox9: TCheckBox
        Left = 368
        Top = 24
        Width = 78
        Height = 17
        TabStop = False
        Caption = 'Ripemd128'
        TabOrder = 8
      end
      object CheckBox10: TCheckBox
        Left = 368
        Top = 47
        Width = 78
        Height = 17
        TabStop = False
        Caption = 'Ripemd160'
        TabOrder = 9
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 145
    Width = 676
    Height = 345
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 672
    ExplicitHeight = 344
    object Splitter1: TSplitter
      Left = 0
      Top = 145
      Width = 676
      Height = 5
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 513
    end
    object ListBox1: TListBox
      Left = 0
      Top = 0
      Width = 676
      Height = 145
      TabStop = False
      Align = alTop
      BevelOuter = bvNone
      ItemHeight = 13
      MultiSelect = True
      PopupMenu = PopupMenu2
      TabOrder = 0
      OnClick = ListBox1Click
      OnDrawItem = ListBox1DrawItem
    end
    object RichEdit1: TRichEdit
      Left = 0
      Top = 150
      Width = 676
      Height = 178
      TabStop = False
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 1
      OnChange = RichEdit1Change
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 328
      Width = 676
      Height = 17
      Align = alBottom
      TabOrder = 2
      ExplicitTop = 327
      ExplicitWidth = 672
    end
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 232
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        Enabled = False
        ShortCut = 16467
        OnClick = Save1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ExportHtml1: TMenuItem
        Caption = 'Export Html'
        Enabled = False
        ShortCut = 16456
        OnClick = ExportHtml1Click
      end
      object UnicodeExportonlyTXTfile1: TMenuItem
        Caption = 'Unicode Export (*.txt)'
        object Default1: TMenuItem
          AutoCheck = True
          Caption = 'Default'
          RadioItem = True
        end
        object N6: TMenuItem
          AutoCheck = True
          Caption = '-'
          RadioItem = True
        end
        object UTF81: TMenuItem
          AutoCheck = True
          Caption = 'UTF-8'
          RadioItem = True
        end
        object UTF8Boom1: TMenuItem
          AutoCheck = True
          Caption = 'UTF-8 Boom'
          RadioItem = True
        end
        object UTF16LE1: TMenuItem
          AutoCheck = True
          Caption = 'UTF-16 LE'
          RadioItem = True
        end
        object UTF16BE1: TMenuItem
          AutoCheck = True
          Caption = 'UTF-16 BE'
          RadioItem = True
        end
        object ANSI1: TMenuItem
          AutoCheck = True
          Caption = 'ANSI'
          RadioItem = True
        end
        object ASCII1: TMenuItem
          AutoCheck = True
          Caption = 'ASCII'
          RadioItem = True
        end
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object hash1: TMenuItem
      Caption = 'hash'
      object Calculate1: TMenuItem
        Caption = 'Calculate'
        ShortCut = 112
        OnClick = Calculate1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Highlight1: TMenuItem
        AutoCheck = True
        Caption = 'Highlight'
        OnClick = Highlight1Click
      end
      object Search1: TMenuItem
        Caption = 'Search'
        OnClick = Search1Click
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object Font1: TMenuItem
        Caption = 'Font'
        OnClick = Font1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object LowerCase1: TMenuItem
        AutoCheck = True
        Caption = 'Lower Case'
        Checked = True
        RadioItem = True
        OnClick = LowerCase1Click
      end
      object UpperCase1: TMenuItem
        AutoCheck = True
        Caption = 'Upper Case'
        RadioItem = True
        OnClick = UpperCase1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object StayTop1: TMenuItem
        AutoCheck = True
        Caption = 'Stay Top'
        OnClick = StayTop1Click
      end
    end
    object N1: TMenuItem
      Caption = '?'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 256
    Top = 233
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 233
    object Copy1: TMenuItem
      Caption = 'Copy'
      Enabled = False
      OnClick = Copy1Click
    end
    object Selectall1: TMenuItem
      Caption = 'Select all'
      Enabled = False
      OnClick = Selectall1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Clear2: TMenuItem
      Caption = 'Clear'
      OnClick = Clear2Click
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 
      'Textfile (*.txt)|*.txt|Rich Text Format (*.rtf)|*.rtf|Microsoft ' +
      'Office Document (*.doc)|*.doc'
    Left = 64
    Top = 233
  end
  object SaveDialog2: TSaveDialog
    Filter = 'Hypertext Markup Language (*.html)|*.html'
    Left = 48
    Top = 337
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
    Left = 144
    Top = 337
  end
  object PopupMenu2: TPopupMenu
    Left = 256
    Top = 337
    object Calculate2: TMenuItem
      Caption = 'Calculate'
      Enabled = False
      OnClick = Calculate2Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      Enabled = False
      OnClick = Remove1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end
