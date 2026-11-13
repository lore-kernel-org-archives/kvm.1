Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794550972;
	b=Vv1XxRvE2a+X9iT0BRsCJ9infx9JOVuooQdoyQ5KnaEk5M0B8KV60PkwCuiqllhWSq+6
	 7nESVDLW7MiGv0SjnuHPCJIAJp/yyaHdl4Q+YjiyHYarDE3QolU5gxbXMCj9q+US+Fmfr
	 YppqAqsj254IDiTwrYmxXF4GgfIgrVkzgUUylhSxYtepKu2SWKATwFBUBoGGem1JQYRv7
	 l8ci7XlZssNsgEQaYo1SFE33EJ/prWtXCP2H6yGtz2UbIF03YdWOQ9eHOBef3gRchcIbr
	 /RIZRixhZX7NTnN8/BKGwQhcZ/pxCvLSU853bSV52If246lN5/kYYIBbkKehbC7i8Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
	b=xYfrQRuxhAdjyDIOKmfWqpKkHqltk1e7DR/33JBgqYx5iYz5yH4BFbHkMU6A+oQoHSJP
	 xHdCz7AwG3gXxIypUNjbvUq4bKz2uPxLwP+OyTI2fUIIdUxocXgKI3RQQysyBxnrPF0Mj
	 YVpAVwlAU1lo4JDHfxt+0XdhUQ8HmD7ydwvufv+nzMKHcx/uFC9e3PF50Bz0ApIUt3QP3
	 OTSIYpmCCiKhsDKAQs0SKnC8GlLVjVs0QG9yXDLncjzunFxbfUsYE6NjFlyieYs5oYQf6
	 3AMSBeZrSrKgX8iz9hhpXeSotDOKOhtEUzXwOZ7o3+iueYckzMikYmRANEAyympI+xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=BZ7XEh1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E6606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 06:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F6E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=BZ7XEh1O
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adfe77d336so7318491fa.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794550969; cv=none;
        d=google.com; s=arc-20260327;
        b=khvDQ/kPFzKcDC/G0beyK9MV3YmQm0IDxg93QDnX2dK/rHtpujcQIQZKCs2yH5B/rp
         u3BKfvfGEGd9sz++uZT5nQbHauEayTnBAROh3t3K/vgHvaIAIsR7EgEYxI8bDJ+P/dJ7
         DwGQRTJuLxSytA0qdEa1/qMJBMhezSOdUtMQM97ZYm7t6X0UM2wbhvZ8Ni6YKvKj+RcM
         xFUxnN8FfBJ91xPe4rFTmSKpsiuKT0NiNrcv4BxvvUjh9eN3KZA3JFKIpAwusCgrMwHC
         enH2eD1EKBDbKiBWAQ8PYGeW82z7DWubHgiB1puQYGFVnbyZXaGIgFELT2+8jkoURupL
         YyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        fh=1Bn4XNOdIBxVwRZpNSqVyDCZKfu2MMf02nnSADOJuRU=;
        b=H4phsWbP8aXPKVX0zy5pllR60JEVb0hVUnEreb+I9JyPzSPfbB54qvK21ytMNU35on
         RNdecvZtsrvObU25bFwqpwuRgCE0idbJY2zXdIIOd87ELIf5pZg504pAhb+66XMU22f2
         8J7DlOQZVqq+QoPs3w89oORJTMokCrZx9KDUS3fvLAuPP+ZedkbK+RMXbOIJY4VIkjZu
         nWCshb1XbQ6LumCNKwkwPj66ek/xKoQTkg2xfij4ecYbkmu62pLI1Vku5JapSPzIlgRe
         lHuEnn67jgPF1KZ4JtsQR7O68pf9yJYiWZCmFKIFUeHACrBBYK0GM2OPlTRPJKfQyPIY
         8VHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794550969; x=1795155769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        b=BZ7XEh1OUBU7AaigZZVIo7uWM6BGc7GFHVDN4uZTK8vSsBEo8lK90GCKY0GZTyfG71
         OzckKGZj5wCmtUZ8AAiLG+RkEgGbQk0MJg97uAjvABrNj8wLZBy2OhxvAXGJBGF7VkVY
         p7v5LVqRZIy0jILUFM7mituBmVZWCTbShH6m5ofC/gWKFtFpBNTAPnZiwZIh6/Ka4qxQ
         BEK19g/F4IOwjLrhFNrbeJhJqRUTUNx09f+37KXIGDlYUc+au7YObthQcCOdU3EvjcuW
         1arUwwt1SphY0qCfiBGtUmegDu0GbzNr7IprfbigT/yROyajzZEEkPTcWE7oQfcleKz8
         X2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550969; x=1795155769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        b=JTVf/w5PnltYKTexY/xaVAIu9AUBlZvuRjaYkQfa0ZLYFapKn5EygOX5X9Ms/4/6F9
         h9BmPImThyNUS2UDFF2qOlis9BPSDJkbrMelzLzGJpLBFL6W8fVMtrqLNApLNaUYOUsm
         fvFW9uEAim6G9zfB3/lfTkOPM3VMbBUoACm4Rz3ygeC0OukX1oypD796tyZq/J9GmlPT
         kes0Jwnd991XgET9LaLeGsVy3e+TBqLCZwrl1F/E7qtT8ceBwlcAVG2cSZfKXSx012qd
         dNKoGK0hv2jSLoOQpMDX2Y8DMRD3kq+FMCykSBOeC7/HPPTV1RcqA+zwjd/9Ik5y3x5C
         3h4A==
X-Forwarded-Encrypted: i=1; AL+hErH80DlP4u5sQ9XKeQEN6RLwcBwMkyqKtEOHM8+ZWBZlfYYwfwIzSE/806wp0HCwe/TM088=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KYsW5gv1i/fZQImYhD/FkR+811HL0pZ7zhdDM1obp3KEgVKnx
	/+he6VQK9hEo1ht+d24Jv9QR3G/UjMs7OHckOvSjTszI19FbuM+73cagKRsWt+ccvywSzEJ6GD/
	mkSJOTncpMoW1YPgr7d8CKX1aFt0foCZJtv05CgdNSOXyH8e3+uTqbBg=
X-Gm-Gg: AYBFou33hN3HXOOb/rgcnaVcYZW2TT4OkYbRijQxtu8JiO4IZThc2VuT1RYkTO6VOPg
	xR/hbMEQ/tkNAgXw//sSL0fyxzBgYHsU62kzRC5U/TIcgBb/KoG4FT9Z9Zi0PjH6cZbGAF5oI8F
	4hyY0aBJwjGFuCwg1KNNFogFlpwjrKVrjluF24XLmf96++s0n4QwARAsm2pBXUftoMiRc18T2si
	rKx4m0JIUIKDmD3xD2z7OhEZUCA7Tkgx7idXOGtYnKkGyyjlJuZv2tSXP+Y2YWoq8MSrV0f6h7q
	1We+PcqjDin/+OJasZCRxbNxQRzCh+gzRWoL3OlpVuideZ0mEEPazEnSl1kU7egng+Uhom1naYH
	4+on1AV69Tw2yw6iBViM3/udg1p1ZrJnBvGMV1xBzISL4d34Qy74Tgfxp40Wng+psWHHiC2moXH
	t6OKGQ8jLXhQzsnw0syM9NMxsRhVV/+mwxVD0Oh9hVozrgxYbXWjb37h7Nx8J4GSGFaxmC0rlqR
	bvgBA==
X-Received: by 2002:a05:651c:984:b0:3ae:25db:778e with SMTP id
 38308e7fff4ca-3ae2b4f8c44mr5983811fa.25.1794550969373; Thu, 12 Nov 2026
 22:22:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
In-Reply-To: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:52:37 +0530
X-Gm-Features: AclHuK8kJEX4JlRXb2KsetLnyCm5PUC-HVvhCYSR9hJmTyId-OXBRfW2YskwCEk
Message-ID: <CAAhSdy1vRrD17+a2-QLAqDiJd=S=H08n66x9hW+-NFQEKdU01g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix builds without CONFIG_RISCV_ISA_V
To: slack up <yxcnew@outlook.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <tchiu@tenstorrent.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:02=E2=80=AFPM slack up <yxcnew@outlook.com> wrot=
e:
>
> From: Xiaochun Yu <yxcnew@outlook.com>
>
> Commit b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context
> handling for kernel-mode vector") made the KVM vCPU load and put paths
> call get_cpu_vector_context() and put_cpu_vector_context()
> unconditionally.  It also added an unconditional call to
> __kvm_riscv_vector_restore() on the guest entry path.
>
> The no-op definitions of the first two helpers live in <asm/vector.h>,
> but <asm/kvm_vcpu_vector.h> includes that header only when
> CONFIG_RISCV_ISA_V is enabled.  The KVM header also does not provide a
> no-op __kvm_riscv_vector_restore() in its disabled branch.  As a result,
> a KVM build without CONFIG_RISCV_ISA_V fails with missing helper
> declarations.
>
> Include <asm/vector.h> unconditionally to reuse its existing no-op
> helpers, and provide the missing KVM restore stub when Vector support is
> disabled.  This does not change the Vector-enabled path.
>
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for k=
ernel-mode vector")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>

A similar fix from Zhanpeng Zhang is already merged.
https://lore.kernel.org/r/20260922021823.44251-2-zhangzhanpeng.jasper@byted=
ance.com

Regards,
Anup

> ---
> This single patch fixes a build regression when KVM is enabled without th=
e
> RISC-V Vector extension.
>
> Tested on base a804c5742bff (Torvalds master):
>
> - CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image modules build passed=
.
> - CONFIG_RISCV_ISA_V=3Dy, CONFIG_KVM=3Dm: vcpu.o and vcpu_vector.o rebuil=
t.
> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..ebc619ed67dd 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -11,9 +11,9 @@
>  #define __KVM_VCPU_RISCV_VECTOR_H
>
>  #include <linux/types.h>
> +#include <asm/vector.h>
>
>  #ifdef CONFIG_RISCV_ISA_V
> -#include <asm/vector.h>
>  #include <asm/kvm_host.h>
>
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
>
>  struct kvm_cpu_context;
>
> +static inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *co=
ntext)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
>
> ---
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> change-id: 20261021-ospp-c1-b4-submit-e22dc09faf5a
>
> Best regards,
> --
> slack up <yxcnew@outlook.com>
>
