Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585796;
	b=Qppo8vlXKSTnZB54cLbLFHmqcJ+QEPfAtcPXQQa3+zdrOP8CuR0ZKuvxnYo1KN5RGB6w
	 vSQTh4tGjp6a1Xwfx4r0NsUIen5kbaIhP3be6s1ljEyd2kdjJk9tSGU8OM5a4b0GKDaX6
	 xPxRZUyUC9yHk4u5Qjqm+xz6lMctAOp/PG70bT2OHWgOwdZIy+IkoczqXATwKK2NIhbsT
	 g2dC6RSAl53h7EE8ZkXVs/z3iaz9EuOjJPdor1tPtWk4IoCBlbTKY7c6vbwFlIs4tPJbP
	 WlSsqUUi1Jze8zhh82Lo/JlffWMURXt1yksEtiuILQi4RyLblQtZ2f4ZRC1Mewg2bDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M0m3xJ6SKs4qbuy6HlPELsinPaGfttdr+a2t/1R0rkE=;
	b=aoMDgf4nU/fYLz0ltgSSuNY9DgRZc0Rnec+aZ0QXPF0cc9EKZZ51G9JW594W+BdRXzI7
	 fdJzRM0kuIGZlWmZd79TGfqbhN2AWFc7lYS4SvNz/Wbm2QdXe76pfCbqS92FYWy+jOKxH
	 Z2uJYS3qxctDBxUZKPVzA5BPOci+x0daG04ojaRU3bVfW/RWtISfb7TIevBLiA3FUFGpS
	 Mz3UMY0S02WImLUrpzsFb5rxTwqHO2J0TVFkWaWkPtl911ZJZcXPIGB17KmpTWvMzThqP
	 UNmAhkYNBTiUiixYqVKa9G/65coOcSab/thIL3PxGtv8FfIKpH2Wr/4lXPoMxL0t15w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=h+FicIgf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777D606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6777D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=h+FicIgf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so46202865e9.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585794; cv=none;
        d=google.com; s=arc-20260327;
        b=TumHZqXmYXwLaSm7YCuN8Nf/jWdEw1SbFa6DOCDgLwwHBP31AC+vIJBP27sf3hf37L
         cXFJJsuiMQDetiSBedmHfZZjlbExBQUB8hsNJk4BCf3pirYjpFAf/Z9Bf3wNK/wVn3ny
         iI+3mrWFDyPW9jfJm0aJ+syVZfeWnK4FjMy8vW8NPXEcf9DMHUq2r/wRd8yvDOCh/2KG
         i26zRVFNckKdekbIF51qXBmnYxktUd8pS6FIXhgym7V6SlFuQpa+XwvaJ4sAQI5No9+2
         CyhFvM3t2L4R9KrEOU2sa1YpuYPXQCUg5LbQH8gxlN1pPnjlUF/0iJcUMMfBGveLcljB
         APEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0m3xJ6SKs4qbuy6HlPELsinPaGfttdr+a2t/1R0rkE=;
        fh=2w1ingGPts8eWzSUvjLPDm0aYu6RAugu0GvCGMX6Paw=;
        b=qR2rspzHHNT6/0xapmtRz4fHrkr8bp5bd/k9xAFrUTIggFRhdfzz4IlcNX6nnGyB5d
         poUhCVGItIZ5KHa2nuOZi/EFIqm7U1WpP+GvJ8xwp4mleLUWY//kcC89k6MOl2JExY64
         Q/Fbt5xtYNtzvvCYV4hbBSt6ALubdPJnxqVRGtGzyNizqPdCfiBsouFODj+slE/PvHm5
         rsMrtU9OkJd8Amdt8NZ+UJZGxZHLlwS+q5CaUDqDJn0WXAOHGGezNH+u5b3S9Himay0W
         c5aZOv5mnJ+ZjMeJ+aSHIahud1O3fTnjV8cyHcEoZ0n8EI82BCHqnKGjCNsqkMTT9e1Z
         bMFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585794; x=1796190594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M0m3xJ6SKs4qbuy6HlPELsinPaGfttdr+a2t/1R0rkE=;
        b=h+FicIgfT8EIQSBvhRApapAA8fwfLIoak2A0ftfOZODClo5oy0cIpg9moMi1grRu8+
         GNg3mkcqylOWKZDdaRcCSA127dAVbCkMVDeB3XIRxtL7BlbzXAG6YItyROi5lMRrBH3y
         R5bBuUnxhsgHi4NsaaWpqzZ6oznVpLA6kGRvpgSh/CJIjI4X64WHHoWJ4/ScAOZgz1JE
         Ofoilgi0JAmYRejJayOk6fMEfAVxhfycgkyUgTWcMOKjckzAuHl/MsA23ENc8Fszm2z4
         h8X8fuSDqXp+VmGl1Mi1qfm2K+lFplxeLNxzCcf82vo7Z4M3UcR5QHUgG1kbV6zs6dL4
         fabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585794; x=1796190594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0m3xJ6SKs4qbuy6HlPELsinPaGfttdr+a2t/1R0rkE=;
        b=r7v4XMPuVpS5UOO1xSuI2ysZdfqod+luyG0Xbj0F+ptRbIRuRvlJ8mrN+lLIrgqo8F
         ViflQyofiXv1g3OAmTVFKD+w2mw6Wh5EK/ZrAvqRR1xVyDudsTauw/yIab82hreC4bL0
         2buRDpTTycbRtqbzp1Y9IskB3yGOJZKJkECqGI2IXsCK4N6WnV+kt4Tsz2kddqe53a1S
         WUMd0mWEYsWnBGkrQcky7r3GbVdJGi/DnD6RXgGFiJ2ugd8JsP8JU3ZH/YCUyF4YyU0N
         szSWQfqycQ9W3evkc/2IFpo8NXbnORS14XkwUtgf+gutG1vlzd0Hw0z3FrPxvCN+PSZi
         6Rjw==
X-Forwarded-Encrypted: i=1; AL+hErF5WhZHaFAQ0ucg/HI1K0tgF2OFxTHFtKO+Y7PF6nLMa/pR8KdNfEGsWtt8nmufg3srqpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XPm+3vVl4Dvqe6bgUI8zdhTO6UOAZajVFzqfuJfqGMzcxf4fR
	0ZCXAl+s60M60/60PkchJIO3owxf4tStAbBWwMowdNAakn1CfyB8MI9PmiJzi6cVe9MH9/skuaR
	QULHp22murJSe13924KEmB5sDju04vgAtrRStb9FD3Q==
X-Gm-Gg: AZFdTZdAwcY6ztVfvr8bqyuiqOkH2esWrmfqBSU/bJtWJcfxXF3EiB2uqPlBI52dC/H
	mtMgRlIZgFxJm9LBxSuldPU9rzLxXZlwkOZtWWESgk8dn43q60SAoz59T2lWUbluaLQbY6vEKit
	1Xu/tnKa8mVcJGJcimK8McTwIm02phTaukZYYc7l2PQKGCNo5xdW/7YoAl8lOwGtZ9gxsd8KdXs
	GYr65HjTCs5IGaGWxdXdDJqGIQggJ3gHnchjbSaq6lCugcJZrifSJs1zf0kpN1cPp2bkIWOvH8+
	V4cc9dnAhmyx+HxtnqswcfDpLfmUOSUZiXkEEiW0jcegQzDnZeS3iIUr9qhnpwh4TAyrPjpaRvE
	mPPGOQPoE4QnWeFgsDpr16fKFC2TsgU1yBOKXylsk1ocKPUYI0V+rJ3D+/veZcj9xapc1XQ+YGb
	4Sw5gK++h5Use9rHXEIotieETZ56CQS+tfVnGew5IJQl4i/bcB+1fBalk=
X-Received: by 2002:a5d:6f13:0:b0:4a7:a7d2:eb45 with SMTP id
 ffacd0b85a97d-4abb6d04777mr28721728f8f.44.1795585794414; Tue, 24 Nov 2026
 21:49:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com> <20260921111402.120911-2-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-2-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:19:43 +0530
X-Gm-Features: Aa3M54rM0lMmhvxe-VB9jSUcy69cdiFPwqZiJIiAYrdwNUAJS1EnS9yl8AAOxXc
Message-ID: <CAAhSdy0r1WzzK-0rik+qkofG6RWHw__KaYus7LTkGdF-4=fnaA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] KVM: riscv: Age all G-stage PTEs in a GFN range
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Jinyu Tang <tjytimi@163.com>, 
	Wang Yechao <wang.yechao255@zte.com.cn>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:44=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> kvm_age_gfn() and kvm_test_age_gfn() only operate on the G-stage
> leaf covering range->start. They also warn unless the range size is
> exactly 4K, 2M, or 1G.
>
> The MM can pass larger ranges when batching the PTEs of a large folio.
> For example, a 64K mTHP range triggers the warning and only the first
> 4K leaf is aged, leaving the Accessed bits of the remaining leaves
> unchanged.
>
> This can be reproduced on an rv64 host with Svadu by disabling 2M THP,
> enabling 64K mTHP, and running:
>
> access_tracking_perf_test -s anonymous_thp
>
> This results in:
>
> WARNING: arch/riscv/kvm/mmu.c:362 at kvm_age_gfn+0x210/0x370
> ...
> [<ffffffff800c8fc8>] kvm_age_gfn+0x210/0x370
> [<ffffffff80095c90>] kvm_mmu_notifier_clear_young+0x250/0x478
> [<ffffffff80ae532e>] __mmu_notifier_clear_young+0xde/0x1a0
> [<ffffffff80932f76>] walk_pud_range+0x86e/0x1688
> [<ffffffff80a18720>] walk_pgd_range+0x518/0x17b0
> [<ffffffff80a19aa2>] __walk_page_range+0xea/0x580
> [<ffffffff80a1a422>] walk_page_range+0x3a/0x80
> [<ffffffff80931dc0>] try_to_inc_max_seq+0x520/0xe68
> [<ffffffff80939dc0>] lru_gen_seq_write+0xd08/0x1310
>
> Walk all G-stage leaves in the requested range. Advance by the leaf
> size when a mapping is found, or by the size of the non-present region
> at the level where the walk stopped. When testing the age, return as
> soon as a young leaf is found.
>
> Remove the range-size warning since arbitrary GFN ranges are valid.
>
> Fixes: 9955371cc014 ("RISC-V: KVM: Implement MMU notifiers")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
