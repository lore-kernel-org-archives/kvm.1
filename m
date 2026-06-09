Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C01360EED
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974524; cv=none; b=c+zIpqsW0f1Rby9lo4Xd65mG6s7czRn2ZBmyve+rMdGPMaQiBO1o6h2VA1OquoQ1H29Td0NrWXDyltm6jHkIuV0ZCUvL08y7h9SXoxYe3am8QCP2ioebQXX4QM0mRXDnzzKDr4jVmn70rWHFcPjOWHg1G9tZhgzGjVBi2WRNBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974524; c=relaxed/simple;
	bh=ZWOR/QrGmJu+uFyB1Ae1JiHHn0938DbKRArZn+SVsjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CikyqCouMqIIsr+AxXcfWn2BZp74puqFv9g2iYcF47iLZ9r3elpDLzSAZ8LmcXoxk0Um86rpKPrdW8nBoCd0dcOhPyFNIOD84x55O1M70KAd8J0jTXkA6xDWYtYvvihbKF+zMgLEmE+OG33o2RqPOguVG4u30+aXF0L7ffbgvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9jzrwcu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9jzrwcu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e112dfso70068705ad.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 20:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780974523; x=1781579323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZhzMIPpW0uftooDfGhS6jJvYEf+eSZUIwidGAEeFqU=;
        b=q9jzrwcuQNqmpceaam+6jcf2tBk8GwjGUprRtthw1FYhw92n/M9caY3tTJI9xSWnxo
         WPyWP9ZV7bilSNRMN/PTNtaVqZOtvYbcBtvmKiI0fhatogrE6eLnW/AjibGXe5C8NHDN
         cbgarGcLlbLLobHodOFcoOPVpjielAwsuRNun/UZivGIjF+39Xh8KOSv5nm2sLWauvQa
         8s+EwPBSA11xDRfP9lVGzp8EMlRV/ZoUOkwdO9y+ruK/6G3iEGr6ZxWrhkFMRHLFWGTZ
         f2JOr9Wk0I25M/n+t3/R+vIndtvtd7x/JXpGNFY3ndtX6Dco7Jb00tgIDzEvhDzUTrHY
         J+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780974523; x=1781579323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZhzMIPpW0uftooDfGhS6jJvYEf+eSZUIwidGAEeFqU=;
        b=ZSdaN5DwI9EdOfRBeNo16lno9qHkiGImk+vXHw62orqeux+WMgscNBtsIQECnReS/n
         HqdXCtKp/Iy7i6Xeg5q2Bk6bdx65VFkaVheFLQXZ3enRI1yXywHOw6/T+jPFOt1VXv1k
         0sRt6h26bTsXHJMnkDXRClL/wOIsHyN6suD15dJtgVIhAlsiX7NOB9vQUwICXLg6LG+2
         cvZvIVUjdaW8Yg9R15uGiR1YFlnUhd2FfzQIFDJdsP5NoRapTCvMeQsyAQgPT5wS8Olm
         JNw6xGeN+MNcAviCRiWocnnwlqaXJ77J2RLEnXJgLt3KW97Df9niQefRsB+0+AXIrJlG
         s48w==
X-Forwarded-Encrypted: i=1; AFNElJ+KSBNKbPcp0NNCBL1r5Yd/8GKClijAu38ZNPPgaegfCh9GxkkkuOKG29a++JeWXemcp6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOfBf7mHqr4l7JztY9Jhj9qpsEYY8YJ03+zmPkYcjIs9ZanFU
	SEa0+Ph7jdjl+qph7skLkQAPGHaf4InxDpVu+e9+cReNko65wjvKdepe6ml+DDBjbJttfk7XYXl
	9BqgblQ==
X-Received: from plbz12.prod.google.com ([2002:a17:902:ee0c:b0:2bf:ce7:ae06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f543:b0:2c2:27be:39a3
 with SMTP id d9443c01a7336-2c227be3b4fmr142116515ad.29.1780974522512; Mon, 08
 Jun 2026 20:08:42 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:08:41 -0700
In-Reply-To: <CAEvNRgHtpFa+HAhPVBvB4=ixUuEW-r_Xh49SHEPktUmHgzYcAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
 <aiCzNbtQ4FPu2yCR@google.com> <CAEvNRgHtpFa+HAhPVBvB4=ixUuEW-r_Xh49SHEPktUmHgzYcAw@mail.gmail.com>
Message-ID: <aieDuZi3oMQvdwaK@google.com>
Subject: Re: [PATCH] KVM: selftests: Make guest_code_xsave more friendly
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.roth@amd.com, jackyli@google.com, liruxin@google.com, 
	darwinguo@google.com, jacobhxu@google.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > Uh, so as the comment says, the goal is to stash state before _any_ compiled
> > code runs.  Shoving the code into inline asm breaks that.  The compiler *probably*
> > won't shove anything before the first inline assembly, but there are absolutely
> > no guarantees.  E.g. you're subtly relying on a tail-call optimization to avoid
> > any stack operations.  If I force guest_sev_es_code() to be inlined, then the
> > prologue becomes:
> >
> > 0000000000402a10 <guest_code_xsave>:
> >   402a10:       48 83 ec 08                                     sub    $0x8,%rsp
> >   402a14:       b8 07 00 00 00                                  mov    $0x7,%eax
> >   402a19:       31 d2                                           xor    %edx,%edx
> >   402a1b:       0f ae 27                                        xsave  (%rdi)
> >   402a1e:       b9 31 01 01 c0                                  mov    $0xc0010131,%ecx
> >
> > and we're hosed.
> >
> 
> And omg, I thought I was running the tests!!

FWIW, you probably were, I had to force it to be inline via __always_inline.

> >> +		"xsave (%0)"
> >> +		:
> >> +		: "r"(addr)
> >> +		: "eax", "edx", "memory"
> >> +	 );
> >> +}
> >> +
> >>
> >> [...snip...]
> >>
> 
> My bad, this patch is such a goof!
> 
> I still feel that it'd be nice to allow commenting out functions parts
> of selftests while developing other parts, but let's shelve this for
> now.

I mean, it's always "allowed", but that's firmly "Here be dragons!" territory.
There are any number of things that can go sideways when adding and/or removing
code for development and debug purposes, many of which are far more nefarious
and subtle than obscure compiler errors.
