Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAF29CE1
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498253; cv=fail; b=fAdgu20PfKykLeHV0n/K4ti3fk/XTy/MbZP/BtFradXpcSTiHgO7jm3Ub5Dg5WvX09dBKts+qo8w7GOYEYs9BWHWWFOdcbdU70iscEl6ZaCqORV8fZqj1kP147emgcTrtxmmVCkCDKNEGbJHIpNlibofCjQBUX2R6kgk1SO+oIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498253; c=relaxed/simple;
	bh=/A4hX39HcRR7SH4Q02RYznjGYalKTiQUMXi+zCxotsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmz9YtFZxSELKc7WgLt8sgNMWdrwxaRfvBUvGJclEScdhYp1vC/4MvwFp8pW6jLveKhSWTmtabQr+4x/J5nvkhvbSP4rh2G7rTJUZKacj9ghL5dV8lm25HeLVzviC2VsGx5WEjpnDhePLeQJfxw/Q1Md66fwJTHS5PriGbPxS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fT1NcaLS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fT1NcaLS"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64N0kCPi3072146
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZSYPnXqPgD1WmWUsBlypXTMK46Ru/H45VtdzBiXsUQo=; b=fT1NcaLS0als
	V0CzITn5MusJzO7wCLcepvtcBFTpq0bJwdQSvOVtuXxphbNRdr5w4GkHaTzTSf3+
	1R03uZUVNbYR09SXtNfze33jf0vl16nQtWNHx7IejIEpQwTNM6Zdr4URIJIP4IUZ
	/MxPR0PRQGLKj5okI7T8m28gwIvEkhfg4k5DlHcYM4LKRk6uMqHrbOKc8yy5HHtZ
	5eqDNEm/6fylQhFYaVIcSOMFDFs1Klh81XfuQ3MBoRuhLL4csUmWciCvrsH6JK3j
	sIxVPa7SHf06LM2veBJyy78S1WcvHjVGrhiGukFXNTCVAfsoQEefzYCSC/aL5enj
	hOGP41Rqtg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ea6t798se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4856a701421so214421b6e.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498249; cv=none;
        d=google.com; s=arc-20240605;
        b=lL5LpYHLzpcdpnt1CxjufJXPvX3iiyo8Htq6CGhmHVu/y7aLXkitvxBMaeIjAhb8UN
         kw53pIN6ummbAKfolExKT5AotICRT86DOQkLBDFJkxnKDNQ6paiT5uiRWxYKAxX9FQup
         Gb5X8G97qFP4QgaIa0yc2bg0wLS+8Gc6Liwbwa1no8twrNf+3P4/HNUj5fOl+7JwlsOo
         8iMsNXR1UlSk729P7qlU64IY+++iwFDSCsZKI18V24X0/Z+9X310UXYKH1wNdw/Fmq8n
         TI7MvWYFd0VrNW0JiSgCK/wf1gjxr+aUy1YaLBiAZmbYzbRVT5XnCd91aZfM33IS03Gi
         CKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        fh=d+lcEwp4GNgo96AwVlTd3bXueI37DDDjpAjsD7X7m/k=;
        b=KjGkVH6kfU1djeA6aLm4LY/8f7vwEO6vSXLIivdJSpFenQdj7rBiGwDLKgNzHV3N/g
         4LbWWlMmYKkRCJFJy5XJzrV8l6UpRLg7W/XVtsQJCjPQcHyilTxAKtaWJCLs+Jvq4ImY
         8l5Kl/5ebLWP5rZWX+ax+frpVPvIRxaDZ0FjiC0TdY/FqQNQ6bP3U09FZhrKx3TPfg35
         VVQvw1fscSOaxjOZtEI7Gs3ptrZARQecs6ZB27Z758vBb04cDw5sie/5QlpRjS+Tl7mx
         icl+N9/JJ1Xg3LMmeBAy/9TP51BeLAl4tJKbFkKDj0SSPZj9ngVFrc2F94d91orZaStK
         KqDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779498249; x=1780103049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        b=W1o6erKRXKufSKDx2igITJIqwLqsyR6jJvUO3h0WQ0YqO690MXsQk5Wlkdsb0la9tL
         qLm0bksKhh9JJqSksQ3HA7Q2/CmeJxOkHVwc77dPSGSRlh6Cq1ddMdkh1bCwhl7Ed54b
         VjNyusbPCHHJStwYDOkhL7rapkQNBI6QLYM06PzcFbEvERiRTajbMvcDU+welTFP9Is8
         N6Fd9IVVnZshNmIk4KFeGPndq70nrZe64REHaAh/5h+5j2SFTbIpy9wGjcH5mAzLoqAD
         G9kvT59K6XrJAeDtvQxz+4v7uInqNkPAg2qIxSdZ9c8WbtyeWR5yZVdoRVo6wJcubhtn
         UKvg==
X-Forwarded-Encrypted: i=1; AFNElJ9XobScGJotibgVBEmRwl7Z509cYZVxWlOXAsqK2ILPwX13bscvCQSUuMm2tus4aZ3CRPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/10SQDAvZuScpArTWOPb4LkIXrrJhuw9SN1p29X1Kq/m0s3zr
	X/bv3Vot8T3N+6mc6l1S74UBIe1W6Z+ERmfak+pY9wx8eJoZYf89itcM5QK/uU2av7p7gkFY14e
	h7DYDXE1SFv1tQnOB2D9FQncXdmFPGAWh0DuJQs+iM+JfwcU+s/UrHx4GI4HPMMRQ0DIPfToFX0
	QnqenlPJALDQ5TJYASenkH85ZlInA=
X-Gm-Gg: Acq92OGEj9sTYd/6alheJRq4LFN1g4JRkO4GD+WVRn6tZFJDHUJu4pW2Th2VURpI6QG
	iG5sBxdtVqWmRxHPNijDuRP9BWqY+TMKs0I4IXgSd/fh8ZBjrpQHNKbwRnKiG51B5x9bCVz0HAH
	yxC3t1f3TBgi4aSa3RV1RJ2GbLZtzaR4ttmxsZMg9emTqijP9OsUA6KVsxIDXEqS2WN4y0R1mji
	z4+
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id 5614622812f47-48549902f22mr3459526b6e.0.1779498249496;
        Fri, 22 May 2026 18:04:09 -0700 (PDT)
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459507b6e.0.1779498248992; Fri, 22 May 2026
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com> <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org> <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521162437.406085db@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 18:03:57 -0700
X-Gm-Features: AVHnY4InmgAbt-a7ZIoyl3OFAhk-P34lQOEjx6K7zj7MuEim3oYM-YaMDsRZ4E8
Message-ID: <CAH3zFs1gh6UZewMf9GJ6CtO5v0yWNokp-eZQ8G2QnyAyxD7-wQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hIFJbU4WS6cRrhexCQJOUC2fUU3BiNZ0
X-Authority-Analysis: v=2.4 cv=fL0JG5ae c=1 sm=1 tr=0 ts=6a10fd0a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=LZULGAC3ikq4sroI4wUA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: hIFJbU4WS6cRrhexCQJOUC2fUU3BiNZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAwNyBTYWx0ZWRfX8mu452NHJtig
 6sx3SfeKq3ytmPf0KoQ6l4YRDRM9MgTNjM0Fcq+uFmNB1UBQBuRRAuM/0oV51eohnkJnasJpggG
 ZHvA7+TK7FJ3pUKLbI99ZJ0hlv8Icrm9uIS4s2BweYYNvczIivpXtyetnCwHrlULxifByo7UnJ8
 Cy6af5K8ZMj8mL05D1Wzd1ds7rKW1CSiqyr2KbN06s02mLfwWhuXWzmRgrT0TA3B0Fftb7fx2U3
 /e0P1netSh0Erlr4d6yEnVbhu9w7+iRganjsxelqycQb3XLOUYxvWIoIKnsEWwH9Q98e706cC5j
 Tl3iSBERHApLNpzWPIfGsVi872tbwbweMdWvZldR1XGsD/4yr/leJ09soBiWjnRA+VslJ344+N1
 XcGpuO+Uq9WJhRKQS//OUwp4JFx0UZl3WQTJ4/xQ0p6CckmF/en5QKiSUzUBJ+oxNSBCf1lORvq
 W6T38tBL7PlEjnsw+NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 21 May 2026 16:04:12 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>
> > On Tue, 19 May 2026 13:13:49 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf get_tph callback for exporters to return TPH
> > > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_=
TPH
> > > so userspace can attach that metadata to a VFIO-exported dma-buf.
> >
> > This should be two patches, the first extending the dma-buf framework
> > for the get_tph callback for explicit approval from dma-buf maintainers
> > (who are not even copied here).  The second the vfio-pci implementation
> > of get_tph.
> >
> > > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > > uAPI carries both with explicit validity flags so importers get the
> > > value matching their requested width. SET is write-once per dma-buf;
> > > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
> >
> > I didn't see what motivated this write-once change, I thought we
> > understood that it was a userspace problem that the tph values need to
> > be set before providing the dma-buf fd to the importer and that races
> > relative to that are a userspace ordering problem.  Write-once seems
> > unnecessarily restrictive and there's no justification provided here.
> >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++=
--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> > >  include/linux/dma-buf.h            |  21 +++++
> > >  include/uapi/linux/vfio.h          |  35 ++++++++
> > >  5 files changed, 198 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >             return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> > >     case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >             return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > > +   case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +           return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                    argsz);
> > >     default:
> > >             return -ENOTTY;
> > >     }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..be1c65385670 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> > >     u32 nr_ranges;
> > >     struct kref kref;
> > >     struct completion comp;
> > > -   u8 revoked : 1;
> > > +   /*
> > > +    * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +    * consumed by the @get_tph dma-buf callback.
> > > +    *
> > > +    * @tph_flags is the publish/consume gate: writers populate
> > > +    * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +    * @tph_flags with smp_store_release(); readers do
> > > +    * smp_load_acquire(&tph_flags) before accessing the value fields.
> > > +    * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > > +    * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > > +    * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > > +    * by importers.
> > > +    */
> >
> > Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> > memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> > held when calling .get_tph().  There's a lot of lockless complication
> > here balanced on this claim of avoiding a hazard that doesn't appear
> > present.
> >
> > > +   u32 tph_flags;
> > > +   u16 steering_tag_ext;
> > > +   u8 steering_tag;
> > > +   u8 ph;
> > > +   bool revoked;
> >
> > If we still used memory_lock for tph, these could be:
> >
> >       u8 tph_st_valid:1; /* memory_lock */
> >       u8 tph_st_ext_valid:1; /* memory_lock */
> >       u8 tph_ph:2; /* memory_lock */
> >       u8 tph_st;
> >       u16 tph_st_ext;
> >       u8 revoked:1; /* dma_resv_lock */
> >
> > The existing change of @revoked from bitfield to bool has no rationale
> > noted for it in the commit log.
>
> On second thought, what dependency does anything here have on
> memory_lock?  I think we're jumping through hoops to avoid a lock we
> don't even need.  If we just want to serialize SET vs get_tph we could
> have a mutex on the dma-buf structure, or use RCU if we want to manage
> it locklessly and make sure get_tph always sees a fully consistent set
> of values.  Thanks,
>
> Alex

Agreed, we don't need memory_lock in this path. For v5 I'll instead add a
struct mutex lock to struct vfio_pci_dma_buf and take it in SET,
get_tph,
and around the priv->vdev =3D NULL store in cleanup.

Thanks,
Zhiping
