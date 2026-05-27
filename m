Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97130BF67
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919720; cv=none; b=lN0raLcwZESjYtMQwXhEK29a5SVaUwdEpghRrE1zo5MPwZvxy0bQdgEeiavoiFm0q0ahA8mGzY6r0tQsrMuvPSQEFccPSuiQ4rlZAFNaYMwEYgGgdavh4G/RgYZrJbQMcE64t/w9QO4N/o11GiITNiJuaGqq1osV8eGJiJIgWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919720; c=relaxed/simple;
	bh=i7wbfpftAHOze6/LqECcmjGsJrtyORuEDEH2Qu6CHmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EN64Ml8V//MFh5O3AVWlH2EHYP++TXl9zgtEuie8mXXsOcLMS10oRYssZghEYvopm1feIoob0+YxuACGj4cTdNnwrxcStxFNWizn7VIgx+mXmdd/lJXcLTxjp2X5aC8JUi7DWWAf/0iU3PHGQqId2oPQzWKB7ahNKATDBIpDMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOHse8mW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOHse8mW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso6485316a91.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779919718; x=1780524518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIKX16irW4EH5cTo/fgiXG4rRWB7A4t/PlB8ZgkXoDs=;
        b=FOHse8mWLSEL5WDZNhwtBPb1PY/s0pYOJgb278YTzuY65jWjtxzMLj+7VOQ6amw87e
         KFNDw0KNnBXanifYbrEXL0QSaA9eGaqqjlynKsObK7Txcp7193FV7zX6AXA3AdjgHBLW
         Ct/AkwbDKySjPw6835pP/jY8VQ2j4aMtcJh52VgNT3k9IP0AeXE9nCvctEPeZqb0JyAO
         bDp0ZGPne9wBblgsEFJm7iCYesm9LeUW8mFoltDM0Iqca+XJZs8xUloQpk/L6qrP9Jti
         ebhLnOTPL7XFcNIqqhtoBKBB9Q6FKdc34oZzCaNk5y+QWKfCSptsAPfqyX+bxMYi15kB
         8uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779919718; x=1780524518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIKX16irW4EH5cTo/fgiXG4rRWB7A4t/PlB8ZgkXoDs=;
        b=o8M/Wy4LJyq4dw/n9Nth1wlFgCKcsJFtgz1bmHtzcxd80BHpoO+8F0oyQryrGQqzeh
         3I1s6WcYy8PnJhat2heVN0lnTD6ZW75bZLyjUEDWa64lMRMzbDhtK/portKqo4xN6sfk
         AWo8wH7FVz/3S4KsZay6bmRXrPNl7znC9royqM9pZbRVC7l7W9bS1CHeJ906yQ/8PuKc
         aNMVvOT6schxIWNO8xUFUCGZvdChRTWit37nLjE4cH77kyXwmQTUVK5UGATrX3Y3wsbf
         e0F5mY6uBL6+i6P95d6k0jCzaYovmVAozWIqNpZt3vChFysL//iV57YqxaMCEfqC0Xc6
         Y0Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9adFT2YP9rmk0vMFHg1ap+yBLOHLxi9fAnA8BJGOFfMvlNqcX6bD9vs7rvPz+VSaLj5/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzCXFw7HmGOCbesypzOoX/JcqCZoRMtuDkZeLjW2R3E1DMdCs
	PnlaEUor87Bud9ovUtpmyv/qgBTUoVfwxa7pEGST/o5i0pNmWUbKz4Vn09I/HvrzSI3BH0by3Ev
	z8ZBBbA==
X-Received: from pgfu7.prod.google.com ([2002:a65:6707:0:b0:c79:7991:6d2f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e545:b0:3b2:a8cd:ef4b
 with SMTP id adf61e73a8af0-3b328e5ae80mr24472025637.25.1779919718163; Wed, 27
 May 2026 15:08:38 -0700 (PDT)
Date: Wed, 27 May 2026 15:08:37 -0700
In-Reply-To: <CAEvNRgEW8nph=Hz-3pcQD7ZxRuAOcjcOfj8afgJMsRgESD-Wbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-2-3f196bfad5a1@google.com>
 <ahXB_tBWakUUjt6q@google.com> <CAEvNRgEN6syKVLjvFX-s=xU=r3CBZ3KtmeKvVYOC09uvFGXSFg@mail.gmail.com>
 <ahdFSxXnWhhsjhKe@google.com> <CAEvNRgEW8nph=Hz-3pcQD7ZxRuAOcjcOfj8afgJMsRgESD-Wbw@mail.gmail.com>
Message-ID: <ahdrZZxE4O0jqmpB@google.com>
Subject: Re: [PATCH v2 2/5] KVM: guest_memfd: Fix possible signed integer overflow
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I like pgoff_t more than size_t because, for KVM, it's really all about addressing
> > memory, thanks to the offset into guest_memfd being associated 1:1 with a GPA.
> 
> The offset into guest_memfd is associated 1:1 with a GPA, and this
> offset is
> 
>     offset = index << PAGE_SHIFT
> 
> > It's not perfect, because GPAs are tracked as 64-bit values, whereas the kernel
> > restricts itself to "unsigned long".  But that's a non-issue in practice since
> > guest_memfd is 64-bit only.
> >
> > But conceptually, I like tracking the gmem offset as a pgoff_t to tie it back
> > to using GPAs to offset/index into gmem.  And for all intents and purposes, gmem
> > is nothing more than a glorified pagecache :-)
> 
> So we actually want to use u64s for gmem offsets (where offset = index
> << PAGE_SHIFT), 

Hrm, poking around, I guess what we really should use for the byte offset is
uoff_t.  My only hesitation to using uoff_t was that it's hardly used anywhere,
but it does seem to fix exactly what we're trying to do.

I don't want to use a raw u64, because I dislike using u{8,16,32,64} (in KVM)
unless something absolutely _must_ be that size (and ideally _exactly_ that size).
Limiting use of raw uNN helps identify fields/variables that correspond to some
hardware asset, versus fields/variables that just need to be "big enough".  It's
not a 100% comprehensive rule of anything, e.g. there are still many "naturally
sized" hardware assets that need to be tracked with "unsigned long", but I still
find it helpful/valuable to highlight hardware-derived fields/variables.

> and pgoff_t for indices, since indices (aka page
> offsets) are semantically the offset, counted in units of pages?

Yeah, I agree the distinction will help us differentiate between byte offsets
and pfn offsets, especially with another compile-time assert to show the
relationship:

	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));

> I pulled this conclusion together from filemap-related code like
> filemap_add_folio() takes a pgoff_t index, so I thought gmem should
> follow that and stick with pgoff_t for index/indices.
