# Load the master function
source("master_function.R")

#Reading the KML files
cookstove_files <- list.files(path = "KMLfile/Cookstove_VCS/Central America", pattern = "\\.kml$", full.names = TRUE)
avoided_def_files <- list.files(path = "KMLfile/VCS_REDD/Central America", pattern = "\\.kml$", full.names = TRUE)

# Read and validate geometries
cookstove_sf_list <- lapply(cookstove_files, read_and_make_valid)
avoided_def_list <- lapply(avoided_def_files, read_and_make_valid)

# Combine all cookstove and REDD+ sf objects into two master sf object
all_cookstove_sf <- do.call(rbind, cookstove_sf_list)
all_avoided_def_sf <- do.call(rbind, avoided_def_list)

#########################
# Perform overlap analysis
##########################
overlap_vcs_asia <- perform_overlap_analysis(cookstove_sf_list, avoided_def_list, "Central America", "VCS")


#### Visualize the results
if (!is.null(overlap_vcs_asia)) {
  vcs_asia_map <- visualize_overlaps(overlap_vcs_asia, "Central America", "VCS")
  print(vcs_asia_map)
}
