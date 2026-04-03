Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C565477E;
	Fri,  3 Apr 2026 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181781; cv=none; b=UcGSev3IeRbVec3Ox9B5XKzULB9myxyA8lcy9VAV9gNs+cyboYpEadgiqUg3E9dQmxWPFZJ8JKTxvkWGDjdbULTEa1e0TEsMNeFTeE8V2moBofdknKwz2/Iq1aTbLSXGBa3r052d/xOoF8evst0ziftB26yqJdT5Piv40YC82lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181781; c=relaxed/simple;
	bh=J7URTCkQ+6zqmQHhZjEtbE1kWUPMibbN1OF6yyMTG0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH3lp2VnyIHGfI6L1Qw55YFQxp70TrfPKVy8nanS4z+WJPPodkhXMdCkKl0rrmdPyC3unMN+a5A6GHVN1bhsaz3F/sYpVY0/1u0rU5R7a5zGFMWsa0c+5vE4Ju4rjmetRvft6C/equkDnLyqsCUaBnyycHlAmI5AHlPwibh/0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JpXXJ+rD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JpXXJ+rD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775181773; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=OyHftAN8dhMQg9njDh58Weo7ed5uJBi0NSC4k8bM2NY=;
	b=JpXXJ+rDy6belaWMNVy8tLFZKrCJEC8bLzbbPbazslwb1K+fcjlWEvCB7ODf6OJDf+DHKtIb3F9Jdl5gxkQ1Axpd5gHZy4mcRSGZQPkhZ/ZXWyTpmcUJ1XQ2HUABrbDK2Cit3f/MghwgheJ243fPhIbvHUK1+af5JE58Jb8A6/s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0IdJa6_1775181770;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0IdJa6_1775181770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 10:02:51 +0800
From: fangyu.yu@linux.alibaba.com
To: fangyu.yu@linux.alibaba.com,
	anup@brainfault.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	skhan@linuxfoundation.org
Subject: Re: Re: Re: [PATCH v7 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
Date: Fri,  3 Apr 2026 10:02:49 +0800
Message-Id: <20260403020249.36676-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260403013137.32604-1-fangyu.yu@linux.alibaba.com>
References: <20260403013137.32604-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>On Thu, Apr 2, 2026 at 6:53 PM <fangyu.yu@linux.alibaba.com> wrote:
>>>
>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>
>>> Add a VM capability that allows userspace to select the G-stage page table
>>> format by setting HGATP.MODE on a per-VM basis.
>>>
>>> Userspace enables the capability via KVM_ENABLE_CAP, passing the requested
>>> HGATP.MODE in args[0]. The request is rejected with -EINVAL if the mode is
>>> not supported by the host, and with -EBUSY if the VM has already been
>>> committed (e.g. vCPUs have been created or any memslot is populated).
>>>
>>> KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE) returns a bitmask of the
>>> HGATP.MODE formats supported by the host.
>>>
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>> ---
>>>  Documentation/virt/kvm/api.rst | 27 +++++++++++++++++++++++++++
>>>  arch/riscv/kvm/vm.c            | 18 ++++++++++++++++--
>>>  include/uapi/linux/kvm.h       |  1 +
>>>  3 files changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index 032516783e96..9d7f6958fa81 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -8902,6 +8902,33 @@ helpful if user space wants to emulate instructions which are not
>>>  This capability can be enabled dynamically even if VCPUs were already
>>>  created and are running.
>>>
>>> +7.47 KVM_CAP_RISCV_SET_HGATP_MODE
>>> +---------------------------------
>>> +
>>> +:Architectures: riscv
>>> +:Type: VM
>>> +:Parameters: args[0] contains the requested HGATP mode
>>> +:Returns:
>>> +  - 0 on success.
>>> +  - -EINVAL if args[0] is outside the range of HGATP modes supported by the
>>> +    hardware.
>>> +  - -EBUSY if vCPUs have already been created for the VM, if the VM has any
>>> +    non-empty memslots.
>>> +
>>> +This capability allows userspace to explicitly select the HGATP mode for
>>> +the VM. The selected mode must be supported by both KVM and hardware. This
>>> +capability must be enabled before creating any vCPUs or memslots.
>>> +
>>> +If this capability is not enabled, KVM will select the default HGATP mode
>>> +automatically. The default is the highest HGATP.MODE value supported by
>>> +hardware.
>>> +
>>> +``KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE)`` returns a bitmask of
>>> +HGATP.MODE values supported by the host. A return value of 0 indicates that
>>> +the capability is not supported. Supported-mode bitmask use HGATP.MODE
>>> +encodings as defined by the RISC-V privileged specification, such as Sv39x4
>>> +corresponds to HGATP.MODE=8, so userspace should test bitmask & BIT(8).
>>> +
>>>  8. Other capabilities.
>>>  ======================
>>>
>>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>>> index 4d82a886102c..5e82a3ad3ad0 100644
>>> --- a/arch/riscv/kvm/vm.c
>>> +++ b/arch/riscv/kvm/vm.c
>>> @@ -201,6 +201,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>         case KVM_CAP_VM_GPA_BITS:
>>>                 r = kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
>>>                 break;
>>> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
>>> +               r = kvm_riscv_get_hgatp_mode_mask();
>>> +               break;
>>
>>Introducing a new RISC-V capability looks a bit complex.
>>Instead of KVM_CAP_RISCV_SET_HGATP_MODE, we can
>>simply re-use KVM_CAP_VM_GPA_BITS.
>>
>>The kvm_vm_ioctl_check_extension() for KVM_CAP_VM_GPA_BITS
>>return number of GPA bits which in-directly implies the underlying
>>hgatp.MODE. As we know, if it return 59 bits GPA then it means
>>Sv57x4 is the selected hgatp.MODE and Sv48x4 and Sv39x4 modes
>>are also supported as-per RISC-V privileged specification.
>>
>>The kvm_vm_ioctl_enable_cap() for KVM_CAP_VM_GPA_BITS
>>will take the desired number of GPA bits and downsize the selected
>>hgatp.MODE. For example, if user-space ask GPA bits <= 50 and
>>GPA bits > 41 then we select Sv48x4. If user-space ask GPA
>>bits <= 41 then we select Sv39x4. If user-space ask GPA bits <= 59
>>and GPA bits > 50 then we select Sv57x4.
>>
>
>Thanks, that makes sense.
>
>In v8 I’ll drop KVM_CAP_RISCV_SET_HGATP_MODE and re-use KVM_CAP_VM_GPA_BITS
>for both discovery and selection.
>

Hi Anup,

While working on the respin reusing KVM_CAP_VM_GPA_BITS, I realized
a potential ambiguity in CHECK_EXTENSION semantics and wanted to confirm the
intended ABI before posting v8.

One concern about the semantics: today KVM_CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS)
on a VM fd may be interpreted as “the GPA bits for this VM” (or at least what
this VM can use). If we also use KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) to downsize
the selected HGATP.MODE for a particular VM (e.g. to Sv48x4 => 50 bits), then a
subsequent CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS) on the same VM fd would return 50.
Userspace might then assume 50 is the maximum supported by that VM/host and lose
the information that the host actually supports 59 (Sv57x4).

Thanks,
Fangyu

>Thanks,
>Fangyu
>
>>>         default:
>>>                 r = 0;
>>>                 break;
>>> @@ -211,12 +214,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>
>>>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>>>  {
>>> +       if (cap->flags)
>>> +               return -EINVAL;
>>> +
>>>         switch (cap->cap) {
>>>         case KVM_CAP_RISCV_MP_STATE_RESET:
>>> -               if (cap->flags)
>>> -                       return -EINVAL;
>>>                 kvm->arch.mp_state_reset = true;
>>>                 return 0;
>>> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
>>> +               if (!kvm_riscv_hgatp_mode_is_valid(cap->args[0]))
>>> +                       return -EINVAL;
>>> +
>>> +               if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
>>> +                       return -EBUSY;
>>> +#ifdef CONFIG_64BIT
>>> +               kvm->arch.pgd_levels = 3 + cap->args[0] - HGATP_MODE_SV39X4;
>>> +#endif
>>> +               return 0;
>>>         default:
>>>                 return -EINVAL;
>>>         }
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 80364d4dbebb..a74a80fd4046 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -989,6 +989,7 @@ struct kvm_enable_cap {
>>>  #define KVM_CAP_ARM_SEA_TO_USER 245
>>>  #define KVM_CAP_S390_USER_OPEREXEC 246
>>>  #define KVM_CAP_S390_KEYOP 247
>>> +#define KVM_CAP_RISCV_SET_HGATP_MODE 248
>>>
>>>  struct kvm_irq_routing_irqchip {
>>>         __u32 irqchip;
>>> --
>>> 2.50.1
>>>
>>
>>Regards,
>>Anup
