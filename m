Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEEF32BF24
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566249; cv=pass; b=c8ONBSY5YbAfpaNMb1CoEiGVh/TEUqY7Gu8mDLscB+8YaHQMiEXfot0SVXxZySsOUWp6NeMidMx76TmFka5z8D1VpXxdLXd5CSzS6b26Tj851ufqpSZi6LlymOrNIIYaL6aasxBIxnlwdZsgThd9dSBHZOLvY0h0iOd4iRFCjFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566249; c=relaxed/simple;
	bh=hdSqERXB+jyTRDV2q8FMyL1RFB3N4Z9Czs6dwjLA4rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8uKIxNqopI0H6CzmGckYbi+7PQOpUAA+NAlsnu8CshGs3g7ls5Ij2qZHdddJmkt0JZk3X/Kp9F8/F+zw49m+iUJ51wfrN8r3e2AvmVaDapU9Y+2uh+ffcSA7aikhzye6CqdMj5KSSgn/XXLkc0aAKdAHdADcH+KGt4k9FKOmQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=dn8nLaOT; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="dn8nLaOT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1280200f8f.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785566246; cv=none;
        d=google.com; s=arc-20260327;
        b=st/v+0PNtkbeDgGQy15C3Xgb2ZwRbRk78dF7tyKOyisybJRCbU67DoOziG5t1g3cW0
         Rolf5KXK8FbLS5e6uhjylQOn6xYpGQjfurkeM0H67nFrUMhn3O1Fcq8U0mZ3eEzF/LNv
         Cwgp93tav/K4PPWDGgJGx1UMekPwyNlQb7nyHYNzeyFYXLiYOuhOnuL48ZIpXS5+tSAD
         mp2HiEaZjQNQTcBCXSYS6omScMI6B3vehgtcwNYNFSBNPlojl3pyeAwun3OT2IP2ltak
         dVIr8h26nLhbJpZV4sc4nksv87NQWsXmlOZkLqTPB6iZBvgFLsUOw/jbmUOivZKhhA5N
         XN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEEKMLrjFoxO4qfPv7PbynqOhcso35VDiGgwdeu5AIA=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=Em/nV50lV+QCb6aafr1SapwkSxzKYATycuaKUs2Z6ZUdyMXPHCkmVuPGy3VZ5VRIyr
         9Zx+lBiEkmQ0/n6yv9rNEjAIBk0PEcDlIYv8JxIdOcAaURl8tcK8WsGPGWI0KspIaFKY
         2ljA/TdMeO85IjldJHro2DT35mhzlDGLSEXeAz2zxV2PrX9L7qGnNfppcXrvob2OjpM7
         8neSpBUeby6duXpPlC/XaFrlhZVUdhYzRrvXjz5vUUMG0CjFIdmKnp9gXJE9MWOhfeam
         fhPehVk2RHGlZNO1LZ99pDcFBAOD+SYG/WaWu+yDHXlrOa9zt7kXdokxHfynAmVpvWow
         c/WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785566246; x=1786171046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEEKMLrjFoxO4qfPv7PbynqOhcso35VDiGgwdeu5AIA=;
        b=dn8nLaOTWwp0LD4nj2p/asUrRjXMIZysr/4wdKBfmhhDgYy94N4NaoP14kyxOOb9Ib
         L6Gg7KqM9HyvgSeeEJmji27sllYoYGrh4+uVgH9B6AAsLHxwaGOZL7oKW1frWu/eezbK
         Otabms4JHRyxPzimbudrB+YRil/MdrkAwnJlAd7i2ZoGEyW3BNYL7IK+aaSdPiK8LNPF
         cjUlL3lcVP5F3J5pMQuDOce13Rbd1cJNRZjgQ1OPppZ03ZJj26S/hreYlh5DPItl4EQX
         oT2dZnKJIgGPf79LGwfaADP02ZJt25KTFJv+u0gBvNtW1aN+Sc4w6EuURZSw15syiQ4Q
         HL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785566246; x=1786171046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEEKMLrjFoxO4qfPv7PbynqOhcso35VDiGgwdeu5AIA=;
        b=Z8SZdZzl7fwJV9JuLhtLzzYO7yP5oOMecLGjifggd4aHovfdYxZT2zH5GIQbiykJLQ
         zVzb26mxwli/WJcumm7OZTWNP5p8msd28x1JO/Swv0PifMm0TSH/tHhQTYCLPj7y8f8b
         N/w4D1siHnUmzRhAiOWUKyOisY/K3Mxl2ZqLf7vrxEs3Ga3en2pAFJI5fEaOuOSOq0+9
         1/VU6UrFecti4sX4tKMecMwSePgMMfHu+sGdUPawWLAqlCaTP1tXET8kWdyJpl7rGEYn
         nAMnk3q8MC02J4fP5CdJlTjjwjOnXhCvj3Bd2v4Dfei4lK4cHXGvoSiiNYN4c72Bx/R1
         QSRg==
X-Gm-Message-State: AOJu0YwFTqtA29sCak3WZhmpjVD1ZfE+CIixxhmRkOECe2TXYjBJjEXs
	Rn0qF/X5I9GoTUWTZQBYG+DgGL0sTfVRXWYLsl4EatKx0ei5xqDWHE/WeJGZr0ewcY0mRZM7ud5
	EZk95bal6wvbwDXshOc/rkO4P6Br+iyc6IduyQP4UNw==
X-Gm-Gg: AR+sD11Al7v2ss+ZSLmp7mZKSfBUIFec3iv+ag3gw0tzs3uZUJFIS5RXr18Ltde2IdT
	XReAFP2LV3mQQ090kmpAuWRpOFEDny3vhHX9Q8934moGfRt5gru6Yuj+AnaC5505jtxy1AQvlpt
	541pxMHEX4kYkmInm52JeWKqoTlUS2UmE3eO/O6/UR0l1BYAa71U2EIsUQtcXflhNUOZ8UIWERy
	pHMIJwFcBmjgirrn25Eyv6FlfvrebhOIwvHQO3opODq1HqNucAiIF9KRXAPN+4HUmJfSqOMJBJg
	Rv4gM4s9c/71Dh1wOim3NPX8Em2oVctZFwb+MkRqk1E/dav5cNHsI+ohE7AudBPV/ZOfynvZPDk
	dJImYLkSkT0PYgvOC83vwsLjCFvkGvk2rNi9rJ21+cpz7Aaa3SOSLTss2cw1FwnGJTL7+TnOj70
	o=
X-Received: by 2002:a05:6000:29d5:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-47fd72a8ee0mr3499962f8f.4.1785566245613; Fri, 31 Jul 2026
 23:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn> <20260731091215.1549430-2-wang.yechao255@zte.com.cn>
In-Reply-To: <20260731091215.1549430-2-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 12:07:14 +0530
X-Gm-Features: AUfX_mz71aCqhPqjPcVLhtR6XkG82Dg8vgNGUVKpq_m_RdgeZktITFDomZMeZYo
Message-ID: <CAAhSdy1d_7w4vJS9CfuSJg6o9CYgnn8j-Bky-KtcCwuP2oo0Hw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] RISC-V: KVM: Add the split page cache for ioctl context
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:46=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> Add the split page cache for dirty logging enablement and the
> KVM_CLEAR_DIRTY_LOG ioctl.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/mmu.c              | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index e2d5808169e44..71e455d166905 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -86,6 +86,7 @@ struct kvm_arch {
>         pgd_t *pgd;
>         phys_addr_t pgd_phys;
>         unsigned long pgd_levels;
> +       struct kvm_mmu_memory_cache pgd_split_page_cache;
>
>         /* Guest Timer */
>         struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..2017d292f4ca7 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -677,6 +677,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
>         kvm->arch.pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
> +       kvm->arch.pgd_split_page_cache.gfp_zero =3D __GFP_ZERO;
>
>         return 0;
>  }
> @@ -704,6 +705,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>         if (pgd)
>                 free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> +
> +       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
>  }
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> --
> 2.39.3
>
