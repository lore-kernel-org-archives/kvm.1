Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFF390C89
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976006; cv=none; b=uOQeNshib9N3ZQO/ce8Pi1hWAjKGCZu+87JkPn9myvvtamZrPUtr3GCI0T0PRbrLoGCG33FPrHz4YRlXvY/9pDJ+dTlQIr7BRNqJ0IOHlAc6dp+Lqu04Jk+/CfoOum+3qgCPDRm1D7S+ynf5cQYo6PIfuKgnTHIGRgyHq3MUc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976006; c=relaxed/simple;
	bh=97ZQnTAUg529qbEE9sEOWNiMIT6xHyR26LQcUHAeJY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTPUUD7uaIHIlkhNc5pjOPTDyIqkscEFubbxMgzBDz+TcUk2SV5vMHybF0J4YefRPTI/oy/Kw3POSsTcEs5HdThsv2nYcQcfKjH3Dtze9zz3owGkgo7oiMhV6w+3+/G75226Ipx+7SQMlq36I0YG6YkOUqFbpMLuLO6bN2kENIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=x2EvxUlQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x2EvxUlQ"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVc3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVc3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975047;
	bh=vnlhoZh7l2UNdzx+DdJhWcIWN61zvwDaJwYQQ2oGRxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x2EvxUlQWQ+66wMCkxs6YfehrKww1WtHtetuCTnrR4LyYhXx1rFFbwQTmLB84wSbA
	 rSNH6GhT0CFIz27ax90CkJz4Mn8wf4hhq/N15Rr7vcctCtyp8yrnlvV8SYD3hoGFd+
	 6xL2mAFsSbt5Pfh/wH3Sbz2+ZFFTR7dNp70XaTAzy7K0CsWZl6HAVfuaO3sO/XGKL4
	 nn8XWWlS+UbfVL/GmwIQQ8m3Wd1/1R6Yosfp6u/8IRvmXxjwAIohLMUplUgpc/RUL6
	 Y9Xqt2BJ+ZlfptFL0aeJr7Yp1BUFBoTJLPJVIWe+S0TBN5kINaG0eMTnjSrmwx/TCx
	 BcUdK25Kj/e3Q==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 03/11] x86/vmx: Simplify msr_bmp_init()
Date: Wed,  1 Jul 2026 23:50:31 -0700
Message-ID: <20260702065039.3434909-4-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper vmcs_set_bits() to update CPU_EXEC_CTRL0.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index bb61610d..da925baf 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -369,14 +369,8 @@ static void vmx_pae_free_page_tables_cb(void *pdpt_)
 
 static void msr_bmp_init(void)
 {
-	void *msr_bitmap;
-	u32 ctrl_cpu0;
-
-	msr_bitmap = alloc_page();
-	ctrl_cpu0 = vmcs_read(CPU_EXEC_CTRL0);
-	ctrl_cpu0 |= CPU_MSR_BITMAP;
-	vmcs_write(CPU_EXEC_CTRL0, ctrl_cpu0);
-	vmcs_write(MSR_BITMAP, (u64)msr_bitmap);
+	vmcs_set_bits(CPU_EXEC_CTRL0, CPU_MSR_BITMAP);
+	vmcs_write(MSR_BITMAP, (u64)alloc_page());
 }
 
 static void *get_msr_bitmap(void)
-- 
2.54.0

