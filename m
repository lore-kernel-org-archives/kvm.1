Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB745D901;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041268; cv=none; b=uHgkirf1lpsT73n7/jH6OQ1tMbt9xvHE/FPWgfjl0O/grabTFCCjOZt3irB2ed9++wyal4AWc6Qhrs8z0CbSBAIuYtaofyO0rwlItp5lPLl/yCKOw4PpNK9SWi3EZH2V8jK94Sedty9PxqGpgH4KG5/3/sEV06Te4kwWadWxcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041268; c=relaxed/simple;
	bh=Hn/KxxUjDNzpfGZXYLAInba45oWKIe7ah1ghdoo0ALs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avlU0UusK8qo7C9oeP3T24m2btIJYqp1buANbj8dRXeKVyC7s4Q4jTrqbZIRd+mc4Sa+f1iV6d6jwxLn4Ri4G23AfzupkSbayb1/SmxQ+uOAJ2Y28In/r96DdDhYslG1YcKEZnlhn7MXeFKTzORbX7uThe9r3vDIK9Fjfly9Yvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf0ZM6zbKSsr;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgd5q6Wzb0tj9;
	Thu, 10 Sep 2026 19:54:21 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP0ae0167815692b8cef0d94c23f3e50e2
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
Subject: [PATCH v2 2/9] KVM: selftests: Use host_cpu_is_intel_compatible for mediated PMU
Date: Thu, 10 Sep 2026 19:54:07 +0800
Message-Id: <20260910115414.3015260-3-ewanhai-oc@zhaoxin.com>
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

kvm_is_mediated_pmu_enabled() returns kvm_amd's enable_mediated_pmu
module parameter unless the host CPU is Intel.  Zhaoxin CPUs implement
VMX-compatible virtualization and are handled by KVM's VMX backend, so
on Zhaoxin hosts the helper wrongly reports kvm_amd's parameter.

Gate the check on host_cpu_is_intel_compatible so that Zhaoxin CPUs,
like Intel CPUs, query kvm_intel's enable_mediated_pmu instead.  This
does not change behavior on Intel, and AMD and other non-Intel-
compatible CPUs still fall back to kvm_amd's parameter.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5d2be3399..df368232c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1454,7 +1454,7 @@ static inline bool kvm_is_pmu_enabled(void)
 
 static inline bool kvm_is_mediated_pmu_enabled(void)
 {
-	if (host_cpu_is_intel)
+	if (host_cpu_is_intel_compatible)
 		return get_kvm_intel_param_bool("enable_mediated_pmu");
 
 	return get_kvm_amd_param_bool("enable_mediated_pmu");
-- 
2.34.1


