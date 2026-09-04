Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEE27467F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481473; cv=none; b=T0mZeYEMt6CAJHpzmFfMOukoEoDGsaIe6onyL+HAsfA6LUCb4bq7J6J86ru+gMv74kNiU0OEbugq4QBFeb7MemlT/h2o+ZFIKRDSmr7O0JlIVV9o6St/5Tg0BwigC62B1r/DFVlPrA+4iSSwjJvgOhJUXe12S0meH3XWMhx5ONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481473; c=relaxed/simple;
	bh=lKfRr6U2bhRKVy1KJfPiyPVEF5KWt/ARhVVbK4kS7kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+1ykZCFs24VOV2UbSmaKvxbIEiRvWCmo3T/qVk4w01UM5w6Ihxj1m8ik/9Q9neFJSMG6c8Dt25pK68+9qOfXIJI+dkV/Te+j+6vCxRJu1PzreTt6PHUAwemX1OXi8rq3hWSMxfWEoZEYeCBQetlxjurf6OFVObEv5Q9z9OtBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGAdgqfU; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGAdgqfU"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c856470fe9fso509517a12.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 17:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481471; x=1789086271; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DpIcw/+ywfe8w4rdBomypCt/lLrNM04RMqmRif2yLnY=;
        b=HGAdgqfUIuZzuI4Lq6ATsGs0cdTa+GQmyN/FCGlQ1HwCiQhkddPkEJhW+aG5FsN1gx
         YVunqfQHvlJ2KqkM7YukxuTLIKARUULxGG+x1JnidzL+SKx14gryyDOXpRRc7b6MxIsh
         qLUnFOfOVpixWw7OlgFo9bLu3uWfKKRVtzHRBYOBD0qmlyKTUWrZKX6FGP4YGLVOXeP0
         SgD0uLEAM0UUUTOIkuPd4nIlHSVyBgjRKHqJsns2zQS0ZibXjGR3D19yXWVRGavj13eQ
         mJdGxmPnfAPUWww4xkwD5ZvPsL+AuU0NKYY/FfRqFp6K5uDPnNjWgb5UWV67ianMtsZq
         yjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481471; x=1789086271;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DpIcw/+ywfe8w4rdBomypCt/lLrNM04RMqmRif2yLnY=;
        b=Si8Tp9oiLKyAJUFn4UUSNvh5cQex18FeFJ01gO8bIeURM3M0c47vUnJruqxdKvnI2L
         EGQjR8M9V2gDBkQkk+hM/4hUp22OKnaAk5PL2T8tFRFbcwSSn2Tvks/C8m1yJscKU4xb
         dergzcON3jTUCXK+IdbAPMZxN44/AaIhmX3vxxtzraGxaIplGOGMol9Q82uIwwzA2EkV
         0zn+xhhSLptRLhghiKG1o+FmhoagnijeSt0ilwU+y5XzJJllMM3S+oAGM9BgIg9ThZhG
         Z0FGW4wUzCln4Cs7GbmFGhxmGc7uIJoUQSV/cqwtoJkb8C/3HJ6wJExjcUpQjtcROmaU
         JNJQ==
X-Gm-Message-State: AFuF++nYXMq161obW9D7ry2RFB3VPU9zOv6Sl/y/AM6D/zzqpLaAJXXT
	DLsKxksoTzEdezr4v+oRrIZSjovulERo1hZENJxCWvRq28A18zgnKSQYgsGpVopI7AKsYQOzBpe
	tjC0mYg==
X-Received: from pfuj13.prod.google.com ([2002:a05:6a00:130d:b0:847:86fe:e9c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4b:b0:84c:1cd2:142b
 with SMTP id d2e1a72fcca58-861671b9e4fmr3506208b3a.9.1788481470573; Thu, 03
 Sep 2026 17:24:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 17:24:10 -0700
In-Reply-To: <20260904002423.3154436-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904002423.3154436-5-seanjc@google.com>
Subject: [PATCH v4 04/17] KVM: selftests: Adapt to the updated VMPTRST
 behavior when eVMCS is used
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Previously, VMPTRST was forbidden with eVMCS and selftests were mocking the
correct behavior in vmptrst() by returning enlightened vmptr directly.
Since KVM's behavior has changed to match genuine Hyper-V, adjust evmcs
test accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/evmcs.h | 8 --------
 tools/testing/selftests/kvm/include/x86/vmx.h   | 3 ---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c  | 5 ++---
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index 82a8ea6b661f..c5b9d26f6cdb 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -265,14 +265,6 @@ static inline bool load_evmcs(struct hyperv_test_pages *hv)
 	return true;
 }
 
-static inline int evmcs_vmptrst(u64 *value)
-{
-	*value = current_vp_assist->current_nested_vmcs &
-		~HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
-
-	return 0;
-}
-
 static inline int evmcs_vmread(u64 encoding, u64 *value)
 {
 	switch (encoding) {
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 04f5e34dea3a..ac7d48d1387e 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -358,9 +358,6 @@ static inline int vmptrst(u64 *value)
 	u64 tmp;
 	u8 ret;
 
-	if (enable_evmcs)
-		return evmcs_vmptrst(value);
-
 	__asm__ __volatile__("vmptrst %[value]; setna %[ret]"
 		: [value]"=m"(tmp), [ret]"=rm"(ret)
 		: : "cc", "memory");
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 63ea1533e4ea..6224d859d7bb 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -92,15 +92,14 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_evmcs(hv_pages));
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
+	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
+	GUEST_ASSERT(vmptrstz() == -1);
 
 	GUEST_SYNC(4);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code);
 
 	GUEST_SYNC(5);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 	current_evmcs->revision_id = -1u;
 	GUEST_ASSERT(vmlaunch());
 	current_evmcs->revision_id = EVMCS_VERSION;
-- 
2.55.0.979.g7e5102b832-goog

