Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283718;
	b=dUb5dVwnHnF1FvkKBR5hDtoGMFBg7g/FKVK0jLNl0yidmSDWSU8JejqvVyMj9J1z9Q7z
	 Nscov6IK+sHco99sFFjrSMAjwUKjve3GrO7EjMLKTJytdQC6q0G1qfGVkhFDNz1s4VuMG
	 BBbEvCM7z5jwXFlEwk3FKnEgRc/n9z8Nslfl/WzkMV/YEgiRId97EeiCtfYpvPWNArqSx
	 dgQWS0TkvWzMo1xLA5ss1kZZibkF4dSCDAD2bGCVnMozzQ3ZYIGjmanD6JZTBjN4ptQ+o
	 LXPNzlfeVz58/gD7gSjhHvCWnZYcMeeXBIg/Qquv0svUSEZcJeog/to2h3jE4jk0eqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jvjwJhSQyKynXs3xcViIfp8Vt2berFNSS1fsGkMrLC0=;
	b=gMD8mRW6y/nTgQGjM5LQOCU9+TiXMEsrzL7HDHqY2l8G3B7bf7UXAmpV89EmpXwFq/gI
	 g9B5K8vhwnIBSYCPwaBQSZFuf5gz219i8fcB0MYcWM3ThElN69H12xOMrutcS6qTDWfic
	 T8RYWbYgOdSWeR/ipdeEfJwcuuvN13ut/vNd4T9MYr0zhaimblgfV1UgC0QnBcHNib1i1
	 GI+rjTnSXtBWI1xbdPB3p9PSkPSdvVLwIRhVTZjFdBw2HOY6wVhgSfqwAJh4DbP3sKxAT
	 DLNz2EcaICd8vyigCKI38Ll+8/lJEQF4IkGQDP9ULgDI82WrqDSmYpWRu1CZVhdL9pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="iwt/2x8Q";
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66560A3804
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C66560A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iwt/2x8Q
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cbf700ddccso1218165b6e.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283717; x=1794888517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvjwJhSQyKynXs3xcViIfp8Vt2berFNSS1fsGkMrLC0=;
        b=iwt/2x8QEJP6nhg68Un19pgka0y5TLe4Zq2rjQM/szmhs2Hzp1Hlu6OWKtD5pxVbbU
         4ZzKmo/ao6KuUhDMVVQEhlRiMrMswlF5N0L8bPAfMgwbPRcFncXMsE2WYGa5mgnz36Fh
         zW8VgdGtwdupotBCMIpD3qu7K8YtB8dzI4XDChAPCtcxhzl40ydolKVqXFzmgrmI01nt
         koC5PQqA7utCSDWilzmOQRM9BjkQHeoxd6+ZT0E4sPtEemSd8mNUwbbM/cEkem6B31K1
         WX2uX7baeBLNZTjDwqOE3SnLW/Qb7LG+cuP6M4O8HA/rjo35EFC3Q+JS+H5vUcvlLd+n
         2tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283717; x=1794888517;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvjwJhSQyKynXs3xcViIfp8Vt2berFNSS1fsGkMrLC0=;
        b=vUGC86YRj4jNalmvLaDivePG/ljUdVPRDcShmPVCJJLaB+Oklz+u6eNyNZBg3mPxOi
         YdDeqwtoUbDcqSyj9iMacOxetunhPA+cbbaKEGL99a0n1SSb0LYL1XxefeCbqMs7Usdm
         YIlVXGQvqubZszisz9tiXGw+GVINNh4CYyBvw0/CbWEOy0xshyJwrXzw5HaraQuoG6Ty
         rnzQcaFgqrJALGxNvpY7JmUTM7DeY4MEcuFMCFQQAUSMn9PVjYW7JUmqh49Ch7b+nrJz
         8dI0OKUhibnUTcwoqXNSJSo6c90t2pNrEecSUlnJ1Lk2RYpTLTf3/JMFuehVE7W3K5N2
         Qj+Q==
X-Forwarded-Encrypted: i=1; AL+hErE4OEyuQCznQu7iZOrTR/a3WpNZRd6AenVtFZHDNAWE0wfVbgyTk4te3m30y4B0Cijm7x0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n4Iwyear0aZjRbwxnr9HFkpZgTNW3JQQ5pBdFFVfxw6WE7xGw
	JcxbGmYaVOkBYRsKIEJZcRGDhL95ct9f8/K5Jcql/MFoQr7kvWkV6sdj7lsNg6wFPeMKpiPCq1H
	jMohDy3CztyxeNw==
X-Received: from iofz26-n1.prod.google.com ([2002:a05:6602:851a:10b0:9c4:b80b:7605])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c3ea:b0:4b3:98f4:f057 with SMTP id 5614622812f47-5683c7b5c50mr1131764b6e.3.1794283716741;
 Mon, 09 Nov 2026 20:08:36 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:10 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-5-skhawaja@google.com>
Subject: [PATCH v7 04/18] iommu: Implement IOMMU domain preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU domain ops that can be implemented by the IOMMU drivers if
they support IOMMU domain preservation across liveupdate. The new IOMMU
domain preserve, unpreserve and restore APIs call these ops to perform
respective live update operations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  11 +++
 include/linux/iommu.h            |   5 ++
 3 files changed, 135 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a1f40e242d93..a98f16d11727 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -37,6 +37,7 @@
 #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
 
 #include <linux/errno.h>
+#include <linux/generic_pt/iommu.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
@@ -67,6 +68,35 @@ struct iommu_flb_obj {
 	struct iommu_ser_set device_set;
 };
 
+/*
+ * Reserve a new serialized object at the end of the set. The deleted objects
+ * are not reused, so the objects never move and can be referenced by their
+ * physical address.
+ */
+static void *iommu_ser_set_alloc(struct iommu_ser_set *set)
+{
+	struct iommu_hdr_ser *hdr;
+	int ret;
+
+	ret = kho_block_set_grow(&set->bs, set->count + 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!set->count)
+		kho_block_set_it_init(&set->it, &set->bs);
+
+	hdr = kho_block_set_it_reserve_entry(&set->it);
+	if (WARN_ON_ONCE(!hdr))
+		return ERR_PTR(-ENOSPC);
+
+	set->count++;
+	*set->head_pa = kho_block_set_head_pa(&set->bs);
+
+	hdr->ref_count = 1;
+	hdr->size = set->bs.entry_size;
+	return hdr;
+}
+
 /*
  * Restore a set of serialized objects from the previous kernel. The objects
  * are read using the size recorded by the previous kernel in their header.
@@ -239,3 +269,92 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_liveupdate_unregister_flb);
+
+/**
+ * iommu_preserve_domain() - Preserve an IOMMU domain across live update
+ * @domain: Domain to preserve
+ * @ser: Pointer to receive the virtual serialized domain state handle
+ *
+ * Return: 0 on success, or negative error code.
+ */
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
+	mutex_lock(&flb_obj->lock);
+	if (domain->domain_ser) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	domain_ser = iommu_ser_set_alloc(&flb_obj->domain_set);
+	if (IS_ERR(domain_ser)) {
+		ret = PTR_ERR(domain_ser);
+		goto out_unlock;
+	}
+
+	ret = pt->ops->preserve(pt, domain_ser);
+	if (ret) {
+		domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		goto out_unlock;
+	}
+
+	domain->domain_ser = domain_ser;
+	*ser = domain_ser;
+	ret = 0;
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_domain);
+
+/**
+ * iommu_unpreserve_domain() - Unpreserve a preserved IOMMU domain
+ * @domain: Domain to unpreserve
+ */
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
+	mutex_lock(&flb_obj->lock);
+	if (!domain->domain_ser)
+		goto out_unlock;
+
+	/*
+	 * There is no check for attached devices here. The correctness relies
+	 * on the Live Update Orchestrator's session lifecycle. All resources
+	 * (iommufd, vfio devices) are preserved within a single session. If the
+	 * session is torn down, the .unpreserve callbacks for all files will be
+	 * invoked, ensuring a consistent cleanup without needing explicit
+	 * refcounting for the serialized objects here.
+	 */
+	domain_ser = domain->domain_ser;
+	pt->ops->unpreserve(pt, domain_ser);
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	domain->domain_ser = NULL;
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 4755ab3cd67a..caa9778eee2d 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -15,6 +15,8 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+void iommu_unpreserve_domain(struct iommu_domain *domain);
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -24,5 +26,14 @@ static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *
 static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 {
 }
+
+static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+}
 #endif
 #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..77f78c88c627 100644
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
+	struct iommu_domain_ser *domain_ser;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.56.0.506.g506a7eabc5-goog

