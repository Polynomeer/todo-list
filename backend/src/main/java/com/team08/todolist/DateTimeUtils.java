package com.team08.todolist;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeUtils {
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static String formatByPattern(LocalDateTime localDateTime) {
        return localDateTime.format(formatter);
    }

}