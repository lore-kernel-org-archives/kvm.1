Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFA4E01F2
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605952; cv=none; b=ut2WO1bsCR+fQE/s99bhv03aMW09f2Qbn6VIpUzgRg5lMWoSc3cds/RSXtICPuqUdiS34Xt4sJL5ZPKbjn20Re8rYfozbGB6jR1DvcxkVtxeaf2mi1K7GEUomxd9ejEmbqGJKPWn5uOHJBnLKRVllUqddNVhOV1cCiZ4jPyRbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605952; c=relaxed/simple;
	bh=yjSyVpAuKGH9gMGCFpQtURI7YjmlqFUcCzwwT3vYzks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiq3Tf3aheHIpVhSi6WHqCvu7qCatKWatTzpU+V5tur86Ewn2t1+Q2uBnniRIsvCUuM6FsYikXsRoIb4398lkMjwKHpggSVqZSShy+BsD7CPcmjNZenf3ojJqqIe0aEejFXt6Tfypn7iFQbW+UuRZiFl6/Kea0wlId6eDQ3JsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A1khsbUY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g+zqZpI1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A1khsbUY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g+zqZpI1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAlSA783115
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g7ykt7LSEJe
	/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=; b=A1khsbUY53TyX+IouxKKcQgcDYK
	8RmG3YIwh2qQRPk8L9AOg75iU5OhtzUQo61HU6vp30hzLq8NwzUNx3kABtBGg8bB
	zFC3VvlPM/YcW73HckfLlY8b6h1eHSfB79tRRdkKLZYXGZvUlzpOCqLolVE/fOMz
	9SDa14kaU0pqJkAuyegYSvTOjpLEQO+VzjNVEX2T6oCjSEhv0VsItB82zWcvTth0
	KSM3IeTuI+7qhUIK0Vdgz4ClN4LxsH7fpUi4hsp+TVNP04VOUCVNboUePJxH0T4v
	MDK4OqUJJhF49TuMdt+sEFKGLQ5SyOyP5hOVkMx67Z2RNROj3R9QZAJNVzQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4axwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:19 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98331b577e4so2469034241.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605938; x=1791210738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7ykt7LSEJe/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=;
        b=g+zqZpI1xpS1hPPaMh1nCHEv+b0by5n8fH56CLrjhn1y9VkPYzjA/G5X+AUyO3pvAc
         q4NoOJTZ6VNzVlasRvL257VlJdMp2YNAXh02Wv8E33ntmpQQ7uiwCnXhFFx0mUOul9YS
         rn3M+dOyVG9hjNIuagU5SSVrBlxGE7HOlrN4AST4rY/hvl4an2Rnc//zEDNDx/T7+M8Q
         BjmCTfPugtG1K/Z9mDHCGLBPrxIu7cxim0ukzSz8icfDdRcxEKOz8462s8lADNfDoiM+
         ayuZirZ1dTYsF+Wrx41oG5dFjy9lLjDcknKpAzcuZOni8SFssQFY99+UqP/PXI91eZpx
         4wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605938; x=1791210738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7ykt7LSEJe/IvR1ZzOjMBU3wKZ7WY6AweTJQ2yjaag=;
        b=2z9pnKI/iaPYOc+fm8bd5+V1NGcvQJIzJpZfQO67ULz8RdtggMr37WVRplKjqJiyLH
         6PGfLc9Ph1jgM3s8pJRPzmS26p5CL13Q+pNJcI0LHRZ2DMIHNMpk/KP76yQUwGpXcjcQ
         Z9oMm3o6dc9FyTP3G9X07kKWXasMtTquXIsoUP2mvmuUj9BVi/tpZUfhJf2XVBHrdvxT
         GvfCTVpRRWMeU/McJg6o7+Tqw2IhDqrHGVCaZJEPI90vQas1+8I4AcGkLFwVtEfyMT9U
         umetNPqfzgrTs+P2yMXgJHEcEwnmdS+5zi8S7wfpXuXuYRcDu7U0IFrw+7dca3dh4q2X
         46Gg==
X-Forwarded-Encrypted: i=1; AKwUvBys53n0vtqrffSyWG1lBsOeIgeHO/EztTsmt2Y+lsLce0OgK1g7kBFGlW3QKtGkyVMYmDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYFvd1JXau7xD7aZ+QusB2hgZigrdg6YKLBK9/uPPuk/kRiIMk
	WoOkcynuggfEdOOShXw9TD8UhwkfFVPO2u4+3Xu9MCJJH2KIcJg6Vg816bY0yL9N4D5633o9f/W
	UB5ut8TxNgki8Ohur1XZxhgI5fcwrUlsbrLy8FPMVNWmIoU/dhLphJyg=
X-Gm-Gg: AYBFou3OcNBs5Smo8XkoX0jvxZnjs+CbyVOiQoALkk17foACeojM1Bfr0avuRxMOE2L
	Wmi7ROKUBcEyVS3rn2NqHTgR8QnllY+hXi8RWket0v/3MvmuCviEpp641gsuQP53aHehz3S5WV/
	FEj8ZqcfiQpX6/0/fy+prl9+tQbX4EJUBeuq8U546CIqEC/PTLskj+mTK6tvhgcdgb0Em27UIjI
	XUpljZZr8f0kNez0OeTrDhzcK8TH3vnICLpHi+5thDJTUV9UG0Ucg0Zc3vS2jK6TcMx7V53Pmjj
	hdrlwYoDzy2UkKHGmYQk6QOHATNGWKmwumizW+xfNbt9YywZtIG4hFu2TWr8f0l+oMKhuxuRjka
	C10fx909BTbteUKLA5m1NgCZr/QWgifBROAJ0QA==
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3266547137.29.1790605937919;
        Mon, 28 Sep 2026 07:32:17 -0700 (PDT)
X-Received: by 2002:a05:6102:32d0:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7b27aac8d4bmr3266533137.29.1790605937424;
        Mon, 28 Sep 2026 07:32:17 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dcf626b3esm211882366b.27.2026.09.28.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:16 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 11/14] iommu/riscv: Prepare info->domain for concurrent RCU access
Date: Mon, 28 Sep 2026 16:31:10 +0200
Message-ID: <20260928143113.49838-12-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: B3UmCtsjXgFcmsdLLzFYtMuxJzAPUIUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfXxj86slmj7zDC
 HTP3qmKeIOaELgHxr4OUI84KUaw4nWh1HGLKj4TgQX7O3qRNsCVuOnRTl0Bhp4ioSosP2Awg1KA
 z+yPi2cVkvyWnO9EzuU1P7wJM/oxS9VCtgZuHTxIXtpT4124diuRJwxrGqX9OEQiN09LOh24hUu
 x+bEnmR9gXDaRX5SFUhw13+JRz2izPMFfxDYRtfpOnlFx4Gnvzm7liAOsg9ZhQTtHGKfra/Red/
 RY3r/NahIo82ogsOVDp0dkRaBmvB1stcheYG7Mgj1suj3MIZTL/TY36UVZXzghKHaA6aurwhJ0v
 NAOtkH/dJBpPTFdtkIWHGcN6nhW0UtBbeu4RzY6rNKbFpagJdMwO+vdPfeez7tJ/zeZnEo/46v6
 aaTv1VIxt/AeSTwXwD4YItq5OTFDeXVrMRaz3u7ri0/6SJ37jw2HDyI0dYZ4I2qsEEVK5UtafAC
 HTW8jGIaKnKcTEoT9Hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX40tbUwZX7G/u
 fBIQyHZC6ih8rXAhApDagalaqu2in1OvKoIK9WGqap/jBVblgzmxd2trMuhAVGDKcN+FSpr21/U
 GqbayG28jWiNHvsUZp+kXSOOt2v+xy0=
X-Proofpoint-ORIG-GUID: B3UmCtsjXgFcmsdLLzFYtMuxJzAPUIUM
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba7a73 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=YVOiLqTVN_ovv9J5ge0A:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057

Upcoming interrupt-remapping callbacks need to resolve a device's
currently attached domain from IRQ context, concurrent with domain
switches.

Protect info->domain with RCU and wait for readers before freeing paging
domains. Provide an RCU accessor for the domain-owned MSI table so
interrupt-remapping code does not need the private domain definition.

Use the stable old domain supplied by the attachment callback when
unlinking its bond instead of dereferencing the now RCU-protected
info->domain.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 34 +++++++++++++++++++++++++---------
 drivers/iommu/riscv/iommu.h |  5 ++++-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 7a8b40d311ea..514470291fd9 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -869,6 +869,16 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
+struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info)
+{
+	struct riscv_iommu_domain *domain;
+
+	lockdep_assert_in_rcu_read_lock();
+	domain = rcu_dereference(info->domain);
+
+	return domain ? &domain->msi_table : NULL;
+}
+
 static struct riscv_iommu_msi_table *riscv_iommu_domain_msi_table(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain;
@@ -968,18 +978,22 @@ static void riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
 	smp_mb();
 }
 
-static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
+static void riscv_iommu_bond_unlink(struct iommu_domain *iommu_domain,
 				    struct device *dev)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
 	unsigned long flags;
 	int count = 0;
 
-	if (!domain)
+	if (!iommu_domain || !(iommu_domain->type & __IOMMU_DOMAIN_PAGING))
 		return;
 
+	domain = iommu_domain_to_riscv(iommu_domain);
+	iommu = dev_to_iommu(dev);
+
 	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(bond, &domain->bonds, list) {
 		if (found && count)
@@ -1415,6 +1429,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	synchronize_rcu();
+
 	if (domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 	if (domain->gscid > 0)
@@ -1577,8 +1593,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	info->dc = dc;
 	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = domain;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, domain);
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
 
 	return 0;
@@ -1732,8 +1748,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, NULL);
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
@@ -1760,8 +1776,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
 	info->dc = dc;
 	riscv_iommu_iodir_update(dev, &info->dc);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, NULL);
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
 
 	return 0;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 4c1c681ba2a2..ed973979d795 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
+#include <linux/rcupdate.h>
 #include <linux/sizes.h>
 
 #include "iommu-bits.h"
@@ -85,7 +86,7 @@ struct riscv_iommu_msi_table {
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_domain __rcu *domain;
 	struct riscv_iommu_dc dc;
 	struct irq_domain *old_msi_parent;
 	unsigned int nr_forwarded_irqs;
@@ -100,6 +101,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 
+/* Caller must hold rcu_read_lock() while using the returned pointer. */
+struct riscv_iommu_msi_table *riscv_iommu_msi_table_rcu(struct riscv_iommu_info *info);
 void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
 void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
 void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
-- 
2.43.0

