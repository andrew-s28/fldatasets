import numpy as np
import xarray as xr


class NHLSections:
    def __init__(self, loadpath=None, savepath=None):
        self.loadpath = loadpath
        self.savepath = savepath
        self.get_data = self._instance_get_data
        self.get_climatologies = self._instance_get_climatologies

    @staticmethod
    def get_data(loadpath=None, savepath=None):
        if loadpath is None:
            loadpath = "https://raw.githubusercontent.com/andrew-s28/fldatasets/main/data/Newport_Hydrographic_Line_Data_1997_2021/data_files/newport_hydrographic_line_gridded_sections.nc"
        data = xr.load_dataset(loadpath)
        if savepath is not None:
            data.to_netcdf(savepath)
        return data

    def _instance_get_data(self):
        if self.loadpath is None:
            self.loadpath = "https://raw.githubusercontent.com/andrew-s28/fldatasets/main/data/Newport_Hydrographic_Line_Data_1997_2021/data_files/newport_hydrographic_line_gridded_sections.nc"
        data = xr.load_dataset(self.loadpath)
        if self.savepath is not None:
            data.to_netcdf(self.savepath)
        return data

    @staticmethod
    def get_climatologies(loadpath=None, savepath=None):
        if loadpath is None:
            loadpath = "https://raw.githubusercontent.com/andrew-s28/fldatasets/main/data/Newport_Hydrographic_Line_Data_1997_2021/data_files/newport_hydrographic_line_gridded_section_climatologies.nc"
        data = xr.load_dataset(loadpath)
        if savepath is not None:
            data.to_netcdf(savepath)
        return data
    
    def _instance_get_climatologies(self):
        if self.loadpath is None:
            self.loadpath = "https://raw.githubusercontent.com/andrew-s28/fldatasets/main/data/Newport_Hydrographic_Line_Data_1997_2021/data_files/newport_hydrographic_line_gridded_section_climatologies.nc"
        data = xr.load_dataset(self.loadpath)
        if self.savepath is not None:
            data.to_netcdf(self.savepath)
        return data
