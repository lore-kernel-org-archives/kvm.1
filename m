Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FC443E2A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044565; cv=none; b=vAn+008DpEpgFOw+YL9GKmw2+6U4puC2aN240dXS7oGSHeJ7kscbquOEamgR0RjobWiZ7p02nuR70F5s7wyU1WpzMIxcrLz2mb/wgakFvZQ2pvSC8tuMhCfXuFDJUlrCos1Ge6Dj9FUCBwfpe8DRTb/8x4Zk09WgfhrLBQIfs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044565; c=relaxed/simple;
	bh=HNfFPs+x0eHWMpwvEPTLebfzN82ZbnT/KE0+yXry6p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OUXgxks9shcjR1ZHmsM+QdQ5MUPs7eBAmZH7mWL6S5v87hoAs+ubpKLBHZFsszemw+g6pAAuJ1Auxp/RW+pNm3ZWmgbzKqGg0UD8YL/HbgF4VKFr6+OAKvKP/4A7HUPxAijjiNpJe27FdozsV6C/mKzqyyZL8SxoEb1D8VzsqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8Dee6wD; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8Dee6wD"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so3474874a12.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787044562; x=1787649362; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCv+HQzJkkz/c+dZ9BRl+4th0Zm+hBhcY2bGeDdOzyc=;
        b=G8Dee6wDhOe4gz/rVPud5Ay2wQrOIyKB+mRabR4YvfFECi56wHvcTXgo0o3n0AvxKf
         4K6X8VT0fliof/szpssa438tS+Pizeh54/S4ywqEyVsBNf2GeXbzPUZZiWnMrZ3J3IYQ
         3QmHGaCm7IJzlBZ4yxrOvwE1g5DqjIwArwoj5Mfx+62mC8Unqm8/sZVwtb8SAX7cW7WB
         5mLFoMdltxYOe1lFgQA/AJMS3g6DRQWjkiVdIhIfNuUUdgryVfYxy1tCNV07/Vr9QOVe
         2X4IhgU2X+BQ7EPhC/u3W4FVK8I93cDVdkV7xD+CG6ayJaJ8StMfpyNF7UpWmjSOKe1Z
         T0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044562; x=1787649362;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCv+HQzJkkz/c+dZ9BRl+4th0Zm+hBhcY2bGeDdOzyc=;
        b=H1SlQ2qHLtH8vv3FNl0r1Gt3u/nzHnpOGIKbzvgnsKZisB0ebi8sUofkrGr1CV3moE
         Rp85ZVmJSQD4EIKo+3/Tt/r+EEk9hwFXbWNiCbT6fnHBK5D5ffTQ3l7p4G7b4ZuvEXvU
         6GGGQXG9Ah5ToUTNoL+XKGQs/AbyUwoVM24iNvnFVzSYfBo5T3kwGnEMQhyD/g2ww6DZ
         52+CGLukAE+979K+/0m84W7nLyLvysf7gJjnPk3ttlRl8udlieDNA4HeL1O+MzJIcWQ+
         mcb0ucDsc6ODP4PXhTTKKuE6oIw41FUcpQi8Hb224uUfYgANgbHTJjZtVNlCnT+H1I7w
         cJiw==
X-Gm-Message-State: AOJu0YzwV8aW8qgxxt7h8iakoV4skG3H71NGK21uetTjXBOr8WsK8ie/
	wiz74l0NAov35EXfK2Y+McREht4RxdTiOMvzxpYIJl3eHyEL1ySG/260as/BVfSB4/vF6WVqcfC
	nxF8O63/qjGuLbZpYNCJDJh/RBA==
X-Received: from pgbdq25.prod.google.com ([2002:a05:6a02:f99:b0:cbe:4e21:813e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4a81:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-3ccda4b541fmr9874686637.12.1787044561971;
 Tue, 18 Aug 2026 02:16:01 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:15:53 +0000
In-Reply-To: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787044557; l=3842;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=iohu3wId074IkPEPPtY6DnmeCpNG8GAOrdh78h28Ak4=; b=Wb19M1g6ZtfbPgdd8ony5ekvd8iGMoQ0KEQZ5+a5RnG18bj+rMXmaWB+Cja685bhXr2oOmDTs
 MA3gk+hFS+oB+rGSqrMgBySp2vT+jhO7KjHLgoEcoMFyz6MXPn7e/ST
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v2-2-5298f42d49bb@google.com>
Subject: [PATCH v2 2/4] KVM: SEV: Drop page refcount early during RMP fault handling
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

When handling an RMP fault, KVM retrieves the PFN for a private GPA from
guest_memfd.

Drop the page reference immediately after retrieving the PFN instead of
holding it across the entire handler so that the later patch can follow up
with completely not returning refcounted pages from kvm_gmem_get_pfn().

On a first look, existing RMP table handling (psmash and checking for
errors) might seem like it works fine, since truncation of the page from
guest_memfd would have called rmp_make_shared() and removed the PFN from
the RMP table. However, that is insufficient since a freed page may already
be used in a different SNP VM.

Hence, adopt the MMU invalidation protocol to guard committing anything
based on the PFN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b2738362a928b..b34b11d7f8fad 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5003,6 +5003,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = vcpu->kvm;
 	int order, rmp_level, ret;
+	unsigned long mmu_seq;
 	struct page *page;
 	bool assigned;
 	kvm_pfn_t pfn;
@@ -5030,18 +5031,22 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		return;
 	}
 
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
 	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
 	if (ret) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
 				    gpa);
 		return;
 	}
+	kvm_release_page_unused(page);
 
 	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
 	if (ret || !assigned) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry found for GPA 0x%llx PFN 0x%llx error %d\n",
 				    gpa, pfn, ret);
-		goto out_no_trace;
+		return;
 	}
 
 	/*
@@ -5069,27 +5074,31 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	if (rmp_level == PG_LEVEL_4K)
 		goto out;
 
-	ret = snp_rmptable_psmash(pfn);
-	if (ret) {
-		/*
-		 * Look it up again. If it's 4K now then the PSMASH may have
-		 * raced with another process and the issue has already resolved
-		 * itself. If it's not assigned, then this must have raced with
-		 * another process that made this page shared.
-		 */
-		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
-		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
+	scoped_guard(read_lock, &kvm->mmu_lock) {
+		if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
 			goto out;
 
-		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
-				    gpa, pfn, ret);
+		ret = snp_rmptable_psmash(pfn);
+		if (ret) {
+			/*
+			 * Look it up again. If it's 4K now then the PSMASH may
+			 * have raced with another process and the issue has
+			 * already resolved itself. If it's not assigned, then
+			 * this must have raced with another process that made
+			 * this page shared.
+			 */
+			if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
+			    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
+				goto out;
+
+			pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
+					    gpa, pfn, ret);
+		}
 	}
 
 	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
 out:
 	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
-out_no_trace:
-	kvm_release_page_unused(page);
 }
 
 static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)

-- 
2.55.0.699.gb54405d56f-goog

