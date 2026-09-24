Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407237E2E2;
	Thu, 24 Sep 2026 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229849; cv=none; b=ncjH2JQqmFOPJLUUFDfp8aCDPzr2/klRH4KkcATn5LzUcJ9532JjFRbKFXlYHwSK/4gtKCwtylWMdsFgGM7uW2S+ettNadebWeFEvmoYLxZHwjzpHDOV13c0fPnrBrJ6xAmv2BeWCQYsYhYSOiRj5E6+EY9KZwaEDZgx+Dwx0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229849; c=relaxed/simple;
	bh=8OIggYykPpbqH0cNgvDs8tkmYEGFXAtwdGTiVl18Qbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W92GwF5giPRUWyKmhFDDy/Q3IHVChfhYRRTn7vzwEhZyBkH+jOKkc/KURfV8K9Fy4s4D/Iw6Q+Lq3kiS68fgILCFjVCt6cy+9t2ZjTsJ+5V8L9/wRdPLiLXbphHXsSBT2dtcpr94e3iDXavK7XrwnyRQuYDy6gSugtwbb0D8kMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ttgRO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ttgRO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF41F000FF;
	Thu, 24 Sep 2026 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229847;
	bh=r85Nf4Srb/iBhnlbT0L3eStB1iPLgO4vX4v+Ock+8jo=;
	h=From:Date:Subject:To:Cc;
	b=I/ttgRO4a5bMMWnm/y3e1sP4hi2WGbt9DePQDXc8NPj2KY2amjK2aqloQjFBK7jUS
	 mRWkN1RFvjHxLpfmv1d2dJwEpHWC8oH+ONCKN9Cq1D+AqNRgq1AfOJH82vP05g54JY
	 6tPj68kqZkeG1TD5GgnsLNP/veY173h7HbdbfEEAer2eO45y6H2+dffju1kzmPqd/d
	 d/lqnAsjZmbbqd+McD/HZ29GmtC7i3kfifvrMV7Oop6R2hLIhZxIqPZSWoF6vt6uRG
	 QUrW6cMMo0mMD+HGL8moXHwum7vC0/hEiqgrDAPgrkagxD5IylvQdCKGWSRz04scXO
	 yPa/aU68oJ8vA==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Date: Thu, 24 Sep 2026 06:03:49 +0000
Subject: [PATCH] RISC-V: KVM: AIA: Initialize per-CPU HGEI free_bitmap only
 once
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-free_bitmap_initialized-v1-1-4cfb73a0d04b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAES9tGoC/yXMQQ6CMBBG4auQWdsEGyTgVYwh03aKv9FK2mqMh
 LtbYPkt3pspSYQkOlczRfkg4RUKjoeK7I3DKAqumHSt27rXjfJRZDDIT54GBGTwAz9xio2zfcM
 n3XlDpZ6ieHy38+W6O73NXWxed7Qsf6JY0Ut7AAAA
X-Change-ID: 20260924-free_bitmap_initialized-abdc94a528fb
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

kvm_riscv_aia_enable() may run more than once on the same CPU.  The
per-CPU free_bitmap only needs to be initialized once, from the HGEIE
width discovered on that CPU.  Perform the HGEIE probe and bitmap
setup only on the first call, and set free_bitmap_initialized after
the bitmap has been populated.

Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
 arch/riscv/kvm/aia.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index b3b466e4db33..a65748321f7d 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -610,6 +610,9 @@ void kvm_riscv_aia_enable(void)
 	lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
 	hgctrl = this_cpu_ptr(&aia_hgei);
 
+	if (hgctrl->free_bitmap_initialized)
+		goto skip_hgctrl_init;
+
 	/* Figure-out number of bits in HGEIE */
 	csr_write(CSR_HGEIE, -1UL);
 	hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
@@ -634,12 +637,11 @@ void kvm_riscv_aia_enable(void)
 	} while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei, hgctrl->nr_hgei));
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
-	if (!hgctrl->free_bitmap_initialized) {
-		hgctrl->free_bitmap = (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hgei, 1) : 0;
-		hgctrl->free_bitmap_initialized = true;
-	}
+	hgctrl->free_bitmap = (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hgei, 1) : 0;
+	hgctrl->free_bitmap_initialized = true;
 	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
 
+skip_hgctrl_init:
 	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260924-free_bitmap_initialized-abdc94a528fb

Best regards,
--  
GUO Ren (XuanTie) <guoren@kernel.org>

