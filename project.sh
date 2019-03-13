#! /bin/bash
declare -a DBARR ;
declare -a tableARR;

 createDataBase()
 {                     
      echo  "Please Enter Your DataBase Name" ;
      read name ;
       
       	if ! [[ -d ./database ]]
        then 
            mkdir database
        fi

       if  [ -z $name ];then
			  echo "you forget insert name of database"
	     
               elif ! [[ $name =~ ^[a-zA-Z]+$ ]]; then
	                  echo " sorry only string is allow"
		        elif [ ${#name} -gt 10 ];then
	                  echo "sorry Lengh allow for  name maximum 10 characters"
                       elif  [[ -d $name ]]; then
			    echo "$name is already a exist"
                   elif [[ -f $name ]]; then
			    echo "$name is already a exist"
	                
                         
	                else
                         
						 mkdir ./database/$name;
					
			fi
     
}

showDataBase(){
    
      
   if [[ -d  database ]]; then
     cd ./database/
         if [ -z "$(ls -A )" ]; then
	        
          echo "No database to be show"
         
	     else
		 
	      echo "Avaliable Database:"
	       

            i=1;
	for DB in `ls -A`
	do
		DBARR[$i]=$DB;
		echo $i") "$DB;
		let i=i+1;
	done
  cd ..
 
         fi 
          else echo "you don't have database"
         fi
         seperate;
        
  
}
deleteDataBase()
 {
  
   
    cd .
            if [[ -d database ]]; then
						cd ./database
						if [ -z "$(ls -A)" ]; then
							echo "you don't have any database "
						else
						ls 
    echo "please enter the database you want to delete";
    read name;
     if [[ -d $name ]]; then
     echo "Drop $name Database? (y/n)"
     read confirm
      
      if [ $confirm = "y" ]; then
       rm -r $name
      echo "removed succesfuly";
         else
        echo "no database delete"
      fi
      else 
      echo "there is no database with this name";
      fi
      fi
      fi
      cd ..
 }
 ##############
  useDataBase(){
    cd .
       
            if [[ -d database ]]; then
						cd ./database
               
						if [ -z "$(ls -A)" ]; then
							echo "you don't have any database "
						else
						ls 
    echo "choose the database you want to use";
    read name ;
    if [[ -d $name ]]; then
    cd $name
       
    echo "you are using $name database";
    dbmenu;
    else 
    echo "please enter a right database";
       
     fi
     fi 
     cd ..
     else 

     echo "you dont have any database please create first";
        cd .
       seperate;
     fi
     
        
     menu;
   
}

createTable(){
    
    echo "enter the name of your table";
    read name
        if [[ -d $name ]]; then
			    echo "$name is already a exist"
		       elif [[ -f $name ]]; then
			    echo "$name is already a exist"
                                elif ! [[ $name =~ ^[a-zA-Z]+$ ]]; then
	                  echo " sorry only string is allow"
                         elif [ ${#name} -gt 10 ];then
	                  echo "sorry Lengh allow for  name maximum 10 characters"
                         
                       elif   [ -z $name ];then
			  echo "you forget insert name of database"
	                
	                else
                         
						 touch $name.data;

            touch $name.meta;
          
          
             echo "please enter the number of cols be carfull only number is allowed";
             read numCol;
            if   [ -z $numCol ]; then
            echo "you forget insert number of row"
                       rm -r $name.data
                       rm -r $name.meta
                       dbmenu;

             elif ! [[ $numCol =~ ^[0-9]+$ ]]; then
                echo "sorry only number is allowed";
                        rm -r $name.data
                       rm -r $name.meta
                       dbmenu;
                else
                 for (( i = 1; i <= numCol ; i++ )); do
                 echo "enter the name of col [$i] be carfull only string is allowed";
                 read colName;
                 if   [ -z $colName ];then
			           echo "you forget insert name of col"

                       rm -r $name.data
                       rm -r $name.meta
                       dbmenu;
                    break;

	                elif ! [[ $colName =~ ^[a-zA-Z]+$ ]]; then
	                  echo " sorry only string is allow"
                       rm -r $name.data
                       rm -r $name.meta
                       dbmenu;
                    elif  grep -o "$colName" $name.meta
                         then
                         echo "already exists"
  rm -r $name.data
                       rm -r $name.meta
                       dbmenu;
                  else
                  	field=$colName;
                    colArr[$i]=$colName ; 
                   echo "enter the type of $colName";
                   select choice in "Number" "String";

                    do 
                        case $choice  in 
                        "Number")
                        field+=":Number"
                         #echo -e " " >> $name.meta;
                          break;
                          ;;
                           "String")
                          field+=":String"
                          # echo -e " " >> $name.meta;
                          break;
                          ;;
                          		*)
      				

			   
			     echo "You Must Choose The Column Data Type"
      					esac
                done
                if ! cat $name.meta | grep "primary"
                then
                    echo "Set as primary key? (y/n) :"
                    read confirm

                    if [ $confirm = "y" ]
                    then
                        field+=":primary"
                        
                    fi
                fi
                echo $field >> $name.meta
                fi
      				done
             

              ###
			          fi
echo "table created successfully";
                fi  
   
             
}
######################
displayTable(){
   
   if [ -z "$(ls -A )" ]; then
	        
          echo "No table to be show"
         
	     else
		 
	      echo "Avaliable Tables:"
	       

            i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
 
         fi 
          
          }
          ###########
 deleteTable(){
    
    if [ -z "$(ls -A )" ]; then
	     echo "No table to be show"
      else
		  echo "Avaliable Tables:"
	       i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
   echo "please enter the table you want to delete";
    read name;
     if [[ -f $name ]]; then
     echo "Drop $name Table? (y/n)"
     read confirm
      
      if [ $confirm = "y" ]; then
       rm -r $name.data
       rm -r $name.meta

      echo "removed succesfuly";
        else 
echo "no table delete"
      fi
      else 
      echo "there is no table with this name";
      fi
      fi
 
        

 }
###############
insert(){
    
    if [ -z "$(ls -A )" ]; then
	     echo "No table to be show"
      else
		  echo "Avaliable Tables:"
	       i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
   echo "please enter the table you want to insert into";
    read tableData;
    if [ -f $tableData.data ]
    then
        record=""
        cols=$(awk -F: '{print $0}' $tableData.meta)
        colsNum=$(cat $tableData.meta | wc -l)

        i=0
        for col in $cols
        do
            colName=$(echo $col | cut -d':' -f 1)
            colType=$(echo $col | cut -d':' -f 2)
            isPrimary=$(echo $col | cut -d: -f3)

            echo "$colName: "
            read value

           if [ $colType = "Number" ]; then
                
                if   [ -z $value ]; then
            echo "you forget insert the data"
            break;
             elif ! [[ $value =~ ^[0-9]+$ ]]; then
                echo "sorry only number is allowed";
                break;
                fi
            elif [ $colType = "String" ]; then
                 if   [ -z $value ];then
			  echo "you forget insert the data"
        break; 
	                elif ! [[ $value =~ ^[a-zA-Z]+$ ]]; then
	                  echo " sorry only string is allow"
                    break; 
                    fi
         fi
            if [ $isPrimary ]
            then
            
                ((primaryIndex=$i+1))
                
                if awk -v x=$primaryIndex -F: '{print $x}' $tableData.data | grep -w $value
                then
                    echo "$colName must be unique"
                    break
                fi
            fi

            record+=$value:
            ((i=$i+1))
        done
        #echo "$colsNum"
       #echo "$i"
        if [ $i -eq $colsNum ]
        then
            echo $record >> $tableData.data
        fi

    else
        echo"Table Does Not Exists"
    fi
    fi
}
############
deleterow(){
 
    if [ -z "$(ls -A )" ]; then
	     echo "No table to be show"
      else
		  echo "Avaliable Tables:"
	       i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
   echo "please enter the table you want to delete row from it";
    read tableData
    if [ -f $tableData.data ]
    then
        columnsNames=$(awk -F: '{print $1}' $tableData.meta)
        question="Delete using ("
            i=0
            for col in $columnsNames
            do
                if [ $i -gt 0 ]
                then
                    question+="/"
                fi
                question+="$col"
                ((i=$i+1))
            done
        question+=") ?"
        echo $question;

        read deleteCol

        if [[ $(awk -F: '{print $1}' $tableData.meta | grep -w $deleteCol) ]]
        then
            i=1
            columnIndex=0
            for col in $columnsNames
            do

                if [ $col = $deleteCol ]
                then
                    columnIndex=$i
                fi
                ((i=$i+1))
            done

            echo "Delete from $tableData where $deleteCol equals ?"
            read deleteQuery

           
            awk -v columns="$columnsNames" -v columnIndex="$columnIndex" -v query="$deleteQuery" -F: '
            BEGIN{split(columns, a, " ")}
            {
                if ($columnIndex != query){
                    printf "%s\n",$0;
                }
            }
            ' $tableData.data > $tableData.tmp && mv $tableData.tmp $tableData.data

            echo "Data has been deleted"
        else
            echo "Column Does Not Exists"
        fi
    else
        echo "Table Does Not Exists"
    fi
    fi
    seperate;

}
############
 displayrow(){

  
  
    if [ -z "$(ls -A )" ]; then
	     echo "No table to be show"
      else
		  echo "Avaliable Tables:"
	       i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
   echo "please enter the table you want to display row in it";
    read tableData
    if [ -f $tableData.data ]
    then
        columnsNames=$(awk -F: '{print $1}' $tableData.meta)
        question="Display using ("
            i=0
            for col in $columnsNames
            do
                if [ $i -gt 0 ]
                then
                    question+="/"
                fi
                question+="$col"
                ((i=$i+1))
            done
        question+=") ?"
        echo $question;

        read deleteCol

        if [[ $(awk -F: '{print $1}' $tableData.meta | grep -w $deleteCol) ]]
        then
            i=1
            columnIndex=0
            for col in $columnsNames
            do

                if [ $col = $deleteCol ]
                then
                    columnIndex=$i
                fi
                ((i=$i+1))
            done

            echo "select from $tableData where $deleteCol equals ?"
            read deleteQuery
          
            echo "###################"
             echo "  "
            awk -v columns="$columnsNames" -v columnIndex="$columnIndex" -v query="$deleteQuery" -F: '
            BEGIN{split(columns, a, " ")}
            {
                if ($columnIndex == query){
                    printf "%s\n",$0;
                }
            }
            ' $tableData.data 
            
        else
            echo "Column Does Not Exists"
        fi 
    else
        echo "Table Does Not Exists"
    fi
    fi

  


 }

 updaterow()
 {
   
    if [ -z "$(ls -A )" ]; then
	     echo "No table to be show"
      else
		  echo "Avaliable Tables:"
	       i=1;
	for table in `ls -A`
	do
		tableARR[$i]=$table;
		echo $i") "$table;
		let i=i+1;
	done
   echo "please enter the table you want to update row in it";
    read tableData
    if [ -f $tableData.data ]
    then
        columnsNames=$(awk -F: '{print $1}' $tableData.meta)
        question="Update rows using ("
            i=0
            for col in $columnsNames
            do
                if [ $i -gt 0 ]
                then
                    question+="/"
                fi
                question+="$col"
                ((i=$i+1))
            done
        question+=") ?"
        echo $question;

        read updateCol

        if [[ $(awk -F: '{print $1}' $tableData.meta | grep -w $updateCol) ]]
        then
            i=1
            columnIndex=0
            for col in $columnsNames
            do

                if [ $col = $updateCol ]
                then
                    columnIndex=$i
                fi
                ((i=$i+1))
            done

            echo "Update from $tableData where $updateCol equals ?"
            read updateQuery

            record=""
            cols=$(awk -F: '{print $0}' $tableData.meta)
            colsNum=$(cat $tableData.meta | wc -l)

            i=0
            for col in $cols
            do
                colName=$(echo $col | cut -d':' -f 1)
                colType=$(echo $col | cut -d':' -f 2)
                isPrimary=$(echo $col | cut -d: -f3)

                if [ ! $isPrimary ]
                then
                    echo "New Value for $colName: "
                    read value

                    if [ $colType = "Number" ]; then
                
                if   [ -z $value ]; then
            echo "you forget insert the data"
            break;
             elif ! [[ $value =~ ^[0-9]+$ ]]; then
                echo "sorry only number is allowed";
                break;
                fi
            elif [ $colType = "String" ]; then
                 if   [ -z $value ];then
			  echo "you forget insert the data"
        break; 
	                elif ! [[ $value =~ ^[a-zA-Z]+$ ]]; then
	                  echo " sorry only string is allow"
                    break; 
                    fi
                    fi
                    record+=$value:
                 fi
                ((i=$i+1))
            done

            if [ $i -eq $colsNum ]
            then

                awk -v columns="$columnsNames" -v columnIndex="$columnIndex" -v query="$updateQuery" -v newRow="$record" -F: '
                BEGIN{split(columns, a, " ")}
                {
                    if ($columnIndex == query){
                        printf "%s:%s\n",$1,newRow;
                    }else{
                        printf "%s\n",$0;
                    }
                }
                ' $tableData.data > $tableData.tmp && mv $tableData.tmp $tableData.data

                echo "Data has been updated"

            fi
        else
            echo "Column Does Not Exists"
        fi
    else
         echo "Table Does Not Exists"
    fi
    fi
 }

seperate(){
echo -e "\n===================================\n";
}

welcome() {
	echo -e "\n Welcome to fatema&sara DBMS we hope to help you to create your own database\n";
}


crud(){
   
    PS3="Enter your choice" ;
      select choice in "insert into table" "update row" "delete row" "display row"   "back to database menu" "exit";

      do 
          case $choice  in 

              "insert into table")
              seperate;
            insert;
            seperate;
          crud;
            break;
            ;;

       "update row")
              seperate;
              updaterow;
              seperate;
           crud;
            break;
            ;;

            "delete row")
            seperate;
            deleterow;
            seperate;
         crud;
            break;
            ;;

            "display row")
            seperate;
            displayrow;
            seperate;
           crud;
            break;
            ;;

"back to database menu")

               seperate;
             
              dbmenu;
           seperate;
            break;
            ;;  

         
             "exit")
               exit -1; 
            ;;

             esac
            done
}
#############

     dbmenu(){
         PS3="Enter your choice" ;
      select choice in "create table" "display table"  "delete table"  "CRUD" "back to menu" "exit";

      do 
          case $choice  in 
           "create table")
          seperate;
            createTable;
             seperate;
            dbmenu;
            break;
            ;;
             "display table")
             seperate;
             displayTable;
             seperate;
            dbmenu;
            break;
            ;;
           
               "delete table")
              seperate;
              deleteTable;
              seperate;
             dbmenu;
            break;
            ;;

        "CRUD")
        seperate;
        crud;
        seperate;
        dbmenu;
         
            break;
            ;;      
            
            "back to menu")
              seperate;
              cd ../..
              menu;
           
            break;
            ;;
               "exit")
               exit -1; 
            ;;

            esac
            done

     }

################
 menu() {
      
      echo "take the chance to create your own DataBase";

    echo "Fellow us";
      
        PS3="Enter your choice" ;
      select choice in "create database" "Drop databse" "show databse" "use databse" "exit";
       
      do 
          case $choice  in 
          "create database")
          seperate;
            createDataBase;
             seperate;
            menu;
            break;
            ;;
             "Drop databse")
             seperate;
            deleteDataBase;
             seperate;
            menu;
            break;
            ;;
              "show databse")
              seperate;
            showDataBase;
            seperate;
           menu;
            break;
            ;;
               "use databse")
              seperate;
            useDataBase;
            seperate;
            break;
            ;;
         
       
                "exit")
             
                    exit -1; 
            ;;

            esac
            done
};
seperate;
welcome;
menu;
