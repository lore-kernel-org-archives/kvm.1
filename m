Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217D403B0C;
	Thu, 30 Jul 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409548; cv=none; b=PoamjbUq/N4Kjx+51ZK4NtBkg4Q2fmTIjK9aI+qtLjeeoqD39S6zEiiggAxNRpSjQWQQmXfxQpnqH5C9ENmvFzzJRUYh3iGkdmzjrbsTUPixrfIbFn4HaQ7b7NyqU2eOkKNj4qCo89P3nIAMv/cHVwWWX0LFopAXFPLNKX9NjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409548; c=relaxed/simple;
	bh=Pg7A7o2LPH1/DS2+iG/h/OysJIRNTtkDlfEaj5Xtc2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J42MuXISRIutBz8Ws4uDH5zV0vpXUiCAiE/1lOHhARnzq5EPafWOMTK7rLmXzqmthZntDaiEp+qjddx4Fi0nfE3FXSJk5A+ufzTWDPD7OuHn8ukaSbNOUP7ws7oX+tc2GmmRA34luLmZmXV/k0jI3gNqsFlkDHAoFL0g7/ay14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZn1NRFzYq2h5;
	Thu, 30 Jul 2026 19:05:37 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZl3TzzzYq2gx;
	Thu, 30 Jul 2026 19:05:35 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPef2f25f2dfb86486edd8dbccd36e50b8
	Thu, 30 Jul 2026 19:05:34 +0800
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
Subject: [PATCH 6/8] KVM: selftests: feature_msrs_test: Extend MSR_IA32_UCODE_REV quirk to Zhaoxin
Date: Thu, 30 Jul 2026 19:05:22 +0800
Message-Id: <20260730110524.2539316-7-ewanhai-oc@zhaoxin.com>
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

Zhaoxin CPUs use KVM's VMX backend and therefore observe the same
KVM-defined initial value as Intel vCPUs. Update feature_msrs_test to
expect 0x100000000ULL for Zhaoxin vCPUs.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/x86/feature_msrs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/feature_msrs_test.c b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
index 9602e29bf9cc..c24fa5275a99 100644
--- a/tools/testing/selftests/kvm/x86/feature_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
@@ -72,7 +72,7 @@ static void test_feature_msr(u32 msr)
 	 * but initializes the vCPU's revision ID to an arbitrary value.
 	 */
 	if (msr == MSR_IA32_UCODE_REV)
-		reset_value = host_cpu_is_intel ? 0x100000000ULL : 0x01000065;
+		reset_value = (host_cpu_is_intel || host_cpu_is_zx) ? 0x100000000ULL : 0x01000065;
 
 	/*
 	 * For quirked MSRs, KVM's ABI is to initialize the vCPU's value to the
-- 
2.34.1


