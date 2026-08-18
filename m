Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2C3BBFD8
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044561; cv=none; b=pEeb0dSpkNyWW3J+XSbpDAu8LzWsVumZ0GZEIAsFCeCFjLMzni51wwdndho5c5SYZEdeNBA/YN3n35PitmdM6peM4KLn93c8K7UsYPji3G6JREDJNkDm5EpLrawAx2JpgVQoEVgoEFKNPj1AMReYHawbm9Upowmpidr+AVRWpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044561; c=relaxed/simple;
	bh=M2Ifb8ZR+HwA/H1LGAE2C/jP4eVMt+pmNz86ycTCoCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=quh36j05Knuq33usEa/BAYSyj2QSBO161ahGRWkMVZPUvKowUTF1+0F309irdw5QAiBjAZ4htYK4ef2ihkGwV6kreS3sTP0TdZblVvTBsRRUiKHCvE80nkZAyneUcpDhNoGFyJmPK6yRd8ztddzXvXTk3dkii9ty089B/nLVoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrpuWYCm; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrpuWYCm"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso97509435ad.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787044560; x=1787649360; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jHUMARs30oMku7rrAHEp5fhgY0hNDCAk+0nqtnlfj0=;
        b=CrpuWYCmK5RlPeUJRDlEVJvSfgq2NDSLY13GFOKLeIOy3eWnwkSTUyPZ9XxgtaHTDp
         +Rk9M8MKMfRSVqVKr8QLkSXOXMd+91tHsJm/1v4R/sWoQJG+BVuvA5N7BYMLAe6mwUvz
         wpYniQIWi7tRGmGqlsnu5TnnuSDUpE3OTNlxds0HdnbIslgEXZe7ZX5c/PU0z+s/+qZQ
         WOyHXBybPwbS7Ui0zIgHyi1ns6yUPccDN9XZbEptE11WJKN129TsVDW9nInS9cbAy1nq
         fab1wTH9nIhbGU9sHCunFJMmjpxmVwdWvgSZQ2NEZHtj5t57qws/j9EFSqmbpKICsKxg
         toZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044560; x=1787649360;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jHUMARs30oMku7rrAHEp5fhgY0hNDCAk+0nqtnlfj0=;
        b=WbDiZmammpyetXcGvt3oWmYzdKZ5KtyF3rjJFJn44DON7vL6SMRsXPekylmu8HNyVd
         RgLaJ4iaoTCt4vyjDVHduTSdNMXwZ4PDBAFgzgRROyzFtDiibctB8Ycftf3Bno7XmYhe
         +CKP6dOkvqWOyrRcMpfEXoO1X6BwPv5WJBfjO1HAX6rfFIRgZ5hhV9qLqdN06qoMXO+x
         LdZtSCaR4hP678Q7j0UadHyuwm5Dq+DtyQ6Rs45bhkIjzEkJz94r4iFTQPRGcfnU0cZy
         vK3zdB1WEKD2ukJaLwr7oaLFM7p/AJBcqFndivHghuUiESAfiYDwv/azJI3fQ0GXWP8C
         Ho0A==
X-Gm-Message-State: AOJu0Ywj47MK37vKdkkMLRjsEjL7V61+P7sPWDTj6Vx0k/flLW7flhzs
	wsYgk+yKrI4WH2IJpIQYTW1OjhsuWlXPHf9EWD6e904yxIB6S73/pKOqsxotIt/XHAjNnWDWfpy
	70GLK3+MfEFiQFDoI+sRdi6i3gA==
X-Received: from plbky6.prod.google.com ([2002:a17:902:f986:b0:2cf:75c1:ab87])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5cd:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d5c4f38113mr76619975ad.7.1787044559821;
 Tue, 18 Aug 2026 02:15:59 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:15:52 +0000
In-Reply-To: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787044557; l=2004;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=M2Ifb8ZR+HwA/H1LGAE2C/jP4eVMt+pmNz86ycTCoCc=; b=j3bFONysasSYdfRKZGzzTAvRwhttD2/ahY+24IAmXMaUu0NHy2Fu2f+igLek2uckCdA21JPeZ
 SpwDdadSI28CzEHJTFEC/85MZAcMO0lcD0WYLfkAzsYZ/YxzsQNemOq
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v2-1-5298f42d49bb@google.com>
Subject: [PATCH v2 1/4] KVM: SEV: Treat unassigned RMP entry as benign race on
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
2.55.0.699.gb54405d56f-goog

