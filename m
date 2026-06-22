Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE75344DB1
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154102; cv=none; b=gqCIOJh8ouz1m5exIYlHCx8jvNBDiNh65Oi9KOCgknDDVjPP3dPEQsCKYSba4Q61bVEqUlXxrJjl+cT6OjlwUB+ESH1DGNDNdxsTxahzoFsY5nA3xtJPNJHjSe3ZlEJljyUt7+d0lCKrZa6BRZQe5+Mabii3VAT2TGvGQ+wkzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154102; c=relaxed/simple;
	bh=fNgEqHnFEeEZPN9Xt3eQkiWjFdfTr5AgQDWEU7ebNQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/hzGr1+l9h7vzP0gbMghtyXwoGI1EqGagG0H2grsCD5iPqMj5fIr9umus0YlaXEHOQleP6mmuwtNhspBCFmt6o73y9exuxiwuRZlTRaMhMx5Yv5F7XaSjkdDJC6WEtfRR/vG1SwcFV0oJTMCRunI3ruVUiyYKPl6BTl2dFY3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jyQD8H4m; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jyQD8H4m"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MIkACL2452333
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:48:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zjBsHBUtYdR789lklIL+1eh40pAOxq1ZSktpZnfPk+M=; b=jyQD8H4mVF0q
	RnQ8WLtzQRQJFW6j7Gdw9wlZm7XidO5dDWoVUiegXV9dgYdYtAirZzAcaM14knoI
	YFrwrMpdcPh8qRuse2nLIWyEr4Eu8MTLZ19oq50TOeQ5D/71n4tKvRGDW/RxYHYC
	sQFVnxjifQ4e+W0vXIOx/uthbykLp4KHsy+6NfnJON/Zl1zPimIp953goGQYAIpP
	Wio1HX6skl6fEiQLToRtCCjMS7Sr1wCN1EAf9g9jzLd0cFpv4JKV4oHuUSPvVR4r
	Y2P/jFyhuUYx9ZxDXMkf2Wu22vTwI7kSpfBZIEtLaHn3jZcHwewwYMuCbxU7LXXB
	ohiQkcqNbA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4excejh1yh-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:48:20 -0700 (PDT)
Received: from twshared25959.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 18:48:14 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 338613FB8E30D; Mon, 22 Jun 2026 11:42:13 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v9 1/4] PCI/TPH: Add requester/completer type helpers
Date: Mon, 22 Jun 2026 11:41:34 -0700
Message-ID: <20260622184211.2229399-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622184211.2229399-1-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfX8Cv1keEWWkmh
 Ud7yh+kzjujXoHAqcU96cyo54MX5VLnIuJl2gLehP3YGQEB07WIYAmFaJgMjt29vokEV0I/ud4R
 9y1iOUYTOF0TUnCcnJ7GiWVJGqhv5270esGlRoj2/T8sH9dAWMBrCB1XJWwas7lrqtTQ3/c5S0a
 ZVPv68HC0DNE0ksxz5rGeNoG3pWUzo4/w9e8vI5Ohtvvaid5zKbNPm5vatUTjTGEgwvTdRbXHTS
 E5cqAu5T5IS6lSHC2W3B/vn91dUoF/C6K93HD3g0mfpRqMAZYMvWUPhV3ueXnkxa+caaDWI+bTZ
 6MV8shhWXuD9QV4H9fOT+8OJh7wtY0Z7wYlzvDqH1NNFQHe7S52GoURcky3p20W6Dvs/n+OKqPw
 iSfA2EV7jo2eFi7ekystgJGDteqeujOd35wkYDjauXgkJL3Gn7UZmSFKaYHPOHNaIgPprcBPKLf
 qBXThkN9m9MyYYkgOsg==
X-Authority-Analysis: v=2.4 cv=T7u8ifKQ c=1 sm=1 tr=0 ts=6a398374 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=K7z10gKaAp536EQdUv4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfXzZQzwDwNVgYe
 6z1e9XFSixyZzcLZ4rZkAWLwyzsBs1EtwEE5rQ1kKBee62Ej90b+wpvlB95mTHrytMeG7p6HEXJ
 clijZDTZ3stpq1rCukxjV7zTc7WSqzg=
X-Proofpoint-ORIG-GUID: q0mpPfdRxiBBnZrb_0RvVQ_NOSOy1TlQ
X-Proofpoint-GUID: q0mpPfdRxiBBnZrb_0RvVQ_NOSOy1TlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

Add pcie_tph_completer_type() so drivers that publish TPH metadata for
a device acting as a completer can gate on the "TPH Completer
Supported" field of Device Capabilities 2 (bits 13:12,
PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
state. Fold the reserved 0b10 encoding into NONE so callers only see
the defined values.

This keeps pci_dev::tph_req_type and the completer-capability decode
inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..717b47d1d9ca 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
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
+/**
+ * pcie_tph_completer_type - Return the device's TPH Completer support
+ * @pdev: PCI device to query
+ *
+ * Reads the "TPH Completer Supported" field (bits 13:12) of Device
+ * Capabilities 2. The reserved 0b10 encoding is folded into
+ * "not supported" so callers only need to compare against the three
+ * defined values.
+ *
+ * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
+ */
+u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	if (PCI_POSSIBLE_ERROR(reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+
+	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
+}
+EXPORT_SYMBOL(pcie_tph_completer_type);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..7743af6fe432 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,6 +9,8 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
=20
+#include <linux/pci_regs.h>
+
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be diffe=
rent
  * depending on the memory type: Volatile Memory or Persistent Memory. W=
hen a
@@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
+u8 pcie_tph_completer_type(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +45,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
+static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{ return PCI_EXP_DEVCAP2_TPH_COMP_NONE; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta
