Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2E202C46;
	Tue, 26 May 2026 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799823; cv=none; b=cd2oJPRfemkXC2tIr8jVicmyYAMWN4VXcV8KrCsyo/ygMrH3c3Fa1tsCTF8w490yPo9m/zqhVO2ot4ilOJjUhGfcvQB2TeoUSNJqNbiKA+MwnhcnA1MwXe8YUWNLvqQ/YeMaEIrdlQr7uEjBfJEoBtBFyRTKvjxZVqLsAcnPHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799823; c=relaxed/simple;
	bh=egfNQSBf1Qu2mK+lLwDnemHrQkPtBEWsLzEju3StLqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGteE1sA6h5mycvYn3u4E/wCkAOwzKVDjKiuugk0A9sXH4KxbpsVtJ8hm//K3CDAKK9ak+UKT5hGjn90L/n1Qi1euFNupSP7n15k+/cY2NtTW5RwHiKGaIDUJdo3qTenARNxjTja+xywznk1NtcBiD1dy59sSHTO9Z7mxZnnUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jgjm/ghw; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jgjm/ghw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799817; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4YSxzzA490KamtxaOd7dYYkwJkuqZylRfAB7NDmYOFI=;
	b=jgjm/ghwc2aLd//UjUZEbhWgOsofqTcaBKX1e9sfZA9cD3WImJ1gRY41rTTRyNjhohGmYV0ReQ+cFyv54kAE9Bt/OuRUuFSOonH2KVdbnTNiWYF3A1JJL76V3PEo3Yyg3Z0WWViy7OzyeFsQh6jcY3CTAt94oq3feAp6zvrDjKI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNK2_1779799815;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNK2_1779799815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:16 +0800
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
Subject: [PATCH v2 1/7] riscv: Add kexec trampoline text section to vmlinux.lds.S
Date: Tue, 26 May 2026 20:50:03 +0800
Message-Id: <20260526125009.2404-2-fangyu.yu@linux.alibaba.com>
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

When CONFIG_KEXEC_CORE is enabled, add a dedicated .kexec.tramp.text
area to the RISC-V kernel linker script.

This introduces a KEXEC_TRAMP_TEXT linker snippet in image-vars.h and
uses it from vmlinux.lds.S to:
  - align both the start and the end to PAGE_SIZE
  - define __kexec_tramp_text_start/__kexec_tramp_text_end
  - KEEP all .kexec.tramp.text* input sections
  - ASSERT the trampoline text fits within one page

The end-of-section page alignment guarantees that the trampoline page,
which is later identity-mapped as PAGE_KERNEL_EXEC, contains nothing but
the trampoline code and padding (no shared neighbour data).

When kexec is disabled, KEXEC_TRAMP_TEXT expands to nothing.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/image-vars.h  | 14 ++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S |  1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 3bd9d06a8b8f..35ee3f059afa 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -34,4 +34,18 @@ __efistub_sysfb_primary_display	= sysfb_primary_display;
 
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+#define KEXEC_TRAMP_TEXT						\
+		. = ALIGN(PAGE_SIZE);					\
+		__kexec_tramp_text_start = .;				\
+		KEEP(*(.kexec.tramp.text))				\
+		KEEP(*(.kexec.tramp.text.*))				\
+		__kexec_tramp_text_end = .;				\
+		ASSERT((__kexec_tramp_text_end - __kexec_tramp_text_start) <= PAGE_SIZE,  \
+			".kexec.tramp.text exceeds 4K");				\
+		. = ALIGN(PAGE_SIZE);
+#else
+#define KEXEC_TRAMP_TEXT /* nothing */
+#endif
+
 #endif /* __RISCV_KERNEL_IMAGE_VARS_H */
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1f4f8496941a..fc7758e5b819 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -41,6 +41,7 @@ SECTIONS
 		ENTRY_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		KEXEC_TRAMP_TEXT
 		_etext = .;
 	}
 
-- 
2.50.1

