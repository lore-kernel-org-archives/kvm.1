Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7E44E037;
	Thu,  4 Jun 2026 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579476; cv=none; b=By7BQrj6T4xGwr0/myC1DgGD7UmLewIQ+3LcP3gljPEX7qPKUT9PhBRSlo5BQ/FqaWg71Ov0SRvejqL0BbYjHUdH/l6g9TFCrws9MUJ/RvEfRvnioXk++QUUUPSvYzbY3jYRjMMUpWb/3+L8SJJisS3xt7yDAwmv1Zk595Qie2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579476; c=relaxed/simple;
	bh=yrZGRcgpP+586LXh4ul6G5gBazpZXUgTFN4htF8QiJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vu46IVW9RhUOGHp4ebGJ8yHAqXIoh2fVz6qWz3/e0TRrZv98Ka0MUg02dJ5RJtO33rlPVw4ly0GslD1WY7Ailds/GjzLctbxsqNkiDLGQrGEZCtgLNOJfkwqwOaHnaXyr5JcYBj7q9T4erbadu1M9ChMO8hbbPaNGt9CrsVlAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hePjELNL; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hePjELNL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579469; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wGJTJ/FaZhfGglBz44gxrkrG5R80OdCp7c0qc5/blwo=;
	b=hePjELNLQCnP7kuoBUge4nzvf0lfBjeKOuWzWw7K664wXv9h8aYjndJzIumjfRXgzw1/417tQJGVKlsFfY1uMXjefrRz+y5lqXI2EGII6goDdMLUbnFwRm4t2UCASEapFAgpusuIbTIszTM4l3sptN8y2nSB3s27YtqPx6arqMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnXk_1780579466;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnXk_1780579466 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:27 +0800
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
Subject: [PATCH v3 3/9] riscv: Add kexec trampoline text section to vmlinux.lds.S
Date: Thu,  4 Jun 2026 21:24:12 +0800
Message-Id: <20260604132418.15725-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-1-fangyu.yu@linux.alibaba.com>
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

Extend vmlinux.lds.S to:
  - align both the start and the end to PAGE_SIZE
  - define __kexec_tramp_text_start/__kexec_tramp_text_end
  - KEEP all .kexec.tramp.text* input sections
  - ASSERT the trampoline text fits within one page

The end-of-section page alignment guarantees that the trampoline page,
which is later identity-mapped as PAGE_KERNEL_EXEC, contains nothing but
the trampoline code and padding (no shared neighbour data).

When kexec is disabled, the whole block is excluded via #ifdef
CONFIG_KEXEC_CORE.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1f4f8496941a..bc615f7b702f 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -41,6 +41,16 @@ SECTIONS
 		ENTRY_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_KEXEC_CORE
+		. = ALIGN(PAGE_SIZE);
+		__kexec_tramp_text_start = .;
+		KEEP(*(.kexec.tramp.text))
+		KEEP(*(.kexec.tramp.text.*))
+		__kexec_tramp_text_end = .;
+		ASSERT((__kexec_tramp_text_end - __kexec_tramp_text_start) <= PAGE_SIZE,
+		       ".kexec.tramp.text exceeds PAGE_SIZE");
+		. = ALIGN(PAGE_SIZE);
+#endif
 		_etext = .;
 	}
 
-- 
2.50.1

