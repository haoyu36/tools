




首先创建好应用


设置编辑器为 markdown
设置语言为中文




tar -czvf bookstack-files-backup.tar.gz .env public/uploads storage/uploads

mysqldump -u benny bookstack > bookstack.backup.sql


