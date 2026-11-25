Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619690;
	b=1NFMF8mbKROK2jWAsYnkrumG03h8PLaVT4ImQJfqNFbYFd3AsrynsobR5YLAODqpakRq
	 EfKTInP7CCDR6hLSR6Z504PGbnaHmxAtjBYySPljkI2Iu2ff3Zfqe72yevuOpsXdBiKBt
	 JWcdboRAtgKMnXz6TD6S4MNbb5yDQjaIfWc2G4g7/a7CIrKs4u02v/EcASPUZ2FRt/8y3
	 RQZRJwb2emvl26Hua2mZRr3HVvd0gHsor8FGnhCnUcDRGZneetkPu7KR9dSGo/uxeqT+9
	 0m8oa06K4jUROktPtP5u9fr6Xz2fcZX6QUKWCKl7082GZVOnmf1V8qCmvJA0uJrACAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619690;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EcPbxzCRQBLYlwvvdDDDLNfLsZvtpyH5dCphexphWKc=;
	b=XyeauGCyMBUCNb/ldw8SjJ6krCHKldWqZ6mEu2f5oXGaE0KfK2nEkD0CWPwoixm+OA3x
	 Fxdp1chEtuQ10fCsz6skQQwFaNsaRU01WqeqTN8Kd+d6a/Y9IyYkZtgINRs8bRPO7BobX
	 8Wkv+Cl3TuQzoUWiEeehqEtj1JfL5eN7azLhtdC5muHkx5o/rhhxc2YMSg0iuyt3a/rWr
	 kBdv84PskavXDZ+1TjnvSXBeTKJ5m89LsJ8IqWEBiFgJlpX6GrgdCjGC3jN1qqYY/1Gcf
	 0X9SHB40XYdqk3Cy31PnQvQnRIPcMo+0qQWfwk5crefvzLddwFmZANNic3K/O8HDuPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qz0PwL44;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7F606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qz0PwL44
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AB2B1BB2;
	Wed, 25 Nov 2026 07:14:46 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B03A3F86F;
	Wed, 25 Nov 2026 07:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619689; bh=Gy5nVQb/XOWmKP1w3nbVDaP9uLNjDefeN9gWl8BMlBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz0PwL446loGI0qW/7GgZMmUyW3JuMqOlP7D93o8r+pGuYUUHMeHu8XbgT0x+rVHQ
	 2WL4WxYWjWgSAsnl9o7hJC0SNuINW8Cosf8DxzbnySJUt8bv93D/vmxht+y3q8dPqt
	 N9VI3edFFb91dYx6RTpBBYxgJzRNtdW7SM+Uh7cw=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 12/23] arm64: Describe timer PPIs for GICv5
Date: Wed, 25 Nov 2026 15:13:45 +0000
Message-Id: <20261125151356.2875108-13-sascha.bischoff@arm.com>
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

GICv5 DT specifiers use absolute PPI numbers due to having separate
namespaces for the different interrupt types. Keep the existing
GICv2/v3 specifiers by subtracting the legacy PPI base for those
irqchips.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 arm64/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arm64/timer.c b/arm64/timer.c
index 2ac6144f..5eff1e48 100644
--- a/arm64/timer.c
+++ b/arm64/timer.c
@@ -9,16 +9,18 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char compatible[] = "arm,armv8-timer\0arm,armv7-timer";
 	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
-	int irqs[5] = {13, 14, 11, 10, 12};
+	const int irqs[5] = { 29, 30, 27, 26, 28 };
 	int nr = ARRAY_SIZE(irqs);
 	u32 irq_prop[nr * 3];
+	u32 type = gic__get_ppi_fdt_type();
+	int ppi_base = gic__get_ppi_base();
 
 	if (!kvm->cfg.arch.nested_virt)
 		nr--;
 
 	for (int i = 0; i < nr; i++) {
-		irq_prop[i * 3 + 0] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI);
-		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i]);
+		irq_prop[i * 3 + 0] = cpu_to_fdt32(type);
+		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i] - ppi_base);
 		irq_prop[i * 3 + 2] = cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_LOW);
 	}
 
-- 
2.34.1

