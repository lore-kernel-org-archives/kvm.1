Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CE477E2D
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454298; cv=none; b=Siwf5SjdTujkZGN3ePs8jbf2ceXuUv1UJoYCWyNYZ0ewOHRb3syiHdYB9L1iHtpvSzr22nDWphJmmICoRfAXJzwgIiQEw1Th/S799b7Q5nd4THo5DkKmww5mHnsoxokok+HU1EQ9OBc8K19NiYegBqZcJQmmLFV9/rT8HkT+FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454298; c=relaxed/simple;
	bh=y5JUWpBC9ZinaNrBiu9Ex9HCA7XQbTmIU8bYaz3FCDM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fJQkaQXkKGcRJKlxDaCcjIPLsIzojTSAKnmPN5Yg2iOsuSNd0qa2hrSr3Tqe7sEJWijBohnre7847iwWricpcpQhEg6LjOcisq51Q9FCOJdUBchl6GS0/PNahTj/jsvSksKtS3j8YGeKA3NAuBuZFC+YVawrK3CWQXNa790IfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai6W4DjO; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai6W4DjO"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so538826a91.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454296; x=1786059096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xz8u3Wn2RzlzqgpqFMq2TpNFtucYC8ouaOfrUxHadWI=;
        b=Ai6W4DjO24de2EPNufjZEnt48splaER+fSVNheodIPk74VpdVx0MMsru5mORcNPxAl
         ar5m3KUnq1Yevf5ZPZRWddJsQtTUtd8qQymTY7ABGi4U6pElwarvH6OdPIWdYk4vueaO
         uHQwYy9SD5luyFvF4WKSDWPakQzEFVM/LPJpocgJiYEcLQV67LI9BL4ruv3/1S2YzGix
         nwUm/vC8+qGDobndz/H0Scgcm3TwGvPuNP24xm4SwvTnPIxwsQ1haJJxc54Y2jPkaip4
         ZBnLgoapgcq5vJ4TcUhqcq/lSbYjsKHuGIiHo2MmHsg8x9tejgBgcJxpAhgmEJEIFuct
         2Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454296; x=1786059096;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xz8u3Wn2RzlzqgpqFMq2TpNFtucYC8ouaOfrUxHadWI=;
        b=lFFk5ZZ9zvLoCZK93N7WMAbIxxEguXejclFO65fgz0kBvXjly6weRshdQjFx2mpj3t
         gtBBmD/09lbRHHnn7GKIOFqD4L0rjYTG8Ej8fVTUYKaZykeRq9VIbkZukn0tg+etqImn
         bQH1DUuz7shnhArdRET4KnU63MPxxy96kwwkS4OtIJwcFRC3pD64eahvDlK+k+irStZ0
         Wr7NKCf3cdbvcv1fZFiPqIywZUAzgHXPx34bvX3cT3H+hRo7qrmE1qj0CvW++JnoXCfw
         bDzqrg8IgZN9rXaTSReceYgw5UQweB39opAMlbFSslpVHanlQk3SFItPjesUMxcvFne1
         y6qg==
X-Forwarded-Encrypted: i=1; AHgh+RpfRZj5Jva6FAZSpkm47+S7qH5TZSkXa2F2rzI1JV1kiIWntFBRI71zx/c21QkcMmAY/FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNdAWqGyvjHdwbVeLMvQ7leDF8LX3OrudjJe1fp7lUeXH0O+Q
	huDMSgjvqahd2zVpCn/6MiZh4pdqruswtN2XRY8IqWrpcoC3j30ivvDLyZsM2jXh4ID3jS2OC7d
	12xr6Qq4F
X-Received: from pjbnp16.prod.google.com ([2002:a17:90b:4c50:b0:38e:a577:5cbd])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1641:b0:37f:9ce2:348c
 with SMTP id 98e67ed59e1d1-38f9bee60d9mr3914341a91.29.1785454295795; Thu, 30
 Jul 2026 16:31:35 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:31:28 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANDea2oC/2XO3WoDIRCG4VsJHtfiz+g4Ocp9lBKiTjdCG8Nuk
 Zaw914TcmDZw2/wefEmFp4LL2K/u4mZW1lKvfRBLzuRzqfLxLLkvoVRxitUKMsUj80eI0ggTZA
 0WLRJ9PfXmT/Kz6P19t73uSzfdf59pBvcr8+KVkOlgVTSeUY2Dn1K+jDVOn3ya6pf4p5pbqQwU
 tcpaacs5xwpxA31AzVmpL5TFVlnQ6RDhg3FkYaRYqfgtU8WwSH5DQ0jpZGGTvtnjfUGTQT+R9d 1/QN5tYoajwEAAA==
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785454295; l=4527;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=y5JUWpBC9ZinaNrBiu9Ex9HCA7XQbTmIU8bYaz3FCDM=; b=IlIquqeKDLgwS50puJtY4XAYyqzP33VaWoN84QoiGxxJt1l93GYgI0Pi4edqXgAVy+WLKuRhE
 I009pLFUIV1DNdZyITl9mJ9KV2B138Te8V6GLx1XmesezkirgbTACpR
X-Mailer: b4 0.14.3
Message-ID: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
Subject: [PATCH v9 0/5] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v9 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v8: https://lore.kernel.org/kvm/20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com/

Version 9 enables Pad Short Packets (PSP) to support short packet
transfers, per Sashiko's comments, and fixes an inaccurate comment. I
also squashed patch 2 from v8 into patch 1 so that Sashiko wouldn't
complain about issues in patch 1 that were fixed by patch 2.

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
Alex Williamson (3):
      vfio: selftests: Add helpers to re-enable interrupts
      vfio: selftests: igb: Factor hardware programming into igb_hw_init()
      vfio: selftests: igb: Recover after DMA-read faults

Josh Hilke (2):
      vfio: selftests: igb: Add driver for Intel 82576 device
      vfio: selftests: Retry on EAGAIN during device reset

 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 577 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  15 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  42 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   3 +-
 8 files changed, 639 insertions(+), 2 deletions(-)
---
base-commit: 550cab3931e84e8a7701155f4dc40c0e4069d390
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

