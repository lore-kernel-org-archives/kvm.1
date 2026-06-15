Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B305682
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507162; cv=none; b=kglLwfF8kVUl/qJ0RN4CyVulnjgaV7Uip3IwcqNydKWo4Pi3PZ8RzuWMOcJYnGVhNo9AfBDH2kS1OYzM8j6ujqA6t2b167VJ6k2IMy96Hu0v/YjlslUWgsYbCYG9OSrxx10+3ilXq9YTwuPbv4BzIy7x76WvNY0GxQKMb1JPOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507162; c=relaxed/simple;
	bh=FVeUhqWQ7R+Gj/BJXno1qRZEvsdwpqmSVpXar+cQYg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teCYt8viy6T94LWrAGJc4mmk5tRSPYctkUAoKs1vk08S5ojucSrLoOwlHEnNpbo1Qbv//phfWDGsVHMRoQZ4Jn/41B/UQuXIn9pzgzho9h0lkeLYq+2NqrtLKYydOFBg21meh+RdIss6LOIDxXOVx1qpzglpH8muMAQ7pPZjX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TUycQ0Sl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TUycQ0Sl"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J9C51218580
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 00:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=JeSGRuwX91zOvjF4v2GthEyP2VW8b6u7SQFPyUI3/CI=; b=TUycQ0Sl7trO
	Y7lB78MwW/Tf7FtAi5WNN/MRtv6FsbDLojG1tByQT6WyYkDBGFQXBL/X59UWvY4M
	bJCU8JOb8qc13qDgZVCKmz9xGKu9sKTg4i7/AopQXnzmLkaVPATDFYVjlbe+FNkR
	ViMdXBWZEMI8u9TOPd1BYU/FZ+xtaI0c0KmY4xhe0yZUk1WVsVbp29uvmUZmaWG8
	w96GCG9DicnQGG22rsPlWDjoqwGx1tsk2PkIc9Ww+i7f8PrrFN9SH/RzSApH/JVA
	17sjlOmQ9pUG3kvKTkZ+TZi/pHc8I1Uc/nlc0DZPPgxp+WrnELnDp968k045NcCt
	k7sZY+U33Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2h0qn5b-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 00:06:00 -0700 (PDT)
Received: from twshared5616.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 07:05:55 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 7385A3EE34510; Sun, 14 Jun 2026 23:59:16 -0700 (PDT)
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
Subject: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
Date: Sun, 14 Jun 2026 23:58:59 -0700
Message-ID: <20260615065912.2177918-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260615065912.2177918-1-zhipingz@meta.com>
References: <20260615065912.2177918-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a2fa458 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=NnIffO1M-inhYcDKZaoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfXxmD3+sr+40Ot
 sDYwa2Ysjuu6BzorQQwjff54sORM97DBeUrX2KY9c0oW/W/zOdrVnPCU5EbeaEWaZMBxzvznITK
 hLNwAq+yRPVBVAAmeq9gQuHC65yBBus=
X-Proofpoint-GUID: D1kQ5i4qHhVq-ljpMr2sdyZO2F9B65ij
X-Proofpoint-ORIG-GUID: D1kQ5i4qHhVq-ljpMr2sdyZO2F9B65ij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX2nNXczOY8Hzz
 zkOrtRONGavS3/qz3XBOrHfpoxiB2JPtg44oj2rl2PmYHLDXcanjBtM4bYVHADpQNYlXEEfBymk
 QQiSZe0emitDCd8r2ZuE19zibRpcCrWWDC9UC/CqGsvkYm9Mb0wsRLXu3qRW5oaOBkhZSi6+cZg
 AqB7toHCE7PLZZ3ZZYrKtc9dgx7t+I2QvaglZpOGZ5XrUwCjTOGxvLGGaQSOyn6yZOqD9d7Gcqd
 SAQoK7vBz0eCchFd4kfSmvbDcFpApYUkLhTfAjiZCRpXPSY/paeu2IAmC1NmsKZVbIP/qOcd5RP
 x6vnHfyqfkOXAp2lS/ktj7EGuYo8UEruBGp6ZbUTuzUgVbTBUtMb5p+lgIPsvLGRo1tgB1cpaRP
 9YprF1JOMJnVbmYyoPTzdsdXPxT/fbpLeQXTBQODVIY9Y9tuPC3u4gE3n2THcOROuqBtFgI0Zw1
 jDXbd6uOtKt+n+6tvEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01

Add an optional dma_buf_ops.get_pci_tph callback and a
DMA-buf importer wrapper, dma_buf_get_pci_tph().

TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
distinct PCIe TPH namespaces, so the importer requests the namespace it
can emit and the exporter returns the matching ST/PH tuple or
-EOPNOTSUPP.

dma_buf_get_pci_tph() is the importer entry point. It requires
&dmabuf->resv to be held while the callback runs and returns
-EOPNOTSUPP when the exporter does not provide PCI TPH metadata.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
mlx5 as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..7a4c9b0d5dab 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
=20
+/**
+ * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadat=
a
+ * @dmabuf: DMA buffer to query
+ * @extended: false for 8-bit ST, true for 16-bit Extended ST
+ * @steering_tag: returns the raw steering tag for the requested namespa=
ce
+ * @ph: returns the TPH processing hint
+ *
+ * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
+ *
+ * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
+ * exporter does not implement the callback or has no metadata for the
+ * requested namespace.
+ */
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph)
+{
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->get_pci_tph)
+		return -EOPNOTSUPP;
+
+	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachm=
ent;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of=
 the
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..5e7b69a40f3d 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,20 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_pci_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Optional callback for dma_buf_get_pci_tph(). Called with
+	 * &dma_buf.resv held.
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +577,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 		    struct dma_buf_attachment *attach);
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph);
=20
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_inf=
o);
=20
--=20
2.53.0-Meta

