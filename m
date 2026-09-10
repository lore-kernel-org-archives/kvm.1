Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4E476CF1;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041267; cv=none; b=l9JhV80DQ+2gKEfPEcSTqUynMyX31VHjPLTm53/uEGl5snr4YR03SMnVViGLe6BUapTJDmy6ji+k4iXZXQrfb+Bl8r3f4D6Lz10lKrnOTMlF0665xw/Y35MDFsyb6s7NwGEmmm14i4RLNSVOkPjDy/bmYg1jEBCTeNnWq9yZE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041267; c=relaxed/simple;
	bh=fmF2RIlJj4fCUlE/+4C6JdTPW6Tucs27fKJP9LhOfjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evv5IhNDDIBv0eTrRU7kF2eg7RzE6Q54pHpeoisUdDz85Rm+g6lYX0EtQzPv3wp+lqbM7qPNKChvcyL7N6cHOdCIwfEn4S+rXFQ2tibiNeTjQC0SgLjg+1o1LjR7wGDQMuVotw5Rm03hG19GWsn4SOJAQIEa8y7Lh8Z1Ko3z5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgf0sZMzbKSss;
	Thu, 10 Sep 2026 19:54:22 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbgd69nqzbKSsm;
	Thu, 10 Sep 2026 19:54:21 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPa08fc640d01ae08631bd445c109f50e2
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
Subject: [PATCH v2 3/9] KVM: selftests: nx_huge_pages_test: Add TDP detection for Zhaoxin CPUs
Date: Thu, 10 Sep 2026 19:54:08 +0800
Message-Id: <20260910115414.3015260-4-ewanhai-oc@zhaoxin.com>
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

Update the kvm_is_tdp_enabled() function to include Zhaoxin CPUs
when checking for EPT (Extended Page Tables) support. This ensures
that Zhaoxin CPUs use the appropriate TDP (Two-Dimensional Paging)
parameter check, similar to Intel CPUs.

The change modifies the condition to check for both Intel and Zhaoxin
CPUs before querying the EPT parameter, maintaining compatibility
with existing Intel systems while extending support to Zhaoxin CPU
systems.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a183cf005..bd50c1265 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -160,7 +160,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, u8 indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (host_cpu_is_intel)
+	if (host_cpu_is_intel_compatible)
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
-- 
2.34.1


