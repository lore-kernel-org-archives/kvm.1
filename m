Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C508386C3C
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626026; cv=none; b=GU78iAw/gDhiJw+vHPzShc+uX1BDaxSZkcnUgLd2ouT8cY3WXGxxwtzAzYElNoUSP6+zvpK0meIjGtYqER/wW3vhPyI1TZHaSzFkkvv9g6zMU3Untuk1b9FvjEk6BL2abpFOxqDb/P9x/8F74+R0iilNllySi10RFQPt3AoBm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626026; c=relaxed/simple;
	bh=i53FjWyS7YWE0lW+P23gNA/w8DQyb0fW9mT5OA9yMC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACu6iIOjd/kffzrc1HRPJzKFfAXXACuIi+NMTPBRE1Bjnc0MZcIICx7n7HO+fK1m6QigQdUeDfeaChkF2Gb7GaE+sGaL1M9hl5DYa+c1GUe2PlFPdWoRE9RPYGktkTJqqQFVAwUig5HCqTwG//inrPbH/treJ2PqhXqt/tRn2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USc2s2zm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USc2s2zm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so3305340a12.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778626023; x=1779230823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDihhhs5K7xf76XP8d4Q3fp6ZIu7vclP5SYzxfurShc=;
        b=USc2s2zmm6vlKOvYrSQuzeMpJ6E5DKX0qzwoL7xbvqY5TLox+Aoi/PvkaN1cjPrA0i
         14pY7ZFxFAWZXcYexkSf6QU4dgy3kv82OlR5o+6lgwBfqudRKnGEWshmI4ArT6OXE8Ae
         8+IKBeuxBAUzejl4hgK3ZzkpJfmsqd3a70EjRhVgHXt31Vr+9N0qVjGacA+z0swbR3H9
         Zf5yg2CchLlr8ZI70PAl1rlQDiyFZ5BpfMpCAGSnWgsktHy17/CxhN1QJUqhZxd8Wlc0
         pOAL+ajEkJ9HQUWacEktGSCLJcqZb1HmpoKDVAhIBnBCAzV/BvtFfzqf/X0FsYI3HpmO
         Xxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778626023; x=1779230823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDihhhs5K7xf76XP8d4Q3fp6ZIu7vclP5SYzxfurShc=;
        b=er2Uro9fb4XshD0l5+PZGDXo0UXzNZZ9zgC1MSNInU/sD/cpfsBHlMR7PXnMRoSGf+
         PP60Z7fmH+P+6aSTbfnIg7FVq673fT5cUkZmrxN3VOAMjApFgMFYS9Ktikq5b1qRSSHz
         rmAh78HqP+IzNYRoHHNQYUgXtrBZPo3Z5r4NlGfWDH25yNyOcVIknCfqs8LJMTcni3NU
         joFH9Bl+kjDeKhww6JWtjL8mbEwSlfcwXjjtHEnlZZWV8ILe0Rjn3urEoktXh2ArtaOc
         PSEAyvI85P7EanJErZd0SX4/uLesvlfQV29yXgbvPJ89CdzWCRoqSomL9MqhgMu+oHFF
         RL9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+J2JYCQxQpqITQpyfG/Ewb4xsUw0kuFzemVehLw3ehQKrQGrF+ALicYllGF0f3vtchx30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfDTPepkhZTJ+fn16ainJiafFQMGwxRnwl/YbOzCV7dS1FEnP
	0JUByKPkmbqTXmJs0JYoNESzAgwtqJuOrUoRLu+QoChUEUi+JTLzsvMVwIKpUGqmCA8lJK+H7cN
	O0Ej3qA==
X-Received: from pfbff26.prod.google.com ([2002:a05:6a00:2f5a:b0:83e:dfc6:971])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a4:b0:3a2:f402:50f6
 with SMTP id adf61e73a8af0-3af82789ed8mr573679637.31.1778626023122; Tue, 12
 May 2026 15:47:03 -0700 (PDT)
Date: Tue, 12 May 2026 15:47:02 -0700
In-Reply-To: <20260507212957.2629561-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507212957.2629561-1-vannapurve@google.com>
Message-ID: <agOt5nzP6pm5yyOZ@google.com>
Subject: Re: [PATCH v4 1/1] KVM: x86: Introduce has_protected_pmu state for
 TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Vishal Annapurve wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..c248abb0e2ab 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6909,6 +6909,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MASK))
>  			break;
>  
> +		if (kvm->arch.has_protected_pmu) {
> +			WARN_ON_ONCE(kvm->arch.enable_pmu);
> +			if (cap->args[0] == KVM_PMU_CAP_DISABLE)
> +				r = 0;
> +			break;

Sashiko: 3, Sean: 0

 : Does this code bypass standard lifecycle validation?
 : 
 : For standard VMs, KVM strictly enforces that PMU capabilities can only be
 : configured before any vCPUs are created, returning -EINVAL otherwise. The newly
 : added block for TDX VMs short-circuits this logic, returning 0 unconditionally
 : when disabling the PMU, regardless of whether vCPUs have been created.
 : Could this introduce a UAPI inconsistency where the same userspace sequence
 : could fail on standard VMs but silently succeed on TDX VMs, potentially
 : hiding VMM initialization order bugs?

That potential issue crossed my mind when first trying to figure out how to allow
KVM_PMU_CAP_DISABLE for protected PMUs, but then SQUIRREL!!!

I think my original reaction is the way to go: add extra validation for protected
PMUs (reject everything except CAP_DISABLE), but otherwise let the normal flow do
it's thing.

Completely untested, but I think this would do what we want?

	case KVM_CAP_PMU_CAPABILITY:
		r = -EINVAL;
		if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MASK))
			break;

		if (kvm->arch.has_protected_pmu &&
		    cap->args[0] != KVM_PMU_CAP_DISABLE)
			break;

		mutex_lock(&kvm->lock);
		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
			r = 0;
		}
		mutex_unlock(&kvm->lock);
		break;
