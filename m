Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584C3A255F
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625167; cv=none; b=AJ5ImPldmkxN0N3RyOE8viYifz4bmK9R1EAAo8MnJFaNtmjwGFLxvKvQGjM7zFX3hfBZsC5LCKI+I6y/uOzuNAvh1ditJLv25qUHu2zXS4U/2XQupYNPn8we598ICEfpHrzZedHRJp1eGkTQ/qKhy+5VHWZWwaC8SLEb0510dHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625167; c=relaxed/simple;
	bh=cOnjEHkKMFpSoDE2r3XBUdHb+gmw+uj+vIqk7L+R3+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nW3NG68kk8azs/+p/Zk8+o/u/DDZ1hxuvM48xXdUfpakvLCnLJo8Xw9aimWj3ArAsElGhol/GTZpMW9ij/YAAlHUpew3j5iq6lgOWWAl34lkU7IG5Bis/Jpz0F8P5m37CS/z1YOi3MojfxnWI4PRlWNz1ck7o826SBjmaL2vjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzqZp98E; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzqZp98E"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83836443305so3467040b3a.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625165; x=1779229965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HW+R3TRETD3DPPcAIs+gc8XoOJGHnJ5Jf4G2TvPsYAE=;
        b=PzqZp98EPgy/gwpw0gI7iWjwdcj0mCU8tmRpglC13Ph4Yg8qy/95y88bqYdwXqQ/gs
         2rjB0lYmzUV+yg3dRMwapKfof9HKUScbwcy9oR9/dyDNUILxKbWrqGjN5uK1cQ42ePLg
         d+afdu1vapDkz4Dx84PuwEcmyIF+uElt3eKw+oDGTI7OLwncJwh583AUqG2Hn7dyFhKY
         QMHhxPbEvBQO3w2Pfg6E9z84OGBsFZNZBwpDFJuCcliu3Ycs2qj7OiAyychhBpS/cnXJ
         ulhDu+/QRIFpc8+G5ycECSwDQYIo3hrZx1JnusHIwaioAtKdyMHBrjv7KnoH2e96ZWe1
         8hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625165; x=1779229965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW+R3TRETD3DPPcAIs+gc8XoOJGHnJ5Jf4G2TvPsYAE=;
        b=bESULnzyuK8cLjlq+7qRItrI4ZAWpTpVHnmamW6DYQMAPbPQVz2gRRJ/KR5rG7JSiy
         d+sQR+SwEvnyJyaeAmkLfo4GV0yNcxcfnPe18FOLt5/Rf+YrGlofFWDsRqquA9o29TNA
         tfo/Jnnpx7Twi/4RPmeR0zdUUluUKEBk8aqAbtIW1nfnqcwmfFNYDLgMaKg25anzDktH
         ortpXHUZpCUUn5laKs915V1XcjO2YxDP4TN/CS+qMHp6DmErXmNUqpvEOwANNK2fRK5E
         h32I1Gd25/+0LBicIxx+n8r+WhGNvlAARUwlzc63Qq4nuYvhtjcfGGrAnrwjGre6xYTp
         pXcw==
X-Forwarded-Encrypted: i=1; AFNElJ9UrZI2XpmuWhgzWaIxjlCQMz68s/bA6HVJwaCE8lfM95vPoX7nZxi5ADK0QlS171y64E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRWYLZgBdclPlxEU5n2/pam8vL2AuvkpdfNc+EyIWRk0IvylC
	PRWbrK7zaoKYdwX2B+As/9rT3dkX8+xs5XzRNNu+ICQn++ZKihuO/rAhliwSe2cWUL5JZ2yCGUe
	mt8tCyg==
X-Received: from pfbgd24.prod.google.com ([2002:a05:6a00:8318:b0:82f:9e73:207b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd08:b0:837:666f:8fcb
 with SMTP id d2e1a72fcca58-83f0547afdbmr236260b3a.5.1778625164805; Tue, 12
 May 2026 15:32:44 -0700 (PDT)
Date: Tue, 12 May 2026 15:32:43 -0700
In-Reply-To: <24df4dabec1328591f9996f00a298660bc0860e3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423155611.216805954@infradead.org> <20260423155936.957351833@infradead.org>
 <24df4dabec1328591f9996f00a298660bc0860e3.camel@infradead.org>
Message-ID: <agOqi22wsB8S4-aS@google.com>
Subject: Re: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, David Woodhouse wrote:
> On Thu, 2026-04-23 at 17:56 +0200, Peter Zijlstra wrote:
> > Vishal reported that KVM unit test 'x2apic' started failing after commit
> > 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming").
> > 
> > The reason is that KVM/VMX is injecting interrupts while it has IRQs disabled,
> > for a context that will enable IRQs, this means that regs->flags.X86_EFLAGS_IF
> > == 0 and the irqentry_exit() will not DTRT.
> > 
> > Notably, irqentry_exit() must not call hrtimer_rearm_deferred() when the return
> > context does not have IF set, because this will cause problems vs NMIs.
> > 
> > Therefore, fix up the state after the injection.
> > 
> > Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
> > Reported-by: Vishal L Verma <vishal.l.verma@intel.com>
> > Closes: https://lore.kernel.org/r/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel%40intel.com
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Vishal L Verma <vishal.l.verma@intel.com>
> 
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>

Tested-by: Sean Christopherson <seanjc@google.com>

> I don't see this being merged yet?
> 
> Without this, Xen timer delivery (tested by the xen_shinfo_test KVM
> selftest) is failing.

And many, many other issues with KVM.  I.e. we need this or something like it
in 7.1.
