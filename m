Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96536AB54
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294764; cv=none; b=Xcc84Abp+McsSzYHiKgCH04rdlA2DAK0X7lm29fjiKBN/p4/8mlVFNv8SzP+8G4PRhrZ8gPrDUivxwLJ961EKExDYcd9eQt6KtTNf6h/IKx7xXBb0yRvYvoVB1uLq4624s2mfXtz26uCQNCA+ihdocnJi2Pi7+FuH/sjrg71h6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294764; c=relaxed/simple;
	bh=4Iu43P+tAmtm9pP3t7jsKWTQ6icIpPUb7lEoPkq8jhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUbadwjhaKzLH8xYuwXXG5E+sr8zB/Fv1Stu4qu2bIWNMlmzMHKevScHuycCD9eiFqIi4qTAlVB2MNViXDLGhuF5JxnH5X2iEGdIZ9CGpqM0yDB0MKTk33JKqryDZ11moVc/k2V83Dy1EIc4x0in5oDUAqgXHCngTCQ240UJ5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ca/Dp5Aa; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ca/Dp5Aa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778294755; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6sbYWlJN+z4hkTQrsoN7IxSNEeSI4CJC1PosPUP5cnY=;
	b=ca/Dp5AaFaqk+Hhadttqx0NBoSLBGzJXAoCUOC76sSZTOE0R7JItXoZJq+0rDecG4zVpLxVvRoECV189BxUQLieUDt11AvIwnswd3/2i8xaaGCt8HI/YPgjn3ENhXUoqIGlUdRGDiEVkNk/RASVVjYTNCsRLyfMD8bSWsZ0+2Rc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guobin@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X2ZCFg-_1778294749;
Received: from localhost(mailfrom:guobin@linux.alibaba.com fp:SMTPD_---0X2ZCFg-_1778294749 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 10:45:54 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 1/2] kvm: remove redundant check in kvm_close
Date: Sat,  9 May 2026 10:45:38 +0800
Message-ID: <20260509024539.90998-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260509024539.90998-1-guobin@linux.alibaba.com>
References: <20260509024539.90998-1-guobin@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kvm_close(), the condition `!kvm_state || kvm_state->fd == -1` is
checked at the function entry, causing an early return if either is
true. Later in the function, the same condition is redundantly checked
again before closing vmfd and fd.

Remove the redundant second check since it can never be true at that
point.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b..70bc2c86a2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -769,12 +769,11 @@ void kvm_close(void)
         cpu->kvm_vcpu_stats_fd = -1;
     }
 
-    if (kvm_state && kvm_state->fd != -1) {
-        close(kvm_state->vmfd);
-        kvm_state->vmfd = -1;
-        close(kvm_state->fd);
-        kvm_state->fd = -1;
-    }
+    close(kvm_state->vmfd);
+    kvm_state->vmfd = -1;
+    close(kvm_state->fd);
+    kvm_state->fd = -1;
+
     kvm_state = NULL;
 }
 
-- 
2.50.1 (Apple Git-155)

