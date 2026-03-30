Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E3386561
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859215; cv=pass; b=neXiUL8ClaghMchjFGz2b5/JMacGp5D21oLPiP++S/KgLGiLdu0Myd5nufCcS6yGYhkHu4qlBO2p0Nw15msz9KG4clzz8X6EEF4mmHytKBb/jubBXDqfa64ALhPGM55+lTgMP7OGFrYK42KO5sWYrpdcybs9MgYJtH6yY0swF9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859215; c=relaxed/simple;
	bh=jbFKa+ewHrccFkXMUpriY7DHURgEYAzQRjauuSftmmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgFSSWv8l0GXHE+U3isLMieIiNz4bWhRr20MCi78SAGe9hCDhBxaFoX4Mhedjg+isRLe/4X6Bd+7hctr1uoLajK182WvHsWGeAc/g5dFgoVsGGVTg1NQJeoKIuvePi53HKRUVDicP4rwaBOMep8Zfsfonk4eJkbYAP4dkIRCorw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=L6gOVKuJ; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="L6gOVKuJ"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67df51b26ddso2639683eaf.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859213; cv=none;
        d=google.com; s=arc-20240605;
        b=ZI7tbudBvsnDTICRJdZFQtgXcHecLTVURfU460xELfO93f9iAWW2786oyQg0P6eS+K
         xLAL9+t9hRNnZPgv5SCyBzqtpLmprTrRgOp6MOGMt1TImhPX618ne/XoRubnmFGU/bL0
         WJe8I4/R4qgGuHoM2fn4/OVMj6rQZmo0WlefDzPNwFbk/ZrmH/TfXFr+4gtpU5crVbCp
         DhfdytdTCQoTs6UEIfzmHgqNhUYJR9Sd6p/JIpxg3BTH87WSbSupJZqpc/aEJg4ZDns0
         kmqXM0mc9dnTs22XJDOBAOJm9+vCg2vjQIm7JVgFk9nkND0EOoLCcwKotvlSmSKTaOq1
         dspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=feNTViC8MFBS6AQiIqWex0bCSJJNY3jWANzumtuP1Dw=;
        fh=bP8EZjOZyhRyagNkyE3wbjQKnUxLW735Qku+/etpwAI=;
        b=Wn3GWxto/GxOJcoS8olIm+NCSXA9YSlycF224qb1/KEhvKnsNqRI5ldmL+a/MaCFLa
         FlTMw6HXYpxQoosF7rY2l+WLclFteuc8XrZExlrLtNDceeYIfknu1Bj/qpxlATdh+Dhw
         WFMAGlXcJgHEwIq9EgDN9CNFv2bceaVqVhcvFZ+4pP6PHrJNsg8hIsetscAHPle6gzzM
         mWiDUUW3RRkHlyAmsD+KzXwkxXBWU4zSRJBmVpxWS4STFyUijR7fz6d/sqVLLwJbzBq8
         GJR9O8U4JenAefX94J5Itm7ca3QyLczTI/nE6l4y121ziAGXjswEJrsunwuxGR037QTr
         V2Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774859213; x=1775464013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feNTViC8MFBS6AQiIqWex0bCSJJNY3jWANzumtuP1Dw=;
        b=L6gOVKuJzzXzlXDxQXDC+0+c+BrFOzFmO3n8kTJLXSrahbfz3x3NFzFnnORA6OKt5n
         jp3BnQbTwVvkZRScx3L7NNsZC8GM4f6Nf91Jow4e/viqW3VgVxpg03JPi/jn+bE/3ZsJ
         DdPkCbyWVEdsc7LB4Ik8021nlppwSqAf5XpfFrIoCQMDvZWFJTyXGmTQzQ4akULdLoJA
         vSI7nktHnJpKwNcaux8Omi9XKUrVrdT9NWNEUsZ8Y5nrH4ph0xSRtdHPQ/lDQvKrAq4l
         wNg2rPG/uRP7SMocpyjdEtTIqhJkzapYjGbgYvb9RI6f+vrTnofl+E8idMeljoNJ3b7H
         G9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859213; x=1775464013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feNTViC8MFBS6AQiIqWex0bCSJJNY3jWANzumtuP1Dw=;
        b=s6Dznw/zs0vzRWFM+n88tk9MS6wU5z9kF46h5a8KvtLtbaB+ZZWJAt0Jhy+Zsc9OHv
         qzExvy7PL4x8+84F/9AktBAGUmw3kcZXUuVxog55fQlhMGJLq+Zjmt0G6doJwv8KmdLZ
         h1HEpVYoEZpX/AdfQLs4iD9mu7DMWXBCMK35WbtahDq4zRZtmHn/EVrgLlUMhpXvb+NZ
         0oiAYY3J6/a5U3/wUoUuPBYn5GJRDINdqWO99t/PKV+WmOUowoA9bHj+jy2kVxHrR6YM
         gjU1J1ScamFIw8vfxGzaQTLJinNkIPySqzQYWNBwVoXUBiO+xGo3RkoLzdUmWtMFQls+
         0Mqw==
X-Forwarded-Encrypted: i=1; AJvYcCWTEzKEXwk7mbNXk+xLwCSyOwimD2M/nbBp1YHf8h7JsdE0UL1+CwZjdmfIy+DqbOgiz88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAWykWOF9IJr+C9fSvqcLmbOed1B9s1CAtAXSbWwrIDjOSdLn
	V0uypkUFNZRISTtksc0VAZA5ip4STI+sCIJYbQPQVtsg9DPbuoTrNtFZ1bmHo0CNEqx9PEUpgtL
	PtBr3+R2/hhmR4Pm5OeyqnhqLNOaB34e0E8X6uqBtng==
X-Gm-Gg: ATEYQzwiMkpS/YTutLw4bZkdbCXQJBf9woZ9hifemaahS5BkrczVQtrL28iA7lI4mfw
	JJzDGdBos3hbZsrddHJ25VKD4A8zSNj0+n05g8W3umTCHyoq3/ySc+9pQAa3fSIfXvllUp7CWCr
	9+ZingBH54MvYrwqi7moGJom9QWaYWMRmSncyNTXedscwXCD+rPNcYBQJYPB2AG6NQ/kdzn3WYq
	4UjGdkAmp9Dy0qfYEhSWFGcNdPql5M/v0fxL6rRsJoEFVRg6jZh4CVEezYoNN7PgfVNoziSpsOB
	JBGNK/a+T5+/hVd1U+WLsH26pbfPK24IKfH5ltIz/KEasQ4KlJqvd/oBkilljr0PvpzagfsIk/O
	GXBY0jsp4gywabiJNkdHY+6Uv8g==
X-Received: by 2002:a05:6820:8188:b0:67c:f1d7:3d50 with SMTP id
 006d021491bc7-67e186566fdmr6317419eaf.32.1774859213091; Mon, 30 Mar 2026
 01:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260319035902.924661-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 13:56:41 +0530
X-Gm-Features: AQROBzD8YcMhVDsongcGEG3uL_G8BwWLXwkEeCGZRFqCzB5qKwscWNn1JiDFjFg
Message-ID: <CAAhSdy0nu1kCYxo2gmpHAgdQKFSUPb36fBoUELE-LLf_BwSO9w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix integer overflow in kvm_pmu_validate_counter_mask()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:29=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> When a guest initiates an SBI_EXT_PMU_COUNTER_CFG_MATCH call with
> ctr_base=3D0xfffffffffffffffe, ctr_mask=3D0xeb5f and flags=3D0x1
> (SBI_PMU_CFG_FLAG_SKIP_MATCH), kvm_riscv_vcpu_pmu_ctr_cfg_match()
> first invokes kvm_pmu_validate_counter_mask() to verify whether
> ctr_base and ctr_mask are valid, by evaluating:
>  !ctr_mask || (ctr_base + __fls(ctr_mask) >=3D kvm_pmu_num_counters(kvpmu=
))
>
> With the above inputs, __fls(0xeb5f) equals 15, and adding 15 to
> 0xfffffffffffffffe causes an integer overflow, wrapping around to 13.
> Since 13 is less than kvm_pmu_num_counters(), the validation wrongly
> succeeds.
>
> Thereafter, since flags & SBI_PMU_CFG_FLAG_SKIP_MATCH is satisfied,
> the code evaluates:
>  !test_bit(ctr_base + __ffs(ctr_mask), kvpmu->pmc_in_use)
>
> Here __ffs(0xeb5f) equals 0, so test_bit() receives 0xfffffffffffffffe
> as the bit index and attempts to access the corresponding element of
> the kvpmu->pmc_in_use, which results in an invalid memory access. This
> triggers the following Oops:
>  Unable to handle kernel paging request at virtual address e3ebffff12abba=
89
>   generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128
>   kvm_riscv_vcpu_pmu_ctr_cfg_match arch/riscv/kvm/vcpu_pmu.c:758
>   kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:49
>   kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>   kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>
> The root cause is that kvm_pmu_validate_counter_mask() does not account
> for the case where ctr_base itself is out of range, allowing the
> subsequent addition to silently overflow and bypass the check.
>
> Fix this by explicitly validating ctr_base against kvm_pmu_num_counters()
> before performing the addition.
>
> This bug was found by fuzzing the KVM RISC-V PMU interface.
>
> Fixes: 0cb74b65d2e5e6 ("RISC-V: KVM: Implement perf support without sampl=
ing")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>

Queued this patch for Linux-7.1

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..a098a9b417ad8 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -266,8 +266,10 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsig=
ned long cidx,
>  static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned=
 long ctr_base,
>                                          unsigned long ctr_mask)
>  {
> -       /* Make sure the we have a valid counter mask requested from the =
caller */
> -       if (!ctr_mask || (ctr_base + __fls(ctr_mask) >=3D kvm_pmu_num_cou=
nters(kvpmu)))
> +       unsigned long num_ctrs =3D kvm_pmu_num_counters(kvpmu);
> +
> +       /* Make sure we have a valid counter mask requested from the call=
er */
> +       if (!ctr_mask || ctr_base >=3D num_ctrs || (ctr_base + __fls(ctr_=
mask) >=3D num_ctrs))
>                 return -EINVAL;
>
>         return 0;
> --
> 2.34.1
>
