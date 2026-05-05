Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805147DD63
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010788; cv=none; b=ljvAsATVvy4EtCjSfLiYN3sQLUge4vkRdNXA60h+34uF2rUrHEKV4YWSv5zQGeHxur63Hb0/ZzBG+7sKZFV3JavcGIeUghQQnkZiubGFGiXwrTteT66VrrU/qcO7n+l2hJGhbEKaOxWiIaXbdE0mjCR1fg/mdwmhkLXMxEDASQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010788; c=relaxed/simple;
	bh=wI5MclD6vKDbgNUt08qaSzPht5u02sZBvRiAID/r77Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eq2sDc5+gN4JmT/0qGLYhfFDPutnHuVMFsPVejk1oFxnUp/RuPJTbuonKabbZB+Y4DialXZrUkiDDPZwIfu1KgOpANOqLtpLSvj4QOXu7rYTPEkGzZWW5br/FjGVPMuKxVU06xPttVbNoWeV8WeGir4ynk2Gl03HX0OBeks3XDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVehaL2B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=StnDPLNh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVehaL2B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="StnDPLNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez9cYUWKCr2Quex9HXt94qBTCOieqPH9eIjMg0PQWG4=;
	b=bVehaL2BIlDvYqVrTt4sh8C/byHT2uIysvdR4yfCcGWgZ/5CPNUhk22TxFVYH91vM0Oc0o
	PMMveM0wZ+s2JBuZbZFMcVHPfwxF+YC8llRL54CXit0KN9D5iGGlwmTzMZ0SeFkz0GwzDI
	e89F/MzuaEWVEsqCi4prvKKlru+6mg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-OcU6urcAO9KcYr-RziTXEQ-1; Tue, 05 May 2026 15:53:04 -0400
X-MC-Unique: OcU6urcAO9KcYr-RziTXEQ-1
X-Mimecast-MFC-AGG-ID: OcU6urcAO9KcYr-RziTXEQ_1778010783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso39943845e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010783; x=1778615583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez9cYUWKCr2Quex9HXt94qBTCOieqPH9eIjMg0PQWG4=;
        b=StnDPLNh/4WjRhyZsfLiaHEMtcqIgziCPbQ37aVGKALVkxikrza+4tzlP8IF8bEyMN
         /ER88AjunU0s0UmwWnrnxQRZh27zyfsM6Crkceo4FYjJ8sWKjBIzzJF1nGQ7cdOlxS7P
         53xKJq7BKstnU0FITXpYCeTypNgvXRn2ZP6qj3NXgulWgIK10PPLWSy0h5bMPdan+rAS
         gx2kJghkSUeApJDzLE6THgptSTSrdKrKQX5dzf8NEytPswwVB9OaYql0Hq2soG1va/JV
         ADpC1I7AgI3fmVu36dkZU3up6D+FMU6KurzfJwv21deLwYQqcPMnI/nhFWFws3lxk7LO
         mjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010783; x=1778615583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ez9cYUWKCr2Quex9HXt94qBTCOieqPH9eIjMg0PQWG4=;
        b=QosBm6HMfhPA41+eDhXMBS3+mE/ZMN3DbyLnHhglqENaUlKJ1mBTTDuU1OvyRX+A43
         tYkaUcHYYO44r+e7cUykuIEaI7PMGMM61Wt8nTJ4A9qknHaYfIdGb/oJ13gEh3Z4fTWW
         aVyBc4hEWsvRsTkqnctPB+/wM/DGDgGx8ACLoN54bwiax+MIcTkbtpimbWNSlhm9005a
         gHduG4fmwcduCBLgR+cR/2pMBFG2CndkhdC4/FwPJGD7LJVybUC4Ej6YM5CZzULox1fR
         X6v4dGIGrw/7Bi+Ervckr1USpDeYOzR3IKVsy3+ujzIWC0Wlza8vQoM9th7GG2hS8VCR
         9o7w==
X-Forwarded-Encrypted: i=1; AFNElJ8Q8ytBbCRxVk9HzqCmSd1jYNLNCVGmEGdggWFYIr24t9a6R+qw2zue6zG0Pd6ZghckznE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYZNoV7rsQCeQZTiA5IH7ca4dyt3Qh5U+CXmyCvQHcm7+kpvK
	L6/Q5o+aTAfggAHIMO/cwEQgmZF9M2YoK2EqQXcfCqrYKZTE51BI4myUVCHvHk46Lmrs5hPXX6l
	S5KMZcCGJWX9cLF3UxrHMbkXcdywiBBtb3BLQMjMKoTM1ieXw47EJgg==
X-Gm-Gg: AeBDiesLg4qQ5R/59lcJGnbACraKqKwZbSvfYJfRlKxISe/oBJYiWxveJRgko/ZaRPY
	hYvjA/jrMm7B2PYjwafoARQU9q5kRXxncKyqI2SVPDsUx/TK+i4g6VEANAWzJ6yBTFX0zfTUw3P
	iAEOqYYltXJmOaQCeQHZ7K4x6ZAi+1wEvqYKLEIiWscCAA4XeGzs7j1XCXdEx5IGlNorHEDtt8x
	IXC1UCSlSS4lX+iRL63S00Heb7UY9lGErGGW2/HthHa8E6TDH6GUU04Nhwd54f4WZu+Vmt7ADYs
	aPvCtqIkyUahJWPS7ERWf7Ils3z1m5R6By80smgQ7GL0PmbHNjDtUhKC07XhBmT7ypknJqQ/7y1
	fIyBtztns9fRUKhmjqiJW1ZxUOGTAANuctMyUn7RJiopqNZ9Vf8tIgdIfaZc91t0A0oiTpJtfZn
	tR6/xRQ+H7U1tlwEFwbJ8HsznUXBbA87LY/NDvWPs=
X-Received: by 2002:a05:600c:8485:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-48e51f327f0mr10178365e9.12.1778010783375;
        Tue, 05 May 2026 12:53:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-48e51f327f0mr10178035e9.12.1778010782900;
        Tue, 05 May 2026 12:53:02 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm671793125e9.1.2026.05.05.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 14/28] KVM: x86/mmu: move cr4_smep to base role
Date: Tue,  5 May 2026 21:52:12 +0200
Message-ID: <20260505195226.563317-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 16eaf413b299..156050e22329 100644
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
@@ -5764,7 +5764,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
-	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
+	role.base.cr4_smep = ____is_cr4_smep(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
 
@@ -5776,7 +5776,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	else
 		role.base.level = PT32_ROOT_LEVEL;
 
-	role.ext.cr4_smep = ____is_cr4_smep(regs);
 	role.ext.cr4_smap = ____is_cr4_smap(regs);
 	role.ext.cr4_pse = ____is_cr4_pse(regs);
 
@@ -5835,6 +5834,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 	role.access = ACC_ALL;
 	role.cr0_wp = true;
+	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-- 
2.54.0

