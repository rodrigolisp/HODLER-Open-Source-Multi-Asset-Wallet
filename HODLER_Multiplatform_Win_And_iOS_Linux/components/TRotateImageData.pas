unit TRotateImageData;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Layouts,
  FMX.Edit, FMX.StdCtrls, FMX.Clipboard, FMX.Platform, FMX.Objects,
  System.Types, StrUtils, FMX.Dialogs;

type
  TRotateImage = class(TImage)
  private

    timer: TThread;
    isOn: boolean;
  protected

  public

    constructor Create(AOwner: TComponent); Override;
    procedure Start();
    procedure Stop();

  published

  end;

procedure Register;

implementation

uses uhome;

procedure Register;
begin
  RegisterComponents('Samples', [TRotateImage]);
end;

procedure TRotateImage.Start();
begin
  if isOn then
    exit;
  isOn := true;
  timer := TThread.CreateAnonymousThread(
    procedure
    begin

      while isOn do
      begin

        TThread.Synchronize(nil,
          procedure
          begin
            AnimateFloat('RotationAngle', RotationAngle + 180, 1);

          end);

        sleep(1000);

      end;

    end);

  timer.FreeOnTerminate := true;

  timer.Start;

end;

procedure TRotateImage.Stop();
begin

  isOn := false;

end;

constructor TRotateImage.Create(AOwner: TComponent);
var
  Stream: TResourceStream;
begin

  inherited Create(AOwner);
  // Bitmap.LoadFromStream();
  Stream := TResourceStream.Create(HInstance, 'RELOAD_IMAGE', RT_RCDATA);
  try
    Bitmap.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;

end;

end.
