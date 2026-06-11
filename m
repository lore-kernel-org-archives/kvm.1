Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0338330B
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219379; cv=fail; b=JjGkAxdtSgmme5vR35Mv7IJwRVv7r3SzdGAMSb7XRkBtB6mNcFVTzZ8/NrMXZaq+a69i3lESEF1D2MuqfNokt9cBQ2dZdNdOimuQlHizTOQKqCx0E0FPqK+DngPuopnRJAPXzXqKh0J9jcIsl9wjUF6vLmvZMnhOHvo/sILMt4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219379; c=relaxed/simple;
	bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDIa1zl8pVts2jKbOz/847V3RODuOaCn4SmOzCfPRDPABNH646way2rx+a5HFy/XdOBTV4Z57zVVYJJoTWuWwR5OH3W9nXes80fghXB6JHsnS0sB4QXu/O5QfU5nFwJbBQGBNvaXaMQSMIlIV079fhGcUFCX0+uveBc848P6cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=USTVjs2G; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="USTVjs2G"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BLb39S185410
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=; b=USTVjs2GSY6c
	zWNomSf5E8qjahkAqgjmiQDPFbjEPZsjQeJ/b94zb0GF9NeM8mlmXX9Gk+kwYdrj
	cTftYVPuOSFB/1Nr+8gqaK6p3IfQ3KYjnHVtCfJwHBjSmm33QENUybqoFyJiQ/fu
	n4EJcipp1CqI7B0zNUDMYv+OiLaw5YrOS8y/AuI2CPHIovD+hq3X3/vXm3tTqiTy
	HHxPhprLBQNWDBST0hkTSIsZqY1y3fvMFa5eDd8O3gaW+GcwgHrjI92X6wE8vhNV
	AHzq3kcWmOiBGIroHAC2qW3JwOJCgC75sMNCqZsKh1VQyolLrORLN0mB76o4eHEv
	+bQz7LwmGQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78snn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b550a521so464542a34.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219376; cv=none;
        d=google.com; s=arc-20240605;
        b=ALUqyOO3spGf+1YxYkP4lMXbUJOTa8IFMkO591kfhrtzPIVgrIs+o/o8rCqy/QcEvm
         J062gg2fzXRhlpwhNpiwsc97y3MeFa0jhb6GJlbSd2yu45iNw8pKje/nbbFMHZfcRsta
         xpyfoxfTjYRIp9MFVJXKThy1mUmDqXmkpvVhE3ZnV4ZBZuNMa+7CKbnDEC4RWQ+MCRZA
         1VzR18qq6aKrpaTx9cjYXQVgWBVM8mYOvhGZMmmZQE6fyR+z9M6P5QnhSJmV4ePz2287
         SBcW9IBZvJRMi7MmES0iJlJYzLQb2Mrsi9sAbdqOqIF9dSjfkYvEFcNxyx3RtZ/6QiVG
         aP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        fh=IEyNMPPNISpXn+Ji4CEeMg1YIRPgO2SpPnvz5bEqyMc=;
        b=G1fnyeZRHhMxhHt7T4MpZ5yItYjqjut79eR0HRTvuBXDbO3dzSuMaIk7/Rgcv7YNbF
         m2cCTyjN5wlVdL9lGzv2N50X3xdQFbVj/o7F/GIp8G8RHQD+j8LRGgy8/fO42RFK9WUq
         84HPA12IHpcrthTKyB+vBWTiuMBG0AitKbDpMNbXUGnYdReb3AX2/LZ/CROsblr7JgC9
         sx0kYIbbFyHxzfd6W1AKHTeIdyX173m1VKVJalWAexh8XipOq9Y19Rt1pPAHZpJg8AWJ
         DEbbeH1IlEPtueP4QwbKz2p+Ev+tfh+CnzDUxkgpWjrjiSjLmi8WTeAmS8nh74f5ffqi
         kRow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219376; x=1781824176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        b=SUahAV7vmVDpb+t2esyrPUglc47/dL4nJ1ESEGEQRGkaKgl5GF4UHQCu8LlO1OrZMM
         Bu8vEBzrSvOp/qK6fk58jK1XNhycbNbrpHydGgzhcjYGIw/MBbw+G7oaHLiPHpymYEpX
         eOJEGzkbIUnfN8qcZP1b6a6jf//TDqFjBq104AeoYBs8gRcd55LYOBib6rEdYzjqSm00
         vAHo2SHyI7Q5RGx5nqXSXFBxMrnn9LtFroslCZyoY0kbxTtc9TofGeZic6vEIBgdrSlP
         I6n3rCOzA/gZovk9+QuSg1XQ2yJxSgrCMB+1UjdAeEwC/6zsPaeSUvE9Xi9UYDMyJtsr
         BfJA==
X-Forwarded-Encrypted: i=1; AFNElJ/dP4Bkh4K/LM8OlIiwETVqy4DBJ+hasEjS4VCyJJoDcEiPF0dXwRq39sMMLmNZ1X2asN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXnp12w3ZvOTwe7U/yXgRm569VlWzD8gAMBY/DEBxKMZTQWzc
	1lMwjHDxHwVPDYRsBP0ozv2Eua/ukdJKWVEoUok05edK255TMUIIMmZ3AQp1qBCq5+1lg1LILyM
	UrcmIL2IkictfmbbmCoOkRm7B8ssMWmBq9I32quWEg9/5tCaO/oixGC5x1LRI3nvG7/3IZoX8lN
	hoytR/ATn7qvvfjl/auGXSXOa3o0I=
X-Gm-Gg: Acq92OGHTYnXgqQoWODeVlZa1byfFzQiY36X3gjqiocoLmfY7hz6PkEcKat/9oALGxH
	y/40o6wJUvHZn5p9CCeKY3kal3MzuxFG0nVdWXdqhQs1+9RLrPMjt9/SiOjP2Qy9nvrBkgZZ1wr
	cfwONZwlGP+Ib9K33EecUAY6KeGrR4q3KCM/ram6iXtfkmYJHHk7+Hu4NDKzzvvU8BeCYwgkHGo
	ezCWAnGdyyXvcFkjldSCw==
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e78473ec89mr120376a34.16.1781219376583;
        Thu, 11 Jun 2026 16:09:36 -0700 (PDT)
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120344a34.16.1781219376083; Thu, 11 Jun 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-6-zhipingz@meta.com>
 <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
In-Reply-To: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:09:25 -0700
X-Gm-Features: AVVi8CeB8nmACAn2v-1nCwadZsgAxPl-ide5TeaDE88hJZn8TEKcdfaG5LmdPSE
Message-ID: <CAH3zFs3ngOXvA5DRzur-_gQ2e0N+-3Az2KmwxZTYczqw34n_Xw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX4TKpFT54aRYz
 3YyKMDR6sGqPOhsG6NS+tJ/sId0rK877M/SAalwTsT9fujp2k7NldcFGFKZh+iLqkH+ZID3poj4
 UOPAbmQKmPsu7x5xJFiuExjM8d+Mfsmh0pkeTfoSWjb5BfB36ffiqVES1o1J/nYN2vxzvm/uVSq
 hYPZZ8mpRr+l74rnGMDgeG9qcG07cGbbUIAjMX07ciX5g6Jfn8ceaOv+JOF0kqaLFMvVrYACIMk
 b5DlOiXQee5UThPAoeNiyUzO0N3HThGTWLVV9gBAiaTYVwWlibuwD1ytgYDmxYM6EUciD9Teob6
 wK+8j7zygblIO0oOf63sZeQl3vAze2mM8CxFXriTs51aQuOqlxeZk6v9Qh5fH4PNBydI1pC7KYt
 g9C93j5jHX4689Dhzq9uDZDHvNItIPNen0pAFnk5tK7QM5lq4U7+4qxb4ubC3Mn4PPY6SNDp1ow
 AYpxybBZu1RC0DbjrEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX9a+K0hzgWptK
 vcSbHnyXHPnhc0AtQlfDIx+glJBqsv2UFyhN3HmCF2HTZRL4oD6pPayfgtAg+1h5qV4FI82Xstv
 l8YNoRG8+HtS27sFURlBXJJOOg5J58I=
X-Proofpoint-ORIG-GUID: hmDqbkAGeuEyQcwoxIhjXnM3lrdIRLcg
X-Proofpoint-GUID: hmDqbkAGeuEyQcwoxIhjXnM3lrdIRLcg
X-Authority-Analysis: v=2.4 cv=ZaAt8MVA c=1 sm=1 tr=0 ts=6a2b4031 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=Ikd4Dj_1AAAA:8 a=G2Tmg7Ww-o-apaxFWtcA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 5:44=E2=80=AFAM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access to a PCIe endpoint and use it to program requester-side TPH
> > on the outbound mkey. If the exporter has no metadata, fall back to the
> > existing no-TPH path.
> >
> > For TPH-backed FRMRs, make the extra ST-table reference belong to the
> > hardware mkey handle rather than the transient MR object. Extend the
> > FRMR pool API so reuse and final destroy can transfer and drop that ref
> > at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> > a ref on an already-known ST index.
> I'd keep the ST reference tied to MRs, where the ST is actually in use.
> There's no functional need to couple ST refcounting to mkey lifetime.
> Once an MR is destroyed and its mkey revoked, the mkey can no longer
> generate traffic, it's just an idle entry in the FRMR pool waiting to be
> aged out or reused.
> This lets us drop all FRMR pool changes from this patch and keep a
> simple flow of 'acquire on MR create, release on MR destroy'.
> > Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> > the requester hint matches the pool key.
> I've fixed that in a series I've sent earlier this week, please rebase
> next version on top of it.
>
> Thanks,
> Michael

ack, thanks!
