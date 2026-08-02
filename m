Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67F3932EA
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785679701; cv=none; b=JMya3PhcJBrce+vrBcaQBiH/yNea5IbmxgJZtr0DgKGTqwhDDgzz3cKbrPk9XXOlTcAvS2z1KJ904h32q2lJ4B4QT+NNcz33bcYccEh7U8Lr6bGGgd0eHTFawoMa2p52DK6rvdVyOCC/a05liI72QMNSSi4oW0iFVexn26hiJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785679701; c=relaxed/simple;
	bh=oUCNdOh9Kwkj8aGAi05IkLLrqAfYLuUGKQ9qpFqDbp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkrKX4tEHE+y4EzkstHI0Tf+7cyT6Tilstj7eKO4IBA3LjIsL7livf8iqcAIoNK+LOPGYx+/Cd9I6cMPauvkZgZjk/oAkAIKl/iK986jtBESr07xZulhPt262rsQKrVK5xRS40GjG35MP0cpVIoDQRbqLTj/+PTQSqevnUqcWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bct4ExGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bct4ExGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A11F00A3E
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785679699;
	bh=QxiERV+W64FsC74zKKtfmIJ5yAmZNdQWDagjEo1LMO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bct4ExGg1WgTO6fKbWdUIFZrTuCS7BlIr74JEQj1PU/8HeU1amYveI2y3xgMQ8Q7A
	 HV+Nay9FnPLfO99EsaXZ5AxIrLH3NU/VJ6hfJKNe96L4UpoGPjKF2IjwVADVagB1B6
	 Fyy+l26SdaFl84jBtetKoT6jug6TaiG67GZ4HDRiJWpTl29HuVFwXd6ysjTkFqJyvq
	 xP2pgiok+pbvMXFaDjpO5R3GmYpqsOzzIyCiz3rpoo/9Vwu1q004+jx4S0Y7je0QVH
	 3oUvpo3K+klBlnjOKzlDDfwWhk3sVGr5HgFbQnDJqGjLBS4dzr5MmmbADpWepXQPMY
	 EW+3hEPr904vw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so4392049a12.1
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 07:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7ZKbziZ1EuJn6OaK2Flc0xAAyoWDnaqMEMQptTroTQHkys0Mgcd5HLG3imCCj1FCJ+BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOW8d7cFxfXunbvpa48dhhyC2Vc9X+89mVUd/gGp8ZbDa7iqGG
	LpL+JlV0ZiASRS/PKVil6/3AXQCgnK/5oxPCxpyMGVg1RXBRTyq+5WGWO8cAvhf7WpRLklQ40XQ
	8HIqmfFfFu++Zr0WVEND+r8z0EJK7FYs=
X-Received: by 2002:a05:6402:44dc:b0:698:5610:76de with SMTP id
 4fb4d7f45d1cf-6a0a7c614e1mr3823671a12.4.1785679698310; Sun, 02 Aug 2026
 07:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714072520.2745942-1-maobibo@loongson.cn>
In-Reply-To: <20260714072520.2745942-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Aug 2026 22:08:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H49xHp+7qn8dXBc91yksGUCoYmuZWwCte3AHSutGRRK-g@mail.gmail.com>
X-Gm-Features: AUfX_mwkjJhmiaMAimXlH3M5HrdNW6aW2mr8kFkdEi2X-bhkAtKWCOpI-4aJPmk
Message-ID: <CAAhV-H49xHp+7qn8dXBc91yksGUCoYmuZWwCte3AHSutGRRK-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] LoongArch: KVM: Harden interrupt injection
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Series applied, thanks.


Huacai

On Tue, Jul 14, 2026 at 3:32=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> API kvm_vcpu_ioctl_interrupt() is mainly to used to deliver interrupt
> from user mode, and internal APIs kvm_queue_irq() and kvm_dequeue_irq()
> are used in kernel mode, also moves IPI interrupt handling within lock
> protection.
>
> Also this patch replaces kvm_err() with WARN_ONCE() to avoid noise
> kernel log.
>
> ---
> v4 ... v5:
>   1. Add one new patch and fix uninitialized stack variable issue with
>      dmsintc.
>   2. In patch 2, set return value with 0 to prevent information leak
>      where return directly with non-aligned address in IPI irqchip.
>
> v3 ... v4:
>   1. From AI assist, replace kvm_err() with kvm_pr_unimpl() rather than
>      WARN_ONCE(), since host may crash with WARN_ONCE() when kernel
>      parameter panic_on_warn=3D1 is set.
>   2. Add one new patch 3 which returns directly when IPI address is not
>      aligned, rather than only print WARN_ON_ONCE() and continue to run.
>
> v2 ... v3:
>   1. Split the patches into three smaller ones, the first patch removes
>      old default case and kvm_err() since it is impossible to happen.
>      And the second patch replaces kvm_err() with WARN_ONCE().
>
> v1 ... v2:
>   1. Add border check with ipnum in eiointc_set_sw_coreisr() and
>      eiointc_update_irq(), so that injected interrupt vector is valid.
>
>   2. Move IPI inject and ack within lock to avoid contention in
>      ipi_set() and ipi_clear().
>
>   3. Add kvm_arch_irqchip_in_kernel() check in user mode irq injection
>     in function kvm_vcpu_ioctl_interrupt(), contention of user mode irq
>     injection is assured from user mode VMM.
> ---
> Bibo Mao (5):
>   LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
>   LoongArch: KVM: Return directly when IPI address is not aligned
>   LoongArch: KVM: Set default MAILBOX access size with 8
>   LoongArch: KVM: Replace kvm_err() with kvm_pr_unimpl()
>   LoongArch: KVM: Use internal API to deliver interrupt in kernel mode
>
>  arch/loongarch/kvm/exit.c         | 16 +++----
>  arch/loongarch/kvm/intc/dmsintc.c | 17 ++++---
>  arch/loongarch/kvm/intc/eiointc.c | 32 ++++++++------
>  arch/loongarch/kvm/intc/ipi.c     | 73 ++++++++++++++-----------------
>  arch/loongarch/kvm/intc/pch_pic.c | 12 ++---
>  arch/loongarch/kvm/vcpu.c         |  5 ++-
>  6 files changed, 80 insertions(+), 75 deletions(-)
>
>
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> --
> 2.39.3
>
>
