NAME=$(firstword $(subst -, ,$(shell basename $(CURDIR))))

USB_DEV_RES=$(subst :, ,$(shell lsusb -d $1))
USB_DEV_W=$(word $2,$(call USB_DEV_RES,$1))
USB_DEV=/dev/bus/usb/$(call USB_DEV_W,$1,2)/$(call USB_DEV_W,$1,4)

build:
	docker build . -t $(NAME):latest
rebuild:
	docker build . -t $(NAME):latest --no-cache
run:
	docker container rm $(NAME) || true
	docker run --name $(NAME) --restart=unless-stopped  \
	--privileged -v /dev/bus/usb:/dev/bus/usb \
	-v/mnt/data3:/mnt/data \
	-v$(CURDIR)/install:/mnt/install \
	-d $(NAME):latest
e:
	echo this is $(NAME) $(call USB_DEV,'0bda:2838')
stop:
	docker stop $(NAME)
bash:
	docker exec -it $(NAME) /bin/bash
