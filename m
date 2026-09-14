Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A43B9952
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404315; cv=fail; b=q87owEiER61tChqacR9idkoGImU/XO0rrmX06UF82txUUX5eRo+rjzaqUBsRzVH7OnF8Sk446f7wwJPw8sPUisTTvBrvCsHHgUbS7wjE4WFO0zg0EGMVILP398ThHeKZ3Ka9HlWxk+bXshB0Du1r6sQTpLzcwQ6PBFWhI7vmYR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404315; c=relaxed/simple;
	bh=muo+Cd/9iEcLFMulfa6tLlUn7T2ati3NRjXSK8W/PXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7RS1s5spvOSjYdt5b/Vb5VUzsch2FS5EUwx8SpZJKLjy58MrbyLdkZKkASgYZWof7ldiJ+xG+XNWmvftKaZWMaMqIN/fhrbKIWzsEy+3P03q2n1CSmSp7ehaUb7ZJSWen1KWIMJ4oNO/kJt2JQzOxfIzpNqRFWoZ1Aq8QKP5zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DRplc9mq; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DRplc9mq"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EDW2O21583977
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 09:45:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Xe1oImVY8GpyEEihZx3CRbXAHQfXQa43WV0lt
	V1F1qo=; b=DRplc9mqL4hnzwGqbTVzHeRcgqwkNieFDA8xQ28u/bMvZuwjEN+7t
	6Hj3j8OQwypYp2Y2YiiGOSkzi1mPKorAmwTJPEUF/IPe9cpWt7CxfmIX6bWtAPU+
	Sd5656jISpInYWLzrP8AcLSXupfLLFClEKmY1iKuuHFjNZA7l//+IYV8bBUEmQ5I
	S7vhKGNeier4AqLSbGr5Nghj7l0CgM673wV3Y8fEhbXoi6Ks09XO8fzS9c6/Kg8P
	a2KNZsjYWQrkqEwmeWeRwTReNOc8EWsfmHkdhiI/er7saSKkqAezfhwCop2VJ8tV
	YTOLmaSjGRJz2T/XRzAwRsLxSpj4hKxLQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gntru7b56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 09:45:12 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-804e73b36eeso5650177a34.2
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 09:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789404311; cv=none;
        d=google.com; s=arc-20260327;
        b=S3gn738MGrG/fHT4adlNFfVLJ8Lwbyi6z/dvHzZCH1nbCmw0cylJUvMFiNKL6e8g8t
         NfXv6yFR5bOADTwslBGr5SQjRICIEg+9eTKWaat+grWnba+2JFni60e/PDwOhQ3Rk7GR
         puLovtHb2Cr7cSkUw9pxJGOHlUHnP4J0EmwO1eIfdLX2hdjmHodJu3Yd6860uQqr2ag0
         YyRJi5mL/+mqFXjX6C5L1isYSjBWYrikTjF8xOejd00xDnZAG5jmQT++l8votvTrQgDq
         khigBab/FdwtAKFDyK2PH16S25XbtFB/+TBsu6AB8/tFqZUjmYQELHa4+y2bYV3nqOzp
         damg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=W/IfzmZpAk7B09Cty+ZUz8VvpecEGW2xEWJ+5rLbuiA=;
        fh=yXowbjwChvTuO2patgCam//1bsfk5grzlKBJPiEYDFs=;
        b=mZpTEVPz2SqV5/5uzVlOSdAIA+T+BJtBJs9Xz3W6gpq32bjmu9E2qYfKHTDibZMe20
         ceFMvJuO1SLmqXalNx6u3iMd+eC60X4MkugUKRxUmxONFfPuapqA14maknTnZvG+4Zc/
         sI28dJApnCeCQBhwfk7xgnZHtkfZLfBNtl85hV6fWMCozDiOFCYU9ZJO0/DJkWTkSIaA
         M5WVwgDX4odIwlZ2sXz9gibnaE+i4WrR6UYQuqaDk49tl5QGe92nLUez5VzrhRVsF1/x
         CZN//cucvvHnk9CnuCJ1OLutdk10U2ftEsMeppt4PPUQZORovPCgTqu6SZe03JEKGPCZ
         zlbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789404311; x=1790009111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/IfzmZpAk7B09Cty+ZUz8VvpecEGW2xEWJ+5rLbuiA=;
        b=Uv628ITzSgf+PVMVOtTbw7xz6G/trz0KYVXkYCVRQpFHKIEGxpdU+Uqj4XNZFm0leN
         jHAXXMB39+0ryIPkTd7GYupZC6dj8bxEBffyOxTaMgnA2c7kN29Ad3PF6G6KLObQlk8t
         i4Fl+AYvrUPKWxcjqpz2vz3uxYoMQFr1pDJHIBhdIDKFVjXRpKNSrw21Tp/obvn0E1SN
         ragPHA36JzQdcw42cG15bWU3N0XFeNUrRTfg1gxeBRGnPnReLROWSKN34SYKo6nSkQgP
         6QDW7Js/QgIGnh9OCDthHki56WF2EZ65zLrMPJ5FCWBRxizToMKMYunYAe1XEyVA3yc2
         Tcuw==
X-Gm-Message-State: AFuF++lyJHd23LC8isN42Z01aR2yQh0ekAR6A4oVuC+CcZjpEXKg2HgL
	4Tw+qNwhUDWSQViCJNZiYKWBZhyjqltqoa/hHLde55xvHmp283yjEuGE2WfOn5qdiDCD6nJzFdr
	EoxTVUT9wn8Ra3U23Gb3RQSjt5984xepL7zfSrlvYDg2wYJlfhtb1pHgXLQuqwZ0GiDXDSs0OOZ
	QWoISgSzQLZRonXB7ZMn9GsrzsL44=
X-Gm-Gg: AYBFou35+/7BnmGYyubiIgxkVbJucQxz7mqnYmPS0fFygfwbzpnKwrQjg89ZfFkOl41
	z1PcSVdXYfxv6/goVOI2VrsV1M4mK+8tIh7vWO3+j6Vxt69CwRouyBH/sPJOXnxJrZCDyGBIuaN
	Miu+6zqpyKITOO/fO43GXrtQ4anvsloU6Pms7xJcsjK8I7DJv/53rGDR4LFYilM/6UE3UV/rWZ
X-Received: by 2002:a05:6830:4c18:b0:804:bb22:6d42 with SMTP id 46e09a7af769-80899165940mr2442801a34.17.1789404311019;
        Mon, 14 Sep 2026 09:45:11 -0700 (PDT)
X-Received: by 2002:a05:6830:4c18:b0:804:bb22:6d42 with SMTP id
 46e09a7af769-80899165940mr2442701a34.17.1789404309350; Mon, 14 Sep 2026
 09:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
 <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com> <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com>
In-Reply-To: <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 14 Sep 2026 09:44:57 -0700
X-Gm-Features: AcwNN1V7qhKXhTeUGI34ctmmAmZsJQy-TojG1H3GIQpXD2MuySir3gvz-U-HjyU
Message-ID: <CAH3zFs3=t3rNDDjUsCAekfhEGOJPyx-YXKta7NdHy3kBKU_RHQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzOCBTYWx0ZWRfX3mTB1CQnq/pc
 a6EFGGPW1C33Z9P6bwjemgtXdj8BS9AO31vJLxJg6T/nyvC3C3ERQv71O+0C0vO05/DjeoPpOfN
 uC2fpzpzIVFTiPW2zDo0a+JfL1MaQ2ZZ/ODE4z/ULYcraLOPweioX8urnulTS+t1W/bisqUbwUj
 I8BKZbopFsDc+C6T2jJF/GNDM809qhOStBzsothntUYC5gY47V05pMamPZ99tDKk3CI3xNXcXSM
 RK0oyQrylHLqpO4o+f26YQ1HjBYf4A8BPwMC5ZHwdfPCyeqgN7S/8G2JVu/hCmdWbxqUw/1dlIP
 4VNetxJukyLmj3jJ81mdwg453te+BEZt4Olpo2pe31f2VPRl6iFMCaLPQT4qOCL3XUY5EYSOHZN
 dKDBXhvyvsmXgKfmp/KXipdaL0wN5faQjtxaf6BSIeB39cslLW83Ig63RR6/Pz8RrhJH7A9Zt4I
 v0sERryMd8HAZzDH2/g==
X-Authority-Analysis: v=2.4 cv=TrZzFzXh c=1 sm=1 tr=0 ts=6aa82498 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=Yozcj6nN4JbTgJmO7zcA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzOCBTYWx0ZWRfX+eWO1Qy3nxrO
 A+TqSHV9kFSrn8FM6i3BAJRvdxdcS1p+4/7fLwWkuP6IePBwX/3G+6rjUD+2aP9rI8ujMB1i68H
 dMc5M4mUQKlAp27S1CWjxny7wdIXJdM=
X-Proofpoint-ORIG-GUID: 6XhbuYIJCG36URlyqksOH6COA5kI4bZF
X-Proofpoint-GUID: 6XhbuYIJCG36URlyqksOH6COA5kI4bZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01

Thanks Christian -- no worries on the bandwidth, I'll add the Acked-by
to patch 3.

Hi Alex, Jason, Bjorn,

Could you help with reviews on patch 4 (vfio/pci) and patch 5
(RDMA/mlx5), plus acks on patches 1-2 (PCI TPH core) so the set can
travel whole if it goes through the VFIO tree, which is the route
Christian suggests?

I've also rebased the set onto 7.3 (base 5225b8eec4c9) and retested on
hardware -- PCIe analyzer captures confirming the requested ST and PH
on outbound TLPs, no splats.

One thing to decide: upstream took 13 for
VFIO_DEVICE_FEATURE_ZPCI_ERROR after v13 went out, so
VFIO_DEVICE_FEATURE_DMA_BUF_TPH becomes 14 in the respin -- let me
know if you'd rather it be something else.

I'll post v14 after I hear from you. Delta from v13 is the rebase,
that feature-number move, and nothing else functional.

Thanks,
Zhiping

On Fri, Sep 11, 2026 at 12:58=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> Hi Zhiping,
>
> sorry I'm completely underwater at the moment and don't have time to take=
 another look at the full set.
>
> But IIRC you already fixed my documentation requirements and skimming ove=
r the patch once more I can't see anything wrong of hand.
>
> So feel free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.=
com> to patch "dma-buf: add optional get_pci_tph() callback" and push it up=
stream through the VFIO channels.
>
> Regards,
> Christian.
>
> On 9/10/26 23:46, Zhiping Zhang wrote:
> > Hi Christian,
> >
> > Third ping on this series. The only patch still without review is 3/5,
> > which adds an optional get_pci_tph() callback to dma_buf_ops:
> >
> > https://lore.kernel.org/kvm/20260731211601.3033906-4-zhipingz@meta.com/
> >
> > It lets an exporter report the PCIe TPH steering tag for a
> > peer-to-peer mapping. The callback is optional -- exporters that don't
> > implement it behave exactly as today -- and nothing else in dma-buf
> > changes.
> >
> > The rest of the series is settled: Chengwen acked patch 2, the
> > automated review is clean, and there are no open comments from v12.
> > Alex is holding his ack until the dma-buf side has been looked at, so
> > this one callback is gating the whole series.
> >
> > If you have concerns about the API shape or the locking, I'll respin.
> > If someone else should review the dma-buf side, tell me who and I'll
> > take it there. Otherwise I'll check with Alex and Jason next week on
> > how to proceed, since 7.3 is in rc and the next window is about a
> > month out.
> >
> > Thanks,
> > Zhiping
> >
> > On Wed, Sep 2, 2026 at 1:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com=
> wrote:
> >>
> >> Hi Christian,
> >>
> >> Another ping on this series for your attention. Pls see below for more=
 details.
> >>
> >> Thanks,
> >> Zhiping
> >>
> >> On Fri, Aug 14, 2026 at 11:08=E2=80=AFAM Zhiping Zhang <zhipingz@meta.=
com> wrote:
> >>>
> >>>  Hi Christian,
> >>>
> >>> A gentle ping on this series, especially patch 3, which adds the
> >>> optional dma-buf get_pci_tph() callback. Could you please review this
> >>> when you have a chance?
> >>>
> >>> https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@m=
eta.com/
> >>>
> >>> Thanks,
> >>> Zhiping
> >>>
> >>>
> >>> On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.=
com> wrote:
> >>>>
> >>>> This series adds TLP Processing Hints (TPH) support to the VFIO dma-=
buf
> >>>> export path, allowing importing drivers (e.g. mlx5) to use the
> >>>> exporter's steering tag when performing peer-to-peer DMA into a
> >>>> VFIO-owned device.
> >>>>
> >>>> There is no separate in-tree vendor kernel driver for the target dev=
ice:
> >>>> vfio-pci is the in-tree driver and the targeted device is managed
> >>>> from userspace via VFIO passthrough. That is why the ST has to flow
> >>>> through a uAPI: userspace owns the device and its ST table, so it is=
 the
> >>>> entity that can configure a meaningful value for a given dma-buf. The
> >>>> kernel-visible participants are still in-tree: vfio-pci exports the
> >>>> dma-buf and mlx5 imports it.
> >>>>
> >>>> On the effect: the endpoint's PCIe ingress block uses the ST as
> >>>> an in-band instruction for the incoming P2P TLP -- selecting a target
> >>>> cache partition and, on writes, an in-flight operation on the data
> >>>> before it lands. The dma-buf callback keeps this opaque to the
> >>>> framework -- only the producer (userspace owner of the VFIO device)
> >>>> and the consumer (endpoint block) need to interpret the value. The
> >>>> dma-buf get_pci_tph callback itself is optional, but workloads that
> >>>> depend on the endpoint's in-flight operation need it because fallback
> >>>> does not produce the same result.
> >>>>
> >>>> The dma-buf hook is intentionally generic and discoverable rather th=
an
> >>>> a private side channel. The exporter owns the completing address
> >>>> space for the dma-buf and decides whether it can provide a meaningful
> >>>> ST/PH tuple for that completer; the dma-buf core keeps the tuple opa=
que,
> >>>> and importers merely request the namespace they support and place the
> >>>> returned value on generated TLPs. Exporters that cannot derive a
> >>>> meaningful tuple simply return -EOPNOTSUPP.
> >>>>
> >>>> TPH is advisory: a steering tag that is not honored on the path (for
> >>>> example an intermediate routing element that does not forward the TPH
> >>>> prefix) is ignored and the request completes as an ordinary,
> >>>> non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefo=
re
> >>>> targets the same-Root-Port / common-switch topology, where the ST
> >>>> reaches the completer; cross-Root-Port P2P is best-effort and is not
> >>>> gated in the uAPI, since supplying an unused ST is harmless and there
> >>>> is no discoverable "TPH routing" capability to test against.
> >>>>
> >>>> Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding i=
nto
> >>>> "not supported" in get_rp_completer_type(), so only architected valu=
es
> >>>> can reach the TPH Requester Enable field. It was previously posted
> >>>> standalone to linux-pci; per Alex Williamson's v12 review it now tra=
vels
> >>>> with the series, which removes the cross-tree ordering dependency and
> >>>> lets review tooling apply the series as posted.
> >>>> Patch 2 adds small PCI/TPH type helpers so drivers can query the ena=
bled
> >>>> TPH requester mode and the device's TPH Completer Supported field
> >>>> without reaching into pci_dev internals (and so callers in
> >>>> CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer=
_type()
> >>>> applies the same reserved-encoding fold as get_rp_completer_type(),
> >>>> inlined locally so the helper is self-contained.
> >>>> Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> >>>> dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> >>>> metadata from an exporter under dmabuf->resv.
> >>>> Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> >>>> (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metada=
ta.
> >>>> Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforce=
s the
> >>>> dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid f=
or the
> >>>> mapping it was queried against, and the mkey's TPH fields cannot be
> >>>> reprogrammed in place. mlx5 therefore records the registration-time =
tuple
> >>>> and re-queries after each dma-buf mapping is established under
> >>>> dmabuf->resv; unchanged tuples continue with the existing mkey, while
> >>>> changed or missing tuples fail the remap rather than continue with a
> >>>> stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> >>>> because invalidation is revoke/quiesce, not movement to a new backing
> >>>> placement, and the userspace-provided tuple is not changed by the
> >>>> revoke/un-revoke path.
> >>>>
> >>>> Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> >>>> Functional validation on the target topology: PCIe analyzer captures
> >>>> on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> >>>> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-e=
nd
> >>>> P2P workload only produces results consistent with the endpoint's
> >>>> ST-selected in-flight operation. For example, with userspace
> >>>> configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a pee=
r-to-
> >>>> peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> >>>> ST=3DF0h PH=3D2 HV=3D1":
> >>>> (TLP Captures)
> >>>> 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> >>>> F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> >>>> E0200000 -> AddrH=3D000020E0h
> >>>> 00080006 -> AddrL=3D06000800h
> >>>> 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
> >>>>
> >>>> The dma-buf get_pci_tph interface has also been exercised by a secon=
d,
> >>>> independent importer: a different vendor's NIC whose driver is not y=
et
> >>>> upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analy=
zer
> >>>> confirmed the ST it placed on outbound P2P TLPs matches the value
> >>>> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result =
as
> >>>> with mlx5. Two unrelated importer drivers exercising the callback
> >>>> end-to-end shows the interface is not tied to a single consumer. That
> >>>> importer change is out-of-tree and not part of this series. For that
> >>>> second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=
=3D0,
> >>>> an analyzer capture shows:
> >>>> (TLP Captures)
> >>>> 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> >>>> 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> >>>> 00170000 -> AddrH=3D00001700h
> >>>> 00200006 -> AddrL=3D06002000h
> >>>> 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
> >>>>
> >>>> Changes since v12:
> >>>>   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
> >>>>   previously posted standalone to linux-pci [1], is now the first pa=
tch
> >>>>   here (Alex Williamson). Sashiko could not apply v12 because of that
> >>>>   external dependency; with the fold in-series and the mlx5 leak fix=
 in
> >>>>   linux-next, v13 has none. The code is unchanged from the standalone
> >>>>   v3; the Fixes: tag is dropped, since no code path can reach the
> >>>>   reserved encoding today and the patch is hardening rather than a f=
ix
> >>>>   for observed silicon.
> >>>>
> >>>>   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
> >>>>   pcie_tph_completer_type() rather than calling the helper that earl=
ier
> >>>>   folding revisions added; that helper was dropped in folding v3 per
> >>>>   Bjorn Helgaas and Wei Huang.
> >>>>
> >>>>   Patch 3 (dma-buf): no functional change.
> >>>>
> >>>>   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
> >>>>   vdev->pci_ops->get_dmabuf_phys, matching
> >>>>   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the fea=
ture
> >>>>   as supported on a device that advertises TPH Completer support but
> >>>>   cannot export a vfio dma-buf at all, so nothing could ever carry t=
he
> >>>>   metadata (Alex Williamson, who raised this to uAPI-affecting
> >>>>   severity).
> >>>>
> >>>>   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index=
()
> >>>>   ahead of the pcie_tph_get_cpu_st() call, so splitting out
> >>>>   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation =
on
> >>>>   devices without ST support nor changes the errno userspace sees wh=
en
> >>>>   the _DSM lookup fails (Alex Williamson). The commit message now
> >>>>   describes this rather than presenting the split as a pure extracti=
on.
> >>>>
> >>>> Previous link:
> >>>> v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhip=
ingz@meta.com/
> >>>> v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhip=
ingz@meta.com/
> >>>> v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhip=
ingz@meta.com/
> >>>> v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipi=
ngz@meta.com/
> >>>> v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipi=
ngz@meta.com/
> >>>> v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipi=
ngz@meta.com/
> >>>> v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipi=
ngz@meta.com/
> >>>> v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipi=
ngz@meta.com/
> >>>> v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipi=
ngz@meta.com/
> >>>> v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipi=
ngz@meta.com/
> >>>> v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipin=
gz@meta.com/
> >>>>
> >>>> Zhiping Zhang (5):
> >>>>   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
> >>>>   PCI/TPH: Add requester/completer type helpers
> >>>>   dma-buf: add optional get_pci_tph() callback
> >>>>   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
> >>>>   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
> >>>>
> >>>>  drivers/dma-buf/dma-buf.c                     |  32 ++++
> >>>>  drivers/infiniband/hw/mlx5/main.c             |   1 +
> >>>>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
> >>>>  drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++=
++-
> >>>>  drivers/infiniband/hw/mlx5/odp.c              |   7 +
> >>>>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
> >>>>  drivers/pci/tph.c                             |  55 ++++++-
> >>>>  drivers/vfio/pci/vfio_pci_core.c              |   3 +
> >>>>  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
> >>>>  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
> >>>>  include/linux/dma-buf.h                       |  25 +++
> >>>>  include/linux/mlx5/driver.h                   |  15 ++
> >>>>  include/linux/pci-tph.h                       |   8 +
> >>>>  include/uapi/linux/vfio.h                     |  43 +++++
> >>>>  14 files changed, 517 insertions(+), 19 deletions(-)
> >>>>
> >>>> --
> >>>> 2.53.0-Meta
> >>>>
>
