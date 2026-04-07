Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38F3382E8
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568025; cv=none; b=PyZR3KaqO/Fch3xWnYO62xIOXJa1egynK8If09HGABkVorOXLWmUja2p91kLpRtNL4QEmEeEGpeVBAN6K+ExgDjN/1SnpOiwlmi3tuI9i0th2DomOKhfRluRlAS2MxlA+wFbFy09VsBAI24DucpYHTCuqa7LfvqK2xdbd+0PoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568025; c=relaxed/simple;
	bh=87CyfNDwFF/L5cnHCUC0dfv1t/cS4nWw6mZ5x+xXPiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWpbkuGT+8JBEBEfFUH3Bsw78cN3zJbhA1MNQAf1ZqjAi7clmU8aqHMi9FuBYBbnyW9Z4TPx9w1zz6maNX8oFRmWimyguMbrO+W3TY9KTVlMTnReWQUPwhqx4eSOXXUkLpeUJ1qUWA5A19v1C3SB+KuCLjSR2va6Qfw7GlvA8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bl9C7Esw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bl9C7Esw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so8222395a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775568024; x=1776172824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bPS983cAWq0du21wO/6yMH6IgpBLm9JLdEvcLcXdGw=;
        b=bl9C7Esw9hfhjnT7PlvluwxrdQOOXuaPJwrrdJ8qUMNedSDIARZwGBwLs20aKKySmS
         SrE767Co4Ewuug616fSBc6cx3PeBZYpu8zYFhkuT9Ux+1uQcIRQqraKmXYMFxgul5qqb
         wa1WZ+tTlDDXhn8iDC0rtuby+Tp+mGAb0BYo7fOa+oiUiL9FWvv1p6IOQEqMT1VlcU9v
         LDdpDHixaKlsr+Mp1k0/WuFQBI4srWwvzjQqwvabIhfTIH/nDvGbM4N8zL/mAuB/BSm8
         YtCrhRrrjWqkaUFKRnRDUIh4v2LlaCpgYtSQy5OH8ziPCIceS3dBoM8lSRiKb2iklKIM
         WLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568024; x=1776172824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bPS983cAWq0du21wO/6yMH6IgpBLm9JLdEvcLcXdGw=;
        b=msVvzWH+KMUfP0kCMc7eTYT8RcInt3Ypt0EuwXnnWC4D8j11n2f5tp7FnFHWrhi+uH
         faqJjpcgF6iZvoyDjnIjn7rci/NYSaN1iY59D+GOPw5u/4SRi7jZEoP2YFrtYsHke41g
         FW/O2CmMXwo97xrArggkVyq6ZA+X43HURf3z+iWd7J2DXyRw+GwuAqBLGHCLWlBJXAtB
         +8ZP8EmsH5LT32uXQr74kts/+y41zGW250saKazdRp6lUtsbs8McIC+gqRyxGlp/3Zce
         zie46y/5pu6vXgNopg62q5lCKXvdOw7J5Yro8630r8Un1Iw6AkNup9iTN4POSZiOIVps
         TKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPsWHj/nIJcxYnnxqZyGwG3YE6lItJ3VM0XuMxV+XaF7S0TQiaTpa3NO1CmUE2I98reUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRkFWey0peAMJDWh9wjE+nlYdo734g9rwz7ZsA9CLE8P0cC8I
	rhV0Ahgn/+3lMiGwQQfIs7ulROoGVghOKpir57hxRrxjusmSRYr8xU2dptRwZtdr5SxR40YeiNZ
	x87K06A==
X-Received: from pfbly4.prod.google.com ([2002:a05:6a00:7584:b0:829:80c3:3c94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac0c:b0:82c:dc17:2918
 with SMTP id d2e1a72fcca58-82d0da82ec4mr16087412b3a.13.1775568024017; Tue, 07
 Apr 2026 06:20:24 -0700 (PDT)
Date: Tue, 7 Apr 2026 06:20:21 -0700
In-Reply-To: <CABgObfaFqrSENS=_eNgkyxebqL1vFauNqG3XAgZm0EHfkbQ_gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com> <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
 <adPRA4ZhnvbaXSn0@google.com> <CABgObfbLm3FR4f_nv5EyYJx4jwfeBaVgTLhr7P++hmhCP98e3Q@mail.gmail.com>
 <adQs4LQgy3mS2t89@google.com> <CABgObfaFqrSENS=_eNgkyxebqL1vFauNqG3XAgZm0EHfkbQ_gw@mail.gmail.com>
Message-ID: <adUElWItuaghWj89@google.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Kiryl Shutsemau <kas@kernel.org>, kvm <kvm@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-coco@lists.linux.dev, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Paolo Bonzini wrote:
> Il mar 7 apr 2026, 00:00 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > > > .  So unless I'm missing something (or hardware is flawed and lets the
> > > > guest speculative consume R16-R31, which would be sad), it's perfectly safe to
> > > > run the guest with host state in R16-R31.
> > > >
> > > > That would avoid pointlessly context switching 16 registers when APX is not being
> > > > used by the guest, and would avoid having to write XCR0 in the fastpath.
> > >
> > > For now yes, but once/if the kernel starts using the registers there's
> > > no way out of writing XCR0 for APX-disabled guests in the fast path.
> >
> > Why's that?  So long as KVM uses vcpu->arch.regs[R16-R31] as the source of truth
> > when emulating anything, there's no danger of taking a #UD in the host due to
> > accessing R16-R31 with XCR0.APX=0.
> 
> Yes I agree with that. But the unavoidable part is the XSETBV because
> only the assembly code can run with XCR0.APX=0. As soon as you go back
> to C, including during the fast path, you have to ensure XCR0.APX=1
> again if the kernel is compiled with -mapxf.

/facepalm

I got so focused on register state that I completely forgot about actually
using the registers...
