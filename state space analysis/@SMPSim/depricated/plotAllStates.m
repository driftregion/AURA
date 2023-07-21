function plotAllStates(obj, fn, oSelect, subplots)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    [ xs, t] = obj.SS_WF_Reconstruct;
    fig = figure(fn);

    

    ns = size(xs,1);
    
    if(nargin <= 2)
        subplots = 1;
        oSelect = 1:ns; 
    elseif(nargin <=3)
        subplots = 1;
    end
    
    ns = length(oSelect);
    
    if(subplots)
        nrMax = 10;
        nGrid = 10;
        nc = ceil(ns/nrMax);
        nr = min(ns,nrMax);
        for j = 1:nc
            for i=1:nr
                nsi = i+nr*(j-1);
                if nsi > ns
                    break
                end
                inds = [((i-1)*nGrid+1):(i*nGrid)]*nc - (nc-1) + (j-1);
                subplot(nGrid*nr,nc,inds)
                plot(t,xs(oSelect(nsi),:), 'Linewidth', 3);
                hold on;
                ylims = ylim;
                ylim(ylims);
                xlim([min(t) max(t)]);
                for k = 1:length(obj.ts)
                    plot(sum(obj.ts(1:k))*ones(1,2), ylims, ':k');
                end
                hold off;
                try
                    ylabel(obj.stateNames{oSelect(nsi)});
                catch
                    warning('State Names not set in topology subclass');
                end
                box on
                if(i<nr)
                    set(gca, 'Xticklabel', []);
                else
                    xlabel('t')
                end
            end
            if nsi > ns
                break
            end
        end
%         for i=1:ns
%             subplot(10*ns,1,i*10-9:i*10)
%             plot(t,xs(i,:), 'Linewidth', 3);
%             hold on;
%             ylims = ylim;
%             ylim(ylims)
%             for j = 1:length(obj.ts)
%                 plot(sum(obj.ts(1:j))*ones(1,2), ylims, ':k');
%             end
%             hold off;
%             ylabel(obj.getstatenames{i});
%             box on
%             if(i<ns)
%                 set(gca, 'Xticklabel', []);
%             else
%                 xlabel('t')
%             end
%         end
    else
        lines = findobj(gca,'Type','Line');
        firstrun = (numel(lines) == 0);
        for i = 1:numel(lines)
          lines(i).LineWidth = 1;
          lines(i).LineStyle = ':';
        end

        plot(t,xs(oSelect,:), 'linewidth',2);
        if(firstrun)
            legend(obj.stateNames);
        end
        hold on;
%         plot(t, obj.converter.topology.constraints.regtarget*ones(size(t)), '-.k', 'linewidth',3);
        ylims = [min(min(xs(oSelect,:))) max(max(xs(oSelect,:)))];
        ylim(ylims)
        for i = 1:length(obj.ts)
            plot(sum(obj.ts(1:i))*ones(1,2), ylims, ':r');
        end
    end

    %% Link all time axes
    children = get(fig,'Children');
    ax = [];
    for i = 1:length(children)
        if strcmp(class(children(i)),'matlab.graphics.axis.Axes')
            ax = [ax, children(i)];
        end
    end
    linkaxes(ax,'x');

end