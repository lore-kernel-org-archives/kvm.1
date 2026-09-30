Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402293515C5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730799; cv=none; b=jYc3XsssOutDNVOH8rOFwI4p7gMVSEWLxnXSlIKTUqa0RmxHklXDpER1OGUOul0sFRkJ6z+8KJsXmlki4F0Fi6bsV2xCWeACvTJe5XIGq/6CTtJOeSVNDCPcrgRhOn3nTd/78Dm6nFJgOpGKSVnJUAzMVVcTih8knZ5td/NNJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730799; c=relaxed/simple;
	bh=wqr+SMrt7dxBNk54DLAnLV4dP8Pt5nYHC5LIfJSQCT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkTHqVqGEn5a9Sh1G0PKN+/VEAt0f+y+VvXuMaDILpRUnzt2lV+T2jQfpPf4/hFUtTONVVvAEgFegqUG7Kql88HjN8FPn1EwAC1ryH2jRFSNfZZ/bNdRE/MTcz+izHpQ68iQkn8Nmr7vA9SB86ak5qgVEASs1cNDCNwUPmuayRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdnV53On; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdnV53On"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088203so2900923a12.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730797; x=1791335597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=APU6Hsi/UB4LmSAjtjOtU74/6EleNQVrcW2jpeijhhA=;
        b=AdnV53OnfwQJ+a0q5dXnX43vYe8Aser8WAAPl4z2s0Mc8nS2fvIYrPZyQjsH8pIT0t
         Iybzkjc+pvng1/l38mXxa1O1kSDBbYrbGpFOolmnCh42nFEwoN1wN7al4o6Zb+RLQMtm
         bB4CC3VUxUBEkwVha6wwb42kI5Q7AiIJ+Ly4wRcZagI9e4YpnUqPaJTqNlqpCl+sKLrL
         ivbbhJxtfKTrxqhzV5k4hoqq6sCZG7lThSwUnBFZ30arulQgJAkDnzA1Xrea3+5LcKrF
         EbHbsmccJBB8RHLSCWrVyS9Ezg0UD7Igztkz7bMYVX0rlnStSM/OAXwK+G83mbMNgaRP
         XwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730797; x=1791335597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APU6Hsi/UB4LmSAjtjOtU74/6EleNQVrcW2jpeijhhA=;
        b=PnQaYrZ73GvGlhuRqoaWkZiKwo8o6O8vbGudvmNRFQxPqdKqWy4rvopZBRqRo1qZt5
         7fdBqEXoww7s9V2cH7Eqmnxq0oDBsMTHy2sxeAXIGXWgd+1nbuVqBhJXP6fu4qGrr0mE
         1xY9Sw+eQF3tQeb2QYX1gXveh2xfAMNqbrnTWYnzu/dhDDlswdlw5GhgI9T0IBV8OBH/
         NJPaGgAKFE2uZM+n75dkBNRaVAidYE8aWv10n+AUlOpoIbD2SxzCkAGpviaNjJ3Gb9K+
         dziONhRYAe07NVI9H1U0bHvp2PLjP5CLn7DPtaZQN5qHqYQIh63SeOQs7J+m51SDyusg
         ZdMw==
X-Gm-Message-State: AFuF++l2BhJV/qMjMplT9HE9DGCLBcrjNvvpkOyeR4xzK0vC4yBFsj9Q
	stPa1B2PlPCd2J/NETR+KhU4XidGo+VCtM5cDnF6Oep8i3ew3vOiNS4Xd4ZGBFThKj04yFnG6a1
	M2/wpmA==
X-Received: from pgdh4.prod.google.com ([2002:a05:6a02:5184:b0:cc7:b470:94ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf82:b0:3dd:a195:dd5b
 with SMTP id adf61e73a8af0-3de953c2acamr737312637.61.1790730797369; Tue, 29
 Sep 2026 18:13:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:03 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-3-seanjc@google.com>
Subject: [PATCH v5 02/12] KVM: x86: Rename kvm_dr6_fixed() => kvm_get_dr6_fixed_1()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_dr6_fixed() to kvm_get_dr6_fixed_1() to make it more clear that
the helper retrieves the fixed-1 DR6 bits for a given vCPU.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index fad31b59c622..62075443f6b9 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -772,7 +772,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
+static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
 	u64 fixed = DR6_FIXED_1;
 
@@ -798,7 +798,7 @@ int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 	case 6:
 		if (!kvm_dr6_valid(val))
 			return 1; /* #GP */
-		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_dr6_fixed(vcpu);
+		vcpu->arch.dr6 = (val & DR6_VOLATILE) | kvm_get_dr6_fixed_1(vcpu);
 		break;
 	case 5:
 	default: /* 7 */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

