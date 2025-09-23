//
//  CalculateCoordinate.swift
//  irodori
//
//  Created by AsaokaTakuya on 2025/09/23.
//

import MapKit

func randomCoordinate(around coordinate: CLLocationCoordinate2D, radiusMeters: Double) -> CLLocationCoordinate2D {
  // 1度あたりの緯度距離（約111km）
  let metersPerDegree = 111_000.0

  // 半径を度に変換
  let radiusDegrees = radiusMeters / metersPerDegree

  // ランダムな距離と角度を生成
  let u = Double.random(in: 0...1)
  let v = Double.random(in: 0...1)
  let w = radiusDegrees * sqrt(u)
  let t = 2 * Double.pi * v

  let deltaLat = w * cos(t)
  let deltaLon = w * sin(t) / cos(coordinate.latitude * .pi / 180)

  return CLLocationCoordinate2D(
    latitude: coordinate.latitude + deltaLat,
    longitude: coordinate.longitude + deltaLon
  )
}
