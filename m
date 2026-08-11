Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326B45C6F8
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469338; cv=none; b=AJ/oTn4a4FHVYST6YgOOthIMLlQzHxEqcs6M89uHm3Mtlg9BTDe41G+M1+r2vn9cPPPDbnp20GVu+j0BPYl2/ipAPkY94QYoV+pzPNkIWXmADVqcXwTdTd8kejRz1DfVZzY3Duyr7zsQgD90uHLKLc0sEBi+Bm9anEbksdqCqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469338; c=relaxed/simple;
	bh=gEPHLTrISbAwWv2wzSbXTZKZJ71uRtEhHNVm+uhlAPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZTj4YKdLH/7zFqAs+iTJPTSZ6Yp+MjIBNAcXhRgGFKFO5Kf5GnI9Ce3ZGpDFdk07afCx1OCDTxvpS4gRMZblrllUln8il47a0k5VDxEVx0/yTZxx6eryKouAyjDZjXvzeFhcjGDp1mCts9zearjlu3EEprx5ckLjTfpDAZDKJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRH3hL0u; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRH3hL0u"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso2289085ad.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786469332; x=1787074132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMDt/Sj6YjXvFiWQr62Lu+RNKL1NV+pa3PqCNwc1t5I=;
        b=cRH3hL0u7KwkHEw+Ah/fr3udLdHkRuuhpmHOOLbBJgKQWvUtMBtLW0AbkOoyuX+IEC
         G+7Fdbl5YuqDXzmS7+FTZRa3GmQna9q8ttfkJNncc0w7hxacywXKle4qZIbG0KCidu2p
         g6034ZQgJKBzJlqA8LXqU2vEl9XCB0/z1ldb6BOFo6EC4bByA6HUjILzyD7kU/S8MEnH
         REWhFY3IfVYRiyCqzfEHLxzgDkGKj00Sl0Jf4V+6fmJsQQze+QeK5/zxNWYJF4sy/AIp
         ElpU0wSDW6W38QZRpt8ivbFoZEsZ6NXlJW7QsaBfzestiq6pxaqqxzH44lvqHblIbafa
         6qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469332; x=1787074132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMDt/Sj6YjXvFiWQr62Lu+RNKL1NV+pa3PqCNwc1t5I=;
        b=ist/nxtfjKxfZ31ZWgKvniurlX0R0xhmNLlzrRyEzyVy48tDGwN9DnILqh8o4M0ZHz
         R44Olt5fr0kjoAlalmJavQMX2gkF5VlpK+M9vUdQpmyIDJQDG65Ir77H1Ml8yL7ItK2a
         Wr6QSKwPoMcBMlkElcDrRcmStenkWg6PfBT4KSZFqVwxXBKclO5MC9Vsx8+DADXFb9Bv
         ItZuFONrPwnrFBtEII9gEN0t0Q3q1FeAaJL22AYiGeBMa8pKenzaejWCSBlq9t5TIjM8
         6uHZxr3BF3pGJOY3PnLY7GdOtDacPeGxD9Irrer40G8lKvyu6OrOoZfqWWVrIWu5QvNx
         TH6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr7CHGo+6SzpuF2OM8uVF2mkjUGC23noVeFopFVBUq77rtDx1gE8V5HMECMDy0pOwtz0NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0AXgbukVTnSnytUQ8KjXoQDPbQQvSYZQyBcLWS+F7K+7oUOs
	22wFAeRWDqXnmryy75tJftKFDhpzutdqRK8OiYY6cKi0LW+4nYSivgLeakzXlyo8TJL7e0j1Fyh
	HMWNBvg==
X-Received: from pleu12.prod.google.com ([2002:a17:903:41cc:b0:2cb:97d4:2e28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:350c:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2d3177f6e83mr61151075ad.7.1786469331912; Tue, 11
 Aug 2026 10:28:51 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:28:51 -0700
In-Reply-To: <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-18-dwmw2@infradead.org> <anoOz2rZ02KFk1l-@google.com>
 <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
 <ano6-gIZtqMfipiD@google.com> <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
 <ansuqrD2KwFuLWbV@google.com> <ansywxh0VX5rtfWc@google.com>
 <e256fa4af96e916ba30019cbba501fa896025fb0.camel@infradead.org>
 <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
Message-ID: <antb01WqOrs-tztm@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 09:40 -0700, Sean Christopherson wrote:
> > 
> > > 
> > > FWIW in my local tree I've just extended the pvclock_migration_test to
> > > test precisely the thing you were concerned about: three vCPUs with
> > > divergent TSC offsets, migrated by setting each vCPU's TSC and then
> > > invoking KVM_SET_CLOCK_GUEST once, through vCPU0. 
> > 
> > I wasn't actually concerned about migration, I was concerned about time going
> > backwards from the guest's perspective.
> 
> But KVM_[SG]ET_CLOCK_GUEST is *purely* for migration. 

Huh?  I raised my concern in the context of "Allow KVM master clock mode when
TSCs are offset from each other", and AFAICT, nothing ensures that won't cause
problems.

Aaah, it clears PVCLOCK_TSC_STABLE_BIT and relies on the guest to clean up the
mess.  So the guest won't see time go backwards, but it could see time stop for
an extended duration, or jump forward.

E.g. if tsc_timestamp is set to a per-VM value, and vCPU0's offset matches the
effectively offset, but vCPU1's offset does not, then vCPU1 could see time that
is either far in the past or far in the future when doing __pvclock_clocksource_read().
If vCPU1 computes time that's in the future, the guest would see a potentially
massive jump forward in time.

And after that, or if vCPU1 computes time that's in the past, if the "future"
vCPU stopped running, the "past" vCPU would see time stop as last_value would be
ahead of the "past" vCPU's current time for a very long while.

	if ((valid_flags & PVCLOCK_TSC_STABLE_BIT) &&
		(flags & PVCLOCK_TSC_STABLE_BIT))
		return ret;

	/*
	 * Assumption here is that last_value, a global accumulator, always goes
	 * forward. If we are less than that, we should not be much smaller.
	 * We assume there is an error margin we're inside, and then the correction
	 * does not sacrifice accuracy.
	 *
	 * For reads: global may have changed between test and return,
	 * but this means someone else updated poked the clock at a later time.
	 * We just need to make sure we are not seeing a backwards event.
	 *
	 * For updates: last_value = ret is not enough, since two vcpus could be
	 * updating at the same time, and one of them could be slightly behind,
	 * making the assumption that last_value always go forward fail to hold.
	 */
	last = raw_atomic64_read(&last_value);
	do {
		if (ret <= last)
			return last;
	} while (!raw_atomic64_try_cmpxchg(&last_value, &last, ret));


> And your variant just added a dependency on wallclock time back into it

Can you elaborate?  I'm guessing I don't entirely understand what you mean by
wallclock time.

> again, where wallclock should *only* be used for setting the TSC, and even
> then *only* for a live *migration* to a different host, not a live *update*
> via kexec/KHO on the same host, where the TSC should be restored as an offset
> from the host TSC.


