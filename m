Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61E3B6C15
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864803; cv=none; b=JocIuqwOqhGtLdjuK5x1x7dAvPAj5n2Zn58//ME5r7PNcC86QAwij0K6QikzLEa62rwHa+eogapGLz1ojq3cF9olmuTaO31kUkvhwE3fHL0lQA2oqSd6QoqMZ/3Hgrmn2Ww1d2TxdKSD1TWDAcMnXJ3oEqyq/aTaG7iB9R9nQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864803; c=relaxed/simple;
	bh=eOBnIA9YEHTavwU6XNfO1eXOfBNKK/xWGBaDbCR8Zxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gX0+YcKwKz2kDsh84QNAGy2oNIbPGlV+Q1KygY7iZCUdhkac0F2fSjPRNCB8A4JgAK0BKQWN2s9TgCpuwGw0grc33NZCT7TXPnT21IDx1POYLi6nPKnyTgviOJkVJeyN+qOxHDHi9OWPUTgBRr90SDl2vhWYhgvKQdbhe0qmqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ01GomS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ01GomS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E87C2BCB3
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864803;
	bh=eOBnIA9YEHTavwU6XNfO1eXOfBNKK/xWGBaDbCR8Zxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQ01GomS2NZT2htGWGAFlcJ2kDiEk1f3a5N+umKhJTrDyFrMTeF2nEezFACVAQScr
	 6FP5RZWL3zAol8EIVZ+HTzWAYk0rX538dheX90YAaXzIw6eDpJW0XjzuuKk6n75Z6L
	 KGKoUpN1Pz7TZXPhD300/IbsVvEcog5jVmdRB52MoMZ+2yelwcKCRynCFi0ZHfXQIO
	 Rlx7fmM25/8AxePh0uLsN77LZ9QM2gAiywIYEInA2pa27vZzdm4o0v0kc/Onx0cspp
	 aqytbAjb+hAXWHJyojkiroOq0pLMl+h3PzCADQFUkyZKfzY6Ny09NJpBsK9cdzUvc+
	 4huetVeWp67Qw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so561179266b.1
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 03:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj9DGobIZlhHGa7BRz8yER+dDhoAnCOjU/KWspiXC0XNVDwJvvxwF4j18BumEogZ2vMjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCRMPOF6y5k+ODsw7cFuw61smdLK16+jiJt1Y8Hca4daM1sIr
	cUOqXmq0zLSMK8Nd5KlKRNfsFmWjDmIxrkoepmnMVZc1EAKj8jX+XIleLUTHHNRk0MCfzUCMP56
	97Ez6bTwRDsBGtzYwiNb7wFHZGfRDw+U=
X-Received: by 2002:a17:907:746:b0:b9b:1b9f:8397 with SMTP id
 a640c23a62f3a-b9b507a5d23mr857667966b.31.1774864802012; Mon, 30 Mar 2026
 03:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035832.2204720-1-maobibo@loongson.cn>
In-Reply-To: <20260330035832.2204720-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 30 Mar 2026 18:00:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
X-Gm-Features: AQROBzCnBMDyHICpmQMtzFy-MLkGP4kgNeOLu1fxvymzLJGP0lA6XvsucRHfPTE
Message-ID: <CAAhV-H4Ws3Y89XfSXdGpm3BL5Pr5kTzC0NPdkDm17uy3ZEZJmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,


On Mon, Mar 30, 2026 at 11:58=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> With FPU save and restore flow, the cost is the same with different
> FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction=
.
>
> Here is to enable FPU with max VM supported type, for example if
> VM supports LASX instrction, enable FPU with LASX type even with FPU
> exeception. So it can avoid possible LSX/LASX exception in future.
>
> With context switch microbench which may touch FPU and LASX, there is 9%
> improvement when halt_poll_ns is disabled. The command is
> "./context --test=3Dpipe" and source code located at:
>   https://github.com/bibo-mao/context_switch/blob/main/context.c
>
> Original     Wih patch      improvement
> 75232        82440          9%
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Enable FPU with max VM supported FPU type, rather than max used type=
.
>   2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
>   3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>   3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
>   4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx()=
,
>      directly enable LSX or LASX from FPU none state.
> ---
> Bibo Mao (6):
>   LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
>   LoongArch: KVM: Enable FPU with max VM supported FPU type
>   LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
Patch-1 add KVM_REQ_LBT_LOAD, then KVM_REQ_AUX_LOAD is only for FPU,
so I think Patch-3 should be squashed into Patch-1.

>   LoongArch: KVM: Remove some middle FPU states
>   LoongArch: KVM: Use vm_guest_has_fpu API in kvm_lose_fpu()
>   LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
Patch-5 remove the consumer side of KVM_LARCH_LASX / KVM_LARCH_LSX and
Patch-6 remove the provider side of KVM_LARCH_LASX / KVM_LARCH_LSX, so
I think Patch-6 should be squashed into Patch-5, too.


Huacai

>
>  arch/loongarch/include/asm/kvm_host.h |  6 +--
>  arch/loongarch/kvm/exit.c             | 21 +++-----
>  arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
>  3 files changed, 30 insertions(+), 75 deletions(-)
>
>
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> --
> 2.39.3
>
>
