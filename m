Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183B1A256E
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114189; cv=none; b=AWNy4nICbU3hmVHAXN/a4VBciSXqYicWbSk8iwtEsuG9gbNtfL10qMeXUMnP+eNEEt0YLuV8Wp9bVYG7Uueq9Phn9ylmh8Zl3MCIYBPdyTVAblEUcxeF2wX5t7bG0nLfoPRgiH3G5AVEuoQ4gQKiYVESyLPAYPEE0773e5ZHL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114189; c=relaxed/simple;
	bh=Mg+OWu4To9gP4YDNSbdHOHMDvr+4y0G1KW2eN+mAZ7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVq7LEh2xhoz94nITWQIT+/F4jsgVx71GrznIsWEOqMK0PX8n86aZLlmXEfSmZcPVyM7g6SDvUj00ODgJClDVhvcKuRZ1k/CHX/u2VaZfcr/061ed1df+3AmpZCMpcj2KL+2P/h1PAVuvSl9G6kjVL6j7SxtgLfNevkXeqMKLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sC1wRbmG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sC1wRbmG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fec175so4323965ad.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778114188; x=1778718988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtFnsbFhhOhOusiCoeAQB82eTGbdASBkHtbXis4GHx4=;
        b=sC1wRbmGMjyyeYvZGnmJM1H4kid3UanYpZ10apemXqzPsv5uHYCivpQPaWJdlcy/qN
         +ZTzqzB4lYXgv6xLaT5fDf+0Ee8US/z53fk5mfImXAXRpJNctOkEQ19CeNYQ2TUlV3Zk
         hM8kr7z7xINslEQCHKez/i31MB9f/ylfG4y5Dr1wwlCQGYoL/t3/syIplNmiheL0pfbv
         a9AnAlbpWtvzglraGlvL+qxa6ZtGUwzoHSg5E4XzPoe5uDW29jq4KrUAh2VVtqB+JacN
         BIqHFo+FPhBXC/KCtH/wnKxGDHEIhVYYJ/Vs2uS8mpbIsi6xv71lrnBvaGcbotImfTyn
         gHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114188; x=1778718988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtFnsbFhhOhOusiCoeAQB82eTGbdASBkHtbXis4GHx4=;
        b=l6YVudh4v12SkwPPmGZI3fSRVcfeZp/0YZQURvsVFCWTGzXhGVPiyK6PqZ+wBDEzpp
         MvSmah1P4tJru5LeLap4tmFo/lqswSAZZxDFesNYN5Pp8gEq9Wif5UKjP25dE8yCCody
         U23SChHVkTSBE8lqotYeaqec9E1urj95XsyJZvnvaaFDPrwWpMX//r/68o7IlFS4pP5g
         pFXRKwGOzP3VtNKesWMFRQuINGRsRgg4eXKWmNdGrepxAl1E/fOu//6kpgzI87MbpMo3
         Ynvxgxm5Kcr2pH7dayldyaZfo9fdox3we4kkKwiboXsbeR5S7Kj5GfSGANXwm0MDiE14
         wsOA==
X-Forwarded-Encrypted: i=1; AFNElJ/mAMXKsei4FHMuEnkX3JWPxpqcZ42c7SjQyaEZsbF0EoIcHZrWdWGiIcVzvk9b4zNh/XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc64FhK5syzaar8G9mKjxf7yBPsghXTPa401zmFEkKPlNkw99N
	utYk6OJTdwltt2iDFX0WH2HoT9kjoR5qKNmFr6UDwc+LQFDbLJZ+BT/OdjZmBoMJ4GIyfbb3zez
	Nn7kn+9XKv5mcPQZgMDpwLg==
X-Received: from plbje14.prod.google.com ([2002:a17:903:264e:b0:2ba:316c:2d88])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:bc4c:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2ba79c22188mr38019025ad.21.1778114187534;
 Wed, 06 May 2026 17:36:27 -0700 (PDT)
Date: Thu,  7 May 2026 00:36:12 +0000
In-Reply-To: <20260507003613.1784851-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507003613.1784851-1-vannapurve@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507003613.1784851-2-vannapurve@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Introduce arch specific has_protected_pmu state
From: Vishal Annapurve <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

PMU state for TDX VMs is virtualized by TDX Module [1]. Introduce
has_protected_pmu state to track the pmu state for such scenarios. Disable
KVM's PMU virtualization framework if pmu state is protected as
additional enlightenment is needed within KVM to control/manage the
visibility of PMU state to such VMs.

Additionally disallow userspace VMM to toggle PMU state using
KVM_CAP_PMU_CAPABILITY if pmu state is protected.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..8371dcaaed1a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1422,6 +1422,7 @@ struct kvm_arch {
 	bool has_private_mem;
 	bool has_protected_state;
 	bool has_protected_eoi;
+	bool has_protected_pmu;
 	bool pre_fault_allowed;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..4836e206f64a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 
 		mutex_lock(&kvm->lock);
-		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
+		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu &&
+			!kvm->arch.has_protected_pmu) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
 			r = 0;
 		}
@@ -13375,7 +13376,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
 	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info = true;
-	kvm->arch.enable_pmu = enable_pmu;
+	if (kvm->arch.has_protected_pmu)
+		kvm->arch.enable_pmu = false;
+	else
+		kvm->arch.enable_pmu = enable_pmu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
-- 
2.54.0.563.g4f69b47b94-goog

