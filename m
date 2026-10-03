Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13839FCB1
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791019176; cv=pass; b=PgxkPOlaRWnRwzAUJBlICFplEXEMAYF9SQ1dYNp4xMMpno37+LyPlyykFzK/yPr+Pm+AmORExvBvR60EY3si/XTT6uX5NL/VvD9W/t2p5HRgj4QH0aztrz2j/TrI9Pht5NUC35sASdzUxzUTLXLMNFdqEcbN4cRzWJkk1GJOIVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791019176; c=relaxed/simple;
	bh=HYD+ToqudDpuaRtSe0fMMsQ+LH+7S828nt4GohMs2Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grazSE2iRWGT5UENj/QE2ajy09luDekF8ZKWmwoFT34gkWtTIpOwqU0ZATxvRnG3hI33eOAtSiC6ikRDfICeZyOKtRMshkdObtKOMW9AMPN6YMIAPLlI/3OKDMo15rB+H1XjqT9PBPOtoQBgFttUbb/YWmfuE2DVieKvQWf1KNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=sIJDf/JN; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="sIJDf/JN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso137664f8f.2
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 02:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791019173; cv=none;
        d=google.com; s=arc-20260327;
        b=rNkaB+aHCLipdczAzQMzqLOc3V3w/iZldB0xRA7J1PxuFlJK0ysLIhfZ+4+hiMzPIG
         sfgBb3N47wlvrNTamMwz8udE/V4UL01sNQKPSFi23BfUDQGJuqZ9efQHnUk9OFGhytXa
         DcmVztcwPJ+6P1VmMnbYHozj0Inm5g4Xls/kktRVbCxPIfD4KtEqGdO33JckRPDNVRy5
         x0g1IXW2onK+sK2yPJisBj9n2Dg8WZRF4usGmBFj5F7hMMXNakPCAmzCj1L9DjmFauCj
         1EBGpRN4CZ72C4Z1xlBmIPgp4NBt6UQZlu3rtDtQIg2xFiqrRcOK9sUa2sdcyaPrAmxE
         yGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCYMl+WZz2TETrAyEjwYvYxJTxXlvc4VUXVoz9zxqJk=;
        fh=PjOSH+YZY/WYfbqpZcbepaALi08sJf8RUpMofzWnYyU=;
        b=ZJ5LRN+MZhzTYhOVgUoCcOrJOnOrH851/QLAVME12VuCUXAAXdQu+a0VqytuvT9JNO
         1bs8eY8j4jQj4Uksg1wyQRKlp0lZU/A5hG/CAWKuHP6spSmDr5jPppyg6NFM2QRYuXVl
         Lp/oRgmVeLLMDSALwh96jqQGaUYiPKRzn0i7iyft+o29gQ4vFLtDf6uwZ8/8DigQA7r4
         w6OQkBplWt7yNnJHgNvLhqvz0i6+em0L29ASCjwARRcB8/ZPglDIeflGpb6QjWw0rCdY
         fvNE1DX26AmDH3lukSvJTRZ29SWh+L60R5pEoiWuBCcvsVqzOadCjJ129yHQuJ3ik9sI
         MMqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791019173; x=1791623973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCYMl+WZz2TETrAyEjwYvYxJTxXlvc4VUXVoz9zxqJk=;
        b=sIJDf/JN2j3oYORqZOoEvgOeOyoUm4bRRGleo60KbKkfWR5BVcvHftxTiXIRGnMBvj
         T/VNxI4VZUk7OHxKrK0mywli3aZDmCSY+QPSjHoXN2nEQEXBSbqcFtOnITem/rnxt9MW
         WaQUks5L5Bd6L0RrvatO7bOVYIPGdnlNpa2hEvMD6F8V6eahA00jQgtDyRgDdQvtmIIJ
         xWOHf+Br98QOFxzaxfNmE3aKfLRJ2AD1wNgkV3bmkaTcmPNZ07r856O9Ql33YaLU1aNS
         S9CjVW047HUol1ZS6oQNvPwP38RG1AW058/OKB6m8GB05bvSLUz0oquGpcsupkezbPOe
         HSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791019173; x=1791623973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCYMl+WZz2TETrAyEjwYvYxJTxXlvc4VUXVoz9zxqJk=;
        b=sY+CjLq/Lagvu9fFfZYb9nHxjkEGm8WU5u/8vll7nqVCUmo1bpSLu2b18KiH/ybNQK
         SF1hwAuJrypwecIXY+o3IE+pcv09z1/9Pq//6JXLVCaSRpWmQhcd322gVXjFyy4jdlTA
         IBqa2iHKhmESy05Cmitw72G/cGkVDi6V8o6+fVPug0hch7gcNIIYwtf+XAAbfjynztNC
         77Ji9Jas7iK7d5PfLv11JDD53hRlY89Qi5vxWEvIqHfe17oVpaX4biJlIzU1dm01iimL
         8wFdFzEauS7mMqTM7BRSLTf0FzEY3J8Sjb1KWvwoqqRvVGHNwxVYln07dXU2HozjlzH3
         tnPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm2KrXd2s5M5HIRSbRLCJ9azULq0O/zfXUTc02CjXwIqIgttaYNnIAw7XEG+WNSSAybn4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN6CH/K5puvxurgN9+4OfD1T26UrFQAOR3kx/kX0CTBb9hPIRp
	3om1kKTl2tVcXQ2pL2rKA2daWy6h6bmuiJaPgqUzHH36OexmhwxrHE/532HD28a/z4JsmBt8fn8
	n8JFX2Fnsowpb3HQia83jxYzSbnSU5qlwSRiGcgJJkA==
X-Gm-Gg: AYBFou1kRStOW27W9cPl3D4f4PKuw/OZEuBR0/nKNEsb/62GQBHy06pRilgsb5me5XQ
	tgBT3MNb0UMOocJTxVcx6g7Rl/cSXDczHui+eaHm/pqhpNtWdC9XeNmzl8rbhKAIFuAlsHDb60j
	Ag2wZVP/I0VqKPEDN2JZ0YC8DZqNUMyVjROdhj/UbkHeMiRcfMs5WRqq7Og7UX+3PBVlw2R1JDH
	uKAgSood8eQvylohYUJh2Kd+BvIWUovOoJ2cOBWDAT/62119F7Q3G3PbMIWtCWaIOaA0u9+O47z
	2/M+pX8fmonFJ74RdUVrG50+ZL6n29FMu58D/DZ4SJ1G/05eTbpiFs/2V9b1v7oW1moOvBNJzqU
	iWzaJ8TKAK+6hxqws5L5vi0O/4UjmRv3eCT7p6Gn7vTgKEv6n/uzRGWtzNf7RQdv3a72TFhnSVx
	A=
X-Received: by 2002:a05:6000:2289:b0:488:8546:d0b2 with SMTP id
 ffacd0b85a97d-48c48023a32mr2361761f8f.51.1791019172398; Sat, 03 Oct 2026
 02:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814123541.593613-1-jinyu.tang@linux.dev>
In-Reply-To: <20260814123541.593613-1-jinyu.tang@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 3 Oct 2026 14:49:19 +0530
X-Gm-Features: AclHuK_Z0ksFSJd3YPpKJCJ3vTWpyr047A-VUpiGpFpHWBI599qCSz9eVjsltbU
Message-ID: <CAAhSdy2TuVK==x2Ewj_yNhG=MkYx+Lrha8aPFA=ROociaG7dGw@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Avoid redundant interrupt check for pending timers
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:06=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
>
> kvm_vcpu_check_block() calls kvm_arch_vcpu_runnable() before
> checking whether a timer is pending. On RISC-V, kvm_arch_vcpu_runnable()
> already checks all pending guest interrupts through
> kvm_riscv_vcpu_has_interrupts(vcpu, -1UL), including IRQ_VS_TIMER.
>
> Drop the repeated IRQ_VS_TIMER pending-interrupt check from
> kvm_riscv_vcpu_timer_pending() and keep the helper focused on the timer
> deadline state. If the timer becomes pending after the runnable check,
> the timer path still injects IRQ_VS_TIMER and kicks the vCPU through the
> normal wakeup path.
>
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_timer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index ae53133c7ab0..0e01bd793772 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -132,11 +132,7 @@ bool kvm_riscv_vcpu_timer_pending(struct kvm_vcpu *v=
cpu)
>         struct kvm_vcpu_timer *t =3D &vcpu->arch.timer;
>         struct kvm_guest_timer *gt =3D &vcpu->kvm->arch.timer;
>
> -       if (!kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t) ||
> -           kvm_riscv_vcpu_has_interrupts(vcpu, 1UL << IRQ_VS_TIMER))
> -               return true;
> -       else
> -               return false;
> +       return !kvm_riscv_delta_cycles2ns(t->next_cycles, gt, t);
>  }
>
>  static void kvm_riscv_vcpu_timer_blocking(struct kvm_vcpu *vcpu)
> --
> 2.43.0
>
