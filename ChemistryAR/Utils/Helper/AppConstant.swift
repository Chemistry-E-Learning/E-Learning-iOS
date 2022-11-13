//
//  AppConstant.swift
//  ChemistryAR
//
//  Created by NhatMinh on 26/09/2022.
//

import Foundation

struct AppConstant {
    static let ChemistryElementResource = "Chemistry Element"
    static let NoAsset = "Missing expected asset catalog resources."
    static let MaximumImageTracking = 2
    static let NoContent = "---"
    static let BackImage = "chevron.backward"
    static let PlayImage = "play.fill"
    static let BackSide = "backside"
    static let GasIndex = "2"
}

struct IONModel {
    let symbol: String
    let electrolysis: String
}


// MARK: - Dummy Data
extension AppConstant {
    static let elements = PeriodicElementList.readJSONFromFile()?.elements ?? []
    static let cations = [
        IONModel(symbol: "H", electrolysis: "+"),
        IONModel(symbol: "NH4", electrolysis: "+"),
        IONModel(symbol: "Li", electrolysis: "+"),
        IONModel(symbol: "Rb", electrolysis: "+"),
        IONModel(symbol: "K", electrolysis: "+"),
        IONModel(symbol: "Ba", electrolysis: "2+"),
        IONModel(symbol: "Sr", electrolysis: "2+"),
        IONModel(symbol: "Ca", electrolysis: "2+"),
        IONModel(symbol: "Na", electrolysis: "+"),
        IONModel(symbol: "Mg", electrolysis: "2+"),
        IONModel(symbol: "Be", electrolysis: "2+"),
        IONModel(symbol: "Al", electrolysis: "3+"),
        IONModel(symbol: "Mn", electrolysis: "2+"),
        IONModel(symbol: "Zn", electrolysis: "2+"),
        IONModel(symbol: "Cr", electrolysis: "2+"),
        IONModel(symbol: "Cr", electrolysis: "3+"),
        IONModel(symbol: "Fe", electrolysis: "2+"),
        IONModel(symbol: "Fe", electrolysis: "3+"),
        IONModel(symbol: "Cd", electrolysis: "2+"),
        IONModel(symbol: "Co", electrolysis: "2+"),
        IONModel(symbol: "Co", electrolysis: "3+"),
        IONModel(symbol: "Ni", electrolysis: "2+"),
        IONModel(symbol: "Sn", electrolysis: "2+"),
        IONModel(symbol: "Pb", electrolysis: "2+"),
        IONModel(symbol: "Cu", electrolysis: "2+"),
        IONModel(symbol: "Ag", electrolysis: "+"),
        IONModel(symbol: "Hg", electrolysis: "2+")
    ]
    static let anions = [
        IONModel(symbol: "I", electrolysis: "-"),
        IONModel(symbol: "S", electrolysis: "2-"),
        IONModel(symbol: "SO4", electrolysis: "2-"),
        IONModel(symbol: "HSO4", electrolysis: "-"),
        IONModel(symbol: "SO3", electrolysis: "2-"),
        IONModel(symbol: "ClO4", electrolysis: "-"),
        IONModel(symbol: "ClO3", electrolysis: "-"),
        IONModel(symbol: "NO3", electrolysis: "-"),
        IONModel(symbol: "NO2", electrolysis: "-"),
        IONModel(symbol: "PO4", electrolysis: "3-"),
        IONModel(symbol: "HPO4", electrolysis: "2-"),
        IONModel(symbol: "H2PO4", electrolysis: "-"),
        IONModel(symbol: "CH3COO", electrolysis: "2-"),
        IONModel(symbol: "Cr2O7", electrolysis: "2-"),
        IONModel(symbol: "CrO4", electrolysis: "-"),
        IONModel(symbol: "MnO4", electrolysis: "-"),
        IONModel(symbol: "CO3", electrolysis: "2-"),
        IONModel(symbol: "HCO3", electrolysis: "-"),
        IONModel(symbol: "SiO3", electrolysis: "2-")
    ]
    static let HtmlContent = """
<html lang="en">
  <head>

    <!-- Declared Vars To Go Here -->

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Metadata -->
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="icon" href="mysource_files/favicon.ico">

    <!-- Page Name and Site Name -->
    <title>Page Name - Squiz Matrix HTML Example</title>

    <!-- CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="mysource_files/style.css" rel="stylesheet">

  </head>

  <body>

    <div class="container">
      <div class="row">
        <div class="col-sm-6">
          <div class="page-contents">
            <!-- Design Body -->
            <h2>Sub Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
            <h4>Sub Heading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
            <h4>Sub Heading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

          </div>
        <div class="col-sm-6">
          <div class="page-contents">
            <!-- Design Body -->
            <h2>Sub Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
            <h4>Sub Heading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
            <h4>Sub Heading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

          </div>

        </div>
        <div class="col-sm-6">
          <div class="page-contents">
            <!-- Design Body -->
            <h2>Sub Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
            <h4>Sub Heading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
            <h4>Sub Heading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

          </div>

        </div>
        </div>
        <div class="col-sm-6">
          <div class="page-contents">
            <!-- Design Body -->
            <h2>Sub Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
            <h4>Sub Heading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
            <h4>Sub Heading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

          </div>

        </div>
        <div class="col-sm-6">
          <div class="page-contents">
            <!-- Design Body -->
            <h2>Sub Heading</h2>
            <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>
            <h4>Sub Heading</h4>
            <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>
            <h4>Sub Heading</h4>
            <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

          </div>

        </div>
        <div class="col-sm-3">

          <!-- Login Section -->
          <h2>Login</h2>

          <!-- Search Section -->
          <h2>Search</h2>

          <!-- Nested Right Column Content -->

        </div>

      </div>

      <footer class="footer">
        <p class="pull-right">
          <!-- Last Updated Design Area-->
          Last Updated: Wednesday, January 6, 2016
        </p>
        <p>&copy; 2016 Company, Inc.</p>
      </footer>

    </div> <!-- /container -->

  </body>
</html>
"""
}
