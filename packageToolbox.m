%% packageToolbox
% This script creates a MATLAB toolbox of the Switched Mode Power Supply Toolbox

% MATLAB updates the .prj file with host-machine-specific data when the toolbox is built, including
% hardcoded paths as well as including whatever packages are installed in host MATLAB as mandatory 
% dependencies. MATLAB packaging SUCKS!
% https://www.mathworks.com/matlabcentral/answers/301027-include-prj-file-in-version-control-without-build-causing-dirty-repo
% https://stackoverflow.com/questions/1790417/matlab-deployment-add-files-to-source-control

% Here we use a sterile template file that is version controlled. We copy it to the actual .prj file
% which MATLAB is free to do its dirty work on.
if exist("AURA.prj", "file")
    % exists, overwrite if the template is newer
    if datetime(dir("AURA.prj.template").date) > datetime(dir("Toolbox/AURA.prj").date)
        copyfile("AURA.prj.template", "Toolbox/AURA.prj")
        disp("AURA.prj updated")
    else
        disp("using existing AURA.prj")
    end
else
    % doesn't exist, copy the template
    copyfile("AURA.prj.template", "Toolbox/AURA.prj")
    disp("AURA.prj created")
end

matlab.addons.toolbox.packageToolbox("AURA.prj");
disp("packaging complete")