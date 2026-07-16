Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319B26738C;
	Thu, 16 Jul 2026 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182467; cv=none; b=fjVxP7Rgqqj/a6u9IHDWDq+D6qx9ElN/cuPSGYK+D1qOZhpr5IQ3bj6qqL/2INc8ma8r2hM41XCEcb7iV/hd6RVGUeZDUuk4fSbodPzylCTu5hpAUwprede2EVHwkK741pDJ5Run4B+Xbz3RFjb0mbE8epkWky/2MEiHoIAocXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182467; c=relaxed/simple;
	bh=zGGp1cJSrbb5PDhnrkgFY8TgBPbykD081l+nxy5YJgM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TWkSlKKNv1egxc0TPJiAY20KgGx/Gs4IvjAz1pUCX0mttJ97jVLJIlieM6n0gfoNvM3bSE1tMNVUqJ6bbIIG4kHk3wU0bOykUJKxJzKSq8Cyk/S5+R4/cX3oU3cneGxDYhFXXWHEboWGJt9wNSofACo85VJvX2ofg6ft3/JxBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxuvC_dlhqGBcEAA--.16386S3;
	Thu, 16 Jul 2026 14:14:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxu8S+dlhqPq0OAA--.19073S2;
	Thu, 16 Jul 2026 14:14:22 +0800 (CST)
Subject: Re: [PATCH v3 1/2] LoongArch: KVM: Reload one-shot TVAL on migration
 destination
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn
Cc: chenhuacai@kernel.org, kernel@xen0n.name, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 lixianglai@loongson.cn, cuitao@kylinos.cn
References: <20260715100640.1454413-1-cui.tao@linux.dev>
 <20260715100640.1454413-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <526ec336-8edd-3640-8ec3-1508d569eaaa@loongson.cn>
Date: Thu, 16 Jul 2026 14:14:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260715100640.1454413-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxu8S+dlhqPq0OAA--.19073S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWxJw17Kr15WFWkKFy8WFX_yoW8Cw4kpF
	4xA3ZxGr48ur17C3W3Ga1Du3Z8u348Gr1fWa4DGFWFkrsIgws0qF1Ig347WFsxtw4Iq39a
	qr1rK345Z3Z8A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=



On 2026/7/15 下午6:06, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_restore_timer() rebuilds the remaining timer countdown from
> vcpu->arch.expire, which is host-internal and is not part of the migrated
> vCPU state. On the migration destination it is still 0, so for a one-shot
> timer that has not expired yet the computed delta is 0 and
> write_gcsr_timertick(0) injects the timer interrupt immediately instead of
> after the remaining time.
> 
> The expired one-shot case (TVAL = -1) is already handled earlier. When
> expire has not been set (i.e. on the migration destination), reload the
> remaining countdown from the migrated TVAL. This covers both one-shot and
> periodic timers. The regular preempt/resume path on the source, where
> expire is valid, is unchanged.
> 
> Suggested-by: Bibo Mao <maobibo@loongson.cn>
> Fixes: a5857b9ff6e0 ("LoongArch: KVM: Implement vcpu timer operations")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/timer.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
> index 3829f35a4070..96f33e34855a 100644
> --- a/arch/loongarch/kvm/timer.c
> +++ b/arch/loongarch/kvm/timer.c
> @@ -119,6 +119,18 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>   	delta = 0;
>   	now = ktime_get();
>   	expire = vcpu->arch.expire;
> +	if (!expire) {
> +		/*
> +		 * vcpu->arch.expire is host-internal and is not migrated,
> +		 * so it is 0 after migration. Reload the remaining countdown
> +		 * from the migrated TVAL. This covers both one-shot and
> +		 * periodic timers.
> +		 */
> +		if (ticks < cfg)
> +			delta = tick_to_ns(vcpu, ticks);
> +		expire = ktime_add_ns(now, delta);
> +	}
> +
>   	if (ktime_before(now, expire))
>   		delta = ktime_to_tick(vcpu, ktime_sub(expire, now));
>   	else if (cfg & CSR_TCFG_PERIOD) {
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

