//
//  FindMDBTests.swift
//  TMDBSwift
//
//  Created by George Kye on 2017-05-14.
//  Copyright © 2017 George. All rights reserved.
//

@testable import TMDBSwift
import XCTest

final class FindMDBTests: XCTestCase {
    override func setUp() {
        super.setUp()
        TMDBConfig.apikey = "8a7a49369d1af6a70ec5a6787bbfcf79"
    }

    func testFind() {
        var data: FindMDB?
        let expectation = self.expectation(description: "Wait for data to load.")

        FindMDB.find(id: "nm3592338", external_source: .imdb_id, completion: { _, find in
            data = find
            expectation.fulfill()
        })

        waitForExpectations(timeout: expecationTimeout, handler: nil)
        XCTAssertNotNil(data)
        guard let findData = data else { return }
        XCTAssertNotNil(findData.person_results)

        let person = findData.person_results?[0]
        XCTAssertEqual(person?.id, 1223786)
        XCTAssertEqual(person?.name, "Emilia Clarke")

        // Test known for movies
        let knownForMoviesIndex = person?.known_for.movies?.firstIndex(where: {
            $0.id == 87101
        })
        XCTAssertNotNil(knownForMoviesIndex)
        let terminatorMovie = person?.known_for.movies?[knownForMoviesIndex!]

        XCTAssertEqual(terminatorMovie?.original_title, "Terminator Genisys")
        XCTAssertEqual(terminatorMovie?.release_date, "2015-06-23")
        XCTAssertEqual(terminatorMovie?.id, 87101)

        // Test known for tv
        let knownForTVIndex = person?.known_for.tvShows?.firstIndex(where: {
            $0.id == 1399
        })
        XCTAssertNotNil(knownForTVIndex)
        let gameOfThronesTV = person?.known_for.tvShows?[knownForTVIndex!]

        XCTAssertEqual(gameOfThronesTV?.original_name, "Game of Thrones")
        XCTAssertEqual(gameOfThronesTV?.id, 1399)
        XCTAssertEqual(gameOfThronesTV?.first_air_date, "2011-04-17")
    }

}
