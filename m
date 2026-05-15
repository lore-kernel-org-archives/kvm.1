Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8423F5BFE
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884011; cv=none; b=df8jXUPYO+qzKa0vMm5x/njl6PX8d7eZ0acpe2JsORhLwNMRGjxseiR1mzp4nIsujPT41dfikf3x1qY9upY9/uq6PNOlVC2bd7bgFYg471k41Y+BPoBijCAnM+V0cO9+OvWFzt7cM7t3mVgeEUPHhF6lvW/U2zwHSvvaZrMAnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884011; c=relaxed/simple;
	bh=UF2AcgAreN9t5cQBNksZDPJUbm/IWXoeU07tGghDGxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oN0nsuD9l4s6bKnJlrmAmjtt2+usKZFJS8Xu7IuV3Q5webHw2oaXV2yh+bhDJ3nUxIU7WvOZw49nFgDYRUyW/T55yMtLa7elqsVQyJ3k2tIvtL1dmKEhYsjxaU74iafRZDMKKVlXTstttOHjgvXHIEM2Y4RKQDQevKOF27qzB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JrBWGmpg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrBWGmpg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso635577a91.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884006; x=1779488806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J27Ju2q/+RYx5fEK+7reGgGhOWnL4zngH5mix3OXeJc=;
        b=JrBWGmpggpyb06yxbsvdmFD7Mvgui4YhemkRFDVfzVuxtcylM4GHkhPgVtRiQNtyO0
         aYjdoeurfDFM0FziP6VbqHBNHhyVvVxWE/14WIUCUHrxpm8LQaDXzx4Hm9+uXxaxD/UU
         KJAvDrPnxEL5Qq0BLQZEpMTRWKootzwg04hNsZw2WkxstZ/IM+XPRlnqJt5+jAocw9iw
         n76PBWGrlYhrw5FwDbiYpPLQjjtchWQoTamYgrFCyylqVgn/LbL2727eebrDpzrViz/Y
         4xucJdajF2OFzKZC47vNrG+ke5FsRZoAyg0J9+KysFh21BxAMgXK6mhyL7V4b1bX1IhX
         /6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884006; x=1779488806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J27Ju2q/+RYx5fEK+7reGgGhOWnL4zngH5mix3OXeJc=;
        b=DN5vqMmEC7lw7Xm1DrtIdkx+yk1vTGr2MKV8CqoUvBbThmlPwxMf+BqBNBMPGVEAvp
         Ax9R+h10NKJUr07mMe7xl1eKo5AsIwrVb38XSyY/1VelQltPBzhdSdJq1fHeX6OvF98D
         N64kx+zAlSmh/teBl9OcasfG3YWkq3AkETAFl+h1wBRQqeVl6/EkbjD9mM5MRGguutUI
         vbgbK40YF0WpyS+IojABYt3H0XMnbEEvDny0ckjtbsJygSEy0FshuAI0BFyzogg28pH+
         Kq11DheJI9Ic9KYB7UpgJzG7Xs0v36WNVRRkQZA0v+kig1A6pbU6Yc5Kn3/pkVVYblo4
         8/kw==
X-Gm-Message-State: AOJu0YyWsNTIW1SFs/Q6Rs/UdFAheySuEzIeb/fCuGM46yGGxjwWp3n8
	heYrg3VnkgDYxsh67+JAVrFwjxx/j7/7QCZAYTymQr3dMOZSGZnG0LwhKRWYzSUw9MbwPb6l9ef
	0qxUN6w==
X-Received: from pgnc6.prod.google.com ([2002:a63:7246:0:b0:c7d:a551:e17b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8f:b0:3b1:a9ce:5095
 with SMTP id adf61e73a8af0-3b22ea4ce78mr6643197637.22.1778884006352; Fri, 15
 May 2026 15:26:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:34 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-7-seanjc@google.com>
Subject: [PATCH v3 06/10] KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into kvm_inject_emulated_db()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

Move KVM_GUESTDBG_SINGLESTEP handling from kvm_vcpu_do_singlestep() into
kvm_inject_emulated_db() to dedup the USE_HW_BP vs. SINGLESTEP logic, and
to allow for removing kvm_vcpu_do_singlestep() entirely.

No functional change intended.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 279e2734e088..ca30a8987f2f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8994,7 +8994,7 @@ static int kvm_inject_emulated_db(struct kvm_vcpu *vcpu, unsigned long dr6)
 {
 	struct kvm_run *kvm_run = vcpu->run;
 
-	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
+	if (vcpu->guest_debug & (KVM_GUESTDBG_USE_HW_BP | KVM_GUESTDBG_SINGLESTEP)) {
 		kvm_run->debug.arch.dr6 = dr6 | DR6_ACTIVE_LOW;
 		kvm_run->debug.arch.pc = kvm_get_linear_rip(vcpu);
 		kvm_run->debug.arch.exception = DB_VECTOR;
@@ -9279,17 +9279,7 @@ static int kvm_vcpu_check_hw_bp(unsigned long addr, u32 type, u32 dr7,
 
 static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *kvm_run = vcpu->run;
-
-	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
-		kvm_run->debug.arch.dr6 = DR6_BS | DR6_ACTIVE_LOW;
-		kvm_run->debug.arch.pc = kvm_get_linear_rip(vcpu);
-		kvm_run->debug.arch.exception = DB_VECTOR;
-		kvm_run->exit_reason = KVM_EXIT_DEBUG;
-		return 0;
-	}
-	kvm_queue_exception_p(vcpu, DB_VECTOR, DR6_BS);
-	return 1;
+	return kvm_inject_emulated_db(vcpu, DR6_BS);
 }
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
-- 
2.54.0.563.g4f69b47b94-goog

