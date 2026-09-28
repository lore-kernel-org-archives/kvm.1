Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496794D7D47
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605905; cv=none; b=sSnHh40TDJpegHIAgjVrNO2QRs67N6DpGDyQ/XmGeCPSDD9Qgv3Voie2OLFwN7Vn8QXJddAyUv6UUFZ8lSQ3Af8BfOh/R7Ivm6GqVju1/Z82fnil96R9kczLSJ7Ck1w20ISJu8ZbzASceaaDQEMHSfAMSlVfpuEd0vv9fX1IwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605905; c=relaxed/simple;
	bh=yJwDlmn443Ax9kpKELDsQBpptC2XSPFpswbCdYGuVZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFDeXeqmuJdVF4WT6eDVDRDIbwzyYYvCsNhnoTPft8C89Ukdp5JG7xWrPPUn2wzhUrYqvW0plPkGTKaIw4YSiXIj6zuRv+CGejva6E+JOotG3zXglefm1RRekbJ4+m+qKZeWaGiAm3c+yb4HaSw39JATdth6uob9/iIIdOpzw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOS1EdWx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFc6fkqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOS1EdWx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFc6fkqZ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAOon2294797
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fnEGeXO1CU+
	HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=; b=MOS1EdWxOybfBOix7icqGEJix+o
	apWHm7pTzOj7QugvSyaGuoGVfeOc+UeR+lqpSg+tGWiMh2aMMz3XKdVPkzsqsDMk
	my9Sk4Vt0vEiWx7p6ETG8/4HXQ1zN1LsisG94fc2nS+DdIKYMKz5qMnImJ3ABxER
	4Xrb2rldPC+l/AhbGn+uNJxgvEsWv/3a6tV2pj1lssxRxQ1Hc3OS9XQrs5Q1W7aC
	LUhrt/O4BBXYOZJr+lF+KHBcYz7ZtnbX0RcHEsBYRFPWyntcFy4Jf/l8Sd6aVUql
	ykVBgI7Gc/Q3JsUYsqguq66kmDwoxJj89uY99wc7xzGjo0aLtkR/IqO8ljg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubj0vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:31:36 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso1113936e0c.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605896; x=1791210696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnEGeXO1CU+HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=;
        b=IFc6fkqZeMUIaB18a1wsQ/BvzquE7aiyVzqOYWimtPUBw/RCYwVw63wukhPCEQVMkp
         eTf7+v2vfSCwSPxUZT7jGUhd4G8v4awddtqmjHuaqdn4InszgH8KLNsPFGcWmBgKG7ja
         utMQVm2n5lcX6wHzSCZPGLOdXXfoti5PBkAt8zKmxQx0NSD03YIZjngOJTckz0qxbk1G
         YTty/5128E57/Si+AVqEvbA6tFCgnGdSpM/Ji5MFYqBWmIeCowKO1FdKjrx2yIxK2K38
         bEwVB8sSwFsxLORInoMwXhSEtMiD6PZBseBOXb4kpuxbr+BcvYJVS7P85X5AcMOEPssd
         YH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605896; x=1791210696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnEGeXO1CU+HZ91pW3NLrROTKl2nGT8dwWEHiiWpE0w=;
        b=rlFs3sGNvsiZiWu96ooHnRpMSvg8BSX+HWM4ZLOvXmigAqF07fuZKmckH7fiwFnKDL
         4g0i+7u9TzLQCZXbdo98cTfl2jDC7Sf7MmCxPgGeLBSvpJ2IB8et4jMH8zkx+sy1fi9H
         tlkiwuVUqhbNPDb0A3zDn7oqNchWUd1EwYv2Od/BHeraR5Dq8g9xumSoH7hQg5wmh8NA
         rgHkN+6TmEsPHhm4ybFcfepeGnnN4Tpn9TSofLrw6HFxSNevLteN6OIHM8YBS72dtPPD
         wFRVhn4WOLz5Ks8qkFuJ5YJ8P8RD+eeTXzkSBFWnFTr/KFmV88OJ9Z0mFS3iP3oEcB50
         OfDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxUUEC53tEOrHVUL1INMHhBxfw3E8QKEPybfYMAVBXr4PwQV3WwaQ+lmeTK9cJBiBCDeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU3WJpplg+/XFYnpPbSQqC2YJWUwVmo5ZvsqHu9TTqEFDNts7/
	FCuvkZzCLRKMFroIlqfzsuUSvite7fghbEOX9S6AzOeP8u4kiM6KI8ihcAqiFKDJ0PdrDN9VSOi
	TK9LsDIWLrNON3yhiPw/ZbjeCy9OGirn0jFTnBnESoSRXrte9DNTrYZ0=
X-Gm-Gg: AYBFou2gMdzH25XNRBvzn5FhTHQAOejinN8bbN09V4y7MasTXa/WEITM4ou3rJqwc4u
	O5+Tphne/IO4B/pIbPKT0CT7ITOGnUQGOeK/y4u8eahTZue/yOdO0h1sMbe1svhi8cvLjE4IeAg
	uc3z0YVnX+LMmx+wJ9mj1atNDxUxf8Msc0RLQbaoqBBhPM+icFFeiWqR/XplyfpQCRg37+j7ENS
	aeXLzE5U65oPgVy9QAwP4afznLXhQnUgMbiQB/xdR3Qs/M0OQy6dBG50OV7fCWxO5KYpxZC+P8M
	iRoi1c2YZJ1kK/Dul0BJ7DEg5XvqHG0Bq9pasvGR5t9jEhzVPV1KxFzGPFOh3H3pHtrrAyKKx6p
	tgfbAtG/SBAOWc6eq5YLAexHhVSokgHtYISQFyg==
X-Received: by 2002:a05:6102:3914:b0:7b3:b84b:ec61 with SMTP id ada2fe7eead31-7b3b84c1495mr1397614137.34.1790605895835;
        Mon, 28 Sep 2026 07:31:35 -0700 (PDT)
X-Received: by 2002:a05:6102:3914:b0:7b3:b84b:ec61 with SMTP id ada2fe7eead31-7b3b84c1495mr1397528137.34.1790605892520;
        Mon, 28 Sep 2026 07:31:32 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bca9dsm292277066b.71.2026.09.28.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:31 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 01/14] iommu/riscv: Allocate MSI tables for second-stage domains
Date: Mon, 28 Sep 2026 16:31:00 +0200
Message-ID: <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: bHxiFiLokIlsXu1jb8EXcrhyNqd182wQ
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba7a49 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=9ujTGIzx3EpO3AdiBq4A:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: bHxiFiLokIlsXu1jb8EXcrhyNqd182wQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX37tvG71lCSKB
 v3AfiSfarhOXeqtIm6EvLVRdV9YZg3g+pUWtT3LdQvCrHt6SDy1agKfVxjb3Q215LXygAMG9cLS
 Fu3NfQlpM04B+9jDnRArRACXLeCYuJN3DM05uQHwfS3DeCFUzHjsmDoJYycW724QcjEnRe7yica
 uYC51hBd7x1kUZ9ZRhTfn5fvr7zAAr9UK0fB2hfwWKtM79YxQD6KyVxthB4HIhKcafCm3xCwXhh
 SBv7MaUWXA5KOB7cnNAOXqxcBR2rPwH5nDFJsoAP0EgMjxlzbqjCa1E4nbAsFdTa3DsQVl9L/dc
 yAFAaqE2qyl1c91vQqwtbQN7KqqPp47UVqv/xtW467UaE22jqmzqzPHiKcZzBeZIwXaHGSRdk0+
 /Xsnac8iIu7cQxr0LPpsfr+WxYyl6l+GUdgKV026XpAKEsMuna9DRFv8ORyEpfMbrF5k0AeDRzg
 6m9OyN4A5/FnCaaGzSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX6isttTWfu7B6
 29Gq4Pc32W5fhSg0lNM3CES61LIQqQlctMCnlcEM3VAk3/DbLWwy9mzVxrm7ySf3rkp47Usum5B
 x1lkCSLctyNulb84+JvfU0YcxvejOiE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280057

IRQ bypass maps guest IMSIC addresses through a flat-mode MSI page
table owned by the second-stage domain. Allocate the table lazily
during device attachment when the attaching IOMMU supports MSI_FLAT,
and free it when the domain is destroyed.

The required capacity depends on hypervisor support and VMM policy.
Expose the runtime-writable riscv_iommu.nr_msi_ptes parameter to set the
MSI table capacity of new second-stage domains. It defaults to 512
entries (8 KiB), and zero disables MSI table allocation for new domains.
Existing domains retain the capacity selected when they were created.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 61 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h |  7 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0953aaf594cb..3bbb4d0d0a85 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -22,6 +22,8 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/generic_pt/iommu.h>
 
@@ -30,6 +32,16 @@
 #include "iommu-bits.h"
 #include "iommu.h"
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "riscv_iommu."
+
+#define RISCV_IOMMU_DEFAULT_NR_MSI_PTES	512
+
+/* A zero value disables guest MSI table allocation. */
+static unsigned int riscv_iommu_nr_msi_ptes = RISCV_IOMMU_DEFAULT_NR_MSI_PTES;
+module_param_named(nr_msi_ptes, riscv_iommu_nr_msi_ptes, uint, 0644);
+MODULE_PARM_DESC(nr_msi_ptes, "Number of PTEs for new second-stage domains (default: 512)");
+
 /* Timeouts in [us] */
 #define RISCV_IOMMU_QCSR_TIMEOUT	150000
 #define RISCV_IOMMU_QUEUE_TIMEOUT	150000
@@ -847,8 +859,10 @@ struct riscv_iommu_domain {
 	};
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
+	struct mutex mutex;		/* serialize domain state updates */
 	int pscid;
 	int gscid;
+	struct riscv_iommu_msi_table msi_table;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
@@ -1303,6 +1317,7 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 		ida_free(&riscv_iommu_gscids, domain->gscid);
 
 	pt_iommu_deinit(&domain->riscvpt.iommu);
+	iommu_free_pages(domain->msi_table.root);
 	kfree(domain);
 }
 
@@ -1338,6 +1353,37 @@ static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
 	return false;
 }
 
+static int riscv_iommu_msi_table_alloc(struct riscv_iommu_domain *domain,
+				       struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_msi_table *msi_table = &domain->msi_table;
+	struct riscv_iommu_msipte *root;
+	size_t size;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT))
+		return 0;
+
+	guard(mutex)(&domain->mutex);
+
+	if (msi_table->root)
+		return 0;
+
+	if (!msi_table->nr_ptes)
+		return 0;
+
+	size = array_size(msi_table->nr_ptes, sizeof(*msi_table->root));
+	if (size == SIZE_MAX)
+		return -EOVERFLOW;
+
+	root = iommu_alloc_pages_node_sz(NUMA_NO_NODE, GFP_KERNEL_ACCOUNT, size);
+	if (!root)
+		return -ENOMEM;
+
+	msi_table->root = root;
+
+	return 0;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1347,6 +1393,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
+	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
@@ -1354,6 +1401,10 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
 			return -ENODEV;
 
+		ret = riscv_iommu_msi_table_alloc(domain, iommu);
+		if (ret)
+			return ret;
+
 		dc.iohgatp =
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
@@ -1425,6 +1476,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
 	/*
@@ -1484,6 +1536,15 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			ret = -ENOMEM;
 			goto err_free;
 		}
+
+		/*
+		 * Capture the current number of MSI PTEs now since it must remain
+		 * stable for the lifetime of the domain.
+		 */
+		kernel_param_lock(THIS_MODULE);
+		domain->msi_table.nr_ptes = riscv_iommu_nr_msi_ptes;
+		kernel_param_unlock(THIS_MODULE);
+
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
 		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
 			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 6d5c70e9ac6d..6bea9da71ff3 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -68,6 +68,13 @@ struct riscv_iommu_device {
 	u64 *ddt_root;
 };
 
+struct riscv_iommu_msi_table {
+	unsigned int nr_ptes;
+	struct riscv_iommu_msipte *root;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+};
+
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
-- 
2.43.0

