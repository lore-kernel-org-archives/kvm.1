Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A242C15BB
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000130; cv=none; b=djz8o+YtYAURnPW7fQVOjJtnZgqRsNLAEp/ipS0s8zOJU8C9G6OXLOstpPQdSGXgd7G4PX1kVhgVlQlRBS1YlYFQA0X7BZH/JDVPSbOJX0HKsX+o8ZSP8GzxOR0R9T525ctzpkZ93GPJNEu2T+jXpt1ut/K5dESdC7WOlt5SLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000130; c=relaxed/simple;
	bh=fDZYLLwunnBogRuB/2Sm1f453rezEII4cyx1T0Gz/tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvMl+RxyCaAUcfbLywjmlDb3VxR08pHLm+ZbU6AgUqRc64Zo+OctROmLieZAWdMOId3JeIGx6KoTxsV3IYWq7tX4O7Cy0bnxDehHzoostQxlnCNyAQz+lqifUMw0kqbbfXSJKOAaPSBmHC3Cs2ucTPiRFYOeZbxt3YfTtb0w2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6AHu44r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6AHu44r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA82C1F00898
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000129;
	bh=KdLjPKzIHUquzdcPG1hqzFLZJYNlVwFFeyfwPJ84akY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W6AHu44rkBG+xTh5I9A4rgOEJ1tRC5r/7s4t1m5tV3j5HZDLR5vwBkFtdi6GftewS
	 p2bvOP2hVP0odUEa1tS2Si1LLeURnGSqWZA77a0SHKjf1DVfVq00ro/hMdPp8T/eEK
	 NSEbogFv1hSQUGKLSKFZX9OuWlr1RJ0XzXXy0LgOqak5Xop8UfmltplEdDK7GX7DYQ
	 YvuVpOrHOeuJuitG7fnG4QbHg0TiZkrA1X57idIXgjGNYowy19KtHIUODTRou+VZHc
	 YXgKJsWHAiXeDOPNiJ4IdJVEmOaaikxaPngGKY0t3+KSKXrABTl8x6u7KmCs8PHwOU
	 vR0Oy5Eg/8spw==
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb88abebdso174387a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVXJhq/5aLKxvMEI5SOCrOxhDE5MJ8o9ktcJh9Kx22RIfBTOR0Duo5Awux8Js+rydYrxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5fhbXZRBIfN9NN4fMWx0o7jHuBv06b6TDS0WUkUfWeD+aBkUy
	if129zYJTfO68LWK9BFTVeAcwyJGCXKc2Mv0KRbHObqGlCe39J5549CkN+TGRmf25sKjJBjCQsY
	hksdRexlF+C2zQB/aFuGC9XhdCzE7JFI=
X-Received: by 2002:a05:6402:a0dc:b0:6ae:550e:5a04 with SMTP id
 4fb4d7f45d1cf-6af9e2de1c3mr2645207a12.30.1791000128367; Fri, 02 Oct 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922103931.215091-1-nagachaithanya9911@gmail.com> <20260924065033.374786-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260924065033.374786-1-nagachaithanya9911@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:01:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6RRtdA0esVcJvRt6JxOvUJtQEWfE5rgC9Kn8trS_tZpw@mail.gmail.com>
X-Gm-Features: AclHuK-MPAuyMvsZ6cjNfizR-jWqAmbMpoiGUDuR9psdxzEyhwYky3ezJ5lfkSo
Message-ID: <CAAhV-H6RRtdA0esVcJvRt6JxOvUJtQEWfE5rgC9Kn8trS_tZpw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Return the actual error code in kvm_ipi_create()
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, Xianglai Li <lixianglai@loongson.cn>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Thu, Sep 24, 2026 at 2:51=E2=80=AFPM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> kvm_ipi_create() registers the IPI device on the IOCSR bus. The error
> path currently discards the error code returned by
> kvm_io_bus_register_dev() and returns -EFAULT instead:
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
> Free the IPI state and propagate the error directly after cleanup. The
> error label had a single user, so handling the failure in place removes
> the label as well. This matches kvm_eiointc_create(), which already frees
> its state and propagates the kvm_io_bus_register_dev() error code
> unchanged.
>
> Only compile-tested.
>
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
> v2:
>  - Handle the failure in place and drop the now unused err label instead
>    of only correcting the returned value (Huacai Chen).
>  - Reworded the commit message accordingly.
>  - Dropped Bibo Mao's Reviewed-by from v1, as the error path is
>    restructured in this version rather than only returning ret.
>
> Link to v1:
> https://lore.kernel.org/all/20260922103931.215091-1-nagachaithanya9911@gm=
ail.com/
>
>  arch/loongarch/kvm/intc/ipi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.=
c
> index 7b333a4a0430..80faa770c0cd 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -423,15 +423,12 @@ static int kvm_ipi_create(struct kvm_device *dev, u=
32 type)
>         mutex_unlock(&kvm->slots_lock);
>         if (ret < 0) {
>                 kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret =3D %=
d\n", __func__, ret);
> -               goto err;
> +               kfree(s);
> +               return ret;
>         }
>
>         kvm->arch.ipi =3D s;
>         return 0;
> -
> -err:
> -       kfree(s);
> -       return -EFAULT;
>  }
>
>  static void kvm_ipi_destroy(struct kvm_device *dev)
> --
> 2.43.0
>
