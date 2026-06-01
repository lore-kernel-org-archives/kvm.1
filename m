Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73362345CAE
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295003; cv=pass; b=dCM1HhFwE/pHFuKc1eihlG6UF53c2xdEqVIo+LRoODWnNV9lZ39+E9hLObmIbDQWyFfjzKC11goLflzi2FOuydupyjsMlDUiCaAQK+GVcu1Q3oFNVn3p9lkHcOIiZ5LgffcTmxR/22LGZcZ8eiXtWtQ68lg4OwWyxJW0ZwdyxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295003; c=relaxed/simple;
	bh=jhd+pMhM1C6m3qD6wdhF+86tYloXhtosTeg7nQP8g5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckh7ifRkuDyXC/X40njDi8B2nqzVUQY4PaCpNHuYvkgFbkcqq/aqCnAf+8CZ5NNIKFMo8k5D/LFxfIjWrrbh6nTDZ1wxNkXNMHdei3EC1u51BIpVemDQFxf3s4zLqidTJpgjluYrHIrrEMRXytyt3iZ7PuA5VMeuUt+0+GnWpGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=b3gMLBUe; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="b3gMLBUe"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d6e5c4bcfso5610524eaf.0
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780295000; cv=none;
        d=google.com; s=arc-20240605;
        b=fgTxYcEogoDl/rcOWoducJSyEky4fFLBKp78Wbx8An+9+6iTEfBVNiF4Sl3ItG7fEX
         wd+Kxj+Pnsx7El5r+w8DBMZdnXrirHVj89VhfHl7UQyJjGzgA4aD69bCukVCJyurhbho
         LVrng2IxHvNlTQWl1bFySqSW+WYiAh9/2ZQXO40K03VpFtgBRpK/D7mq/ggNv2C1dF/L
         xS1EWOLaJ4g8SiYzjz5esV4X0PS4r8EuNSfW9P0/NkFkxfBxx1hvgGd88fRBbYItzE//
         AjBq8B/qV8CX+6u0FEFBSUmCIXb6kX4vf05RmGD9kHrn/t4+FVzEdwbrbuvM6+akBNSX
         RqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iz7SBrm1vl57dsqbfyKBrpGP7ySQe0QBEwPa7zAZwY8=;
        fh=U5dv5WLCoKQUulrNpAd99ZfRrHO95EjOA5k9wPAkjmI=;
        b=i0IwQ4NuvnLwoXHeAh6wfGNHGXb2kFWnlnXvYJIfdL/FM3UvezNT26SZh6Uvxqvm/J
         QSblTNaARkol5pePtVqiwrfIJsEQWpYzeSFjM4+IFCjc5Wo5t+U7xxVIofmWiuMkR4A/
         gmq2kk1AEPooCR3fx0BdZt410jFptsEChVaPUzVD9zRv67I4EF0rxsr04uQ2KIQnZ9N3
         Uf+CN82EPisFWeBX7YrowRClfvlMwVDrv9Gk2QY6OHyHwjJ8ZlwfL1wkMdLhSMLITrWw
         o0ocsJ1VAJOHGsGGBRgWQVIQ3BCbOsYduChqEUiD5LGC0cEqw7C3nbMLWQMXCUnBEKe7
         MNig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780295000; x=1780899800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz7SBrm1vl57dsqbfyKBrpGP7ySQe0QBEwPa7zAZwY8=;
        b=b3gMLBUekeWqyh8lxLlHN1tXrpm2aeGDtTpW4QN7/YsSCioGQOqtz4h1mHAkmq1oOD
         9dkmGpBc6MagqeJF9s+T7SdTH+cmZ5xmoDA+aYd4oyT3zW/z1P88miGp10Lu4FlJjzab
         uSKFOFQ91dB5GxPKax6uEWn7b/4DDU+S/UqTTXWZin34fzXbUH5lmKl91aUy4E+GobdF
         B2GCJpV4a8oJnQse6tmP1aMBnJY5ELS23vIap3Iasm+YPnPRRKZBk7vp5HG1MxH7wXMf
         /GrCx6HalXuQ2mZfqAH9FVj+1E+PSSqF15psdDngVaD43U6pTc4Wvkp6aIqLpxwqrr/W
         lVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295000; x=1780899800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iz7SBrm1vl57dsqbfyKBrpGP7ySQe0QBEwPa7zAZwY8=;
        b=Xxf30WrVlZCaI2DjfDDdcJB/krMmVynof+6QhBndjzN1AgqWAXoK6BQ9gkuOnoDXbJ
         f3thqFYpkkGpZk0gQkfpXxekmz46A+Obphj4cl7TFcn+oxsWBTzXSWWqtRdPVxHQlJdU
         Z1sQ+iOqwWEB6krM64xdFNqJxOAhyQWnS0qwITzI7xzkRkXxABaD3pueqB8FogFnynho
         uVLitZT98yrsrqOWtStFHugR7iotogkY09VzItL3Xpo+GF6rdK/VAe5OgtAv1C2xis7x
         gnxL/0KfPnYCNuBqStGWurgYFcAEKR2qevSR3TLeQEOLm0luADKWK3937G2VU8ySHhpK
         bdDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R/FGLgOrkvt/orGRkAz+11852ANIVmhx5/actfe9klCsaCOsX6GuQVGy5zDXwdiryfmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnzOznRsEcA94SJ9dhByHs9dcCi/CLmvdZJIuI0B7ZDp6uKY/F
	xFqOQdkP1clRz2+gC4eUiThxUHgPgwZcJ6LT/m+bvtjdKlcXKoHe0wgBm/1vhpPS3ssYoGvGBjz
	iSWPDMRk8pd76DJMHAhzep3KhM9hRdFE7uK0eU5Uo6w==
X-Gm-Gg: Acq92OFiG7mloFagKWF/GdeaAhWrsOucU+GJ55OyjXHnpqD5cMpLeSbp6WAji3HvBZK
	4ka2mkWrdJ/9+0wPtThSkv8Gq1feERx+Gd8l3yYSo1IMJ4xdG5OuJ28T3UI/E9p8w/zgVbSq8vb
	Z8koNzng5yxFeT5PkbKVtQ23S/sdqO5KE/3gNFHlHFGWXad9/0TjvM4Fo7DI1PvlkHbIJG8L1NR
	R+Tdw+RMUWIYy56GmjbcCWgex1YscGag958LVM+xDvJJaJIZLjaH+fJoNseJhDblJLZ000PsViT
	R4fwBXcvcjcdU4NGzWGQkb44DdgbT5FHjAuzTyc4oxNE/Iah8irp1UUiwFoi9MmESkrvLOVBkdO
	91pkrqqGqfQhCus/DZB2fF4eL0/mKVys1dNVgQtTLhDS8nxLM
X-Received: by 2002:a4a:edc6:0:b0:69d:9e9d:b000 with SMTP id
 006d021491bc7-69e102bff96mr4763041eaf.23.1780295000445; Sun, 31 May 2026
 23:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn> <20260429173529259zFOx-ZsqSl_DS82KLXv0S@zte.com.cn>
In-Reply-To: <20260429173529259zFOx-ZsqSl_DS82KLXv0S@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 11:53:07 +0530
X-Gm-Features: AVHnY4IK8KCCerdq2ROMJ7Vw6kUdLfOeVHB9CyJGSx470faQyO8EQ5cmziGag78
Message-ID: <CAAhSdy3W4U_wYuH_pKq-V6iP6UE7e9h9Zhv=hKLykvWpiTEGVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: KVM: Refactor kvm_arch_commit_memory_region()
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:05=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Refactor kvm_arch_commit_memory_region() as a preparation for a future
> commit to look cleaner and more understandable. Also, it looks more
> like its arm64 and x86 counterparts.

This claim of making it similar to arm64 and x86 is incorrect. See below.

>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/kvm/mmu.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270..dc6a8efde99e 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -141,12 +141,22 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                                 const struct kvm_memory_slot *new,
>                                 enum kvm_mr_change change)
>  {
> +       bool log_dirty_pages =3D new && new->flags & KVM_MEM_LOG_DIRTY_PA=
GES;
> +       bool read_only =3D new && new->flags & KVM_MEM_READONLY;
> +
> +       /*
> +        * Nothing more to do for RO slots (which can't be dirtied and ca=
n't be
> +        * made writable) or CREATE/MOVE/DELETE of a slot.
> +        */
> +       if ((change !=3D KVM_MR_FLAGS_ONLY) || read_only)
> +               return;
> +

I don't see how this is same as what x86 and arm64 does. There is
no special casing for KVM_MR_FLAGS_ONLY in x86 and arm64.

>         /*
>          * At this point memslot has been committed and there is an
>          * allocated dirty_bitmap[], dirty pages will be tracked while
>          * the memory slot is write protected.
>          */
> -       if (change !=3D KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_P=
AGES) {
> +       if (log_dirty_pages) {

Why drop "change !=3D KVM_MR_DELETE" ?

>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> --
> 2.43.5

Regards,
Anup
