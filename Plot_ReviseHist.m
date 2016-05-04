function Plot_ReviseHist(bins1, Hist)

axes1 = axes('Parent',figure,'YGrid','on','XGrid','on','LineWidth',2, 'FontSize',14,'FontName','Times New Roman');
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(bins1,Hist,'Parent',axes1,'LineWidth',2);


