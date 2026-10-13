Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B41344DB1;
	Tue, 13 Oct 2026 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875990; cv=none; b=PCkkXNA28xTngj06JOddTVXk2YE0o56s7Gee/CFxCIJwBsbJfUo+fh9eqdGse6rOaYdzSsYiu4b96F/F+uX+zMCt4E6Uv0vaRh5JtMVWKA9qJ7XZyuFdcd8Nt88vBtvTHGuLDZveSEBP+XqjDY6kwCglMAhyKAyDmP8IMAZQcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875990; c=relaxed/simple;
	bh=x7VoocJKZ8xJ58hcz2JBPLApPENFPpGjQNsX571uwe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RaNiiS9AxEsg669sHma7iKWZp7zEIAiUnhhQvuVat9dN36ziVEQKKGMqli6D5bZ/mHAzAhTqamtZXj8KxcBgawQfQit2ibGIWSnjrqdYbOdQFIjWaIpQDzPUosQ7os96vXlFU9d+JPqOaDGEhFNOAwR1c5dgWu0HbOgGoO0MHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ruT+Hz39; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ruT+Hz39"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qNipME9Juw2dCqH2Uzcr91SyEvVM97h9UeudwTBJPwc=;
	b=ruT+Hz39+daYMCCADumV2B7ba1Fbc3ZlpfvwdaYDevBJR1V76J91tRmZxbn7q5mnxMedmhK82
	JBT6mieOkCr9hvBFLwspwsajYQCK7ojqqJHY6JSvvSdygvEShPb5xXQP6RJ7bXXhk31tinssft4
	fLtnCG5t2kPcEEn9qQdYLsI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j3llJ2wqjz1prNF;
	Tue, 13 Oct 2026 15:07:24 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 674CA4056D;
	Tue, 13 Oct 2026 15:19:43 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 15:19:42 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v6 0/2] fix two issues in hisi_acc_vfio_pci driver
Date: Tue, 13 Oct 2026 15:19:27 +0800
Message-ID: <20261013071929.3988687-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100014.china.huawei.com (7.152.184.20)

This series fixes two issues in the HiSilicon ACC VFIO PCI driver:
1. A NULL pointer dereference in reset_prepare() when a PF is bound
to the driver and passed through to a VM.
2. A 64KB page incompatibility on QM_HW_V3 hardware that breaks
migration and the guest kernel.

Changes since v5:
- Fix a potential NULL dereference in reset_prepare().
  Open code &qm->pdev->dev at dev_err() to drop the local variable
  evaluated before the mig_ops check.

Changes since v4:
- Removed dev_err() log from reset_prepare().
- Removed redundant pdev->is_virtfn check from probe().

Changes since v3:
- Merged the set_reset_flag fix into patch 1 (was a separate patch in v3)
- Replaced pf_qm guards with a mig_ops check at function entry.
- Moved the 64KB page check from open_device to probe, selecting generic
  ops instead of rejecting the device.

Changes since v2:
- Remove redundant qm->io_base check.
- Drop PAGE_ALIGN for BAR2 configuration region.

Longfang Liu (2):
  hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF
    passthrough
  hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
    hardware

 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 46 ++++++++++++-------
 1 file changed, 29 insertions(+), 17 deletions(-)

-- 
2.43.0
