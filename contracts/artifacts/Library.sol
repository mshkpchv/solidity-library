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
    mapping (string => uint16) booksToCopies;
    mapping (address => mapping(string => uint8)) usersBooks;
    mapping (string => address[]) borrowHistory;

    // mapping (address => ) usersBooks;
    

    struct Book {
        string isbn;
        string title;
        string author;
    }

    function addBook(string memory _isbn,string memory _title,string memory _author,uint16 _copies) public isOwner {
        require(_copies > 0);
    }

    function addCopiesForBook(string memory _isbn,uint16 _copies) public isOwner {
        require(_copies > 0);
    }

    // availabales books, only; one in stock
    function getAllBooks() public {

    }

    function borrowBook(string memory _isbn) public {

    }

    function returnBook(string memory _isbn) public {

    }

    function returnBooks(string memory _isbn) public {

    }

    function bookBorrowHistory(string memory _isbn) public {
        
    } 

}