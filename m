Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FED41C30A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474741; cv=pass; b=cr2zxD1W/AOF49yX9ey1Zs0ndmMrx6QsUjnMg5qNZpIY8IUGd+XZhRR5nOXfYKuBDxj6AH1zyj0v8/VIcOdpaiE5jQFxcI0yHgvNu765L4chCyeC2/Xqzn6S9Z3CdECRhpArtENIWH4PExt+ng+I8SFFQLHf8FEP1wQ4DS5u1gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474741; c=relaxed/simple;
	bh=cqQZECx9zUEnA/ScWLQh4Fkgt4axKo8zA1GFmcMfR3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBzpffWc8awiYB6GSpOExebBRXPdIMZl07L/pGJbqqOeUermPkJrx2N3extYIe6tF8toXU1hUgoX1QS2Ap8Wet/Tnh7Sx8Y0E2p20KVyrLeb1ca+ZxpY3MTcImmf/9lj5f9mUB/s25yDIFjYkOE8G28qX2l0amoT0tBJQTa0QSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Y/RUhHQN; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Y/RUhHQN"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69e1eae4eb4so2739630eaf.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 01:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780474739; cv=none;
        d=google.com; s=arc-20240605;
        b=RMzMYM1oT1B/fkIj9kaQQU+EqN7Qm/Bk3Hj02vBpKJC3QcVh08EKKkxWtRwqjt3o3g
         riviuEstVJvo5oJaXyMbrrHRiuGFChcYP6jQGXnDvRGSVXfqRNDzGCJIZQ9se5llClD9
         AgiSOp2JQUPYrtBbi7j9cKRvOWV7dpPVGZVVzje4J1NbLvl0R7a1P/3Zn1O8AVf8n2s9
         DgpcTpRZf1b7/bRbMdJed0StqtWLptRPsH53mDc6nGrkXcjB5CFI4gu9+B+zB2vt/n2d
         OfQsh/kfspvDM0axfFWN5FJ3Z5Z5Pn3ryEC7HCdVGFnxEChw9dhL9K+XekEPz91F6sXW
         VhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yygNmT61sYbCZArzAqt/fFbSogFcxsrnj7Jj0lk2HmA=;
        fh=wI4FrHJkBfGC9sVhfNRgjPLHJkW98R4tWXkDo3/ZDO4=;
        b=Wb+eaUkw6k+kBEWwFNV9X98g1CXhe3QClHsqh8TXSgqcIEaJubqPRIXetpcYGCiiIb
         adVNdhCkrIi9HCQcha4uW1s0g83ZHHP/agmrh70SXr71yer0yYRft2xhFKbVmegCFicb
         AbkM+hUnjNpvlzWK0f8tSjmCmMs+grQB5V4/df2RqVcKsWgCsS7AGwnzTJ/xwq60RWXJ
         iORI5a9hC4IEEBGPCeeypmrRdup8ZKfCsWpQSblGUZ/gSBZnOqKgSCwjU8q9psVLSMfr
         jr8pUIJkW6jhWysu6MlmC1jqE+Y2h2mKKGyFcxjLrTWPvmRx35GxCPQQ5zRfSCmsVC4O
         r5hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780474739; x=1781079539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yygNmT61sYbCZArzAqt/fFbSogFcxsrnj7Jj0lk2HmA=;
        b=Y/RUhHQNoOqPUs0/h5ROuG5JOxScv4HahlanHV3b9xIZ6yHcG2U//f2cQREXXK00qu
         rGMuyFC/fuYQdKn7j1o096/VetIqREbec3LTv6lU7Szp6Im4fBxo9mnJkVINhOkxS4xB
         NrigBchNGL13YkQPfPspc2hWywcimGr9d08lCmi0nnXJvFuJR5EWX0lwdSQcOvIwlaAQ
         JC9eCuiAU2F/Oeh95nOAZYGiHGFYgZhXxxTkOMzIhpXbPpICCopfRtbI5ivojhhexr3f
         dekn/HtCWbWjaEo/saY24etdCS1OK35BOHS0tGBT7Ru1FMDYapdle60uE06zS6WdpfXW
         ivwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474739; x=1781079539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yygNmT61sYbCZArzAqt/fFbSogFcxsrnj7Jj0lk2HmA=;
        b=NxJZh8k57jYrDeE0RPNEdp7FPEZmxgH7FFYk16uue3pp+kB1tKHNaCYCxUV7mr/3P5
         PHF1NYUJkOBOX9A797oeGxnYyzsUai6zLHuZ0srmihKbK8+2m0q/8y/bg5vnzxflgAJr
         RAXI2Dl+4RgSDLVpUL44JAdz+2c11Hr0w4t3tk1VesW00akYI/lyEsuAf/u2vGp4Fipl
         XyCJfrQOvQoI3TGdjrGzQ9kgJPJooEGi3jKp2sWaNtbjpcm9SjEAaONfu9UVG0xxJEtN
         ZTw/tjzqZMr05RWMbGzuJTTzHJsHFc21olEyTErXWWGpnDdBQ8npPBLx5chP0VXgY02h
         1cUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kb8qaoxWZbQ5flHocLxk5yLd6BxXI/35q7JulNnXf+a/aHqJzxNPj1E5JSBBPh2BbzCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYaOkPszANL1kbCynqynF5Xl1S8dG1vS9qCk2EvrLB6sEYjMb
	IjYzyYDgUz+h6BEsEUU3cQbhpVRUdjbblBUqZG/Ws+Zta+9zQPNKag81pu9UJheGgP2MJd7KPuf
	FGbOtJQzMsLGakiF7MHk2WcuMYyklkQKyrLKVvl9t1w==
X-Gm-Gg: Acq92OGWszzSU96XQ+A9CKDStNr0whfLc2MhV4h3M7XYqUoykgATI6/NA0eGn4OZ6lk
	BjFvCT8e3vE/mBT5UYrdPvgJkxhkUJGlxJyohFpfBC9nyTkyxT8DCk6fpWP7kqbve1UbItLgY0o
	6IP9nk6vDQQrKjhIkWxPgyBYZIw0dnDZzsONsESL3ZXnzayf0brLor8PeF/F3J7jU387OpjFj1H
	Cl2vw5ZtQRguhHdEyzoXbdgDgSkt3Tbu8l1oNBH4JlsyRYg0nIsJTz0jaIirOXXkR6h5i2cRwup
	clk3Gu34NTnt4Wj0QiauAyeYp3ZalQn/zATP4tTENo5O3BeDGwmuNECPzOqd1gjgVjwaNlW2KHF
	litW79xEWt5Vc4mb/RR3YqOTMVeEZI2ULg4jqog==
X-Received: by 2002:a05:6820:280e:b0:69e:3e2a:a838 with SMTP id
 006d021491bc7-69e480c4e0amr960102eaf.52.1780474739437; Wed, 03 Jun 2026
 01:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn> <20260513154500183qjAlxzbei98Q4B5HjLpMx@zte.com.cn>
In-Reply-To: <20260513154500183qjAlxzbei98Q4B5HjLpMx@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 13:48:47 +0530
X-Gm-Features: AVHnY4LzHljWBAXzMy2Za5hYWEvR0vWNkdwQN5CLSrLnlnj2h9dY2gFEIxQeMAA
Message-ID: <CAAhSdy13aO5b7rXfE4eNz+r8cLUhN3-T_YMegRPE2=15KCR1+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] RISC-V: KVM: Add the eager_page_split module parameter
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:15=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Add an eager_page_split module parameter for RISC-V KVM, following
> the same approach as on x86. This parameter controls whether eager
> page splitting is enabled. The default value is on.
>
> When eager page splitting is enabled, KVM proactively splits large
> pages (huge pages) into smaller pages when needed for dirty logging
> or other operations. Disabling it can be beneficial for VM workloads
> that rarely perform writes, or that only write to a small region of
> memory, as it allows huge pages to remain intact for read accesses.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

Update Documentation/admin-guide/kernel-parameters.txt as part
of this patch.

Regards,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2cdea3e3ed4b..2af03c48aff3 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -16,6 +16,9 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>
> +bool __read_mostly eager_page_split =3D true;
> +module_param(eager_page_split, bool, 0644);
> +
>  static void mmu_wp_memory_region(struct kvm *kvm, int slot)
>  {
>         struct kvm_memslots *slots =3D kvm_memslots(kvm);
> @@ -148,8 +151,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
>
>         kvm_riscv_gstage_wp_range(&gstage, start, end);
>
> -       if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> -               kvm_riscv_split_huge_pages(&gstage, start, end, true);
> +       if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +               if (READ_ONCE(eager_page_split))
> +                       kvm_riscv_split_huge_pages(&gstage, start, end, t=
rue);
> +       }
>  }
>
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
> @@ -214,7 +219,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> -               kvm_riscv_split_memory_region(kvm, new->id);
> +
> +               if (READ_ONCE(eager_page_split))
> +                       kvm_riscv_split_memory_region(kvm, new->id);
>         }
>  }
>
> --
> 2.27.0
