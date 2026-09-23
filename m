Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5638F25C
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137234; cv=none; b=cFDQeGqqVCR8XhfYKTdalajpwc7mRahnlzIhtB8J0QwqmXJUb2x3dxebZgjvHq76kvZcKx4fEPeAPZ1qGrYTG66KnSzsvLfBOOsDLFDqrs+PJlNJl5do2rik+sOyY22b5MC85QVJVfuNKPJA5Du5vo6CrMEElpF20kDhhS2roJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137234; c=relaxed/simple;
	bh=kEXCmh5KjACa9jlo2r6L+uwToMUdSFNrNLsT/1Kvc9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7jqqyaceaqZDAeJ4R0ZzGmk9q4+dmch/36LmgvALUWwiWsy822nJ8H+W+XjYkQeZhTvwmqD9TYoEG6KgVz4ZRem8a9DhcK6iiRRzNMjBaaHB1MaZR5Mg/Avm5dHtOK4qZe76WClI9oro3Bwu/LaDvB/NUt5IFixfjsFL2MQYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DooG22bG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DooG22bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB601F0089B
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790137233;
	bh=xRu4IFymWzU2DAq2/pstQkXppKLOwgDVdrPuqvOzeKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DooG22bGzqj86xMITRCYrjpoW0RFqwnABVByxGQ4CZVPtrr1cDx9NkNBBxF0JPD+M
	 Hz+F510Hq+9ODp+qe5tuF6anjMWjWba7hM4kjWuyjI605r6piR319gmu6NBtQ598IK
	 4KGwvAUnyJmoBMNXXk47eDermkyxmW02HOsd/xKwBZE5Hx1B/nKy/1336M4+8Bkf4I
	 gnzoFVhFQiHvWAsSTDlGM87AKN5fPjgl8b8d9FcBMtqoJcQt/esafLBle2kznTaEDK
	 FTw+H35H2zo5rnEvQrU9vqWIDWNJVayesSaOWMSqUQ8cIlQ7m+RmwbVZHuILU1OFaE
	 fNCeb6HGA/stw==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056be4d2so393197a12.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 21:20:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYsTCxoLiLpC4LazRidRQEL1MsO/qWRXZVfSFZiVWTQY/4kz3yR/NeR/WPUgEy/FYR0Ak=@vger.kernel.org
X-Gm-Message-State: AFuF++lkYS0SS3/+FOIs17JjUOAHVIMrcDrR4sCtoXMFO0O2CD8EKSqt
	VRY7wkvuGP76opNjXVG1gcF0/KMJ79Ngpv6o01Q0qX8ZapRBYNU/8/Kr6ZyVYJjsgiNMa1cAioq
	yaPjLWFQNP6wxUKl58fQI87tMbjfGMAU=
X-Received: by 2002:a05:6402:44d3:b0:6aa:aad5:9cef with SMTP id
 4fb4d7f45d1cf-6aab38337fdmr966870a12.6.1790137231703; Tue, 22 Sep 2026
 21:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Sep 2026 12:20:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5toptaidoEvkuSeqg8ufSOcMxNqO4nXUOcs=7M7MwivQ@mail.gmail.com>
X-Gm-Features: AcwNN1UCQ1_Q9X_oEYpqr3iAEWtLdmB9_bsmlaQaWqFXwc6YN0IFf1Wsyqbm3Yg
Message-ID: <CAAhV-H5toptaidoEvkuSeqg8ufSOcMxNqO4nXUOcs=7M7MwivQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Return the actual error code in kvm_ipi_create()
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, Xianglai Li <lixianglai@loongson.cn>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chaithanya

On Tue, Sep 22, 2026 at 6:39=E2=80=AFPM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> kvm_ipi_create() registers the IPI device on the IOCSR bus and jumps to
> the error label when that fails. The error path then discards the error
> code that kvm_io_bus_register_dev() reported and returns -EFAULT
> instead:
>
>         ret =3D kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BAS=
E,
>                                       IOCSR_IPI_SIZE, device);
>         mutex_unlock(&kvm->slots_lock);
>         if (ret < 0) {
>                 kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret =3D %=
d\n",
>                               __func__, ret);
>                 goto err;
>         }
>         ...
> err:
>         kfree(s);
>         return -EFAULT;
>
> kvm_io_bus_register_dev() fails with -ENOMEM or -ENOSPC, so userspace
> creating a KVM_DEV_TYPE_LOONGARCH_IPI device is told that it passed a
> bad address when the real problem is that the host is out of memory or
> out of IOCSR bus slots. -EFAULT is reserved for faulting user addresses,
> and the remaining -EFAULT returns in this file are get_user() failures,
> where it is correct.
>
> Return ret instead. It is guaranteed to hold a valid negative errno
> because the ret < 0 branch above is the only path that reaches the error
> label. This also matches kvm_eiointc_create(), which already propagates
> the kvm_io_bus_register_dev() error code unchanged.
>
> Only compile-tested; the fix is a straight propagation of an error code
> that the adjacent kvm_pr_unimpl() already logs.
>
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>  arch/loongarch/kvm/intc/ipi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.=
c
> index 7b333a4a0430..672ec053a997 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -431,7 +431,7 @@ static int kvm_ipi_create(struct kvm_device *dev, u32=
 type)
>
>  err:
>         kfree(s);
> -       return -EFAULT;
> +       return ret;
Why not remove the "err" label and return at the "goto" statement?

Huacai

>  }
>
>  static void kvm_ipi_destroy(struct kvm_device *dev)
> --
> 2.43.0
>
