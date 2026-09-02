Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B937649B;
	Wed,  2 Sep 2026 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317099; cv=none; b=s9+fNqlR9YDcTaj7ubX6Hr5xE0sC05JxtKA0QR3lezbqZFCDUX9A3QL4quTN+pD43VCjEe8ZIeBE0F65V9Fk8ksioBBaRtabO4afbgmGKJ41pbPe3ZMd40EDJ1NeukpGGqn3NLJXk9T7wjxAkoxpG8UpiN44bkWzyL5bAIETkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317099; c=relaxed/simple;
	bh=Wox4+reExSM56rTC9T/fXMNHX2BRtpavL8TPsWVeVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PisTEqphgQr6IJTQo3PILIpe6SA3FE+NX0PsD4qUN20svxO1C+sBp91xuDxp0f1cEN83xnLT+zt4sqNXOrmyKLa4Dfk7J9H22sd02dOmuHYnfgaq4Tm0U1PhdZu27VYXx0vsG9o96eWGJ/OzW2hhb+OVgVTgyRIK3Ycl/4EZjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd5c7ogF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd5c7ogF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317098; x=1819853098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wox4+reExSM56rTC9T/fXMNHX2BRtpavL8TPsWVeVuI=;
  b=Pd5c7ogFRt3UPeKN1nyAHq5HHzm04o94cwnFt2oTgmEa6TrirK555LA8
   Vfv9YXhgdX/2MCdgznYvSGZJgtdoNAmRVD9zil93aTCdYaCbtwtuybb/5
   QWB28CyqV6fARloM11R3z8KP7JUT/yuKPWvnNPidAKuHUgmk4dEYLW4DS
   UlmAyDSvWnLMIlqb7e79FSXkuM1PAsAlNujfdS2T0a+djd1JnIwMq9DQB
   1rSbsenwthJD5crsTKHquUV+DIIXtPvmHONqJ91gaeeiK0a1xcJIplObJ
   kfh90eIUAinvNzPAbs5bdeMEgMBbeF5wnd0Hk2oHOjXab5EWXiEXDWBFe
   w==;
X-CSE-ConnectionGUID: wIfPmnTOSgeJnBJy/i7WDQ==
X-CSE-MsgGUID: oI17xsBJRwuCLdaGP9sDbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282955"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282955"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:58 -0700
X-CSE-ConnectionGUID: rzrA/elaQaeABjnGxyW3pg==
X-CSE-MsgGUID: kZRFquGESO2ieQ5Qn+pxtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775527"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:58 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 13/20] KVM: x86: Reject EVEX-prefixed instructions
Date: Wed,  2 Sep 2026 02:17:57 +0000
Message-ID: <20260902021804.718676-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/emulate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index eba4e9b7cd5c..f0d5a40eba27 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5052,6 +5052,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	if (opcode.flags & ModRM)
 		ctxt->modrm = insn_fetch(u8, ctxt);
 
+	/* EVEX-prefixed instructions are not implemented */
+	if (ctxt->opcode_len == 1 && ctxt->b == 0x62 &&
+	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0))
+		opcode.flags = NotImpl;
+
 done_modrm:
 	ctxt->d = opcode.flags;
 	while (ctxt->d & GroupMask) {
-- 
2.53.0

