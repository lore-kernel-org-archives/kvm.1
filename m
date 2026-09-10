Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8460348094A;
	Thu, 10 Sep 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041271; cv=none; b=nlcB10LiUA5tcxpx61VjMJG2oI2p8pg2z7muA5WBo6e4X504dAoxoqWE+rv+er1qZjB8rbl3ylbtD/mGduST0Az/l35nAhI6mzOFv0oXgSc4EAkUyz6cDfu3ItgnosK5pz4cxBUxg0SLhORwwFMhZ6YXm9x8iDfLXZ0hQ26Arc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041271; c=relaxed/simple;
	bh=Pd4ATw6gTHfY7Lv8ZYbBNlu+6nxrHVMa+m6WOUrQ8Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NoshjGI2+jA75tpbEThTJdUPc3wYms/lsnDqjeHE8RB3IrJnvH3bTKqC3qiTU1pp6R88L99hjWUgZzxrOZxHoEjPWOm5yPiZVuLJCRmu2iEmFtPw/DqnrYz09Vo6Utr29iX4hwi06i/ZJUjXt/iY9wTTAkz21rWdD8rKHMugyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgj0ZBRzbKSsx;
	Thu, 10 Sep 2026 19:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf5sZszb0tj9;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPc912bb700f5899f2adcbc011148850e2
	Thu, 10 Sep 2026 19:54:22 +0800
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
Subject: [PATCH v2 6/9] KVM: selftests: Skip PERF_CAPABILITIES vCPU checks without PDCM
Date: Thu, 10 Sep 2026 19:54:11 +0800
Message-Id: <20260910115414.3015260-7-ewanhai-oc@zhaoxin.com>
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

KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES through
KVM_GET_MSRS even when PDCM is not exposed in KVM_GET_SUPPORTED_CPUID.
However, vCPU accesses to the MSR fail without PDCM.

Keep the feature MSR query, but skip its checks when KVM does not
expose PDCM, allowing feature_msrs_test to continue checking the
remaining feature MSRs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/feature_msrs_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/feature_msrs_test.c b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
index 158550701..9602e29bf 100644
--- a/tools/testing/selftests/kvm/x86/feature_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
@@ -54,6 +54,19 @@ static void test_feature_msr(u32 msr)
 	if (is_kvm_controlled_msr(msr))
 		return;
 
+	/*
+	 * KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES as a
+	 * feature MSR even if KVM doesn't expose PDCM, but vCPU accesses to
+	 * the MSR will fail in that case. Skip the vCPU checks so that the
+	 * remaining feature MSRs can be tested.
+	 */
+	if (msr == MSR_IA32_PERF_CAPABILITIES &&
+	    !kvm_cpu_has(X86_FEATURE_PDCM)) {
+		printf("KVM does not expose PDCM, skipping vCPU checks for "
+		       "MSR_IA32_PERF_CAPABILITIES (0x%x).\n", msr);
+		return;
+	}
+
 	/*
 	 * More goofy behavior.  KVM reports the host CPU's actual revision ID,
 	 * but initializes the vCPU's revision ID to an arbitrary value.
-- 
2.34.1


