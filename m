Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65525447803
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696416; cv=none; b=mnT+IiSGte1FRsP2trs57M0Z/WtN5ZsaTH956qlzH89JvuNy7cSiBYxIMsRRrjfFyo3bB9x/XcCwETbj71yuRo8PBK1TfQPD/9nKzhGvY0PgV7Qldg4bajIDEJSwO1TpLeBBgHfiTXiPh4OHxt9UaC4F80/ja98s9dUPBdddyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696416; c=relaxed/simple;
	bh=kkdhU9HvxO9a2iwDACmdUBrjvBCHmEHvHRMmZu+eeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S7pdaJtATRvj3pQiBm6BwM4p0t1Qzz1qiHtEUzdWDvia4KafqsPwh5KRa2rd5GdrzFa0jCFQyCqQJRgIdlSJT5EIwBXy4nDf4J7eujwmGTWQu1PqDXACyeUJwbCY2c8OOv7S08+yWiierLlnKG6mf5CPAklVINA+eGxdb7vANdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qpjETMD6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qpjETMD6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786696398; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=n9/kMpHi1J6Odqy/MBWzFhpWVy4M9vqZHPs1iNyrDgU=;
	b=qpjETMD6L+dQMAZKwpSLzQ2NXRqrofZPx48Q4YEkavYQxeedn5W3RpBf1aiQoZBQhol9rugPJOwk/GdN58yVIJ7Td9nmzMEvS1fkJJJdyzVMU8mkfH/A9sEFKhgplbRyYJK7qt1bNhJ2z4e3nY4lCLjOl2nJG7U9tsisNNk4NmI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zhengrong_li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X8wvugu_1786696392;
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com fp:SMTPD_---0X8wvugu_1786696392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Aug 2026 16:33:18 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, zhengrong_li@linux.alibaba.com
Subject:
 [RFC] Expose L1 guest register state for nested VMX via KVM_GET_NESTED_STATE
Date: Fri, 14 Aug 2026 16:32:58 +0800
Message-ID: <178669637845.81620.8189698601844425753@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[RFC] Expose L1 guest register state for nested VMX via KVM_GET_NESTED_STATE

Problem
=======

KVM_GET_REGS and KVM_GET_SREGS always return the register state of the
currently active guest context.  When a vCPU is in VMX non-root
operation running an L2 nested guest, these ioctls return L2 state.
There is no way for userspace to retrieve L1 guest state while L2 is
active.

This affects any tool that inspects vCPU register state.  For example,
QEMU's "info registers" monitor command and GDB stub both show L2
registers when L2 is running, making nested VM debugging difficult.
Users have no way to determine where L1 was executing, what page tables
it was using, or which privilege level it was in.

SVM Comparison
==============

For AMD/SVM, KVM_GET_NESTED_STATE already returns the vmcb01 save area,
which provides comprehensive L1 state (see svm_get_nested_state() in
arch/x86/kvm/svm/nested.c, line 1943):

    copy_to_user(&user_vmcb->save, &svm->vmcb01.ptr->save,
                 sizeof(user_vmcb->save));

The SVM vmcb_save_area includes:

  Registers:  RIP, RSP, RAX, RFLAGS
  Control:    CR0, CR2, CR3, CR4, EFER
  Debug:      DR6, DR7
  Segments:   ES/CS/SS/DS/FS/GS (selector, base, limit, attr)
  Tables:     GDTR, IDTR, LDTR, TR
  Syscall MSRs: STAR, LSTAR, CSTAR, SFMASK, KERNEL_GS_BASE,
                SYSENTER_CS/ESP/EIP
  Other:      PAT, SPEC_CTRL, CPL

This gives userspace a near-complete snapshot of L1 state.

VMX has no equivalent.  KVM_GET_NESTED_STATE for VMX returns vmcs12
(which contains L2 guest state + L1 host-state area for VM-exit) but
never exposes L1's running guest state from vmcs01.

Proposed: L1 Guest State Snapshot for VMX
=========================================

Add a new section to the VMX nested state data that provides a
comprehensive L1 register snapshot, assembled from all sources KVM has
access to.

The data should be returned as a VMCS12-sized blob (same format as the
existing vmcs12 and shadow_vmcs12 sections).  This reuses existing
infrastructure and lets userspace parse fields using the well-known
vmcs12 layout.

Fields to include (from vmcs01 hardware VMCS):
  GUEST_RSP, GUEST_RIP, GUEST_RFLAGS
  GUEST_CR0, GUEST_CR3, GUEST_CR4
  GUEST_IA32_EFER, GUEST_IA32_PAT
  GUEST_DR7
  GUEST_ES/CS/SS/DS/FS/GS (selector, base, limit, ar_bytes)
  GUEST_GDTR, GUEST_IDTR (base, limit)
  GUEST_LDTR, GUEST_TR (selector, base, limit, ar_bytes)
  GUEST_SYSENTER_CS, GUEST_SYSENTER_ESP, GUEST_SYSENTER_EIP
  GUEST_PDPTR0-3
  GUEST_INTERRUPTIBILITY_INFO, GUEST_ACTIVITY_STATE

Additional fields from KVM's vcpu software model (vcpu->arch.*):
  CR2      -- vcpu->arch.cr2 (cached from last #PF)
  DR6      -- vcpu->arch.dr6 (cached from last debug event)
  MSR_IA32_SPEC_CTRL  -- vcpu->arch.spec_ctrl
  MSR_KERNEL_GS_BASE  -- via kvm_get_msr() or uret array
  MSR_STAR, MSR_LSTAR, MSR_CSTAR, MSR_SF_MASK
    -- via uret/uret_msrs array (populated on VM-exit)

Note: the MSR-derived fields (KERNEL_GS_BASE, STAR, LSTAR, CSTAR,
SFMASK, SPEC_CTRL) are not VMCS guest-state fields in Intel VMX.  They
are saved/restored by the VM-entry MSR-load mechanism or KVM's MSR
save/restore path.  The proposal is to populate these into the vmcs01
blob's corresponding vmcs12 fields if equivalents exist, or define a
small extension area for VMX-only fields.

Hardware Limitation (GPRs)
==========================

Neither Intel VMX nor AMD SVM saves general-purpose registers (beyond
RAX/RSP/RIP) into the VMCS/VMCB on VM-entry.  RBX, RCX, RDX, RSI, RDI,
R8-R15 remain in physical registers and are overwritten when L2 starts.

For SVM, hardware saves RAX to the VMCB save area; for VMX, RAX is not
in the VMCS guest-state area at all.  This is a hardware constraint,
not something KVM can work around.

The L1 hypervisor is responsible for saving its own GPRs (typically on
its stack), which KVM cannot locate.

Despite this limitation, having RIP, RSP, CR3, CR4, EFER, segment
state, syscall MSRs, and debug registers provides a comprehensive
snapshot for debugging: it tells you WHERE L1 was executing, its paging
mode, stack pointer, privilege level, syscall entry points, and debug
state.

Implementation Approach
=======================

1. New flag in arch/x86/include/uapi/asm/kvm.h:

   #define KVM_STATE_NESTED_VMX_L1_GUEST_STATE  0x08

2. Extend struct kvm_vmx_nested_state_data:

   struct kvm_vmx_nested_state_data {
       __u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
       __u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
       __u8 vmcs01[KVM_STATE_NESTED_VMX_VMCS_SIZE];  /* new */
   };

   The vmcs01 section is only populated when:
   - KVM_STATE_NESTED_VMX_L1_GUEST_STATE is set in input flags
   - The vCPU is currently in guest mode (L2 active)

3. In vmx_get_nested_state():

   When is_guest_mode(vcpu) and the new flag is set:
   a. Load vmcs01 temporarily (vmx_load_vmcs01 already exists)
   b. Read guest-state fields via vmcs_read*()
   c. Populate vmcs01 blob with guest-state values
   d. Fill non-VMCS fields (CR2, DR6, syscall MSRs, SPEC_CTRL)
      from vcpu->arch.* caches into a defined extension area
   e. Restore vmcs02 as active VMCS

   Alternatively, KVM caches some vmcs01 guest state in the vcpu
   software model (vcpu->arch.cr0/cr3/cr4/efer).  These cached values
   could be used for the fields that are always kept in sync, avoiding
   the need to load vmcs01 for those fields.  The vmcs_read*() approach
   is still needed for segment state and other fields that KVM does not
   cache in vcpu->arch.

   When the flag is not set, behavior is identical to today -- fully
   backward compatible.

Implementation Note
-------------------

Loading vmcs01 while L2 is active requires care:
- Must be done with preemption disabled
- vmx_load_vmcs01() already exists for this purpose
- copy_vmcs02_to_vmcs12_rare() demonstrates the pattern of temporarily
  switching VMCS for state reads
- After reading, vmcs02 must be reloaded as the active VMCS

QEMU Usage
==========

QEMU would use this to provide accurate nested debugging output.
When the vCPU is in L2 mode, the output would clearly label which
context the registers belong to, and additionally show L1 state:

   (qemu) info registers
   CPU#0 [L2 guest mode]

   L2 (current context from KVM_GET_REGS/KVM_GET_SREGS):
   RAX=0000000000000000 RBX=0000000000000000 RCX=0000000000040082 ...
   RIP=fffff8041602ab1f RSP=fffff80414323f68 RFL=00040282 CPL=0 HLT=1
   CS=0010 DS=002b ES=002b FS=0053 GS=002b SS=0018
   CR0=80050033 CR2=00000037a86f225a CR3=00000000001ae000 CR4=00350ef8
   DR6=00000000ffff0ff0 DR7=0000000000000400
   EFER=0000000000000d01
   ...

   L1 (from vmcs01 / vcpu caches):
   RIP=fffff8001234abcd RSP=fffff80014000000 RFL=00000246
   CR0=80050033 CR2=0000000000000000 CR3=00000000001ad000 CR4=00350ef8
   DR6=00000000ffff0ff0 DR7=0000000000000400
   EFER=0000000000000d01
   CS=0010 base=0000000000000000 limit=ffffffff ar=00a09b00
   DS=002b base=0000000000000000 limit=ffffffff ar=00c0f300
   ...

Alternatives Considered
=======================

1. New ioctl (KVM_GET_NESTED_REGS)
   - Separate interface for L1 registers
   - More API surface, but cleaner separation
   - Could return a flat struct with all L1 register fields

2. Extend KVM_GET_REGS/KVM_GET_SREGS with a "context" parameter
   - Add a flag to request L1 vs current
   - Changes semantics of widely-used ioctls

3. QEMU parses vmcs12 host-state area (no kernel change)
   - Already available, but only gives L1 VM-exit handler state
   - Missing most guest state; insufficient for debugging

4. Do nothing
   - SVM already exposes comprehensive L1 state; VMX users have no
     equivalent, creating a debugging gap
   - Nested VMX is increasingly common (Hyper-V on KVM, KVM on KVM)

I lean toward extending KVM_GET_NESTED_STATE because it reuses existing
infrastructure and parallels the SVM approach.  But I welcome feedback
on whether a new ioctl would be preferred, especially if maintainers
feel the vmcs12 blob format is not ideal for L1 state.

Questions for Maintainers
=========================

1. Is exposing L1 guest state via KVM_GET_NESTED_STATE acceptable?
   Are there security or stability concerns?

2. Is the vmcs12 blob format the right container for L1 state, or
   would a flat struct (like kvm_sregs) be preferred?

3. For MSR-derived fields (KERNEL_GS_BASE, STAR, LSTAR, etc.) that
   are not in the VMCS guest-state area: is it acceptable to populate
   them from vcpu->arch caches, or should they be omitted?

4. Is the GPR limitation (no RBX/RCX/RDX/etc., and no RAX for VMX)
   acceptable?  This is a hardware constraint shared by both Intel
   and AMD.

5. For the implementation: should we load vmcs01 to read all fields,
   or use cached values from vcpu->arch where available?  Are there
   concerns about cached state being stale?

Thank you for your time.

--
Zhengrong Li
