Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B13D1CC1;
	Mon, 31 Aug 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167466; cv=none; b=T0fSafXZN31jDeCNBoBJcIH5oF9SbXlbMGnOcq1/Rz6QSNMcwQCt2ylGZHKFJHjztVXjTJbsoEWgTvy/xK8bGM3h13YlfHdjm/qQK5e8Ia2BNOMdbcQd34F3TTkUhG8dygHVofNXeltM0sCV6zM4ozIUqN7+DTBLmmNpuFdwRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167466; c=relaxed/simple;
	bh=bRVegjh7kqwOClGWRibP8qqYTfhvDyLQp1VK6459kYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZcxoRdFF1j44rbm/VLYfntYacdu8kQh7n6cnHLJXzfMAcP4LarTuM/XmJZ4lLjdndJk9p9H0bd73Q+dNZIJf5hc2eQfktjZs6OnaL+M/g0KE4zfHb+LqsxJf/rse4jA7oUJqVFd6qtu9l9SIxnbuAamGgSR/4vltTKYNOBoYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UOIDmJYn; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UOIDmJYn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lBgo/uYQKxqMeB0V4fkOVRE0+0BUTuXRnE++cS8xRrE=;
	b=UOIDmJYn5xG6cpu9afV4PbSEH8GP1x2dg5vqMDykII1SqPgnM0/25PgxYeIas0VwH2W6vC0Wq
	tIA88IlghNp6/XjAhVoPP/vhjVQZyFbJqQ/Vv804OfLhsBsMDVtBiRHIb9Wx+hrLQ3cjgop71ge
	BOTWl9WHMr166ZPun46AhwY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYNGh6TGTznTVv;
	Mon, 31 Aug 2026 16:59:40 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 4836640565;
	Mon, 31 Aug 2026 17:10:55 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Aug
 2026 17:10:54 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v3 2/3] hisi_acc_vfio_pci: clear set_reset_flag after reset completed
Date: Mon, 31 Aug 2026 17:09:50 +0800
Message-ID: <20260831090951.844569-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831090951.844569-1-liulongfang@huawei.com>
References: <20260831090951.844569-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500015.china.huawei.com (7.185.36.143)

set_reset_flag is a sticky latch set in reset_prepare() when this driver
acquires the QM_RESETTING lock, but it is never cleared. If a later reset
attempt times out in reset_prepare() because another agent already holds
the lock, aer_reset_done() sees the stale true flag and calls clear_bit()
on QM_RESETTING, prematurely releasing a lock owned by the other agent.

Clear set_reset_flag right after clearing the QM_RESETTING bit in
aer_reset_done(), so every reset cycle is self-contained and a timed-out
reset cannot release a foreign lock.

Fixes: a22099ed7936f ("hisi_acc_vfio_pci: fix VF reset timeout issue")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index e95d0ab0f11a..4abed2e49986 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1180,10 +1180,12 @@ static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
 
 	if (hisi_acc_vdev->set_reset_flag) {
-		if (qm && qm->io_base)
+		if (qm && qm->io_base) {
 			clear_bit(QM_RESETTING, &qm->misc_ctl);
-		else
+			hisi_acc_vdev->set_reset_flag = false;
+		} else {
 			dev_err(&pdev->dev, "PF QM not available for reset done\n");
+		}
 	}
 
 	if (!hisi_acc_vdev->core_device.vdev.mig_ops)
-- 
2.43.0

