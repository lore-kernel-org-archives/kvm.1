Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB73358CA
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775627; cv=none; b=nVNoIeKWlg1SerQozogB94rxpDhZqiGJOmun1725WjGLg7qykCeMtuviZX8gLvZ01jsPNeDNrsnQh5khXh7U+j2FrsY9wzt2crOUKFKJepZ8Y3TCCx4vTXnsGqw+oTcrjkLxsV8dVtTzZjkHVdm4BjtiBKbR9p7Bn9/fPnGpzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775627; c=relaxed/simple;
	bh=bRPXR+XoAWGyM027fV86uSKqBM6jbUbGdYB+tgBt/1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NtJWDbNE0goMwgbqA5KcuqUa7XOvKczmqRteR0ykGhbGGumMC2YWcV3rQ/LEjWl7EP33mXr6HCsN+KeB0s9IQtD2h80S2kBcNr8rj9Gm/Bpfp6ckth07VxdMAY+8QD0WmeQlRNr0Gnp88Dhh34pzlkOotKpCYX1YmdunK2MU8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKFEPJvF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKFEPJvF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba838d3fa4so88930335ad.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778775625; x=1779380425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZMTbfY/E3jzMdSXTa2jqc1Caj39SJ60tMJ4eJGTiXI=;
        b=vKFEPJvFPOo2E74KeqG8JLqhp9xHiqOnZ3+geHv/T4A2Fc2wz6552roU8SRdLDHavV
         JjUlEp3e8Tf6SONq/uJijrl2fPpf85nhYLg6HqCGTu5Dz4P4jmdSSEylhhUgv7GZHhj9
         /58aiHZzwY8yxP+wPYSH3cyohi7BxprY76dZXwwrUEYQbGShCrx63er+MoISzxvO8EWp
         amNk11UJQev6/KQSzabP7miRKGf+/+s2a5YJYgkWcZhBxzomgGhqMLv879+vjiefDGL7
         FjB6LKmnIbQ9HHd6gkd1Tsn8hmbew5FQgE3b5DHGLFSfXQk8XKRUoyarJA+76XCqGyz7
         6Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775625; x=1779380425;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZMTbfY/E3jzMdSXTa2jqc1Caj39SJ60tMJ4eJGTiXI=;
        b=RY4THODJmLFIitHwyIbABuuuWJpUJD1S+Mvbzz0A0+JvKtzxGY1ar1tOvL6MBezp6k
         +y9LBvdgUkuKsdI/imeGluQadAOiqg6ChrVbZ8aGwpPUXLrfuobvZP+JArbPkx4Craqz
         JRgfP78I9scp1+/+En533SWYMy5ZxSXLscXpnp0c3dH0hUqdKJVQJHgsUbj0UNpKRQFA
         pGW3d8nqOlURaqfXZYtP86vFfHrrZLDRtt/C4tdk6cS1VmGNnJriu9nVoKcBCg7SZsc3
         9toe4VBitC7r3otOzKcfYIM4yMal0N6mqTiPZdGP71fUp6v7ue1ysEIFygBq1aW4pksK
         mI7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/vg+zf4sVm6Zm80qTkDWu5a3bIudyocL2u5akt0Fe2mpKYvPP+FDbkOwPij/oF/V55R90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHj37R6nL3kF6eIut0VuxO6oXXd3IpbYn2XNvM5lN//glYSqU
	cSwlv/Vo0LLxAT5amgtS7JiPb4TGppHG9rGHZESgjGp1QvG6Nb82uD110zv7r2Wa/+tR0Eb2Dg1
	0Sgixow==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:83a:58c1:f5e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a27:b0:398:9ae9:7110
 with SMTP id adf61e73a8af0-3aface18cb0mr9516909637.11.1778775625044; Thu, 14
 May 2026 09:20:25 -0700 (PDT)
Date: Thu, 14 May 2026 09:20:24 -0700
In-Reply-To: <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com> <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
Message-ID: <agX2SJF3rJSkIqDe@google.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026, Jim Mattson wrote:
> On Thu, May 14, 2026 at 7:28=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, May 14, 2026, Jim Mattson wrote:
> > > > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > > > index 95d09ccbf951..fc96ba86c644 100644
> > > > --- a/arch/x86/kvm/cpuid.h
> > > > +++ b/arch/x86/kvm/cpuid.h
> > > > @@ -185,8 +185,9 @@ static inline int guest_cpuid_stepping(struct k=
vm_vcpu *vcpu)
> > > >
> > > >  static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
> > > >  {
> > > > -       return vcpu->arch.msr_misc_features_enables &
> > > > -                 MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> > > > +       return (vcpu->arch.msr_misc_features_enables &
> > > > +               MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
> > > > +               (vcpu->arch.msr_hwcr & MSR_K7_HWCR_CPUID_USER_DIS);
> > > >  }
> > >
> > > Sashiko raises a good point here about a pre-existing issue that
> >
> > Calling this pre-existing is a bit of a stretch.  I'm guessing VMX does=
n't check
> > the #GP before the VM-Exit (checking #GP before a VM-Exit is so stupid)=
.
>=20
> Per the SDM, volume 3, section 27.1.1: Relative Priority of Faults and VM=
 Exits
>=20
> Certain exceptions have priority over VM exits. These include invalid-opc=
ode
> exceptions, faults based on privilege level,1 and general-protection
> exceptions that are based on checking I/O permission bits in the task- st=
ate
> segment (TSS). For example, execution of RDMSR with CPL =3D 3 generates a
> general-protection exception and not a VM exit.2

...

> > Where in the APM?  I can't find anything in the description of CPUID or=
 CpuidUserDis
> > that specifies the priority, and "Table 15-7. Instruction Intercepts" i=
s flat out
> > wrong because it just says:
> >
> >    CPUID  CPUID  No exceptions to check.
>=20
> APM volume 2, section 15.7: Intercept Operation
>=20
> > Generally, instruction intercepts are checked after simple exceptions
> (such as #GP=E2=80=94when CPL is incorrect=E2=80=94or #UD) have been chec=
ked, but
> before exceptions related to
> memory accesses (such as page faults) and exceptions based on specific
> operand values.

Oooh, this is based on the generic CPL rules.  I didn't think about it from=
 that
perspective.  So yeah, addressing that does make sense.  What a pain.
