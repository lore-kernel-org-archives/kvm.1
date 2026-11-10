Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283722;
	b=ox+NR2TJOoX73WOtuX0nHiMzVwyeX/ayOqEqUuwwX33AvD52jsHMkR/E7f61Jo8aAViA
	 JI281DgbimiOKo0rWaWCGMiHfFar6HxK7Rqe6pnAe5husM/jjYPcSTA5XtPzGB1ctKMeL
	 U/S4OqKsP/PHn6SVFFUQpLP2eHqDkI2B6HDLi/XFt+23zmXEgwskxRTEM3PAOGS+LdH+O
	 pXMHhNNYOHPi0ZtqUxm+5JxB/4wFOmNgWQJazoeJTFATzpkzPNq1Gkexd8Zv+XP3riysV
	 +u1cW0eS6d/O5VvY0zrF5OwpirbhXWUbqO35r7k5nOzOR2xUDpGqFhINtYYKDeyZAfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OF4ceY/ukSRr68c2C4QPZiag+9zA6TSBfLv52kcePn4=;
	b=LVUspzQg5Y5kR5lvvANkSasD9v7095CEF+9a7CaBcZXWhUuy751hBYxTiFlJsRsbJXTU
	 nNEbfTXUCF9R9Vt22jJpqne+H85UK7gDRiI3wSe6l10eYvOqJoY8wolmAZ2KrYj9NLaS6
	 HIjLUrsfrCakC3Iz+O5Cdom1G8HdMzKp3lc5My/1wYYOIj1siRxB1R3n2EflFhCsra6SG
	 3KPU2ozmLXGmf9LEVJxLTC8p1p3+BBX+lshDafd2bU+iUJhwrKyAd3rBU59sYNGLEKKpS
	 WeuCCbFd92o7lO02b2HR5Hk6XV5Huz73KvXsgSGoUrgt7K3Idb76QQOrgmL1Oa+wFNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lhmg6rfj;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9760A5BDE
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C9760A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lhmg6rfj
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b0a3ee64bbso2843183a91.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283721; x=1794888521; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF4ceY/ukSRr68c2C4QPZiag+9zA6TSBfLv52kcePn4=;
        b=lhmg6rfjybKs136VNGOJMhEIj1hy06/6FEHOZZdy3cyuKjF/3SQf5SkyOVNCi7kBNa
         QcdBoJOrbuDaYOWdIwN5jYBDsVpwFU7h36TOmU2yNEPAbofo7K5PvYLzw/NXQ04NM43x
         3W+1Lfat1O5HTY1ncC/RscJZcNwWkJbCHwHWN9f+qPUQrEEOLPibkf+vZC4UNjKymLKI
         PEmxrt0H8CNJFe7uW1cG1xgPVmLmOooL7c42PLe6dbxEzhyWSyk5+OdjOAKmAgNrEbNy
         PhbQb10zVo5ipSoVlSjewCq8TSgXS5J6IlV8+VZgJGI2AH7aax0N/gJZRy4fIUMvZeUQ
         kWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283721; x=1794888521;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF4ceY/ukSRr68c2C4QPZiag+9zA6TSBfLv52kcePn4=;
        b=Iuj4fAW6qzBHpJn+rG4Oxo2ollmcW22tFkZ5YMaoZqHwOw6B70yU52i1aCoKVXniG1
         WLUrijjmIWItHp5XzKygJc2RC3uPA4MN266o6eRNYNYzBnfLvtojvi011S9J7nUFUvJn
         6hDwA88DpaqenL2jrridRIoVbButUQ0lJpEPt5jnuiHxzYRLGTreV/LzOZ/Ge9i9e7pw
         JJ15XnC0EiWKvju3qFMbnyGYYxeOGSidJSs9+Jj0oGxNw01WyAOxaOguWeAL+9Bp8D15
         o86WST/fPrk1QZJr1xpXIIAf37XyEuC51tRFTGq9efj3GgLlrhVcEJFkKvnfWBduZLGK
         SAqw==
X-Forwarded-Encrypted: i=1; AL+hErEgoe/AkwQ+SQEP6D1NiG7xSEQ3GdXdcxBieHxj/Mm9sKbHrLYhL8ahTGHvkD3RW9CNoJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+41iaztN5MtQnazB5Z0pSsOyzXFrWBVX+V6kyjx2QOD5pxhPNQ
	BI/mS6zS8c2I0ud53rOQ/e+TLbiLfJybX1e0QiUuQuLBS3vxwnoCKOP0mOrxoOAVXeEAsfRGvAq
	49v+e03HsduKJZw==
X-Received: from pjwx8.prod.google.com ([2002:a17:90a:c2c8:b0:3b1:317:bac2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f87:b0:3ac:9c37:9418 with SMTP id 98e67ed59e1d1-3b166f69fe1mr1628550a91.19.1794283720942;
 Mon, 09 Nov 2026 20:08:40 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:14 +0000
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
Message-ID: <20261110040828.1774343-9-skhawaja@google.com>
Subject: [PATCH v7 08/18] iommu: Add APIs to get iommu and device preserved state
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

The preserved state of the device and IOMMU needs to be fetched during
shutdown and boot in the next kernel. Add APIs that can be used to fetch
the preserved state of a device and IOMMU. The APIs will only be used
during shutdown and after liveupdate so no locking needed.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 2dcac82b453b..6b88c1540658 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -61,6 +61,14 @@ struct iommu_ser_set {
 	u64 *head_pa;
 };
 
+/* Iterate over the serialized objects of a set, skipping the deleted ones */
+#define iommu_ser_set_for_each(_set, _it, _obj)				\
+	for (kho_block_set_it_init(&(_it), &(_set)->bs);		\
+	     ((_obj) = kho_block_set_it_read_entry(&(_it)));)		\
+		if ((_obj)->hdr.flags & IOMMU_SER_FLAG_DELETED)		\
+			continue;					\
+		else
+
 struct iommu_flb_obj {
 	/* Protects the serialized state and the object sets */
 	struct mutex lock;
@@ -273,6 +281,86 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 }
 EXPORT_SYMBOL_GPL(iommu_liveupdate_unregister_flb);
 
+/*
+ * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
+ * @flb_objp: Pointer to get the restored FLB object
+ *
+ * Return: 0 if FLB state found and restored, error if no data found
+ */
+static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
+{
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
+	if (ret == -ENODATA || ret == -ENOENT || ret == -EOPNOTSUPP)
+		return ret;
+
+	if (ret)
+		panic("Failed to restore IOMMU Live Update FLB\n");
+
+	return 0;
+}
+
+/**
+ * iommu_for_each_restored_device() - Iterate on restored devices
+ * @fn: Iterator function to call for each restored device
+ * @arg: Argument to pass to iterator function
+ *
+ * Return: 0 on success, or an error.
+ */
+int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn,
+				   void *arg)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return ret;
+
+	iommu_ser_set_for_each(&flb_obj->device_set, it, device_ser) {
+		ret = fn(device_ser, arg);
+		if (ret)
+			break;
+	}
+
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_restored_device);
+
+/**
+ * iommu_get_restored_state() - Get restored state of an IOMMU HW
+ * @token: Token used to preserve this IOMMU HW
+ * @type: IOMMU type in preserved state
+ *
+ * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
+ *
+ * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
+ */
+struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type)
+{
+	struct iommu_hw_ser *iommu_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return NULL;
+
+	iommu_ser_set_for_each(&flb_obj->iommu_set, it, iommu_ser) {
+		if (iommu_ser->token == token && iommu_ser->type == type)
+			break;
+	}
+
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return iommu_ser;
+}
+EXPORT_SYMBOL_GPL(iommu_get_restored_state);
+
 /**
  * iommu_preserve_domain() - Preserve an IOMMU domain across live update
  * @domain: Domain to preserve
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 2d49885b9fcd..fb1e8efac8ec 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -13,6 +13,16 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+/**
+ * iommu_restored_device_iter_fn - Callback for iterating restored devices
+ * @ser: Pointer to serialized device state
+ * @arg: User-defined context argument
+ *
+ * Return: 0 to continue iteration, or a negative error code to abort.
+ */
+typedef int (*iommu_restored_device_iter_fn)(struct iommu_device_ser *ser,
+					     void *arg);
+
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
@@ -52,6 +62,46 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
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
+	ser = domain->domain_ser;
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+/**
+ * dev_iommu_restored_state() - Get restored state of a device
+ * @dev: Target device
+ *
+ * Return: Restored state pointer or NULL.
+ */
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = READ_ONCE(dev->iommu->device_ser);
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn,
+				   void *arg);
+struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain,
@@ -88,6 +138,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
+{
+	return NULL;
+}
+
+static inline int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
-- 
2.56.0.506.g506a7eabc5-goog

