Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621197;
	b=S0q9zDdXQj7msJ6WpTCs8j23Ms/HcFfdU8ftzLzLCuYqITMfqNE5MFgisxyMjfdIHFBJ
	 2bx7Ms+dat88TeRVxc7jdsehcxA93Fdv/eoRhsTL7o6Qe8HUI3D77uw5XA1FG1HK0VMJx
	 fZ71q+Oo4o72JPCT6GWXijFqlWAyWDxhB5gQLl+1jP/j3LK2NCpxsDrZqH9ElrAr/wla8
	 wvF4JJ3sDW9liDUEQ7VMlxgX0H+t9jichtE3NLNqUxh2SPH9XVTclDJrEancyABpU3kdQ
	 K9un1bRVO6iFxPfuiHrhiEqmLOSc/hMrrNFMYIti+AzBxwsajWdPpj5fJ9bSSfYQibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621197;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HaDpLlZO77/PfdtGsOMSJUUh5Y4j+J367j2Kgogf+tM=;
	b=R/YzJnU347hnbpNxzNcH+L1huTgJ3BtiYAyHaTc5MRX9thuSI3iZwDx/6sb1Z+7SGLab
	 /p5jb7gK8VBo/KKzxoUq7/dpmZSuc/iahriysG1svxXAFiCD6sBw71fYj+BlN9qB/tj1n
	 7Xts8Od2qxq8nJyr+vjeheSooj9zUzf0GhSTKE/51uv7NN3EqJhiVG7P5VHvL05CiLblj
	 ll2x2zBYfQTpTQJAancXZVcUGUd5Z58Jzt0WDyEbrz1pm+ShBgIYdAVwSOWBQJNLStJhj
	 deHx08mWo0dSzRd9nmu2p8qDh1d7saxnxbpL/TLyHLGviCFTJS8MmSW6XJsfHzD8eNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AUAMMum8;
	arc=none smtp.remote-ip=91.218.175.139
Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A145606A6AA
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A145606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AUAMMum8
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GlzUdZprJRkl9i8HWXT3FIkXmSaEpIUlQmDVtwXNSuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621194; v=1; x=1796225994;
 b=AUAMMum8C5V/yzYIzbsSmtIcur4UF37a2pxl5ZAI1XD42u3BoF1NRUXz1MGszxEzV3emLB8D
 EZmliY6jPmUJ6iaXtAlr6XlH6uDFxB+s3rw1pPzQS1024DxwbA4fT54NysiqtzRCC3WN8UwwE/E
 58oCXFxred/kG27tpOTXM1mk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id deebcfd6609d8edf;
	Wed, 25 Nov 2026 15:39:54 +0000
X-Mizu-Trace-ID: deebcfd6609d8edf
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/20] KVM: arm64: Report an incomplete feature map with WARN_ON()
Date: Wed, 25 Nov 2026 15:39:00 +0000
Message-ID: <20261125153911.106793-10-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125153911.106793-1-fuad.tabba@linux.dev>
References: <20261125153911.106793-1-fuad.tabba@linux.dev>
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

At init, check_feature_map() reports with kvm_err() any feature map
that doesn't account for every bit of its register. The next patch
builds config.c into nVHE hyp, which has no printk(), so the check
would need an #ifdef to keep it out of hyp.

Use WARN_ON() instead, which doesn't need printk().

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/config.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index c65cf1dd27330..eef5ca50fc382 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1409,9 +1409,7 @@ static void __init check_feat_map(const struct reg_bits_to_feat_map *map,
 		if (!((map[i].flags & FORCE_RESx) && (map[i].bits & resx)))
 			mask |= map[i].bits;
 
-	if (mask != ~resx)
-		kvm_err("Undefined %s behaviour, bits %016llx\n",
-			str, mask ^ ~resx);
+	WARN_ON(mask != ~resx);
 }
 
 static u64 reg_feat_map_bits(const struct reg_bits_to_feat_map *map)
-- 
2.47.3

