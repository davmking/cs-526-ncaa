import requests
from bs4 import BeautifulSoup
import pandas as pd

def scrape_ncaa_season_data(url):
    response = requests.get(url)
    if response.status_code != 200:
        print("Failed to retrieve data")
        return None    
    soup = BeautifulSoup(response.content, 'html.parser')
    table = soup.find('table', {'id': 'basic_school_stats'})
    rows = []
    for row in table.find('tbody').find_all('tr'):
        row_data = [td.get_text() for td in row.find_all('td')]
        if row_data:
            rows.append(row_data)
    df = pd.DataFrame(rows)
    df = df[[0, 1, 2, 3, 4, 5, 6, 8, 9, 11, 12, 14, 15, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]]
    df.columns = ['School', 'Games Played', 'Wins', 'Losses', 'W-L%', 'Simple Rating System', 'Strength of Schedule', 'Conf. Wins', 'Conf. Losses', 'Home Wins', 'Home Losses', 'Away Wins', 'Away Losses', 'Total Pts Scored', 'Total Pts Suffered', 'Minutes Played', 'FGM', 'FGA', 'FG%', '3PM', '3PA', '3P%', 'FTM', 'FTA', 'FT%', 'ORB', 'TRB', 'AST', 'STL', 'BLK', 'TOV', 'PF']
    return df

# Get data, save as individual csv's. Note: website has some mechanism to restrict number of requests, so if it stops working, change network
# for y in range(1996, 2025):
#     url = 'https://www.sports-reference.com/cbb/seasons/men/{0}-school-stats.html'.format(y)
#     current_df = scrape_ncaa_season_data(url)
#     current_df['Year'] = y
#     current_df.to_csv('Basic_School_Stats_{0}.csv'.format(y))

# Combine for convenience
df_list = []
for y in range(1996, 2025):
    file = 'Basic_School_Stats_{0}.csv'.format(y)
    df = pd.read_csv(file)
    df_list.append(df)
merged_df = pd.concat(df_list, ignore_index=True)
merged_df.drop(df.columns[0], axis=1).to_csv('Basic_Stats.csv', index=False)