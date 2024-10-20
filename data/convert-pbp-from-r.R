library(reticulate)

load("data/game_info.RData")
load("data/pbp_data.RData")

py_run_string("import pickle")

py$game_info_py <- r_to_py(game_info)

py_run_string("
with open('game_info.pkl', 'wb') as f:
    pickle.dump(game_info_py, f)
")

py$pbp_data_py <- r_to_py(pbp_data)

py_run_string("
with open('pbp_data.pkl', 'wb') as f:
    pickle.dump(pbp_data_py, f)
")
