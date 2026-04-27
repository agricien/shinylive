# Antigravity Export Script
# Optimized for Windows symlinks and Wasm GIS dependencies

if (!requireNamespace("shinylive", quietly = TRUE)) {
  install.packages("shinylive", repos = "https://cloud.r-project.org/")
}

app_dir <- "app"
output_dir <- "docs"

# Verify environment
if (!dir.exists(app_dir)) {
  stop("Error: Folder '/app' not found. Ensure you are in the project root.")
}

message("--- Starting Shinylive Export ---")
message("Source: ", normalizePath(app_dir))
message("Destination: ", normalizePath(output_dir, mustWork = FALSE))

# Perform export
# wasm_packages_repos helps ensure we get the correct Wasm binaries
shinylive::export(
  appdir = app_dir,
  destdir = output_dir,
  wasm_packages_repos = "https://repo.r-wasm.org",
  verbose = TRUE
)

message("--- Export Complete ---")
message("Output available in: ", output_dir)
