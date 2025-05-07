
package com.nasa.spaceagencymanager;

import database.entities.*;
import java.util.HashMap;
import java.util.Map;

public class TableEntityMapper {

    private static final Map<String, Class<?>> tableEntityMap = new HashMap<>();

    static {
        tableEntityMap.put("staff", Staff.class);
        tableEntityMap.put("missions", Mission.class);
        tableEntityMap.put("planets", Planet.class);
        tableEntityMap.put("spacecrafts", Spacecraft.class);
        tableEntityMap.put("equipment", Equipment.class);
        tableEntityMap.put("partners", Partner.class);
        tableEntityMap.put("research", Research.class);
    }

    public static Class<?> getEntityClass(String tableName) {
        return tableEntityMap.get(tableName);
    }
}