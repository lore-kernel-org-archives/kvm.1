Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06165413249;
	Thu,  4 Jun 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579473; cv=none; b=TVjowMjLo/4BY91fLLRsaItBodtjfTGyl8IUEnFQz/Wa/x7rARbPv8LRI+wTbMwS2DfmZw6fTZyTjNyMiI8LmvktjAq7cDpM0pKb/mXQRXFmeKxtWWW9mN9INQ6B10ZFq92EJAFLEYNP++mOdRK37X4bSdDoJGFxOgKTEm9HO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579473; c=relaxed/simple;
	bh=pMTKys86GxKDFNgEwsQfuE/mmVXtSkokNA5fOFy507s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRrOsm4oK5qpzOYrzhC7aA69RP7FcxdrUrsCWwG3RjAJgnz6PhON4S5+Fj7bEoWBwZXt37cKQae1Os5msiNrcjA8KgVASKnG1zlI5g76pjxTSF/hBFh8ANfk8TEhXrm83Nkol40QDuvPer/Oc8Pzs+yjwZQT475hC/nlgIkCKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gv387/lI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gv387/lI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780579467; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hnfOs1moHlmKQb6ZUmVUxruUKOqYR4tMlxRWD85j61U=;
	b=gv387/lI93YGi5suqcoP9YqUaspV2zSgGvO1xWDbPe0wEyOXkwaeFEPA3TcYDGDl8iUUyVa7NPv1npX1C2Gb57dtAno45T0SpXgEKXpZ3w/XUzxmFgoESTKlWxj7fB7d7TZrNxiuXBR+e2WAimVhEqm1wIreLREaGeLDijqXKTs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X4AKnXP_1780579465;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4AKnXP_1780579465 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 21:24:26 +0800
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
Subject: [PATCH v3 2/9] riscv: kexec: Bound FDT search by source buffer size, not destination
Date: Thu,  4 Jun 2026 21:24:11 +0800
Message-Id: <20260604132418.15725-3-fangyu.yu@linux.alibaba.com>
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

The FDT search loop in machine_kexec_prepare() reads sizeof(fdt) bytes
from segment[i].buf to identify the device tree, but it gates the read
on segment[i].memsz, which is the destination size in the next kernel.
kexec allows bufsz < memsz (the loaded image is zero-padded at the
destination), so a caller can craft a segment with bufsz=10 and
memsz=1MB:

	if (image->segment[i].memsz <= sizeof(fdt))   /* 1MB > 40, OK */
		continue;
	memcpy(&fdt, image->segment[i].buf, sizeof(fdt));  /* reads 40
							      from a 10-byte
							      kbuf */

For kexec_file_load (image->file_mode), the read walks 30 bytes past
the kernel-allocated kbuf. In the worst case the trailing bytes fall
in an unmapped guard page and the read faults the kernel; in the
common case the read returns garbage which fdt_check_header() rejects
and the loop continues. The plain kexec_load path is shielded by
copy_from_user(), which validates the read against the user mapping.

Replace the memsz check with the bufsz check, which is the right
bound for the read site.

Fixes: fba8a8674f68 ("RISC-V: Add kexec support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index ea6794c9f4c2..e6e179cffc44 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -38,7 +38,7 @@ machine_kexec_prepare(struct kimage *image)
 
 	/* Find the Flattened Device Tree and save its physical address */
 	for (i = 0; i < image->nr_segments; i++) {
-		if (image->segment[i].memsz <= sizeof(fdt))
+		if (image->segment[i].bufsz < sizeof(fdt))
 			continue;
 
 		if (image->file_mode)
-- 
2.50.1

