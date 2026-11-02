Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655315;
	b=Q6MEZCZHQM9lXNdivLWNWUQh2nTLwGPilOlVoLmFDsjfyV+8m/yRgJ589Lxx30tN1M8a
	 5ZZc3TJ1Z9iw/74lVIEiACsKyvxXj+grEAfUXvMWLHK7rf41OoSV0rlHZqgLor4xAx/Bq
	 vC9Q55WURkzAPGpKMJtS+NRNZzls2BdnWx3rWyrib/flwTzBuHRxm5GN+zZumJZqCo0/l
	 wmhX11YOszNu4g4rM3OAVqFgP3ThPaLuIBP7dKqe7mDXq9F4WO38ALMWMkm83A5RxVHcM
	 5cAUaP0XCQHLYDvrQ52cherB+JzifT5i2Vddb50yR7LvUc5lvzL/PnFI8Xio5ZQSLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655315;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J7iTRVnfrJr2JU2DzdPdjF4HGL0/oApU+EFz5weckSg=;
	b=JoUsaj9nX9w7wVShY8ZqArGDMBO4NiSJVeFvyul0UVVUM7WGV1F4afir/Q61JzIyXSbI
	 S0E803ra8JgNfJb8OQSeKHDBnerkZgspphaMcqLnMVEdYsLG/T7k+MNutUgO5DxBfMAaT
	 szalKTv84oKJ3JtO5szXH0HXuTnZit9TvpUdNeaIi3wyiTHNZZfof6GgAMPL2ZTsdmscE
	 oz9MEAl+LpE1pdcT17iaoIqtR6ySJBTNqxPJzIOPEh2lvhEcDJINLvgQnbhQAu2/dAM1s
	 5QGEMK3kvdTv9nBAp4Ic5ZFHEDKYMnIa83SU8dpu0mCD71BGrhzZ5VEUsHXN568S4Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="GhMev/n0";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDEB606A32F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDEB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GhMev/n0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 662801595;
	Mon,  2 Nov 2026 13:35:11 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F02F3F871;
	Mon,  2 Nov 2026 13:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655314; bh=8erxUPpAC4HMUa/CSxOnOZSasi5glINz+cXXY6oBozM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhMev/n0MQ61gvJE00YJS0b8O3HXc8t1L3Qbx3wmHdp6jLiJJtYZM29JXz3R2Zi+t
	 7Q+YK0hI35ZXNo4XPd9vEy9psNgtMeYD1v4IFuSC7WL5B0OuXwwZrXAxtTMsqeBqfZ
	 zOeIMPhyfTFytqpMoaOBSLRc0C+oogjG1pOE+W6M=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 13/23] arm64: Assign CPU DT phandles
Date: Mon,  2 Nov 2026 21:34:03 +0000
Message-Id: <20261102213413.4136118-14-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102213413.4136118-1-sascha.bischoff@arm.com>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
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

