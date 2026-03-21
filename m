Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB772D6401
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051832; cv=none; b=TTkpXMnQxcN1x3fWPKN5f1/Oq1JI63gnLi9rGkcNGwCG6R7Ba9V2TXcz5h3Im7FznXUft2M82stAHSLrXB8ZdiRWMEgKTo7gRnJOhBYcN4C0AYR0SQug54rySx7CwN17c+I4/82ObBze4sdsaGnyh6CctWA9PqGQ93X87NEE5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051832; c=relaxed/simple;
	bh=+ahruIUPnKlfxKy2o5ecEv12yn318QXZMDxIk0hlFag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jwx0yY2q/ZzaDbqWrKISNXBGHjJhIqdvIEKDyrGyNRC99WGq6Ts+W1k3srkvA7ZL+ZNL5xFFx9iFFWSBoaSji3L/GYly+JKw3vHWeeT+pRFVABoHFHumwSNfVIdbxz6HwhFPNeDgk73hKgY3dFe/ee18yIoYZKj7tCAqs6Qsivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFm6oVQ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAgrRRod; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFm6oVQ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAgrRRod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKk6jKe/ZOTufFbEyG3fogFhPhiv78Ux0FHciYJwilU=;
	b=OFm6oVQ65pIk1FWFhPqBH4mGy8LdZRYxQlVNU3ZQ/OQU34+eHDfC6kG2I/gX0FbtmjwFCh
	eLPXvZAxUtVIGDlyVwmWfJxcrOM1xSew4kZW+ruS94mNek1p8oMnaxP5JGyCvQmyVo7ONo
	QmPm0Pvw9GXfqWjbz7u+6bp/0PteeBE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-fuNqiqXsNEuq39F-3_cXKw-1; Fri, 20 Mar 2026 20:10:29 -0400
X-MC-Unique: fuNqiqXsNEuq39F-3_cXKw-1
X-Mimecast-MFC-AGG-ID: fuNqiqXsNEuq39F-3_cXKw_1774051828
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b42cd4becso1599922f8f.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051827; x=1774656627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKk6jKe/ZOTufFbEyG3fogFhPhiv78Ux0FHciYJwilU=;
        b=HAgrRRodh6lTTEBubsrFk97RcWaAIczvDqZHS29GHPu52RO4fB0A/YrcZtTUbGzM5k
         4pvBYeBvUlYHC2MHVUU+Fatj28C+ph3Hxc/ceEWyId/7GYVdLigLb6KN93ClnMwwQpxI
         RPZwpbQchh1qkVYa+jnbdMBePYtR+hvLUBHlVj3nR3gRpM1IEuthNM9TfFIqqc6K4o4o
         S3oQJpR23mzErPkQ8sGec0OjmW+aE8UTSQMrxlpnos5NZSz/jxRgoHnSkPsjKqNEE68U
         IbI0TDAJPvvLUpv+R38CItQLpSTPwlOuQ0Bk5r8xV3gr1n8syNhU1I1JVe9q+G3llluu
         G9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051827; x=1774656627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKk6jKe/ZOTufFbEyG3fogFhPhiv78Ux0FHciYJwilU=;
        b=B3X5tHkeE7M+V4dCO/LDFyrVVWilzJkUrvemVhkWDLR9rPmP+f5wcu9JSroCbaoBrG
         IdHYpNDLbbE+UzVYEwMG1KDmPFb3kMsRYmiKt7atlHiQyVuAL9KhSVImlsSbQKXA+q5J
         lzRW6wnwfhihRgv5u8+UcsdExRWub6eMvBZZT4JVyobVVFNy8IUhInlLXaVZt3yc6hg8
         inOacazBPDzBehU+hk9aYf8sJzUoH7/RgZcPOCZnMj3G/ARuRDpgSX4EmAmVhnEBMFAG
         Im1KzSgcCNXXJ9c3KUv8cr42jz5xrIQfzfuGK9sGLyiDFGQa0tZ9kYW8y950rXFvGTBO
         aZGg==
X-Forwarded-Encrypted: i=1; AJvYcCUY2U2qsAOvhbxyrDQzF/d2Io1THoQ05Gc1EujT+7xA1KkgXoRA5yo3IZhafO/31iPaET0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eGA1wjMdgFgtzePDU9uEv6BPA/2EHBKSZ+pD8KdHhVjO6Yhx
	XOhWQeP9UhsZnd/vMW7aq5hkcnstsnBzrbZbuyM85nVLPqsfv1vdm0pv/3ypG6QreOt00o8i2X7
	sN4NQQz9uhP3YaLLquDlN+2BsZmIuPdKxObu1HUkQkO8EfO8QKsHP9g==
X-Gm-Gg: ATEYQzx3X3t+dHoe7AOn3yCi+mHoNmqNzjV8NS+Jc8B72g435il6NE60oqsz21nf16O
	T38LG6UyzJzFyfKsvXyiU5GX9AAK6OgKgKn9S0lqKbQwsdUI4Ei8szCg8b/WvaPRmlsUVibR0Ob
	Dx21s0miQN0Ua+Rs53GrBof7C7Z1nsluaCvht3tcidZiPWGIXTnIH41LunIJxRD8AXiq2A35jDC
	Li0/uIZK9/ldQkVw1x+xBtz8zJ2z8ZGV2axa5viwb0P+xvM53EPOTj+hiVCFs2+ufUQietYlYzu
	p5znIroO4u71Pu++VFUaShfKpKQYbelDZL5JSR62biSfkhILZX7nDtQcubJDG8h6OqqCBTP3SsW
	ntgELef0bI6SFYl8xGWqyro5KtOy2W7r5AV6d+0tnnQDbg5Nkdr3Z4MEOp011BJvetfcOMJ0V6f
	plClAdSg+zcbnnSImMYCsuHzPi
X-Received: by 2002:a5d:452b:0:b0:439:d0ac:8a8f with SMTP id ffacd0b85a97d-43b576e6efbmr10619729f8f.1.1774051826794;
        Fri, 20 Mar 2026 17:10:26 -0700 (PDT)
X-Received: by 2002:a5d:452b:0:b0:439:d0ac:8a8f with SMTP id ffacd0b85a97d-43b576e6efbmr10619707f8f.1.1774051826317;
        Fri, 20 Mar 2026 17:10:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6471a27csm10888724f8f.36.2026.03.20.17.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 19/22] KVM: x86/mmu: add support for NPT GMET
Date: Sat, 21 Mar 2026 01:09:28 +0100
Message-ID: <20260321000931.1947084-20-pbonzini@redhat.com>
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

GMET allows page table entries to be created with U=0 in NPT.
However, when GMET=1 U=0 only affects execution, not reads or
writes.  Ignore user faults on non-fetch accesses for NPT GMET.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.h              |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 19 +++++++++++++------
 arch/x86/kvm/svm/nested.c       |  3 ++-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3162414186f0..5016a4569746 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -359,6 +359,8 @@ union kvm_mmu_page_role {
 		 * cr4_smep is also set for EPT MBEC.  Because it affects
 		 * which pages are considered non-present (bit 10 additionally
 		 * must be zero if MBEC is on) it has to be in the base role.
+		 * It also has to be in the base role for AMD GMET because
+		 * kernel-executable pages need to have U=0 with GMET enabled.
 		 */
 		unsigned cr4_smep:1;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 035244ccbb5e..b03a5f4d9f04 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -90,7 +90,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1788620e6dfc..eeb8667a283f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -55,6 +55,7 @@
 #include <asm/io.h>
 #include <asm/set_memory.h>
 #include <asm/spec-ctrl.h>
+#include <asm/svm.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
@@ -5451,7 +5452,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 {
 	unsigned byte;
 
@@ -5512,7 +5513,12 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+			/*
+			 * For NPT GMET, U=0 does not affect reads and writes.  Fetches
+			 * are handled below via cr4_smep.
+			 */
+			if (!(tdp && cr4_smep))
+				uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
 
 			if (efer_nx)
 				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
@@ -5623,7 +5629,7 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, false);
+	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
 	update_pkru_bitmask(mmu);
 }
 
@@ -5819,7 +5825,8 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
@@ -5832,7 +5839,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
-	cpu_role.base.cr4_smep = false;
+	cpu_role.base.cr4_smep = (nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) != 0;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
@@ -5890,7 +5897,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true);
+		update_permission_bitmask(context, true, true);
 		context->pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b7fd2e869998..617052c98365 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -96,7 +96,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 */
 	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
-				svm->nested.ctl.nested_cr3);
+				svm->nested.ctl.nested_cr3,
+				svm->nested.ctl.nested_ctl);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-- 
2.52.0

