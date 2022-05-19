//
//  TVMDBModel.swift
//  MDBSwiftWrapper
//
//  Created by George Kye on 2016-03-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation

open class ContentRatingsMDB: ArrayObject {
  open  var iso_3166_1: String?
  open var rating: String?

  required public init(results: JSON) {
    iso_3166_1 = results["iso_3166_1"].string
    rating = results["rating"].string
  }
}

open class TVMDB: DiscoverTVMDB {
  open var genres = [GenresMDB]()
}
