Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800183914FF
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268763; cv=none; b=suq3vNtVOSqujMmpAKSMXt1BIjtVOyR3PzQlB0QaTmlwCtq9AEuTmDxrDv9aQEqTfUZfFijSrDErkmhFa8wt36PgK2x0KqUzz3h97wWX4SM4V4/PdLN9qS2wcvHNXrabX2ekunGL5u5e0yFnyj0joHeFULMkm0MR2ewn2K5NuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268763; c=relaxed/simple;
	bh=mNa+pOHnNs9fqxuQsPFY+ubnJ/wGpTSJgDScv2kh/cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GFy//iDwPCcIo0c6OMobXqBcIkzfNOANu8nsrV93zfUBGKnDZ6PILPNcXQdx1f1Gz4+gpkkvzvZ2t12ja/gbunnbFRnM/IlReSSOuqxQkzacoVHFL+2Vo4V3BxQHYSr3xOsJLYuW0OCxX7dY3jy7DwSveVuBHiVjPLP4IkplwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvEkbvE2; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvEkbvE2"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e375d9736so247149b3a.2
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787268762; x=1787873562; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOtJGHo3/D29WlRaeSux3KPdmxoRq/W1Kkt3/Ky2TK4=;
        b=hvEkbvE25vc9nz9jmZFRPmNbsPbZTtIzB8iTTIowOgD6INXhwv8/lj8kxmh0uliBVa
         kwuMNWwi8UKNUYFZbCm17u315eeFWzPvkNXWmf1vqvbJweZA7JqtfdMRKMtGpIc6bY6c
         aeRcQZGWXSmnXIUnkixmTvKvhRLuy5RWHrQgX4dS7okNi8RIcnqOsDZpfKXhjjcHqU3G
         84QEomPr2zRNLsueq1SQIaeq08oaI2p+brPdET0eLLQUfgcT3w5Bu34k2imYmaZoKhws
         kHr+Eo1GufialTD/Abd5lao1TDD1NDzhGCqyzkmf80TMBvJCEHgMoPx3Bf2mYPnY0Liz
         9vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787268762; x=1787873562;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOtJGHo3/D29WlRaeSux3KPdmxoRq/W1Kkt3/Ky2TK4=;
        b=eL+4eMemdBQbq2txwIMAW9qPg7aoG4f4soguNY3xUHp2hXHatw9bmvSq2XQBHTkHLB
         UrQLqSqUgsduJUuoCeyj/+TCik6CrfkVRlkvTFtDR0x0MGe62k2cU4mYtVieKOlBmLj+
         1fblAS/fIOsXXO5zHeRSNix3phVaWDrPixnjroqrt73tj/oAUA+wf3kUmS28xrszDXZW
         zbV/P5W4XQ0KLLDzhnvMYGcp8vCrSAPQuOchPXnpvoopeRTeukmo8kc99BGd+FtgNXuf
         /A7yIZ1Yn83uFd2o3zXTb4xqAEBmbG9dlTLNA+uSpUueKMEHUFoMdO+mlMgqX+GFQdS7
         llng==
X-Gm-Message-State: AFuF++k63U1dLG2cJKODnA93B2Q8dtU17BMQUatkbow/hDWCLHqWw5Ev
	/1w2bgZkeaF+7ojrX2boaz0G+kyLPtAcsXK4VQ4K5M+eEft94wIXvnmMLvzfo15CEwl3HJ5vEUh
	9JYmlxOnPzDbm1R686UPSY0v6tQ==
X-Received: from pgp16-n2.prod.google.com ([2002:a05:6a02:62d0:20b0:c86:5f41:8c94])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bb91:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-851f9a4b169mr3008115b3a.4.1787268761627;
 Thu, 20 Aug 2026 16:32:41 -0700 (PDT)
Date: Thu, 20 Aug 2026 23:32:34 +0000
In-Reply-To: <20260820-gmem-no-return-page-v3-0-3bf8f80a7b4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260820-gmem-no-return-page-v3-0-3bf8f80a7b4d@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787268758; l=2054;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mNa+pOHnNs9fqxuQsPFY+ubnJ/wGpTSJgDScv2kh/cw=; b=6jdqB/w2bbq3ZNh0ffVDxVWzMNTWlrX73bzku35jkm0BU43Yrh40zgvuTo6drlCXWWiORe1p+
 oG8cHQn44j5ACK9QKezxII+AIYAkCbRDpSItfDEuBO1ZfxEg/YLwW8A
X-Mailer: b4 0.16.0
Message-ID: <20260820-gmem-no-return-page-v3-1-3bf8f80a7b4d@google.com>
Subject: [PATCH v3 1/4] KVM: SEV: Treat unassigned RMP entry as benign race on
 PSMASH failure
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

When handling an RMP fault, KVM attempts to split a 2MB page via PSMASH.
If PSMASH fails, the only expected return value is FAIL_BADADDR, which does
not distinguish the reason for the bad address. Hence, another RMP entry
lookup is required to determine whether the failure was benign.

Specifically, KVM re-checks the RMP entry to determine if another CPU raced
and already smashed the entry into 4KB pages.

A concurrent operation (such as guest_memfd truncation or hole punching)
can also race and transition the page to shared, removing the page from the
RMP table and causing PSMASH to fail. This can happen even if the page is
still referenced by KVM, because guest_memfd reclaim transitions the RMP
entry to shared when the folio is removed from the page cache.

Treat an unassigned RMP entry as an expected race when re-checking after a
failed PSMASH, and skip logging an error warning.

Fixes: c63cf135cc99 ("KVM: SEV: Add support to handle RMP nested page faults")
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fcb41dfde4c02..b2738362a928b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5074,10 +5074,11 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		/*
 		 * Look it up again. If it's 4K now then the PSMASH may have
 		 * raced with another process and the issue has already resolved
-		 * itself.
+		 * itself. If it's not assigned, then this must have raced with
+		 * another process that made this page shared.
 		 */
 		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
-		    assigned && rmp_level == PG_LEVEL_4K)
+		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
 			goto out;
 
 		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",

-- 
2.55.0.766.g2966f0265a-goog

