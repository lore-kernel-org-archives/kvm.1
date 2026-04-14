Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5B3E714F
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175494; cv=none; b=U3ZzckJuPFPz6EPQser0dyRTApscFCxFSJdS8QaHTz5A+tcAYgoK8nTv77l3sSB3XVFmVyHfEmLw3ce9XFQp2BksE92VjMnpROKLsyrqvHs5FQPOo9nFWgnLPEKfpoNurUzGNIo7bjszrqx5v4SvTcXDkC1gN/W8LXzhL9xT8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175494; c=relaxed/simple;
	bh=oOJuBLVg0LbJ5Yjj3+NLnlKO7wSc3PyQABq2OvL3kmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ifeS8lZGFPpx7dHgnqU7gTgwYKFmyypUSci2N6kzjJNXR9hiMSEGu3Vvwvn4Ftgvc5Y5Oh9wyPotA9zOK8ca6LRPkU0Z1gHSKKRfk35ppo7hBJl91Jc3BcUYZ408CfNWtHsA5MagDVUztmWTlkh5H1dUQn+jZrvCKux/pdhJY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXl5mz1w; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXl5mz1w"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249975139so112766475ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776175492; x=1776780292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLVFIIfT15k6UIzADbNAbLyz/lB2RvlpR4+To74x7Kc=;
        b=qXl5mz1wUXJ+lczbexmUNVMbO/9PtpFoFT807vyQMBXGZEAKNjWzi/Bvclj+q7VJyV
         7jgLKOLngsNP12Ajo8XoZeMGwDJxVmy9Re1WoFuvOxAgVljaE2jX/lI9TCzfyQtWl+GJ
         jzb8CqcLhqsk4mZiXsKsNBqQrhVtYv66PF96NeJIFpgzYNMopMMEigeY7qGah4EILSaK
         az35JBTV6fDYfXibCKwyDN+RN/FSGt1ODG76oPPQh4pJaR8KcakCNtrzQdN46PCV3+/S
         i5r0f6DBkGfVa65Q6UGvJbNHV62AGJXV78cpk7eKpQci0OVlp2h4C6dhmeoMRLzpxmOH
         OrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175492; x=1776780292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLVFIIfT15k6UIzADbNAbLyz/lB2RvlpR4+To74x7Kc=;
        b=EUfMhmgk2lv2onYnh7OGnpVM/D7/akwg7JhvlS1r60jZM4buDqSI4iJqxraHvKPBIL
         aCgMXC2tnUhWQ+kILeRcf33Ukjqfu17wGCYLMIiDMDWkzrDWF5Cue8SP8CqifwNDtWMM
         rnUv6JAylvxTqf8S9K65GFE2yd2qv7R2FitvEZURvThyKZN1uEbx8UmojlKtQAMSgUOZ
         DgPCEfmu2kWgQ5peHBuSoOjYCOIJb6LrBs++HsPVZ6n4dNWn5RPUhIDCdQXdlYkAYg1k
         hj63MedlrscEouS9Pplm58iYApRzSy0NCT1sZzDMUDD2ZyqIYaoXl0jCGUH6kjPPGbL6
         DiTA==
X-Forwarded-Encrypted: i=1; AFNElJ/pEDUuym9DsSe/54o/8rR2xEyJGoUuNe1vE9v5PqePA/WQZKogGKHbOL8psPamiArEUKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSX+8DReYbRzxnG6Mztx4DKkkTVcZReGR4TGzzbXJGnQB6/5m/
	AjV2NKMuzuDp394LMfhSxmGtOYGhuZUfgoEkY0vWXUxbCmhOixNbAozT/FkS8XQ/fXwqnqPkgtZ
	2dhYVNg==
X-Received: from plek1.prod.google.com ([2002:a17:903:4501:b0:2b0:b0c0:43b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:9341:b0:2b0:4fb6:85ce
 with SMTP id d9443c01a7336-2b2d5a45a0bmr139996805ad.21.1776175492138; Tue, 14
 Apr 2026 07:04:52 -0700 (PDT)
Date: Tue, 14 Apr 2026 07:04:41 -0700
In-Reply-To: <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com> <20260409224236.2021562-6-seanjc@google.com>
 <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
 <ad0DrDUsUKTMfrDW@google.com> <d6f05e5fa781ccb465d27a4fb1c7c1ac1e9e95ff.camel@intel.com>
 <95a931f8-42cc-4834-953c-30c9167bfdc1@intel.com>
Message-ID: <ad5JeT7UuiQI9Tqo@google.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, Chang Seok Bae <chang.seok.bae@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Xiaoyao Li wrote:
> On 4/14/2026 7:03 AM, Huang, Kai wrote:
> > > Because VMX and SVM make all GRPs available immediately, except
> > > for RSP, KVM ignores avail/dirty for GPRs.  I.e. "fixing" TDX will just shift the
> > > "bugs" elsewhere.
> > Just want to understand:
> > 
> > I thought the fix could be we simply remove the wrong GPRs from the list.
> > Not sure how fixing TDX will shift bugs elsewhere?
> 
> I'm curious too.

What I'm saying is that, _if_ there are bugs where KVM uses a register that isn't
available, then modifying TDX's list won't actually fix anything (without more
changes), it will just change which code is technically buggy (hence all the quotes
above).

> > > More importantly, because the TDX-Module*requires* RCX (the GPR that holds the
> > > mask of registers to expose to the VMM) to be hidden on TDVMCALL, KVM*can't*
> > > do any kind of meaningful "available" tracking.
> > > 
> > Hmm I think RCX conveys the shared GPRs and VMM can read.  Per "Table 5.323:
> > TDH.VP.ENTER Output Operands Format #5 Definition: On TDCALL(TDG.VP.VMCALL)
> > Following a TD Entry":
> > 
> >    RCX   ...
> > 	Bit(s) Name         Description
> > 
> > 	31:0   PARAMS_MASK  Value as passed into TDCALL(TDG.VP.VMCALL) by
> > 			    the guest TD: indicates which part of the guest
> > 			    TD GPR and XMM state is passed as-is to the
> > VMM
> > 			    and back. For details, see the description of
> > 			    TDG.VP.VMCALL in 5.5.26.
> > 
> > I think the problem is, as said previously, currently KVM TDX code uses
> > KVM's existing infrastructure to emulate MSR, KVM hypercall etc,  but
> > TDVMCALL has a different ABI, thus there's a mismatch here.
> 
> I once had patch for it internally.
> 
> It adds back the available check for GPRs when accessing instead of assuming
> they are always available. For normal VMX and SVM, all the GPRs are still
> always available. But for TDX, only EXIT_INFO_1 and EXIT_INFO_2 are always
> marked available, while others need to be explicitly set case by case.
> 
> The good thing is it makes TDX safer that KVM won't consume invalid data
> silently for TDX. But it adds additional overhead of checking the
> unnecessary register availability for VMX and SVM case.
> 
> -----------------------------&<-------------------------------------
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Date: Tue, 11 Mar 2025 07:13:29 -0400
> Subject: [PATCH] KVM: x86: Add available check for GPRs
> 
> Since commit de3cd117ed2f ("KVM: x86: Omit caching logic for
> always-available GPRs"), KVM doesn't check the availability of GPRs
> except RSP and RIP when accessing them, because they are always
> available.
> 
> However, it's not true when it comes to TDX. The GPRs are not available
> after TD vcpu exits actually.

> And it relies on KVM manually sets the
> GPRs value when needed, e.g.
> 
>  - setting rax, rbx, rcx, rdx, rsi, for hypercall emulation in
>    tdx_emulate_tdvmall();
> 
>  - setting rax, rcx and rdx before MSR write emulation;
> 
> Add the available check of GPRs read, and WARN_ON_ONCE() when unavailable.
> It can help capture the cases of undesired GPRs consumption by TDX.

Sorry, but NAK.  I am strongly against adding any code to the GPR accessors/mutators
just for TDX.  It's a _lot_ of code.  From commit de3cd117ed2f ("KVM: x86: Omit
caching logic for always-available GPRs"):

    E.g. on x86_64, kvm_emulate_cpuid() is reduced from 342 to 182 bytes and
    kvm_emulate_hypercall() from 1362 to 1143, with the total size of KVM
    dropping by ~1000 bytes.  With CONFIG_RETPOLINE=y, the numbers are even
    more pronounced, e.g.: 353->182, 1418->1172 and well over 2000 bytes.

Note that updating only the "available" masks is wrong, as TDX needs to marshall
written registers back to their correct location.

In the end, the available/dirty tracking isn't about hardening against bugs, it's
about deferring expensive VMREAD and VMWRITE (and guest memory) operations until
action is required.

We could bury sanity checks behind a Kconfig of some kind, but I genuinely don't
see much value in doing so.  These emulation flows are very static (all register
usage is hardcoded), and so it's very much a "get it right once" sort of thing,
i.e. the odds of a runtime check finding a bug after initial development are
basically zero.

An alternative for TDX would be to avoid bouncing through GPRs in the first place,
e.g. by reworking __kvm_emulate_rdmsr() to not access any registers.  But I'm
probably opposed to even that, because I doubt the end result would be an overall
net positive for KVM.  We'd end up with duplicate code, harder to read common
code (because of the new abstractions), and likely without meaningfully moving
the needle in terms of finding/preventing bugs.  KVM still needs to get operands
to/from the right parameters, though only difference is that for TDX, the parameters
would be very "direct".
