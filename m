Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C2347FCD
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219951; cv=none; b=Xn9+1wshDcPxS00vpGs2momGUxGVndI1RquM2wBmHvavQImcHb0lZFTeuQufcR0pN28VqvMU1RyuSLukEm7V0d0QJd/vAiKRjxekwabm3sKd0BFGuFAYElWEFGsnG08ibP8ailsz+yRRjJOaq/rvXC8aEjpB5U4f3BKD0VrgOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219951; c=relaxed/simple;
	bh=44xEYbljSROVieZ0RPdXuWqnlBLvyVYrKdSQUFcZgLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jt0iF2Hrg/P4Kyf5m7uVYYXFkoLC5olJ0Y8opZe7bT1AHZdPVzpOyaGbbC4pOCo/7qTNbWC6fJ2S0K/ic9vt8y/0JX83/G70CsyR6ZVsm/3SLSTyYPoILukMcfHvKLJj6TZoAeudwrru8aJJuc8R3n5GXJzURWCf3qW6B6A3ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/3r0VfH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/3r0VfH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso34542745e9.2
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219948; x=1779824748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y40Gpg3ilPhkRMprpE5hhH0Rf+TbXkdO/RkFO88+nYo=;
        b=l/3r0VfHovR/6ekaFuEaH17v2fkuZeWEuXKp2tXy5k3OBSu86aZCYHYCA5qRw13Adn
         FBmADAfR4wh0u204d91eaTIJN9qTYNbqewOwFZwD6XnQo4xEdDMCZ+OBRI8Vly1MvKGO
         B03wsZGdcV/dmS/iz8MHFrkWAIGIHVd5XQNm4DPvmNuLBs8xFRT2r016VeHbC7Bma7RK
         Fs/tntSpM9Kxp8d5YIkHeFT2i+jjj/ojZsHMib+Adr4itiDX6yuKyQ7GucaCEAM5QFwS
         dkY5t4P3TJRNASyWIF9uuPT03GelF4SHEGLGT4Imx9I5zJ2YLLp2YymPMXZ1GYPgL9aC
         B+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219948; x=1779824748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y40Gpg3ilPhkRMprpE5hhH0Rf+TbXkdO/RkFO88+nYo=;
        b=R+Fqa2UbYtQZxtXJKLmTA3xXtqTrQoxH+LnTCaPdkwujTApR/Br0EP0O8nHOX5qnlz
         ynRY+CZEgYo7StlZa6PzmDPN16s/lKKFsxzoYqKuq/XhngXswyQQqHDcyF9fuClNlmHN
         pG+dLuEDgOdGFJKuNgwsJUbSVq5JSVMiOcgFk7rXVAbPhL+mAdUgIyBiYzTLewfZyu12
         vIivsF8QL73WPAbKV2UfVJenC6nz7EC7QnLEutMvqk7N36bjZGV7Ve4P2hVZCGsvcBwc
         BVaI+Ft66ti8bi0ScMJWLSbw0XiBwkVywPc3Gtl7axnQQ8U5nX6rNkYYBZozVBoOKJxg
         YAUA==
X-Gm-Message-State: AOJu0Yw8Keku5KiD1q/1QdboFJ7Ejr1BiEQjKlX65VFBv8+fYkEP5OKf
	xBjMRjmGGjwWpiEJPATDwK8MvdtVQeWsAIKa+/G56o8rXplYlIFe2iTr
X-Gm-Gg: Acq92OF7cbaA9f1Sr5CLfwN5Tht7Y4fXbbXPpERc1qxRB7XD84nf9xdh4+IXZXOSIUM
	3LhCdng8iJiyy6eQspZeE/pXGqVOnsZRUkjVpyKK7yw5XQfSLAPvtZGTkGmqr6j7dLJtnqy/7Za
	9tMQHZv1Raj91QbaWfF0qEyfXql66ZdHHUVvY808B2rsbICUjLUbO/OszOn0AmCoLEXZ1Va6ZJk
	Sup8zdXkonSmtCz5FQ/n01ATZF3LfBhvxt+jdgxhqOHOfNOOGtnNDCGrp4ef3sc68JZrKFQZmV5
	0wFIAEXB1hbrsa0+HcxQA/TIIA1yBH8Unu1CM9ROfwXUYjyRXZMgUHo8+QqGhdu3WhqcEr2WxRo
	yiObzNa0GVBXJN+n+Mk79JpKLSZVF1lpF0w8RkoC3o3jWYBOwCduaJPXOhyRI2RvrSYM60q8LvD
	ZDy4LZ85lO30x9MrVAuckVCma6TQ3Yqs6u4FOn
X-Received: by 2002:a05:600c:8592:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48fe60e5235mr242122435e9.3.1779219948365;
        Tue, 19 May 2026 12:45:48 -0700 (PDT)
Received: from spark.Home ([2001:8a0:672f:7800:12:2614:1925:95e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf8305dsm166729195e9.9.2026.05.19.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:47 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothum@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [PATCH] vfio/nvgrace-gpu: add GB10 device ID (0x2e12)
Date: Tue, 19 May 2026 20:45:45 +0100
Message-ID: <20260519194545.41503-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NVIDIA GB10 GPU (device ID 0x2e12, found in DGX GB10 systems) is a
Grace-Blackwell chip that shares the same NVLink-C2C coherent memory
architecture as the existing GH200/GB200/GB300 entries.  It exposes
CPU-coherent device memory via the ACPI DSD properties
nvidia,gpu-mem-base-pa / nvidia,gpu-mem-size and requires the same
specialised BAR emulation provided by nvgrace-gpu-vfio-pci.

Without this entry the device falls through to the generic vfio-pci
driver, which fails the iommufd IOMMU_RESV_DIRECT check because the
NVLink-C2C memory apertures appear as RESV_DIRECT in the IOMMU group
reserved regions, yielding:

  vfio-pci 000f:01:00.0: Firmware has requested this device have a
  1:1 IOMMU mapping, rejecting configuring the device without a 1:1
  mapping.  Contact your platform vendor.

Tested on a DGX GB10 system (aarch64, kernel 6.17.0-1014-nvidia).

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..ac1acf41df86 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -1244,6 +1244,8 @@ static const struct pci_device_id nvgrace_gpu_vfio_pci_table[] = {
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2941) },
 	/* GB300 SKU */
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x31C2) },
+	/* GB10 SKU */
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2E12) },
 	{}
 };
 
-- 
2.43.0

