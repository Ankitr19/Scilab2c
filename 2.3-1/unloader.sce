// This file is released under the 3-clause BSD license. See COPYING-BSD.
// Generated by builder.sce: Please, do not edit this file

try
 getversion("scilab");
catch
 error("Scilab 5.4 or more is required.");
end;

fileQuit = get_absolute_file_path("unloader.sce") + "etc/" + "scilab2c.quit";
if isfile(fileQuit) then
  exec(fileQuit);
end

