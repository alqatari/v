import time

const (
	time_to_test = time.Time{
		year: 1980
		month: 7
		day: 11
		hour: 21
		minute: 23
		second: 42
		unix: 332198622
	}
)

fn test_is_leap_year() {
	// 1996 % 4 = 0 and 1996 % 100 > 0
	assert time.is_leap_year(1996) == true
	// 2000 % 4 = 0 and 2000 % 400 = 0
	assert time.is_leap_year(2000) == true
	// 1996 % 4 > 0
	assert time.is_leap_year(1997) == false
	// 2000 % 4 = 0 and 2000 % 100 = 0
	assert time.is_leap_year(2100) == false
}

fn check_days_in_month(month, year, expected int) bool {
	res := time.days_in_month(month, year) or {
		return false
	}
	return res == expected
}

fn test_days_in_month() {
	days_in_month := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	for i, days in days_in_month {
		month := i + 1
		assert check_days_in_month(month, 2001, days)
	}
}

fn test_unix() {
	t := time.unix(1564366499)
	assert t.year == 2019
	assert t.month == 7
	assert t.day == 29
	assert t.hour == 2
	assert t.minute == 14
	assert t.second == 59
	t2 := time.unix(1078058096)
	assert t2.year == 2004
	assert t2.month == 2
	assert t2.day == 29
	assert t2.hour == 12
	assert t2.minute == 34
	assert t2.second == 56
	t3 := time.unix(1070236799)
	assert t3.year == 2003
	assert t3.month == 11
	assert t3.day == 30
	assert t3.hour == 23
	assert t3.minute == 59
	assert t3.second == 59
	t4 := time.unix(1577783439)
	assert t4.year == 2019
	assert t4.month == 12
	assert t4.day == 31
	assert t4.hour == 9
	assert t4.minute == 10
	assert t4.second == 39
	t5 := time.unix(-1824922433)
	assert t5.year == 1912
	assert t5.month == 3
	assert t5.day == 4
	assert t5.hour == 5
	assert t5.minute == 6
	assert t5.second == 7
	t6 := time.unix(1577858969)
	assert t6.year == 2020
	assert t6.month == 1
	assert t6.day == 1
	assert t6.hour == 6
	assert t6.minute == 9
	assert t6.second == 29
}

fn test_format_ss() {
	assert '11.07.1980 21:23:42' == time_to_test.get_fmt_str(.dot, .hhmmss24, .ddmmyyyy)
}

fn test_smonth() {
	month_names := ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
	'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	for i, name in month_names {
		month_num := i + 1
		t := time.Time{
			year: 1980
			month: month_num
			day: 1
			hour: 0
			minute: 0
			second: 0
			unix: 0
		}
		assert t.smonth() == name
	}
}

fn test_day_of_week() {
	for i in 0..7 {
		day_of_week := i + 1
		// 2 Dec 2019 is Monday
		t := time.Time{
			year: 2019
			month: 12
			day: 2 + i
			hour: 0
			minute: 0
			second: 0
			unix: 0
		}
		assert day_of_week == t.day_of_week()
	}
}

fn test_weekday_str() {
	day_names := ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
	for i, name in day_names {
		// 2 Dec 2019 is Monday
		t := time.Time{
			year: 2019
			month: 12
			day: 2 + i
			hour: 0
			minute: 0
			second: 0
			unix: 0
		}
		assert t.weekday_str() == name
	}
}

fn test_add_days() {
	num_of_days := 3
	t := time_to_test.add_days(num_of_days)
	assert t.day == time_to_test.day + num_of_days
	assert t.unix == time_to_test.unix + 86400 * u64(num_of_days)
}

fn test_str() {
	assert '1980-07-11 21:23:42' == time_to_test.str()
}
