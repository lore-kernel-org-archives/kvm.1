Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0023397329;
	Sun, 24 May 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628895; cv=none; b=gbJpErGHz2VuegeugKHjwyg5dp4/2fXdTWUCN7fILkWGGdy2wJpgolDIGbtsej2cFRd+mstNpTdLt2orVEHy6UuTkMY5aomrDIW3sBYUu4nJnrmAsAdljEpo00GJPHboCmzFGiXL3Mh4rbvpDaIUx9Y+6E+XAx6f5/28tt7z/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628895; c=relaxed/simple;
	bh=1Cz1HNAuj4hUIOJ8cVHN2HWBhZxUe/q8F8Gyo144IFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCF1f3x9Lh/RZ5bgBjgvUnLmh6zbGk5895z8LNxcGxTSPhOa30PpF9xBbvkXMYZekbJe+ami7GPQnCmfZIy1GPh5ayswG3FzaT+/4Nn7cNNeujqGkDzozotrbZ94yV2xbDxIBOOcioKToz1jIIcRcu0suR5SOl/hbcNyKS92LwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zt9emJk3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zt9emJk3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NLtKo12838407;
	Sun, 24 May 2026 13:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jTzdpJ2VY4gVEx122qvvA/GWIcv7kQyG9Q8
	jRQegdRs=; b=Zt9emJk3ukQOEudJnSR62GCMCZJQ6Wdq36AJi01XWgNWnYsZ89y
	v3rCIbaKn06YZleKHouZlYKDOCs7JrFPypiNB1lCgFS/mAXZGduid1eq/LD1bJ0h
	/xA/0mm1j83YbaE333xfs4noUIJudUy7RrAZ/3Oy/Tfxg2eypn3vwd9Ddmrch3l2
	Fce7Xitwtb04CTgpcBjJBUQfV4OgAvUFEPqZRH9aKNgYHPkLxbx9SE96IL+yH59Y
	4L+/4gtgBbXA3VhyGX2Njr/d8xSMWp+G+KvgdiKchetfToyeaObltypP5EHrodCB
	2E5VPZ5dDkjA39mGF1Wcj0n0jjIVE4s2S+Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmkmym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:21:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ODKx3c009280;
	Sun, 24 May 2026 13:20:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ahgq6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:20:59 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64ODKxAW009264;
	Sun, 24 May 2026 13:20:59 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64ODKxiu009263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:20:59 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 7A41C21AE9; Sun, 24 May 2026 18:50:58 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
Subject: [PATCH v3 0/2] RISC-V: KVM: Convert HGEI management to fully per-HART
Date: Sun, 24 May 2026 18:50:55 +0530
Message-ID: <20260524132057.2425034-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEzNSBTYWx0ZWRfXxR/Q+iH1dX5f
 5PhIcJ8bOQa9ORRaw0lUoZIJyExYA6l3CT964kzEPRgZ7duImKa2paT/PKWotNCaJcgH1Jt69j4
 OuoYl4fQ2L7ums3sD+Zt5HnuknxIhsukHEPvu8m+GK21hQWY9qrrTTDIYiuOn/SVLihdgXVH0E3
 tvG41It28RhUvHbtxKElQ/CWzcNhtG1Zl9zG4c+rFQVqGhOMr1WeJg9pLnQoTYXXB2TdWQuUAfX
 4wHL/TO2E2lYjkRCl+skbEDQa5MHJiLy+quPkJ5udyYRn5ibBWvBqKX+VgJIfJfevOOzxXd+egO
 rYu5DKoHf5e5ShZgGfgThByBo+AEmD8f3s+oUwP9RjMw41fNmyhZQSQRTwxkry3n2OF/TgQB1Hr
 wIfSeNvTDTX5nY1z+tW5fWk7Jl/0gN1uqazl5ZwrKP/MzyEheQbfVX9jQASrnFc4CvH3G5MGQju
 7ouOxWRviabHR7H+U8w==
X-Proofpoint-ORIG-GUID: aeAce-kUopHkqVHP3cJRpekuSNskK3dd
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a12fb3f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=KRMKSR888c52cKfz2NEA:9
X-Proofpoint-GUID: aeAce-kUopHkqVHP3cJRpekuSNskK3dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240135

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

This short series converts RISC-V KVM AIA's Hypervisor Guest External
Interrupt (HGEI) line management from a global "one-size-fits-all"
model to a fully per-HART (per-CPU) model. It also performs the
corresponding changes in the IMSIC irqchip driver.

The motivation is to properly support heterogeneous RISC-V SoCs
(big.LITTLE, multi-vendor core mixes) where different HARTs may
expose different numbers of guest interrupt files / HGEIE bits.

After this series, HGEI allocation, freeing, and interrupt delivery
are completely per-HART and there are no remaining global assumptions
about number of guest interrupt files.

Changelog:
V3:
 - Move PATCH3 as first patch and kept the nr_guest_files in
   global config as the number of guest files across all CPUs
 - Droped original PATCH2 and squashed original PATCH4 into
   original PATCH1 which is now PATCH2.
 - Addressed comments in original PATCH1.

V2:
 - Add per-HART IMSIC guest files to compute final HGEI count.
 - Add min(local->nr_guest_files, nr_guest_files);

V1:
 - https://lore.kernel.org/kvm-riscv/20260421145451.1597930-1-guoren@kernel.org/

Guo Ren (Alibaba DAMO Academy) (2):
  irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
  RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

 arch/riscv/kvm/aia.c                    | 67 ++++++++++++++++---------
 drivers/irqchip/irq-riscv-imsic-state.c |  9 ++--
 include/linux/irqchip/riscv-imsic.h     |  5 +-
 3 files changed, 52 insertions(+), 29 deletions(-)

-- 
2.43.0

