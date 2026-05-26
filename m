Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD932232367;
	Tue, 26 May 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799828; cv=none; b=nYV0a+G0NVbxXft762h0b90ryhgR3CHhqkZi+P/QfABFF0NSKHoyIXkB/RI8laF8+BOHFJbLx7uqAcTHgEiB20jIsnu/A2WMGC5dBtJDeg9R6ecAlJqG2aRKXgi5YsqPyNUSiRiEG8A22Ipx5Ey6Rmusq68qFaQA4wFzlelY3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799828; c=relaxed/simple;
	bh=OabSIHlhBI+gs0l14rnJPaYDr6JxhQuybSZmq4WT3+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j86KGE1s5OnqOgwXNAisR7uneO9/9Q1b35N5v8MFqV8TDqXdw/GP+NY3Jw3yTcEfC561/kEjPKvb5b7YYT1nW10HlTwTX23mdtNqd2bdDGBro2LaWqf5lSd++DLvaYle9jWzuRMD2cKlur7SvEDSnvkb12bTuEYgxFDvw4BBZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s9D7TcgS; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s9D7TcgS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799819; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4g9/cguTkXnZOmW3mc5bH5fjRguARWthM2VYsbDUHZY=;
	b=s9D7TcgSGll+fJ0dDaN5t5dXM5TCl/eoSWxoBazRsAILL0SQf2TkDnCA4+2+LB0WFLd5m2az7pl8+9O7o6OWYs780KNKuzNUxKzHjayKvgA8/yt5M7PrTCf4onXwIT0i/sqFfGjZUP6jQGRpEEaJ4bD1PEM0NSUBP8eIbtKm0yw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNKJ_1779799816;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNKJ_1779799816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:17 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2 2/7] riscv: kexec: Place norelocate trampoline into .kexec.tramp.text
Date: Tue, 26 May 2026 20:50:04 +0800
Message-Id: <20260526125009.2404-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
References: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Move riscv_kexec_norelocate out of the generic .text section and into
a dedicated executable trampoline section, .kexec.tramp.text.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kexec.h     | 4 ++++
 arch/riscv/kernel/kexec_relocate.S | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index b9ee8346cc8c..6466c1f00d41 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -75,4 +75,8 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 			unsigned long cmdline_len);
 #endif
 
+#ifndef __ASSEMBLY__
+extern char __kexec_tramp_text_start[];
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
index de0a4b35d01e..af6b99f5b0fd 100644
--- a/arch/riscv/kernel/kexec_relocate.S
+++ b/arch/riscv/kernel/kexec_relocate.S
@@ -147,7 +147,7 @@ riscv_kexec_relocate_end:
 
 
 /* Used for jumping to crashkernel */
-.section ".text"
+.section ".kexec.tramp.text", "ax"
 SYM_CODE_START(riscv_kexec_norelocate)
 	/*
 	 * s0: (const) Phys address to jump to
-- 
2.50.1

