Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8A40861E;
	Thu, 30 Jul 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410109; cv=none; b=c2I8yrKym4WYrnDgqm2KsgDdjhJt1m03TlfQUyNlLbdoB39ei37XRax2hnGlC5HHNnI9+mkNjMaJGoXCC8E6y747nyG7D78bXC2/F1qKWGZQ9ZxEVmbE5/A4avdJyXJtfoc1NRi07xxk/KoOuA06pNX1JTGTowlRXu23aWKS8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410109; c=relaxed/simple;
	bh=6Dc6v6SL9pTfCiYw6nraQmXo6U3VQ3bkwRis9+pUeDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCYTTxN4O0ZWCqOS7ivy60kk3Y32F3Tov4rf7qtIRlXnhKGMWpdsxWeu0sejQt6rXk1dw44HWofoldYVsShl8HmZksmwW/w1EQCu1E7Ly48xfbuYjKQn5GsPmKqeMCVX0jzzPm/iC6mMD4gYG17+sRD5E2XsfV+XmqiFbIIDVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZk13pdzYq2gv;
	Thu, 30 Jul 2026 19:05:34 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4h9mZj3lvFzYq2gH;
	Thu, 30 Jul 2026 19:05:33 +0800 (CST)
Received: from ewan-server.zhaoxin.com (ewan-server.zhaoxin.com [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP9ac15ba83ed3deac62f2d14a5d8850b8
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
Subject: [PATCH 2/8] KVM: selftests: nx_huge_pages_test: Add TDP detection for Zhaoxin CPUs
Date: Thu, 30 Jul 2026 19:05:18 +0800
Message-Id: <20260730110524.2539316-3-ewanhai-oc@zhaoxin.com>
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

Update the kvm_is_tdp_enabled() function to include Zhaoxin CPUs
when checking for EPT (Extended Page Tables) support. This ensures
that ZX CPUs use the appropriate TDP (Two-Dimensional Paging)
parameter check, similar to Intel CPUs.

The change modifies the condition to check for both Intel and ZX
CPUs before querying the EPT parameter, maintaining compatibility
with existing Intel systems while extending support to ZX CPU
systems.

Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a8ea591ebe8e..4688cb2b0092 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -156,7 +156,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, u8 indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (host_cpu_is_intel)
+	if (host_cpu_is_intel || host_cpu_is_zx)
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
-- 
2.34.1


