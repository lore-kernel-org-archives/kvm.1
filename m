Received: from sg-1-30.ptr.blmpb.com (sg-1-30.ptr.blmpb.com [118.26.132.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7514C9F
	for <kvm@vger.kernel.org>; Fri,  6 Jun 2025 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749183300; cv=none; b=eDdzCMYbkoBj/NW4CFrNHs99sUDe/Bo1lwfHuGz6XaZ+YQasb0GiesgeFR0lgpc5O7mb9GAKSTCE2keKD7Buy1LSkJLu150KzANiHhHD4evwbBBZE4v6uzL7TIisVdCP6+jeV/hudxAGIJuZAMBsFIoI8ycrgLx+7Q2Gzx6WBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749183300; c=relaxed/simple;
	bh=IdexLD3eLQvA1s6fHt6lYm6nLYATX2RacfQTFZ/sCXs=;
	h=To:Content-Type:In-Reply-To:Cc:Message-Id:References:Date:From:
	 Subject:Mime-Version; b=NT6wmLwD2u3QO8y2dKrvH5fdf19Ie0RkM/YhbPDDUeMdMorUIQgBJslhi1iZjU5/v5BKUcSfbtZOpPWErp17tpMEyK49+8nsIefYO9o2zMOGcgBVkYfTetcc7ZJQNr0Z+mApSUKwBt1WsnMsDJK6YA4Xix+cH5wEcGDFpeic5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=tiKxe8Tl; arc=none smtp.client-ip=118.26.132.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="tiKxe8Tl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1749183289;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=bxW97WAtWMI/gihYEj6Ht7PAyVXQrYH3mCMOcOfQ04s=;
 b=tiKxe8TlLzaSpftlkKEpF8OWyyY6pKZ27yIdGyAK+Kbd6dB0QZNd5FxI6mAWs79O7n92/p
 IYsmuk7woUc/zMnRRRaAsh6vISLeElv+E+ct5C0DbxK087f70FtCmY5YUPEl+IL1e8jpjh
 27r/sNpvVacdHzVbRvb6fduyZRP8OCe/2eadEC7muBnieLplfYDUpAQY0nZLL5WOv5B10L
 lky+mWeHC2NzSpe0HxbSYQBia0v3fo2urov21PrA+IbZmlDZZM1Bez4q8gBgZXunYmbdVw
 G+TE4jiIp9vVneN9+4wetUjpAXuuPQHeKRdKRg0cXNkhJ3AElqSLQkWAmTh5jA==
To: "Anup Patel" <apatel@ventanamicro.com>, 
	"Atish Patra" <atish.patra@linux.dev>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250605061458.196003-5-apatel@ventanamicro.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, 
	"Andrew Jones" <ajones@ventanamicro.com>, 
	"Anup Patel" <anup@brainfault.org>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
Message-Id: <670cf57f-775e-43e1-abc3-189f3e0dc35c@lanxincomputing.com>
References: <20250605061458.196003-1-apatel@ventanamicro.com> <20250605061458.196003-5-apatel@ventanamicro.com>
Date: Fri, 6 Jun 2025 12:14:43 +0800
Content-Language: en-US
Received: from [127.0.0.1] ([180.165.23.184]) by smtp.feishu.cn with ESMTPS; Fri, 06 Jun 2025 12:14:45 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+268426b37+26deb6+vger.kernel.org+liujingqi@lanxincomputing.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH 04/13] RISC-V: KVM: Drop the return value of kvm_riscv_vcpu_aia_init()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On 6/5/2025 2:14 PM, Anup Patel wrote:
> The kvm_riscv_vcpu_aia_init() does not return any failure so drop
> the return value which is always zero.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_aia.h | 2 +-
>   arch/riscv/kvm/aia_device.c      | 6 ++----
>   arch/riscv/kvm/vcpu.c            | 4 +---
>   3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
> index 3b643b9efc07..0a0f12496f00 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -147,7 +147,7 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
>   
>   int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu);
> -int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu);
>   
>   int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 43e472ff3e1a..5b7ed2d987db 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -539,12 +539,12 @@ void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu)
>   	kvm_riscv_vcpu_aia_imsic_reset(vcpu);
>   }
>   
> -int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
> +void kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vcpu_aia *vaia = &vcpu->arch.aia_context;
>   
>   	if (!kvm_riscv_aia_available())
> -		return 0;
> +		return;
>   
>   	/*
>   	 * We don't do any memory allocations over here because these
> @@ -556,8 +556,6 @@ int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
>   	/* Initialize default values in AIA vcpu context */
>   	vaia->imsic_addr = KVM_RISCV_AIA_UNDEF_ADDR;
>   	vaia->hart_index = vcpu->vcpu_idx;
> -
> -	return 0;
>   }
>   
>   void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 6a1914b21ec3..f98a1894d55b 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -160,9 +160,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   	kvm_riscv_vcpu_pmu_init(vcpu);
>   
>   	/* Setup VCPU AIA */
> -	rc = kvm_riscv_vcpu_aia_init(vcpu);
> -	if (rc)
> -		return rc;
> +	kvm_riscv_vcpu_aia_init(vcpu);
>   

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

This seems more reasonable.
Thanks,
Nutty

>   	/*
>   	 * Setup SBI extensions
