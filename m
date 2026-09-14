Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FE48035F
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396630; cv=none; b=M/d+iLWVp9xn76LNv6LTNYC5d+Otr8fH4R2sra/P6Vdfz7DvyD34iwGYHFCUDZEi7ZYJN0VjXpIFe9AhtlUIgKXGaHtc4G1fwPpl+1MBy1qhnKxvq27smatZnCytpdVrvZuHaRa1HX/zkgEKAgsQq0r7pGjaC0CSxWBTFABOPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396630; c=relaxed/simple;
	bh=y7SAg8QZDph5pEHRtiQuQJaS0nQLmEWANAnP5dns2+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=leAK+rNQ8V8t8j3cM1FUlfN4ZAKTfWcmgBXmIftY9rmeuQ7NbDdB8F+uJ5A/FIFXzXpEEkNtS23hSLfJerb4PukDvctGRvHY0WNy+KtM0dhfegU96jogWRKgMndxFWBs8xK1P5dzoBFFis9dxNuBC966KBSFA2lX9VQaZoPBAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiFoAQ8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiFoAQ8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789396627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tyEM0wAZLk2nDaOpdE4k3vnfO8I2SVdsuSadoby1hAw=;
	b=PiFoAQ8ynuXETjWj+A7TyVZD6DC4X/YJvRI7MxcrKNCF7K0bXac/hLc71n934HZZ4e/jAP
	8tXHI+IqlznOMIfL9ceGvw48csb4pzjeJ4tgdcuWS2aZX9bu64T+NStPcABTms8/2Oh45+
	xPukPd9Qyt6h1LaQspWWLVw7OfnBzp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-sHr_iKrlPD-v9UyfmYmgJw-1; Mon,
 14 Sep 2026 10:37:05 -0400
X-MC-Unique: sHr_iKrlPD-v9UyfmYmgJw-1
X-Mimecast-MFC-AGG-ID: sHr_iKrlPD-v9UyfmYmgJw_1789396625
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE8A11955D98;
	Mon, 14 Sep 2026 14:37:04 +0000 (UTC)
Received: from aharivel-thinkpadp1gen3.rmtfr.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 787E218004D2;
	Mon, 14 Sep 2026 14:37:03 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	linux-kernel@vger.kernel.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH RFC v3 0/3] KVM: x86: per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)
Date: Mon, 14 Sep 2026 16:36:59 +0200
Message-ID: <20260914143702.915401-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is v3 of the RFC for KVM_CAP_CSTATE_POLICY, a new VM-scoped
capability that lets userspace set a maximum C-state ceiling per VM.

Changes since v2 (RFC, design questions only):
  - Implemented Option A from v2 design discussion: temporarily toggle
    cpuidle states_usage[].disable on the pinned pCPU before/after
    kvm_vcpu_block(). Uses CPUIDLE_STATE_DISABLED_BY_DRIVER flag.
  - Added KVM selftest (7 tests, all passing on bare metal).
  - Added QEMU prototype (not in this series -- separate tree).
  - Answered design questions from v2 based on implementation experience.

Changes since v1:
  - Corrected internal flow: enforcement goes through kvm_vcpu_halt() +
    cpuidle constraint, not inline MWAIT execution.
  - Expanded design questions with concrete enforcement options.

== Problem ==

Cloud operators running NFV workloads want to reduce energy consumption
by disabling halt-polling (halt_poll_ns=0). This lets vCPUs enter real
idle states instead of busy-looping, saving power.

However, disabling halt-polling is system-wide and ALL VMs on the host
lose halt-polling. The kernel cpuidle governor then picks deep C-states
(C6, ~133us wakeup) by default, which hurts latency-sensitive VMs.

There is no per-VM mechanism to say: "save power on batch VMs, but keep
wakeup latency low on this latency-sensitive VM."

Existing knobs are all system-wide or not VM-aware:
  - intel_idle.max_cstate: system-wide kernel parameter
  - /sys/devices/system/cpu/cpuN/cpuidle/stateN/disable: per-CPU, not VM-aware
  - halt_poll_ns: system-wide, all or nothing

== Solution ==

KVM_CAP_CSTATE_POLICY: a VM-scoped ioctl (same pattern as
KVM_CAP_HALT_POLL) that constrains cpuidle state selection when
vCPUs halt.

  args[0] = max_cstate:
    -1 = disabled (default, no constraint)
     0 = force C0 (HLT returns immediately, no idle)
     1 = cap at C1 (~2us wakeup)
     6 = cap at C6 (effectively unrestricted)

When a vCPU enters kvm_vcpu_block(), KVM disables cpuidle states
deeper than max_cstate on the current pCPU (preempt-disabled), then
restores after wakeup. The capability is re-callable at runtime --
policy changes take effect on the next vCPU HLT without VM restart.

== Test results ==

Tested on Dell R640 (Intel Xeon Gold 5118, intel_idle driver with
POLL/C1/C1E/C6 states).

KVM selftest (7/7 pass):

  ok 1 cap_supported
  ok 2 valid_policies
  ok 3 invalid_policies
  ok 4 policy_change
  ok 5 cpuidle_no_policy
  ok 6 cpuidle_enforcement
  ok 7 policy_c0_no_idle

Selftest cpuidle counters (1000 guest HLTs per test):

                  No policy     Policy=C1     Policy=C0
  POLL usage:     +0            +0            +56,743
  C1 usage:       +3            +1,073        +0
  C1E usage:      +70           +0            +0
  C6 usage:       +1,003        +0            +0

Multi-VM demo (2 VMs, 60s, same host, turbostat):

                  VM-A (policy=C1)    VM-B (no policy)
  C1 residency:   98-99%              0%
  C6 residency:   0%                  54-99%

The enforcement is clear: VM-A stays in C1 while VM-B on the same
host goes deep into C6.

== Design decisions (answers to v2 questions) ==

(a) Enforcement mechanism: Option A (toggle states_usage[].disable)
    works correctly for pinned-core NFV configurations. The disable
    flags are set/cleared with preemption disabled, so no migration
    race. A WARN_ON_ONCE guards against unexpected CPU changes.

(b) VMCS toggling: not needed for v1 -- enforcement works within the
    existing HLT exit path. MWAIT interception is a separate concern
    for a future series if cpu-pm=on integration is desired.

(c) MWAIT hint mapping: not needed for v1 -- the policy operates on
    cpuidle state indices, which the intel_idle driver maps to
    hardware C-states. This is the same abstraction sysfs uses.

(d) halt_poll_ns interaction: orthogonal as expected. halt_poll_ns
    controls spin duration before idle; max_cstate controls idle
    depth after polling. Both knobs work together.

(e) Per-vCPU vs per-VM: starting with per-VM. Per-vCPU can be added
    later as a separate capability if needed.

== Scope ==

This v3 is scoped to pinned-core configurations (NFV, DPDK). A
per-task cpuidle constraint (Option C from v2) would cover all cases
including overcommit, but requires cpuidle subsystem changes. Happy
to pursue that if maintainers prefer, but Option A covers the
immediate customer need.

== QEMU prototype (separate tree) ==

A working QEMU patch adds -accel kvm,cstate-policy=N. Available at:
  https://github.com/aharivel/qemu/tree/kvm-cstate-policy

== Series ==

  [1/3] cpuidle: export cpuidle_devices for KVM module access
  [2/3] KVM: x86: add KVM_CAP_CSTATE_POLICY capability
  [3/3] KVM: selftests: add cstate_policy_test

Anthony Harivel (3):
  cpuidle: export cpuidle_devices for KVM C-state policy enforcement
  KVM: x86: add KVM_CAP_CSTATE_POLICY for per-VM C-state enforcement
  KVM: selftests: add cstate_policy_test for KVM_CAP_CSTATE_POLICY

 drivers/cpuidle/cpuidle.c                     |   1 +
 include/linux/kvm_host.h                      |   2 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/cstate_policy_test.c    | 517 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 101 ++++
 6 files changed, 623 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/cstate_policy_test.c

-- 
2.55.0

