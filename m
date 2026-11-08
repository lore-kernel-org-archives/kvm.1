Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794114351;
	b=KQvvChvdV9bZRqnTMcxZHeXsizhJurglRDhxFaafYaSWj/kYN82R+h3QssqsoXCcYNxx
	 RSZZMCLJvmW50xmuRIV+MSZ4Cd5OxrImyPYk7mlhP1+I1oM75FlI+4GU4fchIABUwgtpt
	 +b4d8nsvM+F/dzpxdyh1EITQQcOm241+5l5ujG5SlVNdAB0feWE56g8iC8n82zr551wHD
	 VhC2RBFne+UHTSUW8Z7S9sfgG4YEbwp1hTvTzJh4r2o/RAo/ZWW5bmXEnYawSeSVNaGGW
	 zhXRw6wwqUrnKM/AMdEevrY3nU+donD3mPZ3SjwRXldNBne5FhfoSv+VkX8RDMOPAiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794114351;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DMAnc9Xs3KUNlFWK24lYx3EB87h8Uvn2c/RHBGCf0T0=;
	b=O3eT1DMPjBXDJ2teGdyvI8EicJXlJkYhxz5r1vizWJafKKm2blDCTIFqSkD96AScmfO9
	 y4/aP8tMzGszG8JxmGK0YVHoXKAkEeufDMIk812Kg1VtbJeZvvsNl1xrPCjotBbXUV+k7
	 CyjLALE3rshFoPQoIQA1bPjAvrB9fApL7o4KpKewtnifPbHezGaFRnzDlA2lAXq+y1cwn
	 1cV+lMUQp5vFPh6CiRYlofzKPTv1uKoT/FNJScMyJ4lKg/lzzTXtjYD4bYmTcV25fD9Db
	 +E3HVaq+dQk6Bel9uES1Cx56zWt1IdJMDwkF/hFFfKEm361qDk21ftjgaflJUoelsdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vum+POLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB25606A31C
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vum+POLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FD31F008A2
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 05:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794114350;
	bh=DMAnc9Xs3KUNlFWK24lYx3EB87h8Uvn2c/RHBGCf0T0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vum+POLLdPenwWmmEFX+OR/z0AOexlfFNKekeJXHE3QB8MvTvXKgbiEexpO+DAqGR
	 rKO2ptDcp4QW3+4DDvXRUC9ZBLeAVVLjTlm6zgvMsxAl2Cf/HNsL+O26s5qR+uPHvE
	 0jwVARfEzJp7jsOn/YvLgLxGruZSZ+b29o9dy3GhCj6wCA9zC5BeM/PlQ0215I4jT5
	 +97JQELF0tywlw51Mj2MaE3S88XX1KHIAQi5NIVwFjWXCSS+IoPaSV2Y6vxMhJ9tvM
	 2+8r6+BP+REW1lxNVbHrNLhV+lR27VCG4kWWX+dyMDQg+4hqV96tUcFeJUK9L0ie1P
	 HjzPmBLtzChRg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so190633a12.1
        for <kvm@vger.kernel.org>; Sat, 07 Nov 2026 21:05:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzPh9x2uZygu28Be9M141FSpzYptvZWrZ18zhi1NYxqjk0C1PozwBGh7EA7nvujlzaJWt8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9q6UXIFsmNmi2pJhVRSLpuV+JPXf59LrVGGuDHuz7DMd5Vg61s
	fS3I3gKwWnzcz/iXy/E7EtaWUmHFU54C+tBWvP+msPOuvm1pYOrCTZXS5ZUkJNq5wlDrl7Nsrhn
	gZMHqImZVJaVseRS6H70+jZYyhgMmidU=
X-Received: by 2002:a17:906:d550:b0:c4c:e344:ecec with SMTP id
 a640c23a62f3a-c4d6d15a575mr44829966b.6.1794114349578; Sat, 07 Nov 2026
 21:05:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016095151.1155049-1-cui.tao@linux.dev>
In-Reply-To: <20261016095151.1155049-1-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 8 Nov 2026 13:05:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZU1KaagDfObCZFYDTowG5EYf3QpdUebdpBdtozzF00g@mail.gmail.com>
X-Gm-Features: AclHuK_a2jTQjAVHTLhyRW9kDvdj1qOm6NVMjMG_Ua0PORpvn7SJ5WZ1nS5nXwA
Message-ID: <CAAhV-H4ZU1KaagDfObCZFYDTowG5EYf3QpdUebdpBdtozzF00g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] LoongArch: KVM: irqchip fixes
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Series applied, thanks.

Huacai

On Fri, Oct 16, 2026 at 5:52=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> Hi,
>
> Three fixes for the LoongArch KVM irqchip code:
>
> - Patch 1 clears the device pointer in the destroy callbacks: when
>   KVM_CREATE_DEVICE succeeds but the following fd allocation fails
>   (e.g. under RLIMIT_NOFILE), ops->destroy() frees the irqchip while
>   kvm->arch.* still points to it.
>
> - Patch 2 aligns kvm_pch_pic_create() with kvm_eiointc_create() by
>   propagating the real error code; the kvm_ipi_create() counterpart is
>   being fixed separately (Chaithanya Lagisetty).
>
> - Patch 3 rejects repeated PCH-PIC CTRL_INIT with -EEXIST, using the
>   initialized state of the kvm_io_device as the indicator.  The check,
>   the MMIO base update and the bus registration are serialized by
>   slots_lock; on a registration failure the state is rolled back so
>   that a retry can start over.
>
> All patches carry Fixes tags.
>
> Changes in v5:
>
> - Patch 3: roll back the base and the device state on registration
>   failure, as suggested by Bibo.
>
> Changes in v4:
>
> - Patch 3: update pch_pic_base unconditionally, as suggested by
>   Huacai.
>
> Changes in v3:
>
> - Drop "Load dmsintc pointer once in pch_msi_set_irq" (v2 patch 2),
>   suggested by Bibo and Huacai.
>
> - Patch 3 (v2 patch 4): reject repeated CTRL_INIT by checking the
>   kvm_io_device state instead of a separate has_init flag, also
>   suggested by Huacai; the check stays under slots_lock.
>
> Changes in v2:
>
> - Drop "Guard against NULL irqchip in irq injection" (v1 patch 2) and
>   "Rebase steal time counter in vcpu context" (v1 patch 4) after
>   review discussion: their trigger scenarios are not reachable
>   through real VMM behaviour.
>
> - Use the one-line destroy style in dmsintc suggested by Bibo.
>
> - Track repeated PCH-PIC CTRL_INIT with a has_init flag and return
>   -EEXIST instead of -EBUSY, also suggested by Bibo; move the check
>   and base update under slots_lock so they are atomic.
>
> - Add READ_ONCE() to the dmsintc pointer loads so the compiler
>   keeps each of them a single load.
>
> Tao Cui (3):
>   LoongArch: KVM: Clear device pointer in irqchip destroy callbacks
>   LoongArch: KVM: Propagate real error code in kvm_pch_pic_create
>   LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
>
>  arch/loongarch/kvm/intc/dmsintc.c |  1 +
>  arch/loongarch/kvm/intc/eiointc.c |  1 +
>  arch/loongarch/kvm/intc/ipi.c     |  1 +
>  arch/loongarch/kvm/intc/pch_pic.c | 19 +++++++++++++++----
>  4 files changed, 18 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>
