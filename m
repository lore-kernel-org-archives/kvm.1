Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0D3845AC
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480259; cv=none; b=Ku/JXtwXhJp2OupuV6NyXNv+/jGPgTbzTjJ46+Uf64rNTRC4bSf9KFySvaHTAj4AzcAdXeJWybTM68YFCT55gAAlZ05Kn92kvyVOE/tqQKSnfLu13SI84voA2w/UtlxGTlFSorjAptbhH84p2T+NLpdV/5kV74nQRMtfWk7PIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480259; c=relaxed/simple;
	bh=Ia0KLRmyxKl2KmfjkhuvtXJUvVuNT3w4WDM8ljsL404=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYhYEqNOUwFOYLhEc+W9AdTbW9BHcXSgScmDub2HsDn+qYjYdcxIFzXrW75krJ3WvPyn6BrGDR7LMRL1oOnK9Tb3NzOabZlR9LnxuiemdlAOYvMlFBqW6YdIUaZK8Igi1mfURusiS+FsDwxlFIQEBEwfVt8fghXPp7iri7x4nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUV+6VMr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUV+6VMr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8581f7723aso1172500a12.0
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480257; x=1782085057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBaYCYKhJ727LgRzXY3UB5YUUjLtMLxXULsmkNca834=;
        b=HUV+6VMrpQDHrKDs4SLTBIZjb9FcbWj+QRKHPVfRulI/iJMciUQb9S/270aFuBDgaE
         Y04/b9FdzUYVRFhqK0WzjO1B5RQK7L+Pw+YUUVZUhXHX0NqbymSaQvm6zZs+yywlLhKY
         Iz1kzoHD1CD3/8OscD+NjS/aGnFd31hawlURtfkupGjUnPWapiUDDXfxmc6/nj3xsCMK
         XfiJrAIi7MJsi/mD2+CBShHQNG46160cDYLQIjKE9dSPe0K97Iq/vzcvNxrfRO/u8gWw
         3/NZjyjVsJLihL/oWy9w1BfB8ddTmD6fIwFghO47gzVn5chi0+oR1x5sXx5lci3wFwkh
         SMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480257; x=1782085057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBaYCYKhJ727LgRzXY3UB5YUUjLtMLxXULsmkNca834=;
        b=ZEDllcUq8B5RYuP8jf+1nWJLeOe8efsmQQMoTRX9ymK0WfpgOnjhmtDSisTVtdWMxN
         3/DrjGWPFcdEG6xAZJyf9pBmYq9kPmPkXGAmc/aFTkyEZMtIz6HWfecyNERgLfIZnBba
         GLHl+fhF6Wbi0jdayeFBA0WxCxeDvwqKe5WvSlkgcdAYXlc3mou/u7HiI8mudVNRJxQ6
         KASaIvkBcLHI63AiSjsp/ukbMYnK+DN4oUhaYdXEYuh3Zg8xETbLxThtIjj9ZBYwB1Y3
         2D73mSNYfkJY17uRHnjRbXneu9U3VrsdZf1cnl52qPliWVliR5Xg7YxTh1oALqPKECBN
         FNsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HZExVScYF0Q0Blr9C0ZLak2SYcA3/L5JgqiC/39TX2Hva2OzzJc2B+6jagZCHJ2Tfd/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx88Lxlz4Al6ekbSnQo1OsBdgqCKUNDuVD9+CG5qjxFQjU6wtR
	hxK99aMbFb5dYh9haJTUiNC4JUmHqQYfe2OWGedZLRlJjzlVasBbKxRb+ZzoGC09Ial4UcBHz5r
	I6JoN4E1q3rHndQ==
X-Received: from plgt14.prod.google.com ([2002:a17:902:e84e:b0:2bc:bdcd:c51f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:94c:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c410509486mr140737925ad.16.1781480256874;
 Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:19 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-10-skhawaja@google.com>
Subject: [PATCH v3 09/18] iommu: Add APIs to get iommu and device preserved state
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

The preserved state of the device and IOMMU needs to be fetched during
shutdown and boot in the next kernel. Add APIs that can be used to fetch
the preserved state of a device and IOMMU. The APIs will only be used
during shutdown and after liveupdate so no locking needed.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 75 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 31 +++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 2d782023407d..90750e78cd2a 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -18,6 +18,17 @@
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
 
+#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)			\
+	for ((_idx) = 0, (_obj) = (_arr)->objects;			\
+	     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
+		if (((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED))	\
+			continue;					\
+		else
+
+#define iommu_liveupdate_for_each_arr(_arr)				\
+	for (; (_arr); (_arr) = (_arr)->hdr.next_array_phys ?		\
+	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)
+
 struct iommu_flb_obj {
 	struct mutex lock;
 	struct iommu_flb_ser *ser;
@@ -216,6 +227,70 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg)
+{
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_device_array_ser *array;
+	struct iommu_device_ser *device_ser;
+	int ret, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return -ENOENT;
+
+	if (!flb_obj->ser->device_array_phys)
+		return -ENOENT;
+
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+			ret = fn(device_ser, arg);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL(iommu_for_each_preserved_device);
+
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	struct iommu_hw_ser *iommu_ser = NULL;
+	struct iommu_hw_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret == -ENODATA || ret == -ENOENT)
+		return NULL;
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!flb_obj->ser->iommu_array_phys) {
+		iommu_ser = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	array = phys_to_virt(flb_obj->ser->iommu_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, iommu_ser, idx) {
+			if (iommu_ser->token == token && iommu_ser->type == type)
+				goto out;
+		}
+	}
+
+	iommu_ser = NULL;
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return iommu_ser;
+}
+EXPORT_SYMBOL(iommu_get_preserved_data);
+
 static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
 {
 	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index f9528c94979d..5ad006892cbd 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -13,6 +13,8 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
+					      void *arg);
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 static inline void *dev_iommu_preserved_state(struct device *dev)
 {
@@ -28,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *ser;
+
+	ser = domain->preserved_state;
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg);
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain,
@@ -44,6 +60,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	return NULL;
+}
+
+static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
-- 
2.54.0.1136.gdb2ca164c4-goog

