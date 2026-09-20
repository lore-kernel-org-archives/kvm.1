Received: from mail-yx2-f31.google.com (mail-yx2-f31.google.com [74.125.224.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A964718E4
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933036; cv=none; b=GAdVRvzVD/eNEi+TOdtc6CqhUk66lIaC37AdUgoihCA6Iq+DjpzCcP/WciQPhNWRzXbsxqMp9elaSNSK2Ud8qAClQQ5C9Ak14RbNqxy2EsbQ737ocSnzuvyKw8EgshCrOrWjFuE0YWr8Owoshl7WWuiz3eGjM2l3osn2DSYYQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933036; c=relaxed/simple;
	bh=T8oXswy3XoTqpRW/vQA18Qq9+aSSfigAkGNRtoi2I5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw2xPuwlfItwb7WBGNsSTYVI+jJij3LufPbueBzz1DbNwNEb9id3Pltqx2mPaHPGoZ92/QTCx5MsJX7Vq/Sj+Q38d0KCoA4ZoGxAz1rkpA3ZJy7AhlcToviD3PeWiDWyN/iXi+cO51HGr7wx6bimVVwknUHCQUQckJ2nY90x9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HOUu+Vp0; arc=none smtp.client-ip=74.125.224.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HOUu+Vp0"
Received: by mail-yx2-f31.google.com with SMTP id 00721157ae682-8659af7454eso21814397b3.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933033; x=1790537833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gjdNKKGx+yhFaJeCA90Rv+NyjnhIa6+HpCMo5c2ikFg=;
        b=HOUu+Vp0735fEFj6WFuBc3/8Bl8xx4s56LwWXnpIn+UijKhMgpeHreuTa+MptlCCP7
         3UIr4MAlrx0Tm/nDbAI251YE615eSqVkVHGDZS+8C/M4Yr1eaxwcdVIcFMzMOutnyuzn
         mhSItGzRZfn0gPNzjgFvKlgpWisQ7ihkUCtpde75WLcRIqPo0lzd3g94OYrGYbIPll+Y
         DvIFZyhZMdCpOJYIe8+2YdsmLbWD8cPu9YgRvUWx6Jihn/ubOCD6pdrXED+4wmTe6WzQ
         L1PjnHtdpKo5IYThcoXy0OUNXm09FpyGZKVpQL62WXmWSKwbIlxU1z9A+Z3W6HBUhQOd
         H8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933033; x=1790537833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gjdNKKGx+yhFaJeCA90Rv+NyjnhIa6+HpCMo5c2ikFg=;
        b=qs354Y9mRDZ4zqv0xsvobuaqcEqCWHUTI8Q9POGU1KIa2hY0g0dYmryAD/93w8jOo8
         TJE398G3C7TjAX/nUVB0pRa1X1In97e/h9ZmBMCXww36TDam6U0TK34mL1UuomcXlRf5
         0j5sMaPRkY3gpGXUAbffAQgJnZLlHTj7dqadQDEQ+s/SG3hUiPqsxQzPpf5+Q2mCGHb9
         oNVgXa1Th595CpBcOkLx56WmcLFgw2vdRDlfffcgBGjflqrl0YvZjVxj1IiDtmxF9xZG
         x68qY7CNd2sfFTJTQ15GFLXr22/J7v38Kbp+h3JFTupbs9IXKUb73IrYHblc0orZKNmh
         58DA==
X-Forwarded-Encrypted: i=1; AKwUvBwBqizS/7+4KZUxiOQ7RD0skLEwsxXu+j32lRqo1pf04ju76+YL8b9cz2WyKIMyGxqR7E4=@vger.kernel.org
X-Gm-Message-State: AFuF++kuXADYDkmKZaHWJa2gYJRxtpEijxMMjPfdPP0vR19pARTruRLm
	9bMaizvjNqSIMQjw6Ka3xq1wNv41aHmGEfC2FXYu3ytalRJ31ID0KzwNmK9uM65XpU8=
X-Gm-Gg: AYBFou2e35CV6/rcb7Mmo2+/s5Xvprdenk8bvY5aZwTy+Ysw8llGx+SGtbSbW9hZp4h
	va+fpq2g/YeYQib1nTdNRDSxqdHAF5dGzuXxPpMrI/NrNh2CzQYAGeJ1+WG0toN+TYgzJcCA9Rn
	C8HmVSxk+wNS67txN+1qZOvjydauM4PR3oJ8mi0W4PP15qVju1Q+g9oKBK9qiBd5pJT9WvooNB+
	3YrlktXz+D0ctj+Ts2y+Z90iQ8xG6vxKE96ibE9XpIp39SAV2/uEw+LFQ311rm1P7tfyynwvInW
	/RltKDQp3GkCSx7ofUcR7Jr5nVwx7bg4MLGQ78O0DVSQV2J0pxEO6XBplBMAieZcoKqdHEuIeHg
	MnXl84lhPcAjGU4OTof6qFN1aR+yx/Fd3qWwRJlBXUnoTQn29IWdJh7odBvZ9DPedH43xeTflHl
	AMcYPzGKeh2Su6YGROig8aWV6/TT/9eBo9OboGliOonFDIpbA039PG9NyZr6tPfWjIFTizpBhPI
	xbrViG9ZjDYxv1LPFt1o+XnQEQ8MTVU5C5RC4LdU8diBBMT0jj9Lzn3QTKZ5bSNVw+ovM0O2QEI
	XdYuSwXs28aJLG/3oEc=
X-Received: by 2002:a05:690c:9988:b0:89b:5551:4305 with SMTP id 00721157ae682-89b5560974dmr13921117b3.17.1789933033098;
        Sun, 20 Sep 2026 12:37:13 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a48aab042sm18596427b3.47.2026.09.20.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:12 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 03/46] KVM: arm64: Split kvm_sys_reg_{get,set}_user from kernel accessors
Date: Sun, 20 Sep 2026 15:36:07 -0400
Message-ID: <20260920193650.3373435-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor __kvm_sys_reg_get() and __kvm_sys_reg_set() out of the userspace
ioctl handlers and introduce struct sys_reg_index_sink so in-kernel
callers can enumerate, read, and write architectural system registers
via kvm_arm_get_sys_reg_indices(), kvm_arm_sys_reg_read(), and
kvm_arm_sys_reg_write().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/sys_regs.c | 199 ++++++++++++++++++++++++++++++--------
 arch/arm64/kvm/sys_regs.h |   4 +
 2 files changed, 160 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b873ccf1ab14..0049e460e5ad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5569,38 +5569,43 @@ static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 	return demux_c15_set_val(vcpu, id, newval);
 }
 
-static u64 kvm_one_reg_to_id(const struct kvm_one_reg *reg)
+static u64 kvm_one_reg_to_id(u64 reg_id)
 {
-	switch(reg->id) {
+	switch (reg_id) {
 	case KVM_REG_ARM_TIMER_CVAL:
 		return TO_ARM64_SYS_REG(CNTV_CVAL_EL0);
 	case KVM_REG_ARM_TIMER_CNT:
 		return TO_ARM64_SYS_REG(CNTVCT_EL0);
 	default:
-		return reg->id;
+		return reg_id;
 	}
 }
 
-int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
+static int __kvm_sys_reg_get(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val,
+			     const struct sys_reg_desc table[], unsigned int num)
 {
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
+	u64 id = kvm_one_reg_to_id(reg_id);
 
 	r = id_to_sys_reg_desc(vcpu, id, table, num);
 	if (!r || sysreg_hidden(vcpu, r))
 		return -ENOENT;
 
-	if (r->get_user) {
-		ret = (r->get_user)(vcpu, r, &val);
-	} else {
-		val = __vcpu_sys_reg(vcpu, r->reg);
-		ret = 0;
-	}
+	if (r->get_user)
+		return (r->get_user)(vcpu, r, val);
+
+	*val = __vcpu_sys_reg(vcpu, r->reg);
+	return 0;
+}
+
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	u64 val;
+	int ret;
 
+	ret = __kvm_sys_reg_get(vcpu, reg->id, &val, table, num);
 	if (!ret)
 		ret = put_user(val, uaddr);
 
@@ -5618,17 +5623,11 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 }
 
-int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
+static int __kvm_sys_reg_set(struct kvm_vcpu *vcpu, u64 reg_id, u64 val,
+			     const struct sys_reg_desc table[], unsigned int num)
 {
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
-
-	if (get_user(val, uaddr))
-		return -EFAULT;
+	u64 id = kvm_one_reg_to_id(reg_id);
 
 	r = id_to_sys_reg_desc(vcpu, id, table, num);
 	if (!r || sysreg_hidden(vcpu, r))
@@ -5637,14 +5636,23 @@ int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 	if (sysreg_user_write_ignore(vcpu, r))
 		return 0;
 
-	if (r->set_user) {
-		ret = (r->set_user)(vcpu, r, val);
-	} else {
-		__vcpu_assign_sys_reg(vcpu, r->reg, val);
-		ret = 0;
-	}
+	if (r->set_user)
+		return (r->set_user)(vcpu, r, val);
 
-	return ret;
+	__vcpu_assign_sys_reg(vcpu, r->reg, val);
+	return 0;
+}
+
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	u64 val;
+
+	if (get_user(val, uaddr))
+		return -EFAULT;
+
+	return __kvm_sys_reg_set(vcpu, reg->id, val, table, num);
 }
 
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -5688,25 +5696,24 @@ static u64 sys_reg_to_index(const struct sys_reg_desc *reg)
 		(reg->Op2 << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
 }
 
-static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+static u64 reg_to_user_idx(const struct sys_reg_desc *reg)
 {
-	u64 idx;
-
-	if (!*uind)
-		return true;
-
 	switch (reg_to_encoding(reg)) {
 	case SYS_CNTV_CVAL_EL0:
-		idx = KVM_REG_ARM_TIMER_CVAL;
-		break;
+		return KVM_REG_ARM_TIMER_CVAL;
 	case SYS_CNTVCT_EL0:
-		idx = KVM_REG_ARM_TIMER_CNT;
-		break;
+		return KVM_REG_ARM_TIMER_CNT;
 	default:
-		idx = sys_reg_to_index(reg);
+		return sys_reg_to_index(reg);
 	}
+}
 
-	if (put_user(idx, *uind))
+static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+{
+	if (!*uind)
+		return true;
+
+	if (put_user(reg_to_user_idx(reg), *uind))
 		return false;
 
 	(*uind)++;
@@ -5986,3 +5993,109 @@ int __init kvm_sys_reg_table_init(void)
 
 	return ret;
 }
+
+/* The GICv3 CPU interface sysregs, or NULL if the in-kernel GICv3 is unused. */
+static const struct sys_reg_desc *vcpu_gic_sysreg_table(struct kvm_vcpu *vcpu,
+							unsigned int *num)
+{
+	if (!irqchip_in_kernel(vcpu->kvm) ||
+	    vcpu->kvm->arch.vgic.vgic_model != KVM_DEV_TYPE_ARM_VGIC_V3)
+		return NULL;
+
+	return vgic_v3_get_sysreg_table(num);
+}
+
+static void collect_table_indices(struct kvm_vcpu *vcpu,
+				  const struct sys_reg_desc *table,
+				  unsigned int num, u64 **out, int *count)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		const struct sys_reg_desc *rd = &table[i];
+
+		if (!(rd->reg || rd->get_user) || sysreg_hidden(vcpu, rd))
+			continue;
+		if (*out)
+			*(*out)++ = reg_to_user_idx(rd);
+		(*count)++;
+	}
+}
+
+/*
+ * Enumerate every system register that kvm_arm_sys_reg_read() can return for
+ * @vcpu.  This is a superset of KVM_GET_REG_LIST: it also covers the GICv3 CPU
+ * interface table, which has no uAPI representation.  Pass a NULL @indices to
+ * query the number of entries the array needs to hold.
+ */
+int kvm_arm_get_sys_reg_indices(struct kvm_vcpu *vcpu, u64 *indices)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0, i;
+	int count = 0;
+
+	collect_table_indices(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs),
+			      &indices, &count);
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (gic_regs)
+		collect_table_indices(vcpu, gic_regs, sz, &indices, &count);
+
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if (indices)
+			*indices++ = KVM_REG_ARM64 | KVM_REG_SIZE_U32 |
+				     KVM_REG_ARM_DEMUX |
+				     KVM_REG_ARM_DEMUX_ID_CCSIDR | i;
+		count++;
+	}
+
+	return count;
+}
+
+int kvm_arm_sys_reg_read(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0;
+	int ret;
+
+	if ((reg_id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX) {
+		u32 uval;
+
+		ret = demux_c15_get_val(vcpu, reg_id, &uval);
+		if (!ret)
+			*val = uval;
+		return ret;
+	}
+
+	ret = __kvm_sys_reg_get(vcpu, reg_id, val, sys_reg_descs,
+				ARRAY_SIZE(sys_reg_descs));
+	if (ret != -ENOENT)
+		return ret;
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (!gic_regs)
+		return ret;
+
+	return __kvm_sys_reg_get(vcpu, reg_id, val, gic_regs, sz);
+}
+
+int kvm_arm_sys_reg_write(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0;
+	int ret;
+
+	if ((reg_id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_set_val(vcpu, reg_id, (u32)val);
+
+	ret = __kvm_sys_reg_set(vcpu, reg_id, val, sys_reg_descs,
+				ARRAY_SIZE(sys_reg_descs));
+	if (ret != -ENOENT)
+		return ret;
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (!gic_regs)
+		return ret;
+
+	return __kvm_sys_reg_set(vcpu, reg_id, val, gic_regs, sz);
+}
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index bd56a45abbf9..9837db99909b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -292,4 +292,8 @@ int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
 					      sys_reg_CRm(SYS_ ## r),	\
 					      sys_reg_Op2(SYS_ ## r))
 
+int kvm_arm_get_sys_reg_indices(struct kvm_vcpu *vcpu, u64 *indices);
+int kvm_arm_sys_reg_read(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val);
+int kvm_arm_sys_reg_write(struct kvm_vcpu *vcpu, u64 reg_id, u64 val);
+
 #endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
-- 
2.55.0.1082.g2b9226bbc0-goog

