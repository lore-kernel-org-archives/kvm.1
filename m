Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7C7404E
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465104; cv=none; b=C2zma/N6C1yJDCOl2hwG1IdgADix+6rSpZFUcDIm05VIDj4S1f6eqIFbMtuZo4X/RYa+KIpkMKFbimdCrjcP4guDzKTAr7bySywe/GYftBBV5de4IJSJjrTfrifBWUw4RQyOK5sVBEpZMkCigEUkxt0uexHANA5unbk2H15NRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465104; c=relaxed/simple;
	bh=wJQo8cWyxesgPH1j4degVgR5bsBDIIyoMutFduCoUzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1WUfEBewgRfk9AS0B8wFR+2oGHf/CvwaNAcejUCsSulr2eksfnOHb+OEqo0/cZ71ISZXK9Qh7OPgqv0ytVljXc6uhvST1K7Zx8fqbpJolSejP67tARqlxLCYEG7RisYxnNwcBewlr1SqtkNbwtw+uLglTyl7Nc63CBXTBUkAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l5C4MtY4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l5C4MtY4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d736211595so827040785a.0
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777465102; x=1778069902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPHSzoCIyDIC9QP5+spsNloO0c/6uT0t+rTHSV9tUV0=;
        b=l5C4MtY49v1HQivBmv3TSqtU1cgZcvPUfJWXPLnlLxlM7u8yfy8jdzthDJfGa5UNxv
         Z8/Lny/gmlRMZ9Mxjn3SyeM/dT6N0NlBDdNUdI0BrWb3BM+/IbBZORcyPhDD2mvs67xb
         ebRia/MW3KP1DzXQKXwPh+C67LoXu0fE9LML6WXonN6KskLXoOh9iX6I+1aD7soggGAI
         1aKLqm+dcpB3PP1o6IYsVsk0SaoB0iMO6BQrSfpo7kGnfA025r97mnCKZVqCayZXZxaL
         ZjswJ25zwOWnlMHnYm9FTMSvwfpEDdU2u7whjzo0HkL7d8E6NtRvc9M0ejuxfzIxqZUk
         qJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465102; x=1778069902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPHSzoCIyDIC9QP5+spsNloO0c/6uT0t+rTHSV9tUV0=;
        b=XjUyFleBuioK/nUM+HyAf8BotWrsVW0i80+d/GTssdUi+cKds2WWpx24eNKWTz4vUT
         cnqOcx2rACeIq7SaaMxm+o29NhN6mY709rDVoEzfWOa/7eV+n/L1E5WOfVAdCYf3S3vv
         w7feu4vjukh+zox0EF+YlOnbm381NvVaHuX0fvSMtc0khbQYNf8XuDx0mRyeqqLVEZFc
         1molvhhZECy4hhmBYoXDZaPvb3BmKnbvmcDn/g1lbzqfo55/kSke32nEuXa1qAlBMa2d
         bJFMVJpEOXGtIDCOjfzjb7kCcg4afarPeHjDRn30N8XjuzzovgCcFIpCVKNvJGzA4rNi
         0N5A==
X-Forwarded-Encrypted: i=1; AFNElJ92bKcjzZpOtE386w9HUP7QDQO5rwzgRm5/8iuaJwMevksXYher7TCf5i+xzHDa8ESF6+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYqD6p1PFuk7ax+VRIPhFuanWB88NjaSw0qTL5RO+QiW6Lcic
	riUEmrYUndtujRNcqHu8xjbxeJP6Eu6HGhmO50vaLyD3tZCwmIoFMhdYh+GgPhPOpUPgB1+qZMZ
	bjC32KLY=
X-Gm-Gg: AeBDieu8ls+TIYEznb4ASrNLRmInzF+FwK/gDizKzAbo6A6SVfagjYz2uHjLdxngXME
	fsQ9FHJET4KJE7GErPI9pRsRQscS4cUhGWfnBmY22wuZbAAj/aI2taXw0UAvwvFDcXho7pBZDQI
	nek1GVrHpTL3hUI+2AK1erF2VxSfuTcMFBZRtTsq6iUoKdKuHU88YN4/2smE2aaCQo59JUh9qVy
	hLt0iCzdSBXvDA/zt7XBV73OngSeKbwNiumyU5I5Q1mr8ue8ZAgvb8svC/euEGHkSji4m1Wun5S
	RK7MW6cv/6is1cGtjf+XzppJUHww0uvL2RBobYQDzSz7xveA9MxwhUAPnbGSLDfanvgOFDo11NO
	d9NAcIotEDIagaOVPyfd2XWwiCc8vy0kpB7UG8npfSlm2OvTLZ7bTvFR8cIGq2ZK8FGWdFODUUk
	JnuLniIJtboKsoghbvddOqctb1wLAg7/8rl4Mw6vlhN7WXAcR3shbGGfJpNf01iXelXdP2//ngt
	mfUHN6RI9vJHgWu
X-Received: by 2002:a05:620a:4481:b0:8cf:df8b:1e5e with SMTP id af79cd13be357-8f8f3534220mr552478185a.5.1777465101412;
        Wed, 29 Apr 2026 05:18:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940051f0bsm152785185a.40.2026.04.29.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:18:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wI3rw-0000000HF8A-18yU;
	Wed, 29 Apr 2026 09:18:20 -0300
Date: Wed, 29 Apr 2026 09:18:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, anup@brainfault.org, aou@eecs.berkeley.edu,
	atish.patra@linux.dev, baolu.lu@linux.intel.com, guoren@kernel.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
	skhawaja@google.com, tjeznach@rivosinc.com, vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: Re: [RFC PATCH 01/11] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <20260429121820.GL849557@ziepe.ca>
References: <20260428133239.GC849557@ziepe.ca>
 <20260429010650.61646-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429010650.61646-1-fangyu.yu@linux.alibaba.com>

On Wed, Apr 29, 2026 at 09:06:50AM +0800, fangyu.yu@linux.alibaba.com wrote:
> >> @@ -263,6 +281,22 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
> >>  	case 57:
> >>  		pt_top_set_level(&table->common, 4);
> >>  		break;
> >> +	/*
> >> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
> >> +	 * The top level is the same as for the first-stage counterpart.
> >> +	 */
> >> +	case 41:
> >> +		pt_top_set_level(&table->common, 2);
> >> +		table->second_stage = true;
> >> +		break;
> >
> >Second stage needs to be an explicit PT_FEAT not implicitly deduced
> >based on the vasz.
> 
> Agreed. I will add an explicit PT_FEAT_RISCV_SECOND_STAGE flag and
> stop deriving second-stage semantics from vasz.

PT_FEAT_RISCV_S2 would match what I have for ARM

Jason
