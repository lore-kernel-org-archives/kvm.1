Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C21EA7CE;
	Sat, 25 Apr 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078800; cv=none; b=M3fJE1PjMKVyxUlC97+rakTx22IDAyrhO7TkvIOsP+YS1IGNujEaq4sxHfU1jN0bPc+LgDKQkPcu9GIZ7TUierShd8DRPIBJENnexlFtBaMGfEcobzrEnL8HS5TDquRQ8ZnXTtUwUckS+bnWnnuoJQcD2CdE9ltAWllELfaH8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078800; c=relaxed/simple;
	bh=P/xWdbYp78TUgmPmZpbvCjaH6uZ1DZD8kPFRZWdzOHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEFBomeid8wVKQmUcIkJr/3QMD3GbfA92mc3LPcID0+dhgkW4KMXujhUPyJgLPojIcTAy5s+2YEyxtsRdQzwwlvs57BWcN7ivS4wTECUDSk3xmQ4tL5tu4j/5h/n35knETuXNHWNlRBSCemoLbKfmSleKC5Sp6akuOReIL26CVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDKbLWUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDKbLWUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A364C19425;
	Sat, 25 Apr 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078800;
	bh=P/xWdbYp78TUgmPmZpbvCjaH6uZ1DZD8kPFRZWdzOHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDKbLWUAnL2XCg9gxeKEyc2mXC8E7299WLTINp8SuZiaodeEbDHdZ15OMfGvHI51r
	 qAAfTAqehCQMylrcSdbrZaRwQ+ER1eT11KhMYuYKY8eYkKDxOiasQgi9gwGbpb3QCt
	 qCFdHKsXzjTd+xcJCn/8TyRFJboFgvedtanFG6xOOVaLJpyJKfh5g9ywbxPm0SWI4Z
	 yx/Hc24Y65Xe0c31BkGvvdqpneCpvSJwGPvB8PkvLET7SBsag/goxIZXVFOpSiebcz
	 gC7W1WoqAHWMz5/QMUjv3qfJoEZmkEiugPU+q07GjlylR7C1FExQUSFm9Dycj43Ztd
	 BHf4O00FBv8DA==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	inochiama@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	me@ziyao.cc,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tglx@kernel.org
Subject: [PATCH V2 4/4] RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGEI count
Date: Sat, 25 Apr 2026 00:59:16 +0000
Message-ID: <20260425005916.3321811-5-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425005916.3321811-1-guoren@kernel.org>
References: <20260425005916.3321811-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Now that `nr_guest_files` has been moved to `struct imsic_local_config`
and is computed per-HART, KVM must respect the actual number of guest
interrupt files available on each HART when setting up HGEI.

In `kvm_riscv_aia_enable()`:

 - Retrieve the per-CPU IMSIC local config
 - Take `min(hgctrl->nr_hgei, lc->nr_guest_files)` as the final usable
   HGEI count for this HART
 - Use the result to initialize `free_bitmap`

This ensures correct HGEI allocation on heterogeneous RISC-V SoCs
where different cores may have different IMSIC guest file counts, and
completes the per-HART conversion series.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kvm/aia.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 70ff1d25dd99..a5f4b7fe1dce 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -534,6 +534,9 @@ static void aia_hgei_exit(void)
 void kvm_riscv_aia_enable(void)
 {
 	struct aia_hgei_control *hgctrl;
+	const struct imsic_global_config *gc;
+	const struct imsic_local_config *lc;
+	unsigned int nr_hgei;
 
 	if (!kvm_riscv_aia_available())
 		return;
@@ -547,8 +550,13 @@ void kvm_riscv_aia_enable(void)
 	if (hgctrl->nr_hgei)
 		hgctrl->nr_hgei--;
 
-	if (hgctrl->nr_hgei) {
-		hgctrl->free_bitmap = BIT(hgctrl->nr_hgei + 1) - 1;
+	gc = imsic_get_global_config();
+	lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
+	if (lc)
+		nr_hgei = min(hgctrl->nr_hgei, lc->nr_guest_files);
+
+	if (nr_hgei) {
+		hgctrl->free_bitmap = BIT(nr_hgei + 1) - 1;
 		hgctrl->free_bitmap &= ~BIT(0);
 	} else {
 		hgctrl->free_bitmap = 0;
-- 
2.43.0

