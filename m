Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35E472768
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119374; cv=none; b=s4kNbcdeGSD/zWCTuhXc8aOOMpuKqOFPDhW7wIGOtUyafXOjb4eUihQL/hoiGxTBoUVuFSMsvQn9TB+N6gWQmh7nYdaXEu0AVecKf3WXlOvXERp6QIKdcjy145N0FA7V81kI+Xj/d963+L8HyDK4KAbSYLO3jhZp7MAyKpQO2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119374; c=relaxed/simple;
	bh=cxPUQ8mqLOh08M7lDpLo2whW8TN+9q/SMBxitB7xFV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UiQ9I1GXi2899j51W5ibgS66/z9N/q7X5MpDftUNU3MNQrsPY/o1/S5DAAB0jGDVzGywzR0xM4iTR4u9NQiENrH6JpKl/p6UwO4+mw7NG+0LTXps9nnMnhYBCZiEXdH7BBUctCy/TIB1/350TFzIXSmZC76t8Sy7+Q2DIQsJZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7RWZ+uI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7RWZ+uI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784119367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sFxZTrGt2w+HcUGuHyexRURbS0eVpPFhL4MEch1ympQ=;
	b=L7RWZ+uI29/iPa2aHL9UKzPUVwKqfn9posBA4bDro/GF6x+2vNSWiQBxbpgi8lDunaqsMV
	/TFkqQfHMnl5OQKRpBngRmEP7EREBbfmpc02ImHxLSIUdwUWg/jqZWa97joCAyWnw0tcKb
	j6ru3425C9HC40gHJF5nNnYVpJXQMgY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-to0OTG11NV2iou5ucZk3uw-1; Wed,
 15 Jul 2026 08:42:46 -0400
X-MC-Unique: to0OTG11NV2iou5ucZk3uw-1
X-Mimecast-MFC-AGG-ID: to0OTG11NV2iou5ucZk3uw_1784119365
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2228C1955F07;
	Wed, 15 Jul 2026 12:42:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABC8030001B9;
	Wed, 15 Jul 2026 12:42:43 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	aharivel@redhat.com
Subject: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)
Date: Wed, 15 Jul 2026 14:42:11 +0200
Message-ID: <20260715124235.1444895-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

KVM currently provides two mutually exclusive modes for guest idle
management: full interception (cpu-pm=off, host controls C-states but
pays VM exit overhead) or full delegation (cpu-pm=on, guest MWAIT
executes directly with zero overhead but host loses all control).

There is no middle ground. With cpu-pm=on, the host cannot override
guest C-state decisions - not via cpuidle sysfs, not via MSR 0xE2
(BIOS-locked), and not via any KVM interface.

This RFC proposes KVM_CAP_CSTATE_POLICY, a new VM-scoped capability
that lets the host set a per-VM maximum C-state ceiling. When active,
KVM intercepts MWAIT, inspects the requested C-state, and enforces
the ceiling before executing the idle instruction on behalf of the
guest.

The capability follows the KVM_CAP_HALT_POLL pattern: a per-VM ioctl,
changeable at runtime without VM restart.

Semantics:
  args[0] = max_cstate
    -1 = unrestricted (current cpu-pm=on, no interception)
     0 = force C0 (no idle)
     1 = cap at C1 (kill switch for deep C-states)
     6 = cap at C6 (monitor but don't restrict)

Measured VM exit overhead on Haswell-EP (ftrace, x86-tsc clock):
  Median: 867 ns (0.87 us)
  p99:    3,740 ns (3.74 us)

Relative to C-state exit latencies this is negligible: +0.65% for C6
(133 us exit latency), +2.6% for C3 (33 us).

Use case: NFV deployments where the VNF vendor owns C-state selection
via guest cpuidle, but the cloud operator needs a host-side kill
switch to cap deep C-states per-VM for debugging or SLA enforcement,
without guest cooperation.

Design questions in rfc/KVM_CAP_CSTATE_POLICY.txt:
  (a) VMCS "MWAIT exiting" runtime toggle pattern
  (b) MWAIT hint to logical C-state mapping across CPU families
  (c) HLT handling (no C-state hint in instruction)
  (d) Interaction with halt_poll_ns
  (e) Per-vCPU vs per-VM granularity

I am looking for feedback on the overall approach. If there is
consensus that this capability belongs in KVM, I am willing to
implement the full stack - starting with the KVM ioctl, followed
by QEMU and libvirt integration.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 rfc/KVM_CAP_CSTATE_POLICY.txt | 179 ++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 rfc/KVM_CAP_CSTATE_POLICY.txt

diff --git a/rfc/KVM_CAP_CSTATE_POLICY.txt b/rfc/KVM_CAP_CSTATE_POLICY.txt
new file mode 100644
index 000000000000..15439e6e7ebb
--- /dev/null
+++ b/rfc/KVM_CAP_CSTATE_POLICY.txt
@@ -0,0 +1,179 @@
+KVM: x86: Proposal for per-VM C-state policy enforcement
+========================================================
+
+1. Problem statement
+--------------------
+
+KVM currently offers two mutually exclusive modes for guest idle
+management on x86:
+
+  (a) Default (cpu-pm=off): guest HLT/MWAIT causes a VM exit. KVM
+      intercepts and decides the C-state via the host cpuidle governor.
+      The host has full control but pays exit overhead on every idle.
+
+  (b) Delegated (cpu-pm=on, QEMU -overcommit cpu-pm=on): guest MWAIT
+      executes directly on hardware via VMCS secondary execution control
+      "MWAIT exiting" = 0. Zero VM exit overhead, but the host has no
+      visibility or control over which C-states the guest enters.
+
+There is no middle ground. With delegation active, the host cannot cap
+the deepest C-state a guest may enter — not via host cpuidle sysfs, not
+via MSR 0xE2 (PKG_CST_CONFIG_CONTROL, typically BIOS-locked), and not
+via any KVM interface.
+
+This creates an operational gap for NFV and latency-sensitive cloud
+deployments where:
+
+  - The guest (VNF) should own C-state selection because it knows its
+    own latency requirements.
+  - The host operator needs a "kill switch" to cap deep C-states per-VM
+    for debugging or SLA enforcement, without VM restart and without
+    requiring guest cooperation (SSH/agent may be unavailable).
+
+2. Proposed capability: KVM_CAP_CSTATE_POLICY
+----------------------------------------------
+
+A new KVM VM-scoped capability that lets the host set a maximum C-state
+ceiling per VM. When a policy is active, KVM intercepts MWAIT/HLT,
+inspects the requested C-state, and enforces the ceiling before
+executing the idle instruction on behalf of the guest.
+
+  KVM_CAP_CSTATE_POLICY
+    Architecture: x86
+    Target:       VM (struct kvm)
+    Parameters:
+      args[0] = max_cstate (-1 to 6)
+      args[1] = flags (reserved, must be 0)
+
+  Semantics:
+    max_cstate = -1  No interception; current cpu-pm=on behavior.
+                     MWAIT executes directly (VMCS "MWAIT exiting" = 0).
+    max_cstate = 0   Force C0. Guest halts return immediately (no idle).
+    max_cstate = 1   Cap at C1. Guest requests for C3/C6 are downgraded.
+    max_cstate = 6   Cap at C6 (effectively unrestricted on most
+                     platforms, but interception is active for
+                     monitoring).
+
+The capability follows the same pattern as KVM_CAP_HALT_POLL: a per-VM
+ioctl that overrides system-wide behavior for a specific VM, changeable
+at runtime without VM restart.
+
+3. Internal flow
+----------------
+
+When max_cstate >= 0 (policy active):
+
+  1. VMCS "MWAIT exiting" = 1 (intercept MWAIT).
+  2. On VM exit for MWAIT:
+     a. Extract the C-state hint from the MWAIT operand.
+     b. Map the hint to a logical C-state level (MWAIT sub-states
+        are CPU-family-specific; a translation table is needed).
+     c. If requested_cstate <= max_cstate: execute native MWAIT with
+        the guest's original hint.
+     d. If requested_cstate > max_cstate: execute MWAIT with the
+        capped hint, or return to guest immediately (C0).
+  3. For HLT exits: KVM selects a C-state up to max_cstate via the
+     host cpuidle governor (existing behavior, but now capped).
+
+When max_cstate = -1 (unrestricted):
+
+  1. VMCS "MWAIT exiting" = 0 (direct execution, no VM exit).
+  2. Equivalent to current cpu-pm=on behavior.
+
+Transitioning between -1 and >= 0 requires toggling the VMCS secondary
+execution control at runtime. This is the same mechanism used for other
+VMCS control toggles and is well-precedented in KVM.
+
+4. Measured VM exit overhead
+----------------------------
+
+We benchmarked the exit-entry round-trip cost on Intel Xeon E5-2630 v3
+(Haswell-EP, 2x8C/16T) using ftrace with x86-tsc clock (nanosecond
+precision). MSR_WRITE exits were used as a proxy for pure exit mechanism
+cost — fast synchronous round-trips with no scheduling or blocking.
+
+  Samples:  154
+  Min:      433 ns
+  Median:   867 ns  (0.87 us)
+  Mean:     1,523 ns (1.52 us)
+  p95:      3,037 ns (3.04 us)
+  p99:      3,740 ns (3.74 us)
+  Max:      13,963 ns (13.96 us)
+
+Relative to C-state exit latencies:
+
+  C-state   Exit latency   VM exit adds   Relative overhead
+  C1E       10 us          +0.87 us       +8.7%
+  C3        33 us          +0.87 us       +2.6%
+  C6        133 us         +0.87 us       +0.65%
+
+The interception overhead is sub-microsecond at median and negligible
+relative to the C-state transitions it governs. For the deepest C-states
+where power savings matter most (C3/C6), the overhead is under 3%.
+
+5. Design questions for discussion
+-----------------------------------
+
+(a) VMCS control toggling: switching "MWAIT exiting" at runtime when
+    the policy changes between -1 and >= 0. This requires a VMCS
+    update on each vCPU. Safe to do via kvm_vcpu_kick() + request
+    flag, or is there a better pattern?
+
+(b) MWAIT hint to C-state mapping: MWAIT sub-states (EAX[7:4] for
+    C-state, EAX[3:0] for sub-state) vary across CPU families. Should
+    KVM maintain a per-model translation table, or should the policy
+    operate on raw MWAIT hints directly?
+
+(c) HLT handling: when a guest uses HLT (no C-state hint), KVM
+    currently enters kvm_vcpu_halt() which may poll (halt_poll_ns)
+    then block. With a max_cstate policy, should KVM cap the C-state
+    the host cpuidle governor selects for the blocked vCPU thread?
+    This would require hooking into cpuidle or using
+    MONITOR/MWAIT-based idle with a capped hint instead of schedule().
+
+(d) Interaction with halt_poll_ns: when policy is active (max_cstate
+    >= 0), interception is on, so halt polling applies again. The two
+    knobs become orthogonal:
+      halt_poll_ns = spin duration before any C-state
+      max_cstate   = deepest C-state after polling fails
+    Is this the right interaction model?
+
+(e) Per-vCPU vs per-VM: starting with per-VM is simpler. Per-vCPU
+    would allow mixed policies (dataplane vCPUs in C0, control-plane
+    vCPUs in C6). Worth the complexity for v1?
+
+6. Userspace integration path
+-----------------------------
+
+  Kernel:   KVM ioctl (this proposal)
+  QEMU:     New -overcommit sub-option: cpu-pm-max-cstate=N
+  libvirt:  New XML element in <features><kvm>
+
+Runtime changes via the ioctl would allow virsh/QEMU monitor commands
+to adjust the policy on a live VM without restart.
+
+7. Prior art
+------------
+
+  - KVM_CAP_HALT_POLL: per-VM halt polling override. Same design
+    pattern — VM capability, ioctl, per-VM value. Merged in 2020.
+
+  - Xen ACPI idle driver: Xen has per-domain C-state policy via its
+    ACPI integration. KVM has no equivalent.
+
+  - Host kernel max_cstate: the kernel parameter
+    intel_idle.max_cstate= caps C-states system-wide, but has no
+    per-VM or per-CPU granularity.
+
+  - QEMU cpu-pm=on: delegates MWAIT/HLT to guest but provides no
+    policy mechanism. libvirt support for cpu-pm was never merged
+    upstream despite being documented.
+
+8. Next steps
+-------------
+
+I am looking for feedback on the overall approach and the design
+questions above. If there is consensus that this capability belongs
+in KVM, I am willing to implement the full stack — starting with the
+KVM ioctl and MWAIT/HLT exit handler changes, followed by the QEMU
+and libvirt integration.
-- 
2.53.0

