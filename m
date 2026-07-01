Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C348A2B0;
	Wed,  1 Jul 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909358; cv=none; b=sFfsBPv4U0lBGutRVOpqsX8a0CLpPyNXyHBXPOwobelIXzFkNrzLR1IK0sg2isybwTHQMHVHXcQbC6w8qjPuv+QO7lO9qEkZDcRobsWpASDtIRMa41mnsR6pkEPgbEwrY/J85+dIV1mX66A5paWFfxK+v8Dp93gdUBupHK2TVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909358; c=relaxed/simple;
	bh=5asjbQRA/SejkoGP7TIyv3J0JBNm04ggr7Gqjgap87w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ltw4Ae/UqhHfeN/+ChL2zsFu+jDfYg5nahdj6ZNbkBSY3W7OVlWtjUonc0E/5b35NPMMHZlbnGVZV9SjvU2NaIXRxPxvoxF3uzOwM2lwIn4DyS51GMUBEXEdNOezVFU2SXt36fLt/TeXWK4+zdxd/jtDhDueDtU1Ael1pVxCZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 62b519ea754911f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b61fbc7c-595a-4eb5-9fa4-69e8f451306c,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:b61fbc7c-595a-4eb5-9fa4-69e8f451306c,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:07f0df60fb2aa1257ede847843d704a1,BulkI
	D:260701203548LP1802YL,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 62b519ea754911f1aa26b74ffac11d73-20260701
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 65018183; Wed, 01 Jul 2026 20:35:47 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH 4/6] selftests/kvm/x86: fix spelling error in xapic_ipi_test comment
Date: Wed,  1 Jul 2026 20:35:18 +0800
Message-Id: <20260701123520.271580-5-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701123520.271580-1-wangyan01@kylinos.cn>
References: <20260701123520.271580-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "usefull" -> "useful" in xAPIC IPI test comment.

Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 39ce9a9369f5..3a326c5e74ca 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -17,7 +17,7 @@
  * amongst the available numa nodes on the machine.
  *
  * Migration is a command line option. When used on non-numa machines will 
- * exit with error. Test is still usefull on non-numa for testing IPIs.
+ * exit with error. Test is still useful on non-numa for testing IPIs.
  */
 #include <getopt.h>
 #include <pthread.h>
-- 
2.25.1

