Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC63A83A9
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024887; cv=none; b=sxIx2ch/CV/8ZjG7RjN9DEpwQ2cUtVWRkbrF+5UQK70Drdq9+w/VfKZyCF4fRm3m7Dkw3SIy+6XNKWLmLGZZ5IDv9mzzTrP+JH9WL0tnbNzlgK/W7dOcWtm4FQcqSUhnOHpd2W+26hUdxdAgpmpKBzVCXkEVo09U8+ej1bM4KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024887; c=relaxed/simple;
	bh=tOGpweSDpvytxjG8ICUpA9MBJ5AuUOH1CPncR+4OrAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WkzdUu436I9p2P8efL7Ma1jQs459VKYkO1qnG51Hrftb+MQj8fdGESC3HsLldSsRuQyjoxOd0N1pH75NlVt9cTSyHJk6NmEd9WSEXEFxk5OgLpxhkFbRomAoPkAkUIB6w8GZQ3VAHFKmg1//ql3PZYYkEX27yGW+XvwP+Xnbuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOv/+I2o; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOv/+I2o"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so37547805ad.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786024885; x=1786629685; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCifv/Ja/oCMj8s+HfoBf/f+SWTBvdmMy4I6JqPIJ3E=;
        b=QOv/+I2oyY5hSqWyeOI/t4T3rN5DanuHrDQ/2pnN7nDrBVKZSd916NOOqhTymbX9SZ
         cgH9fgIwqw0nosgVCW/fObCdEu6lKy+MuHIiMATp4xreNCifvOluHMhEVuXX2neXLnTw
         RUavZqy5Ue6RcbIN+Hhtgfi1p6Pj18OAzQQXpnuCY/feb4RMZWAnYPnYa32H7tJmfzg1
         BolpcPRFctaXZewcWm+XQYb+brcF7fNjzk3CmQ79rcvqM5yLqKWPgrjiRYIylvhAWRB3
         qlenvdHRzWNFgOhqTnd/y9w+hSzAhMO4QV2jD3FO8BBewR8LjdrQUU1Cm6gUqPJrj2ka
         B+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024885; x=1786629685;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCifv/Ja/oCMj8s+HfoBf/f+SWTBvdmMy4I6JqPIJ3E=;
        b=HknLSBBS2tZuCRqswzIW0x1P4gUw4HnAKfZcC/7juJ/8dnjkFW+SnT1JiEC4WVOHky
         2Pi1lBJbx2iCPFTjuVN4RGCWGl+gF7YHhWt/lQIzWm/cNjOyUx8opdW3CxUUCbyXouo4
         n57F5rADO/1E8vf7RpW11WCfhMFE7FuosiTtVIAf8IzUnBnYo10OieYZjSXgWkMLuhPn
         gV1Dfd8lF4m4i4f4QP4ZlswWruO08iepmED8uSjNBgLFsXyZkiFBcjp2veLc1uG0v+Z2
         z2BhmsEz5AAXSNDY4xEJ+ILFfpQwQSNBWLBLvOu1foBDwaL5ygVYw4RvOTXJN07nEdCK
         bgKQ==
X-Gm-Message-State: AOJu0Ywrs/v+xJCSiqZhJj4CXJ/slNBshWyPWoAWfsRN0r4CTD19V+PC
	o8vm8GmR4wOkabq0Yn0ezcDQJi2hMeC2CTf/91UxHjS1NIQ1BU5C3cQ0RpkeTxe7Lgyig9Ljat2
	TyA8iig==
X-Received: from plas9.prod.google.com ([2002:a17:903:2009:b0:2ca:cefb:826e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:946:b0:2cf:82e6:a5
 with SMTP id d9443c01a7336-2d0ca7f8ec1mr181848465ad.13.1786024884789; Thu, 06
 Aug 2026 07:01:24 -0700 (PDT)
Date: Thu, 6 Aug 2026 07:01:24 -0700
In-Reply-To: <bug-221841-28872@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bug-221841-28872@https.bugzilla.kernel.org/>
Message-ID: <anSTtLor3F4phcn4@google.com>
Subject: Re: [Bug 221841] New: KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes
 infinite VM-Exit loop due to missing RIP advance
From: Sean Christopherson <seanjc@google.com>
To: bugzilla-daemon@kernel.org
Cc: kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Vitaly

On Thu, Aug 06, 2026, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=221841
> 
>             Bug ID: 221841
>            Summary: KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
>                     VM-Exit loop due to missing RIP advance
>            Product: Virtualization
>            Version: unspecified
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: kvm
>           Assignee: virtualization_kvm@kernel-bugs.osdl.org
>           Reporter: f734222792@gmail.com
>         Regression: No
> 
> Created attachment 310582
>   --> https://bugzilla.kernel.org/attachment.cgi?id=310582&action=edit
> Proof-of-concept exploit demonstrating infinite VM-Exit loop caused by missing
> RIP advancement in KVM nested VMX eVMCS VMPTRLD handler.
> 
> When eVMCS (enlightened VMCS, Hyper-V enlightened VMCS) is enabled, 
> the nested VMX handlers for VMPTRLD and VMPTRST return directly without 
> advancing the guest instruction pointer (RIP).
> 
> Affected code paths:
> 
> arch/x86/kvm/vmx/nested.c
> 
> handle_vmptrld():
>     if (evmcs)
>         return 1;
> 
> handle_vmptrst():
>     if (evmcs)
>         return 1;
> 
> 
> Unlike other VMX instruction handlers, these paths do not call:
> 
> - kvm_skip_emulated_instruction()
> - nested_vmx_succeed()
> - nested_vmx_fail()
> - nested_vmx_failInvalid()
> 
> Therefore, the L1 guest RIP remains unchanged after VM-Exit handling.
> 
> Reproduction logic:
> 
> 1. Enable nested VMX with Hyper-V enlightened VMCS (eVMCS).
> 2. Run an L1 guest.
> 3. Execute VMPTRLD or VMPTRST instruction inside L1 guest.
> 
> Execution flow:
> 
> L1 guest executes VMPTRLD
>         |
>         v
> VM-Exit to L0 KVM
>         |
>         v
> handle_vmptrld()
>         |
>         v
> if (evmcs)
>         return 1;
>         |
>         v
> No RIP advance
>         |
>         v
> VM-Entry resumes L1 guest
>         |
>         v
> Same VMPTRLD instruction executes again
> 
> This creates an infinite VM-Exit loop.
> 
> Impact:
> 
> A malicious L1 guest can continuously trigger VM-Exit handling and consume
> host CPU resources, resulting in denial of service.

No, it doesn't.  There are no "host CPU" vs. "guest CPU" resources, it's all just
physical CPU resources.  Whether the CPU is running guest code or host code is
irrelevant.  What matters is that KVM honors NEED_RESCHED (especially on
non-preemptible kernels, i.e. before PREEMPT_LAZY came along), which it very much
does in the slow path VM-Entry/VM-Exit loop.

> The issue affects availability only.

Only the availibility of the L1 hypervisor.

> Technical analysis:
> 
> The eVMCS path should behave similarly to other unsupported nested VMX
> instructions.

Only if the TLFS allows it.  I assume it just says "unsupported" or "undefined
behavior", i.e. KVM can probably do whatever it wants.  Vitaly?

> Replace the direct return:
> 
>     if (evmcs)
>         return 1;
> 
> with an error handling path that advances RIP, for example:
> 
>     if (evmcs)
>         return nested_vmx_fail(vcpu,
>             VMXERR_VMPTRLD_VMPTRST_WITH_EVMCS_NOT_SUPPORTED);

VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID is probably the best fit?

> or at minimum explicitly call:
> 
>     kvm_skip_emulated_instruction(vcpu);
