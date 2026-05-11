Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D240243A
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514175; cv=none; b=VQbKI8SxkNqoWhSAIVXBHC9v+2ev3xZMmSdz9mjxuBLQX/FpoN6tnBopO0D8UehBrgXcrkW1r9oMqayqZX49inMBsklXM1buB7xcqVs2gp6gtsy/JnFWUG2ds8ea9ICFRIuz72KKLDn4JzoDM4ReKWKVcECsYUYJgvZxIKmEjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514175; c=relaxed/simple;
	bh=QrWGF2r3InsIwFP1tHVgnXPsbK3KMEaHKX6mQ01cGag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bt5idEB3QJQRGx2eSQNoEjGlIb5L80y01BmmgaP1/2C3nMghyI1qUeSicYpab4W9ZKbJfTlUOSNY40TN0TlUwHdrN1+Nt4FzsYrCXqYiD74FwSfmyKxwmoPH/4yS6ncXU5kALnXBvvFkhA0QABi/bOFk/TlV52fCjXeyF8bRnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIVWZ3Cc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EIVWZ3Cc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827c0aac70so1002699a12.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778514174; x=1779118974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=povdpx6ak3T2go9LlAuZJty3/UhHDgRkjg9b29stBSc=;
        b=EIVWZ3Cc+o23ZXd8Te3lxlV3cIqpBTKYzx5q09oL4Eo18fXUtPmjMATBwNQ5C9BRFD
         W32c0bhMzua5R+gX6rK18GG7JLo2yfV8fY5m4o1gSqGwzwdsV64PFGjfo4JxdQByhMLA
         kBNY9NUkqrV6UVHrv662kVAJv6Czh5ZCrZtZWp6PYk4UmOEbhd4VOd5179ziQjpAfeme
         zHoqAEHQrrMylF+wpjLjJEqJeUGjpipChJPn5Xf6+Flrcz+H0xEoPxHfQLXfmCmXo+Mb
         6i+BB+mngC5uA568otodBFtiLYdxt4Q/nqW9Kb8gpxqYIIj/4ffvBihAnCuvD32Jw/Zi
         00UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514174; x=1779118974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=povdpx6ak3T2go9LlAuZJty3/UhHDgRkjg9b29stBSc=;
        b=ibQfpBu+AhLyTJAm9GwMULHqXTjaTBdtGuEk+MUj5+ljLJc/8NXXztH7KRZ+lUNXfd
         ShLsadZ4KCfEQ9cqfNeJowzF8XL4X/JyzCbv0E8SucLSunHpwl+bUhD9vXgcS7RFZV0r
         7y1ye5I0SiSHMLyQX0FuOE1C+wZNoniOL07e07dttbEFew16oXPkleayJG0bvl64PZkQ
         GDaL/dSIWJUXsLKjry8Jk44RT8B3cchbe3tA2ARQuvwl23JXsSO3Vs8okwFOm5H1rEd8
         Px4R8uoLLNkekAbyxAJ0Ev4AOiNRy/f+dbqvarXo+gb0ksZj5/tV0pPmze8cR/EfchHx
         Tz1w==
X-Gm-Message-State: AOJu0Yxilpuw/3iht56BnWvHOsk3ehwkc6CoWE+MZLlEleEQ4Wakh05s
	TKCe0PaG0P/8tNGCtftUSASLSZaA5zAA+mV4Xqa5+fH5M+IxGkt9WE1i4j6WdVsUIPKHmEkwDFz
	Dd6TIDg==
X-Received: from pgch29.prod.google.com ([2002:a05:6a02:509d:b0:c74:664d:4080])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:3a0:b65a:5df5
 with SMTP id adf61e73a8af0-3ace1fd2d77mr11622637.30.1778514173645; Mon, 11
 May 2026 08:42:53 -0700 (PDT)
Date: Mon, 11 May 2026 08:42:53 -0700
In-Reply-To: <agH1NMIENm0CIN9t@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
 <9b859ab6a6b59e5ccfdac741459117996fe2da6e.1766066076.git.houwenlong.hwl@antgroup.com>
 <agH0itaqWpc90adG@google.com> <agH1NMIENm0CIN9t@google.com>
Message-ID: <agH4_fcwwIX5_PNs@google.com>
Subject: Re: [PATCH v2 2/9] KVM: x86: Set guest DR6 by kvm_queue_exception_p()
 in instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Sean Christopherson wrote:
> On Mon, May 11, 2026, Sean Christopherson wrote:
> > On Thu, Dec 18, 2025, Hou Wenlong wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index ab298bfa7d9f..f33ce947633e 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -8925,7 +8925,9 @@ static void inject_emulated_exception(struct kvm_vcpu *vcpu)
> > >  {
> > >  	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
> > >  
> > > -	if (ex->vector == PF_VECTOR)
> > > +	if (ex->vector == DB_VECTOR)
> > > +		kvm_queue_exception_e(vcpu, DB_VECTOR, ex->dr6);
> > 
> > This should be kvm_queue_exception_p().  I also think pivoting on DB_VECTOR is
> > the wrong approach. 
> 
> Gah, never mind, didn't look at the next patch.

Actually, that's a good excuse to provide kvm_inject_emulated_db() in this patch,
even though it doesn't become truly necessary until the next patch.  Eliminating
some of the code movement in the next patch will yield a smaller diff, and make
it easier to see that there's change in the !KVM_GUESTDBG_USE_HW_BP case.

@@ -8976,23 +8998,36 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
        }
 }
 
-static void kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
+static int kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
 {
+       struct kvm_run *kvm_run = vcpu->run;
+
+       if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
+               kvm_run->debug.arch.dr6 = dr6 | DR6_ACTIVE_LOW;
+               kvm_run->debug.arch.pc = kvm_get_linear_rip(vcpu);
+               kvm_run->debug.arch.exception = DB_VECTOR;
+               kvm_run->exit_reason = KVM_EXIT_DEBUG;
+               return 0;
+       }
+
        kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
+       return 1;
 }
 
-static void inject_emulated_exception(struct kvm_vcpu *vcpu)
+static int inject_emulated_exception(struct kvm_vcpu *vcpu)
 {
        struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
 
        if (ex->vector == DB_VECTOR)
-               kvm_inject_emulated_db(vcpu, ex->dr6);
-       else if (ex->vector == PF_VECTOR)
+               return kvm_inject_emulated_db(vcpu, ex->dr6);
+
+       if (ex->vector == PF_VECTOR)
                kvm_inject_emulated_page_fault(vcpu, ex);
        else if (ex->error_code_valid)
                kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
        else
                kvm_queue_exception(vcpu, ex->vector);
+       return 1;
 }
 
 static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
