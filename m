Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4B47A87A
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281088; cv=none; b=Rm23cmw6houH/swFo464k0qMryL5Ni9IP4yEceQdavuMuMonqAH/upAfh3nGVq1e8u56cUw7wojZpqRu+oSt6sehqn4yVdApkjffSQnIWl8O3QThJkymt+r5StdqvVyO5T5QeJMn9DoKDkb3wQ4Jn3kO30JJ8NfrhZsNQmQVWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281088; c=relaxed/simple;
	bh=97k0ZlGkYxJ3ZZkL6fedtzCve5UXzHsUti1g1e96dQE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IaDu6usfnAOb+Gdi7nPgbUF1sVH+sLZMRmsbpxN7C9RXKt8Z8A4zKdHUgBun4IiJmy3F4yypQUBZ8XWz6VBvQJBw7htzSidJ0MAoNNCoztjVLwetiAYEfXZSck1NI6H0GDLuRGnXlZPlxRfu4yx7ququc3bLAdrQ3RbSPV2Gkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPSp31GL; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPSp31GL"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso636518b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281086; x=1785885886; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkAgoYMxCwX1gGJVGSLs/sDny9bwcXWRq8b7/ipRw0o=;
        b=CPSp31GL0qwiS/vVONECcXQqtepqFQ/hOOWrqfP5Rer/61l2PzLwviptm9ml25HCyU
         AWeQUYyF5GGvoiXncCjm837lr9brK4TbF2Cyp3CYGxoUP1SHb05l2vwJkfmpsO24KXX/
         ViMCKtJW//KmEkMJbTO+/z+88HCHqYf6y4uuHxlFLIYKdsBS7dSrH8oP4esQaip8/zSl
         ALToCuBNbj9XEDJTLidkkhZbLRRm3gzZyLayYjrKYFMnH4JgcoKZA8CCp19Gfdp0WiY6
         A0PIabOfMcu5erLIXpWZVVx3TKmISyroRptox18uedJedBIgo0llFhGXUjM2DcZy+O15
         sa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281086; x=1785885886;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkAgoYMxCwX1gGJVGSLs/sDny9bwcXWRq8b7/ipRw0o=;
        b=CFGtxoBz4/FRGCgKVU2azawZ7EjyC1ZmWX8rh/FwaxLHsKaHuuIn2PyYA4VXOPzVfe
         kXtfPbGSKCzXZ903gI7x/YVpS+jJiaXmBP89YtzJrbKudUFVgVmfKU7GWy+bz7U2ze1r
         gCpziHu2SxGrgbvczRD858wudbMrXJJfmu3TaFzaXbSeEvbnQkL8oVeD0iGBYvQzvv+u
         hb6uAycr/MNSFW9LzZnV6fp4h6EBfp1XQWF+sqdlfK1iGeZ+LxDV/dNIWdV7ZhRSUTK2
         6JUmIJKRtHTqYcUcN8X0ZquwyM3Bl8JNNKL0xLCsym439Qr5mEUQHaWu4OXsGwxIF/T3
         Ohmg==
X-Forwarded-Encrypted: i=1; AHgh+RrkOk1mB6Q/aajWQ/bQ3HvR3tUDyaNzHR1sGLf81PYNuTh+eTvgTP22MKbHY/vsYhx/UDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfkSjGtUbe0Fzp1YZzawF8QFg1lRZDBrx4Y3PO35eJgkr+bP/
	KOlOTxGjRvZs6kUpsfG3P78VHQ6oIYMf87YLj+ay5GONVzf2IjLgegV8JE+HLNTWqdH/CUX/IGG
	x5BpZ8DJf
X-Received: from pgj1.prod.google.com ([2002:a63:901:0:b0:c9b:aaf2:afde])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:813:b0:848:2f77:e2de
 with SMTP id d2e1a72fcca58-84e93380b96mr4733743b3a.71.1785281085492; Tue, 28
 Jul 2026 16:24:45 -0700 (PDT)
Date: Tue, 28 Jul 2026 23:24:25 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACk6aWoC/2XMTQrCMBCG4auUrI3kP40r7yFSTDKmAW2klaCU3
 t20uIi4/IZ53hlNMEaY0KGZ0Qg5TjENZehdg1x/GQLg6MtGjDBFNNE4Bttl3lmBhaFGOCq45g6
 V/8cI1/jaWqdz2X2cnml8b+ks1uu3QklVyQITLBVoYFIr5+gxpBRusHfpjtZMljUVNZWFGioJB ++tae0fVRVlrKaqUGKBemYMbb34ocuyfAAfd4jbGQEAAA==
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281084; l=5999;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=97k0ZlGkYxJ3ZZkL6fedtzCve5UXzHsUti1g1e96dQE=; b=3qF1GNAiNDgHT1VMPxkNtGseQyBwuY1lCdhYno2jRnhocQj5dj2XA0S10bmb/6vlPrmLpMlKD
 I5v9S+hwLecDsO+vcBV8wbKUapLXW2vie+dy1TR+xGEyDdFQMEDLaM9
X-Mailer: b4 0.14.3
Message-ID: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
Subject: [PATCH v7 0/6] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v7 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v6: https://lore.kernel.org/kvm/20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com/

v7 fixes a regression in reset logic for the physical device that was
introduced in v5 and found by Alex (thanks!), and adjusts the Makefile
to allow the driver to be used on all architectures, not just x86_64.

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

v6 -> v7:
- Allow the driver to be used on any architecture. (Alex) 
- Fix regression in reset logic for the physical device. (Alex)

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
Changes in v7:
- Allow the driver to be used on any architecture (Alex).
- Poll EECD.AUTO_RD during reset, with fallback to CTRL.RST for QEMU (Alex).
- Link to v6: https://lore.kernel.org/r/20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com

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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 579 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  15 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   2 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  39 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 8 files changed, 639 insertions(+), 1 deletion(-)
---
base-commit: de61419bb27f985cb878b19942a55b026c9c865a
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

