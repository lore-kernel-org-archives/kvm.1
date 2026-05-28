Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8430C359
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948458; cv=fail; b=RQKfJ+S+aRvGLwzqfSuJ/E0lNxvMsI+Lr0n9amoKXygTLPhjMS2RPnFlquBPw9YDXgnnWjX5ueqsTAeSjL9Ui5Azcxl62Zua+3NAtliu1aTrLjYTjtMdRDvv2WCMymzFcF+w4MLExeaymFgDddhVUUDCN9qT4Hykt8xhZCn+v8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948458; c=relaxed/simple;
	bh=HybfouVWXzRjvqZuKWAwoAOqax6hVl/L0qzWeXk42y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ5T7fuf4EvIAwxLhL7dKx4+gY10cg9sq41kAnBNZG4bOhGKjIZ6rO4ExhA/x89xP6X8OeRGFArSleGZXHtoDJ96c0VYYEqRAsc8X+lsGa3aIJqeThiYGg/MZbFnM93sdKicLvMKWsM5k7h30yIotlRdZgvmsIK3cdf5bM9OwE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZOFqU3Ho; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZOFqU3Ho"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKlqmw3164863
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GzyvN6ALmGZhc9sEe0zXVntaZeAULheQgTQ/UjOlmfA=; b=ZOFqU3Hokw+Y
	1tWm8OSAw3VppcsXhCy7NjQiED7GF+zwJ1AY0cTIbpcpdYBGC9llvuLJbd1+8rlL
	AXglm2b6A1JTOk8fAn271XgFKVQJNxo2oeVdhw6YawXARksZ4FY4tBG2ugql/lrl
	OpiEUZkdO9HHKOHR42fEty/p77Y0/ml5/z5VbIqwt1zZ3po1sXwT9rtBHbQ0Yd0z
	OPfICWCY2j6tJ46Bv6NfLAq1xI7tfkCqinN5m/CdB/cWEoFzjnUgH0lExTWRP6QW
	U1M02kqSfyicM6TQnFCDh+VID+oYzzysKR/LHRJ/8h9AQoXwa+/h4ymbOE6Zwdfz
	Cn+zoh4Arg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7y42f5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcd7302f00so1976938a34.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948455; cv=none;
        d=google.com; s=arc-20240605;
        b=b77n2pJFDgS2RCD/58IgsE1e4xN+099ucx3WkmEnhcCRiEPo516nGn/IyLxd1uSjfi
         z2HVbmVfSp9tWau9zPKb5broMMPgs5G2dz+ZVveWep86a/Z4aB5MTHX4S0vK+XI0rAvX
         V8edi42w0bRa6+LLWEa5UVzEY4Kukcu8DXIUKxcvE5O05ZSHTeFPqVOTzcFCITV4vlLq
         Wai6xbZbOJ8pbjgNblloW2tody923km2q3D3XGuOQf0hmxJUyryG9DIDBPFcJlxriV74
         3xcRmqkI4iCwZdLD/Wcy0RnhgUtbbP0nINWC51QVNHPKbt5MMNcbhz6pBtygtWRTrJ5v
         rkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
        fh=aLOWNdlIX2i3vgiCN/JR7MP+GsF2xN3RDOiaRuFdMW8=;
        b=lZ6LagD/eOnt0sn2sUJn5wVnobXNeeWchCNp2codVn69TdXazoMQxUcs9I6r6vNjzG
         6FMdjex92sOxZ3915UJg4e38X2LzK9x6SXT5hT6HrQAYd9Nc0QdwsRalXlS6kQrKIr+C
         eChfbdTFPOUnEBGev1ZrkgRu7n7vPkJGx1iU+bv/WeHS8qn3nVhP9eDOSyU4KXVWPiMe
         PkEQLFyI7W9/XrPByhlE34PUE9Njwi7KIaiLTtZ/03NmFPisAe8W9dgvzZ5TEjQtkgI5
         wFOHWewuP07FExtL0Xaj7ffMPOJ3xMpEGnLfQkjzfQCRrvBu0UIkUHoYRIyglb9hLkSG
         KT3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779948455; x=1780553255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
        b=UDGDleDiFE2zfRzIgt74lYwsX0MuJBG+rZm1wz3IVSH1CvEdHBmmpEB0ulSB07uu1V
         kqXORRdpahaNDJT6uJhlGNP16DH0R36QUtVX4AlPNbjD2ZptFBsNceMwsWSuAB1jXqTw
         I28ciHFg9KU1gifKcYC1Gox+cyQ4S9wubSA4t3Cp0cBtHQq9Wcmn9Lwj0CPpXNgEnVE4
         gYRaVVKv5Tr1UWsqPvoP8CVIuswfmXNdF2CE887Q6nm8yrooIVY7l7a6xxi0Dp5XmPkJ
         4H4iYgsTSmSmdL1hIWNGj/bjgFZBRF8DZR+K79GVXS+YhcP48uUYQgCrUoGYxmdZyD4B
         8r4g==
X-Forwarded-Encrypted: i=1; AFNElJ8bTnv7wbxXwLfnWCwxDrNVg8Zqb42ZKI0/oqvRLRmC13XK59lYDlDc+ZNsAWT5GlZOkDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgKN5ekY16k5hK9YmohiJ2lduAcsQ3GWBrV0HD609u/S5MJVi
	2eNobCfQNGZfjs/nLo4bvMPBmsZGO+/tVY55rCiU1fkhHSuzoqoTX3CfA9wOMiK/FmhorPx8/Ay
	Vh4QTaNAfj+ngorWVmWUe2ZADmXoqyKYARx9/5Xu0eqxqT2vOsAqqWJeAVT/sR77yLRJV3BenZX
	jxQNbxZ9Yrakm1nrf5RvyRDa55XtM=
X-Gm-Gg: Acq92OHu2Edn5fegK1VcxLV3jyDinZq6TIuUKijsI7M/atkJFU8m5+n8wEyrVQRbG8L
	BpCoHUL/6b3ri+AqOO+oWJU35a4ts8FvS66nA/cmyH8hZifs4CVuHfsMco0z4yqTIciXbBekj5s
	4DyQMeP8ey+T28X0pjqbT/8trxdD51+fFV8nDECTbvJPiQDZNDaZoPicEnrQzYfQktP54JRRLLW
	rcknrjqR4YNiEZ04WNoxq7IIvJkTV8BKtMdEvxskoU1TEPypL0=
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id 46e09a7af769-7e5fed4d4c7mr17428832a34.11.1779948454554;
        Wed, 27 May 2026 23:07:34 -0700 (PDT)
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e5fed4d4c7mr17428818a34.11.1779948454085; Wed, 27 May 2026
 23:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-5-zhipingz@meta.com>
 <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
In-Reply-To: <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 23:07:23 -0700
X-Gm-Features: AVHnY4K3avPQ8FNE3xy07LlbZrchvRUwd-Dc4i84TnsR6M8GdnFKvihXHQqWEMo
Message-ID: <CAH3zFs27rY5E5q1ybjYf0jjMc_t7NCs6T1dt=1P4io9MOrK5nQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: UNhtu0GhFg9HaUR6YpR9FNN6KJqyqOFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1OCBTYWx0ZWRfX9Cp0GOrwJ61L
 qBQgmZkBLu2a0kLRvhTlv60ZYg3ny4O8d4nsKJJ8OEb78LJBmvBANUu+ihBMv77NOIYhWeDNxVP
 A4q+SfTLA7vrMbYCx0g3pgLiqnFcHPm1FpEzq+BdcCDz2FA+6E5bPh1ifmwpftRcDPOW+P5fcXw
 0wAGxQFki0oLlFQ1WloBW29oRCVrxzxXETNt3gbGAVe3WWEZSqDbLgv4W+BLOgFRGzRf+oTo7rW
 BlU6DIsa9t6Xq0HMu+69IvwWYM2eedUWWR8lenjotbPik4jDZIJjSxve698CXNpkSfJN/NqF+vf
 gWCDWaEVw8uDzfM7s8WUSYCjNAkrHC5aN8sPRH7ZUE7Qt+h2IHRjHafSBLN2Lk3Z9r79v/1+nEG
 tq0r4ZmHzFuOg9FgwKdy0cg4g8TY0JHxka5Yin4YfRvSlz5nfSno/81lx5yz7MViW3ndeY8myH0
 jGwShzlE5FZu9L7ArKg==
X-Authority-Analysis: v=2.4 cv=Xci5Co55 c=1 sm=1 tr=0 ts=6a17dba7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=rnG5qNUxfvSO4QYeIecA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: UNhtu0GhFg9HaUR6YpR9FNN6KJqyqOFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 3:55=E2=80=AFPM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 5/26/2026 5:43 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access and translate the returned steering tag into an mlx5 ST
> > index. Keep the DMAH path as the first priority and only fall back to
> > DMA-buf metadata when no DMAH is supplied.
> >
> > Track per-MR ownership of the allocated ST index and release it on MR
> > setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> > the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> > its refcount reaches zero so repeated allocation/deallocation does not
> > leak memory.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >   drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >   include/linux/mlx5/driver.h                   |  7 ++
> >   4 files changed, 115 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/=
hw/mlx5/mlx5_ib.h
> > index e156dc4d7529..4ab867392267 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
> >                       u8 revoked :1;
> >                       /* Indicates previous dmabuf page fault occurred =
*/
> >                       u8 dmabuf_faulted:1;
> > +                     /* Set when the MR owns dmabuf_st_index and must
> > +                      * release it via mlx5_st_dealloc_index() once the
> > +                      * firmware mkey is no longer referencing it.
> > +                      */
> mkey st value is kept after revoke, regardless of st alloc and dealloc.
> mkeys are kept in FRMR pool for future reuse even if their st index is
> currently stale.

Understood, i'll work the comment accordingly.

> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> st_index can be read from the frmr pool key. No need to store again.
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -46,6 +47,8 @@
> >   #include "data_direct.h"
> >   #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >   static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >   {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >   };
> >
> > +/*
> > + * Query TPH metadata from @dmabuf and translate the raw steering tag =
into
> > + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> > + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> > + * once the firmware mkey no longer references it). On any failure
> > + * *@st_index and *@ph are left as the no-TPH defaults set by the call=
er.
> > + *
> > + * @dmabuf must already be referenced by the caller (e.g. via the umem=
's
> > + * attachment) so we don't re-resolve the user's fd here and avoid a
> > + * dup2() TOCTOU between umem creation and TPH lookup.
> > + */
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf =
*dmabuf,
> > +                           u16 *st_index, u8 *ph)
> > +{
> > +     u8 req_type;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return;
> > +
> > +     req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
> > +     switch (req_type) {
> > +     case PCI_TPH_REQ_TPH_ONLY:
> > +             st_width =3D 8;
> > +             break;
> > +     case PCI_TPH_REQ_EXT_TPH:
> > +             st_width =3D 16;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> > +     if (ret) {
> > +             mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             return;
> > +     }
> > +
> > +     ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_in=
dex);
> > +     if (ret) {
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> > +     }
> > +}
> > +
> > +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> > +{
> > +     if (mr->umem && mr->dmabuf_st_owned) {
> > +             mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> > +                                   mr->dmabuf_st_index);
> > +             mr->dmabuf_st_owned =3D 0;
> > +     }
> > +}
> > +
> >   static struct ib_mr *
> >   reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
> >                  u64 offset, u64 length, u64 virt_addr,
> > @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct devi=
ce *dma_device,
> >               ph =3D dmah->ph;
> >               if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
> >                       st_index =3D mdmah->st_index;
> > +     } else {
> > +             get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> > +                               &st_index, &ph);
> >       }
> >
> >       mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> >                               access_flags, access_mode,
> >                               st_index, ph);
> >       if (IS_ERR(mr)) {
> > +             if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_=
TAG_INDEX)
> > +                     mlx5_st_dealloc_index(dev->mdev, st_index);
> >               ib_umem_release(&umem_dmabuf->umem);
> >               return ERR_CAST(mr);
> >       }
> >
> > +     if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X) {
> > +             mr->dmabuf_st_index =3D st_index;
> > +             mr->dmabuf_st_owned =3D 1;
> > +     }
> > +
> >       mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> >
> >       atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
> > @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5=
_ib_mr *mr)
> >       bool is_odp =3D is_odp_mr(mr);
> >       int ret;
> >
> > -     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> > -         !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > -             return 0;
> > +     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> > +             /*
> > +              * The mkey has been revoked: firmware no longer referenc=
es
> > +              * dmabuf_st_index, so release it before this mr can re-e=
nter
> > +              * the FRMR cache for reuse by another registration.
> > +              */
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> > +
> > +             if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > +                     return 0;
> > +     }
>
> The Sashiko comment on previous version of this series was wrong about
> the concept of FRMR pools and its reuse of mkeys.
>
> Please move the st put operation outside the mkey cleanup flow.
>

will do.

Thanks,
Zhiping
