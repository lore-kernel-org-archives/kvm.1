Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655324;
	b=E6ssj7XvyQ8gCkjjRcCkmwDmZRlqx5AA1YcfmNXFj+ffkJf7mKtY6+mPzYgcNEFTv8uZ
	 oznDP3iQgYTVu0V6Ctxqs4vPEaBuzWyx1H+pyY9+vPw3xV/7h4VX9MFXEcrsXaqdNT15s
	 xXY4LYary5xiSyDO3nryutH8CHtVvqvvpP9wv/cfnWgSrdcDuXHS1OH8cJFMn/5wAY6Wt
	 a/bku+Ta827pySpwIB7DjtpU+c9cgQPtSfiboZL18jSpLa9M0YtZy6+MNHXOCqAxJiyQa
	 zUfJ9j1PWJ6pEx65gTtYtiFdtOO+1derk02kSTKMGaNnOYWAVe+nCwtCrz8TtqyLOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655324;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AN4a81Z9UJtQPnLgJ+RkAktom/qeg65wVEkaF18Qw/Y=;
	b=vAO7xHboBklpRuVuOjUut3xnu5aog3cXfppkp9pi3jDXjJKf/NszyKRsILIV6F+tJKEi
	 RzSnemmVBJWYABeQ2RakDafIuXmZiNanG2OSxZTdRahhCRto35Xci4Z8yfgQdAMWNXCMc
	 AqE9VBN0BM3jpglACy4xBJ1bUpwvumme2/z7NOMv5uZhSit8s8MOkv34PidQ4CAQc6LFN
	 /KXEpX8PsKIlM+NAwguIdYG80lw9TDylN7nQ4NNs3qM1/nykdU/kdKLpe1XAfZEk5+eg+
	 NBwQmKh8be0EXV2sA7hcKTdRofOHtoK8A+8yVrddjFzvWfEBths7PzC64yy1WHZ7afw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Fif+52Ya;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD97606D814
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD97606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Fif+52Ya
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8AE31595;
	Mon,  2 Nov 2026 13:35:19 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926303F673;
	Mon,  2 Nov 2026 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655322; bh=43k+9jU20ktuHYEgwEIXmQdpwB5aJB3Ksk7i8S+YwmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fif+52Ya8ozE6ScJ3kHscKufOpKyFMwCnKn2Km2ASS+YsbNsasnWM6Ip0Uvza1+av
	 aQFXBY9WAIwuQKAstE8tvdLtJq8OD+A7dr84DYcMBLgcKM5qid8++nGwy9Ha7BpyjK
	 RpufmR7O09Ck9YJuw70C8BAnlSxehcIPsc4ApSiM=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 15/23] arm64: Describe the GICv5 IRS in the DT
Date: Mon,  2 Nov 2026 21:34:05 +0000
Message-Id: <20261102213413.4136118-16-sascha.bischoff@arm.com>
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

Describe the IRS CONFIG and SETLPI frames and associate each CPU
phandle with its IAFFID. This lets the guest discover and configure
the IRS for shared interrupts.

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index e69f2742..91447703 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -587,6 +587,16 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 
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
@@ -598,6 +608,31 @@ static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
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

