package util

import (
	"fmt"
	"time"
)

func format(formattedTime string) (time.Time, error) {
	// Parse the formatted time
	parsedTime, err := time.Parse(time.RFC3339Nano, formattedTime)
	if err != nil {
		return time.Time{}, fmt.Errorf("failed to parse time: %w", err)
	}
	return parsedTime, nil
	// Extract the desired components
	// year, month, day := parsedTime.Date()
	// hour, min, sec := parsedTime.Clock()
	// nano := parsedTime.Nanosecond()

	// Print the extracted components
	// fmt.Println("Year:", year)
	// fmt.Println("Month:", month)
	// fmt.Println("Day:", day)
	// fmt.Println("Hour:", hour)
	// fmt.Println("Minute:", min)
	// fmt.Println("Second:", sec)
	// fmt.Println("Nanosecond:", nano)
}
