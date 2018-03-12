# Magento 2.1.9

Local development:

1. Clone

2. Provision
```
vagrant up
```

3. Add teststore.magento.local to your hosts file and point IP address
```
192.168.100.100 	teststore.magento.local
```

4. Once Provision is done un comment lines 21 and 22 from Vagrantfile
```
 # Uncomment lines 21 and 22 after provision
  config.vm.synced_folder "./magento", "/data/magento",
  	    rsync__exclude: [".git/",".settings/","public/var/", "public/pub/"] , owner: "vagrant", group:"apache"
  
```

5. Reload Box
```
vagrant reload
```

6. Open http://teststore.magento.local/ and follow installation steps.

---
