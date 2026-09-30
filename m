Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C65625F3
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789869; cv=none; b=EVxKa3SktUi4M9/p2TKPLpH4aUphqh6FHraIOOJAMzG5aiBx+N4JXMQy4D38t3lSqNGkXKLq5v5349q913eIGPH6K92jZ7qz/RlobpT1vl5O5ewXkk+oSyuq67UNVu7+OUEycU6roIm40ctX4nAAzH51AGMyu+5POTieK8vVN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789869; c=relaxed/simple;
	bh=F7Q1IXb+CKOZRYm6C5YZ7l5m3GJjGbwm4Y6SzdTYEbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pq7+NhyJwVjm+I5YYGbCQ9J6ILdHsHrQ5KlNMFCS4mKtVX58XTXwr/n9sSkH+OesCe+46W+78j3J6Tndimd335yb+4bbCepvAwo2Otc/gDfqp9XP4wmc9bTuA2hwQV4FRuUrNLIcDtX+NvrI0P4lPNPnASyAMGC6ZgNhJfwGyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUYq5YXN; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUYq5YXN"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so620640a12.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789867; x=1791394667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ntIQtv9nBblF51W4pi/NOBUOhOF12Cf69thE16MFD3Q=;
        b=QUYq5YXNsjOv6m67tfOM9Y7TfC8drd4Ysyv8dfmJ126yxDzvJbBKd0t7BSfV+KU1lm
         S2/BnLB96iJMBc3P9YE7naoNLA+NkFNJ/SVVm65gE1ZY3sGOJcI7/dc+wNGoWtHrIg3G
         fEy5HqHGA3UzXWIq6KPxkFxpqdNo5RMFD9xcbuIqLbkc/U9kdp1ISp9RVj1Lrq2TdNvK
         la6eZHqZpbi78jlchFS3PnMye0RTH2YUjP0IrGMBcUPubhh2H2Ys6oOr6YkzQzRuA0hh
         wlKdjta2zcsH4qx+ogzllkUJfOA9TGwHowToWjbAus0vElf4ZqlnpKakApdPCVY0wYOr
         bYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789867; x=1791394667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntIQtv9nBblF51W4pi/NOBUOhOF12Cf69thE16MFD3Q=;
        b=Cgwpgu4AwL4W/lx/Stx+B8Sypiper5fP6Hvg4QpXSurLYM+DlW5IZYP99jQls4yHdv
         B9xu6pP/rPPfFiqe4vV7WxIt4Nmaa4gOTCLidP/sFEKswOjRkHVKPp2VZgLcG7ODDfVl
         YaDNc9IHyUlwZa/NNctbW7OKDesUVNuudiz21nny0uUsU9Elf7ReLxXpzP40aI+tOqNS
         jzMcdZpvGOk3G613levg15UZDYD7dUexjF0u5DPRCEnROJXjTyOrw6NwLlyy65dVYf8z
         jG84/BlMhoTgA9Mkt5hyukiKHhPO+prBZFzh1ya5kBhM9Iy4IdyisJ3C/f4sKPjLEJ1R
         fliA==
X-Gm-Message-State: AFuF++nVK3eJ+XPDIrwETm5nlUAR9lbmRqwBN309hkcUoC/oW6onDU17
	5bMEqZI/VvjyrkFZ1jZ3Wypfz1+PFCQIZ+0hcKFy3PLCwysjYrGV2yhvTI01nJSE3Ii2+ndd7ST
	oYqZolQ==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:cc7:d03f:4d50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2450:b0:3dd:a196:69df
 with SMTP id adf61e73a8af0-3de9eb42380mr2239156637.58.1790789866526; Wed, 30
 Sep 2026 10:37:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:22 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-9-seanjc@google.com>
Subject: [PATCH v3 08/21] KVM: selftests: Rename TSC freq checkers in nested
 TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Rename the nested TSC scaling test's helpers to clarify which one is used
by guest code and which one is used by host code, and to make it more
obvious that the host version *checks* the result and asserts on errors.
Contrary to what "compare" suggests, the helper doesn't return whether or
not the actual vs. expected values match.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c          | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 84312146e93f..e5fc4c9bb9f9 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -32,7 +32,7 @@ enum { USLEEP, UCHECK_L1, UCHECK_L2 };
  * measurements, a difference of 1% between the actual and the expected value
  * is tolerated.
  */
-static void compare_tsc_freq(u64 actual, u64 expected)
+static void host_check_tsc_freq(u64 actual, u64 expected)
 {
 	u64 tolerance, thresh_low, thresh_high;
 
@@ -45,7 +45,7 @@ static void compare_tsc_freq(u64 actual, u64 expected)
 		    actual, thresh_low, thresh_high);
 }
 
-static void check_tsc_freq(int level)
+static void guest_check_tsc_freq(int level)
 {
 	u64 tsc_start, tsc_end, tsc_freq;
 
@@ -66,7 +66,7 @@ static void check_tsc_freq(int level)
 
 static void l2_guest_code(void)
 {
-	check_tsc_freq(UCHECK_L2);
+	guest_check_tsc_freq(UCHECK_L2);
 
 	/* exit to L1 */
 	__asm__ __volatile__("vmcall");
@@ -75,7 +75,7 @@ static void l2_guest_code(void)
 static void l1_svm_code(struct svm_test_data *svm)
 {
 	/* check that L1's frequency looks alright before launching L2 */
-	check_tsc_freq(UCHECK_L1);
+	guest_check_tsc_freq(UCHECK_L1);
 
 	generic_svm_setup(svm, l2_guest_code);
 
@@ -87,7 +87,7 @@ static void l1_svm_code(struct svm_test_data *svm)
 	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_VMMCALL);
 
 	/* check that L1's frequency still looks good */
-	check_tsc_freq(UCHECK_L1);
+	guest_check_tsc_freq(UCHECK_L1);
 
 	GUEST_DONE();
 }
@@ -97,7 +97,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	u32 control;
 
 	/* check that L1's frequency looks alright before launching L2 */
-	check_tsc_freq(UCHECK_L1);
+	guest_check_tsc_freq(UCHECK_L1);
 
 	prepare_for_vmx_operation(vmx_pages);
 	load_vmcs(vmx_pages);
@@ -122,7 +122,7 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 
 	/* check that L1's frequency still looks good */
-	check_tsc_freq(UCHECK_L1);
+	guest_check_tsc_freq(UCHECK_L1);
 
 	GUEST_DONE();
 }
@@ -201,14 +201,14 @@ int main(int argc, char *argv[])
 				l1_tsc_freq = uc.args[1];
 				printf("L1's TSC frequency is around: %lu\n", l1_tsc_freq);
 
-				compare_tsc_freq(l1_tsc_freq,
+				host_check_tsc_freq(l1_tsc_freq,
 						 l0_tsc_freq / l1_scale_factor);
 				break;
 			case UCHECK_L2:
 				l2_tsc_freq = uc.args[1];
 				printf("L2's TSC frequency is around: %lu\n", l2_tsc_freq);
 
-				compare_tsc_freq(l2_tsc_freq,
+				host_check_tsc_freq(l2_tsc_freq,
 						 l1_tsc_freq * l2_scale_factor);
 				break;
 			}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

