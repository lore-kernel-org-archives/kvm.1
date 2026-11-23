Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457889;
	b=qzaS1veohX5elam0uH0u6Dsb2rz0CHwbsvlPnACC4VX+lX0rXFK1VS+0QF2VqdB1WOGK
	 JJvz60shv9jUhMNq1ta9RTm/iFqaMihM7GCTCb5HUrr/Lklm9To5Ipr//4gCV1HMsLFO9
	 UPeTjZpLHWMziW9CBukRTkcNM/oSLsP1zaiRsPkjc9W+IZKwVcYODEHelgON681VnhT02
	 kCCFKveb8C72Uf0Z2dBeCUbR47LUJvkiSfX++DQP1q/Uajm2mHg71AS/1t+Il0meI9DYb
	 hWDW5Luru2gP8ptRju9QfBDBuF0t9YxXOA1yUpi6tW/6bMsz205VtUSzzSZqLjQDI4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ScqDscmR5b5t//ay18FcA7DK8tcsruoDQ0VT4wZ4NAM=;
	b=T1f2ithYSfIvgWzwZwn0jwk1JszHbSOftzCAbNV6COgFyPHLudhxmelDyjcZ/Mei9trt
	 Tw0A7GH7Tdi5H9MXsyHwgCHXha+YbuXpks3LzCxKoAcbWxZO+n/KnLMfGVCCqKyMPfH2C
	 lilzHg2yCHoM+dQuNRao5WdRualRNZoRljejusxOb1Oq9gqMlsFstb7I7XfN8/zgylW+X
	 5l9TwusryRg2zqZGWTlx23TOjYvEfzE2Hb7fGQzLadtZ69ihxJbUrqcSKY/H6VI8FQAjv
	 BEefvVb6DE+PCkzdXo/7Pbh3iKiaDVpdmetQ4EqG1GP4QmKfF9iFa3CkxtREGTIeEIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NDhQahxf;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAD606A6A5;
	Mon, 23 Nov 2026 18:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69BAD606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NDhQahxf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457889; x=1826993889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBxngMr8ALgIdjG3Jq+UjcSryY87DkBnq8Re28p4bYQ=;
  b=NDhQahxfLEa2UZga5K6Ig4TKgd5pTj83+FOy4qlSEz5L2HQ4ccpd+jFA
   u8FRtdGHkYzk0XyyGAT8ibJnUO2bBdRhYwBBkwFKbqKU71INLFPTOATrT
   JjJz1hOwRAV4qlpqnJ1SgcP0fQG8JEpnQDgvm+UuSghKHr3T9bc+YXQfI
   JaPO11jEE6A0SqAoiKu/nCW9u3DttMuPnp9VCrM67O1taMKonezH7qtFV
   U367VsKYVnUarYbW6OHH1BAIWshMHI9ZscRIkA3fjvwUVni/afNtWoSCt
   4k5RXQI5XEHhLzRMcQnTUpRc9bYjKW7y0wa1KgghH6r8JIvAgaaWFXsEt
   g==;
X-CSE-ConnectionGUID: V9pSDWIoS6OziiJIBgLeVA==
X-CSE-MsgGUID: tgsJ/xHESey7Ix8HAh3HPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288864"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288864"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:28 -0800
X-CSE-ConnectionGUID: TLgTbGYVQUKUQOxC7TWnrw==
X-CSE-MsgGUID: 5OBUqS8cRwaEVTSMk00Yfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241151"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:28 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 14/20] KVM: x86: Document EVEX-prefix not implemented
Date: Mon, 23 Nov 2026 17:37:26 +0000
Message-ID: <20261123173732.1072124-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opcode is already marked as not implemented. Add a comment for clarity.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V9 -> V10: Collect a review tag
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 3536bba2c035..cd741d758910 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4286,7 +4286,8 @@ static const struct opcode opcode_table[256] = {
 	/* 0x60 - 0x67 */
 	I(ImplicitOps | Stack | No64, em_pusha),
 	I(ImplicitOps | Stack | No64, em_popa),
-	N, MD(ModRM, &mode_dual_63),
+	N, /* This effectively represents EVEX-prefixed instructions are not implemented */
+	MD(ModRM, &mode_dual_63),
 	N, N, N, N,
 	/* 0x68 - 0x6F */
 	I(SrcImm | Mov | Stack, em_push),
-- 
2.53.0

