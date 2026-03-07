Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06F2D3A7C;
	Sat,  7 Mar 2026 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846189; cv=none; b=MP7CJE6ZIKZkmgDC52Gi6FdP9kbgOJiOlCzrPa4IwLCV7+8uJfUqkH0wh4HTufV89WViAr8fQFu/PW3RO+UMxt5u52uLNMNL6lBP2LnF1+tf0meIgkhghfUtqXHFSRN4iG3H0B2zg0CBIDBwovPw8rVJFN3JRPddgzy9uUrEQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846189; c=relaxed/simple;
	bh=pbvDC5cATKYlFj6xqezHC6kl2o6p3pGv/bHyMa5pBz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKMKpDfWBZ9Mpa5B3dAVYGvapLslNOdAxF0WKwue5BGubMnQL9oTkneqPOTibSa53u3ujQENcpJQGPJdwBrI4KJMPIEwBQSMSkXLOrKymcBxGOqmjpNfQsPBHw3xI3QHDyB39UCaRXRKzeihYdnW+xeBXshVxwsyNhteWStrBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mniWdhCX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mniWdhCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B99C4CEF7;
	Sat,  7 Mar 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846189;
	bh=pbvDC5cATKYlFj6xqezHC6kl2o6p3pGv/bHyMa5pBz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mniWdhCXQkUgmTaEFFzoQ1XjD1VCkhplQdY7Tp3Hp3bWPci8WT/Ykg0gIFVUw4yfe
	 cqd+1hBnZ8q42ZhQu9oPtYaePn/JSxwPgPa3CJICfhManPZ2gkq6e6yRqPsApbWd7S
	 iLC5mVUobKMZk7ZbNoQjc7jBDgQfDhZTk0UcozMMauJDI08QA9j9uUlRcXYjAyXeLw
	 rWcWZtFY1nyjb8tgEV5EcYjnCYOSzz1Ytr/pc9aY0ik7PsWkvc3QnQtwMpMezJKFa1
	 dapsMEb4/vxuw+Bel6GyfFAv4ogbWZJuEGuf1xx1sVLIWaUNwk0N72iASF/DnDjTRi
	 gsKMijnNzJzkw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Venkatesh Srinivas <venkateshs@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 2/3] KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks
Date: Sat,  7 Mar 2026 01:16:18 +0000
Message-ID: <20260307011619.2324234-3-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260307011619.2324234-1-yosry@kernel.org>
References: <20260307011619.2324234-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking that the hardware supports underlying features for
EFER bits, check if KVM supports them. It is practically the same, but
this removes a subtle dependency on kvm_set_cpu_caps() enabling the
relevant CPUID features.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1aae2bc380d1b..0b5d48e75b657 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10027,13 +10027,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
-	if (boot_cpu_has(X86_FEATURE_NX))
+	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-	if (boot_cpu_has(X86_FEATURE_FXSR_OPT))
+	if (kvm_cpu_cap_has(X86_FEATURE_FXSR_OPT))
 		kvm_enable_efer_bits(EFER_FFXSR);
 
-	if (boot_cpu_has(X86_FEATURE_AUTOIBRS))
+	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
 		kvm_enable_efer_bits(EFER_AUTOIBRS);
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

