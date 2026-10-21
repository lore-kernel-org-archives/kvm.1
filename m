Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548628;
	b=30CB2P306PGIckYFfLajn7Ug4mO8rAC2/PMMcXKcHMZ2TARHZr5c9E0rU3XU+8/W4K4/
	 2A/uHaoDPXFsakSF6ptsAeV0oZQvHvCkd2EoTnXi4RaAC67YFgMSEf2N8Hox2PLVL7DtT
	 B3yaRnIRRbwmlPBcH8CVIJWQBN10BNJ0SQkpJuQdSPg2PvNt4CNRHY9eIWPsAql2miQgZ
	 q6YGvQG1HyKDU11MEf8fyzDlF6g5X/wLEmhRlJv23yn19lq4B3az5SHcsCQKPOBWF+AyU
	 SoOmYJUG3dUZfvQn1TE+d/la3fcrkYXmdwUoiWrgOqLmDOvl/J7k0lWPTXE3jbfa+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548628;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tf067HsMqMNUdUVbIdRMJp7vL0vCEPrg8RdQWmdIS2o=;
	b=WrsyVPAThdL3McyD8VskReOi16ms2AsLM4DRQQQhD8gS5XDyw3J/EtkZBUGb2z8WxkFW
	 KjOASzBBoJuSq4QgHRNQA5dvgqqW9JnjSTiDl/gdJyZEwb3Y/elJKL/GgkCdZyZNQGalO
	 r28Ee2jA8cwgobT2phQ6xqL30pxhX3t2OfgtGEmj7P4btj2TLHgLH/dGkOHe435QaSaoC
	 A83j6nMfZgl0etZCykfrWvPP4rR3iwq2DNckA/Ql2jamrEIub91TqroBivv+1v29LR422
	 lj5lpnlj2gzOX+k6rbY2EVtGSmPNWGeTCGgEXjipTipDl4uJp98tgVA5+kj6Pjd/QUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hDiNINIr;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7D606A31A;
	Wed, 21 Oct 2026 02:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hDiNINIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tf067HsMqMNUdUVbIdRMJp7vL0vCEPrg8RdQWmdIS2o=;
	b=hDiNINIrpqCnDYrRIrIEU2UulrgQVlYwzK/xUX571noxe09rTcyn98+LHnuadr
	x08oby4atQ25Eu+AHUaUz5eJDTV9cfdBBAIeXe/zMCknniWazMF9WIeiWBsoZ1hs
	P98NIJ3Jj9Btk6n1HaSiCEh0pICxPDGoHjMC6gruPtnsw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n_r7Hthq4ZLEBg--.32434S2;
	Wed, 21 Oct 2026 10:10:04 +0800 (CST)
Date: Wed, 21 Oct 2026 10:10:03 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Emulate SYSENTER in 64-bit mode for
 Intel-compatible vCPUs
Message-ID: <atge--CosCmrOcx6@192.168.1.215>
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
X-CM-TRANSID:_____wD3n_r7Hthq4ZLEBg--.32434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4DuryUAw4xZrW5JF48Xrb_yoW8KF1UpF
	ZrursrtF95Wry5Ca4kCF4fXa1UZr47tw48WF90gF1FkF4ku3WvqF4UKa45Zas3GF1xCa4F
	vF4qgr1qkw1rXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3-PUUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hyXimrYHvz1+wAA3B

From: Hao Zhang <zhanghao1@kylinos.cn>

Intel allows SYSENTER in both IA-32e submodes, whereas AMD raises #UD
in either submode.  On AMD hosts, KVM intercepts #UD and emulates
SYSENTER to support Intel-compatible vCPUs.

However, em_sysenter() unconditionally rejects execution from 64-bit
mode.  As a result, a valid SYSENTER in an Intel-compatible guest can
fail emulation instead of entering the guest's kernel.  For a
non-nested guest at CPL0, this results in a
KVM_INTERNAL_ERROR_EMULATION exit to userspace even when
KVM_CAP_EXIT_ON_EMULATION_FAILURE is not enabled.

Remove the unconditional rejection.  The existing IA-32e path already
loads the full-width SYSENTER EIP and ESP values and installs the
required CS and SS attributes.

Also reject SYSENTER for AMD-compatible vCPUs whenever EFER.LMA is
set, covering both compatibility and 64-bit modes.  This preserves
AMD's architectural #UD behavior instead of attempting Intel-style
emulation or reporting an emulation failure.

See the SYSENTER instruction descriptions in Intel SDM Volume 2 and
AMD APM Volume 3.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/emulate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..695957ebd871 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2413,17 +2413,13 @@ static int em_sysenter(struct x86_emulate_ctxt *ctxt)
 		return emulate_gp(ctxt, 0);
 
 	/*
-	 * Intel's architecture allows SYSENTER in compatibility mode, but AMD
-	 * does not.  Note, AMD does allow SYSENTER in legacy protected mode.
+	 * Intel allows SYSENTER in both IA-32e submodes, but AMD does not
+	 * allow SYSENTER in either.  Both allow it in legacy protected mode.
 	 */
-	if ((ctxt->mode != X86EMUL_MODE_PROT64) && (efer & EFER_LMA) &&
+	if ((efer & EFER_LMA) &&
 	    !ctxt->ops->guest_cpuid_is_intel_compatible(ctxt))
 		return emulate_ud(ctxt);
 
-	/* sysenter/sysexit have not been tested in 64bit mode. */
-	if (ctxt->mode == X86EMUL_MODE_PROT64)
-		return X86EMUL_UNHANDLEABLE;
-
 	ops->get_msr(ctxt, MSR_IA32_SYSENTER_CS, &msr_data);
 	if ((msr_data & 0xfffc) == 0x0)
 		return emulate_gp(ctxt, 0);

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
-- 
2.15.0

