Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6A30F55B
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944137; cv=fail; b=PkArbG3X0sEWgUFXuIrGDgyLIXdzAZQLwxqA/YE38s+M2fFjBnxsTTrHFeQCAxurCcw1YKKQB66bwKh9cxE/WYqBVzBDeePKReBJDMWH931MuH8uB/hGVjVRwnMHlChagT+YtDMjGgTmYtJqVb6pc8OGs5bNO9dSgs5/cHUB7Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944137; c=relaxed/simple;
	bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO3bEtNoz6OmBqNGe9HNbYV3eatnpcYVjNMyIGKMw6XmdqmWOYYGUjaO7nBNypLz2zCldt4+qC1tFlgMtNPESXUhJ39LDuV6CXcch9iNTByImzZbx6IsBa1pMoJ5BOeVKbdS/wPsiZNb28X2bX4AuTcs5xQF5HYsTuCNF4NxgUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AIyX69k6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AIyX69k6"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKoIsu257316
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=; b=AIyX69k6A+c9
	mM1a5KjBZFSdIajJE7N6M+mQ7sGkngpIAcWIEq6pqulW9U5nSY+gI6sFNht86O+Z
	2D6jvDhopxPYZ1YE7naoN5Kloh1FC7xqcci30zbsC9zqOK5hXC7sYrpQFtCwvBAF
	CM6JDW47bs/SUBHJiMz/+G0F/SU/VgcW4J5HaITGfovQtixxblrvL48RNOE4hkl4
	QSltZkNb8/8gzsiQJteEhsP1K0aDt00kHUNwGqFqoNzF4bdIzG4nAfjSr3a8Np3W
	FHPEHYqrWlMwWuCKKAYylzQAXpY1Mcpxe88gvgN6QcAwDuFO547/X8h14sWFBIaG
	Xo82qWEcqw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee808t6h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcdeac07b1so5572565a34.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779944135; cv=none;
        d=google.com; s=arc-20240605;
        b=A49bbS5OKPi0zUnPVUC9H1fQa+M4kuyxag6lWgcEGA6bZgrVa/YIHQnvplOv4+E2oa
         7sNdfSTw0gjeDrTa+8sZqjBlq76PgoR051zmyyktX/BEKsVr8mdc0ku6JKAPL31ZpHlt
         fIuzX0HR6Ud7fwGYT5rnvShoNS/IBBCNyAeh1soqA6FulXBzqo8muqdZkAff88Spsz7F
         EMKlapjGaI3y0e4fTl3EtcfD7aiUgB3lOiK3/fq33gNgSvOrf+IEw/iaDDgMm0YcEEuo
         Rng+bh2wb/dxQ5Ng37sOKNwZRxneYZ5BpedDU6jRM8AzEBckyxhEDjXFHESaUpBLp6f5
         o5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        fh=syNQK1DfpInhOLC4bnJVh38yzhyB2oLH92LRIMLSAdc=;
        b=bMmmBdAd7rEZR+P+XtpuKYgXPVjTizaMVPmxGLBOEd+B4j/6+QcMnxRhCLQADhB3OV
         BcUb7NUmwGlg0YUv3PKLGUTgkXqD/VV2nrNyxDcb/KfvnDqbToc4jYsKcn86Hx/1eSuZ
         ccYz/TjmwzRtLSP2c5EvXR5pJJ9LeQ+g4iXcVX14o+zy9wT/OGMWaE2uK6Zv8Pe8xc1n
         9RS/yPwMZjNAf5dZJk2s/dfmebXnnOQX9/vS6SzoFt/bk/sBNfNOlVls4TYrSFgrRCwG
         d7LFHTelOm+OET+9FAzIyI2hyPcWzvNTr9ksxPbkCAW6eYz22Hhvd7UuMOAffHWt8az+
         8c1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779944135; x=1780548935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        b=h65DtfxEL37Pc/3FC9V03DQYTPGZERyDapiPGDXwT9R5z6Wdz87IriiuW9K4yqyJF2
         JpSIu4+jO+aujoE2RnORe1op3MlSoTDk+f9nY5FszuLdXRvkLuhDVNagvggCGC05VWGi
         SytRZyGYIH7SslVHHMrmmKjLoOCRTZsOoal8gA6hFDoft7xqrrm+Y3yWsP6PTGMoxJea
         uV6JBUII4fVZgBuFavTIBkp4dxz6X3F/YomJSWpb04OHBuhG7nHpN1hOWMTwBiWTY0P7
         wNApxTO9AlkjstZGMMLH3UWQX36q2BeH9/cSFl9V7IFL2atr0PN5Dig1kffE6t2w96pW
         71Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/X17bpMTQMH+zG+OKEVsvmon4NxisNNndS4oeR26vRBv9WE8OHMwZzX9dCHZk9Bsl7ppE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kAoJwDLrBU620BcbybAw9VDZYATbSOPutYsLFgmtW/9mTnaE
	llgGD2Zj5r9qCM1kjjUhwWS6Xj35/6+zLb7Sr7d+FamQhasvjtzQnckjf57t33wtM52e/G0vSqs
	PdiFDCmZcfFducCYFzAR2twFaJ/va60C277IhQSAIXXgXECQc4KL3tNh7yMiNKb0e8qvNc2w7b+
	0zQqsZkgFNVSVTagQfnvVmaUjWPzv6ZSlk0hjEIg==
X-Gm-Gg: Acq92OHw1/zCAU8o9Kx5T4Bv8S/6wQoc2KN7s+ViHLnC2sIOUN4mYZn7uk8Q8S/HKwr
	ug67yozTaSv7YcgsPCo6801bdenx8HdkQWkMj9O0jUpCYO5rULZyXGKRQ81uhzINCtp6atrT0+P
	zaxjadDMcjZhx5X4/F5+PnugMIfHzZyPPdoK1Tlrt7m8ZW/lprLYVLMAxE9zUsfOsiIcdh4hKIf
	CeyPWOJDRFVDlzW9SmhVw2J0VxlamyW8qLCMrXIMyHhExLuKSI=
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7e5fee23f0bmr17184406a34.17.1779944134689;
        Wed, 27 May 2026 21:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184388a34.17.1779944134274; Wed, 27 May 2026
 21:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
In-Reply-To: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 21:55:23 -0700
X-Gm-Features: AVHnY4KjB7ggvEym3yYxunms23zRrE8n2XXaWHSRU_rJj67WeYLMsK98_vs1TJk
Message-ID: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: d4t8ThdSRlm2idMzd8VfTv5EVFpYFjTp
X-Authority-Analysis: v=2.4 cv=UYZhjqSN c=1 sm=1 tr=0 ts=6a17cac7 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=zd2uoN0lAAAA:8 a=Vls0teBZlVDq3xJ5GeUA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0NSBTYWx0ZWRfX7I5JROQsR7FX
 DBHiEs//+JRhdjd5G3ChAvuvowUvUoYpb66VQhEdaqPnZok7qLP0Yr0pklx3DcnzavKhke0UgOe
 MsGSRu8V5pDPi5CnQhuFDalEa3+avQwjB3Tc5aW+jNlnWEdNIw0/AR6yUBikAz9csr5KpEvnwme
 HzI0yVanj6yfiE/J3Upoxt1omF7EVbg1Ws0ClLhgZrKqpcxCwC1YRDzdlFwPee7Z2gUVRXI3J3L
 DTT3Z68Tdh7yLKDPh4zXmAr80h1/8SVfABj+fm8Or49DlCnQq4PLZpYlS0EzNWHmozAi8NqaPND
 yYcOKFLsSAoRLDBWEQhSiFZhMBmwtRTOnDSVe+X2yI4dUJv5zzd/eFcDmu51LeVcQVAdu/cwIY3
 Kf1rhGdaNSlmziSEYqcleGVr4bjV/WndVK1I7FJTq3jt+6XeEc914dSZMCAE0Vvk57ZZHrh66ak
 OqbSgks7j9gAqOLU3WQ==
X-Proofpoint-GUID: d4t8ThdSRlm2idMzd8VfTv5EVFpYFjTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/27/26 14:36, Jason Gunthorpe wrote:
> > On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >
> >> Yeah that's a good point, I should probably rephrase the question.
> >>
> >> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>
> >> But my question is how is that useful to a PCIe endpoint? What is the =
effect of the ST here?
> >
> > TBH I've never heard Meta explain what their device is doing with
> > it. At least it seems to be super important to their device..
>
> Yeah I think at least a brief description of what is going on here would =
be necessary for the review.
>
> Otherwise we have only the info that the exporter wants to give an opaque=
 ST for the importer to use and no technical description what that is good =
for, how to test it etc...
>
> Regards,
> Christian.
>
> >
> > Jason
>

Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover letter=
 and the
patch's changelog as well.

The short version: in this series the vfio-pci device is the completer
of the P2P
writes and mlx5 is the requester. As Jason noted, ST semantics on the compl=
eter
are implementation-defined, so only the driver that owns the completer (her=
e,
vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
importer treats it as opaque and just places it on the TLP.

Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
 end-to-end P2P workload yields only expected results.

Thanks,
Zhiping
