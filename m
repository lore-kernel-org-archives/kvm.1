Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273337FF4B
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515673; cv=none; b=B4xiNTmujbBuRToM8ccajTybL9p6LrG0S91R0JnelPbnmmYDsQX2NluQWNijHjjik2ZQ9Rwldk66aBiqzsgifsKlwtya7HNHdkOEq5PPfB4ngAa7jRZhf3Uc7+2HgQgqamFINuQea3/h8dhhYNVr0DeMUQB/p8g78BlkQAqYOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515673; c=relaxed/simple;
	bh=KG8AEOyHlE2otVi13kvzL73BVj4nMRalkXRND87oeXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoPn97072sAzBawJnlNaHE4ULzQfwSRYdJjMbZTz75CdokZb4sXFfyxmxVU1+65CgOAmperTRyBbUrzbY6rxS9Kp0j52VcfxQcKVQ1xDwcOc5As2H3ZdCvbBOl1mmXYtmr8JEPvlpdQinQlNDGZ8GEsM6NHbcgdYO88hnammE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7xeGzyV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7xeGzyV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a298cd62so779602a12.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515667; x=1783120467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyjjHPXqo8pPcrTiuemOH+UbhQBXyfEZGCyLEJ/o+8U=;
        b=o7xeGzyVWbproXkDWHriMoMeXBMO62QuYfcomXi51/JTTmUjYTi3OuX2Den6Q4BJpc
         zN6ocu5oecYUIJEZP2IbADu/JiZF4cBjjU26q9rBcom14c/W8fwbU78PN1NGUdHBKbQ+
         GiBVaO+09ku7sVfudUgMMqH2rM8DYq1/FTKfC9Z5HQTqe+O3HmU3EGt3tjd5/euvm/tq
         JS/MBDEPhqWJw9zA6ECVyEUcuGOXMw2b3s1IBeCUuxWWQiDIAVgz9+HOmd5AHF0vN4pB
         PfdW5y7ZXWVCQH9jNT1mSH/TZhx9Txvytccr8ayAHQx566hsbSXxnSs/tRfAsIGlxa4v
         gJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515667; x=1783120467;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HyjjHPXqo8pPcrTiuemOH+UbhQBXyfEZGCyLEJ/o+8U=;
        b=TG+5YQLRzkwWJ8Qm3HHq74f9gVouqD9wZCMjlvqegB7/UUHNZfZJ6SuznI6SnTtezb
         DdAvndhUhyTwoVEYGbs7Qo3C0p2kjCFLD1NaZvz041WuMKWkSMHEChjZUVE6SsqsnAf1
         tiUnZPIwezssatiNMk3StdF/OkP78/t4d3st00NsM1lb+B80dEXvuCzqJWuRGtEtPM14
         wli7IbWOg0ZAQMDRukiY+iDi+EoZgs6z9/j17ZKydLpkfdYsyAJgLramnewy0Ppg1Tle
         55cxQNeOnUlizaDVFxZj5IAZ0LikM2HM/FKStLWPdjVrOxoe7jnitUXQ8f3tUAjTUn38
         Ta6A==
X-Gm-Message-State: AOJu0Yx1A6yjKOJnv7DFceedejtyOjPtu7ipmv1vsel1LRJb5H+DI99n
	Ug1KaCg6UZLx5W0QbMc66iBXIqBfJSz1ICXAMr+wj3CEFdjFHTIwdBg54evH2FkgVpG1VRQ6ku9
	pmAj6Sg==
X-Received: from plbmj7.prod.google.com ([2002:a17:903:2b87:b0:2b0:46bd:4fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1246:b0:2c9:aae1:a611
 with SMTP id d9443c01a7336-2c9aae1a7e2mr5057515ad.23.1782515666913; Fri, 26
 Jun 2026 16:14:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:14 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-8-seanjc@google.com>
Subject: [PATCH v2 7/9] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wire up a gmem_invalid_range() call for SNP VMs, and use it to force vCPUs
to reload/recheck their guest-provided VMSA if the backing guest_memfd page
is being invalidated, e.g. is being PUNCH_HOLE'd.  Use the same core logic
to handle invalidations as VMX does for the APIC-access page, as the two
concepts are nearly identical: shove the physical address of a page into
the vCPU's control structure:

 1. Snapshot the invalidation sequence counter
 2. Grab the pfn (from guest_memfd in this case)
 3. Acquire mmu_lock for read
 4. Re-request reload if retry is needed, otherwise commit the change.

Note, the re-request action in #4 is necessary as KVM's retry logic is
fuzzy, i.e. can get false positives.  If the guest_memfd page has been
dropped, at some point a subsequent reload will fail to get a PFN from
guest_memfd, and KVM will fail KVM_RUN.  If the retry was due to a false
positive, KVM will retry until there are no relevant MMU notifier events
(and will retry in the "outer" loop, i.e. will drop locks and resched as
needed).

Note #2!  Take care to invalidate the VMSA when a relevant memslot is
DELETED or MOVED, as invalidations in response to PUNCH_HOLE are predicated
on memslot bindings (KVM doesn't know what GFN range(s) to invalidate
without a binding).  And more importantly, the VMSA mapping requires a
memslot, i.e. must be invalidated if its memslots disappears, regardless of
the state of the underlying guest_memfd inode.

Failure to invalidate the vCPU's control.vmsa_pa (which is checked by
pre_sev_run()) can prevent KVM from properly freeing the page as firmware
will reject the RMPUPDATE to reclaim the page with FAIL_INUSE if the vCPU
is actively running, i.e. if VMSA page is in-use.  That in turn leads to an
RMP #PF on the next use, as the page will still be assigned to the SNP VM.

  SEV-SNP: RMPUPDATE failed for PFN 78d198, pg_level: 1, ret: 3
  SEV-SNP: PFN 0x78d198, RMP entry: [0xfff0000000144001 - 0x000000000000000=
f]
  CPU: 3 UID: 0 PID: 31345 Comm: sev_snp_vmsa_pu Tainted: G     U     O
  Tainted: [U]=3DUSER, [O]=3DOOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102=
 01/25/2026
  Call Trace:
   <TASK>
   dump_stack_lvl+0x54/0x70
   rmpupdate+0x12c/0x140
   rmp_make_shared+0x3b/0x60
   sev_gmem_invalidate+0xe0/0x170 [kvm_amd]
   delete_from_page_cache_batch+0x1d8/0x220
   truncate_inode_pages_range+0x120/0x3d0
   kvm_gmem_fallocate+0x19a/0x270 [kvm]
   vfs_fallocate+0x1bc/0x1f0
   __x64_sys_fallocate+0x48/0x70
   do_syscall_64+0x10a/0x480
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x496c7e
   </TASK>
  ------------[ cut here ]------------
  SEV: Failed to update RMP entry for PFN 0x78d198 error -14
  WARNING: arch/x86/kvm/svm/sev.c:5160 at sev_gmem_invalidate+0x126/0x170 [=
kvm_amd], CPU#3: sev_snp_vmsa_pu/31345
  CPU: 3 UID: 0 PID: 31345 Comm: sev_snp_vmsa_pu Tainted: G     U     O
  Tainted: [U]=3DUSER, [O]=3DOOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102=
 01/25/2026
  RIP: 0010:sev_gmem_invalidate+0x12b/0x170 [kvm_amd]
  Call Trace:
   <TASK>
   delete_from_page_cache_batch+0x1d8/0x220
   truncate_inode_pages_range+0x120/0x3d0
   kvm_gmem_fallocate+0x19a/0x270 [kvm]
   vfs_fallocate+0x1bc/0x1f0
   __x64_sys_fallocate+0x48/0x70
   do_syscall_64+0x10a/0x480
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x496c7e
   </TASK>
  irq event stamp: 20689
  hardirqs last  enabled at (20699): [<ffffffff8e76092c>] __console_unlock+=
0x5c/0x60
  hardirqs last disabled at (20708): [<ffffffff8e760911>] __console_unlock+=
0x41/0x60
  softirqs last  enabled at (20722): [<ffffffff8e6cd74e>] __irq_exit_rcu+0x=
7e/0x140
  softirqs last disabled at (20717): [<ffffffff8e6cd74e>] __irq_exit_rcu+0x=
7e/0x140
  ---[ end trace 0000000000000000 ]---
  BUG: unable to handle page fault for address: ffff99a64d198000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x80000003) - RMP violation
  PGD 13eb001067 P4D 13eb001067 PUD 78d1d1063 PMD 1184e0063 PTE 800000078d1=
98163
  SEV-SNP: PFN 0x78d198, RMP entry: [0x6030000000144001 - 0x000000000000000=
f]
  Oops: Oops: 0003 [#1] SMP
  CPU: 3 UID: 0 PID: 31407 Comm: highlanderd_hea Tainted: G     U  W  O
  Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102=
 01/25/2026
  RIP: 0010:prep_new_page+0x67/0x220
  Call Trace:
   <TASK>
   get_page_from_freelist+0x1c40/0x1c70
   __alloc_frozen_pages_noprof+0xca/0x1f0
   alloc_pages_mpol+0x10b/0x1b0
   alloc_pages_noprof+0x81/0x90
   pte_alloc_one+0x1b/0xd0
   do_pte_missing+0xdf/0x1020
   handle_mm_fault+0x7c7/0xb20
   do_user_addr_fault+0x268/0x6b0
   exc_page_fault+0x67/0xa0
   asm_exc_page_fault+0x26/0x30
  RIP: 0033:0x4a6b1e
   </TASK>
  gsmi: Log Shutdown Reason 0x03
  CR2: ffff99a64d198000
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:prep_new_page+0x67/0x220

Drop the pseudo-TODO comment about needing to pin the page if guest_memfd
every supports migration, as integrating with invalidations events means
KVM will Just Work if/when page migration is ever supported (assuming SNP
hardware supports migrating VMSA pages).

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel
Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Cc: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: J=C3=B6rg R=C3=B6del <joro@8bytes.org>
Cc: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +
 arch/x86/include/asm/kvm_host.h    |  4 ++
 arch/x86/kvm/mmu/mmu.c             |  5 +++
 arch/x86/kvm/svm/sev.c             | 62 +++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c             |  2 +
 arch/x86/kvm/svm/svm.h             |  2 +
 arch/x86/kvm/x86.c                 |  6 +++
 include/linux/kvm_host.h           |  1 +
 virt/kvm/guest_memfd.c             |  4 ++
 9 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-=
x86-ops.h
index e36eba952705..69ca2a848ad6 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -134,6 +134,7 @@ KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
 KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
 KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
 KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
+KVM_X86_OP_OPTIONAL(reload_vmsa)
 KVM_X86_OP(get_feature_msr)
 KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
@@ -148,6 +149,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 KVM_X86_OP_OPTIONAL(gmem_free_folio)
 #endif
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index dd542c7a7376..776272dc6fdc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -122,6 +122,8 @@
 	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HV_TLB_FLUSH \
 	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_VMSA_PAGE_RELOAD \
+	KVM_ARCH_REQ_FLAGS(33, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
=20
@@ -1878,6 +1880,7 @@ struct kvm_x86_ops {
 	int (*vm_copy_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
 	int (*vm_move_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
 	void (*guest_memory_reclaimed)(struct kvm *kvm);
+	void (*reload_vmsa)(struct kvm_vcpu *vcpu);
=20
 	int (*get_feature_msr)(u32 msr, u64 *data);
=20
@@ -1902,6 +1905,7 @@ struct kvm_x86_ops {
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_or=
der);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *rang=
e);
 	void (*gmem_free_folio)(struct folio *folio);
 #endif
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_pri=
vate);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5925db37543f..8d36ca0a380b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7593,6 +7593,11 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
=20
 	write_lock(&kvm->mmu_lock);
=20
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	if (slot->gmem.file)
+		kvm_arch_gmem_invalidate_range(kvm, &range);
+#endif
+
 	if (kvm_memslot_flush_zap_all(kvm)) {
 		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3d90aa723dc2..04be49b1af57 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3979,11 +3979,13 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
=20
-static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
+static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
 	struct kvm_memory_slot *slot;
+	struct kvm *kvm =3D vcpu->kvm;
 	gfn_t gfn =3D gpa_to_gfn(gpa);
+	unsigned long mmu_seq;
 	struct page *page;
 	kvm_pfn_t pfn;
=20
@@ -4006,6 +4008,9 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu=
, gpa_t gpa)
 	if (!slot)
 		return;
=20
+	mmu_seq =3D kvm->mmu_invalidate_seq;
+	smp_rmb();
+
 	/*
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
@@ -4024,15 +4029,20 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vc=
pu, gpa_t gpa)
 	 */
 	svm->sev_es.snp_has_guest_vmsa =3D true;
=20
-	/* Use the new VMSA */
+	read_lock(&kvm->mmu_lock);
+	/*
+	 * Save the guest-provided GPA.  If retry is needed, then KVM will try
+	 * again with the same GPA.  If the VMSA is usable, then KVM needs to
+	 * track the GPA so that the VMSA can be reloaded if the backing page
+	 * for the GPA is invalidated.
+	 */
 	svm->sev_es.snp_guest_vmsa_gpa =3D gpa;
-	svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
+		kvm_make_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
+	else
+		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
+	read_unlock(&kvm->mmu_lock);
=20
-	/*
-	 * gmem pages aren't currently migratable, but if this ever changes
-	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
-	 * through some other means.
-	 */
 	kvm_release_page_clean(page);
 }
=20
@@ -4058,7 +4068,7 @@ static void sev_snp_init_protected_guest_state(struct=
 kvm_vcpu *vcpu)
 	gpa =3D svm->sev_es.snp_pending_vmsa_gpa;
 	svm->sev_es.snp_pending_vmsa_gpa =3D INVALID_PAGE;
=20
-	sev_snp_reload_vmsa(vcpu, gpa);
+	__sev_snp_reload_vmsa(vcpu, gpa);
=20
 	/*
 	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
@@ -4070,6 +4080,15 @@ static void sev_snp_init_protected_guest_state(struc=
t kvm_vcpu *vcpu)
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 }
=20
+void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_sev_es_state *sev_es =3D &to_svm(vcpu)->sev_es;
+
+	guard(mutex)(&sev_es->snp_vmsa_mutex);
+
+	__sev_snp_reload_vmsa(vcpu, sev_es->snp_guest_vmsa_gpa);
+}
+
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info *sev =3D to_kvm_sev_info(svm->vcpu.kvm);
@@ -5135,6 +5154,31 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn,=
 gfn_t gfn, int max_order)
=20
 	return 0;
 }
+void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *rang=
e)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	/*
+	 * An unstable result for "is SNP" is a-ok here, thanks to mmu_lock.
+	 * The vCPU's VMSA GPA is invalidated before the vCPU is made visible
+	 * to other tasks, and can only become valid while holding mmu_lock,
+	 * after the VM is fully committed to being an SNP VM.
+	 */
+	if (!____sev_snp_guest(kvm))
+		return;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		gpa_t gpa =3D to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa;
+
+		if (VALID_PAGE(gpa) &&
+		    gpa_to_gfn(gpa) >=3D range->start &&
+		    gpa_to_gfn(gpa) < range->end)
+			kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
+	}
+}
=20
 void sev_gmem_free_folio(struct folio *folio)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6f1823e820a4..7d3dd3719070 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5445,6 +5445,7 @@ struct kvm_x86_ops svm_x86_ops __initdata =3D {
 	.mem_enc_register_region =3D sev_mem_enc_register_region,
 	.mem_enc_unregister_region =3D sev_mem_enc_unregister_region,
 	.guest_memory_reclaimed =3D sev_guest_memory_reclaimed,
+	.reload_vmsa =3D sev_snp_reload_vmsa,
=20
 	.vm_copy_enc_context_from =3D sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from =3D sev_vm_move_enc_context_from,
@@ -5462,6 +5463,7 @@ struct kvm_x86_ops svm_x86_ops __initdata =3D {
=20
 #ifdef CONFIG_KVM_AMD_SEV
 	.gmem_prepare =3D sev_gmem_prepare,
+	.gmem_invalidate_range =3D sev_gmem_invalidate_range,
 	.gmem_free_folio =3D sev_gmem_free_folio,
 	.gmem_max_mapping_level =3D sev_gmem_max_mapping_level,
 #endif
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2f8215810a08..c7ecc5fca689 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -996,6 +996,7 @@ static inline struct page *snp_safe_alloc_page(void)
 {
 	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
 }
+void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu);
=20
 int sev_vcpu_create(struct kvm_vcpu *vcpu);
 void sev_free_vcpu(struct kvm_vcpu *vcpu);
@@ -1009,6 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code=
);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_or=
der);
+void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *rang=
e);
 void sev_gmem_free_folio(struct folio *folio);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_pri=
vate);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index adc1e1b244c7..9df6acf9a982 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8167,6 +8167,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
+		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
+			kvm_x86_call(reload_vmsa)(vcpu);
 	}
=20
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -10592,6 +10594,10 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t g=
fn, kvm_pfn_t pfn, int max_ord
 #endif
=20
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range =
*range)
+{
+	kvm_x86_call(gmem_invalidate_range)(kvm, range);
+}
 void kvm_arch_gmem_free_folio(struct folio *folio)
 {
 	kvm_x86_call(gmem_free_folio)(folio);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e5b47a5e4cea..6b7f8801505d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2607,6 +2607,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_g=
fn, void __user *src,
 #endif
=20
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range =
*range);
 void kvm_arch_gmem_free_folio(struct folio *folio);
 #endif
=20
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1618acc3ca64..8ec5041934db 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_fi=
le *f, pgoff_t start,
 		}
=20
 		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
+#endif
 	}
=20
 	if (flush)
--=20
2.55.0.rc0.799.gd6f94ed593-goog

