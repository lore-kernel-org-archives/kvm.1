Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0D3DCDBC
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854913; cv=none; b=Vgi8wabnOVlXyZb15dpZ6fb25fVoWScfJb09/yeNoJkm7jCfZ5Xvc+WnASbXl5pbfgPKCOY4E99s7aU13qTvVQ2MRuY4NRsdv9+p9DBt+U59H9UAkcwbF/B6B/muWk/hY6flKtUaQIIt07ox0FLQVWFFlUazQ9eAHaRXTJySxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854913; c=relaxed/simple;
	bh=l1f5hRevgKH8JjZ+SZUpJpw1Vr/K7hc8Nu/vRqyoRO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhEaS8w80Pc8ZKlP45mcXsduAzjx4I3CtrzlFKRk8ST2lM/fJX84Q2nhaTmfD/MLFWzn3H1mLCVaMCe456D9cez5L2JlumANX2bYJaSdL2jgppgLLGSJYqe2nxfkxWJP5VSLk31/gDgNYQRPa+3pVk+bSY4ySAFZtrRFGqf0tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwfs85H7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwfs85H7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903ED1F00ACA
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854912;
	bh=FAy1Q9YXLdMo+8ilgf6UBUK0WvHjAoC6zfuJqq6oPDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rwfs85H78EtB9phRTlsAMVyL9tXeWaB67j5YZEn3xQAu2INb6WpsnYySmDpWBQmvK
	 Twwy7s/mFdE3Qgqgeg6rzOOWBLxdhDFJaixyHzCdXWN9JpCl5xwg2r5P1jD1hCgzHM
	 7G/01cJFbiqOjePtp0j03OYjmEMLc80UXwdI7kZJppeSVbvgo2hyb9kLQsvHBzRa20
	 Z2D8OU9AGkIh/I/goeb8PzHRviMDQDH+4gmoPv+1rb3CH6X24GlGt9DOU0/C4xvoY9
	 8SiuMHfIuiXhVmoNxOPvPpCnHpK14Wkj8jRj2nbXG8jSBoiovu+tuviYXa3hTwa541
	 TIkMLqlZ0vmRg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so23342266b.3
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:21:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqnk+IF2IyHzRl5kJxQRbl2m1us+mr8w8TENAyjW/lT3htHeMWga5rc1MIIaOpMyk0XZI8=@vger.kernel.org
X-Gm-Message-State: AFuF++kscOQtxNiZ7fQJojhbcZCks1Me+ttOw1wC17lb7xbUH7TsWfL3
	WNC7jAUpTfU/J2apHWpgQjkJNfMr4C4spT+yUtZh0CHdX3sWeoXAxlta8sfzqAMal8vfVYiJelt
	S2IlQyTKW9aWCfIepsn2RYVfO4msVkd4=
X-Received: by 2002:a17:907:c5c3:b0:c16:14d1:b529 with SMTP id
 a640c23a62f3a-c25571f3a11mr48299366b.18.1787854911427; Thu, 27 Aug 2026
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
 <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
 <apBomFOn1ZqHEnAQ@google.com> <CAO9r8zP3O_80Lr=4eKL6v-OaM9etMXPsNzADizf6ztB6YBuLHA@mail.gmail.com>
 <apBxMrqEkl_7khix@google.com> <CAO9r8zOLJs_fm9ixxCRV=uz5qwpOS67=oz5ATGtB=w2Yd2vtOw@mail.gmail.com>
 <apB0-xly771CU7m_@google.com> <CAO9r8zNBpMry1ipXcNcQgZgUkTSb4scDadiMNXN0AwqJiY=8pA@mail.gmail.com>
 <apB87RG_qon96Q8R@google.com>
In-Reply-To: <apB87RG_qon96Q8R@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 11:21:39 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMudqAMX2W8v102yhZ-NFyu7Z=L-iQ11FyN7L8YE2fq3g@mail.gmail.com>
X-Gm-Features: AcwNN1ViTyEKnuilUuNmJedzKHNh1cFIr1S0Ry4cN4uoIt5LCqv49USWhdknc-4
Message-ID: <CAO9r8zMudqAMX2W8v102yhZ-NFyu7Z=L-iQ11FyN7L8YE2fq3g@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > > > On Thu, Aug 27, 2026 at 10:17=E2=80=AFAM Sean Christopherson <seanj=
c@google.com> wrote:
> > > > > eVMCS is a memory operand, i.e. it's MOV RSP, [evmcs->host_rip]. =
 The existing
> > > > > evmcs_{vmresume,vmlaunch}() code is rather stupid and loads the a=
ddress into a
> > > > > register, and then manually encodes MOV RSP, [<reg>].
> > > >
> > > > Can't we keep it as a register operand just to avoid vmwrite_operan=
d?
> > > > Does it actually hurt in any way?
> > >
> > > ...
> > >
> > > > > diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testin=
g/selftests/kvm/lib/x86/vmx.c
> > > > > index 1a8515de42b0..b5efd10950c7 100644
> > > > > --- tools/testing/selftests/kvm/lib/x86/vmx.c
> > > > > +++ tools/testing/selftests/kvm/lib/x86/vmx.c
> > > > > @@ -179,7 +179,10 @@ void load_vmcs(struct vmx_pages *vmx)
> > > > >         vmclear(vmx->shadow_vmcs_gpa);
> > > > >  }
> > > > >
> > > > > -#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, =
vmwrite_operand,       \
> > > > > +const u64 HOST_RSP_ENCODING =3D HOST_RSP;
> > > > > +const u64 HOST_RIP_ENCODING =3D HOST_RIP;
> > > > > +
> > > > > +#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, =
       \
> > > > >                                     __host_rsp, __host_rip)      =
                       \
> > > > >  static int __##prefix##_##insn(void)                            =
                       \
> > > > >  {                                                               =
                       \
> > > > > @@ -196,16 +199,17 @@ static int __##prefix##_##insn(void)       =
                                               \
> > > > >                              VMX_SWITCH_GPRS_ASM                 =
                       \
> > > > >                              "pop %%rax;"                        =
                       \
> > > > >                              : [ret]"=3D&a"(ret)                 =
                         \
> > > > > -                            : [host_rsp]__stringify(vmwrite_oper=
and)(__host_rsp),      \
> > > > > -                              [host_rip]__stringify(vmwrite_oper=
and)(__host_rip),      \
> > > > > +                            : [host_rsp]"m"(__host_rsp),        =
                       \
> > > > > +                              [host_rip]"m"(__host_rip),        =
                       \
> > > >
> > > > I suppose we can use "r" here though?
> > >
> > > No, because then the encoding for VMWRITE needs to be:
> > >
> > >   vmwrite %%rsp, %[host_rsp]
> > >
> > > but for MOV/eVMCS needs to be:
> > >
> > >   mov %%rsp, (%[host_rsp])
> > >
> > > Have fun feeding the '(' and ')' into the asm blob :-)
> >
> > Semi-joking, what if we pass in the entire instruction instead?
>
> Then there needs to be separate parameters for RSP vs. RIP, and we still =
need to
> pass different operands, *and* it bleeds information into the callers sin=
ce they
> would need to hardcode use of %%rax and of the named constraints.
>
> As ugly as the proposed code is, IMO the maintenance implications of the =
below
> is far worse than the subtle 'r' vs. 'm' (and on principle, I dislike pas=
sing an
> address in a register and then manually encoding a memory operand).

Yeah this isn't pretty either. I don't feel strongly either way tbh,
so whatever you think is best.

One other option is accepting some duplication, and letting the eVMCS
variants be separate. Basically keep your original patch as-is, and
just add a similar one for eVMCS variants.

Again, no strong preference, and I generally prefer your proposal for
deduplicating all of them if it wasn't for the subtle 'r' vs 'm'
thingy :/

>
> #define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_rsp, vmwrite_ri=
p,             \
>                                     __host_rsp, __host_rip)              =
               \
> static int __##prefix##_##insn(void)                                     =
               \
> {                                                                        =
               \
>         int ret;                                                         =
               \
>                                                                          =
               \
>         __asm__ __volatile__("push $0;"                                  =
               \
>                              vmwrite_rsp                                 =
               \
>                              "lea 1f(%%rip), %%rax;"                     =
               \
>                              vmwrite_rip                                 =
               \
>                              VMX_SWITCH_GPRS_ASM                         =
               \
>                              __stringify(insn)";"                        =
               \
>                              "incq (%%rsp);"                             =
               \
>                              "1: ;"                                      =
               \
>                              VMX_SWITCH_GPRS_ASM                         =
               \
>                              "pop %%rax;"                                =
               \
>                              : [ret]"=3D&a"(ret)                         =
                 \
>                              : [host_rsp]"r"((u64)__host_rsp),           =
               \
>                                [host_rip]"r"((u64)__host_rip),           =
               \
>                                GUEST_REGS_OFFSETS                        =
               \
>                              : "memory", "cc");                          =
               \
>         return ret;                                                      =
               \
> }
>
> #define BUILD_VMX_VM_ENTRY_HELPER(insn)                                  =
               \
>         __BUILD_VMX_VM_ENTRY_HELPER(insn, _,                             =
               \
>                                     "vmwrite %%rsp, %[host_rsp];",       =
               \
>                                     "vmwrite %%rax, %[host_rip];",       =
               \
>                                     HOST_RSP, HOST_RIP)                  =
               \
>         __BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs,                       =
               \
>                                     "mov %%rsp, (%[host_rsp]);",         =
               \
>                                     "mov %%rsp, (%[host_rip]);",         =
               \
>                                     &current_evmcs->host_rsp, &current_ev=
mcs->host_rip)
