Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85A47F2CB;
	Thu, 10 Sep 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041270; cv=none; b=McYPrXBRY3ZEgjhQRvd7GZEiJfkOOEjJ+s2RRpM48TJdbb/ZuNqm3EOxv3d0B0nPDNdh/IZtYRnHWMvbkBuw4iwv8g9kHS/LdumFPN94z0FOm8NHIa6NnPd17Z5/v66Q7Wi0VeNsLbXBHaoevM/gsLr+n0vV9iDXy4k5J1kygxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041270; c=relaxed/simple;
	bh=AXS2t2pnpKQ8X41YuO34w5QbpEIpeQqHxTUCN4B5oaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shPMbFyJDDP5wpAgmhsxzb8uC2MBASKKDI4lq+nUiUcSb2jt0hGZo4S2/veGBQNc479kVIkOR/sYwk/69q0hdgotcKCSfWUMjg0++78+Pe5IgaEoPaPjgbQyfy1vo7eKzTuiqkHVUuot1wQCPwUhFv4xuV9wzcmag4xv76lINFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgj0ZJHzbKSt2;
	Thu, 10 Sep 2026 19:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf6flczb0tj9;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPebf2f47cf2d09d27d59131a3eeef50e2
	Thu, 10 Sep 2026 19:54:21 +0800
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
Subject: [PATCH v2 5/9] KVM: selftests: fix_hypercall_test: Add Zhaoxin CPU support
Date: Thu, 10 Sep 2026 19:54:10 +0800
Message-Id: <20260910115414.3015260-6-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

From: Frank Zhu <frankzhu@zhaoxin.com>

Zhaoxin CPUs use VMCALL as the native hypercall instruction. Use
host_cpu_is_intel_compatible so that fix_hypercall_test selects the
VMX hypercall path on Zhaoxin CPUs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/fix_hypercall_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 4931ec227..f11fcc520 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -48,7 +48,7 @@ static void guest_main(void)
 	const u8 *other_hypercall_insn;
 	u64 ret;
 
-	if (host_cpu_is_intel) {
+	if (host_cpu_is_intel_compatible) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
 	} else if (host_cpu_is_amd_compatible) {
-- 
2.34.1


