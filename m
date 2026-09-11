Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C32264CA
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132860; cv=none; b=bJNmYWgc2XnnCxCuWEEOrbVnmphXlwbwtnQxNvyLLxqOCPeCe/sWiMOJfD+djAFJWmCMcSeUP+lXgCzouW+HbBWwGrBLiBeb4SjLjSKLijQQJp0Tfl6fj7tDHocE1++OLMVqCqL4vFpspByONRTa0Pe9037WeQpzigKdzJHfAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132860; c=relaxed/simple;
	bh=EolGcyXZdQB+WJQ/fbAT/ovCeKnyMlJRoovdxLhAScI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4WzxSMjbL3nBf+wu5P3bMza/06WUmJLfQ2XQcyXKYppxtOd2fkeOuSgrVbF/cCSYUOyd6ktGY7D0bqDDyiLUoaM9y/cDVGThyU+g5Ja3PnEXH6fzeGsovSEbpV5LMWcQWZ5c/vnK7XsmzVVMUVU7On1kZ2oyNmsI7YToqIscfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhWuBsjX; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhWuBsjX"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so781209a12.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789132857; x=1789737657; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6E03lEoHjRnSy/KkF9YUurNW1tkrhzCisRbnf6MQso=;
        b=JhWuBsjXKa/j2xC4TWzqQDqGpN1vHZydGvEuR7ZlNNx+eE3dFNstaCQI8H8Vby0lc8
         By2hVTiaeIiQ5+ng8Cw24ZqBl6meSDOJlF/pgf+vev7XiTla4WEez/EaD/JaZ2cPMZBr
         Rak3KpMdOUFDf0qD8nBOpqHJSO7wTyn8KK3iRPvnicl8fHPeQhWXqRKr3CbKCRL6xJeW
         t+iwL0VhWlzhHU/v7hrGqOxwY3Xacg1IkfPGhfYjCmOeGF4/MGMfPvhlsLWHnaAh5xPO
         tAyT4YxpueHloR+rke5kFjTPSDy74AdyrXtcM6idmrzY/CAUZWw+p+IrOwH5iBpkDvx/
         MWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132857; x=1789737657;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6E03lEoHjRnSy/KkF9YUurNW1tkrhzCisRbnf6MQso=;
        b=QD360Jq0WEwkCLVSyalaF6lhY7fQgKENwGptghS3KzbfPVz7MTXsMBzb2iAzmxfwPS
         x2G9IJQPUpI+UAvJ6y4trmDRrRLjYOYiwHEamOU4mW9ejdgYW+O6k91ilGFD2l7AJy+t
         O2gIaKNVHrIS+10TRHprnRPYXc9JaWHwkISeb4zcEwgV5kj+rnyQPSzTRnrSweRovEVy
         rJMspdI31hqVL4rNjHVmxF46s81sw8xQzDWraH4XlD5s5rgVDUAZFc8J78WDTy7qHrfo
         cxeSjYiwWZloIogHCZ8BxtbZEzKzjjdJXEBUP/MfkBN5a7rGAd8gzdOUvs6Yjs3YwKv9
         8xug==
X-Forwarded-Encrypted: i=1; AKwUvBwUNKo0N5yjRWA8DuUZLgZgF6us7DRWZdvntQ9OWNrnrf8LYxjEekedjTgaKJtP7NUvAXs=@vger.kernel.org
X-Gm-Message-State: AFuF++mJWy4VSAq51hgxJ+XUDhGIVLgSYMQYzymy0gsbwLYbLhd86OKD
	HjjqLF2cxA68xR4U2kLLVHy+dXJivhQW4nttBJdgSz0WaCHxvxVfxZho0OKEyZclCtPSDU/Ecg4
	2IIlsYQ==
X-Received: from pgfd7-n1.prod.google.com ([2002:a05:6a02:6547:10b0:cc4:56ea:7ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a26:b0:3da:5eda:d167
 with SMTP id adf61e73a8af0-3daed1515e3mr7900074637.5.1789132857186; Fri, 11
 Sep 2026 06:20:57 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:20:55 -0700
In-Reply-To: <20260911074530.3140830-14-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911074530.3140830-1-jgross@suse.com> <20260911074530.3140830-14-jgross@suse.com>
Message-ID: <aqQAN6JbTe0fveKs@google.com>
Subject: Re: [PATCH v3 13/13] x86/msr: Simplify some rdmsrq() use cases
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 11, 2026, Juergen Gross wrote:
> After the conversion of rdmsrq() to an inline function some use cases
> can be simplified by dropping an intermediate variable or by
> eliminating the inline function completely.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com> # Hyper-V
> ---
> V3:
> - eliminate KVM's read_msr() (Sean Christopherson)

Thank you!

Acked-by: Sean Christopherson <seanjc@google.com>
