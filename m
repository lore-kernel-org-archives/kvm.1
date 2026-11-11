Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425064;
	b=Xenr5A7sQHlAJpZo5tg9Ab94nB+fgYXtvT5v3VM1cSvjsniYqjsm7cBps6J1DF7+KmUa
	 4xlVeJC6u8tGEFpM74m6jlOBQrA1WjGH7HXlPu5q38WOdsQpfxudsBAT95JXrmEOFf4sR
	 nTH2sVE3wRkBo7E2fGlER/hDE4rfMo4aVqOVelo6/3idD89i5zsaYmBWRNdBfEem7rnCm
	 FJJIAR9EtOY/ufo4aZeyuc+kun6Vd/ewKjQPvL71KQRNDumMIw0cB06UrM9srZoFtn9nR
	 yLxB5bQFaqWXZwSlnBGqYnmnNqUJv4czi/uZys7+rBwJE7ck31L9nJMb3iEvqHLA7aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
	b=c+O8CGSNp6OyEJsdlMizcRmkmdMuqmmDO4pkhs1Wx4YDfOjBihejosxw9tnGfD3GVuS2
	 9MaMBst6bmGDjfZ2GesjbRX7LE02ySUaQVRVpObLxaDHb3HqypoqPjGwAAo5EW9zTedMW
	 xL3FgQ8ox/3w0cQG5plFdLq+Gq91YvVtmEU8dwc8tllf22CFrFQ262XpGFKq8/UBhACFX
	 itTc1OUfR10Je8OVb1ubhpSyS8FeOUOA4nrq8v4xgj6D8KsHUPcfCjT2c9XH3IVb+mOhw
	 3tQ/nxGEtjf7cpkoEZxvndzKpolJ/UX/5o8x0Oh5GQcbJP0cYys8l7UdMyu+tlvxlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lM/CPmgi";
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF960A380A
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AF960A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lM/CPmgi
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ea2c058e67so3962078b6e.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425063; x=1795029863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=lM/CPmgi2MxnhCIljbY1J6j5HJCMMekv0//LIx4rqPP+rmTASzEwn/BZTlI+Fvfwof
         f5lzQB0rVXFPhPx5zlOmCXnEZsPPgqwyajdOHm2HucaXGcohS4WqmpNnnr0r28fxAkpE
         lg/UcKD+gr2bXmw6OtsYfNTumii+2oGuZptwjhXEy2C8uOHAWNG0YYDFtvZLbBscAarT
         KRjZxsb4x9C8/ukL2U6mxnyYxFXQQR0ZKVLlW4ebshXJs56UjXEXgV5bCqzi520CgmbZ
         ytScVeEa8/BkQ5DOx6FUZPGNcU6+g53Tsl0ljpXVfOyoViGc3s7rFDA5dCAACnp88HpA
         e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425063; x=1795029863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
        b=tRBQGm0G0undKluslmogn/nfD466stC1kKaL3A63tqNDM/aQXWK85BHOp0BNiDZb4Y
         4mNYDV+bkgRIvmdVY+0mNiZv/TvFHpShHa2y+fmI9oX+bNKy/uZy/espNUK0p/+1Qgiu
         AP9mpxwemydBxTA+HxIWwn+kzgNCOO82Ddyk+MHfa9GBzFIZPitUhLSqt/tNj5ff0X1u
         XOjuawETGK714z1sWJQCt7VL/EtLOzPbbARMQ91uT412R3c9iPxkIvl5bt8dXVkx7LDj
         2X3IUyYNrxZJ7lHgdi3G5/UKwfXtW371fvZIznB6qYoz6yXfdXOBa/tYrL4+Z8Vh7rfo
         9tMQ==
X-Forwarded-Encrypted: i=1; AL+hErHHGsoD3lzxw16fCz6EYUUvDOYkVsdLYMbx4i28DFpZxnh4uzhJPGPsbddUfkmwaFUvuZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qH9SQGTVHCR3QRVkD8DMxRJZTdPjeJ2vrAX0p6cvM/aha++KU
	L1Yc4uALX80KOKr3exSj7gmHUXgKS+0neV/YDmU8pcpTqHfoT4ciCoqVbkX/hhILii+Th7f72V1
	ZKLKBGArQk1MLZA==
X-Received: from jabll4.prod.google.com ([2002:a05:6638:9804:b0:61f:e4cd:8716])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:318a:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-56b96ad0615mr3028788b6e.15.1794425063307;
 Wed, 11 Nov 2026 11:24:23 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:10 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-7-dmatlack@google.com>
Subject: [RFC PATCH 6/7] vfio: selftests: Add vfio_pci_find_p2p_pair() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_find_p2p_pair() to locate an initiator device with memcpy
driver support and a distinct target device with a memory BAR of at
least min_bar_size bytes from an array of VFIO PCI devices.

Factor out vfio_pci_has_p2p_path() as the central place to validate PCI
topology and P2P DMA reachability between the two devices in the future.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  8 ++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index fd130f680a2d..9bda93712859 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -42,6 +42,12 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct vfio_pci_p2p_pair {
+	struct vfio_pci_device *initiator;
+	struct vfio_pci_device *target;
+	struct vfio_pci_mem_bar mem_bar;
+};
+
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
@@ -171,6 +177,8 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair);
 
 int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
 			     u64 offset, u64 length, u32 open_flags);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eca6eb13d7f0..16fc98ed170b 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -378,6 +378,54 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 	return false;
 }
 
+static bool vfio_pci_has_p2p_path(struct vfio_pci_device *initiator,
+				  struct vfio_pci_device *target)
+{
+	/*
+	 * TODO: Check PCI topology / ACS / host bridge support to verify that
+	 * P2P DMA transactions from @initiator can reach @target.
+	 */
+	return initiator != target;
+}
+
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair)
+{
+	struct vfio_pci_mem_bar mem_bar;
+	int i, j;
+
+	for (i = 0; i < nr_devices; i++) {
+		struct vfio_pci_device *initiator = devices[i];
+		const struct vfio_pci_driver_ops *ops = initiator->driver.ops;
+
+		if (!ops || !ops->memcpy_start || !ops->memcpy_wait)
+			continue;
+
+		for (j = 0; j < nr_devices; j++) {
+			struct vfio_pci_device *target = devices[j];
+
+			if (i == j)
+				continue;
+
+			if (!vfio_pci_has_p2p_path(initiator, target))
+				continue;
+
+			if (!vfio_pci_find_mem_bar(target, min_bar_size,
+						   &mem_bar))
+				continue;
+
+			*pair = (struct vfio_pci_p2p_pair){
+				.initiator = initiator,
+				.target = target,
+				.mem_bar = mem_bar,
+			};
+			return true;
+		}
+	}
+
+	return false;
+}
+
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data)
 {
-- 
2.56.0.567.gdb80ae8cd5-goog

