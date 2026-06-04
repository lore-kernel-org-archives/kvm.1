Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0E31717D;
	Thu,  4 Jun 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614308; cv=none; b=UTfDVvHZyJ1YB50MNwa3VO1yOm/3B6uvsnaFA2BABCni7niHW48zz4rQ5ZetetPRw1G24+gBl0eZwjYQoDPjBj+wlH5RLPULcTSjSf+ce3oArAvCvpzU6hyT815Ka/RkKmlnGbGAY3LYzt0yu+XTzm1l4nPixL8ODBTgCYBW34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614308; c=relaxed/simple;
	bh=gGIkRUnsC+Vba6wjSmrUbjUDCKilvayuFyp87cV3Vr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD1e1yreRHV392VF5R1XoTBLCmVCNWMC8O3agRwsadTm6FBthivbRaXKMzvLwBICX+0lHWhabgJfz0OnSfrPpVuK/BKpibT15Xz8gawNjRsm0aZoPPwuHC9wz63RGoiDCQOaaqH44BL5SL5MhUgN+I7mq9BeMKXAdqk9kBCWctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JWmUvWsU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWmUvWsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vw
	XeKstSB0GbnzZJywYDxzZVE02bB56coa++tH6Xf6I=; b=JWmUvWsUWhRUWhvgrG
	mUpTBPvQUiyJlJl4SY6AcOVJOP4thhMdMTfftnpKd6PJo+5GcD0vmU9AcfUcTtQG
	q3w+1jl9V8KmeslOTJlg9djUHxt9ux4QrLhTY0OonghIrr1eI32IUUHKeGejcsU3
	QR3g+SMABNecfP6vNbPtkP1SE=
Received: from wufei (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3H9tJBCJqsfP6BQ--.26783S3;
	Fri, 05 Jun 2026 07:03:49 +0800 (CST)
From: atwufei@163.com
To: seanjc@google.com,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Wu Fei <wu.fei9@sanechips.com.cn>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
Date: Fri,  5 Jun 2026 07:03:14 +0800
Message-ID: <20260604230317.30501-2-atwufei@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260604230317.30501-1-atwufei@163.com>
References: <20260604230317.30501-1-atwufei@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3H9tJBCJqsfP6BQ--.26783S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7GFyUtrW8Cw4fKFWUKF47XFb_yoW8JF1rpF
	sxuFy5Cr1rJFs3CF13tFZ8ZwsxKrs8Ka15KryUCa409Fn0grWUtrn7XrW29rW3Xr1kXrW3
	uFZ0qFy5ur4xKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxgAwUUUUU=
X-CM-SenderInfo: pdwz3wlhl6il2tof0z/xtbC7xU52moiBFXcQgAA3e

From: Wu Fei <wu.fei9@sanechips.com.cn>

The current gstage range walker unconditionally advances by 'page_size'
when a leaf PTE is not found, e.g. when the range to wp is
[0xfffff01fc000, 0xfffff023c000) and page_size is 2MB, if found_leaf of
0xfffff01fc000 returns false, it skip the whole range, but it's possible
to have valid entries in [0xfffff0200000, 0xfffff023c000).

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 arch/riscv/kvm/gstage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index d9fe8be2a151..2b141a78ecac 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -429,14 +429,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 		if (ret)
 			break;
 
-		if (!found_leaf)
-			goto next;
-
-		addr = ALIGN_DOWN(addr, page_size);
-		kvm_riscv_gstage_op_pte(gstage, addr, ptep,
-					ptep_level, GSTAGE_OP_WP);
-next:
-		addr += page_size;
+		if (!found_leaf) {
+			addr = ALIGN(addr + 1, page_size);
+		} else {
+			addr = ALIGN_DOWN(addr, page_size);
+			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+						ptep_level, GSTAGE_OP_WP);
+			addr += page_size;
+		}
 	}
 }
 
-- 
2.51.0

