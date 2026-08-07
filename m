Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAF3AFD0D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086634; cv=none; b=Q9j1szLruZRyke3KnXDE+wu6lsP5wcamdVrByU2nYWK57oz/Nu/rj1MCZuUJzQLlLj0yPRIxfm94W7MwaVsXUGf0G1T8yh1sDY31n0+tOo61MP3XGkQR46GjNPvVl1tawh+3XoqLJWK7ktTLQJqDCjpvzm7u7QSv+wC/1oBLrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086634; c=relaxed/simple;
	bh=IAgQobVEQ0CWQcCIqZTlDhgLxtmPcEiR8bt94FC10is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFOvJIh2McO7eOWjU5hpXxWRYiUsVdb2xqiXa7cAiC1vKmmqpXqGprr9zyViEWG/VsRz18xXt26RUtzs6273/Hx80G1U2047uLTBXlqDF9FZPJa9sDU98VGgHP6UecpZ53B7bm79Im2H8RDdY0Wb6niOIiOjBJXa9ochjS+zi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzhEskIj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzhEskIj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2691275a12.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786086633; x=1786691433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NPzl1sllQPeAew0/T4KJhPua2DmqJee68WA88kC38zk=;
        b=EzhEskIjWl8fva57CgIzoxFvd043lv3Nl6E9MviHXT/y79n6BInwiff04k1j4zkgHj
         Rj7PMg0M0GNhh0Pz4oeOH5VUmvb+mhNh4L6wwK7V1AKunK3HCGDknIQ934/8y60n9q3i
         udFQn2kQFgsCFpki9VJ8ESMfeXx2vXd8YGfe9GWpnSd+qCSQ6qlI39VxG1R38Q9oIF+A
         qhxDGddeX36t8j9baVfEghGCRQcVFYzKyV3kByZ30hbSqsMtBjxU7YY0EAtgThMqc3RC
         5tB61bchZyxOEoCiBzzFC7epBYOC2VTNaa/M3dKU4walYC5sWEKuEMcCQPXS8a+geYTX
         2YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086633; x=1786691433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPzl1sllQPeAew0/T4KJhPua2DmqJee68WA88kC38zk=;
        b=s/losjOPzpMmPjUTxXfloH+pocMHzWGIqJq7t8a5byiqpzAynN64ImZtiZsgea2ANq
         mXJgeNN3/3kE5rXASfuxwuFqs77CihbhMLkNv9vD7sIQxW5YsrORQs6Dg9A4a3UJ2Tyr
         tUGNdELgSAk/OdCD2iVuR3c8sRS0gQTWuP4gpMGUWUc2SqPLygpxUfqrlYnmYIoepm88
         A0MM1GzmhHYrG2XvYn+eB5kDRJYckKFC7N1JCD4DAELrgS45wYP0Jan8Va1Xnwdc+rnO
         rIc90lsNuq9ubDyTbfRzRgTLYTlI3Xar3E8rK6HiwtMVbSpI/tPlcqEmMLQd6wBNDmaI
         yZbw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Ay8bgoaqeGGkIz8CnL422nsD/w/re8xUSq7fI0GTBwkCL/UXx+5gkKMDT8+vKuUawnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO9PEVSt0emULtAI3Is7/jRByCj6xPd7nqkWkRjvZYDGZjTpR
	JKyd9UA+lbkimrulbsFTtmRzhIV0ef0xdoMBuh+u8AXu+XrkCloq7CWZ
X-Gm-Gg: AR+sD10ddfoJIsxk52PtNHfX2QfCMKtlEGBx77VK+baOqT9GnyjSLjUwNRTjrvgrYkm
	eETsHZdSsKJ6J3xOpd4UjBneja/9TfNWbUZCUHqWvtyBcYpCm1ejbTnt/F0GjGfLfZzNiWm8UEK
	q3EX+qMAlvrMgje/+5l0r/0w8MiER3+GvO1rF9VcvKBTJSmEz/Iob3a8WQJLUM/fz4skNnAXyBa
	o4lJXaXH4PKA9GY1KsOAqEiwy2jYIK8pSqWskg91ooOaF80fXKNjPv/EaXc6n7Cz1J72vYLobqv
	uouXW4NM9AxEyR31klWNmpPYjpJ5ls+HAoRIUFwrcwe4egmMNNcp/ZrgeXrl5Uq45PCHsiiqnNT
	ygXO2JDKU7WXTwLTErpVQwRrE9aH0ltTlPYAozPBsNGiOD3yrJ66iRuSv1X7bXV3XuencdovMRj
	jKFKAAzwEpzk5SUFEg8S6R+LTlNLYpc9kuyFlVD4DFkCZt94oU6KngAgqxIQrXzV4ojAkb9mun7
	BfmpMiErnXH
X-Received: by 2002:a05:6a20:7f9a:b0:3c3:875d:c538 with SMTP id adf61e73a8af0-3cb85dbce51mr23474608637.8.1786086632688;
        Fri, 07 Aug 2026 00:10:32 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a706fsm4079878eec.8.2026.08.07.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:10:32 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Compare the entire XSAVE buffer in the SEV smoke test
Date: Fri,  7 Aug 2026 12:40:26 +0530
Message-ID: <20260807071026.195503-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compare_xsave() stops at index 4094, so the last byte of the XSAVE state
is never compared.  Both buffers handed to it are 4096 bytes: the host
copy is a struct kvm_xsave, whose region[] member is 1024 u32s, and the
guest copy is the PAGE_SIZE shared page that guest_code_xsave() runs
XSAVE into.  A VMSA synchronization bug that corrupted only that final
byte would go unreported and the test would still pass.

Bound the loop with sizeof(struct kvm_xsave) rather than an open-coded
length, and make the index unsigned so it does not mix signedness with
sizeof.

Fixes: 8c53183dbaa2 ("selftests: kvm: add test for transferring FPU state into VMSA")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6b2cbe2a90b7..c7af27954356 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -90,9 +90,10 @@ asm("guest_code_xsave:\n"
 
 static void compare_xsave(u8 *from_host, u8 *from_guest)
 {
-	int i;
+	unsigned int i;
 	bool bad = false;
-	for (i = 0; i < 4095; i++) {
+
+	for (i = 0; i < sizeof(struct kvm_xsave); i++) {
 		if (from_host[i] != from_guest[i]) {
 			printf("mismatch at %u | %02hhx %02hhx\n",
 			       i, from_host[i], from_guest[i]);
-- 
2.54.0


