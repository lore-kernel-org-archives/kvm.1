Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8033839B3
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480259; cv=none; b=NfnUFp8hbOpKrcDfNPQsA/UMf64X47jexSBAbeKT0O3/Y5+eSO3IJ7sGqqTjerHjocOm4VkLjRZEVuyPf4AsxoLJaBFceNFhVr43fdas32utIxpvyp7qMyfc7ySYmD1WkMxZStdiCTuiT7dbzVeP3b8jaETYlhj7nLtZXT9ckJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480259; c=relaxed/simple;
	bh=/jzn4vHPGiGXDmiCgKEnxoGezE2gNeA4w0++aRG5NbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HC84U6+7ZqBxfZ8qT4bw/p/U1KVfGaixznIUxHuy1ltxshyU8sajNC2lsA/cWn7S7eKYGSXcU7xd6L4L9mLdge27Of7e4SAEDwejnLsTwVg9+K/dl8MIw8gnCXK1o1UDbaW2qUke28ShedcL597XpI/SGEzKOTl6EFQsHYoWPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFMl675m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFMl675m"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c129b3so1235239a12.1
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480256; x=1782085056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCWOgCuUam+6oDxi4jEg6+WaDeW7p6QlTv2GvwnY92c=;
        b=AFMl675mf1JG3CtxwPFcZnRNlhpuy6jTuR/WWhgblZsEaySxCpLaSVJwzfGJxZHaiC
         YZ70O9+k7ypTLRKa16W7PnepXCcafpWwbq59UNA8SXRYPu06vAR2BJ086Feo0apvMNLO
         Du1MxdmoQJ9V9V95I6YSs5mUpw2DgQzsYFa0zx0wvxvtAaFQ07+Vc57zHQ3NKzLzT3/z
         CNczjn8NfDMU3O+aVGjb9fxP/U11knwjXo9BSsdAZMvDAFTBVQcDFtebssFqHko2XsLf
         nzdwqa0lC7bX2T9ULxzi+tdDV57mIWoOJx+952pQwF43u3uUjl6xKSLkD2S5HNU0aQon
         1mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480256; x=1782085056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCWOgCuUam+6oDxi4jEg6+WaDeW7p6QlTv2GvwnY92c=;
        b=Y7gxdVIJpP7Zl5kDSR4RqbyVhRqysaVHFYKY29hmIbnZY4KlkXqxLCcG5gbXL1X0DK
         FoXuERlHWc+2hZco3hUh9wDsr6bo0Jb8LjKtUM/58slx8Z1dbOef/YZ7NkP4kuq8/VkQ
         ZGkN1bw8/D85Sxf9V/F5gA8wgHD7Ff/ggvPqB0xvYj5RyBEyyj04see8K/iiVEx1vtLE
         A8an8jQfblzo11FGZ9r1nwcc3ZRLHdGMuy+SSqxQ9wxrr5b3G7/ZNJcanBDoZAjd6S4F
         a3qRd6dLI41rRbJ0lPKbT4gUlLmgRbJK5OIPsyghTisUxXYfB8TBNDduW5N/Lhf5//BT
         Z5IQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yXki2mhJQCGv8cDhcsd6y9ct78NzXWddVE9n8a3rHCTLGsj0FiI3/6DY3N2P5OIkODnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7/Td4boz5LjXSmqFrEBeqKzsaScSUy3wblyCt8epoX2LHWAf
	4VAfExen309wQn/JTDG0XlHQMfhjSzMPTfKWJYKGyvZgfmfN15bjjWl7yQ3SmR3fIV0V42MYEfv
	L6QjjUMzbexkddg==
X-Received: from pga27.prod.google.com ([2002:a05:6a02:4f9b:b0:c79:81bb:79ef])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431d:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3b784026fbemr12891091637.37.1781480256053;
 Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:18 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-9-skhawaja@google.com>
Subject: [PATCH v3 08/18] iommu/vt-d: clear unpreserved context entries during shutdown
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices and root entries for the
unpreserved context tables need to be cleared.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  9 ++--
 drivers/iommu/intel/iommu.h      |  6 +++
 drivers/iommu/intel/liveupdate.c | 74 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 715b538e7efe..26258861e3bf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2374,8 +2374,11 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-		/* Make sure the IOMMUs are switched off */
-		iommu_disable_translation(iommu);
+		/* Make sure the IOMMUs are switched off if not preserved. */
+		if (iommu_preserved_state(&iommu->iommu))
+			clear_unpreserved_context_entries(iommu);
+		else
+			iommu_disable_translation(iommu);
 	}
 }
 
@@ -2699,7 +2702,7 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  * devices, unbinding the driver from any one of them will possibly leave
  * the others unable to operate.
  */
-static void domain_context_clear(struct device_domain_info *info)
+void domain_context_clear(struct device_domain_info *info)
 {
 	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5e0bc17e76bf..561cc4d14912 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1241,6 +1241,7 @@ void cache_tag_flush_all(struct dmar_domain *domain);
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
+void domain_context_clear(struct device_domain_info *info);
 void intel_context_flush_no_pasid(struct device_domain_info *info,
 				  struct context_entry *context, u16 did);
 
@@ -1293,6 +1294,7 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1310,6 +1312,10 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
 					  struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index b5613e4ad43a..aac7aa89a182 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -64,6 +64,80 @@ static int preserve_context_table(struct intel_iommu *iommu,
 	return 0;
 }
 
+static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
+						   struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		root = &iommu->root_entry[i];
+
+		if (!is_context_table_preserved(iommu, ser, i, 0) && (root->lo & 1)) {
+			root->lo = 0;
+			__iommu_flush_cache(iommu,
+					    &root->lo,
+					    sizeof(root->lo));
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		if (!is_context_table_preserved(iommu, ser, i, 0x80) && (root->hi & 1)) {
+			root->hi = 0;
+			__iommu_flush_cache(iommu,
+					    &root->hi,
+					    sizeof(root->hi));
+		}
+	}
+}
+
+static int clear_unpreserve_context_entry_fn(struct device *dev,
+					     struct iommu_device *iommu,
+					     void *arg)
+{
+	struct device_domain_info *info;
+
+	info = dev_iommu_priv_get(dev);
+	if (!info)
+		return 0;
+
+	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
+		return 0;
+
+	domain_context_clear(info);
+	return 0;
+}
+
+void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	struct iommu_dev_iter iter = {
+		.fn = clear_unpreserve_context_entry_fn,
+		.iommu = &iommu->iommu,
+		.arg = NULL,
+
+	};
+
+	/* Clear context entries for unpreserved devices */
+	iommu_for_each_dev(&iter);
+
+	/* Clear reference to unpreserved context tables */
+	clear_unpreserved_context_root_entries(iommu,
+					       iommu_preserved_state(&iommu->iommu));
+
+	/*
+	 * Some devices might not have teardown/detached properly depending on
+	 * whether a proper device remove is done before kexec is triggered.
+	 * Also unpreserved context tables are removed during shutdown. So issue
+	 * global invalidations to remove references to unpreserved tables and
+	 * entries.
+	 */
+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+}
+
 static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
 					    struct iommu_hw_ser *ser)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

