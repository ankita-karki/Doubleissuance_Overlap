# Load necessary libraries
library(sf)
library(dplyr)
library(leaflet)

# Function to read and validate geometries
read_and_make_valid <- function(file) {
  sf_obj <- st_read(file, quiet = TRUE)  # Read file into an sf object
  sf_obj <- st_make_valid(sf_obj)       # Fix invalid geometries
  sf_obj$filename <- basename(file)     # Add filename as an attribute
  return(sf_obj)
}

# Master function for overlap analysis
perform_overlap_analysis <- function(cookstove_list, avoided_def_list, region_name = "Region", program_name = "Program") {
  overlap_indices <- list()  # Store overlapping indices
  
  # Perform overlap analysis
  for (j in seq_along(avoided_def_list)) {
    overlaps_with_cookstove <- rep(FALSE, nrow(avoided_def_list[[j]]))
    for (i in seq_along(cookstove_list)) {
      overlaps <- st_intersects(avoided_def_list[[j]], cookstove_list[[i]], sparse = FALSE)
      overlaps_with_cookstove <- overlaps_with_cookstove | apply(overlaps, 1, any)
    }
    overlap_indices[[j]] <- which(overlaps_with_cookstove)
  }
  
  # Extract overlapping geometries
  overlapping_geometries <- lapply(seq_along(overlap_indices), function(j) {
    if (length(overlap_indices[[j]]) > 0) {
      avoided_def_list[[j]][overlap_indices[[j]], ]
    }
  })
  overlapping_geometries <- Filter(Negate(is.null), overlapping_geometries)
  
  # Combine results and add identifiers
  if (length(overlapping_geometries) > 0) {
    overlap_sf <- do.call(rbind, overlapping_geometries)
    overlap_sf$region <- region_name
    overlap_sf$program <- program_name
    return(overlap_sf)
  } else {
    message("No overlaps found for ", program_name, " in ", region_name)
    return(NULL)
  }
}

# Visualization function
visualize_overlaps <- function(overlap_sf, region_name, program_name) {
  leaflet() %>%
    addProviderTiles(providers$OpenStreetMap) %>%
    addPolygons(data = all_avoided_def_sf, fillColor = "green", color = "black", fillOpacity = 0.5, weight = 1, 
                group = "Avoided Deforestation Projects") %>%
    addPolygons(data = all_cookstove_sf, fillColor = "blue", color = "black", fillOpacity = 0.5, weight = 1, 
                group = "Avoided Deforestation Projects") %>%
    addPolygons(data = overlap_sf, fillColor = "red", color = "black", fillOpacity = 0.7, weight = 1, 
                group = "Overlapping Areas") %>%
    addLayersControl(overlayGroups = c("Cookstove Projects", "Avoided Deforestation Projects", "Overlapping Areas"),
                     options = layersControlOptions(collapsed = FALSE, position= "topleft")) %>%
    addLegend(position = "bottomright", colors = c("blue", "green", "red"), 
              labels = c("Cookstove Projects", "Avoided Deforestation Projects", "Overlapping Areas"), opacity = 0.5)%>%
    addScaleBar(position = "bottomleft", options = scaleBarOptions(maxWidth = 100, metric = TRUE, imperial = FALSE))
}


# Function to summarize cookstove projects by location, using area for grouping with a tolerance
summarize_cookstove_by_area <- function(filtered_cookstove_sf) {
  cookstove_summary <- filtered_cookstove_sf %>%
    mutate(approx_area = round(st_area(geometry), digits = 2)) %>%  # Calculate area and round to add tolerance
    group_by(approx_area) %>%
    summarise(count = n()) %>%
    ungroup()
  
  return(cookstove_summary)
}

# Function to create a buffer and dissolve overlaps in the cookstove geometries
buffer_and_dissolve <- function(filtered_cookstove_sf) {
  cookstove_summary <- filtered_cookstove_sf %>%
    mutate(buffered_geometry = st_buffer(geometry, dist = 0.01)) %>%  # Adjust dist based on your CRS and desired proximity
    group_by(buffered_geometry) %>%
    summarise(count = n()) %>%
    st_cast("MULTIPOLYGON") %>% # Standardizing geometry type
    ungroup()
  
  return(cookstove_summary)
}

# Function to create a map with cookstove and deforestation overlap
create_complete_map <- function(cookstove_summary, avoided_def_sf, overlap_sf) {
  custom_blues <- c("#deebf7", "#00A8E0", "#008AB8", "#004D66", "#002E3D")
  
  # Plot cookstove projects with gradient and overlap with avoided deforestation projects and overlap_sf in red
  complete_map <- tm_shape(cookstove_summary) +
    tm_polygons("count", palette = custom_blues, alpha = 0.9, border.col = "black", title = "Cookstove Project Count by Area") +
    tm_shape(avoided_def_sf) +
    tm_fill(col = "darkgreen", lwd = 1, alpha = 0.5) +
    tm_shape(overlap_sf) +
    tm_fill(col = "red", lwd = 1, alpha = 0.8) +
    tm_layout(legend.outside = TRUE, legend.position = c("right", "bottom")) +
    tm_scale_bar(text.size = 0.9, position = c("right", "bottom")) +
    tm_compass(text.size = 0.2, position = c("right", "top")) +
    tm_layout(frame = FALSE)
  
  print(complete_map)
}
