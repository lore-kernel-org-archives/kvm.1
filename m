Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B22D9ECD
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375112; cv=none; b=HpTTDGt3xI3Vwrdd+eo3oOApo6JsoD9SwTkX5WY1AE0C2B92HL2AeYzOoh/sizFHUYOg9vvsq0q8y47+5a3usopp8AbtW3SIRYjrb4vBKDbSf4bFaUegjakVYS3wBI3lkyUPOkkCFIDdBDRrLsYBTqDH5nwGWehcyRaDLbOfamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375112; c=relaxed/simple;
	bh=JuhFkdCGHUTa1Toq2fl6YGpvDgg8h25DT7dj2dhCEh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTmnYThPwMQq15Vn3SkkoKCeuMAWxMRm+07Uu2+0+ysw0TxaTAarTw8YFok3Y375u7pGmjmuHeW6CWPVApGwRcYrP8fd0Uw8BstTzCIWG9aq7Neqa0Gj5yJaICe80V+cvuzQ4peXoGmUuhSHl3rUvIWWUefyETJG501gRF6FhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMGpFS0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMGpFS0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A91F0089A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 04:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375110;
	bh=gOWcSTxZdBm2fK8HY+nHIvk9NOaM4hUS3N1iZTG+OeA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bMGpFS0w9MrQGe8YZaVhkeJ1yZDTQbaruewkQrglnDDH5B0oKJzJcUJtLxM2BMAqs
	 BSRhNBKQuVilD9VhspLgUVr42e5uiHK38hJRF4kjUzh+fuNUky9nEwEntijVM2PIgR
	 yVe8WxG9A2BEs+jyy+YtETUhIUjnXjTaEJv8ejKIfINBQ9S3sxBklsT9W+3dp5m4wR
	 wYlset3xeNoMoNiN3OBpoxoBChKMAkAnd4p+QA9lZQDO7AUuno9mO1vY8CaqKMvUTI
	 t3oCaOvx6e0WbI6NzteLT7Xo8rT3b/ffMZ7BuGsPKU6KX9/fZ3IqKk9Yl5AKCBkrnv
	 LFulJJC8HYxEA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso525063566b.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 21:38:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8rV++SJOwke01oKZ0OgQ7I/0c7GYeKpiWvm9E1HepaYGAzbJg9tb32rVowtmylFc1cSrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bU+CG/R0eFFWMrpEq8iS1WOHn7FXONIHEbZzqoYrR6qxnUhm
	6Z8jQp/rwxH9gIyaIlHlFDJRc5G1qCMpAorMk0+Of2PyWn3CplRY9JNnNJAUXed1rCf41yPNqa/
	EfxEbm3xKWNSMNm2E1ZXaM/sBX3keHYc=
X-Received: by 2002:a17:907:d9e:b0:bce:80db:77ef with SMTP id
 a640c23a62f3a-beab3852a00mr805054066b.43.1780375108969; Mon, 01 Jun 2026
 21:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035832.2204720-1-maobibo@loongson.cn> <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
 <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn> <CAAhV-H4+A0bs07v4B8BTCqbNsG5SLSjjx8sh5Lz23i+R37RAKw@mail.gmail.com>
 <74e8fa9e-90f6-175e-fb98-2e4504d5f15d@loongson.cn> <CAAhV-H7WnvO80sQoQLpgnomobkB7Zu5F4rgXxsj5ErymukQ+9A@mail.gmail.com>
 <b1b07f90-3db3-c3ff-2297-f8eaaa3f6faa@loongson.cn>
In-Reply-To: <b1b07f90-3db3-c3ff-2297-f8eaaa3f6faa@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Jun 2026 12:38:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+Jk_MoDyVVe5mG8LQMoeJXnK9j4B4Si9NmA--GF1tdg@mail.gmail.com>
X-Gm-Features: AVHnY4LrAAW6MCGH2E-nR1_cx1nVZNn4lUsBJYDaAjRKpC9OXk_AgNi0TAUTz_o
Message-ID: <CAAhV-H7+Jk_MoDyVVe5mG8LQMoeJXnK9j4B4Si9NmA--GF1tdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:23=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/6/1 =E4=B8=8B=E5=8D=889:52, Huacai Chen wrote:
> > On Thu, Apr 9, 2026 at 8:14=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/4/8 =E4=B8=8B=E5=8D=883:47, Huacai Chen wrote:
> >>> On Wed, Apr 8, 2026 at 9:04=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/4/7 =E4=B8=8B=E5=8D=888:41, Huacai Chen wrote:
> >>>>> On Mon, Mar 30, 2026 at 6:00=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> >>>>>>
> >>>>>> Hi, Bibo,
> >>>>>>
> >>>>>>
> >>>>>> On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongso=
n.cn> wrote:
> >>>>>>>
> >>>>>>> With FPU save and restore flow, the cost is the same with differe=
nt
> >>>>>>> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line i=
mpaction.
> >>>>>>>
> >>>>>>> Here is to enable FPU with max VM supported type, for example if
> >>>>>>> VM supports LASX instrction, enable FPU with LASX type even with =
FPU
> >>>>>>> exeception. So it can avoid possible LSX/LASX exception in future=
.
> >>>>>>>
> >>>>>>> With context switch microbench which may touch FPU and LASX, ther=
e is 9%
> >>>>>>> improvement when halt_poll_ns is disabled. The command is
> >>>>>>> "./context --test=3Dpipe" and source code located at:
> >>>>>>>      https://github.com/bibo-mao/context_switch/blob/main/context=
.c
> >>>>>>>
> >>>>>>> Original     Wih patch      improvement
> >>>>>>> 75232        82440          9%
> >>>>>>>
> >>>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>>> ---
> >>>>>>> v1 ... v2:
> >>>>>>>      1. Enable FPU with max VM supported FPU type, rather than ma=
x used type.
> >>>>>>>      2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
> >>>>>>>      3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >>>>>>>      3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
> >>>>>>>      4. Remove middle FPU state handling in kvm_own_lsx() and kvm=
_own_lasx(),
> >>>>>>>         directly enable LSX or LASX from FPU none state.
> >>>>>>> ---
> >>>>>>> Bibo Mao (6):
> >>>>>>>      LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
> >>>>>>>      LoongArch: KVM: Enable FPU with max VM supported FPU type
> >>>>>>>      LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOA=
D
> >>>>>> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FP=
U,
> >>>>>> so I think Patch-3 should be squashed into Patch-1.
> >>>>>>
> >>>>>>>      LoongArch: KVM: Remove some middle FPU states
> >>>>>>>      LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
> >>>>>>>      LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
> >>>>>> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX=
 and
> >>>>>> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX=
, so
> >>>>>> I think Patch-6 should be squashed into Patch-5, too.
> >>>>> And could you please test the power consumption where there are man=
y
> >>>>> VMs that only use FPU rather than LSX/LASX? As far as I know, the
> >>>> Hi Huacai,
> >>>>
> >>>> Thanks for reviewing this patch
> >>>> Could you help me to test the power consumption with this patch?
> >>>>> power consumption of LASX is significantly more than FPU, which is =
a
> >>>> Could the describe the detail scenery wheree LASX instruction is
> >>>> frequently used by application or LASX  EUEN enabled?
> >>> The purpose is to evaluate power consumption before and after this se=
ries.
> >>>
> >>> So we can run 10 VMs (suppose there are 4 cores), and there is a
> >>> workload run in every VM, the workload only uses FPU, no LSX and LASX=
.
> >>> Before this series, KVM only save/restore FPU context; after this
> >>> series, KVM will save/restore LASX context.
> >> In theory there should be such test, only that it requires special Pow=
er
> >> Management team and testbed. Even if there is such team, maybe they ca=
re
> >> power consumption about DDR and screen, do not want do such experiment=
s
> >> for this patch.
> >>
> >> If someone is volunteer to do this, I do not object, also I want to ge=
t
> >> the result. Just from my guess, there should be no much difference sin=
ce
> >> FPU context switch is much smaller than the whole workload, else the
> >> workload is just FPU context switch.
> > Any updates?
> It deeps on Power Management exports.
>
> By cyclictest/fpubench test on 3C6000, the context switch cost is 3us,
> the fpu save cost is 7.6ns and 7.8ns with fpu restore. FPU switch cost
> is about 0.25% of the whole context switch. I do not why power
> consumption is important factor here.
I'm talking about this:
https://lore.kernel.org/loongarch/b1b07f90-3db3-c3ff-2297-f8eaaa3f6faa@loon=
gson.cn/T/#m6da21ae2f4abfba362a2cd189cb4d8d09e33a6d7

Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >>
> >> Regards
> >> Bibo Mao
> >>
> >>>
> >>> If the power consumptions are similar, then this series is perfect.
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>> little similar to AVX512 (Linus said it is a power virus).
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>> Huacai
> >>>>>>
> >>>>>>>
> >>>>>>>     arch/loongarch/include/asm/kvm_host.h |  6 +--
> >>>>>>>     arch/loongarch/kvm/exit.c             | 21 +++-----
> >>>>>>>     arch/loongarch/kvm/vcpu.c             | 78 ++++++++----------=
---------
> >>>>>>>     3 files changed, 30 insertions(+), 75 deletions(-)
> >>>>>>>
> >>>>>>>
> >>>>>>> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> >>>>>>> --
> >>>>>>> 2.39.3
> >>>>>>>
> >>>>>>>
> >>>>
> >>>>
> >>
> >>
>
