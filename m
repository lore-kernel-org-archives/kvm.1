Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA2475340;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041269; cv=none; b=HR7XWdoUu5Ec8gEgCo7ftrZMJrgfaO8ov5sWfx3T/qeqeCQb1PdrxN9aU2uYbGtfLJdYTMydzB9gyAIL7wIArox9JlJvC6m9wLugKMqtwxBSYRyXDEmAz7xPOzEgon3hsGAx0dPqCF6oZ+JYmCxi0n8qxO3ZkCiKMSa5YIDXvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041269; c=relaxed/simple;
	bh=CJC9ywMuYuiGmx/uuUQuxVxShXesv6iUvPs4QakHY3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcBcmNH6JPYUtXzww9XYkeLRsKykhknxvZNFnal12/+9qiea0jWYEHM7XiXkdZJGbVbAIMNAf9Uc5Le0VmNU25WAun5fketnzIQSE58ACPtAfWtv54eD7PHkT2wozPkujWVUcwP7QA0taF/o9OsaO/36Jwwu7qtEF8xouzv/BMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf1SffzbKSsv;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgc5xCVzb0tj9;
	Thu, 10 Sep 2026 19:54:20 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPe5982129177edb7275ec6bd2632d50e2
	Thu, 10 Sep 2026 19:54:20 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Frank Zhu <frankzhu@zhaoxin.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ewanhai@zhaoxin.com,
	cobechen@zhaoxin.com
Subject: [PATCH v2 0/9] KVM: selftests: Add Zhaoxin CPU support
Date: Thu, 10 Sep 2026 19:54:05 +0800
Message-Id: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

This series adds Zhaoxin CPU support to the KVM x86 selftests.

Zhaoxin CPUs use the "CentaurHauls" and "  Shanghai  " vendor strings
and implement VMX-compatible virtualization, so KVM handles them via
its VMX backend.  Several selftests currently assume a CPU is either
Intel or AMD, which makes them misbehave or skip on Zhaoxin hosts.

Patch 1 adds Zhaoxin detection and the compatibility flag. Patch 2
updates the mediated PMU parameter lookup. Patches 3-5 and 7 apply the
compatibility flag to VMX-backed paths. Patch 6 handles feature MSR
testing without PDCM, patch 8 handles Zhaoxin's #GP error-code behavior,
and patch 9 checks APIC-access virtualization support.

Frank Zhu (9):
  KVM: selftests: Add Zhaoxin CPU detection support
  KVM: selftests: Use host_cpu_is_intel_compatible for mediated PMU
  KVM: selftests: nx_huge_pages_test: Add TDP detection for Zhaoxin CPUs
  KVM: selftests: vmx_exception_with_invalid_guest_state: Support
    Zhaoxin CPUs
  KVM: selftests: fix_hypercall_test: Add Zhaoxin CPU support
  KVM: selftests: Skip PERF_CAPABILITIES vCPU checks without PDCM
  KVM: selftests: feature_msrs_test: Extend MSR_IA32_UCODE_REV quirk to
    Zhaoxin
  KVM: selftests: nested_exceptions_test: Add Zhaoxin CPU support
  KVM: selftests: vmx_apic_access_test: Check APIC virtualization
    support

 .../testing/selftests/kvm/include/x86/processor.h | 10 +++++++++-
 tools/testing/selftests/kvm/include/x86/vmx.h     |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c   |  8 +++++++-
 tools/testing/selftests/kvm/lib/x86/vmx.c         | 15 +++++++++++++++
 .../testing/selftests/kvm/x86/feature_msrs_test.c | 15 ++++++++++++++-
 .../selftests/kvm/x86/fix_hypercall_test.c        |  2 +-
 .../selftests/kvm/x86/nested_exceptions_test.c    |  4 +++-
 .../selftests/kvm/x86/vmx_apic_access_test.c      |  1 +
 .../x86/vmx_exception_with_invalid_guest_state.c  |  2 +-
 9 files changed, 52 insertions(+), 6 deletions(-)

Changes since v1:
- Rebase the series onto kvm-x86/next.
- Spell out Zhaoxin in helper, macro, and patch names.
- Add a new patch (2/9) to use host_cpu_is_intel_compatible in
  kvm_is_mediated_pmu_enabled() so Zhaoxin CPUs look up the mediated
  PMU parameter from kvm_intel.
- Reword the Zhaoxin CPU detection commit message to document the new
  host_cpu_is_intel_compatible flag.
- Expand the nested_exceptions_test commit message to explain why
  Zhaoxin CPUs leave EXT clear for the #GP generated when vectoring
  an injected #SS.

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.34.1

