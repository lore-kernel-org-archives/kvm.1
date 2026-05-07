Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308E3451A6
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189402; cv=none; b=ZFGk1CXm3FNsCuvCb/RaTMmSozQ5g2HuPoZ1qLTzT+/AUb7iu3Iuz8K1JXtiOk5gREG0hBXdE9cXXyQlFInzXtW2uCKBjyGWIfBeXInFcQxIYNNiVJh3Ckj0YA2af6KzsMy0Pi6q+Dwl8KNCiHRHVPrS7XghsUdmfD/4W9Dcgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189402; c=relaxed/simple;
	bh=M6TyNLdPCaCX98unTcfZyHhHGFrHlxx9VaXwbnBkCoU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KvXQYQiwsqt1ngGNfE9/EleMiCdQIi7rPXKKTYdM//svRmuZwlg/lzn0Bm/QfQeCaj0978tTIFAzkBUsUUW9Bu/a1xgkCyh4sYXzIgZe+BPt+Ne2W32Jyf7H+CIesyLuQXL4cQuHHQNSicHnF103X0WJilpnjT9bjr0rx9tB6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9+zuToB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9+zuToB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82437a0e6bso745436a12.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778189399; x=1778794199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVYfOIn/wYZ2EasvebTsT17mCH8x5s+4HIBAeXMtI/Q=;
        b=B9+zuToBg/s+oXv9rIgCcFselqu9wTHB2ieOTrtDyVC24N9IuOUXIUmD6RjL4Tdh3Y
         2pe8AAR/lR/ZtmXI+LEQyZgDSaFBr9cFv6fYIHKFEv4HXe6mMDp/sLznojXajWw+9Z6N
         Gf8YmqZKDB78zwkorkSeuTzXIY6FeHjRMaB0cIi2V5f1pnqPRoN0VMXHtJHTbgh+3hJe
         vG00RFPyD+7qPhhxiZQKVWl/BeJTCIsBElLk1V72qi28Q3SxPlJQaBZ3jhE6fQhiXpj1
         Z/5u0c8G3LkaD2rkLG1pnxuOujKEbXWHhDo0OUYcaFptt1MMKdK1HrrkmR+Zf4pk23Lx
         xchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189399; x=1778794199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVYfOIn/wYZ2EasvebTsT17mCH8x5s+4HIBAeXMtI/Q=;
        b=B4LsTEosJJUKxwV6ZZ6s42JUQSnWKZn+CUHesPLk9ITlX+9Qk6D3dcaQptgHN3YrgX
         H6WYVhUvR51nAE591TYFF37i4JEFVHAEdZbbcAa5BmlhQQWvHp2BJ/2BmCLpscH8UVnK
         PYfk00Sgn4OpNdpGoe5XGx2Vmn9aYuP8hA+rjqcazQO7N3kmsyZReR/HWa3nQfVXAwtJ
         kDWV/NMAwYOx5B/QGgnhZTkAaf3qDDDEOHFc/Jh3yko3JMSD0aSO1y/AUHHbgVpZ7SXT
         TiIGM9swLBpwMiTctSvtZBz12YIq/uH9YoUufvIzfeRlNyJ+YdZ0dlRVbfNtKKd8udJ1
         Yv5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9AuGXpKwx0+J5kwWw2lshBPG9E9saVoyNNi3CdwYHjz6v6LA8teKFtwx7XnCKsmbujSbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPwc2whL+K3YAZnJ17AX7/kPhalTlgVlFsxO/RQ5apfeu1p/L
	JZiAAOJqvI+v3/xC+uFE0PkAALhaNmbkSjHFvUn/yAgF6OTOpU3wZ+DieEs16VuAUX59HwmIQEy
	0MSArR2sWS696i1MK3O8oLw==
X-Received: from pge13.prod.google.com ([2002:a05:6a02:2d0d:b0:c76:6cef:34e7])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7348:b0:398:b178:a53f with SMTP id adf61e73a8af0-3aa5aa79935mr10791548637.40.1778189399312;
 Thu, 07 May 2026 14:29:59 -0700 (PDT)
Date: Thu,  7 May 2026 21:29:57 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507212957.2629561-1-vannapurve@google.com>
Subject: [PATCH v4 1/1] KVM: x86: Introduce has_protected_pmu state for TDX VMs
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
2) Disallow userspace VMM from enabling PMU virtualization state
using KVM_CAP_PMU_CAPABILITY.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
v3 -> v4:
 - Allow userspace to disable pmu virtualization even if
   has_protected_pmu is set.
 - Addressed feedback around enable_pmu initialization in
   kvm_arch_init_vm().

v3: https://lore.kernel.org/kvm/20260507142402.2175933-1-vannapurve@google.com/

 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 6 ++++++
 arch/x86/kvm/x86.c              | 9 ++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

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
index 0a1b63c63d1a..c248abb0e2ab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6909,6 +6909,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MASK))
 			break;
 
+		if (kvm->arch.has_protected_pmu) {
+			WARN_ON_ONCE(kvm->arch.enable_pmu);
+			if (cap->args[0] == KVM_PMU_CAP_DISABLE)
+				r = 0;
+			break;
+		}
+
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
@@ -13375,7 +13382,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
 	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info = true;
-	kvm->arch.enable_pmu = enable_pmu;
+	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
-- 
2.54.0.563.g4f69b47b94-goog

