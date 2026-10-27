Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114256;
	b=iHg3gIMZcW8Q0OJsZaBJ/8q4i/llpDvcP1blyHctTxSKGeJq2/xwLRZNvQ3dJ6wl3L/w
	 h+chTGuAbF2ewbigX/3upHg2UciO2Aax/F3TgCGsyiAHNqWO7LLIwt5sFmWdXZd6Bz2dy
	 Y0sLmE0AVkrp+ymniTrDHJUqdDhPEklQU5z2K1oPbEViau5rwo/Y5G05bHCjXrV9CUNmu
	 1UlXI9kt28DGBVXBEK5oUv5n0Hb+U9i+K0qVvDblhRhRE4fOgpGt516iIrNkKo/7K8bxa
	 Nr5nnevmBfv3UWvcBokyOZIHi0wTqYTUYzAQn6XQYOAphzkdf309kc6KBv/LRcEoFtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U4Ud7qq2I83GZDTdN1xiR67Ms11VsCn4buA6mqvOa9c=;
	b=LwErnrdjrAvxoqCoRis3fGuHTd7uCVNIR2kPW8fbABQ+KJziENzJsFWsyKcE6071CPT0
	 PWHBcg/PzpJvdAF2JAa3Ca+IG6j4KixhOQkhtrFpPXyvXDN00Qn5wGYY6HMgPf8SKS12t
	 kwZ7lv8Wj4swSec/smOpKlxWfz8/GxOTWKSKwh02stw8eCtNwl+8E7pF0WZWdzaq07ne0
	 +HVvNp2eu/OpxhRedb44KajFnuKYD/2jJLYMw3NmaA/miJAcslZLtFnnXoc8EdAezJD6V
	 tFcBfTFx8eTFvn4ctJp7NEblUmprApMKll/eer/kXUNxjwijnPHKveZ2DrwvUbP59rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U1iZ1xcI;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AB606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4AB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U1iZ1xcI
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c7a0c1617so194036d6.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793114254; x=1793719054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4Ud7qq2I83GZDTdN1xiR67Ms11VsCn4buA6mqvOa9c=;
        b=U1iZ1xcIf2hwIIOOPzvu5+3f09OLBYFlaWg95+yayNLvnC0/CP4TAjRhcqtpvXTd0t
         CA9I4Qu2DQg94szEzY0/jUH1zGh1rz42/wZ788zBQrIV/+RWinv1iWjnNl+y4kBE5ZS3
         y/Ki19lyLJO1nBHR1WIB2DnTEfcGTEEi85QIJfGTKhq4g6Z88bHiC7THxR3ARfvpxhTr
         Pic1Qs2yGJ/Q1nLcIuSGiQrAGuzp7gM2jlppig8T8Gbe/y501Lck3L0DNHUOTDycYoeh
         VNyvrin1iqtYmuH7R5QmANxalIiZaq1HW75IiG8cDacUp51JEx1Q/MmIjXoLwAe0gBTE
         eopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114254; x=1793719054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4Ud7qq2I83GZDTdN1xiR67Ms11VsCn4buA6mqvOa9c=;
        b=CvdWC/kzj5v9m0gR5NSqUquU+ibJ5H+bBiml4tD4VtcW64/yKZGJdY9M5d2hxr2pmr
         tEH7MMXkiYU4VGJ5T15Zf4TARsF7JHsrfl5U9yLck3cspUPQ0V1ZPj/2tWpXb/8tB1AM
         7WNLgiGpH+Hhrx1xLoSd3/kNkj4waSAzW9K7EpvdzO0t+GVRIS/JadF68Fsh9PW+s0HN
         Jv414uCPjjd1r53QzJjobgnID22iDJKbME9ceNBqDCZZtOee+XoYq1T+vkVbkVN98l0I
         e6xMiKnagfq8/DexJbmMztmMXsD/P+Hl8JWVSGk5drel1EItqywdo/vX1QKlQOeXIAtm
         0eaQ==
X-Forwarded-Encrypted: i=1; AKwUvByKTxSW8FBp4YexNs4GOtc1/h1HS1CsfZpWeJttto/edvPUhE+J61lsOTSGmCUAesnQ7i4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0EmdqgGf0+ZFCNUqDXaUxOTwfBaUZw4My5YVclx6LMvCFNW/3
	0TfrptvfJ8vSUfDnw6TczzxvMiaLCqfwDSCUW0XWc7VXgv3603pXTZ8lT2kqu36p8OSlArWEVKp
	jx551
X-Gm-Gg: AYBFou2Ija8jJzNdupxfNzBFMS0dThPpx0+dDxACJkl9XZ7kBs5fVBPvlBtx3VdMfB/
	GWznpoCjmwwJEo50F1auA12jWEz8ndY1zO8341oQmNS+24/iGBzrJ/tVte0OS4+iIvIMjbkz81f
	8//GTheGYHv2WXoBzNphoEedRfbX7DX+ke1/R/9O1Yk4nhlDWspk9xEJTUq7VbN7QG2uuElkHur
	a/gQ4rqEffqwDH103ThGRAI83EXbuje8I16XWQxy44OP9pYF1OKYpm2VLF9IJWr3/EwmDx5ivPz
	lkdFRgKkoYR+VjEQFY6jV0pyYsZMdDLzODtYp61E8HuhsVOgckVDbXC6doyrnPOiuEPIPvjEi6y
	hSDg8R4fS/nxieYDY5l/v9sST7YQ/4bwMB+g9iFo4MvGp+WxfSh7xOVoWsscELFP/BmeIfwkR5Z
	V9Ebril2Fmaz+ErJZpBYKG6IEekT/s99FI69o07pCqc5xm2+0Tt6cP7NDQJX1JhgynNYxLLRUlT
	PUmjK7IQDCYB+wnuT3I2cA0DZgG3w+pswXi5UAx73lJvCv8D/Ir9auOMM0hC1V+WZczha1y82c7
	KI5thJD2R14MMZw+SgoFdsmYt44GnkTGDiWiBw==
X-Received: by 2002:a05:6214:f2b:b0:91c:7246:2d4a with SMTP id 6a1803df08f44-91c72462e58mr34928326d6.35.1793114254057;
        Tue, 27 Oct 2026 08:17:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm105565826d6.33.2026.10.27.08.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:17:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLivZ-0000000ADMO-20dz;
	Tue, 27 Oct 2026 12:17:29 -0300
Date: Tue, 27 Oct 2026 12:17:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 02/20] ctlv: Add the UAPI wire format and family API
Message-ID: <20261027151729.GG1685504@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-3-jiri@resnulli.us>
 <at-iEMxN98nie1Qr@e129823.arm.com>
 <auBaROC0XdWpILEI@FV6GYCPJ69>
 <20261027141524.GF1685504@ziepe.ca>
 <auC5sw9YMC9NO4wl@e129823.arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auC5sw9YMC9NO4wl@e129823.arm.com>

On Tue, Oct 27, 2026 at 02:48:19PM +0000, Yeoreum Yun wrote:
> > On Tue, Oct 27, 2026 at 09:02:14AM +0100, Jiri Pirko wrote:
> > > Mon, Oct 26, 2026 at 07:55:12PM +0100, yeoreum.yun@arm.com wrote:
> > > >[    3.856919]  ctlv_schema_check_attr+0x3dc/0x538
> > > >[    3.857105]  ctlv_schema_check_indexed_nest+0x788/0x958
> > > >[    3.857301]  ctlv_schema_validate+0x88/0x180
> > > >[    3.857482]  ctlv_msg_test_as_deep_as_the_core_allows+0x11c/0x1e8
> > > >[    3.857698]  kunit_try_run_case+0x64/0x188
> > > >[    3.857878]  kunit_generic_run_threadfn_adapter+0x30/0x68
> > > >[    3.858086]  kthread+0x10c/0x140
> > > >[    3.858245]  ret_from_fork+0x10/0x20
> > > >[    3.858398] SMP: stopping secondary CPUs
> > > >[    3.858630] Kernel Offset: disabled
> > > >[    3.858720] CPU features: 0x0,00000000,00b0802e,9f190bc3,2affe72f
> > > >[    3.858872] Memory Limit: none
> > > >[    3.858976] ---[ end Kernel panic - not syncing: kernel stack overflow ]---
> > > >
> > > >[...]
> > > >
> > > >I think it might be good to configurable according to architecture
> > > >unless it's not good to reduce the CTLV_MAX_NEST_DEPTH number
> > > >otherwise, increasing stack size when CTLV is enabled seems unresonable...
> > > 
> > > Agreed, will lower it down. I think we should be okay with 8 for start.
> > 
> > I'm surprised this ran out of stack though with even as few as
> > 32 levels.. Is there accidently something large on the stack?
> >
> 
> Nope.
> 
> When I see the each functions stack allocation:
> - ctlv_schema_check_indexed_nest():
> 	sub	sp, sp, #0xf0 // 240 bytes
> 
> - ctlv_schema_check_attr():
> 	sub	sp, sp, #0xb0 // 176 bytes
> 
> Roughly (240 + 176) * CTLV_MAX_NEST_DEPTH = 13,952 (around 14KB)
> consumed.

400 bytes per nest seems pretty big to me...

Do you have debug options enabled or something that increases stack usage?

Jason
