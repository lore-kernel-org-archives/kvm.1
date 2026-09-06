Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6641F345;
	Sun,  6 Sep 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682108; cv=none; b=EUx6o5qTWhuQutADO3oRKItbqnD5XS+yZijOgnFgtMeNA04zXXUh15oXHt2BajciycOsLUlys216yfhLDRx3A6MInQYbwqW/tv+8GTMMsAsLyklalr1bJGMw/cGUKHkDl78muypE6M5XNGwssoz5DT9Cw/pulNmhadODBVpMxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682108; c=relaxed/simple;
	bh=/SsplEHuMFog8UAJ1kZ8XL2L15XWlrnO8ZzeE6VureA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KyWmDHVuXdxxEmP/fvTzSAfzAASrkiWmyW2zcvc/X/r8RRCiHW4llpk4itHJ5vQufMAzl2+eWsX7k4MZ8hbEkZ7obxB/RI7jW2rJ1flsVJs85ou8sWNomNQyc/TA7tqmdy0oApAdDsobehWmyy/sP6kFFXq7Ww9FOlcl5IG1UfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lA/dXTTF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lA/dXTTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
	MIME-Version; bh=H//yKEWH7uGYDzEIgQa88pwd64vRhIeJuk+RkZvLUtI=;
	b=lA/dXTTFCjPe65etT7koqz9kRmupLUgpvW6BXTuY/YxmF+W8aFViggbL/4KEQ2
	mmecpRDNAhbObe4NvO4FmbqC+EFd1mI8suFdthRK176zJ66DcEU7UdA6L9h8UBKF
	RDJAxV/dtg60JJTHfu50BDvTnVaROnRbsvFRN3/cTvCQA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn7zMxH51qMxYMBA--.25025S2;
	Sun, 06 Sep 2026 16:07:14 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PATCH] RISC-V: KVM: Publish NACL HFENCE configuration last
Date: Sun,  6 Sep 2026 16:07:11 +0800
Message-ID: <caplitmus-rv.c91c005b844342d9a9f60949b04c520d.d65@163.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7zMxH51qMxYMBA--.25025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1xXw13uw15urW8KFyDJrb_yoW8AFWxpF
	ZakrWrKr1akr1fK3s0v393uryrWan5uFW7J39xuayjvwnxZ3WrX34vqrWUZa45GF4kZa1I
	9ryY9FWjkFy5JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRdhLbUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxhLVnmqdHzIH7QAA3v

The SBI NACL interface requires software to write Page_Number and
Page_Count before publishing an HFENCE entry with Config.Pending set.
__kvm_riscv_nacl_hfence() currently stores the pending configuration first.

Write the payload first and order those stores before publishing the
configuration word with WRITE_ONCE(). Use a write barrier that also
applies to UP kernels, since the consumer is outside the Linux SMP
domain.

Keep nacl_hfence_mkconfig() unchanged: setting Pending in a local value
does not publish the entry. The shared-memory store is the publication
point.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: d466c19cead5 ("RISC-V: KVM: Add common nested acceleration support")
Assisted-by: GPT-5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---

diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
index 9aff03c4..c5c4907a 100644
--- a/arch/riscv/kvm/nacl.c
+++ b/arch/riscv/kvm/nacl.c
@@ -5,6 +5,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/vmalloc.h>
+#include <asm/barrier.h>
 #include <asm/kvm_nacl.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_nacl_available);
@@ -42,12 +43,15 @@ again:
 		}
 	}
 
-	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
-	*entp = cpu_to_lelong(control);
 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
 	*entp = cpu_to_lelong(page_num);
 	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
 	*entp = cpu_to_lelong(page_count);
+
+	/* Publish the payload before setting Config.Pending. */
+	wmb();
+	entp = shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
+	WRITE_ONCE(*entp, cpu_to_lelong(control));
 }
 
 int kvm_riscv_nacl_enable(void)

base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c

