Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DDD194C96
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805377; cv=none; b=lbHE67HdpoS89RbDErkhJZFQOnKVi5vEntCBUftZyxT9du3uE5sfk4kejUhYfO/E6RJ1bkkDSUDc+Pe7hH04fKJiKuDpwZnz0iSj3zC/azbmf5kcxL3pwCTQRDETKaKj7pvNaooKYWTx8n930H42Xdh6wczDTJwU+S10+hNDrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805377; c=relaxed/simple;
	bh=uj/Ek/OIU5KyWXwpRCvmuocnWKlUHMxQcaw3LAX4Q5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCCRgzQya1uQ+UmzHGlsKh91iF3P9k5+eN2aXnLEfXTIkUJgMJaxP63aPZTHAG5JXN+EkuPoz7yg7c/db20ygmokGBywv4XUcQywVQBkE2Wk+dFebEFOnMYPHSLkxI4Mtpm2vhyBpbBW4BXc97MQc4jvX1AgBKGcgL8Z5aQKCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XChayiNg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XChayiNg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso2526542b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776805376; x=1777410176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2A6E2FR5vQkEE+JGi0ud3Ckpr+NANcoJp/1DbuTKLw=;
        b=XChayiNgW3J7FgN0Fs+LoOJCpGTkdOxoH5ZQvx/KDU6gNEVxk2USB5GzWOSuIy1DRa
         YRqAVJPcl3GGtsX3imkTQJA3UcRqQgTJdoC9O35zwUbq7ZlKyPd6PvIJX71H1Rt3y3S1
         O/3MINMoaqkLPT/Hf3pXj7FVcX4e6ds/8ePL6lozgVbYApAwgdTeubo57PSDFQYRHJvG
         R7zDThs2G23cMRQvWznty66T8W1krqthcWm89eA35tiuAl7kRObQtDFmEAnnZDqtFloO
         MNOroGZd2Q3doP0Bg7zfN8gXiXB+3dzVh3oTw3ARVZHaV2AophAX+criT9BIPokA27nN
         9tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805376; x=1777410176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2A6E2FR5vQkEE+JGi0ud3Ckpr+NANcoJp/1DbuTKLw=;
        b=NbfAdFXoZNSrI58wpMxaVKhL3JjyF++5GBELIP+etU3fv5UBZXyxDXBtg1A18IvFlz
         NFcBVOnxKF4efyXLGeamjEfrpTHjpSdNvQNpoYtSwq+gkMEOuCsXYExELwPdMatXSXlE
         wIUvBvMH6lb6C6W5EPtgUnOZoBS8kozR1nUqjVt/HfM+MyYShHWn7Xb5bpSGRYEkerc8
         H/6R51bQ2/TSUPGIhrvdiBCWuy/c8Epm8qqmPZLu/ZmwBmffKpPLWsFgdGJ/a1++kEff
         FtNFdFvDQVkgxzyst0c3Pd0Xu3CLJAJido7YUTrqNwfIeh/kP5XUmZ4jhnHqdtSVZJoz
         ZKhA==
X-Forwarded-Encrypted: i=1; AFNElJ+QsAvtjuvJg1JVgeK1rdgk5fMdS7kZU8PPs+RE/DCYYjHCB7o0BDCiVwqaHpCwX9RqTc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoVqT36BZWZl8jDCE7NOe/zTf46dLM9HepomrA0SvXSPyj1gT
	eB3DENC2j7yVxGfkkL1AMphn8OP8dPkQ0Dlf/+UDQbbCUL9VdM4axKjKSazZ9u7/dEQO5uKP67Y
	t+csRsQ==
X-Received: from pfbk21.prod.google.com ([2002:a05:6a00:b015:b0:82f:790c:3922])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b87:b0:827:441a:c970
 with SMTP id d2e1a72fcca58-82f8c87e33amr19111815b3a.6.1776805375320; Tue, 21
 Apr 2026 14:02:55 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:02:53 +0000
In-Reply-To: <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
Message-ID: <aefl_RDA7T58u6_i@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Paolo Bonzini wrote:
> Il mar 21 apr 2026, 19:55 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > > > FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXIT.
> >
> > Hell no.
> >
> > > I know. What's the point of that VM_EXIT_ACK_INTR_ON_EXIT exercise? Is
> > > there any performance benefit or is it just used because it's there?
> >
> > There are performance benefits, and it preserves ordering [...]
> > NMIs are unconditionally "acked" on VM-Exit.
> 
> Not that I disagree but...
> 
> > Even if performance is "fine", changing decades of fundamental KVM behavior is
> > terrifying.
> 
> ... it's not decades, ack on VM exit is actually relatively recent (10
> years out 20 :)). The reason why it was introduced is another killer
> for the idea, though. Posted interrupts require it,

Oh, I forgot about posted interrupts.  So yeah, what Paolo said :-)

> for some reason only known to Intel.

My guess is because the ucode that morphs the notification vector into posted
interrupt processing is a sub-clause of the ACK flow.  And from an architectural
perspective, having the CPU ACK/dismiss some IRQs (notification vectors) but not
others (everything else) would be kludgy (even more so than special casing the
notification vector already is).
