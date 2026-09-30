Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C647124F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797009; cv=none; b=c16ynwgwmlRDdNhOkWdJ2UI37wrLJhqHp331SweqBDt/HATxyIShuA5Fx3xgJq8G/9RBSjVCT9rpDsNk9QmwLcWkeDw53Kih5DRipD1aTxeb4i2hMpighR16FGuno0TyyWX9TUS/WxNO013r4KOE2ZKPiOZcewIGBzLkd5zcc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797009; c=relaxed/simple;
	bh=tCrIlqLt20X+8QwPEakDZKkBLPFzZNWoPctoUpEuH7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZsBvwVAFWuJI45FovsPzp6sUCzoT/01ioPSSpV9hzG5bLY/yd+E6P/j37W2KcQJyueN1UlCcqrFfnoSayGCOwE1yg3weYgR5v3gVbWG4r4tclprz02lcyEgXWtIZnbXD74jufmgEVAjJ8XdfsdS5PMZfbr/BqUMVYBXMdD2/ISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QG7E2rO8; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QG7E2rO8"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so54422985ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797007; x=1791401807; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WJqez9q2tYMQl9vJL63He7+wJRl5rjTer8kQlPmkiLQ=;
        b=QG7E2rO8rUBr5BTjDymbAsgh8b3DAPZuOczEVi1Ri7sH5L8Q9BlOD58pzkykBMaWcS
         H+YMQ3Erui6sseKETzBUSLJmH0vtj7xFFVxEL9d5UJeiffRuHN3eK4A7vcIKHMzWh+tq
         kIj0vt+D5KNEL+3ctt5+N8R3J7ds9KBe4hf8hOuYPN0EsoSkTenmUE3fdiuUbNNGWuDi
         GK42fhwR1S+z/RAUt0Qc8Vy6dYCUp71q0iVNT9mAgP7IE5+eSTKlxDXWOuQ5/2s2trd0
         /o3C3+c1lqk7N9mJGUUJV2uF2u55LUvxSvaSJUzz6gWR9LyLYFbIRXm9mLayGQAVhzlh
         ppVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797007; x=1791401807;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJqez9q2tYMQl9vJL63He7+wJRl5rjTer8kQlPmkiLQ=;
        b=LoOA7KFDVvnFvRnxEsHGISBcq424qzkSCcSgDf/1XiWUjvxdWVhJiR/P1Uj11q/+rc
         AhSTodN+eAvnjRrSgdyPnPPITwzvcB8pAXvomHZVA3CEGgSpz41OAG3b3atZuIuNi+7H
         UP2swuPE3Or98ZBgxy4VO97X+FBk71zVU5LXtBE2vd7qBxDaHn0tA98vJZqT3iuLxrt3
         gctpMx0qKboV8HfV0ikNRZtLylvItUk5ZgUuj1izXZ6apsWXLDFnjJRVZyWed6AmjrDP
         ZSwTmd4ggTHOLX12bilMwuVjh3yILqoPsYHC+L+6iSwZSzWw9x2OPO1IwlTtRgRC6oB/
         G/zQ==
X-Gm-Message-State: AFq9FYJWi5Fgfb+OqwLwJiR6mCEERF1X9uh/mzcy/o/+iXlHAnnN+HJN
	iqTltL9jbd6uhxlZ7ghuJ3HSv6hrxImRovqomwiY3G+q5jaWW6sJXlUQiXleshKXLFhwnClGdqC
	I3m/rJw==
X-Received: from plmd10.prod.google.com ([2002:a17:903:eca:b0:2e2:f8c9:e139])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f91:b0:2df:b5c7:d0f1
 with SMTP id d9443c01a7336-2e2e4b5b928mr16860215ad.44.1790797006569; Wed, 30
 Sep 2026 12:36:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:29 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-8-seanjc@google.com>
Subject: [PATCH v6 07/12] KVM: SVM: Add helper to query if LBR virtualization
 needs to be enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Extract the logic for determining whether or not LBR virtualization needs
to be enabled into a helper in anticipation of growing the list of features
that depend on LBR virtualization.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0eb1623052c1..775eccfb7b24 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -875,13 +875,22 @@ static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
 	to_svm(vcpu)->vmcb->control.misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
 }
 
+static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+		return true;
+
+	return is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
+	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+}
+
 void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
-	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
-			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
+	bool enable_lbrv = svm_need_lbr_virtualization(vcpu);
 
 	if (enable_lbrv && !current_enable_lbrv)
 		__svm_enable_lbrv(vcpu);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

