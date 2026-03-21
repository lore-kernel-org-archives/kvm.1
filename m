Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4C284693
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051809; cv=none; b=ZIasmlDbdUsJ6PxfhJo048TqW3i2oGdQIcQ96wZFRmK2HlNKorgKfmHzpHl9096YYtAF3Yj/CJlTK2VLDYnaeQbEJv4GmnPkVlNoIf0CtI3ijOEGan9I4TJYCd34+He1JIHD7c3WtpWcERzTVY3+t3mmrMy4XLN+wLfSs54WZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051809; c=relaxed/simple;
	bh=thxTCLXMnXXt46NcG+nxt5y3q4ww1NruS+v2uYl1Qy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/L9Zf9JO3RLoGxntHChFWsv8C2jcctgLnyzFTKKrdQ18c6pm/0J2ZT5HVBE/swsd+glS6EznnWZaVIEFso2aeqSbxVNuD/aMXkEn1Ljjvi0YqAXsphPM+UqjDpLadNLb5IyJx6jQgHZja5sR9e+xhoHmwlBQ9Tml561CetIz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyTxAnUd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGyCdr++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyTxAnUd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGyCdr++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rt4woCnFZxmsTI89VQAPOQ9bzq7Xm3BBIVink+l0C4o=;
	b=NyTxAnUd/S77K2FC2q+X9chLLiRW2inxAOWKe2BfV40fjmHAvfhnfnOHmdil3ZKts7Y99y
	kR+UCYJelNYigsnQJFK8ihIiguRN6Haap/nJfBkKZ+x/1b/X9l6K6NYnQ9s8elN8byA0yQ
	ylYpJNt8jTzlC72N0TwM5vI8eyfn8qg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-P_wdR17-MMWfk2Sa-k3wig-1; Fri, 20 Mar 2026 20:10:03 -0400
X-MC-Unique: P_wdR17-MMWfk2Sa-k3wig-1
X-Mimecast-MFC-AGG-ID: P_wdR17-MMWfk2Sa-k3wig_1774051802
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso38450865e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051801; x=1774656601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt4woCnFZxmsTI89VQAPOQ9bzq7Xm3BBIVink+l0C4o=;
        b=AGyCdr++AmIdbSEqEW7XdvDbQgdT6wCnBFXr0wREbppk4pBpifFvOSeLJ/u5rGlEds
         h6RsbMqQjDZPvbMwsW030rfPnjA7+8Ii3ulpfcVwBevuhGBvvfL8ey1c1JNm/31jINkA
         qMIDO+LZKvDDM06y50NTww25muRcig9gi5F2Xg/ca4V/9jsQCPRFaxGuDASjNPKpWBJw
         AXvhE90bnNFtBZNaS5uEBJbMWKmypzy0DwoiIeXmbzNEmdjck2jRocaamzyAxYfbX2Yx
         0p2mSLv6B1EaQwm2jsNZDNFxZE0FwWxy0bh3jx1co9+Ex1Si25+KwJlAvQ33VEkfrUhI
         5q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051801; x=1774656601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rt4woCnFZxmsTI89VQAPOQ9bzq7Xm3BBIVink+l0C4o=;
        b=lumSuMDDk/8L7il00TPo7L+wcwAMBVb+6CUptD5O/S9Bv8ipQe4mKa88VP+j2frXAz
         90HYlZsQvqQX1xyM8NMntQ37PIQPTbPRYGrfmq8Z6LCd/LDlUs21B4j1WLkKnfRvNHT5
         OZncNUcEjj/YZbHW7pAT5+oP/+dKXXRPxP1hOnFCGWeNoN53Yd991PxjesQRfezO0Xb7
         zCf7/BH2112HwYRVwy4I/nBvk2OE8Nav66gZOOeHpYPqOcyixpiYaUF52Qg79TwMaKPG
         ez/7l2pOaqLkfk++mx/uQ2AgstlTXLlkVoGJ4J+LPbAzK+QAxSikxjjPdqHpEOM2GI+K
         4XSw==
X-Forwarded-Encrypted: i=1; AJvYcCXa4hrJKo+g9TANE2ENHFB09RnUw8RE8cwCRdbFsaeSm+2CDt/nf9ukVxNLWXtAlPeoBdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FFv4u6/JE/DWZHr8dEaJ6Je8UI3OPhGXcqMvVWHVdaUBQmd5
	P30625dVMwQK14Mee/ldqzrjEs1gXXsexuW4Sr8rOz5R2C5an+vkromFTISD+gXSV/i8Bez+auZ
	Hujlb5LYAeQCnCBm9ld8oLS/rWCqvZNEwBIVCVstcmelWkUnqYavcDrsRp3QMhQ==
X-Gm-Gg: ATEYQzxGR/JpbNFhdDqtQ7Dhb5x7Pp3f6nJSDd4T5h4dnU7mNSrl6NScW3If1Auz5h1
	4fQLgOCNqoKw/WirZsOnjwUFNF77yjDTK9EPAN0JMf1Z1IjA6a6z30LhwHFX1S5bSeP2rJfFa8J
	juOaeqxfpAlIRJc9ma0FscWHVaDS3kNDAEBvWNxq4WxgiBq6klw8OnGydFvYsBqR0WPY2KIgdPO
	iSl2lMyKwBMmq8xtfEZEMMZrHb5ylO5dtVsVVnaGSCO72LTVfs+RGSMxi2DRSJO02b2spYr2kWo
	EvSb+MSqhl+ad3swIghV4TwzdKcrpzzPNiCHBPlI0251O/ugF+lBwmmAgPxwz55YqsB3p5wQqHU
	M7oC9gFIYhJzSWddAzX0NEey6+RV3atNjE+wl/nnZVWEhdbd4D5KuwQ+B+K88Hfrjohl398SC4p
	ISX6pb8E9lhkZxlgIwPUE3p589
X-Received: by 2002:a05:600c:a43:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-486fedb586dmr71991015e9.9.1774051801139;
        Fri, 20 Mar 2026 17:10:01 -0700 (PDT)
X-Received: by 2002:a05:600c:a43:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-486fedb586dmr71990725e9.9.1774051800604;
        Fri, 20 Mar 2026 17:10:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm160796775e9.0.2026.03.20.17.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 11/22] KVM: x86/mmu: move cr4_smep to base role
Date: Sat, 21 Mar 2026 01:09:20 +0100
Message-ID: <20260321000931.1947084-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

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
index 18a5c3119e1a..2ac25b418b26 100644
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
index 3efb238c683c..0d6d20ab48dd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -332,8 +332,8 @@ struct kvm_kernel_irq_routing_entry;
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
@@ -349,12 +349,19 @@ union kvm_mmu_page_role {
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
 		unsigned :3;
 
 		/*
@@ -381,10 +388,10 @@ union kvm_mmu_page_role {
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
@@ -394,7 +401,6 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_pse:1;
 		unsigned int cr4_pke:1;
 		unsigned int cr4_smap:1;
-		unsigned int cr4_smep:1;
 		unsigned int cr4_la57:1;
 		unsigned int efer_lma:1;
 	};
@@ -1813,6 +1819,7 @@ struct kvm_x86_ops {
 	int (*set_tss_addr)(struct kvm *kvm, unsigned int addr);
 	int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
 	u8 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+	bool (*tdp_has_smep)(struct kvm *kvm);
 
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 254d69c4b9f3..a0b4774e405a 100644
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
@@ -5653,7 +5653,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
-	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
+	role.base.cr4_smep = ____is_cr4_smep(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
 
@@ -5665,7 +5665,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	else
 		role.base.level = PT32_ROOT_LEVEL;
 
-	role.ext.cr4_smep = ____is_cr4_smep(regs);
 	role.ext.cr4_smap = ____is_cr4_smap(regs);
 	role.ext.cr4_pse = ____is_cr4_pse(regs);
 
@@ -5724,6 +5723,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 	role.access = ACC_ALL;
 	role.cr0_wp = true;
+	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-- 
2.52.0

