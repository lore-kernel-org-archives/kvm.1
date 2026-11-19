Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072170;
	b=Wqj0GFTFIrS62TKblERY/Muw+Oe8R2e10cxkG2801te2SK3oB59w2whl6i4bBEpOLLtA
	 NAFlvUgr/9FKtTtzO0Mcyg62UuzULAdhZTbVMSnvmCrLbbAote2we75WyTS46MT7iu/aE
	 s/+n2FgG9eJgPg17BBQwvRYvUNGjjg1FKkwCZjIDMtpz5BQiqpwBPbcnOweKqUOYvH5pe
	 +F8IiYfOlZzU9zhxrx9pF5RWAaSJyczjTDMZ90xZlMlbp1RQm1fQ6Qz0fFUBPo5PU1GMQ
	 W9JoJyUGMMCxTE+Le2rEDKq7ffNDbIfrvfJ87Kos6TcxoFu8oCZ79NVZcc4kCmR3WIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072170;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=VayotgvoFXRIHTVMqqUF1RR+4XjKhN+oBiCpb1sihJS0XEB7emIl3TnCXX7WJkGWNVi5
	 pZsFAdiBcXbecXmDHm2QMI5ky0CApI7tbDrSMNc5sG+G/6hXeDX7rliRyxkvYx0PXJU0D
	 diWeR8s0K2ZMBKWy89tzJ0C2p9n57Mj6/y/3fAQzBLjXovZBYDoMbZOZbyrAv6sdPjj2V
	 Eym9L4YtKtrOgw2kuh1qwMeiUUMWS/KXGHMzpVIiK7FbXak/PQJGV6cYd5vf2c6pMmMb2
	 1prAKnlzlncXpsUiPLV+4bBBNRpGX7UkTX5BZAJ9o3YrQROjSg3QOOSfFgXYIlnvgjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tBC7t8Z8;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98A60A2618;
	Thu, 19 Nov 2026 07:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C98A60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tBC7t8Z8
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795072160; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KnwYo2XdWjMn4cLtFXsc7wNn/LqJ2SyRK+sPxYoWIM=;
	b=tBC7t8Z8sZdEHrEzXlOZL2HaBuWkTGRSbn0ZC/j5l/nTdK3issHV0N6Bss754+Oxvuah9oPtftFR2aVO6ANdT0qmBo8KFLcYzAEc6Vx0ShZn1FMPXwP6UkLmO6YZkx+/W87qKOQaG838JCR8Jn1IvVQs1kN5OY8aT5NcnBcDONw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XF2mQ7v_1795072160;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XF2mQ7v_1795072160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:09:20 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@nvidia.com
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v7 1/3] iommu: Add iommu_for_each_pci_mmio_window() iterator
Date: Thu, 19 Nov 2026 15:09:03 +0800
Message-ID: <20261119070905.1336240-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119070905.1336240-1-guanghuifeng@linux.alibaba.com>
References: <179502940167.3851267.4719665473088413793.b4-review@b4>
 <20261119070905.1336240-1-guanghuifeng@linux.alibaba.com>
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

Add a callback-based iterator that walks a PCI device's host bridge
MMIO windows and invokes a caller-supplied function with each window's
bus address range.  This consolidates the bridge window enumeration
logic into a single shared algorithm in the IOMMU core.

Refactor iova_reserve_pci_windows() to use the new iterator, replacing
its open-coded resource_list_for_each_entry loop.  The callback
receives phys_addr_t start/end directly, so the DMA path reserves the
same ranges as before with zero intermediate allocation, and window
lengths never pass through a size_t field (which would truncate on
32-bit PAE systems).

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/dma-iommu.c  | 22 ++++++++++++++--------
 drivers/iommu/iommu-priv.h | 17 +++++++++++++++++
 drivers/iommu/iommu.c      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..5b73e71c312e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,6 +505,15 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+static int iova_reserve_pci_window_fn(phys_addr_t start, phys_addr_t end,
+				      void *data)
+{
+	struct iova_domain *iovad = data;
+
+	reserve_iova(iovad, iova_pfn(iovad, start), iova_pfn(iovad, end));
+	return 0;
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -512,15 +521,12 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	struct resource_entry *window;
 	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
+	int ret;
 
-	resource_list_for_each_entry(window, &bridge->windows) {
-		if (resource_type(window->res) != IORESOURCE_MEM)
-			continue;
-
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
-	}
+	ret = iommu_for_each_pci_mmio_window(dev, iova_reserve_pci_window_fn,
+					     iovad);
+	if (ret)
+		return ret;
 
 	/* Get reserved DMA windows from host bridge */
 	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 1f9f886b2c10..81c5b5ce67ec 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -127,4 +127,21 @@ static inline void iommu_debug_init(void)
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
+struct pci_dev;
+
+typedef int (*iommu_pci_mmio_window_fn_t)(phys_addr_t start, phys_addr_t end,
+					  void *data);
+
+#ifdef CONFIG_PCI
+int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+				   iommu_pci_mmio_window_fn_t fn, void *data);
+#else
+static inline int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+						 iommu_pci_mmio_window_fn_t fn,
+						 void *data)
+{
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..6b0e2b08ceba 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -945,6 +945,43 @@ iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
 	return ret;
 }
 
+#ifdef CONFIG_PCI
+/**
+ * iommu_for_each_pci_mmio_window - iterate over PCI host bridge MMIO windows
+ * @dev: PCI device whose host bridge to scan
+ * @fn: callback invoked with each window's bus address range (inclusive)
+ * @data: opaque pointer passed to @fn
+ *
+ * Iteration stops early if @fn returns non-zero, and that value is
+ * propagated to the caller.
+ *
+ * Return: 0 on success, negative errno on failure (including from @fn).
+ */
+int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
+				   iommu_pci_mmio_window_fn_t fn, void *data)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+
+	if (WARN_ON(!bridge))
+		return -ENODEV;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		int ret;
+
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		ret = fn(window->res->start - window->offset,
+			 window->res->end - window->offset, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_pci_mmio_window);
+#endif /* CONFIG_PCI */
+
 int iommu_get_group_resv_regions(struct iommu_group *group,
 				 struct list_head *head)
 {
-- 
2.43.7

