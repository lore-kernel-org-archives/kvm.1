Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E153163E
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169806; cv=none; b=Z0fHw07Mwr8PzKSZ0zukERyTrmMTxCBu9YVTPnG9LOS/kD9G6jumhoh7iGnC/tl0FnDf1AUQnu+A2cVs6vEhJ3BTqMtuMRcMyDcLzFjhZdZm4/q8W+1NWqxlxChd7W1jZy96dMXm4Y/jfmo8ME/9R7llyHTNWQ6GHfGvS6D36lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169806; c=relaxed/simple;
	bh=Zx0Ui0gYilVzk+9YDFkdqNP6yggvnqYC4z0EOLvwy6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5uZ4IRyHtS2MbZneswwYnxdrtkggM4OKFvK0ep3yBai++qNx6OeieUZr4LRXUapuYvl1vITCNa6V+7jyBzfogD/ltNfJ5gIS/HvLoedaF/0E/t4qJHS7iDpGW4ZZnWl3Fy+b1e1ZfuXOHOKJC4CaQ2pfV9eVtYfWTag2xt/HrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+z7UAFT; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+z7UAFT"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so1029990eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169804; x=1790774604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+o5KblLu0GyQgfzLlM1cTvsfq0uChm3NLiJCLhEk08=;
        b=C+z7UAFTEjHifK8BhCteEyyolJU7i5KtSjTrxYNnTJ/ckJRz8AyHeCkuAPTLvTN5RZ
         oI4ou7IJME4SZhrhViqwaEReSjojbWJIlVjeym6zut9j1y6nz1bf7i0HvIb+TVo4kmOu
         H8CklNB5HdUzPvVq71NfewpHcuz+DrP5J61jKTsMHW0jLTWoNrL34iiU1nQMp1W18dGz
         Kqk1deAHDKH+B3fCiCFEIvxMUtHBCW7okPx7wYEFYkmqXFph3mYGdOXLr7GN+gxrl3b9
         GuZuiJu2+3pJCVlGMs5BGE4mi9L7OBSYpFzbU6MiTIL1VUacC8gouxkALDPiEoP1abs4
         egig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169804; x=1790774604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+o5KblLu0GyQgfzLlM1cTvsfq0uChm3NLiJCLhEk08=;
        b=2mZklQO25clqbMCSUfgLPCtSDe40dGMMf+lQKNXPHcLXBcQHM7gxqDVqEtlbxrxTkv
         W+WlQ+4QvbMGUZRTIHlL9ZV9cmv1qV7xYoZsSwQidgznv1XthukZOSCMdq77U6yvwn5v
         LJFY0y3NPxkuOR+bvuHT7/+vPiYZiyK/rYQKaMEBmmXRlvOiTlSPmbyrYoimwDu8TGc2
         pb4DCnuKnALolI9bQU4b0qv6uYibj1LabSqT2qLWuutXa1gDz0r1guO09rORfCNulxVV
         EBO6fRZEuurJaj97zvh/yZzrzS6JK1rjCoe1WQgSlKxFT3lEv1I/jPQNEi8zQBGc7bdT
         N8ag==
X-Forwarded-Encrypted: i=1; AKwUvBw+5VwnrJKnJsQ+Q8CqJ+hV54FrlL8UYwdDPFGXf4KYnUByFlCRMa4tKZ3vN/l8Sqy1hHo=@vger.kernel.org
X-Gm-Message-State: AFuF++lJGCjcwew6SH+C33YmqMrfWVai6lFSqPqW1jvQ/T9b3ucvd9+I
	Odv4jh9xh7KtMyudgfW9ac4pHbei9fHIOTPUCNENcE74e61l9Gm1bU2h
X-Gm-Gg: AYBFou2HQoJka40dnRcizw3B677uLbhv9sOLsB0hnAFd2I4JyUTlO9G8QNp2G76t+tQ
	hWKrO1WWt6LqdZp3pS+PtCO1v+o2Qwz4yeqTvk8bVnhjdoM5e62Cmjf3COxupDj2s7/7Ikn+ci3
	rXWuyd49cL1dvhOTEKzpVhxb8/GZ2CywElfz+lb9Cme4ue03TRQ0BikSDT0XTgIm89/S0btSbST
	sv87fQmu1iNyV6yw4hh6O5rT8yOl8mSrm9exbLSlbj+CsMWpdvbWQgRGazeO+aAh1XO8PiNFqtH
	6kRG6R8G2IMQ6+3WjI8u+INEQvMv9TUZppSAyFdV0SrnlGYX2t9Z9sKvORLsGrjxvbCfRXqB8yP
	6l4As6xceTA7u7LYW5+ycj01+NvLwj7sMYl6vUCVmEjH8Aa+gIN2Ol+dpoe6k/H19mxGGMjjYBW
	CndaIFUhPwdrPgO/OzMgTRLqE3/0SUUl6mY3xEDQSH9aWYdwRy3C0p4EV9461Sg+zBM0Keonpk3
	y4oDIirny/LHozFp4Z0lWACmv1dT/jhaRcfZ0ccCw==
X-Received: by 2002:a05:7300:7b27:b0:33b:eec0:eefc with SMTP id 5a478bee46e88-33e8e88ea29mr2331973eec.40.1790169802984;
        Wed, 23 Sep 2026 06:23:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:23:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 040/114] target/riscv: replace leftover TARGET_LONG_BITS
Date: Wed, 23 Sep 2026 21:15:14 +0800
Message-ID: <20260923131635.1894-41-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Use target_long_bits() in bitmanip clmul/clmulr/xperm loops and in
  the m128 signed-div overflow check.
- Compare xperm element positions to target_long_bits() instead of
  sizeof(target_ulong), which is always 8 in common-system.
- Leave translate.c and insn_trans TARGET_LONG_BITS for riscv-tcg-tl.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/bitmanip_helper.c | 10 +++++-----
 target/riscv/tcg/m128_helper.c     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index 5af3efe194d..db226146054 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -30,7 +30,7 @@ target_ulong HELPER(clmul)(target_ulong rs1, target_ulong rs2)
 {
     target_ulong result = 0;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i++) {
+    for (int i = 0; i < target_long_bits(); i++) {
         if ((rs2 >> i) & 1) {
             result ^= (rs1 << i);
         }
@@ -43,9 +43,9 @@ target_ulong HELPER(clmulr)(target_ulong rs1, target_ulong rs2)
 {
     target_ulong result = 0;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i++) {
+    for (int i = 0; i < target_long_bits(); i++) {
         if ((rs2 >> i) & 1) {
-            result ^= (rs1 >> (TARGET_LONG_BITS - i - 1));
+            result ^= (rs1 >> (target_long_bits() - i - 1));
         }
     }
 
@@ -98,9 +98,9 @@ static inline target_ulong do_xperm(target_ulong rs1, target_ulong rs2,
     target_ulong mask = (1LL << sz) - 1;
     target_ulong pos;
 
-    for (int i = 0; i < TARGET_LONG_BITS; i += sz) {
+    for (int i = 0; i < target_long_bits(); i += sz) {
         pos = ((rs2 >> i) & mask) << sz_log2;
-        if (pos < sizeof(target_ulong) * 8) {
+        if (pos < target_long_bits()) {
             r |= ((rs1 >> pos) & mask) << i;
         }
     }
diff --git a/target/riscv/tcg/m128_helper.c b/target/riscv/tcg/m128_helper.c
index 7d9b83b1b2c..e59a1ffd7a7 100644
--- a/target/riscv/tcg/m128_helper.c
+++ b/target/riscv/tcg/m128_helper.c
@@ -71,7 +71,7 @@ target_ulong HELPER(divs_i128)(CPURISCVState *env,
     if (vl == 0 && vh == 0) { /* Div by zero check */
         ql = ~0x0;
         qh = ~0x0;
-    } else if (uh == (1ULL << (TARGET_LONG_BITS - 1)) && ul == 0 &&
+    } else if (uh == (1ULL << (target_long_bits() - 1)) && ul == 0 &&
                vh == ~0x0 && vl == ~0x0) {
         /* Signed div overflow check (-2**127 / -1) */
         ql = ul;
-- 
2.52.0.windows.1

