Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BA36EA9F
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878470; cv=none; b=cY6yefB2ioPwRri6r1Ck00FW9MLe1NGiw1+AEMmfqiDivICJBK0IOmF/z1A7l5MbxazUmYqgk8SwsIsrLDW757+eeb4A8xheiI68vKV4ZofuHRrwEoopVnSzdS9Ttd7o48+VesaNxoXLQ04zpCG9sHWZIrV303/b/iZjcptc424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878470; c=relaxed/simple;
	bh=1IOWge6MtXvrty9jqSCer2unjjBTrRLH8qMTiiCM4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLbm0T5JLnYlPZ5wzCY9MHH/lz0l5JZQ+jateZG2ehE4/rViF8lOIHuO0kTKnzQzVdIHAfUZfzQAz/lzOF17Coc0ewgVykfVl/tf+XNrDYmGVCIzkw8GApGrnXo5UVhOAtzjMgWmMeGZBQ8XbJX4g/zXZfT5YZ7C9MCUF6fH4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T9ETon9o; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T9ETon9o"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30cac93dfd7so1073362eec.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878464; x=1783483264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e3YXWFANhBpw4yjMWQhabBTa2QrRN36l2rv62U94S4=;
        b=T9ETon9og09goyfTy2ZMMYS5KFeUwcgzfGNDFRkgPoi50PU84NlRH5dzeFhBlHXyO3
         M6mP8DqHu47bycpf1lK2eLDA6BWkimZRyz+w8clbFWVHcZd/wX+bkummjYBY6de7X1U8
         t7mmPyNC475Uw/z20L/MrGDTJYKYtBAwRf6qsVy+ADem0s+umHr8m3HiSw3AqLLpFuq+
         26et3rETZYJ00tj+0T0dbTfGggJMkXELdaGnOXYk3+v007J0Oi3ODpHOsaqg6Ib80dam
         G2jn++qoGzgFyjwbjIEDe/XAbgpejEHpaKbecOkkJmJgBeWBl10lOdgFUFfdfwLw72re
         dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878464; x=1783483264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1e3YXWFANhBpw4yjMWQhabBTa2QrRN36l2rv62U94S4=;
        b=oUoJs8JMBk1ZJ50KIzPmaRJy0v2LuOIpRUIXHyQltbLa7cHHGu9qdY2s5RL41hgx+n
         9VVRJjzLleVzGI+Ry/Qgg0bLVWukkf335hQqlC4WpGKZe3ei/fiCBwHd3+yO4Nd2oNfn
         jeGfh2Gz33f9Q3CXhy9AADt+sG+A+qFww6bkuh6jPYNhBMP49tZUrGkKkzuDIPzgLGy3
         HlD7dSWGNrYMKZ34thizjtUGVfb9BPhA+HihY208GpVJt4jWXTtv4hAtwXGrdlZ7VQ0U
         2ktIf/+diZ1g2H5mP1UAYfgbiPqOLMlAfs33n6W9PJYACtcny3yVVOOe9cT4rUaqMoSB
         PCLg==
X-Forwarded-Encrypted: i=1; AHgh+RpLVz+4thqZ84wcKpRgLy/cUZTmYygbuWWT0VRvpWuY8JHnCgQL1WWeivRG1si4ZPfDdpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ejyLm7ISNh6Kgh4G0SZRqPAuDuQXpBO7MXBYYrkQzIQM4eWd
	awb3GtfLlnOwhT8jq7dtEt0IxTK1daf3HThOOeBnN80tLE6P2D6JL097ozXL7n1xZxU=
X-Gm-Gg: AfdE7cmIDeFxSemD+RDGCEUaco0NGeS5hsNCtxUJiY2W9+l7//B9Gk8+CQTPAwjFBNH
	3KayKcjVxZg+KsF1X5wRftswKKFPv1acfIhHQIsHxgU/HlmoP1PWcGXCDJGslYf80knPotmiIrX
	4ApMn6dh2ZKjFuQom7fL0IWa89RAVCf2I0QPXpszwwqLSnA+NO5Cs7AJ0WiJd19jpsNVd7bUMi9
	m5AWAPDdVAZw1H//vsPWQoc0DRqx9NcH/UnGKITsMtsGVfS8XiKy0Rd37o84CegGXYY4NfhZARO
	MLLZkuC550fABQCV6+5nE3d4qS0iUbVCM0lT0TL6etreezAIlbHPx4XhOrxZf18M9CY7tUbk8N0
	NGZQVqqy1Vh5TRQ11lfx0sI8igzlf6X9r1uo+Zz+8EJVZSqhWJ+fsO4eVK0c1rCaEJ5yYJ27spy
	USkPfb836hbdSF54DaCPzuhS2o4uzsSaxsSUBPQ03Qp26yqLr5WncbdmwZu6dNejfV
X-Received: by 2002:a05:7300:148f:b0:30c:ab96:7305 with SMTP id 5a478bee46e88-30efe97a06bmr77957eec.21.1782878463972;
        Tue, 30 Jun 2026 21:01:03 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.00.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:01:03 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [RFC PATCH 1/3] iommu/riscv: Complete MRIF MSI PTE setup
Date: Wed,  1 Jul 2026 12:00:14 +0800
Message-ID: <20260701040017.42707-2-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
 <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MRIF path can retarget an existing MSI table entry, but it does
not fully handle installing a new MRIF MSI table entry.  It also encodes
the MRIF target with the normal PPN helper even though a RISC-V IOMMU MSI
PTE uses MRIF_ADDR[53:7] in MRIF mode.

Add a dedicated MRIF PTE helper and use it for both the new-table and
retarget paths.  This keeps the normal MSI PTE encoding unchanged while
programming the MRIF address and information fields when vCPU affinity
requests MRIF delivery.

Publish MRIF entries so the notice information is visible before the
valid PTE word is installed.  When rewriting a live entry, clear the PTE
word first and order the mrif_info update before publishing the
replacement PTE, so a racing device MSI does not observe a valid MRIF PTE
with stale notice data.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 drivers/iommu/riscv/iommu-ir.c | 96 ++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index ccbb7aa74a25..82fbb44d6df0 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -119,10 +119,11 @@ static void riscv_iommu_ir_set_pte(struct riscv_iommu_msipte *pte, u64 addr)
 
 static void riscv_iommu_ir_set_mrif_pte(struct riscv_iommu_msipte *pte, u64 addr, u64 mrif_info)
 {
+	pte->mrif_info = mrif_info;
+	dma_wmb();
 	pte->pte = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, 1) |
-		   riscv_iommu_phys_to_ppn(addr) |
+		   riscv_iommu_phys_to_mrif(addr) |
 		   FIELD_PREP(RISCV_IOMMU_MSIPTE_V, 1);
-	pte->mrif_info = mrif_info;
 }
 
 static void riscv_iommu_ir_clear_pte(struct riscv_iommu_msipte *pte)
@@ -131,6 +132,17 @@ static void riscv_iommu_ir_clear_pte(struct riscv_iommu_msipte *pte)
 	pte->mrif_info = 0;
 }
 
+static void riscv_iommu_ir_update_pte(struct riscv_iommu_msipte *pte,
+				      const struct riscv_iommu_msipte *pteval)
+{
+	/* Rewrite live entries without exposing stale MRIF notice data. */
+	pte->pte = 0;
+	dma_wmb();
+	pte->mrif_info = pteval->mrif_info;
+	dma_wmb();
+	pte->pte = pteval->pte;
+}
+
 static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain)
 {
 	struct riscv_iommu_bond *bond;
@@ -337,14 +349,65 @@ static bool riscv_iommu_ir_vcpu_check_config(struct riscv_iommu_domain *domain,
 	       domain->group_index_shift == vcpu_info->group_index_shift;
 }
 
+static int riscv_iommu_ir_get_mrif_info(struct irq_data *data,
+					struct riscv_iommu_ir_vcpu_info *vcpu_info,
+					u64 *mrif_info)
+{
+	struct device *dev;
+	struct riscv_iommu_device *iommu;
+	struct msi_desc *desc;
+	struct irq_data *irqdata;
+	struct irq_chip *chip;
+
+	*mrif_info = 0;
+	if (!vcpu_info->mrif)
+		return 0;
+
+	if (!vcpu_info->host_msg)
+		return -EINVAL;
+
+	desc = irq_data_get_msi_desc(data);
+	if (!desc)
+		return -EINVAL;
+
+	dev = msi_desc_to_dev(desc);
+	if (!dev)
+		return -EINVAL;
+
+	iommu = dev_to_iommu(dev);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_MRIF)) {
+		irqdata = irq_get_irq_data(vcpu_info->host_irq);
+		chip = irqdata ? irq_data_get_irq_chip(irqdata) : NULL;
+		if (!chip || !chip->irq_write_msi_msg)
+			return -EOPNOTSUPP;
+
+		chip->irq_write_msi_msg(irqdata, vcpu_info->host_msg);
+		return -ENODEV;
+	}
+
+	*mrif_info = riscv_iommu_data_to_nid(vcpu_info->host_msg->data) |
+		     riscv_iommu_phys_to_nppn((u64)vcpu_info->host_msg->address_hi << 32 |
+					      vcpu_info->host_msg->address_lo);
+
+	return 0;
+}
+
 static int riscv_iommu_ir_vcpu_new_config(struct riscv_iommu_domain *domain,
 					  struct irq_data *data,
 					  struct riscv_iommu_ir_vcpu_info *vcpu_info)
 {
 	struct riscv_iommu_msipte *pte;
+	u64 mrif_info;
 	size_t idx;
 	int ret;
 
+	ret = riscv_iommu_ir_get_mrif_info(data, vcpu_info, &mrif_info);
+	if (ret)
+		return ret;
+
 	if (domain->pgd_mode)
 		riscv_iommu_ir_unmap_imsics(domain);
 
@@ -378,8 +441,10 @@ static int riscv_iommu_ir_vcpu_new_config(struct riscv_iommu_domain *domain,
 	idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
 	pte = &domain->msi_root[idx];
 	riscv_iommu_ir_irq_set_msitbl_info(data, idx, domain->msitbl_config);
-	BUG_ON(vcpu_info->mrif);
-	riscv_iommu_ir_set_pte(pte, vcpu_info->hpa);
+	if (vcpu_info->mrif)
+		riscv_iommu_ir_set_mrif_pte(pte, vcpu_info->hpa, mrif_info);
+	else
+		riscv_iommu_ir_set_pte(pte, vcpu_info->hpa);
 	riscv_iommu_ir_msitbl_inval(domain);
 	refcount_set(&domain->msi_pte_counts[idx], 1);
 
@@ -393,15 +458,13 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	struct riscv_iommu_info *info = data->domain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
 	struct riscv_iommu_ir_vcpu_info *vcpu_info = arg;
-	struct device *dev = msi_desc_to_dev(irq_data_get_msi_desc(data));
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_msipte pteval;
 	struct riscv_iommu_msipte *pte;
 	bool inc = false, dec = false;
 	size_t old_idx, new_idx;
 	u32 old_config;
 	u64 mrif_info = 0;
-	bool mrif_support = (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_MRIF);
+	int ret;
 
 	if (!domain->msi_root)
 		return -EOPNOTSUPP;
@@ -422,18 +485,9 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	if (!riscv_iommu_ir_vcpu_check_config(domain, vcpu_info))
 		return riscv_iommu_ir_vcpu_new_config(domain, data, vcpu_info);
 
-	if (vcpu_info->mrif) {
-		if (!mrif_support) {
-			struct irq_data *irqdata = irq_get_irq_data(vcpu_info->host_irq);
-			irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata,
-					vcpu_info->host_msg);
-			return -ENODEV;
-		}
-		mrif_info = riscv_iommu_data_to_nid(vcpu_info->host_msg->data) |
-				riscv_iommu_phys_to_nppn(
-					(u64)vcpu_info->host_msg->address_hi << 32 |
-					vcpu_info->host_msg->address_lo);
-	}
+	ret = riscv_iommu_ir_get_mrif_info(data, vcpu_info, &mrif_info);
+	if (ret)
+		return ret;
 
 	new_idx = riscv_iommu_ir_compute_msipte_idx(domain, vcpu_info->gpa);
 	riscv_iommu_ir_irq_set_msitbl_info(data, new_idx, domain->msitbl_config);
@@ -444,8 +498,8 @@ static int riscv_iommu_ir_irq_set_vcpu_affinity(struct irq_data *data, void *arg
 	else
 		riscv_iommu_ir_set_pte(&pteval, vcpu_info->hpa);
 
-	if (pteval.pte != pte->pte) {
-		*pte = pteval;
+	if (pteval.pte != pte->pte || pteval.mrif_info != pte->mrif_info) {
+		riscv_iommu_ir_update_pte(pte, &pteval);
 		riscv_iommu_ir_msitbl_inval(domain);
 	}
 
-- 
2.50.1 (Apple Git-155)

