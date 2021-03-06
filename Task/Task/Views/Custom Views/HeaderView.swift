//
//  SectionHeaderView.swift
//  Task
//
//  Created by Eslam Ali  on 16/05/2022.
//

import UIKit

class HeaderView: UIView{

   
    //MARK:- Vars
   public var blocks : [Block] = []
    
    private let HeaderImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        
        
        return image
    }()
    
    private let collectionView : UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 140)
        
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false


        return collectionView
    }()
    

   
    
  //MARK:- Initlizaers
    init(frame: CGRect, blocks : [Block], image: String) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        self.clipsToBounds = true
        
        addSubview(HeaderImageView)
        addSubview(collectionView)

        self.blocks = blocks
        self.HeaderImageView.sd_setImage(with: URL(string: image ), completed: nil)
        

        collectionView.delegate = self
        collectionView.dataSource = self
    
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK:- Layouts / Constraints 
    override func layoutSubviews() {
        super.layoutSubviews()
        //let imageSize: CGFloat = bounds.height
        HeaderImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height / 1.5
        )
        collectionView.frame = CGRect(x: 0, y: HeaderImageView.frame.height - 60, width: bounds.width - 10, height: bounds.height/2)
 
    }
    

    
}

//MARK:- Extension for CollectionView Functions
extension HeaderView :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell
        else {
            print("can't get category cell")
            return UICollectionViewCell()
        }
        
        cell.configureCell(model: blocks[indexPath.row])
        return cell
                
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 120, height: 140)
      }
    
    }
    
    


