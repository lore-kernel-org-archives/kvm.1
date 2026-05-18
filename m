Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E613937C115;
	Mon, 18 May 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098384; cv=none; b=ZNWfXgCJdfXxil8Hjr6RBB0x777wiF3YkUIQu4SvR0hT8/kyBjTG+6yVA4aUBlBk7xtI9Rn9SR6l5CYxns+j3SGw7jNvpEt4rdpXfHCyr4le3oR0M36uSNiboDHfAgqzY1X3O1j2JNHgwfmPMLeGIieouFvTEs813HshlRjboDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098384; c=relaxed/simple;
	bh=oyCZ1DMGTSBsBbHc9SWNQko876ePtG6glQ6crX8A/bU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZzcHRqmfLzf5XuUKppniBfNTLRWdtVVo3QEp1zrMvOaes64J59Vz1xi7wTRswI3PphZHQe4M1KQ72LYiZzXezqJO4X0R3up2AYpqGQaZsIqWpb5BxEJNkOnu+PMQBiLvfTAQNEu5Dv1SfuX7rHQ9x77pTmFQb5/4oYvGELDznJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxvekC4wpqb80KAA--.30384S3;
	Mon, 18 May 2026 17:59:30 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxbcL+4gpqMnKGAA--.56726S3;
	Mon, 18 May 2026 17:59:29 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Add missing slots_lock for EIOINTC
 virtual extension device registration
To: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn
References: <20260518094521.138692-1-zeng_chi911@163.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <af3e9ecc-cb30-6d7d-5f2d-19ddf42755a0@loongson.cn>
Date: Mon, 18 May 2026 17:56:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260518094521.138692-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcL+4gpqMnKGAA--.56726S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1UJFy3Kryktr15Jr4xuFX_yoW8JFWUpF
	48uayqkrWrXr9rXrZFq3W8Wa1UKa9agw1rWr1rKFWUKr4qqryrtFykAry5X3Wqk3yxAay0
	qFy3Gr98Z3W3AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2026/5/18 下午5:45, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> The second kvm_io_bus_register_dev() call for device_vext was missing
> kvm->slots_lock protection. Add it to match the first registration.
> 
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/eiointc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index 2ab7fafa86d5..ce64ffb706df 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -645,8 +645,10 @@ static int kvm_eiointc_create(struct kvm_device *dev, u32 type)
>   
>   	device = &s->device_vext;
>   	kvm_iodevice_init(device, &kvm_eiointc_virt_ops);
> +	mutex_lock(&kvm->slots_lock);
>   	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS,
>   			EIOINTC_VIRT_BASE, EIOINTC_VIRT_SIZE, device);
> +	mutex_unlock(&kvm->slots_lock);
>   	if (ret < 0) {
>   		kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &s->device);
>   		kfree(s);
> 
Hi ZengChi,

Good catch.

There should be the similar lock protection with function call 
kvm_io_bus_unregister_dev() in files pch_pic.c/ipi.c/eiointc.c

Would you like add these together?

Regards
Bibo Mao

