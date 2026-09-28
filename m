Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80419332638;
	Mon, 28 Sep 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568488; cv=none; b=j5nIeutoNF4dEyASPd3gywOwuVuRwmIT0E2ttHS2+q2bvBFHBAfbzbPsW9dVn6d2a3VxiKX/dkapbdAJUfojrWEn4ifI7Df8Un9Zg4uTahlbKRBeVhulU5Ay5kLP0J8GOpsZo4Uwj5PkrtU+lG3ioPfZmp+SiQSdWwUDteIckig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568488; c=relaxed/simple;
	bh=Ch0HBzW6MmJQnnO350wpH+dXfM0Nv71aaBGupaQEktw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E6h3ErWS3IgbjF91NOeYu5JI4LRfRjwMR4livAAxXgc/M3RzUQ2z6iB6z8rc0U2jqd7ZKMyEAzGgV1XaBsmkhEdtbMStwTE51l+eJx9zC0XR0I1ncBDKkXSZcYUWAa0aVIjvwodyg4GHjnWv7sfF7MyvXKL+p5zWwb7mUiZ0EPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxYdGt57lqvF8QAA--.48337S3;
	Mon, 28 Sep 2026 12:06:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxBc2s57lqqu8lAA--.52758S2;
	Mon, 28 Sep 2026 12:06:04 +0800 (CST)
Subject: Re: [PATCH 1/6] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
To: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8c68712a-c210-ce43-af5e-e69e0e5d538c@loongson.cn>
Date: Mon, 28 Sep 2026 12:07:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260927075240.3007947-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc2s57lqqu8lAA--.52758S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry5CF1xArW3tFy5JF45twc_yoW5KF13pF
	Wruas0kr4rWr1DXFZrZ3WDWr4jvFsagrySga4jvFyUCFnIqFyrJ3W8Ar9rAFyDu3y8Cay0
	qF1fK34Fv3WUAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=



On 2026/9/27 下午3:52, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The destroy callbacks of the four irqchip devices free the device
> structure without clearing kvm->arch.{ipi,eiointc,pch_pic,dmsintc},
> leaving a dangling pointer.  ops->destroy() is not only called at VM
> teardown but also when KVM_CREATE_DEVICE succeeds and the following
> anon_inode_getfd() fails (e.g. under RLIMIT_NOFILE); the VM stays
> alive, kvm_arch_irqchip_in_kernel() still reports true, and interrupt
> injection dereferences the freed device.
> 
> Clear the pointer before freeing.
> 
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Fixes: 2e8b9df82631 ("LoongArch: KVM: Add EIOINTC device support")
> Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
> Fixes: 229132c309d6 ("LoongArch: KVM: Add DMSINTC device support")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/dmsintc.c | 5 ++++-
>   arch/loongarch/kvm/intc/eiointc.c | 1 +
>   arch/loongarch/kvm/intc/ipi.c     | 1 +
>   arch/loongarch/kvm/intc/pch_pic.c | 1 +
>   4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
> index 89f980d867be..63072595c01b 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -161,11 +161,14 @@ static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
>   
>   static void kvm_dmsintc_destroy(struct kvm_device *dev)
>   {
> +	struct loongarch_dmsintc *s;
>   
>   	if (!dev || !dev->kvm || !dev->kvm->arch.dmsintc)
>   		return;
>   
> -	kfree(dev->kvm->arch.dmsintc);
> +	s = dev->kvm->arch.dmsintc;
> +	dev->kvm->arch.dmsintc = NULL;
> +	kfree(s);
one line patch seems better here such as:
+	dev->kvm->arch.dmsintc = NULL;

Regards
Bibo Mao
>   	kfree(dev);
>   }
>   
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index 80f78e07c74a..fe0a1918f26f 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -675,6 +675,7 @@ static void kvm_eiointc_destroy(struct kvm_device *dev)
>   
>   	kvm = dev->kvm;
>   	eiointc = kvm->arch.eiointc;
> +	kvm->arch.eiointc = NULL;
>   	mutex_lock(&kvm->slots_lock);
>   	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
>   	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 7b333a4a0430..6ee90c10827a 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -444,6 +444,7 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
>   
>   	kvm = dev->kvm;
>   	ipi = kvm->arch.ipi;
> +	kvm->arch.ipi = NULL;
>   	mutex_lock(&kvm->slots_lock);
>   	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
>   	mutex_unlock(&kvm->slots_lock);
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 2b63b0c2c7ce..62c09b5f3937 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -483,6 +483,7 @@ static void kvm_pch_pic_destroy(struct kvm_device *dev)
>   
>   	kvm = dev->kvm;
>   	s = kvm->arch.pch_pic;
> +	kvm->arch.pch_pic = NULL;
>   	/* unregister pch pic device and free it's memory */
>   	mutex_lock(&kvm->slots_lock);
>   	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &s->device);
> 

