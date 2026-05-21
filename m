Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9E352015
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368359; cv=none; b=Sin+1HBDs+SKSVJydYMe03sxkYkMxgIOFo8DzqUEn+Fs7ZWryYNOVMEv1U/yLc0cCquywQFOLRgpz/rPGqyZKNjzVwHBLtegxl33682bDrL6kelmAsW7SL9jjrgByn6BBr7gdhoDmgQlaBpj6W81vwwYdiKo3/LKBrPxJr/nL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368359; c=relaxed/simple;
	bh=0rVVosXepCYQeGWe7dkZUA8zbJznpObfcXBvPIXEpbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bok4J3SIFMUnyg7nNEZc3rGb+kPLULY0Uiij8Ysw7LgvZh63cjYRTL2OHewGgywBYLZqBO4UX1StbSeztJ5b+S36Z/c6mI4QGYJ9hPSvos3TDSgL0BiyV4LpWZPbTs653UItvmqJXlnLUt3A6MINAmEnjT4zCjTGRty7ZrBjprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR+yDFhP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR+yDFhP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835423c69ffso3218744b3a.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779368358; x=1779973158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=BR+yDFhPhU2HJTc+bDFimLPjJebhKzYAT6Adqzfv/rz2IQeWTHscExQsyR+KXenzfz
         WkQT9RvGtGdgMVd+FvQQdjWL1Olz4MNs03/O5e/4eiXA8jGQa15BqypT/p02ljc5St4o
         96PNOLS1t3+htnko40+HcSVbb/wnqE+kcgLVjm9TNFCs+dzkmAFqGVGIWFQatwsJJDu4
         T6nrbjXGfjJ9Zazhi6K4L/6+HrOJe7afPsDlKTk41lcl9AIAksz5amaxXmqowkpSr7MW
         H4LRiRO3d4Z9j4YPND6kqqpVGHhmbtZ0ixHXg692rby216OA+miVDMzTk8NQjOR9HxKu
         LQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368358; x=1779973158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=LUmGS2UkDEi7MgT2YtfXdgWNZb5/ZCTVuocX/nAlwDoc4cHsiB6/OxnvUORBaXSNZ/
         vkLucY+fs8GECnGJUDyBW98NTzRnFg1ps60UTsnVF+4/p5qNKc2sk56Z6ktgdm2DArb4
         vogc5gRj0/413MzvM2IoJEZjXKMz7f42Kr/MrhsD+5QJ/SqriCw9DWSYXNx49yvGr2B0
         GusR2MW64kuC2LRVv8G7EAca+3jbbJwGyPdDrjr9RYt0a725jPky/TEn7O+Gn1yLHSo0
         u37vcoesiEZk5G/7O+mUx2GssL+DtQ3UbxPIoT3Ac4g1LuJOXmTNzXLwm/kautftGpV/
         t0VA==
X-Forwarded-Encrypted: i=1; AFNElJ+lk3apaTYRgUbBWE2Zbe1nrcIyofHGmW8ldPQidjl+wi5ryd5mQZp4//VsgbdFZpTkBaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL7WBagi2+cUrcqouEbMBw88gE1nYtQ9MmYqvMTZio3z6xhrg
	eVFlPJ+64y1mnEfY6G0L5CB2fUJ2cxjA4j7YVTzYKcKMMp/EKmxQvm2pDbpHQP77/x+Kanrqlyn
	ZprS9dQ==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4655:b0:82f:de7:d29
 with SMTP id d2e1a72fcca58-8414ae013a1mr2977074b3a.31.1779368357753; Thu, 21
 May 2026 05:59:17 -0700 (PDT)
Date: Thu, 21 May 2026 05:59:17 -0700
In-Reply-To: <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-28-seanjc@google.com>
 <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Message-ID: <ag8Bpc_uVNrNWqfX@google.com>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
> > kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
> > invoked if and only if kvmclock is set as sched_clock, ensure APs enabl=
e
> > their kvmclock during CPU online.=C2=A0 While a redundant write to the =
MSR is
> > technically ok, skip the registration when kvmclock is sched_clock so t=
hat
> > it's somewhat obvious that kvmclock *needs* to be enabled during early
> > bringup when it's being used as sched_clock.
> >=20
> > Plumb in the BSP's resume path purely for documentation purposes.=C2=A0=
 Both
> > KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
> > not super obvious that using KVM's hooks would be flawed.=C2=A0 E.g. it=
 would
> > work today, because KVM's hooks happen to run after/before timekeeping'=
s
> > hooks during suspend/resume, but that's sheer dumb luck as the order in
> > which syscore_ops are invoked depends entirely on when a subsystem is
> > initialized and thus registers its hooks.
> >=20
> > Opportunsitically make the registration messages more precise to help
> > debug issues where kvmclock is enabled too late.
>=20
> That's a hard word to type, isn't it?

Heh, you have no idea.  I've been "this" close to creating a VIM binding fo=
r a
while, it is time...
