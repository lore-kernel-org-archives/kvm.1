Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276623EA94;
	Thu, 14 May 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750703; cv=none; b=s3oWmQwxpzXenSX3IC/Mn1GCKDndxoBj2eaxCA+xp9eKS7FoFLGeEQkjl9oxFE0WkvHWdwomVXe5P1FiDEcO00xO0F1sa03zbr412bZAiftYwxxTX+NbqlIggHaXEh++6Z3vUFlKbyb2FRN4fom/tVfRzcsvY+BkyVgs4/3erws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750703; c=relaxed/simple;
	bh=u+bCzUWOSTUbMI8I86RWyQMGx5xfcq5zPC/vw5WQ2nI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6i/fgzZNnIMp+i08OQO2//IMk3dGJ20MCk3wqSdc26ZtbinTVgih2yQJnno/MmyGPlNZsQSm3Xz+F/pjh7+qTKs/25nju3/3HG7beWIf0D9bPQdk+CzQZZpoaSExo5nnuL8Iy9pE9GttVFeHmRnI7/NcuH8ucUu56d9eZ6BHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jdZSnmMv; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jdZSnmMv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=02m5FN5q+yEsYLSIU1JMe2YQFTMdG6tEAVvPUKXqtPE=;
	b=jdZSnmMvOdX+AmUQECbzn8ylHkRjEfSwYP1ufyIji+TyUISSzFm96LbXiXS08zMJNPUHFqpdM
	/IDneeNC66AOfwdEZrsm6EWT5m2Yr2+UZLQmBAIkMqmErdMHA2JjOAlMsGmGKCYKcgqurpEvDbg
	Jicfy1wKu9TfBnut3Qwx4b0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gGPqB4cc1zKm75;
	Thu, 14 May 2026 17:17:10 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id C314B402AB;
	Thu, 14 May 2026 17:24:50 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 May
 2026 17:24:50 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH] hisi_acc_vfio_pci: simplify the command for reading device information.
Date: Thu, 14 May 2026 17:20:26 +0800
Message-ID: <20260514092026.2018844-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500015.china.huawei.com (7.185.36.143)

From: Weili Qian <qianweili@huawei.com>

      The mailbox operation for the Hisi accelerator device now
provides a new read function that supports direct information retrieval
by specifying commands, thereby simplifying the related mailbox command
handling in the driver.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 39 ++-----------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index bb121f635b9f..86362ec424a5 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -81,13 +81,10 @@ static int qm_get_vft(struct hisi_qm *qm, u32 *base)
 	u32 qp_num;
 	int ret;
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
+	ret = hisi_qm_mb_read(qm, &sqc_vft, QM_MB_CMD_SQC_VFT_V2, 0);
 	if (ret)
 		return ret;
 
-	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
-		  QM_XQC_ADDR_OFFSET);
 	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
 	qp_num = (QM_SQC_VFT_NUM_MASK_V2 &
 		  (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
@@ -95,36 +92,6 @@ static int qm_get_vft(struct hisi_qm *qm, u32 *base)
 	return qp_num;
 }
 
-static int qm_get_sqc(struct hisi_qm *qm, u64 *addr)
-{
-	int ret;
-
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_BT, 0, 0, 1);
-	if (ret)
-		return ret;
-
-	*addr = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
-		  QM_XQC_ADDR_OFFSET);
-
-	return 0;
-}
-
-static int qm_get_cqc(struct hisi_qm *qm, u64 *addr)
-{
-	int ret;
-
-	ret = hisi_qm_mb(qm, QM_MB_CMD_CQC_BT, 0, 0, 1);
-	if (ret)
-		return ret;
-
-	*addr = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
-		  QM_XQC_ADDR_OFFSET);
-
-	return 0;
-}
-
 static void qm_xqc_reg_offsets(struct hisi_qm *qm,
 			       u32 *eqc_addr, u32 *aeqc_addr)
 {
@@ -575,13 +542,13 @@ static int vf_qm_read_data(struct hisi_qm *vf_qm, struct acc_vf_data *vf_data)
 	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[QM_XQC_ADDR_LOW];
 
 	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
-	ret = qm_get_sqc(vf_qm, &vf_data->sqc_dma);
+	ret = hisi_qm_mb_read(vf_qm, &vf_data->sqc_dma, QM_MB_CMD_SQC_BT, 0);
 	if (ret) {
 		dev_err(dev, "failed to read SQC addr!\n");
 		return ret;
 	}
 
-	ret = qm_get_cqc(vf_qm, &vf_data->cqc_dma);
+	ret = hisi_qm_mb_read(vf_qm, &vf_data->cqc_dma, QM_MB_CMD_CQC_BT, 0);
 	if (ret) {
 		dev_err(dev, "failed to read CQC addr!\n");
 		return ret;
-- 
2.43.0

