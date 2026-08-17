Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7033B42EB
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956374; cv=none; b=D7AlQi2py4bqUpqBtC1IyS5lJLkHqwhyTTcq9+SGGS6XEi/QmJV0qHP6j19z4TP75qW73q7MCYjKrKlCaFtzmGoYE7emTSoZu7Q7nOu0qd0wk9Jws1hL5CGxlHBXod6wnTILuv5mxF3ktXbgrukVr+c9iD1hTgT5CLtb9B+VdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956374; c=relaxed/simple;
	bh=isLS9t3d8SJlInC0ilegt2UmV8A4lwBTmAjCzmJ5etI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITAg0afQpF4ltgLOF9yKhxpejoeVz5vCdT1PaFV2wouf4BO+LXM2aiTOeFD+CBJmMsCivFmoWSGcyp6I+gIGqz8XcSpftWXEBf1xJ592kykL0IXc10SI7GL8Xf28Uewsd5cqWJY+1jphBsEvpr7Q40VoXRYQFaKdFBK36ml1GaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cUy8JAdY; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cUy8JAdY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786956367; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OQAIXAFFYEwB1C5m43LzwLj1VOY7JemLsHMd6qpeG3Y=;
	b=cUy8JAdYC3ufdsqZ6nL7/Tz/r8bK5IDj7yeQrq8FgWbzeV9hN/3OuzzqaeGNtRMvf8LTrN/yyiS//0+zbH6fkHoPtCvSHyCzG44wbi/nyz/KewWCMzdvvQKsXjdpesnW8T1YbrAf92dNCOXFxLRUQeycnPBQS722iRpUOpnw4eA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X95DvBL_1786956366;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X95DvBL_1786956366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 16:46:07 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	will@kernel.org
Cc: yaoyuan0329os@gmail.com,
	yaoyuan@linux.alibaba.com
Subject: [PATCH kvmtool 1/1] Makefile: Don't set -CFLAGS := in Makefile
Date: Mon, 17 Aug 2026 16:45:34 +0800
Message-Id: <20260817084534.92780-2-yaoyuan@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>
References: <20260817084534.92780-1-yaoyuan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't set CFLAGS to empty in the Makefile to allow
set the addtional CFLAGS option from environment,
support e.g native static compiling.

Signed-off-by: Yao Yuan <yaoyuan@linux.alibaba.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 60e551f..6755910 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,6 @@ include config/feature-tests.mak
 -include $(OUTPUT)KVMTOOLS-VERSION-FILE
 
 CC	:= $(CROSS_COMPILE)gcc
-CFLAGS	:=
 LD	:= $(CROSS_COMPILE)ld
 LDFLAGS	:=
 OBJCOPY	:= $(CROSS_COMPILE)objcopy
-- 
2.43.5

