Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83466480321;
	Thu, 10 Sep 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041273; cv=none; b=U0VWJjIHRsiSAo5a/llPCWwSuS3orVCjNdi2UtMR7q7udpUGzl+/R4YQ1qVe0siLHGho8AQQckVT0xp7MUXlE030IOM9aHg6pHe/WEhkYEuQH1tGi5GgGflPclqEN86O3h+EQRdBTvJ1kI/qWCad3Doy1842OejTLYgT3WMLUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041273; c=relaxed/simple;
	bh=uqNNboBSxUGGzuZYGyCpRAjBDMAc6NAxfl0r51Kr9bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evFkqpZpT3/CV+rc+gmrN1FRUCvJBGCN0kugki1DZWi22Q6GrUt1YNjRBQOYU/liIQYciK0sy4cg2Cep2f8gOWCWzucfzll+66+GsuYSmVvyt5ftJ82I5XOXj4gcv1YSIcXQHsIdfC7dE0VqTAK0WUNUkmBdGhRtJ3kOfxjCV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgj0ZDSzbKSt0;
	Thu, 10 Sep 2026 19:54:25 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgg5t1CzbKSsl;
	Thu, 10 Sep 2026 19:54:23 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPfbf124a4b3ff5aeb3c4c11f53ca350e2
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
Subject: [PATCH v2 7/9] KVM: selftests: feature_msrs_test: Extend MSR_IA32_UCODE_REV quirk to Zhaoxin
Date: Thu, 10 Sep 2026 19:54:12 +0800
Message-Id: <20260910115414.3015260-8-ewanhai-oc@zhaoxin.com>
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

Zhaoxin CPUs use KVM's VMX backend and therefore observe the same
KVM-defined initial value as Intel vCPUs. Update feature_msrs_test to
expect 0x100000000ULL for Zhaoxin vCPUs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/feature_msrs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/feature_msrs_test.c b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
index 9602e29bf..bb339709d 100644
--- a/tools/testing/selftests/kvm/x86/feature_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
@@ -72,7 +72,7 @@ static void test_feature_msr(u32 msr)
 	 * but initializes the vCPU's revision ID to an arbitrary value.
 	 */
 	if (msr == MSR_IA32_UCODE_REV)
-		reset_value = host_cpu_is_intel ? 0x100000000ULL : 0x01000065;
+		reset_value = host_cpu_is_intel_compatible ? 0x100000000ULL : 0x01000065;
 
 	/*
 	 * For quirked MSRs, KVM's ABI is to initialize the vCPU's value to the
-- 
2.34.1


