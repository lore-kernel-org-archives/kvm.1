Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA682F8E8C
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209012; cv=none; b=EFeJ2mFn3V/uyoyhcfYXZWCP7/O07C0TR+ZTWn/Ch2XrP0qUS31I3FAZHcTZyDzId/FH+TfNGy9YUk+fmu5eK9v33A1UMwEjiUGked3Vm5MtbmOroDwByeXaKYxd83iDCDTfMbM2hJED5deV40aIsqdC7MqcFKVYY4y33XmBOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209012; c=relaxed/simple;
	bh=K5SSG1r/BsdsaivSjHxhbXYZLBwuM6XJhtPZHjT+pbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7Xobiq+pYn68YhCH0NobmQ816lATsfchRdM06WjFi7/rrN/ZBcvfKmt2R9N0MciPmQQSmwZOUCDxNeYVIVVrVYwksc5A4krXu7cwfB1pwDW8a7pDTrzRcWlytjTBkIhiKQ+FmaX+yZu6qV+8ac4iMgLfEECmpz0U9fX64cuZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFzCTqfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFzCTqfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD93AC2BCF4
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 02:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778209011;
	bh=K5SSG1r/BsdsaivSjHxhbXYZLBwuM6XJhtPZHjT+pbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AFzCTqfK2q+Kh2OClPz8s5upXtFdeY1cPOKZJE2cRrx+iNvmH/ZSTZbAzPD+p1BBa
	 lJfxr30PZCt2OXdnYop1XF1NjvAs3Fz/EEhfbafTsQrgG0YH2ks2HuTHw6PdEGskBQ
	 66gcim2/k/SuxZmWl+juAThDfcxEBJwBAawHyZhZZ2ODWDVViPx8nqYYB0UJeWEnZw
	 DM80ESUcsP43Oh5IiSIZlUYaZJIRDY3ts5BQxoxLnFidsG+qKGGCHhpEjPzlzlEnX7
	 JjXE5O1Pvo8uAe/O17H068MQuD/XUyhBEiTmIsfONkB27C0BDbWRcMZIMIPY6gBTti
	 ilensTBb7sqbA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bc356898256so260240866b.3
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 19:56:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yeD5GaTWDtirB/DsNEKn/jRqhY06Y6BjdkKooYOrmyxlUH2gwPY04J74FuYnt10m6Adg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgugO1jVgjyd7Fg9AKw2D488/Y27QBsZHCm13F5rHqAJDykKa
	v3faw3xVhNPclfY+H+6TUzd6i3Zb9k/oY9Fe7I+awpzypJpCBMQJ54aexQmJa176Ha74/dtdWeA
	5imqawGeCCUBzi6GdHj+rRTf2ndSHqQI=
X-Received: by 2002:a17:907:9806:b0:bc3:8580:f32d with SMTP id
 a640c23a62f3a-bc56af26040mr584492966b.5.1778209010316; Thu, 07 May 2026
 19:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508013001.4107737-1-maobibo@loongson.cn>
In-Reply-To: <20260508013001.4107737-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 8 May 2026 10:56:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6dHM0GBFCh-6-q0fM3VSa49RTXSDz+YUvM0j7u_was1g@mail.gmail.com>
X-Gm-Features: AVHnY4KlCMTgyX8DMjVigyMUUcEj42nQ6DiQI3nyLBWnE9rjigduPUtkcxymLas
Message-ID: <CAAhV-H6dHM0GBFCh-6-q0fM3VSa49RTXSDz+YUvM0j7u_was1g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Move some variable declaration to file paravirt.h
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Fri, May 8, 2026 at 9:30=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Some variables relative with paravirt feature are declared in header file
> asm/qspinlock.h, however this file can be included only when option
> CONFIG_SMP is on. There is compiling warning if CONFIG_SMP is off since
> it is not declared.
>
> Move these variable declaration to header file asm/paravirt.h to avoid
> compiling warning.
Have you reproduced the warning? I cannot reproduce it in my
environment with the config file from lkp report, so I also cannot
confirm whether it is fixed.

Another question:
Is paravirt.h a better place than kvm_para.h?

Huacai

>
> Fixes: c43dce6f13fb ("LoongArch: KVM: Make vcpu_is_preempted() as a macro=
 rather than function")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605061313.O8Hswm2b-lkp@i=
ntel.com/
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/paravirt.h  | 4 ++++
>  arch/loongarch/include/asm/qspinlock.h | 5 +----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/inclu=
de/asm/paravirt.h
> index 0111f0ad5f73..dbc64908017f 100644
> --- a/arch/loongarch/include/asm/paravirt.h
> +++ b/arch/loongarch/include/asm/paravirt.h
> @@ -3,6 +3,10 @@
>  #define _ASM_LOONGARCH_PARAVIRT_H
>
>  #ifdef CONFIG_PARAVIRT
> +#include <linux/jump_label.h>
> +DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> +DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>
>  int __init pv_ipi_init(void);
>  int __init pv_time_init(void);
> diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/incl=
ude/asm/qspinlock.h
> index 0ee15b3b3937..fbfc6be82f26 100644
> --- a/arch/loongarch/include/asm/qspinlock.h
> +++ b/arch/loongarch/include/asm/qspinlock.h
> @@ -3,12 +3,9 @@
>  #define _ASM_LOONGARCH_QSPINLOCK_H
>
>  #include <asm/kvm_para.h>
> -#include <linux/jump_label.h>
> +#include <asm/paravirt.h>
>
>  #ifdef CONFIG_PARAVIRT
> -DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
> -DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> -DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
>
>  #define virt_spin_lock virt_spin_lock
>
>
> base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
> --
> 2.39.3
>
