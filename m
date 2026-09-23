Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC75616BB
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190765; cv=pass; b=SczyUTcbBsqvzpZEPsdnUA0tEuGLl5YiRiIORqoNLAdAJwFgQCqyUtePtci1pAhVQIro4zU7mtRUX5GIAHXx62QjYx0G1IwE66NV7i9cUyNEh8ZCHdbOrJrjhnLnNoFKksMMJk0N9bzf7Qy9yhi9t/cHtI33tYh37l2dbbSfNIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190765; c=relaxed/simple;
	bh=AOdj9fLFjQQcF8dLtOWeuDPgZMMvEstM+FfbA3jqfZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKGfrOyr/CLaEQBsHgpgylq3Kl44uXrSn6zc3J3Wdk00Hq2BpRamFVFLO6c1yKf/l2MUqyfhqqoZw2+6PRUYKmaI0QgCM3MgjFsKPkKLRm1zU9YBs70mXWfDtEN7r92cHhd5pI2UT4AxdXISyHd4STs8++wJdsGjznMqUXzD3qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=h+xdGrvw; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="h+xdGrvw"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTvRa2814746
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=67gq13570PCIFrF6WQtCzSbNx2SomruoSlQd4
	wdQr34=; b=h+xdGrvwJ0B6nhNZjpwStIsUJRdCVAIf4yMaQhP+HPuKX+Xn+sERN
	zAu/uL6h77FqZ9/Mnn2t3C1AKvM4tpljeQSWI126t5nlL+e00qU2Z2DuDCEjXMtp
	AMQuJGLWUSI3hzJvHrHpYCcAnGJmNFWV0OsJoNUmdV6Acr7Zjyxl/4QUQuI3QcRJ
	Q3getWXKR8ljqn605WDJyhCyjO56r+BirICsNSgX9IGp1wJ2FAIqIBANTS5nvgi8
	fAHIDJLNr1+SVhrumUY7XE0cb2ijbI0TK7OK3XjwUS3m10geLcadUorADxIwU54s
	2ni/qRQCm2328sbhCHMDiYoSQZ0f4FTAQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gv9bpntu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:35 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-804e73b36eeso2242938a34.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190731; cv=none;
        d=google.com; s=arc-20260327;
        b=AGIbas2X6FdyvUXBPziFR+xqo2w1BnrQtBSaDANsGSy9UdR49pW60MBQsBTMRZfnmn
         ywn8tHEYo/emRONmK/xwghD8kM7eIOw5xIvmxEPJ2QsXwo+zVZqWe45IG2EtxeyivH4Z
         NYh1OqWgXCvyYyxutHvAvJG52qoUkQ6Q0XerG6P2pqEKbi3px4WoxRMKAyWPoTSC4Xhk
         lYD2fUBVk6CXvr4zzmG+aWb+lxxwuRO7SzYOOY11KQstaKZR2/akimeCuHbtTBb4B96b
         Omc7hO9Os6P6f6x4FsvacnjH29+A8k3tGHrcnn8yebe8Bduu69MGur18EQyuieiG7aLO
         okSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=67gq13570PCIFrF6WQtCzSbNx2SomruoSlQd4wdQr34=;
        fh=lWqkHR8irmViaRpFCCsWvEp9dQTnH0/OMAAqc4Adw08=;
        b=NF37KW7qamO14LKDbxhqonADFLn/UpWoBc3hnPJxg5/C8M9H2zfYiu8oVcwX6F/SWY
         gAvFvXyifFvzdbrxgc6oU4f1R6jigqcT8fyQKr02iOMd0rJqYKjigdmRCa5fEIIOtoVL
         qYqEikqn3BM93iit32a1Dk/GbAFUHePnlIQGJ97pImL0F3dcQhpNs+5wZlX7i4jZcEsx
         CJzYGLGvpnY84LlNPCB/CrUjQf4c2IFAk0Xn9ni5G3/9fp9QlCnoy0vq2OQi2NiSgpM/
         a/wDq0RFK+jmTqkY3TeZmMC8raB7McMjIclvDSLQu7HOyLklroWuQednUm9+vwEr5EK/
         0H2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190731; x=1790795531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67gq13570PCIFrF6WQtCzSbNx2SomruoSlQd4wdQr34=;
        b=VJnxv0+kFnphO+Uhi+NdXDw6ReicF2lB1vHNvuBkhosCNHa7OUVlw8N5PLvsmPbHec
         /5cTa/L8Rn3zWySEZrxPtt6un8pOeIpHd4qDXITI8v71ATQ5glV87oxD6vXXUGzN7+0P
         djPEv9FB+RHL1Q+VhaMk+BEQEDt8Zqg7ElUBsPKXbCBvoDKnkiuHP9TlKBwU0ak1B8Mh
         lgLhSCUx1neNnnXggExnxUeSBT/RaIJ4GEZu4VHQ9gLCdkL9aK+lc8hEuFuWD4l1ROQm
         JdgkcADIVHruGRyl5cjMD/kMdI+21zK0H4D3V9xab4FKBB4hbbxrBivl5OF8K47/4vCK
         bGQA==
X-Gm-Message-State: AFuF++kco1jtfzuix+MyGSHo5fVcAptTYEEpQxeTCHBTUBqNX8YhSLli
	57JGSQuu4gtj0kSse2JloLutltYeFyV3q/BmYpjyLSHT1JW8bd5u4fCr0eDdJAUm2zTbE7rkif8
	Tdq+9ZjvGn1uxZEkqri5lvbxsU9iB/LsMIqtukBs3fix8Sq8/suWgoe4gnQoJgZ8uqbHB15pElN
	2ekv4+h7M45tNz78BxIKcPznFlBBw=
X-Gm-Gg: AYBFou14egURtZFI9F+5mBngGubv8RwSBFtdFfCtOOgiTLJb3h/DhDnD6myklgvBFAD
	NkdU01xH4apqlSSpQmCVNV6EQn3T30abwbCX8l73UTAj+3HHKhVLoVV3mfhsw8PLv9zdxaDsZFC
	XcoRx2XRXiXi4R5b3A+B5gY2CfwJ23rNcVtNq3EvqS6ffJxg9DHT3jJvnuLCFLJ6YWp3+UCZkjj
	WMXcRyJMUA=
X-Received: by 2002:a05:6830:440b:b0:806:621a:e71 with SMTP id 46e09a7af769-8178317f8e4mr176872a34.31.1790190731006;
        Wed, 23 Sep 2026 12:12:11 -0700 (PDT)
X-Received: by 2002:a05:6830:440b:b0:806:621a:e71 with SMTP id
 46e09a7af769-8178317f8e4mr176802a34.31.1790190730221; Wed, 23 Sep 2026
 12:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
In-Reply-To: <20260731211601.3033906-6-zhipingz@meta.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 23 Sep 2026 12:11:57 -0700
X-Gm-Features: AcwNN1XTrrtoP-uYMjwQq4i-LnNmsVLCbE_Qgaj3Rldh2SiS4juG6ezOVv3ehw4
Message-ID: <CAH3zFs3W6kENoEhrPBXWyuzPvR5oC0mQnj0AtpgN-bhCzW6gkw@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ubhSi-sEXMpCsW_s7_GrDYhjNGVb49Yq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NiBTYWx0ZWRfXzwQgD+ruDipI
 zndABFDizMro9/5M3b+ja7JBRDVTSk9sfM8qM76A6j+/RktCy10eIacaYU1Ex3FfLAt3Ffg0brT
 Uo91cqfqF4Bg/4wH4SEAzs3sM3cS+COnpGSI50cAW+XFcbwuSfYSF58bD4EtniqSFmG9WOBHJ6z
 aCfWcTYNHOmn8M8wOT5Dp7SUTyNXAu8Jq5TvksqjiWEMXVxL8sOo0MPA8lKFMgm4t2xLp1yVaFy
 16Pk/yry9H/6EUYDxyxcdwsgIYGYUtPIBNFiVI8CYeKVX7NlGGP8Uk5UZSCsdpSmCQBojKlgiON
 fMAmTRbjSuu/UxB/5IOpVXWQ6VOUvfm8BZXoSx9vW2BWBEdjs9bTUe/lXl5Tk7q/Kkb8EgUx1B1
 g7uiSHzHDfOiZ8/cXEiX3/I1GIJIGKYFTJ5UdgkM4YEYwFaWsnGVtJbITYJfl4haWvMr86BR9Ey
 hczL3v8o7FpZXHK7vVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NiBTYWx0ZWRfXxrZg4mkMU3Ar
 rwmYURYu+Laitg468ixAHraPm3MTpZcraIAyvRQ7lT4P6DAgIZtSzIMuySc7aUqU05HgKEm6hPb
 hAFlNIT/YGul+4s5LxGFms8FTwsEzZo=
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ab424a6 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8 a=CbDCq_QkAAAA:8
 a=72TNloWXzYAqaRGebe8A:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-GUID: ubhSi-sEXMpCsW_s7_GrDYhjNGVb49Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01

Hi Jason, Leon,

Following up on patch 5, the RDMA/mlx5 consumer, this is the last
piece of the series still waiting on review:
https://lore.kernel.org/linux-pci/20260731211601.3033906-6-zhipingz@meta.co=
m/

Where the rest stands: Bjorn acked patches 1-2 (PCI/TPH), Christian
acked patch 3 (dma-buf), and Alex considers the vfio-pci side settled.
On merge logistics, Alex wrote that given the extent of the mlx5
changes he expects to provide a branch for you two once he takes the
series. Michael reviewed this patch in v11:
https://lore.kernel.org/linux-rdma/a97ff986-d625-44e1-90cf-027b079cb1d0@nvi=
dia.com/
I didn't carry his tag forward because patch 5 in v13 has a small
change: it keeps the !dev->st early-out in mlx5_st_alloc_index() ahead
of pcie_tph_get_cpu_st(), per Alex's v12 review.

I do owe a v14 -- a rebase onto 7.3 plus moving the feature number to
14, since upstream took 13 for VFIO_DEVICE_FEATURE_ZPCI_ERROR. Patch 5
itself is unchanged from v13, so a review now still applies. I'm happy
to post v14 first if you'd rather look at that. If the approach or the
placement is wrong, I'm glad to rework it.

Thanks,
Zhiping

On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> (typically a GPU or a vfio-pci passthrough device) traverses the host
> PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> Processing Hint (TPH) Steering Tag yields the best placement for the
> traffic it will sink: per-endpoint hint selection lets the root complex
> or switch direct DMA to a specific cache slice / NUMA node, cutting
> cross-socket snoop traffic and DRAM pressure under sustained p2p
> workloads.
>
> Until now the mlx5 importer had no way to learn the exporter's chosen
> ST tag, so dma-buf MRs were registered without TPH and ran with the
> default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> patch wires up mlx5_ib to query that metadata at MR registration time
> for p2p access and use it to program requester-side TPH on the outbound
> mkey. If the exporter has no metadata, fall back to the existing
> no-TPH path so behavior for non-TPH-aware exporters is unchanged.
>
> Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> steering tags into local ST entries when table mode is active, and add
> mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> index.
>
> Splitting mlx5_st_alloc_index() moves the !dev->st check into the new
> by-tag helper, so keep an equivalent early-out in mlx5_st_alloc_index()
> itself, ahead of the pcie_tph_get_cpu_st() call. A device without ST
> support therefore still returns -EOPNOTSUPP without an ACPI _DSM
> invocation, exactly as it did before the split. The check is repeated in
> mlx5_st_alloc_index_by_tag() because that is now an exported entry point
> in its own right.
>
> For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> creation and release it again when the MR is returned to the pool or
> the backing mkey is destroyed, while leaving the generic FRMR pool
> core unchanged.
>
> The exporter's steering tag is only valid for the mapping it was queried
> against (see dma_buf_get_pci_tph()). The mkey's TPH fields cannot be
> reprogrammed in place: they are create-time fields with no UMR update
> mask, and rebuilding the mkey would change the rkey/lkey, which must stay
> stable across invalidate/refault.
>
> Keep the registration-time TPH tuple in the MR and re-query the exporter
> after each dma-buf mapping is established under dmabuf->resv. If the
> tuple is unchanged, continue using the existing mkey. If the tuple change=
d
> or disappeared, unmap the pages and return -EFAULT rather than continue
> with a stale mkey hint; userspace must create a new MR to get a mkey
> programmed with the new tuple. For vfio-pci BAR dma-bufs this validation
> is expected to be a no-op because invalidation is revoke/quiesce of BAR
> access, not movement to a different backing placement, and the
> userspace-provided TPH tuple is not changed by the revoke/un-revoke path.
>
> Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> modular mlx5_ib builds link cleanly.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c             |   1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
>  drivers/infiniband/hw/mlx5/odp.c              |   7 +
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
>  include/linux/mlx5/driver.h                   |  15 ++
>  6 files changed, 223 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index 02809114fc79..a2b497f6b16b 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -60,6 +60,7 @@
>  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>  MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX s=
eries) IB driver");
>  MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS("DMA_BUF");
>
>  struct mlx5_ib_event_work {
>         struct work_struct      work;
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
> index 522984d958bb..c6a956b2ee87 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -646,6 +646,15 @@ enum mlx5_mkey_type {
>  /* Used for non-existent ph value */
>  #define MLX5_IB_NO_PH 0xff
>
> +struct dma_buf;
> +
> +struct mlx5_ib_dmabuf_tph {
> +       u16 steering_tag;
> +       u8 ph;
> +       bool extended;
> +       bool valid;
> +};
> +
>  struct mlx5_ib_mkey {
>         u32 key;
>         enum mlx5_mkey_type type;
> @@ -726,6 +735,7 @@ struct mlx5_ib_mr {
>                         u8 revoked :1;
>                         /* Indicates previous dmabuf page fault occurred =
*/
>                         u8 dmabuf_faulted:1;
> +                       struct mlx5_ib_dmabuf_tph dmabuf_tph;
>                         struct mlx5_ib_mkey null_mmkey;
>                 };
>         };
> @@ -1341,6 +1351,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *i=
b_mr, int flags, u64 start,
>                                     u64 length, u64 virt_addr, int access=
_flags,
>                                     struct ib_pd *pd, struct ib_udata *ud=
ata);
>  int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> +int mlx5_ib_validate_dmabuf_tph(struct mlx5_ib_mr *mr, struct dma_buf *d=
mabuf);
>  struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type=
,
>                                u32 max_num_sg);
>  struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index e6b74955d95d..404c5d081b8a 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -39,6 +39,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-resv.h>
> +#include <linux/pci-tph.h>
>  #include <rdma/frmr_pools.h>
>  #include <rdma/ib_umem_odp.h>
>  #include "dm.h"
> @@ -167,6 +168,61 @@ static int get_unchangeable_access_flags(struct mlx5=
_ib_dev *dev,
>  #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
>  #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
>
> +static u8 mlx5_ib_tph_key_ph(u8 ph)
> +{
> +       if (ph =3D=3D MLX5_IB_NO_PH || ph =3D=3D 0)
> +               ph ^=3D MLX5_IB_NO_PH;
> +
> +       return ph;
> +}
> +
> +static int mlx5_ib_get_st_handle_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
> +{
> +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +               return 0;
> +
> +       return mlx5_st_get_index(dev->mdev, st_index);
> +}
> +
> +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
> +{
> +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +               return;
> +
> +       mlx5_st_dealloc_index(dev->mdev, st_index);
> +}
> +
> +static void mlx5_ib_put_st_handle_ref(struct mlx5_ib_dev *dev,
> +                                     u64 kernel_vendor_key)
> +{
> +       u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MA=
SK,
> +                                kernel_vendor_key);
> +
> +       mlx5_ib_put_st_index_ref(dev, st_index);
> +}
> +
> +int mlx5_ib_validate_dmabuf_tph(struct mlx5_ib_mr *mr, struct dma_buf *d=
mabuf)
> +{
> +       struct mlx5_ib_dmabuf_tph *tph =3D &mr->dmabuf_tph;
> +       u16 steering_tag;
> +       u8 ph;
> +       int ret;
> +
> +       if (!tph->valid)
> +               return 0;
> +
> +       dma_resv_assert_held(dmabuf->resv);
> +
> +       ret =3D dma_buf_get_pci_tph(dmabuf, tph->extended, &steering_tag,=
 &ph);
> +       if (ret)
> +               return -EFAULT;
> +
> +       if (steering_tag !=3D tph->steering_tag || ph !=3D tph->ph)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static struct mlx5_ib_mr *
>  _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
>                       int access_flags, int access_mode,
> @@ -189,13 +245,10 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
>                         MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK :
>                         0;
>
> -       /* Normalize ph: swap 0 and MLX5_IB_NO_PH */
> -       if (ph =3D=3D MLX5_IB_NO_PH || ph =3D=3D 0)
> -               ph ^=3D MLX5_IB_NO_PH;
> -
>         mr->ibmr.frmr.key.kernel_vendor_key =3D
>                 FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_i=
ndex) |
> -               FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK, ph);
> +               FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK,
> +                          mlx5_ib_tph_key_ph(ph));
>         err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
>         if (err) {
>                 kfree(mr);
> @@ -218,7 +271,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
_dev *dev,
>                                       0 :
>                                       MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM=
_MASK,
>                 .num_dma_blocks =3D ndescs,
> -               .kernel_vendor_key =3D 0, /* no PH and no ST index */
> +               .kernel_vendor_key =3D
> +                       FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MA=
SK,
> +                                  MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X),
>         };
>         struct mlx5_ib_mr *mr;
>         int ret;
> @@ -557,6 +612,10 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *p=
d, struct ib_umem *umem,
>         mr->ibmr.pd =3D pd;
>         mr->access_flags =3D access_flags;
>         mr->page_shift =3D order_base_2(page_size);
> +       mr->ibmr.frmr.key.kernel_vendor_key =3D
> +               FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_i=
ndex) |
> +               FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK,
> +                          mlx5_ib_tph_key_ph(ph));
>
>         inlen =3D MLX5_ST_SZ_BYTES(create_mkey_in);
>         if (populate)
> @@ -753,6 +812,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
>                         st_index =3D mdmah->st_index;
>         }
>
> +       err =3D mlx5_ib_get_st_handle_ref(dev, st_index);
> +       if (err) {
> +               ib_umem_release(umem);
> +               return ERR_PTR(err);
> +       }
> +
>         xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
>         if (xlt_with_umr) {
>                 mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
> @@ -769,6 +834,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
>                 mutex_unlock(&dev->slow_path_mutex);
>         }
>         if (IS_ERR(mr)) {
> +               mlx5_ib_put_st_index_ref(dev, st_index);
>                 ib_umem_release(umem);
>                 return ERR_CAST(mr);
>         }
> @@ -903,6 +969,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
>         .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
>  };
>
> +static void get_pci_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_bu=
f *dmabuf,
> +                                 struct mlx5_ib_dmabuf_tph *tph,
> +                                 u16 *st_index, u8 *ph)
> +{
> +       u16 local_st_index;
> +       u16 steering_tag;
> +       u8 local_ph;
> +       bool extended;
> +       int ret;
> +
> +       switch (pcie_tph_enabled_req_type(dev->mdev->pdev)) {
> +       case PCI_TPH_REQ_TPH_ONLY:
> +               extended =3D false;
> +               break;
> +       case PCI_TPH_REQ_EXT_TPH:
> +               extended =3D true;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       /*
> +        * dma_buf_get_pci_tph() must run under dmabuf->resv, but drop th=
e lock
> +        * before mlx5_st_alloc_index_by_tag(): that allocates with GFP_K=
ERNEL,
> +        * which must not run under dmabuf->resv since reclaim can re-ent=
er the
> +        * same reservation object through a dynamic exporter's move_noti=
fy path.
> +        */
> +       dma_resv_lock(dmabuf->resv, NULL);
> +       ret =3D dma_buf_get_pci_tph(dmabuf, extended, &steering_tag, &loc=
al_ph);
> +       dma_resv_unlock(dmabuf->resv);
> +       if (ret) {
> +               if (ret !=3D -EOPNOTSUPP)
> +                       mlx5_ib_dbg(dev, "get_pci_tph failed (%d)\n", ret=
);
> +               return;
> +       }
> +
> +       ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag,
> +                                        &local_st_index);
> +       if (ret) {
> +               mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> +               return;
> +       }
> +
> +       *st_index =3D local_st_index;
> +       *ph =3D local_ph;
> +       tph->steering_tag =3D steering_tag;
> +       tph->ph =3D local_ph;
> +       tph->extended =3D extended;
> +       tph->valid =3D true;
> +}
> +
> +static void mlx5_ib_mr_put_st_handle_ref(struct mlx5_ib_mr *mr)
> +{
> +       mlx5_ib_put_st_handle_ref(mr_to_mdev(mr),
> +                                 mr->ibmr.frmr.key.kernel_vendor_key);
> +}
> +
>  static struct ib_mr *
>  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>                    u64 offset, u64 length, u64 virt_addr,
> @@ -913,6 +1036,7 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *=
dma_device,
>         struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
>         struct mlx5_ib_mr *mr =3D NULL;
>         struct ib_umem_dmabuf *umem_dmabuf;
> +       struct mlx5_ib_dmabuf_tph tph =3D {};
>         u16 st_index =3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX;
>         u8 ph =3D MLX5_IB_NO_PH;
>         int err;
> @@ -945,18 +1069,29 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
>                 ph =3D dmah->ph;
>                 if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
>                         st_index =3D mdmah->st_index;
> +
> +               err =3D mlx5_ib_get_st_handle_ref(dev, st_index);
> +               if (err) {
> +                       ib_umem_release(&umem_dmabuf->umem);
> +                       return ERR_PTR(err);
> +               }
> +       } else {
> +               get_pci_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> +                                     &tph, &st_index, &ph);
>         }
>
>         mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
>                                 access_flags, access_mode,
>                                 st_index, ph);
>         if (IS_ERR(mr)) {
> +               mlx5_ib_put_st_index_ref(dev, st_index);
>                 ib_umem_release(&umem_dmabuf->umem);
>                 return ERR_CAST(mr);
>         }
>
>         mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
>
> +       mr->dmabuf_tph =3D tph;
>         atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
>         umem_dmabuf->private =3D mr;
>         if (!pinned_mode) {
> @@ -1405,6 +1540,7 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
>         if (mr->ibmr.frmr.pool) {
>                 if (!mlx5_umr_revoke_mr_with_lock(mr)) {
>                         ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
> +                       mlx5_ib_mr_put_st_handle_ref(mr);
>                         return 0;
>                 }
>         }
> @@ -1432,6 +1568,9 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
>         if (mr->ibmr.frmr.pool && !ret)
>                 ib_frmr_pool_drop(&mr->ibmr);
>
> +       if (!ret)
> +               mlx5_ib_mr_put_st_handle_ref(mr);
> +
>         return ret;
>  }
>
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
> index 1badec9bf527..7c1731aa3dd9 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -857,6 +857,13 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr=
, size_t bcnt,
>                 return err;
>         }
>
> +       err =3D mlx5_ib_validate_dmabuf_tph(mr, umem_dmabuf->attach->dmab=
uf);
> +       if (err) {
> +               ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +               dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +               return err;
> +       }
> +
>         page_size =3D mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf, access=
_mode);
>         if (!page_size) {
>                 ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
> index 7cedc348790d..c62bcae7c542 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
>         kfree(st);
>  }
>
> -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
> -                       unsigned int cpu_uid, u16 *st_index)
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +                              u16 *st_index)
>  {
>         struct mlx5_st_idx_data *idx_data;
>         struct mlx5_st *st =3D dev->st;
>         unsigned long index;
>         u32 xa_id;
> -       u16 tag;
> -       int ret;
> +       int ret =3D 0;
>
>         if (!st)
>                 return -EOPNOTSUPP;
>
> -       ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> -       if (ret)
> -               return ret;
> -
>         if (st->direct_mode) {
>                 *st_index =3D tag;
>                 return 0;
> @@ -152,8 +147,49 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
>         mutex_unlock(&st->lock);
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> +
> +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
> +                       unsigned int cpu_uid, u16 *st_index)
> +{
> +       u16 tag;
> +       int ret;
> +
> +       if (!dev->st)
> +               return -EOPNOTSUPP;
> +
> +       ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> +       if (ret)
> +               return ret;
> +
> +       return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> +}
>  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
>
> +int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index)
> +{
> +       struct mlx5_st_idx_data *idx_data;
> +       struct mlx5_st *st =3D dev->st;
> +       int ret =3D 0;
> +
> +       if (!st)
> +               return -EOPNOTSUPP;
> +
> +       if (st->direct_mode)
> +               return 0;
> +
> +       mutex_lock(&st->lock);
> +       idx_data =3D xa_load(&st->idx_xa, st_index);
> +       if (WARN_ON_ONCE(!idx_data))
> +               ret =3D -EINVAL;
> +       else
> +               refcount_inc(&idx_data->usecount);
> +       mutex_unlock(&st->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(mlx5_st_get_index);
> +
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>  {
>         struct mlx5_st_idx_data *idx_data;
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index b1871c0821d0..d26e5744c843 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1182,16 +1182,31 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
>                            u64 length, u16 uid, phys_addr_t addr, u32 obj=
_id);
>
>  #ifdef CONFIG_PCIE_TPH
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +                              u16 *st_index);
> +int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index);
>  int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
>                         unsigned int cpu_uid, u16 *st_index);
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
>  #else
> +static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
> +                                            u16 tag, u16 *st_index)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_in=
dex)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
>                                       enum tph_mem_type mem_type,
>                                       unsigned int cpu_uid, u16 *st_index=
)
>  {
>         return -EOPNOTSUPP;
>  }
> +
>  static inline int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 s=
t_index)
>  {
>         return -EOPNOTSUPP;
> --
> 2.53.0-Meta
>
