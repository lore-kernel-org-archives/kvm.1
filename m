Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A04C0411
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016533; cv=none; b=WE9hWdrrw8LQsEEISvSdBesx7ye9lPhtLat6l4dWCzv5CBnkFFh/LaAEyodzIOqueSgx7UD65we9z4WUsnWJlEglKbLPRCtiY8/9b4gpNiiNRQE0I35PKnD3FdcYvG4sUm7t1AVFCegY+SIrT7g0RC0bvLzqqwgotWF0s05726Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016533; c=relaxed/simple;
	bh=nWWEHlDRK/55H9sc+sSWQt7sjQhogZRCW4tUvpUazfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9afC06rMQOA2wKBHnCUaQQZAdEp14wS2LdBQAuV7uhbRbFcIT1/OYOX91JcpOx+Be9LxYTACniGsA3C56/5K9jjS2bhob1TOJSfBn8hAQHufE9HmvpdiXNrOUyWb7WtUyLRXgGFFH/fS3Kz20jW1LpiMP7C51x4M9mYB14i4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qv20H/vi; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv20H/vi"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-69996a2944dso1647206eaf.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016527; x=1778621327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycq5rNhvfEuPJ4FnDxTrIkEq4BYeEOANTDKltW6JNU=;
        b=Qv20H/vi6NRYLSvG3zZ68HbU/vT2RLQwmMRdI6IOq+X4H3RPA/A/RXWTobKsYynOkc
         Zq+rc9QLjBQhXRITjomonq/veysMV0t4gKPUfLKd8vhU2BHObRwTF+IjDclIzNK82bKM
         d3Gnb9Os0mA/XGqdFJVPmpqXmvJA61sxd9FX9vJtd+Qi32otZDJITphP1rp8T2UvV562
         BcdtgrUktPdwdq4EHQAP8oTPhSJtk/QrwUVmnzNnpmfanX6PPTvTYnjAs87UisUyhO4v
         n+kfKSsZ30m3qFURIDcLQGZHipzqp3vK1hHo1yzt3WvIqbvwm/CAWMQ8vrSSQB9VNGMn
         HN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016527; x=1778621327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycq5rNhvfEuPJ4FnDxTrIkEq4BYeEOANTDKltW6JNU=;
        b=AZanPl1BQprHAbf1oEjgfT2Riodo3OzRCftk/KQQDt+1J+HYvH24eGBS0osi79MPGT
         IJi0qjgRZWSmyHnqlnQRoQe/DiLJEIvp4VRKS1HxbPSVYtRjC8KVgdGbTVF4fbmXYuzl
         FNIp2M7Q7cMEx9WyfpM7AkXvPAqLlm7nXguoKrdLS7TRrRWKKn3lYdBrPXMw32sdQRKE
         GwhtU9cSHqtvvuDhOME+ORjeho3kF0VwgtCjiZGrYgSOZgPS2VFr/o4MiO7RWUceUaMb
         BRVOqidJHFuwGIbmUT6xTNGVfddy/xljxgD2WFeDhFphlaY/XTj5C27yU61TJlrePKs/
         Scxg==
X-Forwarded-Encrypted: i=1; AFNElJ/mNdE4dP2hTG+F39A07dA4w7sZYDbC6P1bhYPQgF5gmyhjr2xpBi1gTW8FZss6MhQRZnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GhtzGjScQYhmeOJGDNxzvVNuSeZTqWqIg3m5OBejRQYD9zpi
	+B1EhoTK4ILKvMxOP8IV2wc14P2FScDmAcmdEv2J5WCPP32v2Zxz0q25KZfVg2MsbST9Wb+osIH
	zGyjxYMSTuA==
X-Received: from ilbdz7-n1.prod.google.com ([2002:a05:6e02:4407:10b0:4f9:ee58:8f69])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:81e:b0:696:7f04:eca2
 with SMTP id 006d021491bc7-69998c90567mr355495eaf.9.1778016527078; Tue, 05
 May 2026 14:28:47 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:37 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-8-rananta@google.com>
Subject: [PATCH v8 7/8] vfio: selftests: Add helpers to alloc/free vfio_pci_device
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper, vfio_pci_device_alloc(), to allocate 'struct
vfio_pci_device'. The subsequent test patch will utilize this
to get the struct with very minimal initialization done.
Internally, let vfio_pci_device_init() also make use of this
function and later do the full initialization.

Symmetrically, add a free variant, vfio_pci_device_free(),
to be used in a similar fashion.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c       | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 4ebdc00e20fca..3eabead717bbd 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,8 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
+void vfio_pci_device_free(struct vfio_pci_device *device);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 6b855fbcb4a22..94dc5fcecbeb6 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -421,7 +421,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
@@ -432,6 +432,20 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	device->iommu = iommu;
 	device->bdf = bdf;
 
+	return device;
+}
+
+void vfio_pci_device_free(struct vfio_pci_device *device)
+{
+	free(device);
+}
+
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+{
+	struct vfio_pci_device *device;
+
+	device = vfio_pci_device_alloc(bdf, iommu);
+
 	if (iommu->mode->container_path)
 		vfio_pci_container_setup(device, bdf, NULL);
 	else
@@ -464,5 +478,5 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 	if (device->group_fd)
 		VFIO_ASSERT_EQ(close(device->group_fd), 0);
 
-	free(device);
+	vfio_pci_device_free(device);
 }
-- 
2.54.0.545.g6539524ca2-goog

