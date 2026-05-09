Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BB3939D2
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335887; cv=none; b=OQXFS+kMDS7W8pHKQOc8Jcwv0G5eIqzOPzHvPlmE5fXXjYtt9+8tlhw8lt37IAbXb4wr1lhaeY7nVEfxklc00FCSXfTkZQxb+Kil444PcOrE/2aFhsTOX1XJX1lnPK8lj8KGRJNgEmutz1l2aBnsRvXY+4nk2enc/N/AkahckRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335887; c=relaxed/simple;
	bh=++fkJcl9vcz0uZyCJnAl6KXcCRI8tvPw7VCGiP5Bbm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxHO6aEOEg80zIa/kEwXTBIqSoxXnxJRAO+h9tSf7O229yjr5Dtcv7cmCqD4TQQ96o7cya1fx4sm9uClI8ymMe5Ib9MiCItfUYDiqCm6yqVtWTuLl8sHtLNOnV+XupyJBQgMRLFOUJhSRZ5MifLQb9dnjQwgbvRxDSlspAwaBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHKz6piI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHKz6piI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACCC2BCC9
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778335887;
	bh=++fkJcl9vcz0uZyCJnAl6KXcCRI8tvPw7VCGiP5Bbm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lHKz6piIvaVYWLx/R3sYqGyLTJgdtt22723ikkrS1OOumQxaRA6azHi6E70oA4vup
	 FGGEPUC9maiAzaGEZyhjq/T/gpK+QhMyvxyBkfBvyTnES+W3qP3BPyt1Vlhca35llW
	 soKhczJmyQeqQFNc1FBod4CpwN8fNM8EBHm8scNzdNJHb85A9GgEhCT7taX0Ve0eMY
	 y6Ma1M0o9gbFdR/L44o1qWAN0zdrxmJpRdMtQNpH9JQcl6AaYbsVAgFdsbQHBTAm/4
	 1/77fDIHDf+yC0DW3wV2zGOfHZY2xZhj/36KrF65elViI/kLe+psO4iTD//pTXuq7f
	 bH4VWFKRGFRiQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcd0111ea98so18289666b.1
        for <kvm@vger.kernel.org>; Sat, 09 May 2026 07:11:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3eaGBJIJ5UW7pUXlB663VrCJngjdneiEV0puXQDMe5BQFyXkwwqNnBDDkqLm3DEeUXnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqszWj1TJL4dDN8rd2DcKLrAt/7j1UD0ZxWjKaNkphYkWzOAY
	h5UncYmGqjlBXEoaDIVnmJ+MGLGCEabQkIBN1A9kRzQe/LNPpA36GT4+vFmOh2tnL4Ewzg9Duyb
	J1YeehTBsqe98PXtvvSMzibzVul2nBOM=
X-Received: by 2002:a17:907:c27:b0:bcb:8984:15ec with SMTP id
 a640c23a62f3a-bcb89842ed0mr240730966b.29.1778335886073; Sat, 09 May 2026
 07:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508013001.4107737-1-maobibo@loongson.cn> <CAAhV-H6dHM0GBFCh-6-q0fM3VSa49RTXSDz+YUvM0j7u_was1g@mail.gmail.com>
 <3d3bb8ea-34b7-b4da-deac-677ac272dd76@loongson.cn> <CAAhV-H44v2TcSAeq+mDiHy26k=mE4ykqjrvPsNurgpw4OhnNTg@mail.gmail.com>
 <076bc4bc-54da-efb6-b1d4-e5e754bb580a@loongson.cn> <CAAhV-H7vCF0=_EdahXSeQBu8r65SJ6t3-FCiWh4TxhoaRnXnMg@mail.gmail.com>
 <3df8e39d-1692-07d2-222c-a68fbfd6ab5a@loongson.cn>
In-Reply-To: <3df8e39d-1692-07d2-222c-a68fbfd6ab5a@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 9 May 2026 22:11:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4W4z+BXm_hREk+ZSZzK=9UAOav7itAvD6ohYPy0fAsDg@mail.gmail.com>
X-Gm-Features: AVHnY4JN0veX4hzftGEtE4xPuLDbneVcownbdzUjsM6-g9vbmTQOorwPZ45Sabs
Message-ID: <CAAhV-H4W4z+BXm_hREk+ZSZzK=9UAOav7itAvD6ohYPy0fAsDg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Move some variable declaration to file paravirt.h
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 9:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/5/8 =E4=B8=8B=E5=8D=889:04, Huacai Chen wrote:
> > On Fri, May 8, 2026 at 11:19=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >>
> >>
> >> On 2026/5/8 =E4=B8=8A=E5=8D=8811:11, Huacai Chen wrote:
> >>> On Fri, May 8, 2026 at 11:08=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2026/5/8 =E4=B8=8A=E5=8D=8810:56, Huacai Chen wrote:
> >>>>> Hi, Bibo,
> >>>>>
> >>>>> On Fri, May 8, 2026 at 9:30=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>>>
> >>>>>> Some variables relative with paravirt feature are declared in head=
er file
> >>>>>> asm/qspinlock.h, however this file can be included only when optio=
n
> >>>>>> CONFIG_SMP is on. There is compiling warning if CONFIG_SMP is off =
since
> >>>>>> it is not declared.
> >>>>>>
> >>>>>> Move these variable declaration to header file asm/paravirt.h to a=
void
> >>>>>> compiling warning.
> >>>>> Have you reproduced the warning? I cannot reproduce it in my
> >>>>> environment with the config file from lkp report, so I also cannot
> >>>>> confirm whether it is fixed.
> >>>> yes, I can reproduce this and it is fixed. The warning is reported f=
rom
> >>>> sparse tool, rather than LLVM.
> >>>>>
> >>>>> Another question:
> >>>>> Is paravirt.h a better place than kvm_para.h?
> >>>> en, here kvm_para.h seems better, will send V2 version in next time.
> >>> Frankly, I don't know the difference between the two files. kvm_para.=
h
> >>> is kvm specific and paravirt.h is generic? Or kvm_para.h is the
> >>> hypervisor side and paravirt.h is the guest side?
> >> kvm_para.h is shared by hypervisor and guest kernel, paravirt.h is onl=
y
> >> used by guest kernel. And option CONFIG_PARAVIRT is useful with guest
> >> kernel, CONFIG_PARAVIRT has no much meaning with hypervisor.
> > If so, paravirt.h seems better to declare these variables.
> yes, paravirt.h seems better than kvm_para.h :)
Applied, thanks.

Huacai
>
> Regards
> Bibo Mao
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>> Huacai
> >>>
> >>>>
> >>>> Regards
> >>>> Bibo Mao
> >>>>
> >>>>>
> >>>>> Huacai
> >>>>>
> >>>>>>
> >>>>>> Fixes: c43dce6f13fb ("LoongArch: KVM: Make vcpu_is_preempted() as =
a macro rather than function")
> >>>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202605061313.O8Hswm2=
b-lkp@intel.com/
> >>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>>>> ---
> >>>>>>     arch/loongarch/include/asm/paravirt.h  | 4 ++++
> >>>>>>     arch/loongarch/include/asm/qspinlock.h | 5 +----
> >>>>>>     2 files changed, 5 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarc=
h/include/asm/paravirt.h
> >>>>>> index 0111f0ad5f73..dbc64908017f 100644
> >>>>>> --- a/arch/loongarch/include/asm/paravirt.h
> >>>>>> +++ b/arch/loongarch/include/asm/paravirt.h
> >>>>>> @@ -3,6 +3,10 @@
> >>>>>>     #define _ASM_LOONGARCH_PARAVIRT_H
> >>>>>>
> >>>>>>     #ifdef CONFIG_PARAVIRT
> >>>>>> +#include <linux/jump_label.h>
> >>>>>> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> >>>>>> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >>>>>> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
> >>>>>>
> >>>>>>     int __init pv_ipi_init(void);
> >>>>>>     int __init pv_time_init(void);
> >>>>>> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongar=
ch/include/asm/qspinlock.h
> >>>>>> index 0ee15b3b3937..fbfc6be82f26 100644
> >>>>>> --- a/arch/loongarch/include/asm/qspinlock.h
> >>>>>> +++ b/arch/loongarch/include/asm/qspinlock.h
> >>>>>> @@ -3,12 +3,9 @@
> >>>>>>     #define _ASM_LOONGARCH_QSPINLOCK_H
> >>>>>>
> >>>>>>     #include <asm/kvm_para.h>
> >>>>>> -#include <linux/jump_label.h>
> >>>>>> +#include <asm/paravirt.h>
> >>>>>>
> >>>>>>     #ifdef CONFIG_PARAVIRT
> >>>>>> -DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> >>>>>> -DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >>>>>> -DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
> >>>>>>
> >>>>>>     #define virt_spin_lock virt_spin_lock
> >>>>>>
> >>>>>>
> >>>>>> base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
> >>>>>> --
> >>>>>> 2.39.3
> >>>>>>
> >>>>
> >>
>
>
