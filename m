Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291294C67EE
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185092; cv=none; b=fHNHjSXz7we1SsUpskameulNPnuePOopXNhsPqvuwZfl435H6eVh8oC6a2KEVTFi5se7jlpKNDU+x3SbUws99khVfmepNaVR5dvI7UBq/rS94Sp7Pmtvo8PBBBWInR1l6fn58AnWX7OiENowwMPd8N2N63PyzNfpIa+sji0ULAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185092; c=relaxed/simple;
	bh=xLPhcn633UxUUaKC4vzFrP/xR7wwEy8KtFue6KjCb3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRU1544CZqrkNUpOfc33RXcf57aIg76fCPk/wBUfj6E1iiPQADVbmqIL9lhod/5DjOuMvOJRPckrXBkTwBSjhBuugedqt/fCSEK1MRB9A3z91Ms3/IBu9PF/e2S20QhaCInCfV0sZrbAJNHsWZ+JkziF1nCc1XY8GSt67Fl83wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihUF8/PM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihUF8/PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D978A1F00ADB
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185089;
	bh=FzX+10cDhmW0hwDmYTE7152l7j2EZIR1C4UvMnU53IQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ihUF8/PMhzJeYrYbYKKZ3CfldjIAWfS3HvzsSf8nZ+5ZJjiOMfRXL7l1UL7Tm5iG9
	 KAcGlkommNiNTV8j2LwC30aNS9gTJgxIws+2EkaRj2H4gEMQBYNccMi29R+7wOK6t/
	 exg2oyr/uiQTLGz075cO8aOKcw94kMi6swAJtmwGNg71cZ+ANghZu+XRtG6rH7lQ8e
	 Bl6v/U1GE7Kl5yfKB8qS/PB63f7piUoz+byXfI1H434K33nJn9t4ctIDLLKm2aSZ9A
	 ltj0zDcAq6PKhVWrw7tBZOlA0hITVoVD7qRwU9vJgsBK8J7baN40sXmH7LecPvsAyk
	 3nYsJgpwgka3A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c252e703fa3so519472566b.3
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Royb0fJE/Y5TDgEzdlnkwVgLsDrzD5xWtiBCCcjmnhEo6YyQahxpCCe9o7rOiU1/Nsw83U=@vger.kernel.org
X-Gm-Message-State: AFuF++ly5gNPWJaIQ3TX9BEmrZx09HHD+lSMA3Yx2zyrNM4hS3GPgbwD
	3l2ReXVubm3aA6eh6md65xJx3SqBierpU5NJNvnQZcNwe+YPcfUVJ/9BejvnmW4nLYKvirVM93c
	RYgXOgSit+wslHg6ZbkTFoGzlslBPkV8=
X-Received: by 2002:a17:906:fd84:b0:c25:9102:fa with SMTP id
 a640c23a62f3a-c25b3bcf4b6mr53883166b.8.1788185088429; Mon, 31 Aug 2026
 07:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817123918.2738447-1-nagachaithanya9911@gmail.com>
In-Reply-To: <20260817123918.2738447-1-nagachaithanya9911@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Aug 2026 22:04:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5eaFd9t5CikZA0Lhy6eVbnUBvvLV5cV7rvo42M47yeWQ@mail.gmail.com>
X-Gm-Features: AcwNN1VDSGpC4QI19ueXEEvghR72mgVgMiabqgpi1oIqT6rLIE-ia0qxu3ODzvI
Message-ID: <CAAhV-H5eaFd9t5CikZA0Lhy6eVbnUBvvLV5cV7rvo42M47yeWQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Free init resources if kvm_init() fails
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

What do you think about this?


Huacai

On Mon, Aug 17, 2026 at 8:39=E2=80=AFPM Chaithanya Lagisetty
<nagachaithanya9911@gmail.com> wrote:
>
> kvm_loongarch_init() calls kvm_loongarch_env_init() to allocate the
> per-CPU kvm_context (vmcs) and kvm_loongarch_ops and to register the
> perf callbacks, and then calls kvm_init(). If kvm_init() fails its
> result is returned directly, but since module_init() does not run
> module_exit() on failure, kvm_loongarch_env_exit() is never called and
> those resources are leaked.
>
> Call kvm_loongarch_env_exit() when kvm_init() fails, matching the
> teardown-on-failure pattern used by riscv_kvm_init().
>
> Fixes: 2bd6ac687261 ("LoongArch: KVM: Implement kvm module related interf=
ace")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>  arch/loongarch/kvm/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4b..b6ddf5827c03 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -428,7 +428,11 @@ static int kvm_loongarch_init(void)
>         if (r)
>                 return r;
>
> -       return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +       r =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +       if (r)
> +               kvm_loongarch_env_exit();
> +
> +       return r;
>  }
>
>  static void kvm_loongarch_exit(void)
> --
> 2.43.0
>
