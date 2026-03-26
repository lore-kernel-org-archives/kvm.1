Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239A372B57;
	Thu, 26 Mar 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494751; cv=none; b=cWVfsapJbr/wKASgXHkfBT5uhiJnBaAnQZSSXOvlZgq+y77MrVS0se45zVAgYNcIIoxk4WuvAfVmAceiaNgEdo4K70f1Oblz84ArXEhK7UmhlopMjy+rtsmwQDzlTwaR8OMfcOw6E1lXAdph+ZlJGrCDjCRURspkiheiovcFjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494751; c=relaxed/simple;
	bh=h/r8PIV+ojYyJjtZwQ41PHWtZzD7MW1lTxeoc/rWfdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTnAZkJIYY5klrZk0+QP4AhK8XgkyyNFoawsuZRUFW+CZO4uEd9/r1Yt3iWYkqGBMN7D9SyxIdq8T4HaRwzbVr/Fr8XAA8MpwVlyxWkN/58wpzvginJSKF8JLMa+aiGvok3iJ9g+xq38dClSN5Mvk7ZjeiqgBJ5XZ7ByCur02aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlhLAeoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlhLAeoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012D7C4CEF7;
	Thu, 26 Mar 2026 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494751;
	bh=h/r8PIV+ojYyJjtZwQ41PHWtZzD7MW1lTxeoc/rWfdg=;
	h=From:To:Cc:Subject:Date:From;
	b=RlhLAeoy0egsTPV1/RCTyOqfRguKNljOafnZa/ZNkPoIxpLWMK/iPyrwGse5fitA6
	 tofMaQ/Z48gAwj6sG9W0myECQm2y7WXYSxfqqPY7tTpqrtRfYeHHhcd/NzZK4EpYQC
	 MVuDkUMOjEiuYaIeQOEUWj/CmvGaDKo3mlUBDdBRTRXjI6nXIpiv+SM6gNKg33sjLN
	 6KoJGZbJsTQOa4tg6ekg+lGGln80YdKtXOo7WwlREHqrHmMEJiaFhgN09O/cvtD1ku
	 S0RJO1UqZDIZunZOm7V0yGXhLOtboJzumqPxpR2O0oYWUh2FAbf4jNnT33D1DRiVK4
	 4QY9SKTp90jRQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 0/6] KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits
Date: Thu, 26 Mar 2026 03:11:44 +0000
Message-ID: <20260326031150.3774017-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 of Jim's series adding support for AMD's Host-Only and Guest-Only
performance counter eventsel bits in KVM's mediated PMU passthrough
implementation.

These bits allow an nSVM-enabled guest to configure performance counters
that count only during L1 execution (Host-Only) or only during L2 execution
(Guest-Only).

KVM updates the hardware event selector ENABLE bit at the following state
transitions to ensure counters only count in the appropriate mode:

  - EFER.SVME changes: Enable/disable Guest-Only counters
  - Nested VMRUN: Disable Host-Only, enable Guest-Only counters
  - Nested VMEXIT: Enable Host-Only, disable Guest-Only counters

v3 -> v4:
- Dropped amd_pmu_set_eventsel_hw(), moved handling of
  Host-Only/Guest-Only bits to PMU counter reprogramming and funnelled
  all processing through KVM_REQ_PMU [Sean].
  - For this to work, added a per-vendor callback for reprogramming PMU
    counters.
- Sorta restored the bitmask from v1, except now it's a single bitmask
  tracking all counters that need to be reprogrammed on nested
  transitions. The bitmask is used to avoid unnecessary KVM_REQ_PMU
  requests and only reprogram counters as needed  [Jim].
  - This is also needed to avoid directling calling vendor code from
    {enter/leave}_guest_mode() as requested by Sean.
- Added prep patches moving enable_pmu/enable_mediated_pmu and
  guest_mode helpers to facilitate following changes without circular
  dependencies and to avoid including new headers from leaf headers.

v3: https://lore.kernel.org/kvm/20260207012339.2646196-1-jmattson@google.com/

Jim Mattson (2):
  KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
    PMU
  KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
    bits

Yosry Ahmed (4):
  KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
  KVM: x86: Move guest_mode helpers to x86.h
  KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
    SVM
  KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on nested SVM
    transitions

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   1 +
 arch/x86/include/asm/kvm_host.h               |   6 +
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/kvm_cache_regs.h                 |  23 --
 arch/x86/kvm/pmu.c                            |  12 ++
 arch/x86/kvm/pmu.h                            |  17 ++
 arch/x86/kvm/svm/pmu.c                        |  44 ++++
 arch/x86/kvm/svm/svm.c                        |   1 +
 arch/x86/kvm/x86.c                            |   9 -
 arch/x86/kvm/x86.h                            |  31 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
 14 files changed, 319 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
-- 
2.53.0.1018.g2bb0e51243-goog

