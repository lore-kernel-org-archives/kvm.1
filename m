Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AF37C918
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110527; cv=pass; b=GywGF13/4hVTtSZlZlmiQfxN7X0VPzzZFFMH7Q5Ac7OqAaPiX/qHNh71vdbz37o4xC7pZWj6xrgvCPK6JBzLsWnSCINk9Q5kL5CL3MG4CvZi9g/gzhN6YJjaYm5arLXAcjEaCGHh1DPc6y5Ea1Sm3V9xHH2mSlP1BC8Pf1B+Sjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110527; c=relaxed/simple;
	bh=wEtRPqU9HxXUvSHcb3pYO+UB1Hmvw9jm3vgzgMrmPz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHIozmn9IYwQYt5mrfsGDrHFwVtK2/Q7yzK0s0YAXsAd8xfQzMwjXpnSU44AuxJW3BDfpHEZcAxQ7+BXODo4cHs0ovSuwlgXQxV238IsPnjGiNoM104ticNePgUZ16ioMbhY3+QaN4+9AAY6/OeWvXdNxro39d4llH46WyRfDnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=jfoOPqEj; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="jfoOPqEj"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c383f2fcso515845a34.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 23:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775110525; cv=none;
        d=google.com; s=arc-20240605;
        b=BD3G1KEL27xEv8/vApj9zY2L9fNfDhOG0AsCzTL7Jb7Rv/hO/qsfvyrbqB9WRlTLK8
         /PlBdG+/GxnInMvKUGGKZkA2azg+HEgvlwy41INkywZyNR2i/2jhg/A2zhJ1IWvz/nXm
         6VgQ1CGuwmxFn0aK8I+JGhamsN7YYl6pGHbrA6mPhElCY+snlQinSHwsdYpAYRV+eSAy
         5kWFNazvxerrj6jSGB6TIa0kTwKYKUbfFNKzi6WJ4grlVeDohSa0CcncxfVrkaJLu/Lt
         747FUMtAgUXw5ixjUJym+rQVMeelOsOwI27LriVDnSQ58WPBMXBYJzcPFUg4VMuGWISm
         lLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gmm+ZuAZEoshHephNI5x+CZdRU1jdbvaZcO28wZCH1g=;
        fh=ssAQtSvfxo+l1oP9bnaOXjO0WOPYtBjyD5g3UIxGOjM=;
        b=i15oElE86ZQ4YziFfJP9Doh4m22GDnR+DzsmJJiUt1OffDAxcJrPIlK9WNU5QzS5NP
         q2I3sCk86lXnI0lO/p+FStRA86L1MnjtVgoVW9I3SnVCd2413nsRaYvBASFiRbDrCuX9
         qrSaS1smxnjISlZXstjfhPAx/whWiO/68mfos3RpS44rU7zz/lnwOh9tVF85qnF8OpGu
         +W89eFMuTwydfyBgCkJCrahAY/mj6FxD09yZqNKoWeUCdo5G00SfLzQ0vwZ574PZEJ5i
         dchvuxkbsqUY8Ty6kPgS7P2udpc0LjromzS8F0zbstf+YWAtnlpLFiGwKmPc74t7TivD
         Dhug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775110525; x=1775715325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmm+ZuAZEoshHephNI5x+CZdRU1jdbvaZcO28wZCH1g=;
        b=jfoOPqEjlPBSss8khUFMpuLAvHt4rDWfiwPA9Sqo/9hNgrKzka2TiC9rxSq8lCfY+7
         gz++PUemq6xsgHe4ieo3CI4uvvdv6iUpE2yjStHlqqYZFYFY/Ck44tvn17+WD8UFc9dT
         32aG/R5QbQo0Rv9OqjFZs8b2uDtTR0Hp+f6zcTHMacrwEhD7w1Ki40if02J2LcCEgxZh
         c8IATeWCt5y/ZRm2y90I1UWE/RcAYlpRtK7YkF7Fmcbn5W2SAl09Sm83Hre8URRtxkeO
         pLL9ApA12q6DwNfuIJsj7QhTJ3uPlrnXhz40bn4IlnWe81w9MqvFbu8DExuHXJmNVjaX
         QzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110525; x=1775715325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gmm+ZuAZEoshHephNI5x+CZdRU1jdbvaZcO28wZCH1g=;
        b=k4CN/ekJbEMG33muYGJcbMT91f+f4OBqAykPW0onym99ZcH+xmRb6cHxilqasKlQgm
         Uyl7NMmLmr6KUf157CW4q6NxIncz1U0TOnZ3A++piaKpsRAXLQctC8ijSPcKmQNZE3bl
         nU53fAE+9NL4gTpZ45gvqcREgu0Kegb9Xeo6TDzV72MTPTEirCLgShvgHgKTNkVU77ti
         wc6gzNBiFje8ZwSJOMM0KZcKGNZylQ/37CoL+TWV4/yxIy17x7e8N7H/8Ef7cH21lT+6
         PIzrO/ZQPcH40J8d69cV2a5SnHqfJClA5I2HegPtJ7jjycm0A4rLjz2B8wYYW7lcPZ0o
         HxkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTgT8N3TA/W7WNLrLxNp3MqSUMCx5zTkKE8fJexHNW8rhEloH7ZyJtzpsjh8amKuxpI7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVOiX58/MTdsvlgAhn35/ZCr34f92/t5MRIqOQiLUXGjChmfX
	mX6E7mJDSHv1PpEvH9Y/X6wT5mG4jOd0ZywicWB96ZQS+PrCvNvNR9pNnlbvsRdE236pOVrkSYu
	Fc7bIqiNMZP/dAORXyTsren+NPP7iSkVTiF4Ndx3boA==
X-Gm-Gg: ATEYQzwTySTLLcbaNM5Alh4FXbcb12m8MU9ADI6SQhLI/ECLV6OkpzhCixF+GYQk3bn
	cUFdFAnkq+5FB7rhiyLQ2p66iN+unPl47aGga98WfYWKAuW4qQi7vM0YYa2eCs9BUEj7J/hpOmc
	DGSGKfqC2Oi4+4h/LfNoywq9N0FJyWmyd4yH19RZKfs07AQr9dza4PqvNAdE9S+IDorFYG1KEjb
	zkIVbRgz9K67rE4YakoHhUyXTHNTjbtip6PunmH7RteFx41taF57Url4i0+0bF8iDo/wNhhdf7t
	W8Yp9ezfN04KPHanRQ3i6vfh4wSC6iL6Uguf+bVmX+reaVU9TigISFkZL+x4zxKKjVux45dODNt
	v2lUzIIfiy0Wh4BXPahmTSngEtbo=
X-Received: by 2002:a05:6820:2083:b0:67e:3c4a:eac2 with SMTP id
 006d021491bc7-67fabd0f6c5mr3266769eaf.58.1775110525373; Wed, 01 Apr 2026
 23:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy3V2kipH8sPzXkmnXP=Sh=7wwqhHaAWDyucJnytbL+qtw@mail.gmail.com>
 <20260401104902.716329-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260401104902.716329-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 11:45:13 +0530
X-Gm-Features: AQROBzCXxzxKAp8muMDJJLpwLYO82PaRHrPCQ2ylV6QJVZYM_9h4TEWap2UJzSw
Message-ID: <CAAhSdy1tN1i3KZ_EmGPN6dz=DYSfGGxeiTCbHYA3GRezFD4Wiw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Fix use-after-free in kvm_riscv_gstage_get_leaf()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	jiakaiPeanut@gmail.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:19=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn>=
 wrote:
>
> Hi Anup,
>
> I've been fuzzing the latest kvm-riscv with the spin_trylock() fix
> applied, and I can still reproduce the use-after-free bug in
> kvm_riscv_gstage_get_leaf(). This indicates the current fix is
> insufficient.
>
> The current code does:
>     mmu_locked =3D spin_trylock(&kvm->mmu_lock);
>     kvm_riscv_gstage_unmap_range(...);
>     if (mmu_locked)
>         spin_unlock(&kvm->mmu_lock);
> When spin_trylock() fails (lock held by another CPU), the code still
> proceeds to access the gstage page table without any protection,
> leading to UAF when concurrent with kvm_riscv_mmu_free_pgd().
>
> The fundamental issue is that spin_trylock() returns false in two
> different cases:
> 1. Lock held by current thread (we should continue)
> 2. Lock held by another thread (we should NOT continue)
> But the current code doesn't distinguish between them.
>
> My proposed fix:
> Use lock_is_held_type() to check if current thread already holds the
> lock:
>     bool need_unlock =3D false;
>     if (!lock_is_held_type(&kvm->mmu_lock, LOCK_STATE_HELD)) {
>         spin_lock(&kvm->mmu_lock);
>         need_unlock =3D true;
>     }
>     kvm_riscv_gstage_unmap_range(...);
>     if (need_unlock)
>         spin_unlock(&kvm->mmu_lock);
>
> However, I'm not sure if this is the best approach. What do you think?
>

I don't mind improving this further but this now deserves some
comments about why we are doing this contional locking.

Regards,
Anup
