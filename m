Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44821257F;
	Fri, 30 Jan 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779527; cv=none; b=qRoHTfQm3hH/xBO0PW0pSX2xiFLYRQ3LVYclUr41sZ2rJXdWHT9o0rxTH/6OhlszW8foLPhpu/HK8Sw5NzTtmbivfqp++G7hqP86sA01SB5lhToZmK1TA97lc0dKRxswJg7IS70nUjaSOJqP7hiWlUcPGZx8RYelnpdmBcmanVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779527; c=relaxed/simple;
	bh=MvGMSADanzB7x+q+EqopZ7kfWA1qw4bC+aLY+a4Q7D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRYOwlnPV9uYEj2l/7lx9s9L6zQICKZpkhXp7zeBoKVrJfVr6FWZtcuqrogcu8z4v8wktBOfQCnRXpAal2qS+eEohu4m4VHXMqWUEMZeYqsjQGPcR64ubkHjqxE/Qtsl++xWwP2GNLjt32Lu6CqefAmZ8Y5jby0WMgV9iIcl3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TuammyZb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TuammyZb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769779518; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=NP4C/8iS3LZQ05EAXyUJq46Gw0HsoTqfjGkTOKLW1mk=;
	b=TuammyZb4RFji8XLQFPYnDia8IMrXDnp4Li5+X/xlzfKh7wqFw6PatmmwYXCaBNllIPqeWizy1PICDcQtXFxDh9gnhIqXQge7N9omJCcajE1mtR+hzyapMuNHEMWwozpXLIkUr6RraJNuuTIZ/xvqHtTEEiOQ9YK51dBLDUn62o=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WyAwpf6_1769779515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 21:25:16 +0800
From: fangyu.yu@linux.alibaba.com
To: radim.krcmar@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org
Subject: Re: Re: [PATCH v3 2/2] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE 
Date: Fri, 30 Jan 2026 21:25:14 +0800
Message-Id: <20260130132514.16432-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <DG199ZOUMRND.1RTVHMI6L9U5L@oss.qualcomm.com>
References: <DG199ZOUMRND.1RTVHMI6L9U5L@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> This capability allows userspace to explicitly select the HGATP mode
>> for the VM. The selected mode must be less than or equal to the max
>> HGATP mode supported by the hardware. This capability must be enabled
>> before creating any vCPUs, and can only be set once per VM.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 18 ++++++++++++++++++
>>  arch/riscv/kvm/vm.c            | 26 ++++++++++++++++++++++++--
>>  include/uapi/linux/kvm.h       |  1 +
>>  3 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> @@ -8765,6 +8765,24 @@ helpful if user space wants to emulate instructions which are not
>> +7.47 KVM_CAP_RISCV_SET_HGATP_MODE
>> +---------------------------------
>> +
>> +:Architectures: riscv
>> +:Type: VM
>> +:Parameters: args[0] contains the requested HGATP mode
>> +:Returns:
>> +  - 0 on success.
>> +  - -EINVAL if args[0] is outside the range of HGATP modes supported by the
>> +    hardware.
>> +  - -EBUSY if vCPUs have already been created for the VM, if the VM has any
>> +    non-empty memslots, or if the capability has already been set for the VM.
>> +
>> +This capability allows userspace to explicitly select the HGATP mode for
>> +the VM. The selected mode must be less than or equal to the maximum HGATP
>> +mode supported by the hardware.
>
>"The selected mode must be supported by both KVM and hardware."

This description is clear, Agreed.

>(The comparison is a technical detail, and incorrect too since the value
> is bouded from the bottom as well.)
>
>>                                  This capability must be enabled before
>> +creating any vCPUs, and can only be set once per VM.
>
>                     ^ "or memslots"

Right, thanks for catching that.

>
>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>> @@ -202,6 +202,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_VM_GPA_BITS:
>>  		r = kvm_riscv_gstage_gpa_bits(&kvm->arch);
>>  		break;
>> +	case KVM_CAP_RISCV_SET_HGATP_MODE:
>> +		r = IS_ENABLED(CONFIG_64BIT) ? 1 : 0;
>
>Maybe we can return the currently selected mode for a bit of extra info?
>Another nice option would be to return a bitmask of all supported modes.
>
>I think userspace has otherwise no reason to call it, since it's fine to
>just try enable and handle the -EINVAL as "don't care".
>1 syscall instead of 2.

I’d prefer to keep an explicit KVM_CHECK_EXTENSION implementation for
KVM_CAP_RISCV_SET_HGATP_MODE. Userspace commonly uses CHECK_EXTENSION for
capability discovery, and returning 0 would make it assume the capability is
unsupported even though KVM_ENABLE_CAP works.

Returning 1/0 should be sufficient here, as the actual mode support is
validated by KVM_ENABLE_CAP itself (with -EINVAL for unsupported modes).

>> @@ -212,12 +215,31 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  
>>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>>  {
>> +	case KVM_CAP_RISCV_SET_HGATP_MODE:
>> +#ifdef CONFIG_64BIT
>> +		if (cap->args[0] < HGATP_MODE_SV39X4 ||
>> +		    cap->args[0] > kvm_riscv_gstage_mode(kvm_riscv_gstage_max_pgd_levels))
>> +			return -EINVAL;
>> +
>> +		if (kvm->arch.gstage_mode_user_initialized || kvm->created_vcpus ||
>> +		    !kvm_are_all_memslots_empty(kvm))
>> +			return -EBUSY;
>> +
>> +		kvm->arch.gstage_mode_user_initialized = true;
>
>No need to have gstage_mode_user_initialized, since if the user could
>have changed it once, there shouldn't be an issue in changing it again.
>It's the other protections that must work.

Agreed — I'll drop gstage_mode_user_initialized. Userspace can change the
mode multiple times before the VM is committed, and updates will be gated
by the existing protections (i.e. once <vcpus created/ran | memslots active>,
the mode change will be rejected).

>> +		kvm->arch.kvm_riscv_gstage_pgd_levels =
>> +				3 + cap->args[0] - HGATP_MODE_SV39X4;
>> +		kvm_debug("VM (vmid:%lu) using SV%lluX4 G-stage page table format\n",
>> +			  kvm->arch.vmid.vmid,
>> +			  39 + (cap->args[0] - HGATP_MODE_SV39X4) * 9);
>
>(I don't think this debug message is going to be useful after a short
> debugging period, and it would clog the log on each VM launch, so I'd
> rather get rid of it.)

I'll drop this kvm_debug() from the capability path to avoid spamming the
log on each VM creation.

>Thanks.

Thanks,
Fangyu
