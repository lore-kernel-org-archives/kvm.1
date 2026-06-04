Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D831E855
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585319; cv=none; b=G8tQ4jOgQpbwUr7s8V6TITjfp1OEORfX2qJlHpQEBZE3aQK5XzwP1BZquGlnfKaHmS7lj/7fW7PiBgwWbwXrhioCv5Srfhru2DdUNREqz8I6pOC19xujkeLPgcABOwl5Tr45wKWxjFfbU1ND8Cv5y7VFUYqpmomjH0ON3xcXPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585319; c=relaxed/simple;
	bh=HbyMcDJBxgMyD0bzqWOlRDkmSTFj0tM83CqcfOeBGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruAnzjG+M6GYszpYjJLSh2fej27s/c2yc2VY3zaUTHVJKSYTxeL3OHAC9eEwIB3uL/nvej6K3Bo0wpwkmbdpkSqIz09u32vhe1eJJ3hBGmgk6FJogBQukEb9CfyCClieSstLFKazMTZE7yGQ8OWyFX3JvzlLU6FNpXqshJVKmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj1an7iZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj1an7iZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so613931a91.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585316; x=1781190116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=Yj1an7iZbQ0joBr5jket5MeFeS+OhrVXqU4lX/spTT2xwFsiCRxhLFGNduO/EVbZVV
         QoL+crZSitKQWlOJAsxgf5jfuiAaucs/Oif4mSzJu0EuV2uOkuotLlkKWLep2eaKz+2E
         o/lXCKmkzsImUCSyXHu0c2f5PyzEA0uv9Lm4IulM+/c9cUZb7oXXTZJuzKVinCPyg+jc
         DU5BlJW5/lj82NJCUncDq02cv3tuYUu7fUuh2+ehNlMwB4BAX9cgopQBnSseAcAzR4pi
         gnrRUG3AUd5OczvgOWXC8fjD1MWYPi8lX7ClWYmDHwg9j8a7G3Z0k6WExfefdkBqnrj+
         gy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585316; x=1781190116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=Z4OhSV5ta0HNpIwOQNlt/kLoMK69TzNNL2W5vKv5YhwR0JYAUwnSDlC7iDMhTFx8tP
         pmKttI9uwf3vi3XpVy+QQW6EzEqlCfLxc8m3YsaBQXjjAtLn9ZtHEDqvGDUKYIVrN2A7
         XPFyYI+pbdu3dgM0SoXXlvzVHPw4mMysjBUbvaGNjrMOkMSdj9WKgUtdP6QlG3DYEB9A
         82qdYywhk7DeHAz+OwEwIdPTrCGOLvGeZEeHvFxpptHkFYfRtMb9UEUtI0uQjQEWb98E
         5zCly/ZgHNz++AtWnlZ5IMo4t8hHKNhnPXLnatF8cD5HV1mJw1wAL7Gz6PuLdJB03VVc
         zb3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8V//VFJB2BMKHPZ7tS+rsSnbWv4p1wG1uEa9SD5hQv0mFAyD7Mu+hMqC4+W2m0H0OuuuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3hGBUzJsoWSl5JSslgOjTg/wkMRB6yI0GL3Z3NWq9vd4T6fvN
	IRuBZ77w3gC2+m2KQy5EvRQybDckHnJUiY0omEG2OjDQJz1BT2AmlWlT
X-Gm-Gg: Acq92OHfFPO7uhVr5UaMEr1xpiicZ+vlisUo8Bp9eQSO5MBOj6zXOlyR4tspFgxWgWc
	qQwa29lQnMb285zDrbrMOXN1KiIgncsNO8Qq1hJnLXSkrM+El+tOs7ncX1aOrsWJey+sqyT3WfR
	bPcLhv07YxmhkLuPRgrsuL/cqfCvGgufSsig9CQguOI7pEEHiyi2l0a1yHEvqgN1B7OYMhPsvSk
	R92BNCI0jcafVIb6COEuZxtD79G0vj/HYnc27+r+FuDjc7DSe/dY2uHpCju8caejR7aMquM+7wn
	f7ulnEP4g5f8mTbsLkRIa/FpXNgcVooxkmqNOFs5lAautrhfs15L3PW9gqoAUIdtYU/2ZozMVKt
	nRH/G8RtKPH0w3or9Nfv//dV4FOgnrGJc0fsf3cNyAHwW77czeujPttFAFudfkHcx8QsbWf2vAW
	3OvKNKz3bebSFgvieEKjMKbF2fVX9a6PHI2qLLuDZLwrQC7REZ
X-Received: by 2002:a17:90b:2d8d:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-36e32285cf3mr8241830a91.14.1780585315438;
        Thu, 04 Jun 2026 08:01:55 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0be0f0sm5020782a12.30.2026.06.04.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:54 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Date: Thu,  4 Jun 2026 08:01:41 -0700
Message-ID: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

Scalable I/O Virtualization (SIOV) is the next-generation alternative
to SR-IOV. The goal of SIOV is to support more virtual devices than SR-IOV
can currently support, while relaxing many of the HW requirements of SR-IOV.

SIOV VFs are referred to as Scalable Device Interfaces (SDI). An SDI has
a unique PCIe Routing ID (RID), but has no configuration space, BAR,
or MSI-X table.

An overview can be found here:
https://pcisig.com/PCIExpress/ECN/Base/ScalableIOVirtualization

Since SDIs lack HW support, the complexity will fall on software
(hypervisors, vmms, drivers, and/or firmware) to provide the same isolation
guarantees for SIOV that SR-IOV has today.

This patch series is one step in that direction, allowing the PCI subsystem
to discover the SIOV capability during enumeration. This was the minimum set
of changes needed so I could test the SIOV feature of developmental HW in
emulation. I have not tested a device that supports both SR-IOV and SIOV,
but this combination is allowed per the spec.

SIOV has two ways to assign RIDs, strided (like SR-IOV) or software assigned.
To support software RID assignment, you need to compute the RID allowlist
after all PCI devices have been enumerated. I've deferred this complexity
for now and only implemented strided RID assignment.

Patch 1 adds helpers to identify if a PF/VF is a SR-IOV PF/VF. The PF and
VF bits within struct pci_dev should be agnostic of virtualization type.
The helper uses the current logic which assumes any PF/VF is SR-IOV.

Patch 2-7 uses the new helpers throughout core. I didn't convert certain
device drivers (drivers/net, drivers/gpu) because the devices will not
suddenly start advertising the SIOV capability. These can be updated in
the future if desired.

Patch 8 tightens the helpers introduced in patch 1 with a new is_sriov bit.

Patch 9 is a small refactor for computing VF RID which can be shared
between SR-IOV and SIOV.

Patch 10-12 add SIOV definitions, capability detection, and bus reservation.

With this patchset core enumarates the SIOV capability and can identify
SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
To support device pass through, devices will need to add a vfio-mdev
driver with IOMMUFD support (or something similar).

Dimitri Daskalakis (12):
  PCI: Add helpers to identify SR-IOV PFs/VFs.
  PCI: Convert iov.c to pci_is_sriov_* helpers
  PCI: Convert pci.h to pci_is_sriov_* helpers
  PCI: Convert arch/powerpc to pci_is_sriov_* helpers
  PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
  PCI: Convert vfio_pci_core.c to pci_is_sriov_* helpers
  PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers
  PCI: Add is_sriov bit to struct pci_dev
  PCI: Add helper to compute VF Routing ID to pci.h
  PCI: Add Scalable I/O Virtualization data structure definitions
  PCI: Initialize and release SIOV capability
  PCI: Reserve bus range for SIOV devices

 arch/powerpc/kernel/pci_dn.c                 |   4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   6 +-
 arch/powerpc/platforms/powernv/pci-sriov.c   |  10 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   8 +-
 arch/powerpc/platforms/pseries/setup.c       |   4 +-
 arch/s390/pci/pci.c                          |   2 +-
 arch/s390/pci/pci_iov.c                      |   1 +
 drivers/pci/Kconfig                          |  11 ++
 drivers/pci/Makefile                         |   1 +
 drivers/pci/iov.c                            |  58 ++++----
 drivers/pci/pci-driver.c                     |   4 +-
 drivers/pci/pci.h                            |  43 +++++-
 drivers/pci/probe.c                          |   6 +-
 drivers/pci/siov.c                           | 134 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c             |  12 +-
 drivers/xen/xen-pciback/pci_stub.c           |   2 +-
 include/linux/pci.h                          |  29 +++-
 include/uapi/linux/pci_regs.h                |  12 +-
 18 files changed, 289 insertions(+), 58 deletions(-)
 create mode 100644 drivers/pci/siov.c

-- 
2.52.0

