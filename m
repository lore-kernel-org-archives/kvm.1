Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4D4D8D97
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605954; cv=none; b=A8p9EISG7ONhCw40a4bD3jV784q1CYQWo92pqKJttmr4cBTu7BMt8bAg5sTvscC/f1Ej6ku/b4KvxAJBRdBUSnFd66gkygCX9nd69u7oKZ3xL/mEDyCDYDdxZlSLNsjN6YoPU8u9Dfv571vfkBIyYhNVcxeY9GcRodIqkEs/woE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605954; c=relaxed/simple;
	bh=OkQmDEYnyASIKXPi/oPrzOVrVCnezyFBIBwxR3DV+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tncijKIB39dQMitWQNfzY3f8tf4DqIpQWDL4IsOrgqy1aI2oKbvYlhkaKsjog7P0X2rA9H/tUnF3QMjqkijQaT+h+UAt0JRJlCixgtvZSauvKZNLdIBRdAOWFKC0jXKd9kkMiBk42oMJqsgLXl/P2dtQToUG14JWx4Y8vN3kta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1lvity3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UshRBAdX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1lvity3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UshRBAdX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAPPh2294821
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tebmqV7yCOW
	UuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=; b=F1lvity3l1MF4Z9dAHH1Wo09WAW
	F+V4zrpfdEK8L+NQ/v2KtbxpP6z7/QGlpNWSdVGve3NMMt6EDHiQD7KULT0doEs6
	Df9TpuC1QZYvDO96q2ED4+nqH4GmEGvKxrIq9p7D+8P734Gq+NpN9/D/x60d+0Qy
	BPQUG4HQNqEW8z1PyFX21py9FnG9qMJeuLk2kvX0XExOUR4F5h1nVTkztwp7PnPN
	4VkkOCQ5hTEJpLMht0WJC6g37JMH9APOGcpM0qUPlHzr6oSTF6JEUYG44noD9Mu8
	9FztFj4iCJClY2PF57YIrz15FgHNKjHXVFVZf01u6ofHdoUb5bnbZky2qUQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubj10n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:22 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9806756ea40so2370280241.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605941; x=1791210741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tebmqV7yCOWUuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=;
        b=UshRBAdXLQ/0KGztu8biX/kc2PAt+gzkEAYcaDNlShAzoGhgqU75BvPoGF3RUGRGiz
         EXsra2iGDQQG1Tzbd2zD7HPDmS89TXwrSpVkerh+ljvFTi++z6KFMLLs/QeUxoRWHJz5
         /O/XZ5K0YsiBF1Xo6BchThcuiTuiOZZ41xvlokF1fKYKLzpJnjrkP0g9xni+gdTL/eEQ
         5BR/cttADEhQHR0LsOfjTR+m4zMLMt2zBR/nWPjB+Xga/mTIUeORTNp7p6nBtYhVgKRA
         buPTe+RxphJ3phGjyJK50eYdb1GijncgdG/om/OI1D3Hdmdsfk0PYNWxseDM/2v3RDvP
         sBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605941; x=1791210741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tebmqV7yCOWUuIVhUGJYMDQXIsJi15ImmfVHeeil9JY=;
        b=S20mO5wtaQC8Fv8SImy6d1enn17ZBA0F9KQC2kOwGaW6I3dMni+0bIUd1kY759CYXc
         AT0JqZj+mnNtVU6BlrArvIr38KJU7+E2SYFju0ZrIKSVAI6T9DOMSplKSm49zFBn/vVw
         buiBWPNef9vgO4ipmo8t5RsxbiMwFwHIL/A1L9guUWHCJvb9OddUesBPdj276Ees6qGy
         9QaTnqPKPdInWDKNdZVmxk0Q6o7dTl/krYZcGxGCklo3EKshHZPS2/1w5bdc+0s2Ce17
         rXtEqabFpLEegdsRusoc1tVFx8+F9KZvDFZLX7scfeljQfHmRbU6n1Ab6KFop6icEbHT
         6QYA==
X-Forwarded-Encrypted: i=1; AKwUvBz95ZzaqwYL9JflX69HmPz5ez28pZrvIRDqAzZgwJ/XgVrrGZkZ68/PEUxiA0aHM3ODzOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoz/gy0kN0Xn5IBv8SAGUtwFveZVJpK26+Bh1rM7tpgfaC+tLa
	9OQ/t4vJ2dzinLUMlWNYgoVffV3jBW85bIQVTuBzHkSfnlbwulIJ6Snn9L/nY8EzKjvngR30GVA
	To0pl6lkJaoWrmv/W5Xmr9OcEgJ5EXJg/nGHc6MSUBBiGdD/xS+8thEM=
X-Gm-Gg: AYBFou285QeKzsTTM20nXx6UsEZA/YqA8YC59BBd2sZoiwDGMxyvgQ6lTmd70/U5WmH
	mEdQz8GvDIYiiqNWVJWoIbqooH0TRqAqdfGsj3n1XNPzY83MCMJyYjJuNrLgSsVgNZ1uCXvWJIy
	Vcw8LQBhpF+EoARLr9CqX+kYZoVzi7FmsVCa/v94eOz0kISjb3USfu3DomoyP9bWvfVEb1pRyJ7
	IBysBD6sZ5hcmTPzYH6FU7w81pA2Ff4R4Bsohg2gbJfv7sW2rKeyZP6PgVRKZCO4UbR85Ax64VF
	FhmP7yEsc5zCK4BGfTbasrjjWrW4aV7vyPlmhsV8NjAI8zCheGYa13ZfDnl5GaMFj1mWve1AE+V
	NH9CQe1jOZIEl0pPRjmO4C4VB7VqCYfi1JUgK/g==
X-Received: by 2002:a05:6102:6896:b0:7a4:a8c4:42bf with SMTP id ada2fe7eead31-7b3b92d1b94mr1507281137.17.1790605941440;
        Mon, 28 Sep 2026 07:32:21 -0700 (PDT)
X-Received: by 2002:a05:6102:6896:b0:7a4:a8c4:42bf with SMTP id ada2fe7eead31-7b3b92d1b94mr1507262137.17.1790605940898;
        Mon, 28 Sep 2026 07:32:20 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm255359866b.1.2026.09.28.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:20 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 13/14] iommu/riscv: Validate IRQ forwarding requests
Date: Mon, 28 Sep 2026 16:31:12 +0200
Message-ID: <20260928143113.49838-14-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: 7Cj6nl0vwedJ_h6Py4PtyYz6sFnp9DK5
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba7a76 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=h2dR55gVlEbTIpH6insA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: 7Cj6nl0vwedJ_h6Py4PtyYz6sFnp9DK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX88VtvYPyvBos
 AscUGajZwB26YGfR1qyp3pXmXJIEIcd7LbEl+3oqHn2ZQyql3wmhKmnYjB9txd160hhYGANE4yK
 bzIO6eCqgRTi1CWi9oJgQuFNP41XcJbbAKuoWW4dRKIcP5YeOjQdLZaSNvYKJ9uqZwZuro9WOof
 b+BOiQ20o3L3wuGZ9SWyMC98CSJLlEEfy74zZJOTDyE07ckr6SL+0+ufITgvkQ/NF3ehDVa99GU
 qHu+//6QLGUx5qUhMtyBGQAeaLp537zOXhLBxu4e9Om9vueTuYMb7jj2W06ph2UXsDbtWjBYlit
 jjK5ILYIxBrk1A3Iuo8RYh4pTBa6PSFGw5glMHvMmO8pP/um64xpbloWBU0qb+in0o08ver4m5O
 cEH7IR5TgKdQMEhixLDx6WvlWfvrlDO6O4j+ORTs7sbW/aZkc0NEsxxQWnxAftAk74RKn8iYYR0
 shLJpydQnlsWCdKjNrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX9Rmt+jbG6bbA
 iuiSJX1afU8n2vBJFYo6E+3mXlV/0QJRdfEFiKoaChSYZ0Q3FWKuEiOJQQpQL+PgRiclE7ILs4I
 7PlhPHaGFprn+AxfcqfQtzB0m1uQKPk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280057

irq_set_vcpu_affinity() receives an architecture-specific description
of a guest MSI topology. Invalid address layouts or targets could select
the wrong MSI PTE, while accepting a mode unsupported by one of the
IOMMUs serving a shared domain could make interrupt delivery fail only
for some devices.

Validate the request before the table can be activated or updated and
distinguish malformed input from a valid configuration that hardware
cannot support. Check capabilities across all IOMMUs bonded to the
domain, and retain the requirements of an active table so later target
updates and device attachments cannot weaken them.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 127 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.c    |  31 ++++++++
 drivers/iommu/riscv/iommu.h    |   2 +
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 22da76987c7c..12a5d0bc77f2 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -20,9 +20,120 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 	return irq_chip_set_affinity_parent(data, mask, force);
 }
 
+/* IOMMU extract (RISC-V IOMMU spec section 2.3.3) applied to the two-run IMSIC topology */
+static size_t riscv_iommu_ir_extract(u64 value, u64 mask)
+{
+	/* Separate the optional group index from the low guest and hart indices. */
+	u64 upper_mask = mask & (mask + 1);
+	u64 lower_mask = mask ^ upper_mask;
+	unsigned int shift;
+
+	if (!upper_mask)
+		return value & lower_mask;
+
+	shift = __ffs64(upper_mask) - fls64(lower_mask);
+	return (value & lower_mask) | ((value & upper_mask) >> shift);
+}
+
+static size_t riscv_iommu_ir_nr_ptes(const struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	return riscv_iommu_ir_extract(vcpu_info->msi_addr_mask, vcpu_info->msi_addr_mask) + 1;
+}
+
+static int riscv_iommu_ir_validate_target(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					  const struct riscv_iommu_ir_target *target,
+					  u64 *required_caps)
+{
+	u64 addr = target->gpa >> IMSIC_MMIO_PAGE_SHIFT;
+
+	if (!IS_ALIGNED(target->gpa, IMSIC_MMIO_PAGE_SZ) ||
+	    (addr & ~vcpu_info->msi_addr_mask) != vcpu_info->msi_addr_pattern)
+		return -EINVAL;
+
+	switch (target->type) {
+	case RISCV_IOMMU_IR_TARGET_IMSIC:
+		if (!IS_ALIGNED(target->hpa, IMSIC_MMIO_PAGE_SZ) ||
+		    (target->hpa >> IMSIC_MMIO_PAGE_SHIFT) > FIELD_MAX(RISCV_IOMMU_MSIPTE_PPN))
+			return -EINVAL;
+		*required_caps |= RISCV_IOMMU_CAPABILITIES_MSI_FLAT;
+		break;
+	case RISCV_IOMMU_IR_TARGET_MRIF:
+		if (!IS_ALIGNED(target->mrif_hpa, SZ_512) ||
+		    (target->mrif_hpa >> 9) > FIELD_MAX(RISCV_IOMMU_MSIPTE_MRIF_ADDR) ||
+		    !IS_ALIGNED(target->notice_hpa, IMSIC_MMIO_PAGE_SZ) ||
+		    (target->notice_hpa >> IMSIC_MMIO_PAGE_SHIFT) >
+			FIELD_MAX(RISCV_IOMMU_MSIPTE_MRIF_NPPN) ||
+		    target->notice_id >= IMSIC_MAX_ID)
+			return -EINVAL;
+		*required_caps |= RISCV_IOMMU_CAPABILITIES_MSI_FLAT |
+				  RISCV_IOMMU_CAPABILITIES_MSI_MRIF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int riscv_iommu_ir_validate_targets(const struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					   size_t nr_ptes, u64 *required_caps)
+{
+	int ret;
+
+	if (!vcpu_info->targets || !vcpu_info->nr_targets || vcpu_info->nr_targets > nr_ptes)
+		return -EINVAL;
+
+	for (unsigned int i = 0; i < vcpu_info->nr_targets; i++) {
+		ret = riscv_iommu_ir_validate_target(vcpu_info, &vcpu_info->targets[i],
+						     required_caps);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
+				   struct riscv_iommu_device *iommu,
 				   struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
+	u64 pattern = vcpu_info->msi_addr_pattern;
+	u64 mask = vcpu_info->msi_addr_mask;
+	u64 required_caps = 0;
+	size_t nr_ptes;
+	int ret;
+
+	if (!vcpu_info->owner || (pattern & mask) ||
+	    ((pattern | mask) & ~RISCV_IOMMU_DC_MSI_ADDR_MASK))
+		return -EINVAL;
+
+	/*
+	 * riscv_iommu_ir_extract() requires the mask to contain the low
+	 * guest/hart index run and at most one additional group index run.
+	 */
+	mask &= mask + 1;
+	if (mask) {
+		mask >>= __ffs64(mask);
+		if (mask & (mask + 1))
+			return -EINVAL;
+	}
+
+	nr_ptes = riscv_iommu_ir_nr_ptes(vcpu_info);
+
+	ret = riscv_iommu_ir_validate_targets(vcpu_info, nr_ptes, &required_caps);
+	if (ret)
+		return ret;
+
+	if (!riscv_iommu_msi_table_check_caps(msi_table, required_caps))
+		return -EOPNOTSUPP;
+
+	if (nr_ptes > msi_table->nr_ptes) {
+		dev_warn_once(iommu->dev,
+			      "guest MSI topology requires %zu PTEs, but the IOMMU domain only supports %u; using host IRQ delivery\n",
+			      nr_ptes, msi_table->nr_ptes);
+		return -EOPNOTSUPP;
+	}
+
 	return -EOPNOTSUPP;
 }
 
@@ -34,6 +145,18 @@ static int riscv_iommu_ir_deactivate(struct riscv_iommu_msi_table *msi_table)
 static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
 					struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
+	const struct riscv_iommu_ir_target *target = &vcpu_info->target;
+	u64 required_caps = 0;
+	int ret;
+
+	ret = riscv_iommu_ir_validate_target(vcpu_info, target, &required_caps);
+	if (ret)
+		return ret;
+
+	required_caps |= msi_table->required_caps;
+	if (!riscv_iommu_msi_table_check_caps(msi_table, required_caps))
+		return -EOPNOTSUPP;
+
 	return -EOPNOTSUPP;
 }
 
@@ -42,6 +165,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 						       struct riscv_iommu_ir_vcpu_info *vcpu_info,
 						       struct riscv_iommu_msi_table *msi_table)
 {
+	struct riscv_iommu_device *iommu = data->domain->host_data;
 	int ret;
 
 	if (!vcpu_info) {
@@ -59,6 +183,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 		irqd_clr_forwarded_to_vcpu(data);
 
 		if (!msi_table->nr_forwarded_irqs) {
+			msi_table->required_caps = 0;
 			msi_table->owner = NULL;
 			msi_table->msi_addr_mask = 0;
 			msi_table->msi_addr_pattern = 0;
@@ -72,7 +197,7 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
 		    irqd_is_forwarded_to_vcpu(data))
 			return -EINVAL;
 
-		ret = riscv_iommu_ir_activate(msi_table, vcpu_info);
+		ret = riscv_iommu_ir_activate(msi_table, iommu, vcpu_info);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 514470291fd9..55c167df2c2e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1441,6 +1441,33 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
+bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u64 iommu_caps)
+{
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu, *prev = NULL;
+	struct riscv_iommu_bond *bond;
+	bool supported = true;
+
+	/* The MSI table lock excludes bond updates for this domain. */
+	lockdep_assert_held(&msi_table->lock);
+
+	domain = container_of(msi_table, struct riscv_iommu_domain, msi_table);
+
+	/* Bonds are grouped by IOMMU, so validate each IOMMU once. */
+	list_for_each_entry(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+		if ((iommu->caps & iommu_caps) != iommu_caps) {
+			supported = false;
+			break;
+		}
+		prev = iommu;
+	}
+
+	return supported;
+}
+
 static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu,
 				      int mode)
 {
@@ -1512,6 +1539,8 @@ static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_doma
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	u64 required_caps = domain->msi_table.required_caps;
 	bool new_is_s2 = domain->gscid;
 	struct riscv_iommu_msi_table *new_msi_table, *old_msi_table;
 
@@ -1532,6 +1561,8 @@ static bool riscv_iommu_can_attach_paging_domain(struct iommu_domain *iommu_doma
 	 */
 	if (new_is_s2 && old_msi_table && info->nr_forwarded_irqs)
 		return false;
+	if (new_is_s2 && required_caps && (iommu->caps & required_caps) != required_caps)
+		return false;
 
 	return true;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index a42f0b6a88d4..9852962e245b 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -83,6 +83,7 @@ struct riscv_iommu_msi_table {
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
 	const void *owner;
+	u64 required_caps; /* RISCV_IOMMU_CAPABILITIES_* required by active MSI PTEs */
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
@@ -104,6 +105,7 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
 /* Caller must hold rcu_read_lock() while using the returned pointer. */
 struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info);
+bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u64 iommu_caps);
 void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
 void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
 void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
-- 
2.43.0

