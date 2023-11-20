pragma solidity ^0.8.0;

contract VideoTracking {
    struct Video {
        string title;
        string description;
        uint timestamp;
        address uploader;
        bool isValid;
    }

    mapping(string => Video) videos;

    event NewVideo(
        string title,
        string description,
        uint timestamp,
        address uploader
    );

    event VideoStatusChanged(
        string title,
        bool isValid
    );

    function addVideo(
        string memory _title,
        string memory _description,
        uint _timestamp
    ) public {
        require(videos[_title].title == "");
        videos[_title] = Video(_title, _description, _timestamp, msg.sender, true);
        emit NewVideo(_title, _description, _timestamp, msg.sender);
    }

    function changeVideoStatus(
        string memory _title,
        bool _isValid
    ) public {
        require(videos[_title].uploader == msg.sender);
        require(videos[_title].title != "");
        Video storage video = videos[_title];
        video.isValid = _isValid;
        emit VideoStatusChanged(_title, _isValid);
    }

    function getVideo(string memory _title) public view returns (
        string memory,
        string memory,
        uint,
        address,
        bool
    ) {
        Video storage video = videos[_title];
        return (
            video.title,
            video.description,
            video.timestamp,
            video.uploader,
            video.isValid
        );
    }
}