Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA32820AC;
	Fri, 16 Oct 2026 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112531; cv=none; b=awKP5do7WrFwuYvScf8SY/NwWqRwT0CijnI1BcP7tUHZfOzuBrg/zVJjqOw+L7j02Q1nbH9JSMVB0TXMgeQ+1LVUuxIX5CLrt/vqCM2690dbj6sjCvHfJiftxSfdAOCqZqr2+YQLD4XALxyiQPhihs02D2w0WGugn5G5/La9ykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112531; c=relaxed/simple;
	bh=PHw2ocoZ4ZqJHQ290VNc8rnqGBq6RJZ6SBSoWHJyDOA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S5bimLmdYCd+7f09jzIdqjph0yBJSb6Zw1c8Blh8T7Gs3oFKg64J7P3N6ctH0F06Jppt06F0G+P4dW/Q7KGYUoU2fVPryrJmidCmwKGLm18AarD8AYYLlu/Bv7qMJ4+XeJZRNFNcGeEiNbF0/Y28ZudkUJ+TFZEhcSh2NnPAX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bxb9OOd9FqQ1QWAA--.64852S3;
	Fri, 16 Oct 2026 09:02:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPs+Nd9Fq_+osAA--.28582S2;
	Fri, 16 Oct 2026 09:02:05 +0800 (CST)
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Clear device pointer in irqchip
 destroy callbacks
To: Tao Cui <cui.tao@linux.dev>, chenhuacai@kernel.org,
 zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
 <20261015234638.1077815-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f0eba7bd-61c6-d63a-abc3-9b50ebe62338@loongson.cn>
Date: Fri, 16 Oct 2026 09:03:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261015234638.1077815-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs+Nd9Fq_+osAA--.28582S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr43tr4kXFW3AF4Utr47Awc_yoW5ur4DpF
	W5C3Z0kr4rGr1DWFZrZw1DWr4j9Fsag34Sga4jvFyUCFsIqFyrJF18Ar9rAa4qk3y8CFW0
	qF1fK34Yva1UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==



On 2026/10/16 上午7:46, Tao Cui wrote:
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
> Clear the pointer when destroying.
> 
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Fixes: 2e8b9df82631 ("LoongArch: KVM: Add EIOINTC device support")
> Fixes: e785dfacf7e7 ("LoongArch: KVM: Add PCHPIC device support")
> Fixes: 229132c309d6 ("LoongArch: KVM: Add DMSINTC device support")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/dmsintc.c | 1 +
>   arch/loongarch/kvm/intc/eiointc.c | 1 +
>   arch/loongarch/kvm/intc/ipi.c     | 1 +
>   arch/loongarch/kvm/intc/pch_pic.c | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
> index ff327b4c05f7..c182185a3d59 100644
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -146,6 +146,7 @@ static void kvm_dmsintc_destroy(struct kvm_device *dev)
>   		return;
>   
>   	kfree(dev->kvm->arch.dmsintc);
> +	dev->kvm->arch.dmsintc = NULL;
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
> index 80faa770c0cd..7a2dd72a4952 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -441,6 +441,7 @@ static void kvm_ipi_destroy(struct kvm_device *dev)
>   
>   	kvm = dev->kvm;
>   	ipi = kvm->arch.ipi;
> +	kvm->arch.ipi = NULL;
>   	mutex_lock(&kvm->slots_lock);
>   	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
>   	mutex_unlock(&kvm->slots_lock);
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 220fc23ffe8c..dab2d3f1b8f6 100644
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

