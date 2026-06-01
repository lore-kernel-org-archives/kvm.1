Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811F3DC4D8
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327378; cv=none; b=a7oW5VJtFSbFoFX4gYBxKnp4ezQiDHSXSMsuxwRMuIYKbQLgL3JbSgJoYjDAZYaas0ymqkJDo/pGv4tX+uFOweI8xC4SfbcRN54Glx9sK3FNLU06epH8e7mGzrRUlgNYeHFmwBFWyqq8jOE+AUlPQkJLLiUhObb3mVN/OQevqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327378; c=relaxed/simple;
	bh=YtWMdOkhy/s8BOEAivXDRtJtPRxT79Nib+XcE0iuDgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vn8gKDjRun+OiZeOLJx0reV0W1K5WFxyaQfbF0QNgOBSDDQfNzNPdxrhQF+O0Qf2P4rCPmaLNzDQxBN5sCIC6PnFPGlS5ZoCzAIyNKkIy/MZkmsNuqofxXik46zpZMuW6KCkGujLKZaMxtA6KP6BvNePJH9nymSDDVlw5lo7JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJqm9+0i; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJqm9+0i"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so4426492a91.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780327372; x=1780932172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FrX6PZclTofes+C27r+o7tPSrpL+NY33x+S+H7JEVg=;
        b=RJqm9+0icp+72LMhuh7XrfzBEjqbqoOV5r6nahdjim3Ep8sTtFpl8eyrog7tnddtVo
         jm794+wRSdVyuRaFX4b+8flBM5fS+uFJVthgZeDGqTKLZ+tqmsxwtxDuG/CRvwYsMi3Y
         krXh9O8d7j9jNFT2ZsabcOI/Y4SFARjVTvtbBFDtYEJlfEFyRYVamX6ifGuuE8PsrLNB
         wMoSj6oMfx1NqSUuufCv7hpB0dOhdwpY8kuTN6ipzi38VRxIRRfo+BSNO1iD/BNaaTV/
         +ayjIjAEDsDGq1P0hS8LD33ubGd29SrmTn5SIGeeXRXQ4+BGLFmIo06vI6/c4Tq2N+cm
         J0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327372; x=1780932172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FrX6PZclTofes+C27r+o7tPSrpL+NY33x+S+H7JEVg=;
        b=staB3p5Z4t4UC7ll3YRB069xt5mnbnE1cCRSOaYIpZUL4NUOlb9dUmaHCFII0BUHgd
         4GBwDszOoQNFGIeAgIlHAT+LKZ5j+UernWdcLfyugB/oA+5iMNBbWm16BXYKBgovsPMu
         fzKCj0sYbkt6yT4MbwPNCHUcwhZ0/5Wl3BrYEtXGABVZT7IDcXCWQsAc0+u2fAaQFbh/
         M9eGzr3XYP0pJzstwkntDl4A6/KHr+1EqRxXpIMhyrf/vbIqRGI3XCqjCeSRWOpaEvHd
         5Bsj3tsc4bzS+LHtFkvodyF6dVxNPIK6kB7V34t5wMuATeTvqQziNGcfH8cM/dd25130
         CI7w==
X-Forwarded-Encrypted: i=1; AFNElJ+GdmYz9M63IteWa3KQxDkZ5U/bICyK/3ATZYgpIVQlNpJ9/z44kchKGNB4wObJMVJIink=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQc4bRTF2q6+hCRcnOlJoKEyP3/jH0DIAKyc8/5Y+pPLD0gF7
	7sRVEYmVdr+TpkWW9qQkS5nHlggIBlQZfkrg0jZrhFg9PVDQiWNJqFIhZ8wDZ2Y1Ua1kO/pyZ1i
	nHDpp9g==
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:365:eb99:afdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e7:b0:36d:70c8:3a3
 with SMTP id 98e67ed59e1d1-36d70c80687mr10451955a91.15.1780327371493; Mon, 01
 Jun 2026 08:22:51 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:22:50 -0700
In-Reply-To: <aho4YC1ufeX14HCE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-37-seanjc@google.com>
 <aho4YC1ufeX14HCE@google.com>
Message-ID: <ah2jynIp6qVBNJCd@google.com>
Subject: Re: [PATCH v3 36/40] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:22:19PM -0700, Sean Christopherson wrote:
> > Move the function declaration for APIs to get/query pending IRQs from
> > kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 5 -----
> >  arch/x86/kvm/irq.h              | 6 ++++++
> >  arch/x86/kvm/svm/nested.c       | 1 +
> >  arch/x86/kvm/vmx/nested.c       | 1 +
> >  4 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 866d33abaee0..38de6c0dc743 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2360,12 +2360,7 @@ enum {
> >  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
> >  #endif
> >  
> > -int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
> > -int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
> > -int kvm_cpu_has_extint(struct kvm_vcpu *v);
> >  int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
> 
> kvm_arch_interrupt_allowed() is only used in x86.c. Probably it wasn't
> used outside of x86 code after a1b37100d9e29c1f8dc3e2f5490a205c80180e01.

Oof, and it has x86-specific semantics (KVM x86 very much relies on 0/1/-EBUSY
return values).

> It should probably be renamed and moved, maybe separately.

Yeah, I'll slot in a patch to bury it in x86.c as kvm_is_interrupt_allowed().
