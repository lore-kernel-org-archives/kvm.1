Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9184279FE
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104747; cv=none; b=F04DzM1DsAslrdvAmkZuPTq3YSS/8LRg1aLeEdFiUz6JG5MNsKjxTl7hshKS89UeitCRse2TMdHhy9bJugSaWrfhr5ph/u41f44pSXSJFerZ5qYVi5eNAKgaCKT2/vEO/stklYrDEetCtRiMB5YCbNsYRl/1eMU0j4FJaMaNQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104747; c=relaxed/simple;
	bh=7eNNpz2/EvHwN4iCpEZbHq3RFKqYSTx5ggdH137Fo0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwYdehBsavpcp+Jxmg5wwRF79imhnVvhWeFX5i6xvzosQjPOZWZygNvsWfkpap9Zn0xTld0EyrN7SQuJFcPV2PJl9G5/BekUccuH6Ywc0KiyCBwJcPNFNiDo4Now0WT8WslAMgtFvmkt7sZSuBu6TgGToN2CNOeIsTyphSP9+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1xdbf77; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1xdbf77"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso4155241a12.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104744; x=1781709544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ISZN5I9MLcMABq6arMUSp7lpAVSf8sE1aC6eUvOgb0=;
        b=o1xdbf77UCxl1mUh36W/AMRD0/H8xO6H3bm9faFiro+TBBvUJJUvfXZoP5c8hIFLiq
         buWu+fMs7urSPn/v/ia2ZNKKHFAq1gRdahrqJgKNGFJR+HeqTSc70XqyV8gTJ29W0RRI
         hvAeG6Js8GiN94rCe/k/qbvlyQSdO6DqSU+cj39NNztPoJPr2xQ6MgdjypqMirIfsDvj
         cxrXqrxu3mCPBpfiOQaEUUhyY5iJWMUc92w2Ck24Fkyqcu1xNo7JNBBTveH4BHyRWMmV
         u5x6gNhZPyf+GghOgy9ddlMsxcV0zMo32xdaRF7XwBhY4OrSdx/WBqK4PXJsnjwbr6FO
         MAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104744; x=1781709544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ISZN5I9MLcMABq6arMUSp7lpAVSf8sE1aC6eUvOgb0=;
        b=pMEh3tSwe1EWBTZI5ftRejhLAn+6cy2/QLQl+C+ROLrJsuzSqAUo9lljVb/55JvuVM
         /2DgAF1rLU0oyYKAiOkFOyXJgSnNr/qP7rXTNqEjO853o9WyCi3R1R6iBrbSTlGOYhVz
         XE9fLmJyunKk8Y1HoNL1uNQBLTv/AhIcnFARTTxbvTshFcD2ZVkLNd2KOwCkJd38yigE
         jVbmc75b6Qtwcdu5eTMrgpegT91MhIsA+rDLEcJw35LQqrjQKx4hS272yoh/C56aVUUt
         yv2/CskNHQ3nD2n2Rz6pU3JFfSQ48bawq5ZehPXqW3Dq/smbzvmQjZ9dfm5RwAcC3WZc
         n80w==
X-Forwarded-Encrypted: i=1; AFNElJ+DDxR+mSjZJYx6uWenzi0Nzg62JiAWbzxs6GOi61dNNux8Q0et/ERe7XTofp1ftuSSeoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJG08KpoTTa61/lTOlqxUIUO8tFY1pIoDzG0F/4IWj9ImCRSB
	cTwpNV1knlUHiYI89eOu32X1WqNSdj8//uLq/3IrkPuM2N3tE3ELYxYRWy5zs/1uxFb3JLyJtnt
	6aw==
X-Received: from plba13.prod.google.com ([2002:a17:903:100d:b0:2bf:106:cced])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b45:b0:2c1:ed61:36ab
 with SMTP id d9443c01a7336-2c1ed613816mr306561405ad.19.1781104744336; Wed, 10
 Jun 2026 08:19:04 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:52 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-5-praan@google.com>
Subject: [RFC PATCH 4/5] vfio/pci: Block ZONE_DEVICE registration for BARs
 with active DMABUFs
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that a PCI BAR cannot be registered for native ZONE_DEVICE P2P
if it is already being used as a source for exported DMABUFs.

Add region_index to struct vfio_pci_dma_buf to track the source BAR.
Introduce a new helper function, vfio_pci_bar_is_dmabuf() to scan the
device's active DMABUF list. When a registration request is received via
VFIO_DEVICE_FEATURE_P2P_REGISTER, VFIO rejects the request with -EBUSY
if any active DMABUF originates from the target BAR.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |  6 ++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c | 16 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9cf494b765e7..7913b8916df9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1579,6 +1579,12 @@ static int vfio_pci_core_feature_p2p_register(struct vfio_pci_core_device *vdev,
 	if (vdev->p2p_registered_bars & (1 << bar_index))
 		return 0;
 
+	if (vfio_pci_bar_is_dmabuf(vdev, bar_index)) {
+		pci_warn(vdev->pdev, "BAR %d has active DMABUFs. Cannot register for P2P.\n",
+			 bar_index);
+		return -EBUSY;
+	}
+
 	ret = pci_p2pdma_add_resource(vdev->pdev, bar_index, 0, 0);
 	if (ret && ret != -EEXIST)
 		return ret;
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 6635a8681291..194d74724422 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -17,6 +17,7 @@ struct vfio_pci_dma_buf {
 	struct phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
+	u32 region_index;
 	struct kref kref;
 	struct completion comp;
 	u8 revoked : 1;
@@ -279,6 +280,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
+	priv->region_index = get_dma_buf.region_index;
 	priv->size = length;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
@@ -410,3 +412,17 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 	}
 	up_write(&vdev->memory_lock);
 }
+
+bool vfio_pci_bar_is_dmabuf(struct vfio_pci_core_device *vdev, int index)
+{
+	struct vfio_pci_dma_buf *priv;
+
+	lockdep_assert_held(&vdev->memory_lock);
+
+	list_for_each_entry(priv, &vdev->dmabufs, dmabufs_elm) {
+		if (priv->region_index == index)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_bar_is_dmabuf);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..0a5da4d5edc4 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -120,6 +120,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
+bool vfio_pci_bar_is_dmabuf(struct vfio_pci_core_device *vdev, int index);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -128,6 +129,11 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+static inline bool vfio_pci_bar_is_dmabuf(struct vfio_pci_core_device *vdev,
+					  int index)
+{
+	return false;
+}
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 {
 }
-- 
2.54.0.1099.g489fc7bff1-goog

