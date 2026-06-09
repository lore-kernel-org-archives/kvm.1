Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499573B42C4
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022069; cv=none; b=dV7A02doc9QjyPC0cL7FOjDngqpVJkv6gtgPyVBWU3Pyn02kP8lboL+9ILzBB263Q35Paw6OSWiYmkrTnxvPAz4t3+V8U9BQrM7MjBI0Av/2VwE8nlbiT8iJOEJ68ejnwOHZr3DY0ljfdF/BGSs5wPcNvIVZchwLn5RT+fIpOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022069; c=relaxed/simple;
	bh=k0w9sVqvj2jX5d0E928Q03YI1/HvAyAtxjAX9SacJwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2298v0wdBrO2Hi16zr4MUgmYtP7ak1TKXJUD6nEFsj90w6pRrtPwVlSj391WgoEP5LWV23hMk70hQ7VLSxqPfm3S0ZwIszrmoOESUYReourA2Ebeu5Kehn0KVd8QcaR7cb0YD8q14oC+xntoN4b5EjfQuEMaVstrzDJZ9AqZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hsmW82b5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hsmW82b5"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b982ec338so6673478a91.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022067; x=1781626867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gvd6MFO1re+VzEtiBDJtkgK8ixXm4k63qOd4VnBfUo=;
        b=hsmW82b5PY+vXS52/eYAh1Gcjdvgo5ADsIJDUkQeqp8UhvDknnfJWKnlB8sK+tpwJU
         MjN3VZPfSDXu3fMdXIL6uSoIOi1doNwHFhhgaxZrzzoILDBhk0T95K+EcMNRjE/3OMRM
         kRTmTlZmt2ZqIf5i/1zrL7cTbK30WGGp4ycnxpa8NFocbIbXjcTiPwy0j9XT8cR9ZlwW
         560vqpHgkab4JItz/cQF+lQrtk1GwMy8rezG31EYQIdR9JUPwgleHIscUJcj8ZymKX+R
         CMcn0TLXMcneVpa8MQxlkaW5zLnpbkPynfOqoMTt2zqN/SRRrdJsbaqvoR1leQPvkV2N
         DYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022067; x=1781626867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gvd6MFO1re+VzEtiBDJtkgK8ixXm4k63qOd4VnBfUo=;
        b=ZdMQ0DRz+nRbhJ94qrpolksWuSte59pM5kw94N1nqprtVFw41lkfOI+h44mVw4g5JM
         r0ue9xlj+iwAeRNgHhxF86HnOWtiBw9gZFNQwEKWzH7CB7rEVpBpzQ4o77X/HCidasto
         KS4UQ6yEOYx2YGpGKQVTeJSwgS0r4UWPYSj+6ckR2YeWctlxiC9WM834gqVqDFyCWBfQ
         Nw67eQ/NZiLpZD9zfuXYcRve0rkp+l9l86+uOummz66MDdQju1LGu95IYuwydF00UfnS
         hZpCxjjQ/G5+yAHiklToksi45783kypRY2Dm3It4o8o5cl/VSuIbYwv3PuALRdDO5kvc
         OUhg==
X-Forwarded-Encrypted: i=1; AFNElJ+rB/azQneS2yRdNK0V99qyJKbTaVXKtY4MjSSu8PO9O94jCIObY7e6A1tVIrgyud08zm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OwaMwN85Jo+5bBmdorL+c2b8+wtocNDmdTDlkXnEgcHvlsKV
	VY2cFsZAyDj5aHY8+yRi8lD32NkJT4gvo3myrDotnt6YTErxUnKd1Kp6EGHu1CVEbZetiMt8qN+
	2k/jMQg==
X-Received: from pjx7.prod.google.com ([2002:a17:90b:5687:b0:36b:bdb2:1426])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c1:b0:36d:dd4a:1e59
 with SMTP id 98e67ed59e1d1-370f057ea9emr23407467a91.23.1781022067379; Tue, 09
 Jun 2026 09:21:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 09:21:06 -0700
In-Reply-To: <alpine.DEB.2.21.2606040048520.22659@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603230718.1733483-1-seanjc@google.com> <20260603230718.1733483-3-seanjc@google.com>
 <alpine.DEB.2.21.2606040048520.22659@angie.orcam.me.uk>
Message-ID: <aig9ckd1f6oZaYgA@google.com>
Subject: Re: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
From: Sean Christopherson <seanjc@google.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Maciej W. Rozycki wrote:
> On Wed, 3 Jun 2026, Sean Christopherson wrote:
> 
> > When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
> > due to DR7.GD (General Detect) as higher priority than a #GP due to an
> > illegal value.  While neither Intel's SDM nor AMD's APM says anything
> > about the relative priority, empirical testing on Intel and AMD shows that
> > the #DB has higher priority.  
> 
>  It has to.  

Not super strictly speaking though, because ucode _could_ check for an illegal
value before enforcing DR7.GD.

OMG, Intel and AMD don't even behave the same.  I _was_ going to say that
"obviously the CPL #GP check has priority over DR7.GD", but on Intel the DR7.GD
#DB has priority over the CPL check, whereas on AMD the CPL check has priority.

Which actually proves my point: hardware/ucode doesn't _have to_ treat DR7.GD
with the absolute highest priority.

Ugh, and KVM's emulator doesn't get the priority between the #UD checks and the
CPL check.  Double ugh, half of the instructions that #GP at CPL>0 don't get the
priority right.

> The primary reason for the existence of DR7.GD is to prevent 
> software being debugged such as an OS kernel from clobbering the debug 
> register state when executed under the control of an ICE or a JTAG (XDP) 
> debug probe.  Under these circumstances #GP remains an ordinary exception 
> routed via the IDT to a handler provided by the OS, however #DB traps into 
> the ICE or SMM mode instead and the OS handler is never reached.
> 
>  This is also the reason why DR7.GD gets cleared at the same time -- so
> that the debug firmware can then access the debug state rather than making 
> the exception trigger again -- and for the existence of the ICEBP aka INT1 
> instruction -- so that #DB can be triggered and control regained by the 
> debug firmware via a software breakpoint, since the number of hardware 
> breakpoints is limited (and #BP is an ordinary exception).
> 
>  It's unsurprising that the priority of these exceptions is not documented 
> well in the processor developer's manuals given that x86 hardware debug 
> features remain vaguely documented overall in public resources.  Though I 
> note the Intel wording for the GD bit is "[it] causes a debug exception to 
> be generated prior to any MOV instruction that accesses a debug register." 

Define "accesses" though.  MOV DR at CPL>0 definitely isn't going to access
anything, and so that statement still holds true if the #GP due to CPL>0 had higher
priority, as there wouldn't be any DR access to prevent.

> so I think it actually implies no action resulting from the execution of 
> the affected instruction happens, including in particular any exception it 
> might otherwise trigger.
> 
>  FWIW,
> 
>   Maciej
