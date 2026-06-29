Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAF40D583;
	Mon, 29 Jun 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737547; cv=none; b=gdMHqGIqc+M6Rvp8NpEHU+qJ9/DuzFrkZ+FQk7TBSU/knIrvfFO1PIXxRvumwEo/C3aiZwm0eqH/klBMvEVBPOgSxHpLeZ1cc/VEHgOqrpwbKLo4KWUPNVAA+r6gGMtsKmqEfoGhi1GLLNbrxpVuHnQfKqIFISGcoXbkQ/WpFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737547; c=relaxed/simple;
	bh=5QK3zxx2OVhnZUXUz81rJQYEtqy1QYH2WhpiGXztExk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0QnaiGe2Ri7YBgPlx+xlMZWHH/FdD0mJU57S1u9EzR0YX+XYYAU9zZW/gNiybofb8we97cruFxVDmVRtpKGXWIF/Nbq6v2qhpcOvc4tq0HXKnsyPhU7dSw/XJYEz4jGCGQb1NEjL1zqwRXtPdHVhhbsQk5H36EXgyOKtSMYKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2546516|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00533731-0.00097848-0.993684;FP=2804453163812833195|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.i8gsqBa_1782737527;
Received: from tina-home.taild49858.ts.net(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.i8gsqBa_1782737527 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 20:52:14 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
Date: Mon, 29 Jun 2026 20:52:03 +0800
Message-ID: <20260629125205.52394-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SVM DecodeAssists feature is reported in CPUID
Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
of the intercepted instruction in the VMCB, allowing a hypervisor to consume
the decode information directly instead of re-decoding the instruction in
software on relevant VM-Exit paths.

KVM currently does not expose DecodeAssists to nested SVM guests, even when
the host supports it, and does not propagate the hardware-provided
instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit.  This
leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 from
using the same hardware-assisted decode information that KVM receives for
L2 exits.

The missing virtualization was observed in practice with Hyper-V as L1,
where the absence of DecodeAssists prevented nested SVM from being made
available to L2 guests.  The fix is not Hyper-V specific.  Complete nested
SVM virtualization of DecodeAssists by advertising the feature to L1 when
supported by hardware, and by copying the decode-assist fields into VMCB12
on nested VM-Exit.

Add a selftest that triggers a nested page fault from L2 and verifies that
L1 sees a non-zero instruction length and instruction bytes matching the
faulting instruction.

Tested with:

  make -C tools/testing/selftests TARGETS=kvm run_tests

Tina Zhang (2):
  KVM: nSVM: Virtualize DecodeAssists for nested guests
  KVM: selftests: Add nested SVM DecodeAssists test

 arch/x86/kvm/svm/nested.c                     | 47 ++++++++-
 arch/x86/kvm/svm/svm.c                        |  3 +
 arch/x86/kvm/svm/svm.h                        |  6 ++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 99 +++++++++++++++++++
 6 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c

-- 
2.43.0
