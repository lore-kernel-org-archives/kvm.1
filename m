Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AC4DE72E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606328; cv=none; b=hg32GGJPihIkmnnwqR9Y9DOMzrQwzW7P9j3NfAYuOy+vpV2ThLTBM5/2RDFDTFUDoUfgC9yowT0+X30Nljpi6USC/qyidGZmm0X98RnPefQ3Dn7h++Cimp3KyWBDSqXAzxC6kZVh4A4ypJjsvg6SyFq+Y/TcuOwv0l8iuAtrhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606328; c=relaxed/simple;
	bh=6+0DWiSp+YJ+CXzkCnouIZkDFMyzgmzRkD4nj0FZ+mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izToZnmb3hb4RGBJL2TxnVorK2IiBlBGtTywDSXJsVxgBMto9BG77sOD/ULtKfU56/f5pkphhT/NAKdJ8v5Dg8qjeRy+HaYd5bZkpQ9hmwIdtAwb9otdIxD0XUGKMi/75X5b8feibdHPeiNUF7Do/vFR9q90lug7bjPl69QO5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WoWqgFa0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atmL2mzc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WoWqgFa0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atmL2mzc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBATDb1450529
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GRnT15XNTnT
	hRrBqENhdYd5BF9k1QXVVKb1KnU2gCEA=; b=WoWqgFa0/f0SN3SxSiWmUYkaO6R
	1oUPDoF+umGUVOzH8Iad152juDLgd09JrFVAoyVqzgKDeuVTc0SofRQLlaq/r2jj
	AZOuJuxqL/LJm6+Ql53rM8Tu1gQ8PVh9S50+ip25xjUGERpRkidq5Lnb+44pGtsj
	zW/v/K9crCbqVwiv6MqJ/1B24qVLQG2E2BSxZmdrMkh7dafVV5239BDB9qj0v9FU
	cnlBFAPlrIcg08lMKPnlQBDW4yxuxvljDet6l/Mr6PXArm2yZ0H3vuaEoffiD1tD
	/P6GAPhY417P4dxn//WksCEIQAQW/58B99QxTOwGltQ5alIzz882n1cq2wQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxhwpf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:38 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e778acdbc6so2789955b6e.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606317; x=1791211117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRnT15XNTnThRrBqENhdYd5BF9k1QXVVKb1KnU2gCEA=;
        b=atmL2mzcaXvg8XBKqvFeEXmpIHk2NMnqkRwR7XVaeCq45zssmsD1fnI9lwfQkw6ry0
         uwh6vEMvkput4KI2jyCYefjZ7wllGshXpfS1c2gwkTap115wNm5I7zbEUJikajcxB347
         l7Jf2Y2LrPZPWEinBMPwedThS0+ptEa0e7/CSdB0i+aFoh2mB3k9XcgTOIh5MUYdeYcr
         5/kurMfM8qJOh3W+GqW1ArkJod21UjukmLsdcO2Gr10tROf0yeYwdntvLnBnrYLcgKIV
         I8KzjQXIiLCveDImLJxWNJ64mTKODh1yKgikiNwL0ZwzfIvX7XPJ+OBx6OtTN+ggKCxz
         Wzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606317; x=1791211117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRnT15XNTnThRrBqENhdYd5BF9k1QXVVKb1KnU2gCEA=;
        b=N01JfiYLCxdK1Y51UTw2Qs8sbf9ErL84F+prr5XbALhRiZMMOF8MAOhOKue/Oz/IfC
         4GTtgUKRTOm5mMfBsBXUJpiUEz12tJgFAdSNqrJZmOFYcz3usHZmPwTZqVZJArr8WzpA
         52RDYeet3pJNxeo0lVxYj4QoK6FbSHzDoO2ogkTPGUKMik1+/pOFHfa7ZYhjIh3Rym6V
         0bwaFpq01JwsuKe/A5uA5V+hm2/dmTtp9+Oi66Rtc2QaZlDJqtOAYLkmnC9NOL7yq66T
         kI89sOYj4sEYflHi+2TW63jVse0L9JHVw+7ElSmt/YvFULMVY/gPX0AZGcI42e5hCjz1
         ++zQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSupAQG5tpSnfOdc5BIfoaQ9DUtVxkX//FAL2Q6OgpWfCz1ec51imZ52gKdO31x0CRrLk=@vger.kernel.org
X-Gm-Message-State: AFuF++nFLRs9A/rg9KryqgxKzud/5/bn9kI7Li/ATA84GG2ksqtE+27t
	d9TdVy2NmkbJooB0WagCk13MZy+jWYFzZsYn1BUZDU2S9aJZohm55IZFtnY+146JKZvese0d2aX
	+uDot53kRGveTiTa6Amt+hhegNkJDCVhomME4xGDUbXuRbZylBozY27dI0vdyA0E=
X-Gm-Gg: AYBFou2GpCywXEyfZBifkwQk+7EemTUmNGYr/YWr4pyba1bwJTyJJmUuCpkmZEaZey6
	cKYodDs8Dr3yipBPtgbMqb2xqsC6Gp0DFOgI9IqwNaI10mNLTMKGivarBrRlVgBepM81UD9UnRO
	fcs4thWd+VZYakiCoUkgCN8MGLKc+LeAK5xgoMSVXVpt1t79ulEvwhwbF4GgI7L4IrwLKYBiM8M
	YGkAHOZy+3KJaXuVZ/y9J3HvICIasnOIOVH5sc6h/HgROu9rq6VuZ7TDgRrQj80u7Jm2krQPiEF
	BzP5dBORhFmuKsVV36sp3u5tLRF5FqTEVvYyU5LFwy0amT0itysWUV6hTiJbWAy+IO3izwRbeW4
	SnnfyWp5E1EQwEM9vu7YGWOv36hVhyHDyAtzXdQ==
X-Received: by 2002:a05:6808:13ce:b0:4c3:ee9e:200d with SMTP id 5614622812f47-4d728c29283mr13397730b6e.7.1790606317459;
        Mon, 28 Sep 2026 07:38:37 -0700 (PDT)
X-Received: by 2002:a05:6102:c12:b0:7a1:f7d2:e823 with SMTP id ada2fe7eead31-7af1ecf6d75mr5364910137.28.1790605939177;
        Mon, 28 Sep 2026 07:32:19 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc0cddsm4296359a12.14.2026.09.28.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:18 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 12/14] iommu/riscv: Prepare interrupt remapping for IRQ bypass
Date: Mon, 28 Sep 2026 16:31:11 +0200
Message-ID: <20260928143113.49838-13-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: GN06vIwAfE5TmRqgJYglba1-IVjQfoMT
X-Proofpoint-ORIG-GUID: GN06vIwAfE5TmRqgJYglba1-IVjQfoMT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX8+s3O59xYjcg
 uzD3414YI/qRqRusTUe0BaOnvCinQ6kgmPhfLUYBOAQvz9+K9XXodRQSkPtqqJlAwX6kVtKw0Xa
 +9vznDWMDAf1fXZuTttgByqR8svcKGc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXxF5TQNl2VgSf
 EazDYoS4RoAS4vcWtbOT77C0YGt2kijDH6imQF9TUMsLwlEuW1W11LGBxRgr937MZJvGrK3tjhr
 Pj7673p+GhOIST5gnWxSpfoA9cgSCYMhW6HHZmlVzkubPeooap6HP6lnx3o4/DzOFs4R0IkztIq
 vEGOy+CzCGVeYJeOoKsQGSBnYPWuSGbqh0L/VeiHtJ+WSn6zF6E2nPNH9t1VACEn+JX4BaXbCmR
 po+plBfrXi4WKWK7wVSc+R5Vyvt9HY6iUWYRZ1q21bLXl8oopRaMYXYYVAaq3Z9nFd3rooijVNZ
 pt7pJQksrTR60aPl+BUIu8X3ibkpL6LBt2gjXjPut1/HPonbZGJv7fXIdRFuhoHxQ2JCve8I8v0
 umh8z7m1p56WCoqHqnQgnZx7v2NzqSigCed+FjDh1OpAe8FlEjLJ/60y4nG9AH3zjrKTFrwgCi1
 Y5Q+5Xm7G7TXe/0iHhw==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba7bee cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=E4clnSanGcVZL-NzkHIA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

IRQ bypass changes the meaning of an interrupt from host delivery to
delivery through the guest's MSI table. The transition therefore has to
follow the device's current IOMMU domain and must not race with a domain
replacement.

Wire the interrupt-remapping irqdomain into irq_set_vcpu_affinity() and
serialize the callback with MSI-table publication and attachment. Since
one table is shared by every device in the domain, also require all
forwarded interrupts to agree on its owner and address layout.

Leave the hardware operations as stubs so the locking and state-machine
requirements are established before MSI PTE programming is added.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu-ir.c | 140 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h    |   1 +
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index c5603cb9f258..22da76987c7c 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -11,12 +11,150 @@
 
 #include "iommu.h"
 
+static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
+					   const struct cpumask *mask, bool force)
+{
+	if (irqd_is_forwarded_to_vcpu(data))
+		return -EINVAL;
+
+	return irq_chip_set_affinity_parent(data, mask, force);
+}
+
+static int riscv_iommu_ir_activate(struct riscv_iommu_msi_table *msi_table,
+				   struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	return -EOPNOTSUPP;
+}
+
+static int riscv_iommu_ir_deactivate(struct riscv_iommu_msi_table *msi_table)
+{
+	return -EOPNOTSUPP;
+}
+
+static int riscv_iommu_ir_update_target(struct riscv_iommu_msi_table *msi_table,
+					struct riscv_iommu_ir_vcpu_info *vcpu_info)
+{
+	return -EOPNOTSUPP;
+}
+
+static int riscv_iommu_ir_irq_set_vcpu_affinity_locked(struct irq_data *data,
+						       struct riscv_iommu_info *info,
+						       struct riscv_iommu_ir_vcpu_info *vcpu_info,
+						       struct riscv_iommu_msi_table *msi_table)
+{
+	int ret;
+
+	if (!vcpu_info) {
+		if (WARN_ON_ONCE(!msi_table->nr_forwarded_irqs || !info->nr_forwarded_irqs))
+			return -EINVAL;
+
+		if (msi_table->nr_forwarded_irqs == 1) {
+			ret = riscv_iommu_ir_deactivate(msi_table);
+			if (ret)
+				return ret;
+		}
+
+		msi_table->nr_forwarded_irqs--;
+		info->nr_forwarded_irqs--;
+		irqd_clr_forwarded_to_vcpu(data);
+
+		if (!msi_table->nr_forwarded_irqs) {
+			msi_table->owner = NULL;
+			msi_table->msi_addr_mask = 0;
+			msi_table->msi_addr_pattern = 0;
+		}
+
+		return 0;
+	}
+
+	if (!msi_table->nr_forwarded_irqs) {
+		if (vcpu_info->cmd == RISCV_IOMMU_IR_UPDATE_TARGET ||
+		    irqd_is_forwarded_to_vcpu(data))
+			return -EINVAL;
+
+		ret = riscv_iommu_ir_activate(msi_table, vcpu_info);
+		if (ret)
+			return ret;
+
+		msi_table->nr_forwarded_irqs++;
+		info->nr_forwarded_irqs++;
+		irqd_set_forwarded_to_vcpu(data);
+
+		return 0;
+	}
+
+	if (msi_table->owner != vcpu_info->owner ||
+	    msi_table->msi_addr_mask != vcpu_info->msi_addr_mask ||
+	    msi_table->msi_addr_pattern != vcpu_info->msi_addr_pattern)
+		return -EOPNOTSUPP;
+
+	if (vcpu_info->cmd == RISCV_IOMMU_IR_FORWARD) {
+		if (!irqd_is_forwarded_to_vcpu(data)) {
+			msi_table->nr_forwarded_irqs++;
+			info->nr_forwarded_irqs++;
+			irqd_set_forwarded_to_vcpu(data);
+		}
+		return 0;
+	}
+
+	return riscv_iommu_ir_update_target(msi_table, vcpu_info);
+}
+
+static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg)
+{
+	struct riscv_iommu_ir_vcpu_info *vcpu_info = arg;
+	struct riscv_iommu_msi_table *msi_table;
+	struct riscv_iommu_info *info;
+	struct msi_desc *desc;
+	struct device *dev;
+	int ret;
+
+	if (!vcpu_info && !irqd_is_forwarded_to_vcpu(data))
+		return 0;
+
+	if (vcpu_info && vcpu_info->cmd != RISCV_IOMMU_IR_FORWARD &&
+	    (vcpu_info->cmd != RISCV_IOMMU_IR_UPDATE_TARGET || !irqd_is_forwarded_to_vcpu(data)))
+		return -EINVAL;
+
+	desc = irq_data_get_msi_desc(data);
+	if (WARN_ON_ONCE(!desc))
+		return -EINVAL;
+
+	dev = msi_desc_to_dev(desc);
+	info = dev_iommu_priv_get(dev);
+	if (WARN_ON_ONCE(!info))
+		return -EINVAL;
+
+	scoped_guard(rcu) {
+		/*
+		 * RCU keeps the table alive, but the device may switch domains before
+		 * the table is locked. Recheck the association under the lock.
+		 */
+		for (;;) {
+			msi_table = riscv_iommu_msi_table_rcu(info);
+			if (!msi_table || !msi_table->root)
+				return -EOPNOTSUPP;
+
+			raw_spin_lock(&msi_table->lock);
+			if (msi_table == riscv_iommu_msi_table_rcu(info))
+				break;
+			raw_spin_unlock(&msi_table->lock);
+		}
+	}
+
+	ret = riscv_iommu_ir_irq_set_vcpu_affinity_locked(data, info, vcpu_info, msi_table);
+	raw_spin_unlock(&msi_table->lock);
+
+	return ret;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_affinity	= riscv_iommu_ir_irq_set_affinity,
+	.irq_set_vcpu_affinity	= riscv_iommu_ir_irq_set_vcpu_affinity,
 };
 
 static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index ed973979d795..a42f0b6a88d4 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -82,6 +82,7 @@ struct riscv_iommu_msi_table {
 	struct riscv_iommu_msipte *root;
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
+	const void *owner;
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
-- 
2.43.0

