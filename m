Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0D3DB31B;
	Mon, 31 Aug 2026 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167407; cv=none; b=P+qQhUDBJT3GGDKw0m7LTLnjMgbK3vZt4P7lxiBSy0jCu9UZ1AqXvE/bg/7jCytWaR2+AmZeL0oKtbO7brFAHiTN0oMhhfZaN4HN07WVQBVCxSXKbUH+4IeZF5n7OBNgFoh/ba1s/H9yJR1spERT3fq3dio+xkBCyyV7N4opF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167407; c=relaxed/simple;
	bh=FIbsewL3Swj5l2EmTvmW8pf9be8oZb9pttPxwoY1wMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngU1h8MPpRpzFmiIgifA+yUKyzzGJwiTCt2p7OrdICWgLjg8FSDK3/r3gUhGyJaeZ5PYhwaRtZ5oEmxn+gYtkY33pNth2B58/1/5z4OMAnxYN5xTgmi6Pd42Eh1YtjAEw9pLR40Gz42GPGXqHQn6wKvc3SZpznwsUUTgpD+sDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WJc+GNH5; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WJc+GNH5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VlXgNXOULHLT6iEyYOwz7SsM49CsAfVi0NYke9687G8=;
	b=WJc+GNH594SeCjnpGrIe/YHtubCBIHyf/Ya3ZspyPYEehGAkCnSRpSkSqUYhUnKzp3M+3+QNV
	52kyFWGt4x4+Gsa908Z53yKaGcTVTPyHcW+kaAfBoWXLwrBwjQELQwFL7o/dr3WNkvHz4npLVeM
	grzX+GlHohLiVXujLwv/ujk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hYNG713wHzcbN0;
	Mon, 31 Aug 2026 16:59:11 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F954056E;
	Mon, 31 Aug 2026 17:09:53 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 31 Aug
 2026 17:09:52 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v3 0/3] hisi_acc_vfio_pci: fix three driver issues
Date: Mon, 31 Aug 2026 17:09:48 +0800
Message-ID: <20260831090951.844569-1-liulongfang@huawei.com>
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
 dggpemf500015.china.huawei.com (7.185.36.143)

This series of patches fixes three issues discovered in specific scenarios
within the driver: one caused by PF device passthrough, one sticky-latch
defect in the reset path, and one triggered by a mismatch between hardware
version and memory page size (QM_HW_V3 + 64KB pages).

Longfang Liu (3):
  hisi_acc_vfio_pci: fix live migration enable conditions for PF
    passthrough
  hisi_acc_vfio_pci: clear set_reset_flag after reset completed
  hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
    hardware

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 43 ++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 6 deletions(-)

--
2.43.0
