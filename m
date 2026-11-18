Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024739;
	b=GfQbxDzLrotcBbLU4azVkuHkYd/Bi9bLM4i7jW7CQdKvdMW9KZ87hj6ZfHOlm2gtg+u+
	 jqsCeJop2nUcbaWPzo60modiK1PIaTZPeOW9rkj5A9ch0aBvsOLPjdiyCPC+c62P2eiE6
	 /xA3az8sIptfjn2G9xUKPOK+XmF3mVnqm55OzVc5HzZF1XpJmipCwg6k0zOszw9BqH/zX
	 nKnGZkCu3G+TLHOgzXYnkIt/kvRZziNaj3MWe3JBKZa7TOkz1lc4IwT0BLsqubYg0L5/r
	 XeJIzgWXv7WIsB78WudVkIsnQA6zQmdiIVGhrLQare/phYXXveHh4lTb4vxW8332ELw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024739;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VraHm7K29SexX5+u12//lf1RRSNEeWxQZDdYUBE8ma8=;
	b=0YkJiU606I2K8SMbTXbr9bRyWXVFvgfu5eKsGkcPzSYLcu0IGhAma969do28za2b2BdA
	 d1qr31qfjGmcIp8UHqneC0UuGRDzt776u2SsZwpsXfL22J2huUEkzL/PXt9RxF9lQzGht
	 9q//ujGw/6EwUesTGkVtXXz9AT8m/2tc0yTscxVGnYU7V+6hHYkJZc9QZzx22Z28sFqMD
	 zYxFNaYF2uTAlILz4pduG8nynEyGsyD3LjGv2rjhSDihJe9D3rdTUC/TlXk+mJ0Sbg06v
	 5W6TXJlGs3zPGLXLAlt6v0smz0ON2zrtSVKKNje6GzP+RmF/knJwN6T/wggapmqxMNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hTf3Ymye;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D7606A338
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76D7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hTf3Ymye
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA0C1477;
	Wed, 18 Nov 2026 09:58:55 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792A23F632;
	Wed, 18 Nov 2026 09:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024738; bh=lRMM8KFMZzejuSmonJyhWiiqR5eUD0xB5XotL3pAJ58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTf3YmyeMLcaecF+eO8XgCh4VFdEl1q+xkIfoTU24/suC+aMzgQL1H4V3AKxLIhbX
	 WRvCxqb7T+3gbGN6twLkquC01A4/nPykHelo/IsBCShpdK/yftssM9IDrSvYPrDD56
	 as/vQWyQjt3sXQFQjF20nWnp9mJgqYRVeWqLPlXI=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 13/23] arm64: Assign CPU DT phandles
Date: Wed, 18 Nov 2026 17:57:45 +0000
Message-Id: <20261118175755.1946977-14-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118175755.1946977-1-sascha.bischoff@arm.com>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
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

Assign stable phandles to all arm64 CPU nodes. The GICv5 IRS DT node
uses them to map IAFFIDs to CPUs; they remain unreferenced for earlier
GIC models.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/fdt.c                  | 1 +
 arm64/include/kvm/fdt-arch.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arm64/fdt.c b/arm64/fdt.c
index 3cbd36e2..5413956d 100644
--- a/arm64/fdt.c
+++ b/arm64/fdt.c
@@ -54,6 +54,7 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 			_FDT(fdt_property_string(fdt, "enable-method", "psci"));
 
 		_FDT(fdt_property_cell(fdt, "reg", mpidr));
+		_FDT(fdt_property_cell(fdt, "phandle", PHANDLE_CPU_BASE + cpu));
 		_FDT(fdt_end_node(fdt));
 	}
 
diff --git a/arm64/include/kvm/fdt-arch.h b/arm64/include/kvm/fdt-arch.h
index 8a0a460e..2b667c53 100644
--- a/arm64/include/kvm/fdt-arch.h
+++ b/arm64/include/kvm/fdt-arch.h
@@ -11,4 +11,5 @@ enum phandles {
 
 void generate_dma_region_prop(void *fdt);
 
+#define PHANDLE_CPU_BASE PHANDLES_MAX
 #endif /* ARM__FDT_H */
-- 
2.34.1

