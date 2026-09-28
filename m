Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83965411F8D;
	Mon, 28 Sep 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580135; cv=none; b=RTC0wATafbvsAe5hwY5OhSPyaTVw70b6ndgbT5aB52esDdBc3kNSrUBsKYIQcphOaFW9Lx0JjhvViZrv+iWdoIxiH33SAysFk9IfzHH7tVhG5CzU72dHlU3rKwfYdR0z/yikXyM4DHEJFmtU71w6LOzcJO3O8lvwEKPL3pvcUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580135; c=relaxed/simple;
	bh=V8QlhZUYn1YHfL8bhH35XrLM0K+kWYCYXhnYTx2/DRs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HIPyHZg4G1GVgByglavPZf3nQOOsww7XieJtszEgXTEnTjKOOLWWpmSU9DTNfGN0Y/Pugmmxg4+ohQ3Yo+0NUmtAta6akw8aHDmVWmZfJeW2M1KYKas1OyFB40+7u+xhn9byG8+8cGnUZZg3q2LSlYNEurqJdacTzA1/no1uM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxS_CgFbpqgG4QAA--.48248S3;
	Mon, 28 Sep 2026 15:22:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPs+dFbpq2_wlAA--.14639S2;
	Mon, 28 Sep 2026 15:22:07 +0800 (CST)
Subject: Re: [PATCH 4/6] LoongArch: KVM: Rebase steal time counter in vcpu
 context
To: Tao Cui <cui.tao@linux.dev>, gaosong@loongson.cn, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-5-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <789eaa76-50a1-61bf-0419-0f45beb45a92@loongson.cn>
Date: Mon, 28 Sep 2026 15:23:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260927075240.3007947-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs+dFbpq2_wlAA--.14639S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry5Ar4xCr47Wry7Ary5GFX_yoWrXFyxpr
	W7ur1jgrWrKr97CwnrK39Y9F1YvrWxCr12gry7WFyFkFs8tryYyFsYkFW3AF15A34rZa1I
	qF1Yy3ZI9ayjy3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
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
> KVM_SET_DEVICE_ATTR(PVTIME GPA) initializes st.last_steal from the
> ioctl thread's run_delay, but kvm_update_stolen_time() accumulates the
> vcpu thread's run_delay; the first delta can be negative and wraps in
I think that ioctl thread is the vCPU thread itself in KVM mode, there 
will be many potential problems when one thread set registers of vCPU 
while vCPU is running.

Regards
Bibo Mao
> u64, so the guest reads a steal time close to 2^64.
> 
> Drop the initialization from the attr path and lazily rebase the
> counter on the first steal update, which runs in vcpu context like the
> hypercall path.  Re-registering a GPA clears the rebase sentinel first
> and publishes the address with a write barrier; the reader side loads
> the address and sentinel with READ_ONCE and a read barrier so a
> concurrent re-registration is not observed half-applied.
> 
> Fixes: b4ba157044ea ("LoongArch: KVM: Add PV steal time support in host side")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/kvm/vcpu.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 8e028be3f0a9..d931a5a802f6 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -154,12 +154,13 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>   	u32 version;
>   	u64 steal;
>   	gpa_t gpa;
> +	u64 last_steal;
>   	struct kvm_memslots *slots;
>   	struct kvm_steal_time __user *st;
>   	struct gfn_to_hva_cache *ghc;
>   
>   	ghc = &vcpu->arch.st.cache;
> -	gpa = vcpu->arch.st.guest_addr;
> +	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>   	if (!(gpa & KVM_STEAL_PHYS_VALID))
>   		return;
>   
> @@ -187,8 +188,14 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>   	smp_wmb();
>   
>   	unsafe_get_user(steal, &st->steal, out);
> -	steal += current->sched_info.run_delay - vcpu->arch.st.last_steal;
> -	vcpu->arch.st.last_steal = current->sched_info.run_delay;
> +	/* acquire pairs with the smp_wmb in the attr path */
> +	smp_rmb();
> +	last_steal = READ_ONCE(vcpu->arch.st.last_steal);
> +	if (!last_steal)
> +		/* first update in vcpu context: rebase the counter */
> +		last_steal = current->sched_info.run_delay;
> +	steal += current->sched_info.run_delay - last_steal;
> +	WRITE_ONCE(vcpu->arch.st.last_steal, current->sched_info.run_delay);
>   	unsafe_put_user(steal, &st->steal, out);
>   
>   	smp_wmb();
> @@ -1122,7 +1129,7 @@ static int kvm_loongarch_pvtime_get_attr(struct kvm_vcpu *vcpu,
>   			|| attr->attr != KVM_LOONGARCH_VCPU_PVTIME_GPA)
>   		return -ENXIO;
>   
> -	gpa = vcpu->arch.st.guest_addr;
> +	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>   	if (put_user(gpa, user))
>   		return -EFAULT;
>   
> @@ -1197,7 +1204,7 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
>   		return -EINVAL;
>   
>   	if (!(gpa & KVM_STEAL_PHYS_VALID)) {
> -		vcpu->arch.st.guest_addr = gpa;
> +		WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
>   		return 0;
>   	}
>   
> @@ -1208,8 +1215,10 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
>   	srcu_read_unlock(&kvm->srcu, idx);
>   
>   	if (!ret) {
> -		vcpu->arch.st.guest_addr = gpa;
> -		vcpu->arch.st.last_steal = current->sched_info.run_delay;
> +		WRITE_ONCE(vcpu->arch.st.last_steal, 0);
> +		/* publish the new address only after clearing the rebase sentinel */
> +		smp_wmb();
> +		WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
>   		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>   	}
>   
> @@ -1800,7 +1809,7 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
>   	struct kvm_memslots *slots;
>   	struct kvm_steal_time __user *st;
>   
> -	gpa = vcpu->arch.st.guest_addr;
> +	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
>   	if (!(gpa & KVM_STEAL_PHYS_VALID))
>   		return;
>   
> 

