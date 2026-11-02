Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633829;
	b=5YiAPlwI6JfOf2jHWdDbsAPVG951zwzQxrgHJxeVmSw2/5/MC/IZN7qmj4tWTo4oinKo
	 hwW7Ymf6YgzYnp6sHDDRY585CsTDEEaabAdKKKAQxfOxb4l1StBoyCEbgdvrJj6J2DbOy
	 GcBzXYbwE8REf1LMVlFA0NVTKnD8O6zvcv7wz4WCg7ABGcJFieEFbT2/3R2ICcNxTLqur
	 YJ04L1Uvp+8u0P8dlgQqNG4cqM6M1WxI+FwRpT+meIU9iJ0CrlnEr/BVoeV70Ro3GbRdz
	 Iekzi8BD4wKnsh5Ux1os4SXjh7yWihQ4++BuOqtjNmGaTBvE8rRHQkXWq5qbAymILkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=;
	b=Q1ZhAvNHIH98gDa0iaI9EmvYKvQgcj50CLpdv/0ed7noV1WiQrKzvC/QDa4ebw8UP5Mb
	 gI4+TuN49l4+t2kj0VvRAMPMIpbDlk12vuTcEmC1qay8M/BcFXiiFEi9h1xR+t7RjP1L3
	 flO2c+WcXLgbk1xpKAxBtEL9f/mwITDO1aMdMb3pST/ivXKnNXAMO28VVb6Hr5EZrhdIx
	 DCw3IK9DYrGyqKpGHzSlJE/nRhzkJMXh5XfV8MZV7gkNtBVQzXvpFZxh75h2fnrKahlI0
	 KcVG/K+0nBUHaZdoUSLwE7lV3+PRpHpXajZAyzXtfGSYml2lsiBLMKlE0P0DQCDDv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MTy0uESg;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8E60E500D
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB8E60E500D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MTy0uESg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e818ca61bfso33409255ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633829; x=1794238629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=;
        b=MTy0uESgncAZlH0iQMNHpU8jn/jckpkeRnSFlvH0xJzADMfZeqG2eqDZjLvSoeuQEo
         9aDvj0zLbYP55mxDEfLXUPmurTYimTNHHAA+HAiAtohQvne6lmaJV1hIKdIhEUKp2v5o
         +FXoYxwqn+R8bnwHePVYqaUT+xMEmEfBTJ8Or6T+AovH2c0EKY4kaGdVClhC4FQQL9It
         2LQy4c98Ge39Fa/9YMLUzbEQsW6gkCxJP/D7HdYaz0PI467Od/mHZECDLdyRDUYtMQGl
         S82hmym/DxYo5znL5qBXXIhpIeJmE0Qgzgu8+SMkgEJeKvp6Cr0TuY3X9imoJfgZyEi1
         SvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633829; x=1794238629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uG7rE7VtaZNVuMuLVIq/vVqSMDnx3FJ/eSjGr3CevQ8=;
        b=a9JkTrk88p6SYFnVDarT8nV9WS0XeawT958J8qMzRvXXrNNj4xK6Kt7Ene96/LH/zE
         DqAXY8FZaKTp8CU09+TkzbEzVdxgkhvIYI67MTmYbrk53JElwzbGzNreZbntzdL+Agpn
         IyGoYrvJDlcTPSrbdF/p0Sl+c+8w/EtaV7wtU0pyTX0XQesodo5iVFtRFvlpcjOnvNLO
         bWC9f11qw0SRjyJADEmNQz9gdjAAZX5NDeYWQBQLifOQEIBRh8p8fZ6E+O7WX7+4Jx+n
         c9QhhuMetLpfknXpobEV4sti7K5eiWDwJ+I75LRMhG3uh2lkvHqISAXofODkDEtxjPKU
         cZcg==
X-Forwarded-Encrypted: i=1; AKwUvBy30Rjs6lfCgKzdlsMdR18rhhKBkvbM7vct0ON81zSgJ2yAY8L53g136drCTasYMFQmo1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OKqBtQJ5tPfdTGbAbrUejOyOLgU+1Hi9QOpTB1jAzs73yy4qE
	nE9iGT6d5qqeXC7+OyXNjITeRmNV3wrYPQOuQ89nmze+HwLW3rMcU9BaApva1IQORMoHh3CNMkQ
	mh4L599eNjQ==
X-Received: from plct12.prod.google.com ([2002:a17:902:d28c:b0:2e5:712c:5c7])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea02:b0:2e9:2a1a:8b69
 with SMTP id d9443c01a7336-2eb364f1986mr88587545ad.55.1793633828399; Mon, 02
 Nov 2026 07:37:08 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:37 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-9-vipinsh@google.com>
Subject: [PATCH v6 08/27] vfio: Introduce vfio_find_device() helper
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Introduce vfio_find_device() to discover a registered vfio_device from
vfio_device_class matching user-provided criteria.

To ensure safe lifecycle handling, vfio_find_device() acquires a
registration reference (device->refcount) via
vfio_device_try_get_registration() rather than relying solely on
device.kref taken in class_find_device(). Holding only kref allows
vendor modules to unload while external callers hold device pointers,
leading to a kernel panic on release. Callers must release the device
via vfio_device_put_registration().

Additionally, move refcount_set() prior to vfio_device_add() in
__vfio_register_dev() so device->refcount is initialized before the
device is published to class lookups, avoiding registration data races.

On vfio_device_add() failure, the error path drops the initial
registration reference and waits for completion to drain any reference
taken by a concurrent lookup before returning the error to the driver.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/vfio_main.c | 64 +++++++++++++++++++++++++++++++++++++---
 include/linux/vfio.h     |  2 ++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 291460102cd1..00b3bc0c5339 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -383,17 +384,20 @@ static int __vfio_register_dev(struct vfio_device *device,
 		goto err_out;
 	}
 
-	ret = vfio_device_add(device);
-	if (ret)
-		goto err_out;
-
 	/* Refcounting can't start until the driver calls register */
 	refcount_set(&device->refcount, 1);
 
+	ret = vfio_device_add(device);
+	if (ret)
+		goto err_add;
+
 	vfio_device_group_register(device);
 	vfio_device_debugfs_init(device);
 
 	return 0;
+err_add:
+	vfio_device_put_registration(device);
+	wait_for_completion(&device->comp);
 err_out:
 	vfio_device_remove_group(device);
 	return ret;
@@ -1845,6 +1849,58 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device_match_data {
+	const void *data;
+	device_match_t match;
+};
+
+static int vfio_device_match_fn(struct device *dev, const void *data)
+{
+	struct vfio_device *vdev = container_of(dev, struct vfio_device, device);
+	const struct vfio_device_match_data *mdata = data;
+
+	if (mdata->match(dev, mdata->data)) {
+		if (vfio_device_try_get_registration(vdev))
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * vfio_find_device - Find a registered VFIO device matching search criteria
+ * @data: Context data passed to the @match function
+ * @match: Device match callback function
+ *
+ * Finds a registered VFIO device in the vfio_device_class matching the search
+ * criteria specified by @match.
+ *
+ * On success, this function acquires a registration reference on the matched
+ * device via vfio_device_try_get_registration(). This pins the device and
+ * prevents its vendor driver module from unloading or unbinding while the
+ * reference is held.
+ *
+ * Return: Pointer to the matching vfio_device on success, or NULL if no
+ * matching device is found. The caller MUST release the acquired registration
+ * reference using vfio_device_put_registration() when finished with the device.
+ */
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct vfio_device_match_data mdata = { .data = data, .match = match };
+	struct device *device;
+
+	device = class_find_device(&vfio_device_class, NULL, &mdata, vfio_device_match_fn);
+	if (!device)
+		return NULL;
+
+	/*
+	 * Drop standard kref reference. Caller holds reference from
+	 * vfio_device_try_get_registration().
+	 */
+	put_device(device);
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 3cfbf1d73479..1c1e41de49b3 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -441,4 +441,6 @@ static inline bool vfio_file_is_bound_cdev(struct file *file)
 }
 #endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.56.0.317.g454f8302e1-goog

