Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C21408023;
	Thu, 30 Jul 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410109; cv=none; b=NCvXGsPD5lCxS928Cv4soYa0+/gmFkphbw3xDkf/ZhvWNB+iS4R4wo3PW8yaBzvFkXOEnRA5W0+lXqXIBFHmDVi0lbElBgO3vZ6sUAjiY/HemHU8dq5qc+W3gTqs15QTJfz2q8Nv85JJDRhf0WhK2w+jCxneCmqou+WE6aqGSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410109; c=relaxed/simple;
	bh=MdO8Yn63yHGODC8CXk3daIw5EeL9tEO0t4vDl9Q15m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBI1cU5FlDW55VBKmJGAcB3oDjpHMMd/u8yZQxIrIE8CPYCJLPwaBtJalWGjVfQydxgLRlgHVGHvhJGh4izAY4EUYxLRxzCixkrlVY2Cbp7WdWjkwsWMahIU9PDV+XLw3weocvnVUhwqiZKkCHL9LDbHK8tMj2NsZN2IJN0dUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZn14KCzYq2gx;
	Thu, 30 Jul 2026 19:05:37 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk3tJbzYq2gH;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP9dea32821ef3596f77d48b5a07ff50b8
	Thu, 30 Jul 2026 19:05:33 +0800
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
Subject: [PATCH 4/8] KVM: selftests: fix_hypercall_test: Add Zhaoxin CPU support
Date: Thu, 30 Jul 2026 19:05:20 +0800
Message-Id: <20260730110524.2539316-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

Zhaoxin CPUs offer a VMX-compatible interface with the same VMCALL
instruction as Intel CPUs for hypercalls. Add host_cpu_is_zx to the
Intel branch to allow the test to run correctly on Zhaoxin hardware.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/fix_hypercall_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 753a0e730ea8..0fb75ad1715f 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -49,7 +49,7 @@ static void guest_main(void)
 	const u8 *other_hypercall_insn;
 	u64 ret;
 
-	if (host_cpu_is_intel) {
+	if (host_cpu_is_intel || host_cpu_is_zx) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
 	} else if (host_cpu_is_amd_compatible) {
-- 
2.34.1


