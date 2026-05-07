Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1793B9DBA
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163849; cv=none; b=WZZ0rUyIsesqmjbZUs3IrH8J/GEcvuizk0UzK6LzqqkWfAfhXoESW/Ac/snW9ARhBpHP6A4EgHl1yDTToqCSLF3E4Rj2jsrBFsrAn+1QDehT1HRLszlNK0J6oC+Zd4RXDdUs2R/EKVF7sWFjFoDttMowIvstP7q+f8fgD90hdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163849; c=relaxed/simple;
	bh=OxFHDaVSNTAne792Mz4V5XYZv2AJ1ijjDy4sqaH+Iec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cW1o1WwwdlQrZHdr1dsSU9E8aMYAFQQLGltU4pPDFx3csPji38+9/j9NE0ruA3UU5GFf6B9Y1zAgJ78ohGWG8cQIVYtTQZRQre2GvCghUbpNQ/GfmiYwTzFOmXFNyHUWv1XS7CXP9JRgE3amiE86/qQePNn9azE4/Y2trgVemV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foLjRw/4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foLjRw/4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c823549b1fcso1109144a12.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778163846; x=1778768646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mj8rEO/ebA0/lfuBQ4WOd6fm92ol9qu+Z0Tr+/bARRw=;
        b=foLjRw/46y9LDzZGss8jHZ08nplYjWtfz1cVN8qngtN7fbIreVlcF7O9OZqIGe8U/r
         stam7jrJ7M/xyD3yzx7pbdRSa+nElSNSAIuEVOZvHT9gWo00a4wIt7GbFWxP1ZHu0X6K
         Q5zPg0F/PHLVJPtWJ+wX1eflJ3F23KnmTOTkCCjKDP82ZKdTSEmNXDLHDSNmpUTPUuVP
         2bdDaPix9pNTBI7zibOPOFhZvSbk0F6JYluZP8Ru4xEkmmaq0sZYsTkpGBDu9a5eyCXh
         e4d0hF95zloKtVXZCH5Q4KpSOY2FNY204nWme0FZjBeAsLS4K5IT+4cHhoP8uiBWpfbo
         v/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163846; x=1778768646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mj8rEO/ebA0/lfuBQ4WOd6fm92ol9qu+Z0Tr+/bARRw=;
        b=P57Vj7LAKgGVmTCwHDvZBGM7I2BrnwwQq0F6ggCY9Z9T5pQCr2BErvY5/2dIxkDJoM
         MQ0p+VnMToe2r2Lov/XkZry3kxhEnyp+B0OfzXus7rHuSU7l+WrzWgp8lsmHwNq/tPOW
         trofk8JR/p5EDJUzj8sXU6tsfmTSs/RsN0dj7tdvaWbD+h3/CcAHPwq57+0jrP9tsBhi
         QX6VMGk8qtSkvedGcVcImQe13qs8SQ6NFyM2qRn3fEzPGErei46ceA4LvwSG9qL8oDhz
         Y3YycSQ6PDUnncGP89m5l9fNjXMZe9X0b7j4+Tok3Es3PlhcYoEm7/GvjQg/ncuFxWAY
         4Esg==
X-Forwarded-Encrypted: i=1; AFNElJ8omx7Ndmh5qma7ZtkcF/g3dzc9YV8ebV6I44Gq6qdQWCdUj7fwWTrWKgoy2SRGocXkL/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnBLIpNevyD5wx9vjgr0362IjvnPpwxqRO8ehYkQj9+i1C2q5
	PO/RA1r01foUsKVSzsYtwy9UUxbTyPPrtpUMHxRQe2tdGUvxvLtYzqZnrFGvT/enIEhfl8A2gXu
	lgkP+YnNoA18zrzgxBQxfkA==
X-Received: from pggi4.prod.google.com ([2002:a63:cd04:0:b0:c79:639f:7e23])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:244f:b0:39b:ce34:f7df with SMTP id adf61e73a8af0-3aa5a72e354mr9298497637.5.1778163845681;
 Thu, 07 May 2026 07:24:05 -0700 (PDT)
Date: Thu,  7 May 2026 14:24:02 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507142402.2175933-1-vannapurve@google.com>
Subject: [PATCH v3 1/1] KVM: x86: Introduce has_protected_pmu state for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

PMU state for TDX VMs is virtualized by TDX Module [1]. Host has following
toggles to control the PMU functionality exposed to TDX VMs:
1) Configure TD_PARAMS to allow guests to use performance monitoring.
2) Restrict the TD to a subset of the PEBS counters if supported.
3) Limit the TD to setup a certain perfmon events using basic/enhanced
   event filtering.

KVM will need to be enlightened to support these toggles. Introduce
has_protected_pmu state to track the pmu state for such scenarios
and explicitly set the has_protected_pmu flag for TDX VMs.

If pmu state is protected:
1) Disable KVM's PMU virtualization framework as additional
enlightenment is needed within KVM to control/manage the
visibility of PMU state to such VMs.
2) Disallow userspace VMM from toggling PMU virtualization state
using KVM_CAP_PMU_CAPABILITY.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>

---
v2 -> v3:
- Squashed two patches into a single patch as per feedback from Sean.
- Dropped the cover letter.

v2: https://lore.kernel.org/kvm/20260507003613.1784851-1-vannapurve@google.com/#t

 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 6 ++++++
 arch/x86/kvm/x86.c              | 8 ++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

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
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..eb4b4518e6f0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
 	kvm->arch.has_private_mem = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
+	/*
+	 * PMU support is provided by the TDX-Module (if enabled for the VM).
+	 * From KVM's perspective, the VM doesn't have a virtual PMU.
+	 */
+	kvm->arch.has_protected_pmu = true;
+
 	/*
 	 * Because guest TD is protected, VMM can't parse the instruction in TD.
 	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..99a383455d46 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 
 		mutex_lock(&kvm->lock);
-		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
+		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu &&
+		    !kvm->arch.has_protected_pmu) {
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

