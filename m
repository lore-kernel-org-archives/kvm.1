Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3F530E11;
	Wed, 30 Sep 2026 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804113; cv=none; b=PcKioPuD8GdBeOf6R4rXZXKDrTa8+r4WpEe1zzAu8EsYcGVMnUsZCAIk4uBvcFdUfzeu7bh8e50S2+FfToX3U+SjOGKQ6GpvSJwROUHFDm6439h83MXadNmhGXpAmCAw5ARHJk1khK5KNwSs64iTcc2C2U7bSGe45GPtbp5gyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804113; c=relaxed/simple;
	bh=Wox4+reExSM56rTC9T/fXMNHX2BRtpavL8TPsWVeVuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG9XuciV43B2V5IYfiX3bPF/H9AXhjVP4ky/ul0Nk9RXfS4KI/Mj1TPpyGPQFS6OObNpmx8ehos+CqvM4xS0ATF5QdMXW39qyP4efclMtJ3hVyKBO8EN6EEpsXlzT2ypK8tSO5ly3iWPLImj+34+dO5gTMQH4G6dmu/0gfGHnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nk26ewv8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nk26ewv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804111; x=1822340111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wox4+reExSM56rTC9T/fXMNHX2BRtpavL8TPsWVeVuI=;
  b=nk26ewv8g5o6loJsCY2uOOVMXVyg02nLz5coFEsSBy5+GgY2Uw5NJEgP
   wgLWK3bmHgJu5Hk5QJOBjkYxWqm+s8XRMHiZgXTcLcRigc1/wEaQIsFx2
   doFP2S1GhHvYQEoWyINaDFvupt4A83DSizx28/lzUW+iG0kR9SA0yZqa5
   RL3P5PFVTcP260VmjHOioMRn+VW8EBfqVF6RIRINc2uzHplpVfhXnRTcr
   YeqTwGDbqM68FSYMMjRbSTmG76ntt1Rk1bh5/DZkP5+OgrpItelLTgDut
   M2nQj7eaKm72Z7GcxEvgM7ia0WBRpGf52mSSu9/sMNrexO2Q/u2LuNt+W
   g==;
X-CSE-ConnectionGUID: xAy5NHEpRWCfLBOA2NAo1w==
X-CSE-MsgGUID: hbH8jrk+Smu4CkWsS8+sgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432712"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:11 -0700
X-CSE-ConnectionGUID: q2DKuZzhQX2tHJKwghnLhw==
X-CSE-MsgGUID: vRrSWuLnSaqoVwc3ps656g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867363"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:11 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 13/20] KVM: x86: Reject EVEX-prefixed instructions
Date: Wed, 30 Sep 2026 21:07:43 +0000
Message-ID: <20260930210750.1487547-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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

