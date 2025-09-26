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

  let verticalScale = 1.2

  let deltaLat = verticalScale * w * cos(t)
  let deltaLon = w * sin(t) / cos(coordinate.latitude * .pi / 180)

  return CLLocationCoordinate2D(
    latitude: coordinate.latitude + deltaLat,
    longitude: coordinate.longitude + deltaLon
  )
}

func regionThatFitsAll(points: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
  guard !points.isEmpty else { return nil }

  let lats  = points.map { $0.latitude }
  let longs = points.map { $0.longitude }

  let minLat = lats.min()!
  let maxLat = lats.max()!
  let minLon = longs.min()!
  let maxLon = longs.max()!

  // HalfModalより上に全てを表示させるため、一番南の場所から少し下がった所を中心とする
  let centerLat = minLat - (maxLat - minLat) * 0.2

  // 中心
  let center = CLLocationCoordinate2D(
    latitude: centerLat,
    longitude: (minLon + maxLon) / 2
  )
  // 余白を追加
  let span = MKCoordinateSpan(
    latitudeDelta: (maxLat - centerLat) * 2.2,
    longitudeDelta: (maxLon - minLon) * 1.2
  )
  return MKCoordinateRegion(center: center, span: span)
}
