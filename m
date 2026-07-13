Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C03B3BE5
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931611; cv=pass; b=iHC9yvSOFRewbCqNBbeYV/qJNQsoi+iMYoOh2Wkfdl3TZ/m2GxFRo3DddBCGOzS5OvtWOvtCH+BfdUmiIwGKrgRAoFXjHOjCM3TUl77XIHcsh0T6kG5yTMuP9RBq86sJtRWIniZRNw93TxjFSKkW27hu1wSiTY4AFqrFf7+1Nz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931611; c=relaxed/simple;
	bh=I8Ahcyx1157H3fyQeYshWuEx6yg3uTGMl/avrNEV+5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9XFeEyoRTF6aPZqYRMOwKCtSFb2e8v5KwFh3xMwuRQdykHenLqMdoUAhRqbXujD08ZWfjEqY4qL5LBOsgnlkwS+m5K8+jopAKgQ1xD3Ayn67eFhwr1ZELIADG0qyDDhP4epMy/E6EjM0/jS7DFGzsfJlEi6m8MQMbTec9lYYNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=mtHF6ew9; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="mtHF6ew9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso10454135e9.1
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783931604; cv=none;
        d=google.com; s=arc-20260327;
        b=PKR4tJvBATWYnYssLOrsEQpkvTVPsi5vR6tLmIeMi3zZqO5b5Cm5qMC5rD/UFARyJJ
         SPCL4gNle5zq/mShVj9zjq+X7p7zoncQtFWjSTyd1LlwyzC4Veg/giaQLwYsYeMoMI93
         4WJW/nIU/wz+QyMG5zXMW642cg2aov0Wgp06fEWOiJHsPsez5aqsTNjHwSox4Ptf6piR
         qt0gWTIYPSOUAfoSewg40l4MVCeNwNfpguUDbbRhZtpg3jlu4DqS4sRSPXDbpbRMCf6O
         tnwoL9wexX3N2sRpZ3n+KXHeiBjNCqP+xA3m4yg2pwncqJrO9cvHhtjQAcKAVN60fAhC
         kkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/TTX6pDKN8WM9gjZfXrDKvUiLlBJOTFwE6JKAQaNe8=;
        fh=liEKoVanTMB+qwiPZvf/QSAA6YgqcnllmDo7BBrNiqQ=;
        b=J7GFu832Ry+W3l81JavXnkfjRioxnHz/KoQOfechkYJuoYtoXB5jYr2jSpweL8ywU9
         8MTlkDPwQKwrzdurL41WAL1zofMSotgktskhgdgx1ZCbruGQniWnB1/HOrPhPwp6MIc/
         mdMs80YyEe675a6Bx+dHbXBgCd15H8Izbr/8+ld6RLr2CHa6P/oY1tngE9NLYFtXZBFo
         KnFO74cGxyKCU+wAXIhI7MbOn9ejRoqu7p1HDssGOO+7iL+lHcwM47CEAgYPd3JOGUMn
         tfOdQeWkhPcekhnEwryJx5k+47dcKOqqNV2tOWoUKUF2/jZ1jCdOTNeRUXR8f4xQTkIr
         QEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783931604; x=1784536404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/TTX6pDKN8WM9gjZfXrDKvUiLlBJOTFwE6JKAQaNe8=;
        b=mtHF6ew9oislSeq+yGMy3oWCy71NGXCQeNk8VkUGsTuEVW1DSMJedc2K6Qq3dsoZZb
         JUMu2/icdVcPUSNxbj/GwHCLPoBbBwelAOd4UxB9zzefLwV4acYT76HOkk3Bcu2VoGDO
         /OFP7GnqMdO3O1BV6jlmXskk/3/FsYEWYYxWAMOI8pvsn8AqzH37ZgTArudRxMX50f6w
         wttBrl2ckYr79qh+TQbXOjhqzDaOZ99oyS4O58bz8apzJTanARsGWIwL6v2D6J+u4RB3
         8uj7QhHQtzrQhGJd83Xv0e8t6MAIlSKlpvD6nM8hPk6wEXJog0NLlpRg3fpnDC4LPrsL
         igqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931604; x=1784536404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/TTX6pDKN8WM9gjZfXrDKvUiLlBJOTFwE6JKAQaNe8=;
        b=Dtc349K/baQ20pgiKsjv6ZQVNtSLrO4ND/aP0zDeiMSX7LLgMfgnfidEPwY+zbpaJr
         0NGFve8KS00oV61BMjGM9uXX7Nw//obSJCbJHY9zWKUqrWgBaSlC9bCqa7RY8KbRzMDK
         WH3PUd3udmdxjdCLl67zI+DYxq6+QrI5Rq4eZqsEENioBiTXFaX+qOfBzSpVBo7Pwsc/
         nRqEFbcn/U2myz8Lc1PxK+E9gUuQIXPC/p518WNxuGrLJh30MVu9TLexVZPAPj1Y/3vU
         1tuV3j14AwR1BMmFSVCgfiK7PWccRL+O4BQWxJpod8imOm34sT7QUy9fTgoUtb89ywu4
         /2xA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5pUMOJDt5Em5/CfPZq1SJ6m+IdsUC6IVt9ucq6DNzngKd1pMxXJQH80FPd+vgu4CbGAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+ekGwVqDHh47ZJFNq6s91ZAi1xBW6zu+g6sJLFPOmAWKXeaG
	omLENbIzlDSnGJzu3B4guXNxLBHMotFeNEgmpdrsXppnY/BBs6GIT78fW886sC5yIMlf5YbVmZR
	oy6Wkt4krjXY+mqeYSdJLRJzsN1qrNOcjAL5KkzrP8w==
X-Gm-Gg: AfdE7cniuC3waXS2RXVYn/OaxoG9ORFqinvRSohmCGNuUsXXv5u3STi9GpWWpAH7GZZ
	rDRrExJkKyFsoGhlyYvXfTJR4TCN3Pwk9bDJD5vdmry9TVjt0jE7Q+Ao4c5K24fIoo2G6tIqhR0
	CgsP7ps1ldOG6qPr8RfKiKVOGOE+GRpneCKDPQXH+R18d8HDOv2exgekI9lN9fvYZyqjFlwT4YJ
	UPY6aoQ1Ax8XYTrBCB/Axee+9Q+EI5FoOJaEvkKPosqlhk08ZhwHcacJGBu9xPoujJ29RJeK0ZC
	k31TVIIeUNQKGMGipa38+E1Zr8xAvfVRLG5eoFGKSi+X6HJJQxsf+udtE0UD5LaKj32Bjfjdj3g
	DMOWuG0UMsMBFAhlY
X-Received: by 2002:a05:600c:638f:b0:493:f762:45d4 with SMTP id
 5b1f17b1804b1-493f87d9311mr77398405e9.2.1783931603573; Mon, 13 Jul 2026
 01:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624130238.524706-1-suunj1331@gmail.com>
In-Reply-To: <20260624130238.524706-1-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 14:03:10 +0530
X-Gm-Features: AUfX_myLtlmicbiW4GefupawlEmm4GHGfSrV2gtz0C0tAQHCDS5effgNQRiwzOo
Message-ID: <CAAhSdy2YUuC8BLVDp53VWGnUYLShGkuWeHr87mpe5RnZx3PLSQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: atish.patra@linux.dev, cleger@rivosinc.com, ajones@ventanamicro.com, 
	skhan@linuxfoundation.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 6:33=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> kvm_sbi_fwft_set() applies the caller's flags to conf->flags before
> invoking the set() callback. If the callback returns an error, the LOCK
> bit persists and the feature becomes permanently locked without its value
> ever being changed.
>
> Move the flags assignment after the callback so LOCK takes effect only
> on success.
>
> Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index ab39ac464ffd..1342adb3180c 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -327,9 +327,11 @@ static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, u=
32 feature,
>         if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
>                 return SBI_ERR_DENIED_LOCKED;
>
> -       conf->flags =3D flags;
> +       ret =3D conf->feature->set(vcpu, conf, false, value);
> +       if (ret =3D=3D SBI_SUCCESS)
> +               conf->flags =3D flags;
>
> -       return conf->feature->set(vcpu, conf, false, value);
> +       return ret;
>  }
>
>  static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature=
,
> --
> 2.52.0
>
