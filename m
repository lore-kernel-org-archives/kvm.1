Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68931F9B4;
	Wed, 23 Sep 2026 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134561; cv=none; b=ONwXOeikkKiy8UuEW2ClxNqHJVvMwfzBETYDyvJhyfuVYV6J8kzkBWCAtdSDWcwVtn3esDMyEfsj0MU+ejyVnUaHKS8+S3BHRUFY1tITFM43VzEJ3Z5Du6PI0ubQUtv/mLqq6fcMqF5vKfSJKutTQp/obLt9zKMPzu6P4i12tKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134561; c=relaxed/simple;
	bh=YZClwGub7OWQ5QcJYOffM2Nj8dPyoO6GR78mkRbFquY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YLOyk5Hex5PlASjUE4RUnv1hEsk7+JyDsKhDFfyGjYSsxGeQAgQOxvrMuqGAG4thH5de6hZQoBJQlHoqCW9rds1shPri41+tErpzLNY9w5rWeW6cXE39w3wfNvI/wHq0tGkTb2lqORhw6LZaggE/LUypceGpCytq3nIaLSBg4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxC9IdSbNqk+UOAA--.43752S3;
	Wed, 23 Sep 2026 11:35:57 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxFs0cSbNqogskAA--.19191S2;
	Wed, 23 Sep 2026 11:35:56 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Return the actual error code in
 kvm_ipi_create()
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Xianglai Li <lixianglai@loongson.cn>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <97b7d3f3-7929-9d4c-04e0-b5a4f7cfe2ac@loongson.cn>
Date: Wed, 23 Sep 2026 11:37:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260922103931.215091-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxFs0cSbNqogskAA--.19191S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryUCrWrKF45Kw1rXrWUAwc_yoW8uFyfpr
	WfuayqyFW5Wwn7KrWq93WDGF4UZr4fKw1fuw10grWDCr45Kr1Syr18t345uF1UG3y8Ca40
	qF15K3s8Z3WUAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZU
	UUUU=



On 2026/9/22 下午6:39, Chaithanya Lagisetty wrote:
> kvm_ipi_create() registers the IPI device on the IOCSR bus and jumps to
> the error label when that fails. The error path then discards the error
> code that kvm_io_bus_register_dev() reported and returns -EFAULT
> instead:
> 
> 	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BASE,
> 				      IOCSR_IPI_SIZE, device);
> 	mutex_unlock(&kvm->slots_lock);
> 	if (ret < 0) {
> 		kvm_pr_unimpl("%s: Initialize IOCSR dev failed, ret = %d\n",
> 			      __func__, ret);
> 		goto err;
> 	}
> 	...
> err:
> 	kfree(s);
> 	return -EFAULT;
> 
> kvm_io_bus_register_dev() fails with -ENOMEM or -ENOSPC, so userspace
> creating a KVM_DEV_TYPE_LOONGARCH_IPI device is told that it passed a
> bad address when the real problem is that the host is out of memory or
> out of IOCSR bus slots. -EFAULT is reserved for faulting user addresses,
> and the remaining -EFAULT returns in this file are get_user() failures,
> where it is correct.
> 
> Return ret instead. It is guaranteed to hold a valid negative errno
> because the ret < 0 branch above is the only path that reaches the error
> label. This also matches kvm_eiointc_create(), which already propagates
> the kvm_io_bus_register_dev() error code unchanged.
> 
> Only compile-tested; the fix is a straight propagation of an error code
> that the adjacent kvm_pr_unimpl() already logs.
> 
> Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>   arch/loongarch/kvm/intc/ipi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 7b333a4a0430..672ec053a997 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -431,7 +431,7 @@ static int kvm_ipi_create(struct kvm_device *dev, u32 type)
>   
>   err:
>   	kfree(s);
> -	return -EFAULT;
> +	return ret;
>   }
>   
>   static void kvm_ipi_destroy(struct kvm_device *dev)
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

