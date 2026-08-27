Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D3499F11
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851297; cv=none; b=bVWr0Z/4F4lR3U12JVeYpwLpbnQjNwB//HCmFC5WT8FaH6xKPhRpEB77XenPYOqeHsfe+pFN3SW5BHVaSnxRxrVtCC79L/qqzAjqpEOs1mq+pr5VR28s8VQGwTfJCQik1RTRZg28tOtFFROCeEE1bkvGf6KPMg4yLCQd91YLY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851297; c=relaxed/simple;
	bh=Q2vX2PKqgnf/DT3s06TtwCDpR39+I5KACde3Q2QRvJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UYWQXmkK0BCRaw2Z9jk+p8utL3Fnan+pXjopMAMl2UZRCY92j0lQbXz+0be6V5stMND/3a7rSmDHPuxJN5XNi+FCDVGBY2hQm6FILKwL3b5egiZfpdWCYuDDcHOEQ3QjN3vXPMjgXpMB0oE3kiXimIR5JuKhv8HlJHj5M9gSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOkLBXoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOkLBXoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E431F00A3D
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851295;
	bh=Nbo8Jw/JZFRmbxLTzajprfYhK+yfsWSB2oYFirNFgOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JOkLBXoZMwoO0qgjUsL5ERaBPFhU/l7Qd1v3teTkrW10vFS3e6AV5rUfiWYgpsVLY
	 a4vDop3LZjIn8COWwK6FspX9hCeePOlWqNjRa1NMEmtregqPKeYpGkX67oQ7D6og0C
	 6fm7IODb5QFnuQpsEUpTcNIhZfYrcoqL+XCRyiG2pXhIUZ8gH0bhDE4/SQkPqhkf3Y
	 Td0qJRsvjUHj9HhIAr01PNB9A0KDK957ia+OIZNByszTQ3qdSBdelVzuNJKPUOdGft
	 hNQbeYBYROnBHvFiv199deJCpwB44A977pKNw1mO43Y/+ulJFMr0yjHsOGVrHoGtTn
	 GC6c0bRMwcFOw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c252ff776efso192636866b.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:21:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro5DUvJ/WETtVTMpBuRSCedwy8FwFpuuH8pmGW2lwdQqJDBHL8PrkLEbX1cfNtFY44vSZk=@vger.kernel.org
X-Gm-Message-State: AFuF++mv3OlCBlUwMsoUqxRWreQSyK8WSHolib1eqGZjv5S/R/IH7Kn7
	8nfaS/3PruinRMDT2y1Mq4EbBFlHneQ9NMyMlISu4EojftXb9e7tvelYvve24fOZ8ycB+z6VZy+
	K4/hhn07yHHVOul3huTQjygom9n6XkAQ=
X-Received: by 2002:a17:907:c26:b0:c25:4ca3:dfd8 with SMTP id
 a640c23a62f3a-c25534389a4mr57307666b.2.1787851294689; Thu, 27 Aug 2026
 10:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
 <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
 <apBomFOn1ZqHEnAQ@google.com> <CAO9r8zP3O_80Lr=4eKL6v-OaM9etMXPsNzADizf6ztB6YBuLHA@mail.gmail.com>
 <apBxMrqEkl_7khix@google.com>
In-Reply-To: <apBxMrqEkl_7khix@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 10:21:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOLJs_fm9ixxCRV=uz5qwpOS67=oz5ATGtB=w2Yd2vtOw@mail.gmail.com>
X-Gm-Features: AcwNN1V7RY0NKDbWFxDp6DWWaXNc7A3a2oETPSEHAGQdetAOsfYzfTwtAk0wcB8
Message-ID: <CAO9r8zOLJs_fm9ixxCRV=uz5qwpOS67=oz5ATGtB=w2Yd2vtOw@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:17=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 9:41=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >   #define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmw=
rite_operand,      \
> > >                                     __host_rsp, __host_rip)          =
                   \
> >
> > The only part I really hate is vmwrite_operand. Why do we need it?  See=
ms
> > like all the current helpers use "r", I feel like I am missing somethin=
g.
>
> ...
>
> > >   static int __##prefix##_##insn(void)                               =
                   \
> > >   {                                                                  =
                   \
> > >         int ret;                                                     =
                   \
> > >                                                                      =
                   \
> > >         __asm__ __volatile__("push $0;"                              =
                   \
> > >                              __stringify(vmwrite_insn) " %%rsp, %[hos=
t_rsp];"           \
> > >                              "lea 1f(%%rip), %%rax;"                 =
                   \
> > >                              __stringify(vmwrite_insn) " %%rax, %[hos=
t_rip];"           \
> > >                              VMX_SWITCH_GPRS_ASM                     =
                   \
> > >                              __stringify(insn)";"                    =
                   \
> > >                              "incq (%%rsp);"                         =
                   \
> > >                              "1: ;"                                  =
                   \
> > >                              VMX_SWITCH_GPRS_ASM                     =
                   \
> > >                              "pop %%rax;"                            =
                   \
> > >                              : [ret]"=3D&a"(ret)                     =
                     \
> > >                              : [host_rsp]__stringify(vmwrite_operand)=
(__host_rsp),      \
> > >                                [host_rip]__stringify(vmwrite_operand)=
(__host_rip),      \
> > >                                GUEST_REGS_OFFSETS                    =
                   \
> > >                              : "memory", "cc");                      =
                   \
> > >         return ret;                                                  =
                   \
> > >   }
> > >
> > >   #define BUILD_VMX_VM_ENTRY_HELPER(insn) \
> > >         __BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite, r, (u64)HOST_RS=
P, (u64)HOST_RIP)  \
> > >         __BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov, m,           =
                   \
> > >                                     current_evmcs->host_rsp, current_=
evmcs->host_rip)
>
> eVMCS is a memory operand, i.e. it's MOV RSP, [evmcs->host_rip].  The exi=
sting
> evmcs_{vmresume,vmlaunch}() code is rather stupid and loads the address i=
nto a
> register, and then manually encodes MOV RSP, [<reg>].

Can't we keep it as a register operand just to avoid vmwrite_operand?
Does it actually hurt in any way?

>
> P.S. just in case you didn't already think this code is evil, the '&' in =
the
>      above "[ret]"=3D&a"(ret)" is an earlyclobber that tells the compiler=
 that
>      RAX may be clobbered before all inputs and processed, i.e. prevents =
the
>      compiler from using RAX for VMWRITE's register operand, or from usin=
g RAX
>      to compute the memory operand for eVMCS's MOV.

TIL.

>
> P.P.S. even though the prototype for VMWRITE is "VMWRITE r64, r/m64", Int=
el is
>        ass-backwards when it comes to syntax, i.e r/m64 is the source, no=
t the
>        dest, and so the field encoding *must* be a register operand.  I.e=
. we
>        can't do something like this:

Right, I was suggested using register operands for everything.

>
> diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testing/selfte=
sts/kvm/lib/x86/vmx.c
> index 1a8515de42b0..b5efd10950c7 100644
> --- tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -179,7 +179,10 @@ void load_vmcs(struct vmx_pages *vmx)
>         vmclear(vmx->shadow_vmcs_gpa);
>  }
>
> -#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwrite_=
operand,       \
> +const u64 HOST_RSP_ENCODING =3D HOST_RSP;
> +const u64 HOST_RIP_ENCODING =3D HOST_RIP;
> +
> +#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn,        \
>                                     __host_rsp, __host_rip)              =
               \
>  static int __##prefix##_##insn(void)                                    =
               \
>  {                                                                       =
               \
> @@ -196,16 +199,17 @@ static int __##prefix##_##insn(void)               =
                                       \
>                              VMX_SWITCH_GPRS_ASM                         =
               \
>                              "pop %%rax;"                                =
               \
>                              : [ret]"=3D&a"(ret)                         =
                 \
> -                            : [host_rsp]__stringify(vmwrite_operand)(__h=
ost_rsp),      \
> -                              [host_rip]__stringify(vmwrite_operand)(__h=
ost_rip),      \
> +                            : [host_rsp]"m"(__host_rsp),                =
               \
> +                              [host_rip]"m"(__host_rip),                =
               \

I suppose we can use "r" here though?

>                                GUEST_REGS_OFFSETS                        =
               \
>                              : "memory", "cc");                          =
               \
>         return ret;                                                      =
               \
>  }
>
>  #define BUILD_VMX_VM_ENTRY_HELPER(insn) \
> -       __BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite, r, (u64)HOST_RSP, (=
u64)HOST_RIP)  \
> -       __BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov, m,               =
               \
> +       __BUILD_VMX_VM_ENTRY_HELPER(insn, _, vmwrite,                    =
               \
> +                                   HOST_RSP_ENCODING, HOST_RIP_ENCODING)=
               \
> +       __BUILD_VMX_VM_ENTRY_HELPER(insn, __evmcs, mov,                  =
               \
>                                     current_evmcs->host_rsp, current_evmc=
s->host_rip)
>
>  BUILD_VMX_VM_ENTRY_HELPER(vmlaunch)
>
