Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B1352F95;
	Thu,  7 May 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153842; cv=none; b=Z9eBxYCz8i4cmoGD3D4joECsL0Y8LBRby8dZmt9OX9M60RFQzKaAOllXZRprPPxy+EQLv+nhQIxo4b0sPxfLYOiiet3zY6kkA/ahV5/ybhYtN9hgBEuv5ULB1tbOkzaLyQCNmTyCcZSTIU2CePKdeB8xQn6TmRFfXppJDHxUpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153842; c=relaxed/simple;
	bh=hPPEJWpqwcsCvFcsSjXs2lsoWzuWtKcWOt/3dw8I5Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sA+zBAGkMDMgO0IrsuVacWlhxkJEFXhnuqAdxyLu8mwBkLYqG39IMMl6jHmQ9yv0iCE7+YzU4CowvwiuS0vOxM42rC3pFea0h3NjVFDtbZ0I/s/235bJslzblDyErsKJnkfvxyaagVnbQ8nO4TkdM7yy/LjedRuK7ShUDUtpFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RSX4BvwY; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RSX4BvwY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778153837; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tFAMKZYz1nJYVHM70HUe0OYd4bRWfYYuKOfYQU7XBks=;
	b=RSX4BvwYeEHCNtgbWc5I/ytxbCmD9PK12UsigpTX1mql4jho1ttTtg9wN4mkYYEBlpapS8xptZIeOY29O3nwQH2qiCAJ8r8VTWB2LY1kzODrIF8jMbMjGOunGmr4JnKlzu2fwN5ygcc2zvZV7T+iJKQTmp8aH2oywaLhuwK/x3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2UVF.3_1778153834;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2UVF.3_1778153834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 19:37:15 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	andrew.jones@oss.qualcomm.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH v2 03/10] iommu/riscv: report iommu capabilities
Date: Thu,  7 May 2026 19:36:59 +0800
Message-Id: <20260507113706.11400-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capabilities required by VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a31f50bbad35..bd36e3b5d13f 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1336,6 +1336,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1397,6 +1407,7 @@ static void riscv_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.50.1

