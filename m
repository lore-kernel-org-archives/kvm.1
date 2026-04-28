Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50616401488
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374620; cv=none; b=Z0LR8UlRITQn3UJbYQsyB8iUSEOQZFrQycyAbDw3Ub0tkZZ41yDQdfAM6qlR8hVyRYk4SEhCjZ4pTmgvnnsNWTcCs3ShHqUdR63U1xH3B1myy1R/wCTAyd963Kj+9ICS4iaijG411CMd3tVYE5h4JFkV04L1mowY3qqT++nlSMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374620; c=relaxed/simple;
	bh=Bbnd3BUnQXTYnytKJzY6LoFx9CgYX19VSh5xco7y51Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+1b0W6RNjv1bcBDVynjv/HSxVk8ioTg2I5GdH/FnNuUQ5qYwL22zOQjvdpwVOQFirk62oW1NxQVKchDYBtpWd2Q4GhjRTv2ZiKfh2u9wP2LzXjhK74anvmCBcjG7EAwXU+8QbgiOylK0bfJ0o0nym8RvrcommOyKDPZbtsqYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka2waPRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka2waPRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OvKZw2ZCZ+pTGKnaYxanCgyg8mnQ5aZNhL8dTXgrDw=;
	b=Ka2waPRPgA5fyPXLhsqzGi21tm3UrSz+vGDgNsS83M+IFLIGnIv5CdxGxXmtEn6U7b4Pb2
	+MrYaN3oIjCuwzla7r4Qys5TrWoxWyCzAWV/2HFztpYo+4n1OtvVU4NQnAfLIozdBjPncT
	eFhD1RvGc1g2QzkwUCwJbt/6lgNBpDU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-C9F2Xj4yM_WuP4ozzkSdCA-1; Tue,
 28 Apr 2026 07:10:11 -0400
X-MC-Unique: C9F2Xj4yM_WuP4ozzkSdCA-1
X-Mimecast-MFC-AGG-ID: C9F2Xj4yM_WuP4ozzkSdCA_1777374610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF2D19560B1;
	Tue, 28 Apr 2026 11:10:10 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBB1019560AB;
	Tue, 28 Apr 2026 11:10:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 22/28] KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
Date: Tue, 28 Apr 2026 07:09:40 -0400
Message-ID: <20260428110946.11466-23-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

While GMET looks a lot like SMEP, it has several annoying differences.
The main one is that the availability of the I/D bit in the page fault
error code still depends on the host CR4.SMEP and EFER.NXE bits.  If the
base.cr4_smep bit of the cpu_role is (ab)used to enable GMET, there needs
to be another place where the host CR4.SMEP is read from; just merge it
with EFER.NXE into a new cpu_role bit that tells paging_tmpl.h whether
to set the I/D bit at all.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 arch/x86/kvm/mmu/mmu.c          | 8 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 23a7ac8d7fbe..7dde4ca87752 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -414,6 +414,13 @@ union kvm_mmu_extended_role {
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
index 8deeb89d88c4..07b64df8519d 100644
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
@@ -5787,6 +5792,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.ext.cr4_pke = ____is_efer_lma(regs) && ____is_cr4_pke(regs);
 	role.ext.cr4_la57 = ____is_efer_lma(regs) && ____is_cr4_la57(regs);
 	role.ext.efer_lma = ____is_efer_lma(regs);
+
+	role.ext.has_pferr_fetch = role.base.efer_nx | role.base.cr4_smep;
 	return role;
 }
 
@@ -5940,6 +5947,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
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


