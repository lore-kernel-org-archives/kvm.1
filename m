Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3683F7A8F
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151073; cv=none; b=uav2TSpBby5IWHqsITCxSrdW6ZsSIWro7L0IpfLbwwZHudBKBWG/xh8ZJeDQhqkirTqUIThfcBfqf1ooEPQmLkylwXCHrtqudIfCxAvsz3lbcTN14DZ/T2jS7xoZ8RbffDKBDlwjKGeypoqBO+P5mGkecZMDOxznXBuWHeRHqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151073; c=relaxed/simple;
	bh=JvspclGG//MbGhKd05tl7x7zTJzEXGzkxs42ikNGdSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vGtSNY+EWAeNmG5MF1dsAKSEjw6/6PRewX69cFNwpODSRMovWQgfPyrts3KGmhQIMqYOoHor3XpA9z7aD20LcHlYmIr6Wltu97LFqToyU5bfJPto4q/rv8euOYqor79kIrs48ElUxU1Ct/MAMAIx2EQuw76gRS7jOLuT7wcfjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVkeId73; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVkeId73"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-466ef11c4baso2361150b6e.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151070; x=1775755870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ib/Tb14sQxCq5zPTYDnrbZcYfKDUfA5Bwx4aPAdsY=;
        b=pVkeId733giV/Nw5L7Dr7mSYkf44MQZNPkRhy62qN9uFF49rjDop/hwp34eWjQn88j
         +pi0/GQVbDa8GJBCtbnw3hAKTEJxELtMk2TU95K+X8d/s+K82OFSN44jXgNIOOAb1zI1
         6uAbzn5vOrAXn3KCu8YXdWRik5WPuhouZvh9u96EGrMiLoPqKkCFZ/ISi1MhUkx2Iic8
         AIpVhOLKQv3MJILFGfd4/g61JumfJVcLw0WfcjKaSQleLCBpTaqhjKWPCrWSM3kh/MkC
         y4q5ymI1el2w1NZUmVuEz5jM4I+Avp+6Ioe9MrMooDQHLTpLe1gJfqhF4aq5ST0nSRMa
         Y2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151070; x=1775755870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ib/Tb14sQxCq5zPTYDnrbZcYfKDUfA5Bwx4aPAdsY=;
        b=TofTPE+jCppzU5EKs5hQUwiHwhoGEgQ9W0Q+Rzzeo2dGf2d+ymy5fDI7YN2FyzTfA/
         YqceMayW0936k07w30SM5c2dB6g72W14cNuMlmAn2pWQpJ2z23609OfFSURlNTw1tLEi
         odfdhA9veL1BFu2GVWQ7RFA98UjwbcoUkLge7/x3cO6+J7kgqtI30NvkNMzUvT+aVSu2
         4vLDY6/hQFY19vg5YZ2ovsfZ7ES8DWI+0En3B8GAqVHgCybr59jY/XjMy35M2LXD0xDz
         lhjWazuuPVrIYwkSL0KtskliUEOXmcp6qHxzgX5u3mra0f0tVDLkvMN9005nQFSqAnkX
         lYfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/j9kuMx7SMJOqCkl3XB93YrtChCJ4GwOidcokJobD/XXHe4mln3PtppdQU/NHVSsBXek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwviVR4DxFu82/2XFfFcRPB7BjqqDkRzS8rq6LNRTqDtq+FWRZo
	tJlPh+KAC2dQPJwL29uf9L6yw288KZGYxdOIp3GbTPsg4xbd68q78BTOgjNFAsxYfU9s93L/Erg
	j1DIP7f3vag==
X-Received: from ilqu13.prod.google.com ([2002:a92:cccd:0:b0:4f8:aea6:eab7])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a54:4e82:0:b0:464:82c5:567c
 with SMTP id 5614622812f47-46ef8314beemr88833b6e.41.1775151070223; Thu, 02
 Apr 2026 10:31:10 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:58 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-8-rananta@google.com>
Subject: [PATCH v7 7/8] vfio: selftests: Add helpers to alloc/free vfio_pci_device
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
index 4673b148f8c44..4ff76970e3791 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -419,7 +419,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
@@ -430,6 +430,20 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
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
@@ -462,5 +476,5 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 	if (device->group_fd)
 		VFIO_ASSERT_EQ(close(device->group_fd), 0);
 
-	free(device);
+	vfio_pci_device_free(device);
 }
-- 
2.53.0.1213.gd9a14994de-goog

