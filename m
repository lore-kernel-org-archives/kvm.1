Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645534;
	b=NihUAC77POQM2J0WM5LFTfVPLjTSPZ5lKWPeSDoHR3/p1xRWOTSREL2gudb+0I66LYU6
	 VH5w7xs4/S703ZYe4SOLbzP6o+g3rwHaNKYgoH3MfyeJsU0rbKqzih1gwnvclx2vxuUiy
	 nVhtPTYKVgtxEeB0XB6qxfIsgN5EWuRJIRS0pKiBGTDxmWfwS1HL1ITDcdKYUcNkBsbzz
	 fpCd9A5JontQHZHHo4FIKYbeqoBjubmeQe8PzzFc90jptbTv56D7C4OYOEcyRpKZIH57F
	 VhEdNgBdR1oIjsR/a5xvRaJGTFwOWFYF0lC4Cum9RXRxi7EvLc3KJ3p2A9HWNGn7Bww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645534;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IK5p9/oAjFQaLEk4iOn+2jSpIJGhuFIILB+nKJjM5W4=;
	b=IGBi1lm1JgKQKs96dutdKgRIxJrX7vrUV6Mt0qlveke7Q/+3ZeEyre7X5frkAg33iSsX
	 jt5PVzh1L3vW7xFRWiyRn7o3YFUtVWC6NCP5oJPToEefJqTpePg6NjQ97mk3glRkHD68m
	 pq+y1nCQ/QZ7/+ysv4dP0yGQlXSSVAPhBON5EOhdEVhGD1wMN7ogm0wH7oLDZ5Xs0E66J
	 VLCH91rpM38vdvaYtzaaM0LcozpGH4re1vbnzhozyfddFQqeZlrsBu6wkEKZyc4SgKKyC
	 8Hr3wAqVLAkvzOpxloTatSeVXNZbZO7wW87h2HyR3onUFi4NGgjFkX5bUKK2m1oD3KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rpf7QTW0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40264606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40264606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rpf7QTW0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721EF1FC4;
	Mon,  2 Nov 2026 10:52:09 -0800 (PST)
Received: from [10.57.89.36] (unknown [10.57.89.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D17523F673;
	Mon,  2 Nov 2026 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793645532; bh=eRT8EPlGmj8VVlfVMAD9ve9ebI+67LjsP9Gf4hzofTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rpf7QTW00lwV9uTdlfHmVNFktsConMIdlqcqODPOVAoWzTp/3ZRQLmYqIG/rB3/O2
	 B43c7J+phQXwSkzgHrVn+KcB5LCXoLOCtrWx8k8KB+MD49amIYjt2Wg0OljbJdEkDw
	 nQjecks+ITNlOMcG9zeZ9omftVPNSf4vFKcf0l94=
Message-ID: <ab0d81a4-da63-4f36-8412-0649153ebd49@arm.com>
Date: Mon, 2 Nov 2026 18:52:10 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] KVM: arm64: gic-v5: Document ITS userspace ABI
To: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261016155741.979985-1-sascha.bischoff@arm.com>
 <20261016155741.979985-17-sascha.bischoff@arm.com>
 <sashiko-outbox-174640@kernel.org>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <sashiko-outbox-174640@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 17:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: arm64: gic-v5: userspace writes to READ_EVENT_DATAR are silently ignored causing state loss
> --
> 
> commit 3a4606444ec9f90ae2360e066a229c789d9eca15
> Author: Sascha Bischoff <sascha.bischoff@arm.com>
> 
> KVM: arm64: gic-v5: Document ITS userspace ABI
> 
> Document the GICv5 ITS device and its userspace ABI, including the
> MMIO address, reset control, register attributes, and MSI requirements.
> 
>> diff --git a/Documentation/virt/kvm/devices/arm-vgic-v5-its.rst b/Documentation/virt/kvm/devices/arm-vgic-v5-its.rst
>> new file mode 100644
>> index 0000000000000..250057e4445d7
>> --- /dev/null
>> +++ b/Documentation/virt/kvm/devices/arm-vgic-v5-its.rst
> 
> [ ... ]
> 
>> +KVM_DEV_ARM_VGIC_GRP_ITS_REGS
>> +-----------------------------
>> +
>> +  Attributes:
>> +    The attr field of kvm_device_attr contains the ITS register offset from
>> +    the control frame base address. kvm_device_attr.addr points to a __u64,
>> +    regardless of whether the register is 32 or 64 bits wide. A 64-bit
>> +    register must be addressed at its base offset; userspace cannot access
>> +    its upper or lower half separately. Guest MMIO may use aligned 32-bit
>> +    accesses to DT_BASER, DIDR, READ_EVENT_DATAR, and GEN_EVENT_DIDR.
>> +
>> +    The ITS base address must be configured before this group can be used.
>> +    Writes to read-only registers are ignored. Writes to DT_CFGR and DT_BASER
> 
> [Severity: Medium]
> Does this design violate the rule that read-only attributes must return an
> error on set?
> 
> A device attribute documented as read-only whose set path does not return an
> error can lead to silent migration state loss. For example, READ_EVENT_DATAR
> is a stateful register that holds the result of the READ_EVENTR command. If
> userspace restores this state during migration, but the write path returns 0
> while ignoring the value, the restored state is silently dropped, corrupting
> the guest's view of the command result upon resume.
> 
> Looking at the implementation, READ_EVENT_DATAR is defined without a uaccess
> write override in vgic_v5_its_registers() and uses vgic_v5_mmio_write_its_wi.
> The userspace attribute set path in vgic_v5_its_attr_regs_access() defaults
> to calling the guest its_write handler, which invokes the Write Ignore stub
> and successfully returns 0 instead of returning -EINVAL or -EPERM.
> 

The posted userspace access patch in this series (patch 10) silently 
discarded READ_EVENT_DATAR, which was a mistake on my part.

I've added its restore handler in patch 10, and a read-back test in 
patch 14, and ABI text in this patch documenting that userspace can 
(read: must) restore it. Guest MMIO writes remain ignored, as this is a 
RO register from the guest's point of view, but it must persist across 
save/restore.

Thanks,
Sascha
