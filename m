Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B734E3232
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606384; cv=none; b=qgiZ37l1bTKxkh3826/FvKc0whyOs3sJMBLKwIOhd//0pXfVp/gLliEoBuyNx1B2JtO0XNm8NIY4ImLah/W386nm+Cnk+USYVt70aVSGg2n122ZS7VgfWnB2Va7ZZo3h3heosWjwuZXmtkS7z+nlEQluyZuhKobqDMJAUw5eIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606384; c=relaxed/simple;
	bh=1mRl07ST/iJhykaW3wF3eXHlnR3DTJeLAgQFLYXJDnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyWhaGX0n4f6Q+x39SgRKZj9wHC8IYMDuISeA6PvOzn9ehyzraAEN1wNQR3aAC+7SHXbnBdC7jqxKEYnquO7vHMXkQHBN9hedhuDad/jsaFTbXb4anc0aXjth2/u70Z+2cVyCs9t3EwzjnEDdnAigH28CtCdEKRUYcLLTd8Gi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ninvScti; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fl9wdss2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ninvScti";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fl9wdss2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAOkb2294806
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jvlI2T8w+64
	hQrpum98oA1DnDUfoowHi2+WuxN0638E=; b=ninvSctiq/nMCrPjojeVd+h7piV
	MkS2L0yVYz80LV5d/CefxgMB16lyAZhxotakiwoBSpDK+1NKDQLiDyBCcl6JhcL5
	0cVwUZ2Lgk7ZKuCNfd/Dp/nJAWjYmR7S2mmbcrUcZsprSqQM5fj+HuvbAOXn3x45
	ALQZ2QnrTVXvEtxkzgwL8rVJg/Y9I0Cbzb+LPsN6OrFjDBC8cbcVETgQa/t6y5wX
	wsF8RTOlSs7uYGLAvc3y8W4UF98GAfijitszPClypIQKEN0ib4RvALb9cZ0sxP1H
	/FygaS5wZHxSsf47sjUpIdUEtJEP/+158ZrYE6ERboIsnX1Nb8d6xOMa1wQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubj1sv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14383177746so6421135c88.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606369; x=1791211169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvlI2T8w+64hQrpum98oA1DnDUfoowHi2+WuxN0638E=;
        b=Fl9wdss20Klgccjx4iLW9an57xcL0zXtvuiOCS92+iCnQB486rQYCKkCSxMaF6k3Rj
         Wb+W/vdn5JCAS/qWS2Fh+X464orl+2CvHEp68aPfWltPcqbkGo2ib7ryQg9WKUEIeqkC
         5Mzj+lVmzyB4eU2m+/hhIE4s22SYgde5q7K6oijmiFDddbfLElgNOWehDqC4F2ZePupZ
         z5W0IbKX30u+IwrvwlZQOwr+MFyhZXv3f9n90y69GARmI8h+NCktO10ZtcU3lz6MGpi3
         Mq8yMdY6X6NlkkkaIl1ylS/7OrE4uBDQEGgng8fJgt55ga2zkKEFRpLePXnhMmP8MZ6W
         /b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606369; x=1791211169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvlI2T8w+64hQrpum98oA1DnDUfoowHi2+WuxN0638E=;
        b=bbSc+u5w/nCV8WCsXJqReG4XA5PgdZPkPhHOknIS0HvXbuwQQJp7ikdNgg1kQFxdPL
         Z5FJdhI/JI8BOJHuOEZQqG+/H8RVPPXq5TBua0DjbeMgEq4TMFS0JUpBaoIq4E5zUmqM
         tMKu0QDK079WtaMk7Aqvqw5vWl9hlbXxBfLpXbO4b9ElZKotUQ1us8IkZXut93nl9WV9
         CVC76kQrACASjNBwst8P2OrN6Md56JF182NCE32N6rxw2dSeu5GCspW7vjXw7R+DyqZm
         Ot3fKsl6IsjI5gd0w7RGJNQRTvOGbSxxZZhcAuyQIR9BXsG7I5ny9hvW/2ioIA5q26Xi
         OpfA==
X-Forwarded-Encrypted: i=1; AKwUvBxS7xe2MsiQQ7DW3hNbDDyO5iZqbevKT2MfC5toafc25bwpNK6La7NCE+zgt88XXJnBKms=@vger.kernel.org
X-Gm-Message-State: AFuF++kd2NfVl3RjOIc/O4SAGEunDyo37p2pU1yyFCKF6tYMCG1MPCRh
	sbH7Avf08PoxtNnYYiobGb8KFRjGNGAu/pZYcKLY2g6fTu1P9PaKadnUJRB823T6pQI1LTF9SV0
	JxiBg9xtQzd1z293KH2QDFb6+wNsrsBqngSEHiRT4TC+3E5BKvbqb3qU=
X-Gm-Gg: AYBFou2TEcWMCJcHpLDDVYKbpPgWDXAgIgvn+OJh6N2/XKohGopChWCgsjHH0SpgrxJ
	JQJTb/pZNRO1gC6SYWE2vI13AsqTFmiGuFPfM+ISLHIMV/82askV1CvUBU4B1iLu9+/7Z+gzwGk
	2M1Ops9pgCqyF7WOnF++F/fuXi7CXEaGr0llaDHwcjhTr5WDf5d8ujbJJwyQTYa/bRHlZpPmg8k
	kkl4YETPzvD8NS3cll+mbw8QuyOicAN7AOR8c4O/1FvXMgW9g6O5KbpJpuy/qwfA/9SC3f8tmZK
	M3NDc4f1Mh01p5llz40hhGC+/yB3NL66CcBtzhGH4mVPhPnSp/K2tsXkRo2j9yMiV/2X21GThyT
	UxIUpnDVnA8wiyHpHy2mRjK6SVpox8u08tXnDHw==
X-Received: by 2002:a05:7022:5f02:b0:144:c124:279 with SMTP id a92af1059eb24-146d00bb34bmr10912376c88.35.1790606368433;
        Mon, 28 Sep 2026 07:39:28 -0700 (PDT)
X-Received: by 2002:a05:6102:869c:10b0:7af:81dd:a9d3 with SMTP id ada2fe7eead31-7af81ddbe26mr2436839137.29.1790605898562;
        Mon, 28 Sep 2026 07:31:38 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76ad030sm484086466b.36.2026.09.28.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:37 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 03/14] iommu/riscv: Serialize MSI table publication with domain attachment
Date: Mon, 28 Sep 2026 16:31:02 +0200
Message-ID: <20260928143113.49838-4-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: c--j2OWKByw2xr7zpiiLPUUKBIr0EZG4
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba7c22 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=BJuWs42claz3fuW2R7YA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: c--j2OWKByw2xr7zpiiLPUUKBIr0EZG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX0Mz9A6AyjANT
 U19HFTXwde7tFfSksg2+WVz5WK46ixPUfZ5ovI65xZQceQJ00penrxvM3m3ughvRS6hp2FzDWoH
 +eZ4KetjNaYJdbob5m0uakNSDyE35BxmQVUSRqzTnhf9bvImoGRbWpL1AR9jVZl5FQTv288av93
 aZ9VfcyD33bJNZi9nSPnCYNlX54wjF0VwTElErs9o3DY2+9JWEKHAXt+Ga2eJKXsglXhyKRJfsW
 E7DaxO9DVQqZNZIlKFHhq0h4Eem4PS3uI/K12f3as05IdlBEpleJGb5BC/UAuadU6MSSdM133qx
 IEHAJaaya3NQRvlRxRDZiIVfKLH/GxnCWxgjqr20XfGgy2J+Er48IDpusjyBjo0h90aUFtKLjXn
 JoWVHVqSQLyeBFsRmmrUguR46rBJYYe+gdkfL0/veWfnB0VYqVXPwmmswbVu8N0MkZtXMOQJOFo
 yjuiJpMXUckT2QRvSCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX1vdzmkLlcTy1
 CXD+4Akrw41nr72RqToEhXlHf/hcxSqdwd5yrDMxnBCrZPNyO4Njh1ERNG93miUzE5ySeLMtujm
 vuKnSQkQqMLLf2o1Z3+xyta80TGXhIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

DMA mappings update entries behind the page-table root installed in each
attached device context. The existing bond and barrier protocol ensures
that attachment either observes a completed page-table update or is
included in its IOTLB invalidation.

MSI forwarding also changes whether the MSI page-table configuration is
installed in each device context. The first forwarded interrupt
publishes the configuration to all devices bonded to the domain, while
the last removes it. These domain-wide updates can run concurrently with
attachment because devices in different IOMMU groups have different
group mutexes.

Serialize attachment to domains with MSI tables against forwarding state
and device-context updates. During domain replacement, lock both old and
new MSI tables because either domain may process forwarding changes for
other attached devices while this device moves. This also prevents an
old-domain RCU walk from overwriting the newly installed device context.

Order the locks by address to prevent opposite-direction replacements
from deadlocking. Domains without MSI tables continue to use only the
bond lock for list updates.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 64 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  2 ++
 2 files changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 09ec8c3e4a72..57f2884dec42 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -874,6 +874,60 @@ struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
 };
 
+static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain;
+
+	if (!iommu_domain || !(iommu_domain->type & __IOMMU_DOMAIN_PAGING))
+		return NULL;
+
+	domain = iommu_domain_to_riscv(iommu_domain);
+	if (!domain->msi_table.nr_ptes)
+		return NULL;
+
+	return &domain->msi_table;
+}
+
+static unsigned long riscv_iommu_msi_tables_lock(struct iommu_domain *domain1,
+						 struct iommu_domain *domain2)
+{
+	struct riscv_iommu_msi_table *first = riscv_iommu_domain_msi_table(domain1);
+	struct riscv_iommu_msi_table *second = riscv_iommu_domain_msi_table(domain2);
+	unsigned long flags = 0;
+
+	/* Address order is stable when the domains reverse roles. */
+	if (!first || (second && first > second))
+		swap(first, second);
+
+	if (!first)
+		return flags;
+
+	raw_spin_lock_irqsave(&first->lock, flags);
+	if (second && second != first)
+		raw_spin_lock_nested(&second->lock, SINGLE_DEPTH_NESTING);
+
+	return flags;
+}
+
+static void riscv_iommu_msi_tables_unlock(struct iommu_domain *domain1,
+					  struct iommu_domain *domain2,
+					  unsigned long flags)
+{
+	struct riscv_iommu_msi_table *first = riscv_iommu_domain_msi_table(domain1);
+	struct riscv_iommu_msi_table *second = riscv_iommu_domain_msi_table(domain2);
+
+	/* Recreate the lock order and release the pair in reverse. */
+	if (!first || (second && first > second))
+		swap(first, second);
+
+	if (!first)
+		return;
+
+	if (second && second != first)
+		raw_spin_unlock(&second->lock);
+	raw_spin_unlock_irqrestore(&first->lock, flags);
+}
+
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1388,6 +1442,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_bond *bond;
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
@@ -1421,10 +1476,12 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		return -ENOMEM;
 	bond->dev = dev;
 
+	flags = riscv_iommu_msi_tables_lock(old, iommu_domain);
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
+	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
 
 	return 0;
 }
@@ -1474,6 +1531,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	raw_spin_lock_init(&domain->lock);
+	raw_spin_lock_init(&domain->msi_table.lock);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
@@ -1569,13 +1627,16 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
+	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
+	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
 }
@@ -1594,13 +1655,16 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
+	unsigned long flags;
 
 	dc.fsc = RISCV_IOMMU_FSC_BARE;
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
+	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
+	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 6bea9da71ff3..2876703a6698 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -69,6 +69,8 @@ struct riscv_iommu_device {
 };
 
 struct riscv_iommu_msi_table {
+	/* Protects attachment, interrupt forwarding state, and MSI PTE updates. */
+	raw_spinlock_t lock;
 	unsigned int nr_ptes;
 	struct riscv_iommu_msipte *root;
 	u64 msi_addr_mask;
-- 
2.43.0

