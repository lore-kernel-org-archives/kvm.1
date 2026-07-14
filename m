Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9642BE90
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057371; cv=none; b=AEBlHl+ZX56AWDoP7KMy5jaaxn6m/iCIrg/eMDLE2SE/OCXN5kLuOc3ZDoPXuBJ2rOA4ccJIxTY84u+6Q3VJgNor+/CoD4PTqVkuTIiIIJ5PmlVMPsexwp+a6gB7sv5vPxYxF7K0TRaGO5fKlvq2NTMXsEHfj+3+nu2iCnubQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057371; c=relaxed/simple;
	bh=tDg4wl0W/Si3x5qXM8/VUYRL5A+d1JQuaPD8sj4bEHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NU9EiSK+ASu6kJjfIUxE0YpXVFuOKB6RbiE4L45UV3FaMix7C7m779gabyItp/04DYmgguGPN5VKLz4VzNO69l8+8eTU5vazbqorI0i/O7VteDEazizjXFv5ZcNAZYuyh8Yp176w5prfuH84vHKnaxTgELhaejW6/SUpMWKtEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkU3xmfp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkU3xmfp"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1584833b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057367; x=1784662167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ss7g3eD7npKIlK1jpim9LIPl59c3dlvPKOBpcKadRME=;
        b=fkU3xmfphMRMM94Vh0Jrv4oDnOF/EFoMnCMpxI7VSH2zCknNXPAJcRWfjowf14PbsE
         erCOn/3MkWIFmqgzzOiUQi30uiAJFaPxWOhVLgGosAVg3esVHr8Sk081hOaNQooz5wgQ
         gL5acRpdhwOj20yqSdIl/+amHu7LeVSMO88mcyihm/e0oD9EWY+Yr2jjhSIHy1P92mBf
         1l5kQQZ4kwGuxQDrFCTcnD2UuT/kRITU+oxasGLWkybSnjhzahfkmrNmRt4xS7Ks1gN8
         irpVapihUmdipN6h1R2p4mlYQ9yeHm4YabYXLpJdCZ+3AchBszzsW3JEBzC+5o05BAhj
         b7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057367; x=1784662167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss7g3eD7npKIlK1jpim9LIPl59c3dlvPKOBpcKadRME=;
        b=T+wqm0/1pGhJU/fkF0gIcjMDUGLAdAocEXnYZY9SHU6YmNe0gE12eX6SoJ21O/JFBa
         EF7CsC3TvmI9wqaCIyFoFyHJQcAFXKQsHr/1FH3eXAA5t8lik3M41MJD5UbtgGiedbuu
         joUNJKLaTUEqZlpp6rUE+SXJcrB+YcwjtUAffIA4Dl+TKKDrTRkhEscZTTyBIViGHA53
         MnSHle2bF654ZPv6ep4Siubtzhf2sE93R3tqQZpm6mYM1dgoLGzwmgPdxdZli9rl3893
         NMzvyomib72UdGzkymkJquCi47rnPAOe7lTQkp2z3SjFZ+qCpGDeLklFAD3IFLLtnBRD
         vYjA==
X-Gm-Message-State: AOJu0YxkBeazHnGiZgYd4Rl7mcSSo2P5BGl/BmOjGvXBeId42vEv/RP4
	vnRrHnxAut/i8h1jxyf+VDjV01qZbCBT6hy+851n2rcWmsl4XtcOvHG3Dl2rdx8erHObfTPC8XW
	U3PBXZg==
X-Received: from pfbcu1.prod.google.com ([2002:a05:6a00:4481:b0:848:8827:5d12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e24:b0:848:65fa:542
 with SMTP id d2e1a72fcca58-848898081aemr13875831b3a.53.1784057367070; Tue, 14
 Jul 2026 12:29:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:23 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405361325.3123550.7477828012411654626.b4-ty@google.com>
Subject: Re: [PATCH 0/9] KVM: x86: Spring cleaning, part 2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 25 Jun 2026 15:04:41 -0700, Sean Christopherson wrote:
> A few more cleanups that I wasn't able to get out in time to catch kvm/next
> (almost all of these are the result of code review feedback).  The main theme
> is again trimming down x86's kvm_host.h.
> 
> Sean Christopherson (9):
>   KVM: x86: Move the "APIC attention" macros from kvm_host.h => lapic.c
>   KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
>   KVM: x86: Pluralize the macro guard name for msrs.h
>   KVM: x86: Move CR and DR macro definitions from kvm_host.h => regs.h
>   KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h => x86.c
>   KVM: x86: Add static asserts to document connection b/w TSS structs
>     and macros
>   KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
>   KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h =>
>     lapic.h
>   KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.h
>     => hyperv.h
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/9] KVM: x86: Move the "APIC attention" macros from kvm_host.h => lapic.c
      https://github.com/kvm-x86/linux/commit/26c877c70b57
[2/9] KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
      https://github.com/kvm-x86/linux/commit/eb4b67c93472
[3/9] KVM: x86: Pluralize the macro guard name for msrs.h
      https://github.com/kvm-x86/linux/commit/8821646e292d
[4/9] KVM: x86: Move CR and DR macro definitions from kvm_host.h => regs.h
      https://github.com/kvm-x86/linux/commit/eb42c91b6546
[5/9] KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h => x86.c
      https://github.com/kvm-x86/linux/commit/eb7313b66c59
[6/9] KVM: x86: Add static asserts to document connection b/w TSS structs and macros
      https://github.com/kvm-x86/linux/commit/de28ef6548a2
[7/9] KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
      https://github.com/kvm-x86/linux/commit/0bc5f998e18d
[8/9] KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h => lapic.h
      https://github.com/kvm-x86/linux/commit/c3d35340a337
[9/9] KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.h => hyperv.h
      https://github.com/kvm-x86/linux/commit/ed6ee602bceb

--
https://github.com/kvm-x86/linux/tree/next
