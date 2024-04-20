class DatabaseQueries{

    // CREATION

    static String createSongTable(){
        return """
        CREATE TABLE IF NOT EXISTS song (
          _id VARCHAR(300) PRIMARY KEY,
          title VARCHAR(300) NOT NULL,
          albumId VARCHAR(300) NOT NULL,
          FOREIGN KEY (albumId) REFERENCES album (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          imgSong VARCHAR(300) NOT NULL,
          bdCoverPath VARCHAR(300) NOT NULL,
          createdAt VARCHAR(300) NOT NULL,
          songLink VARCHAR(300) NOT NULL,
          bdSongPath VARCHAR(300),
          year INTEGER NULL,
         )
        """;
    }
    static String createAlbumTable(){
        return """
        CREATE TABLE IF NOT EXISTS album (
          _id VARCHAR(300) PRIMARY KEY,
          title VARCHAR(300) NOT NULL,
          subTitle VARCHAR(300) NOT NULL,
          imgAlbum VARCHAR(300) NOT NULL,
          bdImgAlbum VARCHAR(300) NOT NULL,          
          artist VARCHAR(300) NOT NULL,
          createdAt VARCHAR(300) NOT NULL,
          year INTEGER NULL,
         )
        """;
    }
    static String createUserTable(){
        return """
        CREATE TABLE IF NOT EXISTS user (
          _id VARCHAR(300) PRIMARY KEY,
          lastName VARCHAR(300) NOT NULL,
          firstName VARCHAR(300) NOT NULL,
          role VARCHAR(300) NOT NULL,
          email VARCHAR(100) NOT NULL,
          profileImage VARCHAR(300) NOT NULL,
          bdAvatarPath VARCHAR(300) NOT NULL,
          phone VARCHAR(20) NOT NULL,
          bio TEXT,
          createdAt VARCHAR(300) NOT NULL,
         )
        """;
    }
    static String createChatTable(){
        return """
        CREATE TABLE IF NOT EXISTS chat (
          _id VARCHAR(300) PRIMARY KEY,
          user1 VARCHAR(300) NOT NULL,
          FOREIGN KEY (user1) REFERENCES user (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          user2 VARCHAR(300) NOT NULL,
          FOREIGN KEY (user2) REFERENCES user (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          createdAt VARCHAR(300) NOT NULL,
         )
        """;
    }
    static String createMessageTable(){
        return """
        CREATE TABLE IF NOT EXISTS message (
          _id VARCHAR(300) PRIMARY KEY,
          user VARCHAR(300) NOT NULL,
          FOREIGN KEY (user) REFERENCES user (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          chatId VARCHAR(300) NOT NULL,
          FOREIGN KEY (chat_id) REFERENCES chat (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          content TEXT,
          sentAt VARCHAR(300) NOT NULL,
          read INTERGER
         )
        """;
    }
    static String createEventTable(){
        return """
        CREATE TABLE IF NOT EXISTS event (
          _id VARCHAR(300) PRIMARY KEY,
          title VARCHAR(300) NOT NULL,
          img VARCHAR(300) NOT NULL,
          bdCover VARCHAR(300) NOT NULL,
          description TEXT,
          date VARCHAR(300) NOT NULL,
          location VARCHAR(50) NOT NULL,
          startTime VARCHAR(30) NOT NULL,
          endTime VARCHAR(30) NOT NULL,
          createdAt VARCHAR(300) NOT NULL,
         )
        """;
    }
    static String createEventTicketTable(){
        return """
        CREATE TABLE IF NOT EXISTS eventTicket (
          _id VARCHAR(300) PRIMARY KEY,
          userId VARCHAR(300) NOT NULL,
          FOREIGN KEY (userId) REFERENCES user (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          eventId VARCHAR(300) NOT NULL,
          FOREIGN KEY (event_id) REFERENCES event (_id)
          ON DELETE NO ACTION ON UPDATE NO ACTION,
          createdAt VARCHAR(300) NOT NULL,
          price INTERGER
         )
        """;
    }




}