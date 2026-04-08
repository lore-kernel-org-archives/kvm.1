Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CF3BA234
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644158; cv=none; b=ILyHvXSGlOAiSjurGfLCTnX+BxRCHv0Za2++9de5M+bhWdkWUPt3yGlQaDcRyvBZPsah7UQmW3VkAjUOQBmKWTIXPKKnoSNnibpYQOuS5bMLOS6pI8OKDcjLkKC95j+3nNhSg0tRsW2KlxuQJIgrxL1dj2h/S4+LCQMUxF1g0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644158; c=relaxed/simple;
	bh=Bj7hF8FY0R8afa6Qd3I4y/Z8HbTjcQ+4kH+m9ERkvJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAXce9h0D6/mN+MGbE0HJNMVYfSZNkiwSDArykWwIgpkv3+Xrnsl80vzVjD4h+D1f1zCIX4SUHMcomw2CIhRiX/Ao1C9Hf1L5aKNMxRZcu8Pnk05Vvb+5Rca8oMatGXSX39vslZaaM8+Gn9fG4LggQyNM7mIsHgXA2WYDJIV4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyc/RpZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyc/RpZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1546C19424
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644157;
	bh=Bj7hF8FY0R8afa6Qd3I4y/Z8HbTjcQ+4kH+m9ERkvJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eyc/RpZRei9V3qKoqlyn9ibCoYd0dPOpBmTQZqN8JytEJ2ySeW1YsRG5RimQJLKeI
	 D6TTg73a4iH8pb/72NKOO7E8CZFiMyEhs1xGar3zBmpH2oAJVlRWh894/z1kT6FI2c
	 krfKkOUs9MheYp/4rkHqf03KhqZgw73ngrgMpdL+TFMgVKwkcTJBhu4fwC3Wcaj6+D
	 Xh3uhQmQ9353UEk4hK2e9IW+520BXpwXmcfGgztcB47vp0rfJ0lxXoPYNgKoY8E7Ra
	 QEzX8Jr46ZlMU5RxIrlS162eO5txj4ygImDAWKth22syxZfeNahlDLom5QkKrLsH72
	 o9714g86iuylg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1000249566b.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 03:29:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYOsPSUI+GYOf3m5vBGNC1+qNR0cZkdNxo0RE6BAYb6Y7WDvsA1tLqKTHnspaP4PzQfGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8RoCFcx7K+eSUwBCJncVTuA7XGlb5cEVv7rjZoFhrP9T6wn6
	g2uQg4LBDDbUo264j/J1JswG6rCSkGqpzebJAHvkEGsC2mn8HWwHnjtGat3aIkbqGBNotA5JtKJ
	YB2UF57DgfJn3TdIxGW5v/hbezMI2Px0=
X-Received: by 2002:a17:907:a2c5:b0:b98:427e:218d with SMTP id
 a640c23a62f3a-b9c67957b5dmr1055394466b.25.1775644156296; Wed, 08 Apr 2026
 03:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323025613.3260876-1-maobibo@loongson.cn>
In-Reply-To: <20260323025613.3260876-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 Apr 2026 18:29:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6TyXh95QUZcYbQ6_BaSjzCEpNfmCBdMT9S8Sr3YYWyjw@mail.gmail.com>
X-Gm-Features: AQROBzBJYyB5MqRJ0qqrzBOwPzUwsN43JG80OmYqdwthYWhR4qzq6b2t6F6qT4s
Message-ID: <CAAhV-H6TyXh95QUZcYbQ6_BaSjzCEpNfmCBdMT9S8Sr3YYWyjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] LoongArch: KVM: Some small enhanments
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Mon, Mar 23, 2026 at 10:56=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> There are some small enhancements about LoongArch KVM. There is
> improvement about VM entry path in patch 1 and patch, add pending
> request checking in advance and it is empty at most time.
>
> Also change vcpu_is_preempted() from function to macro method, by actual
> benchmark test such as unixbench. It is affected on physical machine
> with function method. With the macro method, only one nop instruction
> is added and there is no parameter parsing, there is no obvious
> performance influence with physical machine.
> ---
> v2 ... v3:
>   1. Add new patch to move host CSR_GSTAT save and restore in context
>      switch stage rather than VM entry, update it only when VMID is
>      changed on VM entry.
>
> v1 ... v2:
>   1. Add READ_ONCE() with src->preempted to avoid compiler optimization.
> ---
> Bibo Mao (4):
>   LoongArch: KVM: Add kvm_request_pending checking in
>     kvm_late_check_requests()
>   LoongArch: KVM: Move host CSR_EENTRY save and restore in context
>     switch
>   LoongArch: KVM: Move host CSR_GSTAT save and restore in context switch
>   LoongArch: KVM: Set vcpu_is_preempted() with macro rather than
>     function
>
>  arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
>  arch/loongarch/kernel/paravirt.c       | 15 ++------------
>  arch/loongarch/kvm/main.c              |  8 ++++----
>  arch/loongarch/kvm/vcpu.c              | 26 +++++++++++++------------
>  4 files changed, 42 insertions(+), 34 deletions(-)
>
>
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> --
> 2.39.3
>
