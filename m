Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033E235045
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278177; cv=none; b=rhxpIKTZTYUFXUQMtVM665h0QdBOjGBz2G7bvLBlLEwJvopPyVvGq3Cy3qPKbSmYuFXeuZgpCOm7xTOYAPb0/8K/HFiWVM0L6teyOfu2aiwDnYxzbLaZmp+MfX8lMsEjzq4MeJuOQdpj7OcBBpOSc2RlO1zzQ7j4cyE5rtwHqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278177; c=relaxed/simple;
	bh=k9lHAzZ0mz/6+uMLG5Jftm+uhaM7TMoNiQEN86drbKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv69qa30bJ97HYZFHa3YGCpGse4SwHJepL7kUuHGl6TqQLWaTVOSOO0tWHxniDfPfy+tvrN2AAnUXPFryq7bpqy8bChpiv64+QmcTau+9OUhTr9XnZ0JWTOUjVagoWS/q4Rm4icX2GNz4m9BAgNqbc4wOmM/ecMnJvLXpRViR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2744F14BF;
	Mon, 23 Mar 2026 08:02:49 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00CD93F73B;
	Mon, 23 Mar 2026 08:02:52 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 3/6] arm64: Initialise the PMU last
Date: Mon, 23 Mar 2026 15:02:18 +0000
Message-ID: <20260323150221.49256-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMU initialisation is done in:

setup_fdt()
  vcpu->generate_fdt_nodes()
    pmu__generate_fdt_nodes()

The PMU ioctl KVM_ARM_VCPU_PMU_V3_INIT requires that the GIC has been
initialised, which is done in gic__init_gic().

gic__init_gic() and setup_fdt() are part of the same initialisation list.
The relative order on the list depends on the order of compilation: gic.c
is compiled after fdt.c and this places gic__init_gic() first on the
initialisation list.

If the compilation order changes and gic.c is compiled *before* fdt.c,
gic__init_gic() will be executed *after* setup_fdt() and PMU initialisation
will fail with an error message:

PMU KVM_SET_DEVICE_ATTR: No such device

This is fragile and hard to debug. Improve the situation by creating a new
init list, last_init(), execute it after late_init(), and move PMU
initialisation on that list.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Another option would be to initialise the gic in:

setup_fdt()
  vcpu->generate_fdt_nodes()
    gic__generate_fdt_nodes() <-- initialise here
    timer__generate_fdt_nodes()
    pmu__generate_fdt_nodes()

but doing device initialisation in the same function that generates the fdt
seems out of place, so I opted to initialise the PMU outside of the
function that generates the FDT, in an init list, just like the GIC.

 arm64/pmu.c             | 29 +++++++++++++++++++----------
 include/kvm/util-init.h |  6 ++++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arm64/pmu.c b/arm64/pmu.c
index 5f31d6b6f346..e15244b51c1f 100644
--- a/arm64/pmu.c
+++ b/arm64/pmu.c
@@ -193,21 +193,32 @@ static int find_pmu(struct kvm *kvm)
 void pmu__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	const char compatible[] = "arm,armv8-pmuv3";
-	int irq = KVM_ARM_PMUv3_PPI;
-	struct kvm_cpu *vcpu;
-	int pmu_id = -ENXIO;
-	int i;
-
 	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
 	u32 irq_prop[] = {
 		cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI),
-		cpu_to_fdt32(irq - 16),
+		cpu_to_fdt32(KVM_ARM_PMUv3_PPI - 16),
 		cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_HIGH),
 	};
 
 	if (!kvm->cfg.arch.has_pmuv3)
 		return;
 
+	_FDT(fdt_begin_node(fdt, "pmu"));
+	_FDT(fdt_property(fdt, "compatible", compatible, sizeof(compatible)));
+	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
+	_FDT(fdt_end_node(fdt));
+}
+
+static int pmu__init(struct kvm *kvm)
+{
+	int irq = KVM_ARM_PMUv3_PPI;
+	struct kvm_cpu *vcpu;
+	int pmu_id = -ENXIO;
+	int i;
+
+	if (!kvm->cfg.arch.has_pmuv3)
+		return 0;
+
 	if (pmu_has_attr(kvm->cpus[0], KVM_ARM_VCPU_PMU_V3_SET_PMU)) {
 		pmu_id = find_pmu(kvm);
 		if (pmu_id < 0) {
@@ -228,8 +239,6 @@ void pmu__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 		set_pmu_attr(vcpu, NULL, KVM_ARM_VCPU_PMU_V3_INIT);
 	}
 
-	_FDT(fdt_begin_node(fdt, "pmu"));
-	_FDT(fdt_property(fdt, "compatible", compatible, sizeof(compatible)));
-	_FDT(fdt_property(fdt, "interrupts", irq_prop, sizeof(irq_prop)));
-	_FDT(fdt_end_node(fdt));
+	return 0;
 }
+last_init(pmu__init);
diff --git a/include/kvm/util-init.h b/include/kvm/util-init.h
index 13d4f04df678..e6a0e1696689 100644
--- a/include/kvm/util-init.h
+++ b/include/kvm/util-init.h
@@ -39,7 +39,8 @@ static void __attribute__ ((constructor)) __init__##cb(void)		\
 #define dev_init(cb) __init_list_add(cb, 5)
 #define virtio_dev_init(cb) __init_list_add(cb, 6)
 #define firmware_init(cb) __init_list_add(cb, 7)
-#define late_init(cb) __init_list_add(cb, 9)
+#define late_init(cb) __init_list_add(cb, 8)
+#define last_init(cb) __init_list_add(cb, 9)
 
 #define core_exit(cb) __exit_list_add(cb, 0)
 #define base_exit(cb) __exit_list_add(cb, 2)
@@ -47,5 +48,6 @@ static void __attribute__ ((constructor)) __init__##cb(void)		\
 #define dev_exit(cb) __exit_list_add(cb, 5)
 #define virtio_dev_exit(cb) __exit_list_add(cb, 6)
 #define firmware_exit(cb) __exit_list_add(cb, 7)
-#define late_exit(cb) __exit_list_add(cb, 9)
+#define late_exit(cb) __exit_list_add(cb, 8)
+#define last_exit(cb) __exit_list_add(cb, 9)
 #endif
-- 
2.53.0

