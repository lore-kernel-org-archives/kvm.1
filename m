Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292523FFFAD
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944213; cv=pass; b=saqfrLtnA3qB3rOFEymbc5AzJGQW/tfvfi5hvPwT9aSqHXzFRK+dRZ3GoMUVfrNuWqc0ORCgLZYaq1JNycqs2avC3QnAFydtF8TVU/gT4KCoigdcP1DhHYeOSwFk6fmRdH1cA6X/LtnRTVKDtDQPR0nh9wJEPQXWZKH5PiFiBEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944213; c=relaxed/simple;
	bh=iXiq5+OnroxJLh5+bVgkbdIJL794NQvCJgWYipCDuJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6JlzTZ5vHTLAMvXtWIH6w2mQcfGpl6Gnmd5Q2nz3LL33FWyG3vtjmCgluWt4/1Ku0X9XB1sA1YkznVFAeM+cplj5eVJ/FxWyrhv8d4CjjraJL/xb4TiF3I1oOlJtFosXL5R/0CEawXw9c5sgiFO4GyqYsmufftupv3trF/UmhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=XVdK/VzB; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="XVdK/VzB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f60208a5so26406815e9.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783944209; cv=none;
        d=google.com; s=arc-20260327;
        b=fkhWxyFppkZEBnwYUJu8xLodnx7GABeO4mN0iqUDYdbyNj8f0cGS0WfXEmvtkvLF1y
         hnoPAOZXlGudTzoysjFjgVe39Rm6KT6TGCRcT8lpisirghD3T2Z+uJxQQfJwUGMKP3nF
         zSB1/hMk31lf0dy7vrlr9ui1fLzo0U5vKyRpQ4TUzqF6k3OY3mhNpf2ytvkclFfy+UZo
         fXlFa9XWran5wsT8U/6McdE23JOjWLnR6MhGSsIr342GrU6EfTkg8F1o6wSYEdSQdXVM
         Q4pe53np4rN/4hTy/kcpJ/cJqs9eFE3FaE9Lt5nXxriqIYC7b/wQvKprNIuoIi6Oxy97
         RxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oozs3eFC1FFs/wCU61IvN3QW98PJylYyvcgjFAJyGPk=;
        fh=j6stJj2//xurfpcgMYb1gtiXBSr5eG/oxpH5JbyvCp4=;
        b=qWVTVqOAspyKOI+rejJ2sjzZiz5nznGev7cyr+Gyz/U0K6woYjkIix98owRNhO2ham
         iWgfIUVHEbQFAFJMPR78cn5xuKT7xYodxic+QOlLBikNzd9OafTodhGtP2zGl5UmS9qV
         cUbnPKaT1OPXqi27N3XWDeuxnHikknAXRGCQP9YcZJ5WTsbFFW/BrkB6bUummgjFpVsX
         SVLF5rxjXhWccm5jm9gxHxvnQXJ3+GgIbxLN1wg3O8vMgPfQDvlcZNyXVyUqNqqDOGFL
         cHPaZLbZmkgZ0cp+0+jHGRLUopNIEkIXasaAgexFzQUAY5t38atnXGPzFXGQTYoVYt+7
         eR7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783944209; x=1784549009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oozs3eFC1FFs/wCU61IvN3QW98PJylYyvcgjFAJyGPk=;
        b=XVdK/VzB3sYcIira/Pz8vwtPquhA17mgtC0ZxP09sOyJueidrUwpoGxldxpd9DKZUZ
         Qbk6N+UqLnQigeR9XJ6QlBsM0hc/c4CrHHCYk+M+7iA0FPsoPV0zmrUXIYHpwoXuJXaz
         6iOmpvHrGhYvM2xoWA7DmFyXclW8jFJ3be6LzZzeWvE8srdTfoBWzBpLnXJT7RZDggkH
         Q3UmHDXjsCoAwNo3U0ioNwYE24/OkUUzskSnHAI++EBOgWu6jrgKHRUARwsZfrn9fGf8
         XkGbRbnmOKiHLHyHmA5DTrM7RmmRdBikHEW17seYlfkovxQ1gF+FkDG7Eqgb3Jzux/Mg
         nWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944209; x=1784549009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oozs3eFC1FFs/wCU61IvN3QW98PJylYyvcgjFAJyGPk=;
        b=YSzM7kPLM3IQbQRyUIZPbTpJKL9CUWNaud94i/VfnwLJUelQx/1IIgeQ8HasYzt+kT
         royvSKhoUaXDOF9iKYm34uebbmgyipJjDmfYq8mJFwK0RCM9m9z0xPPNVkMgeyz4pq4g
         yyEaTOwTDQ9Wa4Tr3qaobtGaTm51NZu3d5rx4zh3L/wc2nU/319moO08rDPV3qsEHGOn
         HwKuSA9Sz8/hZuk5aLkH8UCUSnsyQqAaMe/vG9/SEUgedMcon0xYM96wY1YHr9ZuHOOl
         qcF5mQs6XVmiQsTSAlIDc6jKN9X0E7SzAjT1TazXd7nIoRlkBQ6aRyJNA9cQlMH+1yKC
         oVdg==
X-Forwarded-Encrypted: i=1; AHgh+RqEmFxiUQrqhsDYpTtkbKfmw/BD9W+sit4KqWJo4sDSOjw4Dl1Y+zxTu6ZOXuEeJokyZpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2UXUydas3Fm2QLaYfBLYvtUCiVDThiIVi8HsbMFMSfyuxB3R
	0g+vk8bBW2aWbTC8MLZKcogblSuMqNza9QChchkxGSVBFvXHnqd6k0pEOsFZ8xh0ayEWTG8WC8h
	SUbdxXAOn0kA2mUHKbBZzJ4WKNAD28fwu1oP5CsYVdQ==
X-Gm-Gg: AfdE7cltYtvT5RIBeweHJPhx5kC10EW5PSHFxOgbHqJt98UqlAOeT9eNWRqwi0eVLT4
	zX7XvOZ6WhOmd1paICMstmuC0rEBqldY38YuyPnE432NTM3cwIEB6LuWugI5pqV98Mmq8dAqPWY
	ESLu1YSViZOerhxlDLFi2/OeHoGWypqr7aICpzsk63qFJMsmhIr9jA+H8lPEOVDeH4RPdTv5USy
	zBdM0XJEMj/YoL0VniY5jA+uTKg8T8CUJCANrP34elr+Rs+IGtnU4WAhHJI9cFq4J1WkSIE0YMz
	ReFBdhsKuGpzWJX8gZ6PkxEISI5YHf4FaVPJA2LXZG3OWL7NvKhICnBgUb7BswdhSwsf61bFU2R
	+OM9kt+Gj+HNmf8KvZcx6iS5Qhw==
X-Received: by 2002:a05:600c:468f:b0:493:df1d:7488 with SMTP id
 5b1f17b1804b1-493f87e5b4cmr96665755e9.16.1783944209169; Mon, 13 Jul 2026
 05:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626054051.3360865-1-shengwen1997.tw@gmail.com>
In-Reply-To: <20260626054051.3360865-1-shengwen1997.tw@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 17:33:16 +0530
X-Gm-Features: AUfX_myWpn2AvfXbvMGkjx49S1JKE-8WzmOZBUvjQKodn67rqUdZl1K_Gwiur7Q
Message-ID: <CAAhSdy253v97ivo8rx9ftnAdYaQs6zmjaJ+yRnk6x-Kt7Xm_XQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG
To: Shengwen Cheng <shengwen1997.tw@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 11:11=E2=80=AFAM Shengwen Cheng
<shengwen1997.tw@gmail.com> wrote:
>
> The PMU SBI handler passes the guest argument registers directly to the
> PMU start/stop helpers:
>
> kvm_riscv_vcpu_pmu_ctr_start(vcpu, cp->a0, cp->a1, cp->a2, ...)
> kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, ...)
>
> which map to:
>
> unsigned long ctr_base
> unsigned long ctr_mask
> unsigned long flags
>
> Thus cp->a1 is a single unsigned long ctr_mask, not a bitmap array sized
> for RISCV_MAX_COUNTERS.
>
> On RV32, RISCV_MAX_COUNTERS is 64 while BITS_PER_LONG is 32.  Using
> for_each_set_bit() with RISCV_MAX_COUNTERS can therefore make
> find_next_bit() access bits beyond the storage of ctr_mask on RV32.
>
> Limit the scan to BITS_PER_LONG.  The requested counter range is already
> validated by kvm_pmu_validate_counter_mask(), so this preserves RV64
> behavior and avoids an out-of-bounds bitmap read on RV32.
>
> Signed-off-by: Shengwen Cheng <shengwen1997.tw@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb..2025b6649 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -586,7 +586,7 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcp=
u, unsigned long ctr_base,
>                 }
>         }
>         /* Start the counters that have been configured and requested by =
the guest */
> -       for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> +       for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
>                 pmc_index =3D array_index_nospec(i + ctr_base,
>                                                RISCV_KVM_MAX_COUNTERS);
>                 if (!test_bit(pmc_index, kvpmu->pmc_in_use))
> @@ -658,7 +658,7 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu=
, unsigned long ctr_base,
>         }
>
>         /* Stop the counters that have been configured and requested by t=
he guest */
> -       for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> +       for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
>                 pmc_index =3D array_index_nospec(i + ctr_base,
>                                                RISCV_KVM_MAX_COUNTERS);
>                 if (!test_bit(pmc_index, kvpmu->pmc_in_use))
> --
> 2.43.0
>
