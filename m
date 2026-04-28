Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978743FAE17
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374609; cv=none; b=HFRH8r5VRLvBt0UmI0lG5BgcHuP8p96MviImjsHmpkxmyoHOFeO74jta3fJakk+qL4D8luOPMhmTnhqEs1ghC2FjQPSdAHE28WTEG3XM87bZR/MM6cLciam2iaB+t6OW52QT1tvqYS+S1tvMOiV1/f34LEtgdKH8UIB48bMyviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374609; c=relaxed/simple;
	bh=u/T/XnFEYI8jb2x+BMcXW1IpRiElxCRg/RvL4rLmSSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr/HaHyTwUV8gOfSy/sQbO5MrrYtTOV3BzS9LuVf6KI9oHQDv++fEiInMxTxrD7GswlwUq9/OVe9qgap7bs9AyE+j29EBCmJ5Q6C0uoopC+QTBxlZRUp81YVb2x8m7Yt5vVCTerwMXLnyKoJsuxjYuJkvqYb34u/eP0NpeqNSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8paft+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8paft+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5JGWhDyupao8iQS7w6vNtoMXP+MNkr3VzEL5bu/Qt0=;
	b=J8paft+NMZjUwjIVbGa7RuwkU1zVq3NXcs4M0BOa5IZleN+JygGcTll6MNK9YWrhKhZ+ic
	pHUd1lBIoe9bnZYxwKBeJ1h8bdXdCc0TQXjkde8aeOyRC3/tdXd3lDscVkvS/KAFydtAHO
	JHSXx4VWrNzo18AsX2CD0dhFhjsdtHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-ea44xMwNOI6HhxDtM0M77A-1; Tue,
 28 Apr 2026 07:10:00 -0400
X-MC-Unique: ea44xMwNOI6HhxDtM0M77A-1
X-Mimecast-MFC-AGG-ID: ea44xMwNOI6HhxDtM0M77A_1777374599
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092DD18002C6;
	Tue, 28 Apr 2026 11:09:59 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76109180045E;
	Tue, 28 Apr 2026 11:09:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 14/28] KVM: x86/mmu: move cr4_smep to base role
Date: Tue, 28 Apr 2026 07:09:32 -0400
Message-ID: <20260428110946.11466-15-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Guest page tables can be reused independent of the value of CR4.SMEP
(at least if WP=1).  However, this is not true of EPT MBEC pages,
because presence of EPT entries is signaled by bits 0-2 when MBEC
is off, and bits 0-2 + bit 10 when MBEC is on.

In preparation for enabling MBEC, move cr4_smep to the base role.
This makes the smep_andnot_wp bit redundant, so remove it.

Tested-by: David Riley <d.riley@proxmox.com>
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
index 3776cf5382a2..e4fca997ec79 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -94,6 +94,7 @@ KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
 KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
+KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL(link_external_spt)
 KVM_X86_OP_OPTIONAL(set_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 62dc782b2dd3..23a7ac8d7fbe 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -343,8 +343,8 @@ struct kvm_kernel_irq_routing_entry;
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
@@ -360,12 +360,19 @@ union kvm_mmu_page_role {
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
@@ -392,10 +399,10 @@ union kvm_mmu_page_role {
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
@@ -405,7 +412,6 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_pse:1;
 		unsigned int cr4_pke:1;
 		unsigned int cr4_smap:1;
-		unsigned int cr4_smep:1;
 		unsigned int cr4_la57:1;
 		unsigned int efer_lma:1;
 	};
@@ -1887,6 +1893,7 @@ struct kvm_x86_ops {
 	int (*set_tss_addr)(struct kvm *kvm, unsigned int addr);
 	int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
 	u8 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+	bool (*tdp_has_smep)(struct kvm *kvm);
 
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 72f56791122e..7ec29979a209 100644
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
@@ -5758,7 +5758,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
-	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
+	role.base.cr4_smep = ____is_cr4_smep(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
 
@@ -5770,7 +5770,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	else
 		role.base.level = PT32_ROOT_LEVEL;
 
-	role.ext.cr4_smep = ____is_cr4_smep(regs);
 	role.ext.cr4_smap = ____is_cr4_smap(regs);
 	role.ext.cr4_pse = ____is_cr4_pse(regs);
 
@@ -5829,6 +5828,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 	role.access = ACC_ALL;
 	role.cr0_wp = true;
+	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-- 
2.52.0


