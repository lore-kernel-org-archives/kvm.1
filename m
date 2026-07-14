Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A337E5F6
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062678; cv=none; b=H1wLsOM2+/PxteoitnEYhhZdb214QgsVB78B3oFV5Fq0DwJN0qLb+ahhWABLqTtBGvanq8x9WPjte+Q+KTUhq6ozzJ8cSzTfE2ZcX5bHFlQ5xjwHjKpxIcZ4LV6JEoZLsx03xUEpq29MonbAUZ+V8I2PY4hT02mV24Hca6tfvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062678; c=relaxed/simple;
	bh=9gcR7HvP2KVUYsA1XwWA0eR6QDaw8AQ1VuLJtUoJiH4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mAlfP88WId8Yu7uFeFzKL0Fqg7EI/kqwlKthuqm84OPjX5FGBQhK9q2U2zsgAkhQMaPb5vXmL5GUE+jslWHrV90TZTDr5dJF7qzBM4b8r2KC6NAy+skp+nDFztWT4GTN7uZXXYo064vqmQLtjeB4IZccBt+SYEnPodZlSUdoVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIANFmII; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIANFmII"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cefa1a2be6so8731545ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062677; x=1784667477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAGqVJILZLq4bP+7ZV1P5jt91DTzcodBnQZuTGxkl6k=;
        b=uIANFmIIKLuizBJ+NfT+8btU8JnwsfwpM6rP7Hb9/yHZdwvqdN0IVi8zgjy/1GGsho
         HgGGFXcOOnJDNnXQX87a9HkOLO3pI7BNHoqntqeptNEo+gDRDs9jaZlTXCxcLohDTuj7
         AwncHumMbQb78yYanJOi/+JW867nk/rVXVzyMGBFFUSPnw4qJYPHtAp7TAK2lv8jOTdI
         llyomUC1Ucf2dXieRT+qCcurynmPMJ0ryXffTpZ52ANeHtV9st08IzUthnYbbPMy0psj
         LKY8iRFWcln4qYxCCyDdSU3Rr0cO6+EOFAG5YgYjZGgINZaQ3LhPAJPJxvEkl5OJ/RXs
         xyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062677; x=1784667477;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAGqVJILZLq4bP+7ZV1P5jt91DTzcodBnQZuTGxkl6k=;
        b=qY9/NHgJfsA0oDbrgGtjk8Okok5L1mrhoNUt/SeZikDvIsOopIf3fOhkiZ2eK5MyQG
         x4F9yx9kCXhXjISYyk6UASmlbi5e+X8nl0/iDTfbK/ofexlC8HuDc+eFKpKu+jDcYoPH
         x3N3fVPkwAF/MzPKf0BA1tQStNihLrHslgfIW7btSkXRYOgg0jWdXrgsyHih/Sg9rIB3
         +PlYeZ/arq9/RyDmEmeb2PCb0RJMpaqqWFnarK+MGcLxl0ZFZm+RqsuxnANGKolvFLxr
         ybrENOWZMDrgJ6Jpm3BpAFnv1qS34LdB+tKENmrdJO9sNaOC1uzM971crcGDAdNVBwOy
         fa9A==
X-Forwarded-Encrypted: i=1; AHgh+Rqr2rllkynTtShlpGO8iusMAwopcgCvqe3dGU2IXTlZObZwUACbaNuoNi22oFBNB5M7t3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjafq0a/JVdgm9zsEPYYknkiXBz+pjeHktWl7oGaaZgqy+CYgL
	v4Ejlmk5FwHQRYVaYkn5jvfwAs1GT7ezeIioNZ08Q351JF7DftFF79fY9DbVTjhd40FQu2lQjS6
	kyAlzOH+M
X-Received: from plbmu11.prod.google.com ([2002:a17:903:b4b:b0:2ce:fc90:1592])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c2:b0:2c9:b48c:fdde
 with SMTP id d9443c01a7336-2ce9f285258mr157803295ad.26.1784062676447; Tue, 14
 Jul 2026 13:57:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 20:57:36 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMCiVmoC/03MSwrCMBSF4a2UOzaSd6gj9yGl2HhNL2gjiQSlZ
 O/G4sDhfzh8K2RMhBkO3QoJC2WKSwuz68DP5yUgo0trkFxa7rhjFKaxqHHSTPei115o5ZSH9n8 kvNJrs05D65nyM6b3Rhf9XX+K4H9K0YwzY9GhNM56L44hxnDDvY93GGqtH16xxBijAAAA
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784062676; l=5364;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=9gcR7HvP2KVUYsA1XwWA0eR6QDaw8AQ1VuLJtUoJiH4=; b=unawleeUdKi8mUhMeA1t337eMzLAohYXWgrFI24/uS9kdp0aZ95qFGkq9l9MSxNmy8Y4fRuIk
 puITf3C9qxQBaiYFEzuOMAZ72Zj85S6z7O8CC+er4S3y2A//EWTeF4r
X-Mailer: b4 0.14.3
Message-ID: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
Subject: [PATCH v5 0/5] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v5 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v4: https://lore.kernel.org/kvm/20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com/

I restructured the series by folding Alex Williamson's advanced
descriptor support, MSI-X routing configuration, and completion timeout
patches directly into the initial driver patch. Hopefully this ensures a
clean baseline driver so that Sashiko doesn't complain about bugs which
are fixed in later patches in the series.

Also enabled Multicast Promiscuous (MPE) and Broadcast Accept (BAM)
modes because any test data where the first byte's least significant bit
is 1 will be treated as a multicast/broadcast frame and dropped by the
hardware's MAC filter.

Implemented a few other minor fixes from Sashiko. See changelog.

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

Josh Hilke (1):
      vfio: selftests: igb: Add driver for Intel 82576 device

 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 564 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  14 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  22 +
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 8 files changed, 606 insertions(+)
---
base-commit: de61419bb27f985cb878b19942a55b026c9c865a
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

