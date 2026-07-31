Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512D489880
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532937; cv=none; b=eaR5Mx/oyBacvR8j85Gv2EBcdps+mJMcilmZoF9pwV/5aWMlBMJ1ld9XStgB9ut6LkQ6qeUd4CI4A7R1Vxe6FxxRBj0qUcLjXVPXCl402+9wBPJLNIvd+ycHWT6s9NPQs8pN6Vcv9aDk7QLdUr5RXjD6OBlgUyNystHDK8gO3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532937; c=relaxed/simple;
	bh=61LGxgbwioDhky7KmCpvz9QsqWmStm3Otzwr5zJolHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cUx0QLu39AsSkcZ/pvOPllrrqaMWQtSS7ChRbwHC/tDmg1ymCbVZMcduBUsMuZAv3jZZjF+yEXFFnkwr1irvBE0XHSfdINanuxGPZsOl8j1IvLkTiVTt38zE0H45rM9PfdH7xDZD7X2eeP8wJff/uUVJzCrGoUiTQZ5+NjCQmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HT6OU2r0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HT6OU2r0"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VKXC4T2186232
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=pFKzXrE9d
	JCGAaJnRLSJRFbf4ZRBBbauPPLUdV0LPAM=; b=HT6OU2r0MqdmsK4r2Xs76u1e6
	Gfmyp4XOqdNVpohEkMGck6DZ2qQEUdp4Gw1TvZcYj/toKBMuZ2RMbGkuYQMZYxow
	D23tXIHhS73DLSrA2bGy7Btr7+kJuSf9dtqu2rHSPeV+7YK+pkH7438cIu+ury3z
	oHrtIDD3PIOMKOy7J/uaTO9AWjdz0FAKcEtsseji7zxiQi1chvPoK2ha/mYruI65
	Ve75BdrRn9em0zckEx19Ysdo4NWJWkSg6NC5rWHLTOkqSmcsjO8PFjpFB1vrZbKe
	QW+T7RM/1eRzpspOOhQsBLNWvn9qHErSB4QdvfiMmNJT5tmaiyupfT/jae5Jw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fs0dsh67u-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 14:22:14 -0700 (PDT)
Received: from twshared22813.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:22:10 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 2B8DE43C24DD7; Fri, 31 Jul 2026 14:16:01 -0700 (PDT)
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
Subject: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Fri, 31 Jul 2026 14:15:47 -0700
Message-ID: <20260731211601.3033906-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MiBTYWx0ZWRfXzdFK4DcN2jDD
 2zAOGaUCI2f4UYhFBkUL5Cb5x1lhRUEmgChbQVF4XS81KRvHLQi8X/6d6zWiXvQbsymchTAsUox
 PgwhpBxmppTlQpeAqZaz5g0StW1yVkQt/KEmFmsigxCC1S7xFQJfG/tPY+ToUj3bNHHNJj/FZWG
 EYUOJrZ+Vd7KWnBFm0pU4UGEVd3ykn2dF5SQdiIZAkTchHmo1IQ2OqRgCg/jXMh94bwDMoqgBx0
 g365cWGl7beOPszkEW9jsqYdgfAh8VWjhAdz7qf8uxHekrpdEvDyOSAHGm4OYLI+9n08TDk6KP5
 ez6eo2gL3QrT7Aq9lfpMtnomgjLkk8G0aKs5r6Zmc85SbW1A1GVnmDXUm5330YzK9GAdCSo2gak
 dPJcYfmw3UzQvtkCpuLYF0n1YvKWD9jwmL56ldW9Pc+LosEzgOFh0QVnal1ZSzTzBgJpa6/5JV7
 a4HtoiFiW1h8v5UIAlQ==
X-Authority-Analysis: v=2.4 cv=Du9mPm/+ c=1 sm=1 tr=0 ts=6a6d1206 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=6WOsqIM7_T6_WFakPMoA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MiBTYWx0ZWRfX+dl+8KqoePNh
 K6V2dgUqqY4XhduBvbcwWTqK8h/mBbYB3ioUvoraNk5R7lYlKLK3WPJC+nr0XwmbdfHBmukpXzn
 IGyObmUDDB9mYPdp6inoLVouvouflHw=
X-Proofpoint-ORIG-GUID: cHFUHb87REZWgaMB3DgAgRFGxuGSKqdi
X-Proofpoint-GUID: cHFUHb87REZWgaMB3DgAgRFGxuGSKqdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

There is no separate in-tree vendor kernel driver for the target device:
vfio-pci is the in-tree driver and the targeted device is managed
from userspace via VFIO passthrough. That is why the ST has to flow
through a uAPI: userspace owns the device and its ST table, so it is the
entity that can configure a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_pci_tph callback itself is optional, but workloads that
depend on the endpoint's in-flight operation need it because fallback
does not produce the same result.

The dma-buf hook is intentionally generic and discoverable rather than
a private side channel. The exporter owns the completing address
space for the dma-buf and decides whether it can provide a meaningful
ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
and importers merely request the namespace they support and place the
returned value on generated TLPs. Exporters that cannot derive a
meaningful tuple simply return -EOPNOTSUPP.

TPH is advisory: a steering tag that is not honored on the path (for
example an intermediate routing element that does not forward the TPH
prefix) is ignored and the request completes as an ordinary,
non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefore
targets the same-Root-Port / common-switch topology, where the ST
reaches the completer; cross-Root-Port P2P is best-effort and is not
gated in the uAPI, since supplying an unused ST is harmless and there
is no discoverable "TPH routing" capability to test against.

Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding into
"not supported" in get_rp_completer_type(), so only architected values
can reach the TPH Requester Enable field. It was previously posted
standalone to linux-pci; per Alex Williamson's v12 review it now travels
with the series, which removes the cross-tree ordering dependency and
lets review tooling apply the series as posted.
Patch 2 adds small PCI/TPH type helpers so drivers can query the enabled
TPH requester mode and the device's TPH Completer Supported field
without reaching into pci_dev internals (and so callers in
CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_type=
()
applies the same reserved-encoding fold as get_rp_completer_type(),
inlined locally so the helper is self-contained.
Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
metadata from an exporter under dmabuf->resv.
Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces the
dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid for th=
e
mapping it was queried against, and the mkey's TPH fields cannot be
reprogrammed in place. mlx5 therefore records the registration-time tuple
and re-queries after each dma-buf mapping is established under
dmabuf->resv; unchanged tuples continue with the existing mkey, while
changed or missing tuples fail the remap rather than continue with a
stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
because invalidation is revoke/quiesce, not movement to a new backing
placement, and the userspace-provided tuple is not changed by the
revoke/un-revoke path.

Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
Functional validation on the target topology: PCIe analyzer captures
on the P2P TLPs confirm the ST emitted by mlx5 matches the value
configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
ST=3DF0h PH=3D2 HV=3D1":
(TLP Captures)
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
E0200000 -> AddrH=3D000020E0h
00080006 -> AddrL=3D06000800h
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-

The dma-buf get_pci_tph interface has also been exercised by a second,
independent importer: a different vendor's NIC whose driver is not yet
upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyzer
confirmed the ST it placed on outbound P2P TLPs matches the value
configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result as
with mlx5. Two unrelated importer drivers exercising the callback
end-to-end shows the interface is not tied to a single consumer. That
importer change is out-of-tree and not part of this series. For that
second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D0,
an analyzer capture shows:
(TLP Captures)
08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
00170000 -> AddrH=3D00001700h
00200006 -> AddrL=3D06002000h
10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-

Changes since v12:
  Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
  previously posted standalone to linux-pci [1], is now the first patch
  here (Alex Williamson). Sashiko could not apply v12 because of that
  external dependency; with the fold in-series and the mlx5 leak fix in
  linux-next, v13 has none. The code is unchanged from the standalone
  v3; the Fixes: tag is dropped, since no code path can reach the
  reserved encoding today and the patch is hardening rather than a fix
  for observed silicon.

  Patch 2 (PCI/TPH): inline the reserved-encoding fold in
  pcie_tph_completer_type() rather than calling the helper that earlier
  folding revisions added; that helper was dropped in folding v3 per
  Bjorn Helgaas and Wei Huang.

  Patch 3 (dma-buf): no functional change.

  Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
  vdev->pci_ops->get_dmabuf_phys, matching
  vfio_pci_core_feature_dma_buf(). Without it PROBE reported the feature
  as supported on a device that advertises TPH Completer support but
  cannot export a vfio dma-buf at all, so nothing could ever carry the
  metadata (Alex Williamson, who raised this to uAPI-affecting
  severity).

  Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index()
  ahead of the pcie_tph_get_cpu_st() call, so splitting out
  mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation on
  devices without ST support nor changes the errno userspace sees when
  the _DSM lookup fails (Alex Williamson). The commit message now
  describes this rather than presenting the split as a pure extraction.

Previous link:
v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhipingz@=
meta.com/
v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipingz@=
meta.com/
v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipingz@=
meta.com/
v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz@m=
eta.com/
v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz@m=
eta.com/
v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz@m=
eta.com/
v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (5):
  PCI/TPH: treat reserved 0b10 completer encoding as unsupported
  PCI/TPH: Add requester/completer type helpers
  dma-buf: add optional get_pci_tph() callback
  vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/dma-buf/dma-buf.c                     |  32 ++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
 drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
 drivers/infiniband/hw/mlx5/odp.c              |   7 +
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
 drivers/pci/tph.c                             |  55 ++++++-
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
 include/linux/dma-buf.h                       |  25 +++
 include/linux/mlx5/driver.h                   |  15 ++
 include/linux/pci-tph.h                       |   8 +
 include/uapi/linux/vfio.h                     |  43 +++++
 14 files changed, 517 insertions(+), 19 deletions(-)

--=20
2.53.0-Meta

