Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D53803D6
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533287; cv=none; b=nRq52ddS8OMReVWX2EEaJAIPHCw3xMwUQ9oIl0KPTWrPwDJ7fgxlodQG5bHRBfHPgtS+7jILYouFTZmKAQnGXTjFGo/vlHF/kORgNGw1/aFn+udy9twGxIRwsZuH3dHOSbhvIEJPAhh3fMpZrhT2uDl40cbVXWLsfGo4fQzWSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533287; c=relaxed/simple;
	bh=meQDWovVlwq9l83GJ3i+XK2S1UHI8/kEM1Z1ZJaX5MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUH63gF4pHlCZP2mcO4Ha1SAefWYPn0r52hgl7P3QbHdlj/VZ7221KCwEtuNfVHJZbsyi7zhrobl3YtOqPKIoWvHE+ZA9/ZE6LUbTIxO4L4jhGsdTiG58p/bpVidTXk66Evha7rpaLKU6xgYyDDtfpHNBIIZfNn4pmLRGNE9MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HZlnexVt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HZlnexVt"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VKX5Jw2105498
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=W7iqLmYoZdNfKKZd/AsiKZKGkQzWVXi2ivpsj
	OaJhGQ=; b=HZlnexVt3+uoXQ66UYkAypriTFtiVZCTZ0iuWnripwU4s81QQYMtf
	3uiGm7MDLbrR3rjFIOMPn62LHDRzhW3PlLrqOJV3tfj8gTBN6OcXnzxfDecOgtKP
	qUKbjdUe8IMDI1YfX8bmQZEZVGbunyhMrquhFNbFvOCZea6NwtEsRNjOKF2QzHJ4
	Hmdxyd7aYrM8RzpU0ZVs8ZqQMTT/oBFRzrw9l0QDqGu2pxGc4LxOL1K+ymsaV5PB
	ndv1MDSEHEVYXhnrc5IWACVLSQTVgOd+58F8tlerdxD+pnzlJ+B6tYcZWYxn24aj
	hdJni3HX7B9Y+EOIeOSrtR5b6Hp5dQdag==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fs2n60a8j-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:28:04 -0700 (PDT)
Received: from twshared14582.04.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:27:57 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id BDF5043C24EC0; Fri, 31 Jul 2026 14:16:14 -0700 (PDT)
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
	<zhipingz@meta.com>,
        Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding as unsupported
Date: Fri, 31 Jul 2026 14:15:48 -0700
Message-ID: <20260731211601.3033906-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX81ZeirEA7nSC
 HYPOmZ1sW6MouSstIbeT8Rk814656X26Wz5NLHo8XOtiYe1zmeYp4ji/T3W5IgWmCD3u/CCZoc5
 /bCsihm2XTHaqc9OFy8Jrcwlov0N5y0=
X-Proofpoint-ORIG-GUID: nSQeOEpTnlmeTR3CNEePSUmybFObBoj3
X-Proofpoint-GUID: nSQeOEpTnlmeTR3CNEePSUmybFObBoj3
X-Authority-Analysis: v=2.4 cv=UvNT8ewB c=1 sm=1 tr=0 ts=6a6d1364 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8
 a=5iV6q52TU81yRMb5XQMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX5JVdbR5ql6T1
 IVdOX6DH8R2cuyN2S0UrT8O9q+S6MzTcMWZJ7IGsaImr+CZM7r7LWy0M8CYLBE1ucSOHNort4qU
 U9pfwJgfk+6OpktfijlXm5ZR5W+FSAbwCmdEw9Ezr7bfkzE7GHOYWjSLDNZhDBOFwAr7j9cFSuF
 YpItzs8WLgMjJTs85Vlw2c2mo67XGuG8+4BTFPDNsjwRHBLTnqwNG24NbNavIdDIlc8VgwcSlCE
 GV1vUJMkkzoXfxitTEuAXxvjJRBTSBuGsE15Hy69p+YiezOD0wCFGkKWfakkt0LKo6AEmahtZnE
 7NnzdEVgjqNWS8koW5iFpAyTE1XKMM4Tw3kmGB/hfrbKEzEYHxx6CD3Q4qY5ZAxyt2fWdcGRtxx
 ubdrLXr20LbRBqIWoTquA8AHYR111JN2U8xAocYnVuYh+atQXprV+gmbcwdDoLpPmZAWwZgMSWb
 vRi+vLoB1AfXcX9SbjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01

get_rp_completer_type() returns the Root Port's "TPH Completer
Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
into the requester type:

	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);

and later writes tph_req_type to the TPH Requester Enable field, which
only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).

No known hardware presents the reserved 0b10 in this field, so this is
defensive hardening rather than a fix for observed silicon: fold the
reserved encoding into "not supported" so only the three architected
values can ever reach the Requester Enable field.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..5cbb381e2a02 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -200,6 +200,7 @@ EXPORT_SYMBOL(pcie_tph_get_st_table_size);
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
 	struct pci_dev *rp;
+	u8 tph_comp;
 	u32 reg;
 	int ret;
=20
@@ -211,7 +212,15 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 	if (ret)
 		return 0;
=20
-	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	/*
+	 * 0b10 is reserved; treat it as "not supported" so only the
+	 * architected encodings reach the Requester Enable field.
+	 */
+	tph_comp =3D FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	if (tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY ||
+	    tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return tph_comp;
+	return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
 }
=20
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
--=20
2.53.0-Meta

