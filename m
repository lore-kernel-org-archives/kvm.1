Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC03FBED0
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802322; cv=none; b=Di5mrdRPwnN2xNEHOxh/TwD/YNDXQgppHRaW8sFKpJ2fmHS+FkHxk77F2RkIYhqikCw70glejj+4P2qcUSKM8aPHxtzduvGZvJnQwjxXOSTKHPLTVflpnuaIyq79a2ADfiiEC9kgCo7ZiuA/Pn9q6lY1xI2Pr8J8n89td6DZGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802322; c=relaxed/simple;
	bh=er5WhZuT8iO54WLetLLXi+bUQ6Pjir8+uPBvqHnWrCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GesFYXVuKbD98TQm8VHwToW0H3l69vMddXeHii3iYfuv23c32la+AZ0At5SAUAn3ZBfA5X8jurHMP+lQF5IXF9TZWPmE0xSvPr9BQfu0+N9L2itlFT1XczSWouOrnFcQ9tTLb4tj2c/Jok/9rN4PxtmF0yjS1wHjHHO6u4HTTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oMfIbfF/; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oMfIbfF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779802296;
	bh=PXZ61ZSDxPqDDY3NM1tN66z6vDr+ymWgRX7JCP/SJpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oMfIbfF/rdGTSWa3cMOWyHXDuDzfAv2bcnpLR05HKFMuA5Jt+5YPKlqwGlD1xO8AB
	 Jzl5Dp0g7zUGQVTJQs34NyjkJMAym7Xcq8rzMqxvL4iACYaucOrsegOO4VoFYxiAly
	 KTGgindeVD/pYgNBMDgl0aHbA1Qvuu2H4f48xlYA=
X-QQ-mid: esmtpsz16t1779802293te1af78ca
X-QQ-Originating-IP: yANNd3rtLdTsBYfmF1Qq1EDeLz854fT+sDaygQIvVKc=
Received: from [10.10.73.115] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 21:31:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1454614997282183531
Message-ID: <093E9E6366684579+e5297caf-5b6c-470d-8465-9cf5099fb3fc@uniontech.com>
Date: Tue, 26 May 2026 21:31:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: Fix timer state restore
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260526075544.796396-1-maqianga@uniontech.com>
 <20260526082339.101271F000E9@smtp.kernel.org>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <20260526082339.101271F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N6p5qtJwZog+YaZQeiTVhGp6byNI0055FlidDohmHrYJD4Bl0wPk3jgD
	MrYUfXK10o42olXHRl5y9lEn87Yp3MbUyGRtqDH0MEhdEbO3ASq7wDDS2Md1Z1JjRlOTuKw
	qIX6JYZRjZZPoTp9E4c2a/Fj7r0xefxGBPJLyQXhOET5Q2p1lWncQdTZ2gq8qBhgmWYrIK8
	OINCdDSOj37DD+bkOFFBsJUgJlEswpI0KMbl6OgmafLfygOXKEjJJ1YDSKKsLgEJ/OgDRW0
	ONvwArIol9gznRTF+tC5i5b8YPm9oyI3t0cAOUhOpVQC/GK3AaCBTxXkYcRtM3r/ZTKFWc5
	ndBUh9Cd1y63ri6brdORXx/IDYvRwa1oFgZbGBWaTMBiYTgEYPq1FClIDbLpbmdtzKbnDmZ
	zofCF4NC7cqfLZz+0S5ZGAWCLev2H55nZp4SabnGztjEXbvIVwlyVmYM/09n/T1DgQX5p4e
	2H32silMNZcFiDnjahqHKsIVilZMB6lNYG5Z2JW7akypzTNRDtpgaf+1lSRb1i7l98Vmgot
	v+fhV4R6Ux0Y7nqI1FCdED+4xmOx4ARLnEBCbWID7TpxQqhKuUc1tXGagamMAFh7hBJzemf
	pdesgcFQtM90k65pJ5pfpU7pUdKAt9h8N+zKeyFaSKue8CRySkL49X1fly/VHdCwxHKre97
	fTAVb4eptT/MB+U18mEzDpelX0RRyqO8EivKOEGiAjafmmKLu/FcBj23wQGEjohvpl8506u
	mlkGvPEOM+9qlexE1FeqoF2Serj3h2iukKnUt6NGSH7Yq4aZLsy5+tAYb1SuAfPvhGAfOO3
	GBQdNQXyU4tcCMuOO7uYeHf2zu8tymkM1Gd1wxNTGjB8w6x42ffuuVl9FwYZ/gHD1u8FY6z
	6jw1WsoaBw13z8/MkxCoVdRztk7g892a7It9KEFJXEohVhd+hmo77pHD+hw4MbC0wWSoiiM
	HOkAD+CJKeaKuCS+bpZuOGdOJAwTPbtZ+rbOphx3gWsWN8gQyPttvIWTCFx91nlVmYx6IA/
	AoMNuKMcAlmClant7kuwJIrVZXpRHP7TcJNUXJlA==
X-QQ-XMRINFO: OWPUhxQsoeAV8xKf2v2O9PdriWjoSou4mA==
X-QQ-RECHKSPAM: 0


在 2026/5/26 16:23, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] The patch introduces a strict UAPI register restoration ordering dependency, causing the timer to permanently stall if `state` is restored before `compare`.
>
> Pre-existing issues:
> - [Critical] Timer teardown uses a state flag for synchronization instead of unconditionally canceling the hrtimer, leading to a use-after-free on VCPU destruction.
> - [High] Restoring the timer state to OFF fails with `-EINVAL` if the timer is already OFF, aborting live migration. This is exacerbated by SSTC incorrectly reporting its state.
> --
>
> commit 12ffaa755d54118c3c86ae260e5df5a3b6b59454
> Author: Qiang Ma <maqianga@uniontech.com>
>
> RISC-V: KVM: Fix timer state restore
>
> This commit changes the timer state restoration logic in the one-reg interface
> to re-arm the timer using the restored compare value (t->next_cycles) instead
> of using the state value itself.
>
>> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
>> --- a/arch/riscv/kvm/vcpu_timer.c
>> +++ b/arch/riscv/kvm/vcpu_timer.c
>> @@ -229,7 +229,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcpu,
>>   		break;
>>   	case KVM_REG_RISCV_TIMER_REG(state):
>>   		if (reg_val == KVM_RISCV_TIMER_STATE_ON)
>> -			ret = kvm_riscv_vcpu_timer_next_event(vcpu, reg_val);
>> +			ret = kvm_riscv_vcpu_timer_next_event(vcpu, t->next_cycles);
> [Severity: High]
> Does this change introduce a strict ordering dependency for userspace register
> restoration?
In qemu, in the kvm_riscv_put_regs_time(), the values were originally 
set in the order of time, compare, and state.
>
> If a VMM restores the state register to ON before restoring the compare
> register, it appears this will arm the timer using an uninitialized or stale
> t->next_cycles value.
>
> If the compare register is restored later via KVM_SET_ONE_REG:
>
> 	case KVM_REG_RISCV_TIMER_REG(compare):
> 		t->next_cycles = reg_val;
> 		break;
>
> This only updates memory and doesn't seem to re-arm the running hrtimer. Will
> this cause the virtual timer to stall indefinitely?
Currently, such a situation does not occur in qemu.
>
> Before this patch, using 1 armed the timer for immediate expiration, and the
> subsequent callback would asynchronously pick up the restored compare value.
>
>>   		else
>>   			ret = kvm_riscv_vcpu_timer_cancel(t);
> [Severity: High]
> This isn't a bug introduced by this patch, but does restoring the timer state
> to OFF fail and abort live migration if the timer is already OFF?
>
> If kvm_riscv_vcpu_timer_cancel() is called when restoring an OFF state:
>
> static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
> {
> 	if (!t->init_done || !t->next_set)
> 		return -EINVAL;
>          ...
> }
>
> On the migration destination, a newly created VCPU has t->next_set == false, so
> restoring an OFF state returns -EINVAL.
>
> Additionally, when the SSTC extension is enabled, the timer is programmed
> directly via CSRs and t->next_set is not set to true for a running timer. Will
> this cause KVM_GET_ONE_REG to incorrectly report the state as OFF for active
> VMs, which then fails during restoration on the destination?
In QEMU, the VM is running normally and does not call the 
kvm_riscv_get_regs_timer().
>
> [Severity: Critical]
> This is a pre-existing issue, but does using the t->next_set flag for
> synchronization during teardown lead to a use-after-free?
>
> Looking at kvm_riscv_vcpu_timer_cancel(), it skips canceling the hrtimer if
> the flag is false:
>
> static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
> {
> 	if (!t->init_done || !t->next_set)
> 		return -EINVAL;
>
> 	hrtimer_cancel(&t->hrt);
> 	t->next_set = false;
> ...
>
> If the hrtimer callback clears t->next_set before it finishes executing, and
> the VCPU is destroyed concurrently, the teardown path will see
> t->next_set == false and skip hrtimer_cancel().
>
> Will the still-executing callback then dereference the freed VCPU memory?
>
>>   		break;
