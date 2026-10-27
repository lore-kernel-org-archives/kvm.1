Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110528;
	b=0qx8ZNV2aYU3uHUcxLyJ0KrqoHEU6WCQQGm5fRz8WBC//Jk8lJjQpDH6sphOoYRkCylA
	 DpWA/mqisvmLlxblwgYm1wpyZyKBkkr6/+I+YpSmrIXJFDjzJVZ9RKFO6EUGTjemG0/Zh
	 m5U5HFc/X9JYeAQdzaqbNVEAvSGLRH/sFeEINN9+a/WL9mFtFyvXLYEQD/epcBCZTG95D
	 Xwkif29AUxmdqqClNDn6Ckt/kAH89sJD6MqE/1xhj0l2eq82qr2eT6ALIO+c5Fuz8HCpY
	 Uv+Ca+ImvV82PeP7mMSYUqo0iThdfZ2/3KbSS5fopZzuhdmaJWLIYUy6eJJLO58d4Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zUsMbjO3gCQtUvLruyRuDb07/mulBS+KPR/B4sl8JQg=;
	b=zL1+2QgGanfxkcYJzpC/mSxTnRvqJ9JLvKuOAoRMG0T44kBnzrXOqSMHLHG6st5wdcET
	 rQncGQk3EF5XVyYtur/yTv84N3O8QTtEFRo2ZrmywNXkJLupHQsq9dKPrpe/sfmF4fwXx
	 7lLD5Bz3YFFAzyYmAKfFAp1a2evCZmtVoUQNa2uW6V0znmFlUkat9zkFexoAchk9fETag
	 qLg8fPNKvqG/tOaO9/nulDLaYYEMz+qdDf5dW/4wOX0g0+v+eRIeDfnS2MQqB9KOIbX85
	 vM1JitrtEZMdb6jUMRk6YmzdkQE4xS5pVh3OG3alcVFpnEE2oSVcALNdjvMHbXQBS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Be4xWtvF;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1E606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C1E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Be4xWtvF
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f20b304c0so398736685a.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793110526; x=1793715326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUsMbjO3gCQtUvLruyRuDb07/mulBS+KPR/B4sl8JQg=;
        b=Be4xWtvF6zD3vHFfarAJm9xvRSujoQ4ZcjWYGMVUL72IZdQIrglRXya7nu1BUbTDL4
         JU5H5uRGbpfBgIl70sNPb7M5LjoH0JVWDiWYrd5p4dA1OYCaMa+eIU/FSQPzPq322pXW
         3BIOxxgck38BNY71yNhw4SSAeSgx6JinXx3Zn9yaso3wr//ChfahhDpgNLVyEjzAUE4O
         dAZ29PJibsBSyXgYh9LfzzRTLPKUcXDHhi6ZnUGansAH2HGrRy8Pnu4yfMUh815lcwdA
         ly/eGdf5n5xPlK639WdhZJDZBQmI4py6CAaKCrpKXNlKtynHB1yPt8pqrUeP1VSUuNAQ
         Z3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110526; x=1793715326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUsMbjO3gCQtUvLruyRuDb07/mulBS+KPR/B4sl8JQg=;
        b=Ft9tjZBKT2ymLf2XlHz5saV8WEHWXEKOBn0lCAQnuRsi2Nl0rJv7hRrHADgGqUd/lq
         ljjBXD2R/88PPcry6hU7yuu9w2SeBUZn9ypoUxQVdNR9nMqHoSRdNaqOestI3GZ207XP
         tt8mTabKXA304JNjnR0nxmeBLBmrEH4XQ5tkmeP8hKh4i83XNGYl4Os+cXWroy1fsHmK
         0rSlKo2egQInpw5ghyn1wcBa/Ebin4ODzcXYPNBxSzqF738PssW9lB3uFKtr9XtXhGS/
         u7+rXJq3swrIja73IC8i+BMq28MRDZf2k+Ar6FLJs2pTkV7to3tD533zVr2lNDOadVre
         DX3g==
X-Forwarded-Encrypted: i=1; AKwUvBxqeCcma1rJ/DqbzrEbfhC1bV2oFYTe/fa2VQpIbPK0abivlnmnHMLv7P/5Al7o1pbW32Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtuTPi+s/0A1Xdju+Hb87HaxXbsSmB9wILRILXrNXp3HuRk8Gn
	swbxkktzBEp0K1fMBr9t0EteO5c/3RWK0ZCksIMcJuvlfqZGRdmVRtBnv0e9XaxN3KU=
X-Gm-Gg: AYBFou3vDXZCZLdcEt3Uzn0L2rtiWjT0PG/TsfCYSdBuVHlx8mbVXSllCV+hrAWeAmd
	9My7VHmY36ep/F6Y1d3dfcYJk7Sfg3Ag9VdV7Q6IPvOPNzDaMBBP8yfybZdWa1Z5/ZVSISxHvMy
	chSaW5ovFf0S7JyVu4QJUl/nOhPQi33Bpq4V1i+9me+b0LED1L6wyokqpEvd5vP2lA2mol7CIlL
	SxBvVY/5E3Y80l8afZVCgsSnwY9wRLDKBTHWUoJGcw05TaIa0BubLNW+NfJqzqLB3FKyFrZJw/X
	f86OOJ+pxGAfaC+6nJR0Qp+qeSvFqOh9iyC3EsMjBABshJHwuhRuSPbFFEDh8IXLreVnOEYE2ht
	2bEby26q/1OrC+bIHqWnW+S1ga487PRyx+Ods1T5jAc9EIU4v6yHjeeo9X+/IMSCoCMagaT+Cjm
	9HE93BTI7NITErbj13+/CBTm65KASEIE4lOQ4m1vbiMkLyGGmZYMlcZpe8QhHUlGMUsB+wmUNuZ
	OSxncE1fyuHaUUCC4NBeJO03JN254BjrZS68gtDdE6htcLOmeJI2NXS/zrr2oWdCxmzMDhgbvZu
	siunCk8wn60wVC5mi+MrIViIPt4TNTZCLo+Egw==
X-Received: by 2002:a05:620a:261e:b0:93f:d27:c89e with SMTP id af79cd13be357-940ef9d6997mr1602321285a.75.1793110526435;
        Tue, 27 Oct 2026 07:15:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787d96sm982932985a.28.2026.10.27.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:15:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLhxU-00000009zYJ-422J;
	Tue, 27 Oct 2026 11:15:24 -0300
Date: Tue, 27 Oct 2026 11:15:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev,
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
Message-ID: <20261027141524.GF1685504@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-3-jiri@resnulli.us>
 <at-iEMxN98nie1Qr@e129823.arm.com>
 <auBaROC0XdWpILEI@FV6GYCPJ69>
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
In-Reply-To: <auBaROC0XdWpILEI@FV6GYCPJ69>

On Tue, Oct 27, 2026 at 09:02:14AM +0100, Jiri Pirko wrote:
> Mon, Oct 26, 2026 at 07:55:12PM +0100, yeoreum.yun@arm.com wrote:
> >[    3.856919]  ctlv_schema_check_attr+0x3dc/0x538
> >[    3.857105]  ctlv_schema_check_indexed_nest+0x788/0x958
> >[    3.857301]  ctlv_schema_validate+0x88/0x180
> >[    3.857482]  ctlv_msg_test_as_deep_as_the_core_allows+0x11c/0x1e8
> >[    3.857698]  kunit_try_run_case+0x64/0x188
> >[    3.857878]  kunit_generic_run_threadfn_adapter+0x30/0x68
> >[    3.858086]  kthread+0x10c/0x140
> >[    3.858245]  ret_from_fork+0x10/0x20
> >[    3.858398] SMP: stopping secondary CPUs
> >[    3.858630] Kernel Offset: disabled
> >[    3.858720] CPU features: 0x0,00000000,00b0802e,9f190bc3,2affe72f
> >[    3.858872] Memory Limit: none
> >[    3.858976] ---[ end Kernel panic - not syncing: kernel stack overflow ]---
> >
> >[...]
> >
> >I think it might be good to configurable according to architecture
> >unless it's not good to reduce the CTLV_MAX_NEST_DEPTH number
> >otherwise, increasing stack size when CTLV is enabled seems unresonable...
> 
> Agreed, will lower it down. I think we should be okay with 8 for start.

I'm surprised this ran out of stack though with even as few as
32 levels.. Is there accidently something large on the stack?

Jason
