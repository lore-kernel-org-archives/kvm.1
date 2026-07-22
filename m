Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210BF3054E4
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679342; cv=none; b=eYdDsRbWHE7OdP6Hd4b9Vni2anhG3Nw16uVXnpaMdOCkqAV100UbKFj1sigLKwI3Z7MZHk6A3b7smtl/J/pYjpjxK8LZYowpnp/kQaba8oRyc82MtvO9lXy5QPS2pidJQv5p1zU0cz9Pvgt4FnMU3+NkSDi69WXSE//hLiXplpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679342; c=relaxed/simple;
	bh=590cShiY0eSgAQmFSO/tqEVwDhYL1KsClsQrQs164MA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IY5ct3zre7ke1UFL5rs/ouvDFt63f2w5i31AMCG5evS7E8I4xKrFPCNRLXq7SC8LXuF3l9Yzr7ZN+cZLh4p5l5ngReqHTYu5RqYBcO5DuhjM3ArNlrKZwHA3y6Y6kAgKPpUOFPrjmRwheQO0MTGW3JshnOfjVLgAxvN2fgpLK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDfeIRd8; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDfeIRd8"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so20887243b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679338; x=1785284138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9/6GtGXg/YU+vJli6gEWc5fTaadTXT3wwRlPESHFLM=;
        b=IDfeIRd87+iTgjTpiwzn1XXNDVCpJOQHbgyfHWlEfw4sPEZqELeOJjE4Q9MN/VlOd9
         keeqyEBRszhQfG1gPCcrPu7HjwQML50TwsmknqPzuBViGZaQWtNgFonwyKn6BSquiPdI
         qBwsLDWdGA+1aS1Jdfhag+64AddAY9QE3IIuCXEKDjxnR7LqasrfcgfHRArPQxhEv1wL
         3O6hrjI0SiXdy/gzpPbawzwOm2h8x2sbyChFhHbkqeOqodyKdEGskqxJTML0SA1trAwL
         bOO0A/q+jkRpNOOwE5g/w1EhNVr7bYMgDu8v+oH1ABftbByIMV7U+pOakiMvc5GrIxfp
         freA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679338; x=1785284138;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9/6GtGXg/YU+vJli6gEWc5fTaadTXT3wwRlPESHFLM=;
        b=ACTKCnoNsgNn8lBdZWFTRM9qBlaZ3wseiwGTZ0o+KjsZr3Ny3LjsOyXs0RBWxiwTU1
         UE0SFB+KfoEoiLa3FAoJa629wQkQPF1diGlTitbk3QGE4fJrZuvPq/akc8qC5wj9WM1d
         jF7Qt5B2SYpelbU6WTLERpZv1Nu2muXWisJEKirFWgdIzdddlFjsSZSyIqEz3Rys4Bvd
         Btm/dArnHPEq1Xw5Hcg5WFpQ5YNcnAsp+EP1crnf9ONoRMTRQmnLrvtvvXcWoMAVO4wI
         IowOQv/0Sj+A2Dj3nC8Jq4yVBFofc7+ZD8ECLJllcb1wdxisS5jaQ/+2XfyqRqWx+AUJ
         wpHw==
X-Forwarded-Encrypted: i=1; AHgh+RqsfkjpJ7IPVxPUY+j7SiuHRFg20SSkelB3OAFqrytbwm6VzkVsz5yGmohoBzRTJIefDCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhKB7JD3qaUxNVXgS9U/PvY4UwKPqlunKcATGkg5eTiMQ1/Mn
	b6tRU12KpPGWAUUX24Aq9+mrpN7N5pyE/JDbOBCvdVstL/lIVFUrhSHm4Q5hYOf7PlsW/QLAKKo
	ZiQIYAsMW
X-Received: from pfei9-n2.prod.google.com ([2002:a05:6a00:c049:20b0:84b:57b7:60c5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928f:b0:842:3a98:b34d
 with SMTP id d2e1a72fcca58-84c2931087emr21320132b3a.31.1784679337712; Tue, 21
 Jul 2026 17:15:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:35 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKcLYGoC/1WMQQ7CIBQFr9KwFgPlA+LKexjTCP1SEi0GDNE0v
 bu0cVGX8/JmJpIxBczk2EwkYQk5xLGC2jXEDdfRIw19ZdKyVjHNNA3edkV0FigYbsBxEFo4Uv/
 PhLfwXlvnS+Uh5FdMnzVdYFl/Fc42lQKUUalQYyu1co6ffIz+jnsXH2TJFLlVYavKqhoumcC+t +Zg/9R5nr97QI6w3gAAAA==
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=5864;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=590cShiY0eSgAQmFSO/tqEVwDhYL1KsClsQrQs164MA=; b=y8ySHczxf0D7PXSrvWiXWOOkW4qkbKXDenuoBNQ8uqIvwVItesJiIs+N3ikFUwKp/FusFkPGq
 ClwymxH4o73B61u2ifHTZJJzGQ41NJ6p8K2+tAMhDzHD813d7iIAO0w
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Subject: [PATCH v6 0/6] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v6 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v5: https://lore.kernel.org/kvm/20260714-igb_v3_b4-v5-0-91503eddb98b@google.com/

The only change in this version is adding a patch which adds retry logic
to the VFIO PCI reset library function in response to Sashiko's feedback
in v5 about the 10ms being too short of a timeout if there's lock
contention during PCI reset. I was gonna make it the last patch, but
decided to put it before "vfio: selftests: igb: Recover after DMA-read
faults", which is the patch where Sashiko raised the issue, so that
Sashiko doesn't complain anymore.

Testing
=======
- VFIO selftests builds clean at every commit
- vfio_pci_driver_test passes using IGB driver + QEMU. Use the following
  command to run the tests:

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
--------
Changelog:

v5 -> v6:
- Retry on EAGAIN during device reset to handle transient lock contention (Sashiko).

v4 -> v5:
- Reordered igb_remove() to reset the device before disabling MSI-X (Sashiko)
- Refactored hardware reset logic into igb_reset() helper.
- Simplified reset completion check to usleep + assertion instead of retry loop (Sashiko).
- Allow arbitrary test data by enabling Multicast Promiscuous (MPE)
  and Broadcast Accept (BAM) modes (Sashiko).
- Fixed igb_send_msi() to use MSIX_VECTOR_MASK instead of magic number (Sashiko).

v3 -> v4
- Enable MSI-X mode in GPIE (Sashiko)
- Fix hardware initilization order to avoid race conditions (Alex/Sashiko)
- Add memory barrier to prevent speculative reads (Alex/Sashiko)
- Clean up stale references in commit messages and comments (Alex/Sashiko)
- Add a comment to address software/firmware semaphore (Alex/Sashiko)

v2 -> v3
- Poll reset bit and document the required wait time (David/Sashiko)
- Fix the logic for enabling PCI_COMMAND_MEMORY (David/Sashiko)
- Fail the test if autonegotation fails (David/Sashiko)
- Handle endianness conversions (David/Sashiko)
- Use real IGB headers at the start of the series (David)
- Add E1000_TXD_CMD_IFCS to the TX descriptor command word (Sashiko)

v1 -> v2
- Removed the chunking loop in igb_memcpy_start() (David)
- Removed redundant writes to status_error and hdr_addr (David)
- Include official IGB header files (David)

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Changes in v6:
- Retry on EAGAIN during VFIO_DEVICE_RESET (FLR) to prevent test flakiness under
  load when the device lock is temporarily held by kernel error handlers (Sashiko).
- Remove the 10ms heuristic delay before reset in the recovery path since lock
  contention is now handled by retrying (David).
- Reorder the series to introduce the library reset helper before the driver
  recovery patch.
- Link to v5: https://lore.kernel.org/r/20260714-igb_v3_b4-v5-0-91503eddb98b@google.com

Changes in v5:
- Restructured the series from 9 to 5 code patches by folding advanced descriptor
  support, MSI-X routing configuration, extended memcpy completion timeout, and
  PCIe completion timeout retry disable directly into the initial driver patch.
  This ensures a clean, fully-functional baseline driver from PATCH 01 and avoids
  intermediate legacy descriptor, timeout, and bus-spamming bugs.
- Reordered igb_remove() to reset the device before disabling MSI-X.
- Switched igb_irq_clear() to write-to-clear as required by the datasheet when
  EIAC is programmed.
- Refactored hardware reset logic into igb_reset() helper with proper sleep
  (1ms mandated by datasheet section 4.2.1.6.1) and poll-assertion.
- Simplified reset completion check to usleep + assertion instead of retry loop.
- Allowed arbitrary loopback test data by enabling Multicast Promiscuous (MPE)
  and Broadcast Accept (BAM) modes.
- Fixed igb_send_msi() to use MSIX_VECTOR_MASK instead of magic number.
- Link to v4: https://lore.kernel.org/r/20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com

---
Alex Williamson (4):
      vfio: selftests: igb: Use PHY internal loopback on 82576
      vfio: selftests: Add helpers to re-enable interrupts
      vfio: selftests: igb: Factor hardware programming into igb_hw_init()
      vfio: selftests: igb: Recover after DMA-read faults

Josh Hilke (2):
      vfio: selftests: igb: Add driver for Intel 82576 device
      vfio: selftests: Retry on EAGAIN during device reset

 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 557 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  15 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  39 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 8 files changed, 616 insertions(+), 1 deletion(-)
---
base-commit: de61419bb27f985cb878b19942a55b026c9c865a
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

