Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48172DECBF
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481483; cv=none; b=l+/wNIvXIsy6cjqRvv3OlN9j58+o0Kb8JGznmkQsk7WFqqqOIU9EoJbCvTU8+qI+KpBbwqaMVsu1YDdJjPockVabx2yxQ/xFgEG+fhU8UlI77hkDXpjDkUhpa8eOgV+whwunnP7MN/9kvlgC/Z+o0lrP61IJ3KAYPyXHf/9r0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481483; c=relaxed/simple;
	bh=aHwWoAXL6Rh4JcyNpSkn+QfPxM10FYDybagucr0UcI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H928J+z3NhbWGkxyqVC/ceyLUdZUrSwF5GVzFpuv+Es9aiEJDktD/LdipPKr1T7tRMMGfOzi60ERIOVCr57MriFoL5SOhemW6lKLkaYYbxIYW7XFQ8hGntcNrs+brv/NwjAVB28Wz3AKQ5MXQON5Nl0FMSCsp+kB3lG6IwqBxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+gJ7ocp; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+gJ7ocp"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d7443e0f0bso6947085ad.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481480; x=1789086280; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Tg/5+B1ZuTrkzw//MOyCVIR0C7JVEC7pdCYgG150qIo=;
        b=c+gJ7ocpxYIcxJPC9qXXvfgV29fR4gzVK+IwzsrHyw/oG8sJXtM8YNCgQOtN1qxlHt
         1DIaXPsWno8Ke3LDA68TMcRuIrUdYGobsmsiDP2CZlXCb0jGBjDc5Gy37SAyX3HHkx50
         xRuQO1OZtJga11diiOqkM4tCg7j9gK8UulT1cNq3i+/vjAvGClRRHLRBWIWhzRAjS7JF
         fypnoe1TMPV0eyquri+WUn64tKMKdSn/kBevDCFr+6pIDGMSVI8KP/3TOnQnHJsgmGnx
         g/Wgrhd7sO0bQ7fJttECVXbRH7MVACnmkiyvhXcptvXrRw4e96G/RR/xwje/uqLJ4fC7
         gQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481480; x=1789086280;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tg/5+B1ZuTrkzw//MOyCVIR0C7JVEC7pdCYgG150qIo=;
        b=A+c/ZSlPI5FkQDRdGf+YDvQ/giE6DxzOYbP7MsgymHcsE2ZemwqyguXvaBYaA+qE7r
         XkeFC022zWHI1VIUwMHOhW9hwozsleug1a3H1FeYNF2hjG7uF9mofaAau6jewWQcdceQ
         YbMHGrTiqcNKO3cPDIH2kscwdbqT9X5YxFja9XFLHLtuoD8pRwLdXcC5xDhFoDKbtCl8
         8Iga0SZ9fbdIhteaPU8ZuSkebSIaK9T5OrjdOvj0LtbxUhszZj+b0Z+ZEi4p50jyrAJR
         hxTMaXWkhYAMYELuTtiDI6pYyn70xR54UO1/ZWStyxPfpB21wBPPNOjSnxsQF7kV77uT
         NRVw==
X-Gm-Message-State: AFuF++ny5BavC0EeGUHSuFvhV7CqcdPws7p7uajsh5U1bUXY/DTMBsPA
	k0a5aNhRkmR51uuNH/dIusZ6avhHVU2dIVlK1VUart4D/C9fuBAU8fUFG9lNsEIbd38IrV9SxlG
	+VpGwJA==
X-Received: from plgq3.prod.google.com ([2002:a17:902:eb83:b0:2d6:eae9:3473])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8f:b0:2d9:2fc9:5706
 with SMTP id d9443c01a7336-2db12321cd9mr36362385ad.2.1788481479587; Thu, 03
 Sep 2026 17:24:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:18 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-13-seanjc@google.com>
Subject: [PATCH v4 12/17] KVM: selftests: Drop dead return code from
 evmcs_vmptrld() and load_evmcs()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the return codes from evmcs_vmptrld() and load_evmcs() as they are
hardcoded to return '0' and "true" respectively.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/evmcs.h      | 12 +++---------
 .../selftests/kvm/x86/evmcs_smm_controls_test.c      |  2 +-
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c       |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index c5b9d26f6cdb..f18ebfb10ee0 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -245,24 +245,18 @@ static inline void evmcs_enable(void)
 	enable_evmcs = true;
 }
 
-static inline int evmcs_vmptrld(u64 vmcs_pa, void *vmcs)
+static inline void evmcs_vmptrld(u64 vmcs_pa, void *vmcs)
 {
 	current_vp_assist->current_nested_vmcs = vmcs_pa;
 	current_vp_assist->enlighten_vmentry = 1;
 
 	current_evmcs = vmcs;
-
-	return 0;
 }
 
-static inline bool load_evmcs(struct hyperv_test_pages *hv)
+static inline void load_evmcs(struct hyperv_test_pages *hv)
 {
-	if (evmcs_vmptrld(hv->enlightened_vmcs_gpa, hv->enlightened_vmcs))
-		return false;
-
+	evmcs_vmptrld(hv->enlightened_vmcs_gpa, hv->enlightened_vmcs);
 	current_evmcs->revision_id = EVMCS_VERSION;
-
-	return true;
 }
 
 static inline int evmcs_vmread(u64 encoding, u64 *value)
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index cafb58a37023..5c0391f8a38d 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -56,7 +56,7 @@ static void guest_code(struct vmx_pages *vmx_pages,
 	evmcs_enable();
 
 	prepare_for_vmx_operation(vmx_pages);
-	GUEST_ASSERT(load_evmcs(hv_pages));
+	load_evmcs(hv_pages);
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	GUEST_ASSERT(!vmlaunch());
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index d0e857b75a47..854b86c4be8a 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -95,7 +95,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 
 	prepare_for_vmx_operation(vmx_pages);
 	GUEST_SYNC(3);
-	GUEST_ASSERT(load_evmcs(hv_pages));
+	load_evmcs(hv_pages);
 	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
 	GUEST_ASSERT(vmptrst() == -1);
 
-- 
2.55.0.979.g7e5102b832-goog

