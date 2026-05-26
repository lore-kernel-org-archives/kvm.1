Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E613AC0D7
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839682; cv=none; b=JDrD8O3QA3ERB8qzK2VQsGPIPihyKouqx+hOTlyIdyN4jQVl+yhc8HRzNjGo6uU53xTNFl6afdXpqPnQrUVOWlPJcRIEd298kcZjZj+CpRFH56C110ezd7FqfwIT820wYs1L9d6VMw9ytPcBqZQ+j9twJtj0rMspqZGafA/BaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839682; c=relaxed/simple;
	bh=9QWShLCg+biAKruenPVCu4t8KlGA/YVrnPuJYqidxP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uX5v83TjiOLXEI27h7mYbiyRDVC6zoDWF9VSnNXslkyo+Px2YXJkJ17f/ALc5CPw7yTnYCNTzZ2ShbeVjXTV43ZSI7LCbC9Thguu1PP/aW/guAOC2sR94YZF3zk0G+w5MCabwHXrKhVK/uZe5GVtqW+t7/i2dGddmPwjjv05iLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFAlLqpl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFAlLqpl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8525f0807aso5892516a12.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839671; x=1780444471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eaxrSKFqGBxNoB11ICKwv8puvUXJxfWCmED1lIq2/fE=;
        b=wFAlLqplgdO0zLjNokWOXzKRgWMq8hIhylqQTypa2t6+Khc4DRPpLMoUE/JoVjX3ut
         A3ZVitGvwRfgiENJmQ3WD9eIPpoXCYazjpcAt9DYJpI64lZWVc1gXo20ttFybZBP9fbV
         pWjK3p/STI5MOXd/4c4TiL8wtOyfrABYhrFnYzhKZ3jwiHG2QnF59hqHWD6XSSabvkC8
         RnRO60/N5Iw71NA9lUiiNYPVwSzdWBfUrFxCCeW3vwLTIK7paZjU4Sgh2ZHMR49AdENx
         22tAIp9KfDnRT+KHXIRU9a5qFJFfcf18iukpSNoPCpqOJSoc2XeE18tmoISiIt/XGG3u
         d1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839671; x=1780444471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaxrSKFqGBxNoB11ICKwv8puvUXJxfWCmED1lIq2/fE=;
        b=QjU0wFSkN3fOJs4dT9rzNOo0DdLTEwjqfmhQ6ay43J4h2i9Gx/b8NGmuaLW6KQcU3/
         d5ING7ogTyTB7RLUI9+kfA/kj6UxxL+VP1+bnmTnJVYRXddcUCV11AHMQS97QjCnFOFs
         xj0uVvEZPayhcoO20Vq7BJSYahaVGm2ajZTwhOkrAjiY13b03Qk2uojP5NYZwL0Dq//W
         yprYDa6M0MYZOzyXGRD61JejFMuyHSyY85NG7fpo/w154kyoljJ5GcLoFUZBQvTLnMO7
         XytALLaNx/XXxkFlE6i6ymyw5VeD8dDgjsTONm/RFhtbwiMozCE1d+WPA5IVow9NIc8A
         Ybsg==
X-Forwarded-Encrypted: i=1; AFNElJ8cwunnrZs8U6kfyQfqLAgcqEkKT3440Dg/GGRcYRQratXB85SLGdyjtAz9NsEsgiO9Mvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvlN5GWT303cPopFfv40O1DQDK8ww0XPvfrYTRFWM/xFAXQEP
	2kwdoCTTX7/dhVUM6/3ZU1iJeXydnThI1MSMQKj/DPCAsjWa+kYj7RRTe/rFduFTRCb0GqMgNWd
	iKQY6MtCL
X-Received: from pgli31.prod.google.com ([2002:a63:131f:0:b0:c82:3bf0:91df])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244c:b0:3aa:ec28:edc6
 with SMTP id adf61e73a8af0-3b328ebdb67mr22169975637.39.1779839671206; Tue, 26
 May 2026 16:54:31 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:07 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-1-jrhilke@google.com>
Subject: [PATCH v2 00/10] selftests/vfio: igb: Add driver for Intel
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

This is v2 of a series which adds VFIO selftest driver for the Intel
82576 Ethernet Gigabit Controller (IGB). This device is emulated in QEMU
and is also ubiquitous on many systems which makes it a good candidate
device for running VFIO selftests.

v1: https://lore.kernel.org/kvm/20260511211839.2781731-1-jrhilke@google.com/

Major changes in v2
===================
1. Patches 2 through 9 add Alex Williamson's series which adds support
for the physical device since v1 only supported the QEMU-emulated
device. 

https://lore.kernel.org/kvm/20260515220330.565792-1-alex.williamson@nvidia.com/

2. Patch 10 adds the official IGB header files to the driver, which
eliminates duplicate register definitions.

Testing
=======
- VFIO selftests builds clean at every commit
- vfio_pci_driver_test passes using IGB driver + QEMU. Use the following
  VNG command to run the tests:

  vng \
  --run arch/x86/boot/bzImage \
  --user root \
  --disable-microvm \
  --memory 32G \
  --cpus 8 \
  --qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
  --qemu-opts="-device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on" \
  --qemu-opts="-netdev user,id=net0 -device igb,netdev=net0,addr=09.0" \
  --append "console=ttyS0 earlyprintk=ttyS0 intel_iommu=on iommu=pt" \
  --exec "modprobe vfio-pci && \
          ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 && \
          ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing/selftests/vfio/vfio_pci_driver_test"

Future work
===========
Modify QEMU's implementation of IGB loopback data transfer to be
asynchronous. Alex noted that QEMU's emulation of transmitting data in
loopback mode is synchronous, i.e by the time memcpy_start() returns,
the data is already in the Rx queue. This won't work for testing
continuous DMA (memcpy) across Live Update + kexec.

One solution is to simulate the line rate in QEMU. This would allow us
to slow down the rate of DMA, so that it continues for the duration of
Live Update.

Assistance
==========
- Claude Opus 4.7 with additional assistance from GPT 5.5 for Alex's
  patches
- Gemini 3.1 Pro Preview for my patches

--------
Changelog:

v1 -> v2
- Removed the chunking loop in igb_memcpy_start() (David)
- Removed redundant writes to status_error and hdr_addr (David)
- Include official IGB header files (David)

Alex Williamson (8):
  selftests/vfio: igb: Use PHY internal loopback on 82576
  selftests/vfio: igb: Use advanced TX and RX descriptors
  selftests/vfio: igb: Program MSI-X interrupt routing
  selftests/vfio: igb: Extend memcpy completion timeout for line-rate
    hardware
  selftests/vfio: igb: Disable PCIe completion timeout retries
  selftests/vfio: Add vfio_pci_irq_reenable() helper
  selftests/vfio: igb: Factor hardware programming into igb_hw_init()
  selftests/vfio: igb: Recover after DMA-read faults

Josh Hilke (2):
  selftests/vfio: igb: Add driver for IGB QEMU device
  selftests/vfio: igb: Use offical IGB headers in selftest driver

 .../selftests/vfio/lib/drivers/igb/igb.c      | 524 ++++++++++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |   2 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   2 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  22 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
 5 files changed, 552 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.c

-- 
2.54.0.794.g4f17f83d09-goog

