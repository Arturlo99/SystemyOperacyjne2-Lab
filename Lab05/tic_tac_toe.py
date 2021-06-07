"""
TicTacToe 3x3 module
Artur Sołtys
"""
import os


class TicTacToe:
    """
    TicTacToe game class
    """

    def __init__(self, player_marker):
        self.winner_marker = ''
        self.is_game_over = False
        self.player_marker = player_marker
        if player_marker in ('X', 'x'):
            self.bot_marker = 'O'
        elif player_marker in ('O', 'o'):
            self.bot_marker = 'X'
        self.board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]

    def print_board(self):
        """
        Prints game board
        :return:
        """
        os.system("cls" if os.name == "nt" else "clear")
        print('   ', end='')
        for i in range(len(self.board)):
            print(str(i) + '  ', end='')
        print()
        for i in range(len(self.board)):
            print(str(i) + ' ', end='')
            for j in range(len(self.board[0])):
                print('|' + self.board[i][j] + '|', end='')
            print()

    def is_field_empty(self, row, col):
        """
        checks if field is empty
        :param row: row number
        :param col: column number
        :return: True if is empty otherwise False
        """
        if self.board[row][col] == ' ':
            return True
        return False

    def make_a_move(self, marker, row, col):
        """
        Returns True if bot moved
        """
        self.board[row][col] = marker

    def try_to_block_or_win(self, marker):
        """
        Try to block player from winning on rows
        """
        did_bot_move = False
        for i in range(len(self.board)):
            for j in range(len(self.board[0])):
                if self.board[i].count(marker) == 2 and self.is_field_empty(i, j):
                    self.make_a_move(self.bot_marker, i, j)
                    did_bot_move = True
        # Try to block player from winning on columns
        for i in range(len(self.board[0])):
            for j in range(len(self.board[0])):
                if [row[i] for row in self.board].count(marker) \
                        == 2 and self.is_field_empty(j, i) and not did_bot_move:
                    self.make_a_move(self.bot_marker, j, i)
                    did_bot_move = True
        # Try to block player from winning on cross
        if [self.board[0][0], self.board[1][1], self.board[2][2]].count(marker)\
                == 2 and self.is_field_empty(0, 0) and not did_bot_move:
            self.make_a_move(self.bot_marker, 0, 0)
            did_bot_move = True
        if [self.board[0][0], self.board[1][1], self.board[2][2]].count(marker) \
                == 2 and self.is_field_empty(1, 1) and not did_bot_move:
            self.make_a_move(self.bot_marker, 1, 1)
            did_bot_move = True
        if [self.board[0][0], self.board[1][1], self.board[2][2]].count(marker) \
                == 2 and self.is_field_empty(2, 2) and not did_bot_move:
            self.make_a_move(self.bot_marker, 2, 2)
            did_bot_move = True
        # Try to block player from winning on another cross
        if [self.board[2][0], self.board[1][1], self.board[0][2]].count(marker)\
                == 2 and self.is_field_empty(2, 0) and not did_bot_move:
            self.make_a_move(self.bot_marker, 2, 0)
            did_bot_move = True
        if [self.board[2][0], self.board[1][1], self.board[0][2]].count(marker)\
                == 2 and self.is_field_empty(1, 1) and not did_bot_move:
            self.make_a_move(self.bot_marker, 1, 1)
            did_bot_move = True
        if [self.board[2][0], self.board[1][1], self.board[0][2]].count(marker)\
                == 2 and self.is_field_empty(0, 2) and not did_bot_move:
            self.make_a_move(self.bot_marker, 0, 2)
            did_bot_move = True
        return did_bot_move

    def bot_move(self):
        """
        Bot Artificial Intelligence
        :return:
        """
        # Try to put marker in the center
        if self.is_field_empty(1, 1):
            self.make_a_move(self.bot_marker, 1, 1)
        else:
            if self.try_to_block_or_win(self.bot_marker):
                return
            if self.try_to_block_or_win(self.player_marker):
                return
            for i in range(len(self.board)):
                for j in range(len(self.board[0])):
                    if i == 1 or j == 1:
                        if self.is_field_empty(i, j):
                            self.make_a_move(self.bot_marker, i, j)
                            return
            for i in range(len(self.board)):
                for j in range(len(self.board[0])):
                    if self.is_field_empty(i, j):
                        self.make_a_move(self.bot_marker, i, j)
                        return

    def check_rows(self):
        """
        Checks if there is a winning row
        :return:
        """
        for i in range(len(self.board)):
            if self.board[i] == [self.player_marker, self.player_marker, self.player_marker]:
                self.winner_marker = self.player_marker
                self.print_board()
                return
            if self.board[i] == [self.bot_marker, self.bot_marker, self.bot_marker]:
                self.winner_marker = self.bot_marker
                self.print_board()
                return

    def check_columns(self):
        """
        Checks if there is a winning column
        :return:
        """
        for i in range(len(self.board[0])):
            if [row[i] for row in self.board] == \
                    [self.player_marker, self.player_marker, self.player_marker]:
                self.winner_marker = self.player_marker
                self.print_board()
                return
            if [row[i] for row in self.board] == \
                    [self.bot_marker, self.bot_marker, self.bot_marker]:
                self.winner_marker = self.bot_marker
                self.print_board()
                return

    def check_crosses(self):
        """
        Checks if there is a winning cross
        :return:
        """
        if self.board[0][0] == self.board[1][1] == \
                self.board[2][2] and (self.board[0][0] == self.player_marker or
                                      self.board[0][0] == self.bot_marker):
            self.winner_marker = self.board[0][0]
            self.print_board()
            return
        if self.board[2][0] == self.board[1][1] == self.board[0][2] and \
                (self.board[1][1] == self.player_marker or
                 self.board[1][1] == self.bot_marker):
            self.winner_marker = self.board[1][1]
            self.print_board()
            return

    def check_if_game_over(self):
        """
        Checks if the game is over
        :return:
        """
        self.check_rows()
        self.check_columns()
        self.check_crosses()

    def is_board_full(self):
        """
        Checks if the board is full
        :return: Returns True if is full otherwise False
        """
        occupied_fields = 0
        for i in range(len(self.board)):
            for j in range(len(self.board[1])):
                if not self.is_field_empty(i, j):
                    occupied_fields += 1
        if occupied_fields == 9:
            return True
        return False


def game_loop():
    """
    Game Loop
    :return:
    """
    while True:
        player_marker = input("Select a marker ('X' or 'O'): ")
        if player_marker in ("X", "x"):
            new_game = TicTacToe('X')
            break
        if player_marker in ("O", "o"):
            new_game = TicTacToe('O')
            break
        print("Wrong marker!")

    if new_game.bot_marker == 'O':
        new_game.bot_move()
    while not new_game.is_board_full():
        new_game.print_board()
        while True:
            player_move = input('Your move, enter row,col: ')
            player_move = player_move.split(',')
            if player_move[0] in ('0', '1', '2') and player_move[1] in ('0', '1', '2'):
                if new_game.is_field_empty(int(player_move[0]), int(player_move[1])):
                    new_game.make_a_move(new_game.player_marker,
                                         int(player_move[0]), int(player_move[1]))
                    new_game.check_if_game_over()
                    break
                print('This field is unavailable, choose another')
                new_game.print_board()
            else:
                print('Wrong coordinates!')
                new_game.print_board()
        new_game.bot_move()
        new_game.print_board()
        new_game.check_if_game_over()
        if new_game.winner_marker == new_game.player_marker:
            print('Congratulations, you have won :)')
            break
        if new_game.winner_marker == new_game.bot_marker:
            print('Im sorry, you have lost :(, try again!')
            break
    if new_game.winner_marker == '':
        print('It is a draw!')


if __name__ == '__main__':
    game_loop()
