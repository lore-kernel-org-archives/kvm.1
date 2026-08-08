Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC933F5BE
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156054; cv=none; b=SdNBcDp5yRsrZ0tOIKdzXZT6XUfEj2eVNSlM4BLv3nu0QLX+93JV4y4TKqFsLoMGdW7mo2xAA4SXcH/R1rHBfl4gTUmzyhI02biyNt+SUAOd1JTZrbSIH+FhstEwmKyg5XF0xRoFg5EgMxY16o/yDXHD6HkWlezQZulogks2YM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156054; c=relaxed/simple;
	bh=YdVyiwhsCeGpKxT0Q8nLIDeBOSv3F53BL01x6ICDG5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cqIzJivw6m/s8rI7poZCepzOpcab3Z4njpAFurrbWC7IihRbifKqWOmKjstKYScJlRROxxYiC6dMd6nm7qP9GLNTSsZYf3FBXEPPiteAb1aAKuG+mnFIWIhAn7UPLF9WlEW5feljC1gYmRFmTRbQD6FZqML8CnVOFBCkIYrzSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBv47dXD; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBv47dXD"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso183319a91.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156052; x=1786760852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QcZ3lEyCCzzeMyNCnd0GGUSHNnyLl9dJXn3wXJmrfU=;
        b=nBv47dXDGoWjD6Jx69vkxWqSnVdMKgxdJZjb8SeyIP8scbx+Db1dl1zpvkoUzwbOrS
         aMhFLAGRHvqIKZkAFEufmjPqrfwe57E4gTRGeRMeFoIedq3G+i+pILO/D7AGhtss6//P
         EfCAT2EGryuocU0+K24sVRRIEApALfv9eGBaz9ciwZ5oU1Vn/7ygHUKJBBj7zTrr1sRY
         0CwwmeDvQsGO4g7+pSnn4yenVhRNO+iQdFonSRicMXOrlTRGZ5Rt6bwTc7royBCIlapg
         cj9KaVshem7GVLJB3mejr6gs8zQnBthSbgZtzKSSDhHMtp0KBSWZOR+POR9Zse1g3kG9
         TkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156052; x=1786760852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QcZ3lEyCCzzeMyNCnd0GGUSHNnyLl9dJXn3wXJmrfU=;
        b=IlteyBFJskjCklRl7BdwIw9O6wJPLymE7gPmxirsc8HVokMWWclelJNBkSCoXtAfdk
         qiRv9N2210JYsIuO13YZ0AlTt4knoGf3S29gjMCnZpyNRnSjaKLzWCZ1nCgWKDOkgK7v
         gIVx3tgpp3+3BEEnSbSuT88dXPemLLhPcBQITGMhA0EziQPEHZOBSiStChErtEW2zJjS
         JD+w4Wr4sjqazQkecQ970BP2tOkVh3bbsnAXLccZ52FrIV0wMKD4h3ZI9MgySq3aKquR
         SuZuhHBJPR1g4TRKp32AJLoEFmYt9SN081zWkSk1O6uiBifj00PuAzA6tpEz6Esfbc7+
         GE+Q==
X-Forwarded-Encrypted: i=1; AHgh+RojaHkAf2/U7ZSFvJPIyeqVC4HLbl2Np0/pGa9bLf16RPt9tE6G/taeiJR6mDx2QQtZ2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy92YmOH39x3ec6wPvCFDqV9nI8vvV4AKBuckdWipRfeIOELng
	eHoFXyV3mgNkRcFEJXNaBQ5LV25SQ4z1O8QjyeqTCqBmsEjO0MO+fq+dnkjzyOAF4jTWgZtCigP
	oNLJ/dlrHpa2T+Q==
X-Received: from pjbhk8.prod.google.com ([2002:a17:90b:2248:b0:381:27d7:fc1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d84:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3903c58ece8mr27114243a91.12.1786156051516;
 Fri, 07 Aug 2026 19:27:31 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:14 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-10-skhawaja@google.com>
Subject: [PATCH v4 09/18] iommu: Add APIs to get iommu and device preserved state
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
 drivers/iommu/liveupdate.c       | 122 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  45 ++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 7f349ae5a124..20acf123b47a 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -47,6 +47,17 @@
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
@@ -262,6 +273,117 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
 
+/*
+ * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
+ * @flb_objp: Pointer to get the restored FLB object
+ *
+ * Return: 0 if FLB state found and restored, error if no data found
+ */
+static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
+{
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
+	if (ret)
+		return ret;
+
+	flb_obj = *flb_objp;
+	mutex_lock(&flb_obj->lock);
+
+	/*
+	 * FLB version mismatch is considered fatal for security reasons for
+	 * now.
+	 */
+	if (flb_obj->ser->version != IOMMU_LUO_FLB_VERSION)
+		goto err_fatal;
+
+	/*
+	 * Array Phys of each type should be valid if the FLB was created for
+	 * preservation. This is true even if no devices, iommus or domains were
+	 * preserved.
+	 */
+	if (!flb_obj->ser->iommu_array_phys ||
+	    !flb_obj->ser->device_array_phys ||
+	    !flb_obj->ser->iommu_domain_array_phys)
+		goto err_fatal;
+
+	mutex_unlock(&flb_obj->lock);
+	return 0;
+
+err_fatal:
+	panic("Failed to restore IOMMU Live Update FLB\n");
+}
+
+/**
+ * iommu_for_each_preserved_device() - Iterate on preserved devices
+ * @fn: Iterator function to call for each preserved device
+ * @arg: Argument to pass to iterator function
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
+				    void *arg)
+{
+	struct iommu_device_array_ser *array;
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return ret;
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
+/**
+ * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
+ * @token: Token used to preserve this IOMMU HW
+ * @type: IOMMU type in preserved state
+ *
+ * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
+ *
+ * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
+ */
+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
+{
+	struct iommu_hw_ser *iommu_ser = NULL;
+	struct iommu_hw_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return NULL;
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
index fd88c7e9c400..891a77e86c88 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -13,6 +13,16 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+/**
+ * iommu_preserved_device_iter_fn - Callback for iterating preserved devices
+ * @ser: Pointer to serialized device state
+ * @arg: User-defined context argument
+ *
+ * Return: 0 to continue iteration, or a negative error code to abort.
+ */
+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
+					      void *arg);
+
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
@@ -37,6 +47,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+/**
+ * iommu_domain_restored_state() - Get restored state of an IOMMU domain
+ * @domain: Pointer to struct iommu_domain to get restored state of.
+ *
+ * Return: Pointer to restored state on success, NULL on error.
+ */
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
@@ -68,6 +98,21 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
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
2.55.0.679.g6767b8d81c-goog

