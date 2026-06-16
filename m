Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9C146D5A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572036; cv=none; b=ljctKBtE0/eBOdybNTB4DA9F1MO+qYvh4VExS/PSeKw+XY8hBw5H1fIkBGB+snnbm31YoiB7IPMbpK+8w+ZRt3gnP0r4W2XQQIToRAowJeQbo/sqfHuyXBMNUz3htxHbBh5wadMJ5GMMnG43qL0nrbAwIh7yWVsjn/xEILdsM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572036; c=relaxed/simple;
	bh=xsiqlFSg3vngrUio9CDIwn+AXV8aV/3EyoF2hfDyVCg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cnu87AymZzMEzosrSWVYW9lkNzfzj2lwu7iFCd86kPxUBReYtXZ3Owidy0216y8ExyZw8A9DVgjhLQ/YEhCCDC+eqC4axItsf30aq0+a+OJi4AlfUiHE85sa9Ob69xV8+bmmMDIVU8iF0COzUpX9eZe3o1Gm37ILmpXaE5P5kL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxX+u9oTBqFZUUAA--.53669S3;
	Tue, 16 Jun 2026 09:07:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxacG7oTBqsaWnAA--.42441S3;
	Tue, 16 Jun 2026 09:07:07 +0800 (CST)
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Add PV TLB flush support via
 steal-time shared memory
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7bb86447-c5d3-7a81-5578-b1ac2419fa32@loongson.cn>
Date: Tue, 16 Jun 2026 09:03:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615082154.42144-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxacG7oTBqsaWnAA--.42441S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFyrJw4ruF4rZF47Ar48Xwc_yoW3Cr1fpF
	yvyFnYgF4xGr1fAwn3t39F9r45WF4xCr1Sga429ry5AF4agryDur1vkrWDAFyDXw1rXayI
	gFyFy34DZFWDX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=



On 2026/6/15 下午4:21, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Implement paravirtualized TLB flush for LoongArch KVM guests using the
> existing steal-time shared memory page.
> 
> The mechanism uses the preempted byte in struct kvm_steal_time with an
> additional KVM_VCPU_FLUSH_TLB flag bit:
> 
> - When a guest vCPU needs remote TLB flush but the target vCPU is
>    preempted (not running), it atomically sets KVM_VCPU_FLUSH_TLB in
>    the target's steal-time preempted byte instead of sending an IPI.
> - When the host re-enters the target vCPU (kvm_update_stolen_time()),
>    it atomically reads and clears only the preempted byte via amand_db.w
>    with mask ~0xff on the 32-bit aligned word.  amand_db.w provides
>    full barrier semantics and avoids the race with guest-side
>    try_cmpxchg().  LoongArch is little-endian, so the preempted byte
>    occupies bits [7:0]; this preserves pad[0..2] for future UAPI
>    extension.  If KVM_VCPU_FLUSH_TLB was set, the host drops the vCPU's
>    VPID, which triggers a full TLB flush on the next VM entry via
>    kvm_check_vpid().
> - For non-preempted vCPUs, the guest falls back to normal IPI-based
>    flush, avoiding unnecessary VM exits.
> 
> Issue a normal load (unsafe_get_user) before the atomic amand_db.w to
> avoid operating on stale cache data when the cache line was last
> modified by a different core.
> 
> This significantly reduces TLB flush overhead in multi-vCPU workloads
> where target vCPUs are often idle/preempted.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   arch/loongarch/include/asm/kvm_host.h      |  1 +
>   arch/loongarch/include/asm/kvm_para.h      |  1 +
>   arch/loongarch/include/uapi/asm/kvm.h      |  1 +
>   arch/loongarch/include/uapi/asm/kvm_para.h |  1 +
>   arch/loongarch/kvm/trace.h                 | 15 ++++++++++
>   arch/loongarch/kvm/vcpu.c                  | 34 +++++++++++++++++++++-
>   arch/loongarch/kvm/vm.c                    |  3 ++
>   7 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 776bc487a705..1750632699e0 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -168,6 +168,7 @@ enum emulation_result {
>   #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
>   					 BIT(KVM_FEATURE_PREEMPT) |	\
>   					 BIT(KVM_FEATURE_STEAL_TIME) |	\
> +					 BIT(KVM_FEATURE_PV_TLB_FLUSH) |\
>   					 BIT(KVM_FEATURE_USER_HCALL) |	\
>   					 BIT(KVM_FEATURE_VIRT_EXTIOI))
>   
> diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
> index fb17ba0fa101..28e3fa3b4c0e 100644
> --- a/arch/loongarch/include/asm/kvm_para.h
> +++ b/arch/loongarch/include/asm/kvm_para.h
> @@ -41,6 +41,7 @@ struct kvm_steal_time {
>   	__u8  pad[47];
>   };
>   #define KVM_VCPU_PREEMPTED		(1 << 0)
> +#define KVM_VCPU_FLUSH_TLB		(1 << 1)
>   
>   /*
>    * Hypercall interface for KVM hypervisor
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
> index cd0b5c11ca9c..e4cd4bbf8914 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -106,6 +106,7 @@ struct kvm_fpu {
>   #define  KVM_LOONGARCH_VM_FEAT_PTW		8
>   #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
>   #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
> +#define  KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH	11
>   
>   /* Device Control API on vcpu fd */
>   #define KVM_LOONGARCH_VCPU_CPUCFG	0
> diff --git a/arch/loongarch/include/uapi/asm/kvm_para.h b/arch/loongarch/include/uapi/asm/kvm_para.h
> index d28cbcadd276..8872839251cc 100644
> --- a/arch/loongarch/include/uapi/asm/kvm_para.h
> +++ b/arch/loongarch/include/uapi/asm/kvm_para.h
> @@ -16,6 +16,7 @@
>   #define  KVM_FEATURE_IPI		1
>   #define  KVM_FEATURE_STEAL_TIME		2
>   #define  KVM_FEATURE_PREEMPT		3
> +#define  KVM_FEATURE_PV_TLB_FLUSH	4
>   /* BIT 24 - 31 are features configurable by user space vmm */
>   #define  KVM_FEATURE_VIRT_EXTIOI	24
>   #define  KVM_FEATURE_USER_HCALL		25
> diff --git a/arch/loongarch/kvm/trace.h b/arch/loongarch/kvm/trace.h
> index 3467ee22b704..8556954fa196 100644
> --- a/arch/loongarch/kvm/trace.h
> +++ b/arch/loongarch/kvm/trace.h
> @@ -210,6 +210,21 @@ TRACE_EVENT(kvm_vpid_change,
>   	    TP_printk("VPID: 0x%08lx", __entry->vpid)
>   );
>   
> +TRACE_EVENT(kvm_pv_tlb_flush,
> +	TP_PROTO(struct kvm_vcpu *vcpu, bool need_flush),
> +	TP_ARGS(vcpu, need_flush),
> +	TP_STRUCT__entry(
> +		__field(unsigned int, vcpu_id)
> +		__field(bool, need_flush)
> +	),
> +	TP_fast_assign(
> +		__entry->vcpu_id = vcpu->vcpu_id;
> +		__entry->need_flush = need_flush;
> +	),
> +	TP_printk("vcpu %u need_flush %u", __entry->vcpu_id,
> +		  __entry->need_flush)
> +);
> +
>   #endif /* _TRACE_KVM_H */
>   
>   #undef TRACE_INCLUDE_PATH
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e68..5230e95a7816 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -173,7 +173,39 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
>   	}
>   
>   	st = (struct kvm_steal_time __user *)ghc->hva;
> -	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
> +	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
> +		u32 old = 0;
> +		int err = 0;
> +
> +		/*
> +		 * Prime the cache line with a normal load before the coherent
> +		 * atomic below; it was observed (when the line was last dirtied
> +		 * by another core) to be needed for amand_db.w to see a current
> +		 * value.  amand_db.w overwrites `old` with the real pre-AND value,
> +		 * so this load contributes only its cache side-effect.
> +		 */
> +		unsafe_get_user(old, (u32 __user *)&st->preempted, out);
If there is a failure, it does nothing and go to out directly, however 
guest TLB remains stale without flush operation.
> +
> +		/* Atomically read and clear the preempted byte via amand_db.w. */
> +		asm volatile(
> +		"1: amand_db.w %1, %3, %2	\n"
> +		"2:				\n"
> +		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)
> +		: "+r" (err), "+&r" (old),
> +		  "+ZB" (*(u32 *)&st->preempted)
> +		: "r" ((u32)~0xffu)
> +		: "memory");
> +
> +		if (err)
> +			goto out;
Ditto, if there is error, guest TLB is not flushed and vCPU continues to 
run with preempted bit set. The next TLB flush will be skipped with this 
vCPU since its preempted bit is not clear.

Regards
Bibo Mao
> +
> +		vcpu->arch.st.preempted = 0;
> +
> +		if ((u8)old & KVM_VCPU_FLUSH_TLB) {
> +			vcpu->arch.vpid = 0;	/* Drop vpid to flush TLB */
> +			trace_kvm_pv_tlb_flush(vcpu, true);
> +		}
> +	} else if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
>   		unsafe_put_user(0, &st->preempted, out);
>   		vcpu->arch.st.preempted = 0;
>   	}
> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896..cfba45a7343c 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -54,8 +54,10 @@ static void kvm_vm_init_features(struct kvm *kvm)
>   	if (kvm_pvtime_supported()) {
>   		kvm->arch.pv_features |= BIT(KVM_FEATURE_PREEMPT);
>   		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
> +		kvm->arch.pv_features |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
>   		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
>   		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
> +		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);
>   	}
>   }
>   
> @@ -158,6 +160,7 @@ static int kvm_vm_feature_has_attr(struct kvm *kvm, struct kvm_device_attr *attr
>   	case KVM_LOONGARCH_VM_FEAT_PV_IPI:
>   	case KVM_LOONGARCH_VM_FEAT_PV_PREEMPT:
>   	case KVM_LOONGARCH_VM_FEAT_PV_STEALTIME:
> +	case KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH:
>   		if (kvm_vm_support(&kvm->arch, attr->attr))
>   			return 0;
>   		return -ENXIO;
> 

