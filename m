Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC93EEAFE
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630206; cv=none; b=q/hPRG6wsPdOA24/LlChj9Gff5lorMJEB2iZ5MIMmbFji81VqEdr0a/Y1KBYHdjRVR3lz3MV8ail8arqdwzV3yXNZmQTvvD+Sf4GfXTyTCA7B10L61FxH+8Huq9aE8CsncEXhvm4eEenYktdwKHIzEbViw5ht8nLLpj6QxPTmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630206; c=relaxed/simple;
	bh=tASlHiMGmonG5Oj5Tsl6KPbBklaqAUdTHq1KC0ulvHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWntNqbghdCf3YMHOCCvllxfHAin6DfwOoWcur0BPANgb1p5tyhmIfWOGBVaepR3QuPXb3jTPNLPJM4yzl55RQ5F/5Jw0kIYOsd6AET/n0QorHeNc2uTyusT7O9PlS9WjEUGeHXhnP92vlJ3181kpn7IB3pCXBw1Z4/1BCpUDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXWoW4Lu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXWoW4Lu"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84870e7f498so177657b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630202; x=1784235002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LtHroNlpBHIrmfhH7re3tEZyHRraW0QiukJmoZB0k4Y=;
        b=LXWoW4LuDrnr3xs1e48v10pCjqaSwG58sQfFvSZ9J92HQLx3VIzVq+MpO2nV6rD/SZ
         bJlG/ATqBtUfE91DkPiy6p5QaFjJvufFGp2gx98AQKTDQfgqzLVUGSy/qt1LzM+R530J
         bhRM7vK2nFwF16s67Ml1lcWCNB+4QlhqtNbmwUnqCt/8NhQ9SUgoj9RfRfUFP83JEx8J
         Q3LT0N5b8BBFKI8/mzlSpdjbr2RdtGjljFCkNdm9S1R256PwStMjlrCBRDTEScPKqXvx
         3ePmHlNeh0L52Jw7SjPt7uGZUTGK0H7FC3ynUH4VTSgudlMnX+mWlfPCu5Zpzkc2i9Fa
         7mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630202; x=1784235002;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtHroNlpBHIrmfhH7re3tEZyHRraW0QiukJmoZB0k4Y=;
        b=nWDiyZxlYoHoOw3P/mWiLdHXS1Nu1AbJNWpuXBcwN9yu3Qotrb4yEx+QcLuM/NeXcO
         w+gEHONmRkoBtnb49unEWggoKEATcZDRnn94ZysdMWnnZDO1yizY3th/mhBegp6VYwIM
         mB7hvTmeyurxwxqRRF5tcWlQ8rQC+oEOOJXZjFDGgN//mF3M/WfaxuAP5e7Tmz9yzflE
         e2QVn+i/XeHJTSqzxcAvgiQPzdHzUqtsEVZtNF0B0PmYVI+b48qNkUmiX8WuJXo61bwY
         h/UHT7HMIn0lj0Km6G54VrduAJm2DduoO+vb5aVbyf/RbRg/ufDC/ktDIjClA91/5uv5
         WKHA==
X-Gm-Message-State: AOJu0YzRjZCQfaAwsLII9psAs+5dhDLrn64CRJx/gBvXJWcyB2fiaWHp
	FMPqVK2aOBOOgA7LbH699UBinSk/DqEtmgmXNhnq1ednHveqHpj/G9VxezmdMG/Y/iEFXzCUIbk
	pa/YYgg==
X-Received: from pfblh15.prod.google.com ([2002:a05:6a00:710f:b0:848:409d:738f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:399f:b0:845:d286:1fb4
 with SMTP id d2e1a72fcca58-84842fc38f9mr8356764b3a.50.1783630201672; Thu, 09
 Jul 2026 13:50:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:40 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-11-seanjc@google.com>
Subject: [PATCH v4 10/18] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wire up a gmem_invalidate_range() call for SNP VMs, and use it to force
vCPUs to reload/recheck their guest-provided VMSA if the backing gmem
page is being invalidated, e.g. is being PUNCH_HOLE'd.  Use the same core
logic to handle invalidations as VMX does for the APIC-access page, as the
two concepts are nearly identical: shove the physical address of a page
into the vCPU's control structure:

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

Note #3, invalidate() and invalidate_range() have _completely_ different
semantics; the new invalidate_range() is a true invalidation, whereas the
existing invalidate() is really a "make shared" operation.  Ignore the
confusing naming and poor Kconfig bundling for the moment to minimize the
delta for LTS kernels, the mess will be cleaned up shortly.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel
Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Cc: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: J=C3=B6rg R=C3=B6del <joro@8bytes.org>
Cc: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  4 ++
 arch/x86/include/asm/kvm_host.h    |  6 +++
 arch/x86/kvm/mmu/mmu.c             |  5 ++
 arch/x86/kvm/svm/sev.c             | 80 ++++++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.c             |  2 +
 arch/x86/kvm/svm/svm.h             |  2 +
 arch/x86/kvm/x86.c                 |  6 +++
 include/linux/kvm_host.h           |  1 +
 virt/kvm/guest_memfd.c             |  4 ++
 9 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-=
x86-ops.h
index 83dc5086138b..ccf23b3f0e1c 100644
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
@@ -148,6 +149,9 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
 KVM_X86_OP_OPTIONAL(gmem_invalidate)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
+#endif
 #endif
=20
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index b517257a6315..1c598b40e0c3 100644
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
@@ -1902,6 +1905,9 @@ struct kvm_x86_ops {
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_or=
der);
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *rang=
e);
+#endif
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_pri=
vate);
 };
=20
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3eb1f86593b1..e2978e9a1731 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7589,6 +7589,11 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
=20
 	write_lock(&kvm->mmu_lock);
=20
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	if (slot->gmem.file)
+		kvm_arch_gmem_invalidate_range(kvm, &range);
+#endif
+
 	if (zap_all) {
 		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 30792adcfc8e..62c6126d52c0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3979,19 +3979,25 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
 	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
=20
-	/* Clear use of the VMSA. */
+	/*
+	 * Clear use of the VMSA.  Ensure snp_guest_vmsa_gpa is written exactly
+	 * once, as it is read locklessly when responding to gfn invalidations.
+	 * Pairs with the READ_ONCE() in sev_gmem_invalidate_range().
+	 */
 	svm->vmcb->control.vmsa_pa =3D INVALID_PAGE;
-	svm->sev_es.snp_guest_vmsa_gpa =3D INVALID_PAGE;
+	WRITE_ONCE(svm->sev_es.snp_guest_vmsa_gpa, INVALID_PAGE);
=20
 	/*
 	 * When replacing the VMSA during SEV-SNP AP creation,
@@ -4006,6 +4012,9 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu=
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
@@ -4024,15 +4033,20 @@ static void sev_snp_reload_vmsa(struct kvm_vcpu *vc=
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
@@ -4058,7 +4072,7 @@ static void sev_snp_init_protected_guest_state(struct=
 kvm_vcpu *vcpu)
 	gpa =3D svm->sev_es.snp_pending_vmsa_gpa;
 	svm->sev_es.snp_pending_vmsa_gpa =3D INVALID_PAGE;
=20
-	sev_snp_reload_vmsa(vcpu, gpa);
+	__sev_snp_reload_vmsa(vcpu, gpa);
=20
 	/*
 	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
@@ -4070,6 +4084,15 @@ static void sev_snp_init_protected_guest_state(struc=
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
@@ -5199,6 +5222,41 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t =
end)
 	}
 }
=20
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
+		/*
+		 * Read snp_guest_vmsa_gpa without taking the vCPU's VMSA mutex
+		 * (or its generic mutex) as mmu_lock is held, i.e. this task
+		 * can't sleep.  The VMSA is invalidated outside of mmu_lock,
+		 * but can only become valid inside of mmu_lock, i.e. the below
+		 * can get false positives, but not false negatives.  A false
+		 * positive is benign, as a spurious request simply forces the
+		 * vCPU to re-establish its VMSA.
+		 */
+		gpa_t gpa =3D READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa);
+
+		if (VALID_PAGE(gpa) &&
+		    gpa_to_gfn(gpa) >=3D range->start &&
+		    gpa_to_gfn(gpa) < range->end)
+			kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
+	}
+}
+
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_pri=
vate)
 {
 	int level, rc;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 79c818d91dda..dd51df74c2dc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5445,12 +5445,14 @@ struct kvm_x86_ops svm_x86_ops __initdata =3D {
 	.mem_enc_register_region =3D sev_mem_enc_register_region,
 	.mem_enc_unregister_region =3D sev_mem_enc_unregister_region,
 	.guest_memory_reclaimed =3D sev_guest_memory_reclaimed,
+	.reload_vmsa =3D sev_snp_reload_vmsa,
=20
 	.vm_copy_enc_context_from =3D sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from =3D sev_vm_move_enc_context_from,
=20
 	.gmem_prepare =3D sev_gmem_prepare,
 	.gmem_invalidate =3D sev_gmem_invalidate,
+	.gmem_invalidate_range =3D sev_gmem_invalidate_range,
 	.gmem_max_mapping_level =3D sev_gmem_max_mapping_level,
 #endif
 	.check_emulate_instruction =3D svm_check_emulate_instruction,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index effca6372e15..130205defffa 100644
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
@@ -1010,6 +1011,7 @@ extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code=
);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_or=
der);
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *rang=
e);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_pri=
vate);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area =
*vmsa);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8abd733d5173..5a5fd6211d23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8170,6 +8170,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
+		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
+			kvm_x86_call(reload_vmsa)(vcpu);
 	}
=20
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
@@ -10599,6 +10601,10 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm=
_pfn_t end)
 {
 	kvm_x86_call(gmem_invalidate)(start, end);
 }
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range =
*range)
+{
+	kvm_x86_call(gmem_invalidate_range)(kvm, range);
+}
 #endif
 #endif
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..c00fc1740ce5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2608,6 +2608,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_g=
fn, void __user *src,
=20
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range =
*range);
 #endif
=20
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86690683b2fe..659b8dbe0b30 100644
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
2.55.0.795.g602f6c329a-goog

