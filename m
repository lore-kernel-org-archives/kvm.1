Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7E3AA4F9;
	Mon, 24 Aug 2026 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560145; cv=none; b=hAZW4/+HYsEzOH+VwSJtfmZ+8OBQF/9hY7UtFX+1G9g2bSDSDgKaaxmqgY0FD0hVzulh1xKKoK3bKFm/AuYwSo97q/To7Ah57j1ltH/MNd/tjINo+zpcNSxBiqx7ZxBSsVMeOa1djJsdco0u47zEh+uIMUYOo1EYhAscBgXrvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560145; c=relaxed/simple;
	bh=dRLcLdMYl5GzeBCaUejbuCc7hUZHXW7WoQrE1FpJxfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdNtcFaWh/esgctJPMOCWPLYCnpT8poHojGsBJAcZ3zTPV9E6Sl5FCDfBtmb9g1PYPopfJt0dvaRm4btY8EqNPQAYITmjIaXDmzQ+elmIVjX+W0goVpqqGFc7a1qLSHnTpZtEXHvWHm95E6kRgS1LPV4N2RUagD0bXCtF0Aw6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TX5Q5dqM; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TX5Q5dqM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cdc1jqWA1QUbbCM8EfKCvKPeocDc6VKAXtctAXStpeo=;
	b=TX5Q5dqMHL3Ton1ZYDgFulIc0+6p6g8LOj+v00acoXWDWHssILhBlYuGFVPVumTXjaR86gDWF
	jIYLWt+aIqsIdGUXwZlJyMnfVfUoGoQn66AODpFLl3xVTL0BU2nmt8D6WMpYs69fz681vwWJ0o/
	p7qkyl4JESORslBQj/R/bfQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hT3h028qTzLlTg;
	Mon, 24 Aug 2026 16:18:08 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id A473A4057A;
	Mon, 24 Aug 2026 16:28:52 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Aug
 2026 16:28:52 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 0/2] hisi_acc_vfio_pci: fix two driver issues
Date: Mon, 24 Aug 2026 16:28:49 +0800
Message-ID: <20260824082851.1436129-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500015.china.huawei.com (7.185.36.143)

This series of patches fixes two issues discovered in specific scenarios
within the driver: one caused by PF device passthrough, and the other
triggered by a mismatch between hardware version and memory page
size (QM_HW_V3 + 64KB pages).

Longfang Liu (2):
  hisi_acc_vfio_pci: fix live migration enable conditions for PF
    passthrough
  hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
    hardware

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

-- 
2.43.0

