Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0F38551A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552741; cv=none; b=lfMVbln0ncWP5L17RF4SefdiJJIeE9rt0jcPpPrs52+8MAQIjUSclb/zPW1bY3cUwOo9WjsE7c0MdSc3Rn0+PRAUrQ8U973aJqp8bIpvy9MhIoeYe0Xex2L1aMOigTEBFqQ5j9Sfino2ay7599Ql7mVfpVTqg5YjdN93B6MRXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552741; c=relaxed/simple;
	bh=nJ7XGUXkOgQHsRv+Wj2dMRj6wKQfs9bdI3HzzM3b4fM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XARIrwOg5rilonTNhp/1yvXF7Q+nCbLJw4jSmUyJsQ2kjyVs70nRStSoJYqUeJnHI7XofJvzHGHNwZqGJuevZavsrbAWYwz/4Cc8fGewyt4TAln5S5XDatllq7b1BevoDeWHsI0QoN4qZeL4sXZWQkb0+SWSWlANlbdxz+l3ZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obF21kqf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obF21kqf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8482df30da4so486659b3a.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552740; x=1784157540; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2qj5AVAlzvjbRDYHoteGFszEgxXl9L/uO4rkcOJvTg=;
        b=obF21kqfkcxyV+2DWgLneu/IhBlNKqtEZVB2r1EyOz1u81fsyVQYWeuWAhvROcx49j
         KX65glsRDlEh+3m7UQYUI1ZtSnSQv/34EzXwLEEcvXgogsOgt+LN1AvFq/KzmcoQGFC1
         tzR8e87/uVjqj9r9dopxL/XtfwmjKgjoZw3A1kTi3lgBs8C7E7nJNLI2rDrTvMZqFbk2
         GnDMR5jy0A4q5Ym8b9as3IX9Gs8LXikXOIe7SkAUmiP2E0zj2iEurzv/zUci/Hcqpx9N
         ecsX2zCLL4dZNpCPL7q2yEJCcuSi2BWpzpdXJWx/cf2GRIzL1bRewFNGwDlTW1s++dGd
         KPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552740; x=1784157540;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2qj5AVAlzvjbRDYHoteGFszEgxXl9L/uO4rkcOJvTg=;
        b=oCePVnzyIxVo7LEFLmuxrvtjuHotTVikfKVmAy61Wvbme+RQXerzZnH6qL+9f/HYhV
         m0d+JXtUJYeFfpV6QnNgryXZnDR0MvejFCXhqegXPHXAeeaR47DxymQB9mbUfEhElSkl
         HcoCqLEw9L6H70IJIoGUNhWnT8OMXdf24Ex8OWXKKLJdMyygvfW854m4XYP+Irp+ILij
         0Uge/tSgZv+EP5Oj/3ZgagccNBiHQBCgk4tCx1Ua16P/N7g1D6sX+tvgiGeS4mnrx3e3
         r5qw+2vI5YZKmB1F7uv8RcsGt9eWxojtPTbGT4Uo6wj5N5RpSyoeyIShk0V1mHMriSxX
         c3Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpoGDkiYGIyEmGzenADW5ph0nCVx2ZHK9siZSU61UNz7wSRunNgGjDB5C+6X/m868Rag58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNLFf1SUP6n7s6Fl3QoJWpVH1m0l1QV1kCdDf9d8K9sHLwPnN
	MwILfMCIuzKDcaDCTt0jXG+MQ0T5kE92U0dWiQJ6nQzsYrjbL3NATsG849WA17rpOd6OQCFH2JQ
	V+eNjiUvB
X-Received: from pfbdk16.prod.google.com ([2002:a05:6a00:4890:b0:847:91f5:748d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:91a9:b0:848:4b49:27fb
 with SMTP id d2e1a72fcca58-8484b4929e9mr2799279b3a.78.1783552739603; Wed, 08
 Jul 2026 16:18:59 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:47 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANfaTmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3cz0pPgy4/gkE10TS0NLk2RDE2Nz42QloPqCotS0zAqwWdGxtbU AASnXE1sAAAA=
X-Change-Id: 20260707-igb_v3_b4-49194c14373c
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Subject: [PATCH v3 0/9] vfio: selftests: Add driver for Intel Ethernet Gigabit
 Controller (IGB)
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

This v3 of a series which adds a VFIO selftest driver for the Intel
Gigabit Ethernet controller (IGB), specifically targeting the 82576
device. IGB is fully virtualized in QEMU, making it suitable for running
VFIO selftests without specialized hardware.

v2: https://lore.kernel.org/kvm/20260526235417.2058313-1-jrhilke@google.com/

No major changes for v3. Just addressing comments from Sashiko and David
on v2. See changelog for more details.

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
--------
Changelog:

v2 -> v3
- Poll reset bit and document the required wait time (David/Sashiko)
- Fix the logic for enabling PCI_COMMAND_MEMORY (David/Sashiko)
- Fail the test if autonegotation fails (David/Sashiko)
- Handle endianness conversions (David/Sashiko)
- Use real IGB headers at the start of the series (David)

v1 -> v2
- Removed the chunking loop in igb_memcpy_start() (David)
- Removed redundant writes to status_error and hdr_addr (David)
- Include official IGB header files (David)

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Alex Williamson (8):
      vfio: selftests: igb: Use PHY internal loopback on 82576
      vfio: selftests: igb: Use advanced TX and RX descriptors
      vfio: selftests: igb: Program MSI-X interrupt routing
      vfio: selftests: igb: Extend memcpy completion timeout for line-rate hardware
      vfio: selftests: igb: Disable PCIe completion timeout retries
      vfio: selftests: Add helpers to re-enable interrupts
      vfio: selftests: igb: Factor hardware programming into igb_hw_init()
      vfio: selftests: igb: Recover after DMA-read faults

Josh Hilke (1):
      vfio: selftests: igb: Add driver for IGB QEMU device

 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 530 +++++++++++++++++++++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  14 +
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  22 +
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 8 files changed, 572 insertions(+)
---
base-commit: de61419bb27f985cb878b19942a55b026c9c865a
change-id: 20260707-igb_v3_b4-49194c14373c

Best regards,
-- 
Josh Hilke <jrhilke@google.com>

