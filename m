Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071383A1D1B
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549084; cv=none; b=GZF6zM9QKpIq3Xw1T241z84jTaMOzP4ayPyS6hB2W8qYfAOu2ggN1fTAkGmCOFEGSBo0zwnuxOT6XaQ8tJ9FxdZI5bXOUfu3FQfqoCpyu/9ePA5y3hFy2V0FxUNgOL38UPWmjI1qail6SJ4dIyw+CIAV6rGznkxS8EGyG641dzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549084; c=relaxed/simple;
	bh=kV5YnC97ln5+DVsaOb883H58Ze7qwkIsim21YHCrnRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+YrgodpAo/df6fLSMfbmpuavlKxEgrXM5dYdTKfiNgxS+zLGKKAnVki663Va19VIw3BTZQfV1c0S9F1aiVZO1aTMBolZF3FfgxLzjvIu1nrJikLQLHqSLQW9Py1gZxgKLOOkNaRY24fnG1aUGYTVw1eCASWH2XY0JI3JMiSaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSWwM62B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVLAVCfv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSWwM62B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVLAVCfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys9YR6CdTMd5WSS5mBv+iUvUa9v1KcPcwFdGEo7dT2o=;
	b=FSWwM62BP54lE3XKw5IKH8Sp5UM3Q1Twt158Me4rFUu5FDh+Da2wJNTFxkaUL+1s8QbJu6
	gDhdm+JPIYNA8t1Z6QGLuzjR8Ej7hcplE5N0z2n7CS/YqfZt9mrWMCIlwQ3pU2dtxQZl3c
	ZVqrCvgMJPAsehFNp5+F6QW9z7b+2zY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-HiWMDTDMM62YdLXaA1v_4g-1; Thu, 26 Mar 2026 14:17:56 -0400
X-MC-Unique: HiWMDTDMM62YdLXaA1v_4g-1
X-Mimecast-MFC-AGG-ID: HiWMDTDMM62YdLXaA1v_4g_1774549075
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439cbfcfc21so1233657f8f.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549075; x=1775153875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys9YR6CdTMd5WSS5mBv+iUvUa9v1KcPcwFdGEo7dT2o=;
        b=eVLAVCfvgV/96ymIetRJaJ+nYiognZrool41FFlNySC8t+pXe0nDlScW8E2MOCn5Fh
         bgPVZI9I9OnwUQJXRaKO2Yja1rBcps50hjsMHLWIvzl2plQVD3yXPFBrUOLaxYIve1j4
         /QOQEs1EmaMXPiMHIBSNSbLdHm9gmwAe1QkV9Y0r8hRrgl2vK+Bhiofx3Q6rAPNkslgC
         r5ypFpwc1RLTE07y9nYbh3A/T/JOMQhqgPzeBxAnS3zdJ5UkGNPGiWadTJE8mtP/CA7j
         SaepI0ofFS51s4EAtTkULxngpCTdMfwMGiPbM8eZqgmK0vEnMHCAJLq61/htNDEEY4uw
         E6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549075; x=1775153875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ys9YR6CdTMd5WSS5mBv+iUvUa9v1KcPcwFdGEo7dT2o=;
        b=MR7Iw/DBnyB0tt6EBk6xWrqO7anLQQZBBLLJJKNDOpbfqOqyh7CUE1U1Yh62mdvOMq
         5bk5nzSnwMOAtTx/rITqf4fhbqWXqR8owR7efONTXBfxf4vBMem6JRcUvjU7+VeHDTxs
         6pxeDE9vGg+ZLLF/2Pm0y/EfK2wfg5XIEV7BFHWHTrkr+nMPMCpO1BCxbPB7WIumfJsr
         xrTQfMr9KqyuxV0rDXTOKMEBsj4lyo3Qu7EBl7ccpO9+EtYU0sW1HUt2pnaKhqfwVjD+
         TV+rJfMgeDoFnTFh3BEOPFM59c0jJMRfOj9ZZGbIkg0E+D2tJS0B3jAQC8VPaTzaPpAR
         f+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWCL3f5slAKKoNN9O8VwulCltMNpVlmwteRP/Q3NBR9petIqEQcqEmn+7RMBVz6AWPxLAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD73FAj89qoG8mdcJPu5l9j55ODUb2gVR6sBqQWcUSDPfDRxCp
	dv1/uHD1pSPUh5CkErvcOKe9TdxHp2QGh1Ml3iSPA+2psWCVT466GceoNNWoI+2WsmFvvbFfve0
	QzovY/TSQZ3JbnizaxMYwARrQeaZdrc3n+Q7O9zGDY0vjEmPkrmOWkQ==
X-Gm-Gg: ATEYQzwFcP7J7oa9ZrwhxlA1DjlL8qrPYvdfIBIbMioD7yf3CSlR1zwDYhg9VtPT4tL
	AXMUer1Q+vPsNZdO3wIXU0QfkrgAwpmPCE2VcYIQHg+Q2gmofErEjE+rhbI1Ma0CpZ16Kbe4vbc
	bd9s1Fs/kfoGKyxnFUXBw7D8xtcNXySoF5fo7I1+YWflR3TUonExNhFmoAGC2BQyZPYolAzZq7I
	5jzuWJlAl/l/U8LTwtWovDNpOMvAwKGC42g4v2a4tZzo1UOjhFKoSV2NuowVbyggFyxUXbt7Pkx
	f91dpQweWYPtSM2XoDzfoFMI88pggYw102CLIV61xwJWCoXL3DkoDfeovu+/KRzmpmJD87vM/66
	zDcgcNk3DZtToUkzrq0YAfhKrYLvV6Ch43tbeDCJRuzOOsLUUF2RWM4zX+kTVsTec3YgwW+hmHW
	wbp9lX/4qav4aGV1DAPmMgewee
X-Received: by 2002:a05:6000:1ac7:b0:439:b440:b8b0 with SMTP id ffacd0b85a97d-43b889f5ae2mr13531509f8f.45.1774549074993;
        Thu, 26 Mar 2026 11:17:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac7:b0:439:b440:b8b0 with SMTP id ffacd0b85a97d-43b889f5ae2mr13531444f8f.45.1774549074443;
        Thu, 26 Mar 2026 11:17:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf1c4sm9612818f8f.23.2026.03.26.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 11/24] KVM: x86/mmu: move cr4_smep to base role
Date: Thu, 26 Mar 2026 19:17:09 +0100
Message-ID: <20260326181723.218115-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
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
index 65671d3769f0..50a941ff61d1 100644
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
index a6ee467ad838..e768aeb05886 100644
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
@@ -5745,7 +5745,7 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
-	role.base.smep_andnot_wp = ____is_cr4_smep(regs) && !____is_cr0_wp(regs);
+	role.base.cr4_smep = ____is_cr4_smep(regs);
 	role.base.smap_andnot_wp = ____is_cr4_smap(regs) && !____is_cr0_wp(regs);
 	role.base.has_4_byte_gpte = !____is_cr4_pae(regs);
 
@@ -5757,7 +5757,6 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	else
 		role.base.level = PT32_ROOT_LEVEL;
 
-	role.ext.cr4_smep = ____is_cr4_smep(regs);
 	role.ext.cr4_smap = ____is_cr4_smap(regs);
 	role.ext.cr4_pse = ____is_cr4_pse(regs);
 
@@ -5816,6 +5815,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 	role.access = ACC_ALL;
 	role.cr0_wp = true;
+	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-- 
2.53.0

