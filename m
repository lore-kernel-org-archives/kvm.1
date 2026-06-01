Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA13AD531
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322009; cv=none; b=TLZEBJmqNkIHXprSSdzbBqCMRvNUHjN5fj5eg7JRMHLdkMM3+xMcW9BJkjITVG6QdbrKpm332zBTCQ8I5ZHFL5h0X+CsZv94aHD+kLSY+mPOZ/jb2tzg+MRjgs1btP6Bbs0UaWRlyBigCk4X8ddDzocoW8HULy7QbW0zZJQYPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322009; c=relaxed/simple;
	bh=qP8lKzZrsylXy05K6FjCDs2G6l+OQ1PcKYCx6rKU3Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4qQRaTI8/MAuib2KJeYKMHSnMBeg61I2RGOTrK9//fYKHe1VLHl4kSfzrif9BHUSj7r+nyGmLVREbJpXgbgqbO2Mq6t3DG0qoUgQU218POIiqolBAU6XwUcUxLPhQrLOQmncvj7VmeYfa5hD61QDJPvSOv1RePxbJ2BiquDPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH3QE8AL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH3QE8AL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF51F00899
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322008;
	bh=Xyq8NTa698xN/xj2FFcrxgT6n2ZyDlpM2h15b5ZLE4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OH3QE8ALoU6zCH4VNyNzyZwWl58aYBHkn8t5BjpHvETQtWSDGYNt81eNCf0mADHRQ
	 Z+JrgXpaChtnq2LEVOKgrMwozJvlhz+HvhiWZCPDSeozQjcxCHPBpQouetad9UDVL8
	 DMq40hYRrZdpc4V9Fp2i8A1pmzOqqrNIEY4bxSQ7jUKbL6pOFq0zeDVDI+d+ZzZpX/
	 JElaoGkBxpc59SOUeh+lUYNTXhRrXR4Hzg4iOQeyVQnxkEW8kmQw7YayaM71yWerbt
	 6CoPf4We0KEEg4xdervH8R5UO3c9K6BLHNAuKcRFKwQb6mlNDU0Abi2BydtFrTAGyj
	 wGN/j6Vqs+Vyw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bebb72b845aso248870466b.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 06:53:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8igsEw9D/Hzmxwq4zwW+v031HxE+qaC/IfCGjPRZAm05mXmHNwng+q0tU1bNZCsu2yoE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnQOXG/NrNBzB6fOllJO0SkvnizE/UP0n6vb2oHncfo5xe98Z
	HbRHNe/7L+Zc8lr4Ddd1vFZoQamcgWZDJjQwon7FZWPwDwj4rb9l1P409CU8hMHt7e7ksnGHB2X
	i+QnTkLJu4SqxBD1WfdvJLasyI9tvURY=
X-Received: by 2002:a17:907:b05:b0:bee:aed6:9d50 with SMTP id
 a640c23a62f3a-beeaed6a140mr33022366b.48.1780322006736; Mon, 01 Jun 2026
 06:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035832.2204720-1-maobibo@loongson.cn> <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
 <CAAhV-H7UP5TZh5zaqtkAboUt226-vGUBddksYXxafdKOioVngQ@mail.gmail.com>
 <61d0efa7-a15a-be48-3bca-5be5efd99acf@loongson.cn> <CAAhV-H4+A0bs07v4B8BTCqbNsG5SLSjjx8sh5Lz23i+R37RAKw@mail.gmail.com>
 <74e8fa9e-90f6-175e-fb98-2e4504d5f15d@loongson.cn>
In-Reply-To: <74e8fa9e-90f6-175e-fb98-2e4504d5f15d@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 1 Jun 2026 21:52:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7WnvO80sQoQLpgnomobkB7Zu5F4rgXxsj5ErymukQ+9A@mail.gmail.com>
X-Gm-Features: AVHnY4KoQON_TBQI0hp_0s1fZ6GYByMH8-GyvNX2pquyO_ikcj-9QX50vC5iiT0
Message-ID: <CAAhV-H7WnvO80sQoQLpgnomobkB7Zu5F4rgXxsj5ErymukQ+9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:14=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/4/8 =E4=B8=8B=E5=8D=883:47, Huacai Chen wrote:
> > On Wed, Apr 8, 2026 at 9:04=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2026/4/7 =E4=B8=8B=E5=8D=888:41, Huacai Chen wrote:
> >>> On Mon, Mar 30, 2026 at 6:00=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> >>>>
> >>>> Hi, Bibo,
> >>>>
> >>>>
> >>>> On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongson.=
cn> wrote:
> >>>>>
> >>>>> With FPU save and restore flow, the cost is the same with different
> >>>>> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line imp=
action.
> >>>>>
> >>>>> Here is to enable FPU with max VM supported type, for example if
> >>>>> VM supports LASX instrction, enable FPU with LASX type even with FP=
U
> >>>>> exeception. So it can avoid possible LSX/LASX exception in future.
> >>>>>
> >>>>> With context switch microbench which may touch FPU and LASX, there =
is 9%
> >>>>> improvement when halt_poll_ns is disabled. The command is
> >>>>> "./context --test=3Dpipe" and source code located at:
> >>>>>     https://github.com/bibo-mao/context_switch/blob/main/context.c
> >>>>>
> >>>>> Original     Wih patch      improvement
> >>>>> 75232        82440          9%
> >>>>>
> >>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>> ---
> >>>>> v1 ... v2:
> >>>>>     1. Enable FPU with max VM supported FPU type, rather than max u=
sed type.
> >>>>>     2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
> >>>>>     3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >>>>>     3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
> >>>>>     4. Remove middle FPU state handling in kvm_own_lsx() and kvm_ow=
n_lasx(),
> >>>>>        directly enable LSX or LASX from FPU none state.
> >>>>> ---
> >>>>> Bibo Mao (6):
> >>>>>     LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
> >>>>>     LoongArch: KVM: Enable FPU with max VM supported FPU type
> >>>>>     LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
> >>>> Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
> >>>> so I think Patch-3 should be squashed into Patch-1.
> >>>>
> >>>>>     LoongArch: KVM: Remove some middle FPU states
> >>>>>     LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
> >>>>>     LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
> >>>> Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX a=
nd
> >>>> Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, =
so
> >>>> I think Patch-6 should be squashed into Patch-5, too.
> >>> And could you please test the power consumption where there are many
> >>> VMs that only use FPU rather than LSX/LASX? As far as I know, the
> >> Hi Huacai,
> >>
> >> Thanks for reviewing this patch
> >> Could you help me to test the power consumption with this patch?
> >>> power consumption of LASX is significantly more than FPU, which is a
> >> Could the describe the detail scenery wheree LASX instruction is
> >> frequently used by application or LASX  EUEN enabled?
> > The purpose is to evaluate power consumption before and after this seri=
es.
> >
> > So we can run 10 VMs (suppose there are 4 cores), and there is a
> > workload run in every VM, the workload only uses FPU, no LSX and LASX.
> > Before this series, KVM only save/restore FPU context; after this
> > series, KVM will save/restore LASX context.
> In theory there should be such test, only that it requires special Power
> Management team and testbed. Even if there is such team, maybe they care
> power consumption about DDR and screen, do not want do such experiments
> for this patch.
>
> If someone is volunteer to do this, I do not object, also I want to get
> the result. Just from my guess, there should be no much difference since
> FPU context switch is much smaller than the whole workload, else the
> workload is just FPU context switch.
Any updates?


Huacai
>
> Regards
> Bibo Mao
>
> >
> > If the power consumptions are similar, then this series is perfect.
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>> little similar to AVX512 (Linus said it is a power virus).
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>>
> >>>> Huacai
> >>>>
> >>>>>
> >>>>>    arch/loongarch/include/asm/kvm_host.h |  6 +--
> >>>>>    arch/loongarch/kvm/exit.c             | 21 +++-----
> >>>>>    arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------=
------
> >>>>>    3 files changed, 30 insertions(+), 75 deletions(-)
> >>>>>
> >>>>>
> >>>>> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> >>>>> --
> >>>>> 2.39.3
> >>>>>
> >>>>>
> >>
> >>
>
>
