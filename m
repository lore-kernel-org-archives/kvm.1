Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174E2475F7
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481481; cv=none; b=n2u0HiFKTpT5TbTxErI7RgTsuSJxY6I2vUfAl615VOPfrIaiTEc2I8K4CvxA+xwf+GB9oZTFfqGRT9QB9GU1P2612MXXDdQPJRgvtHEw4iNDK8NZ7AoDqAEf+DuRiUJ3Q44XkiKB3Iu9fCwXFYTO0DXxAscfm/oW4w+p39judMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481481; c=relaxed/simple;
	bh=zXd5X55+TiJnkrJw6tJzRxUAJwCp93n+SWxvi5/Zx/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ESI/DAtlx5qsVOjaefIMB2E2Lxn5WmJND0CKjxjBncp7/U3ArweVxyFkE8O2okemth9IbwDXChbaPYu/Dlf2vH9TuvPFQpF58IEXttE7Pr1xTdfSBg+FS1Qb33D+rdzFrwCMxkqqhfNAu0e/zTKnXojWe2R7/RW1k8wSkPxjpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/xhtsIf; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/xhtsIf"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so7697635ad.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481475; x=1789086275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=907we4nZ8HxvlT+POuzPHkcKY9uyEq/810sd3j/s3UI=;
        b=d/xhtsIf12jSgcDeDr+ygm5tQ+mLVA/z61lVc1REfIvsSA4pAV1EOkHTs4kqRFb9De
         zflYvDonYVj0H1Zol/99oOUZNpyI4jeYfTOaZ+TENc0ies4MYmqhbRYbTnzv1wwkcmqa
         PxgXMT9nRCkRPfWoq579jldUvnpft7vHfLiy0wJPs2w+fpPywROFOzXzrLhQIm9JzskS
         /RVBkqy0mx/3Z5forDOauEqKWkVPIINMmqKRB/HzYvCQxWVthL1bHorsH1Td/EhSlfZv
         kNM1QtlyduC26ZLli4hoFr2XNuFrR2OKXw/APKYzPR0EROgu9cxvURBtB8NIijskJqE1
         J/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481475; x=1789086275;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=907we4nZ8HxvlT+POuzPHkcKY9uyEq/810sd3j/s3UI=;
        b=G4WL6gF7uKkNRl2pZfpc+NYKg8OVxpc4vBFK+G0zwA8I8nO+OUr/pLlu0gXbG9py2e
         QXtwIy6eVD54EB9BpF6W1Sa6XshuW1qtCgnnlpWYeiP+5YPnuFdNFV/yRDjRR2JRLiU6
         V8+gwUmIO2SACxqIq/6J3c9WWO1ho9Vk3vhrrG3dcSEorhSFmtC87Vgr4eKuOmtfkZ8Y
         WaP8HpwxhpSz82yI8fACl+dnovS/o9XI9RROJ6tc3edrCGc3m8kqS1lqtdFG0NganQH4
         C3T8AA7kOzM0Ug1ZsKZAmP1AG3BiiurPT/Y51UlY9XU0pHNwjQXkD+x2dXWMIAt1eMRi
         0G5w==
X-Gm-Message-State: AFuF++na1CJm7S85Jn4PBVhJ39QRwwIBVT0fzB/UyWAR4iwvw0XCzeWt
	w9RnGXdX7GUnW0wFBrkbzOqRZMXvE2bTv/qq6dHXzYF2LMdQuPvxNx53zrgPdbf4Rbgh2+mBr23
	VP4n7Uw==
X-Received: from pjli19.prod.google.com ([2002:a17:90a:7e13:b0:38d:b62f:5045])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c7:b0:398:e73e:5a0c
 with SMTP id 98e67ed59e1d1-39b2609f34bmr3601202a91.1.1788481475060; Thu, 03
 Sep 2026 17:24:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:14 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-9-seanjc@google.com>
Subject: [PATCH v4 08/17] KVM: selftests: Always assert that vmclear() succeeds
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
2.55.0.979.g7e5102b832-goog

