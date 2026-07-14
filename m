Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59F412C0E
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053454; cv=none; b=GNim0HmepzVbkDQ64b1FHVKWlCabw+KZJClAYOfbuvTFJuZ3nPZMY0BFICTLE4O+o9Ph/n1SKou/93uCFlXtjLH6Rls+YwUj/ZScFKjRE9lpdz3kiHwTbwx16O/qKLTjWI+DhHAPIGazHV1WN+lbN6uzmnd6f5kRiosy9jehxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053454; c=relaxed/simple;
	bh=PtzgifCToE9i6F82rJer+x001djxxH72Wo5oXYVWRO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ANVvTAkyFHhlN9WtqRP1M9lHWPS4EvX/SGLGJZnsV5SS3eaS6j9aEYy5FIdUgQUbuUE/M4nGsLLXFAH9aMACiH1haRrbvhCWewxxxdrxy2bNNTChx+cZ8Mq/tyyucjkdTKMIFN4nu2lvWJRhKymXMrU4yXmDG1hZloCkC+JBtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvLR8AIq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvLR8AIq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848d21bbb55so5875781b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784053450; x=1784658250; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENRucSgO3o5mHLQK4q7atyT1xZ8PJlvadC9enFcBAkg=;
        b=nvLR8AIqERqFQbE0lxZ614/PC/AWdW1iE1+H0sQuFfR2OTviFs9Cpg4wbpWDkwmsa1
         WcSVFFkcEBN0x+riATcj24cOXYhlgVAiIQKoY8myGi74QrbgNBwWTXq9NYXVFz98qm7X
         Gw+osxVmD6E7LXPHUjD/7pmcLG/VlXBJneOdVzDgG1yDlalCDTs5WKXpnYmrbEyNYy+R
         CtXyFGnmxuAo14eoyTSqMXn4UGbhYnKi4VBzzbrC0S7eErCeOcXr3q+ySe8o5fpQ7IF+
         TajdXwYJm8L4j0Ac5Wry9QEgGHG5yMul5U8wiJtfG2OPPMGm4jhZveSszgjkox+Mtrn4
         Z7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053450; x=1784658250;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENRucSgO3o5mHLQK4q7atyT1xZ8PJlvadC9enFcBAkg=;
        b=N1roT++Tk5W1rQRklgUA9ty2QMzQa9aevEeActyzdCRn0kuyFePtarCGAdd7n9aUUT
         ZhD/1oYuQDDJgO+vUhBH9nWlYuRVDjqMpyCXU76Be3axhcvn8YKTR6S/FsERpKgccD0p
         OPpEAmnm34fwzMVqpbQHIJFQjdA6oDhbR1ThocTeAwaw5AEr8s768w0gfjrbAV4z6pPW
         pNEat1oI1H4EX1Rb5MGeQibiuqTVKqjNxXZ1e1XEs4z1Uhhs/TQE+fJykOfHBR4Tatto
         J7oZAZ3UUem7+orN2235dEdZzX/VVuB8CwB62ZpfP+/g5XNiNOR7r6d3MjBHng+h116e
         tVDw==
X-Forwarded-Encrypted: i=1; AHgh+RrDbrYhSmv+avnzsI8tbSwBu75lJOfE5Iy5U+E8Uy5sZRqwvX/j0xCItSTsmtna22+pXeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNxBvzQYtYrbuJ7TR98ZylXXLyCGmZTIJlnYLraja/55Jv1Ce
	m+ebCWg+WoS/aptKUM8iXFGTn9p76aOOk2zpXZkd4B7Y/BwgCLyCvvoRsti3z5+iPuK+G+0Lpcp
	KHQFDzA==
X-Received: from pfez10.prod.google.com ([2002:aa7:888a:0:b0:848:492a:5b41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b45:b0:84a:2c46:3fdb
 with SMTP id d2e1a72fcca58-84a5576e5c3mr3341929b3a.5.1784053449523; Tue, 14
 Jul 2026 11:24:09 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:24:08 -0700
In-Reply-To: <6d8588f8fb1b68fee59d4a0c8cfcfd7a58d25f79.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630202828.440724-1-seanjc@google.com> <20260630202828.440724-2-seanjc@google.com>
 <6d8588f8fb1b68fee59d4a0c8cfcfd7a58d25f79.camel@intel.com>
Message-ID: <alZ-yMvZb2I2tJOf@google.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 14, 2026, Kai Huang wrote:
> 
> > but now KVM is over-reporting support for
> > KVM_CAP_NESTED_STATE and KVM_CAP_HYPERV_ENLIGHTENED_VMCS.
> > 
> > 
> [...]
> 
> > @@ -2346,7 +2346,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
> >  		break;
> >  	case KVM_CAP_NESTED_STATE:
> > -		r = kvm_x86_ops.nested_ops->get_state ?
> > +		r = kvm_x86_ops.nested_ops->enabled ?
> >  			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
> >  		break;
> 
> [...]
> 
> >  #ifdef CONFIG_KVM_HYPERV
> > @@ -2354,7 +2354,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
> >  		break;
> >  	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> > -		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
> > +		r = kvm_x86_ops.nested_ops->enabled &&
> > +		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
> > 
> 
> IMHO an additional 'enabled' seems a bit redundant?  And it seems there's no
> rule whether the common x86 code should check it before (checking and) making
> the call or not.

Because in most cases, the hooks are reachable if and only if nested virtualization
is actively being used.  Generally speaking, the only flows that need to check
"enabled" are those that enumerate support to userspace.

> How about letting VMX/SVM code to explicitly clear the function pointer in
> xx_hardware_setup()?

The downside to that is approach is that all nested ops would become optional
from the perspective of arch/x86/include/asm/kvm-x86-nested-ops.h, i.e. we'd lose
the sanity checks provided by:

#define KVM_X86_NESTED_OP(func) \
	WARN_ON(!kvm_nested_ops.func); __KVM_X86_NESTED_OP(func)

We could probably come up with a way to make things work, but I think we'd end
up with something a lot like the "enabled" flag.

> Perhaps as an ultimate goal, I am not sure whether VMX/SVM should provide a all-
> NULL version of kvm_x86_nested_ops and the kvm_nested_ops_update() should treat
> all as either OPTIONAL or OPTIONAL_RET0.  There will be still call sites which
> needs to check the pointer is NULL or not and return -EXXX but I guess we can
> live with that (kvm_x86_ops is similar too anyway) ?

I'm concerned this would actually be less robust, due to static calls being nops
by default.  If KVM screws up and invokes a "mandatory" nested op that has been
nullified, exactly what will happen is harder to predict, e.g. kvm_translate_gpa()
would probably return stack garbage?

Any such bug is highly unlikely to occur, but I don't want to sacrifice
defense-in-depth without a clear benefit, and IMO avoiding the "enabled" flag
wouldn't provide much benefit in practice.
