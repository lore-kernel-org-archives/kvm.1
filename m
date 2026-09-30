Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8443CE51
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797004; cv=none; b=gdjVAAZP9q8KcZk6Ud3t86MgVnCkCSBW6k65y0y4x+YTo0YdNKXt6Oc7WgSdteGNnENPH9q6GwAB/9QiLgtjsP4KjxyXcOsGrS19oie3Nf8wvAVsXQlDMo8hbjG6j5ylNtELQddnzio41+qS6Ft2dd4OHrcRxUQqLGkYrCO9rLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797004; c=relaxed/simple;
	bh=IG1RFG7JM2igBgdTr4qbALiuJCKa94wBRCLlp9vz/Yk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uYzohCw5b79L/FRWlWNXAW7imJBJNuyie+Sc87m76jIIAUb919FcnY7biWrrZhvOJi8wPv2ljyqTjwD+ESTSLyPw6uLflvKEC+12jkcjjUEgvaBUZc+/NZR7c6Nz7vzVXPkG8vJduAijKa29qRzSmpPjdzOTHJGPWTUcAkbvFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brnYs8fp; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brnYs8fp"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so54422495ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797002; x=1791401802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zf6V7qVlBg/9H6Aj6n5GwJRdbCo9HKQWheBBXTou4EY=;
        b=brnYs8fpUU+K8w3T0Y+5HkpdoTMnhgK7SeVfaJAwQCNbgc1WnmB3ZCpraR3M60SJlf
         tzUXd4EK73N4C19/RJApkr6QGlHZR+6TAbKCj7/vEx9dzaIqHms0dPFVv1OTyht9xY0p
         ndPxMwxFNfxMFofL9gLZaNLQRa18nO9SFtpD56de/MwPY148HuxNQHQIBr+mJrUTvjjP
         tTIDhPwFIttuFz3bGBjSc3DiMJzSr4PBANqiWFqg461LnyPWYSqqoJmjwdhnxmgbTDp3
         y5mOPjm6TzqdJaLfDG8VkapDC50JsiC74zAzTDRjMY9HC2GkN0wkEYyRY4qcrJu7CkdJ
         3r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797002; x=1791401802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zf6V7qVlBg/9H6Aj6n5GwJRdbCo9HKQWheBBXTou4EY=;
        b=qK6uosGMHmehJ2XSaDG4XazlEHbGP4B9fMwSN/ngcN01q4CMwhgLvk0HUVdNKiwTBy
         36BRb4fzjJPi1bLMSmj3cvzja3/mLWouThO76grLiFDAEfUZuXNrMzheAmRQ8JR2H6DQ
         CeZlNtwCwPw+WPfPcHbWB6C/T9As6fs4IQVVeTnFHHZL2LNA84/FqkFnqZpYo72tocaT
         yyt0zLqYC6iQdDyKsukXDhbAhw3pQnht2CtvS+OhEn4ftradmDmVgBzmOi51yLrSMAVE
         vQ53Hc6yP4Xc4DeNGF2QAVsGva8DuockH0sVPElKyQIdAkufmOJA+cXMHYrKpG+97S1p
         JEAg==
X-Gm-Message-State: AFq9FYKV4WH4Mmm0wzgd9kBvqmyhazcLVXr5Uj+aLrMMu7QA27f5w7Lj
	W96uL3axd3lDN0mQwNTHd6sUG3MWMu9QNJj62ucN8ddQw/FcUsT5RwjYBfCyEfYdrMyk+OtS5ZU
	Elwnfiw==
X-Received: from plct20.prod.google.com ([2002:a17:902:d294:b0:2e3:214:e99a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db08:b0:2e2:db9f:3e88
 with SMTP id d9443c01a7336-2e2e4b85249mr18284175ad.52.1790797000662; Wed, 30
 Sep 2026 12:36:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:25 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-4-seanjc@google.com>
Subject: [PATCH v6 03/12] KVM: Return an "unsigned long", not "u64" for the
 fixed-1 DR6 bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Return an "unsigned long" instead of a "u64" from the helper to get the
fixed-1 DR6 bits, as debug registers are natural width registers, not
64-bit registers.

No functional change intended (the fixed-1 bits only set bits in 31:0, and
the sole caller truncates the value to an "unsigned long").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 62075443f6b9..f74a29621661 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -772,15 +772,16 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static u64 kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
+static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
-	u64 fixed = DR6_FIXED_1;
+	unsigned long fixed = DR6_FIXED_1;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_RTM))
 		fixed |= DR6_RTM;
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
 		fixed |= DR6_BUS_LOCK;
+
 	return fixed;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

