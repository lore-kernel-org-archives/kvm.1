Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD0439F6E;
	Thu, 23 Jul 2026 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804020; cv=none; b=bfMH8rEbbIe1Fw5TE7oCaMdoaNv7XPlCRjsDRsjBZGkr3jg3nBEftlhI3U3kf45+HSdGEYVOz7WlysQM5XxLxiRP7bGC9jO1MRbxmvSJsAvTu8cfyc3h92xCwSxZ/X0LATvGRdo0/X+m/jGCcYqJspIdF6656i4WPg9KHW6iDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804020; c=relaxed/simple;
	bh=vJzQ7GKwTtr+b0ookNAGxunyYySDkMFDOGJJiC2ZfGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9gf+2bPF7w53L1CafHwKAx0M/PjP/6e8Tr9dk3lzh8GMfePj5SOCTun2Tnkgd2rFN6tvT02JjnDQoBeAouClxb7Is4ZNl8Q2CA61p5QEbNJD2nCIphV2WKHPutD0hM0LPVap5YYoRb9BkUZkdTYXBxtC9Ie6ViiT0VEVmALx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=LEYPMffZ; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="LEYPMffZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784804019; x=1816340019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MaoXwGo7f4P7szeSw5C8Wc8hpbKQPPnQlD4Vd1DZzkM=;
  b=LEYPMffZSuaZzNf0i21l/9y+tmeEV3qrhgepxloylhLFNFulhynUaG+R
   DajXQaMjrUjVm5z/215rrIm2ojBGwKQudNQcdKYPz+JhVoUo8nNCCD7GI
   r41OK7NOd/guvE9doJQLXsagBsZiiOm4HEdkgo8gbBgqQsePVx///6hmq
   ZkEWjw9JtJxQSWBWxPXQ9pgaABMNggBKVWIuyvqmRNSEQp0VQi2AYgxxE
   DmD7qzjZBkzAy860HyyKfgVTWxl4IxnIdemTLlOeDGNL4n5Agv83ih7fi
   JZkUH1RZukidhQ9i9aX2vNo0MXDWev9FApMh79fPlyD2W7ZGe+4ZK/P2b
   w==;
X-CSE-ConnectionGUID: FyI6F7EUTyW39zvRebV3lg==
X-CSE-MsgGUID: 1bSdZPXLQ7+qFy21MivF8A==
X-IronPort-AV: E=Sophos;i="6.25,180,1779148800"; 
   d="scan'208";a="24022123"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 10:53:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:10225]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 3f8a3acd-3529-42d3-b83c-91a8e4997de9; Thu, 23 Jul 2026 10:53:36 +0000 (UTC)
X-Farcaster-Flow-ID: 3f8a3acd-3529-42d3-b83c-91a8e4997de9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 10:53:35 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 10:53:34 +0000
From: Luka Absandze <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Graf <graf@amazon.com>, "David
 Woodhouse" <dwmw2@infradead.org>, Luka Absandze <absandze@amazon.de>
Subject: [PATCH v2] KVM: x86/pmu: Add module param to batch emulated-instruction reprograms
Date: Thu, 23 Jul 2026 10:53:09 +0000
Message-ID: <20260723105309.12145-1-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On a host with an emulated vPMU (guest PMU MSR accesses trap and each
guest counter is backed by a host perf_event), the per-emulated-
instruction PMU accounting added by commit 9cd803d496e7 ("KVM: x86:
Update vPMCs when retiring instructions") is pathologically expensive.

kvm_pmu_incr_counter() requests a counter reprogram (KVM_REQ_PMU) on
every emulated instruction that matches a programmed counter. The
reprogram is drained on the vCPU's next VM-entry, where
reprogram_counter() runs the full pmc_pause_counter() +
perf_event_period() + perf_event_enable() sequence: ctx->mutex, a
ctx_resched() of the PMU context, and a burst of serialized PMU-MSR
writes. Because the batched reprogram is serviced on the next VM-entry
regardless of which exit preceded it, ordinary exits -- notably the
guest's 1kHz timer tick -- absorb the cost, inflating timer interrupts
into the hundreds of microseconds and, under some workloads, escalating
to a guest CSD lockup.

Add emulated_counter_reprogram_tolerance, a module parameter bounding
how many emulated instructions may accumulate on a counter before KVM
forces a reprogram. 0 (default) preserves today's behavior of
reprogramming on every emulated instruction. A larger value batches the
reprograms.

Batching does not lose counts: pmc_read_counter() and
reprogram_counter() already fold pmc->emulated_counter into the value
observed on guest counter reads, so RDPMC/RDMSR remain accurate. The
only effect is that an overflow-driven PMI may be delivered up to
"tolerance" instructions late -- acceptable given the overflow PMI is
not cycle-accurate to begin with. The knob only affects the emulated
vPMU; a mediated vPMU increments its counter directly and is unchanged.

Suggested-by: David Woodhouse <dwmw2@infradead.org>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
v1 (RFC): https://lore.kernel.org/kvm/20260720192221.72912-1-absandze@amazon.de/

Changes since v1:
 - Drop the new KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING capability and its
   Documentation, i.e. add no new uAPI.
 - Instead of disabling emulated-instruction accounting outright, batch the
   counter reprograms behind a tolerance threshold, per David's suggestion
   to bound the reprogram rate rather than skip accounting [1]. This keeps
   guest counter reads accurate and only bounds how late an overflow PMI is
   delivered.
 - Expose the threshold as the emulated_counter_reprogram_tolerance module
   param (uint, 0644); 0 preserves current behavior.

[1] https://lore.kernel.org/kvm/f5552576fc749b4b453514f52921332cc104c6a6.camel@infradead.org/

Results (single run, not averaged over multiple runs):

Host: AMD EPYC 7R13 (Milan), emulated vPMU. Guest: 8 vCPUs under an
8-thread busy load, running a binary that toggles a PMU counter group
cross-vCPU once per second while an instructions-retired counter is
resident. Latency is the duration of the guest's local-APIC timer
interrupt handler (__sysvec_apic_timer_interrupt), measured in-guest with
ftrace function_graph over 30s (~160k ticks per pass). The module param
was changed live on one running guest between passes.

  tolerance      mean      p50      p99    p99.9      max
  ----------  --------  -------  -------  -------  --------
  0 (default)  148.973   11.080  464.200  469.569  919.690   (us)
  1000           3.194    2.950    7.251    9.831  470.100
  100000         2.974    2.940    3.869    4.400    8.060
  10000000       3.054    2.940    7.129    9.211  209.880

These are numbers from a single run and are meant only to show
the order of magnitude, not to be precise.

 arch/x86/kvm/pmu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dd1c57593f48..33a73271186a 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -39,6 +39,14 @@ bool __read_mostly enable_pmu = true;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_pmu);
 module_param(enable_pmu, bool, 0444);
 
+/*
+ * Number of KVM-emulated instructions that may accumulate on an emulated
+ * (perf-based) vPMU counter before KVM forces a counter reprogram to fold the
+ * emulated count into the backing perf_event
+ */
+static uint __read_mostly emulated_counter_reprogram_tolerance;
+module_param(emulated_counter_reprogram_tolerance, uint, 0644);
+
 /* Enable/disabled mediated PMU virtualization. */
 bool __read_mostly enable_mediated_pmu;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
@@ -1072,7 +1080,15 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 	 */
 	if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
 		pmc->emulated_counter++;
-		kvm_pmu_request_counter_reprogram(pmc);
+
+		/*
+		 * Batch reprograms: only force one once the accumulated
+		 * emulated count exceeds the tolerance. The count is still
+		 * reflected in guest counter reads via pmc->emulated_counter;
+		 * this only bounds how late an overflow-driven PMI arrives.
+		 */
+		if (pmc->emulated_counter > emulated_counter_reprogram_tolerance)
+			kvm_pmu_request_counter_reprogram(pmc);
 		return;
 	}
 

base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.47.3

