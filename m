Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC423D6CDA;
	Mon, 11 May 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496849; cv=none; b=t/vBF6fj27aTfQ2r+qZyoCCLQA/FeXMWOxETGgz+RYRJcju2pEuKGIDkO9D5DOGxcv7ABK4RoTdswQQoedT6QHfVKG4V1iD/Sz5LtUkKkHfwyYcN+CS1OgAAQ86KIhpTA2NoQMKsGqluAOfL9zKMQ9RvDLXl/5CT1yFxc6pZ3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496849; c=relaxed/simple;
	bh=qscxFIM5lJvuXmSCjvKIqXAniCgOmviEUH8lm3h2Lcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6swuU7gfDd7gwBCY0ovn5/Zd7T84LGUTlUKlkMfXMJVFKu7Zz4j3H0aFtiMchD9EJPgS2mQ8t7E+GqdV981fF11FhyaY57Byu+zu0MkEmtQkA9cilGaRE+03v/EecxakzALHXsf2TeVksw+uMmIpTWAKFjz9n5SYCwy5tESbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B131FA0C49;
	Mon, 11 May 2026 12:53:56 +0200 (CEST)
Message-ID: <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
Date: Mon, 11 May 2026 12:53:54 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: jon@nutanix.com
References: <20260505195226.563317-1-pbonzini@redhat.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778496723325

Thanks again for the updated version of this patch series.

I have been testing v6 on Intel and AMD platforms again and observed
a regression on Intel when CET and MBEC are both exposed to a Windows
guest.

Environment:
- Kernel: mainline 7.1.0-rc2 (with v6 patches applied)
- QEMU: downstream 11.0.0-1
- Guest: Windows Server 2026 (24H2, Build 26100.1742)
- virtio-win: 0.1.271

Hosts:
Intel: Intel(R) Xeon(R) Gold 6426Y
AMD: Epyc 7302P

Both hosts are running Proxmox VE (based on Debian Trixie).

Windows Guest Setup:
After the initial installation and verification [0] I enabled
Virtualization-Based Security (VBS) and Hypervisor-Protected Code
Integrity (HVCI).

I set the following in the Group Policy Editor (DeviceGuard):
* Select Platform Security Level: Secure Boot
* Virtualization Based Protection of Code Integrity: Enabled without
     lock
* Require UEFI Memory Attributes Table: Checked


Issue: Host Lockups and Guest Hangs

On the Intel platform, the guest fails to boot when using:
QEMU options: -cpu host,level=30,+vmx-mbec

I observed two behaviors:
* The guest hangs indefinitely during the early boot phase. (Most
   frequent)
* The guest fails to boot and ends up in Windows Recovery Mode.

When the guest hangs during early boot, the host experiences hard/soft
lockups:

watchdog: CPU11: Watchdog detected hard LOCKUP on cpu 11
watchdog: BUG: soft lockup - CPU#11 stuck for 28s [CPU 0/KVM:16105]

I also recorded a trace of the virtual guest getting stuck using:
`trace-cmd record -e kvm`

and found the following:

Frequency of top RIP:
* 987816 rip 0xfffff801b031bf36
* 985670 rip 0xfffff801b031bf35
* 184002 rip 0x7ffd3e35

Sequence of Events:
--
CPU 0/KVM-16105 [001] .....  4327.371276: kvm_cr:  cr_write 4 = 0xb50ef8
...
CPU 0/KVM-16105 [001] .....  4327.373469: kvm_pio: pio_read at 0x608 size 4 count 1 val 0x5bcbb1
CPU 0/KVM-16105 [001] d..1.  4327.373469: kvm_entry:  vcpu 0 rip 0xfffff801b031bf36
CPU 0/KVM-16105 [001] d..1.  4327.373470: kvm_exit:  reason IO_INSTRUCTION rip 0xfffff801b031bf35 info 608000b 0
--
the last three lines seem to be repeating in a infinite loop.

On the AMD platform, the guest had no issue booting when using:
QEMU options: -cpu host

This seem to be the case because CET is not present on AMD.
I confirmed this using:
`cpuid -1 -l 7 -s 0`

which shows that:
- CET_SS: CET shadow stack                 = false
- CET_IBT: CET indirect branch tracking    = false

On Intel `cpuid -1 -l 7 -s 0` shows:
- CET_SS: CET shadow stack                 = true
- CET_IBT: CET indirect branch tracking    = true

If I explicitly disable them on Intel using:
QEMU options: -cpu host,level=30,+vmx-mbec,-cet-ss,-cet-ibt
the guest boots without issues.

This regression previously did not occur because I was using QEMU
version 10.2.0-1, where these options did not yet get exposed for this
particular Intel CPU [1].

Please let me know if you need further information or if there is
something else I could try/test.

[0] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security
[1] https://gitlab.com/qemu-project/qemu/-/commit/5cb89cad7f30be3175dd5abbb79ae5e634476cfa


On 5/5/26 9:50 PM, Paolo Bonzini wrote:
> This version can also be found in the "queue" branch of kvm.git.
> Since it should be final I'm including again for reference the full
> description.
>      
> Both MBEC and GMET allow more granular control over execute permissions,
> with different levels of separation between supervisor and user mode.
> MBEC provides support for separate supervisor and user-mode bits in the
> PTEs; GMET instead lacks supervisor-mode only execution (with NX=0,
> "both" is represented by U=0 and user-mode only by U=1).  GMET was
> clearly inspired by SMEP though with some differences and annoyances.
>
> The implementation starts from two changes to core MMU code, both
> of which help making the actual feature almost trivial to implement:
>
> - first, I'm cleaning up the implementation of nVMX exec-only, by
>    properly adding read permissions to the ACC_* constant and to the
>    permission bitmask machinery.  Jon also had to add a fourth ACC_*
>    bit, but used it only in the special case of nested MBEC; here
>    instead ACC_READ_MASK is the normality, which simplifies testing
>    a lot and removes gratuitous complexity.
>
> - second, I'm enforcing that KVM runs with MBEC/GMET enabled even in
>    non-nested mode, if it wants to provide the feature to nested
>    hypervisors.  This makes the creation of SPTEs looks exactly the
>    same for L1 and L2 guests, despite only the latter using MBEC/GMET
>    fully; the difference lies only in the input access permissions.
>
> This strategy adds a limited amount of complexity to the core is limited,
> while providing for an almost entirely seamless support of nested
> hypervisors.
>
> Later patches have to use slightly different meanings for ACC_* in Intel
> and AMD.  On the Intel side, some work is needed in order to split
> shadow_x_mask and ACC_EXEC_MASK in two; now that there is an actual
> ACC_READ_MASK to be used for exec-only pages, ACC_USER_MASK is unused
> and can be reused as ACC_USER_EXEC_MASK.  However, unlike the older
> ACC_USER_MASK hack these differences are backed by concrete concepts
> of the page table format, and there is always a 1:1 mapping from ACC_*
> bits to PT_*_MASK or shadow_*_mask:
>
>                              Intel                 AMD
>       --------------------   -------------------   -------------------
>       ACC_READ_MASK          PT_PRESENT_MASK       PT_PRESENT_MASK
>       ACC_WRITE_MASK         PT_WRITABLE_MASK      PT_WRITABLE_MASK
>       ACC_EXEC_MASK          shadow_xs_mask        shadow_nx_mask
>       ACC_USER_MASK          ---                   shadow_user_mask
>       ACC_USER_EXEC_MASK     shadow_xu_mask        ---
>
> On Intel, ACC_EXEC_MASK is used for kernel-mode execution and is tied to
> shadow_xs_mask (when MBEC is disabled, ACC_USER_EXEC_MASK and the XU bit
> are computed but ineffective).  update_permission_bitmask() precomputes
> all the necessary conditions.  On the AMD side, the U bit maps to
> ACC_USER_MASK but nNPT adjusts the permission bitmask to ignore it for
> reads and writes when GMET is active.  Despite the smaller scale of the
> changes compared to MBEC, there are some changes to make to use GMET
> for L1 guests, because the page tables have to be created with U=0.
> This means that the root page has role.access != ACC_ALL and its
> permissions have to be propagated down.
>
> Note that with MBEC the user/supervisor distinction depends on the U
> bit of the page tables rather than the CPL.  Processors provide this
> information to the hypervisor through the "advanced EPT violation
> vmexit info" feature, which is a requirement for KVM to use MBEC,
> and kvm-intel.ko passes it to the MMU in PFERR_USER_MASK (unlike
> kvm-amd.ko which computes it from the CPL).  This needs a small change
> to pass the effective XWU permissions of the page tables down to
> translate_nested_gpa().
>
> The former "smep_andnot_wp" bit of cpu_role.base, now named "cr4_smep",
> is repurposed for nested TDP to indicate that MBEC/GMET is on.  The minor
> pessimization for shadow page tables (toggling CR4.SMEP now always forces
> building a separate version of the shadow page tables, even though that's
> technically unnecessary if CR4.WP=1) is not really worth fretting about;
> in practice, guests are not going to flip CR4.SMEP in a way that would
> prevent efficient reuse of shadow page tables.
>
> Paolo
>
> v5->v6:
> - rename make_spte_executable to change_spte_executable
> - rename byte index in update_permission_bitmask to index
> - use (u8) casts before "KVM: x86/mmu: introduce ACC_READ_MASK"
> - make commit message for "KVM: x86/mmu: split XS/XU bits for EPT" more accurate
> - add XU to shadow_acc_track_mask already in "KVM: x86/mmu: split XS/XU bits for EPT"
> - fix compilation error
> - use alternative code for __vmx_handle_ept_violation suggested by Sean
>
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
>    KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
>    KVM: x86/mmu: introduce ACC_READ_MASK
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
>    KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
>    KVM: x86/mmu: add support for GMET to NPT page table walks
>    KVM: SVM: enable GMET and set it in MMU role
>    KVM: SVM: work around errata 1218
>    KVM: nSVM: enable GMET for guests
>
>   Documentation/virt/kvm/x86/mmu.rst |  10 +-
>   arch/x86/include/asm/cpufeatures.h |   1 +
>   arch/x86/include/asm/kvm-x86-ops.h |   1 +
>   arch/x86/include/asm/kvm_host.h    |  48 +++++---
>   arch/x86/include/asm/svm.h         |   1 +
>   arch/x86/include/asm/vmx.h         |  14 ++-
>   arch/x86/kvm/hyperv.c              |   4 +-
>   arch/x86/kvm/mmu.h                 |  30 +++--
>   arch/x86/kvm/mmu/mmu.c             | 182 ++++++++++++++++++++---------
>   arch/x86/kvm/mmu/mmutrace.h        |  19 +--
>   arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++----
>   arch/x86/kvm/mmu/spte.c            |  92 +++++++++------
>   arch/x86/kvm/mmu/spte.h            |  70 ++++++-----
>   arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
>   arch/x86/kvm/svm/nested.c          |  38 +++++-
>   arch/x86/kvm/svm/svm.c             |  31 +++++
>   arch/x86/kvm/svm/svm.h             |   1 +
>   arch/x86/kvm/vmx/capabilities.h    |  12 +-
>   arch/x86/kvm/vmx/common.h          |  26 +++--
>   arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
>   arch/x86/kvm/vmx/main.c            |   9 ++
>   arch/x86/kvm/vmx/nested.c          |  46 +++++++-
>   arch/x86/kvm/vmx/tdx.c             |   2 +-
>   arch/x86/kvm/vmx/vmx.c             |  27 ++++-
>   arch/x86/kvm/vmx/vmx.h             |   1 +
>   arch/x86/kvm/vmx/x86_ops.h         |   1 +
>   arch/x86/kvm/x86.c                 |  18 +--
>   27 files changed, 536 insertions(+), 228 deletions(-)
>

