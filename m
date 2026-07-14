Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E794C6EEE
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042128; cv=none; b=tpDcSPckW0sHXmiT99OYUjZWtv+0UUkOm69YyqydISx+f1QU+A8QtfiWT5vlxX87T1Yv433O0PUaNhLEPVpgHNRpc8YpdPyu0uRr9I81RwMH4NjUi7J7pDDISd6i/h5BsonniS9GmsFGJT1oS5ITRokqDinwwZxLc/K1f1RlJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042128; c=relaxed/simple;
	bh=18is/Qt0S+jmUTzhdeluE3sxLqScHvGF040iAxoJfOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pk6gZ9r0MVFQi3/aVW293BnFo1vP3T1GHzQiMMKYYD2VAtCcR24wYJ6Kl5qAdSJd+m6esaNkBYMYmNa3R2wOx/Tlvfx75+MH1Vshkn1DuTAPQ8M1TdUqCoMQgOWPkwc+5dOu0N0Ac6DKOapCL5xOnEefz4XxGQfyI5ZnDzfx/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTpjetri; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTpjetri"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84859a64079so8061530b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042125; x=1784646925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=;
        b=hTpjetrirdlqoEFS/f56wAzOxHd4w/QamnydPc19Y/LJtawKyAhOx4W4TPKTm73c6g
         Eua067ADISKd0fsw9arYvGfi9pU9Ms/x+lq1pMiAqo/Z9YAjcekHMbY0gmg5y1osaHuE
         IbO9LCx7dFdg6+HVGFeaYWeEj+4UyQZqBcdauktw+pWJVmBvpdJMGA9lH6amUfhmmJVv
         9VGDpPsqqHThH/1ymD/XkugLKbs0E8SjGMnO6cOPrta2jHCtNKunARRdfV15rBCs6TI8
         Wo842BcgAiRv8Ch0uxDISIRhQ1TmoakAVDXJlOMQwXxIYCzaRw9IFomg/kd7JNjR8ozX
         E5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042125; x=1784646925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=;
        b=HZMedtVK1Um1rXTUSGPXl408wNz6A0GLbvpz/9/q5PMTkMPQ3i1apAKmMvAHe4sIvR
         +Zc/xmqHLNW3fQUR15UYoemfE41QJRDfxiG5SINGcgDE53ngH1FDMa15tV0S5RfVs67w
         cgT1qCl7h2cbpLGbIqgTNmewqEWksZIYd7LIkbA7yOf5qveZcHFVIQzb60zOc77IEMkZ
         fYYCmJfqk4QTqs6AXu8y7rmYp+zr/kJbAmKXWj+TSWPm0LzzUni9ocJDwcXkZvqmUOSj
         HeHnYWbf1F+om8VS+yRPR7fd2cmghfNDRsLNryvC/Qps50tTKKo5xRj1een7K1GVW1SP
         XzQg==
X-Forwarded-Encrypted: i=1; AHgh+RorNLBGm6DxNoE5AJFFcBhnl9be0imjDIT08rSWA0/bxsyssk1AvCV0/bTIfce8uvFPmm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesozWBpbrxM813LFVroaJ7YHO0se7sco/0HGEONJ7acAgjoMf
	pPYjn47CWX72Zy9STQcsi7NmfvKHlE9VoN4i7TbmX0sfpP+S8QHdmQpq7niLeceXxHVOR/LULIn
	7NqrSkIhCDw==
X-Received: from pfbll1.prod.google.com ([2002:a05:6a00:7281:b0:845:e386:e036])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f14:b0:845:e9e5:cdec
 with SMTP id d2e1a72fcca58-84a559bb7dfmr2554072b3a.62.1784042125277; Tue, 14
 Jul 2026 08:15:25 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:00 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-16-vipinsh@google.com>
Subject: [PATCH v5 15/20] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
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

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow writing selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  3 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 ++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 3eabead717bb..66fc29662daa 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -40,6 +40,9 @@ struct vfio_pci_device {
 
 struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_free(struct vfio_pci_device *device);
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..a6e0e7c6e18e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -414,9 +414,13 @@ void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
 }
 
 static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
-				   const char *bdf, const char *vf_token)
+				   const char *bdf, int device_fd,
+				   const char *vf_token)
 {
-	vfio_pci_cdev_open(device, bdf);
+	if (device_fd >= 0)
+		device->fd = device_fd;
+	else
+		vfio_pci_cdev_open(device, bdf);
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
@@ -440,16 +444,20 @@ void vfio_pci_device_free(struct vfio_pci_device *device)
 	free(device);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
 {
 	struct vfio_pci_device *device;
 
 	device = vfio_pci_device_alloc(bdf, iommu);
 
-	if (iommu->mode->container_path)
+	if (iommu->mode->container_path) {
+		VFIO_ASSERT_EQ(device_fd, -1);
 		vfio_pci_container_setup(device, bdf, NULL);
-	else
-		vfio_pci_iommufd_setup(device, bdf, NULL);
+	} else {
+		vfio_pci_iommufd_setup(device, bdf, device_fd, NULL);
+	}
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -457,6 +465,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	return device;
 }
 
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+{
+	return __vfio_pci_device_init(bdf, iommu, /*device_fd=*/-1);
+}
+
 void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
-- 
2.55.0.795.g602f6c329a-goog

