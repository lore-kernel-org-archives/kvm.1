Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9E48A2A8
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042112; cv=none; b=D7RGA+zgD3PiFIW2SLgF8N6/8JjQh/4uvYJDBgOky4UXVqNwg82KDCPzFK7pEW1J4zKRT4wnhXiH7anp/Eky3DzcXH3iSJ6rjRIezDrfKLhfvQOua3j7SAAspsVI/I2EO2yXfgG1hLYzGqJmDfVFo8NLb/mwA0NmcZagh6P4R44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042112; c=relaxed/simple;
	bh=KhYuiyOIcEqYqU9+FIYZUGJQyg6c8kYtZW9cH4hwYuI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ca0HUhINmLxl89PSmHGgWfWuwqE+6SF0z0lbKhqLOod0UxXB/5dS5y+31uMLpjFSInIdaQSLAsnVYWJBJhldOSuus9NH9A+LQkBrl2cy6EL5tB6jpscUUwtU3Os4oVrqncus81C5XEPDi6pAZyylyy78mw1o2qRr3bKmZ2xd4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oh3ehXx5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oh3ehXx5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848568a6f62so7766056b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042110; x=1784646910; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AdMdxqs5Z8x509tTZKpL2bKGAMA2jSi8MmCd4hShlVQ=;
        b=oh3ehXx5gPDkW44Jj7WTh7qN3mSQFBGcvRU1dGBjcFcvifZIZ1TqczpvQOnKMlUk7/
         0vUt1Ttz5xqvKzSIuuhFwFZbFoAd5Qz0jqy2j5yrnkCIKEK37iexB2V9OZ+Q+stLPWO3
         fObORFO5IxIKRRI3tFHmQkvrFfKxzHwzX7YHou4qUafjex0/KItcegFst9psyahGPCuQ
         RA6ge11jU3s+pemI/kqq7BgY9+NKMvlNiLJteH+VbVfZkp8Uwtwrl0mtbsewj2qo6pAs
         6ZoQFrVM+PzMevUSmyTrDD4FPiEONRA8BDNH2Ry0JNigtTYaafvrid/saaN1UlUh9Dq9
         cAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042110; x=1784646910;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdMdxqs5Z8x509tTZKpL2bKGAMA2jSi8MmCd4hShlVQ=;
        b=OrYjS1ZoWdi+TCBz42NX04IrUdRg8OvIKZ3w4hXUcGwTOd7cszOwUxULskzghSZ7uy
         xOmwhW1nlWNcwB+HsQJPqS79npPnIUeGRrhi2/7NgimLxD2YeUFaStfGOKTFLQUx3ZjY
         paZAg6eF1JwoETl1mcd+vBjOpiyrUeDuVOsRtJ0ROm3idlSKBjVmE8OCtuD3sSEp6T6p
         SGnJjTPLusShPCaDJ/t5ElxnktpoyIsDq0GKVj9E1/xp3jNPKNNJMqVRnMVQbP4scVw7
         W5JvdMh2lvhmLWQEBpjIFYK8TdRbJTi5gbXjnTYp1MMhvpU9ycBLHc+9Y5IqHDg+r1lE
         a2+w==
X-Forwarded-Encrypted: i=1; AHgh+RqM8MXW6qOJ+tEMk7N7f9E3NBfLkLijKzSCgK8CREl/Xu8wOsLaQS8WplLAcbmk7I9Dc/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy563UKG9VNInYZi1uCN0CNThSu0E2xMCfXGjiJUjLxnf2eqexH
	0xFBo4bPQZMT2PWcQS3YzIpKgMGWLZVlFurL5n97Sv6EV1M5Tei8RbdIupXe6puOpAPNTaK+NqX
	f7X8KXnIQ/A==
X-Received: from pfbhh6.prod.google.com ([2002:a05:6a00:8686:b0:847:9199:e06])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:460e:b0:845:363e:12d9
 with SMTP id d2e1a72fcca58-84a554f93damr3265089b3a.3.1784042109576; Tue, 14
 Jul 2026 08:15:09 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-1-vipinsh@google.com>
Subject: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This series can be found on Github:

  https://github.com/shvipin/linux vfio/liveupdate/v5

This series provides the base support to enable Live Update feature for
VFIO PCI devices using the Live Update Orchestrator (LUO) and Kexec
Handover (KHO).

Overview
--------

This series makes the following changes to support VFIO Live Update:

 - Puts VFIO Live Update support behind the CONFIG_VFIO_PCI_LIVEUPDATE
   config option (which requires CONFIG_VFIO_DEVICE_CDEV).
 - Preserves VFIO cdev device FDs across a kexec Live Update session via
   LUO/KHO.
 - Enforces that incoming preserved devices can only be retrieved via
   LIVEUPDATE_SESSION_RETRIEVE_FD post-kexec (preventing legacy
   group/cdev opens from accessing uninitialized state).
 - Quiesces the device prior to kexec in freeze() by resetting hardware,
   disabling bus mastering, and marking the device frozen to reject
   post-freeze IO/MMIO.
 - Includes VFIO selftests (uapi & kexec tests with continuous DMA
   checks) and kernel documentation.

VFIO PCI Live Update Roadmap
----------------------------

We are planning to add VFIO PCI Live Update support in phases. Since full
support of this feature will come in phase, VFIO PCI Liveupdate is
controlled by CONFIG_VFIO_PCI_LIVEUPDATE config option. 

This series is phase 1 below:

 1. PCIe function (non-VF) preserved across Live Update without changing
    BDF
 2. PCIe function (non-VF) preserved across Live Update without resetting
 3. PCIe function (non-VF) preserved across Live Update with continuous
    DMA (noiommu)
 4. PCIe function (non-VF) preserved across Live Update with continuous
    DMA (iommufd)
 5. PCIe VF preserved across Live Update with continuous DMA (iommufd)

Dependencies
------------

This series has following dependencies as shown in the diagram

    |---------------------------|
    |         VFIO v5           |  <--- Sent in this series.
    |---------------------------|
    |  Liveupdate Selftests[1]  |
    |---------------------------|
    |        PCI v7 [2]         |
    |---------------------------|

[1] https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/
    These selftests changes are needed by other selftests also (iommu,
    kvm), so, I have sent them separately.

[2] https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
    This is the PCI v7, which adds the live update support in PCI core.

Github branch I have mentioned at the top has all of these dependencies.

Testing
-------

Tested using VFIO Live Update selftests in both QEMU and bare-metal
environment (Intel DSA PCIe device).

  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 1 0000:6a:01.0
  $ kexec --reuse-cmdline -l -s /boot/vmlinuz
  $ kexec -e
  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 2 0000:6a:01.0

Kernel command line options used:
  - liveupdate=on
  - kho=on
  - vfio_iommu_type1.allow_unsafe_interrupts=Y
  - vfio_pci.enable_sriov=Y
  - vfio_pci.disable_denylist=Y
  - vfio.enable_unsafe_noiommu_mode=Y


Changelog
---------

v5:
 - Addressed Sashiko feedback.
 - Removed condition to disable CONFIG_VFIO_PCI_DMABUF.
 - Expanded vfio_find_device() helper to safely discover a registered
   vfio_device by matching criteria. Internal Sashiko instance found
   data race.
 - Updated selftests to latest changes in VFIO selftests.
 - Rebased on top of PCI Live Update series v7.

v4: https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (7):
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  docs: liveupdate: Add documentation for VFIO PCI
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
  vfio: selftests: Expose iommu_modes to tests
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

Vipin Sharma (13):
  vfio/pci: Factor out the reset logic in VFIO PCI device close path
  vfio: Export various helpers from VFIO
  vfio/pci: Export vfio_pci_dma_buf_move for vfio-pci module
  liveupdate: Export symbols needed by modules
  vfio/pci: Register a file handler with Live Update Orchestrator
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio: Introduce vfio_find_device() helper
  vfio: Refactor vfio_device_fops_cdev_open()
  vfio: Add API to open cdev device for Live Update restore
  vfio/pci: Retrieve preserved device files after Live Update
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test

 Documentation/core-api/liveupdate.rst         |   1 +
 .../driver-api/vfio_pci_liveupdate.rst        |  23 ++
 MAINTAINERS                                   |   2 +
 drivers/vfio/device_cdev.c                    |  67 +++-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Kconfig                      |  12 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_config.c            |   3 +
 drivers/vfio/pci/vfio_pci_core.c              | 119 +++---
 drivers/vfio/pci/vfio_pci_dmabuf.c            |   1 +
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 340 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  28 ++
 drivers/vfio/vfio.h                           |  18 +
 drivers/vfio/vfio_main.c                      |  67 +++-
 include/linux/kho/abi/vfio_pci.h              |  43 +++
 include/linux/vfio.h                          |  12 +
 include/linux/vfio_pci_core.h                 |   3 +
 kernel/liveupdate/luo_file.c                  |   2 +
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   3 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  25 +-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 256 +++++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  97 +++++
 26 files changed, 1097 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: cbf37fff757e87376e80e11a8378393a8f25145f
prerequisite-patch-id: 85705fb54d3065efe1d87ab4b69e828a9f3404e7
prerequisite-patch-id: a33ae79b5fc0259bd013b430c18cc3d14a678599
-- 
2.55.0.795.g602f6c329a-goog

