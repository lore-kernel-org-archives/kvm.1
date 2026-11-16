Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852205;
	b=lvJu63XaMYIo5su55PZzW7NhH34oM/J3O/AMXl+ZmEaFjXCfs93dHgvCDYNQFGI/nVMk
	 ZIDpa6Ffux5MuCPPVjaJafF393HC5xDt4NZuR+3PlR2oseJdpDCOyjjKZgpOlZOixyg3i
	 jxDTio63ebtkqh3Ablk2iPVQpDexsglnyhfGAAH0QxzWfa7pqYDLFcNA0FR3sia3aTbSE
	 pAIr6Ugkpjht5dgrVJanf7yQnJAM9LnppCxPBIaeRSYcYbbYmrgXkNPmARtxttCjUu0fQ
	 G/vYvraUsaKZVcTj5SN6s0fV5wRBv0i5I3CRsDNb6qXQxxkk5ykqMuzcT7goAaOhGIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
	b=fG4dGzNhQJhffXVb6Jk1ZFCcq4h+j4XyI8+St4TY8+QnJ2IcLhNCA9EWVAqmIujvzNDh
	 73vNiX2ccb9aflrM/cg/CZFIoT/r9/3oGt6Gs8C7xOb/bQK1IbcSEwz1jV0DvYHOp9cpO
	 RBH2MFY4YptoXKZn3iKBrsryN6pQ3Y71pFyvV6SAAb6930YGzlNPffeXc7fNWKXLBLvmQ
	 f9fzhCvc9q3XE4c+XpYvImJgU5pxIq+bOYlyBRTFjE1WoGvxMlvc9+u/tVOLLORCnRUgZ
	 yuY3wo9JgY+KlP3MWHJbc3ORB3F1NBLIgt615+SVuPngYgVSy5qVIyviPhQCUVYjOGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hD5jCwnG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D649606A322
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D649606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hD5jCwnG
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50a4a2132cso490873366b.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 10:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852203; cv=none;
        d=google.com; s=arc-20260327;
        b=VHXa65NVbfqL80SmrfJmCNnBx9f+iJybviIFOurB+DlE7NvAjX+OUrLxtHay1T9XSl
         f5IzwwbR7YiOHTMaKSB2PTpBA89JH8waioy3lg3JyzIU0b1LwEClrveBYCjDW2nlcrFJ
         Ox7DZf+7106huGkgmhjAslq/AalRR/CTwBQfNJj+UNfcro319W/ND7YE+Wlnn1eFipzo
         OVTpN/QQhDCGefaLI3Ml6XDmDRWG+zHJTkZPhKjEDt5h5pVQkKC5yFS0cCoZLd5MGtzG
         5HmitVB5/XLzU0JpjJr6JCd1FParpxWh9AkH/t2PqfPluihuuYXIjQQKrKekxipLapMh
         1e0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        fh=psaO2uhVSdaigmJJbp32sdrR2oziL5cStSjp6lwUMaM=;
        b=JL03y5dxtaGOOE16R0Ums0Uy382gK/5LplrTla5BKOn1Er9I5ZO1wc6g9vUA6FV1qt
         WpIkU0Ta0ZsARs1yPSW1Jx+rX38wPsSKIRHsUo/ey1veWvz+zCd0frav6H/SWR1kJtvs
         qjCZPrDAZ+E8eWQR1J9Uod6maPdRr8/mdRj4WJMlvP2JihMSPiyKdwZrKzIjopY+Te0I
         15/4HP834aiY+nW/ZbwLc9AT/lzWUcC2hgZ/Ksiu0I38Rbd+DQ3Hzo8NfwyKJudWMm0m
         YpMzSFLo0peWrL1v25JTVktIlTtaWogc7ohAw3NEkogLJDCP+8AOKdtL8NAHLZVQlDgu
         ao5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794852203; x=1795457003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=hD5jCwnGpTvZNYaAr2+aCoE6cb7zi0fesWLJtmKfjHp/JQ/kaIWWIrz6e09KboJAb1
         22Gj7G2b351eZKv4rCg7O3GyMG1MtGoWN6xg7EU2eQrnCKJD+f8uRHwt83vpvd9hqvPB
         j53rMQM4o3q7Rg1hd8Jp/uyfVa3Rs7TKp1FVmCxM7aw8dB5JXvPGM+7605iLxZWFOQVr
         Hzz/427CEAuvdW4FK5liL8c7JyBMf3Wp6j0Smxe/NQ/y2H4En7HwyLYAEmh4P9ItT+s3
         3VFwCqZ15r0ILkjB9apt8n5E5rVNDQGKIc+1yYF4pQP8Uw+CYIUALhII1lJTfuUwpnZm
         RlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852203; x=1795457003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=ArUeRuVwU2seeGbHHdcRo6+ga5C7cmrZUGzbIJQXds5kDEHDQ3m6wkCmW5OW6aZ9WR
         SUvt3+mFUww7bwJp4sR2iZ2yrEV2wjn3ChdpLTr2NQzijbTfqGXKmg9OU37OX7sBZSF1
         a1Q4Tl0G6gzGLHX7US/8XLkopGsO7K4VBkVHqtG3WDy5EWxMiBbsb6PGG+/NPA3aQRyo
         3vg4UQ6vQxCS47+Kp2IrEfqnI+WI/5Oz0GK+5VylKNfulPGLsoLj4qArc2st40BkMY2i
         +Q1bn1FDPqzLvtTXKuHsRLYRaznBQa7eSe47u9Z3rOvZCJJVF2+mSH84U+8Ah5xmrd0c
         RL2Q==
X-Forwarded-Encrypted: i=1; AL+hErEwiWnazIi5fWWdrmjJCTunFD2bq5jV7ysLHVGabEZqXtx3MTjSwCIB+MBYLmVPZmeskDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9954rC3uMVBWu9MyVWUq1u7grv2DCJAYgYpyavxAhi57Wdoxye
	W1FZp1LFPb7Id4lHy3dpNzr+nKGrKKEb6nFkGMbKv9XrfcNSYyWXTa5H/vqLN1ZjR7bItnfva0y
	jkHnnHGQWDox48Mxv5yJhB5ZWUagtnBTfoNHK4Yw3
X-Gm-Gg: AYBFou1NMHYL/TjaEsNHlGaoAve9BoMc/A7hEocvwjy/tSUz/djy2PmXSQZAr0fj/EU
	kNPIc8ejmAEjE1Rp5Ps8iRx6wyCpBuT8hoF/lPa/4IFVPCOTKEossbmGyuYBle4XwO2wzTI40bF
	9rQKgdKJ0xCcpjXXG41lI1EFmoT43+YGvJzMV0mMAMHbpfFPh+n1JyP4e0/c/Ut5KUwdJLtBSHi
	eR3vzN5yMf78F7EAW0SGMafZdOq6mvoKiRpOwMEUgH1z39JupFdTtet1aW9plrsiGywYgax37na
	rSW/nHhfBm3rWpZOVLyjGNvC+nQN7/AOeMCRzsinWjO/u7XiG47ph3D8eEKDJcX7zTdLq9YeyhQ
	D5GrCjcqJY3J1a5kfeNIuUaHpp7Vz0CCDRsNJa1Kn0bHGZ1BVhNiuljUvfPA=
X-Received: by 2002:a17:907:ea92:b0:c49:cdc8:10cf with SMTP id
 a640c23a62f3a-c50963df2ccmr868161066b.40.1794852203026; Mon, 16 Nov 2026
 10:03:23 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com> <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com> <20261115231946.GB1239159@nvidia.com>
In-Reply-To: <20261115231946.GB1239159@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 10:02:56 -0800
X-Gm-Features: AclHuK98Rk-099iLtslJwrWtAxHkQR-ncmpykOH17KTcOCuNGBfykDUUL8uCEbE
Message-ID: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> > > Hey David,
> > >
> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> > >
> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expec=
ted
> > >>     uAPI behavior?
>
> Yes. Even if we wanted to the locking is doesn't allow trying to do it
> automatically.
>
> > The way I designed the P2P selftest support requires 2 things:
> >
> >  (A) initiator: A device that has a VFIO selftests driver.
> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_=
bar()).
> >
> > So far I haven't found a single device that can do both. But you are
> > right that theoretically a single device could satisfy both
> > requirements.
>
> mlx5 can do both

Looks like GPUs and NVMe can do both as well.

How would we implement vfio_pci_find_mem_bar() for mlx5? BTW for the
target device, by "a memory BAR" I meant "a region of a memory BAR
that behaves like normal RAM". Sorry that was not clear.
