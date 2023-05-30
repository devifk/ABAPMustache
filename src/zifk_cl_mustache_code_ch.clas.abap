CLASS zifk_cl_mustache_code_ch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    TYPES: BEGIN OF flight,
             flight_no   TYPE i,
             destination TYPE string,
           END OF flight.
    TYPES flights TYPE STANDARD TABLE OF flight WITH DEFAULT KEY.

    TYPES: BEGIN OF flight_list,
             company  TYPE string,
             airplane TYPE string,
             flights  TYPE flights,
           END OF flight_list.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zifk_cl_mustache_code_ch IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA flight_lists TYPE STANDARD TABLE OF flight_list WITH DEFAULT KEY.

    flight_lists = VALUE #( ( company  = 'American Airlines'
                              airplane = 'Boeing 737'
                              flights  = VALUE #( ( flight_no = 1234 destination = 'Hawai' )
                                                  ( flight_no = 5678 destination = 'Toronto' )
                                                  ( flight_no = 9012 destination = 'Los Angeles' )
                                                  ( flight_no = 3456 destination = 'Miami' )
                                                  ( flight_no = 7891 destination = 'Houston' )
                                                )
                          )
                          ( company  = 'Southwest Airlines'
                            airplane = 'Airbus A320'
                            flights  = VALUE #( ( flight_no = 0987 destination = 'New York' )
                                                ( flight_no = 6543 destination = 'Washington' )
                                                ( flight_no = 2109 destination = 'Boston' )
                                                ( flight_no = 8765 destination = 'San Diego' )
                                                ( flight_no = 4321 destination = 'Chicago' )
                                                )
                          )
                          ).
    TRY.
        DATA(lo_mustache) = zcl_mustache=>create( iv_template =
            'Airline: {{company}}' && cl_abap_char_utilities=>newline &&
            'Airplane: {{ airplane }}' && cl_abap_char_utilities=>newline &&
            '{{#flights}}' &&
            '* Flights {{flight_no}} : {{destination}}' && cl_abap_char_utilities=>newline &&
            '{{/flights}}  '
        ).
        DATA(output) = lo_mustache->render( flight_lists ).
        out->write( output ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
