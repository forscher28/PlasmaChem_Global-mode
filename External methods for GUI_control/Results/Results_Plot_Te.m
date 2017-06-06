function OutputFigure = Results_Plot_Te(X,Y_Te,Title,Controller,toflag)
	%disp('Results_Plot_Te called')
	TempFigure 			= figure;
	TempFigure.Visible 	= 'off';
	IndependentVariable = Controller.H.GUI_7_IndependentVar.String{Controller.H.GUI_7_IndependentVar.Value};
	p 					= plot(X,Y_Te);
	ax 					= TempFigure.Children;
	ax.FontSize 		= 16;
	switch IndependentVariable
	case 'Test #'
		xlabel('Test index','FontSize',18)	
	case 'Power absorbed'
		xlabel('Power absorbed (W)','FontSize',18)
	case 'Starting pressure'
		xlabel('Starting pressure (mTorr)','FontSize',18)
	case 'Gas supply'
		switch Controller.H.GUI_7_GasSupplyVary.String{Controller.H.GUI_7_GasSupplyVary.Value}
		case 'Total flow'
			xlabel('Total gas supply (sccm)','FontSize',18)
		otherwise
			ParameterSplit 	= strsplit(Controller.H.GUI_7_GasSupplyVary.String{Controller.H.GUI_7_GasSupplyVary.Value});
			GasSupplyKey 	= ParameterSplit{1};
			TotalFlow 		= Controller.H.GUI_7_GasSupplyAt.String{Controller.H.GUI_7_GasSupplyAt.Value};
			xlabel(sprintf('%s proportion (%%) of %ssccm total flow',GasSupplyKey,TotalFlow),'FontSize',18)
		end
	end
	ylabel(ax,'Electron Temperature (eV)','FontSize',18);
	title(Title)
	p.LineWidth = 3;
	p.Marker 			= '.';
	p.MarkerSize 		= 16;
	warning('off','MATLAB:handle_graphics:exceptions:SceneNode');
	set( findall(TempFigure, '-property', 'Units' ), 'Units', 'Normalized' );
	set( findall(TempFigure, '-property', 'FontUnits' ), 'FontUnits', 'Normalized' );
	ax.OuterPosition = [0 0 1 1];
	switch toflag
	case 'GUI'
		ax.Parent = Controller.H.GUI_7_PlotPanel;
		delete(TempFigure)
	case 'figure'
		if nargout == 1
			OutputFigure = TempFigure;
			OutputFigure.Visible = 'on';
		else
			TempFigure.Visible = 'on';
		end
	otherwise
		warning('invalid flag for Results_Plot')
	end
end