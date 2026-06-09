Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A40040860F
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008108; cv=none; b=eLWi+FDMysIQF6TjPAHV8NHXVZ2c2x7Ww5Uf2tD/SWpL8iyZAGgTRwr6sIXXVKoOJqkAIiyYGJPzSGZlJ2M8+z02iQS/8mpUjv5vAAZj50jdYy6EGMn3jS+jzacf4tjRWz47bLZjqCMaAsfEfb957AzJE8CyoDyBhwkTlkM8dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008108; c=relaxed/simple;
	bh=lGEDaxP9s5MVbkz0GqDIcVYCTfkJX1Q1PY4dt58kBow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1aVjhpyqyv2Ns1WCNGJcbibNrktnNe5R+VKXHZqkA3PLtCXgFTwrdA3k+Uu/m+xLS0zjuo0NsdsWzCshARTyc55NpUGrUQN/qB/9+8m24me0gJaIx+Ns/V8cF3PmD9H0oLvvfhF6qXrAgaqqQx1iVKrdKwmdDA6IpnMu97bnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU+WTCSR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU+WTCSR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso3569518b3a.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781008107; x=1781612907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=DU+WTCSRssJwa5wdtrb4CWbSufN3OC0Prz86X0WlYIDJI+tJgnlOg6zPqp+N4CDzFW
         FCKi8B17p5aS0Yi2MEADjSiwugwoaxswbwIQZWQQsj/6H2MlT8ZMYahbTTpYWOukY6wV
         RnU6+HrAcEJmpcuwuQjFkHITFNwhE/5j0PEr4p1RAt+ZrGr9lb3NAVHMY5LwMHBoRbAq
         XP8exaSCqWeLrDm3/eOnLqNfmPA/qnThrR5vMvCgaY8BrDwlhkr1e77FyWj6XdJm2bBo
         TPZ6hLalYkmWqS2mNlsvmbBa42aYETE+dDZgwqd5HCCFBsQa3T3E0ViAPj5Gaubcljli
         jq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008107; x=1781612907;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=VxvX8xxKKoEG4Uwl54it1neS5QhUHEAAWPoqGcZEfMC/fm69b0oLLkPCe3pPSYgVOr
         v+PvNDZTMH9dD1D6LL3hjKqRkDS1zymbzrUazWSW8tl+X+SDoq7V88YoT9yWrNPmwgIM
         JG4KhGcFORDxB/xQMMe9+cmktE+pTZebElpK0EKP4RPRheBIRp0V+7GkeH4GQ4n5Z46p
         esy+tgfOfnsnWzdW9iEKijcy/IfZMI14KhDfrGy9mZOlRlF3xcumiFzLIZ6mJai+i/lp
         zyOnGI//zbUKz11GJsEFV5ZpQs0QRdkkf2BWBxDLrDEQ9v8nhHVb+6B+16q/xESF8kUf
         lBBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JPpA4Af64KDb91M693Ul/QteEufOAKWUQUCa+YPOUZ7dYDdU/zIom0F2GLwKPJAsL4Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaCvAnDuvx5VB+7p/v1IsSpKpMkMc9DBvW7yFvWCE3cB8BvBx4
	02sqjnEU/yQgB/olPUNiY3r6oLa0qcvMPEOnzqFLqDyPWuiTspXwv12hDFPT/KxqLbqGPYF0puG
	++uoOjA==
X-Received: from pfjf5.prod.google.com ([2002:a05:6a00:22c5:b0:842:4720:4013])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2910:b0:842:6fce:6171
 with SMTP id d2e1a72fcca58-8430a62f307mr3223335b3a.3.1781008106459; Tue, 09
 Jun 2026 05:28:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 05:28:24 -0700
In-Reply-To: <87a4t440js.ffs@fw13>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-11-seanjc@google.com>
 <877boc554l.ffs@fw13> <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
 <aidEfvTMjLa2zt43@google.com> <87a4t440js.ffs@fw13>
Message-ID: <aigG6NdLZtbc7prD@google.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026, Thomas Gleixner wrote:
> On Mon, Jun 08 2026 at 15:38, Sean Christopherson wrote:
> > On Sat, Jun 06, 2026, David Woodhouse wrote:
> >> > Along with:
> >> >=20
> >> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring n=
on-sensical tsc_early_khz command line argument\n");
> >> >=20
> >> > or something daft like that.
> >
> > Ya, I ended up in the same place once Sashiko pointed out that skipping=
 the SNP/TDX
> > setup was hazardous[*], and also once I realized that tsc_khz_early *co=
mplemented*
> > the refinement instead of replacing it.
> >
> > This is what I have locally:
> >
> >         if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> >                 known_tsc_khz =3D snp_secure_tsc_init();
> >         else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> >                 known_tsc_khz =3D tdx_tsc_init();
> >
> >         /*
> >          * If the TSC frequency wasn't provided by trusted firmware, tr=
y to get
> >          * it from the hypervisor (which is untrusted when running as a=
 CoCo guest).
> >          */
> >         if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> >                 known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> >
> >         /*
> >          * Mark the TSC frequency as known if it was obtained from a hy=
pervisor
> >          * or trusted firmware.  Don't mark the frequency as known if t=
he user
> >          * specified the frequency, as the user-provided frequency is i=
ntended
> >          * as a "starting point", not a known, guaranteed frequency.
> >          */
> >         if (known_tsc_khz && !tsc_early_khz)
> >                 setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>=20
> If the frequenct is known via the above then you want to set the
> KNOWN_FREQ feature bit unconditionally. SNP/TDX/hypervisor override the
> command line argument as you print below.

Doh, forgot to remove that check when I shuffled things around.  Thank you!
