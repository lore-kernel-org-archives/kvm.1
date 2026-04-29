Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6523FBEA5
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468371; cv=none; b=dppN7FU9fxk54VrBef3P8K8LUzCxJ7SY55ilAa517+BPTC20kA2xYZql9zAy7S57fIGOpGLrSZLROMpAPM2z7HsSDbAaecw2rtyKbalvqQMokUKzOge525/OKjJni68aD/UpqcDbz/FYcVh/pUcoBJ8dLhVjrRM0YB8KYh2crpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468371; c=relaxed/simple;
	bh=cbKiqhmyH5VUZOFnX/urJu+FXvUOE411StIXrenRehQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6GVLHKe34QItGohs1zyXsLElGuddC+ed410ed4kAZZyrlRN29baNiYmBTKB1AuvWfj5URGOYOK5NsQt+LWHLEL/NbRolGirIY3nlWCVdoKUCzdLUx4uyQy6yUhldeKLgNnrRXEBLXtX4Zm89qSiP2uSw967SX2FQiCcGiAB9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGUCb4VG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGUCb4VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777468367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8E5kZ1RcB4dhWNt3KCYHJCaakGGspAk1TSHwRy0WfAQ=;
	b=EGUCb4VGoNeSBoKF/DeERQ3jGKtWXbKtpdHkrkA8GITqI4fmmXpcFzvUSNTEHjR/jcSTjU
	D9Ig5y+X6t1zyTx+KwdoL1YU8ct/u37nBVju40a6gD38ZV9ibpsY8K/I5TN8yB+ORNY+QN
	KvirOXbkFWYefA7KxOUCDih2IuOQWrI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-Zmrcb_iZPkuLWk3HurtCTg-1; Wed,
 29 Apr 2026 09:12:44 -0400
X-MC-Unique: Zmrcb_iZPkuLWk3HurtCTg-1
X-Mimecast-MFC-AGG-ID: Zmrcb_iZPkuLWk3HurtCTg_1777468363
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 857711800348;
	Wed, 29 Apr 2026 13:12:43 +0000 (UTC)
Received: from [10.44.50.163] (unknown [10.44.50.163])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22F65180045E;
	Wed, 29 Apr 2026 13:12:41 +0000 (UTC)
Message-ID: <56d2343e-cab0-4804-b078-eddeb33b3d02@redhat.com>
Date: Wed, 29 Apr 2026 15:12:38 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
To: David Riley <d.riley@proxmox.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: jon@nutanix.com
References: <20260428110946.11466-1-pbonzini@redhat.com>
 <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 4/29/26 15:05, David Riley wrote:
> Windows Guest:
> After the initial installation and verification I enabled
> Virtualization-Based Security (VBS) and Hypervisor-Protected Code
> Integrity (HVCI).
> 
> I set the following in the Group Policy Editor (DeviceGuard):
> * Select Platform Security Level: Secure Boot
> * Virtualization Based Protection of Code Integrity: Enabled without
>     lock
> * Require UEFI Memory Attributes Table: Checked
> 
> I tried to launch the Windows Guest with these QEMU CPU options:
> -cpu 'host,+kvm_pv_eoi,+kvm_pv_unhalt,level=30'
> 
> These flags worked with the last patch series (v3) without any issues
> [2][3].
> 
> I observed the following:
> The guest now never actually boots into Windows. It gets stuck before
> that and therefore does not even enter Windows Recovery.

Interesting, I'll see if I can reproduce.

> I found the following log in the journal:
> Apr 29 13:44:55 jura2 kernel: kvm_amd: kvm [29717]: vcpu0, guest rIP:
> 0xfffff83560f3b225 Unhandled WRMSR(0xc0010115) = 0x0
> 
> the same messages also appeared in dmesg:
> [ 1910.476609] kvm_amd: kvm [8755]: vcpu0, guest rIP:
> 0xfffff851f793b225 Unhandled WRMSR(0xc0010115) = 0x0

This is harmless.

> I also did a trace using `trace-cmd record -e kvm` and observed that
> the cpu seems to be stuck in a infinite loop. Snippet of the output:
> 
>         CPU 0/KVM-29834 [020] .....  8801.135700: kvm_page_fault:     
>   vcpu 0 rip 0xfffff83560f8f6a0 address 0x00000001011e9f80 error_code 
> 0x200000007
>         CPU 0/KVM-29834 [020] d..1.  8801.135701: kvm_entry:      vcpu 0 
> rip 0xfffff83560f8f6a0
>         CPU 0/KVM-29834 [020] d..1.  8801.135702: kvm_exit:      reason 
> EXIT_NPF rip 0xfffff83560f8f6a0 info 200000007 1011e9f80
>         CPU 0/KVM-29834 [020] .....  8801.135702: kvm_nested_vmexit:    
> <CANT FIND FIELD rip>vcpu 0 reason npf rip 0xfffff83560f8f6a0 info1 
> 0x0000000200000007 info2 0x00000001011e9f80 intr_info 0x00000000 
> error_code 0x00000000 requests 0x0000000000000000
>         CPU 0/KVM-29834 [020] .....  8801.135703: kvm_page_fault:     
>   vcpu 0 rip 0xfffff83560f8f6a0 address 0x00000001011e9f80 error_code 
> 0x200000007
>         CPU 0/KVM-29834 [020] d..1.  8801.135704: kvm_entry:      vcpu 0 
> rip 0xfffff83560f8f6a0
>         CPU 0/KVM-29834 [020] d..1.  8801.135705: kvm_exit:      reason 
> EXIT_NPF rip 0xfffff83560f8f6a0 info 200000007 1011e9f80
>         CPU 0/KVM-29834 [020] .....  8801.135705: kvm_nested_vmexit:    
> <CANT FIND FIELD rip>vcpu 0 reason npf rip 0xfffff83560f8f6a0 info1 
> 0x0000000200000007 info2 0x00000001011e9f80 intr_info 0x00000000 
> error_code 0x00000000 requests 0x0000000000000000
> 
> Could this be related to the new patch 24?

I wouldn't think so, but I might very well be wrong.  You could try 
reverting it.

Paolo

> Are there certain flags or enhancements I could try?
> 
> Please let me know if you need some additional debug output.
> 
> Best regards,
> David
> 
> [0] https://gitlab.com/qemu-project/qemu/-/ 
> commit/746a823a17f25393cc8c0cd1257f6dcef757bc09
> [1] https://learn.microsoft.com/en-us/windows/security/hardware- 
> security/enable-virtualization-based-protection-of-code-integrity? 
> tabs=security
> [2] https://lore.kernel.org/kvm/20260408154217.458420-1- 
> pbonzini@redhat.com/
> [3] https://lore.kernel.org/kvm/c91391f4-57b8-4bad- 
> aba8-2c47c285ab27@proxmox.com/
> 
> On 4/28/26 1:33 PM, Paolo Bonzini wrote:
>> I will send you to v3 (https://lore.kernel.org/ 
>> kvm/20260408154217.458420-1-pbonzini@redhat.com/)
>> for the description of the series, and leave a short list of changes:
>>
>> - patch 15: clear enable_mbec = 0 if enable_ept == 0
>> - patches 23-27: adjust for rename of nested_ctl to misc_ctl
>> - patch 24: new
>> - patch 27: disable svm_get_cpl for SEV-ES/SEV-SNP
>> - patch 28: fix commit message reference to __nested_svm_check_controls
>>
>> (patch 24 is the only major bugfix).
>>
>> Thanks,
>>
>> Paolo
>>
>> Jon Kohler (5):
>>    KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
>>    KVM: x86/mmu: remove SPTE_PERM_MASK
>>    KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
>>    KVM: nVMX: advertise MBEC to nested guests
>>    KVM: nVMX: allow MBEC with EVMCS
>>
>> Paolo Bonzini (23):
>>    KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
>>    KVM: x86/mmu: remove SPTE_EPT_*
>>    KVM: x86/mmu: merge make_spte_{non,}executable
>>    KVM: x86/mmu: rename and clarify BYTE_MASK
>>    KVM: x86/mmu: introduce ACC_READ_MASK
>>    KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
>>    KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
>>    KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
>>    KVM: x86: make translate_nested_gpa vendor-specific
>>    KVM: x86/mmu: split XS/XU bits for EPT
>>    KVM: x86/mmu: move cr4_smep to base role
>>    KVM: VMX: enable use of MBEC
>>    KVM: nVMX: pass advanced EPT violation vmexit info to guest
>>    KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
>>    KVM: x86/mmu: add support for MBEC to EPT page table walks
>>    KVM: x86/mmu: propagate access mask from root pages down
>>    KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
>>    KVM: SVM: add GMET bit definitions
>>    KVM: x86/mmu: set CR0.WP=1 for shadow NPT MMU
>>    KVM: x86/mmu: add support for GMET to NPT page table walks
>>    KVM: SVM: enable GMET and set it in MMU role
>>    KVM: SVM: work around errata 1218
>>    KVM: nSVM: enable GMET for guests
>>
>>   Documentation/virt/kvm/x86/mmu.rst |  10 +-
>>   arch/x86/include/asm/cpufeatures.h |   1 +
>>   arch/x86/include/asm/kvm-x86-ops.h |   1 +
>>   arch/x86/include/asm/kvm_host.h    |  48 ++++++---
>>   arch/x86/include/asm/svm.h         |   1 +
>>   arch/x86/include/asm/vmx.h         |  14 ++-
>>   arch/x86/kvm/hyperv.c              |   4 +-
>>   arch/x86/kvm/mmu.h                 |  30 ++++--
>>   arch/x86/kvm/mmu/mmu.c             | 168 ++++++++++++++++++++---------
>>   arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
>>   arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++-----
>>   arch/x86/kvm/mmu/spte.c            |  74 +++++++------
>>   arch/x86/kvm/mmu/spte.h            |  70 ++++++------
>>   arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
>>   arch/x86/kvm/svm/nested.c          |  37 ++++++-
>>   arch/x86/kvm/svm/svm.c             |  31 ++++++
>>   arch/x86/kvm/svm/svm.h             |   1 +
>>   arch/x86/kvm/vmx/capabilities.h    |  12 ++-
>>   arch/x86/kvm/vmx/common.h          |  20 ++--
>>   arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
>>   arch/x86/kvm/vmx/main.c            |   9 ++
>>   arch/x86/kvm/vmx/nested.c          |  46 +++++++-
>>   arch/x86/kvm/vmx/tdx.c             |   2 +-
>>   arch/x86/kvm/vmx/vmx.c             |  27 ++++-
>>   arch/x86/kvm/vmx/vmx.h             |   1 +
>>   arch/x86/kvm/vmx/x86_ops.h         |   1 +
>>   arch/x86/kvm/x86.c                 |  18 +---
>>   27 files changed, 505 insertions(+), 220 deletions(-)
>>
> 

