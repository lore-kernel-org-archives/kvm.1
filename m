Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024747;
	b=qSyrP53MTGOdp6hwGQ7hXIgfCn3MsIKvNYwN44uJLjx7WRDYVUwfWq3ScR4FXd8sXdZp
	 l8jTPKrXX57dQmTWcZbXKF2bG4znEi3zFAA2vg5Ul6EFOafSXFUYwksYuYEYPF+15J45b
	 GLDN3sE8W3vB4uIlT91gICY2JGwzlaVkPNYRqxzhteZIVQGDX7bobzwvBwfvaaknjh46o
	 3chLrsYYyO1bqNSDwBJ5jnoQfcyDB1m7oSfgzGFGiQpJ7Tug36SiAEpC+Pxi/9Z3z+lWJ
	 wUmp35Az84ULOMs9qMH1IU/ay2F5f7XZJ5mhyfTVvvIyGRKty3U8R8KOGMQ+vIN41hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024747;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fd1g9/NEscWmX+eN9+XxgtznyDz5p7juKT9ngSQT6jc=;
	b=o7Cj3x2rq27yIjyj2qJ7saRa+jcr5hREK2l8J6LSSuyz0PLm53NkYbdbAU3EmSzSKysD
	 ER4TitswdbYBYN9QlxWwxa656+EL8OTkRDvLwogVEXp8fPEWKmyk4tGscHCS4MesS6EkV
	 PEOVmilRtndzZoNsKS9i/mjeyjljhqtUF0PTPb/dU6CkXC06fPUW5o7hFRZ2NHdR+tXCs
	 MnnuranI7QmgLxteHNuV+FQYBpZttz5TO3Xp0cH3aHISicT/m7flyLD3HlJTTsw4SsCJ3
	 GaOHEOYvjAWKGoAfajGM+T5ipVUyI8Jl7mM5wKoKnGr+V5oB2r61TQ9FpoSVwgG8DiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lx2Iqh0X;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D85606A332
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D85606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lx2Iqh0X
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E5E1477;
	Wed, 18 Nov 2026 09:59:03 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681323F632;
	Wed, 18 Nov 2026 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024746; bh=h2Lzch2cOCA7Blo1kAImL8IByrsHBQfeADe3b+dd1zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lx2Iqh0Xm/5wO9TG59uT9arWrNmYhnw8NWAiCtcPEGi1G/WzW2yYk1S+TM68xgI4I
	 9OWT6V7umqD/E3xubk/F44qpgIxwHJ9Jtiek1fpS3iP5xB8QKpIHmtTJX8/RBHe0wu
	 AmU+wGisu5kAQ2OhuKN57/GMZX/j0Okuw20iPfnU=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 15/23] arm64: Describe the GICv5 IRS in the DT
Date: Wed, 18 Nov 2026 17:57:47 +0000
Message-Id: <20261118175755.1946977-16-sascha.bischoff@arm.com>
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

Describe the IRS CONFIG and SETLPI frames and associate each CPU
phandle with its IAFFID. This lets the guest discover and configure
the IRS for shared interrupts.

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index 9a8f9916..e5a26252 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -588,6 +588,16 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 
 static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
 {
+	char node_at_addr[64];
+	u32 cpus[kvm->nrcpus];
+	u16 iaffids[kvm->nrcpus];
+	u64 irs_reg_prop[] = {
+		cpu_to_fdt64(ARM_GICV5_IRS_CONFIG_BASE),
+		cpu_to_fdt64(ARM_GICV5_IRS_CONFIG_SIZE),
+		cpu_to_fdt64(ARM_GICV5_IRS_SETLPI_BASE),
+		cpu_to_fdt64(ARM_GICV5_IRS_SETLPI_SIZE)
+	};
+
 	_FDT(fdt_begin_node(fdt, "gicv5-cpuif"));
 	_FDT(fdt_property_string(fdt, "compatible", "arm,gic-v5"));
 	_FDT(fdt_property_cell(fdt, "#interrupt-cells", GIC_FDT_IRQ_NUM_CELLS));
@@ -599,6 +609,31 @@ static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
 	/* Use a hard-coded phandle for the GIC to help wire things up */
 	_FDT(fdt_property_cell(fdt, "phandle", PHANDLE_GIC));
 
+	/*
+	 * GICv5 IRS node
+	 */
+	snprintf(node_at_addr, sizeof(node_at_addr), "irs@%llx",
+		 (unsigned long long)ARM_GICV5_IRS_CONFIG_BASE);
+	_FDT(fdt_begin_node(fdt, node_at_addr));
+	_FDT(fdt_property_string(fdt, "compatible", "arm,gic-v5-irs"));
+	_FDT(fdt_property_cell(fdt, "#address-cells", 2));
+	_FDT(fdt_property_cell(fdt, "#size-cells", 2));
+	_FDT(fdt_property(fdt, "ranges", NULL, 0));
+
+	_FDT(fdt_property(fdt, "reg", irs_reg_prop, sizeof(irs_reg_prop)));
+	_FDT(fdt_property(fdt, "reg-names", "ns-config\0ns-setlpi",
+			  sizeof("ns-config\0ns-setlpi")));
+
+	for (int cpu = 0; cpu < kvm->nrcpus; cpu++) {
+		cpus[cpu] = cpu_to_fdt32(PHANDLE_CPU_BASE + cpu);
+		iaffids[cpu] = cpu_to_fdt16(cpu);
+	}
+
+	_FDT(fdt_property(fdt, "cpus", cpus, sizeof(u32) * kvm->nrcpus));
+	_FDT(fdt_property(fdt, "arm,iaffids", iaffids, sizeof(u16) * kvm->nrcpus));
+
+	_FDT(fdt_end_node(fdt));
+
 	_FDT(fdt_end_node(fdt));
 }
 
-- 
2.34.1

