Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BF32E72F
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394722; cv=pass; b=qi5EkKoK4jCPTj3nX8qqiIj5gB/E8hzLvYlMhJ7NqOrTsacBT8Clt6WsOhOLvpenvONbbNDJKbvYZTQjUQISvex/h2Sa61ZlLezcPGvC4WSoRUcTqVJp4BLsjT5MxUdpQftBI9RKdqjaZVzHZpER4y7/urghoFn2UcjIuWr4phE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394722; c=relaxed/simple;
	bh=JUQQR1oPNfUfNNFpRz0UfhBcP0zUk26c3dSQprfAzJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpHk2oeAWQkbm4T494eeOdFFeGn469SWfmLLBX16daKPrumImztyMNiwpIS8RQR8E49CvbdMEsFf0uPcHklITmt+UovjgHuiHuDU0P/gzEASHvAXpAGl/AmWCF4ib/Eb0UWrO5h1ySPFrS9d6BHcvRL4P2pWP5P60dcf6heyK5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=il43kB6a; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il43kB6a"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1665a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 20:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783394720; cv=none;
        d=google.com; s=arc-20260327;
        b=IirThbMbQqx+vC+cw4Mw/z+HVoJ8IWX0ppKU9gxFR3bWisQ6lNJEN9mHtF+Dl01Lod
         t/IeBk2GIi06v6gCyhWGPUxJF4tA7eozkEjprslrz/ZWC31KWI4R2biXD/b/A1zOhi6C
         rO5GIraSS0DSyBlqOUZyP0FvhUNvyyVxQ4j1kTvb0cPvL0enjxXUvMqFGY02bz65lyo3
         l9D+v1mcaSUMOtSuvp+Vaksrwdr+X4TBslGLZ9N09CU7CBS9mT4+BCGNSsfprTHbWgcU
         06lgEdvZtOwwuTurM3yBJSEqn0h/NCouOPH90o5rxXcVDnUdY4NsHAzlwWmLFQRhul7c
         adBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FSN/7jkO/THQgi7rBzivwdf4R8K+C1xk2GyT2rq723I=;
        fh=RdT4zpGe1gw688smleUPrtGB2gqlXNr+PxmkpQO5eWs=;
        b=UXnt8C4WQIf0b8uzjWWgMC/6CRs4CjMxBcls7ag1K3tUBnx4RdOkGIdhjsjVvWWc9h
         il3DLwgecRZ3wxmCI+naEd77KpTMh7BNrRr1CMbgCK336/zHR4VPzXNjoQH6NjLrqLiX
         hoItptpiLTpncA0ML0qzEs0qZLmSi01l5QI70DLdQne1OTpw7CbPQaQnT4Qf9rWU5AnW
         pM4qFZGGwaTph6CRSWv/8baR94pb06tE64G/Yjn3nqV0gF+pSbN9jgv5P+GxjJAS9pKR
         PdIVvP91kLRL0+HSXk7fX4hTGahQPtdW5xcDflPPnwvdwwK0PRaxeCDeu5ws7bHp0Bx/
         KV0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783394720; x=1783999520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSN/7jkO/THQgi7rBzivwdf4R8K+C1xk2GyT2rq723I=;
        b=il43kB6aWTHMz3aRITwMB+Td4jwNCf0nHC0T7jAEBYguCLncIGQrfmRL69hYxdJiaA
         JpLsNxh81yWsoTXRe52Y14Gxj0iOGUNmxgPhJYE+xNCBLB9ZoYaKAhVQSqReH2RoMDc+
         AcWLrfLcPpxYy5Sb3ATqCcO8M/CPUR9zd0CidLZrY8ExWTpPNhh+ytjHhS+WCJB+98ZJ
         fblrMthnw5qmNE68DzWxb8aZ9IlpfTSboZye/WRBr58+ecdUmEZnXfYBH463J3wTzY4n
         Rpl3Med+Ej/l/ZK7EBs8T7m9F57gFGKaKljpaEP2nkj+BAXT50lkxuT9FmHrFlYR5h6w
         5nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783394720; x=1783999520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSN/7jkO/THQgi7rBzivwdf4R8K+C1xk2GyT2rq723I=;
        b=YtodGt1YWyK7UlWS9HyPy3bFeUYCqdJDi9PHPPSCCw660kluoxASvI/gPwufQ/AZhR
         E4py0iF3UQIJQgQAQn07dploIm6k2I/gsB0j0N+G0I4swAvPC91sF8yVLwJP6W5ZAg9H
         okQxuMmSNEmJKTZyRaqXhzyZhjJpm3HiJkBcMeygdD7ZEg1VA91Njh6tRRioMYwmP3tc
         rFUrVqwIucSAdcsc02aKK+cbyTDu1c87B/06q6Tr/etMl0l24o4tzbva4T8MMLqQ2vZv
         Evokh9LXwd1geT1kkvqe17XCaA3FyW+eT41IxVVB904TMGCnLurXH5NVm92NBsmFv12F
         pVfw==
X-Forwarded-Encrypted: i=1; AHgh+RpXWSIKW71i9ejX1xM9p3L+xUbfcU8uLoXtPD12ZMDIek+1tLzf1JhQHb4XFvQmh56c4I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVscVgnvO2dosq4nkJccV+yPGELRYoGoFy5FpQtWSGsEyRsVZh
	hSBkKmDnoBHdEEuO9VOIq1HG0f6pCMVTJ0ZRW4xmDJ6IEcioWoNXIawKfylvDgura2oRfKIyOea
	CZKW6RE/Gdj9sryplRMPoSAXugfFeyX5nRNemtL8u
X-Gm-Gg: AfdE7cmlY1a56wzsbg8/TzCSGMKai8bxOGSpKHFLotGKQPDJOINKW3hVqlySno4OtIj
	J+AXoVoexj6Zh0qOOgL59btulCXG/q7QJC7taFl684VOtIE/iI/ejiD5OImyULoxCXQEoBC8hBb
	cuJYzzIScdkHDZsXTQQiw0nXwX7Rhs7cMrhJwkypnj1zEA/q8yDLXMrvR59i8cUCmKRVMSMWl0G
	bVevD1JOkiggtrC/ZzSnIGlzth01ut6Lp071ww4t4C47UskWKMAWL/zPf97BvbsYr3QR1YI
X-Received: by 2002:aa7:d8c4:0:b0:696:b77c:ba9a with SMTP id
 4fb4d7f45d1cf-69a91370f64mr10055a12.1.1783394719359; Mon, 06 Jul 2026
 20:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
In-Reply-To: <akxwt1mX6blSnkxI@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Jul 2026 20:25:06 -0700
X-Gm-Features: AVVi8CfuejAVy712ilr9YphmdP8cUuU4yAzMJ6TW2-_EOEZkQzRbivVW67fKzIQ
Message-ID: <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:21=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jul 07, 2026, Tina Zhang wrote:
> >
> >
> > On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-hie=
co.net> wrote:
> > >
> > > > I will take another look for the next version and try to handle the
> > > > remaining pieces properly, while also making sure we don't expose s=
tale
> > > > or incorrectly synthesized decode-assist state for emulated exits.
> > >
> > > Naples erratum 1096 seems to imply that the instruction bytes stored
> > > in the VMCB are not necessarily the same instruction bytes that were
> > > fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> > > emulation, it might be sufficient to read the instruction bytes quite
> > > late in nested_svm_vmexit(). That would certainly simplify the
> > > plumbing.
>
> The plumbing doesn't seem all that complex though.
>
> > Thanks for the suggestion, and for pointing me at Naples erratum 1096. =
I
> > wasn't aware of that erratum.
> >
> > My understanding is that late fetching/decoding from guest RIP is not
> > strictly equivalent to preserving the exact bytes observed by the origi=
nal
> > decoder, as the code bytes or translations could theoretically change i=
n
> > between. But the suggested workaround for erratum 1096 also tells the
> > hypervisor to decode the instruction at the instruction pointer when
> > GuestInstrBytes cannot be used, so it seems that this is an acceptable
> > model/fallback.
> >
> > For KVM-synthesized/emulated #PF/#NPF nested VM-Exits there is no fresh
> > hardware GuestInstrBytes state to propagate to VMCB12. So I agree that =
it
> > should be simpler to avoid plumbing instruction bytes from the emulator=
, and
> > instead fetch the bytes late when constructing the nested VM-Exit for L=
1.
> >
> > I'll try this direction first.
>
> I'd rather not, at least not as the primary way.  It's going to raise a d=
ifferent
> set of issues, e.g. how to behave if reading guest memory fails.  That's =
probably
> unavoidable, e.g. if reading the INVPCID descriptor fails, then KVM doesn=
't even
> have a pre-decoded instruction to work with, but it should ideally be a l=
ast
> resort.
>
> E.g. where the NULL case triggers an on-demand read of guest memory.
>
> diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
> index ba985a02208a..812af3a8d8b9 100644
> --- arch/x86/kvm/svm/nested.c
> +++ arch/x86/kvm/svm/nested.c
> @@ -42,6 +42,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu =
*vcpu,
>         struct vcpu_svm *svm =3D to_svm(vcpu);
>         struct vmcb *vmcb =3D svm->vmcb;
>         u64 fault_stage;
> +       u8 *insn_bytes;
>
>         /*
>          * For hardware NPF exits, the GUEST_FAULT_STAGE bits are only
> @@ -68,7 +69,14 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu=
 *vcpu,
>                                     (fault->error_code & ~PFERR_GUEST_FAU=
LT_STAGE_MASK);
>         vmcb->control.exit_info_2 =3D fault->address;
>
> -       nested_svm_vmexit(svm);
> +       if (from_hardware)
> +               insn_bytes =3D svm->nested.vmcb02.ptr->control.insn_bytes=
;
> +       else if (vcpu->arch.emulate_ctxt->eip =3D=3D kvm_rip_read(vcpu))
> +               insn_bytes =3D vcpu->arch.emulate_ctxt->fetch.data

Won't this be shy of the architected 15 bytes if RIP is within 15
bytes of a page crossing and the instruction ends before the page
crossing?

> +       else
> +               insn_bytes =3D NULL;
> +
> +       nested_svm_vmexit(svm, insn_bytes);
>  }
>
>  static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
