Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A74E9C1B;
	Tue, 29 Sep 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672623; cv=none; b=D1bm/KDJW1yCJsmpiqICLU94OQmwU5X1U4vkoRYpvk/5HfvBRqPo5OIfS2aPG/QN3iA43AIAuf1DvuTbf1qJZxcJKJ7u7V1GkJ1LwL8KQY9aiEOtQUVkticdj9gFwPlWAw6Gnk5pDZ8ztjtryVPM/Wa8RBrA0TymK3Xkzyu7xbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672623; c=relaxed/simple;
	bh=XE0diPgi/S0dFf0Xr5cAfejhQRRFpZccGQeHnbrLWi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNiPn8X7oaT7bRfAbawRdk/TS4qkw/+PP1N/jJpLa1+fIyktPlluwFGO4uQLT8k1Wph44i217MD56zgvQV6IgAjwJY8R6aU/MuPkE7QyKxd/Ey6FNc9Mq40lKzUEeUu73QEnfvEnMyUxlD6A8Pk0HV53hvZ1B2uR/fJ9SpqyIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.46.54])
	by gateway (Coremail) with SMTP id _____8AxS_Dbfrtqk+cQAA--.49609S3;
	Tue, 29 Sep 2026 17:03:23 +0800 (CST)
Received: from [10.40.46.54] (unknown [10.40.46.54])
	by front1 (Coremail) with SMTP id qMiowJDxRs3Yfrtq+XgmAA--.3044S2;
	Tue, 29 Sep 2026 17:03:20 +0800 (CST)
Message-ID: <7d47fb51-2f92-4565-92d5-be11181ef1ab@loongson.cn>
Date: Tue, 29 Sep 2026 17:04:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: KVM: Return the actual error code in
 kvm_pch_pic_create()
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Xianglai Li <lixianglai@loongson.cn>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260929052712.470413-1-nagachaithanya9911@gmail.com>
Content-Language: en-US
From: Bibo Mao <maobibo@loongson.cn>
In-Reply-To: <20260929052712.470413-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs3Yfrtq+XgmAA--.3044S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW8Zw1ftr1xtw47KrWUKFX_yoW8AFW5pF
	W8CFs0kF4kCr1xXa92v34DGFsxZrWxXFyIgF129FW5ArsxX3WSkr10krZIvF98K395Gr1S
	qrsxGF90v3W7tacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

Hi Chaithanya,

Thanks for patch, there is similar version at:
https://lore.kernel.org/lkml/20260927075240.3007947-6-cui.tao@linux.dev/

Regards
Bibo Mao

在 2026/9/29 13:27, Chaithanya Lagisetty 写道:
> kvm_pch_pic_create() sets up the default IRQ routing and reports every
> failure as -ENOMEM, discarding the error code it was given:
> 
> 	ret = kvm_setup_default_irq_routing(kvm);
> 	if (ret)
> 		return -ENOMEM;
> 
> kvm_setup_default_irq_routing() returns -ENOMEM only when its routing
> entry array cannot be allocated. Otherwise it forwards the result of
> kvm_set_irq_routing(), which also fails with -EINVAL when an entry is
> rejected by setup_routing_entry(). Userspace creating a
> KVM_DEV_TYPE_LOONGARCH_PCHPIC device can therefore receive -ENOMEM even
> when IRQ routing setup actually failed with -EINVAL.
> 
> Return ret so the original error code reaches userspace. This matches
> kvm_eiointc_create(), which already propagates the error code from the
> helpers it calls.
> 
> Only compile-tested.
> 
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>   arch/loongarch/kvm/intc/pch_pic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 2b63b0c2c7ce..7fee60ae01a5 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -444,7 +444,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
>   
>   	ret = kvm_setup_default_irq_routing(kvm);
>   	if (ret)
> -		return -ENOMEM;
> +		return ret;
>   
>   	s = kzalloc_obj(struct loongarch_pch_pic);
>   	if (!s)

