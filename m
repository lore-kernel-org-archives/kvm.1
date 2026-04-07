Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510D3B38A8
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565704; cv=none; b=FKBM5LUeijGpgrnFmqvZtKynKjz8FSbjR0W5KW+YppFYNZB71yNwdSb5IAU6BcZRsdipFGOnfHy7B/1LFGqtTPLOFauUoA4oJw5ri/dear1bUzREImVM1eaeWxTaTF97gjv5XSArPDhr17ny3IOGYWM1WvadHu2Ofr0PoQvxdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565704; c=relaxed/simple;
	bh=h+Q+4GDMZ0Hnfe+YIBStnMoQmrnrXoWxr2IqRHz2y98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxA5VySEFqzuJNF2KYKn+uhhtp3pb3oxKrWusBoj1u1vBRPNjiAN+LkZhxqoCrviHEVOt7x8hLbLnsMteAyS398Bt0o3kz+M30PVXuSde+B5XeRHhJV5BbAn92kyY0T+e6VaQexxgJ8FYY/YMt0MHBC43zE235V21QMF0h++mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE1Q7GD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE1Q7GD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1090DC116C6
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775565704;
	bh=h+Q+4GDMZ0Hnfe+YIBStnMoQmrnrXoWxr2IqRHz2y98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mE1Q7GD4xGJey5SQiMcJ6aaFcJiur97WGv9vGxDyWbbOdWuGGoMH0t2aITY+TnMI+
	 rkT20C5tMQmhnpd3chyN2aTtQtOoKZl7glFQ77+WDFkBPqZus5Y4eK7frrZDt7yAv/
	 hedsFrtInnvj3fu9Yce8Rzk5IddwdFXp8QOfpmLLk10xVruzZqHf94KoEzqi1xjyIf
	 QIwZD7oxN//yF2QWpbsveLBbI56h7roboPPBXz8ytQOkC4meY++pFtHAIWEW7HvdQF
	 LoDQUyJdF2raV6AwGRZ/fB2/t3dvb5GT++AywPNApM74wGh5tZp4Q5qzLviE2zg88S
	 qj5mmfnh/g62Q==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66f3093a9c7so1978418a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 05:41:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjdnNu8BnGyedaR2W/cBmVMPX/nXSq8DfR51scEecfPF/sB623xdJfYsd69A74F1ZoG0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylC2Tba48CYzoUHlZ66aZFLYBfu9KEGnATw2S2pZjoVcqPJ5DU
	Xkmk5/pd6vJUrGWBFH6wbQsH52LP+y86Opx6ds6u2vxTBrJE/dp+T/KP9sKyJu2ff2OLHpbLAuB
	m8Aptvvn1r5MgYJUhPhJQ0+mXYbO/CCg=
X-Received: by 2002:a17:906:2092:b0:b9c:578c:50a8 with SMTP id
 a640c23a62f3a-b9c67b51d8bmr454940766b.51.1775565702525; Tue, 07 Apr 2026
 05:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035832.2204720-1-maobibo@loongson.cn> <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
In-Reply-To: <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 7 Apr 2026 20:41:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
X-Gm-Features: AQROBzCBBI_saF5lD1_UiUpPEskuaOdGRbMYtW9Y6QETl82j9p9eWRoziBEvZHw
Message-ID: <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 6:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Bibo,
>
>
> On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >
> > With FPU save and restore flow, the cost is the same with different
> > FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impacti=
on.
> >
> > Here is to enable FPU with max VM supported type, for example if
> > VM supports LASX instrction, enable FPU with LASX type even with FPU
> > exeception. So it can avoid possible LSX/LASX exception in future.
> >
> > With context switch microbench which may touch FPU and LASX, there is 9=
%
> > improvement when halt_poll_ns is disabled. The command is
> > "./context --test=3Dpipe" and source code located at:
> >   https://github.com/bibo-mao/context_switch/blob/main/context.c
> >
> > Original     Wih patch      improvement
> > 75232        82440          9%
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> > v1 ... v2:
> >   1. Enable FPU with max VM supported FPU type, rather than max used ty=
pe.
> >   2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
> >   3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >   3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
> >   4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx=
(),
> >      directly enable LSX or LASX from FPU none state.
> > ---
> > Bibo Mao (6):
> >   LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
> >   LoongArch: KVM: Enable FPU with max VM supported FPU type
> >   LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
> so I think Patch-3 should be squashed into Patch-1.
>
> >   LoongArch: KVM: Remove some middle FPU states
> >   LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
> >   LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX and
> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, so
> I think Patch-6 should be squashed into Patch-5, too.
And could you please test the power consumption where there are many
VMs that only use FPU rather than LSX/LASX? As far as I know, the
power consumption of LASX is significantly more than FPU, which is a
little similar to AVX512 (Linus said it is a power virus).

Huacai

>
>
> Huacai
>
> >
> >  arch/loongarch/include/asm/kvm_host.h |  6 +--
> >  arch/loongarch/kvm/exit.c             | 21 +++-----
> >  arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
> >  3 files changed, 30 insertions(+), 75 deletions(-)
> >
> >
> > base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> > --
> > 2.39.3
> >
> >
