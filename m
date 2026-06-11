Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FF363C7F
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218513; cv=fail; b=lNkV/qAuMvueD672n6Na3FO1hrdoCng0qeL1Bx1/hxxzkvwcB+PKEcm1bpYNQi/+ac7vmuFYhy8V9DfRkkbumJBis8ezzE30iXd/KkXejUsPDpv2uSUhq6FApSaSd5mfIhasw7Iuho8vxljXVa6wp+6nu7MR6CiGQIzmF5Iu6W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218513; c=relaxed/simple;
	bh=TIHi+z0G+5507IUn8zV5xzVcf+lqGAUQi74HLRRwRWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCUL3+xIYuqS4e+LPwmnZz7S7TZiakDRrRuzLsVo9tDLUpYOUaB11vUxSyt41waFT4eeg2dKDSwnq/ynL6TaFZWCQKPcILE6WiAvqA1D3UvHHZ2GR5TZW4+eu8Q8ri1Ijdj/+OXA6bFIC7Bz4eM08jJn1R1IVY3+2Jxb3T200LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GSoH5Slu; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GSoH5Slu"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BLJJ783485128
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PstN10mGGH+L0A0CuZvfxdqRssEKVpUiOodgdSJiiVo=; b=GSoH5SluoitA
	ZhbhWOwNzZW0wVQslaRzOinRNj0iQBrT8vlZdPN2pSQ81NJhJsM6lrkRBfl65wwB
	Y6XI9NxpND7U3QFlGs/3h9zNcYs5uhOwY47aIU5+EFwN8tL0uJjB3xT4Nc2flLB8
	OuoRY9cJNAxqPnad+ocTYUbkKCVC8IBCfC3SpUi1FJ+WZQob1ge1Jpp9UqjUFdWz
	K1c+zwzcafG7syWDN66Fj9WqXwz7FP2S9x2PYeJbkQE2VqOZpCCSJ1Pi0LPZggjM
	b2aFPVkM2zchaidEebRvMGWAVwnPUS0gkiIJhE8DgZHNoygYJJTbBZkcw54dlUux
	W3AMfKkv+w==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7b994f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:55:06 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6d78299e9so859998a34.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218505; cv=none;
        d=google.com; s=arc-20240605;
        b=gqFyikXk/VIu3eAuzebExJWGoXUjSguWcMpC5cylqKzvcqqpW8c+q5JjiWRtwdj3K4
         0ahYP/FHXlosR9sO5g8FI1E3CZTCHuXbp5IlgKeN05a1dX30NZPQa1kk+kN2V71NjhXZ
         MYJN2nN7tovwr3cwg59HOG+r2UqkJ6Pg4K0fmSYtVwkJVQPgFNQgNKi6RFpyR5zPyuwW
         aY/kBslBOkv4neiyl9Vx2aB+CdzTG6Me+jTdcfHGa6wrJz14iBLOmdVA2ozM6QAX0UlQ
         Xf5JjfPoi4Mzp6hID/hKtuqIs3CpBtqZBJhbi1SskfXMB/I3H7628c5fk8DmWQu9dz4/
         X14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
        fh=Y+KYivgtax/z85gVt76uyK1ORwE9fQMGlYAlHdz9B0Y=;
        b=HdwnXGD8zDFWrx0qj5w4bex71iv6YvIbrzKhOIdmTr6jdfc9X/P0/o2oCAvxKbFOJF
         kBHNrb4XaqTYzrJJAkxPYbCoIW+a6mAUQRcwCeC4C8PWdgYkS0VHGMBOIeaPcI7bGqmF
         6Ew3i0t8grd3bcmOjnrgCcfS+qjkLVxD+Ll1LGwLnYQsrnyLE8VhyeCu1rOEQko0e38C
         BO6xMdD38X02UKPXRPURYgb9NAr+5PKZH3WE3oZJt66xV1HtIUoX4PsDja6W29es1Aae
         5b3wnGYrhwgRk86dLprbgUtKdC0wpqI432OANizC9HYJOSRMmQmIXX1RJZSMy8UzqLwX
         SYsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218505; x=1781823305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
        b=rM2LIp0yx+QTQGBni9gc89APDvxcArO3AmskV+jtfGo9IHEaQ2bbK1uIf6KPJ/nJzq
         43QjFIFOZ3+8uCjNJp+BUm8MLA9cp9R6XpTbJ/56E2tyjld9iSAv8lbnR0hk1JkzJtPL
         t/4VlNliyPivk7kd5OeO0A6jnzuUsryaUHkEkQOnAgGv4pOSptR9YH447HIRqJXiJSsN
         B0ph/KIWNdclBm2YGeJID06UOLP9Pp1v4l3Gv1fDJ41RgBl8KDVNCd2PbTUkG1SXAcYU
         dPAf2z11w60DG7j3v2p7qo8NyM/1K30bItDSmPsrNBM8IUf6ezH+96+XoRLfwn39qFut
         M9xQ==
X-Gm-Message-State: AOJu0YwGSCChDDLA7NPjNVCQzUA7m9R1wrNrOjS+IZr8oIunSSnN/F2d
	DKd2v/7gPuT5lkQBZ+iqIiIqjENR1SV/8Kjhos03zX+I98G94ABNRvDolpQ2+UdSZn1FZmVR1y2
	BnQWit7PT/Duy9xVftibVjlGEE4VoyWOpD//0hO60zSPVIVHTdj1e8f8vv3OJsrPnp4sCw5EITD
	ZPJWx6zJ1QjrzMfEFlL1hFPX7RGwg=
X-Gm-Gg: Acq92OHMfrTDG3hOPJQKuhlDSUzNZMgV/eHU5HhUkm6Ov7SfQZsGr6fq/oJ/mZWUIg5
	pZhjFdCjz5ZSzDTBHNzSwB4ZQRid0GjxGLSLrCx7oxI8GM2Tk8XxOGGtikAN2Gq0+7G1A6oCvAv
	q/hM7i1446GzAWUBfRmaw16q5wq25O4HfPJwdRSvpTsw6wtIFBbnJ2KSJVY9fI2zxAbdEpzP6DI
	6GwaWGrTfI4/5FNUJaUDw==
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id 46e09a7af769-7e7846e89d4mr84839a34.9.1781218505372;
        Thu, 11 Jun 2026 15:55:05 -0700 (PDT)
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id
 46e09a7af769-7e7846e89d4mr84824a34.9.1781218504891; Thu, 11 Jun 2026 15:55:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-2-zhipingz@meta.com> <20260611202559.80EF21F000E9@smtp.kernel.org>
In-Reply-To: <20260611202559.80EF21F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:54:54 -0700
X-Gm-Features: AVVi8Cec0xPin_3Tu2bkuOl2uwNE0xNjryiPQU2XmmSIcyBQ5hzh3oLNXw3MBdo
Message-ID: <CAH3zFs1U92oXZse+8h5rKNrfWmtqt3SeCRJa8D9O8R02chnwTA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX11MNR24YZEVV
 kzk5E9tv7wuBst1e93UhSCY/o93rCEjgnvhclQvhfUTlYTCMq9SYdsLhPtz73677fvvdaxvgxhN
 U2eiawFslbdF4Iet/nfOctlSDMA9oXQ=
X-Proofpoint-GUID: YNqzZw2__Smd9y76bYtm5ezhQ8eNoAty
X-Proofpoint-ORIG-GUID: YNqzZw2__Smd9y76bYtm5ezhQ8eNoAty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX+22gYzJM+6cj
 TXDyZfoC97uaLBy3ifpQtvVNLvBAJkc9vfv0KOMOPujwDPzZlJ8j5mm+DORiwRbaRsnFWMhVMEM
 ZBV+9bnfnaw0+tYxm7p/6YS9lCsLYecTc7NXBQTgYxaeT3fjrIrbCZ5gwn6hwjyju2Teh7EBwFi
 i4bOPUi9EU9D8ZizSyv9Z1HUfYn1d+y4yBP8ESzlhQG4eyvsuGlSY5gX7Y656XhypZEub9+0viX
 ZsVkfeddTM9zTICQPepzFORLu04yHVLAoeMfltacIneKTYH8frmhcWQc3lLnep9wqphnkh3aBJ3
 7gS2wqZFWBYADxiK0T4GPZ4wpfbcuacL7uDADrh7OtXCeGQdU3R4UPADLjkTCLTPMFt30EuyiGX
 KR7Hl1Xgyc49zhfbgGeFm5HJYrz85GOFFD/I23kS0VNh91M0gACdXNIAt860gw8NraP9+ydJKiG
 qELR/TmU9uhXbVXXdxA==
X-Authority-Analysis: v=2.4 cv=C8nZDwP+ c=1 sm=1 tr=0 ts=6a2b3cca cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=37eGqx-N3tBcJSbcPa0A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Out-of-bounds read in UVERBS_METHOD_DMAH_ALLOC handler due t=
o missing bounds check on user-supplied cpu_id.
> --
>
> commit efb72743b37fe4c5005fca2d75b36ef50832bc6c
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> net/mlx5: free mlx5_st_idx_data on final dealloc
>
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a135..7cedc348790db 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
> >
>
> [Severity: Critical]
> This is a pre-existing issue, but does
> UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC) in
> drivers/infiniband/core/uverbs_std_types_dmah.c lack bounds checking on t=
he
> untrusted user-supplied dmah->cpu_id?
>
> drivers/infiniband/core/uverbs_std_types_dmah.c:UVERBS_HANDLER(UVERBS_MET=
HOD_DMAH_ALLOC)() {
>     ...
>                 ret =3D uverbs_copy_from(&dmah->cpu_id, attrs,
>                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
>                 if (ret)
>                         goto err;
>
>                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
>                         ret =3D -EPERM;
>                         goto err;
>                 }
>     ...
> }
>
> The dmah->cpu_id is copied directly from an untrusted uverbs attribute
> without value validation.
>
> Since cpumask_check only emits a warning if the CPU ID is out of bounds a=
nd
> does not cap the value, could test_bit compute a bit offset far outside t=
he
> bounds of current->cpus_ptr?
>
> Can an attacker exploit this to read unmapped kernel memory (causing a ke=
rnel
> panic) or infer the contents of kernel memory by observing whether the
> syscall succeeds or fails with -EPERM?
>
> --
> Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.dev/=
*/patchset/20260610193158.2614209-1-zhipingz@meta.com?part=3D1__;Iw!!Bt8RZU=
m9aw!-yx89CgOVvF9E6-bX3TWkgI1oBHKqqBP1C88LmgmavxlZKHEFJdEeW7gwHdiVC2U2gzS3R=
GnvW_CiJNQVwxS$

Not relevant to my patch series.

Zhiping
