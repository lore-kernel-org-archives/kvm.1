Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548723;
	b=ByWprlro7fBavfSQ877kn6QTp1ckt04CAp89uKKDR88kyoHJaL4vASCGwooyBzW5zQWK
	 XTemMo1Z45DOZTwZUng9TNyqi/S7j1HS7qBWG3FY7gI28L9m5xwc91HLTdS+o1e+55M/W
	 hZfonR2wbdxRQqffhUDfljEpbDy9JcuNJDKxOQj8XZ7UNX8EaT2/IzDDj6icpllKCW/pC
	 Fl0Dg8wy2nRoi3gwpBl7z4z4qr0VWRqVrXM2Fy2E1guhCEGp1iJFbY1JpqZ4okvOxCikU
	 A9Yyi5On8+8R5ZdA9G494aXdGvYg61uSAZCz+ERH6e3cCPKKsmvu091L3+oLQgWe1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548723;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=U1bMnDwm6FzN6mY++vh18qaqtEjRNas2FZcI4bgSDsI=;
	b=gpNoSJtX3YMKuwnk4xIQS8lUKP8xaHRruKHg2Zh5b9emlb5N/QJzz+5jR7yP4wG9X8DP
	 QLeq5HQ9cNYq6O5iwgvk4Zv4KGSf3spuYKMP88AwwTap+xMCyO3wiw1KNFlbCU2T9WYqz
	 zIV+ND2IqzrVxUBicmRRomGfov51X1+X2Xrqpd0HZnbD3c5ZZVrlW++dXqQh6sr9Ehfct
	 sxQOB6JHd4dKuyxVjHM+UhdTdOrG0ScXgXJUcKRfOvpllgDhfRDdyDxf6RxhQIoG17nIe
	 IBGP8IC0NYGAn7dB/SLdm1FGOjL3z0Gf4cHDZJrWT4pVQWAnL52GY0UKGmJFymrEACQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LS3m70NQ;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39405606A319;
	Wed, 21 Oct 2026 02:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39405606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LS3m70NQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=U1bMnDwm6FzN6mY++vh18qaqtEjRNas2FZcI4bgSDsI=;
	b=LS3m70NQpDk48fEjkIAE534dKS4gx56oT1Ee1Be5ckz7OJesbMLIxTWSl7pVy5
	7+33wnVooyM4RRxJEJHeXn9s2wSdrnP3Sb2HD91NMegZXeUtQwArgfA2MTNecm1J
	8wRVAbc41j8SBJL/qORRCc6qOryTd4OZukgph6KFPyN1E=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3VZplH9hqIo9qBA--.10042S2;
	Wed, 21 Oct 2026 10:11:49 +0800 (CST)
Date: Wed, 21 Oct 2026 10:11:49 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Inject #UD for AMD-compatible SYSEXIT in long mode
Message-ID: <atgfZa-_ZaGT-Lg8@192.168.1.215>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:QCgvCgD3VZplH9hqIo9qBA--.10042S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDJr4kAw47XF4rKFy7trb_yoW5XryDpF
	y5ZwsxKrykX34Fy3WvyF4fJay3JF1UJF48GF98Ka4FvFsavw17Xr1I93WavayfuFZ3G34S
	qF1FvFZxC3Z7uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVT5JUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+gWxpGrYH2XJoAAA3L

From: Hao Zhang <zhanghao1@kylinos.cn>

AMD specifies that SYSEXIT raises #UD in both 64-bit and compatibility
modes.  On AMD hosts, KVM intercepts the hardware #UD, but SYSEXIT is
marked EmulateOnUD and em_sysexit() applies Intel semantics without
checking the guest CPU vendor.

For an AMD-compatible guest at CPL0, this can incorrectly complete
the transition to CPL3 or inject #GP, depending on the SYSENTER_CS
value and other operands.  At nonzero CPL, the generic Priv check
injects #GP instead of the required #UD.

Inject #UD for AMD-compatible vCPUs when EFER.LMA is set, before
checking CPL or SYSENTER_CS and before modifying architectural state.

Move the CPL check into em_sysexit() and remove the opcode's Priv
flag so that the generic privilege check does not take precedence
over AMD's long-mode #UD.  Retain the existing #GP behavior for real
mode, virtual-8086 mode, and nonzero CPL outside the AMD long-mode
case.

See the SYSEXIT instruction description in AMD APM Volume 3.

Fixes: 4668f0507870 ("KVM: x86 emulator: Add sysexit emulation")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/emulate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..2154a2f2fd92 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2457,12 +2457,18 @@ static int em_sysexit(struct x86_emulate_ctxt *ctxt)
 	const struct x86_emulate_ops *ops = ctxt->ops;
 	struct desc_struct cs, ss;
 	u64 msr_data, rcx, rdx;
+	u64 efer = 0;
 	int usermode;
 	u16 cs_sel = 0, ss_sel = 0;
 
-	/* inject #GP if in real mode or Virtual 8086 mode */
+	/* AMD rejects SYSEXIT in both IA-32e submodes, even at CPL3. */
+	ops->get_msr(ctxt, MSR_EFER, &efer);
+	if ((efer & EFER_LMA) && !ops->guest_cpuid_is_intel_compatible(ctxt))
+		return emulate_ud(ctxt);
+
+	/* Check CPL here so that AMD's long-mode #UD takes precedence. */
 	if (ctxt->mode == X86EMUL_MODE_REAL ||
-	    ctxt->mode == X86EMUL_MODE_VM86)
+	    ctxt->mode == X86EMUL_MODE_VM86 || ops->cpl(ctxt))
 		return emulate_gp(ctxt, 0);
 
 	setup_syscalls_segments(&cs, &ss);
@@ -4390,7 +4396,7 @@ static const struct opcode twobyte_table[256] = {
 	II(ImplicitOps | Priv, em_rdmsr, rdmsr),
 	IIP(ImplicitOps, em_rdpmc, rdpmc, check_rdpmc),
 	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysenter),
-	I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack, em_sysexit),
+	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysexit),
 	N, N,
 	N, N, N, N, N, N, N, N,
 	/* 0x40 - 0x4F */

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
-- 
2.15.0

