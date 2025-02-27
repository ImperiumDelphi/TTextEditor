unit TextEditor.Colors;

interface

uses
  System.Classes, Vcl.Graphics, TextEditor.Types;

type
  TTextEditorColors = class(TPersistent)
  strict private
    FBackground: TColor;
    FForeground: TColor;
    FOnChange: TTextEditorCodeColorEvent;
    FReservedWord: TColor;
    procedure SetBackground(const AColor: TColor);
    procedure SetForeground(const AColor: TColor);
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
  published
    property Background: TColor read FBackground write SetBackground default clWindow;
    property Foreground: TColor read FForeground write SetForeground default clWindowText;
    property OnChange: TTextEditorCodeColorEvent read FOnChange write FOnChange;
    property ReservedWord: TColor read FReservedWord write FReservedWord default clWindowText;
  end;

implementation

constructor TTextEditorColors.Create;
begin
  inherited;

  FBackground := clWindow;
  FForeground := clWindowText;
  FReservedWord := clWindowText;
end;

procedure TTextEditorColors.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTextEditorColors) then
  with ASource as TTextEditorColors do
  begin
    Self.FBackground := FBackground;
    Self.FForeground := FForeground;
    Self.FReservedWord := FReservedWord;
    if Assigned(Self.FOnChange) then
      Self.FOnChange(ccBoth);
  end
  else
    inherited Assign(ASource);
end;

procedure TTextEditorColors.SetBackground(const AColor: TColor);
begin
  if AColor <> FBackground then
  begin
    FBackground := AColor;
    if Assigned(FOnChange) then
      FOnChange(ccBackground);
  end;
end;

procedure TTextEditorColors.SetForeground(const AColor: TColor);
begin
  if AColor <> FForeground then
  begin
    FForeground := AColor;
    if Assigned(FOnChange) then
      FOnChange(ccForeground);
  end;
end;

end.
