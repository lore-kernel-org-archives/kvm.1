Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD513A0E8B
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381833; cv=none; b=bXiw2LHRhzT82MAZHBUMe6jL89hXbGBBf9xqZ7r+773VWWhIKtNu4KSnStbgsoNxhuavidMgTrRxntZo6sGPlT2K3ZTAomeN/kknIU1yNizSgOon2YY/WJF7BYr1QSCN+I35klp5lL3LwM99gP+kzYAmbzBGXbNPv4kuDif6f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381833; c=relaxed/simple;
	bh=jxXG1p7zC04tYFTfJPIVEx/ypGFjINDEhD2100oJ18Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kdeTAtlQkOHbGIZVo4vtd24GHmzUplS0B2WEb2ycv51fw3xxROzDnP89bGuHZ789iRIkrIGcSMlh/qdrn0EnmyDaWymJVY9RxKiiFrztVg4u7bQJWr3+XveJl3k+HBVVP2XFZFFO/5fDczcJboyq76B1riWY0MSYaAuq74f3oOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPZZeUYm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPZZeUYm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so803853b3a.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381824; x=1776986624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=s+DOdHTafr7BremJNOxlZjtkuJmIgjyz+aBnTy0imDs=;
        b=WPZZeUYmijAkwbcPlONBw1k/LKWRN19AOzfF8GccNlF7N/Bj7J5Cl1lcQF9rOGIEIQ
         uzaGX2IKoVO7n7J6/SmRsBmC0ONyHoHV+TuyQfQ8p6jKyWlaZy2zX1n0lQjqTXshVb1E
         RyIzA6GjmhdcDvDoYv7QEcRXQQr75eL8vpmMuibks0sMDxBOdSLbDdLWCKr1LXIS+xBw
         zhXsZNgZ3VzqBHzINNzNYtKlCsGX7lgpOgzkhqPDGoFPVJRXQFLNnYOEQUxlFkZ/UTcZ
         0Fua9LEviVwmgW0w/y01L9nu6DBr1kzNysGm72DOVmPVaRco934eXStFmc6IZbt4+4Sh
         zehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381824; x=1776986624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+DOdHTafr7BremJNOxlZjtkuJmIgjyz+aBnTy0imDs=;
        b=dg4KmFoLMTVNd3gX1xnD1KbJP8cxz5wDlVCp98n0mzlCYvKWGi10OIKRsGt8l4BaT0
         VkaYxDjCTpSCUdUFj4GrT8uJ+KdCWXXWR4Gvewbtp60G6Xwh46urWjrGbamBynoWmEHX
         1ull4ZTAkZnLCgVKBz2J+rfV473r/CY05nrPyLgwxlYqznklgUhqaDriyVSHDLb9FRs9
         yqRRAA3aeUOetAMbzZumiiZWl2MPbk05gT6dju7rwgtyDrV4qhVqWbfgnSMsMkCnRs4y
         P6MpUu61+FYABB/OJBPsT0mPlloEe9kJs2YKnFjKD0tmy4VY/HSrpAIXIFDIsUBYdzzo
         d/QQ==
X-Gm-Message-State: AOJu0YwkHf7oc5v6VZHQtYhC1aA6uSBeCmUDW75yENrmGiXZTXCD4jpH
	sSss5wnImtwPHG50XMRjKV0G9WmnZKW2QFeswJuN1OfA2iu8FpysLl+7HlrnjhW149l5gtmjGe7
	kzZPHBQ==
X-Received: from pfaz1.prod.google.com ([2002:aa7:91c1:0:b0:82f:2efd:4159])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9389:b0:398:7daf:6d7e
 with SMTP id adf61e73a8af0-3a08ca74edbmr302078637.17.1776381823334; Thu, 16
 Apr 2026 16:23:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:23:25 -0700
In-Reply-To: <20260416232329.3408497-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416232329.3408497-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416232329.3408497-4-seanjc@google.com>
Subject: [PATCH v3 3/7] KVM: SEV: Set supported SEV+ VM types during sev_hardware_setup()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set the supported SEV+ VM types during sev_hardware_setup() instead of
waiting until sev_set_cpu_caps().  This will using the set of *fully*
supported VM types to print the enabled/unusable/disabled messaged.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..ea4ce371d5f3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3013,18 +3013,14 @@ void sev_vm_destroy(struct kvm *kvm)
 
 void __init sev_set_cpu_caps(void)
 {
-	if (sev_enabled) {
+	if (sev_enabled)
 		kvm_cpu_cap_set(X86_FEATURE_SEV);
-		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
-	}
-	if (sev_es_enabled) {
+
+	if (sev_es_enabled)
 		kvm_cpu_cap_set(X86_FEATURE_SEV_ES);
-		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
-	}
-	if (sev_snp_enabled) {
+
+	if (sev_snp_enabled)
 		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP);
-		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
-	}
 }
 
 static bool is_sev_snp_initialized(void)
@@ -3194,6 +3190,13 @@ void __init sev_hardware_setup(void)
 		}
 	}
 
+	if (sev_supported)
+		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
+	if (sev_es_supported)
+		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
+	if (sev_snp_supported)
+		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
+
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
 			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

