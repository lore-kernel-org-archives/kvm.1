Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1099440A2C
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364028; cv=none; b=iN1j4jDTLIn1Jd1/sBro5jmrl9fOJVFTLkxEZsLyMHPuU5UVed6LltnLa/QY5w+JCExqf+FHvLEYTjEEGK6c2R8hVJFR/KMpn0W3Tpbo+htZaqe4M5c9Uy/IL0Q5U4CO4GjQpBDmINE1LfCQfQnx8L06OX/WbYqTEwI/Nj3LyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364028; c=relaxed/simple;
	bh=r1c+CaBhW5s4wXFD2O6k3jFF+p8PGPmXib9duAj+dtw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IfHuGTGfwalUUneMkXsYh0mnq50sUZD7CpwC0VUACku3rheGXYYupNxmOp7BLgYXcvOXPasRWwCgMlmAWxb3S/qvSz4OD2iUu+hU14lVhpNaNCB2iD0m5lhzLYpZEq5tPZ1QFABP/VJjbuyGqb95GUfpQp+QRCg0O/D7fnTmfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPdG9xoO; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPdG9xoO"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca124bf0189so116367a12.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364026; x=1785968826; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6i9gxS0ccvnf11VUuXna08dr0rnR4es/fvIWpwBhRHA=;
        b=KPdG9xoOeeAkYwv6rNeVc5TFkPwRqXwfsC+TcpzDrN11WI2y8npCLKWpgqycMjN/qF
         rsAtx5ARHDpyzr2Dgl+SsJxlPaxeixFDNne+rsIvyrr5X4011QQ5uwiO49gEoBXGCTmE
         D3Slza//jAE8CdvMd9tR+Hdjn+ANl3ZKuOn+sGOE9sN7m20Hmyejt1F2f6hBhaV6xJya
         Zn1lUKdsuQRDrnUsMiZt9YghiV1FpDpncfkk8e+gFKKchgUtOi1JFItFF4iMk2ce/dNH
         qTBcywDrSrVWozsEPwhmeiQjNejsDErBn5fRYz7gVwdlqZI18rBRVNVMPPH1hwG4nBA9
         XrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364026; x=1785968826;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6i9gxS0ccvnf11VUuXna08dr0rnR4es/fvIWpwBhRHA=;
        b=jTqOZwPGsByGN+KpNceUemNzweXYd1wIJZNZEts2P2lZqCz5Msddb+P9oH+ayS+drx
         g57a8qG2VA6YNY2QP5CrFozAVEJZg8B7+tnYY60q45trLi/rhpR7QLPb2H7Pax2Aj4Ii
         cNN4KRtEbL8K1nhSlR/cY7oWugIVlPUcqpPUk8apxeFiUxSGqPpYOErDaSmmhnWmxMvU
         2Pvi4iSgzv1JLT/FZ5BP9noglH0ak3izk16togWty1O3MreijKD3tY9eHZPv4FUC8CUy
         wppDNrXNP1+lN7xc8QTiVSegS3Z5y7WC1PgMu5FsDehFVc3FLrqtkrYSQYwLS62Ynx2+
         p+FQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNhiAAwCcqqQEyXXverXMgiM3Y3KF6GBKpZn0MK9fjUZTxPfnyAvY8tzbGTvO8EisPlOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldpnlO194QVFCBED06Di+Mo91hH2/FQ9l1FEIBulQyMH8VW+p
	O36y+q4P2tFtkB9sgaHH+0fhOdR8rEZE0b7Z/5OpAJwUIqsHm9EKjeVVJQ8CEqHxAYmvFHMEUn7
	k5rBzpsvC
X-Received: from plhz9.prod.google.com ([2002:a17:902:d9c9:b0:2ca:c400:4a09])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54f:b0:2ce:803c:6f09
 with SMTP id d9443c01a7336-2d035eece1emr1289925ad.18.1785364025721; Wed, 29
 Jul 2026 15:27:05 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:26:55 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC9+amoC/2XM3QoCIRCG4VsJjzP8GZ21o+4jIlKnTag1dkOK2
 HvPogOjw2+Y532yicZEE1svnmykkqaUhzq65YKF02HoiadYN1NCWYECeer9vui9Bw5OOggSNOr
 A6v91pGO6f1rbXd2nNN3y+PikC7yv34oUTaUAF9xYQlIGbQhy0+fcn2kV8oW9M8W0FFpqKnXSC E0xetf5P2obqlRLbaXCk4zKOdlF+KPY0q6lWClYaYNGMOjsD53n+QWJXeg2VAEAAA==
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785364025; l=4280;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=r1c+CaBhW5s4wXFD2O6k3jFF+p8PGPmXib9duAj+dtw=; b=GvZyKrMoebAjcDDlHpBwLITYvFjBc8UxGxjmlTe7z78CFZom1l0u1GemCj7aUoJII1+yOy7th
 7cDIB3fSI19CZcMppmbdegaPL19XcAoeU/u4gVi0fAcGCsp6EgDot1c
X-Mailer: b4 0.14.3
Message-ID: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
Subject: [PATCH v8 0/6] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v8 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v7: https://lore.kernel.org/kvm/20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com/

Version 8 caps the retry logic in vfio_pci_device_reset() so that it
doesn't loop forever, and rebases the series onto linux-next.

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
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  42 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   3 +-
 8 files changed, 641 insertions(+), 2 deletions(-)
---
base-commit: 550cab3931e84e8a7701155f4dc40c0e4069d390
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

