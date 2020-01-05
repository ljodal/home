create function get_or_create_device (device_name varchar)
    returns integer
    as $$
declare
    device_id integer;
begin
    -- Try to first get the device id without having to insert anything
    select
        id into device_id
    from
        device
    where
        name = device_name;
    -- If we did not find the device, create it now
    if not found then
        insert into device (name, description)
        values (device_name, '')
    returning
        id into device_id;
    end if;
    return device_id;
end;
$$
language plpgsql;
