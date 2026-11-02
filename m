Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633832;
	b=ZBEkLv97j/myaEJB7zTZdQ3njsYBxvBIF9k/k41IJtxznp7hOJDBwP+X9le2ukcJdHQz
	 khG7HwSIYE6ct6aO4qCaX/OvLCYuKZtxFpDUHMckS868m6joawA1RSQ1N2Z/DknPv5XP5
	 sy6a4KhoCPCrcbV79TJE+LYjIvXXjQUGy7GgT8d1k2W1CaRwWDGI7rD4Rvf7LdPdv4iDY
	 NV4ezr8AYEL+uOO2LAplqqUFCXUu3DZUXVlbvuGXPufVKxqeeqRxBgphZa68yjx8bhW+C
	 PSWJwI23CH2Qdz76ZfLmgjG/KDsqGDOuNgX2QfpqvPuTx9BSzNAXNs8xOy26DJHgSOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=;
	b=Y0tew+2M2NAxoWzJPwEk4eGNyyMb8f1W/6xJ9SXlBQdpv+eHlHxJ6aZznUOe02hIgqSL
	 Sge3/LE6Ipmouyneu3TpHt90h6hNHwwdWhTvMBI7E+sfanxJVcFls+R1ybIV3Nga37vwD
	 AJdHlY3YtLtZKSOgEBZQVcbSDDQBsYhFmbYoSnhE6d3tq4yb6chqO/q7a5y4/omxJEXNV
	 4rlidB48UWOikJkK40XaSQwNDVfUH+QpltVJvQeb9/mYi04tY2bjtsUTd/YFMQ/oQPRPg
	 ORTW36y2ZW9iA5mLlXFmEshRjU/poRe6q4t1r6NK3f6Hqs503MWIkd1NYI95D1gZDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=icWuYzZ5;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DC60E6016
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9DC60E6016
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=icWuYzZ5
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e942b1cc86so35701815ad.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633831; x=1794238631; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=;
        b=icWuYzZ5Y9u9EFc54kOO+nz00Ke1fEd7Jz3Pu2lc5Sn8CWvbYCluoIYgBFkPIw7dI5
         Akfz3ciH5QmgT07+jYrEfkfQQfaodQvFT4dy9nnqePIZIerFQEUAqdJ8dnXsZqcFuKTj
         DWRFJt6jLifjhDFVsrdEIjdtaWr2d+hqssHmPWnQBe71dPwAGZJWj7j3VYGkxml2VMkj
         hs1biMpohVnd16XNZT1eacw1KHr0Ixtqi28b0+S3oDVV1GXyIc1NJQxRxfHxUGQ62mYI
         ejPsL6da/8Eke8C39H1kyWsxP8FXDLRtGhnzybpcjgrfRq+RipNCSTpV9IwsKH0x8llN
         DMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633831; x=1794238631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3L9pfGvMPznW7jp7Vs9w+wIM+Sxe1yFTij+KVLbvMwU=;
        b=CfQ40QiKbhxJeIsbLtcMFK7Ddlt4TBojfNv9CJEJUfejDOxZ2st2vnoHf6N3OO1Iiv
         SPl/0qLWdu3sgVgOhYQat01C7i1MnGkfaShhqcL6QInGUQs5OOr0EnnOVPvV1sczX7vj
         FUHf0RPQVlMHVvYUucq0Fwv4H8fvs/H+hUT88uaik2mxL0snUg8I3Q0FK4OiDd+RT6AL
         935dzzcgo9IVTulMWJKBuO391qEkq3Gl4+0NS5XG+IhZgKJtGS/e9jQGiGeXPk0N9myY
         iIRJ6qCIed32cCAztyjEdXwvpZ1NBaPdg6rfw/6u4na5YYkZynJSe8NBDjIwfVVh4VXM
         7nyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjbR9FWVRcJdBexxC9+9QDd8DVx2lSGXCNwXyyC+b1ywqFpOwfgEqDbvh7FKJAgN4r0hY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/i6XM/MxnsgvYny8WohTCKkF3PwBFf9vggpwsH1S77pVe4xapn
	NBI97gnLnSlfnymkVdhHIvjBxx0GLqw47ODpeHfimMSi/b94IdOjl4h9d+iKUpOvY4gOp5XIBUN
	EAekrQNfTsg==
X-Received: from plblf11.prod.google.com ([2002:a17:902:fb4b:b0:2ea:7f9c:2ce])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124d:b0:2e3:1bb4:6121
 with SMTP id d9443c01a7336-2eb364deeadmr90939265ad.49.1793633830638; Mon, 02
 Nov 2026 07:37:10 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:39 -0800
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
Message-ID: <20261102153656.1431701-11-vipinsh@google.com>
Subject: [PATCH v6 10/27] vfio: Add API to open cdev device for Live Update restore
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

During Live Update restore, VFIO PCI driver needs to recreate the device
file context that was preserved before kexec and return it to the user.

Provide an API for VFIO Live Update to get VFIO device file. Use an
anonymous inode when creating the file, since the retrieved device file
is not opened through any particular cdev inode, and the cdev inode does
not matter in practice.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 39 ++++++++++++++++++++++++++++++++++++--
 include/linux/vfio.h       |  6 ++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index d83e99137e1a..38e691eceab5 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -20,9 +21,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -40,6 +42,24 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 		goto err_put_registration;
 	}
 
+	/*
+	 * Simulate opening the character device using an anonymous inode. The
+	 * returned file has the same properties as a cdev file (e.g. operations
+	 * are blocked until BIND_IOMMUFD is called).
+	 */
+	if (!file) {
+		file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+						&vfio_device_fops, NULL,
+						O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto err_free_device_file;
+		}
+
+		*filep = file;
+	}
+
 	file->private_data = df;
 
 	/*
@@ -51,11 +71,26 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 
 	return 0;
 
+err_free_device_file:
+	kfree(df);
 err_put_registration:
 	vfio_device_put_registration(device);
 	return ret;
 }
 
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	struct file *file = NULL;
+	int ret;
+
+	ret = vfio_device_cdev_open(device, &file);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(vfio_device_liveupdate_cdev_open);
+
 /*
  * device access via the fd opened by this function is blocked until
  * .open_device() is called successfully during BIND_IOMMUFD.
@@ -65,7 +100,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
-	return vfio_device_cdev_open(device, file);
+	return vfio_device_cdev_open(device, &file);
 }
 
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 1c1e41de49b3..f46796b6724c 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -434,11 +434,17 @@ void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
 #if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
 bool vfio_file_is_bound_cdev(struct file *file);
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device);
 #else
 static inline bool vfio_file_is_bound_cdev(struct file *file)
 {
 	return false;
 }
+
+static inline struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
 
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
-- 
2.56.0.317.g454f8302e1-goog

