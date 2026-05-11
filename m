Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EA3FADE9;
	Mon, 11 May 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510824; cv=none; b=t8iEtmuSQZH88rZ9RU1Sa8ZYpj/WYp3PqcqIfXq8KaS7lllKx1Kuv1SWil9XC1/57Oodo4yWI15SJGjierFKL0AT5qm0iu2o8gj8WF3SdSBZMGhmn5CXVdOb7JolyPGaQ7YPqK549mvftvhToEOVyfeV625aPTjRHRODc/2lrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510824; c=relaxed/simple;
	bh=vWb+gFw4kEMiYXes3fXKejYbzghgQQCItnjWAGcfj4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbe+/0Ufo/UuHozcHpMSeAZbCkEaQjGX251raatftmNCbC7xTtIBnjRtt1vlQKjxmP6QnEd82sbRBN1yg3IpHQcUjtZyRc0mAPiDP7075QPBXWmefWbDg62PmAoTEBKnBbMvOpE7ExzN7aJBjg1EclLikQe+3Ff72uBIlVFQZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NSMT7rAR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NSMT7rAR"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AN0u0U2460008;
	Mon, 11 May 2026 07:47:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=ZiTHqkqZMghjlfU1eR
	Tgg1uVuRxiTy+WlHuVBC4Fy1w=; b=NSMT7rARKqbX1+uaK5p0Nfo+3AoFn5cI7P
	H8173UcDln5c7dVSFIC2ulm7+v23pMkku8X1F06709CbKvW3QAijDCIr2CBUAq/v
	4yGb140NWl9kCLOGzupkCa6vEy0BzXbxRH7kvh7KMSp9rwEj3yERlfBlxfohovM9
	tSYn6kUkHiYAVB968XlozsmKKukdUlk8ZAN6V1ybvS5bZVNi07sjUTGVrE1tyPVh
	AtIs9xd4suBJlYW1j/KYp6bCpiGs9bVJEsxvWT0hhPicuBRZmaEIhzX0k7aFXKMp
	KNSgE7tC0WxaY+jENQRBFlqzzC1WQ5NqEUhHFczlf+QevKBVPOwA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e22ebtf2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 07:46:59 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Mon, 11 May
 2026 14:46:59 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfio/pci: Make VFIO_PCI_OFFSET_TO_INDEX() return unsigned
Date: Mon, 11 May 2026 07:46:42 -0700
Message-ID: <20260511144642.2926799-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2MyBTYWx0ZWRfX2Fmysf2Dt/BG
 Q7gMxapb/jHuaVfzH/gvUYiG0bSVI7sS6zDupU+wSFqGOsgNnKh7uGPg0E7a4hGhSOb8vsxqnK/
 mqn0i+S55A+Pq+ZlZMo0xksqfxoeIZVBAWev1scF8WxKY5ooP175jX2qakfXM1ko8ir0acRoLQ0
 nJdQl99pT1ryAutyWMjIA3kDbiSzjssO5tht+S+m8zCCEHpSC2cgGvLslY5JAEZ4A0xQjSSBmOB
 dbuWojNCFS3f1kRFpxftR6hPE07hHIUt1dfCmXQEOjornbsWvn2BRJ0kQdFpHKnX3P93ToGHAyS
 SxA4Fow4x4MH8ByRQ/aSoKlXR8Pdgt6Z2kMl6UyX/tFTmQKGPoudaso/0v7AvdA24IgMPgr4uVg
 9Dl5JGcIuIAGh37a1Olai8MSVsSFNpUSlFd+J2S5A7ml8DUjFSqRF8/dFaWdAd2Lbn5Cm2meHnM
 ppDBQMb0EMHOIPeZ9hQ==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a01ebe4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=WMeaP-Si3NigN2-QYpwA:9 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: NHFMvgY43cl_QBpSICVu4lbrhgK202yB
X-Proofpoint-GUID: NHFMvgY43cl_QBpSICVu4lbrhgK202yB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

VFIO_PCI_OFFSET_TO_INDEX() is used in several places with a signed
parameter (e.g. loff_t).  Because it makes no sense for a BAR/resource
index to be negative, enforce this in the macro.

This fixes at least one current issue, where vfio_pci_ioeventfd() uses
this macro with an unvalidated signed loff_t returned into a signed
type, leading to a possible negative array access.  This instance does
test against an out-of-bounds positive value, so treating the index as
unsigned fixes this issue.

Fixes: 89e1f7d4c66d8 ("vfio: Add PCI device driver")
Signed-off-by: Matt Evans <mattev@meta.com>
---

This patch follows up on a nearby issue found during review, discussed
here:

https://lore.kernel.org/kvm/20260508114552.6f5b99f0@shazbot.org/

 include/linux/vfio_pci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..89165b769e5c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -21,7 +21,7 @@
 #define VFIO_PCI_CORE_H
 
 #define VFIO_PCI_OFFSET_SHIFT   40
-#define VFIO_PCI_OFFSET_TO_INDEX(off)	(off >> VFIO_PCI_OFFSET_SHIFT)
+#define VFIO_PCI_OFFSET_TO_INDEX(off)	((u64)(off) >> VFIO_PCI_OFFSET_SHIFT)
 #define VFIO_PCI_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_PCI_OFFSET_SHIFT)
 #define VFIO_PCI_OFFSET_MASK	(((u64)(1) << VFIO_PCI_OFFSET_SHIFT) - 1)
 
-- 
2.47.3

