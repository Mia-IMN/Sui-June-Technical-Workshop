#[test_only] // This module is only compiled for tests
module coin::mia_test; // Define the test module for mia

use coin::mia::{Self, MIA}; // Import the mia module and MIA struct
use sui::coin::{TreasuryCap}; // Import TreasuryCap from sui::coin
use sui::test_scenario::{Self, next_tx, ctx};
use coin::mia; // Import test scenario utilities

#[test] // Mark this function as a test
fun init_and_mint() { // Test function to initialize and mint MIA coins
    let addr1 = @0xA; // Mock sender address

    let mut scenario = test_scenario::begin(addr1); // Start a new test scenario with addr1

  
    next_tx(&mut scenario, addr1); // Advance to the next transaction in the scenario
    {
        let mut treasurycap = test_scenario::take_from_sender<TreasuryCap<MIA>>(&scenario); // Retrieve TreasuryCap<MIA> from sender
        mia::mint(&mut treasurycap, 1000000_00000000, addr1, ctx(&mut scenario)); // Mint 1,000,000 MIA (with 8 decimals) to addr1

        test_scenario::return_to_address<TreasuryCap<MIA>>(addr1, treasurycap); // Return TreasuryCap to sender
    };

    test_scenario::end(scenario); // End and clean up the scenario
}