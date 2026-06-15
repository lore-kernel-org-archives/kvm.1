Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857F396B7F
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552289; cv=none; b=uD0qzK1AQXJkTmxHIRl2jX5Zg46dcDqcVWDseHqZiTXapwPnuDjoBap01iq3HLxVYnEOVs8/Jo3SD3ZVJJc6eBY1CsLzpYgk4HJgfNWfpmdDb/nH73ReaiYaDb1cae6YaM7qHK7252+Ux8ZnLInuJpUcrgawCBN3d9QvupTAjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552289; c=relaxed/simple;
	bh=lrgqIF/mjECQo6WT3ktE1TEVzQwCweh6IAPMwloAr5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3pur3nz9haEQOPBF9ic2PXgOXIWHMAV/s+xCiJnNMQH/nWGYAB/b51mUWlYKiTJzr5OWMIs48RoPX2w3N7g0VJC5S41vnvSC6Im6kwd+X19gefaXtCoRqchWmIpS4nYiHDxUT/nWthgkWRQ7xYBM1Bs1uCjHc3WE5RIwZsPJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1m/cpo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1m/cpo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE71F00A3A
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552288;
	bh=3RSQeke4udSklKG4LzWW0CPeGYZoTqU0etBOUbfF9U0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n1m/cpo0g2wzcP9EPQfp3+Bi6OTf8udMiaSbr7Dw903QIS91mhkARunvFV7GpmNaD
	 vh9Qs9HvwogTPPv3YINXyQHYBRmCSKlgH2TwW471nlsBHwCHKGNMo4pp77f74DgYST
	 X81Uqy7sGRz91cRdDQ+eEPywtStU82JKmN7PmOGDKJtVobJgWgSWDahMc3r4jWno5p
	 QbsP5wBkVO18kthas81SNvk5DKp1KI4dXeS/9fOtaNyV1XlbpF6dpKSoy4D/DvG8UC
	 ax7JsSPu+tAQ0XBuzqOgNrEE1caN3crW31aw1pRDauEQR/EYviGvw4n+CS66/M6FMl
	 uuv8NAwarWuQg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so523991966b.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ZvxGWIhNvUHQKI1tFYThBXjv/gSQjg6CciYBWNMsHTChrlekoH80BEV8Gk9MKmE/b4p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIsU5ki9ocT8EXoIEJn9OzzzP64hD44qOLx6SqIhCX14hLFC3
	Z3xdKH19vRW5eaXR2j2iXfCavDpA8Ni8Ur9H9hPwZyPA1cncJFRiI2owNBfWcyl+WeTwrfbNhtn
	w6PRUBnn1A2qamgLf8Yv5MHttH6zoMtw=
X-Received: by 2002:a17:907:1c13:b0:bec:5ebd:e169 with SMTP id
 a640c23a62f3a-bff4a30f33emr637491566b.22.1781552287188; Mon, 15 Jun 2026
 12:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
 <CAO9r8zMX3_JgrJNQGuvFaANXKsA4hMEgO7=OS=q=-AA4mMhhaw@mail.gmail.com> <ajAwSMLG9OJfnVQT@google.com>
In-Reply-To: <ajAwSMLG9OJfnVQT@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 12:37:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOfhY_tT3JvtOx-3rkrsRYB67whp2ZDwR9pkarEpAtSCQ@mail.gmail.com>
X-Gm-Features: AVVi8CcrZnpYMC3q8rcx31MKWdaBG9VMLAd76DRFvbUdC2n29PZpUki48tXo7_k
Message-ID: <CAO9r8zOfhY_tT3JvtOx-3rkrsRYB67whp2ZDwR9pkarEpAtSCQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

> > > 2. Aside from TDX, seems like {vmx/svm}_interrupt_allowed() are doing
> > > the same thing? So maybe move all that logic into
> > > kvm_arch_interrupt_allowed(), rename it (because it's only used by
> > > x86), and make interrupt_blocked() the actual per-vendor callback?
>
> Doesn't work, at least not with more changes/hooks, because nested_exit_on_intr()
> is subtly vendor specifc.  The concept is identical, but the implementation needs
> to query vmc{b,s}12. :-/

Duh, obvious in hindsight :)

>
> I'm not opposed to figuring out a way to move the logic to common x86, because
> I agree that's where it would ideally live, but I don't want to tack that in this
> series.
>
> > > I assume this is the case because nested_run_pending used to be per-vendor,
> > > but now we can clean this up. For TDX, I assume the per-vendor hook can
> > > just be tdx_interrupt_allowed() reversed?
> >
> > It also does the renaming (nice!), so we're halfway there. I think for
> > this series, we should at least convert all direct calls to the vendor
> > .interrupt_allowed through the new kvm_is_interrupt_allowed() helper.
>
> Sadly not in this series, because handling the for_injection=true case requires
> moving the nested_run_pending logic to common x86, and without that, we end up
> with two very silly wrappers.

Yes. I think probably the way to get there is to replace the
.interrupt_allowed hook with .interrupt_blocked and a nested hook to
replace nested_exit_on_intr(), but I am not sure if performance will
matter here if we do two calls instead of one. With that, we can end
up with most of the logic in kvm_is_interrupt_allowed().

But yeah, at this point this is definitely not something to do in this series.
