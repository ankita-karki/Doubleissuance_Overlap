# Load the master function
source("master_function.R")

# Define file paths for VCS Cookstove and REDD in Africa
cookstove_files <- list.files(path = "KMLfile/Cookstove_VCS/Africa", pattern = "\\.kml$", full.names = TRUE)
avoided_def_files <- list.files(path = "KMLfile/VCS_REDD/Africa", pattern = "\\.kml$", full.names = TRUE)

# Read and validate geometries
cookstove_sf_list <- lapply(cookstove_files, read_and_make_valid)
avoided_def_list <- lapply(avoided_def_files, read_and_make_valid)

#Fixing Geometrical inconsistencies 
###################################
cookstove_sf_list[[7]]  <- st_make_valid(cookstove_sf_list[[7]])
cookstove_sf_list[[12]] <- st_make_valid(cookstove_sf_list[[12]])

## Drop fourth row of the eleventh element of redd_sf_list that causes the issues.  
avoided_def_list[[1]] <- avoided_def_list[[1]][1:3,]

###################

# Combine all cookstove and REDD+ sf objects into two master sf object
all_cookstove_sf <- do.call(rbind, cookstove_sf_list)
all_avoided_def_sf <- do.call(rbind, avoided_def_list)

##########################
# Perform overlap analysis
##########################
overlap_vcs_africa <- perform_overlap_analysis(cookstove_sf_list, avoided_def_list, "Africa", "VCS")

# Visualize the results
if (!is.null(overlap_vcs_africa)) {
  vcs_africa_map <- visualize_overlaps(overlap_vcs_africa, "Africa", "VCS")
  print(vcs_africa_map)
}

#################
# Summarize cookstove projects by location using area
filtered_cookstove_sf <- all_cookstove_sf %>%
  group_by(filename) %>%
  summarise(count = n())

# Call master function to summarize cookstove projects by area
cookstove_summary <- summarize_cookstove_by_area(filtered_cookstove_sf)

# Call master function to buffer and dissolve overlaps
buffered_cookstove_summary <- buffer_and_dissolve(filtered_cookstove_sf)

# Call master function to create maps
create_complete_map(cookstove_summary, all_avoided_def_sf, overlap_vcs_africa)


##########################
#Proximity analysis 
# Define buffer distances and colors
buffer_distances <- c(5000, 10000, 15000) # Distances in meters
buffer_colors <- c("#800080", "orange", "#0000FF") # Colors for each buffer distance

# Perform proximity analysis and generate map
buffer_map <- create_proximity_analysis_map(
  cookstove_sf = all_cookstove_sf,
  avoided_def_sf = all_avoided_def_sf,
  buffer_distances = buffer_distances,
  buffer_colors = buffer_colors
)

# Print the map
print(buffer_map)

