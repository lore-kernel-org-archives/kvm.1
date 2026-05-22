Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9843635B
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462952; cv=none; b=rP/8dj9Cd03i8xJRsHx1d8bmK2c7es0tueiu6+1tz1W8HVRWuBlDA+xgHWWId778ULlJWJec1kZ+p4Ld+BXIy8/QPou90MqJnxcDa65c3Pg3ZebIoxqoD14P4A11++G1dT9I++p0guLZEVZ8dM2PcSAYD2XW1nBDgDwg/l6BiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462952; c=relaxed/simple;
	bh=9g8EAfGvDG1p08Pmtu91DH9geQTr1Eg1+earq8LfPG4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OJz6CgE9bZChZ2Euah+XrgMsKtFk50HjC+VVE7OnE5ZfSJ/yJSzDLl7tYtCtTYLB74+/yEWS3tgWiyB47BImRrJ1+zEZxffyNAraRHgygvksfZ7qx/gBX7m4nWzmiRco2O0bUXp5ol3dTH78famcxeA4+qUj8Mr7Wm6srdfCOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfd+qkAP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfd+qkAP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba86e35aa1so121847825ad.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779462937; x=1780067737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8KQAP9mWp0ZRebZLa5bEvFOR8JqQ907ANUwCS1BhIk=;
        b=vfd+qkAPjFOttcXas/Ji9M35M4Rw8hcV5fTyPE3i/qz6Urtu59oiZWjVnliJDV8b8X
         nXc9ju8hf7FIeD4KxoV5671zCCTo2KNxg28Cmp4AowLYke7YszNsR6TOu0LU29I05LHu
         NSjtge7CzHic4JZstW7NiIi5zCq0R9rSyguhEBY1sHF3mhEiONnewRhq/IygjhEMo45+
         UqI62LjC+u9pJ3cidfHtOwJCng5tWfNVW3jIAdm2IrU+XE1LeLKh+9GOP76Pkzbyv+tT
         /XN9Xrdhft0Grt9ieG4VlRCvjwukUwPKDX1O1aJ7qZg6qvWELuu5Nlts4Y0ezfW/P1jP
         usZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779462937; x=1780067737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8KQAP9mWp0ZRebZLa5bEvFOR8JqQ907ANUwCS1BhIk=;
        b=RcTDDQ+Tfzp246ATUz5/YuO+ZUidMrJHh8drEWPEFqjF5QfT4gyavB1ebI4/yKvQcx
         uZgbADv0edPzfuah4yKFGm+HlwzZA67lv/LIWk51EbN+Gxfz9c3bbYxeStIyBdsM5PxK
         s4pq623QtQC+IvHue3DTuLmvwbm0wLcC4N4qgU371Ha02OsXn3NoNKJ4odpo26s56TZ5
         T9FwGH4e7nRQt5TAk/upQV6jwK2+icm85ilNjz/mMldufbm/wC87w/yvz202NiDN4+IJ
         yJjuE+HrMcxZPPB3XV/UK4aFXqO5rdq0w6Vz3mBHb6tVe26xQXTgFQvN+RaymjZQsSev
         zQdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9T2XXqp7Ws3U43LbHMODWzFdfxTu3CbjrUARPmeVPqsbRDIBqSpz6Dm00P9C5JtT8sh8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJz5braGSljTCJYlDyhT2rYVok5GeGgNO4BBCiR5jXO2LSGt0
	or2BbIRdsgPu9h4Xuh6NasV7KYIWaNu7/bSAROaX+MaM++HLsOv3z+bjz999ft8bm6Olb01frVd
	884+mlpOGiICwOd1Uabuwbg==
X-Received: from pleg14.prod.google.com ([2002:a17:902:e38e:b0:2b4:58ed:55d2])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70e:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2beb0347058mr43525335ad.6.1779462936728;
 Fri, 22 May 2026 08:15:36 -0700 (PDT)
Date: Fri, 22 May 2026 15:15:34 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522151534.652522-1-vannapurve@google.com>
Subject: [PATCH v5 1/1] KVM: x86: Introduce has_protected_pmu state for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, michael.roth@amd.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
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
v4 -> v5:
 - Allow userspace to disable PMU virtualization before creating any
   vcpus inline with existing ABI contract for KVM_CAP_PMU_CAPABILITY.

v4: https://lore.kernel.org/kvm/20260507212957.2629561-1-vannapurve@google.com/

 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 6 ++++++
 arch/x86/kvm/x86.c              | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

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
index 0a1b63c63d1a..733674ea0d2a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6909,6 +6909,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!enable_pmu || (cap->args[0] & ~KVM_CAP_PMU_VALID_MASK))
 			break;
 
+		if (kvm->arch.has_protected_pmu &&
+		    cap->args[0] != KVM_PMU_CAP_DISABLE)
+			break;
+
 		mutex_lock(&kvm->lock);
 		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
@@ -13375,7 +13379,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
 	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info = true;
-	kvm->arch.enable_pmu = enable_pmu;
+	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
-- 
2.54.0.746.g67dd491aae-goog

