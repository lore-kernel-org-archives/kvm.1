Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C2446C00
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051359; cv=none; b=J4gfK+AD6OVUuVWa94UZRkWS4zq5iGwTpp/JQyhY/SrwQjdaCS4m7hHQG/9d7GeBdox6mPSv7Ou2xapgJAolxPA9zbhCP5zcJZz+oLF0CY/0d6tv4OKeO9M61wcyMCtOtDE88XLakdLcS+Ufi/gVyY5ch4dLJVCztKg+9bcf+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051359; c=relaxed/simple;
	bh=1p6nZ20jw4LUTgx/Y5mwhRhU4CxUnUa0MQ66rPqdx6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmgvLa00xhvOYX2hmPPb0dI7wVUKjou39RcaB8etnj2GCaZe0w1Av37D+w0Pq2JaTDBPTFmYc/DxxRryWN2MEMxVDHfSzyj5hYQj0qhi52vD93vg/RMQAOZn7RPNGXpfAi1/yC6H70SsUhZXlfv5TC8Chdue429bxFq2lr1PFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtm5OsuU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtm5OsuU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so43361985e9.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051355; x=1787656155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1p6nZ20jw4LUTgx/Y5mwhRhU4CxUnUa0MQ66rPqdx6M=;
        b=rtm5OsuU5Yz5il1gpxTqZl4bkbsLHlDSA2cZ7XGucWQLXuM6BEU+gFGzpAO9f2dqmt
         4IlO1lOidhY0hUDDr2Srdji2EmZ2hmT32m+S+ei6N8iih64JDrGu9hj+7o3C4NOxItLH
         Z8NozMDslSfVclk3H4Bq0UBTCikrEDMc5HRqBu8MsdLYsIhAndzTVsyPjPFZbBifw7QY
         lgQ7E4AtO/znY6wCljlySQuHI57LFgctsARDbxBdyGU1OQD7VUUnDfc3kP+Lmq05SH5Z
         M6bA2+rY+3/PU8S8HRorx/NuTmk5Ya+3CC0HP1KTZeqTtthfVtD9hrXAcFs0TZmeyuCh
         yyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051355; x=1787656155;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1p6nZ20jw4LUTgx/Y5mwhRhU4CxUnUa0MQ66rPqdx6M=;
        b=NuRe/AS6oZUr6t0UM7wCaA5rT0hUklNDCnTjfeOnPDHOS8TRkErVmRgofINKZVS9G8
         3Tmdabv7kZNDzcXiYwGtvoxtTiPRNT81KnzolIZgHC8MuUJfYSWVX1FXLBtF3zgi4xBU
         GVn9PEwCQ1RZX1y301tRYZAldkneraYqJ0OhRbvak5nnbFszMA2AxdbgtbPqoUPp8ACi
         Svol6g5+8CFGLzY1kHkxk3bIZEyPJYaBQx4mNjte2FQi8qzrX+S1iUMBHFvIMP/sbIyY
         T2hLV60RIeZtt3/30cfTTI6fA3TPe1mjuJW/MZdmg/RnYL9OSCu27lH8pi0EkS3/8Le6
         dAmg==
X-Forwarded-Encrypted: i=1; AHgh+RrRi31lZq5V24caH1kPFIkES92PM5RV58iEryMRRLU+c1JHUUXJ6IqgmRRYRqbx5+qjxZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+WTmLEdgHaiRUFtjRthwVDc/hZIHsJSqnuin+3lD8ge74Yv+
	TK47hi+YDDn2Hn4idoPdQMOu0xzm+1rx5bTKXVPj6K9h0j7JryIv1I7S
X-Gm-Gg: AR+sD10uA1s5zE+FJUrCfxO2bZIl4e8ysil/bGtNo43xwPobRxiyx2wfWCGV4W6sj7p
	3Fqgi5TxvBCfgXTO5zOx/vogaxl2kiFPr4Gxx0etpOdvf2W3bmObavwQqQ06cQihSMrZAlwHxJr
	1rm3fGWBWIhXQbhJfBfauPFL15EGxkWDfRK90EZOpbq4kVLyuptS2LK7vc84pPVFK7t4Q1MLxCQ
	1rbujk5OZYTnMA1vtNVQYchKSl0ZaxUb+rDluaQ/peKoAM4vQMSIvFRMHKQmEy1nxosKPDazoXW
	cygL6uiLuZ3b0bDZBfbKNpw/Ean7CJbEsZXz08k6m30pOUBDyOGHXRbOFqAbiLSzfynt8p58+pO
	bkQl8PqLoj+r02/g1ESrW1hNeG8g6dNNtbWofnvdHE1KdL7BA/bjhauDJeRf2Kr2qbFkrs3k+vy
	aIY0JI1V2/51rDtoGYuDWGjQtSeQ7VdeqgyH8OEt+8i6UT1uOVE/UUhYQfkiTSH3c=
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr507923515e9.14.1787051355348;
        Tue, 18 Aug 2026 04:09:15 -0700 (PDT)
Received: from [10.245.245.215] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996109652sm301473815e9.4.2026.08.18.04.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:09:14 -0700 (PDT)
Message-ID: <83968006d6ee498621978d81a02659bb6186a0b9.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	 <seanjc@google.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, 
 "x86@kernel.org"	 <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
 "binbin.wu@linux.intel.com"	 <binbin.wu@linux.intel.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>,  "sathyanarayanan.kuppuswamy@linux.intel.com"	
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "dave.hansen@linux.intel.com"	 <dave.hansen@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,  "kvm@vger.kernel.org"	
 <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>,  "mingo@redhat.com"	 <mingo@redhat.com>,
 "Fang, Peter" <peter.fang@intel.com>
Date: Tue, 18 Aug 2026 14:09:11 +0300
In-Reply-To: <0b5a26492f367f793aab38e4a0d9d6f398340f51.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
		 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
		 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
		 <anxvwV_Pz4UYaxxt@google.com>
		 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
		 <anyiwqi9i0NSv0QW@google.com>
		 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
		 <20260812223707.GD1013044@pedri>
		 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
		 <anz9b6CDkhr5D5RG@google.com>
		 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
		 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
		 <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
		 <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
		 <21ffbb7b80c0c654c23a97cda55f43c73e49ba25.camel@intel.com>
		 <498af8d6a5de3ee05e0216ea075c0eebf88c7072.camel@gmail.com>
	 <0b5a26492f367f793aab38e4a0d9d6f398340f51.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-17 at 17:26 +0000, Edgecombe, Rick P wrote:
> > I am curious if today this is an attestation-only problem or a pattern.
> > I mean this "many TDs compete for a shared TDX capability, VMM needs to
> > be involved to handle fairness".
> >=20
>=20
> Yea, I think it is a really good question. This is getting off topic now,=
 but...
>=20
> There is an existing issue we have with the "host priority" (HP) bit. Thi=
s is a
> part of the TDX arch that is designed to help with guest host contention.=
 For
> example a TDG call like ACCEPT can take an S-EPT lock that the host wants=
 to
> also take with a TDH call. It is sort of important to have the host be in
> ultimate control. So the way the HP bit works is, if the host meets conte=
ntion,
> it sets the HP bit. The bit means if the guest tries to take the lock aga=
in, it
> is blocked without letting the lock get taken. This gives the host a chan=
ce to
> retry and succeed. After the host succeeds in taking the lock, the HP bit=
 is
> cleared. This is like a crude fairness thing.

Thanks. Yes, sounds crude, and it does not look like it covers
fairness across TDs. It only covers the "VMM has priority" part.

> But it all depends on the host retrying. If the host never retries becaus=
e
> userspace intervenes, then the guest stays locked out. We actually hit th=
is
> condition in the tdx mmu stress selftest. So it is on the to-do list to f=
ix in
> TDX arch.

I see, the VMM not making progress blocks TDs which could make
progress=C2=A0otherwise. Thanks for the info.

TDX specs describe the HP_LOCK_TIMEOUT per-TD property (set by the host
via TDH.MNG.WR), which could be used to somewhat make the symptom
somewhat controllable, may be make pain less painful, but it is not a
cure for the illness.

> Now how this connects to the 1-flow vs 2-flow design... As we have been
> discussing this quote/report stuff, I wondered if we couldn't solve the H=
P bit
> problems with a similar 2-flow thing. For example a TDG.ACCEPT call could=
 exit
> to the host without taking any locks and providing some kind of token, th=
at a
> paired TDH call could be used to complete the accept (and take the locks)=
. TDH
> calls should not be able to accept guest memory arbitrarily, so there nee=
ds to
> be some kind of security validation on the TDH call. But then the host co=
uld
> control all the scheduling/priority stuff. The overall solution would be =
better
> for having this locking balancing stuff done in a single place where ther=
e are
> no odd overlaps. But it means we also have extra host code for every TDG =
call
> that takes a problematic lock. Probably more TDX module complexity too.

Yeah. We have TDG.VP.VMCALL as an "exit to the VMM and let it handle
stuff" capability.=C2=A0

So essentially you are pointing out that one of the=C2=A0approaches is
turning a problematic

TDCALL[TDG.ABRA.CADABRA]

into a

TDCALL[TDG.VP.VMCALL]<AbraCadabra>.

I guess this approach could be used in few selected cases.

Thanks!
