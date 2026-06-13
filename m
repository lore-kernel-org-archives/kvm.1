Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B91E8826
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389951; cv=fail; b=IPDSffcautTP/aVjlTqB++c43+k5wxRMPy3k4x+i8Jfdi/oGiVtgJYm/I6Hkes72XbRVM/z6r6Z1hixD9JRugq+dGDixqayhLJcAcsKkZDwXFsXNxhjHXatqdgYUwLRhHGj9NtQu9MDK1nRMgUoHfbR8IyDW13QEEkc5kzO30rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389951; c=relaxed/simple;
	bh=QTx9041dhhMcKfJPsP1m79Vn1j8B0I/HYNpHnE5xa8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hugCIMyHDI1SWpHJz6YJ1O7MF457OgeVpzMExmFJXSDc68uV2azHAuGE5M8j9rXurD+3YiXUDMtqC/q7KfKJGpR23MKJCwQGKk9CP6ONl4+UwQYnVk2ciVk+CXNjDFlPkoLNkRbQ/aty/ujzDZpeYuIP6wpEGg7VBzWvoPa0u28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rsF2tE+d; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rsF2tE+d"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DJou5Z1481791
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=92RmcGHbhf5Dgq7ILHGOiuMda6Ei+OUfewhzqJcCUNQ=; b=rsF2tE+dN2jV
	8eSKu+oUcO7wcwlrfJk9Pn+sNPKnf6ltXg8x/OTwIZ84uT53mMdFnfRTfogreJTl
	ux59CUebsLYlnA7MhUawpqRbFwNyIqdqkq9zLr1FwMv9slGPLI1CNtJ24Lfu0llZ
	Rk6XPtUNx43hUJLKH+gKhMifA2LssSZ6uKuYy5WjsYzmHXE78JtBry5Pbeqw52kW
	ejazSNvM4mpnSf8D3usXWACDowFONzH008jjUEsbGk43T1GWP2zxiWOlql5NU9iX
	kSspyuuh/5nlyZq/g+/vZoFqs8rDYdQb1QLQUgbtulXEJrCOyULq00O3JLm4c3KM
	aNoVDcyGww==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2btagjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:32:28 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e713779405so4622389a34.3
        for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 15:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389948; cv=none;
        d=google.com; s=arc-20240605;
        b=NqUN7TY+UUqM2gFOEMewt5cdJlbuaGJqR6TbRnkLWWgUFQkF2VY7DaK2VBwfGHB6o6
         PJPnyvbH0PKG8q6tLrvaqERUaPDp0kj4Gq5FrNra4PP9HDa/a1/mv2OTzcRzKTcQ5+Hp
         LW+2dMNLVxxwLZYvtvNsExIUeR3NRM0TdrKjW5bJoLiCtM3BC8jeRHPtXo5fqlkCdN32
         PXjL/N4FlgkXG05CIRUbcfCxbnCu4ZBNTx7Tf2p5rcdVJtQDrdE+yCQ58xXgLxHAORBm
         V62515QH5n1ZzpgN+JWkmKQ9ijgCM2rVbtOywyUU1JkYpEGQSHrezGfiAieoakRRSxmV
         XW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PY5KrR9iMJ26IpdWUfDs9HsxqKRAuKri6MmYIkjb96M=;
        fh=dscaC2KvulhxOKKHCQE9SNLg6nT6DEOmZaSgV+7yOwY=;
        b=MgQmNYP5KpYKG8BPHJ+q+EoMvX8aBy4swig3h2EsNBaYifb+xEi4SJKgwm00ntkosG
         7Q03cXGcDL3aUP4vjXrMOl5d3fX3t0kPe0aQH34aqRAYfUkSgd9r0PRMEoTLZ6325l0a
         u50gbUGPzE+mjphIwFcVkxyrPkHyK3ecvethmKy2HuAQDMdhO13vYdlFc9AEl6IkIVP7
         RnGdTtpnB29+ZcqXy+ikAXrzk0pcS314JezAp84qjMZno1e4zw5gH+9Rtsx7kKv2saDk
         leOhvxwGAEmGhE/0ZfmzihzpfsXF25Y8unHTcKvo7o0PTTmGL5vjA2r5wixmcc2rpu/b
         rK1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389948; x=1781994748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PY5KrR9iMJ26IpdWUfDs9HsxqKRAuKri6MmYIkjb96M=;
        b=h/hZo0wVAM+SxBJY/eCqa3YMCrOYUnvLJNn9HTq6F65hpHAoXgChnbRFisNwGqMQKM
         MozWQVUiSZgY9LE1yVXyQlNc6PZHzW/+YSIbH/pBZONjSnVY0iNSRmcpBIIJZcBzL7ez
         M//NRS8ScmHarRsIXnHs1NfGlMIjptFTgjcS61H+qIIso/oim2AYcFLlkuB7pylwsDdo
         fSJ0R/vLAWRhc+RYESEZ8tw5S5Ow5uXVmcYXIUtZgwP4JyhcaI+FB+NGx1KJCvbd3Abc
         t4rrxj0Ike31CBAigOPIgvsBWLSx8JTAMW5SJqY/CG1vPKJ0RONjhbBrcENb+1e5KXhl
         Bvqg==
X-Forwarded-Encrypted: i=1; AFNElJ8kiilQfU/cNnmU04vDSnerpNsoWcEoXmBBfr1Dwia7mumMV5XxnFKW7WgzZnj18RdC25Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHTzxqqTiayjklqdmzyclMf1/3R85K+jEfAviozFRrqKt9Tl0
	LvPT/xdZZiDht3Z8hpcfg/2ecQGJx2H9jZO0QxZi5s8Hv2QiwGdB0k/4xHzlTS8Isw1OUxz1cmB
	vKbiw/yadfrFgYvLfbUMVhwHklsbsUpCoeVKvryFexelwyg8+IbyPcc/cHeluHbCISyEEDuB37I
	J4E+86/scZvV1DZgEnmNqi5qJlIo4=
X-Gm-Gg: Acq92OFGBVsd51DRLKmEPDHQXVBJUBhhOgPxonbovHUuDhwa6l/TKCccuyD3J+RYiHk
	RPyoUlEqbgytMeqh/WExS6wNU8yHcbRNwslcODn9yB/yDPhbCqrwjinWcJsyevrKQn//AI75g9z
	Jnd3cA2Oj/naObroFQr1xV8EXpwQZCfoxjkYPTmpQIThFPvShNJlEty0hnAeGm1GRa3kWauCF4F
	erFSHDpvZ78gTq+xc2zcw==
X-Received: by 2002:a05:6830:2e03:b0:7e6:f7fb:9682 with SMTP id 46e09a7af769-7e7846efe32mr7148468a34.2.1781389947813;
        Sat, 13 Jun 2026 15:32:27 -0700 (PDT)
X-Received: by 2002:a05:6830:2e03:b0:7e6:f7fb:9682 with SMTP id
 46e09a7af769-7e7846efe32mr7148455a34.2.1781389947375; Sat, 13 Jun 2026
 15:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-5-zhipingz@meta.com> <20260611202555.B0FE31F000E9@smtp.kernel.org>
 <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com> <20260612105928.200220b8@shazbot.org>
In-Reply-To: <20260612105928.200220b8@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:32:15 -0700
X-Gm-Features: AVVi8CcMGigExPKR8IpfZtGzrLOFWz5YTcGVhRoJFgHdM9ZEhG5IiCIsvSLW0hM
Message-ID: <CAH3zFs0nGMXV2N=6epd2-40D0tyxcXs8K0E7zX8-H1DcaDOj=Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=WPZPmHsR c=1 sm=1 tr=0 ts=6a2dda7c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: -uxhOIRmMNU7Rxt1lgSu0M-hgrs8Y5PD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNSBTYWx0ZWRfXxniiuIgc76XA
 1ebV/GmhQXRITVOdJ04xlrfsd9Dlj66m0lJPlRUqdhvi2GT4ehuRCk1bqc5zmAD7hnigp7GYYcZ
 oEt2snZnpf1GUpFn1k8oUWtUlty4Ro4=
X-Proofpoint-ORIG-GUID: -uxhOIRmMNU7Rxt1lgSu0M-hgrs8Y5PD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNSBTYWx0ZWRfX6x2ap7XG3Brl
 ytKGMkWXcv1qpoVTC+ZjZGGLxEqJ51Or20J5dL8FxxpqQAyeQ/VK+iySeizQ1Dfa+N5Lg199m/y
 5irZDQAhYu1DcCfZBBhZ6eCs9vciFWk90ZcD4D1LaevBEuC9KnoG2VQovlDBAuMSBUExDReTNMW
 iJr2TUe5xgKImW9+0lhfwgaJxqgGvbNr02EkCqMMXqPebS4zhptnXKuAxL6R12GZ6SAofqRWPdi
 izs7lX1Yh7AW0vUmeo5sz/ytF16FHjUWz4W4rsIqv8ghPYeWlOlRuDNcErV2qUzykXCjjUvVurv
 dtdwAHTXFh0BKE//01KikrXOgwlMY/3idc/dqMsUyTgBe9KRxrY+xLyLiGgQJxhpf/p4nmpHupE
 tK7WdH+1rfP/lGHw89WjlNpDoNSfFfnv4z4se+FaFWB/zgVdNOM//dorOiIjs/4ZVEji9Lj5UUQ
 wRhhi/KpRpLOlrD72rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01

On Fri, Jun 12, 2026 at 9:59=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 16:02:25 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > >
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [Medium] Unconditional validation of the flag-gated 'ph' parameter =
can lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> > > - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE=
_FEATURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> > > --
> > >
> > > commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> > > Author: Zhiping Zhang <zhipingz@meta.com>
> > >
> > > vfio/pci: implement get_tph and DMA_BUF_TPH feature
> > >
> > > This commit implements dma-buf get_tph for vfio-pci exported dma-bufs=
 and
> > > adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspa=
ce to
> > > publish TPH metadata for a VFIO-owned device. It checks completer sup=
port
> > > and protects the metadata under dmabuf->resv.
> > >
> > > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/=
vfio_pci_dmabuf.c
> > > > index 1a177ce7de546..0a0705c8dbea6 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > >
> > > [ ... ]
> > >
> > > > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_=
pci_core_device *vdev, u32 flags,
> > > >       return ret;
> > > >  }
> > > >
> > > > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device =
*vdev,
> > > > +                                   u32 flags,
> > > > +                                   struct vfio_device_feature_dma_=
buf_tph __user *arg,
> > > > +                                   size_t argsz)
> > > > +{
> > > > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > > > +     struct vfio_pci_dma_buf *priv;
> > > > +     struct dma_buf *dmabuf;
> > > > +     u8 comp;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_=
SET,
> > > > +                              sizeof(set_tph));
> > > > +     if (ret !=3D 1)
> > > > +             return ret;
> > >
> > > [Severity: Medium]
> > > vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing=
 an
> > > early return of success.
> > >
> > > Should the hardware capability check (pcie_tph_completer_type) occur =
before
> > > checking the feature flags, to avoid falsely reporting that the featu=
re is
> > > supported on devices that lack TPH?
> > >
> >
> > Will fix it with a change like below:
> >  -     if (ret !=3D 1)
> > +     if (ret !=3D 1) {
> > +             if (ret =3D=3D 0 &&
> > +                 pcie_tph_completer_type(vdev->pdev) =3D=3D
> > +                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> > +                     return -EOPNOTSUPP;
> >                 return ret;
> > +     }
>
> Typically this is done before the check feature call.  Thanks,
>
> Alex

Sure will do =E2=80=94 move the completer check to the top in v8.

Thanks,
Zhiping
