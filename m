Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C174416CEE
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104742; cv=none; b=lizTimN2XGyOY7BKtBqSQjV+GSuHOhmYvhcLWhZ14fcyy7el5EftqDuNGjKGsGZnRE4iAUlK/ogt5Cy+GSUZas/R4EGdZq/M3SvCZbd5eOtj2ArBtgzVEhcZH5LbzZl4xVp9L766zMGYK29oJ8kpfhEcMBGFuuyANTRRZ3kdTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104742; c=relaxed/simple;
	bh=UkLj+tZqpkffpEV5QRjxZQz63KWtzsiYYBPOPyc3h+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/p6+LhkNX20XUP4DgA1tlw4B1wWOdtOoTf8Jyh9LhLNawie7KLzLFAFwZy04M9mEKDl3H+vfse3DvEvEEO4zX0UFs+FsPEu2ile1dysmKsrW6eQdm2VovZpRX8Ao8hAHr7ZtbXPQ6dt0VP6SdCJH+a+GylF4kE3EXTWb7jlGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKP784vD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKP784vD"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so4788160b3a.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104740; x=1781709540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0es0rdpo5zHpTGer7c4Y4kWiVEeVry4q+hd8CbVLqA=;
        b=MKP784vDc7UNawXDtsg5E7d6oNffWCVBigWrW1Ew20YpxmMB8ThtgADhHLGt7L6kRR
         q0D+IHtzvCZ3LcvOTJ45TLSAt2/WNKybrhMQi5DGQtZxdkX4XgsnRAqfsZB7sB0ooXzX
         2WdWGa91rOez5S2tWKMbzMlXxJk//O1fW6tdEachK5wLhwUXxCShQ/iTgvJ4DGL+98pY
         Q32APzBQCU6zsbo2GVU7LZ/1ei0kouhczuWuIQr1CJEB3LyQ0Y4lGifnWrExvNhz1xvt
         IhugI5NV///6FTrnYxWBrnxSLKySqEX9Gq9fR5GaS69WOn42rXaNHGcVELgrcfraQqLr
         v2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104740; x=1781709540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0es0rdpo5zHpTGer7c4Y4kWiVEeVry4q+hd8CbVLqA=;
        b=hhGDwTWpvqbfze3glolp1ThxEakkC92a+WVED3Q8cAKIEVbcLvrTAzJEks6MlGMNCl
         0R6TfbP0kV3DYSTqF+9xsFjXIQRWybWRg7tTyoIX+xUPNveyZjQ9oeXiBc0iHuQ9ZZ+H
         S6gqADGe8PmuSCcqT36dRc9WkMK2mXPMPLLZsXhs3LV3r9sRFMcBXJmq1Doiomk5MT+p
         C1rz020ZJfM9nwL7NPoPLlgPcE757lpqe/exMZ5RWjJdeT0fG3/RRDO9wLqZo54XERR8
         +eAMDojzEpD70YkO09ibzed1ADq3+W4jSta9TmKB3iv2FzrL/NjhgaW1CnsGtRPmDyvz
         fyTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hDcOa/1NDswWDQMXTbFFrddl718JBmnTyyu+1T0GdgxaxL6O6WwWfhGrproC0sGktIuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5p/aYUw8iLHHT2qrjN23ssUAu2ys2nYz8hNw+eMc2A+2kAu3
	3GMhBEC/Cxs6MjOe1jOrD25NEGJZBJIkUUx/5SyML6Y87ibdVheE2Tbq40uv2ghFwo1KdL2Gglj
	Keg==
X-Received: from pfne8.prod.google.com ([2002:aa7:8248:0:b0:842:4f22:f388])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440a:b0:842:614e:cc9d
 with SMTP id d2e1a72fcca58-8430a70be01mr8519996b3a.27.1781104740313; Wed, 10
 Jun 2026 08:19:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:50 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-3-praan@google.com>
Subject: [RFC PATCH 2/5] vfio/pci: Implement ZONE_DEVICE-backed P2P registration
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement the VFIO_DEVICE_FEATURE_P2P_REGISTER. A bitmask is added to
track the registered regions.

Post-registration, the BAR is added to the device's P2P pool and is
available to be used with standard page-based APIs.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 39 ++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..1e922e3aaeb3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1554,6 +1554,43 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_p2p_register(struct vfio_pci_core_device *vdev,
+					      u32 flags, u32 __user *arg,
+					      size_t argsz)
+{
+	u32 bar_index;
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(bar_index));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&bar_index, arg, sizeof(bar_index)))
+		return -EFAULT;
+
+	if (bar_index >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (!(pci_resource_flags(vdev->pdev, bar_index) & IORESOURCE_MEM))
+		return -EINVAL;
+
+	/* Already registered */
+	if (vdev->p2p_registered_bars & (1 << bar_index))
+		return 0;
+
+	ret = pci_p2pdma_add_resource(vdev->pdev, bar_index, 0, 0);
+	if (ret && ret != -EEXIST)
+		return ret;
+
+	vdev->p2p_registered_bars |= (1 << bar_index);
+
+	pci_info(vdev->pdev, "BAR %d registered for ZONE_DEVICE P2P\n",
+		 bar_index);
+
+	return 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1572,6 +1609,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_P2P_REGISTER:
+		return vfio_pci_core_feature_p2p_register(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 5fc6ce4dd786..cae7f069e5b6 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -112,6 +112,7 @@ struct vfio_pci_core_device {
 	struct vfio_pci_region	*region;
 	u8			msi_qmax;
 	u8			msix_bar;
+	u8			p2p_registered_bars;
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
-- 
2.54.0.1099.g489fc7bff1-goog

