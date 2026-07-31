Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AF1D95A3
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533590; cv=none; b=qeXJoMnknqCj9X4s8UFkFIaF5W0u6cyflqC3NLsePT8AsSoRX7jfpjTqZifRFe2tG9z5tciGRGtp0dPES8IFC80qigXEubVA/Ru0gWAlVNiAqC5AMVW2cvkiLci3QbqC/KPwcjd+ArglfBXZueB5Co14EVaQXnfT9LmEnS45W6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533590; c=relaxed/simple;
	bh=MvOB32OcZnuLePIPjHQEokG9w+TViA1MfpDFtDnXxig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYMb5BNiTxSTFOuYlgnsOBKTWzsHSrXCyz+9ykBJSiAi4QZG6OBuYxnH4Dg8iaFCeToh0djeifnktSDlL/32NKvp1MPG15NF22vY/Dg5R7EQNslVvhNRkfiCa8m4Zk3ioxHly9e9eXUouPjDZZ0XiwYbvuIlot4kU4A+Dv5HSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a0HFdqWM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a0HFdqWM"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VLWsDV2307560
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=vCoC9kPvd9L9eWd1I71UR2CsPLtClId9Denx+
	viO4H8=; b=a0HFdqWMro7MinE5ctNppEbCSV18apph+UkeVVXnOtQ6EhDXJcufW
	D1PqIdndYX0TI58jA/yD/vN0jDzd+KLye8UwCiPPWf3MbyUiKTdM50lddDV1yo4/
	MGJ5vPARTpgjoPD0Q+k/kngRgEpC5sk0g+Czfb9Y4xeKjtc18rIjRZ+jfw12DcUp
	D2DkHhLEUOK5vJvnNoOo7yFU7yVy47zhBcujx7ZbOzp+aKrVVNtPiD6tdHlvkN6Z
	cyE8qWchN7zL+BjRQm2NQ8genhJtQsQ50QeRZu+Z0eIfjaKz8tFVaP68h38VRq80
	zSiOMWqTtYtDURyis8FkIXR9cnZ4VcibQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrkq002g-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:33:07 -0700 (PDT)
Received: from twshared14178.03.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:33:03 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id EBB1A43C24EE2; Fri, 31 Jul 2026 14:16:15 -0700 (PDT)
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
Subject: [PATCH v13 3/5] dma-buf: add optional get_pci_tph() callback
Date: Fri, 31 Jul 2026 14:15:50 -0700
Message-ID: <20260731211601.3033906-4-zhipingz@meta.com>
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
X-Authority-Analysis: v=2.4 cv=E639Y6dl c=1 sm=1 tr=0 ts=6a6d1494 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8
 a=mECi3VIRXVL5EC2FsE4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: f6ZZBrGF1E5dazL5YAWCCayisORqjuoT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX0i1yxgpxD4ON
 PdE1Nx3zQXvbmPGLZKtZIIwr5JmHD9sFCJYyEndqRdjfmByCn08YF7V9O9g87srL6v7kVrI8oPA
 MMPJPgeFXzwSH46oKwUK8Rt+h6+L04Y=
X-Proofpoint-GUID: f6ZZBrGF1E5dazL5YAWCCayisORqjuoT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX+QBAtSp4aDTs
 HuQ18YW0EkaW2M2eC8zwn6kA7HN5cf/xGAcDXpheKtqInpjdMyAwrVuYoe8zOCVo1uYqXp9QKD7
 Ox54vZ3po2j4eD9jBf1qwqH5GWndgjhU+OD9JOSlLujt5X81EUhxRy7gr9zK9tpCL1HWNHqkbFN
 9kO3L1cOoPelfnenKq5qR6TOKsZKDr/ichO/YB9lPaz9LhgEeEk6wi9iuT45za/OtUpBKQk99de
 Ulop1+KKUNhDI0xQ/CDxZDglj4PjBBqDcJ8OvI74VRTFOgW317G9lhSdS/ahd90aWisctbFMNCe
 2N2Aplui1B0p75T6HLSmP4JVoUqF+mzO5E+4pfGwIa0bouCMoMDYLcmHI9j2v06YOAiYti6X23I
 lp8S9U92tXXTF6+CUM5Eo2N0SRgs5nd3jt6JVn8FYgMtqMQvU1SGmTOt7cqgU6Z75OJaYBbpheb
 21/k/e+qBd18Vw3Xz1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01

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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 25 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..71f335442ba7 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -939,6 +939,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - dma_buf_unmap_attachment()
  *     - dma_buf_vmap()
  *     - dma_buf_vunmap()
+ *     - dma_buf_get_pci_tph()
  *
  * 2. Importers must not hold the dma-buf reservation lock when calling =
these
  *    functions:
@@ -979,6 +980,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - &dma_buf_ops.unmap_dma_buf()
  *     - &dma_buf_ops.vmap()
  *     - &dma_buf_ops.vunmap()
+ *     - &dma_buf_ops.get_pci_tph()
  *
  * 3. Exporters must hold the dma-buf reservation lock when calling thes=
e
  *    functions:
@@ -1144,6 +1146,36 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
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
+ *
+ * The returned steering tag and processing hint are only valid until th=
e
+ * exporter invalidates the current mapping (signalled to the importer v=
ia
+ * &dma_buf_attach_ops.invalidate_mappings). Importers must re-query aft=
er a new
+ * mapping is established following invalidation.
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
index d1203da56fc5..14e8eb61a62c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,29 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_pci_tph:
+	 *
+	 * Retrieve PCIe TLP Processing Hint (TPH) steering metadata for
+	 * this buffer so an importer can program a matching ST/PH hint on
+	 * outbound TLPs targeting the exporter for peer-to-peer DMA.
+	 *
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Optional callback for dma_buf_get_pci_tph(). Called with
+	 * &dma_buf.resv held. Returns 0 on success or -EOPNOTSUPP when
+	 * the exporter has no metadata for the requested namespace.
+	 *
+	 * Returned metadata follows the lifetime rules documented for
+	 * dma_buf_get_pci_tph().
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +586,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
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

