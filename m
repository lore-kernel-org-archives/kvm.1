Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2952FE35
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169788; cv=none; b=H9i21oaR/ZhDjp8jfdQxYtEPlWmVRbYkHS92x22QVLmNdX0qrcXMBr8hIWGklJEi1vNT8Qj+apA/jjLDbWlXWv6ftvLjhp/4OsxTELFP1/s93JO99EbpJ0qx0im3iiU4HYJdDmHL3aq7LgEGa1zaHIAnX75N6u+Z5Y9hg2rgA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169788; c=relaxed/simple;
	bh=MbDQB6HN5ojntoT7o4p1HD0PolpTednELR2bdRYTDdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiPlCxHL3Ilcu9ihdr+Br/7HPHcyayo+V9LBxN97vPVmzBxm8F7zO0DUPdFWu80mc42TL49ZS0zxd5+VZX5Ug9Efo4IapDfFU+RoJ9vqcRj77cmp8w+QOJgBQrOdL/Fdty04Ly4E/uqwiz5gl2hfZ9wFaQZJ/8ZdlRjH4qaZbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNHOwfht; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNHOwfht"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so1049878c88.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169787; x=1790774587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9wmWDAGxCIEbiXb+JeTWZOg+WBaBPZDk+tkeJy0Fzg=;
        b=pNHOwfhtB8nuHI8wvgDgzIPzbQFTaVlWP17c85qdvMQLs/FVajj5+LfpceQ4Z1e9uW
         0uV9U5pfor8rBl3Rg3Dns/R9vF7Gk+5NHX4Hg29LJT/dBfqxslmyLcpsfBjTfqHcG3p1
         FoDo13wz1OBJq0D6UCTWmL0hK3vMTWzfVomT8+AAedohQc396uRnaa+Ba0BOf9ihfaDG
         8SBQdE8VZu9WlUVzmy+qdlIlp9yU+xbmdjCpumesTFbHsTNRXucfsIJ+8VT5RDBBMzy4
         6r7CbpEhjhoMi+fUoIBl016xGStpVGaPcvO8DLPpU20gE5FeY0gcsCErOMrfeRjtycQK
         XYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169787; x=1790774587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9wmWDAGxCIEbiXb+JeTWZOg+WBaBPZDk+tkeJy0Fzg=;
        b=vu8qUP+a0qc1DWIdUmkSUkrsHKeVYDq0KPo63cgIwVlo4WmaqDi7BjTJmAuTxNFn5R
         lQdRNuYMTBuDkxOToa/H4AquxlNSDxtZkd9xzZSPToMnDKMOc/JSw4ATDIhDl5kWs/xD
         tlCL+7zSg10YYhRserdfT7Oj1ybkOEvehMQ1D/7PU5Y3sRJ7mTw2I/ayNZoJ8r6FTrya
         51einsFY692bUp7sddSLv/vjzdJfhC3sNhIGkglDSisbFIR/XcBIAmnBk+E0lOTzgeyW
         Gatk5jNRqYi0xMVO1+fKtRImwYCVKjZ0yo2Rnw2DgBWo9R1ZHLirNtnmWG4TCe4CxypK
         U5UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxa/Q3w/PmVSU+eszTu/8TSGBsUcZH+YVmK2lEpVRnoa0oH4IgyXabfN6vINsWacTXkPfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kLjKxN3tKBB/2/lJbUDF4V5ttZxCGFvOMa/W2JMKDh09vbRAyd
	c1xAILASgJveDbDsLIcNo65sgEYApatQ7q3dPMPbI1oHrOzw8GsYXSRH
X-Gm-Gg: AYBFou0T31+M0tzGKvsRTsjOKqS7JJdnkdPzaC4to7CvAYSyLvxTY6/I4NX76Cxjqr9
	CQCEnRhs9nguYrT2Je95k8kejagBzyMHMXp9z8NdudbZX3F/C/k5SsJvuzkY9BPzsUSfXwzJrEo
	RBmwOjV1qwIS6hOm/u4ZRphKjuMxAERFsHuGpF3RSzJ70AsoBSJztdwraZc1sgGIzbVxh+me5it
	pfskWFHBHpg6BaaQJB2V9cUBXZu1O3f9Dswp+cCtqJWKZqfvUubk4QVtVTJeen6IfE+avxmTxvA
	FH3NvEXKJQssfA68p9We7bfh1HOP4oFVKf6VvqaVNPDc13FL2x+Wq+lVrt9NvtgZnxaF6Jbj1ez
	T+dBr6fioD7Pg9e92vvLfqmNdLqvQfPUtvMpRf5xOjzC8rcw33ZCb1hyCfSRdYM/LzTbguuLVma
	IVFCdZRwXGDNhuHHfbcX0MiW41FnWb7bxrwQ/bjOKWMmTELsn3vLB2A9qlZlQyzBA4/qBCogTnz
	whfrCeSEcUPxjN/rMQscaCkRam0uJQH/NdWNENmXg==
X-Received: by 2002:a05:693c:88c6:10b0:33c:e93:764b with SMTP id 5a478bee46e88-33e8e3add75mr2436826eec.37.1790169785754;
        Wed, 23 Sep 2026 06:23:05 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:23:04 -0700 (PDT)
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
Subject: [PATCH v3 038/114] target/riscv: use target_long_bits in pmpaddr granule checks
Date: Wed, 23 Sep 2026 21:15:12 +0800
Message-ID: <20260923131635.1894-39-luoyonggang@gmail.com>
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

- Replace TARGET_LONG_BITS with target_long_bits() for TOR/NAPOT
  PMP address masking.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/pmp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8e..03ee7c74300 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "qemu/target-info.h"
 #include "target/riscv/tcg/csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
@@ -643,14 +644,14 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
             /* fallthrough */
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
-            if (g >= 1 && g < TARGET_LONG_BITS) {
+            if (g >= 1 && g < target_long_bits()) {
                 uint64_t granule = 1ULL << g;
                 val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
-            if (g >= 2 && g < TARGET_LONG_BITS) {
+            if (g >= 2 && g < target_long_bits()) {
                 val = deposit64(val, 0, g - 1, -1ULL);
             }
             break;
-- 
2.52.0.windows.1

