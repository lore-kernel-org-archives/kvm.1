Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B73914E1
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559583; cv=pass; b=orHvjWzGVFWgaDRr4Z3VqbJW0ShTrVGhZop7eQBcInSqIQKlKOJ78qyBNRr+VfqfjBpEZ8O0Njv0/dJcYovarcO+K+5ey0fj2SXKo+YlcmYpkUdJiEUdCmRgvY6kXpJa14tJxYsOwwG4hFN/cAbAZ7xoCrHt/E5xFFF4HM/3tLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559583; c=relaxed/simple;
	bh=1FqXujxKcP+T4oEVwg9Bf2k3exrrAG/yw1mfAcRgae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXhgJ8lWfWDeDqZzLmN9zWLFNx5XCl+Nb1JQd/v/LHH7YnlrcMkvywQjEQctpiwvWTVTP/tcUpl7zZlNWD5621e7sQmOgaH2rVi5Omhmvs/R0S9Cw4oplyEnxD7xr/UPkhuFLiCuBkCxlY256IxDMNzOAOPa+rYQ5zTrVvAUBdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=YzNuMuYb; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="YzNuMuYb"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e4483cfe9so712911eaf.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 00:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780559580; cv=none;
        d=google.com; s=arc-20240605;
        b=WutkfR1YoJ7HMyGzPWBtktT4nb5ZqUIfCgJgMQVtWUXCUaehanCmF5kQ29Vq7MSPKS
         oH/YN+pLaVEg+DRlLjLl52iIuS46WW3M/QLUiHCqJPY+aS9NOLmAXQzwZ925UM69iQ1o
         ojynUTfXoVNuv5hvfvt0hVPfVIaTwvVoQgs7f4HetrJqGp1Qbqs8fQpP9ONjR74AE8u9
         k2jCcYhJ/LELPkvpytQchRc6SH1Ip+nTZ5TfMQ6m50eoVpSOAIrJ5IHBtI/ndLMvm7N6
         xWIsCQtQIvGRzvbjwFjrm0eCPKduGmRTUH4TNmNBHrftplUeOWobIoqAjTx25YecnE83
         wrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqAVryQ+sSJ2qvei7sWyBycSvMmltoGs0O/9YnbcysQ=;
        fh=9eg8bZWQpHTKv/IWBJftQEK9QSXj0EihzBrfpsCZio4=;
        b=e8ex7xKMiCWBTQQ+FBc9r83COPF44a0+2VEgW4MHP1vPS9AdUu2CpVEdMLfAIh9jwC
         H/pxg3jdEstV/6atoxWQ6O3zBiHS124v1V8CxdpWaBssUnokREkW9EnTWvToZEYKmYIw
         3SZeoxJIMnCxtM9rraBa+qFa/sqI8G8oN83NQ+Q0RQH9NYrZBUmmSi5ztdJYpLft6x+2
         chZSV+umi0yyyJ13HKFzfFq0aVFptkedtpnU+fgrvaoRlTVlh8rch9wBfW61sDz78Gum
         FypQBekz8eLL3e6PxFxMoFnMCNgb1MbjEBBrwu6Bj+NQ+SOu9ik4P9X8sv9znVgLwYQe
         W4lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780559580; x=1781164380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqAVryQ+sSJ2qvei7sWyBycSvMmltoGs0O/9YnbcysQ=;
        b=YzNuMuYbWx9fx0yylKcXStFicW7S6VkXpsSvp7FLcBQceAV1nuZl5G9J0asirpPsYW
         6lAcCyAqdgm70o42jI83zBLIy7VIYhoPSVTUhadNGvfuAgldrV9Bw7ZmRhDoE2BOMMTZ
         aINzqO7RUnOJQXrZE8I3TO+hV5EySI8VNkS5h1etEi89/7jR8OTcGHRBdVinU8K0HimM
         TjbuI0EA9AzKYiiAEYXDNdCFM+c3qCOUCnZ/haFkRIjHTtlRUdzXarxZAIJzfdhVcVum
         yPYzxjki4FwEGzGtIBcjGP34aqz1ZSbU7pR61T+q5IBGCsAqfui1xvZmNnVrEtXEs7cs
         VZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559580; x=1781164380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqAVryQ+sSJ2qvei7sWyBycSvMmltoGs0O/9YnbcysQ=;
        b=GhECTXiTHCjpGSVM70FbtSl2cQHmhUywMApVvLulK2X6iERrSV4WZikkVOyxnQFjld
         B1fEhZV2tMIH3Pw+Dg18yebWHR2igrQTcpRsf3LbCtXZw8zb3iYWIZ1O4gBbfdk6me0b
         3l9hK7aylp+kHjlu9kJmyxFzdQvQr6ayC5NknNrrkP/LWCbY2lJ2UPid70B4fxwjZGeI
         st5Stt/p+K2iDJDKmPpDBB9unr/MBnEkqo1EtMlLYZt/Bpoo8eyfnt+Ba9sVPdyeqnEU
         WVw8JwrsfEiQfrILe1QWbd4J//rS0kzAJ/+iOtmkKjOrdJr1gjsajcDIb2rCjGqqebjn
         D2nw==
X-Forwarded-Encrypted: i=1; AFNElJ94bTsgqCZy90pmpO99BS8f510SMTA7pjTeTcgFh7K4MU7bqk9ao2JOBMbet+NiBWTKmj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8gBXiJ7n6myux3LKxK3Ta/XquUsT2jEtJ136lKjgU+sU6ZVtn
	3LRT4o5rd4OGRON7WCWzC6uBKvMFC/kUIbmta+kpcRsM1GJnlEsGZytmbpthDcN3wgSrTa1Sbli
	1Txcyork7nnJCl4F1i+5zj+7SkKOzhPM02ZvHs3IeIQ==
X-Gm-Gg: Acq92OFltoYu+73KGT2+HehfeXtg/0NfoyXQD/4q1PkSn0ttKKKJhsWPAyODCt9YZmD
	hXe8TNQLsOg7tKrS7icQ7yF8wu7rU7CNtANYwqnX/fLXmRs5sQLfNVdv4uNYYqfBTjwWqsrYWYt
	yoHewU+K1n7P72HNQjlJpACFAjlBAeXhWmcT+J/LmxticCkYWe8Ime2pvzOUubSEXt7gMF91otr
	+FJjb5t0+SlgME2o4H7OBJdxOmYBf7C/iuSnyyb9mk/RRkwv432+f9ze/GnmyY9XSrCyDF9kY8T
	9YAvAduskFM+Wf9eJuUqUnr+BNlLZ9n16VpC03VnYbbI1vFcZS9mRzpf7otFW3K2Hykd3+nIP/5
	727/84226YO1ruPORmiAJcNG0bJ2NyWrye9x7jeqbOLEiW+8=
X-Received: by 2002:a05:6820:180a:b0:69e:8d4:28b8 with SMTP id
 006d021491bc7-69e590bafefmr1397926eaf.32.1780559580298; Thu, 04 Jun 2026
 00:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526075544.796396-1-maqianga@uniontech.com>
In-Reply-To: <20260526075544.796396-1-maqianga@uniontech.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 4 Jun 2026 13:22:49 +0530
X-Gm-Features: AVHnY4IC89pVbBq6__qpDj1Dq7LuA6tOCD1DQTi9OxR8RUuRHdUDSjYF2_D39Rc
Message-ID: <CAAhSdy2GwXZ+qDdnNYe6Ykunvoa8-okQepxBNffGMFXu0U8Mig@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix timer state restore
To: Qiang Ma <maqianga@uniontech.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:26=E2=80=AFPM Qiang Ma <maqianga@uniontech.com> w=
rote:
>
> The KVM_REG_RISCV_TIMER_REG(state) one-reg write passes the value
> written by userspace to kvm_riscv_vcpu_timer_next_event() when
> re-enabling the timer.
>
> That value is the timer state, KVM_RISCV_TIMER_STATE_ON, not the
> timer compare value. During migration or state restore, userspace
> restores the compare register separately, which stores the target
> cycle in t->next_cycles. Re-arming the timer with the state value
> schedules the next event at cycle 1 instead of the restored compare
> value, causing the virtual timer to fire too early.
>
> Use the restored compare value from t->next_cycles when turning the
> timer back on.
>
> Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
>
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index 9817ff802821..ae53133c7ab0 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -231,7 +231,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcp=
u,
>                 break;
>         case KVM_REG_RISCV_TIMER_REG(state):
>                 if (reg_val =3D=3D KVM_RISCV_TIMER_STATE_ON)
> -                       ret =3D kvm_riscv_vcpu_timer_next_event(vcpu, reg=
_val);
> +                       ret =3D kvm_riscv_vcpu_timer_next_event(vcpu, t->=
next_cycles);
>                 else
>                         ret =3D kvm_riscv_vcpu_timer_cancel(t);
>                 break;
> --
> 2.20.1
>
