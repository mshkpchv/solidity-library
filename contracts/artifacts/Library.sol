// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./ownable.sol";

/**
 * @title Library
 * @dev Manage small dApp library
 */
contract Library is Owner {

    // conditions,
    // A user should not borrow more than one copy of a book at a time. 
    // The users should not be able to borrow a book more times than the copies in the libraries unless copy is returned.
    // Everyone should be able to see the addresses of all people that have ever borrowed a given book.
    Book[] private books;
    mapping (string => address[]) private borrowHistory;
    mapping (address => mapping(string => bool)) private usersBooks;    
    mapping (string => BookRegistry) private registry;

    struct Book {
        string isbn;
        string title;
        string author;
    }

    struct BookRegistry{
        uint16 count;
        uint16 availability;
    }
 
    modifier existsCopies(string memory _isbn){
        require(registry[_isbn].availability >= 1);
        _;
    }
    
    modifier existsBook(string memory _isbn){
        require(registry[_isbn].count > 0);
        _;
    }
    constructor() {
        // test data
        addBook("1111", "Thinking in Bets", "Annie Duke", 1);
        addBook("0000", "Fire and Blood", "George Martin", 1);
    }

    function addBook(string memory _isbn,string memory _title,string memory _author,uint16 _copies) public isOwner {
        require(_copies > 0);
        Book memory book = Book(_isbn,_title,_author);
        if(registry[_isbn].count < 1){
            books.push(book);
        }
        registry[_isbn].count += _copies;
        registry[_isbn].availability += _copies;
    }

    // availabales books, only; one in stock
    function getAllAvailableBooks() public view returns(string[] memory) {
        string[] memory result = new string[](books.length);
        uint counter = 0;
        for (uint index = 0; index < books.length; index++) {
            string memory currISBN = books[index].isbn;
            if (registry[currISBN].availability > 0) {
                result[counter] = currISBN;
                counter++;
            }
        }
    return result;
    }

    function borrowBook(string memory _isbn) public existsBook(_isbn) existsCopies(_isbn) {
        require(usersBooks[msg.sender][_isbn] == false);
        usersBooks[msg.sender][_isbn] = true;
        registry[_isbn].availability--;
        borrowHistory[_isbn].push(msg.sender);
    }

    function returnBook(string memory _isbn) public existsBook(_isbn) {
        require(usersBooks[msg.sender][_isbn] == true);
        registry[_isbn].availability++;
        usersBooks[msg.sender][_isbn] = false;
    }

    function getBookBorrowHistory(string memory _isbn) public view returns(address[] memory) {
        return borrowHistory[_isbn];
    } 
}