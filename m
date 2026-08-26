Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA03B9D80
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734929; cv=none; b=CvQxTLAdP0NhF9SpVvie7rTCqiDJeXRmEy93rB8mZDXtKR4C1Z42H5xTYDCuSjCV22LjP0Aqpg2oevy1MHNLyz2p9uraKr2VEHLdIZ69chsBS5JYQ8my85TQncPHg3VU5AQlkh0ZvT7x2qHPZP1ptrky//5OqhpSV6ojlfluSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734929; c=relaxed/simple;
	bh=M+i2SxvXQ8DSphNQ8ShtoJPE8ttDtKFUtUCnzxjFNwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kofWg6Fqod091HJ/Pp7MUJA+Jr1jSAWo4wcRtWw4oS8/l7g5XyLNCqD50gPSF4EFB+nX2p9jjb1vjpKJcZqVkE3q94pLRDYhDc4JfxYAE9SWfi7NTtAHmYk6JaSRt1/WUbdX98E9L3Tv0VnQ1XL/f1paSCq0nIr7fGzfR5bDDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oM2HTjBo; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oM2HTjBo"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so1389325a91.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787734926; x=1788339726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuS9O11vr193qDv9HWb04MHk5U9f4uvrgo/7abqfaWM=;
        b=oM2HTjBoNEA0H6zfU6s1Hu1LIMF95ijv1Ochgwf1L0N+7y26tGEg223OWzfQN4pDnI
         pSRkZr14s1e1t0PYNxpzi/Q5QqDoKnyPXvc9lfkOPfoUianQatntlFYHWwvRibqLogSk
         V11JkLWCfKrweXoe0xbys5bnzTq6loMCcRDYxMY2HRClZIenT9UY2PYXbeb3IORHxNAq
         fBRPYD4sLSHHvsvjgVz0W2f3iAE6pKYYU6HmZ/w805tAKrvDGr7qoWss/0rmm68LIjSK
         MmXblvaei+nRti7lD/fE7ksR7S9Enfw/Zpi5bVnu3aMx4IKHegpbJMNcxZdRnD7cC77X
         0Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734926; x=1788339726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuS9O11vr193qDv9HWb04MHk5U9f4uvrgo/7abqfaWM=;
        b=fn7VycYmpCU0QOaz8WDFb1CofNiByetDzSSWdTxivGseDFuo7mtMDK8aW28WLiZBQa
         yu/pM7tTL1X9R3+uhvbXlAmQIgepcNYYvnO/IbMn7SrqDX0lOfoCGZ2iLYbXxTe4be5E
         ev5PqIPU/Xm441nQzEaXkPnwUd5IA7gPQkMa1hu7IjmGe+7QJYM3Y5a1mJd6Mz6nww0I
         pveqIgntKoZw8xt+D9uTCGI0upxclClVtlsHHNiPIbO12wI3DpLOxx+3jDpiYH3XtIzl
         3RI1HCG/m5VYSRV2o52mpA4pyKeb9Ql3NMg1xbIAVpndzrGL4DJ0yySY+RlD0a+tiWXA
         GIkQ==
X-Gm-Message-State: AFuF++kupsHZkCkMIaVUw9MrLKtsHeIyYAWUAfBVOkq7r+THbBJH15+I
	BxfqwTeHOOiyDU/gHnfPxWTUrlYkdLeEKSc6Zs/Ybc4NMulY2L+L4ALOo2orsnLEuk16mOCqN3k
	5fyYBbbXoDvptrb/9yYAoElTpBA==
X-Received: from plbmz15.prod.google.com ([2002:a17:903:350f:b0:2cc:6063:a658])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e70e:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3966d4503ccmr11876759a91.13.1787734925365;
 Wed, 26 Aug 2026 02:02:05 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:01:47 +0000
In-Reply-To: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787734920; l=3858;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ifBAzXs8dlmanG/v8Acwb5QccjLKb55JHzRk/esPfm4=; b=kJMdcnrib7/3q/fmH14PIC5RislnUwwDuforS4mPsCFG6U4RlmpkwZgDuAO6oLG+VTfDnsS8p
 VAKOV4a6zA9BcErbmRbTF6QWV2iI5gPuSe8RTZJyLl6TjYx7ftseQ1s
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-no-return-page-v4-2-3bb9c1ddb4e3@google.com>
Subject: [PATCH v4 2/5] KVM: SEV: Drop page refcount early during RMP fault handling
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Rework KVM's handling of RMP faults to rely on MMU invalidation logic for
safety, instead of the current approach of holding onto a folio reference
until the RMP operations are complete.  I.e. drop the reference gifted by
guest_memfd immediately after getting the PFN, and instead do RMP updates
under mmu_lock, after checking for relevant MMU invalidations.

This will allow dropping guest_memfd's reference gifting entirely, which is
ideally how KVM would operate for all "follow PFN" operations (GUP has many
more complications, which is why KVM holds a reference across page
faults *on top* of the standard MMU invalidation logic).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e198469eb074c..0d027cff734cf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5019,6 +5019,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = vcpu->kvm;
 	int order, rmp_level, ret;
+	unsigned long mmu_seq;
 	struct page *page;
 	bool assigned;
 	kvm_pfn_t pfn;
@@ -5046,18 +5047,22 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
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
@@ -5085,27 +5090,31 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
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
2.55.0.887.g758fc8c411-goog

