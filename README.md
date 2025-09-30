# Mapping Carbon Project Overlaps (Geospatial Analysis)

## 📋 Overview
This repository focuses on identifying overlaps between efficient cookstove and avoided deforestation projects in voluntary carbon markets. The goal is to assess the risk of double issuance that undermines carbon market integrity.

---

## 🎯 Problem Statement
Carbon credit markets face a critical integrity challenge: when cookstove projects (which reduce fuelwood consumption) and forest protection projects (which prevent deforestation) operate in the same geographic areas, both may claim credit for the same carbon emission reductions. This "double issuance" inflates claimed climate benefits and erodes trust in carbon markets.

---

## ✨ Key Features

- **Direct Overlap Analysis** – project boundary intersections, % overlap, regional maps  
- **Proximity Analysis** – 5/10/15 km buffers to account for fuelwood collection distances  
- **Case Studies** – detailed district-level analysis of 6 VCS cookstove projects  

---

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

### Buffer analysis in Africa region
<div align="left">
  <img src="https://github.com/ankita-karki/Doubleissuance_Proximity/blob/main/output_maps/Africa_Proximity.png?raw=true">
</div>

*Map showing Buffer analysis between VCS Efficient Cookstove Projects and VCS Avoided Deforestation (AD) projects in Africa*

### Buffer analysis in Asia region
<div align="left">
  <img src="https://github.com/ankita-karki/Doubleissuance_Proximity/blob/main/output_maps/Asia_Proximity.png?raw=true">
</div>

*Map showing buffer analysis between VCS Efficient Cookstove Projects and VCS Avoided Deforestation (AD) projects in Asia*

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

## 🎓 Key Insights

### Direct Overlap
- VCS program shows highest risk (46%) due to broad country-level boundaries
- Gold Standard and CDM have more targeted project areas, reducing overlap

### Proximity Effects
- Overlap risk increases significantly with buffer distance
- 15km buffers reveal 2.7x more overlap than direct intersection alone
- Accounts for realistic fuelwood collection patterns

### Case Study Findings
- Actual cookstove distribution is highly localized
- Broad project boundaries significantly overstate impact areas
- High-risk districts identified: Malawi, Zambia border regions

## 📋 Policy Recommendations

1. **Standardized Boundary Delineation**: Require precise geospatial coordinates based on actual cookstove distribution
2. **Phased Area Claims**: Start with smaller, verified areas; expand as needed
3. **Buffer Zone Protocols**: Implement science-based buffer distances (10-15km)
4. **GIS Integration**: Automated overlap detection in registry systems
5. **Transboundary Coordination**: Cross-border frameworks for regional projects
6. **Regular Spatial Updates**: Mandate annual geospatial data updates

## Citation
* If you use this repository, kindly cite:
* Master's Thesis: "Assessing Double Issuance between Avoided Deforestation and Efficient Cookstove Projects: A Geospatial Analysis Approach."
* Author: Ankita Karki
* Institution: Rheinland-Pfälzische Technische Universität Kaiserslautern-Landau
* Supervisors: Jonathan Jupke, Isabel Hasse
