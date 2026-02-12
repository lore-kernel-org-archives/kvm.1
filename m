Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C52DE711;
	Thu, 12 Feb 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893136; cv=none; b=s0UtHcLME2JU6oSTSNNGSitdGca4cXAUt4XmYKtvvaO36M2HM0GVi6qOz2LYMEJqDZ3aGN1hfP9zukjcMhSGZf4Qg3a3NzK9zVXNkQZVVGatTNBtZ5izaImKNOVMu0yWYxY/AlOfdjLIYBcBCvD7XZWc1LZQZ1C1syXpYx81t1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893136; c=relaxed/simple;
	bh=+t7xMZd2bxyA6AXpZ3ZGbX/wqavwiOsDd51RPH8NXPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8UcG2smpjVf+3Z6wJ9FwUYVZTR99VYjNxanNJ2zdsbLyQ1IT1mDY6KchwOsGZOnDj0s4YqfEVA+fznD+bghHDVFavw4S/B9+oQ34SJ1nyWhPSgSywqAoHApcbNgfXdY1LFzJNgSCqJ8NvaOh/hqS3hye0eOxaMQ9ZLCt6XVVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QW7qvKj4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QW7qvKj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=66
	A7mfit9unPft68eNmo36DM2y3Z3VGpv2Yc+cf0gqI=; b=QW7qvKj4uL2rIWMlKQ
	Ikf2e2hWtR/hE1dyVAlSPatCttDK/png6/bYxKZ8A7OPmpDLph34hi5tRm9B8tGJ
	Urk9rX0PJikV72hbRr6XeHlngIW9U6C0IzgQvG4bWWQQXjuvoO9j8Xv5Lm0yXTzp
	evn894iMTaAeUliXVuIZ+oLlQ=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA38f4Tr41pL2eqLA--.10527S5;
	Thu, 12 Feb 2026 18:44:42 +0800 (CST)
From: Zhiquan Li <zhiquan_li@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan_li@163.com
Subject: [PATCH v2 3/4] KVM: x86: selftests: Allow the PMU event filter test for Hygon
Date: Thu, 12 Feb 2026 18:38:40 +0800
Message-ID: <20260212103841.171459-4-zhiquan_li@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212103841.171459-1-zhiquan_li@163.com>
References: <20260212103841.171459-1-zhiquan_li@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA38f4Tr41pL2eqLA--.10527S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1DKr13Kr1rGr47CF1fXrb_yoWDJFb_JF
	WxKF9rArs5AFy0yr48tw4YyFWIka1fJws0qr90qF17Jr4jyF45GF4v9r1qkryxurW3K342
	vF4qkr1Yvr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUiL07UUUUU==
X-CM-SenderInfo: 52kl13xdqbzxi6rwjhhfrp/xtbC6hqvmGmNrxra5gAA3q

At present, the PMU event filter test for AMD architecture is applicable
for Hygon architecture as well.  Since all known Hygon processors can
re-use the test cases, so it isn't necessary to create a new wrapper.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
---
 tools/testing/selftests/kvm/x86/pmu_event_filter_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
index 1c5b7611db24..bbd1157ef28e 100644
--- a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
@@ -361,7 +361,8 @@ static bool use_intel_pmu(void)
  */
 static bool use_amd_pmu(void)
 {
-	return host_cpu_is_amd && kvm_cpu_family() >= 0x17;
+	return (host_cpu_is_amd && kvm_cpu_family() >= 0x17) ||
+		host_cpu_is_hygon;
 }
 
 /*
-- 
2.43.0

