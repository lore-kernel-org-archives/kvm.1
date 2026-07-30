Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F26409121;
	Thu, 30 Jul 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410110; cv=none; b=WJrRLg7YIhDGgCoQwgBgcNw3XSJm7UleyXdqVUnjoHtuIu4OgnG6usnyFMVqFOOjQsY3GxDJQPavY2KqlwrC6GQKs3wboj7nxLesSlTotdoNIJMeV4BeU/1BhN5m4GgPSdrRBcFW9zkdrvZ5GtAujfvHdDcoWx8wY+aryrq+60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410110; c=relaxed/simple;
	bh=WqQODRvdOXoohPxESYaZGf+5Ew8cESez9OFgKXxZv7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foct7BBYz9+rFr/qlBisMpkMKOm+M6b+bDrkfyZYfsQt85Z+V4cg9FabwQPstg1+cHvzwgEyRNjF5xINsHOGMxUoOZrWjf5vzk82ahOAhPNcYdzuUoTlgWNWRaZmPPtwa1cPP3tgKZ/CJBm6YdiIwEKh3XIfT2Rqr6s+kuQQVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZn14XXzYq2h3;
	Thu, 30 Jul 2026 19:05:37 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk3pgkzYq2gx;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPedd08eb0bc1e0f98fe57626a50e450b8
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
Subject: [PATCH 5/8] KVM: selftests: Skip PERF_CAPABILITIES vCPU checks without PDCM
Date: Thu, 30 Jul 2026 19:05:21 +0800
Message-Id: <20260730110524.2539316-6-ewanhai-oc@zhaoxin.com>
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

KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES through
KVM_GET_MSRS even when PDCM is not exposed in KVM_GET_SUPPORTED_CPUID.
However, vCPU accesses to the MSR fail without PDCM.

Keep the feature MSR query, but skip its checks when KVM does not
expose PDCM, allowing feature_msrs_test to continue checking the
remaining feature MSRs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/feature_msrs_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/feature_msrs_test.c b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
index 158550701771..9602e29bf9cc 100644
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


