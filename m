Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E048C40F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042120; cv=none; b=Fu7Oeofe8rGhjLXb3fXUjItksaz/EcYlcGIoFph68zPdul32hvjSK2LMKfHpkXd++OQk+JjQrc098GCxfKT0PO64qi++O5OVSzEZEv/tpK8htBtAxb58p17pxchhM4ITrZwY2g37rKAoJjZgWx6n8JQZUZD8EFF+DFaH2LWXYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042120; c=relaxed/simple;
	bh=D1azvDxApPs5xbXiJtVJUqLP/cxUk13HfBV7O9ih/3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUZ44JiVfja0gPtsuaR5xWepgdEMbnvKS1Sv9Axe18EjzTJjytOAmcvr84MWXbvqxrO1tUa+fAZslu/F/x2MJe81lsGl0vJ50XNgPv78NUASENeDggt2pfW7FmDbXgKV093TkXzaz1eXM9TlOrS8nOEVfQq0bF5pvjVbj4Z+qYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkAVN8ha; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkAVN8ha"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1239967b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042118; x=1784646918; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEd+0Hxb+fZMWIajq41a/8wnr7549OLbqTKKS2EBeVQ=;
        b=nkAVN8ha9vPSVAEThwr9y96KS7Jl6hScvKVpUMEdQb7bYzh9SK6UqJeijRbfzNq8Cq
         C+7UjICjP8xXv/ZoMP/WVJlviwDRFGIGQ0vB+2JCwqwH/1yIPI1K4uHEGAIL7yjI/K/N
         tq9hgX8bIosrjvwonH8xk6FMOygLMnU5Dd5dmD9SRtnJMbSJGVeCLzLds8tQchi4FNI3
         27tBOn6nQiqLVFYz3RI4kgxS6SGyYRI7WQuKoa4yqYMQkJswOczV407dvvveQQHf7Gtu
         9aBj/RPuIDC+0JztGtF8YkbVEtSz7VtASGtyq0N2ME74QayvECMni3fmB4N08q119YC3
         Jp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042118; x=1784646918;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEd+0Hxb+fZMWIajq41a/8wnr7549OLbqTKKS2EBeVQ=;
        b=hFH1f+NqjTBewy6NesIDqACKKLtejSTwCY4cgM/8S9ripSp/7SKEFDSSIlh7eipPta
         7CUOWJ6kUjRmBrK9ZIufm5vXM4ONeaqs1jRgR+6boedAuZCLSoNl8oFx9jeiAVZZAJKg
         kKI3FAJUkR1Q0mkhPx2hDxLcEPPbDkBvktkA1cHgn809V8fUsQmZSj5XxN1ip3VTNKst
         cZ0NY/klfcRYs/ACLwc52gUm4hMiB6ExjCDh8TRkmVBga/Aw7tQlrBNZRoLcca4G91sb
         U54VaKtZhUwGtThOnRnkPz0JoWnirlAvs+8QkObDiBf69+IXRNPzDvnBUKSpKaIOAGPd
         gTIg==
X-Forwarded-Encrypted: i=1; AHgh+RroLV7Ro3d84tl5rXSwc35wdsKy5781WQYKt2/P5PY9bGOv1DD4UzWU8K9/04SzJaFUgSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmjLUCZigP0dAOYlSBJkouKKSO1Ryxgw1/+c8KakwCCO2Ygi/
	eQEuAu5epj49ZOqnEaxWj5+isG5MhGzEagc/drV61pyaycE3+JelNcx5/8aD0yICVGG8KT6/Lp5
	CDNKFz/sahQ==
X-Received: from pfblh20.prod.google.com ([2002:a05:6a00:7114:b0:847:86de:a817])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d9e:b0:848:7459:5f62
 with SMTP id d2e1a72fcca58-848897d2bbcmr12462324b3a.44.1784042117867; Tue, 14
 Jul 2026 08:15:17 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:53 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-9-vipinsh@google.com>
Subject: [PATCH v5 08/20] vfio: Refactor vfio_device_fops_cdev_open()
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Refactor vfio_device_fops_cdev_open() to use a static helper
vfio_device_cdev_open(). This helper will be used in subsequent
patches to support opening the device file during Live Update restore.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..2231423fe56d 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -16,14 +16,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
 	int ret;
 
@@ -37,14 +31,14 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
@@ -53,6 +47,18 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	return ret;
 }
 
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-- 
2.55.0.795.g602f6c329a-goog

