Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A033C0600
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178378; cv=none; b=akGFCny02gCE6CUx0pe9wHmyORlY4MjKsc8P8FUI4tVDXuUm2iuFLlP/uaydu9KSjrbG3vQ027NxpH1j6g9eHDi7GGL4PrdCCFjOHsgYFX1ruDeXqKBu1KcqIe9cTUYVTzK4eKD+ZUbD7F9fH11eEDIZz7/TOkWqEKizOBFi/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178378; c=relaxed/simple;
	bh=WnP2L3Z244f2jFb4DejSCVxYFVK4CkmnAYjbQNaO+Vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXdCyUuGvhSRZwIfKzkW6i5eim3Acy97TLF77dvEodxjmyK3L8USYB2u/pKP068lEgPlF4WKKHp4JJ8PCqelsxVdkcJw9J1pxdVMutIPJ1Cwb5JLKaWzcGDWgO0Fmu/rqt8jBegeCBkrgR5ijaoxPSnLYQCTwHElBmCGu9QbjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow5HCdGQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow5HCdGQ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c797d8c9c2dso1425010a12.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778178377; x=1778783177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XwEaSXiweDe5hmWJaN2upZUdWOSyRB+UON0cDCFjcI=;
        b=ow5HCdGQxegM7fMFi6ZmVdluY3g7ILJxqqK0cfm+EE6cKKGsKNiOAcdX/e1cWS34u8
         0qhrnRdyfp3IpcdYA3QsIMKDxm4/K8t9602CuxbaD+LIYfeiPAcQ7zVbs4Ww18r8K5fp
         3lIRo6/FsBhVeNL6TrVSCb7eyC9rQM662hK7eYrLCs6nF0COC3HLqxZPrLXeOGfCM54v
         Ous14KQDvpSNWzG8EPRZQsY33UunUO62SbWuSAPGZRH4ybznICU6Jwx25LabO4hYNa1P
         +GmhniCxvG0cjHb7xHByioHfoSO6PqbkpM/tDaOcCzkm8inOeFIcz8IcnTq/KkWzbT6T
         ZWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178377; x=1778783177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XwEaSXiweDe5hmWJaN2upZUdWOSyRB+UON0cDCFjcI=;
        b=NLyaIYPl1JX0Xq4gG4rkTmvBvj3NyrY2NaZ+hN+PsyIaKZOx1QS3JH5RFi4j7nfgTO
         MWw6OB2SUMgw3XP/WpJZKRpqVsZv59UnA3j+R8+MPsnyDxipm2RplJNf7PJDr3keSVZv
         Djfol226TXEt4IJ2yUue4/gVfNT1QpPREygU3LbhxodN2KnJEMc0t1bC2nEpDjRu+GJJ
         0fQ8b7OOmlafe10stCZe7Fo+YzfZguG000FtC2VyZ6h051cO5zwEbogKdU0e1bil+1cE
         kBxYQo9TtWV7mvqnidt0sbBRfiFT7MOJPegHDC4IAMWVk63HtQVD44Fso85CAnrvcukl
         /VyQ==
X-Forwarded-Encrypted: i=1; AFNElJ80rItnD1qFDj/qEsFhFXYlKzI4cVlJScAsn6FtzXKYgSId8RLp1cPvccrr60aQ/iBzly4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zdR6By+Nte5NYL7yAXUbmt0SkRRPYiP8/7yKJZJ7jU4xJuzM
	qAK+QK30gdSlU+IVJE23I4ydN91MJ+gjyn/Ydl8vKKB1J6V1sxVKv7GZGhMbuPS057f7d8P+rVS
	ufWTL1Q==
X-Received: from pfbhx5.prod.google.com ([2002:a05:6a00:8985:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e87:b0:82f:5034:77a4
 with SMTP id d2e1a72fcca58-83a5c4be2eemr9226149b3a.21.1778178376445; Thu, 07
 May 2026 11:26:16 -0700 (PDT)
Date: Thu, 7 May 2026 11:26:15 -0700
In-Reply-To: <afyzRvFqb19Kodej@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-3-seanjc@google.com>
 <afyfFRkUIHuodvG2@blrnaveerao1> <afyzRvFqb19Kodej@google.com>
Message-ID: <afzZR3S43Ebr4khL@google.com>
Subject: Re: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT
 (current APIC timer count)
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Sean Christopherson wrote:
> Oh!  Actually, even better!  This is a great opportunity to dedup Intel vs. AMD
> (and we can/should do the same for writes).

Scratch the writes idea, the behavior of Intel x2APIC virtualization and AMD x2AVIC
are too different.  Intel doesn't trap writes when x2APIC virtualization is
enabled, and instead redirects the raw value to the APIC backing page.  Which I
guess makes sense since WRMSR interception is about the same overall cost, and
it allows the host to safely and fully disable interception for registers it
doesn't want/need to interpose on.

AMD on the other hand more or less follows the xAPIC (AVIC) behavior, where regs
without "fancy" acceleration generate traps.

Side topic, handling a trap-like unaccelerated AVIC #VMEXIT is ~10 cycles faster
than handling an intercepted WRMSR (out of ~1770+ cycles for a super simple reg
like LVT0).  I.e. we _could_ deliberately disable interception of x2AVIC MSRs that
get trap-like behavior, but for me, being perfectly consistent between Intel and
AMD is more valuable than shaving a few cycles for paths that should rarely be hit
(most of the trap-like registers are "configure once and forget about them").

The only reg that's at all hot is Timer Initial Count Register, and (a) it's a
moot point with TSC Deadline mode, and (b) the cost to program hrtimers is so high
than shaving ~10 cycles is completely meaningless.
