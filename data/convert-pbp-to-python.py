import pandas as pd
import pickle

with open("game_info.pkl", "rb") as f:
  games = pickle.load(f)
  
game_info = {key: pd.DataFrame(value) for key, value in games.items()}

with open("pbp_data.pkl", "rb") as f:
  pbps = pickle.load(f)
  
pbp_data = {key: pd.DataFrame(value) for key, value in pbps.items()}
