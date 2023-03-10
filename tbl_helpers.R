#
#
# Helpers voor algemeen gebruik.
#
#

# C-style print functie
printf = function (...) cat(paste(sprintf(...),"\n"))

## log levels
ERR = 1
MSG = 2
WARN = 3
DEBUG = 4

# functie om (fout)meldingen weer te geven
# middels het level kunnen verschillende niveau's worden aangegeven, waarbij een lager niveau
# altijd wordt weergegeven (dus msg("test", MSG) wordt ook getoond bij log.level = 3) 
# - msg kan een object of een sprintf-style string zijn
# - level moet een log level zijn
# - overige argumenten worden doorgegeven aan sprintf
msg = function (msg, ..., level = DEBUG) {
  # alleen output geven als het ewenste level gelijk is of hoger dan de gegeven waarde
  if (exists("log.level")) {
    if (level > log.level) {
      return()
    } 
  }
  
  # geen gewenst level of level hoog genoeg; printen
  if (level == ERR) {
    if (is.character(msg))
      stop(sprintf(msg, ...))
    else
      stop(msg)
  } else if (level == MSG) {
    if (is.character(msg))
      message(sprintf(msg, ...))
    else
      message(msg)
  } else {
    if (is.character(msg))
      printf(paste0(ifelse(level == DEBUG, "[DEBUG] ", ""), msg), ...)
    else
      print(msg)
  }
}