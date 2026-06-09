Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A54C0431
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025427; cv=none; b=AvRanXmG25oSa9MxeWtgdLiJybTXy7dwOhUmggfrgOL1LUhJRYwtmD6P988yZuDmQLyPsrEWEeyPDKdx1kR6XmM/dWgyNecbbW8qmfaKgI0pJACYp2y4saDgd/k99p7W6k/uhiMFcwpABNjF6RmLtGkkpnO2Lf3rrgkh3wcv7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025427; c=relaxed/simple;
	bh=0yX1le44tc/9XtzmqoIANl5jWHza37di/KrrdJWLzbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4yDI4SIoOnCJvgIPR5ZyGT8JrqBRoXFkF1O31fMhijogWpzBIeR50amcJswchuucmur6Njfqizm9+78HYpTgGWfCVglsRtvL7/Wzfp54Wazg0DiR4mPEQFFb1iHYJdY8SJ9heBKe3p+HSZB9r5cFsTl5R55avuyUJweYKx+H/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8KBVCtV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8KBVCtV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf30576aa3so41043885ad.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025424; x=1781630224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=llq4Kn5i8ui4r4izxxTvg7cm7qJE2krNstJXZkbKQn4=;
        b=s8KBVCtVd1cjGtYZ0XC+KmoyL3dYkMocyXltXuOVX001T1Vhpg3oSCO9LHHYzPEx+R
         v7llcoRBz8VAxnVxAfrGryebeAP7OpQ2dL9s4xEoeTK7Hil6CKRqTQp50RUmnbKwA//0
         sTaGzvjKSq2vSxnkWKrL47I58hGeXqgNHkBOZhk9wtx8Q0K5ydW+9WDyL7dbm9PD/ZVL
         5wptLmtUv9nrDXECohxU5pjxw2jVrg4+s0p9MrHtikrGvAKHcvSStexyfHFVVnhlxzER
         34Oxm/AN5N2LfYI+z1dMtGtFErPRMECxr8fxI3k4MnXbZmYe176ZX/emaTmKyc1ppxPY
         AEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025424; x=1781630224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llq4Kn5i8ui4r4izxxTvg7cm7qJE2krNstJXZkbKQn4=;
        b=YWU2KrRLRt7nvDYsfks1i+oSKlCjpnKcYsKS7VDyaw4uTsP6Jv41oaVe2L2vpTnoMU
         30Sn1Vw2aNRxnefTIgRlFj6Id0OQkicg5edaIr0wmHg7zgF34u9af8XI7ob5VD44eYvb
         3sd4Ze/3sEhgFfH87klEnCaiNu5fD+s/OTOux+UkjWg9RCCqRtqBUGhLML+BAzDIVfjb
         MhrwDA4qGx0uOb3j+YaAXerQXxJbkwA2zlFc+IeR+rE+nVwHAJ14vrE0/6upBq7znkRc
         75jv/mmrchTnOEdORaQ74ADKlMpoJRC873Nf1EdAitP5QefauKlLwKi4MzUui6iW7hEL
         VjEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rqDU8nRzhMYMh1sT6hx/Y7meoxMo3KlioR0rDhkOyDRzyZSFfjhH/79XV/jPv2FvgKnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8T7oT16vNrCQH6t4m9Z1PB4AJ45hJDyb8h+gAMd2rjQFb7SN
	el615uAjarSVPeDGBa9geIp83LNv3aJOk18ha5bhIg2anZ5DTzaxILA8uNQ2WgtHY9YFk0AIjKf
	7smJd9w==
X-Received: from plpg1.prod.google.com ([2002:a17:902:9341:b0:2bd:1ca5:b928])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:196b:b0:2be:3434:4e28
 with SMTP id d9443c01a7336-2c2a1c66522mr44737215ad.19.1781025423861; Tue, 09
 Jun 2026 10:17:03 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:17:03 -0700
In-Reply-To: <87a4t86a0l.ffs@fw13>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-2-seanjc@google.com>
 <87fr315fq9.ffs@fw13> <aiMPxl5vkvJDldi9@google.com> <87a4t86a0l.ffs@fw13>
Message-ID: <aihKj-0nP7bUbNHH@google.com>
Subject: Re: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if its
 exact timing is known
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Thomas Gleixner wrote:
> On Fri, Jun 05 2026 at 11:04, Sean Christopherson wrote:
> But we also should have a check in the TSC init code somewhere which
> validates that X86_FEATURE_CONSTANT_TSC is set when
> X86_FEATURE_TSC_KNOWN_FREQ is set. X86_FEATURE_TSC_KNOWN_FREQ is useless
> w/o X86_FEATURE_CONSTANT_TSC.

Ugh, any objection to punting on this for now?  KVM and Xen guests will trigger
TSC_KNOWN_FREQ without CONSTANT_TSC, thanks to commits:

  e10f78050323 ("kvmclock: fix TSC calibration for nested guests")
  898ec52d2ba0 ("x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()")

Hyper-V guests might as well?  Hyper-V's handling of TSC is weird, even for a
hypervisor.

Even when the frequency is provided in CPUID by the hypervisor, QEMU at least
requires a fairly explicit opt-in to advertise CONSTANT_TSC, presumably to try
to prevent users from shooting themselves in the foot.
