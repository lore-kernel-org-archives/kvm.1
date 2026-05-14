Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A83164C7
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774203; cv=pass; b=hbzjHemztYWGVWX1OmoRFbbmyIXaBDVSjiCuD8XxNHSiFWDyzbdhn0SRhfkVq4AIu6Rf+WxCyskdbl1udh687CODi0EfxbPbTSGYEdIOH8Hxq+rw8D/V4mSSbfLoLU9/tx2YuM7aoF4UShPvP+AMbguNIiOJN4/KW2unZaCCZlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774203; c=relaxed/simple;
	bh=6v1UHBjv/DFH+0Ul8xgSPSU0jOKeFZ0m2kyYZAa6kK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLleFtwkyjRzJZJ6tgEII2Em8Wrvjay2phR62rcMQFWRyGNZUnZYDVQHxoL9La1XdeDC4qBzcY8wCqhUJ95Mu+sjdPXzmNMiXdOb8M/UNK0QxpikKpriBCkt6b4sVLUHlVIPRNBFfCH8PNoG+LtnThUdXEUI5Xl6zTpODZBcAe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=KRQl3Wlq; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="KRQl3Wlq"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-697bcc9d769so4129012eaf.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 08:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778774200; cv=none;
        d=google.com; s=arc-20240605;
        b=Ty6L2ZiL3NZ0AoiBSxCbwz0V9JDydUDveKWZIkxPmePboeBqQFJ3EfQPnAW5aW7gcX
         3c2veMk1n00kthGjxpDSbmqwzNg/+gz3+n2a32wryOt7M0D48uiu9NAZ3hNfDex4rptK
         KmmmrJl+W91BoTFvP3vW14/y3AFGll31aWwQVXpa1S381M4zZXMiOFUkr7q7L5+h1OUW
         if4bZi5cs7v8nvm8pZcBAHmArbLh+RW35616kstVgySsl+I5+PIxjxZw/cul/6dW2s9/
         K14YXBrf4spp/RBBTjNRPRRXBWO7W2KvTB0YZJ+f6Mg/Rxd6h9B9uubKhuEiMtc24Im4
         6w7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/uCT6HXYhjKb/dFCYEBtj0FV6pBWcX+E/ZnHhtNgfIE=;
        fh=v22TmrC88SJcYVqn06bntXnAjAi7EDY5VR0zZ0wQ5RI=;
        b=YK7DbM6BzrcE866QT1raBzpNiUqDaqQC+XE2+jSpD7Vl66AB5xt7oYULkiSmRcOGR1
         4ZWTZ7f0wIH7e/AB5eazKLZPkj9l2ucIhdvS/qu5pF99apmm2OehrgVcf/0GYdQo1GKb
         z7etNYzVx1NyqtxLePWgabt+zVCBdTSKXeCkFA5emnnA9s5fkwFrz/6hC2LpdKORvrFh
         JONozQ7OdOQMOIlgR/KBUgj4g5HJtbyDGJu6grT4MmFYB1OnqvTyTNswQrsOx8BfRxI5
         15h4JMjLFrJtw7wpAhvTf/eG6slRPeB8bJci0IuVrT0/8ztBkTMdCZSqx7DjbmGYgePZ
         uBUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778774200; x=1779379000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uCT6HXYhjKb/dFCYEBtj0FV6pBWcX+E/ZnHhtNgfIE=;
        b=KRQl3WlqlUXn87tuO8+Sckzu6PCBV90VFwRTXCby8usARUhdu2ME9W6yzgCGOCxxz0
         qKrbDgrMGr/5K6UryIfIWKNwp3ZqCPBgZdTN/s0lwwjOVttZ76+yGuUglRLjbccwYRjY
         4s0scdwFYIA8NwoW582CYaiU8ccHg9cESqFVwE632WzIp+OToYrw1xHfL49dhRYuCx47
         1mOkGE5dd4+xE2rI4xcjDwD9MDQlScCw2pPIz7jFYELFxAu5PyypC1vTjVlNu8W3VpRk
         LHpGmhFR2lrRRsGDGd+FaSVWRlzg4Rbps9Ow6GYbq4fqTJDaoakfRxOIRXEODl2+RTWv
         EQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778774200; x=1779379000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uCT6HXYhjKb/dFCYEBtj0FV6pBWcX+E/ZnHhtNgfIE=;
        b=gquFiWdIljbKUx5X9i7r5MNV3qOdyDrD2DZPs0LmqqJYmO2roFBFNiN+8Z1DRjKJdL
         25bRmF+zM61YyXzB3iUM0bysIiRKeP10+bHGo85Y5ljsh1T/S6g6jCGB12kErrZSIB7/
         F1NPaW+ZtzHL6YYG9Qb6+zDNGLdxZorEZaTC7dZ6Z5mYcevB2VLNvUNs9/dW9XaVmqDU
         YAm0Br+zxXOsCv4zw1OA5SRwyjrMSZfkWt+y5SejOq0hAkMYM3xQdiXpN6GHQEjMI/zf
         shlugtSxhS6tHhe7AhfZqA/1pGdoXgCcR89s5I4JHWCNLzuEQFSt9fYpkYUIK/94R7Jr
         w+3w==
X-Forwarded-Encrypted: i=1; AFNElJ+GMbzbFTHPxXqMsX9wAdkqyNTI7zrWYNyik3gCorJJn0JE6uqd9SzI3BdoQ4Dryil8j3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLqDtlEebUL/cj2Za1oOArfgbMbBeRZw8RFvFTxp8LHIMw294
	bz9fakvMSQU2vErKNC+73zGzUhNlCVYXyoqm5VO1F2D7M9KxHmqbpuJ6c+rtqOnkhEx7i7gM4/9
	nYAL3CLaFtC2V3PIBabxNjml888EKB4N6a8BP9wut7t+eChE8rzMz6/Q=
X-Gm-Gg: Acq92OF5xcqTSUKpE9WCcYo9pgj4L3Wt6gHHc4ybNyRaG2C0Hf481TvXmzQgfa4pE1z
	U/dueoY4rxYjVXM3N5A/u2kcXVNosDSCAzLGCeaL6FOkrcQrdHqqSeJ/M8HXN28C5f9dvBU1kvL
	bkm985QSD9RbfeXapQ1qUPSN3+Ze7NOO5Lcp8nmTyqMpub3+xmCTuTHa0QMABqLlPjNtyOOqz9q
	hBMpvRKQZtorEqLKH3y/XRXxtIvBzVkgn65c/pRNBtL3oC4znPtQjXCKkK2gTkJtzOzmqw6UBCj
	KbXVpK34c1YQtYpHhNJd8rAGqr9lpvl9P8pxzeNzlNndK1YkKIZ4C/YvJulmE0UIgGQ0UXmUjM2
	apZh73lmHInCEbvAEjy44Zmmh0AXFBNf4nMHvQQ==
X-Received: by 2002:a05:6820:81cb:b0:696:1cbd:27b2 with SMTP id
 006d021491bc7-69b78e1431cmr4290185eaf.29.1778774200112; Thu, 14 May 2026
 08:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509114122.1868327-1-vulab@iscas.ac.cn>
In-Reply-To: <20260509114122.1868327-1-vulab@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 May 2026 21:26:27 +0530
X-Gm-Features: AVHnY4KnO5GP15bm8wpvO_qtJw6UtrK8AXTiAujoajkCIeV2BiTUAo8W-MSSrh4
Message-ID: <CAAhSdy0YEe802RXPbL9aAdVYqj7BCcTXBBmLNnWinHTFohjtGg@mail.gmail.com>
Subject: Re: [PATCH] riscv: KVM: Fix missing TLB flush on HENVCFG.PMM updates
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 5:11=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote:
>
> According to the RISC-V Privileged ISA specification, if henvcfg.PMM is
> changed from or to a value where (XLEN-PMLEN) is less than the GPA width
> supported by the hgatp translation mode of that guest, hypervisors must
> execute an HFENCE.GVMA with rs1=3Dx0.

The change below is unconditionally doing local HFENCE without checking
if (XLEN-PMLEN) is less than the GPA.

>
> Currently, when a guest dynamically changes pointer masking mode via the
> SBI FWFT extension, kvm_sbi_fwft_set_pointer_masking_pmlen() directly
> modifies the hardware CSR_HENVCFG from the non-one-reg-access path
> without issuing the required TLB invalidation
>
> Fix this by adding an unconditional HFENCE.GVMA after the CSR write.
>
> This vulnerability was discovered and reported by my SpecHunter, an
> AI-driven architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa=
-manual/pr-2494/linux.txt
> Fixes: 48d67106f4a7 ("RISC-V: KVM: Implement ONE_REG interface for SBI FW=
FT state")
> Assisted-by: DeepSeek:DeepSeek-V4-Pro
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 2eab15339694..c2bd3ae699fd 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -186,8 +186,10 @@ static long kvm_sbi_fwft_set_pointer_masking_pmlen(s=
truct kvm_vcpu *vcpu,
>          * update here so that VCPU see's pointer masking mode change
>          * immediately.
>          */
> -       if (!one_reg_access)
> +       if (!one_reg_access) {
>                 csr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +               kvm_riscv_local_hfence_gvma_all();
> +       }
>
>         return SBI_SUCCESS;
>  }
> --
> 2.51.2
>

Regards,
Anup
