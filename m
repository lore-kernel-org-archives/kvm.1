Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6119E96D;
	Fri, 14 Aug 2026 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669746; cv=none; b=mH5EUCK74JzM/rCJtLcSjdlT1WnzdTz7WNOw4Riyq7SiInOuV9UVsRiqOrwub6ZbF9km1fw4WSn1S29MTOoKd8JlUVrbJVjNdZS5l1Uoibil/dwVk/60cdGBchB65wWv7AFUVMZ+LVSKEMIolG1nEFs5XoBV/2aDvZD+W5sH5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669746; c=relaxed/simple;
	bh=w64a7Z4GIJBQMHHeEWLAsXt+Pf8BkxyVv0y+3bYbrwU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gd2aX0kwUXHpIfj7CpP3CpHsya1INHhsIvflHJ21Eeg+4L6d0E6lPUZ/pcfkVRfiPQbLxYRCCWPqLF4ctvGID71y4+RBswxkrvIqO3nwbBMsMeaa/1GQxZCWEicjkttPgThZhWF+gud80jnYGN/am1y5y+3lgmm0/9m8FRWbu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxntKtan5qNhYBAA--.3349S3;
	Fri, 14 Aug 2026 09:09:01 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxTs+oan5qzREEAA--.26901S2;
	Fri, 14 Aug 2026 09:08:59 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: KVM: Fix TOCTOU race on pv_features
To: Tao Cui <cui.tao@linux.dev>
Cc: zhaotianrui@loongson.cn, chenhuacai@kernel.org, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260813232542.2098930-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d26fdd03-dcfe-8ae0-d925-d121866e566d@loongson.cn>
Date: Fri, 14 Aug 2026 09:08:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260813232542.2098930-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs+oan5qzREEAA--.26901S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWkGFWfJFWfuFy3tr1DJwc_yoW5Jw1fpF
	9ruF95JrWrGr1xAF9rtwn09r4UZw48Gr4aqFyY9a48AF1agr9xZr10yFZrZF4qq3y09a97
	WF1ftas0van0v3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2026/8/14 上午7:25, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The check-then-set on kvm->arch.pv_features in
> kvm_loongarch_cpucfg_set_attr() is lockless, so two vCPUs can race
> past the validation and set different values.  Add a spinlock to
> serialize it.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
> 
> Changes in v2: use a spinlock instead of a cmpxchg loop (Bibo Mao).
> Link: https://lore.kernel.org/all/20260810081321.157258-1-cui.tao@linux.dev/
> 
>   arch/loongarch/include/asm/kvm_host.h | 2 ++
>   arch/loongarch/kvm/vcpu.c             | 6 +++++-
>   arch/loongarch/kvm/vm.c               | 1 +
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 23cfbecebbd7..cdbbd90e0584 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -128,6 +128,8 @@ struct kvm_arch {
>   	struct kvm_phyid_map  *phyid_map;
>   	/* Enabled PV features */
>   	unsigned long pv_features;
> +	/* Serializes pv_features updates */
> +	spinlock_t pv_features_lock;
>   	/* Supported KVM features */
>   	unsigned long kvm_features;
>   
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..551ed39b2d1f 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1165,10 +1165,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>   			return -EINVAL;
>   
>   		/* All vCPUs need set the same PV features */
> +		spin_lock(&kvm->arch.pv_features_lock);
>   		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) != val))
> +				&& ((kvm->arch.pv_features & valid) != val)) {
> +			spin_unlock(&kvm->arch.pv_features_lock);
>   			return -EINVAL;
> +		}
>   		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
> +		spin_unlock(&kvm->arch.pv_features_lock);
>   		return 0;
>   	default:
>   		return -ENXIO;
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..b984cc54f305 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -76,6 +76,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   		return -ENOMEM;
>   	}
>   	spin_lock_init(&kvm->arch.phyid_map_lock);
> +	spin_lock_init(&kvm->arch.pv_features_lock);
>   
>   	kvm_init_vmcs(kvm);
>   	kvm_vm_init_features(kvm);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

