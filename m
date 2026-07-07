Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281C14A60F
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392412; cv=none; b=odXq6rsnIPTe7oa9cWYm0HGpdCcCAgTvCVEmZ04FWaOc93mgHJSBnNf9efBdK0Trafpf6Am1Qhn2z2jylfCy6VIxnmyXgUYU44SWraDtU6Si2pib01h4uyEqDSYnu01T8qKTRM7ldpWNDtSOX+2JIBaF5qU8LRGNLEyUnjDOwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392412; c=relaxed/simple;
	bh=lRiqjFf04MnEC+CrmqPUzkUqYQMTfmDEzEzuWOONfT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpIf51dANKibrOSsr1PxvRkuzXHKH3LBipLAXx565TbQi7xAjJO4ZJAkuQ2gVUAVPYFmPw3+7D8zWxuzesyQa6tw/tCHaLq86vNY6JwlpeCeirJn6lPyNuBnrzbZTp79cyK0x6tMyrKVxZwh59fvdicnTLrVkmBD43TgnFjf4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDsAD6Kx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDsAD6Kx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacd69a9c0so31182305ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392410; x=1783997210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2/fxWwb3oyYd4m0R5LKJRcZCrGk+3eTcmW2x4VDQgPg=;
        b=BDsAD6KxirLL0qGoYEXFCqLKLNnSa5iMzZt7cuYXFejWM5k/kp69XRlpxCBAGDba/Y
         QhIrc46poUQi44POpxWJRdvThb+P7z3IZoHcOypPMmRBD1F2NOlGQDrmlHv546bBFEnU
         SzQ6XQS46WZqvoYGfgiKjBHQTl2MA5MSqERJF7y6dFYmZtoRp6PT+hlTZdktDkiHYJHt
         1K3gv7xWYAlGN9AXA+5PcT3IeI62cLKI22idEeYWjAT6+648VO+kUOizNfb3rKNlNZ/p
         m7BqAHfrl6l9S9Pylr6egk7Eb3nB0YcEQWdJg2J0nyFWotfuFcB6z5wbXGqT0V6ekVje
         fuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392410; x=1783997210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/fxWwb3oyYd4m0R5LKJRcZCrGk+3eTcmW2x4VDQgPg=;
        b=lyo/KSANqGmLsNLTyHuvZ1lXDX58c4B7+fJQEcfmf+ZWfVCBcWDBCiDHW15foe14KF
         pvy+ptUCZPOwcIhJokVswxkv3tqzuuc0BMPIbVpBlOdTsH37dXZQaUcFvl57LlEcNMbz
         tAwEsMkr4UZqw14dPQk3WiRDgP5YC4jfHm5CIqB58pRuYaQgktu8L+MCq/0/S082y7gn
         8roFrNWnFOTxrDDUhh5cyayBvK75XDTiGpaRbSaSYy4neDQh5damKbCTqGnFOTbZJF8G
         FgvoSoCVMyn7jXRLJXwj0b0zTB+weAuOygKBWB3JqFTo01kQPdWx85H9cK6JDGmHDygN
         R0qg==
X-Forwarded-Encrypted: i=1; AHgh+RpTts5lBM8T6V144rZxcMncbV/Gnq73Q+w2ph5NEFVZINfJ2RxJaIlKhbJiDKFyOqNe4EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjmUsb9DpwZ6jgf0SFpshmL0s8i9Me9EgByOF5MzgALbASqeH
	OvQtPWOMVD1n8wCPfLrtQknJerWkGtKmHt5Snhzb0TyyePFWuAXIfTCg
X-Gm-Gg: AfdE7cl/IZGIYfKRsDxE4dvC6B+GwTgg4Ansuz3lGZ/3aGLPn0Sm629FavGxsy5VzZ1
	+jlK9jBZrrpqE/XgX3IWVZ5Aw0o0NMiySOLKXeS2btnBiQEKV/jtu5Ely6VZG+0JOVtt5gO7WaO
	fDf6865D1GmdHcchQrQ14kwBCQ5wjM4pIDOiqOQT7k7jlnOuISov5pLMszSfsYhUDA3SRPnB//p
	gG0oByqOkH0htV2YkT93FqQszGZvNYtyWAIXHc99GKmrFnufhA7JvdmntF4jZCHF9dZrvy5BUyX
	8Qrp6Y+B0XbBni0zsNqyzesu/J2zeIeL30/btKrQn7g6ce78ddkfvSZtJFeLyLT3XTXppBAKE02
	RI0oZHHyyW+R84d1I6qL+6T5phX2OO5Sry0mDiN0eeX1SviEoijf2AhD7fqHNg1Pa
X-Received: by 2002:a17:903:1a0e:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2ccbe618242mr29826855ad.20.1783392410361;
        Mon, 06 Jul 2026 19:46:50 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfd443sm3388815ad.30.2026.07.06.19.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 19:46:49 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:46:14 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sergey Matyukevich <geomatsi@gmail.com>, Thomas Huth <thuth@redhat.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Deepak Gupta <debug@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v5 1/8] RISC-V: KVM: Add support for Svadu FWFT features
Message-ID: <akxm_sT7R9u4OIXo@inochi.infowork>
References: <20260706022046.214956-1-inochiama@gmail.com>
 <20260706022046.214956-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706022046.214956-2-inochiama@gmail.com>

On Mon, Jul 06, 2026 at 10:20:37AM +0800, Inochi Amaoto wrote:
> Hardware updating of PTE A/D bits is controlled through ADUE bit in
> henvcfg Expose the feature only if both Svadu and Svade are supported
> for VS-mode.
> 
> Allow the VMM to enable/disable this feature by change the ISA
> extension state in the guest.
> 
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h |  1 +
>  arch/riscv/kvm/vcpu_sbi_fwft.c    | 77 +++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 504e73305343..7bbea8812d92 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -240,6 +240,7 @@ struct kvm_riscv_sbi_fwft_feature {
>  struct kvm_riscv_sbi_fwft {
>  	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
>  	struct kvm_riscv_sbi_fwft_feature pointer_masking;
> +	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
>  };
>  
>  /* If you need to interpret the index values, here is the key: */
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> index ab39ac464ffd..01db40b53295 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -11,6 +11,7 @@
>  #include <linux/kvm_host.h>
>  #include <asm/cpufeature.h>
>  #include <asm/sbi.h>
> +#include <asm/kvm_nacl.h>
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/kvm_vcpu_sbi_fwft.h>
>  
> @@ -94,6 +95,45 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
>  	return false;
>  }
>  
> +static void kvm_sbi_fwft_env_flag_reset_helper(struct kvm_vcpu *vcpu,
> +					       u64 flag)
> +{
> +	vcpu->arch.cfg.henvcfg &= ~flag;
> +}
> +
> +static long kvm_sbi_fwft_env_flag_set_helper(struct kvm_vcpu *vcpu,
> +					     struct kvm_sbi_fwft_config *conf,
> +					     bool one_reg_access,
> +					     unsigned long value, u64 flag)
> +{
> +	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
> +
> +	if (value == 0)
> +		cfg->henvcfg &= ~flag;
> +	else if (value == 1)
> +		cfg->henvcfg |= flag;
> +	else
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	if (!one_reg_access) {
> +		ncsr_write(CSR_HENVCFG, vcpu->arch.cfg.henvcfg);
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			ncsr_write(CSR_HENVCFGH, vcpu->arch.cfg.henvcfg >> 32);
> +	}
> +
> +	return SBI_SUCCESS;
> +}
> +

Hi, Anup,

The sashiko bot point out calling NACL helper is not safe here as
preemption is not allowed when calling this_cpu_ptr() and it is 
used by the NACL helper. Since I have no idea about how to fix it,
is it acceptable to use csr read/write directly here as other FWFT
feature?

Regards,
Inochi


The original reply from the bot is 

Is it safe to call ncsr_write() here without preemption disabled?

KVM handles SBI ecalls with preemption enabled. The ncsr_write() macro
evaluates nacl_shmem(), which relies on this_cpu_ptr(). Using this_cpu_ptr()
with preemption enabled will trigger a CONFIG_DEBUG_PREEMPT warning.

Could the thread be migrated to another CPU after computing the pointer but
before writing to it, resulting in per-CPU memory corruption by writing to
the NACL shared memory of another physical CPU?

Additionally, when NACL is disabled, it falls back to csr_write(), which
writes directly to the physical CPU's host CSRs (CSR_HENVCFG). Could this
leave the host with modified hardware state if the vCPU thread migrates?


> +static long kvm_sbi_fwft_env_flag_get_helper(struct kvm_vcpu *vcpu,
> +					     struct kvm_sbi_fwft_config *conf,
> +					     bool one_reg_access,
> +					     unsigned long *value, u64 flag)
> +{
> +	*value = (vcpu->arch.cfg.henvcfg & flag) == flag;
> +
> +	return SBI_SUCCESS;
> +}
> +
>  static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
>  {
>  	return misaligned_traps_can_delegate();
> @@ -137,6 +177,34 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
>  	return SBI_SUCCESS;
>  }
>  
> +static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
> +{
> +	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
> +		riscv_isa_extension_available(vcpu->arch.isa, SVADE);
> +}
> +
> +static void kvm_sbi_fwft_reset_pte_ad_hw_updating(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_sbi_fwft_pte_ad_hw_updating_supported(vcpu))
> +		kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_ADUE);
> +}
> +
> +static long kvm_sbi_fwft_set_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +						struct kvm_sbi_fwft_config *conf,
> +						bool one_reg_access, unsigned long value)
> +{
> +	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
> +						value, ENVCFG_ADUE);
> +}
> +
> +static long kvm_sbi_fwft_get_pte_ad_hw_updating(struct kvm_vcpu *vcpu,
> +						struct kvm_sbi_fwft_config *conf,
> +						bool one_reg_access, unsigned long *value)
> +{
> +	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
> +						value, ENVCFG_ADUE);
> +}
> +
>  #ifndef CONFIG_32BIT
>  
>  static bool try_to_set_pmm(unsigned long value)
> @@ -246,6 +314,15 @@ static const struct kvm_sbi_fwft_feature features[] = {
>  		.set = kvm_sbi_fwft_set_misaligned_delegation,
>  		.get = kvm_sbi_fwft_get_misaligned_delegation,
>  	},
> +	{
> +		.id = SBI_FWFT_PTE_AD_HW_UPDATING,
> +		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pte_ad_hw_updating.enable) /
> +				 sizeof(unsigned long),
> +		.supported = kvm_sbi_fwft_pte_ad_hw_updating_supported,
> +		.reset = kvm_sbi_fwft_reset_pte_ad_hw_updating,
> +		.set = kvm_sbi_fwft_set_pte_ad_hw_updating,
> +		.get = kvm_sbi_fwft_get_pte_ad_hw_updating,
> +	},
>  #ifndef CONFIG_32BIT
>  	{
>  		.id = SBI_FWFT_POINTER_MASKING_PMLEN,
> -- 
> 2.55.0
> 
