/* 
    Anything with a status that changes along with time.
*/

create table core.fct_claim_activity (
    id bigserial primary key,
    dim_claim_id timestamp not null,
    activity_type varchar(25) not null,
    claim_id int not null
);

create table core.fct_invoice_activity (
    activity_date timestamp not null,
    activity_type varchar(25) not null,
    invoice_id int not null
);

create table core.fct_treatment_activity (
    activity_date timestamp not null,
    activity_type varchar(25) not null,
    treatment_id int not null
);

Fact_deliverer_activity
 Session_id
 Deliverer _id
 Region_id
 Timestamp
 Activity_type -
        login/update_account_info/available_to_pickup/accept_order
        /Cancel_order/arrive_to_resturant/picks_up_order/drops_off_order

Fact_customer_acivity
 Session_id
 Customer _id
 Region_id
 Timestamp
 Activity_type -
        login/update_account_info/available_to_order/places_order
        /Cancels_order/receives_order/rates_driver/tips_driver


/*
    3. Add fact tables for transactions (like orders) involving multiple actors
    * include: ids (self, each actor, region) + timestamps (order placed, deliverer: accepted & picked up & dropped off)  + activity type.

    4. Add a dimension for any transaction type from point 3.
    * include: ids (self, other actors) + timestamps (like in 3.) 
/*
