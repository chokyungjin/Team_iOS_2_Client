//
//  Album.swift
//  90's
//
//  Created by 성다연 on 2020/04/10.
//  Copyright © 2020 홍정민. All rights reserved.
//

let AlbumDatabase : AlbumModel = AlbumModel()
let LayoutDatabase : LayoutModel = LayoutModel()
let CoverDatabase : CoverModel = CoverModel()

class LayoutModel {
    let arrayList : [AlbumLayout] = [.Polaroid, .Mini, .Memory, .Portrab, .Tape, .Portraw, .Filmroll]
}

class CoverModel {
    let arrayList : [AlbumCover] = [.dreamy2121, .fellinlove, .happilyeverafter, .mysweetyLovesyou, .svibe, .sweetholiday]
}

class Album {
    var user : [String]
    var albumIndex : Int!
    var albumName : String!
    var albumStartDate : String?
    var albumEndDate : String?
    var albumLayout : AlbumLayout!
    var albumMaxCount : Int!
    var photos : [UIImage]
    
    init(user: [String],albumIndex: Int, albumName: String, albumStartDate : String?, albumEndDate : String?, albumLayout: AlbumLayout, albumMaxCount: Int, photo: [UIImage]) {
        self.user = user
        self.albumIndex = albumIndex
        self.albumName = albumName
        self.albumStartDate = albumStartDate
        self.albumEndDate = albumEndDate
        self.albumLayout = albumLayout
        self.albumMaxCount = albumMaxCount
        self.photos = []
    }
}

class AlbumModel {
    var arrayList : [Album] = []
    
    func defaultData() -> Array<Album> {
        let stock = Album(user: ["test@gmail.com"], albumIndex: 0, albumName: "행복한 앨범", albumStartDate: "2020-04-26", albumEndDate: "2020-05-21", albumLayout: .Portrab, albumMaxCount: 5, photo: [])
        let stock2 = Album(user: ["test1@gmail.com"], albumIndex: 1, albumName: "여행 기록", albumStartDate: "2020-04-25", albumEndDate: "2020-06-11", albumLayout: .Filmroll, albumMaxCount: 10, photo: [])
        return [stock, stock2]
    }
    
    init() {
        arrayList = defaultData()
        arrayList[0].photos.append(UIImage(named: "fellinlove")!)
        arrayList[0].photos.append(UIImage(named: "husky")!)
        arrayList[1].photos.append(UIImage(named: "dreamy2121")!)
        arrayList[1].photos.append(UIImage(named: "husky")!)
    }
}

enum AlbumLayout {
    case Polaroid
    case Mini
    case Memory
    case Portrab
    case Tape
    case Portraw
    case Filmroll
    
    var image : UIImage {
        switch self {
        case .Polaroid : return UIImage(named: "framePolaroid")!
        case .Mini : return UIImage(named: "frameMini")!
        case .Memory : return UIImage(named: "frameMemory")!
        case .Portrab : return UIImage(named: "framePortrab")!
        case .Tape : return UIImage(named: "frameTape")!
        case .Portraw : return UIImage(named: "framePortraw")!
        case .Filmroll : return UIImage(named: "frameFilmroll")!
        }
    }
    
    var size : CGSize {
        switch self {
        case .Polaroid : return CGSize(width: 184, height: 213)
        case .Mini : return CGSize(width: 183, height: 249)
        case .Memory : return CGSize(width: 261, height: 236)
        case .Portrab : return CGSize(width: 270, height: 325)
        case .Tape : return CGSize(width: 326, height: 336)
        case .Portraw : return CGSize(width: 356, height: 218)
        case .Filmroll : return CGSize(width: 286, height: 382)
        }
    }
    
    var bigsize : CGSize{
        switch self {
        case .Polaroid : return CGSize(width: 368, height: 447)
        case .Mini : return CGSize(width: 338, height: 463)
        case .Memory : return CGSize(width: 354, height: 320)
        case .Portrab : return CGSize(width: 346, height: 414)
        case .Tape : return CGSize(width: 354, height: 366)
        case .Portraw : return CGSize(width: 361, height: 221)
        case .Filmroll : return CGSize(width: 332, height: 444)
        }
    }
    
    var layoutUid : Int {
        switch self {
        case .Polaroid : return 0
        case .Mini : return 1
        case .Memory : return 2
        case .Portrab : return 3
        case .Tape : return 4
        case .Portraw : return 5
        case .Filmroll : return 6
        }
    }
    
    var layoutName : String {
        switch self {
        case .Polaroid: return "Polaroid"
        case .Mini : return "Mini"
        case .Memory : return "Memory"
        case .Portrab : return "Portrab"
        case .Tape : return "Tape"
        case .Portraw : return "Portraw"
        case .Filmroll : return "Filrmroll"
        }
    }
    
    var dateLabelFrame : CGSize {
        switch self {
        case .Polaroid: return CGSize(width: 40, height: 103)
        case .Mini : return CGSize(width: 34, height: 85)
        case .Memory: return CGSize(width: 44, height: 44)
        case .Portrab: return CGSize(width: 32, height: 25)
        case .Tape: return CGSize(width: 33, height: 81)
        case .Portraw: return CGSize(width: 16, height: 22)
        case .Filmroll: return CGSize(width: 50, height: 16)
        }
    }
}


enum AlbumCover {
    case dreamy2121
    case fellinlove
    case sweetholiday
    case happilyeverafter
    case mysweetyLovesyou
    case svibe
    
    var image : UIImage {
        switch self {
        case .dreamy2121 : return UIImage(named: "dreamy2121")!
        case .fellinlove : return UIImage(named: "fellinlove")!
        case .sweetholiday : return UIImage(named: "sweetholiday")!
        case .happilyeverafter : return UIImage(named: "happilyeverafter")!
        case .mysweetyLovesyou : return UIImage(named: "mysweetyLovesyou")!
        case .svibe : return UIImage(named: "90Svibe")!
        }
    }
    
    var imageName : String {
        switch self {
        case .dreamy2121 : return "dreamy2121"
        case .fellinlove : return "fellinlove"
        case .sweetholiday : return "sweetholiday"
        case .happilyeverafter : return "happileverafter"
        case .mysweetyLovesyou : return "mysweetyLovesyou"
        case .svibe : return "90Svibe"
        }
    }
}

