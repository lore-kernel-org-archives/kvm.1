Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794551414;
	b=OERnBh9SBL2r+B8imWvq6uBjdIgqIc2K5Eck7Ii7HeasV54GG1dYDAnDBU+QQxcmwJz/
	 Hm5vpRi70N0hMtk5pQgn5ypphDgKzpYFs2vaALVob6B0fMHZ3k1HHT488rHPE/oGtz1nW
	 R65oLFb4IQOIGCufYhM7sq+mAZ0zMyABOmM6xiNyDMRhdJl1gracseylXyaEwSdWHH87P
	 Hk4e7OfnIES8m4KN571XJdoH251S3w093ft/oqjyKFTk0sjb+GsKZQ9FqXDiUskDHkR9n
	 itioUvd24eNjFzhjHMlHFPkhbNC1dGWhIt0e7cPhur/DAvWu7n2OsCeZB/Ch2KUaZrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
	b=3bJra18s3KBmTrI59l8Wsgw/Q02cqO5f7pmIy1GXZF1raaIDSvskb/knrVEaGtXbD5lo
	 SGPyEyRi5ASG1QtiM9GsQbl7w0C4TA3EPFzwAtp66HDzbHB89zS4nbtn7dODQKVABcP2r
	 cK/ns2kigM6LEw9vWr/WK5Ibv6Pi8CJn8FLhjTA5mk+iqZGEagUE349+hW4yKNqUcSYtn
	 Drayu1jzRFBxDOk0OGECOyE1Iiltz9AdrMIAswYQh1iMMGN23lNSF1ow086KGA9rAffTw
	 4Yuc1jCoH2nmzx3NIZMYUwnIjO+zsi7bKvCbZJ2er0+PhUwE/IaPsvv+opuk7b6l28A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CISkgUyd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1B606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 06:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B1B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=CISkgUyd
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a49a022221so6831451fa.3
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:30:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794551412; cv=none;
        d=google.com; s=arc-20260327;
        b=S7UDIFRIb3EjB1ql60a4XcVhYT8pC4XK7zQqp6R7w/ma9lMa+TMkJgUMlSHelaIkvK
         1fJpETRIDf55wsZFiQSvqIPAI2XIew7aKmT80xZ+LFp3IiTAlY+AXF7NfPPXg3FjX5V2
         TGCoBQkyAfhE9Eknda/Ru70Wno6mDKMTWb27txaQdvc5Jqv0QWzHxVxBottStFWW4Zbg
         reM+kx+DdEeDVIaTSkevRRFkOHjznFWp7+oqRsk48KcaAxd5s2SkUXjBYOh55CFR3caT
         g5Pruga5w9ISSg5/lf2RgldtNpVQTgNnbCfmw/153tSt2sJiZiV+HzxVlsv6lOYY3xHs
         JsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        fh=MdugXWURFG/udUBo+y4bMnqmnHLEeT/J1HEkdsyn7fU=;
        b=AZcVqlOHoOu5E28am0wTrjLNOftl242WvmdSrRHwzQEz+f57YDYxEdlmzIjIaradpD
         dJIpcppQxwGvsY7RlSAvm6Zcyw6nAmnKafbeU7WZWx1xrZ4joFb87vKxpI8azSV2lckS
         mj0a4eJG4HUnwNgKirVd9PyQ6FYxUWpisR2hPgHehSJgajFVy36SM0nX0pYK939IiCCC
         v7RTB9SFr6kWSVgNbzqRxsCian3TIFKNw1Q1J5m2zmFFvLz5AC9s9fqxPVKDVu0cJMal
         k+4Qa+UMKB32sPv4Xg+ECkpruTSEAE8+FwWRglDiv83RZbjn4RgYGxprsOPldUtOLJXv
         Vxkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794551412; x=1795156212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        b=CISkgUydz5u2X77u78uCB1fRwoqbwfnH7RNmDCopYJjHDuyVTgOKMzYZCTkmUevY3g
         3K5gvlQXqrBOx+waPEU20+MtV3M9UX4Ii1fRaHcNSwqHFX/t58xEIIo43Q5/5oat3alL
         UFWy4s0BgaccGuhvrccPxulBiqx7gFYq9Yi+vvFNKVVZiNyeV/5V2Blol/QBCuMOJ6ir
         ZeLzky/15YFIooTxDnd5PsFWe7BzdueFp5Fpw8AldUWc4Zoj5yPa8n8UVjdDd7H4zd7j
         Z3qky2hKscrFwxxJYOYEm+t9zLlgaXK9fnKUk1rCo2A5XxFP0oHrA/TpJMTUZNjV3FSU
         vVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551412; x=1795156212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPecgQc9IrDFB6t3fU9sDhl6pEXoErsugQYzriIpc5g=;
        b=zd7NhooiT1F7C+zCsrdr7O8WO+EQgXZyDmrBC00ncPl7vJQkRNSimfGPV5qpSaJd9A
         1NLL53zqm/MqrLfwDEX5H/ZtlzMauOBkUuCIRWLVLZcmWQxQZrox5RrXnHcPRYwwtoyA
         0uF9ynfJVjToY4DhIX8HJ3lvoLW80q+xbyLg8FEXPmJO2gpQ2QqNlS0UKfAC2T6NG54B
         fugwhbD98RhOZH+vXheIcu2aw667u6OOqS1lLsXam7/CPXNsYdqkUAfs/+4iqht+39qM
         pfUD8+o9aoFRFVPse16zwZSxTjqW2YFVSVTC/zJPynLWM0OFUdrENmMufBK+NQYZW9Py
         Yu+A==
X-Forwarded-Encrypted: i=1; AL+hErHkXdbMvEgx0esf/T7xmvxr8Nxga1Wos9aFAZsFrWw8bqQQ/kn/y0yZ5mSDZxyYqwrs1Y8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eF2jlgXyJiEXf0eqNrdKdS2pqz7pFOvfr3e6Fe3YCu7I00+KV
	FqXu+xQFyqwFBsl6cFKMbgKUqeCHQ+Ar0NnmYDhL6trPKEuwEfaFC5nfP32kEWIFSybWFk8wz2L
	ZTjCutg67B5bQMuTCeEoNDeMTewW1dFyHVtYxW7n3JYHtBET3d9s9
X-Gm-Gg: AYBFou3gyRBh2dn9Tj0vm0aL1ZR7DqqIFzENjpaCG/wRWjUf/yCRlgrwjmXZJcUxf5p
	qushxkbIt0HyBH5m85ta4mXjLYqt0sTb9ZJmVbwRT4922GPmUbXZp9WRSOjqiFCSoZWBFeOZp9u
	SgbGErCAAb8BOIjCJRC6GubB+9g28wMZMGjvNSpBNUMVi16fHhWnGhLtii7t6pzoJVHzOS0Gt7d
	mBosagf1V1DU74hZM2CxWGa2IaAjnSlV/O15lpZcJvAqc3ahFH7uhQAV40J6zkLBI7GyPmJhQvX
	bNAQe/Kyad9oZa3kBQq2C6xthnqzIxPf7Wk083tpBWIM+vsf1J9j9ECRXiN+vQMoaprxgcH9aP7
	hzrgT5lNlmtlTOmDMmDflqUbDdkZyZJ6ZkId784raH7cP048v2nkj6xunxJmLZZGI0HlNT/pj6W
	vCp8+fDZK6TID0O8H1jXCqZfUsOaK+oAk1qnpOPrhHVzEFUEvvu/tdiiox
X-Received: by 2002:a05:651c:a182:b0:3ad:f0bb:344c with SMTP id
 38308e7fff4ca-3ae2b4cd92dmr4405361fa.10.1794551411872; Thu, 12 Nov 2026
 22:30:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
In-Reply-To: <20261022025248.477832-1-jinyue.li@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:59:59 +0530
X-Gm-Features: AclHuK8NiJX_tgbZANqAwiOjegb650NzlAml5enSgYn0fBkXeJUfWcHpMs2vGKY
Message-ID: <CAAhSdy13okqRhJLCygqZajrwDTa64gJt=SnCcZPRQxRd5E=WKQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix double free of the split page cache
To: Li Jinyue <jinyue.li@linux.alibaba.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, wang.yechao255@zte.com.cn, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:22=E2=80=AFAM Li Jinyue <jinyue.li@linux.alibaba.=
com> wrote:
>
> kvm_riscv_mmu_free_pgd() frees pgd_split_page_cache after dropping
> mmu_lock. It is reached from kvm_arch_flush_shadow_all(), i.e. from the
> MMU notifier ->release() callback, which can run concurrently for the
> same VM from exit_mmap() and from mmu_notifier_unregister() in
> kvm_destroy_vm(). The stage-2 teardown is serialized by mmu_lock and the
> second caller finds kvm->arch.pgd already cleared, but both callers then
> go on to free the cache, and kvm_mmu_free_memory_cache() does not
> tolerate concurrent callers:
>
>   BUG: KASAN: double-free in kvfree+0x28/0x32
>   ...
>    kfree+0xc4/0x428
>    kvfree+0x28/0x32
>    kvm_mmu_free_memory_cache+0x178/0x246
>    kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>    kvm_arch_flush_shadow_all+0x1a/0x24
>    kvm_mmu_notifier_release+0x36/0x7c
>    __mmu_notifier_release+0x182/0x66a
>    exit_mmap+0x7f8/0x8c4
>    mmput+0x7e/0x2fc
>    do_exit+0x57a/0x22b4
>   ...
>   Freed by task 15956 on cpu 3 at 8926.103524s:
>   ...
>    kvm_mmu_free_memory_cache+0x178/0x246
>    kvm_riscv_mmu_free_pgd+0x20e/0x2b4
>    kvm_arch_flush_shadow_all+0x1a/0x24
>    kvm_mmu_notifier_release+0x36/0x7c
>    mmu_notifier_unregister+0xf0/0x328
>    kvm_put_kvm+0x32a/0x7b8
>    kvm_vm_release+0x3a/0x50
>    __fput+0x330/0x974
>
> The cache only feeds huge page splitting from VM ioctls, so it does not
> need to be released together with the page table. Free it from
> kvm_arch_destroy_vm() instead, which runs once after the MMU notifier
> has been unregistered, as arm64 and x86 already do. The error path in
> kvm_arch_init_vm() is not affected because the cache cannot have been
> filled at that point.
>
> Found by syzkaller.
>
> Fixes: 6c7f75ef096a ("RISC-V: KVM: Add the split page cache for ioctl con=
text")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.4-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 2 --
>  arch/riscv/kvm/vm.c  | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 3e955d808743..74dece22d172 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -798,8 +798,6 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>         if (pgd)
>                 free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> -
> -       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb76..a7e1b518257a 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -54,6 +54,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>         kvm_destroy_vcpus(kvm);
>
>         kvm_riscv_aia_destroy_vm(kvm);
> +
> +       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
>
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.25.1
>
