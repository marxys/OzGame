functor
import
   Application % Allows to terminate the application
   System 
   QTk at 'x-oz://system/wp/QTk.ozf'
   OS
define

   %% Default values
   HEIGHT   = 14
   WIDTH    = 12
   
   %% Posible arguments
   Args = {Application.getArgs
	   record(
	      height(single char:&h type:int default:HEIGHT)
	      width(single char:&w type:int default:WIDTH)
	      )}
   
   fun {NewActive Class Init}
      Obj = {New Class Init}
      P
   in
      thread S in
	 {NewPort S P}
	 for M in S do {Obj M} end
      end
	 proc {$ M} {Send P M} end
   end

   class Gui
      attr grid
	 food steel wood stone
	 foodImg steelImg woodImg stoneImg playerImg bg
      meth init(H W)
	 CD = {OS.getCWD}
	 Grid Food Steel Stone Wood
      in
	 {{QTk.build td(
		grid(handle:Grid bg:white)
			lr(label(text:"Food :") label(text:"0" handle: Food)
			   label(text:"Wood :") label(text:"0" handle: Wood)
			   label(text:"Steel :") label(text:"0" handle: Steel)
			   label(text:"Stone :") label(text:"0" handle: Stone)
			   button(text:"Quit" action:proc {$} {Application.exit 0} end)
			  )
			)} show}
	 for I in 1..H-1 do
	    {Grid configure(lrline column:1 columnspan:W+W-1 row:I*2 sticky:we)}
	 end
	 for I in 1..W-1 do
	    {Grid configure(tdline  row:1 rowspan:H+H-1 column:I*2 sticky:ns)}
	 end
	 for I in 1..W do
	    {Grid columnconfigure(I+I-1 minsize:43)}
	 end
	 for I in 1..H do
	    {Grid rowconfigure(I+I-1 minsize:43)}
	 end
	 grid := Grid
	 food := Food
	 steel := Steel
	 wood := Wood
	 stone := Stone
	 foodImg := {QTk.newImage photo(file:CD#'/food.gif')}
	 bg := {QTk.newImage photo(file:CD#'/white.gif')}
      end

      meth player(Team X Y) Img in
	 if Team == 'a' then
	    Img = @playera
	 else
	    Img = @playerb
	 end
	 {@grid configure(label(image:Img) row:X+X-1 column:Y+Y-1)}
      end
      meth disposeFood()
	 
      end
      meth changeFood(X)
	 S P in
	 S = @food
	 {S get(text:P)}
	 {S set(""#P.1+X-48)} % propriete handle d'un label ?
      end
      meth changeStone(X)
	 S P in
	 S = @stone
	 {S get(text:p)}
	 {S set(""#P.1 + X - 48)} % propriete cell
      end
      meth changeSteel(X)
	 S P in
	 S = @steel
	 {S get(text:P)}
	 {S set(""#P.1 + X -48)}
      end
      meth changeWood(X)
	 S P in
	 S = @wood
	 {S get(text:P)}
	 {S set(""#P.1 + X-48)}
      end
   end

   %% create the GUI object
   G = {NewActive Gui init(Args.height Args.width)}
   %{G score(a 4)}
   {G changeFood(4)}
   {G changeFood(8)}
end
