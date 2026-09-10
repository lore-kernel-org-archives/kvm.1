Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68755490BFF
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048763; cv=pass; b=uYppgMiDVqqPMZeCuPIM7E20umgKrm/7n6QVjzilexxmuCYZhS4e+B77Zj31evxBYWI9NVL4w1sg2IHAKVqdL2+kQmQLS/NeKZ64RNEK+meb+ZDcqeGxTcZHq54s7teNqeWVtnAP04+ZQ8tciHsa7+7C9pE9OhoqJ/55cP2o/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048763; c=relaxed/simple;
	bh=4FCRoa1ZFnGPclKdf7FZ3h4xxGbrom0G8s8bGT+RMtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivu0OCcsJvhvbDNuBs0e8Tafwf1fVB+EawlCndZbYsvcBzu2ouVvT7SoWyDwufTIYSUcYRhKPCr6oOnCERe+Se49ZWd8p2uPohhBmUcx00MibUeimzCm07ZmV9WDDB4beUTuQ6GJzRiHKuvSFeRME9v8V/StRqa76GV9ykV9d6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=cezdMIZV; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="cezdMIZV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485888b3c3dso7151664f8f.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048759; cv=none;
        d=google.com; s=arc-20260327;
        b=skoHjc0EVTJ9smwEW0aNJhUUWHJmMKzC9YoIky+JmqcZoRlAIZjGD/3gGKN5dd28de
         M4AsKVx6MFFvhsNDbTEzIawE1QITWmMquc3ufSIfqj1uG08XP4XomxjYUWfsYDIO3Sto
         DwYeFuRkS33QJWTdvYFFW5oSSj0GI6qlmukzjtNTH5vk4bHoApC0nquIuDAwWij0XSwa
         FMQ616I5nVx2yr8Wll5uJrFWYTP4doJLRjrJuPmnCzRE5Lu5/cWVnA/4LkjjLP8M8ZN0
         kTEJtidRN/aXYc/f9Zne4h0X73AGgCf/YaL38sZiB3H4HtsQ3X4Nf4YpXK1fXo9udssy
         ct8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        fh=In8G9uBHGNPC6QRN+NtcLGPGKegYvQD6mlfLg80Uolo=;
        b=OXGp6bobU8GyKuVXLh/zoepmkgpUDGglGfYrBHSQTn5wQeM7o7EXEFCsQjoOe0oRte
         ZXHmIk5z+eVrFQWl1AU9x+MK4P6GsczPMU6q1TX/L3AeC99dGWjYCJrm4f7GaO6N5iNj
         fGSBK7gUN3FccTyyFnS5MKjs+NwPfxAynAiF/xMPoPXDQiiPspxzegnDSMfKnIEPyN0a
         +Mzra+LT8q70QsAAkMNsHFKvdS0cIMXYV+nDMIzsHxq6X/+eajN1m2/zCY8ywEeADKMt
         fF82mAv5VraArv3St+5YeD00jxysMLWTFTkNp2LjkDbTiL7pcE0jXcTxJgZTJZtNS815
         ySLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789048759; x=1789653559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        b=cezdMIZVSt/fPfjPM4Tz7FCdYVXwEhvQh4y1VNkoAE6iTTKKxoAwM2P6UpEay8aZRo
         xkeuPkPs1GKJxYdoFtai1dg31xay+5IogFF/e9TemeVV0ohMBYVMeMsoyqxARbg6vsey
         bqn4f9KdCZpO4bxWRqgA0LWYRCm0ddgKK2F6DCFGaeIy9oCc7H+Ovmzf2DKYinnjJAzS
         IoX198GgGsmkCnV/qgo25Cku/TF8djv4y+M+6RcRFn63TN+jTyd/yW/41hfqCRyaOw/4
         So4AA6wKwzBm7nODwEKHitRIcNBnT07F55ldEm1M/0U5dpiw/PSckrTOMpVVfeSX0+kS
         yZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048759; x=1789653559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        b=qVFZyirtRNCveQfmO/6OGb7cwfQTxTSPzZiRmjjxRgkQ9TnXuSUMB1+RP7L4Ty9jW/
         i4rb3Etm40KRUuI5dhD5Cu2kSABRyNkN7Uwk9eyj61CJsYM8/6ypt8XxpEoZ6BorzqS7
         FW60aLgAG3T96BzTL+KuJvXDkmPPwQSmhGYKp2KETT9HcAa8OrmiFXQ3MGVawF9Amsy1
         t7HH8As4BbKQQeeJ9k+Ub+whDdk11bWQEWTl91igMGvtarxiOG7dEhlcr1gFcP0+ArYS
         mUXKRreftu7iHoKiayfrGcRNuGC0ps5R+hxYxmL/JePscDKV1t/7bajjEoaLC/bnI83D
         szew==
X-Forwarded-Encrypted: i=1; AKwUvBzY5ef1Fdp9bB0nHE56/bb4Rcpc3WboC4IEmyjSOTzWRZQfrjpGwvj/c6xFMyeboT3GLLk=@vger.kernel.org
X-Gm-Message-State: AFuF++lx2+Y7C35a2ZgZq1OJp9AmlZF8ceNuJA/Q2wWWe3trU1BiJLvR
	TRUXMeZOhIVxGzzrKVUh2UBn6HYtZnRs+iqcOd7LHZYbyIxgQo2hsK55LbyRtH0RZsBRqn3EEF2
	YF8nKcgPKq626D6jnV6zGw/qgtuyUPweVSNju+XIia8m7scIEogsSpOE=
X-Gm-Gg: AYBFou2lafpsFWUtfbLOQlrh5oIbFF6x2mLclc1xaE3O3/P767cdofosAmnzb1HxDLo
	n1NfXwxONx0VkpFiQ1nCrXDImVsWJ3gxeMuLUC3FJLQaOgclXxIFqGR8TDlAtUQO3ux0Je//yON
	OULTHX9tFJi1y8ScZSu/nR95P/hvY2eNh7m8c/sfLN8qUZUTeUTupCnb9W9fEG3+bB2OyyyCQGN
	RG3VwTLOdiBtQSR1DVDG7ckwngo7kn+txX5A7jR3zPpi6nju8HsNRv2ffS4PNserl0v1eYER1Mc
	aybgCAkILSHs+rxGzQehoE3jZCbBszksDz/u+7jJUeFqxA1tKRv3eZPMaOBONAiEfUyARMWnZHq
	OltPpHSrXSPA1QoCdhvUY1y1NeoDXjbgGj94OmBLe0REDvGw9RFIaGT99qfm9U6V1wtK23UPLuA
	==
X-Received: by 2002:adf:e19e:0:b0:485:8c16:5eef with SMTP id
 ffacd0b85a97d-4858c166088mr39391128f8f.41.1789048759310; Thu, 10 Sep 2026
 06:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051544.3953925-1-xb@ultrarisc.com> <20260810051544.3953925-3-xb@ultrarisc.com>
In-Reply-To: <20260810051544.3953925-3-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 19:29:06 +0530
X-Gm-Features: AcwNN1W7Uqn-QGBR02QgV1a2VTJVT2tlA_caJMvDJlneztIk9EUK-XjvcF0ult4
Message-ID: <CAAhSdy2qxD9x-mvt=5yEKA+xoa8QJ9evnQkJot9n+rkxvOQukA@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] RISC-V: KVM: Propagate interrupted G-stage faults
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:46=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> __kvm_faultin_pfn() reports an interrupted host page fault with
> KVM_PFN_ERR_SIGPENDING. RISC-V currently handles it as a generic error PF=
N
> and returns -EFAULT.
>
> Return -EINTR for the signal-pending sentinel so callers can distinguish
> an interrupted fault from an invalid userspace mapping. Do not log the
> expected interruption as a vCPU exit error.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as a fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c       | 2 ++
>  arch/riscv/kvm/vcpu_exit.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d189fd5..3e955d8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -708,6 +708,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>                                 vma_pageshift, current);
>                 return 0;
>         }
> +       if (is_sigpending_pfn(hfn))
> +               return -EINTR;
>         if (is_error_noslot_pfn(hfn))
>                 return -EFAULT;
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c36..8d36eb8 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -283,7 +283,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>         }
>
>         /* Print details in-case of error */
> -       if (ret < 0) {
> +       if (ret < 0 && ret !=3D -EINTR) {
>                 kvm_err("VCPU exit error %d\n", ret);
>                 kvm_err("SEPC=3D0x%lx SSTATUS=3D0x%lx HSTATUS=3D0x%lx\n",
>                         vcpu->arch.guest_context.sepc,
>
