# ---- Libraries ----

library(tidyverse)
library(ncaahoopR)

# ---- 2024 ----

dates_2024 <- c("2024-03-19", "2024-03-20",
                "2024-03-21", "2024-03-22", "2024-03-23", "2024-03-24",
                "2024-03-28", "2024-03-29", "2024-03-30", "2024-03-31",
                "2024-04-06", "2024-04-08")

games_2024 <- get_master_schedule(dates_2024[1])

for(i in 2:length(dates_2024)){
  games_2024 <- rbind(games_2024, get_master_schedule(dates_2024[i]))
}

games_2024 <- games_2024 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away))

pbp_2024 <- get_pbp_game(games_2024$game_id)

pbp_2024 <- games_2024 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2024, by = "game_id")

pbp_2024 <- pbp_2024 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

pbp_2024 <- pbp_2024 %>% 
  mutate(referee_1 = if_else(referee_1 == "", NA, referee_1))

game_info_2024 <- pbp_2024 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2024)
rm(dates_2024)


# ---- 2023 ----

dates_2023 <- c("2023-03-14", "2023-03-15",
                "2023-03-16", "2023-03-17", "2023-03-18", "2023-03-19",
                "2023-03-23", "2023-03-24", "2023-03-25", "2023-03-26",
                "2023-04-01", "2023-04-03")

games_2023 <- get_master_schedule(dates_2023[1])

for(i in 2:length(dates_2023)){
  games_2023 <- rbind(games_2023, get_master_schedule(dates_2023[i]))
}

games_2023 <- games_2023 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away))

pbp_2023 <- get_pbp_game(games_2023$game_id)

pbp_2023 <- games_2023 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2023, by = "game_id")

pbp_2023 <- pbp_2023 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2023 <- pbp_2023 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2023)
rm(dates_2023)


# ---- 2022 ----

dates_2022 <- c("2022-03-15", "2022-03-16",
                "2022-03-17", "2022-03-18", "2022-03-19", "2022-03-20",
                "2022-03-24", "2022-03-25", "2022-03-26", "2022-03-27",
                "2022-04-02", "2022-04-04")

games_2022 <- get_master_schedule(dates_2022[1])

for(i in 2:length(dates_2022)){
  games_2022 <- rbind(games_2022, get_master_schedule(dates_2022[i]))
}

games_2022 <- games_2022 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away) &
           !grepl("Classic", away))

pbp_2022 <- get_pbp_game(games_2022$game_id)

pbp_2022 <- games_2022 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2022, by = "game_id")

pbp_2022 <- pbp_2022 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2022 <- pbp_2022 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2022)
rm(dates_2022)


# ---- 2021 ----

dates_2021 <- c("2021-03-18",
                "2021-03-19", "2021-03-20", "2021-03-21", "2021-03-22",
                "2021-03-27", "2021-03-28", "2021-03-29", "2021-03-30",
                "2021-04-03", "2021-04-05")

games_2021 <- get_master_schedule(dates_2021[1])

for(i in 2:length(dates_2021)){
  games_2021 <- rbind(games_2021, get_master_schedule(dates_2021[i]))
}

games_2021 <- games_2021 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away))

pbp_2021 <- get_pbp_game(games_2021$game_id)

pbp_2021 <- games_2021 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2021, by = "game_id")

pbp_2021 <- pbp_2021 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2021 <- pbp_2021 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2021)
rm(dates_2021)


# ---- 2019 ----

dates_2019 <- c("2019-03-19", "2019-03-20",
                "2019-03-21", "2019-03-22", "2019-03-23", "2019-03-24",
                "2019-03-28", "2019-03-29", "2019-03-30", "2019-03-31",
                "2019-04-06", "2019-04-08")

games_2019 <- get_master_schedule(dates_2019[1])

for(i in 2:length(dates_2019)){
  games_2019 <- rbind(games_2019, get_master_schedule(dates_2019[i]))
}

games_2019 <- games_2019 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away))

pbp_2019 <- get_pbp_game(games_2019$game_id)

pbp_2019 <- games_2019 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2019, by = "game_id")

pbp_2019 <- pbp_2019 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

pbp_2019 <- pbp_2019 %>% 
  mutate(referee_1 = if_else(referee_1 == "", NA, referee_1))

game_info_2019 <- pbp_2019 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2019)
rm(dates_2019)


# ---- 2018 ----

dates_2018 <- c("2018-03-13", "2018-03-14",
                "2018-03-15", "2018-03-16", "2018-03-17", "2018-03-18",
                "2018-03-22", "2018-03-23", "2018-03-24", "2018-03-25",
                "2018-03-31", "2018-04-02")

games_2018 <- get_master_schedule(dates_2018[1])

for(i in 2:length(dates_2018)){
  games_2018 <- rbind(games_2018, get_master_schedule(dates_2018[i]))
}

games_2018 <- games_2018 %>% 
  filter(!grepl("NIT", away) &
           !grepl("CBI", away) &
           !grepl("CIT", away))

pbp_2018 <- get_pbp_game(games_2018$game_id)

pbp_2018 <- games_2018 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2018, by = "game_id")

pbp_2018 <- pbp_2018 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2018 <- pbp_2018 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2018)
rm(dates_2018)


# ---- 2017 ----

dates_2017 <- c("2017-03-14", "2017-03-15",
                "2017-03-16", "2017-03-17", "2017-03-18", "2017-03-19",
                "2017-03-23", "2017-03-24", "2017-03-25", "2017-03-26",
                "2017-04-01", "2017-04-03")

games_2017 <- get_master_schedule(dates_2017[1])

for(i in 2:length(dates_2017)){
  games_2017 <- rbind(games_2017, get_master_schedule(dates_2017[i]))
}

games_2017 <- games_2017 %>% 
  filter(grepl("MEN'S", away))

pbp_2017 <- get_pbp_game(games_2017$game_id)

pbp_2017 <- games_2017 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2017, by = "game_id")

pbp_2017 <- pbp_2017 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2017 <- pbp_2017 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2017)
rm(dates_2017)


# ---- 2016 ----

dates_2016 <- c("2016-03-15", "2016-03-16",
                "2016-03-17", "2016-03-18", "2016-03-19", "2016-03-20",
                "2016-03-24", "2016-03-25", "2016-03-26", "2016-03-27",
                "2016-04-02", "2016-04-04")

games_2016 <- get_master_schedule(dates_2016[1])

for(i in 2:length(dates_2016)){
  games_2016 <- rbind(games_2016, get_master_schedule(dates_2016[i]))
}

games_2016 <- games_2016 %>% 
  filter(grepl("MEN'S", away))

pbp_2016 <- get_pbp_game(games_2016$game_id)

pbp_2016 <- games_2016 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2016, by = "game_id")

pbp_2016 <- pbp_2016 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2016 <- pbp_2016 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2016)
rm(dates_2016)


# ---- 2015 ----

dates_2015 <- c("2015-03-17", "2015-03-18",
                "2015-03-19", "2015-03-20", "2015-03-21", "2015-03-22",
                "2015-03-26", "2015-03-27", "2015-03-28", "2015-03-29",
                "2015-04-04", "2015-04-06")

games_2015 <- get_master_schedule(dates_2015[1])

for(i in 2:length(dates_2015)){
  games_2015 <- rbind(games_2015, get_master_schedule(dates_2015[i]))
}

games_2015 <- games_2015 %>% 
  filter(grepl("MEN'S", away))

pbp_2015 <- get_pbp_game(games_2015$game_id)

pbp_2015 <- games_2015 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2015, by = "game_id")

pbp_2015 <- pbp_2015 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

pbp_2015 <- pbp_2015 %>% 
  mutate(referee_1 = if_else(referee_1 == "", NA, referee_1))

game_info_2015 <- pbp_2015 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2015)
rm(dates_2015)


# ---- 2014 ----

dates_2014 <- c("2014-03-18", "2014-03-19",
                "2014-03-20", "2014-03-21", "2014-03-22", "2014-03-23",
                "2014-03-27", "2014-03-28", "2014-03-29", "2014-03-30",
                "2014-04-05", "2014-04-07")

games_2014 <- get_master_schedule(dates_2014[1])

for(i in 2:length(dates_2014)){
  games_2014 <- rbind(games_2014, get_master_schedule(dates_2014[i]))
}

games_2014 <- games_2014 %>% 
  filter(grepl("MEN'S", away))

pbp_2014 <- get_pbp_game(games_2014$game_id)

pbp_2014 <- games_2014 %>% 
  select(game_id, away_rank, home_rank) %>% 
  rename(away_seed = away_rank, home_seed = home_rank) %>% 
  right_join(pbp_2014, by = "game_id")

pbp_2014 <- pbp_2014 %>% 
  separate(referees, into = c("referee_1", "referee_2", "referee_3"), sep = "/")

game_info_2014 <- pbp_2014 %>% 
  group_by(game_id) %>% 
  slice_max(play_id) %>% 
  ungroup() %>% 
  mutate(overtime_game = if_else(half > 2, T, F)) %>% 
  select(game_id, date, home, away, home_seed, away_seed, home_score,
         away_score, score_diff, home_time_out_remaining, away_time_out_remaining,
         home_favored_by, total_line, referee_1, referee_2, referee_3,
         arena_location, arena, capacity, attendance, overtime_game) %>% 
  mutate(total_scored = home_score + away_score,
         over_under = total_scored - total_line,
         line_error = score_diff - home_favored_by,
         abs_line_error = abs(line_error),
         pct_attendance = attendance / capacity)

rm(games_2014)
rm(dates_2014)


# ---- Compiling ----

game_info <- list("game_info_2024" = game_info_2024,
                  "game_info_2023" = game_info_2023,
                  "game_info_2022" = game_info_2022,
                  "game_info_2021" = game_info_2021,
                  "game_info_2019" = game_info_2019,
                  "game_info_2018" = game_info_2018,
                  "game_info_2017" = game_info_2017,
                  "game_info_2016" = game_info_2016,
                  "game_info_2015" = game_info_2015,
                  "game_info_2014" = game_info_2014)

save(game_info, file = "data/game_info.RData")

rm(game_info_2024)
rm(game_info_2023)
rm(game_info_2022)
rm(game_info_2021)
rm(game_info_2019)
rm(game_info_2018)
rm(game_info_2017)
rm(game_info_2016)
rm(game_info_2015)
rm(game_info_2014)

pbp_data <- list("pbp_2024" = pbp_2024,
                 "pbp_2023" = pbp_2023,
                 "pbp_2022" = pbp_2022,
                 "pbp_2021" = pbp_2021,
                 "pbp_2019" = pbp_2019,
                 "pbp_2018" = pbp_2018,
                 "pbp_2017" = pbp_2017,
                 "pbp_2016" = pbp_2016,
                 "pbp_2015" = pbp_2015,
                 "pbp_2014" = pbp_2014)

save(pbp_data, file = "data/pbp_data.RData")

rm(pbp_2024)
rm(pbp_2023)
rm(pbp_2022)
rm(pbp_2021)
rm(pbp_2019)
rm(pbp_2018)
rm(pbp_2017)
rm(pbp_2016)
rm(pbp_2015)
rm(pbp_2014)

rm(i)

