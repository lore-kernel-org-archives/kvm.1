Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026D64A8C;
	Fri, 16 Oct 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112553; cv=none; b=Q6caN+Mk4Qlqkpnv+EoTqe/KTRLxkt7wZo8UApBzVFVGbIhmcX76dCBSFP5/1lHoxfvK67yGepGAiar5L6VfHwHRcijq7iQogc5RMbYiEgqJ13957DMY87me96oqx6ImatFAbj4CzNX8oyojBYROAnIDC8KUeeIFDA09JsT24yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112553; c=relaxed/simple;
	bh=UJsDNsYASr7FwO+ngumIVuPF4bunFrTOPFvlyh20ewM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Eo9B4aJWDgDtqZickjO5Ge/e5dfvRf8WvVmtjEVd7vNt9ijDpNMNUFNxOAJ0evfwkYmRRb888DI7hzM7n5mciUSZ7TSA6pNtOu2pqXJA+nvPxXgPr8y3swXpwigbv6hOTccv8oeluX5FN4pgDqpExP6o4UmN7b56VarPsXNZIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxjdKid9Fqi1QWAA--.64726S3;
	Fri, 16 Oct 2026 09:02:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxBc2dd9FqEOssAA--.1015S2;
	Fri, 16 Oct 2026 09:02:21 +0800 (CST)
Subject: Re: [PATCH v4 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>, chenhuacai@kernel.org,
 zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
 <20261015234638.1077815-4-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <57a57af2-ff5b-fe6d-1ecb-3f1312358260@loongson.cn>
Date: Fri, 16 Oct 2026 09:03:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261015234638.1077815-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc2dd9FqEOssAA--.1015S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFykJr4xCFyDGr4DAF4fWFX_yoW8uw4xpr
	Wrua90krW8Wr17uFs7Zwn7XFWxua1I9w1FgF1YyFyjkrn8tr9YqFyrta15X3WDt3y8AFyI
	qFn8K34Fva1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU



On 2026/10/16 上午7:46, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
> invocation: every call overwrites pch_pic_base and registers the same
> kvm_io_device on the MMIO bus at the new address, while
> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
> init, MMIO to the stale ranges computes its register offset against the
> new base and silently reads 0 / drops writes, and the leftover bus
> entries persist until the VM is destroyed.
> 
> Reject repeated initialization with -EEXIST, using the initialized
> state of the kvm_io_device as the indicator.  The check, the MMIO base
> update and the bus registration are serialized by slots_lock, and the
> real registration error is propagated instead of being replaced with
> -EFAULT.
> 
> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/pch_pic.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 51e4a6a39dc0..a4c35ed704be 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -281,16 +281,21 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>   	struct kvm_io_device *device;
>   	struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>   
> -	s->pch_pic_base = addr;
>   	device = &s->device;
> +	mutex_lock(&kvm->slots_lock);
> +	if (s->device.ops) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
> +	s->pch_pic_base = addr;
>   	/* init device by pch pic writing and reading ops */
>   	kvm_iodevice_init(device, &kvm_pch_pic_ops);
> -	mutex_lock(&kvm->slots_lock);
>   	/* register pch pic device */
>   	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
> +out:
>   	mutex_unlock(&kvm->slots_lock);
>   
> -	return (ret < 0) ? -EFAULT : 0;
> +	return ret;
>   }
>   
>   /* used by user space to get or set pch pic registers */
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

