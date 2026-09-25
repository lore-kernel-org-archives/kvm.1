Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDE4A3844;
	Fri, 25 Sep 2026 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343866; cv=none; b=T2S47wfiEpdUVoBBIiyjh7xMZV89/mwavT1El6l0yRvc4ttBdebcfBtWGZftd0vdeV4wLs+SErB06pMRbUwImktvU0q02VchTfKcuCiaTQUS25z2r5wST1HG/2MAI0zePQSC2Pvz+6pdD94yJaOuGNYnYhCoT2Jbc8WDmfJSxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343866; c=relaxed/simple;
	bh=nGGG+MtBjARiLhSZAfUGEfNq5HzGBD6Fm/5cv+SY0Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUwlDms01QZfI+2KNlA0xQH25r6tXta+yi9g/itKZ+GrYPsOtgOibrTFCnvVFZ7LlkU0f8DzIBrIeQT8Ch7/tUUYr2aGp1K8ez2Vh4mmL06wyn1goBU6oDpGWN6DVeI9b8Wlo2h1TO97KCHPkS2ggPPWeWFUALATDOXppd1p968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=BMRaqaYT; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BMRaqaYT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=r+SX5mpVsJj4bSe5fVeKN2CFHOlH307yKu1jEYAwyKA=; b=BMRaqaYTVtYS
	hYAWjP5cY6/PbFH26IQbl751ZLpALIYEkDjNgqP7wwFMuV/btMo5JEd2m3mfdzVYkukGfzMLum2pa
	rSyKvaDgMLmZB+SISEqHP/WUn/HFZhxHAl5iojBRtjk/niL0G/EPXuDOgw4vEdCT/IW7cr80wNeO2
	iQ2u1voS802MKG7lBNUxPKigohTz1gUh6ZkNpx2r1X6Oby23dPWFmnf/PTw4ni2ihL04loVsTKQD0
	pOS/wWbT9BqpNgJ+ZbDN5e/MhtMnIrvCf1ZAVQmLK0fp4deYYceUeNmkYEjVCWA89p+TOUm+KVujV
	MHnfzJHHbjpsfqCP76xx2Q==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA6As-008eJw-37;
	Fri, 25 Sep 2026 15:44:15 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Shuah Khan <shuah@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH] selftests/tdx: skip when the TDX guest device is absent
Date: Fri, 25 Sep 2026 16:43:57 +0300
Message-ID: <20260925134409.3639204-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verify_report fails outside a TDX guest, where /dev/tdx_guest does not
exist.

Skip only when the device node is missing, so that a real open()
failure, EPERM or EBUSY, still fails the test instead of being
reported as a skip.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/tdx/tdx_guest_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index dfaefa685519..c31cc77cc7df 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -135,6 +135,8 @@ TEST(verify_report)
 	int devfd, i;
 
 	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
+	if (devfd < 0 && errno == ENOENT)
+		SKIP(return, "TDX guest device is not available");
 	ASSERT_LT(0, devfd);
 
 	/* Generate sample report data */
-- 
2.55.0

