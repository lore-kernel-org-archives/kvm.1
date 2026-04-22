Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2D3EDAD8
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884175; cv=none; b=V9uU+fx+Rn3z67Xm0scJFvQ5uZJgiJ5qW7aYzJEpBOwZAfXjo18U+XZ/aD7huBahEMe3njBoCwVPmptwFsD9z1+KFNRq/I2oS1ic1eNzxi219sg/oTKPoq5cDoIaawHA2ihE9pGyefr1xv8uJi6auj9M94F+O6KegBY7VzWSxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884175; c=relaxed/simple;
	bh=ViuhG0mu8Ha9fsEyxqrNsYBVfNjlabLkf9f5NP9XO+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbcMyoyPRSUCWeNWGV6s9rp1OyOUc/q5CYwO5hJ8V5Ce0TdxA3vW8xB/MfFQPK5SSxcC8nxEE6eL3095AGUft5xIkDaRN6W/f2F20t69MEJFYq70RdXjSsSIKhec3kp52a79VLzq4fyaU+cAR4k3rJoXqkQoZZ8eVbExSjQwZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4IfqD4d; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4IfqD4d"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f8bbb4045so3626390b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776884167; x=1777488967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZORh0sWGKBSfeUiZSwo8UV4Uy/LJPm2z8W3xtCwXTs=;
        b=M4IfqD4ddaT+R2msBdsBZ/QJO392819qpNlahWcJj0/s+vVV47q3LE8KJ9Y2azFBNt
         0alcSDOujWpwei90fNnjxa4qcBt7pXB3niQSZO2MH9SzM8ftgdzaktjHK5ytBqYKQPfT
         /WRGyMTrHftqpk9XgV+UpyzLNOVSHTftvLfYwXcLEWp4pxuCmXYqyoczlkVcRvKVHcjM
         1s0CC7XSoGSnUQA7xN1gdp3BzgSVZzZWqOdPNR3mNrvQ74N25Jgu8e70O9oxnJIamPTE
         cQdIEWkQAGJqd8D12vVz/klOLTXBOoG/AiKMk5jt51wqkz9jJUujepXJ8+wH7mdpVC80
         EebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884167; x=1777488967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZORh0sWGKBSfeUiZSwo8UV4Uy/LJPm2z8W3xtCwXTs=;
        b=DDlpniIcfaxJ/FfYIRLCgnLq7ujOS2EB++IC39Ty7VUqqRkKg4tXqQBOTwCcnL9CJS
         dkdsuJ44BDbzQxscX0BFxJ1SsHxEkh4VFJqqkq/J8+V3l2VuVoXSv2huVdP2/ARWzH7C
         rmzSalUZeS6PRE9MFdD9K2bW2a2pyjgQyYM+PpwtcxKHfg+fGr2MLNiuf5qTfqpVX/ww
         3fCRL20SKX/5heXzLPqyfP3q+V9yYRsu3Q/qR+b4Rpqu+8P7nLxwadpBXcgacpk6LCeq
         U74KI4EBD/D4jA0OiJMn0C/PiEcvOKKs6toFxPFKyaIpX5Dfhi1DA5FNpdV+r92JazQe
         5NmA==
X-Forwarded-Encrypted: i=1; AFNElJ9dUk/0KCeQMgXTESE0ccFjNJU5bnsq7dcOkQr1KuZLRrYQtZoMlDrqxsIF7pdSF94Jwpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1iJdo78ub4ZU1wBPLr5kfWAnR1rMWzIlpS6xyqQ7cdXmce3p
	uVXnOl80+nxf+rTUvk0m7ZHk0rR5k0mqXC41FgJ+yqG1mTkYt8MIiF2+zQhbuYkfKFvuHwXVe2F
	3dxmOPA==
X-Received: from pffx16.prod.google.com ([2002:aa7:93b0:0:b0:82f:af01:3a8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2288:b0:82c:e1aa:21e3
 with SMTP id d2e1a72fcca58-82f8c84da16mr25101996b3a.10.1776884166929; Wed, 22
 Apr 2026 11:56:06 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:56:05 -0700
In-Reply-To: <20260422175000.1544258-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260422175000.1544258-1-khorenko@virtuozzo.com>
Message-ID: <aekZxVXzxJ_sj4Ev@google.com>
Subject: Re: [RFC PATCH 0/1] KVM: VMX: restore host CR2 after VM exit
From: Sean Christopherson <seanjc@google.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Konstantin Khorenko wrote:
> All four oopses happened inside the L1 host itself: the original fault
> plus three further faults taken inside the oops-reporting code
> (dump_pagetable() -> copy_from_kernel_nofault(), vt_console_print() ->
> lf(), vsnprintf() in the "Modules linked in" path).
> They are not extra levels of guest nesting; the nesting stack in this
> setup is just two deep (outer hypervisor, then this L1 host running its
> own L2 guests).

...

> The mechanical fact (VMX leaves the guest CR2 in the hardware register
> after VM exit, and the rest of the kernel treats CR2 as "address of
> the last host #PF") is easy to verify from the source.  What I cannot
> pin down from that one dump is which exact delivery path brought a #PF
> handler into play with the CPU not having updated CR2 on that run.
> The plausible candidates include:
> 
>   - corner cases of outer-hypervisor event injection into this host;
>   - NMI/MCE entries racing with oops reporting;
>   - crash/__show_regs() invoked from contexts other than a freshly
>     taken #PF, where die()/oops code reads CR2 as if it were fresh.
> 
> All of these stop mattering the moment the host CR2 stops being a
> guest-controlled value after a VM exit.  The patch targets the
> weakest link directly: the "CR2 on the host == address of the last
> host #PF" invariant should hold across VM entry/exit on VMX, and
> today it does not.

And it never will (barring a hardware/ucode change).  This flaw is impossible to
completely fix on Intel.  The best we can do is "restore" host CR2 within a few
instructions of VM-Exit.  Intel doesn't provide a GIF equivalent, and so NMIs
can't be blocked in the entry/exit path.  E.g. the kernel already needs to be
prepared to handle NMIs with guest CR2 loaded since VMX doesn't provide a way
to block NMIs.   

More importantly, I just don't see the point; the host CR2 is _guaranteed_ to be
stale.  KVM obviously doesn't do VM-Enter from #PF context.  It'll probably be
less garbage than guest CR2, but it's still garbage.

I appreciate that seeing a bogus CR2 can make debug difficult, but IMO, the
benefit of making KVM moderately less painful on rare occasions where all hell
breaks loose isn't worth the cost of the extra CR2 writes.  And practically
speaking, the kernel _must_ be hardened against bogus CR2 values when dealing
with OOPses and panicks, because pretty much by definition something has gone
sideways and so CR2 can't be assumed to be benign.

> Patch properties:
> 
>   - Hot path impact: one extra register compare in the common case,
>     one extra MOV to CR2 under unlikely() when the guest modified CR2.

That's not unlikely.  The odds of guest CR2 matching host CR2 are basically zero.
In practice, this likely adds two extra CR2 writes on the majority of entry/exit
transitions.

>   - Stays within the existing noinstr region.  native_read_cr2() and
>     native_write_cr2() are plain inline asm with no instrumentation,
>     so noinstr constraints are preserved.
> 
>   - Not a security fix for a user-triggerable issue per se, but it
>     removes a class of confusing "kernel CR2 points into guest memory"
>     oops reports and hardens the CR2 invariant for the whole kernel.
