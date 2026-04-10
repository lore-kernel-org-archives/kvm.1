Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D56397E81
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865532; cv=none; b=GTHjWO6x0TpdTPQjYtLOSRybC4kMNdtcZCyFL8LgvghMTyyCG6ejyWH8h7dRSuv5J4AEBZewh7tAz+ExS5GMTNwhkj+hw6DGp4XiDeCaMMDtIpJmyVSKcNu8IlqPkwKoAPrO4upWIUnAX1hpv+NTp4wp/7dhaZqO5VyybN3hep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865532; c=relaxed/simple;
	bh=Up0zPE44wbHizmXLy2N+MWhNJad8IKFfIgw/Q82aWvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u0L4nM2yNq3Dtfi03TCPutghtQ8rGeLTdHhL/Q7ajLS2kLWI2blzzVhkbrSjm8xrf99dThjaXYvD1Xz7PJ4jNnPdGjt40HiBFERFLk6qRQEuFJkvIbDtRY8vCd0jNziQHYQduLVlnABH+GKV25lhpWAesTi4hcIA+5i6bMKCjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPg0qnud; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPg0qnud"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so2922598a91.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865528; x=1776470328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt9IOTDzpkaNgZx9Kt8Jp36anBcR1CNnZR/7vwCAC/8=;
        b=vPg0qnudNJjtEDnHzTj49SnB3jidRQXw48ZzIXktrWpfY46el2YIUGo3c3chYzln0/
         X9mA9iS01wVvOfg5sbo6CDf5XysrRmFtgTyz0+nEdu2PhkFN56F/0Smoal6nF7qNSTZz
         8EBaEEVL4/BORRk1UuLizgLj4PtYD3OjcryxGssKa0gwfKvAsz66f8ZdCH264x9HXq8F
         HnNS2YIQbxatkWx2GvKTfSqOqGNmz642whRO5KiO9bBkQnB341yMJ8YA7klfv54oNUGC
         Fo5AmaPDrHaB8gmcemCW9i39OY6q5jIwD3Z45C9z2okt5SAftXCWrqrpSKhDWMtfX9jk
         MlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865528; x=1776470328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt9IOTDzpkaNgZx9Kt8Jp36anBcR1CNnZR/7vwCAC/8=;
        b=KKDeTZG+LJJRcqH4JfKCfPY3Q80q0m2eyw6VqS983tiaQqNjWSevWGKAEvrxl/uKNA
         rDVpokufRc8MhzNV/ZsLQVcYRkboQrsoEpeqdeAHxS2TQ7z6V2UB9DjvRlFFirBwFn+N
         nu5dmey7YmAtK+yjKU5tVTSSvju3ZKCFC/Oo4YlHjjO5NmBja9wOeRupqX9HRc+7KOLN
         kkMDG3RTLTM05X0hCgyke0UUyP7NNzZgh+nbDJrNOB623sU/3rlZhEBzHgSy4ZXxnJCz
         vgic6ku0lR/ZMnplzsgDuB1jsGZtYFO5k9IezC/VhW8ysMxuNSLOZn3Yj6FnJNOh2yW7
         adUQ==
X-Gm-Message-State: AOJu0YyWY66etDOMQmBgiuDCZISuNgamoCc+eIFnHUgi047vSbj0GowM
	CUUQNaE3PvyusohqdR8S5OqSN+En4qadmR96wvOUW6kMRxxYEIbopoWD6qkYzndMsmpQGy69FAx
	cLCG9bg==
X-Received: from pjbng10.prod.google.com ([2002:a17:90b:1a8a:b0:35c:15e7:3e9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d403:b0:354:a57c:65db
 with SMTP id 98e67ed59e1d1-35e428287ddmr4641345a91.20.1775865528381; Fri, 10
 Apr 2026 16:58:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:25 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Nested SVM changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A massive pile of nSVM changes, the majority of which are fixes of varying
urgency (though nothing so urgent as to warrant a mid-cycle pull request).

FWIW, there are a few more nSVM series lined up for 7.2 (gPAT, PMU host/guest
bits, and #NPF error code fixes), and I'm also hoping to see a series to
optimize TLB flushing sooner than later (but certainly not for 7.2).

As noted in the "svm" PULL request, the virt_ext => misc_ctl2 rename has a
minor conflict with the sev_es_guest() => is_sev_es_guest() overhaul.

There are several much-less-fun conflicts with kvm/master due to the RSM
fixes.  Here's what git shows for my merge commit (or just make it look like
kvm-x86/next and hope I didn't screw up? :-D).

diff --cc arch/x86/kvm/svm/nested.c
index b36c33255bed,b42d95fc8499..961804df5f45
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@@ -402,31 -448,6 +448,17 @@@ static bool nested_vmcb_check_save(stru
  	return true;
  }
  
- static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu)
- {
- 	struct vcpu_svm *svm = to_svm(vcpu);
- 	struct vmcb_save_area_cached *save = &svm->nested.save;
- 
- 	return __nested_vmcb_check_save(vcpu, save);
- }
- 
- static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
- {
- 	struct vcpu_svm *svm = to_svm(vcpu);
- 	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
- 
- 	return __nested_vmcb_check_controls(vcpu, ctl);
- }
- 
 +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
 +{
- 	if (!nested_vmcb_check_save(vcpu) ||
- 	    !nested_vmcb_check_controls(vcpu))
++	struct vcpu_svm *svm = to_svm(vcpu);
++
++	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
++	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
 +		return -EINVAL;
 +
 +	return 0;
 +}
 +
  /*
   * If a feature is not advertised to L1, clear the corresponding vmcb12
   * intercept.
@@@ -992,6 -1047,35 +1058,34 @@@ int enter_svm_guest_mode(struct kvm_vcp
  	return 0;
  }
  
+ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa)
+ {
+ 	struct vcpu_svm *svm = to_svm(vcpu);
+ 	struct kvm_host_map map;
+ 	struct vmcb *vmcb12;
+ 	int r = 0;
+ 
+ 	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+ 		return -EFAULT;
+ 
+ 	vmcb12 = map.hva;
+ 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
+ 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
+ 
 -	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
 -	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl)) {
++	if (nested_svm_check_cached_vmcb12(vcpu) < 0) {
+ 		vmcb12->control.exit_code = SVM_EXIT_ERR;
+ 		vmcb12->control.exit_info_1 = 0;
+ 		vmcb12->control.exit_info_2 = 0;
+ 		vmcb12->control.event_inj = 0;
+ 		vmcb12->control.event_inj_err = 0;
+ 		svm_set_gif(svm, false);
+ 		r = -EINVAL;
+ 	}
+ 
+ 	kvm_vcpu_unmap(vcpu, &map);
+ 	return r;
+ }
+ 
  int nested_svm_vmrun(struct kvm_vcpu *vcpu)
  {
  	struct vcpu_svm *svm = to_svm(vcpu);
diff --cc arch/x86/kvm/svm/svm.c
index d304568588c7,1e51cbb80e86..07ed964dacf5
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@@ -4880,16 -4999,12 +5000,15 @@@ static int svm_leave_smm(struct kvm_vcp
  	vmcb12 = map.hva;
  	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
  	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 -	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, false);
  
 -	if (ret)
 +	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
  		goto unmap_save;
  
- 	if (enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa,
- 				 vmcb12, false) != 0)
++	if (enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, false) != 0)
 +		goto unmap_save;
 +
 +	ret = 0;
- 	svm->nested.nested_run_pending = 1;
+ 	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
  
  unmap_save:
  	kvm_vcpu_unmap(vcpu, &map_save);
diff --cc arch/x86/kvm/vmx/vmx.c
index d16427a079f6,d75f6b22d74c..d76a21c38506
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@@ -8528,15 -8528,11 +8528,15 @@@ int vmx_leave_smm(struct kvm_vcpu *vcpu
  	}
  
  	if (vmx->nested.smm.guest_mode) {
 +		/* Triple fault if the state is invalid.  */
 +		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
 +			return 1;
 +
  		ret = nested_vmx_enter_non_root_mode(vcpu, false);
 -		if (ret)
 -			return ret;
 +		if (ret != NVMX_VMENTRY_SUCCESS)
 +			return 1;
  
- 		vmx->nested.nested_run_pending = 1;
+ 		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
  		vmx->nested.smm.guest_mode = false;
  	}
  	return 0;


The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-nested-7.1

for you to fetch changes up to 052ca584bd7c51de0de96e684631570459d46cda:

  KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name (2026-04-03 16:08:05 -0700)

----------------------------------------------------------------
KVM nested SVM changes for 7.1 (with one common x86 fix)

 - To minimize the probability of corrupting guest state, defer KVM's
   non-architectural delivery of exception payloads (e.g. CR2 and DR6) until
   consumption of the payload is imminent, and force delivery of the payload
   in all paths where userspace saves relevant state.

 - Use vcpu->arch.cr2 when updating vmcb12's CR2 on nested #VMEXIT to fix a
   bug where L2's CR2 can get corrupted after a save/restore, e.g. if the VM
   is migrated while L2 is faulting in memory.

 - Fix a class of nSVM bugs where some fields written by the CPU are not
   synchronized from vmcb02 to cached vmcb12 after VMRUN, and so are not
   up-to-date when saved by KVM_GET_NESTED_STATE.

 - Fix a class of bugs where the ordering between KVM_SET_NESTED_STATE and
   KVM_SET_{S}REGS could cause vmcb02 to be incorrectly initialized after
   save+restore.

 - Add a variety of missing nSVM consistency checks.

 - Fix several bugs where KVM failed to correctly update VMCB fields on nested
   #VMEXIT.

 - Fix several bugs where KVM failed to correctly synthesize #UD or #GP for
   SVM-related instructions.

 - Add support for save+restore of virtualized LBRs (on SVM).

 - Refactor various helpers and macros to improve clarity and (hopefully) make
   the code easier to maintain.

 - Aggressively sanitize fields when copying from vmcb12 to guard against
   unintentionally allowing L1 to utilize yet-to-be-defined features.

 - Fix several bugs where KVM botched rAX legality checks when emulating SVM
   instructions.  Note, KVM is still flawed in that KVM doesn't address size
   prefix overrides for 64-bit guests; this should probably be documented as a
   KVM erratum.

 - Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails instead of
   somewhat arbitrarily synthesizing #GP (i.e. don't bastardize AMD's already-
   sketchy behavior of generating #GP if for "unsupported" addresses).

 - Cache all used vmcb12 fields to further harden against TOCTOU bugs.

----------------------------------------------------------------
Jim Mattson (1):
      KVM: x86: SVM: Remove vmcb_is_dirty()

Kevin Cheng (4):
      KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
      KVM: nSVM: Raise #UD if unhandled VMMCALL isn't intercepted by L1
      KVM: SVM: Move STGI and CLGI intercept handling
      KVM: SVM: Recalc instructions intercepts when EFER.SVME is toggled

Sean Christopherson (12):
      KVM: x86: Defer non-architectural deliver of exception payload to userspace read
      KVM: nSVM: Delay setting soft IRQ RIP tracking fields until vCPU run
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: nSVM: Always intercept VMMCALL when L2 is active
      KVM: SVM: Separate recalc_intercepts() into nested vs. non-nested parts
      KVM: nSVM: Directly (re)calc vmcb02 intercepts from nested_vmcb02_prepare_control()
      KVM: nSVM: Use intuitive local variables in nested_vmcb02_recalc_intercepts()
      KVM: nSVM: Move vmcb_ctrl_area_cached.bus_lock_rip to svm_nested_state
      KVM: nSVM: Capture svm->nested.ctl as vmcb12_ctrl when preparing vmcb02
      KVM: SVM: Rename vmcb->nested_ctl to vmcb->misc_ctl
      KVM: SVM: Add a helper to get LBR field pointer to dedup MSR accesses
      KVM: x86: Suppress WARNs on nested_run_pending after userspace exit

Yosry Ahmed (49):
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: selftests: Extend state_test to check vGIF
      KVM: selftests: Extend state_test to check next_rip
      KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
      KVM: nSVM: Delay stuffing L2's current RIP into NextRIP until vCPU run
      KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
      KVM: SVM: Switch svm_copy_lbrs() to a macro
      KVM: SVM: Add missing save/restore handling of LBR MSRs
      KVM: selftests: Add a test for LBR save/restore (ft. nested)
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a helper
      KVM: nSVM: Refactor writing vmcb12 on nested #VMEXIT as a helper
      KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
      KVM: nSVM: Triple fault if restore host CR3 fails on nested #VMEXIT
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers
      KVM: nSVM: Drop the non-architectural consistency check for NP_ENABLE
      KVM: nSVM: Add missing consistency check for nCR3 validity
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Add missing consistency check for EVENTINJ
      KVM: nSVM: WARN and abort vmcb02 intercepts recalc if vmcb02 isn't active
      KVM: nSVM: Use vmcb12_is_intercept() in nested_sync_control_from_vmcb02()
      KVM: SVM: Rename vmcb->virt_ext to vmcb->misc_ctl2
      KVM: nSVM: Cache all used fields from VMCB12
      KVM: nSVM: Restrict mapping vmcb12 on nested VMRUN
      KVM: nSVM: Use PAGE_MASK to drop lower bits of bitmap GPAs from vmcb12
      KVM: nSVM: Sanitize TLB_CONTROL field when copying from vmcb12
      KVM: nSVM: Sanitize INT/EVENTINJ fields when copying from vmcb12
      KVM: nSVM: Only copy SVM_MISC_ENABLE_NP from VMCB01's misc_ctl
      KVM: selftest: Add a selftest for VMRUN/#VMEXIT with unmappable vmcb12
      KVM: SVM: Triple fault L1 on unintercepted EFER.SVME clear by L2
      KVM: selftests: Add a test for L2 clearing EFER.SVME without intercept
      KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
      KVM: x86: Move nested_run_pending to kvm_vcpu_arch
      KVM: SVM: Properly check RAX in the emulator for SVM instructions
      KVM: SVM: Refactor SVM instruction handling on #GP intercept
      KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
      KVM: SVM: Move RAX legality check to SVM insn interception handlers
      KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
      KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
      KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails
      KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
      KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name

 arch/x86/include/asm/kvm_host.h                    |  15 +
 arch/x86/include/asm/svm.h                         |  20 +-
 arch/x86/kvm/emulate.c                             |   3 +-
 arch/x86/kvm/hyperv.h                              |   8 -
 arch/x86/kvm/kvm_emulate.h                         |   2 +
 arch/x86/kvm/svm/hyperv.h                          |   9 +-
 arch/x86/kvm/svm/nested.c                          | 613 ++++++++++++---------
 arch/x86/kvm/svm/sev.c                             |   6 +-
 arch/x86/kvm/svm/svm.c                             | 352 ++++++++----
 arch/x86/kvm/svm/svm.h                             |  81 ++-
 arch/x86/kvm/vmx/nested.c                          |  50 +-
 arch/x86/kvm/vmx/vmx.c                             |  16 +-
 arch/x86/kvm/vmx/vmx.h                             |   3 -
 arch/x86/kvm/x86.c                                 |  78 ++-
 arch/x86/kvm/x86.h                                 |  10 +
 tools/testing/selftests/kvm/Makefile.kvm           |   3 +
 .../testing/selftests/kvm/include/x86/processor.h  |   5 +
 tools/testing/selftests/kvm/include/x86/svm.h      |  14 +-
 tools/testing/selftests/kvm/lib/x86/svm.c          |   2 +-
 .../selftests/kvm/x86/nested_vmsave_vmload_test.c  |  16 +-
 tools/testing/selftests/kvm/x86/state_test.c       |  35 ++
 .../selftests/kvm/x86/svm_lbr_nested_state.c       | 145 +++++
 .../selftests/kvm/x86/svm_nested_clear_efer_svme.c |  55 ++
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c      | 176 ++++++
 24 files changed, 1228 insertions(+), 489 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
