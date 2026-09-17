Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708451FF5E3
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603933; cv=none; b=sOSAXSN6JCzBQn+UBaEN0EpeQqAbAhBqVuTiqdwQelraQZQLv7XCUr9QiZiOW+Q1vQDe7lCEvBBcHs1dpoHMTxmAGRQnvyNSImBxiQd+VM5ZeHI2BkosQXDDWOIjkGNp2ygZDDCztviSIdyq/XLLSnxjV1+k6PrfyU3MZQqiwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603933; c=relaxed/simple;
	bh=HozO84mXGPcKS1igoe/VwSJOG7i5lKGoSVIesNmNWWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WN7E3kV1+FGtLjLRIaZzM3j2TkPyN8X8cW469L7b3obaBIJmQ0SujzX51MQvG3Qvv1SUjqCsmzkC3lYdi6pSqynfMOl0tHiyO/88Gl6aoQuWjyrECL0MEjkUZZ89mYa8KrbVnhUJZpwXQ29VGdsRdnRSbP2U+RNN7n7t9AU6Svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIi8kwNO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIi8kwNO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so350108a91.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789603932; x=1790208732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6iDNH5wuGoL3/bmQAOC4Dn6hjBP2bgu5FvPAn8HKIQ=;
        b=PIi8kwNOUE05OJOvW+p3JD2hKWNLG6LeG5NF4sm0t9pkSoAG3uIET79vZnP5gMjcnK
         1Eg2mLY2GQZTsl0v7MYHN19VLBn34tsaRZawG3pLH0K6jtmrCs6dSLwoF2kZ5ptsPxm5
         E4UjpLnrAyGbeGOSCmFxvyXMYW/6iQGsNizi7mityK33Qb5jfWqSwnr2xgAxOwa3xheb
         ZzRBj5eQXvr14wvds5IMEMcczqTCb1oEoYCTbRhG0Ka1tNqxA7XUFkvirSEGQNfg7b6+
         WagWMif4BuHJ3ByIhnNisFNYLrjFBQdm8PDe58XDeb+commwjD4Klb7oQMlXDCAJeE+6
         FLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603932; x=1790208732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6iDNH5wuGoL3/bmQAOC4Dn6hjBP2bgu5FvPAn8HKIQ=;
        b=W11r3Uc0uzEN92slMo6sslFP1dmWamFWK40tWBV3Tlh2zvi0l7gnhsCw7JCKvy5GXt
         rA16eCxK2Wwj5EKz76DF5nD+mQgbTAH+kCYupQbCA5M6EwRBqJaYAh2QPnQLQo4jS8cW
         BYXpDPT67OxzsuKX1Y7R8jQG7Tl44dJ+wXOyoJms90tZ/fHCqXtkjr4W0ZqjKZ7fNniE
         WSOyIlrGnvx5SX+d2DurYiZUK0GoiO6E2hTOFMojotqG7aTf5yIna+Jr0YiCb8fz0yTx
         56AhyLXwvYQy4Lrh6Fxi7t/xu9wvjy8f4L0V8MZX7zPIwL2FFtGIVJkIzjV4a9VbD4nJ
         OXpA==
X-Forwarded-Encrypted: i=1; AKwUvBx7ZGtEhVtpOd1ugAVCMIr3pgPn2F+xED4GtISh4W1/C+cz7OpCHYyCGqcLgpe12eCLIy0=@vger.kernel.org
X-Gm-Message-State: AFuF++nDBuQfb/qwAT2rKRrF3d9YhUUxIvl5yzkoT6KSBjvPAyVRtDvj
	bvodb4xvIOVO1lPMVSJge2J8B+slcLAr0BVzI3JoD4fsNyDHhGSe/DfKnKAwi/gu62K7ReglnjW
	yMjO25A==
X-Received: from pjqf7.prod.google.com ([2002:a17:90a:a787:b0:39e:18b3:6422])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6cf:b0:38e:7168:281
 with SMTP id 98e67ed59e1d1-39e1e329409mr10995151a91.10.1789603931494; Wed, 16
 Sep 2026 17:12:11 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:12:10 -0700
In-Reply-To: <aqe4QCxIhcoBL+po@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902230932.2760127-1-seanjc@google.com> <20260902230932.2760127-2-seanjc@google.com>
 <aqe4QCxIhcoBL+po@yzhao56-desk.sh.intel.com>
Message-ID: <aqswWjRN0_G-xyGJ@google.com>
Subject: Re: [PATCH v3 1/3] KVM: x86/mmu: Use KVM's max TDP level to determine
 need for 32-bit TDP root
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 14, 2026, Yan Zhao wrote:
> On a separate note, though it shouldn't be a real issue, is the below change
> necessary?

I would say this is technically correct, but unnecessary, because I can't imagine
any 32-bit guest firmware would try to relocate BARs above 4G.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index bb68a021cfaf..abbba26dbdc6 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1810,7 +1810,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                         phys_as = entry->eax & 0xff;
>                         g_phys_as = phys_as;
>                         if (kvm_mmu_get_max_tdp_level() < 5)
> -                               g_phys_as = min(g_phys_as, 48U);
> +                               g_phys_as = min(g_phys_as, kvm_mmu_get_max_tdp_level() == 3 ? 32U : 48U);

FWIW, if we wanted to do this, my vote would be for:

			if (kvm_mmu_get_max_tdp_level() < 4)
				g_phys_as = min(g_phys_as, 32U);
			else if (kvm_mmu_get_max_tdp_level() < 5)
				g_phys_as = min(g_phys_as, 48U);

but I think I'd prefer to just leave this be.  Rr better, drop 32-bit kVM support :-D
