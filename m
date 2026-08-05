Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB73002D8
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889264; cv=none; b=ZLxjLEk6ydH62RJ6zy4ojuxk2Syx15zsyYywPeYOLBX6GjW3vRXyvRpj4DpZcL78xW7ZzgFh6HrD3ze3d//SK1SXnGcLWPoA5m5PQEAhz/luzUxIsxklmyPHGsMuwgkjtmcooVtWPaboCyaCg/yOvF3O9LAuT2LjNWprSGY6m6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889264; c=relaxed/simple;
	bh=sLFbKfSOzTOgEZoliwMAFgQy/seHdKaiywfAzh200YM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BbL30hTfktgzqNjdkv4Ag9vLdBDekKkNvjdsWpUfA9SG+HQF9L2Cp6MEPci36PrPTlwAj2xRvv3j+zg85yyCKlsX5RfyRatgPYrB0QKt1d2iSLiBIQc1ozRuIifxX00Am05X74C18IV/MJDPtx3ZioN5OSlj/DSZ9eDpi+2qLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaqqJSZY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaqqJSZY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so6678705ad.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 17:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785889263; x=1786494063; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pr3cQnrTGmUiECdXxfqO/gRSt1KNbd++por5s4HYq+A=;
        b=TaqqJSZYSlzJUjLf0zQTsMT6OoUwz0LqMmJ4yoggXdlZQJxJTG3KnN0HbUjvbyuSZ2
         zSAkJ+vUhQl7YdSOitfOIbBE1mQ8F5m4w7QqojOKTL0ebUK+NI5MHajxb2jb7RTfKOOW
         wdTtbLiqaX6QOFvrN6saS09csiYaMDPYDwjIYOaaygKUk4gBr6JSPravvdHMTniBNqpT
         VaC2OR9Kts9+yM3Ge/Y7Qhppp572Evh4x8/kYtbatPYjjQd/HpeQ6rAQFAPPsc20nDTd
         Ed32FXPsM7SUna8qAsJrZBb6RJGQuPeqjJIXMrHnuhB4AOv2Nmz0EMUiW327J3HhgsrS
         heeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785889263; x=1786494063;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pr3cQnrTGmUiECdXxfqO/gRSt1KNbd++por5s4HYq+A=;
        b=Y9iAKPMnozUFRjq0LZHsv59pQ2LWy8WcnNr7csuUyfeW8O1zcxvTSGrZ7dGHnwBdwz
         nMWm/jvfSPTt3YF0CRZ1iDeclCSPWPx3OeKiWcu1ONWiztG52QIxA9qzlUMAJoNPfQTG
         SM9aJBN2N2To5IRxofYQkxQIPvv3nsFK8Hs0tuMe4hY2XSj4KtybqwmHWDtx4UIsU0X8
         lN6k0mUGpl+COuaYHcXAvDD012c+ZlKuzP/Oe603pYC6pbgp/nJceUiRKvp6AFFoPKAr
         KKq20C4nYR7RWpxk/C4S/JEJRffS5+pVhoFbbP6z5c9ePx5wCrctUu6Tv7i+wrYAmjmX
         XJeg==
X-Forwarded-Encrypted: i=1; AHgh+RoPUoTzg63e08afnJ6Esjy1Xw3z55tYKVsxRQBixVpmNNHXCJ14rjw8M//Yagp9x4Ox2F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvabAEXrQC51gNa1Vs4Q8DBjgrikpOgkQ7OeegbRpKFfzi1nRD
	DXTdw3Maia3CST77RiuDFqRq5CsG2Ql9DD7KVLZ+GMq23RVwVXZrMNxs9TGqMI9QAAW+pwIo7S+
	OyBT7wXqH
X-Received: from pjbgn23.prod.google.com ([2002:a17:90a:c797:b0:38d:ed16:8b30])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dca:b0:38e:9045:bac0
 with SMTP id 98e67ed59e1d1-3903c55928emr2660916a91.5.1785889262333; Tue, 04
 Aug 2026 17:21:02 -0700 (PDT)
Date: Wed, 05 Aug 2026 00:20:57 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOmBcmoC/2XQS2oDMQwG4KsEr+vih2xZXfUeoYTaVieGNi4zx
 aSEuXs9oQuHWUro+5F0EwvPhRfxcriJmVtZSr30Qqung0jn98vEsuTeEEYZr1ChLFM8NXuKIIE
 0QdJg0SbR579n/ijXe9jxrdfnsvzU+fee3WDr/qdoNaQ0kEo6z8jGoU9Jv061Tp/8nOqX2GKaG
 ymM1HVK2inLOUcKcUf9QI0Zqe9URdbZEOmQYUdxpGGk2Cl47ZNFcEh+R8NIaaSh076ssd6gicA 7SgO1D2+i7VaGHHww/eWPdF3XP/iewSjLAQAA
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785889261; l=5064;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=sLFbKfSOzTOgEZoliwMAFgQy/seHdKaiywfAzh200YM=; b=QRSXirJpRY4w5NU9OHqeukPHuvr0rH832rQcFR2dXn3ywzrgll43a16zecLK4r/PMLpiaglvm
 xAOsW+JHxyRB3MHG4xfgc9k8OGcTNE5aJkIsriDsHbhpoz2BzW0iWDU
X-Mailer: b4 0.14.3
Message-ID: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
Subject: [PATCH v10 0/3] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v10 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v9: https://lore.kernel.org/kvm/20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com/

Version 10 adds an assert in the IGB driver to prevent DMA transfers
smaller than 60 bytes, avoiding out-of-bounds DMA writes caused by
hardware padding on short transfers, and squashes the recovery logic
(previously Patch 5) into the main driver patch to keep the driver
self-contained. Also add some logic from Alex to correct the ordering of
Tx/Rx queue setup.

This series applies on top of linux-next, but the VFIO selftests don't
build without this patch which fixes a compile error for the test
fixture:
https://lore.kernel.org/linux-kselftest/20260630213341.1664345-1-dmatlack@google.com/

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

v9 -> v10:
- Add assert in IGB driver to prevent DMA transfers < 60 bytes (Ethernet
  minimum payload size) to avoid memory corruption from hardware padding. (Sashiko)
- Squash recovery logic into the main driver patch to make the driver self-contained. 
- Set per-queue enable bits _after_ enabling global queue bits (Alex)

v8 -> v9:
- Enable Pad Short Packets (PSP) in TCTL to support transfers < 60 bytes. (Sashiko)
- Correct misleading comment about interrupt delivery in Patch 1. (Sashiko)

v7 -> v8:
- Rebase onto linux-next branch. (Alex)
- Implement retry limit in vfio_pci_device_reset(). (Alex)
- Carry David's reviewed-by tag onto the patches that haven't been
  touched since v6.

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
Alex Williamson (1):
      vfio: selftests: Add helpers to re-enable interrupts

Josh Hilke (2):
      vfio: selftests: igb: Add driver for Intel 82576 device
      vfio: selftests: Retry on EAGAIN during device reset

 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 585 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  15 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  42 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   3 +-
 8 files changed, 647 insertions(+), 2 deletions(-)
---
base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

