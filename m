Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCB4DEC3C
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605918; cv=none; b=eKTXu2+nMUkCwAtS6w8iGFR84hLrCils/A7GKcnxg6CdH919M60Kink277hzOjwpmHLjBUz6uMfG21Er7riZ5hSgn0MotJWWbXG2nBbYMynBOtwp3iRxs3vFj6vEn76/VEQCMdhliDnL96H9ENp+o93No4yH3QhC/9Gjrozqpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605918; c=relaxed/simple;
	bh=HMHDIkk9eqjhFkHSH2xSM+qF3/e16Lj391jOJsFu1M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/Ro8HzrUv93JmJlim8uLjNehnLPZ5ikDvR5R6ZInzfQnDzqL3/Dfuw3831CVIA2UJFPq0kB7XIHxxYQFnXqhssC0Wro1SxJd+lbPSDM0kSJVqlTwoKBfMyRhiqiCTc3t1OPju0qnNOb3XGwYqjCRknyFIMVUFPjEmmZXs1R0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeL9p4w2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6sC2lg4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeL9p4w2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6sC2lg4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBA8Z61189326
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SgBxAUOx84U
	cn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=; b=PeL9p4w26BhoNlRqOvQ3LSV7n/M
	IktOMye2ZvfZB0pICaZ3TBWrcQlguntFEJzgoIjtjths47tJk1xoUZly2IPaQszy
	pNIDDoUjuy9W6cB/mpFxHlby71PtXHVdx0VWz6WtEILSV8JQfkeE87kr7Ib7ZPIG
	TOC7sMO2YdQEslR/txVR634Jw5qrZWxsKyoGjrLuyh/QQjmvwNSaJ/WsFebp67mG
	IImMljNxomfy+bPYM3oRVTQ8paB3pwle9mjd3f8s58TbjX1938Z7pGGKc7eXz9Rg
	gV+3ERanv7za6SCrYk/1jUrCxiIAqpgci3qNcOuCurOWNf5dPF9aV7CCWrw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc15v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:49 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7b37c39d36fso497311137.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605908; x=1791210708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgBxAUOx84Ucn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=;
        b=C6sC2lg45nsbZq1eSuGD9s5R/hnB+G68ElvbiXkwVDn0GJDMlQq1NzsDR+W3V3f8fu
         DR7P1gsWNabgOeK9akdKYY5zHhBMUDx8xGguQXp8T25uZ+wEBwRXCdoU1EtQrbhp+SEc
         5PzSy7V83PuCplYwZorLrzyG5JYnrSO+Ucv9KisqfThlYWGfqw9GtHgfab2+BBJvPfre
         VavcDKn07ahQt02NJsWWPZ2KSU93bHyqLgJHgwiZaQxbiQ6py4cFiJZ4hlTUWyyXLAny
         m3vyc1nE/3IckhFWVxvoTI2+4evXd1Vf6oxXFrODbchRZ7hIrZcXLyEfeusqXvv1j17o
         SHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605908; x=1791210708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgBxAUOx84Ucn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=;
        b=Wmin2wSZOvUzPYsRKMjB3DKNpw3FWDzo1JwWGqQXrDBH21F4hMHQd0voYi/9nJXKey
         eeM6UisfbTvpXHWAfPvdaYHOWCcjxXZN7RufaEd7YZJeR9nDIwN5omPvg28zdp8nqC1t
         z8RwTsjwJotd0HL13WYnOUNf+69wMXS3cwM+So+rk2+ZSrOh/HLJ+j3J6WOiCZuHGzxa
         8kONUih5n5ahIB2Be5z7ak61Vdm5ea3vjSKnIO21XsPrlqeDKqEsKPFUiCuuYekP7ln4
         SrvKmFogTO4id90zQ4FNlzuPkhcUVkHBwsEaN9Qx+Su/ytkuv7elQg+Zuf63r7f4qpmi
         ZVXQ==
X-Forwarded-Encrypted: i=1; AKwUvByO56q1VIU6aRrn++7NfbdRZctJ23v9Tu2RtDjMN6lkuZS3UhkNmPVcvyqQx4+nEulcOMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEb5atSMbEt7Q7i3n0WCw9mj+n0LaEaamm3zjUQVvssLCia1w/
	6chsnrh76T8/HBWVNiTCk9XZC2fpGpjIWO3DHk1SboliMcOXZ5cFNa4Gvj6j4eT58bPHzVxanwT
	Vfswzkz4nm2tXPwcbFvrS9PW/3cswL3T+nqNb5Cvts2AwEORDm+IJSYk=
X-Gm-Gg: AYBFou0TKd1k6cDNzfuiRC2Vhfw8pitikvMy50rZ8HXIDbyK1g9iO5OrKKBHzeonZft
	r045uedAx9D3sLuj350Iqno50OY9Kt+4bi/PBL1sQ66NiMwkyXFPGrm08hkmPQi5wU17854ALiN
	7XnmAexXWkwNhUsiykX5XjdEC8Xh5S/A9sgG9154TeNUYRU8ZqVUyhw+5Uht7UmgJ5d3okVGnPl
	Fg7y4CiX8Rz1im8PmW09T7QvMq0tmuTusDIFf5TLBOCftX2BuH7a5DfbPhL0i3AGw9iPuywCqfD
	pODzkzCkPPQmz+urlYXPT72tg0aKaaTRl5/V2LLFdSxzvDQ1eGyMBBRz1FUjcffhJnHi2K9lfoR
	h4PJpxI+E97LhRkUWlVV8bnbCCWTQKG/E32aRsA==
X-Received: by 2002:a05:6102:4b1a:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7af1e4f8b12mr3623679137.24.1790605908336;
        Mon, 28 Sep 2026 07:31:48 -0700 (PDT)
X-Received: by 2002:a05:6102:4b1a:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7af1e4f8b12mr3623511137.24.1790605896839;
        Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc097csm4205378a12.12.2026.09.28.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 02/14] iommu/riscv: Prepare domain bonds for outer locking
Date: Mon, 28 Sep 2026 16:31:01 +0200
Message-ID: <20260928143113.49838-3-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba7a55 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=69OsnF3JIPtLgHPxktkA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: wiE52XzPpFbyRMKK7CEKvpvymn-fvgZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX5cTKxBCab21q
 0fWJMk/xMaHKfd0z9Dm/s6/KZQUGdTumgcrt0n0KsynsuVorLtSS5Qst+fuyF0f8dyo4anC1vbN
 hYE5OEHvGW0Xtn8m/LK3nk9yrISBX6qkWoMK3+70wZYdX/pPOWksV9G39zMojf1+ZTZW1cEnZDm
 iUFt0g4+hKtA8S8ZQWpzAmyKq/3E9poeqToo+7kZ2r8+wsXAQWpwix2WZx2QjtwAiR3/f5+0BkE
 sjo4FPX109Gl3l0iZn9RYqCg2rbiYFpCypY7C51UWgiOKoHFgOIjKg5aPTCxYyWr4z5UKyCKP+Z
 G2dZPnX9pXyhKrxqmV4NM3buzo/XOyWIeIWevmKM0Z0bHRUZ9p2Dy3sLyU1Ju/PkNRJwRqHXDaY
 yolfz+gCcurFVvZZdH/dp4xueLtal9R+ZJN9D2E6rVT47ULGfAq5Tueqkl8uY41CtYT4iIUGHuv
 WnzO79p6F7h9nU4sveA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX/xzSoe/JE5uw
 30dK151UOv8TZH0Vnh3EGzhVwsYGIYkF0ZSNqq27Hg+Y8LHxcrtRVXb/PMzSDdmAOv6v2uvtEkW
 yKFQw3PZfcVcryC7KEsY7ljVYv6GMas=
X-Proofpoint-ORIG-GUID: wiE52XzPpFbyRMKK7CEKvpvymn-fvgZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057

IRQ bypass will serialize attachment under a raw spinlock. Bond updates
retain their own lock, so make it raw for safe PREEMPT_RT nesting.

MSI forwarding will acquire the MSI table lock under the hardirq-safe
IRQ descriptor lock. Nesting the bond lock below the MSI table lock
therefore requires IRQ protection even for domains without an MSI
table, where attachment takes only the bond lock. Use irqsave/irqrestore
in both bond helpers to avoid a HARDIRQ-safe to HARDIRQ-unsafe lock
dependency.

Also split allocation from list insertion so a future outer lock can be
taken after the sleeping allocation.

No functional change intended.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3bbb4d0d0a85..09ec8c3e4a72 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -858,7 +858,7 @@ struct riscv_iommu_domain {
 		struct pt_iommu_riscv_64 riscvpt;
 	};
 	struct list_head bonds;
-	spinlock_t lock;		/* protect bonds list updates. */
+	raw_spinlock_t lock;		/* protect bonds list updates. */
 	struct mutex mutex;		/* serialize domain state updates */
 	int pscid;
 	int gscid;
@@ -896,34 +896,27 @@ struct riscv_iommu_bond {
 	struct device *dev;
 };
 
-static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
-				 struct device *dev)
+static void riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
+				  struct riscv_iommu_bond *bond)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
-	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu = dev_to_iommu(bond->dev);
 	struct list_head *bonds;
-
-	bond = kzalloc_obj(*bond);
-	if (!bond)
-		return -ENOMEM;
-	bond->dev = dev;
+	unsigned long flags;
 
 	/*
 	 * List of devices attached to the domain is arranged based on
 	 * managed IOMMU device.
 	 */
 
-	spin_lock(&domain->lock);
+	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each(bonds, &domain->bonds)
 		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
 			break;
 	list_add_rcu(&bond->list, bonds);
-	spin_unlock(&domain->lock);
+	raw_spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* Synchronize with riscv_iommu_iotlb_inval() sequence. See comment below. */
 	smp_mb();
-
-	return 0;
 }
 
 static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
@@ -932,12 +925,13 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
+	unsigned long flags;
 	int count = 0;
 
 	if (!domain)
 		return;
 
-	spin_lock(&domain->lock);
+	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(bond, &domain->bonds, list) {
 		if (found && count)
 			break;
@@ -948,7 +942,7 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	}
 	if (found)
 		list_del_rcu(&found->list);
-	spin_unlock(&domain->lock);
+	raw_spin_unlock_irqrestore(&domain->lock, flags);
 	kfree_rcu(found, rcu);
 
 	/*
@@ -1391,6 +1385,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_bond *bond;
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
 	int ret;
@@ -1421,9 +1416,12 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
-	if (riscv_iommu_bond_link(domain, dev))
+	bond = kzalloc_obj(*bond);
+	if (!bond)
 		return -ENOMEM;
+	bond->dev = dev;
 
+	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
@@ -1475,7 +1473,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
-	spin_lock_init(&domain->lock);
+	raw_spin_lock_init(&domain->lock);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
-- 
2.43.0

