Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A237A821;
	Fri, 21 Aug 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351456; cv=none; b=XjPVMi+Le2x2+TlwrZg2EtnETB19eYhQfOXrxwqViTO2cm9gLMidNDrqyF6Kvwl4yru5l2rk27q87T8gBw6mLY2Pr8maJYTqiHTE0arwocLtoIw50lr6YWzQLha0miLQCgcirywlVpcuhlOVpayERAxGYRdqLX/SJhoUxO0c/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351456; c=relaxed/simple;
	bh=sIK5WOJyq73wJ97+I2to187trRDx9/2dwqiP/gH5EPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boaxSgedGXVe36arGvqB0HaFAk98+lQOgmmdUCxYMxDAKzdzAJ1NZriNZiEN3RQVnXFTUHfXuzpuoREUPkokIeNryNGMg1c6Xe95E6WqmMSk1XGeqUWAdgD0nZiUnWjuu7CMZ1fB3oeEmQ2n/ceaK4Y2yFWFU8GwIwctfXQ4XUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqD6R8OL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqD6R8OL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351452; x=1818887452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sIK5WOJyq73wJ97+I2to187trRDx9/2dwqiP/gH5EPc=;
  b=DqD6R8OLRKVWSQtcAioEV6RHvjw9w3yqJxMQI/3EIiPP4/4BthqRsG2j
   fLuuuu2v6EiwG4T28Kkd+XGrDOjTOIuqXYLhyZfpxlESCdt2bssnHdjJI
   yd0lQGSPuVVYBCN8DrPjpRJCZ0hofQAwCa4erNC3JSVb3arQhnS9kfbKf
   CcFyNIQkwZKBAOmJCQRv7DbZ4mNwSv3v4iZdnsswTPm0oK1a2ZFVUKn0M
   U4UHIck/n4JyWh0I3+SEflSiqFieA2HhzuwvcpWEqCixW5nZEhu+olcRn
   ngfb6PgsKfvU6VWplCxYPPQ7XvPxHlxwW7z7Jxo70tmeXj2Ltu84Pv4Xe
   Q==;
X-CSE-ConnectionGUID: 5Ol7jEAuT4K3PIgWNNHcbw==
X-CSE-MsgGUID: 9ijpyhA9Tqy8eU4doLds/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032600"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:47 -0700
X-CSE-ConnectionGUID: 03jGNTnESsGiadl0EQYD8Q==
X-CSE-MsgGUID: sFrO0dBJQ2GwX1rGotKQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679756"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:47 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 08/23] perf/x86: Export available PMU counters to sysfs
Date: Fri, 21 Aug 2026 15:19:47 -0700
Message-ID: <20260821222002.54907-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With PMU partitioning support, the set of PMU counters available to a
PMU can vary from the architectural maximum. While this information is
available through CPUID, it is not easily consumable from scripts.

Add two new sysfs ABI files, gp_counters and fixed_counters, under the
PMU caps group to export the available counters. The fixed_counters
file is omitted when the PMU does not support fixed-function counters.

  $ grep . /sys/devices/cpu/caps/*_counters
  /sys/devices/cpu/caps/fixed_counters:0-3
  /sys/devices/cpu/caps/gp_counters:0-7

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 .../sysfs-bus-event_source-devices-caps       |  5 +++
 arch/x86/events/core.c                        | 37 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
index a5f506f7d481..385ad7a23dd6 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
@@ -22,3 +22,8 @@ Description:
 		of PERF_SAMPLE_BRANCH_COUNTERS, while the "branch_counter_width"
 		exposes the width of each counter. Both of them can be used by
 		the perf tool to parse the logged counters in each branch.
+
+		The "gp_counters" and "fixed_counters" attributes expose the
+		available general-purpose and fixed-function PMU counters as
+		a range list, e.g. "0-7". The "fixed_counters" attribute is
+		omitted if the PMU does not support fixed-function counters.
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 76af9cfaf0ad..282170f7c1e1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2814,14 +2814,51 @@ static ssize_t max_precise_show(struct device *cdev,
 
 static DEVICE_ATTR_RO(max_precise);
 
+static ssize_t gp_counters_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%*pbl\n", INTEL_PMC_MAX_GENERIC,
+			  hybrid(pmu, cntr_mask));
+}
+
+static ssize_t fixed_counters_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%*pbl\n", INTEL_PMC_MAX_FIXED,
+			  hybrid(pmu, fixed_cntr_mask));
+}
+
+static DEVICE_ATTR_RO(gp_counters);
+static DEVICE_ATTR_RO(fixed_counters);
+
+static umode_t x86_pmu_caps_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (attr == &dev_attr_fixed_counters.attr &&
+	    !hybrid(pmu, fixed_cntr_mask64))
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *x86_pmu_caps_attrs[] = {
 	&dev_attr_max_precise.attr,
+	&dev_attr_gp_counters.attr,
+	&dev_attr_fixed_counters.attr,
 	NULL
 };
 
 static struct attribute_group x86_pmu_caps_group __ro_after_init = {
 	.name = "caps",
 	.attrs = x86_pmu_caps_attrs,
+	.is_visible = x86_pmu_caps_is_visible,
 };
 
 static const struct attribute_group *x86_pmu_attr_groups[] = {
-- 
2.55.0

