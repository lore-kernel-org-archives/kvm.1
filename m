Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605B3859DB
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440231; cv=none; b=bQO9b4U3vqiOWRsR6f6wf3LUvmuwWytFyQpKr6mg9SB8n5g8Sj7wMIm+/dcaJ28qlerv7BxAJETCmb92NHxpoBp/myoxCi3w1iWNfHyWU3r/Tqq4hyOkfwT2xfCjEQO0ZLhl7teTly1YJK26OVVeEm2WoWU2vzU4TazyfyUtBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440231; c=relaxed/simple;
	bh=IPH5Ej3PDUUNxCzPQNelFX1QxXieJceC0jZ3nnZPpTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VrvdxG4m12vW/L+dDtwl9XqvSmWnROA4GKPp2wrXMkmbpbKGUf8rNv4GL4HQn4aSS58yeMHSt17rc2gAnSq2SwaI5TuvULiulQtvdhJY0LRGOsewbIdCFKy3mBB15HFVUq0os20lQGbVKVS2Der0bQ9+xfRe5/qzFbg6MhS8Llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXi9ehdz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXi9ehdz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aec6c572fbso146465625ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773440229; x=1774045029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT6d3N37fL+kvB+pZajEl2dnTkN9RP3PeWa3L8uub+Y=;
        b=QXi9ehdzNQB40Opn+QXxQCEhfXtZQfR0nn3e3cRtg+s5/FlA09vfa0gNHIns0l2gqL
         JpMcbORz3SjR3KscBqCuxNagVwwmNKo1ODGLsEnuOPrXE8TG8/huYUocyfLckwo6yvpW
         bxBI3H8ul7Pg8vmccsk2hCZdlu4FxZnWb1pxyKcSd+jQrY7BD9XFqS4fGSwPVoMSuEUS
         PNKgDc1kIJT+YQ+S4SJZRKPChOz48I7o57Z8CO0wfLqQbXL9A9H+eis/9Lqs7lNCU1p5
         0CTo+z1F7j1QsEuu5cwOU9AHsTQM71EMWAvYMjJjindpe79h/5oMcdNikGevjMV6wyw8
         mjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773440229; x=1774045029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT6d3N37fL+kvB+pZajEl2dnTkN9RP3PeWa3L8uub+Y=;
        b=JEBx0Z2lk07jFLCpnWYAsS164+XaJq+Vs5nuajTcgwLuQ1wyh7xlL70Pts5RkleoCD
         cMQEso7hDvh6Dj/fmbJvAmoeXyyDluPButM05Jh2UZWz3zxSaSsEzZxdSFDEusQZrIy9
         c1zuesD6eMInZqVw9vQeiumlj6r6nOLEOAFPU3oWLdpgva5qdN/QmKSXuy4unDFITD5p
         Yb4eVjN/4LVcXIfD8u0AGn1UP+3peN8ISE6qUyhqRoRKesUxMYc6sP3JeqKDGjsH2wpr
         wMkWoGn1IIk6KCPsq5NRalhHP/Cis+enRZXN25RNuWVOsVIEKbWtJrdQdkb0Q0temfMD
         2rAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZdiPWHrbsn8ieXHRESS+LzG2P3S/lZj2VmDR4xkJvvP5dh93JpU+/FXPNZjDmVT2xGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHgO5FEvJVYX8LICz1x32zrh7iAXksYcn9Te6dYqkqsVhK1Y0
	9vi7YzVPjoBXlJB+h39GRA44GLgttrqrsOMM8WElFBP/FoSSoyLRHVJTTaxkECSOhMKPfKgnq/M
	cG3s0uQ==
X-Received: from plbkh16.prod.google.com ([2002:a17:903:650:b0:2ae:4e8d:56b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17c7:b0:2ae:47c9:68b9
 with SMTP id d9443c01a7336-2aecac4dedamr45715115ad.49.1773440228916; Fri, 13
 Mar 2026 15:17:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:17:07 -0700
In-Reply-To: <CAO9r8zOaUM+TBcQO=6k2Nt5=VauiDifCU2JvhUpts_VGcPSYKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com> <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
 <abRwSJHJ9yS4XAx7@google.com> <CAO9r8zOaUM+TBcQO=6k2Nt5=VauiDifCU2JvhUpts_VGcPSYKw@mail.gmail.com>
Message-ID: <abSM4_uF2Px7h-iu@google.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Yosry Ahmed wrote:
> > Hrm, I was assuming the compiler would be smart to understand the other cases
> > are unreachable.  What clang version, and are you doing anything special with
> > your config?
> 
> Debian clang version 18.1.8 (20+build1)
> 
> Nothing special with my config AFAICT.

Lame.  Given that it's Friday and I'm about to become a pumpkin, and it doesn't
really matter if it's compile-timer assert or not, I'm going to sqaush it to this:

static u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
{
	switch (msr) {
	case MSR_IA32_LASTBRANCHFROMIP:
		return &svm->vmcb->save.br_from;
	case MSR_IA32_LASTBRANCHTOIP:
		return &svm->vmcb->save.br_to;
	case MSR_IA32_LASTINTFROMIP:
		return &svm->vmcb->save.last_excp_from;
	case MSR_IA32_LASTINTTOIP:
		return &svm->vmcb->save.last_excp_to;
	default:
		break;
	}
	KVM_BUG_ON(1, svm->vcpu.kvm);
	return &svm->vmcb->save.br_from;
}

Can you double check that kvm-x86/nested builds for you?  In the process of
rebuilding kvm-x86/next...
