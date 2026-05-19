Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03265320CD1
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222328; cv=none; b=dS3XfRrPJsLJLBldbjImd9VpuzV+T+zwujB6rFS8L1Fcjys16ZqQIejs37myhy10ASRnIluH68emBk+huX96F2YcvATSOp0atwhY2J1MBAZaNqBgsFg8GLT62VsuVabAh2jOccfTGlkw1caPlF7zWIlbnEJTRvagGe2G5bkNmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222328; c=relaxed/simple;
	bh=dA37R4YtoSYDx/LRAb6HTe3J+AD7RYOx5pXSv+u8r8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr35hv3zZZKYlmkKJXkodqQWA4is6ATPJEgWD9Woko8z0aoyg43pjI8hQslyT84xK/7KvRWbeI6zcMsYySxp2C+JUPKQwLwShGOuMJe0LkfaG5KKmAf+NcU+M+Gk6VpOKHNq0Vp2bn7krONebmTkDHIcVM7eKzzU24oc4X6bueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MtUMjghr; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MtUMjghr"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JKJIMK3374386
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:25:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rbYQZfT6xz9UhXToVb8wAi/NM8rY7U8L5aP4mxh8ef0=; b=MtUMjghr/Ra4
	BYZTh/gh7rLL8iSFD01ZRiUU0lM5+FjgixhztW4Lq8CLxVsfHyAbgZXmqPoc/Eca
	QbiImoM326mVvAGWiAhiBM9z6T5HCYc32EocwLvtbpUrBniLkIvkd9hQDUri+xqs
	X+tSgcvBEajUxSI5QMD+jWSJs1priMPz+Zo5bcr5U1VyFW9QwlUho4RI7hpWli5B
	/JpNdlj7+DQWXo9dy3AZra2abYTIklgyDEAveiW9wPtxitLiSQ1XISWlrj2WLHU8
	nAduPhDSyH4CkKQ9RpiJZ3lsAbaRjNj3ojPjfM7GQh+K/A+kBJvtb7Xy1FhS+SUa
	amxjUSKHrg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8xsxr15e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:25:26 -0700 (PDT)
Received: from twshared132777.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 20:25:24 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 3130E2F3ADAE5; Tue, 19 May 2026 13:14:06 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v4 2/3] PCI/TPH: expose the enabled TPH requester type
Date: Tue, 19 May 2026 13:13:50 -0700
Message-ID: <20260519201401.1558410-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519201401.1558410-1-zhipingz@meta.com>
References: <20260519201401.1558410-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwNCBTYWx0ZWRfX/Dln6DUYIOkR
 8uhNRh6Unq0J5SBUW5ZbA+eJNxD/NuPtrW93G6UHGuJ4O0HLB/TmquTTUNCzCrUzeeedkv+Kut+
 ZhaVp77sQtMAmqLqJJNxgMIua8ktmiMbvaswabNXwC9nrucKEYj75ZU5a9cjpteSgEeq2V46nE2
 tDIJos8Z3vWNiTsOqlWox23nYBCDkYxJtdpkLCgT7gseXKl6x4KjnvVaiaKK8Il7tyKyBKAMLQk
 rgH8/KcPufX5uO/Qp0yfX6LspHEEYC67SqFFhQeeGc08vHWVRupLBiH1PuYW1oTdsShvht4gbaj
 nK3JO7ihGCiWWP14f5yHFbjnAepWnylGg5bMpc26SEKpMDJdDkhbjDvdKQTPU3fZ4Ha4RHNoTSI
 f1/JPBJgHyR4wSIu1oYtTN9BOYj8jwuhd177veJeg3pkK9ck26ir0buS0pGCdWdygIvaHLBLxzY
 8fTwgLcTmV3suFXxpPA==
X-Proofpoint-GUID: WX-LkAENhXvSs9dIEVVYDnkfQgp5oBKf
X-Proofpoint-ORIG-GUID: WX-LkAENhXvSs9dIEVVYDnkfQgp5oBKf
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a0cc736 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=YRoFvhOfcVPyCIBj9wAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals. A
!CONFIG_PCIE_TPH stub returns PCI_TPH_REQ_DISABLE so callers need no
ifdef.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 12 ++++++++++++
 include/linux/pci-tph.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..6c4492075ae9 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
=20
+/**
+ * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
+ * @pdev: PCI device to query
+ *
+ * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
+ */
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{
+	return pdev->tph_req_type;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_req_type);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..fe572737b409 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *d=
ev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { retur=
n 0; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta
