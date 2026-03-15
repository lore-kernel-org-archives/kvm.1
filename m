Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF714D719
	for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773561816; cv=none; b=Unt4t5lUtiqXZJEpIepzY6TGgJ7hrLmF3QmVsDgodHcziUzx7n1APikZhr1MRz3L0cwQZUeLZw4pLJd8Hqm0faJGg0EqqmSutHvCFffK65SfWSeu8BrB6iOeGZb0Rt0KaXvuXxE2+pfCwU1ySDJoUGwW7FVzl5IoKZXgu4fWY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773561816; c=relaxed/simple;
	bh=0WYXzzTo4+7yyvFucUL6qBG07+FQTHZ0JbJCsd55X00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0rYT80olPY+fEPHo2TlTTb/lG7Y1wHGn3oM9ILUIimge1BiPY6MSeJT23ttjfmtADvUMZ4OAdx7hqpyQXJh4Pjy6WSEmLupny+j+8I6bL5QHMNSliPIXeZiX+SHX4185LevrgmHpIHS4FJcUhSheEhfUcxNKJWBJFQVyVHp6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z73hahok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z73hahok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30ABC2BCB0
	for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773561815;
	bh=0WYXzzTo4+7yyvFucUL6qBG07+FQTHZ0JbJCsd55X00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z73hahok5M0oILKuuebsYGE3NaGCdD29t7KC5x3Ri1utJS5FCnei6NGsNpg6PDdqy
	 zZB7e2SGfvEzyBpt8He5HWoyc0dB+WUOs/jne/++wyLW9+CR9uL50YNZlSIEu4UhxJ
	 t2d6P5jx8FxZbQWwmvMNBruQKtQb0k5WoP0ExsOb663QrtkHSCJL3mCVPoz9cKk8y5
	 bOgmEOzdG/x9jdqHdH38uxGAE+8u43TlCE2BIvdlJaX6YR6yugteVyIYXvR9whNVq9
	 u0ygtj0dyE4IE7iB9fX456y2n3dKYoaNxnkEF7pE5i3Df6mYNmdJHXO5oG/6+af+l3
	 htFMHXZE77CRw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso401826566b.3
        for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 01:03:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSgDpkXlXJokmL8MhYFXSUJnov+82VHiBXBLvXm7CsD24FHF3nv62DgiGpGs7/wP+zLRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmFsyRl6sUgVmo33EwxsI9J07nu3A6tVoHmqjLBYK99SWiYY5
	x6weP3vcgoO2uiha7cE1y8hSpUfpZCu275B8eGnwKx7E9dRHB9j49BDGJNCmVfuvWknqiDPVieP
	xPjBlEuPk3XjfF2CLpbYSpiqsihACeJA=
X-Received: by 2002:a17:907:2da7:b0:b97:7d04:bb4f with SMTP id
 a640c23a62f3a-b977d04c7f5mr344487766b.7.1773561814089; Sun, 15 Mar 2026
 01:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304013254.2543620-1-maobibo@loongson.cn>
In-Reply-To: <20260304013254.2543620-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 15 Mar 2026 16:03:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Po6kAEnti2erZAnojZo7ePksHC7SYuPuv4T=jnhzzXQ@mail.gmail.com>
X-Gm-Features: AaiRm51bYXLTUkebafKzwzFT8OTqTREqgZNYP9zLCMSpNcD_xiPtiavJ0NBmNog
Message-ID: <CAAhV-H6Po6kAEnti2erZAnojZo7ePksHC7SYuPuv4T=jnhzzXQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix typo issue in kvm_vm_init_features()
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, kernel@xen0n.name, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Mar 4, 2026 at 9:33=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Most of VM feature detection is integer or operation, and integer
> assignment operation will clear previous integer or operation. Here
> change integer assignment operation with integer or operation.
>
> Fixes: 82db90bf461b ("LoongArch: KVM: Move feature detection in kvm_vm_in=
it_features()")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 63fd40530aa9..a555ea037cf5 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -49,8 +49,8 @@ static void kvm_vm_init_features(struct kvm *kvm)
>                 kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PMU=
);
>
>         /* Enable all PV features by default */
> -       kvm->arch.pv_features =3D BIT(KVM_FEATURE_IPI);
> -       kvm->arch.kvm_features =3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
> +       kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> +       kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
>         if (kvm_pvtime_supported()) {
>                 kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
>                 kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME);
>
> base-commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
> --
> 2.39.3
>
>
