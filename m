Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEE3BD63A;
	Thu, 16 Jul 2026 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187562; cv=none; b=t40KutfbIYV8UM6naJonUlGsBmJwIz6kss9fjICcurjVuJC4yRuShAQKVbU2Hhypv9MJAfkVKH8kgscYPTkwvVUcDl0sKtlgXRMpg4KfjSiBHLTq6oiqBYgwkTxiozn7YF+KcCnc7HZidM06ncCmOVQ33L8xXpusbzsQ4dIb8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187562; c=relaxed/simple;
	bh=zyrLfzWQaKc9gapHtEKpwLe0w9arwGPB8VIsXpBv1QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VokfL0qkWM+RdxD9wMUqUSeyH7xDdmccEAKk2A2HUTxcudsvfQzYh1rQfRYtAb9wZwxlE/q1IW2D0WZnveP4BsGtxNT1jCxkXz80HSJWOr9gVcpOxUAJ7fp3MUzfxGXD00PMll2Jvos6kd7ZTlBwZJmOvrJr+BAuotxgy4LYxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BpfmbnTx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BpfmbnTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0J
	XU3cAUzaSbuwG+IlW2Ctt3lxfI9p33+cxpVmrZTCY=; b=BpfmbnTxJjIhkGOMH4
	evePfG+TieRPYpeMG7SNLkqTTeuA1k8xRJmqZbjG3CM+xyanBeAa10dvjwGALRw+
	d9mtF3Auf40V8cyk4QvabMEiBdgZdaPWrHZZZaOkHyE6oZizvbxxf9f5IUylarnS
	3z5yiL4qxscG9vju/XdDlscS0=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBXvgNdilhqW6A9Jw--.32504S2;
	Thu, 16 Jul 2026 15:38:06 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] KVM: riscv: Fix infinite loop in NACL hfence entry allocation
Date: Thu, 16 Jul 2026 15:37:56 +0800
Message-Id: <20260716073756.44153-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXvgNdilhqW6A9Jw--.32504S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWrGFy3AF45Gr1UAry3XFb_yoWDWwc_C3
	WxX3yxWrW8ta1jv3Z3Ww4rXF4aya98C34DGr1Iyry7ta4Fq3yaqa4kKw1DGryUAr45Zasx
	Jr1rXr13Z3ZrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jiiDUUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8x5qFmpYil75OQAA33

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

try_count is initialized to 5 but never decremented in the retry path,
making the `if (try_count)` check always true. If all NACL shared memory
hfence entries remain in the pending state after sync, the function loops
forever, causing a soft lockup. Decrement try_count on each retry so the
fallback warning and return become reachable.

Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support")
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 arch/riscv/kvm/nacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
index 6f9f8963e9dd..9aff03c4f667 100644
--- a/arch/riscv/kvm/nacl.c
+++ b/arch/riscv/kvm/nacl.c
@@ -33,7 +33,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
 	}
 
 	if (ent < 0) {
-		if (try_count) {
+		if (try_count--) {
 			nacl_sync_hfence(-1UL);
 			goto again;
 		} else {
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

