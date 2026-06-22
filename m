Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A603B27C9
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134149; cv=pass; b=XVBeJXMgZGAb0jDnREPK8mCj1zm5mpYz6SyYBIxRVw2ZfP9kZxb3DtvPyWdwKDkiBskTTG/3W+TAtg4SAqOpiqsJy0CJsrmTgc48115gGfUehFwWqxLqLUwiSZyQhIqvGsXvvmohg3Mhbl8FawdbBVe5g5B4ZHvqn1RvF/+gOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134149; c=relaxed/simple;
	bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxNzuRIv1+08YR8guWkAhOQHcaETmYR18GifQPU+XOXA+6FA7f7QidsA+bWXYVzpV7x8RVbaGTtwVossU+xir99q1k39VVY6UCkiJSDKfpKs0eCpBRYbbeenSq4tL4OAa5Un9v0vb8i/JsHG7gmotDfVLEEzF1ay5YMF4Gc2SFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLRXbWHo; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLRXbWHo"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-695469b574eso21327a12.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 06:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782134146; cv=none;
        d=google.com; s=arc-20260327;
        b=i/va17DXViwoT+lYv935XnCeAKSxIUV28LLWoh1AAcd1OFUfPqZaQZAbubv03UC7Lv
         8xUw2UDbbnErpLNuUrya1ghqrHmXF9vXWQJUqxOhxkSXflWZ1ujCT2zgnLVTbyAZ4Rgx
         Tsk722y7Xwwo9pyTGDA/v3mSun085GtSJrlhrbuX+hfkdpqautrqmDdwRL2SI2hd/Wbz
         Zm3v/vAXZeSJ7GZYenB4kvYxToU5uAa/0OwTQGHRdNQEdyiG1cDYqgobSGWhXzo12c/X
         SzjERILyhL/b6LEcc7Y2yKCWudiTD5S3uEklPAsZGnm0JiE2FkBMuOil6DIYD/r91IAD
         hBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        fh=FNCIFHj6rd/Jy6n5zsLRInOE4UKjlWySnCN8K+Z5U3w=;
        b=Lytd5/jB7/M8meB8gLXkIU2gmGXDyqnsZq7OHk9DBRoT8ruavcRlfL88Lo7f20ZcOR
         ETWn9auL1VykREjFJFbxxCG1qkWwrTl8unV2VQGiNVTzIEhoy4C9j5hBKfRDpQFmDRqZ
         AwqNH6GEUd6ucHDHTV1kufpiuUN364O2L9x2diaAz9wCfbAl0cC2MNEJQF4z0XeUvXCt
         idCuxbjkfryAGSSlls2AwvImKtv57IU9/+svJFtYiIiEdc0XgERFJScyglst+DSnHWXh
         D8vedWrx3/1EIFbQ7BWJhc1zrplPBZjjhKF9vHO0sxOvy5y6lPo4f/xAQgpugdqJdIU4
         xmQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782134146; x=1782738946; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        b=qLRXbWHonFOzBAMhk8Y2uR8rc6BmM5eQXfVEFXVEqMNH4ibnEem4FoWajkNnxmeP8M
         wc3eaddJGOuBWj8BRD5AdUO/hzsebmZaOiOc8NG+M9PXe8Pgbj4YkRtmTX1fE+uEInlp
         XOm9Q3OhjY1jswu8jZOghvs3Z4441JxWY+9+8OWMisc+Lx/+t32u4f6bBX8aRSGRDa0E
         RuZVWfTG3rApXJz05d1rN8QUhposak/kS1eNBjMGA0dlbkGltp+l0ThagngvC/JmjU57
         NED514s8jJMLdlww73sfw9TMuo5CC+zidIRNV28QA0e28WjxSiQGrNgeWfZOSMQmp6Vg
         l6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134146; x=1782738946;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w1jdgcb1GTzI/MFxGAxn8bD+AX0AkPgc9MYjNjyFClw=;
        b=bh+0IJWBxnIEGOH0Vh8D8K4WiMbbvU246QoQ/VhlWZ7fXc/1YYQuORKLhDQ8i0k6k2
         eUiRAZS5OGTGcG9Q6Ql7mi7RSbX+n9b/atwyvmB4/UjiFxxldVMN/qu8Y4cVvcG3f6MS
         Mvh3E97wlAzGr7xgHD3GyIR8odx76e3yRmcjQ/7Twre21zqzh8HwhrizY2z1J1//0p1/
         /VuZlTh1Ln35IHiaJi2kn3q/GPDODSQKhpoq8jjdjdhs+vf1AnHsAghrcYnZ6S/7S90a
         Ae/42UtzpMAX8kGYVqCRsMzB5HpoYbNDkpoCkLvNz18D/xgvydALe1wH9I4jRyfiuNnd
         cpzA==
X-Forwarded-Encrypted: i=1; AFNElJ/jwUmbmxr7lDhiOfkE8m9EbVbM4ZYFuSbdvUBpwWMN0fkmLgP92HDQIURei5YWiO1xlKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfV+QmTcw8KkpZjgBHErThxggWPORnp5Z2I9SZPME1XM1Uj/p
	46ijKlQQv7Dx8VLBNUwlESSQQGJB6I9fM9yhcDuV9G/VZxc6h1C4Dd+l0otkzSQ8VBjOlM0oTNe
	J1AYVOvXKU97dMPpDwPQbLghnIqK0BtRSoTBbTEQm
X-Gm-Gg: AfdE7cnEbz+33VAm4+cM3skFCGCdnpUK0E3mHoKEHSKW0hcTr4aarejfowER9a4mxKt
	oemzM/28+DQq2xI1/aRh5s4PwKMCr3+JA7n3wLTbNaKCDbjmnbyb8FIxF+GZ5DniNppZEvRdzdO
	SYNA9kLJ18DLXq8XP9VlzSzFU1cG116vra122YI1TjL1ihaXzyFDWxPzBQoctbsRJ5C23u/qtzb
	rJhwkaTggHqhKXti93XSJCcDvXmZQpTRo4zI/HuVEmvvTfZW87sSSLIKWldRcLwI7OFWfVKvs70
	A2vrDH1thesOx/lm4+MrZRvOEAKI9jJKV0vo
X-Received: by 2002:a05:6402:5154:b0:691:6fb6:dab2 with SMTP id
 4fb4d7f45d1cf-697498d9fb0mr119450a12.5.1782134145476; Mon, 22 Jun 2026
 06:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <ajkzGElCGxJt-s84@lucifer>
In-Reply-To: <ajkzGElCGxJt-s84@lucifer>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 22 Jun 2026 15:15:33 +0200
X-Gm-Features: AVVi8CfrL4Oxj7BVaLIKs0bu_A57lof4blIfUKooVGhj0U4uQfgaPE2LZeA5esM
Message-ID: <CA+i-1C00oZP9U4CBPkq5txH=cP54mypr0sYJU1t7pgis0envQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] mm: Some cleanups for page allocator APIs
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
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

On Mon, 22 Jun 2026 at 15:09, Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> Thanks for the series (cleanups are always welcome :) but just a gentle,
> annoying, note to say it's week 2 of the merge window soooo we're not taking
> anything at the moment as it's a quiet period (mm-unstable taking only fixes
> AFAICT).
>
> Though, it's potentially good to get stuff in front of people early, just an FYI
> that we're trying to move towards keeping the merge window preview/RFC-only
> going forwards.
>
> I'm not sure if that'll fix the impossible review load problem (TM), but it at
> least helps keep us sane re: what's actually landing/not.
>
> So Andrew will expect you to resend this after 7.2-rc1 appears!

Sorry as I discovered on [0] I am completely ignorant about merge
windows, etc. Even after that thread it never really occurred to me
that people might not want to receive patches at all when busy trying
to get the rc into shape!

Anyway in this case I'm assuming there will be at least a v3 so I'll
just wait before sending that.

[0]: https://lore.kernel.org/all/DJD12YR8S99G.1I43PSHB77TA2@linux.dev/
