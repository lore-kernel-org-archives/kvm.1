Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D53783C3;
	Tue,  1 Sep 2026 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225351; cv=none; b=nyHAUnjDy3l+9Q5n0ve/lrvkM4WuJDChWHZaQrxIbNxjw22dP9HP6QKrZrJmOTIIWHXj7VISgFNfyU8JfWADi3kOI2ARgHaSQ8vgRP6nbjrhdOwl4NPocb9HJpcYh/PZHYv8O2vSOrBTufvqhPqH2EfIQI6vwDC7iChi0NJbIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225351; c=relaxed/simple;
	bh=1K1IOftsUjhFTWQ4EUqxCVyFzZP8AIM7bIw+sa7JFKM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ogf6Vgbp7oELWPuexwclCBLxjUe56iCdX5mw9ChSJGqiNy//0Lb2WbUVekynzSfv3ivhtw8yMgKDvsZzviM5qbBVA4miF5DHGL7tjToSqZ7r2TPoc4ymdFOdHbtqKZELrZ23e5tosopYgmymt9QKyDvVt76kbik3Bky1M32rWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxS_A_J5ZqGjcHAA--.20388S3;
	Tue, 01 Sep 2026 09:15:44 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxBc0+J5ZqipQYAA--.24106S2;
	Tue, 01 Sep 2026 09:15:42 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Free init resources if kvm_init() fails
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>,
 zhaotianrui@loongson.cn, chenhuacai@kernel.org
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260817123918.2738447-1-nagachaithanya9911@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <813b686a-8e79-990f-e7d1-c161c73ebb4a@loongson.cn>
Date: Tue, 1 Sep 2026 09:15:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260817123918.2738447-1-nagachaithanya9911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc0+J5ZqipQYAA--.24106S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFy5JF1rArW5Jw48JFyfKrX_yoW8Gw4fpr
	y7ur4Dtr48GrsrAF9rJw1DWr1DXrZ7Gr12v3WSkay5Aw4jvrW8Jr48Gr9F9FyDA3y8C3WF
	vF4SqF42v3WDA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeQ6JUUUUU=



On 2026/8/17 下午8:39, Chaithanya Lagisetty wrote:
> kvm_loongarch_init() calls kvm_loongarch_env_init() to allocate the
> per-CPU kvm_context (vmcs) and kvm_loongarch_ops and to register the
> perf callbacks, and then calls kvm_init(). If kvm_init() fails its
> result is returned directly, but since module_init() does not run
> module_exit() on failure, kvm_loongarch_env_exit() is never called and
> those resources are leaked.
> 
> Call kvm_loongarch_env_exit() when kvm_init() fails, matching the
> teardown-on-failure pattern used by riscv_kvm_init().
> 
> Fixes: 2bd6ac687261 ("LoongArch: KVM: Implement kvm module related interface")
> Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
> ---
>   arch/loongarch/kvm/main.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 3e1005526f4b..b6ddf5827c03 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -428,7 +428,11 @@ static int kvm_loongarch_init(void)
>   	if (r)
>   		return r;
>   
> -	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +	r = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +	if (r)
> +		kvm_loongarch_env_exit();
> +
> +	return r;
>   }
>   
>   static void kvm_loongarch_exit(void)
> 
Sorry the the late response.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

