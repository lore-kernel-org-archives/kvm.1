Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71F3033DE
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229347; cv=none; b=FdAijkAhNnfY36TJvXWREX1DAJJCwT0sFhMYjIgipQyOUTMFWV2kM7wIncwHXWkKXkST0GPug5EoLjHxIEMbxGdaP3n6XMxm5IADFIVJa0U3cWyaq4QeBBS6pa496XPt9OKoD21v2dvWZMaWDmSvpirQgg+8tHehAfOgn3wEwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229347; c=relaxed/simple;
	bh=cE6vuGo9Qj/m7nI2WQ4MfKbqxo6/AEANgrmzqFQGJ7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PmUwLJVzgProuoOcTT33Dz+XnusBQAj5id2ydwgNiPmg7fqUPLUxbfoUF27Xxtih5qHD1go4ePaNWsq80zXfgfeT0xA5ClEh0o6KxgfYrMm1ne5bEq6VdCgyZaA5sH423WDcL8s78xXdDG/6O5qn9Np6qmxj7aibyf7t6SuMjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=b+AEmUK5; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="b+AEmUK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791229345; x=1822765345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X05L+cGOWHitc8iZGub1E+W5ABl0okO8X1iAwH89lXc=;
  b=b+AEmUK5nqK68XYYKBZO0Z9ltLH15fFlmnLDj7OhmIjx9Tk2w5j5QjmP
   BIvLf0JImgYSTC1rTg249nLTDU55DWGXdzg2Y+sA8CLeV78HoQTbOiTLO
   945I5kgfbmVLIfi2eadkn3CEjvnV8P8JQUKqrNDrkAolf1XyzAw2WPS9f
   cEC0GFqNPOjNsEVEU2uDbyXMyjGHkX+aCf96ZxokBLPWTyI6wAg/dVhhk
   /zb+ExCQvt6fV8ks6WmBx+1YxyuOC70ZSC9bgwEmKj5Oj1d7xZGH01QQ9
   xYXBlAe4076vRHTyix/A9bs0kw9bjrQxHriDUrrj40thDD9X27/+fkFUB
   g==;
X-CSE-ConnectionGUID: tnKiq6T9Rba+Td+1SEdyGA==
X-CSE-MsgGUID: kBikmnN3T4yySf42yRod3A==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="30336888"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:42:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:20514]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id 539ad01c-c153-41d9-9df7-1667452e5eeb; Mon, 5 Oct 2026 19:42:22 +0000 (UTC)
X-Farcaster-Flow-ID: 539ad01c-c153-41d9-9df7-1667452e5eeb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:42:22 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:42:20 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Marcelo Tosatti
	<mtosatti@redhat.com>, <kvm@vger.kernel.org>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, <nh-open-source@amazon.com>, <mushi.shar@gmail.com>
Subject: [PATCH] i386: Hyper-V partition time restore feature
Date: Mon, 5 Oct 2026 19:40:57 +0000
Message-ID: <20261005194057.10910-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A nested Hyper-V that sees the frequency MSRs lets L0 own the
partition reference time. After a resume from hibernation it issues
HvCallRestorePartitionTime with the TSC and the reference counter it
saved. Hyper-V offers hibernation to its root partition only when L0
advertises CPUID 0x40000004 EAX bit 20 (RestoreTimeOnResume).

Add 'hv-restore-time-on-resume' for the bit. It requires
'hv-frequencies'. KVM reports the bit in KVM_GET_SUPPORTED_HV_CPUID
when it handles the hypercall.

KVM side: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/

The TLFS marks the bit as reserved. The name comes from Microsoft's
hvdef crate.

Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
 docs/system/i386/hyperv.rst    | 9 +++++++++
 target/i386/cpu.c              | 2 ++
 target/i386/cpu.h              | 1 +
 target/i386/kvm/hyperv-proto.h | 1 +
 target/i386/kvm/kvm.c          | 8 ++++++++
 5 files changed, 21 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index e1babffb0f..2224dc2111 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -259,6 +259,15 @@ Existing enlightenments
 
   Recommended: ``hv-evmcs`` (Intel)
 
+``hv-restore-time-on-resume``
+  The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
+  enabled, Hyper-V lets L0 (KVM) own the partition reference time and issues
+  HvCallRestorePartitionTime after a resume from hibernation so that the TSC
+  and the reference counter continue from the values it saved. Hyper-V offers
+  hibernation to its root partition only when this enlightenment is present.
+
+  Requires: ``hv-frequencies``
+
 Supplementary features
 ----------------------
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3bc6911c1..9fa14f6fab 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10769,6 +10769,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_EXT, 0),
     DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-restore-time-on-resume", X86CPU, hyperv_features,
+                      HYPERV_FEAT_RESTORE_TIME_ON_RESUME, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd..dab559a3d8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1487,6 +1487,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_XMM_INPUT           18
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+#define HYPERV_FEAT_RESTORE_TIME_ON_RESUME 21
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..e420827a68 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -81,6 +81,7 @@
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
 #define HV_NO_NONARCH_CORESHARING           (1u << 18)
+#define HV_RESTORE_TIME_ON_RESUME           (1u << 20)
 
 /*
  * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a72b6e6b74..1b16af7cd4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1137,6 +1137,14 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_VAPIC)
     },
+    [HYPERV_FEAT_RESTORE_TIME_ON_RESUME] = {
+        .desc = "partition time restore (hv-restore-time-on-resume)",
+        .flags = {
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
+             .bits = HV_RESTORE_TIME_ON_RESUME}
+        },
+        .dependencies = BIT(HYPERV_FEAT_FREQUENCIES)
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
-- 
2.47.3

