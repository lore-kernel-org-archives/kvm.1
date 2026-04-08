Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B03D75B4
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662951; cv=none; b=r4r3VSefZrehDsfNymN0Q0UtcyRXsgUpJjWw1Brc02apacf3AhmSGh2sk1RdXFaBAb9tkCNi84CcD5SBvjOmy29cD9rlgkdy95kiCVZYctml2Vo1W4/xkOQws5LDrc55beJDzHlLU2ImLNLSG5IsytVue7ALMbAzxyjMn7Ppx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662951; c=relaxed/simple;
	bh=4wfYkrFN50FHG05YmSPc1pofxxO5dJR8621OgU+SFPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMnOeCJn8uDZvZz3UUHzrX4kdNdB32h6RrUYiqTyJhqu79DKOrNgEue4cxNPDVCreHW7c0lIXg73yIdt2o86VGeCwWS+B3dREcHgly8x15IPKfnTMLEjczRv2esVXL7iZpHRw32D6ZJMffsgYoV8CyDOzaJ1yJz7m0MDOhLqt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clLEK/S6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clLEK/S6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/vvFmSSmUOnfWiEIp/wD8q6eB+HbhY3sP9j1R2wBnb8=;
	b=clLEK/S6koiibWN4b+wTcRQVRMVOqQ+7uVmO/Grcsk03aVqVK9PvJ0JhC6E8XkZpJJxnlW
	Hpe5MXrMC1Kejmow4wu9lqn56ZfbsJDrkXyu9go6uyIzibG5Xqjje8xpyL+nwCbMzAi+xR
	/ZMvw7IBIH4465fugKMcgOHLBShr8is=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-Ang_U7wlMO6hU4dKTZmT_Q-1; Wed,
 08 Apr 2026 11:42:25 -0400
X-MC-Unique: Ang_U7wlMO6hU4dKTZmT_Q-1
X-Mimecast-MFC-AGG-ID: Ang_U7wlMO6hU4dKTZmT_Q_1775662938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C648D19560B2;
	Wed,  8 Apr 2026 15:42:18 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C036F180036E;
	Wed,  8 Apr 2026 15:42:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 00/27] KVM: combined patchset for MBEC/GMET support
Date: Wed,  8 Apr 2026 11:41:50 -0400
Message-ID: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series introduces support for two related features that Hyper-V uses
in its implementation of Virtual Secure Mode; these are Intel Mode-Based
Execute Control and AMD Guest Mode Execution Trap.

Both MBEC and GMET allow more granular control over execute permissions,
with different levels of separation between supervisor and user mode.
MBEC provides support for separate supervisor and user-mode bits in the
PTEs; GMET instead lacks supervisor-mode only execution (with NX=0,
"both" is represented by U=0 and user-mode only by U=1).  GMET was
clearly inspired by SMEP though with some differences and annoyances.

The series was developed starting from Jon Kohler's earlier version at
https://lore.kernel.org/kvm/20251223054806.1611168-1-jon@nutanix.com/.
The difference is that I am starting this implementation from two
changes to core MMU code, even before looking at nested MBEC/GMET;
these are seemingly unnecessary for that goal but they make the actual
feature almost trivial to implement:

- first, I'm cleaning up the implementation of nVMX exec-only, by
  properly adding read permissions to the ACC_* constant and to the
  permission bitmask machinery.  Jon also had to add a fourth ACC_*
  bit, but used it only in the special case of nested MBEC; here
  instead ACC_READ_MASK is the normality, which simplifies testing
  a lot and removes gratuitous complexity.

- second, I'm enforcing that KVM runs with MBEC/GMET enabled even in
  non-nested mode, if it wants to provide the feature to nested
  hypervisors.  Initially I thought this would mostly simplify the
  testing; but it actually has a big effect on the code as well, because
  the creation of SPTEs now looks exactly the same for L1 and L2 guests;
  the difference lies only in the input access permissions.

Later patches have to use slightly different meanings for ACC_* in Intel
and AMD, but the differences are driven by whether the underlying SPTEs
have U/NX or XS/XU bits, and propagate from there.  In other words,
unlike the older ACC_USER_MASK hack these differences are backed by
concrete concepts of the page table format, and there is always a 1:1
mapping from ACC_* bits to PT_*_MASK or shadow_*_mask:

                            Intel                 AMD
     --------------------   -------------------   -------------------
     ACC_READ_MASK          PT_PRESENT_MASK       PT_PRESENT_MASK
     ACC_WRITE_MASK         PT_WRITABLE_MASK      PT_WRITABLE_MASK
     ACC_EXEC_MASK          shadow_xs_mask        shadow_nx_mask
     ACC_USER_MASK          ---                   shadow_user_mask
     ACC_USER_EXEC_MASK     shadow_xu_mask        ---

On the Intel side, some work is needed in order to split
shadow_x_mask and ACC_EXEC_MASK in two; now that there is an actual
ACC_READ_MASK to be used for exec-only pages, ACC_USER_MASK is unused
and can be reused as ACC_USER_EXEC_MASK.  ACC_EXEC_MASK is used for
kernel-mode execution and is tied to shadow_xs_mask (when MBEC is disabled
shadow_xs_mask == shadow_xu_mask, and ACC_USER_EXEC_MASK is computed but
ineffective).  update_permission_bitmask() precomputes all the necessary
conditions.  Note that with MBEC the user/supervisor distinction
depends on the U bit of the page tables rather than the CPL.  Processors
provide this information to the hypervisor through the "advanced EPT
violation vmexit info" feature, which is a requirement for KVM to use
MBEC, and kvm-intel.ko passes it to the MMU in PFERR_USER_MASK.  When
walking guest page tables, PFERR_USER_MASK is passed to the final nEPT
walk via translate_nested_gpa().

On the AMD side, the U bit maps to ACC_USER_MASK but nNPT adjusts the
permission bitmask to ignore it for reads and writes when GMET is active.
Despite the smaller scale of the changes compared to MBEC, there are some
changes to make to use GMET for L1 guests, because the page tables have
to be created with U=0.  This means that the root page has role.access !=
ACC_ALL and its permissions have to be propagated down.

In both cases, the complexity added to the core is limited in comparison
to the benefits of a pretty seamless nested support.

The former "smep_andnot_wp" bit of cpu_role.base, now named "cr4_smep",
is repurposed for nested TDP to indicate that MBEC/GMET is on.  The minor
pessimization for shadow page tables (toggling CR4.SMEP now always forces
building a separate version of the shadow page tables, even though that's
technically unnecessary if CR4.WP=1) is not really worth fretting about;
in practice, guests are not going to flip CR4.SMEP in a way that would
prevent efficient reuse of shadow page tables.

Patches 1-9 are general cleanups, mostly for MMU code.

Patches 10-12 make kvm_translate_nested_gpa vendor-specific, to
account for the different meaning of the PFERR_USER_MASK for VMX vs. SVM.

Patches 13-20 are for Intel MBEC, with the first three covering
non-nested use.

Patches 21-27 are for AMD GMET, with 21/22/23/25 covering non-nested
use and the others covering nested virtualization.

Paolo

v2->v3:
- do not clear ACC_USER_EXEC_MASK for NX huge pages on AMD [Sashiko]
- add comment that is_executable_pte() works only because XS==XU [Sashiko]
- handle XU in __is_bad_mt_xwr [Sashiko]
- use CPL<3, not CPL==0, for U bit of nested #NPF [Sashiko]
- move forced clearing of GMET_ENABLE to __nested_copy_vmcb_control_to_cache [Sashiko]
- only add XU shadow_acc_track_mask if MBEC is enabled
- only enable nested MBEC if enable_mbec==true, likewise only set
  X86_FEATURE_GMET in svm_set_cpu_caps if gmet_enabled==true [Sashiko]
- add MBEC/GMET support to translate_nested_gpa (plus preparation)

v1->v2:
- fix EXPORT_SYMBOL_FOR_KVM_INTERNAL goof
- drop bit 10 from FROZEN_SPTE, add static_assert to catch it [Kai]
- fix exit qualification for page table EPT violations [kvm-unit-tests]
- add XU to shadow_acc_track_mask
- propagate root_role->access also in shadow MMU direct_map()
- add requested access to kvm_mmu_spte_requested tracepoint
- include support for passing advanced EPT violation vmexit info to guest
- advanced EPT violation vmexit info is now required for nested MBEC
- fix nested MBEC to gate XS vs XU based on the U bit of paging structures
- drop SECONDARY_EXEC_MODE_BASED_EPT_EXEC if L1 does not set it
- add mini commit message to "KVM: nVMX: advertise MBEC to nested guests" [Jon]
- drop gmet from /proc/cpuinfo [Borislav]
- fix running L1 without GMET



Jon Kohler (5):
  KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
  KVM: x86/mmu: remove SPTE_PERM_MASK
  KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
  KVM: nVMX: advertise MBEC to nested guests
  KVM: nVMX: allow MBEC with EVMCS

Paolo Bonzini (22):
  KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
  KVM: x86/mmu: remove SPTE_EPT_*
  KVM: x86/mmu: merge make_spte_{non,}executable
  KVM: x86/mmu: rename and clarify BYTE_MASK
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
  KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
  KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
  KVM: x86: make translate_nested_gpa vendor-specific
  KVM: x86/mmu: split XS/XU bits for EPT
  KVM: x86/mmu: move cr4_smep to base role
  KVM: VMX: enable use of MBEC
  KVM: nVMX: pass advanced EPT violation vmexit info to guest
  KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
  KVM: x86/mmu: add support for MBEC to EPT page table walks
  KVM: x86/mmu: propagate access mask from root pages down
  KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
  KVM: SVM: add GMET bit definitions
  KVM: x86/mmu: add support for GMET to NPT page table walks
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  48 ++++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |  14 ++-
 arch/x86/kvm/hyperv.c              |   4 +-
 arch/x86/kvm/mmu.h                 |  29 +++--
 arch/x86/kvm/mmu/mmu.c             | 165 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
 arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++-----
 arch/x86/kvm/mmu/spte.c            |  74 +++++++------
 arch/x86/kvm/mmu/spte.h            |  70 ++++++------
 arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
 arch/x86/kvm/svm/nested.c          |  33 +++++-
 arch/x86/kvm/svm/svm.c             |  30 ++++++
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/capabilities.h    |  12 ++-
 arch/x86/kvm/vmx/common.h          |  20 ++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |   9 ++
 arch/x86/kvm/vmx/nested.c          |  46 +++++++-
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  27 ++++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |  18 +---
 27 files changed, 500 insertions(+), 216 deletions(-)

-- 
2.52.0

