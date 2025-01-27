# Overlap Analysis

## Overview
This repository focuses on identifying overlaps between efficient cookstove and avoided deforestation projects in voluntary carbon markets. The goal is to assess the risk of double issuance that undermines carbon market integrity.

## Key Features
* **Geospatial Mapping**: Overlay efficient cookstove and avoided deforestation project boundaries
* **Intersection Analysis**: Calculate overlap percentages
* **Visualization**: Generate maps showcasing overlapping regions in Africa, Asia, and Central America under VCS, Gold Standard, and CDM programs

## Project Maps
### VCS Africa Region
![Africa Overlap Map](https://github.com/ankita-karki/Doubleissuance_Overlap/blob/main/output_maps/VCS_Africa.png?raw=true)
*Map showing project overlaps between VCS cookstove and VCS Avoided deforestation projects in Africa region*

### VCS Asia Region
![Asia Overlap Map](https://github.com/ankita-karki/Doubleissuance_Overlap/blob/main/output_maps/VCS_Asia.png?raw=true)
*Map showing project overlaps between VCS cookstove and VCS Avoided deforestation projects in Asia region*

### Central America Region
![CentralAmerica Overlap Map](https://github.com/ankita-karki/Doubleissuance_Overlap/blob/main/output_maps/VCS_CentralAmerica.png?raw=true)
*Map showing project overlaps in VCS cookstove and VCS Avoided deforestation projects in Central America region*


## Tools and Technologies
* **R**: For geospatial data processing and analysis and  for advanced spatial visualizations
* **QGIS**: To refine and inspect geospatial data
* **Coordinate System**: WGS84 (EPSG:4326)

## Data Preparation
* Download project boundary data from Verra, Gold Standard, or CDM registries
* Preprocess geospatial data using QGIS to generate KML files if needed

## Outputs
* Spatial visualizations saved in the /outputs folder
* CSV files with overlap percentages and statistics

## Citation
* If you use this repository, kindly cite:
* Master's Thesis: "Assessing Double Issuance between Avoided Deforestation and Efficient Cookstove Projects: A Geospatial Analysis Approach."
* Author: Ankita Karki
* Institution: Rheinland-Pfälzische Technische Universität Kaiserslautern-Landau
* Supervisors: Jonathan Jupke, Isabel Hasse
