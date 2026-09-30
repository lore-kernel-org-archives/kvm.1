Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C97287518
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727709; cv=none; b=i2GEB1iJP98t0uEFP+ItGEVLh6N3SmMQd0w2aW/Ki7pgOoxUGhjd/ZssJT0gFMtAU/PKtHC3jwaNWZbEcO7vapuFdaIVnSNzFAOWsRPgOpiusPB9crXy8c1q0Nd+GEEfiWH7N7ZRR0A+pYBGfYNqkXYEJaHVI8CYdT2jesh8PpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727709; c=relaxed/simple;
	bh=KhzCmk5WC8AOQA8Ul45nUPC1/2N85vtoaJQNQF67U3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AtNnWc5Rd17r/WfK2LsUgE9CE3klumv6gsI3Ha1WaTmWZhKJf+AfpIn4RwS4Up6b02fEFLY8gMNgbY2oMNvisdrh2TDHtqYKjm9nKf6eCsA3sULB9fLIpFSpD0/rh8Ga19bUqoeaVNVUOUmtFquukhwIi6GeF5GPPAf3/kZOmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xrdorw5z; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrdorw5z"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd8920c132so68613925ad.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727707; x=1791332507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=StSfMMKa3bvOgPVEPrc0vegrNiPAcw8xGz3Rd2c57Ac=;
        b=Xrdorw5zUTSEsZKS7vW50rQ30l8lL9yBGgS2Jv+MTf+hQmvKHVKS1ydsr4Z7FUTN3X
         kiU6eL/4jMhToZ3ykIuYoerGJCNM46tzGpVYnKuWcrcYlSM5JuqBZZuMXzO51c+t5Kol
         d3WZwrNGIlhyF1mvpYgw+48z9mlTOqjnDuCjeuc3NThMyTOtHL8AXSlLtx+tST7XATxb
         AC+MfU9YY44fN9uHgOILYms6VDDNYSzNJrg8l5cNSuz/9lVJFtdr3WnaQJLVtliKaPWP
         1Azp9uSuFS5vGcgm+CoXDMhIgseguDV0RtGDUpCOl/jKqWuv0aYZcuNNR10F/J2qS0hk
         iRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727707; x=1791332507;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=StSfMMKa3bvOgPVEPrc0vegrNiPAcw8xGz3Rd2c57Ac=;
        b=emOf33uHNH3f9Q+gT46XDaC80bYuagNmUngKlXq6aho2JQ5KN0obihNtinQ1zOB7W0
         RIRBR78fDwwTj2r2vo61o1Y9nU80iKU6XkMp5uAiTNBgtGbDrSdIUcpn0BSk2z7Oftl4
         2S6kM0n9e0kVQcM0RmJ35sSlwp8KD1qkKoBUV0JQxnPpsTFIugySTD5xdQVnPoKGlbhm
         ZCCdt0o697XmoeHUcA263K5W2TDMK1NEORCzrk24O7YZjcB+WvWb5X6js+4KeXZg34Ic
         Pz5zignXtSeVEZlYs38prgJbGiLDqMLu198h9EOKrppGUrhb1m33XweO6eCN1hNAU2eO
         JG6A==
X-Gm-Message-State: AFq9FYIbOy9rx0J+kdDPLedkt3UpHeQORFPHThapPmApwrOvpuozgrcn
	S0kyRptefhkppkJC+kLqqYUFz/ccuzVeZt8KbfJMYy7j4cAbrYe3nM6l7BLNSr486Gz7YyHFc4o
	K+zDyHA==
X-Received: from plsm16.prod.google.com ([2002:a17:902:bb90:b0:2df:8ce6:d461])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1212:b0:2dd:c054:197e
 with SMTP id d9443c01a7336-2e2de56c95amr5179495ad.35.1790727707033; Tue, 29
 Sep 2026 17:21:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:21:38 -0700
In-Reply-To: <20260930002140.3174449-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930002140.3174449-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930002140.3174449-4-seanjc@google.com>
Subject: [PATCH v3 3/5] KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Rename svm_nested_clear_efer_svme.c to svm_nested_efer_test.c so that the
test can host coverage for other EFER bits whose behavior is tied to nested
SVM, and so that the name matches the svm_nested_<topic>_test convention used
by svm_nested_pat_test, svm_nested_shutdown_test, etc.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 .../{svm_nested_clear_efer_svme.c => svm_nested_efer_test.c}    | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/x86/{svm_nested_clear_efer_svme.c => svm_nested_efer_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..2554464d8b96 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -117,7 +117,7 @@ TEST_GEN_PROGS_x86 += x86/state_test
 TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
-TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
+TEST_GEN_PROGS_x86 += x86/svm_nested_efer_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
rename to tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

