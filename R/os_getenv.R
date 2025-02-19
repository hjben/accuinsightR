#' Get user's home directory
get_user_home_dir <- function () {
  home_path <- Sys.getenv("HOME")
  # path.expand("~")
}

#' Read .env file from user home directory
get_os_env <- function (env_type = "LC", env_path = NULL, env_file = NULL) {
  const_val = accu.consts
  file_dir = const_val$EXPERIMENT_INFO_FILE_DIR
  file_name = const_val$EXPERIMENT_INFO_FILE
  
  if (!is.null(env_path)) {
    file_dir = env_path
  }
  
  if (!is.null(env_file)) {
    file_name = env_file
  }
  
  read_file = file.path(file_dir, file_name)

  # Read in the data
  # x <- scan(normalizePath(read_file), what="", sep="\n")
  x <- scan(file.path(read_file), what="", sep="\n")

  # Separate elements by "="
  y <- strsplit(x, "=")

  # Extract the first vector element and set it as the list element name
  names(y) <- sapply(y, `[[`, 1)

  # names(y) <- sapply(y, function(x) x[[1]]) # same as above
  # Remove the first vector element from each list element
  y <- lapply(y, `[`, -1)
  #y <- lapply(y, function(x) x[-1]) # same as above
}

#' Get runs directory
#' @export
get_runs_path <- function () {
  const_val <- accu.consts
  home_dir <- const_val$EXPERIMENT_INFO_FILE_DIR
  run_dir = file.path(home_dir, const_val$RUNS_ROOT)

  if (file.exists(run_dir) == FALSE){
    dir.create(run_dir)
    Sys.chmod(run_dir, mode = "0777", use_umask = FALSE)
  }

  return(run_dir)
}
