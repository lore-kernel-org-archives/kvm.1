Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06293A382B;
	Fri, 22 May 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453763; cv=none; b=j+/Qw2H6tmBSyRHqRb4vJUjg7ORXiWjuTi41rotgRjmjxOT0JbQ0zIMHIsJ0I//zJL2nnSnoGFh778kBJy269oAdstK0awVCCQNiyWWrBy+aXY/GTiqD1z6lLtRgkeqncgVMcgTs8fhd/u8Uge7KvS8GaI7hRwqE+V5Lez3zCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453763; c=relaxed/simple;
	bh=TdAp5VHTo4kSpGRN7kTkXxWq7+25sIsT0KITiE3yivY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zy1wcahoZgQaj7SzxwOvd7CN3T7RHVEB92XrA/GKs3UCJQss1Actp4BdYrzxDv0/S5fYj5/X/NKz2wcd4y9noVwfMN0ULV+ZO8p8nA9WYOJoRc4mGXGF2r4jr1WNdOP5pVsf3KKMhY/puD3TDjoo7bEtq3LoLjJtXheXmKVzizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sJ6DTlGo; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sJ6DTlGo"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8HYYq841953;
	Fri, 22 May 2026 05:42:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/aUTLjCJ1AtOwCEJYW
	hG7oCDm+n498quUxGoDFsC6Ts=; b=sJ6DTlGobC86SevvKIsr8mjfjYPYp1fbbx
	GUaZWREoI1iNnR9uk6nvRjxqcXL8SnsBubzmVXX7yBW8zWE57OT95UwlyeZCC4Z0
	Du1KktTYNswUp5Lh4DIOWT8+G+7ztoB4FktYjI21b7Idjzq8ZMhN0BKrCJ0IQz0U
	QRjxg/J5maIQKXkYI5zScJbVd0xrtLal6n6NV6AV7J7jxt+PQy/gk52tFfrtgLzx
	DPbRTJi7dzyLCpBDLWagYZ3io7WLT//LSFm5U/k1SSrWsIlDTx2zhl5zZ+7AUypI
	6YzcDVgmWyToqTefADK24jX+NwLraxyJUz0n6oT88Qk2CXrvOheQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea3yqeugv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 May 2026 05:42:34 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Fri, 22 May
 2026 12:42:34 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: [PATCH] vfio/pci: Fix sparse warning in vfio_pci_core_get_iomap()
Date: Fri, 22 May 2026 05:42:11 -0700
Message-ID: <20260522124215.3268565-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wD6jP2B1rwjjsN56EgDW5keEJavFqXH4
X-Proofpoint-ORIG-GUID: wD6jP2B1rwjjsN56EgDW5keEJavFqXH4
X-Authority-Analysis: v=2.4 cv=NuHhtcdJ c=1 sm=1 tr=0 ts=6a104f3a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VabnemYjAAAA:8
 a=qM8KBkelLQ9gvC1fiHcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyNiBTYWx0ZWRfX0ztNQtSSaa45
 saBdNys/J3YamVpegN+65EHfFdR7TVkSEWCT8Bb4zIrosxYWVLQr2j1mPrUgGUO+F7htsBLQFFX
 Uv8HIdsEb0g67OmLQlCkaWCcCI7vrsYkWZvMT/mj/ATpx0S0qIafxOSe+m7IWki5WlEsQPPORvU
 8pSlU3DTOHmbGw4On9aEv69h75WbteVYh4u09mdE5c+HJ57q+zvNgtpCB9wm9Tt/cgdK58lEP+b
 ASdhEMe2lUc55nEBOiACfQFeOxZ0nNGuJeKGfww04RDGUHX4U5e0paHBXaLDkE0RsDRCw7W90Up
 nQxQLOIyR0+NClbefMBoh6R5SgIIi2FOVKNCss2cdLsaHHPa+ynt2d0fka27mua6SEPd5PLYVzf
 Kar2M+OPBN2cOn4V27hBhfU1eIS8KmW5VHK3GTz9NfcyAOCHR8Z9AzXae5fdvyIk7Mq5jDOEnhG
 +MMJh+6CnYThqyBfrTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01

Use IOMEM_ERR_PTR() when returning a void __iomem * rather than
ERR_PTR().  This fixes a sparse warning, "different address spaces".

Fixes: 859dc0f6253b ("vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605211601.U1OvmuqY-lkp@intel.com/
Signed-off-by: Matt Evans <mattev@meta.com>
---
 include/linux/vfio_pci_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7accd0eac457..4fa129fc5c64 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -244,10 +244,10 @@ static inline void __iomem __must_check *
 vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
 {
 	if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))
-		return ERR_PTR(-EINVAL);
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	if (WARN_ON_ONCE(!vdev->barmap[bar]))
-		return ERR_PTR(-ENODEV);
+		return IOMEM_ERR_PTR(-ENODEV);
 
 	return vdev->barmap[bar];
 }
-- 
2.47.3

