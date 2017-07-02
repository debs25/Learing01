//tic tac toe game in swift console 
struct Move{
	var row:Int
	var col:Int
}
var player:Character = "X"
var opponent:Character = "O"
var board:[[Character]] = [["X","O","-"],
						  ["-","-","-"],
							["-","-","-"]]

var move:Move = Move(row:-1,col:-1)
func IsMoveLeft()->Bool{
	for  i in 0...board.count-1 {
		for  j in 0...board[i].count-1 {
			if board[i][j]=="-"{
				return true
			}
		}
	}
	return false;
}

func Evaluate()->Int {
	 //check rows
	for i in 0...board.count-1 {
		if (board[i][0] == board[i][1]) &&
			(board[i][2] == board[i][1]) {
			if board[i][0] == player
			{
				return +10
			}else if board[i][0] == opponent
			{
				return -10;
			}
			
		}
	}
	//now columns
	for i in 0...board[0].count-1 {
		if (board[0][i] == board[1][i]) &&
			(board[2][i] == board[1][i]) {
			if board[0][i] == player
			{
				return +10
			}else if board[0][i] == opponent
			{
				return -10;
			}
		}
	}
	
	//diagonal
	if (board[0][0] == board[1][1]) && (board[0][0]==board[2][2]){
		if board[0][0]==player {
			return +10
		}else if board[0][0] == opponent {
			return -10
		}
	}
	
	if (board[0][2] == board[1][1]) && (board[0][2] == board[2][0]){
		if board[0][2]==player {
			return +10
		}else if board[0][2] == opponent {
			return -10
		}	
	}
	return 0
}

func Minimax(depth:Int, isMax:Bool)->Int{
	let score = Evaluate()
	if (score == 10) || (score == -10) {
		return score
	 }
	if(!IsMoveLeft()) {
		return 0
	}
	if isMax {
		var best = -1000
		for i in 0...board.count-1 {
			for j in 0...board[i].count-1{
				if board[i][j] == "-" {
					board[i][j] = player
					best = max(best, Minimax(depth: depth+1, isMax: !isMax))
					board[i][j] = "-"
				}
			}
		}
		return best
	}else {
		var best = 1000
		for i in 0...board.count-1 {
			for j in 0...board[i].count-1{
				if board[i][j] == "-"{
					board[i][j] = opponent
					best = min(best,Minimax(depth: depth+1, isMax: !isMax))
					board[i][j] = "-"
				}
			}
		}
		
		return best
	}
}

func FindBestMove(char:Character = player){
	move.row = -1
	move.col = -1
	var bestval = -1000
	for i in 0...board.count-1 {
		for j in 0...board[i].count-1{
			if board[i][j] == "-"{
				board[i][j] = player
				let moveval = Minimax(depth: 0, isMax: false)
				board[i][j] = "-"
				if moveval > bestval{
					bestval = moveval
					move.row = i 
					move.col = j
				}
			}
		}
	}
	board[move.row][move.col] = char
	var finalvalue = Evaluate()
	if finalvalue == 10 {
		print("Player wins")
	}else if finalvalue == -10{
		print("Opponent wins")
	}
}

func PrintBoard(){
	print("Game looks like")
	for i in 0...board.count-1 {
		print("\(board[i])")
	}
}

print("Starting Tic Tac Toe with player \(player) & \(opponent) & isMoveLeft \(IsMoveLeft())")
PrintBoard()

FindBestMove()
PrintBoard()

FindBestMove(char:opponent)
PrintBoard()

FindBestMove()
PrintBoard()

FindBestMove(char:opponent)
PrintBoard()

FindBestMove()
PrintBoard()

FindBestMove(char: opponent)
PrintBoard()