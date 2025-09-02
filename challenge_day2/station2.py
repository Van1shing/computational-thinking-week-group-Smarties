import datetime

def solution_station_2(date_str: str) -> str:
    week_days_jp = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"]
    date_obj = datetime.datetime.strptime(date_str, "%Y-%m-%d")
    weekday = date_obj.weekday()
    return week_days_jp[weekday]

