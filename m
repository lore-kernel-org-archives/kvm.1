Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEB3B0AED;
	Tue,  1 Sep 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226216; cv=none; b=H8vNPfZtQdjkBOu6p+70LMibMBkg5CVLbmu7xON+JfeIxOZpRGrGExEvN1YCIDJioejZjxe/vBFgtzUpJs/5+SVde+CaecwXDiYkVX3BNW5rNlZ5AV/VED9qSvwi+RWukf6MgW+a3lb7/28Nu0FNcdWeZ8AbF7y2Z5YimwZHeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226216; c=relaxed/simple;
	bh=rkLmymAjLKoFEmu1EBZW8/mMsRG6aAXBZVaTDQbwGLk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D09S5+sHs+uvv8Q8XdcdOF2IZEDPczKNJGbOJAjY4w+mOXEhN9GKSi01i6Ah7rSoAozeBI++d6R+Ou4RIQ0bkzcthj/IlTbwGV8Dj/9zuxwGg6CpwP+zoQ1qdcUIsa8nuJw2T3eJ59vGwFvBDQe6JOZpJSDgRG6vR9CdqJnQyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxntKaKpZq7DcHAA--.20311S3;
	Tue, 01 Sep 2026 09:30:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxNs2ZKpZqpJUYAA--.38761S2;
	Tue, 01 Sep 2026 09:30:01 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Fix memory leak in
 kvm_loongarch_env_init() error path
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
 zhaotianrui@loongson.cn, chenhuacai@kernel.org
Cc: kernel@xen0n.name, lixianglai@loongson.cn, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e24c4184-0c23-3ce3-9021-9f544070fbb1@loongson.cn>
Date: Tue, 1 Sep 2026 09:29:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260817115847.2705791-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxNs2ZKpZqpJUYAA--.38761S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4kuF4kuF13tF15WryxCrX_yoW8KFWkp3
	y29an8Jr10gr17J3sFv3W5WF93ursIgw1xuF1Iyw1UCr43Wryvq348Kr9FqF15C3y8ZF10
	vr4fAay7u3WUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
	UUU==



On 2026/8/17 下午7:58, Chaithanya Lagisetty wrote:
> kvm_loongarch_env_init() allocates the per-CPU kvm_context (vmcs) and
> kvm_loongarch_ops, and registers the perf callbacks, before registering
> the IPI/EIOINTC/PCH-PIC/DMSINTC KVM devices. If any of those device
> registrations fails, the function returned the error directly without
> freeing vmcs and kvm_loongarch_ops or unregistering the perf callbacks.
> kvm_loongarch_init() propagates the error without calling
> kvm_loongarch_env_exit(), so these resources are leaked.
> 
> Unwind the already-acquired resources on the error path, mirroring
> kvm_loongarch_env_exit().
> 
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>   arch/loongarch/kvm/main.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4b..685d334cf957 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -385,22 +385,33 @@ static int kvm_loongarch_env_init(void)
>   	/* Register LoongArch IPI interrupt controller interface. */
>   	ret = kvm_loongarch_register_ipi_device();
>   	if (ret)
> -		return ret;
> +		goto err;
>   
>   	/* Register LoongArch EIOINTC interrupt controller interface. */
>   	ret = kvm_loongarch_register_eiointc_device();
>   	if (ret)
> -		return ret;
> +		goto err;
>   
>   	/* Register LoongArch PCH-PIC interrupt controller interface. */
>   	ret = kvm_loongarch_register_pch_pic_device();
>   	if (ret)
> -		return ret;
> +		goto err;
It will be better if there is wrapped unregister function, to remove 
previous registered callback. The same with eiointc/dmsintc driver, 
something like this:
+
+void kvm_loongarch_unregister_pch_pic_device(void)
+{
+       return kvm_unregister_device_ops(KVM_DEV_TYPE_LOONGARCH_PCHPIC);
+}

Regards
Bibo Mao
>   
>   	/* Register LoongArch DMSINTC interrupt contrroller interface */
> -	if (cpu_has_msgint)
> +	if (cpu_has_msgint) {
>   		ret = kvm_loongarch_register_dmsintc_device();
> +		if (ret)
> +			goto err;
> +	}
>   
> +	return 0;
> +
> +err:
> +	kvm_unregister_perf_callbacks();
> +	kfree(kvm_loongarch_ops);
> +	kvm_loongarch_ops = NULL;
> +	free_percpu(vmcs);
> +	vmcs = NULL;
>   	return ret;
>   }
>   
> 

