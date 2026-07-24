Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E550446074
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909959; cv=none; b=gLjo1THywUIbwOWgWwtEMAxH0+/G0lbNWZjvOXV4cU9AKTykjD+hHBEZnr+QjPNabhU64hDef9HKaU75CWkRLUvrNIL6ubjO93Ebxrl8oNn+zOnzzQvXwAbocIeHBFnq0LP86M+LH53GBuqardAjKf2lE0eJWNby6rZqOnSurzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909959; c=relaxed/simple;
	bh=giUuQxxOmMjoOlFHSkiQaMvF6B8vuCBTwkQ0iNnBKRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoF8tZK1kjhd3qJqN+oi4ydT4Uh/58HmxMT42VsEiVxkM2/wmSHrcPeRAocijlul6mzVhVYcFHuh+cEUZ0WsklUEIMd/ObPGx87zjFEVi0VhSfN580pbtCtl8VUEr5Je1X2ohoBRqvsTlgjmhwxbXtE3XN5K1gL/wjI+31yScYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmE9rjuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmE9rjuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99341F00A3E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909947;
	bh=JHP7k86H3JznodLz1/TF+l53yX9Dgi1MCraE9waaqEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OmE9rjuSTQqFxn+wOmQlf2vHO31q+yO3Dndn+pqM81rSzSAMqfh9AC4z1k3btbTKY
	 BP06tTOd4V0Xa2hIi7Fp316zbugX614FCH6KHq/9gXLOVZld0C3XRvZ2Udjxdi76pd
	 9eAA57xr602fDu36b17N5E2Zg6fZnGJkN7bXI8L9xUO5wtTEjoQp0glnD9KxMR/o9V
	 UqU69beulZ+OVOpgRdSG4m6ZhvvWZ13jyQUB64e+ZgA+2SVnpOk4mVih5I5pzaR7E6
	 /uuF9Pn/p6QUpzncl6nBOCu99Uu9T0gqhDYUT8YHtAzZaMOFRwTUwFh3S9YyIqYAXz
	 I91sw1QD4PlBQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d47266baso83858066b.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpW2tcbYWmyUr4/MHbWj3jBr0a7cqllKyinYgIHJkNMqIc7eFIa+6XHPCrgehgGYQ/Kcws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwOjcpPpPm864wsC2d6SKohYSlz0XD8qzW5ADrfIuMaZSvSBx
	N9xzW4miRCXJTz1L6YXkVOc+UX7/D2vGgn1rsAgVTIyKGCG4+Ljh/L1h5sva3+CoKXi0LumC7Tc
	23lytJPvdVq5c0P/l7Ei9hLFWZVlSn74=
X-Received: by 2002:a17:907:9613:b0:c12:9eb4:48bc with SMTP id
 a640c23a62f3a-c1c509931e7mr441226366b.51.1784909946672; Fri, 24 Jul 2026
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-4-yosry@kernel.org>
 <amOF2p2tTjOXcRS_@google.com>
In-Reply-To: <amOF2p2tTjOXcRS_@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 09:18:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMZmGEmkwu7ixZE+5izZEwsAdoq3fiypiDO0fHowp7_1g@mail.gmail.com>
X-Gm-Features: AUfX_mx-9LfL4ywdn-YXcNSuPOSv2QdXSc55F6fs6-KLnn7ZdYNfwv8XFCIe120
Message-ID: <CAO9r8zMZmGEmkwu7ixZE+5izZEwsAdoq3fiypiDO0fHowp7_1g@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] KVM: selftests: Use an array for guest_regs (and
 fix offsets)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:33=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> > The assembly code defined by SAVE_GPR_C uses the wrong offsets for some
> > registers in guest_regs. For example, the offset of RCX should 0x08 not
> > 0x10. Also, the last offset in the struct (R15) is 0x78, not 0x80, so
> > the code actually saves and restore beyond the end of gpr64_regs.
> >
> > Eliminate hardcoded offsets by using an array instead of a struct
> > (similar to KVM's per-vCPU regs), and use the array index to generate
> > the offset. While at it, rename SAVE_GPR_C and LOAD_GPR_C to a single
> > macro, SVM_SWITCH_GPRS_ASM.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  .../selftests/kvm/include/x86/processor.h     | 36 +++++++-------
> >  tools/testing/selftests/kvm/lib/x86/svm.c     | 47 ++++++++++---------
> >  2 files changed, 41 insertions(+), 42 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tool=
s/testing/selftests/kvm/include/x86/processor.h
> > index 7d3a27bc0d842..535f26e077570 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -396,25 +396,23 @@ static inline unsigned int x86_model(unsigned int=
 eax)
> >  #define PTE_GET_PA(pte)              ((pte) & PHYSICAL_PAGE_MASK)
> >  #define PTE_GET_PFN(pte)        (PTE_GET_PA(pte) >> PAGE_SHIFT)
> >
> > -/* General Registers in 64-Bit Mode */
> > -struct gpr64_regs {
> > -     u64 rax;
> > -     u64 rcx;
> > -     u64 rdx;
> > -     u64 rbx;
> > -     u64 rsp;
> > -     u64 rbp;
> > -     u64 rsi;
> > -     u64 rdi;
> > -     u64 r8;
> > -     u64 r9;
> > -     u64 r10;
> > -     u64 r11;
> > -     u64 r12;
> > -     u64 r13;
> > -     u64 r14;
> > -     u64 r15;
> > -};
> > +#define GUEST_REGS_RAX       0
> > +#define GUEST_REGS_RCX       1
> > +#define GUEST_REGS_RDX       2
> > +#define GUEST_REGS_RBX       3
> > +#define GUEST_REGS_RSP       4
> > +#define GUEST_REGS_RBP       5
> > +#define GUEST_REGS_RSI       6
> > +#define GUEST_REGS_RDI       7
> > +#define GUEST_REGS_R8        8
> > +#define GUEST_REGS_R9        9
> > +#define GUEST_REGS_R10       10
> > +#define GUEST_REGS_R11       11
> > +#define GUEST_REGS_R12       12
> > +#define GUEST_REGS_R13       13
> > +#define GUEST_REGS_R14       14
> > +#define GUEST_REGS_R15       15
> > +#define NR_GUEST_REGS        (GUEST_REGS_R15 + 1)
>
> Eh, these aren't guest specific, they're architectural x86 values.  Ideal=
ly,
> KVM's own VCPU_REGS_xxx would be X86_REGS_xxx, which is possible now that=
 KVM
> doesn't do pretend RIP is a GPR.

I just called these GUEST_REGS_* because they are used to index
guest_regs, but yeah I can name them X86_REGS_*.

>
> I also prefer arch/x86/include/asm/kvm_host.h's approach of using an enum=
, e.g.
>
> enum x86_general_purpose_reg {
>         X86_REGS_RAX,
>         X86_REGS_RCX,
>         X86_REGS_RDX,
>         X86_REGS_RBX,
>         X86_REGS_RSP,
>         X86_REGS_RBP,
>         X86_REGS_RSI,
>         X86_REGS_RDI,
>         X86_REGS_R8,
>         X86_REGS_R9,
>         X86_REGS_R10,
>         X86_REGS_R11,
>         X86_REGS_R12,
>         X86_REGS_R13,
>         X86_REGS_R14,
>         X86_REGS_R15,
>         NR_X86_GENERAL_PURPOSE_REGS,
> };

Oh I wanted to, but the compiler wouldn't let me use enum values
directly in the preprocessor, see:
https://lore.kernel.org/kvm/CAO9r8zPz8WbijVN6mgLb8OaU6=3DtNSSz1NgNBjZCsC36D=
4+TO+w@mail.gmail.com/.

I can do an enum *and* macros using enum values if you prefer so, like:

#define __GUEST_REGS_RAX 0
...

enum guest_regs {
    GUEST_REGS_RAX =3D __GUEST_REGS_RAX,
    ...
    NR_GUEST_REGS,
};
