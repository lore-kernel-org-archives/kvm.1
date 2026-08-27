Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53E2EC083
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849404; cv=none; b=JGHks5B644yScyEg0nMThB+vr7CmT2SgMv2saRTHvj/tDJ166zO7KZ0SKUjkriulNL+GaYExljTlLQPda+nt7Ht7uEd+2bpbpuhGFXcDMZn5MHFXyMgVBc4xNqzdR7Y3pdAibcrmbn7moHoeCmJDZB7xaSMiY056dGbOFH3Bp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849404; c=relaxed/simple;
	bh=hq6Dd50QNE5pWnkdJ3+SExZCZgpC+xCCarGNcc61RpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kadj8bYvCNWvw5nkheES/RtCYhEKpiSYvhguZl8zCpRtJWCYRHb6hflx9X+ERDUra3mm012l63O7o/ryIu9zdaQQQr6EHfYKO+Ac6mVIixIexM/Y+UzjK1JalkOCnbO65SPmIMOVEiaLU28Iv9klH3duYlK2sXeoOvXRMmjqpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnw2tHW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnw2tHW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79E11F00A3A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787849402;
	bh=A/HAoX1rGIxvt6EEdQNxTt9eQFJoQAsSXwVrATMnQi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fnw2tHW7/JQrFneuoDnsPVtBASjixPJmOmusU213TMDjOGxosTRME5M6qS4fz6zza
	 +vBPRSOku1WgC7NZrRQhccTW4wQPPuWxuUK2AxVNEeqdyvbea1nldOt6eFMNM5Rcf4
	 faxONOwZnCrhje0MaOdCNVsy+3mptZBd436U763i4tOJxykHH0lIMBeRlUeMYnk4K9
	 yywJF9bKIWISA6yh31jsx2X4HNN1Hdyx/0pMLWDOLoQgA6ok73Xif/HUejjYio8uTr
	 I5aC2QHisbja7NrmHyz62XZmjqk6a8/FB7v4b+V1M8O2NOWvYZ23j9Wi+UAQ42kMBo
	 269U0RB1SvfNA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so270829766b.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrEc+CRYKP8QZsTbYBNrUMo5Oh0RDgtEWHkX5VUj252HEz5sNp3lEdEr3PdFsesAg/qAdA=@vger.kernel.org
X-Gm-Message-State: AFuF++nIhi1thPUyUlogtQ4tyQ9qPjdMq6MupuTqkk6wSqdalm53N1cW
	dy96PHcYnnYSDB76bnyIEoeP9rlqgcOEw/fMut9bd21tjvOFJlU6zV5+TvMspdnsnrWqkXFh4ll
	tqGOrhlZ2T4m4DVlnaRv7uok/5XSqlBQ=
X-Received: by 2002:a17:907:1c94:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c2553d1daf7mr27301666b.10.1787849401600; Thu, 27 Aug 2026
 09:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
 <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com> <apBomFOn1ZqHEnAQ@google.com>
In-Reply-To: <apBomFOn1ZqHEnAQ@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 09:49:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP3O_80Lr=4eKL6v-OaM9etMXPsNzADizf6ztB6YBuLHA@mail.gmail.com>
X-Gm-Features: AcwNN1WbGRFrBMKj62JwHlPuclqja8iCvmGe-oH8-_V7feeYeeyNw27mngDjnYM
Message-ID: <CAO9r8zP3O_80Lr=4eKL6v-OaM9etMXPsNzADizf6ztB6YBuLHA@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:41=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Aug 26, 2026, Yosry Ahmed wrote:
> > On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Dedup the assembly code from VMLAUNCH vs. VMRESUME, the difference is
> > > literally only the actual VM-Enter instruction.
> >
> > You couldn't resist macrofiying this too.
>
> It's either that or throw a branch in the asm blob, which is surprisingly
> difficult because VMX_SWITCH_GPRS_ASM subtly clobbers RFLAGS and obviousl=
y
> clobbers GPRs.  Which basically leaves pushing the value on the stack, wh=
ich is
> totally doable, but still annoying, and needs to be done immediately, bef=
ore
> vmcs.HOST_RSP is loaded.  Branching at runtime also makes the generated c=
ode
> harder to read, e.g. when debugging, as it's not immediately obvious whic=
h
> instruction was actually attempted.
>
> That said, looking at this again made me realize evmcs_{vmlaunch,vmresume=
}() have
> the same core copy+paste mess.  Blech.  Macrofying the standard flows but=
 not the
> eVMCS flows is rather silly.
>
> Inlining these blobs *twice* (VMCS vs. eVMCS) at every VM-Enter is also r=
idiculous.
> E.g. at a glance, it's responsible for something ~100k bytes of code in t=
he compiled
> state_test.  While the code footprint of selftests isn't a priority, that=
's still
> absurd.
>
> So instead of macrofying everything, how about this?  Depending on how on=
e feels
> about macro shenanigans, it's either horrific or amazing.  Or both.  But =
IMO it's
> worth eliminating all of the copy+paste, and it makes the control flow mu=
ch easier
> to read, which in practice is likely what most people care about?  At lea=
st until
> the entry/exit sequence fails and they have to debug macro hell :-)
>
> vmx.c:
>
>
>   #define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwrite=
_operand,      \
>                                     __host_rsp, __host_rip)              =
               \

The only part I really hate is vmwrite_operand. Why do we need it?
Seems like all the current helpers use "r", I feel like I am missing
something.

>   static int __##prefix##_##insn(void)                                   =
               \
>   {                                                                      =
               \
>         int ret;                                                         =
               \
>                                                                          =
               \
>         __asm__ __volatile__("push $0;"                                  =
               \
>                              __stringify(vmwrite_insn) " %%rsp, %[host_rs=
p];"           \
>                              "lea 1f(%%rip), %%rax;"                     =
               \
>                              __stringify(vmwrite_insn) " %%rax, %[host_ri=
p];"           \
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
>                              : [host_rsp]__stringify(vmwrite_operand)(__h=
ost_rsp),      \
>                                [host_rip]__stringify(vmwrite_operand)(__h=
ost_rip),      \
>                                GUEST_REGS_OFFSETS                        =
               \
>                              : "memory", "cc");                          =
               \
>         return ret;                                                      =
               \
>   }
>
>   #define BUILD_VMX_VM_ENTRY_HELPER(insn) \
>         __BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite, r, (u64)HOST_RSP, (=
u64)HOST_RIP)  \
>         __BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov, m,               =
               \
>                                     current_evmcs->host_rsp, current_evmc=
s->host_rip)
>
>   BUILD_VMX_VM_ENTRY_HELPER(vmlaunch)
>   BUILD_VMX_VM_ENTRY_HELPER(vmresume)
>
>   int __vmlaunch(void)
>   {
>         if (enable_evmcs) {
>                 current_evmcs->hv_clean_fields =3D 0;
>                 return ____evmcs_vmlaunch();
>         }
>
>         return ____vmlaunch();
>   }
>
>   int __vmresume(void)
>   {
>         if (enable_evmcs) {
>                 /* HOST_RIP */
>                 current_evmcs->hv_clean_fields &=3D ~HV_VMX_ENLIGHTENED_C=
LEAN_FIELD_HOST_GRP1;
>                 /* HOST_RSP */
>                 current_evmcs->hv_clean_fields &=3D ~HV_VMX_ENLIGHTENED_C=
LEAN_FIELD_HOST_POINTER;
>                 return ____evmcs_vmresume();
>         }
>
>         return ____vmresume();
>   }
>
> vmx.h:
>
>   int __vmlaunch(void);
>   int __vmresume(void);
>
>   static inline int vmlaunch(void)
>   {
>         return __vmlaunch();
>   }
>
>   static inline int vmresume(void)
>   {
>         return __vmresume();
>   }
