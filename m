Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E233D4F2
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036914; cv=fail; b=qUyoT/Bk+S7osWcBu9SeWw9k5G7f7npU6ScdLp1b0lPKdS94SJ2f9R6Hlthp2TMensNnOvsa5KgTrLWjpT6DDII01M/ddcj80gwNqUqsXzb+LaVOPxvIPZ4m1dpy29rnwLMGwXWywiDWYIM2uLikT7djLW+zXDMuy3CAWq2Yvy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036914; c=relaxed/simple;
	bh=RUFhAdhfxdt+409Lo5x+VBLswnLbP635ULre/4vDtdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ2ior7upk2GhQvHNMnqC0IF7laleK0TxnCFhMXPx/1ErN+pVYxG+ESqB1FhBMYOnTKGnaxeRpXjFcG1V8yuTBm1qYl0b8dU9CCAvCvyq2yrMPlvoNAGfFseZjvgEKzvg4c5IazPfr9S6f3/N2Ltddd47+DW7+dZDpCj5eSf9tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=myui/KH8; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="myui/KH8"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T1NUuG2026330
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wjl2lJMhu3x6YF6VZMdTDkNQcozAcKqTdHEY7+axmxo=; b=myui/KH8juDb
	9VFRxDDFEIimNoAd5XwHhraUO/L1qE4ZtZnO5K+/nzprny+oPTbRJWHwUl7Iab/B
	cMLPIr8HMpKYeWusLbb/K+iwCBNNEvNQ4TbH/N8JWoEGZzYAl66wAE0qc8sarvKy
	NYv2JsEurivQoqaAHfEmVHaXwieB82fQ7S1h7lyRTkK45xQ7kvSunBJhbh5mhqcS
	R4u4gH7+DhvThFUOuSUwR7HsCG5Cx58JsKiG3AGPcpDd3+2CHCL50PZkKvpuBsSW
	56zV2uZKI0BOQNtMOtj246H6KVeuu5CBuNc+Twlud+11KyL2joGJMeL7vJmJjcwU
	nf9M3D97/Q==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1j4py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4856a701421so7698732b6e.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036911; cv=none;
        d=google.com; s=arc-20240605;
        b=LlPxHZLHpkYirinCuMdkmdMV6sDETE231CUQnA6R/rcdStECLox/HGY3z6XAGu8rGY
         Ch75ePrGiAp5py5IeT9vEfgMPOBEH8FaAvZwlQY3OZN8tzgtulzzENCmETfWaOYLqDrs
         rmfetpN5DpeadLabeRwV6Xccjcqd4J3d/77Cf4gL3/H5q67aCMt4cejrUpO5sd2HIXmk
         RuLNMehCv/YGUS6wD4bnO8aYtvUZkkZ1dP57I4f8nDcZj4t6rj6A3VjONGzTWARqb7bB
         Shzh5riPWNn7hKC7ZLYeeu4qbF95o853K5z5od3s5KARomiznk3i+9/XmIFBOg0s7xTi
         /zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        fh=EeuiGo3NKWxDQHp2TKIlG/Cqr/ijZ7dx288mOQ4ves0=;
        b=Fieq67MOAJa0J81Woq5TXW5ZzjUX+9zxaK58unPRDcF/5VgFG6FvRCPMQ/oBK+uMdx
         JnPxpuCBqP90nRH7Nqbpcj1ry3bzUrfP576HUYi8VNBO0NE1WJ71j+elxOCMBdfNRvXp
         tzTClxoUsom59qCw8fJ2Wyo9PXMUd0rj0Wrw6qO+e491oeDjI+O7an7kwoAJwRndFr0L
         CznsPa7Eb8uU4S+SSMkb2SK7cOf0ECkYef+NxyptmB7Ftdht7Ml0HUUHYOX7rlI3d3Oe
         F+N+xa0CziR72ypUymh8ZptfoMU6A79VMjfhm/SQNtATqWSs/epy/8VuPl7Krc/97MVR
         aamw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036911; x=1780641711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
        b=RWdaQVRzcHTM4nRZTUU3xnuE9nxnfLeNXvlqtMrhhGstQAiTkxBejK05G9rQUBbpBB
         dWswQlJNuHaunH5IcNoDOgToDuey6/hf1afNTDenSQRrA5YYGwfN5uXisp9WsuFHH2E1
         JPGT/G22ewZ3j1D3xME2YkdnwBnqwue8dC47QFFjGaBf288tU4c5wrMuWNOJ84EAqbxX
         jzfX/1mnUAC/Olj9s/zhwlTNava4KlwUh/I1UVUReKMPGCypWb4YaSHK3ipPIJH3PN8I
         t36yIkHVts9VHQRvKURtcgllSUFWIV9wKs3qArpaVyaC7jhdcTirVML9AMTd7SIAVdx0
         Ujag==
X-Forwarded-Encrypted: i=1; AFNElJ/axfWYMaserhuC+zSgbHeeUE8CMI4swEnEExFi1mdzDZxGJ7hMn640CjHcPA/8ZE/79mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxduXVHZ2uo2bQUC7GnUlG7627jq8ILiyqDJ3La5SlByhwKKF7
	egXUjDklMQsnHPxcySi/9bcyx31FTDCPLV1hFRmNSrpMyWZ73qnZ29fZZh6e5KkjCCwoWhQXOzi
	ggp4CnI2yshy+7fYYZ+NA1+nUHtAAbug7v+ICj8tHlL+Edh8dWtcj92UOOerpmlbSKPWBNGbu80
	+MRa+7BbfR1tc2Z/JM8Jz6NDBwhfA=
X-Gm-Gg: Acq92OExVie0MBvQf6M0f+K+8S6HHfYO0Iv7Iirj5s9GrDOBXP+imnHjRu1f4dqz/n9
	oZ43dH6hDKREM5DMv2j/B7VopWRWZnOJPi7tHdXxfXawl7dwCogEYUJuGByBw4VbaKfjpliE/gS
	J8TeWO+9/n8xksrLvRWVWeliZvhbbP3C/GcFS+t9gCUxYSxaALBKJsgNZenHIiYr2gIyFZhLULh
	yvok193tREbtdjUydjFDnFhZvF2cRO02Jen7mlR6DIKfWVDBoQ=
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id 5614622812f47-485e6dc0223mr972294b6e.35.1780036910692;
        Thu, 28 May 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id
 5614622812f47-485e6dc0223mr972266b6e.35.1780036910218; Thu, 28 May 2026
 23:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org> <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
 <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
In-Reply-To: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:41:39 -0700
X-Gm-Features: AVHnY4JOme_X08lKUfayqc49fxg4J4ab3o3Y14UzTjVjHMNZxrhWL7QV4gYwqO4
Message-ID: <CAH3zFs3eddZUtb08oNpjEg5b2=DJtRCuEcjsxuPyRA-zB2idag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: fengchengwen <fengchengwen@huawei.com>
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
X-Proofpoint-GUID: w0Zr50r4KqZP3l5TcQmNcmgui0uuysJ2
X-Authority-Analysis: v=2.4 cv=Yu8/gYYX c=1 sm=1 tr=0 ts=6a19352f cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=i0EeH86SAAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=zzBG9ipUb6nLY-ocZWUA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MiBTYWx0ZWRfX3SEV6D+NPhog
 yCrK4HC49jeK/11IO8vsWsVzdkM0hTMSVJLhFio17q/zL0sYBbdtAVEWxoH6PLKXdW/OH8/5fmk
 SBsgucXrZ+ZpfW5LVtEVzSk4xKCezZhydbpDIw2ghEY262TKZlW17jxIBXEqNPj9rfjKQvwMj+L
 8MPMa/qPxPBxvfwRG0/4kJ2/7/nMdViN2jrZrvwmGw7nNU9dNw5ToNo0/r/1oAc/TWUkWzyKkAn
 ZyPuY0KfExfS3ti+EWrm51VNthnfAMTSbTdp/A1eZg27raWjDZjXJcUM/1MLwSnM+ICtS7O+YQ9
 69oZsGvY45GYbke9nZe8dbkpXmvBnnRPgSjmUuyhKDXxz3fbLDSTZAcgOL4zyiqp+/FKDWnluDy
 vNnhuHe3Lv9FzPHbZOKT77nsCqm4v6GBwrJG2xPwk/E/JBfvTbO/f37WseYSFL11099kRB4EDtE
 WoXV+Z00SdGJ8A/7eBw==
X-Proofpoint-ORIG-GUID: w0Zr50r4KqZP3l5TcQmNcmgui0uuysJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01

On Thu, May 28, 2026 at 1:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >>>
> >> On Tue, 26 May 2026 07:43:53 -0700
> >> Zhiping Zhang <zhipingz@meta.com> wrote:
> >>
> >>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> >>> requester mode without reaching into pci_dev internals.
> >>>
> >>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides=
 a
> >>> !CONFIG_PCIE_TPH stub for callers.
> >>>
> >>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >>> ---
> >>>  drivers/pci/tph.c       | 12 ++++++++++++
> >>>  include/linux/pci-tph.h |  2 ++
> >>>  2 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> >>> index 91145e8d9d95..6c4492075ae9 100644
> >>> --- a/drivers/pci/tph.c
> >>> +++ b/drivers/pci/tph.c
> >>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pd=
ev)
> >>>  }
> >>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >>>
> >>> +/**
> >>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH reque=
ster type
> >>> + * @pdev: PCI device to query
> >>> + *
> >>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_=
EXT_TPH.
> >>> + */
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> >>> +{
> >>> +     return pdev->tph_req_type;
> >>> +}
> >>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> >>> +
> >>>  /*
> >>>   * Return the size of ST table. If ST table is not in TPH Requester =
Extended
> >>>   * Capability space, return 0. Otherwise return the ST Table Size + =
1.
> >>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> >>> index be68cd17f2f8..fe572737b409 100644
> >>> --- a/include/linux/pci-tph.h
> >>> +++ b/include/linux/pci-tph.h
> >>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >>>  #else
> >>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >>>                                       unsigned int index, u16 tag)
> >>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_de=
v *dev,
> >>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >>>  { return -EINVAL; }
> >>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { r=
eturn 0; }
> >>
> >> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> It need add #include <linux/pci.h> at beginning too, else it will counter=
 compile error like this:
>
>    In file included from drivers/vdpa/mlx5/core/mr.c:8:
>    In file included from include/linux/mlx5/qp.h:36:
>    In file included from include/linux/mlx5/device.h:37:
>    In file included from include/rdma/ib_verbs.h:46:
> >> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PC=
I_TPH_LOC_NONE'
>       48 | { return PCI_TPH_LOC_NONE; }
>          |          ^
>    1 error generated.
>

Great catch =E2=80=94 thanks for testing.  I will add
#include <linux/pci_regs.h> to pci-tph.h so the TPH macros
(PCI_TPH_REQ_*, PCI_TPH_LOC_*) are in scope wherever the header is
included.

Thanks,
Zhiping
