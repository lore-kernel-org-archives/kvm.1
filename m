Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473741F378
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040781; cv=none; b=YwZ6r6DQIQkaQkBk9UTaB+NqeSamLmI6U+BeFIiF5kA/DTmKwPxe0QVriVN2ST5IDHDj66wHY+EYzJtX2FdM9KL6w41mndacGoEBm422kGSU7g37kQUyFzafErOpKhMOANl1of2ygZZ+eUW+rsbxLZYAm9yNCP3tRe1GD4caAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040781; c=relaxed/simple;
	bh=7i6cqBtbFkQctrI98iz0J10uujeLpSmIIWcG5kUAid8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kk1/ttjTFFzdeg0bKRMuGQhDwChJtHcpCEJoPyLbF3/HkHvaVRUjfMz8r5G9E9iMjFDmDtkchuWcjccFC1svccVL+PY5+imUKwNgkpLF4VVRm0zYjeDjNSHasDiJu4Kyemaip2e8zKaPXhe3Xg4MPILO+mB/VOzlbabG9C+VGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxBNQ2WZ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxBNQ2WZ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a67b16217so6847880b3a.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787040778; x=1787645578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3ULsNgYxwRhZwue5bCy+g9EswRkhCGynb1/tmXwwp8=;
        b=SxBNQ2WZdi+yx7i7T7w80XIWfig5JXAq1IWse2xb9wjL5jzs7Y/0BbaEBuDOyNskvY
         sTqgSq9vfnOQtvByY+mBoyGH8Ta0kDCEK9zQh1V8T6xP00emtVokHkndvObiiIsEJlHh
         o+rhVAIKMWL7nkZGFtpCdOMhLvjHz/vYCwRaSRTke0S8AlyKuFS7pVuQhj0sGyDD57K8
         5goXyDd+eT0fiVNLY6SWfUQ0AAeE/f+WZMsjOAe1+6TISUBLM/nYehISFSK07bpI8FjO
         VFp8VHhlzw+rwyC4EamFiEsWMKYrlG3o121nxmDgUWl8CueU9oPrYdVLd0uroMnuHlfc
         1Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040778; x=1787645578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3ULsNgYxwRhZwue5bCy+g9EswRkhCGynb1/tmXwwp8=;
        b=Aiz6L8T6RrFRWywd1eD0DiPhO+LIGhKgxY4g9a3W3ZHybNkv+r6pYRYdoVdK2TujtK
         l6c7hjFUeybFBzlFKsK8EFlqWxV4tQzeiHl/KqSJU6B3d5UXR9IoStwOFBZyzfCWP6kU
         oHCrxNJ5BO2ZPC22fGPIwXW+oYaD3hPqb0qnig0Wx5mBkGeIx5hluJT3MaKmsfNbNofH
         Dr07QjqVg06kn9igwwzE+AGkBX0ILRzM1FmOk1DixQyf3zw/+i+V+BTZIXq1Qe6LtMH8
         cS6+91gVRIPqc3n901DkgWEhtJ9YRvImaJdOGuJaIB2FwRuOiZho5f8yd5svHR6OxVzl
         8LGA==
X-Gm-Message-State: AOJu0YzeuAAs3gHIh23Ce8fRat3J6+BUoCFfrq6UiqBJRj3cGzwlXCcv
	7J3bg9J83tzFQIysZ0bzTpM3FOs/eZCwwqiYXjqZAKT2uHQfj2N10bEIm4Rj91eyCtKjvhDGqer
	Vk+MllAUxNMhGsXtFFy2L3ymAWg==
X-Received: from pglf19.prod.google.com ([2002:a63:1013:0:b0:c96:da8a:c09c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:10a:b0:3cb:853e:850e with SMTP id adf61e73a8af0-3cc71b7acbamr41629166637.13.1787040777693;
 Tue, 18 Aug 2026 01:12:57 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:12:36 +0000
In-Reply-To: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v1-0-4f8d939efdbc@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787040773; l=1697;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7i6cqBtbFkQctrI98iz0J10uujeLpSmIIWcG5kUAid8=; b=ekVPncMmVUriS84Zt3+p8nRYXWSGEYGwwUVXJK5NXlHtz70OGF8spprSioZ5xfncCfU5EKAue
 7ocjFnw2d/JCgGzlgbUnq1q4Jp4Sgvc0ggqydJcjSIEBFCCyy17BUEN
X-Mailer: b4 0.16.0
Message-ID: <20260818-gmem-no-return-page-v1-2-4f8d939efdbc@google.com>
Subject: [PATCH 2/4] KVM: SEV: Drop page refcount early during RMP fault handling
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

When handling an RMP fault, KVM retrieves the PFN for a private GPA from
guest_memfd. The page reference taken during PFN lookup is not needed for
the remainder of the handler, as checking the RMP entry, splitting the
2MB page via PSMASH, and zapping shadow page tables only operate on PFNs.

Drop the page reference immediately after retrieving the PFN instead of
holding it across the entire handler.

A later patch will follow up with completely not returning refcounted pages
from kvm_gmem_get_pfn().

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b2738362a928b..19c31fa944e34 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5036,12 +5036,13 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
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
@@ -5088,8 +5089,6 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
 out:
 	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
-out_no_trace:
-	kvm_release_page_unused(page);
 }
 
 static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)

-- 
2.55.0.699.gb54405d56f-goog

