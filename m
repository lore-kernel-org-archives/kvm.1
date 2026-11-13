Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589747;
	b=pPnNPK2t2ucrd/YqnjEO7AzckqWFyttRXZtEuo+JSTwNLFfu7qTuCXkElJ3NY7SNUEqI
	 N+sa26hNdjHOSi4dRipm/rjD+VXNM/hdIcKhDKNCxJ1xYiS2LqOaUOWZbQjdJ3Bzhf2A0
	 XeQcHKzggBLBrJOH+GvRykvXl1VFRY2g2j7B/PXfHsXc7Dwp66FoPBXbDUiHmPtAe0x+t
	 l71Ing5V/fwP3B82S2o5LzxboEKgBzYvqqAxRa3eLxkK1WDEPgqZ3Hgq/UD5CQPk/lPTf
	 10givLfMroO+tPeGsRMC32WcN9qIyqhR6AkSN1wpUJTP/oB5ZGFdIfIdHWx91A53Q4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zTGaV1UloT0Chf0ol30qq10ZNwEvfaESId1U8G45Gn0=;
	b=CdXW5bZegDF/jXFiFxosu6NY/DJNJIXqehJ7rRs2V9WsfYLKD6LF7+VYhcPxq4O+G/su
	 2gt5+nbqfEfg30BFsA+Ybx0r9UcsHLuy9yMab9WSD4fXNuhrWMFS9UOQjsAyo4y1pe/Cg
	 y2e38MRIunZhKwvI5I2cRc9qsqUZlPyln8kZ88IZjf4IVSqpabwRvVIP3hlg28zt8urVO
	 alQehbrS0zB2Lg1EabiYc3LhQCKpbE+IY/JJKknoPgkViR4Mpy8eRkbQmvYN1Ho/SyGgY
	 25qTRTtqXrzCMSfmO0JYCu1q3V4tC7BaNUT0Bb31ZPItlDasJEnOgWD/2c8oTlD5JFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYpt8qHU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704F606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1704F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYpt8qHU
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so981525d50.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589746; cv=none;
        d=google.com; s=arc-20260327;
        b=SmmbIekVkjYBi5HF43XCXdiMSLYVlaw9LVyX7K/+9/Ozj/akk2LK38qZC69ksUyDNt
         KsNhhHxX4cKDlc6b2P3ViXN4Oldc+GZMn41ndEghZjyIy1GHrhuF50ntIDoZ3TDwYJjb
         skE4isCJ3UbzPK/15NjMcKu+Pppi19ZKSwXQKf3BpYcMmNdSU3Pt9E7ROciOb34U0wPz
         61jFlfStSHEGFTYr+nLKVvGA2WsEBcluQf7qTTkn/ho8phpi3pL4DHiNLw5S5DILDYv+
         62a/pwK38sBCRjO5fYb2XR5IAc1L4f60NL4zB5QHuoDtJBfW0dr8hx1APFOXEQ5ctn1n
         uEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zTGaV1UloT0Chf0ol30qq10ZNwEvfaESId1U8G45Gn0=;
        fh=7GLsMAbjwctLn5T6vJj+2SQlTnfn1P1/Je2tOelQEEw=;
        b=SbLEc/u4yfHeg7wAb70GED1tcHI+0o8zqw5BSoNfyZvFY73QVPbaul5yrqWNW3JS17
         Z/06q+nVrkTaP0LvfFTbVBieTam4fAEKlaKkp9igsMjRXw8y04ZMZ/f6F5g8rGqSAmQZ
         yAiEy8GyI8i3NGZu/j+oxLFYL3TSTL2vFqA28W/v2hb1f0CBQ7sHv2wwIo17ahX1Xkh3
         xBUDdTXNh4P0/to5eD2GxDH1AOOFP9TZGOapl/5zlABMAWKJg/V/r8PbesT+TISvf570
         pCBxrrf6Kr78bZFidRAIKJOqMWnqSwB0q2CMuspBSatj9lh8tFY/IiWKivEqyOKjT37H
         MxOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589746; x=1795194546; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTGaV1UloT0Chf0ol30qq10ZNwEvfaESId1U8G45Gn0=;
        b=qYpt8qHU1s3hYs2EdjpWPeJcxzItZ/dHhSXtd8KhfZT3VZndoapqqo/OPSrbzOt0u5
         YA45CjpERrjrGn8LOk30kLgXGFHhxbKXm+0KJMvaOE5aq776n6/nsV9LuNgUcZOPzLP9
         Z6HJMWgs0iDKwIubCmVYdDf1dHLK+25mFG64ErQ3ErC6l3o2z3/7ihXV4XKJQ5pkd+3O
         xguj4lgkehPCVghW5LpqoZRB0z5nzLayOlxNzznfeFszFIuKZEv0SIKkzKBzEy7HkEsK
         C5AIM3YNskWJO+dHDT1aQa8TIfkWG+YmYlI8AR+konnAQY+T5yYgyfV1DKfXHoHlt3O6
         Z/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589746; x=1795194546;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zTGaV1UloT0Chf0ol30qq10ZNwEvfaESId1U8G45Gn0=;
        b=pdsgH0ZrXuUnS53E3xuGTwXhMI4Eex5ukn2BXeWTxvSDX/j0uXLocyWDn+HaZUay3A
         5/x7xnF3Axk2wCABssXe+RdvRz+2K760tl2Cn8tmq5U2KLXzcIurabnCX/gWSZgHthZX
         9rjCmkk4XoyFNBBTefvkAOGK7js1/3aezlmzLL6Z8tEc/NKFZnzRpVRdIl7jeJ6J1dpF
         63/d1AJL0Vheugulg/kVayrvB/l+T8Rz2smMoKhCVo6fGeRwqxS6Yefl/Y+4NGF6C4YQ
         simoN6OzrLtzLVgJ839hYp885uI4sm8gHtih7pzwCyW0f8gCzkM4x+m3bH4N2Kf4Q2JX
         tffg==
X-Forwarded-Encrypted: i=1; AL+hErGNn5D2JoHcRFygRVWrj6sOvJgqPoMymJxFHG/cAI27EFaPkCPk0orM36aOhUuT0szgIkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z810dCqxTQO/ZU5AhwibnTpcYUgzVJsxtEIQ2v17MgpGDbQXDqu
	BxjPjdMRotUihbdnDOZtyJrf6BRYT+5nbBJ/DmpMT0y4LH5csR7m9iJKbmpHPHn/ITUCyNUvVVn
	Z6hwksDJIwxFT2+mAMADw6meXsyZimFc=
X-Gm-Gg: AYBFou0NyHuP7ag/wxuKJ3atQiNaqPhUDovIuHRY3t4So09Zobzk/Ibvp0wH88GAc+Q
	h6sVp8YPYYdQyzhVlH/elR2GMgv4eOYdulPpn9mTUryWWrU5FbAaMkohuPvtIhrLpVq//IHGc0O
	le+5j0HNDie2GNAF1C2TUdShpzu4oqjlsa72GKPT3xLunrGZn+oUYH8+q9x0yFtSAKbh9CepDGT
	KeVMj/HLGFpCubCkAUznYqstCM/mUQNntZqm0M3NVwX/LGXpeQVD3w+k8Ov9NSeZeo33xPL3QYE
	gbtLnmMIVn0+QqqnQ6OSzzX+s6ech4C6TUkvu/i5EPo2TW8LPVD+Nz/u0x/TZixHvBK/CaHOl5Y
	4bVW1EED71PCHLfeHEibUDac+chTv76zf9i70k92taRQYNmtgAMrdgBrXEkmibLNPaG/+tr2Qr5
	whClhlRLxscjgUYhCjD9+WE/VK7qoLUYaBoBAeTEh9XM705+NC3kb+0aY9lf3gWJcBtY8emkRRa
	iUyEb6v
X-Received: by 2002:a05:690e:b83:b0:67c:1fc:2a49 with SMTP id
 956f58d0204a3-67d970207c9mr377453d50.54.1794589746003; Fri, 13 Nov 2026
 09:09:06 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023070110.1833446-1-fuad.tabba@linux.dev>
 <20261023070110.1833446-2-fuad.tabba@linux.dev> <86fqxwzul7.wl-maz@kernel.org>
 <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com>
 <86ecdgzp6m.wl-maz@kernel.org> <CA+EHjTy0jpY3sdVCENJRj_kfRDwbZ6TpkCAHQ2xUO-7ZuErpcA@mail.gmail.com>
 <ad724195-3452-495a-a50a-5e5c8093a483@app.fastmail.com> <CA+EHjTyLnAXanf9R7SuoL3gFZUNewX7QOnW=mc3qzwvaxg7jJg@mail.gmail.com>
 <040cf379-baba-4e3a-bf3d-6bc009a9e28d@app.fastmail.com> <20261112180741.17614-1-sidchintamaneni@gmail.com>
 <0a5e252e-1494-4b0f-a761-d984238c9d0d@app.fastmail.com>
In-Reply-To: <0a5e252e-1494-4b0f-a761-d984238c9d0d@app.fastmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 13 Nov 2026 09:08:54 -0800
X-Gm-Features: AclHuK_eSsuSs47N6QK3g2E7GgnMGVY8PMc7m7IxLZzX0JjkDZoYycjEKtYvyFw
Message-ID: <CAE5sdEjVx-eGz4hkN3bMMJAag_g0hm+J18G6JvFH814Z4_ZGaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, Navneet Singh <navneetsingh@microsoft.com>, 
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 03:31, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 12, 2026, at 19:07, Siddharth Chintamaneni wrote:
> > On Tue, Oct 27, 2026 at 02:48:29PM +0100, Arnd Bergmann wrote:
> >> On Sat, Oct 24, 2026, at 09:14, Fuad Tabba wrote:
> >> > On a host that runs at EL1 (nVHE or hVHE), this also requires
> >> > __init_el2_fgt to set nACCDATA_EL1 in HFGRTR_EL2 and HFGWTR_EL2, and
> >> > __init_el2_hcrx to set HCRX_EL2.EnAS0. Without them, the ACCDATA_EL1
> >> > access traps to EL2 and the hypervisor panics, and so does ST64BV0
> >> > once SCTLR_EL1.EnAS0 is set. Happy to write those and the KVM change
> >> > once you're ready to post this.
> >>
> >> Thanks for the offer, that part is definitely not my area.
> >
> > We are preparing to post the Microsoft Smart Data Accelerator (SDA) VF
> > dmaengine driver for Microsoft Cobalt SoCs, which uses IOMMU SVA with
> > direct EL0 ST64BV0 portal submissions carrying the process PASID in
> > ACCDATA_EL1.
> >
> > Now that Fuad's KVM guest FEAT_LS64_ACCDATA series is queued, are you
> > planning to post the host ST64BV0 SVA + EL2/KVM patches as a standalone
> > series soon?
>
> Yes, sorry for the delay on my side, I'll try to get it to you ASAP.
>
> For my understanding of your requirements:
>
> - Is that hardware using an SMMUv3 or a different type of IOMMU?

SMMUv3.


> - Do you have userspace calling ST64BV0 on the host, guest or possibly both?
>

We are focusing on guest VMs first, where guest userspace calls ST64BV0 on
the portal mmap'd by the guest VF driver (with bare-metal host follow later).

> > Either way, we have Cobalt hardware with FEAT_LS64_ACCDATA available and
> > would be happy to test your patches on silicon, or help put together and
> > carry any remaining pieces alongside our driver series if you prefer.
>
> Sounds good, thanks!
>
>     Arnd
