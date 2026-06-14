Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78937F8C1
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480256; cv=none; b=HCGiqoxgQrBshj6XyI8o1B43Cp0cFkxcTEPls7At+xFecFj3k95FxOlcJd61yHUeLTwGhBcz095hTfkNeBcu1QfG07LbC7zM45wGgzgXZy8yw3OPbvWJ2rXXwEv5jnj/DiOGLC5I0/8auQIUXf8938LFnOdCAO0f6ke7ArH4fYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480256; c=relaxed/simple;
	bh=u0j6XRiheniDrp72IFhQbCJaXglYcVebtHPVp/yVTXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npHi0QaM1OTznilIVNimX5n2GhaZq7NV1RuVP8fzdiqd6oCzTKciTiesL+B/oBZwEdDs5kuVF5a/9COINjXiF6OT8wceylCPoE/KAalh0qlD4MzK2+iiHly1pFEqpWwrse57JIpLPylv3jeroKKEcB6jwZQCxv5D6L0/iTzEksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYoXG+bm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYoXG+bm"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso1916672b3a.2
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480254; x=1782085054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXln37ss5Ikk8xz45fqFwD7l8OdsQwQR5jb4btzwNjQ=;
        b=WYoXG+bmULh/35BzKw5u8ven8M3qI+ksm8M6kAYtkqtfe8mT03Y7OMdHrZVfIw78NY
         dJ3exWz9OPODIv4OU9dFNqTz9kYBjgVs29nBuPHuZWPoLfYZw+LYEJGdTvnMidHKGfhb
         IgpRhlpzmr0lD/aT2qQgvpfmNdnVoFyLNb/yz1GZn2/CJHZY4xfwQgAD0lgLcBIAOsgc
         pAGr3qZstGitHX3fJHug4DzkELZ0PklLNhb3b0oKfCKQh8JOWsj6wjkOT6MLWoIJgTbM
         ahs6H00hXagRNSI67JZCdQeshbYb4mR7DfZo/ecaSLtKuUFXKtGDKEhqDXg5Ms9AqciH
         q4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480254; x=1782085054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXln37ss5Ikk8xz45fqFwD7l8OdsQwQR5jb4btzwNjQ=;
        b=MrQ9oyR343pRtS56Q/Ele7GlWrQiYGJD15Bc+LjLv2d4YIEy4bEYZTlLscSNX4+y00
         ZFlo/Oxv8KBq5UAVmsY8Jcn9ozWQw1mn083VLBgAQn0eL6Qq5qv/NqaLUfbVycupOfHQ
         2PeOTLRsS5DT9l3o5sXEQcy6+UQx6UN4loVGb9Wsst5Qm983hrnqB96DXEY2M/jbEA9k
         jEgMPd3WhZxYKHsztKYx0LWkJ64f9M/otd/oli9d1W7hsaNFTWnUSS/kNNUmsxzdYlsf
         kTwtCPNuYX8w9sMtxMX6uVLW3RA6YqYmL2rmOmXgIxSCKLdALKcu9soGvpgo2/16Ty6x
         39/A==
X-Forwarded-Encrypted: i=1; AFNElJ8xalpfaDmokhE7Gb73i5Pz5QybnuLcxk39+3PWKPaABic9QSfYT/tWxDcdbU7ZhWSoOy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJhwBHYBIxRE6TqoLSSsVsMleOhBBvP1oQ5RtvEHir6BshxZy
	hoQMNRWE4HBP5YH3JjCD+31E9jw5EnfSAV6noGDhacGIjC8FEVBgiP1TVkvcQcs4rpvxSn0wJXh
	4pjc3L5gV1RXXBw==
X-Received: from pfbkr18.prod.google.com ([2002:a05:6a00:4b52:b0:842:5944:1f82])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1256:b0:842:68d3:e29f with SMTP id d2e1a72fcca58-844e193a464mr8767666b3a.3.1781480253445;
 Sun, 14 Jun 2026 16:37:33 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:15 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-6-skhawaja@google.com>
Subject: [PATCH v3 05/18] iommu: Implement IOMMU domain preservation
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

Add IOMMU domain ops that can be implemented by the IOMMU drivers if
they support IOMMU domain preservation across liveupdate. The new IOMMU
domain preserve, unpreserve and restore APIs call these ops to perform
respective live update operations.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 104 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  14 +++++
 include/linux/iommu.h            |   5 ++
 3 files changed, 123 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 45fae91b43ba..16a0f75a98e3 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -8,11 +8,15 @@
 #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
 
 #include <linux/errno.h>
+#include <linux/generic_pt/iommu.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 
+#define iommu_max_objs_per_page(_array) \
+	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
+
 struct iommu_flb_obj {
 	struct mutex lock;
 	struct iommu_flb_ser *ser;
@@ -210,3 +214,103 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
+
+static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
+{
+	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
+	struct iommu_array_hdr_ser *next_array;
+
+	/*
+	 * The objects marked as deleted are not reused to avoid traversal of
+	 * linked-list and arrays.
+	 */
+	if (curr_array->nr_objects >= max_objs) {
+		next_array = kho_alloc_preserve(PAGE_SIZE);
+		if (IS_ERR(next_array))
+			return PTR_ERR(next_array);
+
+		curr_array->next_array_phys = virt_to_phys(next_array);
+		*curr_array_ptr = next_array;
+		curr_array = next_array;
+	}
+
+	return curr_array->nr_objects++;
+}
+
+static struct iommu_domain_ser *alloc_iommu_domain_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((void **) &flb->curr_domain_array,
+			       iommu_max_objs_per_page(flb->curr_domain_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_domain_array->objects[idx];
+}
+
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	struct pt_iommu *pt = iommupt_from_domain(domain);
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (!pt || !pt->ops->preserve || !pt->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	domain_ser = alloc_iommu_domain_ser(flb_obj);
+	if (IS_ERR(domain_ser))
+		return PTR_ERR(domain_ser);
+
+	ret = pt->ops->preserve(pt, domain_ser);
+	if (ret) {
+		domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	domain->preserved_state = domain_ser;
+	*ser = domain_ser;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_domain);
+
+void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+	struct pt_iommu *pt = iommupt_from_domain(domain);
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (WARN_ON(!pt || !pt->ops->unpreserve))
+		return;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (WARN_ON(ret))
+		return;
+
+	guard(mutex)(&flb_obj->lock);
+
+	if (!domain->preserved_state)
+		return;
+
+	/*
+	 * There is no check for attached devices here. The correctness relies
+	 * on the Live Update Orchestrator's session lifecycle. All resources
+	 * (iommufd, vfio devices) are preserved within a single session. If the
+	 * session is torn down, the .unpreserve callbacks for all files will be
+	 * invoked, ensuring a consistent cleanup without needing explicit
+	 * refcounting for the serialized objects here.
+	 */
+	domain_ser = domain->preserved_state;
+	pt->ops->unpreserve(pt, domain_ser);
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	domain->preserved_state = NULL;
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 3d1c65ed76fa..0204e17996b0 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -12,6 +12,20 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+void iommu_unpreserve_domain(struct iommu_domain *domain);
+#else
+static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+}
+#endif
+
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..0bea1a57f4be 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/kho/abi/iommu.h>
 #include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -249,6 +250,10 @@ struct iommu_domain {
 			struct list_head next;
 		};
 	};
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_domain_ser *preserved_state;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.54.0.1136.gdb2ca164c4-goog

