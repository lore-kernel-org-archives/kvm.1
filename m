Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254314;
	b=VkezoeYmamXQOckB1xgQCrz1qDnACe9fberyby1ZFaP3f9zKnTEd4JXKN/+T3hjjF9at
	 Ir1hHcPPup7DtjWdYRNgzBFnLVFs95S7nLt+uGdgXemy3V1fKnAY1GRfy1S+zPiY/dw36
	 SblPu6S8dft+Qt07/U+7CKvXocsaGUf2SUcJ1kwKPtIZdTDp2+Zc/Zu5ls/boq9e+45Zf
	 bkPn1Vh/2BZTrILOmyhgIg14otLQWEiS3fJmOkSrz2xVifZ2eerARyrOn1fmie/OeOjpp
	 qwmE56d0JmF5TBjseA+J5vCVSKM4ysm+ml/s5Fk3sqBuk9gorsv7kK1FYhbe0VKH9iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254314;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=lEFaOgUY9j3NkmVlcaXimZAUNSl/Q/naPVQh39qUVgU=;
	b=jBCacLgE57FR1I84Ark/Z4jv35kzTzLQNnusCpjJZil+1JS7ci5DxX5g5Sl9cMvFeHIu
	 +IsGNG6UdNS5WMHOSCkkKy8q9PmXv9RUI5mxoHJ+CXOD3zuECNkfAqRYRBFM14a0zlEht
	 ayZQM+Yd3fnJ1ri1e690ceh4xxweNxHSili9ho8mlxKx3SC2HgqLM5pnOl0hrCO67CT5W
	 T4DdbqHExCuOnVfRwvEj3OuqBxpqtHhki/Bfeop/kBWFHfdEOXP7Dvi32YavlU/VZKtxN
	 vDUMnHpkEbbtTRVMXFBYG87PcXFnBr+IJtFOV1vbA2/YxXHLY4dzQh9bz+DTZtL7FLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693BA60A262C;
	Thu, 29 Oct 2026 06:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 693BA60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYll4fMvz8XrrZ;
	Thu, 29 Oct 2026 14:11:47 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 69T6BdP8044561;
	Thu, 29 Oct 2026 14:11:39 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:41 +0800
X-Zmail-TransId: 3e816ae2e39c027-e7d9b
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Date: Thu, 29 Oct 2026 14:11:31 +0800
Message-ID: <20261029061131.584453-10-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69T6BdP8044561
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 14:11:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E3A3.002/4jFYll4fMvz8XrrZ

From: Wu Fei <wu.fei9@sanechips.com.cn>

Attach a device to a nested domain by combining the guest provided
stage 1 context with the host-owned stage 2 context in the device
directory entry. This allows the physical IOMMU to translate device
DMA through both stages.

The device is bonded to the stage 2 parent domain so that it shares
the parent's invalidation state.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 44fab79110ac..a103c0465e62 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1673,12 +1673,53 @@ struct riscv_iommu_nested_domain {
 #define to_riscv_iommu_nested_domain(domain) \
 	container_of(domain, struct riscv_iommu_nested_domain, domain)
 
+static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain,
+					 struct device *dev,
+					 struct iommu_domain *old_domain)
+{
+	struct riscv_iommu_nested_domain *nested_domain =
+		to_riscv_iommu_nested_domain(domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *s2_parent = nested_domain->viommu->s2_parent;
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct pt_iommu_riscv_64_hw_info pt_info;
+	struct riscv_iommu_dc dc = {0};
+
+	if (nested_domain->viommu->iommu != iommu)
+		return -EINVAL;
+
+	if (!s2_parent->nest_parent)
+		return -EINVAL;
+
+	pt_iommu_riscv_64_hw_info(&s2_parent->riscvpt, &pt_info);
+
+	dc.tc = nested_domain->tc;
+	dc.fsc = nested_domain->iosatp;
+
+	dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn) |
+		     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, s2_parent->gscid);
+
+	/* SVA/PASID are not supported now, keep PSCID at 0. */
+	dc.ta = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, 0);
+
+	if (riscv_iommu_bond_link(s2_parent, dev))
+		return -ENOMEM;
+
+	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_bond_unlink(info->domain, dev);
+	info->domain = s2_parent;
+
+	return 0;
+}
+
 static void riscv_iommu_domain_nested_free(struct iommu_domain *domain)
 {
 	kfree(to_riscv_iommu_nested_domain(domain));
 }
 
 static const struct iommu_domain_ops riscv_iommu_nested_ops = {
+	.attach_dev = riscv_iommu_attach_dev_nested,
 	.free = riscv_iommu_domain_nested_free,
 };
 
-- 
2.53.0

