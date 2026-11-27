Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798973;
	b=GxVySs6JJZ3ep1eVSkTINgED1hHspoejal1Z8twVQbATXWu+C1Fw6Os+dfqqIm2SH6JF
	 e8RsI4fejIym7fp+xbly8Z8nfsDo1kYsIeyYeDCxKGswLLDngE0kGVf99vPBRErwtoBGa
	 1iDw+7Fqq9DNNxDKgDPDEcwF7so1HyFUOwgKfxzpPuJOMv2HSpNb2jwf77c3DcbMCC3CR
	 vp1+67+IJ4jPXREzYvSUrRUY7XZyfbDy0vPXz1yPASekkPU4Q3TB5TbvDYkf3IKSsSpRC
	 +5Z4pbikcWB7gWCHVC2EYrXG9Dlr1Is9lfwrGuh9O31Ut00RNMID9cDbbnwjnHez5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798973;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7IjkaBGmYu85g24uQenlccDZhi7fu0Y7Y254ywFpT6E=;
	b=hMUiktQgeDB9XqdltFdhs8bXhmRhc1zdw1fYb5c4/VeLBgGyzyRgwCFQYs1nHcudbE77
	 7kI1LNDIJ7AUS2MS9RRtqH0W7D4DKuout+U5Zpgl+gi5RJ4/hcscHdNrbqyFQ6R9CBZm+
	 7i8qKK1znN6icW0n9Lgrm9FobwAc+Gv9CWqXmSs/ukgqH3/Uqj4KcljpNLV2AgBhNDjdh
	 TlZq5p1JQ1lumc/QVaIvUx/b0/5hF94xQEfG8KqC1C4l3WNEjUgXO2Js/cksVbA+dqIAc
	 ONeijazVim2EkuAS7fbr6Y8bRnJ66Yl4pQj+2KkQ8tBwHN9TPMxqDVjC7YeDpQav4Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iGFTdYgu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057D606A329
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A057D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iGFTdYgu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7C01D70;
	Fri, 27 Nov 2026 09:02:49 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1638C3F632;
	Fri, 27 Nov 2026 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798972; bh=J0TQJvWtX9geqJfP7DW01jkzi/iokZhh74xeAdUCbqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGFTdYguxdTUfq0qlv838ztAoWUuhFS7vZAH967s4tF+22CZxwT6kcVPF0znXRfIC
	 BZ0EzUFAJ1VltRH91TFXobANcIGrPnwxG1aCDm1/oBJml9OrOF4XfeFtYJJWhQZ68F
	 maRbcEs2W9S6ajrPb2j2/+eDj3Jhz3M+4a1KJbH8=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 15/23] arm64: Describe the GICv5 IRS in the DT
Date: Fri, 27 Nov 2026 17:01:37 +0000
Message-Id: <20261127170145.4138182-16-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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

Describe the IRS CONFIG frame and associate each CPU phandle with its
IAFFID. This lets the guest discover and configure the IRS for shared
interrupts.

KVM reserves address space for the adjacent SETLPI frame but does not
currently emulate it, so leave it out of the guest DT.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/gic.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arm64/gic.c b/arm64/gic.c
index 9a8f9916..955eeb5f 100644
--- a/arm64/gic.c
+++ b/arm64/gic.c
@@ -588,6 +588,15 @@ void gic__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 
 static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
 {
+	char node_at_addr[64];
+	u32 cpus[kvm->nrcpus];
+	u16 iaffids[kvm->nrcpus];
+	/* KVM reserves the SETLPI frame but does not emulate it. */
+	u64 irs_reg_prop[] = {
+		cpu_to_fdt64(ARM_GICV5_IRS_CONFIG_BASE),
+		cpu_to_fdt64(ARM_GICV5_IRS_CONFIG_SIZE),
+	};
+
 	_FDT(fdt_begin_node(fdt, "gicv5-cpuif"));
 	_FDT(fdt_property_string(fdt, "compatible", "arm,gic-v5"));
 	_FDT(fdt_property_cell(fdt, "#interrupt-cells", GIC_FDT_IRQ_NUM_CELLS));
@@ -599,6 +608,30 @@ static void gic__generate_gicv5_fdt_nodes(void *fdt, struct kvm *kvm)
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
+	_FDT(fdt_property_string(fdt, "reg-names", "ns-config"));
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

