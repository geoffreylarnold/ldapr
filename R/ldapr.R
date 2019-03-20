#' TRun and ldapsearch and get user dn's
#'
#' @param ...
#'
#' @return list
#' @export
#'
#' @examples
ldapDNs <- function(...) {
  args <- c(...)
  result <- suppressWarnings(system(gsub("\\-x", "", paste0('ldapsearch ', paste0("-", names(args), " ", args, collapse = " "))), intern = TRUE, wait = T))

  lookup <- paste(result, collapse = "")

  lookupScrub <- gsub("?<!\\:) ", "", lookup)

  dns <- stringr::str_extract_all(lookupScrub, "dn:(.*?)DC=pa,DC=us")

  return(unlist(dns))
}

#' RRun ldapmodify from R
#'
#' @param ...
#'
#' @return ldap attribute change
#' @export
#'
#' @examples
ldapModify <- function(...) {
  args <- c(...)
  add <- paste0('ldapmodify ', paste0("-", names(args), " ", args, collapse = " "))
  print(add)
  system(add, intern = TRUE, wait = T)
}
