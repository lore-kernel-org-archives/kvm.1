Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E43DB659
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662961; cv=none; b=jv67TIhou44rWhCZIh67nWFmNHFOA5I+xLKxQiWGtI8oC0FhXprrGlJa/d5OVjvvRLht8eV0QQ4zGs57V1DJB24sVjIlr7fixvQCRM2yKybR7szeKVsoEaaUVVsUHgBZj4lFRnOiaxhASrZ5xtNn52UMNuZHrCfVDUUcdwwEdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662961; c=relaxed/simple;
	bh=EVq7oL8uEMO231dsy+MPZQt2fG2+GObD3otZ38j/nm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEArKue6tYYggzFkx5fxuBalMXf7lk6hltajZimNtB96MOtWP4UpoyZiMFiVO9OdGmmgPb1Bf2za/ayZYUgyFyX0ybBTXeMluQB6dCOuz+LjyGVgnfO2s8HTcjo0xZcdYaH1RPbmEeLbdAeqDF45q6RAN/Qh1mirguGjXRH2HcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwyZ7CSP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwyZ7CSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXT+GqnSDhFlo87FMfdObpuhhX2JHr2SghRG5EaXeTE=;
	b=MwyZ7CSP8F2Vvmy1kEqks24eGJGSHqJwAF6oHESP5ce4/dOr9Qxx7J5rIcpEMM4hIeSn4W
	ZdaEn0u88esTzR7vNFEAEnAK3QFImJV7+V9oeIcZjPgyH2zGemyHZCGX+Z9iin5PG8qnyE
	HOLfWq+TVxyGbserhIHAjL82urMXqj0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-VWX3loJoPTeq1UVPiLt6mg-1; Wed,
 08 Apr 2026 11:42:35 -0400
X-MC-Unique: VWX3loJoPTeq1UVPiLt6mg-1
X-Mimecast-MFC-AGG-ID: VWX3loJoPTeq1UVPiLt6mg_1775662953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73F37180057C;
	Wed,  8 Apr 2026 15:42:33 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FDF219560A6;
	Wed,  8 Apr 2026 15:42:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 14/27] KVM: x86/mmu: move cr4_smep to base role
Date: Wed,  8 Apr 2026 11:42:04 -0400
Message-ID: <20260408154217.458420-15-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Guest page tables can be reused independent of the value of CR4.SMEP
(at least if WP=1).  However, this is not true of EPT MBEC pages,
because presence of EPT entries is signaled by bits 0-2 when MBEC
is off, and bits 0-2 + bit 10 when MBEC is on.

In preparation for enabling MBEC, move cr4_smep to the base role.
This makes the smep_andnot_wp bit redundant, so remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 10 ++++------
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    | 23 +++++++++++++++--------
 arch/x86/kvm/mmu/mmu.c             |  6 +++---
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 2b3b6d442302..666aa179601a 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -184,10 +184,8 @@ Shadow pages contain the following information:
     Contains the value of efer.nx for which the page is valid.
   role.cr0_wp:
     Contains the value of cr0.wp for which the page is valid.
-  role.smep_andnot_wp:
-    Contains the value of cr4.smep && !cr0.wp for which the page is valid
-    (pages for which this is true are different from other pages; see the
-    treatment of cr0.wp=0 below).
+  role.cr4_smep:
+    Contains the value of cr4.smep for which the page is valid.
   role.smap_andnot_wp:
     Contains the value of cr4.smap && !cr0.wp for which the page is valid
     (pages for which this is true are different from other pages; see the
@@ -435,8 +433,8 @@ from being written by the kernel after cr0.wp has changed to 1, we make
 the value of cr0.wp part of the page role.  This means that an spte created
 with one value of cr0.wp cannot be used when cr0.wp has a different value -
 it will simply be missed by the shadow page lookup code.  A similar issue
-exists when an spte created with cr0.wp=0 and cr4.smep=0 is used after
-changing cr4.smep to 1.  To avoid this, the value of !cr0.wp && cr4.smep
+exists when an spte created with cr0.wp=0 and cr4.smap=0 is used after
+changing cr4.smap to 1.  To avoid this, the value of !cr0.wp && cr4.smap
 is also made a part of the page role.
 
 Large pages
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index de709fb5bd76..a02b486cc6fe 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -93,6 +93,7 @@ KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
 KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
+KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL(link_external_spt)
 KVM_X86_OP_OPTIONAL(set_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a20263a4e727..8b4a55cc0918 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -342,8 +342,8 @@ struct kvm_kernel_irq_routing_entry;
  *     paging has exactly one upper level, making level completely redundant
  *     when has_4_byte_gpte=1.
  *
- *   - on top of this, smep_andnot_wp and smap_andnot_wp are only set if
- *     cr0_wp=0, therefore these three bits only give rise to 5 possibilities.
+ *   - on top of this, smap_andnot_wp is only set if cr0_wp=0,
+ *     therefore these two bits only give rise to 3 possibilities.
  *
  * Therefore, the maximum number of possible upper-level shadow pages for a
  * single gfn is a bit less than 2^14.
@@ -359,12 +359,19 @@ union kvm_mmu_page_role {
 		unsigned invalid:1;
 		unsigned efer_nx:1;
 		unsigned cr0_wp:1;
-		unsigned smep_andnot_wp:1;
 		unsigned smap_andnot_wp:1;
 		unsigned ad_disabled:1;
 		unsigned guest_mode:1;
 		unsigned passthrough:1;
 		unsigned is_mirror:1;
+
+		/*
+		 * cr4_smep is also set for EPT MBEC.  Because it affects
+		 * which pages are considered non-present (bit 10 additionally
+		 * must be zero if MBEC is on) it has to be in the base role.
+		 */
+		unsigned cr4_smep:1;
+
 		unsigned:3;
 
 		/*
@@ -391,10 +398,10 @@ union kvm_mmu_page_role {
  * tables (because KVM doesn't support Protection Keys with shadow paging), and
  * CR0.PG, CR4.PAE, and CR4.PSE are indirectly reflected in role.level.
  *
- * Note, SMEP and SMAP are not redundant with sm*p_andnot_wp in the page role.
- * If CR0.WP=1, KVM can reuse shadow pages for the guest regardless of SMEP and
- * SMAP, but the MMU's permission checks for software walks need to be SMEP and
- * SMAP aware regardless of CR0.WP.
+ * Note, SMAP is not redundant with smap_andnot_wp in the page role.  If
+ * CR0.WP=1, KVM can reuse shadow pages for the guest regardless of SMAP,
+ * but the MMU's permission checks for software walks need to be SMAP
+ * aware regardless of CR0.WP.
  */
 union kvm_mmu_extended_role {
 	u32 word;
@@ -404,7 +411,6 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_pse:1;
 		unsigned int cr4_pke:1;
 		unsigned int cr4_smap:1;
-		unsigned int cr4_smep:1;
 		unsigned int cr4_la57:1;
 		unsigned int efer_lma:1;
 	};
@@ -1856,6 +1862,7 @@ struct kvm_x86_ops {
 	int (*set_tss_addr)(struct kvm *kvm, unsigned int addr);
 	int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
 	u8 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+	bool (*tdp_has_smep)(struct kvm *kvm);
 
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ff87dca46cc6..c4da7a42c77f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -227,7 +227,7 @@ static inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
 }
 BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
-BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smep);
+BUILD_MMU_ROLE_ACCESSOR(base, cr4, smep);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smap);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
@@ -5749,7 +5749,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
-	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
+	role.base.cr4_smep = ____is_cr4_smep(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
 
@@ -5761,7 +5761,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	else
 		role.base.level = PT32_ROOT_LEVEL;
 
-	role.ext.cr4_smep = ____is_cr4_smep(regs);
 	role.ext.cr4_smap = ____is_cr4_smap(regs);
 	role.ext.cr4_pse = ____is_cr4_pse(regs);
 
@@ -5820,6 +5819,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 	role.access = ACC_ALL;
 	role.cr0_wp = true;
+	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-- 
2.52.0


