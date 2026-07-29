Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0693B7767;
	Wed, 29 Jul 2026 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354234; cv=none; b=AISZVjRCCEDdFSdIuzLN1G6ARglykqWAYG2Dr5Hox7Ajki/LtbhqB7CYWHVNKzimo0Xw3dSWi0qKclNGIaNpKPo2IsAz3MQlR9AKwmMOpuDXUNyeWKqyxV/tm3D8bDG+lVgMQL3NMEIJAS2mEIZBiOtIs7VBsrlnmiqzmzEBVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354234; c=relaxed/simple;
	bh=K0a43zC/CH1JRV9XZ9iaXKo0MS6XUMZZHsZPAiQ70Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZQUCYLWIfmpx3xOh1oo1ukpkrKYZ6MuOKIyqOgb1BscWCERUB5gSiVjitx4Z2/1c3vC4rNyO/uYo8xPf+wApG7FeUZN2WqYPlXVqlfRAkhj2YepNjKVi74sd35lXKBUxPr81jpOg/GFi8exW4RbfZcNRxcyp+TNmIKFpNM3NL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev8FRveT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev8FRveT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354230; x=1816890230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0a43zC/CH1JRV9XZ9iaXKo0MS6XUMZZHsZPAiQ70Pc=;
  b=Ev8FRveT38Bl7/0w+rgylIU+KPmEleJTLOyr3dCRX5MgR9XqZoTgHcA4
   BU5gwLFmPIHEec+KNaKSTCHfQOCNGGyI3FFcOmrsy3mR9pp6jhYgjN/rQ
   Ak3g4d2pt9WNB3MsfGyRMuemRioP9e0/BpLbopfCAXVBKXcnBMJS2VKPZ
   ZxHNOk0yQLUhSImPXuNhEppRhsl0pe6jRdYGOlQvy6koHtpyAR3IJEuu1
   31fQIGnm7pMGaut5YDcoMPhDxnW8rrY/D6d3azJnQZoHIhJ5xjQyovBQj
   9LgZhSt/+SQefvE2uEt880VEtxWnk1YH5LkgquT5cFICxPa6Xpnys70Rz
   Q==;
X-CSE-ConnectionGUID: A4Gf5t6yTSuLXlPjgvjBWg==
X-CSE-MsgGUID: XlGYOdYwT7SqwyZI4tIeQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508293"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508293"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:29 -0700
X-CSE-ConnectionGUID: b+tWblBIREic0ms0IfrgeA==
X-CSE-MsgGUID: 79mLAWJPRIqE9q77v65rIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769260"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:28 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 13/20] KVM: x86: Reject EVEX-prefixed instructions
Date: Wed, 29 Jul 2026 19:16:49 +0000
Message-ID: <20260729191656.598771-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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
index cb075bd74f76..fc7f9f17c1da 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5045,6 +5045,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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

