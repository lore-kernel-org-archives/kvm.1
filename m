Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429E36F905
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470518; cv=none; b=lqI7ZX7q7E2Zfa5n4UelNagEbbetw6d0mHLd+Zn7KUK65WnKLBvxnPWn1vcQKaxNTGpd7r+G6EGVGPxCv7L8KPBrg9kFtUlVkxRj/3AsF4E+J9hjiwoanSzOR/9GWJUmtgAxITjOsyQuFW4DYW8KoOFeCTzkN/eRTQ1ZXqIOtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470518; c=relaxed/simple;
	bh=8VUw56+T3RjvwctLlOGVrHVP61jIETZcQoXLXcNsDuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gs/cyo57pdMP0iRovszZ2cLRRBtm6XfTgyq+eyKGlmLKe7NzKGvj7QOvgKdFnJpGyMqISX3INvuz1qzHZ+vO3qc4BS9cVK/9/w6cyrBe8nhc/Tih1ou8z2Vl/S0EDAHK+syPtCO2r9IuJvdZPmHW22Sm4ru93YEcDCdWtD6zbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQ7rUdzn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQ7rUdzn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so9401528b3a.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470516; x=1780075316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/d3jj67pPnoaU6PwH8tPSTkB0XF7ZYOVQlKJMFXSJsU=;
        b=IQ7rUdznM+G0WC8sCpuMb2CfjL+VB4WIoqHctyR+Uacytih8Rop5VuZ6njtQb0Npt7
         njlqpw0qMDHvudoD5qKUaop20ke4K3YWdXd7NhRyDu45QDyp4cQKXcXqtNzbdwjAt6CL
         f5IdujpQ4pOKHwj/NnCOCuHTKgAAVP5haM8y4YkNTn+MpVPuIi0hCe/cy5XkOy7z00yd
         yrPKrz6fv6MuCLPui1EGnIQP+rRLxj3OuJokZu6UC7tBCWEpCPYGNFUMrF8TRKZ19vwi
         wdXMVkjIIF/V1ZUd8v7mbgSuyqaf3WoTnLTkqH3ZT24wYRE6qTaYGvdMMGu+6+aJr/CF
         gXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470516; x=1780075316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d3jj67pPnoaU6PwH8tPSTkB0XF7ZYOVQlKJMFXSJsU=;
        b=jbn3q8hpRdG8HtQOYrv+2iorzcsevnV/HFVb0I9j0125H2hZQesoOy8axi5e43tfsX
         ii/YYhwHaD4nIceNayOJAkxFqWvF6E+fRmD584i337oP4vgxJPPqu5Rz/5JyN1cZ+nku
         T7z/7O26WVz6d/0Ui7QgtqrOE4ELAsOmondYhHO5nqg1v0MpYfj4TwpYo96i+hyLMl3T
         PlA/6sFuIJ3OQkHxlFcG0P/k1UxpliJoCd4J3lCRP6kj8ENpzF2tesS71gQj5VbdIJkv
         Jc9nHPH+oHsvMNEa96yf4B+Zoiojw1ld2/ThPiQPshUzwzDBqidt1gkyvCWoRV2GYSuq
         BO6g==
X-Gm-Message-State: AOJu0YzD8enbbtyjb+DVJvShm0J8L/5QAVZTg9Ft8mRAOy+1auiyD12p
	6ygxZAka8kdXK03YAKlZbzYVesk2sHjGOOIpQE4taSAr0QD40nT67Q0O/N9/ORbHEF2wW4qHV7e
	9zfK47g==
X-Received: from pfblx5.prod.google.com ([2002:a05:6a00:7545:b0:82f:c34b:9799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1807:b0:81f:31c3:2e34
 with SMTP id d2e1a72fcca58-8415f330494mr4957284b3a.25.1779470515914; Fri, 22
 May 2026 10:21:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:21:50 -0700
In-Reply-To: <20260522172151.3530267-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522172151.3530267-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522172151.3530267-3-seanjc@google.com>
Subject: [PATCH v2 2/3] KVM: selftests: Test guest_memfd binding overlap
 without GPA overlap
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

The guest_memfd binding overlap test recreates the deleted slot with GPA
ranges that overlap the still-live slot.  KVM rejects those attempts from
the generic memslot overlap check before reaching kvm_gmem_bind(), so the
test can pass even if guest_memfd binding overlap detection is broken.

Recreate the slot at its original, non-overlapping GPA and use guest_memfd
offsets that overlap the front and back halves of the other slot's binding.
Expand the guest_memfd so the back-half case remains within the file size.

Fixes: 2feabb855df8 ("KVM: selftests: Expand set_memory_region_test to validate guest_memfd()")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
[sean: keep the existing GPA overlap testcases]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 9b919a231c93..be99c1ff5a5a 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)
 
 	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 
-	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
+	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 5, 0);
 
 	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
 				   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
@@ -526,7 +526,30 @@ static void test_add_overlapping_private_memory_regions(void)
 	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
 				   MEM_REGION_GPA, 0, NULL, -1, 0);
 
-	/* Overlap the front half of the other slot. */
+	/*
+	 * Verify that overlap in the guest_memfd bindings (i.e. in guest_memfd
+	 * file offsets), but _not_ in the GPA space, fails with -EEXIST.
+	 */
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
+					 MEM_REGION_GPA,
+					 MEM_REGION_SIZE * 2,
+					 0, memfd, MEM_REGION_SIZE);
+	TEST_ASSERT(r == -1 && errno == EEXIST,
+		    "Overlapping guest_memfd() bindings should fail with EEXIST");
+
+	/* And now the back half of the other slot's guest_memfd binding. */
+	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
+					 MEM_REGION_GPA,
+					 MEM_REGION_SIZE * 2,
+					 0, memfd, MEM_REGION_SIZE * 3);
+	TEST_ASSERT(r == -1 && errno == EEXIST,
+		    "Overlapping guest_memfd() bindings should fail with EEXIST");
+
+	/*
+	 * Repeat the overlap tests, but this time with overlap in the memslots
+	 * GPA space.  Regardless of where there is overlap, KVM should return
+	 * -EEXIST.
+	 */
 	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
 					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
 					 MEM_REGION_SIZE * 2,
-- 
2.54.0.794.g4f17f83d09-goog

