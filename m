Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003B3D6CB0
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330126; cv=none; b=UwjrUnVv8Q58udZmEt75XD76R3EEPfIvPgibN5Ni5zYQoqOKX3XKSA8UOLQC3gywAjXu+lu0mvWL6XHuE2/UjnMlBudW1NDLy9qU6gDr7i2HmJVWma5yBXVBLJeLr9TMgUHignLZ8MbgS0u2UN/z0dgtEIQ981n+4OrDsTL8dFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330126; c=relaxed/simple;
	bh=IxHD8EsJvKBJ4mWzOOAhpewIyTVODpY0N6LJF3B0ba8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdWxRgtPT27o8//B/q/4141XfDhTgxMRObR+DBylBvAAU2cSc+QRw5XbpPMnk53S3pdGhVfU56IwGfE+M3n61G0vB+dsncambASZfUFugVC02S8QfWwMRNd8mEWhSYiXun5tEA9pCE5pwn40nGWSA7/wFvDsa3FgVCeMaeeWJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsVW46BD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsVW46BD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a168355946so11384165e9.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791330123; x=1791934923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xtl9xeh/w1n1/842SeGkR83P1qgAjaMld+9slL7tN5Y=;
        b=lsVW46BDC8HTcKESMKOwBYpYB+Luef+Krku/nfpPysjl1bjIQ578wnHi36+99Mx1q9
         pf6KX1v4tPyzAiaUc1+yTVoWo34uWg9C50iIU2CbTyDD0t2iYueS1Uv69JQMoTEXJ/51
         lRYdRqNQX06PCAQt0ouvn1IP/m7ayhiSWa2/gDTKUrq32xbOuaVNl4WOZRwZU1cXsHNk
         KLLnQ25S/ECfC4xYtjyPAb45DTekSBdpKzISg+tm3LF+oSN34IKI5XgXYiP496hr9hsV
         Zzl7RAcDhLE7r92dC3DnUXsRJVxBAnqduoI0mhByVxyMnBybLgm4tXsZtlV54vCtWHkX
         mfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330123; x=1791934923;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtl9xeh/w1n1/842SeGkR83P1qgAjaMld+9slL7tN5Y=;
        b=fRJVDA9gnjiWbvdG/ikCa043Q3RHSEME9/KTzNrQ+S7xdaRbVMXuis8Cxs3MP50XxT
         Qnc/cOsnrhdcBdR1Vqj/rz6TSU/BEUXBJBgifUOJwOZRIqWSWsM6GfCEMmjf2akNWJ97
         yKyqkUzn02M49AES7mM316YqzdRBzP0IenEvfUOkE/kGxrjAyXmpajkJXKx915ZRzY92
         L36RvS5jVMJxxSXDHMJR/mtDrK/taTSnE6/Il2HK9pMtk4WR12wGD2qdVJ3bhvzNm0af
         o56woxs7gOT5eixfK3gFNDWI3di/k678sPOTmx6vCY1PVfCmkoCxnKGl2dJ+ouKUNU9x
         Bw1g==
X-Gm-Message-State: AFuF++kn/q9CtjdRi1h/LwLEVQHcBjZpj17ZsHA7EYB7Qb5Xp6wBeOf1
	dkYZRJFDvYJJ8EiNDUN41xF2Nty1NfV/ci9fMvlgmpbsLgLRaUdGHtgE
X-Gm-Gg: AYBFou1sOAVRYZ0m5B8dQoNmVYpqg2vw2fK1NXMyyjZo6XdLHECut6siy/HRCQ1Hxuh
	elDk5t8lSUiAWp+GxATmWmGC9oELJ+ku+JvPKTlW3ZzF06xYa6zSbmDe2U+1DRgg26MWWFXed0T
	9QPzW0tXr0QmGKN5NWmDqOF+HMUvItuW73tcJbsKHPwF0FzTSO11mHMPwy1rbW41FzqaSxOjH31
	byy+HQf+erNK8D6K3+P0cPb8qqjBDR2yGKLkO4tENn/Y6ZdGBdqZh/tWt/WKXhLiGiOisn1S6bz
	BPocXei9u8Hf9itHXUc4mxiRedgS32GJdMKmF24c9i0pZLud/yZU3ovTN42SljNuSUZZjRICO8f
	3dg1mkCTK5AlmrpyDZbj5l4RaNgjKKYVWRdULpKoQsfExAwqnEnLstWihVhlRg9UTTBzxeV5mvQ
	TMHGg1cb5/qdOco47BMpsz3HXVmaZb5qvR8UOPOSKeFQNHlOYyTbVrF9rS+dLeU7qaZCNoXtHlr
	XOycHXQbcxpkI7FAnhsycy9mkH7kpU=
X-Received: by 2002:a05:600c:1e17:b0:49d:2562:d670 with SMTP id 5b1f17b1804b1-4a180310dc1mr5435555e9.14.1791330123255;
        Tue, 06 Oct 2026 16:42:03 -0700 (PDT)
Received: from blinky ([81.0.216.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53997sm153565635e9.12.2026.10.06.16.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 16:42:02 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:42:01 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Andy Chiu <tchiu@tenstorrent.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: KVM: Fix compilation when CONFIG_RISCV_ISA_V=n
Message-ID: <asWHSd31uyyNvt0a@blinky>
References: <20261006-vector_off_fix-v1-1-9e48e654d445@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-vector_off_fix-v1-1-9e48e654d445@gmail.com>

On Tue, Oct 06, 2026 at 04:39:03PM -0700, Charlie Jenkins wrote:
> Fix the KVM code to use stubbed out versions of vector functions when
> vector is not enabled instead of failing to compile. An alternative
> approach would be to ifdef out the vector code but since a handful of
> the vector code already just uses stubbed functions to tell the compiler
> to drop the implementation, follow the same pattern.
> 
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector")
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Should have looked at the lists first, this wa already sent
https://lore.kernel.org/all/20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com/.

> ---
> I was reviewing [1] and noticed that when I disabled FPU and tried to
> compile that vector got disabled and the kernel failed to compile.
> 
> [1] https://lore.kernel.org/all/20261006075303.205216-1-radim.krcmar@oss.qualcomm.com/
> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..1c9efc6048bb 100644
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
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_context *context)
> @@ -55,6 +55,14 @@ static inline void kvm_riscv_v_exit(void)
>  
>  struct kvm_cpu_context;
>  
> +static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_context *context)
> +{
> +}
> +
> +static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
> 
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261006-vector_off_fix-938d61b1f906
> 
> Best regards,
> --  
> - Charlie
> 
