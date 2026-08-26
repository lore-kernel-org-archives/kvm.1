Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701D3C4B71
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787574; cv=none; b=I9Ybm/IS8LYjMqiXRkGWh0SDOFt1oOFKOwUY+PfyJ9stbnDA0KoZSODMgMn1/S1z7q0OaONHyAzFt041LSXUHzXWrJ8iKM5LXSjqukjZ7qpMny80tsU04o5FZ3/vhe0ctSrUOmxnI9FuGcgC51rLIXhLmw9ml5/keXEsxGiiunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787574; c=relaxed/simple;
	bh=X1BRoEH9xWUqpdXQA+bNGQ+2MW9ec/x1eBIcfsK56lU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oETGYs+GuGtLUCFdEQwKIGdvJfP61g4B7lZ0pmDlyyQd06y16kQg+4Fvt9Xy//YoixgpxJLakschJYyoGDKOobGUD3gFQtk7co0ycrk6sQSEax+j1YyU86Q6S/tlT1T2Qrq3GVlKWNB9KMfiqGG/DaDxaS9K07gKPp1QcP5x04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGL/sobk; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGL/sobk"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so25875315ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787570; x=1788392370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=umk0Ww8KPqFn6CRSo/BfZ8eSGuaGIBiCuDbN+K2wrFs=;
        b=wGL/sobkIRI9uQGFYcRigZz4zlR2ifGlp78WXwqOkvLWQtsND/Frjr7DfUtielFOIC
         rWQaD8Cs9UTo9YzeYtL533at1RCrTKDUWK+Z6fEEPmrLTgIFm8EhTj/AlrRnyTZ+XBvp
         EEewOy/GLUoecWeEWgIc3rSnOsImrLPjSbkWN3x8x7DSFbnngJ+z4HXfaVVlCo3DlKH2
         UtUdnzAhyc36xXGFgAweXhmAO8OKY29IN1X2m366NUtxAbGD8UQiFvoW4MyBCllH8qBI
         clLq/UG2JNL2QN0NdF5CN1uAuOZimQCkbE8srvId7nd4YJfhYCs10lt/24CrBxb30nud
         Re3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787570; x=1788392370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=umk0Ww8KPqFn6CRSo/BfZ8eSGuaGIBiCuDbN+K2wrFs=;
        b=NmEUvkkAOCvNGnlUuE+oiwOPt8CJFXX7jLaXY9DEKWLD8QAYvNUwlHs5U9d6fmVLa/
         HXJGGgpX31as2z/JTOW6q/BmB4C54lS/giX5r3RG45Ug2nBN0hafsVWvuvMFFJKxqM7f
         zbI1gKFUXAzktVLgbpYN/KpBg7oQIO7ZY2zK/K3sgDKzjcjtI07NXVCvXa4L2bRlwN6g
         NVLeRfFNwQCiWxZCTMbXlbit8LZ7+Ac42sk17nPFSrjDNJEVLdqxbEIrEhQkoHhAJYZW
         We3VwyO3oWGZvUH3BrJG5hGkpvMTsP8k0ntc6DVedreqNRV3gshcaN5viFXeYyVpw9oG
         hQbA==
X-Gm-Message-State: AFuF++mrnJ4wiBdonEbn8XUcNfWSZOvlkguITNTMLCabOErfCdYyhum9
	31jLUx2U9yn/8eBMFXpM35TKEr5V10/dCyG6qOalJ2mqzTJkYjNUAGEv4yOjMPejCtvKFRtciXA
	tJzQ2kw==
X-Received: from plae17.prod.google.com ([2002:a17:902:e0d1:b0:2ca:cba4:f740])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a8e:b0:2cf:82e6:a5
 with SMTP id d9443c01a7336-2d707b90f2cmr214231945ad.13.1787787570304; Wed, 26
 Aug 2026 16:39:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:14 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-9-seanjc@google.com>
Subject: [PATCH v3 08/13] KVM: selftests: Always assert that vmclear() succeeds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Continue removing dead error "handling", and assert that VMCLEAR
succeeds instead of forcing callers of load_vmcs() to assert success.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 4 ++--
 tools/testing/selftests/kvm/lib/x86/vmx.c     | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index f7ca6646dfbe..cf37a03a93b9 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -326,7 +326,7 @@ static inline void vmxoff(void)
 	__asm__ __volatile__("vmxoff");
 }
 
-static inline int vmclear(u64 vmcs_pa)
+static inline void vmclear(u64 vmcs_pa)
 {
 	u8 ret;
 
@@ -335,7 +335,7 @@ static inline int vmclear(u64 vmcs_pa)
 		: [pa]"m"(vmcs_pa)
 		: "cc", "memory");
 
-	return ret;
+	__GUEST_ASSERT(!ret, "vmclear [0x%lx] failed\n", vmcs_pa);
 }
 
 static inline int vmptrld(u64 vmcs_pa)
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index 03d61b1159f8..57a8287de0d2 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -170,16 +170,14 @@ bool load_vmcs(struct vmx_pages *vmx)
 {
 	/* Load a VMCS. */
 	*(u32 *)(vmx->vmcs) = vmcs_revision();
-	if (vmclear(vmx->vmcs_gpa))
-		return false;
+	vmclear(vmx->vmcs_gpa);
 
 	if (vmptrld(vmx->vmcs_gpa))
 		return false;
 
 	/* Setup shadow VMCS, do not load it yet. */
 	*(u32 *)(vmx->shadow_vmcs) = vmcs_revision() | 0x80000000ul;
-	if (vmclear(vmx->shadow_vmcs_gpa))
-		return false;
+	vmclear(vmx->shadow_vmcs_gpa);
 
 	return true;
 }
-- 
2.55.0.887.g758fc8c411-goog

