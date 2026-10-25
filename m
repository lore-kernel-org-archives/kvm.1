Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792935032;
	b=SBIP9XtcXaYOh30JrmeW2eu4kzw8G70LcEJHMmVfuigr7+Xrmv9dg7q3kN0b33429IS7
	 JBEw3iOzXwLn+2Ihn5HSVTRyu0cOcgDmacGeyPuH9KuTTE0sqnOESxghAo9c4/xNUJwTw
	 bMMiZOgibv9pwm5MGcWmpQ8WF6bcDLJzXP6XveCKlTQJbsl3Z0QQuAbYEY08sroyb1Hgb
	 LIDfoPpwZJ9vpbJrai07d8rNzKK93Vgw2sCq5ElD6oqg8zJyNm+mPVsrXkeyiIRuQP5q+
	 Qcqd91iRIWS+N0zUl+CYdeIgcTh8PoRJKGXPk0ZvkY1/5hdY9YtQ5k4NdXmq3Y1INDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792935032;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+n8GzFLwIs6kJq4X8aNKy8RDZSwodsQriGPD8H/OFq4=;
	b=FPxjitMz9VS/5t1yUECNPGdIUTnMq3Oc80eNXaj2bkyppcMNwtLrCCETgaN+Gbv4lACo
	 qSVd6Dki53QZt7oLNfMi/+W/sgXeNCzgSjLW/m4LGWecLty5ifgrhqJGeZa2VGaem9Rz2
	 84BsmmqaBRRXDNXtrJWFPOoV11sHU4tcAw2fGiKurmZwGxdv4mnVs1OhdSJPAtAksEf8p
	 Ayc6Xc0WJvFzgNDKgXnxAImgJs4F9WbOxGs0pKrBvxcf2PggxVmOk/81H5KPjDypErn8b
	 PlwtWx07OlutgWjc4P6zU1SkwWUps1qB95pPeurcVj/sC3RlQHMS4851mbSBI15HA3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T2LAGSJh;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C910606A320;
	Sun, 25 Oct 2026 13:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C910606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T2LAGSJh
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792935022; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+n8GzFLwIs6kJq4X8aNKy8RDZSwodsQriGPD8H/OFq4=;
	b=T2LAGSJh148jXc6Trzry76hRVOntBti1pxctbiaD9dUIwOoFXRYFpXCl7vTgjzEaROZZdQ7y8bX2YwScvmczsMRbbFxH/CZ0aCLHk9kk0F4Foo/NAyH7bBGnCAX/ZFONysgskWWXpKL4MhBVv/H2VzqKHnNV6OgP8MlzB5hxgnQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDQQjHo_1792935000;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDQQjHo_1792935000 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Oct 2026 21:30:21 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v4 0/2] iommu/iommufd: Expose PCI host bridge MMIO windows for opt-in IOVA avoidance
Date: Sun, 25 Oct 2026 21:29:58 +0800
Message-ID: <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261022193359.GF3381610@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device sits behind a PCIe switch and ACS Upstream Forwarding is
not fully enabled, DMA TLPs whose IOVA happens to fall within a host
bridge MMIO window may be routed peer-to-peer to another downstream
device instead of upstream to the root complex for IOMMU translation.
This can lead to faults, data corruption, or silent misrouting.

The DMA IOVA layer already avoids this via iova_reserve_pci_windows().
However, passthrough paths that let userspace pick IOVAs (VFIO type1,
iommufd) had no mechanism to learn about these ranges.  Commit
cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into
dma specific path.") intentionally keeps this information out of the
IOMMU reserved-region API to avoid pessimistically restricting
userspace.

Following Jason Gunthorpe's suggestion [1], this series takes an opt-in
approach: the kernel reports the information, userspace decides whether
to avoid it.

  Patch 1 adds iommu_for_each_pci_mmio_window(), a callback-based
  iterator in the IOMMU core that enumerates host bridge MMIO windows
  with zero intermediate allocation.  dma-iommu.c is refactored to use
  it, sharing the same algorithm.

  Patch 2 adds the IOMMU_GET_PCI_MMIO_WINDOWS ioctl to iommufd, a
  per-device query that returns these windows to userspace without
  reserving or enforcing them.

[1] https://lore.kernel.org/all/20260921115513.GK11599@ziepe.ca/

v3: https://lore.kernel.org/all/20261004162213.3787623-1-guanghuifeng@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v3:
- Patch 1: redesign helper as a callback-based iterator
  (iommu_for_each_pci_mmio_window) per Jason's review [2].  This
  eliminates intermediate iommu_resv_region allocations, avoids size_t
  truncation on 32-bit PAE (callback receives phys_addr_t directly),
  and allows dma-iommu.c to share the same algorithm with zero overhead.
- Patch 1: dma-iommu.c now uses the shared iterator as Jason requested
  ("if you are going to add a function to the iommu core then
  dma-iommu.c should also use it").
- Patch 2: rename 'windows' field to 'out_windows' per iommufd
  convention.
- Patch 2: remove irrelevant 1:1 IOVA discussion from kdoc (iommufd
  only supports identity-mapped devices).
- Patch 2: explicitly state that windows are reported in host bridge
  resource list order, typically non-overlapping but no sorting
  guarantee.
- Patch 2: handler simplified to use callback directly (no linked list
  allocation/cleanup needed).

[2] https://lore.kernel.org/all/20261022193527.GG3381610@ziepe.ca/

Changes since v2:
- Complete redesign from forced reservation to opt-in query (per Robin
  Murphy's and Jason Gunthorpe's v2 review).

Changes since v1:
- (Superseded by later changes.)

Guanghui Feng (2):
  iommu: Add iommu_for_each_pci_mmio_window() iterator
  iommufd: Add IOMMU_GET_PCI_MMIO_WINDOWS ioctl

 drivers/iommu/dma-iommu.c               | 29 +++++++----
 drivers/iommu/iommu-priv.h              | 25 ++++++++++
 drivers/iommu/iommu.c                   | 51 ++++++++++++++++++++
 drivers/iommu/iommufd/device.c          | 64 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 59 +++++++++++++++++++++++
 7 files changed, 224 insertions(+), 8 deletions(-)

-- 
2.43.7

