# Load the master function
source("master_function.R")


#Reading the KML files for Cookstove GS and Avoided deforestation VCS
cookstove_files <- list.files(path = "KML file/Cookstove_GS/Africa", pattern = "\\.kml$", full.names = TRUE)
avoided_def_files <- list.files(path = "KML file/VCS_REDD/Africa", pattern = "\\.kml$", full.names = TRUE)

# Read and validate geometries
cookstove_sf_list <- lapply(cookstove_files, read_and_make_valid)
avoided_def_list <- lapply(avoided_def_files, read_and_make_valid)

# Combine all cookstove and REDD+ sf objects into two master sf object
all_cookstove_sf <- do.call(rbind, cookstove_sf_list)
all_avoided_def_sf <- do.call(rbind, avoided_def_list)


# Overlap analysis
overlap_vcs_africa <- perform_overlap_analysis(cookstove_sf_list, avoided_def_list, "Africa", "GS") #No overlap found 


#### Visualize the results 
#if no overlap occurs, no plot is generated
if (!is.null(overlap_vcs_africa)) {
  vcs_africa_map <- visualize_overlaps(overlap_vcs_africa, "Africa", "GS")
  print(vcs_africa_map)
}
