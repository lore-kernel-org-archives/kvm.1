Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF3481223
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153310; cv=none; b=Wnprt78m0JNeqjqzKCA0xLZH9RD83alOeEKrjR0/5FHDG2kq1yIhZmGaHTLNSdUi/KxZAGL+uvfGzpEwi5cajpm2gMwTbz7Y4HaUfXri8cvlf3j9AwBNBG5Cp4TfM+FRcPmvd4Fp9EEHHz4MkODI9W1zPDp/sHSLHWQ94zEfqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153310; c=relaxed/simple;
	bh=WQ4ky5U4JQQu6hUzm3L7HWqJp+fDn3g165r7VCIsMM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4FTESqdxuZtB4K2NuaA5PYQRSL2xt49+RvkaXMBeGAuq9/UXgqsazmdtw2X7jXdZLkcpTehJDkPk1+j4VEJsaUiTb5q/4VlU6ek4oL2f3RlOizbUs7LHi3ThTBFcAxBj1o7u3yDAG0oF0FYQZs2FtLzk6ODnKswNQUHkHLaCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QmRnSFTC; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmRnSFTC"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d5d00fd19bso19157305ad.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787153305; x=1787758105; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcN5BlvBo+qUseHk2cpS5BEUiqMQnkNDxZmMEll7hc0=;
        b=QmRnSFTCCOOQKM7qE0xSmyx9G+NGvlNlOvyuasssFqHEJvv3Yyz5ue7mHyiDOP31pL
         3N10D0RM9zy3IYgs2qNzxOX1kcy2wMJdOkL/3Dt7gfBIEOl0gk9HI+c7wF3B2gRBlLs1
         ZKc653ZrtWNxZDbMKiPw5z0v/qyVBdG1AFSL4BChOd8YkYmOFbCSOStNjs6vg5PchhCU
         EdaP2I9A2c6IhsTGVWcUw03oCZNuXpGmJWwRBMR4t8Cd/OxgoU9RA76Rn+Njp+a+Sab5
         RmvcPSGCCNcjIefzXSnTpR64LQEaYIWsG6ZK4fnv4LGRf+T4vCnOHbhiD1Oj+6GSHNS+
         McQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153305; x=1787758105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RcN5BlvBo+qUseHk2cpS5BEUiqMQnkNDxZmMEll7hc0=;
        b=VDqSbArjroFOH4Y4qTqJvdwKKNHXBeRTzbywZxSz7/jdfzTVruUFDEz96F9KtdxlGu
         8ER6TKVaLI5JdNcPvLvM75KU6/8mWQvsQF3oUIbrrhPspxDOGyoahRZSZuESPQF0gGuY
         24gwnv7TY0Wzkr77AIRHAcdrADSfY2D43UtNDmJgJgFc3+YyQ7kkoSndyOFusQMBLYU2
         /8jeX438sECPB/KWhB+U4H9BloLlRjYSIK5am35U1YStgHqmFczOy6sbiEgNaAqmB1ji
         /eLEBxP79v9aTgZlwN5Dw5hPujNl+wWHe9Z1QyC0Z1F2wHrkB2H1/DQJAy7sOBmz+t3/
         vJKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0q2N5cBwIpwDEhmkIpLDLTWMmgQF8nQL3UnMkvpTj/Lz+0w8DitC9T0w6VfXE9w151rQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lUTR71K3chpZQRo8Ett8e6TTotG774I2jM2WqfAhwmu9izdyUP
	f9LzjlqRBcB1fW3l+uSqrxDjuf6c9gMcIIoHG4rKRBp08q4RDqfsnkW2cRS1IIq4TEeAyqkcwLO
	LXN2ahg==
X-Received: from plbaz6.prod.google.com ([2002:a17:902:a586:b0:2cb:97da:d8ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4e:b0:2d5:ea01:429d
 with SMTP id d9443c01a7336-2d60197e7b6mr110802505ad.14.1787153304834; Wed, 19
 Aug 2026 08:28:24 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:28:24 -0700
In-Reply-To: <20260819102314.1499258-14-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819102314.1499258-1-jgross@suse.com> <20260819102314.1499258-14-jgross@suse.com>
Message-ID: <aoXLmJE8ZmQngou8@google.com>
Subject: Re: [PATCH v2 13/13] x86/msr: Simplify some rdmsrq() use cases
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Juergen Gross wrote:
> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable.

...

>  static inline void update_debugctlmsr(unsigned long debugctlmsr)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2097602a00a0..2a68f937c080 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2415,10 +2415,7 @@ static inline void kvm_load_ldt(u16 sel)
>  #ifdef CONFIG_X86_64
>  static inline unsigned long read_msr(unsigned long msr)

NAK, please fold in "KVM: x86: Remove the KVM private read_msr() function"[*].
I very deliberately went out of my way to leave read_msr() as-is when moving code
out kvm_host.h, as I was expecting the MSR cleanups to eliminate it entirely.

[*] https://lore.kernel.org/all/20260218082133.400602-5-jgross@suse.com

>  {
> -	u64 value;
> -
> -	value = rdmsrq(msr);
> -	return value;
> +	return rdmsrq(msr);
>  }
>  #endif
>  
> -- 
> 2.55.0
> 
