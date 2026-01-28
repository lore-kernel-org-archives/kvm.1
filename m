Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02151344DA4
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642265; cv=none; b=A6sAeHj6aPf18DYklZO2xGox8wm+WCVXghUF3rUVi+iukOcgATTieXOH3F4LFn6tSfNyf8VhqlggQuyy2Geynmic6Osgm/wg4+Q3FefbdclWjVoUpDl4p/DlC5wu9CazZ1OXUEV4vrXLgv+dmIkbJe6pUdWw5qMJICkHxWTJ4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642265; c=relaxed/simple;
	bh=tFX4i3T29aS2SR3Yr9A5LhqF7R5HWjkcRb3UIujv1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qb9BaWaA1BynzZA7CEufDcG0uQOAFQoLtFjLPcXTCPCBAgHvI2FRdE708OWO/GvShINpJSKu/QprgSntzBjmLc6mOk9H6x3n1KoA37vDFUSgXinhMkioFmPq3Lx0R/wErkcGZ3V0tuVW1GwPVqCMrn82cBaYNFZIYBXe7OzB1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLCX7qTd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLCX7qTd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642263; x=1801178263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tFX4i3T29aS2SR3Yr9A5LhqF7R5HWjkcRb3UIujv1eE=;
  b=bLCX7qTdECGpkCeM6Rs/tGyOc6Vj2HVxrwlzZ0GlozvoHfE5k5TucMZI
   qSy8pqcZUWck+wWxww5jCOWdAY3G/j7ZDKZXlBmhncuRJnPBRnGmUMPKD
   3wMHInlsivS46aBE4eYSVx5Q9jdspNw8ZaVvjEsh5j0v9OWkXHphxGQ4v
   2PumDd34wxKOdYTa6dMHXPSC7w5lIIk4zTl96DAjANeRExYxw2oyD4zVy
   rCW1FwtmD0FF6PkV+wIr08Xwid9RnmI9kZthSHSZgq3ZfDyJchI42FoDX
   Qs2qnbbGmLA4qpVI/InXy29/2GTMEnASONrHKerOqGv9vegymiAxeAdKs
   A==;
X-CSE-ConnectionGUID: T0IqgxsiRXyxCNSg3f425Q==
X-CSE-MsgGUID: 5nQfq6t0RDKYSJPbsJobjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462338"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462338"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:41 -0800
X-CSE-ConnectionGUID: eFMJHCByREqk9Vkmu5E7eA==
X-CSE-MsgGUID: baSQ/vM4SuSE2jwU1xiMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208001782"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:41 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 08/11] target/i386: Clean up LBR format handling
Date: Wed, 28 Jan 2026 15:09:45 -0800
Message-ID: <20260128231003.268981-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the lbr-fmt property is masked with PERF_CAP_LBR_FMT in
DEFINE_PROP_UINT64_CHECKMASK(), there is no need to explicitly validate
user-requested lbr-fmt values.

The PMU feature is only supported when running under KVM, so initialize
cpu->lbr_fmt in kvm_cpu_instance_init().  Use -1 as the default lbr-fmt,
rather than initializing it with ~PERF_CAP_LBR_FMT, which is misleading
as it suggests a semantic relationship that does not exist.

Rename requested_lbr_fmt to a more generic guest_fmt.  When lbr-fmt is
not specified and cpu->migratable is false, the guest lbr_fmt value is
not user-requested.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- New patch.

 target/i386/cpu.c         | 18 ++++++------------
 target/i386/kvm/kvm-cpu.c |  2 ++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f2c83b4f259c..09180c718d58 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9788,7 +9788,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    unsigned requested_lbr_fmt;
+    unsigned guest_fmt;
 
     if (!kvm_enabled())
         cpu->enable_pmu = false;
@@ -9828,11 +9828,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
      * with user-provided setting.
      */
-    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
-        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
-            error_setg(errp, "invalid lbr-fmt");
-            return;
-        }
+    if (cpu->lbr_fmt != -1) {
         env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
         env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
     }
@@ -9841,9 +9837,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
      * 3)vPMU LBR format matches that of host setting.
      */
-    requested_lbr_fmt =
-        env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
-    if (requested_lbr_fmt && kvm_enabled()) {
+    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
+    if (guest_fmt) {
         uint64_t host_perf_cap =
             x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
         unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
@@ -9852,10 +9847,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
             return;
         }
-        if (requested_lbr_fmt != host_lbr_fmt) {
+        if (guest_fmt != host_lbr_fmt) {
             error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
                         "the host value (0x%x).",
-                        requested_lbr_fmt, host_lbr_fmt);
+                        guest_fmt, host_lbr_fmt);
             return;
         }
     }
@@ -10279,7 +10274,6 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
 
     object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
-    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
     object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
 
     if (xcc->model) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 33a8c26bc27c..b4500ab69f82 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -231,6 +231,8 @@ static void kvm_cpu_instance_init(CPUState *cs)
         kvm_cpu_max_instance_init(cpu);
     }
 
+    cpu->lbr_fmt = -1;
+
     kvm_cpu_xsave_init();
 }
 
-- 
2.52.0

