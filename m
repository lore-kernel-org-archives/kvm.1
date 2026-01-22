Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0327E045;
	Thu, 22 Jan 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047461; cv=none; b=bjEacR0JEQ6AyMQPm56h3XCRHKlH1Xgpa4srG4DEH12sFGjOzCUeDWuKpNQus0BfaI8NG8m+phKGojwlECYhq6IO65CSj+YsfvvTg2XJAHkUtrE263ocUlItn5J0xGj+uP/wqhZpCX6LEwubkbBqRQ2rFGMsB/J5GuDIpBehi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047461; c=relaxed/simple;
	bh=xqzP7gAB/INyvRS6jUS+n5deBZbgLYREzvQIcAOfv+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0dypvVCOaEH68XbOs/wZOSc6QwSDdJGLco0YksHs5oaXxk+N8QKgfthgXbGj+EohQyr5MeA8Q4L8qC3vl/ydJb5P8eD7AuiWhmbtpiu78yy6/fy2/ZC4M0ObNuvV7q1VTDrMGnsyf2wmrSzmGQhAdCtUFy0jxYpI1ESy24BnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H5t3NMSy; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H5t3NMSy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A/y88TE+BcSK9wV70vu1iD14mtgz2MdDmaDBOt2ZnNo=;
	b=H5t3NMSyHkBrBZKjyApUXjpIsORx9qJuJLnBZpthkwH8xzprM+t/ftWyChQAuywh+rGLcbAvH
	e4AGXDmYxO1YTMTfOw/xxVJvc181HfEfD94bOOMf2Gru64yTaGyoq5rIaObtHYHVEQeCTia369/
	gARgBh0Jq04GIWlYHQwMCZc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dxPQc3mhRz1T4hP;
	Thu, 22 Jan 2026 10:00:08 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 3345140569;
	Thu, 22 Jan 2026 10:04:12 +0800 (CST)
Received: from huawei.com (10.90.31.46) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:04:11 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<jonathan.cameron@huawei.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 4/4] hisi_acc_vfio_pci: fix the queue parameter anomaly issue
Date: Thu, 22 Jan 2026 10:02:05 +0800
Message-ID: <20260122020205.2884497-5-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260122020205.2884497-1-liulongfang@huawei.com>
References: <20260122020205.2884497-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500015.china.huawei.com (7.185.36.143)

When the number of QPs initialized by the device, as read via vft, is zero,
it indicates either an abnormal device configuration or an abnormal read
result.
Returning 0 directly in this case would allow the live migration operation
to complete successfully, leading to incorrect parameter configuration after
migration and preventing the service from recovering normal functionality.
Therefore, in such situations, an error should be returned to roll back the
live migration operation.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 483381189579..e61df3fe0db9 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -426,7 +426,7 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	ret = qm_get_vft(vf_qm, &vf_qm->qp_base);
 	if (ret <= 0) {
 		dev_err(dev, "failed to get vft qp nums\n");
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 	}
 
 	if (ret != vf_data->qp_num) {
-- 
2.33.0

