Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633841;
	b=3Ovu4DvMtCEVh7YhvVtJMN/5TbhOMhbKHkdZMoolJ4s4wukARi/aG68fbw747ASi7nKF
	 lVy8X9BeC5p6PJZUoX/j6g0wqay8I+QhnkYmmHozSwkx42oINPwFMVvLh11g9UsJuBEHv
	 pDiW8crdLjcXHdYrflBf13CxGjmJtfhyGY6sMR2cmGhswqGog32SesUx1XY8J2QcYnM5b
	 w7paZKHpvjFzxkL6gs7ae97GQ8/ri/WM0CbxrIIg+j+pI4luAlxU23mi2ylQO6REHRGtW
	 EOCskHTY+YR2hk9eSXbMumNbpZjHe+5RYhWKYOvI7ZNISWW+g4t40ZM3/UVBvj5VX6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HVnfWSj8ZzZvrderQaZLMWS7UwjUc+ra7btm+XE8Eyg=;
	b=U6BCor9vTBD45szsc+rUFXp6j08lgfQUwDPvGUJK+6tX8ETUpOoEJ28nBHJo//KngVvA
	 +a5sEEzgLGZxaR4Eg6gsmo48kC8JnOTInf8oE7pwEKRxvXpvEYLvRMdufDldwSlRnkjPH
	 BLMPSQztx9DpfwJ9gK7tP2RVDufa1Arn2HPRFRBTqRJdkklgDLHDrfBvQ6yOLpJX8ucBS
	 yPQxMrgCPOfYdBfDtvvvMfFkPGQi2/9k4qkHtFqI4zqeBbwqih/ljyWyCLVUypOl5pGLg
	 VnfdUIYebDHdVeIPPQYpZcK+KaM7WcPXaakj0OXlb7oGUC5KYV96U38xf2bp4Ylh+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YuNUml4z;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03A606BA57
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A03A606BA57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YuNUml4z
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so2145606a91.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633839; x=1794238639; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVnfWSj8ZzZvrderQaZLMWS7UwjUc+ra7btm+XE8Eyg=;
        b=YuNUml4zH5ZHRF+F04Y7wZI2Du7rDKxyBW+kJiSWbxaOMaxfx2YJgwtnteKndFaeMU
         98s6w51k5AYecfjYWhc3MYYHhUtImK75pts8pb+0GFwvFi7w0vtp9tj1PZmkGZsV84gJ
         xPCJPb4d3wfZIT4to5hUUq9Ao2dMaNm77qyY/QVJWg7pFYQ7A/yDVdNKewYByOOnTmhL
         t6zR/lVN3HCZ8Incyv+jQRM9rZdS/VIMvk8nWsYXE51hvqRk+W0ZvCwFPcmUuoMMAiNd
         0YrrXkQ+z9u3VqHi+8vh4p49Wncxt6fL/niRcmmRcPZMou2OxoCHoSmc018ApFcTj0RM
         vI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633839; x=1794238639;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVnfWSj8ZzZvrderQaZLMWS7UwjUc+ra7btm+XE8Eyg=;
        b=VHmJcPzWI4PBFnRoOGRhO7KNaGI1qdoTWhHkoKiguImSclZA14JjlSOV0jANAbRslB
         HQTpjOklm/yCR4px/yAudJ8ZdqN9G/Bm20+gXULDJOmeQOLhV9TodCbyViQXwix1RLHK
         gbb9Ye+KcsfSwWSLP18ykwqwsJhwzD6d1EdKrLf6WXpSvS4MaJYQ6pe9h2aiQhcidYFX
         Hfv/P8DU1oiZHkFkf+aGtvX0bCl/vrE/33pwiq5JqY9x4j0wumWHADveFyUMG0TwMRz1
         R2p9Y+GSDcRYqLbltOXbMiPcGsNUsXZtAGfYzbF51/+d754tpEkwXwW6py47BtazIuXl
         0LpA==
X-Forwarded-Encrypted: i=1; AKwUvBwUM+3dM/w3DOJNmfXnVNYTvkbn8AlG6FZnNv/C6oQIjV1EIV8NcMyz3A8+IfiixeJIfBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gfC9uUmxrUut3XBVEwQmEVVfU4VzPiJKRM2HyorJTWMIZBFy1
	5EzIsvLoIhAY9ycDPjGRratz9YT3Woh+0JGbqjbXGYCdfEXJW1k8GbDyAUVBlPkDUIsIVjpPAP1
	fymOZ+1GywQ==
X-Received: from pjat8.prod.google.com ([2002:a17:90a:d08:b0:3ac:3195:12b4])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5870:b0:3ad:6090:a189
 with SMTP id 98e67ed59e1d1-3ae8983e2f3mr7697277a91.45.1793633839167; Mon, 02
 Nov 2026 07:37:19 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:47 -0800
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
Message-ID: <20261102153656.1431701-19-vipinsh@google.com>
Subject: [PATCH v6 18/27] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
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
index e19bd94b8dd2..9a62bfb6b440 100644
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
index 4063a0e2b3df..af789c859586 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -457,9 +457,13 @@ void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
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
@@ -482,16 +486,20 @@ void vfio_pci_device_free(struct vfio_pci_device *device)
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
@@ -499,6 +507,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
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
2.56.0.317.g454f8302e1-goog

