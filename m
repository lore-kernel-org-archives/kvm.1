Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB62EBDE9
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001492; cv=none; b=tFOot/uAvsS7lIP8wR5XDoGz38FZJeWqp+XwOkwuxkFMLtaYrwK0r/+5QuMXjNoVdBHQejsnzNAFfnuNMicnb5OjY4Osgy/d8tZNODr9lNFD6kfjLJOyO8YFhh6WdAlOg0YL4KjscIc8ujxqjgbcnK+T1wh170gZ6v36PuA+0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001492; c=relaxed/simple;
	bh=e4CmGyWXjfTeWfkwiyi+/rIf8mOqJekR3R9IpPk5lHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnUvSgQPYUpqjG8Jr/Cl1K2Rk1/S0BEFMf/zGaOBQIbdU9pl7EtLuQV3YaMe7XowiVkEjfrV6Ak1f6NkSspqROXvwLyIx+F/UPj2gSSpOIkRAiPTN/M9Ul+7lz6urdiMhn3Q3/7PYTcyHARpArcCCEW/Few7XBS7FDoJnAANV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5a8VN4g; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5a8VN4g"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so3321085a91.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 17:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789001490; x=1789606290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRIMJxhn/P9+4wFGBvYMMbxEht2YCax0x/lNJGg/0QU=;
        b=v5a8VN4goY0d89TPRBQmoE/r8SVhIr1eiO26rtqNd42jG76gU7wAoLD2OWq6bOsgto
         knhr+eCCXDJvLQhXmtuYAehTzPiyJZsi8XvbRtU1w3YGGn9KSt/IGjHx08L9hBwmxWMW
         u2x4/s04HbIUbWL0JMiit+G0Ui2p5aS7LDQIvUEdh0qoAndMWRZ2deQEw1SnqsVzAPpM
         4jRO5U8AbJRTKQBff7/+QezCZ89v1cPyXbHbY2/mY9Xa5m62LxapxIj4GDRbd6dgsgnD
         Y7t8cCdzM0LiIL/4N4MIs68BhE1y7UfVBTPnS1hyrriPxF9N5A8NJAn5n0+y/YmlPkcR
         e/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789001490; x=1789606290;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRIMJxhn/P9+4wFGBvYMMbxEht2YCax0x/lNJGg/0QU=;
        b=QmMQ4/bWunQGpvTzKuIV0WhVaDRcGDcYPEjlKQKMmLTsW+iWDKxKwDV0JiLZstE9H0
         9B51z+Y4R3wD4eOTqKxUsDnpPrY/b9DD/nGcF0v7DmCKh8qZd436jFOsA9RV14q+/wD1
         U00CMabOCg1GzWOERkSNurMQRwQNUAfnjbcNzpwgcpWYVT57eAOr8r5yIgd1/n+dkgTn
         fmp11mTabBCbGZEHn1kiJG7al3hDArgd5aJPO69YSrSECe0/Qg7PREvZgo5eXPuAHl30
         XHoTAj2wE5tsevBxDmph9zO8Xx40gSKfPZI4RVVy2LBVOIup94ip38ilekMDLewev5tC
         QOmw==
X-Forwarded-Encrypted: i=1; AKwUvBx1KsYQC3Cgc5qD/dlGP4iEov5VwRGxYRW5WaCgrB2aYfIRzRKGH9RYcibFYcMUICnU5mM=@vger.kernel.org
X-Gm-Message-State: AFuF++nHrgTUIVUfxOawpjooZI58xUZTXT4K5Y4qkjOUFluKuDidggJe
	q7s2TNr8S2Oxik/Jyz+pEtgvHuif2k6OMgZMoAAyZSynMSG6KXh6om0nj1Vm0sDhhM7OrxzwEEF
	PxyXU2A==
X-Received: from pjbmr23.prod.google.com ([2002:a17:90b:2397:b0:39d:64b8:27cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1850:b0:38e:bbf1:de3f
 with SMTP id 98e67ed59e1d1-39d70b4a963mr6666007a91.12.1789001490137; Wed, 09
 Sep 2026 17:51:30 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:51:29 -0700
In-Reply-To: <CALMp9eQQY-Tu3C0QLMe2kxvt=__Fq91dLtzA=fbTDNc_Av7Gew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-7-zhang_wei@open-hieco.net> <CALMp9eSoLMx6DLH=Ve5_r7y=0EOmxjZgJWE_fLM_CAYxOvJdkA@mail.gmail.com>
 <f187e4d1-9d31-4e54-a75b-b724ed5d0e9a@open-hieco.net> <CALMp9eQQY-Tu3C0QLMe2kxvt=__Fq91dLtzA=fbTDNc_Av7Gew@mail.gmail.com>
Message-ID: <aqH_EVgaV-s0pJg1@google.com>
Subject: Re: [PATCH v5 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2026, Jim Mattson wrote:
> On Sat, Sep 5, 2026 at 11:40=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.=
net> wrote:
> > On 9/5/2026 8:39 AM, Jim Mattson wrote:
> > > On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hi=
eco.net> wrote:
> > >>
> > >> For a synthesized #NPF, the emulator fetch cache is not guaranteed t=
o
> > >> contain the full architected 15-byte DecodeAssist window, e.g. it ma=
y
> > >> contain only the bytes needed to decode the instruction.
> > >>
> > >> Keep preparation of synthesized state limited to capturing a matchin=
g
> > >> emulator fetch cache for #NPF.  When constructing VMCB12, copy those=
 bytes
> > >> and fetch any missing tail through L2 guest page tables.  If no emul=
ator
> > >> bytes are available, fetch the full window from L2 RIP, including fo=
r a
> > >> queued or synthesized #PF VM-Exit.  Stop at a translation fault, rea=
d
> > >> failure, non-canonical address, or CS limit overrun.
> > >>
> > >> For a non-64-bit L2, truncate each incremented linear address to 32 =
bits
> > >> so that a fetch whose CS.base makes it cross the 4GB boundary wraps =
as
> > >> required.
> > >>
> > >> Do not perform tail or fallback reads for SEV guests.  KVM cannot re=
ad
> > >> plaintext instruction bytes from encrypted guest memory, and the exi=
sting
> > >> SEV emulation path treats missing hardware DecodeAssist bytes as
> > >> unavailable instead of decoding guest memory.  For nested SEV, repor=
t only
> > >> matching emulator bytes already captured for a synthesized #NPF,
> > >> potentially a zero instruction-byte count.
> > >>
> > >> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> > >> ---
> > >>   arch/x86/kvm/svm/nested.c | 58 +++++++++++++++++++++++++++++++++++=
+++-
> > >>   1 file changed, 57 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > >> index 635ff20cc431..c677ad5df8d6 100644
> > >> --- a/arch/x86/kvm/svm/nested.c
> > >> +++ b/arch/x86/kvm/svm/nested.c
> > >> @@ -87,6 +87,54 @@ static void nested_svm_clear_synthesized_insn_byt=
es(struct vcpu_svm *svm)
> > >>          svm->nested.synthesized_insn_bytes.insn_len =3D 0;
> > >>   }
> > >>
> > >> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *by=
tes,
> > >> +                                     u8 count, u8 max_bytes)
> > >> +{
> > >> +       struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
> > >> +       u64 access =3D PFERR_FETCH_MASK;
> > >> +       gva_t rip =3D kvm_get_linear_rip(vcpu);
> > >> +       struct x86_exception e;
> > >> +
> > >> +       if (kvm_x86_call(get_cpl)(vcpu) =3D=3D 3)
> > >> +               access |=3D PFERR_USER_MASK;
> > >> +
> > >> +       if (!is_64_bit_mode(vcpu)) {
> > >> +               u32 eip =3D kvm_rip_read(vcpu);
> > >> +               u32 limit =3D to_svm(vcpu)->vmcb->save.cs.limit;
> > >> +
> > >> +               if (eip > limit)
> > >> +                       return 0;
> > >> +               max_bytes =3D min_t(u64, max_bytes, (u64)limit - eip=
 + 1);
> > >> +       }
> > >> +
> > >> +       count =3D min(count, max_bytes);
> > >
> > > Ugh. Pasting together two partial reads performed at different times
> > > is egregious.

I don't love it either, but IMO (obviously) it's better than potentially re=
porting
completely different bytes than what KVM emulated, especially when KVM emul=
ated
using the buffer provided by the CPU.

And practically speaking, KVM will always be splicing together two partial =
reads
when the instruction splits a page boundary, which is the most common case =
where
KVM will even need to read more bytes at this phase.

> > > This function should read all 15 bytes in one go. That
> > > pretty much renders the emulator's fetch cache useless, except when i=
t
> > > contains the necessary 15 bytes.
> >
> > This patch was based on the discussion from the first version of this
> > series[1].  My understanding from that exchange was that preserving the
> > bytes used by the emulator and fetching the missing tail later was the
> > intended approach, as it retains the bytes actually used to decode the
> > instruction.
> >
> > Did I misunderstand the conclusion of that discussion?  If the
> > preference is now to avoid combining reads performed at different times=
,
> > I can change the next version to use the emulator fetch cache only when
> > it contains the full 15-byte window, and otherwise fetch all 15 bytes i=
n
> > one operation.
> >
> > [1]
> > https://lore.kernel.org/kvm/20260629125205.52394-1-zhang_wei@open-hieco=
.net/T/#m3fa3f64ddd3284b312d3ddb44fd30a2e26708037
>=20
> I still don't like it, but Sean overruled me, so I will be quiet now. :)

You can always appeal to Paolo.  I'm one of the District Courts, Paolo is t=
he
Court of Appeals, and Linus is the Supreme Court.  :-D
