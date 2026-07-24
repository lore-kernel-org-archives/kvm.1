Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6F31A053
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915087; cv=none; b=lttQ+r5LGddfuyJw5hUdPBIjNZFdzLke7E4LyT+8kk96sWkHL5z5TGM8k2JlRQqzPX0yq5AK0HhgXa01jmYK7kOxUzHanaUQQV4O0CHMyfQdryBpgC0sJlNQzmbT0B9S7HPA6mwhatBL2Eo/2oeugdamg0mxXBi9LNmHFq8Nbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915087; c=relaxed/simple;
	bh=z1oNcUsRlOFGA18rjMXpU5GE9yBMejjGSh1aa08IXhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv6FF4rHmHuG+5o51Ea7g4qAbZP+AOxMJKzn24px3dl7BYlcroUJXhyWAZ9Fw182isJiZNY/CuUEFeE87N2uib8szmN+ZkcjOFuk11Fx8QvxkrYNoU08KbndABpLJCIDkAajVHFp8kAlHbqCMIAobjYttsp8hIdHufHEUUwmJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGxnnmCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGxnnmCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FE81F000E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784915085;
	bh=MEwQXqYLWAe2bg98nMvsfb0h1a1fv3TEfTemC2WxCSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GGxnnmCOIz18CkQDKv6HNnBzpPlkg9/ohD5oILskiGS+2cYv0iM7ELav71Ra10U7l
	 lTXlpj83knzEPT9Pz4WlQBFX1WJHCk4WERYKoaksUJE3txnT9KqPOqyemHCriLMVRz
	 6LKz61F4JJKbffyBGVt74YGG4tAjsqbMlMFOeu+/9b1yUx1iREgNGZ02EI81I9HUT0
	 6krBaJ6OuRVH0BACBG1cCY7PeERAs/GhIF5lL3aD0vASS+nG2mDG+8TaS5YQhR45TT
	 Xw8M6zqMBwyC0IuScfBz0CxHYU4WxFJP9lIn7aILFK5ZP8qkGsye62o3O8fF+v9Vf7
	 khot2ZMSGYbVw==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efef6533aaso6299976d6.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrDUnRe2pahYBJpSGTyY2Xx4UEVm8UpWV0hLiSu5gyXYxPZQl2CntmhdsmLKlsnLcjE0DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5a0zy4CXLSdFfhJjj4Dspj9Twzy/wsRMsg4iolipqbSiawCP
	eWvVXMMHjXQuWKpdxE367/BingppiAHmsTueN6s4z5NaHkE3MOcoZJDCtLq64dmUF7wqpPyFVAu
	gyAkuQRD4tefHZ3Qfgp683gUKw0RYWk8=
X-Received: by 2002:a05:6214:4016:b0:8eb:24e8:8d28 with SMTP id
 6a1803df08f44-907ca59e44amr93351776d6.46.1784915085151; Fri, 24 Jul 2026
 10:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-4-yosry@kernel.org>
 <amOF2p2tTjOXcRS_@google.com> <CAO9r8zMZmGEmkwu7ixZE+5izZEwsAdoq3fiypiDO0fHowp7_1g@mail.gmail.com>
 <amOa6qCKvyFWc6z4@google.com>
In-Reply-To: <amOa6qCKvyFWc6z4@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 10:44:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPMAgCjCfGuVCdT3rG7bStL3PxRoaEW_Qr-Du8EArPjTQ@mail.gmail.com>
X-Gm-Features: AUfX_myFW1bMp6y48jWNF0ymnXyK_o4GvpVO_cQW1tSd8eiKwkprXh7bT9Dmemk
Message-ID: <CAO9r8zPMAgCjCfGuVCdT3rG7bStL3PxRoaEW_Qr-Du8EArPjTQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] KVM: selftests: Use an array for guest_regs (and
 fix offsets)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:03=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > On Fri, Jul 24, 2026 at 8:33=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > Oh I wanted to, but the compiler wouldn't let me use enum values
> > directly in the preprocessor, see:
> > https://lore.kernel.org/kvm/CAO9r8zPz8WbijVN6mgLb8OaU6=3DtNSSz1NgNBjZCs=
C36D4+TO+w@mail.gmail.com/.
> >
> > I can do an enum *and* macros using enum values if you prefer so, like:
> >
> > #define __GUEST_REGS_RAX 0
> > ...
> >
> > enum guest_regs {
> >     GUEST_REGS_RAX =3D __GUEST_REGS_RAX,
> >     ...
> >     NR_GUEST_REGS,
> > };
>
> I would much rather follow KUT's lib/x86/virt.h, and provide asm constrai=
nts for
> the offsets.

I actually did this initially (without knowing it's what KUT does), I
did not like the asm constraint, and I think I may have run into a
limit on the number of operands. But yeah if we are already doing this
for KUT let me try it again and see if I can make it work.

> Actually, my vote is to copy+paste KUT's entire approach, and provide:
>
>   struct guest_regs {
>         u64 rax;
>         u64 rcx;
>         u64 rdx;
>         u64 rbx;
>         /*
>          * Use RSP's index to hold CR2, as RSP isn't manually context swi=
tched
>          * by software in any relevant flows.
>          *
>          * FIXME: Actually context switch CR2 on Intel.
>          */
>         u64 cr2;
>         u64 rbp;
>         u64 rsi;
>         u64 rdi;
>         u64 r8;
>         u64 r9;
>         u64 r10;
>         u64 r11;
>         u64 r12;
>         u64 r13;
>         u64 r14;
>         u64 r15;
>         u64 rflags;
>   };
>
> Using an array for the GPRs is only valuable when the code *needs* to ind=
ex the
> GPRs based on their index, e.g. like KVM needs to do when emulating instr=
uctions.
> But for "normal" software, using an array just makes the code kludgy.
>
> E.g. this
>
>         vmcb->save.rip =3D (u64)guest_rip;
>         vmcb->save.rsp =3D (u64)svm->stack;
>         guest_regs.rdi =3D (u64)svm;
>
> versus
>
>         vmcb->save.rip =3D (u64)guest_rip;
>         vmcb->save.rsp =3D (u64)svm->stack;
>         guest_regs[X86_REGS_RDI] =3D (u64)svm;
