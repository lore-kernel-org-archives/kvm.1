Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126421771B
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893191; cv=pass; b=RsiJmC/XyF4nfE8fHgwIXoqxpscXgJ1kfuLMSIJBEyBGMtUeN/vivRG8O7baJpOYjKIMz7Ix3iSL34PrA6HMOOgQaF/yceJp60n7SK68vJaapujjgsF6SaqjOuMf2KRgWWzSrDmwbLN8yHvQVL41bb0VoAevaCh6zbAY+ObsKsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893191; c=relaxed/simple;
	bh=nY61M98sNbFncUjcLGc9YQMg14gQYVXeRn4B4Hdca0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhOwbe8TtdAsizGHy8WSjpaqVRv59RUDoIxPyerIKhja+PbS7kLYjpSbdtEhCmIk8qEXmSFD0urzH2PCHxlsXlIPu3Inqvi/FOrNNO/rQFtlsyYeEJnJO8VtX6Ti048rfAdLOr39190snSkIpb5xsWDAQ/W2OtKrz4aitLP1uS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8vxFe9X; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8vxFe9X"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so6014a12.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 21:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773893189; cv=none;
        d=google.com; s=arc-20240605;
        b=fKvszF9g/XJXP3x1+/jl9BlAmv8AB4JkUTrOSwmY9H2LKODISVol6Quy2/8GE4Gu3X
         pb6dl7Q0tfYhezGVQJzWxVyW5yfRkW0Yl1pDZCkPe7SNuQ7OQJ0E/m39xjGzzu0AAgWI
         j9UjIzgtt92TZNx+/dMEL0qiNRGG9HcBBKxBMx7QmDG1iq9L/nO9J2YXo89LoliM2+In
         gT97qEj4CgZGRwFRpI7ViTJLETT1KxPGk1Sn9ETiKthglD1yR8bKloRWmj3AoIrarsYL
         KkJuXwQ7ZaKDJUPaq/4qYy6lQD7Tl/b/LOfrexvxoA4Yj4x8nfaX2Hr6AeSfogylWG9x
         Iswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZFupn+7z2aHtdyw3MiPnyeYQXXbBr5+TRfey41p/lPg=;
        fh=BBJDJK3qS1H8RxMDFUEW0JVjTpOu7iBcZCZsL1FQlcw=;
        b=lJDMe6/Ev/KHxa8ADmx70XO1QCo0pSTK2xv8hMZ11Vb+dOxVWYN5Fx2TEPfLbGOL5P
         sBQEiyqDpQXtd/dlnc4CLuIIM11md1MoTj6iNiqBAnckOmDIJ72rgWxhXukbYy1CiRTH
         fFWQpIRqQ9I1YYFtMSYDUBPSMj43rq7/ptBXdMh4KygwW+TkNVXaX5M13xoPgKl+dxTy
         eDbT/h4w7YZqD9TjlGmAhRgwSrikia/Ibev45Tl0G94lwn4LIU6+C9b8h5Hth/xPOkEY
         Gf+yCzMIuRmP7XCcxkJRepnP5JlAB1n/aS6JoL0kMRlD3ag6OIaUaNnm4Yu12KHKf5kV
         kJqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893189; x=1774497989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFupn+7z2aHtdyw3MiPnyeYQXXbBr5+TRfey41p/lPg=;
        b=F8vxFe9XxJQaZB2m1xp/FlAQH7hDyOQS5nw5CvKeGC6Md6GZSLx0aeBy2KVNLOg7Ys
         4xM6u7Y9Hyoh4BQn+2VJFm0R4Jy3GIMIexNAyC3IWRHye8n5ZxycbNdw9YL3O4YqyhSL
         tIyfRBmQovoXnfX3QkYcXqd0SxuQbgITO/w0BUwOnqZRXVagTD2ga/u8/1ssKob5klnG
         07c59Djzfp6U6AnljUjFH8ZZULDBpFQIb8IVdhqYFGEhJpzzyQAjQWKszIwJ6e6HkMAZ
         J0CDOBbxd4877hq2JB5nC/CdSSYsrpyFtT3Ug75qlygnghMpTdrUDKuvYQPi2DQbFB4r
         55pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893189; x=1774497989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFupn+7z2aHtdyw3MiPnyeYQXXbBr5+TRfey41p/lPg=;
        b=PTHXP4xLOq6FbF3wa5r8WosQkUJBdAetrsYcrbym5srSOQf7n0sCIRwm3jfHFueaz9
         uka2Rdj5+zf3+3kNXYm6mEGLRwoyA9tKWmN2FpUMZuJwiZK0/eujKungc7GFFRPdjv3p
         kSdkcknbsSElf54AFh+8NGjBiAXt+3+HnwcFzWa34wYT1VqxroHs5piianBTxw5KS809
         FHpe/oVan8v9LoBoKxmf/xRIEcv4v0LCNk5WoBIN6eJA0g4JwCe2yRbDKVakNqX9NKfZ
         +KuBdIhQ17umqj31qL+hlnNmrKsRXpZ2gNr3vfg/vx89nahg5uDN1ryU7B8DjiZfwhCA
         DuJg==
X-Forwarded-Encrypted: i=1; AJvYcCX93HMWsKnfpFxww3s+mC3mBEABsEhr6snYWacuJoBnSFx8pQibmIhYTX+CRkD0nBt96zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJnVlfv8+JLw0x4JhCauVmwt6gR6R1syaX1PW1qtkrVV9IIcG
	2cAURPYMWKpbB1F5BfYJWikjnzBkHMZ55SH1ej9jJMR3V1UVkkZvc0Q/ZfgKlgGTmlrXUcqE3Eb
	bjcucpC4poauL3nwjvPhnmh5wunaeKDjCO4m/stAZ
X-Gm-Gg: ATEYQzxCh8hKXjoQ9LrpoxYZqkfRuZdHy1Z7t8R7o5cMijUQXQowMCTSxkKRQXxdqor
	XYzHRwv6wTWe5ZWLesjHNU9NlAXzvf5Wr4BGor48wwfjCzzMNhtset6fcs2i2jbPdepY8xsQ6kr
	ORDbzvKzgfntcdmnzLabmSLVU4t6HOVCIDaNSdqFk7vQhgY/S4FNgNwSJvy/OgJaNeBUuE3qRiD
	I/JjnxH839idcjGc6w6z6CmT8Tv4NkoD80RUPOx6LqnY62tWNtNVYc5hVQrPT+GUJml3tBC8/P6
	HEIphb1qYcgDwvbm2w==
X-Received: by 2002:a05:6402:a518:20b0:660:f90b:a19b with SMTP id
 4fb4d7f45d1cf-66852d86339mr17295a12.8.1773893188325; Wed, 18 Mar 2026
 21:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_VUswFkWiTYI0eD@do-x1carbon> <Z_aovIbwdKIIBMuq@google.com> <CALMp9eRvB5Jqbs6aKMsPzKDJE7Pb0iUTsO9Ot1CB698px1GHcA@mail.gmail.com>
In-Reply-To: <CALMp9eRvB5Jqbs6aKMsPzKDJE7Pb0iUTsO9Ot1CB698px1GHcA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Mar 2026 21:06:15 -0700
X-Gm-Features: AaiRm52WJRfvPAUqdIkMTaSmp90F_ogLSUXEWsodofL5Jcw8j1NrdQ8m-_7HYBY
Message-ID: <CALMp9eTxwD2c1CwyzLr0eKkCM2YJYo7XTViMCwo=envoWoEssg@mail.gmail.com>
Subject: Re: kvm guests crash when running "perf kvm top"
To: Sean Christopherson <seanjc@google.com>
Cc: Seth Forshee <sforshee@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:02=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Wed, Apr 9, 2025 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
>
> > Long story short, masking PEBS_ENABLE with the guest's value (in additi=
on to
> > what perf allows) fixes the issue on my end.  Assuming testing goes wel=
l, I'll
> > post this as a proper patch.
> >
> > --
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.=
c
> > index cdb19e3ba3aa..1d01fb43a337 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4336,7 +4336,7 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
> >         arr[pebs_enable] =3D (struct perf_guest_switch_msr){
> >                 .msr =3D MSR_IA32_PEBS_ENABLE,
> >                 .host =3D cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_=
mask,
> > -               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask,
> > +               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask & kv=
m_pmu->pebs_enable,
> >         };
> >
> >         if (arr[pebs_enable].host) {
>
> Because kvm_pmu->pebs_enable is optimistic, I think we also need to
> swap these two modifications to guest PGC in the code below:
>
> arr[global_ctrl].guest &=3D ~kvm_pmu->host_cross_mapped_mask;
> /* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
> arr[global_ctrl].guest |=3D arr[pebs_enable].guest;

Doh! The line above those two lines is:

arr[pebs_enable].guest &=3D ~kvm_pmu->host_cross_mapped_mask;

So, the ordering of the global_ctrl modifications is irrelevant.

> By the way, IA32_PEBS_ENABLE can be modified in NMI context by
> handle_pmi_common(), so the host value returned from this function may
> already be stale. We have seen cases where handle_pmi_common() clears
> a bit in IA32_PEBS_ENABLE between here and the next VM-entry. VM-exit
> restores the stale value with the bit set, and that bit persists
> indefinitely. If the next perf event assigned to that PMC is not a
> PEBS event, it magically becomes one. When an NMI arrives for PEBS
> buffer overflow, perf refuses to claim it, because it doesn't think
> any PEBS events are active. So, we get an "Uhhuh. NMI received for
> unknown reason" message on the console. A flood of these is enough to
> trigger the NMI watchdog and cause a panic.
>
> I think we need a fixup after VM-exit to clear any IA32_PEBS_ENABLE
> bits that were cleared by handle_pmi_common() between
> intel_guest_get_msrs() and VM-entry, but I'm not sure what the best
> API might be. Calling intel_guest_get_msrs() again seems too
> heavyweight. Maybe KVM could ask perf nicely to just rewrite the MSR
> with cpuc->pebs_enabled? Note that any erroneous IA32_PEBS_ENABLE bits
> are dormant post VM-exit, since any PMCs throttled by
> handle_pmi_common() will have their enable bits cleared in the
> corresponding event selector.
