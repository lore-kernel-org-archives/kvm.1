Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EA1FBC8E
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051827; cv=none; b=VWjlWVLrOGz+I+iCEmWxmG7itUanDfp2+fADbiNqjrevZ0jV3AHjfB7+CyYQ6gDAKB4GYPbU4dvw5OSi/wz8i/2ycJM6ctIPhm7FulR/Z2ZIxUqriNLxYNGxYBkp5KnazsEYwP/3gCPVPQVB7TV6+mGqan9f+8lfBX4t/YGGuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051827; c=relaxed/simple;
	bh=/16SafDH9K05Lrj2Hx5uWI8fsz2rMRK5QpEm2KFKex0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFIiQS9NIhmXvsRUe/bI//wt/+MRl+z/J3AM4zkgAh8PS4AgKG0NSn3fBIjeMME+vD4pNZFg0O0S2Pv3DNA5D+lnH+Um0xTBRliOTWMntBdpyxS3iOPzipehEXIWkpdDi51rhxs2xDRhtLKiKx6L+KlAfEne4u8/nmjkLK42PWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqj5sOB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=owPtHKQm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqj5sOB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="owPtHKQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfElTO9TcWC97/JAeIaxbpPcvqCq+qJTPgscQo4VRkQ=;
	b=gqj5sOB7ciJiwk6Clb20QfZ3YoWRs+WQ3cY3n4xtNZg0gYuP/g6tl5R1QMnsR+nH8N9vFq
	YS4d5RjtY3YXZCs68aKKRZv+vsKXqMJMa+7KGriAeEEQsJy9ESwy5q7tw+2I+k0Fq2sLC8
	MZMr6aUrBCMQEZSopyq2eMBCho7t58Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-BuW7qQkIN3-DEjI65MCGSw-1; Fri, 20 Mar 2026 20:10:23 -0400
X-MC-Unique: BuW7qQkIN3-DEjI65MCGSw-1
X-Mimecast-MFC-AGG-ID: BuW7qQkIN3-DEjI65MCGSw_1774051822
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485345e2fdfso6551895e9.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051819; x=1774656619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfElTO9TcWC97/JAeIaxbpPcvqCq+qJTPgscQo4VRkQ=;
        b=owPtHKQmOLimlQ7cUsKUydSkdN4d641ENnSzHu8sURhfRJDkBHpS9RxG69MP3TrifL
         /ITnMBvy+y6apu9pnzL9ZhXPgJv81P2/JInKFA05dI1gRHMtw5FgnLAysx6M4mZjjAPD
         bVuRGsHSShrYZOmCyLroHb9y0W573d+AdSDDnC7K63jckRH8c7GtWqNQfMCh1B0cgsyI
         E0tam9WW+XavfOTcqoPQtlCrZVlwG5KDpbNOUB+0Kibx38tzSGz7+v0x/KIFyp1o6Pon
         5SQopvisT1huUfwYNKgzewjauX+Oq35Sdg/cU+iCFtE9ToLr0KnRr0enKct8JXUDgVm0
         9vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051819; x=1774656619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfElTO9TcWC97/JAeIaxbpPcvqCq+qJTPgscQo4VRkQ=;
        b=D7QlKd+6VRxbDv80K1d+32j35v9YPJsFJP0TOwyC6rHrCWJ7aQqPXwDE4qYxiiqg3c
         RYEHy4m7MbwzwrRd1iS2voazXmq8Rv647ge0n+xq1Qiscxw6IlzTcMMk1s5Jf6C4l1k8
         ui3QtwtgO3My+izJrkiwO7QK+ltGiwAR4FYEkYDj/PD5C4gerw6zLMPu+kX2jPf8SHqa
         KYxqmZ1mUQXOuQdf/aCxgFnef/odsLzIJpn9YdMOmboEn0dkuu/hI9pxImw86gC8tP6/
         A7FIpnkal4MvCEM1E3EG9ltMF+ZyHKqlfSmMkqJyWEdZ+trJMfppvYt92vtPh304NsZb
         e95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFXBzVTRsVIO2+5yInHiviF2qSxpboDHl+6Qp0i60qb6jI9/nKmKXIgKUQucKqBPiOyss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6j8TPw7TMrWB0duerrGm8AXOJh+D97gQIPbCPZil6RshUHQV4
	vSrF7DNzFHnt1avLUlgzlp7VpDVB3sy7/it8Np/tO8R9Q46CZamBEw2g8MITQveG0d9Oslom5Xh
	JrxYtCQkZZyOBMUTJy5g6eUo4+/TXQz9iJwG+NDgc2SKyRik3veb1Zmx2y7c0uQ==
X-Gm-Gg: ATEYQzyYEBgHSlhUt9rvYj0FawvGr+VcjBX+uf/H4USmN5Jhhy8Xc2tA8AWjrbDD/e/
	hgH517J27TmWxIFPy9Z/cDARfo0xVK5ejN+dHaAwaKjDkGJqcmS3P6+AIF0xF9QiJfuoJC1CPOP
	uKxes+CoZ82cqIr3pqgZI9l9/zqAdWw99d4zMXIfuXr1Sq9SZav/12n8ouwO2p2sDTJQ95bmsBC
	+WgmltJ4QyCwC6f3lfTTJWAiIlpHXlTyFTcOWaZYv9mFOmLS/bkgvY0dZ9HKyyHDqcz8p7GeueR
	+eE5qtHoRr2Ejpsk1vkZN36aZJahjPGDupQsLbmhrouvlHO0P3kAXmBGbqTDNkVDaTbvq+qrqia
	kdX7bn2M0zJ9dlxAbkdmlWxxG4LV6Eci1d850eAYY/K3vVXM4ErpbXmz0iRHRePMZK+5y6qsOR+
	R+g72+bPq2a7yV3rSZyTXfW+ze
X-Received: by 2002:a05:600c:3554:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-486ff01d7f3mr68805505e9.28.1774051819344;
        Fri, 20 Mar 2026 17:10:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3554:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-486ff01d7f3mr68805235e9.28.1774051818841;
        Fri, 20 Mar 2026 17:10:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1c2026sm26071725e9.27.2026.03.20.17.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 17/22] KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
Date: Sat, 21 Mar 2026 01:09:26 +0100
Message-ID: <20260321000931.1947084-18-pbonzini@redhat.com>
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
index 0d6d20ab48dd..3162414186f0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -403,6 +403,13 @@ union kvm_mmu_extended_role {
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
index 647dffb69d85..1788620e6dfc 100644
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
@@ -5672,6 +5677,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.ext.cr4_pke = ____is_efer_lma(regs) && ____is_cr4_pke(regs);
 	role.ext.cr4_la57 = ____is_efer_lma(regs) && ____is_cr4_la57(regs);
 	role.ext.efer_lma = ____is_efer_lma(regs);
+
+	role.ext.has_pferr_fetch = role.base.efer_nx | role.base.cr4_smep;
 	return role;
 }
 
@@ -5825,6 +5832,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
+	cpu_role.base.cr4_smep = false;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d50085308506..bc6b0a1a1c8a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -486,7 +486,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
+	if (fetch_fault && has_pferr_fetch(mmu))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
-- 
2.52.0

