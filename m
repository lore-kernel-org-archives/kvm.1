Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A3481FA3
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372494; cv=none; b=dM8pt+BWQcHRfqe/MVEM5/z2RJSoV8Admr9MfZuzAjEVtaMePEvCSdKFAJiG9qKbj7qe3pfxmZ3Pp4xO9ZfYGOpyQQYGFFxF/FI04kmDsQItWnrJdDZHwSIXqv/P295EoW/eMq+Zvy1/89j/v2yXe/qCQ4EWgwnNbq17FiccviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372494; c=relaxed/simple;
	bh=UdNnpY1s0JZcKFf12kXtXKzQHcVo0VQb9ksp6zlj8eE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Fc1eHt44ekPSIbjycwaBdhrNQyW3F7bctYkdM47pIL9dBFpHukfVEI7nG/G4HOC2HdK7v4aakTTwJray1xQbPROtOfIq3tu3IEmrLO82RyBOWCGEq+g0kecEC1HWxumD8TTPu3m9tMyxzf3GLEycHfucSzsHeJCp85Q8+j5OMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNDwodD5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNDwodD5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b042c0759so1399394f8f.2
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372479; x=1791977279; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N25GKi4KKDEgKB7UY+JEtW1Q7H8cAQfRQt0G3e7XtJc=;
        b=PNDwodD5Nj/V0ABFD2g5pxFhA7H2qO1P2aLGNEFxnMEpIx+Z1mLUJDYEU6qvqcIYvk
         NK6IcunLmD+/ALwRUuOP2x6QzqlE69azXezUrc0/nc6AF5kJ+i6STcVw7kDOtal9KkRI
         GwxMbf31BVckUaCJJ/AKacuMTLVqGW9eg1QsOEAXMlimmSqWHKQSWlu+Q6KLeWJymb8H
         BoNJ7oYgABE7eh6eQcIj1vD4ctRr6gk7SUC+JA81J+vYFwC+/YAIcAsAVOKbX7ZLQxjA
         mrdUnghqy4Gk4ghHFUjwfhJ/Je3z1zyQERc1zYNH9njmjjW6Mn09G7JMXnxWacOkrySb
         ELxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372479; x=1791977279;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N25GKi4KKDEgKB7UY+JEtW1Q7H8cAQfRQt0G3e7XtJc=;
        b=ICanfAVEcS0TVHkH8p5TTTDVagB8TN4NqF9Ssy7oIsSV3WjilVg6cY+qKM/bgCiXEz
         B3tvR8p+n7n0mKYrkWyHDpAMBBbCWbiM5Q0IQOCyoCdooPuddmw4nvdwH5luDSA6HKy9
         G5rrrruKC2RyQfMiy7420sP6ySgVGMvKcdyjjSxof+sgNJ3aSQFECmOF2ROVqxdTuXsj
         a5dFdnvGWYYBAN83+qrJ0oINOyA34H27tvOJeoaWJjYHSJBJpnPVGTUux3eV6mG8cMnZ
         RRklfkrvgT3Na6AX+pPGOubyEUuLanQ7voCLdFNUBwd6E+5LivT1H9rQzxTzYWiVIf3I
         CV2g==
X-Forwarded-Encrypted: i=1; AKwUvBzXcCC7HQTQIyvtjBa4LijpIdWIi2brJO243qC3D5CBzvOsNYS4lXT3C4gXezhwUAi1fr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyfe1nGgxL56xtYzOizXAZw5joqI9Sga0TQZw6mh6NTU29mHn2
	Jrw6lziP02nLVbhsy0KLaoF+ZAL4XymLfxmnLVZoVp31sGrwLHtCmFhD
X-Gm-Gg: AYBFou3yCDfBe0/gmx2mvJtQ9QDVM4j9db7pA6kzz7ouXPlUvH8uvtmytTCBF5Wg/yL
	rrtKQOaIV6iVCLPVoXNn3Jk7C2xMUfpq7lW5MsPCLBHmJzDM/d3/pFWv6D6lk4H8L47F50JUVZl
	vmyx0zquuQE3rRBTA33QPgXvx4Gse17HIEZ7nLZRoxQgqxwhH9wP13kBNMsguiABrEgg8Ku+zJY
	Ntu6Pb/Xkv4Z//uGuCNsiC+kNeGpFMN8QFNySEGRXshq0frF6RcdVDVDhqqxoCSzRoXeN3BXmsz
	FMG9VJcveSNCvlQ/a5ZOW/Psavs929GxTmZwZYXXdH2874dl9C/nrX9/VrEzxlyD+xy6P/8faSI
	Tnp9y9VlJF5sBiPrGAPaVDvhGvdnlnrVBn8nmqNFiKn3CbcbED7GKCO+BGmfUz0Ma/0jqbxNf5Z
	WKpG1jkaZ2OJa8rg0qRneWuAnSHP5VU+GI7eVrjMe6+V53UdFBmFTuQgN0MwtH/meDtM52Ccehj
	ug7DweAfNDaD8Q8U3a2yuCKTu2Sl201K7AwCghUOPDF5YdT0X6ze27eM7rHQm60Qg==
X-Received: by 2002:a05:6000:46db:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48c7275ad2fmr2408703f8f.18.1791372478783;
        Wed, 07 Oct 2026 04:27:58 -0700 (PDT)
Received: from [192.168.141.88] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d22ec8sm4631673f8f.39.2026.10.07.04.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] RISC-V: KVM: Fix build with vector support disabled
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Andy Chiu <tchiu@tenstorrent.com>, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
In-Reply-To: <20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com>
References: <20260922021823.44251-2-zhangzhanpeng.jasper@bytedance.com>
Date: Wed, 07 Oct 2026 04:27:55 -0700
Message-Id: <179137247589.137225.11125498978893340639.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791372478; l=2180;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=UdNnpY1s0JZcKFf12kXtXKzQHcVo0VQb9ksp6zlj8eE=;
 b=N4/1k9PAIKC/zlNc3SD1Pn/ya7soMKpi9nQoq3x35ys4TSjiRf8v2bkGSSm8YfelPHY4YVtCW
 JtOp7Fsds4lASn3a2Wb2XWeDh7BhMwE9O2EQTUj58BfxxJ+9qr0myJF
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

> The kernel-mode vector context handling added unconditional calls to
> get_cpu_vector_context(), put_cpu_vector_context() and
> __kvm_riscv_vector_restore() in vcpu.c. With CONFIG_RISCV_ISA_V=n, these
> calls fail to build due to missing declarations.
> 
> The get/put helpers already have no-op definitions in asm/vector.h, but
> kvm_vcpu_vector.h only includes that header when CONFIG_RISCV_ISA_V is
> enabled. Include it unconditionally and provide a no-op implementation
> of __kvm_riscv_vector_restore() for the disabled configuration, matching
> the other vector context helpers.
> 
> The paths that set RISCV_V_VCPU_NEED_RESTORE are compiled out when vector
> support is disabled, so the restore stub does not discard any live
> vector state. Keep it __always_inline for its noinstr caller. The vector
> enabled implementation is unchanged.
> 
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector")
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

I sent a patch before checking the lists, we can ignore my patch [1] since
this fixes it!

[1] https://lore.kernel.org/all/asWHSd31uyyNvt0a@blinky/

>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..50d4789b9cac 100644
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
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
>  
>  struct kvm_cpu_context;
>  
> +static __always_inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *context)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

