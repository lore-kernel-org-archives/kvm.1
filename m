Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC41313E07
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773205; cv=fail; b=TIRhHaN4/Pbf6HuDCz5IuXPZiWu0Tw4ZztuRrvC5iFy6zg9cwPp1eT5FKHNBwnrT/H4S77AyRxlsraZpLTVf7HyJHOsvlYc2QlVy7HlovD9CCLFdERM4BfNZN++EZ6W/p/4rc9DlSO5REEUWj2eOjVg9Hj3XoNc691WWmeT1CzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773205; c=relaxed/simple;
	bh=LAAsXswdYRhoMmUQBXGAxhkMFD79zG1d6WTOgeAPZ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjZYME1d0eDApH38R38tX7VXYlBudAXrVkw/VI2kATDxDXbfCEC790UWafNcOdIJ/MsIjJLs57kW9yanLhwTNUvGHSm5PZyoo+PEKVUq+q9XlyeyQJHDzbMFt4I/wJmNBk3yaHYbC8CniBoXv0XOOGBzIiR9QLuBuap0HNngnJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D6Y+Suqj; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D6Y+Suqj"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKgsVb2903258
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wLX+q6aZUGU2+tNflRbeS5hmHMHpHmOV5uipQIZIRjc=; b=D6Y+SuqjEQrM
	f2QeVXHoqMHxZexgeghszFXVrZw4LS2kXjWpFfTX8mYzWTSEZtH/ttBdVAMkyWdy
	t22Kq702OWpcjEU/kF74grLjnJ54kbNPw0ntlbzzWsw9KEK4RR3CgBqUj3aHbeET
	ijCi6YifPqpFYhAvAOCkBJNfzC61asm2Ur9WnbU9jxmtIccXlhxFn7djlehRcrRk
	CI4mOnrSJnRZys+tAPctwAstQLwZ/r0gp8f8Cpuv+y14HBevZ8rrU6ANkQzUAHDJ
	nM51q117Utf29kv/dShBoc87MTcZ26F0vt+BK+TCjbX+Yw7l2sLH0bG+JlOh+Qz+
	pPe0+S/ERg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f2c1bq96e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b5976d74so6169727a34.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 15:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782773202; cv=none;
        d=google.com; s=arc-20260327;
        b=W5c8+5L5POqr0Utz1LnHHHX09nnCAJDjuIs0UAS7rpLdq28oK0nuiAVrTYWL98X5s5
         fRVpSIjW/RbnwJvBxfo/rF/LoOL59EbT/GA4a4L2BSQ9EQw+0thCW+JqceWh1ie5t558
         +/4RrKGT3Mg6EfKyTwrcpU+HKgMt2vjDHh/ANJ3w0ROc+s6ipp469aIhJcldUIhwv+FZ
         6ChP0vW/mqITi8oKZLkqalPTOCV6+XhMgEFq0bnHdLdDyxojVcY4whsEh/9i4cWK7j2E
         r00H313QW9A6fPQ1J1ItkyG8U/c0y47bx8hyfFGi6mmehxMZirMyI3Ix4pOvHWyOCXyn
         LYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        fh=vyyTswUpLWm0KAYcS7goAxTsTTngQaWjMHSRI2C+tP0=;
        b=F9Wdiqm2Ey4HuPIE2Ha1sPYhby7+3kdnUmyccRGSb7qhJcJCRtphqIZ89CCoGrl7sl
         Dc+cEnYICxSCzR264HhtfrEKYmVRUJnnfvo/HtRr9d3BFtBxkBoqfpc4g2HsEi3GSyjp
         Bypexs5AMjdxO8Lju8thB0klpQG0sBgXgBPRudMEtr0tHuFUq5bj9wm1/vw9hYeqk+mg
         F620wt8jQUMKPp3414y85aSBAdKQ/QLPlS7bay5nCMqo+7oDSsKELjsdELVkDGnu8aj/
         9HHAJtGQjjO9KVmoKizejIuhtqe8HNeSbggYHLWjLR64Q3KqtdhQ2BDCdDICTW5YIJvt
         ZmyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782773202; x=1783378002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        b=nr8Wjx4Hviv10rAAmE8Gu3uD/SCrLu4vIO4KxT5013TBJioqsQLQsy3xO1TnMVIjaU
         mQU8s7xlKEiVBkUkd9GCj7x7psETVQA8Wh2AqKh8eCO6AwZYtekTpl7tfJybRcf2zDIK
         Pr3mSOmf7r4tl6mzPXPSi2uw5mTu6K5M0i4EDoap8h5AHdvnTDgLO/LgEc7Mr0i6xdc0
         d6ec3PgDNNNEQa7S9fn0ryI4uqfknHYGImtIGU2hjkyFCo0fA/mr9bfU90lWGsCIZJSy
         ZWgXt6SyiI+M2G8986B7DMnETlizJ6o8geGxaJoM441BbaGldkEmr6MVFn/m9x21mtda
         iJyw==
X-Forwarded-Encrypted: i=1; AFNElJ/SeigSRDRmXUWANYcM3W8qdkLt+26VKY01YwhlWYuM9RKW/dChlvEQC6DQsP+NTOlGrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTVGJ6+AVWaeTSYiS7RwqZ2BO4qurVMi2S17p9a7vsqX9ITuW
	J/PB3cEcvTjJ5kFviMIVdESk7KEZO/mJ4drrz3IK1qUk2jbWk+4P2tSc6cKfkTprd994jDiPJlq
	PC/FM0QwtCvVp6Z7zOn4luS0Tx8ZAD0NZPtWQuM50qNpupRX1wUODqoqRP8NigpY9FCGsVQndMm
	dRhNfHbOoB7t8KsSD80thfJEAHJFY=
X-Gm-Gg: AfdE7cmWdQO67pnXMZWZNpDM6bL/Njlag8GLvu33u3rrDbA7WWTywq5mdcu6bxROaQR
	CjpOBeRBAvRcd0ana3lR6/FisbdamyPbqkJ1VBpzgWSiSd7ULkPZpEvV9p7xnTF3kaTlO1SDUi7
	hfefmEETnoIHhOlGgyggE6kGa7eSwgVxZHn5q9DB5FOnetpIm/7NEfmnr9fxbab9nOw07EeUkbw
	5I8Wefk
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7e9ec7c6eaemr1372415a34.31.1782773202407;
        Mon, 29 Jun 2026 15:46:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id
 46e09a7af769-7e9ec7c6eaemr1372389a34.31.1782773201883; Mon, 29 Jun 2026
 15:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com> <20260622184211.2229399-5-zhipingz@meta.com>
 <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
In-Reply-To: <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 29 Jun 2026 15:46:31 -0700
X-Gm-Features: AVVi8CfM8-1FZc35vpJ8kCojEp6xp5zFP0DjBW3kt6zGgKV_ax4f1nQ8Em8QwAQ
Message-ID: <CAH3zFs2LbjPCn9B2iCvFyW5yKoAirkZqdhwxmZh+U65wH9uy=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: TcI5OtTNl_RwWNW6jkZnQ3B7Omc9UNNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE5NCBTYWx0ZWRfX0lFTwBJUniw5
 kDFFL7F6FmXgIeeIS2wB0/CwXvC9IoHO8jjgyD1ph/zm74+nSNrA7m7cogA7xsewvqQIK9zJLk3
 OVsShi58hRqhMsTHWlzYXnI1lyeFwJHqTiUcKVsF+TL3C+tMbZu+EHK7nWMMssp7SHW92cnw7Kq
 gPI55DAOEnycmusLDfzQmGz6bpCf0E/4b31qERf9/I2XcY4zEtKfRo7L1tQhdp+fwWJjQUA5LMA
 DVQ8Mnn7mPh6XMkyLlXmsiiehmarKfGN9c9aQZqFLyedNXb9qYYJhXZtpzp/iKEyW+gRiIR1hgo
 kCngHZyt505gUWb/oO1dTO6MTzen5tLZlKsbCutbb2+aZdxnR7WKGQKYYOXeIeklGtSC3gT+vxb
 VDVKr47q54x0mIcBacbS6ujzBzg1K9LomnvS2MjDQ0I6lHuYE9rF420d69lcva8ZSv+p0s7DhfV
 MR+7AWJcj9nC//42y5Q==
X-Proofpoint-GUID: TcI5OtTNl_RwWNW6jkZnQ3B7Omc9UNNd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE5NCBTYWx0ZWRfX8p5Fhh7z1JpK
 LayiEyTw7oXlL7/nEF0nZ1yZfb5iWupxfxQV9WnBUjde4au8flkK3Hf1xtDKhtNQS8BwPclAFql
 a5ukYl4MghJvytOJ6GBiggBSSNQ6UDI=
X-Authority-Analysis: v=2.4 cv=NPjlPU6g c=1 sm=1 tr=0 ts=6a42f5d3 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8 a=l0kR5rhSyQLp93Ybf_gA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01

On Mon, Jun 29, 2026 at 12:11=E2=80=AFAM Michael Gur <michaelgur@nvidia.com=
> wrote:
>
> >
>
> On 6/22/2026 9:41 PM, Zhiping Zhang wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool
> > core unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c             |   1 +
> >   drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
> >   include/linux/mlx5/driver.h                   |  13 ++
> >   4 files changed, 157 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 02809114fc79..a2b497f6b16b 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -60,6 +60,7 @@
> >   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (Connect=
X series) IB driver");
> >   MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_IMPORT_NS("DMA_BUF");
> >
> >   struct mlx5_ib_event_work {
> >          struct work_struct      work;
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index e6b74955d95d..7aced3f55456 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct ml=
x5_ib_dev *dev,
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
> >
> > +static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                         u16 st_index)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return 0;
> > +
> > +       return mlx5_st_get_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_i=
ndex)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return;
> > +
> > +       mlx5_st_dealloc_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                          u64 kernel_vendor_key)
> > +{
> > +       u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_=
MASK,
> > +                                kernel_vendor_key);
> > +
> > +       mlx5_ib_put_st_index_ref(dev, st_index);
> > +}
> > +
>
> Please remove the _frmr_ from the functions naming.
> This is now unrelated to the frmr and is strictly tight to MRs.
>

Agreed. Will rename for v10:
    mlx5_ib_get_frmr_st_handle_ref() -> mlx5_ib_get_st_handle_ref()
    mlx5_ib_put_frmr_st_handle_ref() -> mlx5_ib_put_st_handle_ref()

> ....
>
> > @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *d=
evice,
> >                  get_unchangeable_access_flags(dev, in->access_flags);
> >          out->vendor_key =3D in->vendor_key;
> >          out->num_dma_blocks =3D in->num_dma_blocks;
> > +       out->kernel_vendor_key =3D in->kernel_vendor_key;
>
> This path is used to translate an frmr key passed from user-space to the
> right values, enforced and masked by the drivers.
> kernel_vendor_key is not allowed in this path as user-space is not
> allowed to control those.
> Please drop this line.
>
> Thanks,
> Michael
>

Good catch, will drop.

Thanks,
Zhiping
