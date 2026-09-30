Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C8437448
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802447; cv=none; b=XZJTgkR5N3yv+RSeflUnziiPHgvarBqK2BUd/JUIoAcOQShu3+cqZSTnOazqI3e1BqyhbMW4Ug8A5zWwONUSSCUFNJNZ9+2uURC/5p4obpH2JVz92ZnIMXFk6sg4IqbUoiTzWTXydtNY5nLw+mcTo1NX+/RzwsDpzjFD0WcUf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802447; c=relaxed/simple;
	bh=93bpceLZlrAkvmaGoE7sfUNLduNSj8klf5sl0EI9qNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=naOBEkEgYz1NeBGPDBDWVq8ysd0w5JlwJTrPNJYeghhgJIaM8EmgHJtovQAV6ilPWYW21387ngRxdUFGHDnGOLi6iQ3fCB/aqZQUOLN+HZgukuRwXRc5nO/C4s86DP0JqpMkWxOkQ9Xrozf1DUSSS6n/0sTv44uUgergQHAkYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqBuqhdB; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqBuqhdB"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so6583059a12.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790802445; x=1791407245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3E+HmnTRuwa4/8xSFm89S79BjMh+ktjR1OaIYiNyOOk=;
        b=qqBuqhdBLHlspmri5lqrkiMxb2k/60W6Tf2Nr0h9KFfHEutveiPwSU2CpxSBSsjHfc
         D0ufg0pdup77pKGeWfomYEuye0bKjubbbFquY0XKydPQC1plgG+zSULAco6vai6skg7q
         NjF4Y/+Cx6vFN+IST52+KvplN5ZO+3zcK2dXsjTD/K01xi0UM2M48h67Su7GLOczHEz8
         3YSfd3SP+pv44ejz57N6izjvD9lmATAn8W3sclX0uI9YUJ70d0q6QEoEQlUmb30QolPy
         PpACWIdw4Lbn6+G2q74F/H2GlBleuSZ936Aqr3oKU7PN5YbKm/rk4IRw8+5tMgI5pnl/
         pq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802445; x=1791407245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3E+HmnTRuwa4/8xSFm89S79BjMh+ktjR1OaIYiNyOOk=;
        b=UWLDI6QYFl7zh2iBCBLuqRel0q5ws6oYGfE2x2iepRBB7Ktd4MRnx98XA8R5nYOtGY
         R3CkMb29JCUMTrL9g/xciCrKezM42VN6czMF3P5LHDcINKzS1cJt120hsEYEPuHd1ybV
         ntWRbpV01HHKLdeA1Wsgnczhoyh733aLlOQr3Xkf/AP6yoXghbC7/luAtAzLAIQjmHv9
         4Ttlc57PUyeeg2qTUDnisF0daSvs0OLZJv/qYeZdUzA8VG2ejFtJTysPSYc3TL2eE1tB
         NDfpiV1lTYeN1Vw7zYatBzN/x/Nd9NCS6XNQlrOuRyLUjluSimZ+7uk90PDjzKPGR98d
         FL1A==
X-Gm-Message-State: AFuF++ku21oMphC9PucKXG8YHiNYC9uhcSQYSf7lGgJubjtxQCsgcymn
	jO2mPS8MIQl/3p6DlCgHEWvBoqQeDL0uY1PBnnnO7IYPgnXY/ALT22+CbFB+F6GDuwO3Omducjx
	Z9r5laQ==
X-Received: from pgvi21.prod.google.com ([2002:a65:61b5:0:b0:cc7:d161:7edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:3de:4542:1a91
 with SMTP id adf61e73a8af0-3de9e84e310mr2375161637.30.1790802444857; Wed, 30
 Sep 2026 14:07:24 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:07:24 -0700
In-Reply-To: <106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <106bc3a4660653cb7750f3ae07a4dbca42c2762c.1786356229.git.sandipan.das@amd.com>
Message-ID: <ar16DP3mAeWTewq8@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Add option to raise NMI on overflow
From: Sean Christopherson <seanjc@google.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, 
	"Nikunj A . Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Sandipan Das wrote:
> Interrupts raised on counter overflow are currently delivered through
> the PMI_VECTOR as regular maskable interrupts. However, for some
> configurations, like SVM with PMC virtualization and VNMI enabled, the
> guest LVTPC is ignored and the interrupts are always delivered as NMIs.

IMO, that's a KVM bug.  KVM shouldn't enable PMC virtualization if the guest LVTPC
is configured for something other than NMI.

> This causes the test to crash, as seen below, because it does not
> expect NMIs.
> 
>   Unhandled exception 2 #NMI(0) at ip 0000000000400326
>   error_code=0000      rflags=00000056      cs=00000008
>   rax=00000000001300c0 rcx=00000000c0010202 rdx=0000000000000000 rbx=0000000001019f58
>   rbp=0000000001019ee0 rsi=00000000000f4240 rdi=0000000001019f58
>    r8=ffffffffffffe000  r9=00000000000003f8 r10=000000000000000d r11=0000000000000020
>   r12=00000000001300c0 r13=ffffffffff6768f0 r14=ffffffffff6768f0 r15=0000000000000001
>   cr0=0000000080010011 cr2=0000000000000000 cr3=00000000010fe000 cr4=0000000000000020
>   cr8=0000000000000000
>           STACK: @400326 400de1 401715 401e51 4001bd
> 
> Add an optional "nmi" argument to improve test coverage for such
> configurations. When passed, the LVTPC has the delivery mode changed to
> NMI (APIC_DM_NMI) and the overflow handler is installed on the
> NMI_VECTOR. Otherwise, it keeps using the maskable PMI_VECTOR.
> 
> Unlike maskable interrupts, which stay pending until EFLAGS.IF is set,
> an NMI is not gated by it and arrives as soon as the counter overflows.

Hmm, AMD does have GIF though.  What if we conditioned use of NMI on (nested) SVM
support and thus STGI+CLGI being available?  Then we can largely abstract away
interrupt masking, and if we wanted, we could even do that in advance of NMI
support since GIF=0 should block IRQs as well.
