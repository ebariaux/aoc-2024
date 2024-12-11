import Foundation

struct Region {
  var isFile: Bool
  var numBlocks: Int
  var fileId: Int?

  func valueLocatedAt(_ index: Int) -> Int {
    guard isFile else { return 0 }
    return (index..<index + numBlocks).map { $0 * fileId! }.reduce(0, +)
  }
}

struct Day09: AdventDay {
  var driveMap: [Int] = []
  var map2: [Region] = []

  init(data: String) {
    var isFreeSpace = false
    var currentFileId = 0
    for char in data {
      if let blockSize = Int(String(char)) {
        if isFreeSpace {
          if blockSize > 0 {
            driveMap.append(contentsOf: Array.init(repeating: -1, count: blockSize))
            map2.append(Region(isFile: false, numBlocks: blockSize))
          }
        } else {
          driveMap.append(contentsOf: Array.init(repeating: currentFileId, count: blockSize))
          map2.append(Region(isFile: true, numBlocks: blockSize, fileId: currentFileId))
          currentFileId += 1
        }
        isFreeSpace.toggle()
      }
    }
  }

  func compressedDriveMap() -> [Int] {
    var result = [Int]()
    var leftIndex = driveMap.startIndex
    var rightIndex = driveMap.index(before: driveMap.endIndex)

    while leftIndex <= rightIndex {
      if driveMap[leftIndex] == -1 {
        if driveMap[rightIndex] != -1 {
          result.append(driveMap[rightIndex])
          leftIndex = driveMap.index(after: leftIndex)
        }
        rightIndex = driveMap.index(before: rightIndex)
      } else {
        result.append(driveMap[leftIndex])
        leftIndex = driveMap.index(after: leftIndex)
      }
    }

    return result
  }

  func compressedMap2() -> [Region] {

    var result = map2

    var rightIndex = result.index(before: map2.endIndex)
    while rightIndex > result.startIndex {
      if result[rightIndex].isFile {
        let region = result[rightIndex]
        let freeIndex = result.firstIndex(where: {
          !$0.isFile && $0.numBlocks >= result[rightIndex].numBlocks
        })
        if let freeIndex, freeIndex < rightIndex {
          let freeBlocks = result[freeIndex].numBlocks - region.numBlocks
          result[freeIndex] = region
          result[rightIndex] = Region(isFile: false, numBlocks: region.numBlocks)
          if freeBlocks > 0 {
            result.insert(
              Region(isFile: false, numBlocks: freeBlocks), at: result.index(after: freeIndex))
            continue  // Insert makes rightIndex already point to the previous element
          }
        }
      }
      rightIndex = result.index(before: rightIndex)
    }

    return result
  }

  func part1() -> Any {
    let map = compressedDriveMap()

    var checksum = 0
    for (index, blockId) in map.enumerated() {
      checksum += blockId * index
    }

    return checksum
  }

  func part2() -> Any {
    let map = compressedMap2()

    var checksum = 0
    var index = 0
    for region in map {
      checksum += region.valueLocatedAt(index)
      index += region.numBlocks
    }

    return checksum
  }
}
