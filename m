Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4543C061;
	Thu,  4 Jun 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579480; cv=none; b=u6nFnO7UPzLXHpiHxZOuDcFMOfsNm11brLZatOzlGEz9Di2dnsXffAUzTzu/B7SQkPkOayUgZIz9vItcbu+zDUBFY6+B47eX03ss6lfpU0l5jMoJlEbgEU0dX+Vjq7hmM7R99ukXpnDcH/4o1lf8siVo/eJw691Qh6Xkx/WCGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579480; c=relaxed/simple;
	bh=nu8W7twZjz5nIDlkKua2W3bKJV/ysCREgtclmrGqtW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BViTPKCoq2RK11potvfMd2sqtP8x876/hlNhXgb4TcW0ruLbVeaighLPCiBJ5041wFlhFzwzjndajlFnVtjdnWjUweNk8VEW/iHX8EI7YRhoZcuYRoZFh7XHnQzEp6XFV1ptpND7YI9jtNyZrrDTVASPFyXMENpY/8+w2vTQpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S8zh3jHO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S8zh3jHO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579466; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/yMhiuP+Blm+ANy4YIKSZBeqw55+G0nlxi+JWHCA5d8=;
	b=S8zh3jHOwUiHsWACoJKv6JVNLtLsvCrJhu7d8rU5vx/KF3zGLtb1Nh/hf6/HYTJmmzWegcdwPEau4KHnNF3l1Xxyhj+9K3FduVHeyyfmU6dueM48fHSNdOk3/ywVcZ0Iit+2ojKOwysy2GBLUO+DEo08Pa3Uz/zg0hwt/OWsYRg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnWu_1780579463;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnWu_1780579463 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:24 +0800
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
Subject: [PATCH v3 1/9] riscv: kexec: Reset executable bit on the control code page in cleanup
Date: Thu,  4 Jun 2026 21:24:10 +0800
Message-Id: <20260604132418.15725-2-fangyu.yu@linux.alibaba.com>
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

machine_kexec_prepare() calls set_memory_x() on the per-image
control_code_page so the relocate stub copied into it can be executed
during a normal kexec. machine_kexec_cleanup() is empty, so when the
image is freed (via kexec -u, or because a later step in load failed)
the page is returned to the buddy allocator with its executable bit
still set. Once the page is reallocated for arbitrary kernel data,
the W^X invariant is broken: a writable page also marked executable.

Implement the architecture cleanup hook to call set_memory_nx() on
the control code page for non-crash images, mirroring the
set_memory_x() in prepare().

The crash path does not call set_memory_x() (the crash kernel is
loaded into the reserved crashkernel region whose pages are not in
the buddy allocator) and so does not need the cleanup.

Fixes: fba8a8674f68 ("RISC-V: Add kexec support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2306ce3e5f22..ea6794c9f4c2 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -91,6 +91,19 @@ machine_kexec_prepare(struct kimage *image)
 void
 machine_kexec_cleanup(struct kimage *image)
 {
+	void *control_code_buffer;
+
+	if (image->type == KEXEC_TYPE_CRASH || !image->control_code_page)
+		return;
+
+	/*
+	 * machine_kexec_prepare() called set_memory_x() on the control
+	 * code page for non-crash images. Revert it before kimage_free()
+	 * returns the page to the buddy allocator, so we do not leak an
+	 * executable page back into general allocation.
+	 */
+	control_code_buffer = page_address(image->control_code_page);
+	set_memory_nx((unsigned long)control_code_buffer, 1);
 }
 
 
-- 
2.50.1

