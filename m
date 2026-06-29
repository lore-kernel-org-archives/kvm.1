Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781332B10F
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743466; cv=pass; b=HEGv3re1gOzYtHlyPjsaoJ2we/9b7rJVIlNOGhayvPZbQtt4h7Nd0oqToYDu0dIc9uPK4n2Jj7CQ3MNgfOL9Weid2elM67HpJ3lNdknHnyr1TY6A1ts0MnUvG1dfsCuwCMbcQb2sxDk/LwlgzuRG1uCGi2t9t+ME9bPrbnX+bXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743466; c=relaxed/simple;
	bh=JOTz4KtAczNQIH2HE0MRXHQ9N5BikOZW0rasYD1FxGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUuOrSimE3XuXAR9HSU9k29C/eSVK7W9EK+Jjix+GATlnjQMkPc9iE5mWiPIqxmdUG8fCuL0AIdL9/SFUI4q0rzEIcYVZaKUFFIbXNBBz4hEK5zUgpebFA9c/K7kRVoKt2UAMP3cIKGKaMF8vxSiQDfTjh54W/9mAlV//L93Mck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXH752tv; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXH752tv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so13387a12.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782743463; cv=none;
        d=google.com; s=arc-20260327;
        b=BUvNJGQeVI1P2Hj0lmWvH861crxY+6lPhL1qHKwY8WACR42wjqBguTRdJfMvoQqHRx
         gtvKTry5ehOT/jQbEuZbqKluLEH7N5sMearpbTxezr1wQ51Tb5lo4ZG7JCazwaOQxw6w
         vRwp6NEPjJnCo1D7wfjhnEnwuRINK+uFnB/P9oH4tq9IcfUqu2ELQgEavOJz7DqEad8g
         CU5spcvc8n0j4kUnOA0EvaXMxRpnEIfFuajq/kB4L88rly0vHKuX+cC4Rzb1p0xtbccL
         i9v5WWy1nZx3iswBNjWyYvcISjpU2Rer56rLh9LFeyMhfkKXV9Lit/9IG9XC0o41/9Ap
         WcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        fh=5EanQuooGqXgGR9YzLzup8pQ32wbvNF6+sKDGuQBhZg=;
        b=gNstziNDdM5YFngT26XyjZCF2O26jPEXxreYSSnHjSm4zz1XycaU3z7qSoHhHTwUdK
         N5XB/XV9eaE8ZlNb7T6uf8dHkES6wmwNyAL9sObYHhii8Wtbk6aI+kUSwTaGMfYWsnaL
         SI+6BJUskJRoC5Ot+J1D0Bd+jiT+/vu2oe/0ic6uHJdkbKciTtR5GsVo2SSnDBsaYxOX
         Z4NOFxWXcNHFseQFy7woay35qZx6OYiFvEZZSb8ns0Rxw9Ap0MNCRQZ3Gtrm4RV/F84Q
         JaygZL4xp80VXWzBQklPVQJjs53SibhJB0Emz9EKH9dcNIeZizfk5l6J5qG3JcVCDrVR
         gM6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782743463; x=1783348263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        b=wXH752tvdeSuA1i1apDn7TTzLr3bExU6Z8p9gF6NF5lq6HMMSEINfVCEqVz2gtMWS4
         folI5fWFkWjP+43pviAxTH8bNyusXbYCMa+H7mSVeOKyK2XGf0Xl6453w4YvxhpLkrVh
         csG2QYuYc7HVkS9CVmIp6L17Q0WJN/RA46UhNsAC+dJh0VRoOOYnSmudtkYl9zRP1wCh
         klrUYtbgT2oGG0izffbsIdZr0+hbJBvdilVluSW7x89T+DNNt/MIGA8GwOHwb9nXlyTb
         ZHEMRIR544qOTfR64Q4LY4LlYwPX0X51xzqgovpzkAlHnjTsb4UTY7dS4w93wZZGIdP9
         +IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743463; x=1783348263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HnUpC3GuUlHFE5pSzflrbaIDrqRbSXDM/GZaCK/+qOU=;
        b=MzRntiJrJpLdlNNEVaAB2s1vpkuSqOgDNFsA52xLRqkEDtvccCWCNK39xXh9hZNGl7
         Fqzjdj+9+eThyW5FGTADxIeUHnKHoHNO65VbTw8CwvJJ9BXDlkpHmB9ORvp4TfciicAs
         gFrKwG6iG054RRZq9rqa6venPXpgxWIvJ6YHZAPEtLiWmQUpSeYze5sUBW7mLx6/YVG6
         l0jTQ/djI+mn/LBTpXjjc/fRqyF2YRYBxcaloSTcpSzY2GSFtPnxGTfCTRvLLPJtl83y
         OvKDJsM4JZSMFnvcuJ0citZwSALoi+Q5+Ny5NfYNXTD8pH4CM3WHox7J+eS1BrRuZTTZ
         Yn/A==
X-Forwarded-Encrypted: i=1; AHgh+Rpq8EUi3uU3+oK3lTjM2vHJ4/m5i/c3+6o2sgOdmp1h9g/wg+daoDNJxEtcMf7iwbkvpTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrdFkek+sM5AIgszlh2Blz4/5ExNpCKr4WAttVJI/Tvsbnc8Y
	yu/A4+/PCaq0gWhOnuUlbRKDyx1nS5GEm/DF8BXA61J1PeSHG+Im5vTklHFmmdS+r53w9rN0Bui
	O5RTD7RFqfAKr27z2OruDL8+n30QSBwTHz7Yazyvv
X-Gm-Gg: AfdE7ckF6XDT6FLj9VP3NV9zhoPXfkugg1fTKjWn4PtT9x1CGTnpON7w9HwU2zgZzWX
	URADQnneeYysH5rhgRPo+tG8mJ58inywcYYxHI3CkujNJnoMc/wLIEA7BUO73c81aSkY2kg7bM1
	cksqH3XlgPm3aVc6ZbTwGvyt4BxyQ9alLmQHmelU13hC+yZBYjTkMVOGcZWZWJ85E2UaZ+DetFV
	gzPxccOW/zuxK98qfrwgzRBCUk5ohUDijCd6Hpufz75a5x/56M5W4e6UTLAcuYqgGHTtzvsew==
X-Received: by 2002:aa7:cfc3:0:b0:693:3e06:8f4d with SMTP id
 4fb4d7f45d1cf-6983f23c5a0mr91050a12.2.1782743462440; Mon, 29 Jun 2026
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com> <akJ6Z2P8eMm1tc65@kernel.org>
In-Reply-To: <akJ6Z2P8eMm1tc65@kernel.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 29 Jun 2026 16:30:51 +0200
X-Gm-Features: AVVi8Cc2-nXLSknBHksHveOm17x8Qt4efvzGWpwSODhQBj5we1EbHkogy0SyKrc
Message-ID: <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 16:00, Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi Brendan,
>
> On Mon, Jun 29, 2026 at 01:11:49PM +0000, Brendan Jackman wrote:
> >
> > Some tweaks and cleanups for page allocator entrypoint and flags. This
> > is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> > become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> > to be an improvement to the codebase in its own right: unifying code
> > paths, reducing API surface, and removing GFP flags.
> >
> > Tested:
> >
> > - KVM, mm, and BPF selftests in a QEMU VM
> >
> > - kunit.py on x86_64
> >
> > - For the ALLOC_NO_CODETAG bits I just booted a VM and read
> >   /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
> >   kernel crashes in early boot, so I was at least booting code that
> >   depends on this logic.
>
> Heads up before the full kbuild report:
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [v3,00/16] mm: Some cleanups for page allocator APIs
> Patchwork:  https://patchwork.kernel.org/project/linux-mm/list/?series=1118244&state=*
> Matrix:     https://github.com/linux-mm/linux-mm/actions/runs/28375636866

Agh, thanks, I broke the build for CMA.

I thought I had this covered in my local test scripts. I will fix that
first then I'll send a fixup for the patch.
