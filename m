Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945713D812B
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662969; cv=none; b=r8fFUaToNukGpxs4R/+Vts0fTC7TLfHL4MhTkYm8Ivjanrk3rDZGix4e3DBSC09RCtHinmSIMeLG7pvBFcQuNdTUHXPWMkpqWmUiT4lQRirmVR3LDsdMjZ1JlM7nbdddVP/US0PpTqktyOg1LJj0u/iQ+OnYJL8uEpxxJ6n0+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662969; c=relaxed/simple;
	bh=hcs/cCShvVSFWUEielIenwF1plhGW01uLgpk5qBMrAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lqq9p5TkQ/B5ODhyUOzJVMs5aYJK/8pmKwrVU891ewvT5TezbccWeeeXiVTzMOYSO9xyFQ8tr5ZFJDKEf61+JfOR+NeEyyZah5XrmaxFIkvLHB6ibkEfPQLTR8LasVDbzPBV7K1UDSd2hFi3Pb1FBkJeAb/h8GWd5+5mzV7MXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZTYx8TG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZTYx8TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htdHEzNxZVx0urLlhtk3SLmGjAoqKwgtxTQYw/MvVdE=;
	b=IZTYx8TGT63/vHi39k7qTwr8fickGKtvJ08HwshRGCRws/lVEM5bdOtYFkeF5veneHTwVJ
	lka4TXbSOxi4vvh2S7dbEmdffUsxYNXruSqaFFesvEGrsUONLJV0bs/miCYDGj/8VHfbN4
	Ogmqw+pEHd0mJUZo+xCdOPoXD4baimw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-LKUr8K8HPfmLjBV1AQbhAQ-1; Wed,
 08 Apr 2026 11:42:43 -0400
X-MC-Unique: LKUr8K8HPfmLjBV1AQbhAQ-1
X-Mimecast-MFC-AGG-ID: LKUr8K8HPfmLjBV1AQbhAQ_1775662961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAD1A180035D;
	Wed,  8 Apr 2026 15:42:41 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5C783000210;
	Wed,  8 Apr 2026 15:42:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 22/27] KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
Date: Wed,  8 Apr 2026 11:42:12 -0400
Message-ID: <20260408154217.458420-23-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While GMET looks a lot like SMEP, it has several annoying differences.
The main one is that the availability of the I/D bit in the page fault
error code still depends on the host CR4.SMEP and EFER.NXE bits.  If the
base.cr4_smep bit of the cpu_role is (ab)used to enable GMET, there needs
to be another place where the host CR4.SMEP is read from; just merge it
with EFER.NXE into a new cpu_role bit that tells paging_tmpl.h whether
to set the I/D bit at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 arch/x86/kvm/mmu/mmu.c          | 8 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8b4a55cc0918..e20f729f6eb2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -413,6 +413,13 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_smap:1;
 		unsigned int cr4_la57:1;
 		unsigned int efer_lma:1;
+
+		/*
+		 * True if either CR4.SMEP or EFER.NXE are set.  For AMD NPT
+		 * this is the "real" host CR4.SMEP whereas cr4_smep is
+		 * actually GMET.
+		 */
+		unsigned int has_pferr_fetch:1;
 	};
 };
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4374784f1154..290537b0f36c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -234,6 +234,11 @@ BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
 BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
 BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
 
+static inline bool has_pferr_fetch(struct kvm_mmu *mmu)
+{
+	return mmu->cpu_role.ext.has_pferr_fetch;
+}
+
 static inline bool is_cr0_pg(struct kvm_mmu *mmu)
 {
         return mmu->cpu_role.base.level > 0;
@@ -5778,6 +5783,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.ext.cr4_pke = ____is_efer_lma(regs) && ____is_cr4_pke(regs);
 	role.ext.cr4_la57 = ____is_efer_lma(regs) && ____is_cr4_la57(regs);
 	role.ext.efer_lma = ____is_efer_lma(regs);
+
+	role.ext.has_pferr_fetch = role.base.efer_nx | role.base.cr4_smep;
 	return role;
 }
 
@@ -5931,6 +5938,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
+	cpu_role.base.cr4_smep = false;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9ad2b05a0f44..ad0e5f43b8ad 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -489,7 +489,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
+	if (fetch_fault && has_pferr_fetch(mmu))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
-- 
2.52.0


