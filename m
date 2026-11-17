Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940335;
	b=nfZHsCIKNmeit8uBNSAb0zuSH+DBuNaiHsN6LH8/oi338ioGbkRQA+r9mIp9Vz367XP6
	 qj4R7nN6jfqBkgwGSYjPQjQ7P75Z8SkvBSZwt9uBs9m1XTTsgrbF4OehtQQi12gg1fvFU
	 UnFT1HQDvq18Spr2fxCe+FpiG5i/s0tKY+JPShYaHTgs+j5Qe94zMRykPcO6sSUjd4A6Y
	 OxCszDSwn8jl1qQwdwPhTneB/tUz3XlQHaKiLZK+NlYMEh3ei/HxgJmqOIisF6EwWk/Pu
	 rowOgy/rzQkSumzH+0Vt22vngYvs0uKEo4J+F1YrIF7CnP0MwKZBYhDGpg2LrGmsPPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940335;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ef0+SQXs/90m3ZE5j6sH0rGSgTNxSlxiGQ7SXd69Cms=;
	b=AuK/er11xUby5178CWH8lZ4w6L8KjMWiPp+ycARL5T+lWYEfCEy2aS9DIlyCGjNVo1Zo
	 pHpoDm6msiXwqiZ9iEk7etc1awqemoojuZmUtfLjQPPNrEV2SnwTmmpF3RsGY05/+Pgx6
	 o1D4eq7D6ML51RvSVOv0oFIHr6aTLPxxmwUgo4tq58kJk4iTH4LsgYBgTYPQnqGjcbvzw
	 1p4ex+6y4Gu0qgdYxYIiql4L7jPjsNuVSD9IEtbUZpe3tdasA+QamaZQnH5KFUx5UuTT9
	 6qftdAycgEGmSPAcOj5+KaURaoYMebOHTIaFdeWWXr016u62z6PaI94iTeAY9o+/akQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhdTwCyB;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9560A261F;
	Tue, 17 Nov 2026 18:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F9560A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MhdTwCyB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940335; x=1826476335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3CghxgIvgD/bieSRMf1sj9DrIKWNwNj5YvlSHwXNzc=;
  b=MhdTwCyBi99LwG9HHaX3nkD0dc6qMEfO72XXv4ONPpdCOPa+e+Dfn50d
   7fWOgtQeAexyA7v+htdP0buP6na/R57t/2UKA5gkzQjdA9u9F3NmIyeZb
   eQs+kngroFYzEsD8Q3XoOtGyIWix7ngyZcitoPoJCkxCBl2x6/z4cV8Y+
   OzFWiVHJFuaQiAOSUZR+XMA/IU5mSZQ+uKnTbYxFbyQ9eRbxolt0nGhJ7
   l6NBj1rOh1ARZPSpmxJdHCh6nhswiYcwkKEZHlpUYWS5tlM2C6M1BwrB5
   djLpQt9vtAD8XZQ4XqcOgQDb+AV37gY/u5LINc06u1R90LoDsH2U8KMaV
   A==;
X-CSE-ConnectionGUID: TAJFQuq5SlOJeQoNiZwAAA==
X-CSE-MsgGUID: V4W1pTt/QR+4ZNer8WLMeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607337"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:59 -0800
X-CSE-ConnectionGUID: 1ynJ1tBQTpaQQwFquDkTuQ==
X-CSE-MsgGUID: wXyi32xASjCCtYPXmvaw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775077"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:00 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 14/20] KVM: x86: Document EVEX-prefix not implemented
Date: Tue, 17 Nov 2026 18:03:04 +0000
Message-ID: <20261117180310.921701-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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
---
V8 -> V9: Drop code change (Jim Mattson)
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 3a587e553f9a..808a604c3f5d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4280,7 +4280,8 @@ static const struct opcode opcode_table[256] = {
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

