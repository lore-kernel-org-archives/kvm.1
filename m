Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B93C5DA1
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918525; cv=none; b=S41MBhToh+byWuhuazkrsra4j8vZNXGYDgCKj4pO4AGPW3lAUsGiBPW8HWfwKl2AdrFuW6SL6YKORLNgyA5CbbWLFNkyxFaW7B2WT/U9NENm2aMD3tlLFIFu6KWuFsHkfunEOR6yNOIWIKcaI8p6k1wnRvwO72O9eC7D/BjQDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918525; c=relaxed/simple;
	bh=PX7By4zeDo2HgbnlZbo6iqNdru4CTHDyE1Od/gCRqZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iwR5R6YwTYka9ZDh7GCRK6F2C31Vq0wwuVkIFooO6X5El5zZsEpQ0jUm5lQZuY4rCKDG2nsh3ys2Z+KCqAPDrn5yz0DPd5sFINv66z/aYClv2wLeM5PWMcpLBEAGRo6CW73Y3DHcG3GoHGIX88VzSlfFUeouH+Sbc6R5RxFZcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lC+Ldoxr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lC+Ldoxr"
Message-ID: <b4343223-a221-4cc3-aee2-cb79c556bcb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785918512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HhgnZYRXj0g/pjMUG8Oa4nhud1GQ6qpbjBU13+rTKc=;
	b=lC+LdoxrVf/VMQK042vRrMhoKMUXlUhEYwean6p1u3TymfQItYTZspEyvgP6fxuXzII/yT
	8noe4u3l8mch4DzquSFouMcdnvXUX9yLmqZQ6/eKkVOgfUqbdkTGDT6c6zpXma1HnzqeN4
	9tzr0ggLTdXUAZHiPRPc3P99/TxQj28=
Date: Wed, 5 Aug 2026 16:28:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Advertise already-supported
 capabilities
To: sashiko-reviews@lists.linux.dev, Bibo Mao <maobibo@loongson.cn>
References: <20260805054549.287648-1-cui.tao@linux.dev>
 <20260805060636.A0FB11F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260805060636.A0FB11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Bibo,

The Sashiko automated review of this patch flagged two pre-existing items
— neither is from this patch. Wanted to get your thoughts,

在 2026/8/5 14:06, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The unsafe user-access macros (`unsafe_put_user()` and `unsafe_get_user()`) are used without the required `user_access_begin()` and `user_access_end()` guards, violating the kernel API contract.
The steal-time code uses unsafe_put_user()/unsafe_get_user() without
   the usual user_access_begin()/end() around them. On LoongArch it
   doesn't actually cause any trouble — there's no hardware user-access
   protection (user_access_begin() just resolves to access_ok()),
   __put_user is a plain store, and the ghc->hva address is already
   validated by kvm_gfn_to_hva_cache_init(), so the access_ok() is
   redundant anyway. So I see it more as a convention inconsistency /
   style nit than a real bug. I'd be happy to put together a small
   cleanup wrapping those in user_access_begin()/end() (or switching to
   kvm_write_guest_cached()). Does that sound like just cleanup to you,
   and would you want it?
> - [High] A lockless read-modify-write on the shared VM state `kvm->arch.pv_features` allows userspace to bypass the validation check that requires all vCPUs to share identical PV features.
The check-then-set on kvm->arch.pv_features in cpucfg_set_attr() is a
   genuine TOCTOU — again pre-existing, unrelated to this patch. It's not
   really reachable in practice: 0/3000 with two vCPUs hammering it
   concurrently, though a debug widening of the window does reproduce it
   every time (3000/3000). It'd basically need a userspace firing
   KVM_SET_DEVICE_ATTR with different values on two vCPUs at once. The
   odds are low, but I do think edge cases like this are still worth
   fixing — happy to send a separate patch using a mutex or cmpxchg.

Neither of these affects v2 itself, so I'd leave it as-is.

Thanks,
Tao
> --
> 
> --- Patch [1]: [PATCH v2] LoongArch: KVM: Advertise already-supported capabilities ---
> commit 91e3758510b96f271c2589373d1340c246fab45a
> Author: Tao Cui <cui.tao@linux.dev>
> 
> LoongArch: KVM: Advertise already-supported capabilities
>     
> This commit advertises KVM_CAP_STEAL_TIME and KVM_CAP_VCPU_ATTRIBUTES on
> LoongArch, making existing features discoverable to userspace.
> 
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 1317c718f896a..0a51931d6f6e0 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_IOEVENTFD:
>>  	case KVM_CAP_MP_STATE:
>>  	case KVM_CAP_SET_GUEST_DEBUG:
>> +	case KVM_CAP_VCPU_ATTRIBUTES:
> 
> [Severity: High]
> This is a pre-existing issue, but does advertising KVM_CAP_VCPU_ATTRIBUTES
> expose a data race in kvm_loongarch_cpucfg_set_attr()?
> 
> Looking at arch/loongarch/kvm/vcpu.c, there is a lockless read-modify-write
> sequence on the shared VM state:
> 
> arch/loongarch/kvm/vcpu.c:kvm_loongarch_cpucfg_set_attr() {
> ...
> 	/* All vCPUs need set the same PV features */
> 	if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> 			&& ((kvm->arch.pv_features & valid) != val))
> 		return -EINVAL;
> 	kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
> ...
> }
> 
> If multiple threads concurrently call KVM_SET_DEVICE_ATTR on different vCPUs,
> can they bypass this validation check by both reading before either writes,
> resulting in divergent configurations being silently applied globally instead
> of returning -EINVAL?
> 
>>  		r = 1;
>>  		break;
>>  	case KVM_CAP_NR_VCPUS:
> 
> [ ... ]
> 
>> @@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_NR_MEMSLOTS:
>>  		r = KVM_USER_MEM_SLOTS;
>>  		break;
>> +	case KVM_CAP_STEAL_TIME:
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does advertising
> KVM_CAP_STEAL_TIME expose an issue with unsafe memory accesses?
> 
> In arch/loongarch/kvm/vcpu.c, unsafe_put_user() is used without the required
> user_access_begin() and user_access_end() guards:
> 
> arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
> ...
> 	unsafe_put_user(0, &st->preempted, out);
> ...
> }
> 
> And similarly in kvm_vcpu_set_pv_preempted():
> 
> arch/loongarch/kvm/vcpu.c:kvm_vcpu_set_pv_preempted() {
> ...
> 	unsafe_put_user(KVM_VCPU_PREEMPTED, &st->preempted, out);
> ...
> }
> 
> Since omitting user_access_begin() skips the access_ok() check at the access
> site, could this cause a kernel fault if hardware-enforced user access
> protections are introduced?
> 
>> +		r = kvm_pvtime_supported();
>> +		break;
>>  	default:
>>  		r = 0;
>>  		break;
> 

