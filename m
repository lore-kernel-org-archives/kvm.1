Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A231AABC;
	Mon, 20 Jul 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575359; cv=none; b=TL1HXDTIN0wysY3SmDWzkbmy0mzO7avruABmHqawA1bHn+GhtJ0o307IRsEI4iWo9xlVJdDJFmXfmwVaTm4uA3oolhd//vR4qvCkwAOj2+YbCK035AImmMPeKQ4KSkpQ8KHSzwfL8zagflU7qYFBiG96w54xe0xc2uPoiEIW1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575359; c=relaxed/simple;
	bh=9A7FHFBR2K3ixxAl9r4pyafVyvaI2Pdzg1dpvZLAPLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8jvNU8TvQvoD22vBatXmaFxkZoZtxpQMwBIZt58f+TGTEKLoGwxIpk0hYpBHnLmqlwmDV4Efz+RG8QYZWFmeFtJuWvg8FBXWSisPSRHCYE0xyE5WiW96xldi8TVbfwx5phZ6arp6C989mUj0qArWhUVy+Ao/wuO68Omk22Zx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Mw15Hsab; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Mw15Hsab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784575358; x=1816111358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgUn5YOdx6Heb5TIqRhSwhMrk7BDvV8TgP29ZY9fNt0=;
  b=Mw15HsabkGRSmZPah7wlQuDQ5/Zh1tWwXsl45fNByUNKTQCZaJlni2cE
   CaM6OA3uuOY3LLPF0LHGEavo85Fx4paU4/E5JMC2ySGS6eK1JvKqJjpLZ
   OeaeZO3pNgnK6xqmm4iYT45GPzGwcXmzIgsKgtBYpufTE1nRsgkKP/12r
   BCCh+S376ksCARr9FKkaM8PaZPI2AVrLqb6xvI2tl2JqlC0U/STjJ6dUL
   Fn2LUN9oLj3UxDjCGByi9PIJGqznStfCHif/po6NP9LAISFVQ5HJt1IiT
   s9yb2aBNB3kH04rIQRreKUsEmZbYOjpKNH/zy0Voami9a5w66PCifxNR1
   A==;
X-CSE-ConnectionGUID: /+g1p2m2QFKAlSr72GbIYQ==
X-CSE-MsgGUID: 0gSBVYNgRcuyEraao86KzA==
X-IronPort-AV: E=Sophos;i="6.25,175,1779148800"; 
   d="scan'208";a="24032957"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 19:22:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:8645]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525] with esmtp (Farcaster)
 id 206a8b10-9bee-4d35-80cd-5a03b63c0a24; Mon, 20 Jul 2026 19:22:35 +0000 (UTC)
X-Farcaster-Flow-ID: 206a8b10-9bee-4d35-80cd-5a03b63c0a24
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 20 Jul 2026 19:22:35 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 20 Jul 2026
 19:22:33 +0000
From: Luka Absandze <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Alexander
 Graf" <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Luka Absandze
	<absandze@amazon.de>
Subject: [RFC PATCH 0/2] KVM: x86/pmu: Let userspace disable SW accounting of emulated instructions
Date: Mon, 20 Jul 2026 19:22:19 +0000
Message-ID: <20260720192221.72912-1-absandze@amazon.de>
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

On hosts that run guests with an *emulated* vPMU -- guest PMU MSR
accesses trap into KVM and each guest counter is backed by a host
perf_event -- the per-emulated-instruction PMU accounting added by commit
9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions") is
pathologically expensive.

Whenever a guest programs a counter for retired instructions (0xc0) or
retired branches (0xc2) -- routine for any profiler-style workload --
every instruction KVM emulates triggers a software increment plus a
batched KVM_REQ_PMU reprogram. The reprogram is drained on the next
VM-entry regardless of which exit preceded it, so ordinary exits (most
importantly the guest's 1kHz timer tick) absorb a full
reprogram_counter() cycle: ctx->mutex, ctx_resched(), and a burst of
serialized PMU-MSR writes. That inflates timer-interrupt handling into
the hundreds of microseconds and, under load, can escalate to a guest
CSD lockup.

This series adds KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING, a VM-scoped
capability that takes a bitmask of PERF_COUNT_HW_* event IDs and makes
KVM skip the software accounting of emulated instructions for those
events. It is opt-in and defaults off; the only cost to an opted-in
guest is that instructions-retired / branches-retired counters
undercount by the instructions KVM emulates in host context, i.e. the
behavior that predates that accounting. Hardware-executed guest
instructions are still counted by the backing perf_event and its
overflow/PMI path is untouched.

  Patch 1 adds the capability and the accounting short-circuit.
  Patch 2 documents it in Documentation/virt/kvm/api.rst.

Measured benefit
================

Host: AMD EPYC 7R13 "Milan", KVM, v7.2-rc4 + this series. Guest: QEMU,
-cpu host,pmu=on, 8 vCPUs. The guest workload keeps an instructions-
retired counter resident on every vCPU and periodically reprograms the
PMU, driving the accounting storm above, while the vCPUs are kept busy
so the 1kHz tick fires. The guest's local-APIC timer interrupt handler
(__sysvec_apic_timer_interrupt) is traced with ftrace function_graph
for 30s (~160k samples per run). The capability is toggled per-VM via
KVM_ENABLE_CAP; nothing else changes between runs.

  Timer-interrupt handler duration:

    metric   accounting ON (baseline)   accounting OFF (CAP)   speedup
    ------   ------------------------   --------------------   -------
    mean            209.8 us                   3.16 us           66x
    p50             256.4 us                   3.14 us           82x
    p99             463.3 us                   4.45 us          104x
    p99.9           915.2 us                   5.03 us          182x
    max             929.7 us                  22.55 us           41x

Some workloads genuinely need the extra precision that the emulated-
instruction accounting provides, and for them the default behavior is
the right trade-off. But for many others the accuracy gained is not
worth the cost it imposes on every exit, and this capability lets those
users opt out of paying it.

Luka Absandze (2):
  KVM: x86/pmu: Add CAP to disable SW accounting of emulated
    instructions
  KVM: Documentation: Document KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING

 Documentation/virt/kvm/api.rst  | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/pmu.c              |  6 ++++++
 arch/x86/kvm/pmu.h              |  9 +++++++++
 arch/x86/kvm/x86.c              | 10 ++++++++++
 include/uapi/linux/kvm.h        |  1 +
 6 files changed, 57 insertions(+)

-- 
2.47.3

