Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021437A832
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606265; cv=none; b=XPO/n7fy4GIN1WzU3p6JpoY3vHOw65awNBBksjfSGPSWHWm1QGldpPyw0p+1n6+kN5aA7LrYP0AvKuKr/DtEReB10Vq9xrl8JoQXyWJYsnJtlbzdhTN3XiZlK/s6uRI2SaytrtLby7fyYUqi9s+OQLaWxdXidblwq0qyhKdamV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606265; c=relaxed/simple;
	bh=cjRzePwWQclJUJKIhRKrEwy8caVabOEtV4kllClzkAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbSV0k+0YKNIBzqyWu4nBW12Ock6T9b4O06w0yoSwMnGDiUtKcHoAhmj5tialHC3T804JGqtmim6cVdHVg4t2ckzKxfl2ZXWs8YwBAworcDYTSATtnCR9myyTXZOnl96pGhAdPvDD5U7qtD9kaHbkimrYu6wvNWJR/LUwcEviLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhsmkViQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VH9LShOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhsmkViQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VH9LShOJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAI1o1682983
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qxLv+wRWUPQ
	akyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=; b=PhsmkViQJCQemOPtl3iSwfqxLSx
	H1fsXQFhaw0QaJgQtyvDTJgSLVVQuvDwsotMKk2pwtHckkciUEGML0xfKcPf98Wp
	vin8jKqi1SaP3eleGdOEg7yBW5QbMfx7RF+6LAzz/jgrPP/GPEPtVaDOS9ztH4Tv
	Oc0Jh4N4HkqvGf+tQV6HRr8Fr2WrrUVzV+N3FFwOGYpg25m09BYu/iyOM49vJfdX
	VepGC9OC6VN1I5a7UxNpNlab3ygBmiSIrbtw/zbYKGyKNusJj+NdOWILbS+hVQmF
	t3OrWlUdMCKh/SwOazWzwIoNyuHMOHjZJvuMPy3K9+N+QE8cTGWzVdm4HLw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfks5y3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:37:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9855e11e5b9so3034146241.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606252; x=1791211052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxLv+wRWUPQakyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=;
        b=VH9LShOJlaDZcYeyHj2pNHnda0GIQBPm2xB/kELWzM4R4I1HVt1cn87EXYkSO8M4/b
         2GgRhSM7bHYSnzQZCdYGLv5CY+wh0SByG3+htk113bx6B3ItF7VN0DaLcw+UD44pwo35
         vzVyPJsypyTK6bVJg3vpNZLuu6jiGLcDGnFxEynfKARaye1zrI1Vx2uz1F+pAyAIC/cO
         D0MdFD9FY+cTcz9/rWqyXWYlotTpiBz7awj3g5b5xsMZkx/hUlVqqHNLGNMhpMfYhN6b
         7WVQw46HwDBmy8udATGjDi1OickeASftOwphAb4OsEj3YK9P1PGiF2XQsjgh+pGXAqiE
         YLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606252; x=1791211052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qxLv+wRWUPQakyE8xOuZTAbdosP4MYCeK2FTsiU2BFI=;
        b=bd/zYltxosGiXMUWGGP1k2LMRb52TY+q3HuT2NrYL7yHuo3Rgedyur34R+kb3LGRsD
         wICpY4jUYVxyMvcv3L+QCxWAhAITaN77pZZfUnZu/7+yQIIw6om4Ndimm/p7OA8SkHbd
         QteKXqxTb13KK3g3+jrM1BFbiuSuY0ZSeHU20XIgMlYzTV8TRlFdB46UAyCpk3VlIrwo
         tz6eRGnnGT6uJULD61lIif35tge+B95cReILCdJywT7xqWAZksvg0E/23mEWDmoqTMp6
         IkjhN/KTAM6Jj5Lt44dyZm7teynbHJ81ICXgmfnZOkBEw05AX/VMfLduopN/j2zpxbif
         SLRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYJcsRY3RZq/uy2XMXsbVKc/JmSCXaCvenlJI2s1tP8qV1hSqd3dgzHRz9rstOgiArPfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJp0Ftvff+Ch+D2PELGM7PtwGFHWm4tRg4N5VBfy6zX3RLk/ahh
	PrctcXVwGHRPm9dls9P4/sf+M0KaSwMJjSrT97vy1Rpu77yf7DdHeM7tB36B+L0bPIucAvRQBPV
	2vRmbWAm90FOHOl3Bgtp+QJqcH5tmlN50OZ+D4O8MNJLKfLzYxEi1N5SY9uoJwXQ=
X-Gm-Gg: AYBFou0kHsbZp9qFAQrc+0u2t3t/edx4xbkt3dyRvBkmaWhzhQE47kiFkF2VyhHmm8C
	9+NJPZvWuio97UgDvUqY3AaifiwAUtZR9dAEauE4lx0okqZ4gX8Tp7Eo8+I/XNThRYLB8hFBupr
	JB3cc0GpTnGyudjN3qOThdYy/cX7ebKwJ9BTj/pvkAn5tnKGfO+E8T1wHaNgeWGxRYJFLXxf1wp
	4+8SIAcQNEBBVxTKuj4KHsJoQ3CeE0nMvO2Ya+2BEmALhwTx78ergK1BEOd/pTbbQY/UfHXAaLd
	FxfiJDcA6CDfHp1juRiPuTDFlrOPjqPjkXFaabRE5SmI4mR1uTRa5blEnHSr9yEu4G5Mf8lptPY
	uvBrhI4Hce6fjL994yhHJysbulkcZa4OaNtEqBA==
X-Received: by 2002:a05:6102:8089:b0:7b5:1ca4:9de5 with SMTP id ada2fe7eead31-7b51ca4ab04mr1049899137.4.1790606252507;
        Mon, 28 Sep 2026 07:37:32 -0700 (PDT)
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3265770137.29.1790605900321;
        Mon, 28 Sep 2026 07:31:40 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaecf2f62esm4040194a12.27.2026.09.28.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:39 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 04/14] iommu/riscv: Reject live S2 replacement with forwarded IRQs
Date: Mon, 28 Sep 2026 16:31:03 +0200
Message-ID: <20260928143113.49838-5-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXypgbYFLY0UFm
 BqnaSH2R0EjQNEik9F/aHdMFvE9fS/ruZvhvvBTTqwjDzLNaB0Zj7ZjMglc4aQLtN3CCgqhc05K
 dliuCpINf0ebaQnW4xUDxq7s0IVEhhe3aMsTC7mqsbI/cuUyxVqzVeZ+hw8X8lj4e0rVcg2vAeQ
 Aap1bFB5mc5auj/vXxM937VRAlhEl7O9fJWPmBqYSGuxOsEyUhejMbThV8azH5RNEUD2zvy3P7t
 Xk4uU6CKWeXqiw75x+tbbdIr/wWF72I0bKTxCmxt92erE2TGvP4MTzrcSJy3D4Mjcg7t028NrWW
 t2/jyTo9k9JdYaiw7N1+Z3/opRX7VtDDdUnIXbQ0uPSH7ILn0+nN9t3zJ0gcUdFzFzVlAyHYsxt
 kM+8glcPUFr4cisZ2JAcbLIMqUUT+m8JXo7E8J6c5V1FjU9caAxC5OkPMOiJKhsuKBrw4hVth1D
 ZJglmXTmjbC1gsTkF9g==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba7bad cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=t97w11WlQ40Dee02AfYA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: VhWkpKdDZssckNo_UtgrwQwo59kGp_kO
X-Proofpoint-ORIG-GUID: VhWkpKdDZssckNo_UtgrwQwo59kGp_kO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXw+tm7teqNKyA
 4b+vk/YgUae94oXy7x04/Qg/JNGzhNooM9f358lfCx69yIEJ1VzUiseER+YKa5+FzowJ7wB/MU6
 3ZycwtiXM0kJmnI0MSoI/tMK8eA/xEs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

MSI forwarding state is tied to the S2 domain MSI table. Replacing a
device's S2 domain while one of its IRQs is forwarded would leave the
IRQ state referring to the detached table.

Reject direct S2-to-S2 replacement when the moving device has forwarded
IRQs. Introduce a per-device nr_forwarded_irqs counter, rather than
domain-wide accounting, so other devices in the same IOMMU group can
still move and can be rolled back if a later device fails.

Later patches which introduce interrupt remapping support will manage
the newly introduced nr_forwarded_irqs counter.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 57f2884dec42..d48667112cd9 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -872,6 +872,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	unsigned int nr_forwarded_irqs;
 };
 
 static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
@@ -1432,6 +1433,36 @@ static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
 	return 0;
 }
 
+static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_domain,
+						 struct device *dev,
+						 struct iommu_domain *old)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	bool new_is_s2 = domain->gscid;
+	struct riscv_iommu_msi_table *new_msi_table, *old_msi_table;
+
+	if (iommu_domain == old)
+		return true;
+
+	new_msi_table = riscv_iommu_domain_msi_table(iommu_domain);
+	old_msi_table = riscv_iommu_domain_msi_table(old);
+
+	if (new_msi_table)
+		lockdep_assert_held(&new_msi_table->lock);
+	if (old_msi_table)
+		lockdep_assert_held(&old_msi_table->lock);
+
+	/*
+	 * Per-device accounting allows other devices in the same IOMMU group
+	 * to move or roll back while this device has forwarded interrupts.
+	 */
+	if (new_is_s2 && old_msi_table && info->nr_forwarded_irqs)
+		return false;
+
+	return true;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1477,6 +1508,11 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	bond->dev = dev;
 
 	flags = riscv_iommu_msi_tables_lock(old, iommu_domain);
+	if (!riscv_iommu_can_attach_paging_domain(iommu_domain, dev, old)) {
+		riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
+		kfree(bond);
+		return -EBUSY;
+	}
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
-- 
2.43.0

