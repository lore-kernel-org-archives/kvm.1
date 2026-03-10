Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E413C9EC1
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177528; cv=none; b=SAT2GLkEX6aDksWvA08jkbqGmj3B9VvRM7R+YHuV2CbEThgP2QIXfDAEFVkdzhVnngbKB5l6MZKh7zR8xUHtTHJD59w14Er0b36h36kYKo5SYtt1S/aRoH0I5FWMBxTCD6TqopnkZwzksQbMn1DvHcs5kdFIyFA7QRAGXo9E0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177528; c=relaxed/simple;
	bh=I6/K8Mr0bjHYxOECs28OHjZKcjEU5wZuhZrOi8DO2X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kItUYOFsq1CRETc2ISbD0NuNHmc+XgmygfcnfhxSyZkahpH4F5i+48AVjNlMpeLgWAY7C1jRcPgOoSHLxYIqN7LdwDFoitD4LfsbBMVqvF7fVrGV2bKGpdqOLIXIzMkLXyd7Rl5QukJNRQ0dQWA6HzGjZV9zGA9nmVASasUZbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2Uo46m2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2Uo46m2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598518beceso10197062a91.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773177526; x=1773782326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7fUvP6PMmMjoOVXqU7ieGLMVIjfZdL4Sg65k3US/tM0=;
        b=W2Uo46m2NV2VA80fWZxXi4/suK+QcYoyrQfPilc/0/aXJnC4lK/xpEdu9N/7/AX8bt
         ErRKGjA1un6LBF2f9jfHR/MDEoG3v2qJ/CIpnAjmtl4bf0hiIsygPn4OJJTh8gH2htzL
         t91kUf71JC/rPq6h/j5OoCjYrOQTGm/eg60eeQBmkDMc7Mp7mD9BH4rkbmlX5/T0j7Fj
         9C4XjH53gck+YLMRFKgEgAL4gSCXuiAqm9YFwaDwcwAcJwDZUG9i9/ATssPdSSgSXPhR
         ogY1SDy/kroc5UGh4Gvj0goIXD3bXKr94hJfNm92g9faJVppF+/FaljyEpOIGYFEIljs
         zjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177526; x=1773782326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fUvP6PMmMjoOVXqU7ieGLMVIjfZdL4Sg65k3US/tM0=;
        b=c0HMSn0FhVtX+UYmtjNk7vtJIGt7OYZ7a6lVIHglc6YVNdTTPXiGzrHP8iZne9T1QN
         DvBS43qa3HZbwxfGpYakzYYX9R0Js69GIXmjUZCNsedj5bnUysxM2N/jX70qZa4wRB75
         N/gTFPVN+hlcaOzwKsL3eZVVP+m7vJw6Y0xEbFM1zeJGsXrP7dv4ywcft/J5hEEluBr7
         oRAEZzHz9IWHIJoTHlzSFGPganhO7d11jmVyeuIKfQyAfiEYK7/0ndosMIbZ7WZsK1Am
         /0KmlrbtwyurL9t0kLRG8wtrTdzzSk8S1nc6c5Kw0Hupq16q8eT3hiYPfFTwzyoahVzU
         oG5w==
X-Gm-Message-State: AOJu0YyCuEZwZdKJjKfjtIgo4XPwwDWKN+KqKc1V3ltBh9ceQu16Lnzb
	9Ps/VbjoJpgJvIwNGW1YWPXWafaGjSLfrTjUNiwv3fAMr40TaTochz5GRxAE805M1AU5IBiTIHl
	VIQOy7g==
X-Received: from pgki21.prod.google.com ([2002:a63:e455:0:b0:c73:9c8b:4186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b8c:b0:398:7df5:2dae
 with SMTP id adf61e73a8af0-398c5e6067fmr65812637.9.1773177526121; Tue, 10 Mar
 2026 14:18:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 14:18:40 -0700
In-Reply-To: <20260310211841.2552361-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310211841.2552361-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310211841.2552361-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: SEV: Don't set CR8 write intercept when disabling
 AVIC for SEV-ES guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srikanth Aithal <sraithal@amd.com>, Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't set the CR8 write intercept when disabling AVIC for SEV-ES vCPUs, as
attempting to intercept CR8 will generate a #VC and in all likelihood kill
the VM.

Note!  At first glance, one might think KVM's handling of CR8 write traps
for SEV-ES is flawed, as KVM traps CR8 writes even when AVIC is enabled,
despite the fact that hardware updates the AVIC backing page as well.  But
KVM unconditionally inhibits AVIC for SEV-ES guests as current hardware
apparently can't support it (see c538dc792ff7 ("KVM: SVM: Do not activate
AVIC for SEV-enabled guest")).

However, KVM's overall handling of CR8 _is_ broken, as sync_cr8_to_lapic()
will clobber with stale information from the unencrypted VMCB.  That issue
will be fixed separately.

Reported-by: Srikanth Aithal <sraithal@amd.com>
Closes: https://lore.kernel.org/all/19935696-36cf-411b-af90-aabe6a98d7e7@amd.com
Fixes: e992bf67bcba ("KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated")
Cc: stable@vger.kernel.org
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 13a4a8949aba..f7ec7914e3c4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -226,7 +226,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
 	vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
 
-	svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
+	if (!sev_es_guest(svm->vcpu.kvm))
+		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	/*
 	 * If running nested and the guest uses its own MSR bitmap, there
-- 
2.53.0.473.g4a7958ca14-goog

