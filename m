Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD264BA9F8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052419; cv=none; b=Vo0aSH1kjG6jKdOXdKAk4ffB4p18kO+ZxQ8hXMChfJuktsbP0ChHnuWGsUxoZlyibHLi98sePkm5v26RDgxMm1Pu5WP0TNQscGf/uYiLvnV4ybp5bM/xynr0Vcj8vAtzGirV2yh51kJzSbR9aZ5nK8dD2cYVZin9LxGSUYrqdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052419; c=relaxed/simple;
	bh=qDKOJFD5O0yGfj6OQWmcK5ZqqsZPXy8lBN3o3xrmKik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb3xjRVlJr/EmV/e3XHaenE54kB8FdOZ1FP4IN4wrQkQcQcN8Rx+tfd5e3+NQE/rwxbkfH+IQUGMos7DJQA2DhUoxBu7+zpBeXqP7LOU3NUVku1LAi04CpXgJWtLXqdDvoSxr0IUCouE79RRbR4bf9xRStacYlxxVLXBH+HJzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHNVcfLa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHNVcfLa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ff680331aso19335175e9.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792052416; x=1792657216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVeDY3+0BdViKhSzi1t1ljxDn9zxHbrg3FVtH9WKAx8=;
        b=OHNVcfLaAVjhBuAKxImvGRz7bXzRjbBTEZmit33wcYkt1Y84wv3HSljjlSGXvaQ30d
         VyVkMryOKZ8sFumKqs0P+7d+7+A8ijLGekWQ4ck+TDN5pPeD5duDcPvYFAH+cs8VcpO4
         oMWz7ahdNQon9Tn7N6Fjt/BjvLlZ6KDFJilNRjlIfE435lnOuCBrwjDrfkT1qN/5mfNN
         j/Uesg/f4xzFVfmo3UHAR34gzlKEWI1sYnlH7a0myeYn3jpEVkL9t4yf7OePgX8kDQwL
         dVBu19z4taI/jVQLaKdXNeuc1kAsRrFMz4Ns0gDC1JQbr4lMInq+WPDnMkEY70StB7S6
         gZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052416; x=1792657216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVeDY3+0BdViKhSzi1t1ljxDn9zxHbrg3FVtH9WKAx8=;
        b=xQoLobrYu4p0yC+uh1o2Aqp7tQ/xkMuwR0R3PUwwTHFAhm1+WEjCCDokm5De+ncNuy
         04W3IPR+62JH/bLsaHsKxTa1TLxesY2CFtOvdK6k/COJ56Nd736tVb/N4XksU/2/JNLQ
         pifgDPZCV8vWaLpjgtWZk1dEzUBQkHXzTfSUwVye73+yK4njDFuKWY3h0/bNyf5nvnK+
         Rh/YuI4skhvhjcwgV7Pl0vDCtBO1rZ3s7ILSGAY58kiVa0IHSOotCSO0X+4TEcaiF7cw
         Nb/q1PCUhkyubtI+d+7jBkFuT6yqxzGBug4hel3gVtZzwP8P9EGbvV6l7k/23SaOakHf
         w8SA==
X-Forwarded-Encrypted: i=1; AKwUvBw6czJuo7g+FP3R1ESKuWFJLWFiQi8ntmRcD/GdnzonWq+qhf2Th/k42qDzIT/8CsiMa0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZtNm+C8lUkW0X0Ej2oAsfIJkquEXnV2NT8V8ogkkUHc6l3clT
	UKomFE2h39RbSiUFWDTkxgeN3sRbkzglZChfiKki0nVlcJc7q7YalUU1
X-Gm-Gg: AYBFou3CT6XwpbrpsnysCiTpXMtg4YUGnNf4eqMaX2SHdwymedJ/UdxDtkB9DSqZ8Od
	GKFhNWDPxW+yndfUbbyXeJbWYbYVF+rPxLdufKRRl2WBxNsB+scnGAoNHmgrqcNH3XAMvOuwsGm
	s0IkkgyA5rkkJUZyrXcqIQj0fmXpvGFOwP1kKipDXVey+WDG+D9M6KRhWG4oyKxN+NpFLJxjxg4
	3qWMIZQ4pb8d1kDSg6LyYqGkWuzxKG9TnoeVteU/K7fPPc1BRHgvi0o5ibWrMOOUe77QeeHPniw
	EwdKHIhKQHtlfAMMrrgVFTkU2g5Mhw5vhqjFjQaniG64skCGXY13J1hfddd27k1pUNFs0WwUlpL
	YTYrbDgy764aKJm0Vhaehuk5QzrktwR5oJuu0CI/kvRfVzO9P0Z0ZLQkSmwqqfb3x+4QSQkIrP+
	Z2m5G2PJzrzpOUhmfP79lYS8GLSkhle9NS7IhLBFaVdUlCmAGx3rEMHyGeqdJdz40dIDEBAIhC3
	2wrQrffimBUYv+ITH7IEED33IWSs74iKlaeDHy1zh26+Q==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4a18e47a844mr384308475e9.9.1792052415154;
        Thu, 15 Oct 2026 01:20:15 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm49003545e9.6.2026.10.15.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:20:14 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] vfio/nvgrace-gpu: Use a core-only open_device in fallback mode
Date: Thu, 15 Oct 2026 10:19:34 +0200
Message-ID: <20261015081937.405320-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015081937.405320-1-parri.andrea@gmail.com>
References: <20261015081937.405320-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ACPI memory properties are missing or the C2C link is down, the
device is exposed through nvgrace_gpu_pci_core_ops.  That table opens
through nvgrace_gpu_open_device() but closes through
vfio_pci_core_close_device(), so open and close are not symmetric.

nvgrace_gpu_open_device() registers nvdev->usemem for poison handling
unconditionally.  In fallback mode usemem.memlength is zero, and
register_pfn_address_space() inserts a node covering [0, ULONG_MAX].
Nothing removes it: a second open fails with -EBUSY, and once the device
is unbound the node outlives the nvdev that contains it.  The next open
after a rebind reports:

  BUG: KASAN: slab-use-after-free in interval_tree_iter_first+0x209/0x310
  Read of size 8 at addr ffff88800894aa30 by task nvgrace_repro/203
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   print_report+0x153/0x4c6
   kasan_report+0xe4/0x1a0
   interval_tree_iter_first+0x209/0x310
   register_pfn_address_space+0x97/0x100
   nvgrace_gpu_open_device+0x21c/0x730
   vfio_df_open+0x213/0x520
   vfio_df_ioctl_bind_iommufd+0x3e8/0x6e0
   vfio_device_fops_unl_ioctl+0x782/0x1570
   __x64_sys_ioctl+0x13c/0x1c0
   do_syscall_64+0x106/0x630
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 188:
   ...
   _vfio_alloc_device+0x3a/0x500
   nvgrace_gpu_probe+0xcb/0x660
   local_pci_probe+0xcf/0x170
   ...

  Freed by task 188:
   ...
   kfree+0x20d/0x600
   device_release+0xcf/0x250
   kobject_put+0x152/0x2f0
   pci_device_remove+0xb0/0x1c0
   device_release_driver_internal+0x38d/0x540
   unbind_store+0xde/0x100
   ...

Give the fallback table its own open_device that only calls
vfio_pci_core_enable() and vfio_pci_core_finish_enable(), the
counterpart of vfio_pci_core_close_device().  Fallback mode then never
touches the nvgrace memory regions, as Alex suggested.

This should be safe because the fallback table uses the vfio-pci core
read, write and mmap handlers, so nothing there uses the state
nvgrace_gpu_open_device() sets up.  The one visible difference is that a
fallback open no longer fails when BAR0 cannot be mapped, which matches
vfio-pci.

Fixes: e5f19b619fa0 ("vfio/nvgrace-gpu: register device memory for poison handling")
Cc: stable@vger.kernel.org
Suggested-by: Alex Williamson <alex@shazbot.org>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2: Replace the usemem.memlength guards with a core-only open_device
    for the fallback table (Alex)
    Ankit confirmed fallback mode does not need the BAR0 check:
    https://lore.kernel.org/r/SAWPR12MB99926787B53C4FF469A6F3BE7AB09D2@SAWPR12MB999267.namprd12.prod.outlook.com/
v1: https://lore.kernel.org/r/20260925161024.189771-1-parri.andrea@gmail.com/

 drivers/vfio/pci/nvgrace-gpu/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 963fd8ded20d1..208463c218088 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -1083,6 +1083,21 @@ static const struct vfio_device_ops nvgrace_gpu_pci_ops = {
 	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
 };
 
+static int nvgrace_gpu_core_open_device(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	int ret;
+
+	ret = vfio_pci_core_enable(vdev);
+	if (ret)
+		return ret;
+
+	vfio_pci_core_finish_enable(vdev);
+
+	return 0;
+}
+
 static const struct vfio_pci_device_ops nvgrace_gpu_pci_dev_core_ops = {
 	.get_dmabuf_phys = vfio_pci_core_get_dmabuf_phys,
 };
@@ -1091,7 +1106,7 @@ static const struct vfio_device_ops nvgrace_gpu_pci_core_ops = {
 	.name		= "nvgrace-gpu-vfio-pci-core",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
-	.open_device	= nvgrace_gpu_open_device,
+	.open_device	= nvgrace_gpu_core_open_device,
 	.close_device	= vfio_pci_core_close_device,
 	.ioctl		= vfio_pci_core_ioctl,
 	.get_region_info_caps = vfio_pci_ioctl_get_region_info,
-- 
2.53.0

