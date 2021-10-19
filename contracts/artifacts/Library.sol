// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./ownable.sol";


/**
 * @title Library
 * @dev Manage small dApp library
 */
contract Library is Owner {

    event NewBookAdded(Book book);
    event BookBorrowed(Book book);
    event BookReturned(Book book);
    

    // conditions,
    // A user should not borrow more than one copy of a book at a time. 
    // The users should not be able to borrow a book more times than the copies in the libraries unless copy is returned.
    // Everyone should be able to see the addresses of all people that have ever borrowed a given book.
    // Books[] books;
    mapping (string => uint16) public booksToCopies;
    mapping (string => uint16) public inStockBooks;

    mapping (string => address[]) public borrowHistory;
    mapping (address => mapping(string => uint8)) public usersBooks;
    

    // mapping (address => ) usersBooks;
    

    struct Book {
        string isbn;
        string title;
        string author;
        // uint copies;
    }
 
    modifier existsCopies(string memory _isbn){
        require(inStockBooks[_isbn] >= 1);
        _;
    }
    
    modifier existsBook(string memory _isbn){
        require(booksToCopies[_isbn] > 0);
        _;
    }

    function addBook(string memory _isbn,string memory _title,string memory _author,uint16 _copies) public isOwner {
        require(_copies > 0);
        
        uint16 bookCopies = booksToCopies[_isbn]; 
        booksToCopies[_isbn] += _copies + bookCopies;
        uint16 inStockCopies = inStockBooks[_isbn];
        inStockBooks[_isbn] += _copies + inStockCopies;

        Book memory book = Book(_isbn,_title,_author);
        emit NewBookAdded(book);
    }

    // function addCopiesForBook(string memory _isbn,uint16 _copies) public isOwner {
    //     require(booksToCopies[_isbn]>0);
    //     require(_copies > 0);
    // }

    // availabales books, only; one in stock
    // function getAllAvailableBooks() public {
    //     // can implement it
    // }

    // function borrowBook(string memory _isbn) public {

    // }

    // function returnBook(string memory _isbn) public {

    // }

    // function bookBorrowHistory(string memory _isbn) public view returns(address[] memory) {
    //     return borrowHistory[_isbn];
    // } 

}