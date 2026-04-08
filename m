Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39863947A5
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634446; cv=none; b=lDNLEJTyM7fUSpQaLRUQhzPe1tM6jrtnrHmPUR2cxU5R8OIjIWpNBXhXphOvUbKFqx5LofITtf5YvY2psO1jT5gKuVZAaYnCn2lpuENE9nHBMoP44IdJgyrAQ5b2gariWXJbga6/aQQlQLZspz49IXu7B6ASylaCo3PEdIo/FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634446; c=relaxed/simple;
	bh=f1aGC2+c5jz12rmqttFu31vbeJclnJIJ3Fw26Vwh6Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJN8qz5sIxorNCeWuVE8OiOCrUzPCF0PfUD1WoePQmqUKafHRsGKXEB/6m7Qxjyfv50qyBfoRZjrCXRn5eBfnmaUNuS175VY2SLxkOfGEgd8V7mj967oLtdg42CgXHCsHSQtjF3rYBCFJqTEQgM1Qtu/RsbTpHjxFldGdRHRiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMEpzw/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMEpzw/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ED8C2BCAF
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775634446;
	bh=f1aGC2+c5jz12rmqttFu31vbeJclnJIJ3Fw26Vwh6Lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iMEpzw/+ZB+K3oWmTQjLRU3yNPtpj2PxCgVA6O7ccUnirVIePMoma94cUV3Ita8Ax
	 sW9yD40silRGQ300bJ7t6z6Bxb3sLQ0odcpiLBhshewNl+Bx5go/u9aR0dFXlDZQ0O
	 zsYQKfC2kjtVyFENnLuhWPcmEKHCQObxo2gQ/9ttXODU0TPj1KUEjIeh1/V44SCd5r
	 gcKA9RjAEgliYdmKE9h2QlsXxPbD8mr49ZSyaN0ECJXsFODrMD6LiI8rqGXtXgb5mS
	 CDhGgiHjoK7PToD/P24R9jT9OsDDLyp2ESoSvxAlN2PnQFczPu0AbkdWUeA2zv9VDR
	 fpg2jShy5SoXQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso6447089a12.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 00:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg1MhJOddDnVz37hA/8M0YX3tzbnwaxVByoQOQTYmW2v478Of3lHupo8TAMOk/Rac257s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m/Ukqk2rw19d6WN0iScsWByReFzUOOrx5rv/sZ15BWJVsSEK
	RLCEg7j0RAl5dYYEJKNG746taVDJ6/UacgvzXy7J09jrbPlShujJOpUciO9hKFeU8FwzVjBFqWq
	GgWxnJKAU1lvGzhWPKs9TVvDcZno8pI0=
X-Received: by 2002:a17:907:ea8:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c676881bemr1020033866b.18.1775634445108; Wed, 08 Apr 2026
 00:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035832.2204720-1-maobibo@loongson.cn> <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com> <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
In-Reply-To: <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 Apr 2026 15:47:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4+A0bs07v4B8BTCqbNsG5SLSjjx8sh5Lz23i+R37RAKw@mail.gmail.com>
X-Gm-Features: AQROBzA28K1m8zlIxxkJUyCejsYe9Z6_RBp9qxpvPmb7Ma_0xO7zqtxyHDgRyKg
Message-ID: <CAAhV-H4+A0bs07v4B8BTCqbNsG5SLSjjx8sh5Lz23i+R37RAKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 9:04=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/4/7 =E4=B8=8B=E5=8D=888:41, Huacai Chen wrote:
> > On Mon, Mar 30, 2026 at 6:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> >>
> >> Hi, Bibo,
> >>
> >>
> >> On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>
> >>> With FPU save and restore flow, the cost is the same with different
> >>> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impac=
tion.
> >>>
> >>> Here is to enable FPU with max VM supported type, for example if
> >>> VM supports LASX instrction, enable FPU with LASX type even with FPU
> >>> exeception. So it can avoid possible LSX/LASX exception in future.
> >>>
> >>> With context switch microbench which may touch FPU and LASX, there is=
 9%
> >>> improvement when halt_poll_ns is disabled. The command is
> >>> "./context --test=3Dpipe" and source code located at:
> >>>    https://github.com/bibo-mao/context_switch/blob/main/context.c
> >>>
> >>> Original     Wih patch      improvement
> >>> 75232        82440          9%
> >>>
> >>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>> ---
> >>> v1 ... v2:
> >>>    1. Enable FPU with max VM supported FPU type, rather than max used=
 type.
> >>>    2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
> >>>    3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >>>    3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
> >>>    4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_l=
asx(),
> >>>       directly enable LSX or LASX from FPU none state.
> >>> ---
> >>> Bibo Mao (6):
> >>>    LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
> >>>    LoongArch: KVM: Enable FPU with max VM supported FPU type
> >>>    LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
> >> so I think Patch-3 should be squashed into Patch-1.
> >>
> >>>    LoongArch: KVM: Remove some middle FPU states
> >>>    LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
> >>>    LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
> >> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX and
> >> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, so
> >> I think Patch-6 should be squashed into Patch-5, too.
> > And could you please test the power consumption where there are many
> > VMs that only use FPU rather than LSX/LASX? As far as I know, the
> Hi Huacai,
>
> Thanks for reviewing this patch
> Could you help me to test the power consumption with this patch?
> > power consumption of LASX is significantly more than FPU, which is a
> Could the describe the detail scenery wheree LASX instruction is
> frequently used by application or LASX  EUEN enabled?
The purpose is to evaluate power consumption before and after this series.

So we can run 10 VMs (suppose there are 4 cores), and there is a
workload run in every VM, the workload only uses FPU, no LSX and LASX.
Before this series, KVM only save/restore FPU context; after this
series, KVM will save/restore LASX context.

If the power consumptions are similar, then this series is perfect.

Huacai

>
> Regards
> Bibo Mao
> > little similar to AVX512 (Linus said it is a power virus).
> >
> > Huacai
> >
> >>
> >>
> >> Huacai
> >>
> >>>
> >>>   arch/loongarch/include/asm/kvm_host.h |  6 +--
> >>>   arch/loongarch/kvm/exit.c             | 21 +++-----
> >>>   arch/loongarch/kvm/vcpu.c             | 78 ++++++++----------------=
---
> >>>   3 files changed, 30 insertions(+), 75 deletions(-)
> >>>
> >>>
> >>> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> >>> --
> >>> 2.39.3
> >>>
> >>>
>
>
