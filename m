Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E80448B90
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912622; cv=none; b=AACQ3yN3rPYy4558mPW0Ptym/09ZrTNXM9BhGS0gJGsrIujLnOGzx/Zv7oplPuJVrKRPHKDfGwmDwqmtubs8++0DesO9Or5209yEYG2WMhRkBh7+WHzy+O7BZvQcvm8WcoJmfjXQ2/QdYEd89rECmJro1t2ezN+KAsLPWPgPfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912622; c=relaxed/simple;
	bh=uThP5DN8hBmDk9ozrDz1/noMwlLLWMeuDiEN3R+XDw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZN9JUXfAgN+Ix2vmLjV5QmZ5IQCevYeJg60/PwvCj5yQPlNe2I4KlrfzVEWIzfwW5Qi1fIV/L/OxDOqLnwo0fMWMJihoOvvk3c+LBgf7aEKbLJStv1dIMkSyGLnxLA6KVsqoFN8qFdeI9NoyoHKlilm+PuRd6+Wpymxejl64YE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIMHVc/7; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIMHVc/7"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so7062365ad.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784912619; x=1785517419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=36mf1aNlc4+1LO0bFWV2L2nSgnD9FrklptP7m3OCGq0=;
        b=vIMHVc/7OSf6gbzceeLtl2H586Quv9nFaF9Yr84nIGORBNDDmdNFOR7mRPd9b2x04C
         BtLA1bQLSmR2jTO17EhpvXcsa2ppxSiTaoJjoBgvtEbT+Q551S+jIxUD2LovvxNvfCDM
         nYpT+2Gt/HhAk/sLl+ZGtmYw9hEupKCP81aeW/umn210cgaer7B7USrAyMVCAXrKIm86
         Q8N/HL2oL23lK2MriY0Oezjw9kketyBvKyNmdihSty+L29x4V/EvQNrjVMkwl6i7xuIT
         B06cwuHGKccs5w+FBOfkwR7QtaK4YLQTp5+V17RPR755467pmlgWbao4C2ouunRQysI+
         PvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784912619; x=1785517419;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36mf1aNlc4+1LO0bFWV2L2nSgnD9FrklptP7m3OCGq0=;
        b=MYxbwjMlqKBPeDCOWz5nS5rCkMna+Nq3VO8Cp4JndzF1iL4NXjdycHyElFI/e5m880
         dUeeHZStxwFNzIbhhgX9CJUMIfB3+op6LEr0RUkQ1AYPVe3nOOlzlnAmTWavTxHHcn4R
         snznYzRJ4tPa9nnRYas/XdkXz4DFBczFuHkR1LJiZLNuLQUZGCfofjQwqVXLUSiIKhQt
         k1UukI02+xS5WiF9y4OshEOqTqZk5LSUZInDPbN9Zuv0qoJKET+u8Ta4TjvnFoYxAyov
         btMEbie4bAUNcvdAvgyxVmd1/3UPQ5c1qygL3JMe7EZxcmv6RoXQEPMUUOd/N3lcpPgr
         mi4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrnl3W63pc5LPj4WoIZcS62GTQuAWWKqc1ADGv/cCS2F0mhnSrTrWxIN2QKAdlscdBDFdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3Aoop1W1LRRzKMKHetRyORRZhZVbaVxjVWlgr0TvWLoPeU80
	81zsOMzwV7+T31glYAn7fLbx6U+mV86PykEu1Gt+0FPY0iNspCCKprlAB4mJKL3lWg/ALUfjuxe
	NFqd1Xg==
X-Received: from plai17.prod.google.com ([2002:a17:902:c951:b0:2c7:f19d:bb15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c0c:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2cfa6a55841mr95408635ad.10.1784912619137; Fri, 24
 Jul 2026 10:03:39 -0700 (PDT)
Date: Fri, 24 Jul 2026 10:03:38 -0700
In-Reply-To: <CAO9r8zMZmGEmkwu7ixZE+5izZEwsAdoq3fiypiDO0fHowp7_1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-4-yosry@kernel.org>
 <amOF2p2tTjOXcRS_@google.com> <CAO9r8zMZmGEmkwu7ixZE+5izZEwsAdoq3fiypiDO0fHowp7_1g@mail.gmail.com>
Message-ID: <amOa6qCKvyFWc6z4@google.com>
Subject: Re: [PATCH v3 03/10] KVM: selftests: Use an array for guest_regs (and
 fix offsets)
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> On Fri, Jul 24, 2026 at 8:33=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> Oh I wanted to, but the compiler wouldn't let me use enum values
> directly in the preprocessor, see:
> https://lore.kernel.org/kvm/CAO9r8zPz8WbijVN6mgLb8OaU6=3DtNSSz1NgNBjZCsC3=
6D4+TO+w@mail.gmail.com/.
>=20
> I can do an enum *and* macros using enum values if you prefer so, like:
>=20
> #define __GUEST_REGS_RAX 0
> ...
>=20
> enum guest_regs {
>     GUEST_REGS_RAX =3D __GUEST_REGS_RAX,
>     ...
>     NR_GUEST_REGS,
> };

I would much rather follow KUT's lib/x86/virt.h, and provide asm constraint=
s for
the offsets.  Actually, my vote is to copy+paste KUT's entire approach, and=
 provide:

  struct guest_regs {
	u64 rax;
	u64 rcx;
	u64 rdx;
	u64 rbx;
	/*
	 * Use RSP's index to hold CR2, as RSP isn't manually context switched
	 * by software in any relevant flows.
	 *
	 * FIXME: Actually context switch CR2 on Intel.
	 */
	u64 cr2;
	u64 rbp;
	u64 rsi;
	u64 rdi;
	u64 r8;
	u64 r9;
	u64 r10;
	u64 r11;
	u64 r12;
	u64 r13;
	u64 r14;
	u64 r15;
	u64 rflags;
  };

Using an array for the GPRs is only valuable when the code *needs* to index=
 the
GPRs based on their index, e.g. like KVM needs to do when emulating instruc=
tions.
But for "normal" software, using an array just makes the code kludgy.

E.g. this

	vmcb->save.rip =3D (u64)guest_rip;
	vmcb->save.rsp =3D (u64)svm->stack;
	guest_regs.rdi =3D (u64)svm;

versus

	vmcb->save.rip =3D (u64)guest_rip;
	vmcb->save.rsp =3D (u64)svm->stack;
	guest_regs[X86_REGS_RDI] =3D (u64)svm;
