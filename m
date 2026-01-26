Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2224113D;
	Mon, 26 Jan 2026 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393569; cv=none; b=QcU9thf9xkVFEeSC3Tmoxbks3cTK73xCiXZpD5mtB9unXCteMcjrVH9MXNRke2HUi8iKCuUiK2w0bHT6qhTqbeXSY5jqJ5S8qXfdrZA6B6Ad8dB9GSsZW7g6dn6aYG0RDu5cIh2OQ8kG2qAf8GBPIPAfJyeQS1HG+ULCntX9Wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393569; c=relaxed/simple;
	bh=BUM8C9hkjEGzOYKfxRu8J1XeZ8xVDt4sjCeOZKvu4Ww=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CG8EMLxt3MgYA1EWJpkfZwQkKLxJneNAc0J/03SyPHlpkbAMI9qvemiAI/xZSBLfnsOujs1LJ4S/uUtmMVNcm6zSC57+iMjWrhk5ANlLcVp/FmV1vfCCKrKlC78v2FVMoFeDxpJccdEQHqiXzIX8wX3NSbvXLKOqZLRPWA2gFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axz8OQzXZpgJUMAA--.41370S3;
	Mon, 26 Jan 2026 10:12:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxfcKFzXZp7TQxAA--.30120S3;
	Mon, 26 Jan 2026 10:12:23 +0800 (CST)
Subject: Re: [PATCH 1/1] KVM: Add KVM_GET_REG_LIST ioctl for LoongArch
To: Zixing Liu <liushuyu@aosc.io>, WANG Xuerui <kernel@xen0n.name>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 rust-for-linux@vger.kernel.org
References: <20260125054322.1237687-1-liushuyu@aosc.io>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4b504274-4241-0e3e-3ed3-7804b72b7ee8@loongson.cn>
Date: Mon, 26 Jan 2026 10:09:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260125054322.1237687-1-liushuyu@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcKFzXZp7TQxAA--.30120S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr4rurW3ArW7KF47ZryxJFc_yoWrGFyDpF
	W3C3ZIqrWFyr1Ik343ZwnxuF98Xrs2gw47ZFy3Ga4xAr4Yyr4FvF40krZrXFWrJ348CF40
	vF10gFyY9FWqv3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUA529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUShiSDUUUU



On 2026/1/25 下午1:43, Zixing Liu wrote:
> This ioctl can be used by userspace applications to determine which
> (special) registers are get/set-able.
> 
> This can be very useful for cross-platform VMMs so that they do not have
> to hardcode register indices for each supported architectures.
> 
> Signed-off-by: Zixing Liu <liushuyu@aosc.io>
> ---
> 
> For example, this ioctl could be used by rust-vmm/rust-kvm or maybe
> VirtualBox-kvm in the future.
> 
>   Documentation/virt/kvm/api.rst |  2 +-
>   arch/loongarch/kvm/vcpu.c      | 69 ++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 01a3abef8abb..f46dd8be282f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3603,7 +3603,7 @@ VCPU matching underlying host.
>   ---------------------
>   
>   :Capability: basic
> -:Architectures: arm64, mips, riscv, x86 (if KVM_CAP_ONE_REG)
> +:Architectures: arm64, loongarch, mips, riscv, x86 (if KVM_CAP_ONE_REG)
>   :Type: vcpu ioctl
>   :Parameters: struct kvm_reg_list (in/out)
>   :Returns: 0 on success; -1 on error
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 656b954c1134..b884eb9c76aa 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1186,6 +1186,57 @@ static int kvm_loongarch_vcpu_set_attr(struct kvm_vcpu *vcpu,
>   	return ret;
>   }
>   
> +static unsigned long kvm_loongarch_num_lbt_regs(void)
> +{
> +	/* +1 for the LBT_FTOP flag (inside arch.fpu) */
> +	return sizeof(struct loongarch_lbt) / sizeof(unsigned long) + 1;
> +}
> +
> +static unsigned long kvm_loongarch_num_regs(struct kvm_vcpu *vcpu)
> +{
> +	/* +1 for the KVM_REG_LOONGARCH_COUNTER register */
> +	unsigned long res = CSR_MAX_NUMS + KVM_MAX_CPUCFG_REGS + 1;
> +
> +	if (kvm_guest_has_lbt(&vcpu->arch))
> +		res += kvm_loongarch_num_lbt_regs();
> +
> +	return res;
> +}
> +
> +static int kvm_loongarch_copy_reg_indices(struct kvm_vcpu *vcpu,
> +					  u64 __user *uindices)
> +{
> +	u64 reg;
> +	unsigned int i;
> +
> +	for (i = 0; i < CSR_MAX_NUMS; i++) {
> +		reg = KVM_IOC_CSRID(i);
> +		if (put_user(reg, uindices++))
> +			return -EFAULT;
> +	}
CSR_MAX_NUMS is max number of accessible CSR registers, instead only 
part of them is used by vCPU model. By my understanding, there will be 
no much meaning if CSR_MAX_NUMS is returned. And I think it will be 
better if real CSR register id and number is returned.

Regards
Bibo Mao
> +
> +	for (i = 0; i < KVM_MAX_CPUCFG_REGS; i++) {
> +		reg = KVM_IOC_CPUCFG(i);
> +		if (put_user(reg, uindices++))
> +			return -EFAULT;
> +	}
> +
> +	reg = KVM_REG_LOONGARCH_COUNTER;
> +	if (put_user(reg, uindices++))
> +		return -EFAULT;
> +
> +	if (!kvm_guest_has_lbt(&vcpu->arch))
> +		return 0;
> +
> +	for (i = 1; i <= kvm_loongarch_num_lbt_regs(); i++) {
> +		reg = (KVM_REG_LOONGARCH_LBT | KVM_REG_SIZE_U64 | i);
> +		if (put_user(reg, uindices++))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>   long kvm_arch_vcpu_ioctl(struct file *filp,
>   			 unsigned int ioctl, unsigned long arg)
>   {
> @@ -1251,6 +1302,24 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>   		r = kvm_loongarch_vcpu_set_attr(vcpu, &attr);
>   		break;
>   	}
> +	case KVM_GET_REG_LIST: {
> +		struct kvm_reg_list __user *user_list = argp;
> +		struct kvm_reg_list reg_list;
> +		unsigned n;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
> +			break;
> +		n = reg_list.n;
> +		reg_list.n = kvm_loongarch_num_regs(vcpu);
> +		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
> +			break;
> +		r = -E2BIG;
> +		if (n < reg_list.n)
> +			break;
> +		r = kvm_loongarch_copy_reg_indices(vcpu, user_list->reg);
> +		break;
> +	}
>   	default:
>   		r = -ENOIOCTLCMD;
>   		break;
> 

