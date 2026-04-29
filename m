Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A23A3E92;
	Wed, 29 Apr 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467955; cv=none; b=Q634kdHfd6rZ+QCijwEbZiv7N8O1wWLGhsjMGM47WHvG87PnHXGOlM4mO6UIm0cJ6xfH0Buip3gR+3IxF72XNpBBt1LVNvtHJO+CVeXs17ySFmrz1n4ywWcQrC/JioO6bt6eFS5t4oLXn2kMIS5Rr0A0OuLZknlJ5JUVg0OQVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467955; c=relaxed/simple;
	bh=OD3NhNJETaPWIcKqkklvtfGx4cPQVQClNbLzmYNj7TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGnMyK12LUDLN3RoR4o0SCXVcxDorh6YlRE9FXj0Twl7gUS5AdJwzH4efZd5776tfwGJOc5iGpbHImDp/MK8XvZWlpjChdtMymPy39715EEoJosh3r74QdrtcUVd9789pZp7Egt+IJ91oBsZyWImIXjRdSjXkJlg0RqLhumXzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AD5D1874FF;
	Wed, 29 Apr 2026 15:05:43 +0200 (CEST)
Message-ID: <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
Date: Wed, 29 Apr 2026 15:05:41 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: jon@nutanix.com
References: <20260428110946.11466-1-pbonzini@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777467844418

Hi Paolo, Hi Jon,

Thanks again Paolo, for the new version of this Patch Series.

I have once again tested this patch series (v4) focusing on the updated
implementation of GMET on the AMD Platform using Proxmox VE (based
on Debian Trixie) with a Windows Server guest
(24H2, Build 26100.1742).

Setup:
- Host CPU: AMD EPYC 7302P
- Kernel: mainline 7.1-rc1 (with v4 patches applied)
- QEMU: downstream 10.2.1 with the backported commit for the gmet
   option [0].
- virtio-win: 0.1.271

I started the Windows VM and verified that GMET was detected
correctly.
AvailableSecurityProperties [1]: 1,2,4,5,7

Windows Guest:
After the initial installation and verification I enabled
Virtualization-Based Security (VBS) and Hypervisor-Protected Code
Integrity (HVCI).

I set the following in the Group Policy Editor (DeviceGuard):
* Select Platform Security Level: Secure Boot
* Virtualization Based Protection of Code Integrity: Enabled without
    lock
* Require UEFI Memory Attributes Table: Checked

I tried to launch the Windows Guest with these QEMU CPU options:
-cpu 'host,+kvm_pv_eoi,+kvm_pv_unhalt,level=30'

These flags worked with the last patch series (v3) without any issues
[2][3].

I observed the following:
The guest now never actually boots into Windows. It gets stuck before
that and therefore does not even enter Windows Recovery.

I found the following log in the journal:
Apr 29 13:44:55 jura2 kernel: kvm_amd: kvm [29717]: vcpu0, guest rIP:
0xfffff83560f3b225 Unhandled WRMSR(0xc0010115) = 0x0

the same messages also appeared in dmesg:
[ 1910.476609] kvm_amd: kvm [8755]: vcpu0, guest rIP:
0xfffff851f793b225 Unhandled WRMSR(0xc0010115) = 0x0

I also did a trace using `trace-cmd record -e kvm` and observed that
the cpu seems to be stuck in a infinite loop. Snippet of the output:

        CPU 0/KVM-29834 [020] .....  8801.135700: kvm_page_fault:      vcpu 0 rip 0xfffff83560f8f6a0 address 0x00000001011e9f80 error_code 0x200000007
        CPU 0/KVM-29834 [020] d..1.  8801.135701: kvm_entry:      vcpu 0 rip 0xfffff83560f8f6a0
        CPU 0/KVM-29834 [020] d..1.  8801.135702: kvm_exit:      reason EXIT_NPF rip 0xfffff83560f8f6a0 info 200000007 1011e9f80
        CPU 0/KVM-29834 [020] .....  8801.135702: kvm_nested_vmexit:    <CANT FIND FIELD rip>vcpu 0 reason npf rip 0xfffff83560f8f6a0 info1 0x0000000200000007 info2 0x00000001011e9f80 intr_info 0x00000000 error_code 0x00000000 requests 0x0000000000000000
        CPU 0/KVM-29834 [020] .....  8801.135703: kvm_page_fault:      vcpu 0 rip 0xfffff83560f8f6a0 address 0x00000001011e9f80 error_code 0x200000007
        CPU 0/KVM-29834 [020] d..1.  8801.135704: kvm_entry:      vcpu 0 rip 0xfffff83560f8f6a0
        CPU 0/KVM-29834 [020] d..1.  8801.135705: kvm_exit:      reason EXIT_NPF rip 0xfffff83560f8f6a0 info 200000007 1011e9f80
        CPU 0/KVM-29834 [020] .....  8801.135705: kvm_nested_vmexit:    <CANT FIND FIELD rip>vcpu 0 reason npf rip 0xfffff83560f8f6a0 info1 0x0000000200000007 info2 0x00000001011e9f80 intr_info 0x00000000 error_code 0x00000000 requests 0x0000000000000000

Could this be related to the new patch 24?
Are there certain flags or enhancements I could try?

Please let me know if you need some additional debug output.

Best regards,
David

[0] https://gitlab.com/qemu-project/qemu/-/commit/746a823a17f25393cc8c0cd1257f6dcef757bc09
[1] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security
[2] https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/
[3] https://lore.kernel.org/kvm/c91391f4-57b8-4bad-aba8-2c47c285ab27@proxmox.com/

On 4/28/26 1:33 PM, Paolo Bonzini wrote:
> I will send you to v3 (https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/)
> for the description of the series, and leave a short list of changes:
>
> - patch 15: clear enable_mbec = 0 if enable_ept == 0
> - patches 23-27: adjust for rename of nested_ctl to misc_ctl
> - patch 24: new
> - patch 27: disable svm_get_cpl for SEV-ES/SEV-SNP
> - patch 28: fix commit message reference to __nested_svm_check_controls
>
> (patch 24 is the only major bugfix).
>
> Thanks,
>
> Paolo
>
> Jon Kohler (5):
>    KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
>    KVM: x86/mmu: remove SPTE_PERM_MASK
>    KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
>    KVM: nVMX: advertise MBEC to nested guests
>    KVM: nVMX: allow MBEC with EVMCS
>
> Paolo Bonzini (23):
>    KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
>    KVM: x86/mmu: remove SPTE_EPT_*
>    KVM: x86/mmu: merge make_spte_{non,}executable
>    KVM: x86/mmu: rename and clarify BYTE_MASK
>    KVM: x86/mmu: introduce ACC_READ_MASK
>    KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
>    KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
>    KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
>    KVM: x86: make translate_nested_gpa vendor-specific
>    KVM: x86/mmu: split XS/XU bits for EPT
>    KVM: x86/mmu: move cr4_smep to base role
>    KVM: VMX: enable use of MBEC
>    KVM: nVMX: pass advanced EPT violation vmexit info to guest
>    KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
>    KVM: x86/mmu: add support for MBEC to EPT page table walks
>    KVM: x86/mmu: propagate access mask from root pages down
>    KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
>    KVM: SVM: add GMET bit definitions
>    KVM: x86/mmu: set CR0.WP=1 for shadow NPT MMU
>    KVM: x86/mmu: add support for GMET to NPT page table walks
>    KVM: SVM: enable GMET and set it in MMU role
>    KVM: SVM: work around errata 1218
>    KVM: nSVM: enable GMET for guests
>
>   Documentation/virt/kvm/x86/mmu.rst |  10 +-
>   arch/x86/include/asm/cpufeatures.h |   1 +
>   arch/x86/include/asm/kvm-x86-ops.h |   1 +
>   arch/x86/include/asm/kvm_host.h    |  48 ++++++---
>   arch/x86/include/asm/svm.h         |   1 +
>   arch/x86/include/asm/vmx.h         |  14 ++-
>   arch/x86/kvm/hyperv.c              |   4 +-
>   arch/x86/kvm/mmu.h                 |  30 ++++--
>   arch/x86/kvm/mmu/mmu.c             | 168 ++++++++++++++++++++---------
>   arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
>   arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++-----
>   arch/x86/kvm/mmu/spte.c            |  74 +++++++------
>   arch/x86/kvm/mmu/spte.h            |  70 ++++++------
>   arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
>   arch/x86/kvm/svm/nested.c          |  37 ++++++-
>   arch/x86/kvm/svm/svm.c             |  31 ++++++
>   arch/x86/kvm/svm/svm.h             |   1 +
>   arch/x86/kvm/vmx/capabilities.h    |  12 ++-
>   arch/x86/kvm/vmx/common.h          |  20 ++--
>   arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
>   arch/x86/kvm/vmx/main.c            |   9 ++
>   arch/x86/kvm/vmx/nested.c          |  46 +++++++-
>   arch/x86/kvm/vmx/tdx.c             |   2 +-
>   arch/x86/kvm/vmx/vmx.c             |  27 ++++-
>   arch/x86/kvm/vmx/vmx.h             |   1 +
>   arch/x86/kvm/vmx/x86_ops.h         |   1 +
>   arch/x86/kvm/x86.c                 |  18 +---
>   27 files changed, 505 insertions(+), 220 deletions(-)
>

