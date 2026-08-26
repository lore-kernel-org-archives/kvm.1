Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43125390237
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787569; cv=none; b=IUxpBzsMMD//WZ/qwoBbKlohhRTFR3USe0tUNTKGOMqAT3ag7qtmztw7jbEkpalwxQzj1zdPDEsrny2wY0+ZvThE3inkbYkJvdTZkJhPPtBnb+iIaKS7QqFEPHSPXpwVmHapgjPEykHn9KvyguzhmUX9tmmqJPAt16QcYAKJjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787569; c=relaxed/simple;
	bh=CkRIS9u8AusztvWTvPzOWFGQYsyZZzKW1ZZus+mQkq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OzXbJxQZXOzjiiahYftQx/OpJ3+nizYZfYfIaZI/CUN2lpNFyk9DC+l8iVA7FRKXS6ZWA4ToBQA5cd3l027Xan4k0EgLikuEsv8VUYz65icFNge+lbrV8865mQJKGJ7vp49tUXoEg+lcKkBlraS33mGt/bMLD+XJJXcGtlzeC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TahZQetJ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TahZQetJ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce8a76df2dso2318225ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787566; x=1788392366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FfB1TPfB01BkpCh74isHXlJBf/gfFyIKtvCvmm75NxA=;
        b=TahZQetJz5ZuCHjt3IPtvow3OAVijwGfi3Wse56JqfR2nG13Pi7OV2SIEzsRuUaFeQ
         oA0YaoVlabsCqpyz7Rc84gDvR6KtNM1eYUJiFgRllEdmvwqnto6dPAxQTbY1bSE7MIhu
         rgkRN1APdOYoIaL4kymMwZDiLoHLvS5yp9Fzoflt0bJo5cAY96TTo+1yfDFqTK7QCgck
         kxxRJJcdwo8xg/xdeLck/4QJDKy+fAguhwSipU0tmMO9PO0Pk+kmAwoFo7O7DfWhQKMq
         Z+fXvysodB4wl5hpPX8Q+bugOTLJnbtPvcx+0chpQ+iD1mb37TCZHsinMz2xtDEeWul0
         xMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787566; x=1788392366;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FfB1TPfB01BkpCh74isHXlJBf/gfFyIKtvCvmm75NxA=;
        b=WR6xbpyXCA3UZPESWsbCISaJ02JVdrqgXplksF7TaPFYKQpUAnxQ0iVTr1/697Ix3P
         kbDwqyf8W5+zPTiqaCIx1yM7QXJP+fskYZmr8VfywRyBOG5QPOW0FkdJlMGeXtz6OKL5
         RlT8bE0HWZB0J0wwZpUDvEKl6xQt0rpAfM3zAVkXlB8nkegoWAvE5LUjHe9xMJBk5DgD
         uWz4SpQDrTHktsJLD3EbLZK66ECF/XMc/ih8RNpXX0cdks1UiL1nSuS051aP3fMkxBiK
         o9C6GtfSjkqTkfm0VqUb4SPweG9t26qAYppCch4r5s6t3orSUWiA3CTDlPUUrQe5sDR2
         TFeg==
X-Gm-Message-State: AFuF++kZRCxqPUrYRTJ0/ngNErlUq3wWiIvaIg2cI8niLODD88tc+D7j
	PTfQ4saY+5wz6Hxqv57BbKPiU466DLbAJ54KWs2VGa7hyqdE9Ugc6jZ0kPoD0mEpJeQGHQWjyN0
	7PvgQ4Q==
X-Received: from plbkn16.prod.google.com ([2002:a17:903:790:b0:2d6:e484:2160])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:324f:b0:2cc:f5b8:4c2e
 with SMTP id d9443c01a7336-2d707b45a87mr197320385ad.9.1787787565494; Wed, 26
 Aug 2026 16:39:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:10 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-5-seanjc@google.com>
Subject: [PATCH v3 04/13] KVM: selftests: Adapt to the updated VMPTRST
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
2.55.0.887.g758fc8c411-goog

