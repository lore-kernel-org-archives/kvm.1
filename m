Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5982367CF;
	Wed, 15 Apr 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277007; cv=none; b=gTtKgCcroP/c5NiWX68sRtq2/KQduNUh+41w2DPzSo+Fnz+ScEq1vbTnkQjzAIk9g+Rf/lFLW8gyvaNSYffZk3g+qvaX3HlZca8ID7xwsH2UBK3fiGjSu70tndvoa9khbMDp53bM71ZFztHapcV/krmWLHLOecaQS4D6OHHOfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277007; c=relaxed/simple;
	bh=XDOas1yfPVSdREWaoR4XFcltJaLl3yyTO+WQvYsWDNw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HaHIzoxBxVlIeYc+4LfISYXZ4dl1tyPxgpgD31Ez0cis6bqwFuMKcRv41UFyAbNgV3clVcZt35jULHc2jarBz5QRGcd19tMPRBE7m0EkKGTB+hqJCkiWl69XL/1A4herkzkPExQsNHdmubef7F8n3KzccUra6GK0ZQDY2hIJfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Hq1rUEf5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Hq1rUEf5"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2tfxB3088107;
	Wed, 15 Apr 2026 11:16:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=irgpgoHOjMqU8imuli
	It4+lwPmuEzeVBbV9GtbCRsQw=; b=Hq1rUEf5SquprWj1nQvm/Ld+beftWPa6QR
	vnte9mJ7QLesIJrhnX1wJDtCnTwYB/I9n60g/Q589RNfBe/BkcsEozVOrjcq9XbQ
	RuAUCLO69bSjFzfdcVj0KEAR7QDwnmKAc4ongbw153BIjXJjOeaRCJNGNir/Z1Kz
	WaVUrNDm/b2c5fDyo0D4KAAO3UpvJDp91AXAa3xp5dQTljRuOVZQk8S80NnCBsfV
	YBWanI+q8u3OoxG/vyAsKhKJ/gRAYd0yoao5Da2ecSEdvFc6dyL2rLpHex3M4UvH
	2kOLujQtLRCmXdTzUJwtVjrs1+vhNbRJsKsysohIF3BuV11zfVsQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84yd1at-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Apr 2026 11:16:37 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Wed, 15 Apr
 2026 18:16:35 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Matt Evans <mattev@meta.com>,
        "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian
	<kevin.tian@intel.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        "Ankit
 Agrawal" <ankita@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Date: Wed, 15 Apr 2026 11:16:23 -0700
Message-ID: <20260415181623.1021090-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MCBTYWx0ZWRfXxeky6YPlWYAM
 SQ7ZxwO92cqqB+RbXUjgEoCWAy3zcg3YWIUXjq7KShUiAvSfTJLEEomiA5G3DQOg6Nb2RdlmeqE
 8uZnyHhYCUyRrgNZAu6oASe3n742ymU32wYf2d+HRTPeD75crRFYJYTGrKi9RIiLUDqlbRNLPZx
 q+KuuLwHjM2jwN0ZWApuFu+K0E89xvCsHlVyrwZRe969Cqoxj8zXGqbZYrlkwTtL310QmO8uo3H
 RTg3xepl5cCY9AvmQz5Xl4f1Aio+z6SmlJ0TR+ySpWBcG9YrTBVX3tFNL4h6rSEbPJhRH6WFQrt
 QJVArof9XLt02OS6v/8pk+ZZVSLWDVdurPkknTO6pYky4axDhEpAL9hB2WmY9DBiIAsDutdAfUL
 vyFnLYrj1TUAkkZanjoJKRpPqkXhEjZP/MW02oQQircfANWp1xyBEVE66udk1kTm12SPGYTkYDC
 91Drm4zcFtRRDMRLZJg==
X-Authority-Analysis: v=2.4 cv=eubvCIpX c=1 sm=1 tr=0 ts=69dfd605 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=Ar5XgymO5WXOdC_jA6UA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: EiS3w0IH-VlRLCaqPzbe3Kkbm95Dk2bY
X-Proofpoint-ORIG-GUID: EiS3w0IH-VlRLCaqPzbe3Kkbm95Dk2bY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

Although vfio_pci_core_feature_dma_buf() validates that both requested
DMABUF ranges and the PCI resources being referenced are page-aligned,
there may be reasons other than alignment that cause a BAR to be
unmappable.

Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
mmap path.

Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index f87fd32e4a01..4ccaf3531e02 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -ENODEV;
 
+	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
+		return -EINVAL;
+
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
 				       sizeof(*dma_ranges));
 	if (IS_ERR(dma_ranges))
-- 
2.47.3

