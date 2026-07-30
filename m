Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD640860E;
	Thu, 30 Jul 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410109; cv=none; b=dRIpdWpIxt0vr45v4q5OvDxXLXVoSYYzHFAs78Fu2KE3Iq+jVXz+q0hFu5Qj/nwkm+YBxafz8ouAbkfSVHKebiveatPQNvnX4q6lBysiOfR6UrQWaXCSmAg2IXX7CGTEpUovP5Q23QPaeUNgywu4qnMUHwmMCADqM1TSAdJCIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410109; c=relaxed/simple;
	bh=vh7HDR4KjCcB5te28Gwt1tattt2S8OQci0/3Hb0I5h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4DAkRGRpTASjhtnTpgJ9WdlajfBLCSMJFKEMOqeZ9Szy5LdjxaPpfHCHGy+6Pk5Szm4sNC+YR+bDxNYjOnHZjbaOm9eA4KtgWnTv3i6GB543Dkb5trtPOUu7k8+zWL6voPzVa+E8nbnHsWH301CqMWBvgTGAuqfJxAfTzEPRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk12xfzbLW71;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZj3Lz8zbLW71;
	Thu, 30 Jul 2026 19:05:33 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP7411d5182e47f82afd2dd486616550b8
	Thu, 30 Jul 2026 19:05:32 +0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] KVM: selftests: Add Zhaoxin CPU support
Date: Thu, 30 Jul 2026 19:05:16 +0800
Message-Id: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

Add Zhaoxin CPU detection to KVM's x86 selftests and enable tests whose
VMX paths are applicable to Zhaoxin CPUs.  Zhaoxin CPUs report either
"CentaurHauls" or "  Shanghai  " as vendor string and expose a
VMX-compatible virtualization interface.

Patch 1 adds the common vendor detection.
Patches 2-4 allow applicable TDP, invalid guest state, and hypercall
tests to run on Zhaoxin CPUs.
Patch 5 keeps feature_msrs_test running when KVM does not expose PDCM,
allowing the test to run on some Zhaoxin CPUs that do not support PDCM.
Patches 6-8 handle the KVM-defined IA32_UCODE_REV initial value, Zhaoxin
nested exception error codes, and optional APIC-access virtualization.

The series is based on kvm-x86-next-2026.07.28.

Tested on a system with a Zhaoxin CPU:
    - feature_msrs_test
    - fix_hypercall_test
    - nested_exceptions_test
    - vmx_apic_access_test
    - vmx_exception_with_invalid_guest_state
    - nx_huge_pages_test

Frank Zhu (8):
  KVM: selftests: Add Zhaoxin (ZX) CPU detection support
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

 .../testing/selftests/kvm/include/x86/processor.h |  7 +++++++
 tools/testing/selftests/kvm/include/x86/vmx.h     |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c   |  5 ++++-
 tools/testing/selftests/kvm/lib/x86/vmx.c         | 15 +++++++++++++++
 .../testing/selftests/kvm/x86/feature_msrs_test.c | 15 ++++++++++++++-
 .../selftests/kvm/x86/fix_hypercall_test.c        |  2 +-
 .../selftests/kvm/x86/nested_exceptions_test.c    |  4 +++-
 .../selftests/kvm/x86/vmx_apic_access_test.c      |  1 +
 .../x86/vmx_exception_with_invalid_guest_state.c  |  2 +-
 9 files changed, 47 insertions(+), 5 deletions(-)


base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.34.1

