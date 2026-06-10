Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D532143D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104738; cv=none; b=uxCUzcl1VLgnAJ0Qx8f0828vvKzx3rUjvudfTAJCPodREvbaCzCJmuQ4AgBxxiuO9GMXkJ24/blN0iSBM4Gi8ncIjtNrx1PP67pV/IP2vWKy4ECyjPj0e7VUQfB8IPj2vNd+swIZRd6hlPhqDBOowZgIg1FCUMnkerjbQc6W0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104738; c=relaxed/simple;
	bh=2FikaBR52j14eG2q4c7uEh8VobH/ZwHZeG2IeNzY9To=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s4GKCsEYUMV6NEQy+6G7di82nkSt0UB3kSAsRKbuMVyoJwy8DrmUDCCORJSJkxnUk1e9LLFXzwImPNHOSMXmFCgmpnD1bHYWex6JMe9rwI6RVg6KtKPheKmnF3F39ItmZ7saXUasr5Y80JizCOKHMiD6uAv0aRsevms9J/de7+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uodRyeWq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uodRyeWq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d979441eeso5953750a91.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104736; x=1781709536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3ufllk0o8kYPSdIZb3vpcLex8ZiEWODUNKVQWpmUYY=;
        b=uodRyeWqx2qrn/F7GC1FiUjPsxT03DAhr3png2dsGvE7wx+70Bas4NcySYhlrvHCtL
         fUTUbhhzf7eSbrdwYSROX1gKLQ63Zy2Vd71phl3g7T1Sm/goljIb1PEB72lz12D2a8gW
         wZys+OFE3hAkmhoWiBGRTtLuU8esUzGTL4cDbLy5RePE7smh/ncALvRLoHYHM3aqTcgP
         IPGBjDkzHptgODU2keotgcYYDyvDP/PD/aQ6r63+IFpDWk7Ws6D30uDrkwLWetUnngaR
         bkBcqyBHJ66BqX7cmRg0OErac6jhL8FGJOcmz+iPweX68Xa7J9V4mdiCZ23RFZhlYtHL
         DEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104736; x=1781709536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3ufllk0o8kYPSdIZb3vpcLex8ZiEWODUNKVQWpmUYY=;
        b=svGKJ54TbGBX9QRaPQhIs7S0QhuninEJp1yx0I+M96JKGIsL3ePn1X2D7VVf6uJYBf
         eTJIHiwZHaORHJrXgn0nRX9c+ZC8JEIGy8a2numeQ7YDjYcNfAhs4j0TXTSSv3uTmtpX
         kvmRVMu/7rJTjJUEJ513fmAqCfktPHp+mlX6x0Yoooe78nlZdrjAFoe4tYlyQ1qjgS5k
         o3/XT6zqK+YHxps+WaLUpDTMqdqGaTI7arV6PT1cXSjOwbW312TOLtxaM67fH2Wn1Le0
         31YQ/XIvfRw+62SUx9jzQ7sG+wrsKPGiOOZNs1ThW08/+0O9toal3n36KGJCYmvsb7IR
         umJw==
X-Forwarded-Encrypted: i=1; AFNElJ9SSYkAW1L2JxsznxdTIwFrEXV08/J1PKb/Xtnd4yBgW2UArA7hJIzjctJHFv9Dxp4tFIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8GmzqVNEkLILUq5ZYRoX3mAtSwiD1OaaQDwB2ICREoT4hG3i
	y9cx8TJnpN/q7Ijhqo7dwv/HO8jiKCJJ8xaSfmkcucdAhzYR6KGkjyW6wFa/SeQjT2Z1JmEADye
	RIg==
X-Received: from plbkn13.prod.google.com ([2002:a17:903:78d:b0:2b9:6a4a:141])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a46:b0:36d:bbe0:de7c
 with SMTP id 98e67ed59e1d1-370eeff19bamr24652982a91.12.1781104735720; Wed, 10
 Jun 2026 08:18:55 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:48 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-1-praan@google.com>
Subject: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P Registration
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce ZONE_DEVICE backing for VFIO-exposed PCIe BARs.
Currently, kernel drivers can register their BARs with the P2PDMA
subsystem to enable high-performance, page-backed P2P DMA. However, when
a device is bound to vfio-pci, this capability is missing.

As a framework, VFIO should support the same set of capabilities 
available to kernel drivers, provided appropriate isolation and 
lifecycles are maintained.

This series adds support for VFIO to register BARs as page-backed P2P
providers, enabling userspace drivers to perform zero-copy P2P DMA via
standard POSIX APIs (e.g., O_DIRECT) which require struct page metadata.

Design
======
The proposed design enables VFIO to leverage the kernel's pci-p2pdma 
infrastructure, delegating memory management and slicing to the managed
P2P pool.

1. ZONE_DEVICE Registration
A new feature, VFIO_DEVICE_FEATURE_P2P_REGISTER, is introduced to trigger
pci_p2pdma_add_resource() for a target BAR which creates the ZONE_DEVICE
struct pages and registers the BAR as a standard P2P provider.

2. Mutual Exclusivity Policy
A strict mutual exclusion policy is enforced:
     - Registered BARs: Standard mmap() and DMABUF export are blocked.
     - Exported BARs: Native P2P registration is blocked.

Users utilize the standard sysfs p2pmem/allocate interface for managing
memory slices once a BAR is registered.

3. Lifecycle and Resource Reclamation
A new helper is introduced: pci_p2pdma_remove_resource(), is implemented
to support manual teardown of the P2P pool. VFIO invokes this helper 
during device reset or session termination to ensure the pool is
destroyed and the ZONE_DEVICE pages are unmapped.

This is on github: https://github.com/pran005/linux/tree/vfio-p2p

Alternative Approach: Page-backed DMABUF Export
================================================
An alternative implementation has been explored which integrates with the
ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
registering a BAR as a system-wide P2P provider, VFIO optionally
allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.

A proof-of-concept of this approach is available at:
https://github.com/pran005/linux/tree/vfio-p2p-alt

[1] https://lore.kernel.org/all/20260527102319.100128-1-mattev@meta.com/

Pranjal Shrivastava (5):
  vfio: Add UAPI for ZONE_DEVICE-backed P2P registration
  vfio/pci: Implement ZONE_DEVICE-backed P2P registration
  vfio/pci: Block mmap & dmabuf export for ZONE_DEVICE-registered BARs
  vfio/pci: Block ZONE_DEVICE registration for BARs with active DMABUFs
  PCI/P2PDMA: Introduce a helper to release P2P resources

 drivers/pci/p2pdma.c               | 38 ++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 57 ++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
 include/linux/pci-p2pdma.h         |  1 +
 include/linux/vfio_pci_core.h      |  1 +
 include/uapi/linux/vfio.h          | 15 ++++++++
 7 files changed, 140 insertions(+)

-- 
2.54.0.1099.g489fc7bff1-goog

