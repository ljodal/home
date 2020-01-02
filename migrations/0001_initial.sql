create table device (
    id integer primary key not null generated always as identity,
    name varchar unique not null,
    description text not null
);


create table sensor_reading (
    device_id integer references device (id) not null,
    timestamp timestamptz not null,
    temperature real,
    relative_humidity real,

    -- Validate that at least one sensor reading is set
    constraint sensor_reading_has_value
    check (num_nonnulls(temperature, relative_humidity) > 0),

    -- Make sure device readings have a unique timestamp
    unique ( device_id, timestamp )
);
