Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FB2DEA75
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855437; cv=none; b=bvOPWwcy3AA3Y/M/fHAco/p4zq0NhTrvG+E28uB0KKD0j1FvtD/80n14LIa0Xk2op4D7CGUew0M/27Tg3UK4F05ydpmfDOvbtk9/T7uo7etOb1yo7JsHfdIQ0B4QVaW9JE4u3+SXV+5sZj03RdTbRF+3QPSFfb4ussvWksebxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855437; c=relaxed/simple;
	bh=VEV764k+YjgSV8ElwdVW6Rpo38QFc1TTbPvkYXFjsh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ib92Wgs0NexdLWnh04zuTr4IXB/2oY2SpU8wCfJjp/HdgDchoxTLx0U3ZWx/QL7xOh+5hyJtItcS2GhIGLIPKF3i/2/Qz3T+GpD+NxSZTHcwZGBL7AY4n/Tf2CB7nKaYWIToCTOCzMmfi4Lbc4GQVWTAXwAwscK8p7t0+9m/X7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6ie1Sk+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6ie1Sk+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9ae1da340so57628565ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782855434; x=1783460234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uJbwc1Qhi2ZE+Oi6hXPhS12AxXWHzXClhddjya3ipjo=;
        b=D6ie1Sk+7wRpfZnK7ocqFQ3Ypm1MfLorf6iXpunmg26y7Qdq2w/M/GGWuWj9UmxTyO
         w+1otz+G8advwaU0v6rpS/YH1/iVfbM2xgRTihMKw9XftKdIJlp8lQYyDHGqxaN4iQLu
         6Rb2FrcvAX/gI7ryzFRswEcRfunF1plfoFBHDUCd5ZilWCcwg4QqFCyIc/Ck5eURjBrp
         z/RwNsc/DyaTRb8F7ixGjrh3bQr4pVRM78lK6eK0Zgjokjotb8VZDzbQZJPsjml+h0EC
         /cC6h3aYGDO2vU4CBk30FXal6I8VJEY0rqPopzRVblp/OeQB+m5gpd+GFZrYan4UnFsT
         htCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855434; x=1783460234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJbwc1Qhi2ZE+Oi6hXPhS12AxXWHzXClhddjya3ipjo=;
        b=HnQboee0oyZUxkywEdmO/U/gHNuoMxI8DNMRHX7nwvZI0cp3h+ecQvpj0VMnWhfalT
         17yYa3XUVwSmostxHfcaSUTy4ncNgMqQffHz1FvfO9CvtpK1IE7KwTt3U2E+s590m2jH
         1ShsmTNYkcbdumPxV3RjkK+XsO0ra9iuRG/tP+oGQl0KQHo+xfjnZ9mDMYF73dOy9DDA
         JjqQ7xHZEMOYMu8Ml//AYP/yzyl2TR2af7r185stC0k8GW0ZSwKaARD60+O11eNShGTz
         6ELgT5nNXydhkTkAakpo7hMTMlQzENQ/Do00bms08hv9/GQcNAUlaesV5QC8j6Q3XAlu
         zJxg==
X-Forwarded-Encrypted: i=1; AHgh+RpyDEws5wn6YQXt4YQYdSCnX1sGefqvM4ZjgrCjrPRYWadzm4Y3oK/4Zz2F7zKw5zeGvGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEbpKxMTSzh3WSN3x8wjuTmgZpWAu/I5JTsmyOp3zIfad5ndp
	SfiFeINs2/HcCueoaT2puCir7G5/pHms8hWA1ywqUvWGi+qXEkl181dg2fTlYjfaRPVpu2hU/dj
	H9RXhXA==
X-Received: from plbkq4.prod.google.com ([2002:a17:903:2844:b0:2c7:f3c5:4bc6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0e:b0:2c0:af09:f3c7
 with SMTP id d9443c01a7336-2ca2ea17914mr38760775ad.30.1782855434158; Tue, 30
 Jun 2026 14:37:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:37:10 -0700
In-Reply-To: <20260630213711.479692-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630213711.479692-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joerg Roedel <joerg.roedel@amd.com>

Explicitly reject a NULL userspace virtual address for the source page of
SNP_LAUNCH_UPDATE instead of relying on the post-populate callback to do
the check, and don't WARN on failure, as the scenario is blatantly user-
triggerable, as reported by Sashiko.  Waiting until post-populate to check
the address "works", but makes it unnecessarily difficult to see that KVM's
ABI is to disallow a NULL source page for non-ZERO pages.

Note, several existing VMMs pass a valid userspace address for the ZERO
case, i.e. KVM can't *require* the userspace address to be NULL for ZERO
pages, at least not without breaking userspace.

Fixes: dee5a47cc7a4 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260611125849.9ED631F00893@smtp.kernel.org
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..621a2eaa58f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2330,9 +2330,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	int level;
 	int ret;
 
-	if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
-		return -EINVAL;
-
 	ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);
 	if (ret || assigned) {
 		pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared state, ret: %d assigned: %d\n",
@@ -2421,10 +2418,12 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	     params.type != KVM_SEV_SNP_PAGE_TYPE_CPUID))
 		return -EINVAL;
 
-	src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_user_ptr(params.uaddr);
-
-	if (!PAGE_ALIGNED(src))
+	if (params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO)
+		src = NULL;
+	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
 		return -EINVAL;
+	else
+		src = u64_to_user_ptr(params.uaddr);
 
 	npages = params.len / PAGE_SIZE;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

