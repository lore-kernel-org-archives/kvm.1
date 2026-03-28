Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330123E330
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774692404; cv=pass; b=RV8MLdcpkQrZwjYcy3d9xg43pXMtt23a1sj6PcBmx76JvLhF2ot8Z0IHHnx2Me1VwMn+pav001glF0j3WV0ByFRi8AuTX0wvg3l128XASSN1JgBzt2U20+2hfM72IvpTkK0ZRSVLE3P6XJhSECLZSLhlDUW3BgQAsq43HPblMto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774692404; c=relaxed/simple;
	bh=0682UY7oG+exHTPxH8DSBtqFNGltgt7shz7Wv8rkkE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlUKmOK4Rutq1EEICVo0RniOg7ZOgufyQo/SLc6VtCoKviLmvIxwwXcMX1Scy9Ug0advFq/tkE/9PUG8AtHkMlLF7F1SACT4TAQ4SHi6nZEX3mb/SDrkiuAVdCLEYM5KtG40zmj+U4WRS7/nF+PBXF01tOozMVjs9xP5M3LfBuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=nQxb+nF8; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="nQxb+nF8"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67c1b8b1f96so1787101eaf.2
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 03:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774692402; cv=none;
        d=google.com; s=arc-20240605;
        b=COGGbsZnwXB4GYkTnc1uc3idfpwrmA1z90rRXLCohlP5kwmwmORhX+jSX/I/kj+lGI
         ox3ufXB/fOAIHc9liCXIoj7yTZeQcHN+4ZPSY4Bh+1ABhptYJcoCCpgw84XW7vo1SGQT
         P2FtlDDqgiAuYxZorAZtHanD904+yeas6Fc5wp6602MbszmSx1XWFhRgm7IG1TL7LCrl
         yWSN5xFBe6y2WEuB2IRjhNEmpd90a/WO8GXLdecztVAmd0VHmTC6AVHF6t+j/b+NPXC0
         FixzBfS+NqZnIzi4fa2ZheJc8Kne+NSrm+KNW/Girr/1nma6YViNaVU0l2E2JS7ui6DU
         JdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hfk8WCjcSH9rv2rGOCgYWMqdh0uuxmNhxPE/XH9vGjo=;
        fh=GXHltEjyfky9usHfCi51Qs8EBZD2gvhOOWQeFSfvwDk=;
        b=k6v5t1dqOucPXTWUpLOGBMBbGHT53RwOGE4ZtXh7u+bsnaFBXFVOhL8xvaxCI9CaW8
         8R/4kXR+DWo+bFKHuPvvQUTaQa6HTxiNv3y8xITQP1OXBaudOmJPYIx9Ru8rnsGKb4/1
         g12yqtTlxgvEPdjtxcANksxjbyjmshFhH3vwkq9qgMEk4g725VGYInogpW88au9JNABX
         J1Z5B+nQ7eRjZcEm/8gjn/7Vtm0x0lg/PGzk2whEClPw47Rx81hiaeXiFB5yRAELmO1A
         fFTJH25GQWH104QAP9F98idlWBfLqkXcA1L8DfRSJztal7AFkuO2Gr8jvV9ERejs/oCW
         iwYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774692402; x=1775297202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfk8WCjcSH9rv2rGOCgYWMqdh0uuxmNhxPE/XH9vGjo=;
        b=nQxb+nF8eCiJEd8H8Io/jZ1+ImMONfWSunaIun0Umag5IknlkEQkPyxchU0hiY5Eit
         ZxQ9sG/+Il2WA2i6eDXckEa04Zeoo2uKileUL3RdK2U9d16MGCVSKv+YPmtZkHzEYDc3
         IEVh7czsqs62NP2iKGevhO6/vUl+zhTbNJbh48IiYj/YuZmwiinxlu8gxc+gbSLD2JHh
         qPZo7eF7hiBhze8hqlx6XUbh/arvVuMMfJNjlcJqUJfsSo90HDoUYyrOJIAptTUCtePw
         d4z2c3131nTxrdMk/QEmBvnS3kYJK4gM0SD1oqoNkhHOdJXikh0petp6yY+rU3Cibipn
         5GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774692402; x=1775297202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hfk8WCjcSH9rv2rGOCgYWMqdh0uuxmNhxPE/XH9vGjo=;
        b=ehSYajZyAWUbnvqtB3KK+dm3baVklg5nyXoS3j6JiYk1b8i65jzjtrQSTXI1rwH460
         Gc2ho/RU54yaISowijyen2KNn6DG+1CDQk+gp5DbOvZZRaii2XHEU8F952Lgks4/t37M
         05FNZwfvTaMAfxTxLvKXyXvGAeGHeaStBch2iGRnSk++Zww/CfC/sVxdMhA260JDfv+m
         GLyHdEHCJRwB+4CeeLd5Ko+BpNHVDLn72LHsMaGzREMCGwrE2FveExTdaakDa7vK35ou
         IXmZtcZ0CJ3Zd4ipRydECF+uKVZoQ7qB+ugYjbSjDsDwcBjueXguyG03st22o11Gw0G3
         C/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU8El1Su8blScM91v9HflOkxC705sd39kuYldeDUIMQTepK2CnbbSrjuojOLS70ikyMKnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALm59yVy2+JKWpMJjnkx4N+eCxInB3WPb9qfmYdq742Fnoivy
	mmFtVXDg9tIOLfS6EfqvhGOoPVUJhm8IYvI5FzxbJHW2ksXKoZz0M17bI6yyjl07YHfc9bp34N0
	WgBwlV7O5UKz8MLdLLSxyVrcyGrbZWJDMD/6f7jDV7pICcQZKFFFX6VkcdQ==
X-Gm-Gg: ATEYQzxASKqcEUCE1LTmsbTaqn0GnsDwftVdxpdHpIWkp2c8r07qo1Oo10rU9XTEvh9
	GOGQu0VZ7hIVnJBXW7wG+QI10RQIPkBVrQ2pz6KaE+p1+ZlhDwcXxTeI17kdNNphPH2AOq/dRl9
	LTTTM8Ic2PzKCDTWI/KXNIGb8pIAmq7xpQyjgvlJoBLD78zAZvj275wN/WAicZJH0v4Ymo3CfeI
	4VYVxYIOg/5wKiLn1jDORhhv+8hr72KWUG98Eo+M6vrdKsMCm2FJOeZPqrNqx/V09fDjOUjcJLQ
	NJ8wt85dx+q0C87gxElM8Q12N9LIw10gCntQtnZLOO+gJD8LznYvyw9wtUrGhrQGuoWqkTB8C6V
	Cbd3i1QNI4vC9r6JqK5YHmbMjO7U=
X-Received: by 2002:a05:6820:1744:b0:67e:16b4:aa07 with SMTP id
 006d021491bc7-67e1877fb16mr2519511eaf.61.1774692402504; Sat, 28 Mar 2026
 03:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328092157.75058-1-yufan.chen@linux.dev>
In-Reply-To: <20260328092157.75058-1-yufan.chen@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 28 Mar 2026 15:36:31 +0530
X-Gm-Features: AQROBzDbSN0ndaTo0i3wUYARAGuUJ9U0NfN66GMvIm76mGAmAZYGMorETfeVvDE
Message-ID: <CAAhSdy2uvN20G=fy4dRDqzkh_wKw9RyyMMM1p_A6g_HYYrSVjQ@mail.gmail.com>
Subject: Re: [PATCH] riscv/kvm: fix guest vector leak on host alloc failure
To: Yufan Chen <yufan.chen@linux.dev>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yufan Chen <ericterminal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 2:52=E2=80=AFPM Yufan Chen <yufan.chen@linux.dev> w=
rote:
>
> From: Yufan Chen <ericterminal@gmail.com>
>
> When allocating vector context for a vCPU, guest_context.vector.datap is =
allocated before host_context.vector.datap. If the second allocation fails,=
 the function returns -ENOMEM directly and leaks the guest buffer.
>
> Switch the failure path to centralized cleanup. On host allocation failur=
e, free guest_context.vector.datap, clear the pointer, and return -ENOMEM t=
hrough a shared exit label.
>
> Signed-off-by: Yufan Chen <ericterminal@gmail.com>

This is already fixed by patch "riscv: kvm: fix vector context allocation l=
eak".

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_vector.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 05f3cc2d8..4c2f92dce 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -75,15 +75,23 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cp=
u_context *cntx)
>
>  int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
>  {
> +       int rc =3D -ENOMEM;
> +
>         vcpu->arch.guest_context.vector.datap =3D kzalloc(riscv_v_vsize, =
GFP_KERNEL);
>         if (!vcpu->arch.guest_context.vector.datap)
> -               return -ENOMEM;
> +               goto out;
>
>         vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
>         if (!vcpu->arch.host_context.vector.datap)
> -               return -ENOMEM;
> +               goto free_guest_vector_datap;
>
>         return 0;
> +
> +free_guest_vector_datap:
> +       kfree(vcpu->arch.guest_context.vector.datap);
> +       vcpu->arch.guest_context.vector.datap =3D NULL;
> +out:
> +       return rc;
>  }
>
>  void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
> --
> 2.47.3
>
