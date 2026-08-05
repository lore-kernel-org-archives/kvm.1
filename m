Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530C1F1932
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890054; cv=none; b=KwylToCx4lHwpXQjmEPKZFWiQGkAbSUT4NG7R0XY/st5x1LUI8EB1zWkJxuD/JxjyFX1CDpOUJyGqGKYMGRuVxc0A/gb5SQWM9GTcBm+jqTkJt4lR/bSCNU5ormRKvi/fUbmO7OZC57PnmUyNH0J7ySymrtlBPE9rmsqzz7t7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890054; c=relaxed/simple;
	bh=KpPIXjOjdk9TFSefb7X4R5kauQyEY3RCk1OY1txk4uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=op2+va0VyD51BCSncS7eeEIrlSgP6YaHN84hN1oJNFgSh3Ied3Fp1+iJNDGFZVa2j10Qn38wOOW5VlaPbSsKJuFATZ0JXwwfx95uWjS2c5ZrZzzSpMgMuKSAIMLE/kI4FMGxzoBNz0jIAOKHHszuIofhA2ftCTp2gd0kvz05y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEOljeb6; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEOljeb6"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so787864b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785890053; x=1786494853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtIdwWr6GeZCUuTQ8YFV0qk0dXF8h3wQJ2uzIcjet9k=;
        b=vEOljeb6LKuka+ffNuShvKEKQXfjLu93/vMR8B//6U72mfiXzgMJqI37KoQ0Wbtye6
         PCXSNJo5sQf3F1EY/TeSxVqQRWe5fTaEenRVfemsSGoNDKlQUbs9EtNLI0yUoPrjAEvz
         zlvaCuQ5TP0TO5tvh9HvCku701tgxINCHJCp7adM/y4IdKsTEFUb4fZphSVeiTvH5o/u
         hHguPgExxUjMova3C3jPS3NOX6f2pVlrs/MRsB2+2UdQby4pnuX9Uc+isIDHS4gPb1hC
         3zlHzzKbGmXWrd36kCgsDhVHCm9ZUa2a2qMSIBzm25MG990jrlfXvG17ezL8rgEfrCGw
         /0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890053; x=1786494853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GtIdwWr6GeZCUuTQ8YFV0qk0dXF8h3wQJ2uzIcjet9k=;
        b=AJ/WkxevN00LSkg+aOcTGlhaRqMY+ewbGPK+JgR1LOcQE+9vEXEzP1vaDRSbUC0hTC
         P7okWNTqnUSOx0VeKqkMlV9IbhaZQJ8JBX3KXtJcdpA2y34f4hiwWbLwwgdNEIL9Bmyq
         0XY/yAGDaRMA9Vk7BLQy4Csh7RFWL7fRciwvbpHR8Y5VMVd/VznERVDLYn9DJQGhFnq6
         NMmqsZdI4jLHzEr9d+fMOWPQSDVGAScDvte0bJ78ApixscYRMFjd9qMklbT3iB1Ji5cb
         9LF5hJ07e5X0eZRW2o23vnJgIA60bV0SJv2tTdY58au27vwWMuTtgWln8Q2uFP+2iCKC
         sg7g==
X-Forwarded-Encrypted: i=1; AHgh+RohVLSmze+Y8BvBy6d28scsmgRvKWD7xnQc8r1xAcLmDShu4BYnqsKxArBcyDEi7xy5xBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv09xnNkfEBNzgZDEXjUJtPVOp6C/rbk/V0xIYIe780vMXzQ/H
	IrgRNYSyuxftw3UBWUcdXEOxe+8uaGJeFGN47m8ysoFz0edXyOwqqsnbSpND0otoVIJBKN8lx4J
	9QS3ij6BKMhPQHg==
X-Received: from pfjt10.prod.google.com ([2002:a05:6a00:21ca:b0:845:48ff:3362])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4218:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-84f2e210308mr2833955b3a.1.1785890052657;
 Tue, 04 Aug 2026 17:34:12 -0700 (PDT)
Date: Wed,  5 Aug 2026 00:33:55 +0000
In-Reply-To: <20260805003355.728299-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805003355.728299-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805003355.728299-2-skhawaja@google.com>
Subject: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, bhelgaas@google.com
Cc: Samiullah Khawaja <skhawaja@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When userspace closes a VFIO device file descriptor, the vfio driver
performs a hardware reset on the PCIe device to ensure it is returned to
a clean state. However, if the closed device is an SR-IOV Physical
Function (PF), it may have instantiated Virtual Functions (VFs) that are
actively bound to host kernel drivers (or other vfio instances).

When the PF is hardware-reset via VFIO, it implicitly disrupts SR-IOV
operations at the device level. Because this reset happens without notifying
the core PCI driver model, the kernel drivers bound to the VFs remain loaded
and operate under the assumption that the VF hardware is still functional.

This creates a state mismatch between the kernel's view of the hardware
and the actual device state. Subsequent attempts by the host OS or bound
drivers to interact with the VFs will fail, leading to unexpected
errors.

Disable SR-IOV on the device prior to issuing the PF reset so that the
VFs can teardown and remove at the software level also.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a113c55845e1..b36c77eb3c40 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -826,6 +826,13 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #if IS_ENABLED(CONFIG_EEH)
 	eeh_dev_release(vdev->pdev);
 #endif
+
+	if (pci_num_vf(vdev->pdev)) {
+		device_lock(&vdev->pdev->dev);
+		vfio_pci_core_sriov_configure(vdev, 0);
+		device_unlock(&vdev->pdev->dev);
+	}
+
 	vfio_pci_dma_buf_cleanup(vdev);
 
 	vfio_pci_core_disable(vdev);
-- 
2.55.0.629.g250fe7f194-goog

