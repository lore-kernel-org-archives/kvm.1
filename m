Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3F345731
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853062; cv=none; b=L2VkIrlj1LBTYfx4kstW9a3scMw30qWYs4denyNh2yMWqu035R/49y6Wbv1nwjm4c295OCYrVz9qLHxKcXyWHR4VblJuGM99u/1pWptOQzxYBqzaTYSj+6gK6ZFhDNjm1phejua+NhhB+eyfk74zr7G3WS0sI/2YDx55wU+LKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853062; c=relaxed/simple;
	bh=98xSLCeP/KtjNIE3URT2T3ktkLlRgaR2uDzIK7EVBC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJsowWhRMVLGqzuaWnXcclQltAJyQDPomYYE6A8kUGack5vUtcRErTVgq1JnRC/CK2hbYBkrxodPEdFxJt4vjFQsbnhRRR87ejEG/T9Hkscmyajv0MkJcMqgD3ddLseFD5G5af0TT/XzI8sOEtROXuhXbOVzGY6ot3GWrNa6W3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy4Qqmnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy4Qqmnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0605B1F00A3A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853061;
	bh=AA9Eg0o6kfycCZiwUGvxKpK3Wz7lkTqnaLYtvXj6bv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Iy4Qqmnwp1H9ZEqACqVv3bPqMPC0TfxCeWcUT+Z3KorgFGoHmiDaSPtsApnXaPF5i
	 F+TcgDte0T215Pb4dfTYqMtJaY4QiIYEdzq4uZYdRmqtC8lqzQrEX6IP2OU4LKfOek
	 +xalo5SpUjoRrIfrf00gXi8soQpQFw7+eSSFaa/GTI34zVpLH3GVfX/ap7IriblyLg
	 5YgR2wHlbBY1KbOHZyAgH5Oj4L+TyUD0vr8Bhny8DUByDYt6Lpasds8x424JMKVjqW
	 7Co24JReBCiP5ANVSb85Uw6oACV8bOTGSG7QH/X7y7BePBTL59usXOwaIwEcmL9TZV
	 o77ah8Q7IfGXA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c207cb16cf5so22208566b.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqX22iAu5epwKth1+H9c9XapDipBKD4TXMwcQRZiCOdOPQ47C20bi4zP7K/y3YwMyt5Obg=@vger.kernel.org
X-Gm-Message-State: AFuF++lsHLnGicPQs+d58/lorzg0vfqbHCvndbswokGf2j4kmISW+77L
	f/3T7ElQWXBaV/6Or4BYzlgVyEpeB6cpgs480Yj1vWg+N8O5suoIhP/UkEw2kAmQ2UQil88JcN8
	GZRNQiGwI+5IrszUShRDTun82eat3/ko=
X-Received: by 2002:a05:6938:a084:10b0:c1c:64d4:5ba3 with SMTP id
 a640c23a62f3a-c25571a8f9bmr24618066b.20.1787853059996; Thu, 27 Aug 2026
 10:50:59 -0700 (PDT)
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
 <apB0-xly771CU7m_@google.com>
In-Reply-To: <apB0-xly771CU7m_@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 10:50:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNBpMry1ipXcNcQgZgUkTSb4scDadiMNXN0AwqJiY=8pA@mail.gmail.com>
X-Gm-Features: AcwNN1Wa9VbVW9ULNjRnPEstsY-Z3ikWYpJe-mFQA5YB7LB5wYWjhCZNky6CCWw
Message-ID: <CAO9r8zNBpMry1ipXcNcQgZgUkTSb4scDadiMNXN0AwqJiY=8pA@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> > On Thu, Aug 27, 2026 at 10:17=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > eVMCS is a memory operand, i.e. it's MOV RSP, [evmcs->host_rip].  The=
 existing
> > > evmcs_{vmresume,vmlaunch}() code is rather stupid and loads the addre=
ss into a
> > > register, and then manually encodes MOV RSP, [<reg>].
> >
> > Can't we keep it as a register operand just to avoid vmwrite_operand?
> > Does it actually hurt in any way?
>
> ...
>
> > > diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testing/se=
lftests/kvm/lib/x86/vmx.c
> > > index 1a8515de42b0..b5efd10950c7 100644
> > > --- tools/testing/selftests/kvm/lib/x86/vmx.c
> > > +++ tools/testing/selftests/kvm/lib/x86/vmx.c
> > > @@ -179,7 +179,10 @@ void load_vmcs(struct vmx_pages *vmx)
> > >         vmclear(vmx->shadow_vmcs_gpa);
> > >  }
> > >
> > > -#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn, vmwr=
ite_operand,       \
> > > +const u64 HOST_RSP_ENCODING =3D HOST_RSP;
> > > +const u64 HOST_RIP_ENCODING =3D HOST_RIP;
> > > +
> > > +#define __BUILD_VMX_VM_ENTRY_HELPER(insn, prefix, vmwrite_insn,     =
   \
> > >                                     __host_rsp, __host_rip)          =
                   \
> > >  static int __##prefix##_##insn(void)                                =
                   \
> > >  {                                                                   =
                   \
> > > @@ -196,16 +199,17 @@ static int __##prefix##_##insn(void)           =
                                           \
> > >                              VMX_SWITCH_GPRS_ASM                     =
                   \
> > >                              "pop %%rax;"                            =
                   \
> > >                              : [ret]"=3D&a"(ret)                     =
                     \
> > > -                            : [host_rsp]__stringify(vmwrite_operand)=
(__host_rsp),      \
> > > -                              [host_rip]__stringify(vmwrite_operand)=
(__host_rip),      \
> > > +                            : [host_rsp]"m"(__host_rsp),            =
                   \
> > > +                              [host_rip]"m"(__host_rip),            =
                   \
> >
> > I suppose we can use "r" here though?
>
> No, because then the encoding for VMWRITE needs to be:
>
>   vmwrite %%rsp, %[host_rsp]
>
> but for MOV/eVMCS needs to be:
>
>   mov %%rsp, (%[host_rsp])
>
> Have fun feeding the '(' and ')' into the asm blob :-)

Semi-joking, what if we pass in the entire instruction instead?
