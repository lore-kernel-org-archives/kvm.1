Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011834;
	b=AJ3M7nVlm0pljVfqHOHm0CPRXrSYqL9Hm3d+mh+esfqqj5UNbqD97YJDR8BNCKKI4HMh
	 8BfuflYnVFztlk7YzcZQp3und+3gahnSNpDQ705Dnli4Zwl0/0MAF02BKpE0pNsX+Sq7q
	 TELffj8pOz35kkU/YPxq5NI9ObKACXYz1TuAXwbd4vxh4biOxNqP6Ug0sLxXph31BQKEu
	 EUyTD1O01Xpan8JFGb1nQczrDF2NMI9iZyo8k3/SsGcvx5mzCwpt+9liMB8/LIkDiCNuw
	 uDa78v1E+S2k+ENzqQMN3ndnAH5pGhN25H2AR1dM085wdQIdLv50NI5n+q97JnRCifg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011834;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wc3ZDddF/SoKim6dDvu+EZKuiq91csySlG+i1DCw1cw=;
	b=tPlFy9CzzxdnO5RTaZXe52g+r64/WEIzXjtZZGqZYHW6AlLZXaJiNCX22xU0iyA8SYen
	 DjdPI6pkwCm0nu6wKHwtMGWcSEwP/rMrGgbX6Rwaoekb2X3ozntuxR1isytrL2lXD7AQe
	 J3+Hf2Er0KM0whrJwAdodKw8I0MbaAtBx1SCycuN1Y6DeXWWIS7wkx2VKtJTofk8VHvUc
	 j22uacgnYr3Ybeh2R05ba/5jnAg/KxtMwIi0FLg+vvqB+uA3r38S77d3RyNK8tL1MJ9Z1
	 12dIb0UsFbU0dbEkWArjHZBIHuRd9/GEzjuMG02Gf5KkJGNv+g5rq2i/r7nL9zOAeHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox45Wigg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234A60A6F54;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox45Wigg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011834;
	b=Zz5OI4UnS+Im9SbNjVgMQn2QG+mBRPyYISR4/XjNlKx9lz9I4vSHxpk7SRQjaz7IKEVf
	 x7XFcCe+NBA6E310meVaDkT82KGXrm6r57CvpEOzzW/60EqLWx/9/fixN0+PFJm/rf9jr
	 W8Z2ov8uLwpRltTNsewGKF9QGB51D/YULNlWxPnuAvT64dlVHebql5W05YZUlsFh1jdzr
	 ni46Y+jdhpNX1Ftk5kOMOmB+KPGt03f+hY1UHUHl9c9qsygjbfdi3Fs9wszFg1l7Nrh/6
	 lvhbDvMXwUmwyjcggOkSkgPq3mpaxVGjtK6mM1pvzoBV0fNTxRIunlfmN11Ce8znZEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011834;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wc3ZDddF/SoKim6dDvu+EZKuiq91csySlG+i1DCw1cw=;
	b=C8L5m0dXh0hoCyNkRT2rH1tCEvDcjR+CcvXmbyouKO50T9kNSzU2lm5RLwG9jF2ddCwb
	 61WqQw1W5HMvvBluTSJ101Ryw9iFqLRhiliRLFotgMFyvF/qYpcpzrT1Emub3FZTCRhxP
	 TfUQS+zknYSoE0JZBXZvt4PLVu21q/NwHy9YdwK42BKIRzbnG8JHmX7JHbP8UbS83r+wp
	 tibf5RqPeb5zR1p2lV+oM+qnkX734Re7HKFbH9yfTcSwZJwVLP6+JdcROpMTb4lACQeh6
	 mJy3g8cIbdcb1Ew3Ep+/w5TOntomgJo88zfeyOpCgJcyE4zo+7D9ODnNw+ofCInzofg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 821CD1F00931;
	Sat,  7 Nov 2026 00:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011834;
	bh=Wc3ZDddF/SoKim6dDvu+EZKuiq91csySlG+i1DCw1cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ox45Wigg0rP/vYFLncB75Hq5AYXzucWZcIsHNiwt8ekt/v7HmVTnfF3LXVUH5R3g0
	 7F5zfz52rR9w28s8JAfi7vEZGVDUbVWSpryFcFsMV9bzniDKrJyboMv+gCE1M6fVfn
	 iOfqoTi+MCVS/tsxLb0FsaMVhsEwbA/VDEv/jyRnzkvgCFE2jMRMDsXsXeA7/2peWb
	 bcqfKNGvBjt1qC+DF0E7zj0KbNRL26/4FYBOgPQ97x00Wdze/+zUHwRNc8IGSAOB4Y
	 nVihah4Qq2K/aZKDvJXmByQv08cS3uaxTA4SJLCDeQaNLI81b8/Q9V+uA44E30kIf1
	 316D0DlA4nW0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D5AC9479F4;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:32 -0800
Subject: [PATCH RFC v3 58/88] vfio/pci: Implement attach and release
 provider ops for guest_memfd
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-58-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=4120;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=BlUGE6K++nDiJr8qPUVvPATO+O8fe24pYgQMxNdL00c=;
 b=NgSlL+6BQDukoZMQwJMCQVxrx2tW2tfdtYAwt2Mqe6zuF4vrIrK51yN6n7vJ+9KVephyFm5Wd
 nI/Gwn7eHXYBu4/2kJhD2xUzUg8WGqxthiF+W0hHlwEEnmJsIIb2avw
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement guest_memfd provider operations in the generic PCI VFIO bus
driver to support attaching VFIO PCI devices to guest_memfd.

In the attachment path, acquire the device memory lock for write to
initialize the BAR availability flag according to whether PCI memory
decoding is active and runtime power management is not engaged. BAR
resources are already mapped and reserved during device open at bind
time.

In the release path, acquire the device memory lock for write and mark
BARs unavailable.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/pci/vfio_pci.c      |  4 ++++
 drivers/vfio/pci/vfio_pci_core.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  5 +++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 3dc232ee65491..96f438671db29 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -168,6 +168,10 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
 	.pasid_attach_ioas	= vfio_iommufd_physical_pasid_attach_ioas,
 	.pasid_detach_ioas	= vfio_iommufd_physical_pasid_detach_ioas,
+#ifdef CONFIG_KVM_GUEST_MEMFD
+	.gmem_attach	= vfio_pci_core_gmem_attach,
+	.gmem_release	= vfio_pci_core_gmem_release,
+#endif
 };
 
 static const struct vfio_pci_device_ops vfio_pci_dev_ops = {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 907e6ab024acd..c7b67fbce4cae 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
+#include <linux/guest_memfd.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
@@ -2696,6 +2697,42 @@ static int __init vfio_pci_core_init(void)
 	return vfio_pci_init_perm_bits();
 }
 
+#ifdef CONFIG_KVM_GUEST_MEMFD
+int vfio_pci_core_gmem_attach(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	bool bars_available;
+
+	down_write(&vdev->memory_lock);
+
+	bars_available = __vfio_pci_memory_enabled(vdev) &&
+			 !vdev->pm_runtime_engaged;
+
+	/* Pairs with smp_load_acquire() in provider operations */
+	smp_store_release(&vdev->bars_available, bars_available);
+
+	up_write(&vdev->memory_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_attach);
+
+void vfio_pci_core_gmem_release(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	down_write(&vdev->memory_lock);
+
+	/* Pairs with smp_load_acquire() in provider operations */
+	smp_store_release(&vdev->bars_available, false);
+
+	up_write(&vdev->memory_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_gmem_release);
+#endif
+
 module_init(vfio_pci_core_init);
 module_exit(vfio_pci_core_cleanup);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1053774d2d659..c3c16459e14f4 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,6 +149,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	bool			bars_available;
 };
 
 enum vfio_pci_io_width {
@@ -168,6 +169,10 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
+#ifdef CONFIG_KVM_GUEST_MEMFD
+int vfio_pci_core_gmem_attach(struct vfio_device *core_vdev);
+void vfio_pci_core_gmem_release(struct vfio_device *core_vdev);
+#endif
 extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);

-- 
2.56.0.455.g6c5a503b38-goog


