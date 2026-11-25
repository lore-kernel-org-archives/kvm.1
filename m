Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619694;
	b=bd/f3O7Vg2vE9TLZ5CMCV3Y5kLn9Lu9CGaXnZUhivkIcXJtDqHYRHVL21QFsjJ+Nd/Tc
	 JgPW+jDwoMsX/tyPQNoUzDkomn2AAfVZJAqYdg0GK5VlydjB7Z+yWoCN9cMv61Fhd4PzQ
	 63owvVkEKFPnh4iyr3ZudMgOjA4Y9k0QInwQ/OPtD+D3wkQo0+M1M35/VhlysTO36saBT
	 p0b/wMMsqkwWwaKgrTw4n82eHtGDltXEe5FYRqbzE9nC1AT8XUxQdIr6nNN3WAiEwVKET
	 iIfoBw2NqEOQwlBYzDycrh1rPLIpGNGf8yGw6JADc3MCIPEzR6odKyqO1vZ1hFP/BNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VraHm7K29SexX5+u12//lf1RRSNEeWxQZDdYUBE8ma8=;
	b=mDUXSIcjB+NbuGs3wFbSSyiIOUzXIabVsxHt6ZEy8OMHFiaV3ng0B8XIXHp4WGiyELNU
	 oz4lztensltjHcCMkBHrt26t5VJLVD1XnN1yF7UhKfClQNneL9chpZTIj7is/V+oCcRhj
	 dT5NTj9wFyxf6rLN2mc8Fe2FOJnJGYsA5ceYH3QP8wwjE6DZiZiETKRQJyxATB/1efjd0
	 6fpLuqo9kswI30kALdnNqMvNhy/pMHkfhxQBB5wuIh41e+ovE9P+Uv44QfiyMRDcZfFXL
	 /O+qS4Q3NVByjw5LlOIgFuYHnSj8exvKdeVUHnmoWpDU/aUBrAHjPfassME2ik/pEVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=phomfASt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD70606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD70606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=phomfASt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CF06339;
	Wed, 25 Nov 2026 07:14:50 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F61C3F86F;
	Wed, 25 Nov 2026 07:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619693; bh=lRMM8KFMZzejuSmonJyhWiiqR5eUD0xB5XotL3pAJ58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phomfAStu8lSOFyt6dDPQHTEWgPFqKl1rS1IQOFiu6zC7UFyioelJbJCp/gCPWz0V
	 nx9Mj1WK4WyVTX0j56rXEx9z90FR/DK68dxQdMM05TgmzkUB+zMxF22aGN4/e1sZcJ
	 62+ZWM6wcoFp02qiFpByXuq0Ln+buH9NWMe5wFIU=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 13/23] arm64: Assign CPU DT phandles
Date: Wed, 25 Nov 2026 15:13:46 +0000
Message-Id: <20261125151356.2875108-14-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125151356.2875108-1-sascha.bischoff@arm.com>
References: <20261125151356.2875108-1-sascha.bischoff@arm.com>
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

