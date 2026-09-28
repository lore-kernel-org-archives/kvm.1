Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C36468C13;
	Mon, 28 Sep 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582382; cv=none; b=GhhEk7mDf+viflgkKQDAOk5gHzsmp8oF/z/aQgkz8s9uvS/yFyWVqAWoV+3WBcg89eeL1zCyjile5QCg6oSEC1unBbPyqpn8nveZM6+DZ/31JVu99KXnWMlzgqehWj1Hfr8+9HTb/jtfaYJWhZ5H7pK81Yb+7xA5oJ757uRbk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582382; c=relaxed/simple;
	bh=4kl2el4FpHcVHqxsS4pGEvHLvJHgWdZsn2aHeqzIC4Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SakwRzNZftAS5XrdekmiWV2DTs5OvKDk6aMvQw6w6xkL+PjkP6tOR2/xkBINird3pMjaCiviaKTJ0OCiJzL16qgnk4Ntou6kq0cngyOdyHHdzPD4kMkoVBYCJudcJ6zl3CjLswONOHMFRpr2l0TALbk9PHPs/47lGJ8hKlfxam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxvtJqHrpqU3EQAA--.48063S3;
	Mon, 28 Sep 2026 15:59:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCx9cxpHrpqVP8lAA--.52959S2;
	Mon, 28 Sep 2026 15:59:37 +0800 (CST)
Subject: Re: [PATCH 6/6] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-7-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d3a560db-f4f2-6cfe-6742-ca5de9f5719c@loongson.cn>
Date: Mon, 28 Sep 2026 16:01:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260927075240.3007947-7-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9cxpHrpqVP8lAA--.52959S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW3Cry8JryDKr47XF48Xwc_yoW8KF48pr
	WrCa9xCFW8Kr129Fs7Zwn3XF1I9Fs7uw4S9a45AFyYkwn0gryrKFy8A3yDX3WDJ395AF1I
	qr4fGa90va1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU



On 2026/9/27 下午3:52, Tao Cui wrote:
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
> Reject a repeated init with -EBUSY, a null address with -EINVAL, and
> only set pch_pic_base after the bus registration succeeds so a failed
> init does not leave the device half-initialized.  The registration
> error is propagated instead of being replaced with -EFAULT.
> 
> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/intc/pch_pic.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
> index 136211f154d4..2baf9ecf0c8a 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -285,7 +285,10 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>   	struct kvm_io_device *device;
>   	struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
>   
> -	s->pch_pic_base = addr;
> +	if (!addr)
> +		return -EINVAL;
To detect repeated init, I think it will be better add a BOOL type 
variable such ready/has_init for this. In theory device with physical 
address 0 is possible.

> +	if (s->pch_pic_base)
> +		return -EBUSY;
-EEXIST or 0 if it is created already?

Regards
Bibo Mao
>   	device = &s->device;
>   	/* init device by pch pic writing and reading ops */
>   	kvm_iodevice_init(device, &kvm_pch_pic_ops);
> @@ -293,8 +296,11 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
>   	/* register pch pic device */
>   	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
>   	mutex_unlock(&kvm->slots_lock);
> +	if (ret < 0)
> +		return ret;
>   
> -	return (ret < 0) ? -EFAULT : 0;
> +	s->pch_pic_base = addr;
> +	return 0;
>   }
>   
>   /* used by user space to get or set pch pic registers */
> 

