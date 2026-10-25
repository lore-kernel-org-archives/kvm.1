Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894798;
	b=nHiVt+QA0C3VJGhxFDynRKQECPVJ9xu1dWCjn0WV8UQ+9N+SO+5oG3PGSHoyxtSpeusD
	 i/Pasb9Z2ZUCQeBu6WSEdS328CxDd8NbUJXYqsOjp1XNy5CLHdVOrUKMuPElzwfi42Xep
	 F3zF6Vjp+Z1zr0/vyodu4TKQuVq3BiEUAEHrlA8nYwZmj6Peh7VTcNvyMG3EO/sn9xNMJ
	 3PeXeIutiLbPN1emrPbGoljWP/wVLLXC5Pd5A6eZRY5+q9sJ0uSB60PtV76f2c8DTbJNC
	 TUJNhMD01nz+ZWx9K170rNvYqNFBfxsOtwdo8n6Xapp6Z9b9tgrB/3KoJdcCDdbCMvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
	b=J04OLq59uk6vE8ZCN37nos/8atYEUuR3331yBWl6Z2CUmwv55rd0mQ2cM8EBseTC+n16
	 odnaMFh37ur3QN+stPYZN/Hp+us+9TykSoKHUPh7acgHrlxXCfGRJL9q0dRrhtnQvbGiO
	 HUYWy1ZqCshV2moEOmT7bQiHSqYncW+h8WGBAkmxZ4i65YNJ7bnLi4/zE8+lb5Ro4GhhI
	 y7mnKYQdAxnWlVYZBx8eAoVIcrv2HbkfXsPa2QiUf8VEJG7H6BVQO86vQlBaeBgOi2JGU
	 nP4lcb35jYjT13y39mq3CrkRJLC/K7Bm4PxDeK9N/JulektKRFCsLfad4yAAdbAxSBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MOGUHLmL;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD262606E681
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 02:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD262606E681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MOGUHLmL
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05bfa6af5so1373779b3a.2
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894797; x=1793499597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
        b=MOGUHLmLUnPwN3tRm/1O5vwpl5r9335IPWecnBCHBk0mRCDH2OhFylvP6lex7dlvSy
         6ANqgE9lSFrwPk7S2kcJX58MOEaORsPOylprkuBeJKXvm65ABB3KV0q0/8donZ/qEPMi
         ccIaX9TnOByGOfdkjzyRR3cAX06LJMY+GrnuqplD8aESyQL7OK5qSwlz8XrPidTp5Ovs
         SWHEhn/tzTqX0k08hyp1988po7qS0t3r+Ziwdq2N20Nkf2WWecom1UdQ02GUHFdLan7/
         NO/T6MnVopeG29Uqs+PTUi/7IvBAl2pbHWOzeQIuOP7CEFpHvvzFbeHahfBVagOvlqAg
         5R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894797; x=1793499597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
        b=OGQuktJ2hNhPQewYYbsRUhI6jQYgAQLbtEHet4IpmE/bngUaVwZe2+tigBK8O307y3
         OyaGb9xxJnL6bA6FO4x/3oTSFX7MoymMnvs10f5Bvzdmj5dcYtJTi3QYMwiClmikX7Ej
         YwP7OaktIwGgrMRTDE/JK1UTjxAyd/5Lp5WIRrkWMWboQXl19fsWl1wU7qacW438PYe2
         qyxsyEfeXgCg+ZvxYxyUZH+jqUREEdAg44FbxSX1s2ikwsj8v1jvGeC3QoA7lTPEd2UZ
         qHB5rf9/l+EHjlJGL/1oHTGyiZ7QT5wGpiEXDe/d7/K7R7QyFbjPDHmQVCU04gYwHvNF
         uXHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCBT6UviAlxUq6yQeGSHyUmVmX/+dO7j5zJf+jUwXY01KpAZEyu4V4KTMAM69y8MDeMtY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK08fx/bDPlHScRznSE8KtkH5iYHG38htpV5he76mhiRAMvYX6w
	cZu3h3T90RQiKISDftrATHDjOLDHFiA+NdBCrA6YHsvvTZPvO8/GDXxr04kX3S2YjKYFNfk5898
	sMennlVHVhpRx2Q==
X-Received: from pgp10-n1.prod.google.com ([2002:a05:6a02:62ca:10b0:cd6:1e1f:43b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3f94:b0:3d3:adbf:7781 with SMTP id adf61e73a8af0-3e7bfa200afmr2334050637.22.1792894796861;
 Sat, 24 Oct 2026 19:19:56 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:28 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-18-skhawaja@google.com>
Subject: [PATCH v6 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index b818aab92f76..4eb7ffd489bd 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
 		ret = device->ops->pasid_attach_ioas(device,
 						     attach.pasid,
@@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		mutex_unlock(&device->dev_set->lock);
+		return -EBUSY;
+	}
+
 	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
 		device->ops->pasid_detach_ioas(device, detach.pasid);
 	else
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index f0ea37d98696..fb2141ee8942 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -106,6 +106,7 @@
 
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/iommufd.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -114,6 +115,8 @@
 
 #include "vfio_pci_priv.h"
 
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
@@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
-	int ret;
+	u64 iommufd_token;
+	int ret = 0;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
-	ret = pci_liveupdate_preserve(pdev);
+	mutex_lock(&device->dev_set->lock);
+	ret = iommufd_device_preserve(args->session,
+				      device->iommufd_device,
+				      &iommufd_token);
+	mutex_unlock(&device->dev_set->lock);
+
 	if (ret)
 		return ret;
 
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		goto err_iommufd_unpreserve;
+
 	ser = kho_alloc_preserve(sizeof(*ser));
 	if (IS_ERR(ser)) {
 		ret = PTR_ERR(ser);
@@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
+
+err_iommufd_unpreserve:
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 	return ret;
 }
 
@@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
 
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
+
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
-- 
2.56.0.257.gf7497c7d27-goog

