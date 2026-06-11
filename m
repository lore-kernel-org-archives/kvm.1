Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA9231A23
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218960; cv=fail; b=pqLwBpbdOIZ69V03gKKvbg6xwve1vDe3m3C7X3yQlv9ucRKiX88EiUTwazEb0vr1Ppo6Ps6m4slN1JBHABeJ0PL6RWdSInjYWF6dfjGxqrikbOi6ARURRTc+BE0NYDltQ+MzvipbDwDltx37dSLGZ8lvv56pZMguqvHwYOCZVaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218960; c=relaxed/simple;
	bh=KmwjCJkcGhr9SpyfvITozRaH7etw0dkoyx0aMoQc8E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+9On4AIn7Ic1sXXvf/co5Vd51qFRadJnnGvBev4sck97vwPnTWhuQr98zDtAypiRXXkO0NdPonwg6bsQHIeCUGYBcosII5lbsMjuqdXzN9ScDalfiF2hPoxkBuuV6dZ8eYas9WcFi1lGyKCWulXKS5yX17lRr/4njnS70tklrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=md1FMUhb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="md1FMUhb"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BKkhu44124446
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ob92Tq2R57wAiMWenfqpV0H25NaZcFwlwctuc69C3Js=; b=md1FMUhbMLo8
	Fh894GG//O50My3HeLIl+N1moRtgU28J41XgC7IeNjtkXzdqb3Q4pJbloUb0sI57
	9jVz7NnQpwJ5bDPV4npoEbwYzhg4rgAl9HiKES6OFpGviFE4XpNWf6+El9J9dJ7B
	Yo/EOv0vO3lg0CKH0IeKIWviH2o6Ji1sS4icJbrVsodYNItHLNAjRW6ZraJMViyk
	n/FyvaceZSOsCn5SwSysZB4DgzxdCuNLNoHpkBe5q1vDh++JPpSH4eLPJhsKjRSE
	bq0UWdRUpM7b1KbePNQSfzI9YgeqCUP1xW5dgvSck3N00OzgCLYF3SsitjHsc7bI
	ag85db8yRw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78sks0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b5976d74so825307a34.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218957; cv=none;
        d=google.com; s=arc-20240605;
        b=fuz6TETTuXE1s51PDPvHl2caIvV4ekZCr9FaKoeNRRUrNi2kB0/g2MZLWesdGpx8H7
         DC654zUs4KISY0WRthN1xLAunTmPcy1kVh8+R/ucL+34SPod3v6ZPC5DpqFnUjSAKD+0
         eGaOCzhATJQE1nPXzItE/qKwkVZwdfc2ejFqE2vC1XY6o6NnCvXTIRDDoYBPzGrZdoWN
         vK02spP0XUJn/1t/P1F22pEi9nXJWAapB/2Frfm9LrFTs5DcUTp/5YYtbHDWaaIReRFD
         w7SnQoLLmofPw0pHRms2QRe7dvO/4k4E+hsbYQK399JBPZEeN7Jj7Iz8dgrMvdnYJM5k
         OWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
        fh=AbfLmcAFihT2WIfDcsWJ9FZilGQweYI2gbM/fv/ALeA=;
        b=A1HPkIJj4IHAFl3A3NSuF4WFgyrCO99kFfOFMitLtTlTx9HfwUlmfBDWo8lo6llOY2
         AcgjlSPYmSHCjJ4Ke3Ol5TbC8WfbItbhBwgwxggxVCEwM8fgB2FC4HN9h2PhMuZCtqmw
         88hrODg7s0kWwuel05m1VR4DAYdTQT0COruHuYCiQdAZll29LyYqqZ/QVh1Qu2w0nv1K
         hzxlTpTQcPm6DuhmcWLfz00k8LMww2yzCJgTT3JRrYVYgQNvwPyAvoyilHO+YSjXj30V
         zVQRlrWJtFecxu4Gh87zswKpolgvridZOpHTZ3n6ucVWXK740S+pdTKqC0D8Rqyk/AEV
         Vq7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218957; x=1781823757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
        b=U9DeRSiAAzWr82LQwCVnGXU75Nz6eLj+Lz4CnXEFXP0seoLXMPp5WYai+PNcjPje+N
         0l5fr08DYTWxXr0YZoVz1e8YDQdGLUo0PqxkIO7Gkr6lkJ/d0+zruWHZE8B230J2oalV
         ndXVhJfBt0Zb3OO7xDUM3Z5RubXRkw4r/5DxR01vdxNytdGNWNHypfWxMJKoh33qiC+U
         Mo7zAziZujf6bXFW+TExbg3XpruXxiT8o5wL5H+HNy+j++w4/d5M9kdSLJaW3VrL+hEu
         cYBVee1tppF+MfGsbmuhukrrneGDoLAolSp5tyMsMUxZWD1hJSWSD5ugBBSc3UFHW7R8
         84xQ==
X-Forwarded-Encrypted: i=1; AFNElJ8oro2hDHblBtX5esWlMJoekDx5mj4QwN0WPFr1xkMZ4+IYJ2aP6tpr8P/VdgGFjhi9MFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMhPdlkMNbw6vDYEyhFG1c1lZjwQsZqdVptc5s34Pqvxqumho
	8KvfrB1cEsqEZ300cAU5LX10OLw9HbG5pzTcxwAkY5YTFMtAuMIHl6lo/4WZ/5g23eN2UCHbP5R
	sYokWj7CH8lwArbSR3X0rj1N/LVErc0le+nLcmUQW2TmdOpPOwltVwSv5JTexgFBFVu1J533K3e
	2sur3t5gGccHBnjsPywVpR7DW41MQ=
X-Gm-Gg: Acq92OGnHW7cT1u6zdIWxTXtBcYZFoqAXQ6CjvIT1rAfUhq/Spa7GLwqkg5WT/L4wIG
	u9Qx8BIAv/YGV5Cgb32DEoS58pJOpnSbL81Ai3Amz1z20VrBMkFUTUMhaesc/SJ1xbOk23u1Ekg
	rmb3x2ZggfX8CARjnLvd+N6nzMI2NTbUwiHkesPBREm/z/Jj9KsvSu4E4SCGdL3ZV7B6oTBJGnP
	ZTHJUl6hiLThf5k/EsRDA==
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id 46e09a7af769-7e78473e9a9mr114899a34.7.1781218957158;
        Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e78473e9a9mr114839a34.7.1781218956672; Thu, 11 Jun 2026
 16:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-5-zhipingz@meta.com> <20260611202555.B0FE31F000E9@smtp.kernel.org>
In-Reply-To: <20260611202555.B0FE31F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:02:25 -0700
X-Gm-Features: AVVi8CelQJPHsRb_TsddVOxCGdtZJzAKJ67zmwHKr7MIkmqZ8rgse99DfYGSmhU
Message-ID: <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXz26dvoFpJ5eQ
 igcNq+NkRFjWHipD/YZd71f/7LkadoGTOu4aggruWRIwWh2wn0M8byxNxYqnUrGGKKu+OrYozBF
 lRTfTYlY/rpsRFBourZhuq2oFYTJvYhG1OsHkxs3qFCbvd5XsgzMYgpXIGy00ak8qrja1nZzAnU
 6auiShUpZ1wYARiu3gypjzlmD/ZqcAg0AEgkUw6hAuIOt4MZS/flD9QH+k48CuxMeeshoiZ1sZa
 PRAG5Cf9eU0gMiESe1+TbU6zV5qA72G8rjsWG9Dzycui8jhSwUWuSQQZlUcW/KMvqquDPD7+mx+
 pA5Zv/Y2nHq42dMUstYrmLVxJpW0h22pVpf3udzHU+WmfneAIJrcJYxz0Z3g3b0gOcK6TQB1PDt
 22YSzKmSv+Rt3N8Udtl6L3AkHLLUt5uDeVG0kBH+KStAj/JKduaRreXlLjJng8+EvC14hljvoWI
 aheeOSsStxpmo2Mj9WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX3/JLb6fqmzAN
 XTgpDs6ldeY0IvJkx3zwtlhg6dkBvrL6nw0GgwKC17wkZqAW5sI4X1QGn/hV/JDNCAMG7rmJtnz
 v4ukM4odW9Wx+yoTHL7psdkJtjLaGtA=
X-Proofpoint-ORIG-GUID: 4GPRShkvAPH3mJ2kGjrBUPlLIaScGHGo
X-Proofpoint-GUID: 4GPRShkvAPH3mJ2kGjrBUPlLIaScGHGo
X-Authority-Analysis: v=2.4 cv=ZaAt8MVA c=1 sm=1 tr=0 ts=6a2b3e8d cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditional validation of the flag-gated 'ph' parameter can =
lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE_FEA=
TURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> --
>
> commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> vfio/pci: implement get_tph and DMA_BUF_TPH feature
>
> This commit implements dma-buf get_tph for vfio-pci exported dma-bufs and
> adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspace to
> publish TPH metadata for a VFIO-owned device. It checks completer support
> and protects the metadata under dmabuf->resv.
>
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de546..0a0705c8dbea6 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>
> [ ... ]
>
> > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     u8 comp;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
>
> [Severity: Medium]
> vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing an
> early return of success.
>
> Should the hardware capability check (pcie_tph_completer_type) occur befo=
re
> checking the feature flags, to avoid falsely reporting that the feature is
> supported on devices that lack TPH?
>

Will fix it with a change like below:
 -     if (ret !=3D 1)
+     if (ret !=3D 1) {
+             if (ret =3D=3D 0 &&
+                 pcie_tph_completer_type(vdev->pdev) =3D=3D
+                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+                     return -EOPNOTSUPP;
                return ret;
+     }

> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> [Severity: Medium]
> When userspace clears the TPH metadata by passing flags =3D=3D 0, is it r=
equired
> to zero-fill the unused ph field?
>

Not an issue.
