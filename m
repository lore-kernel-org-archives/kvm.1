Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F873FD97A
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899285; cv=none; b=iQszQLGyc4L5bdLgGBr8WOi9gTk6UGR3Tf1J19/oWvzkSyB+5Eqw8oXjhPegpUStwopkvsceu5ladHEEprjVqwIl1B7OXXbll3j9nof+NyJ/LyaInohmdoRsZehDIt7R6LeNyABz/EgXWQJBzAgC8ITa1xA2RQ66pUxCMLeiaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899285; c=relaxed/simple;
	bh=U9DQGPROwJOnRQToob0nRWEH2RGcqydB6+hnMh20fUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKhVCjidd89J6C+sAccqcJahCVFyqK/fLMKA/7x9kpfiMHghzeYbRO+hw4GG29qR5hdaI8H4YGrHJB8ynSF3mfPISGHhvrpzbxWNlTH0PTNkCqIT+R7GcBPfFU8CQZd9GAQVUQagTXMd20j2dH943jqK+v8m6zF+VVlNb+TtOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwkMTj87; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwkMTj87"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c9c1779fc8so1936345ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899283; x=1783504083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YsyBUeISRtTsmCW0fRgq5oh/PaolZ1FgVZ4dpWHLHI=;
        b=nwkMTj87bJ68wdNs035uO/zCZwLGArAqcD4apejyOIHd2NBYyzfAVh/TB4Y0a6VOkx
         rsXO0M3ar3zByVbPi/Xof0/Ki9Iqtt4wso55tPb2O1Dbvb0gr2FIQq42KSlb5AXAXZbz
         TaPFnOz4iomRrqXETluyO60V5tOU9VJyPnQrykZGpdJvvf5IIYtt6HSVDroOJmWPmKNE
         6L4/9RMFgzEl8QdvpwWAOH868L1b33lV6p9AxpLx0mbqWbFs0kDeLySFAu755meDkVqA
         SaREOckCHzdFWrkffcc1R5MhU30gxgnD+iWKOC4U4ltPabvnez/O21SkK0M8O7Aiw+6y
         Qztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899283; x=1783504083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YsyBUeISRtTsmCW0fRgq5oh/PaolZ1FgVZ4dpWHLHI=;
        b=Arw61OauknUavc22wZ0zEKvEcRGHE9/cD61HSS8/9dxkJhdeQ8BdOKBiyrxCfWbUY5
         7e7YvcH+YM93/e6wt9HDUUxOFvUar7fWjMRk9A5PmZyYivaXqnfdPu1X2eakA4Ovdx7u
         JfezWtLP2NImSGogjElFmJCrnBoSOZ692uBIK1v1AnSqTs/BFlT/FgvXg83qyweeIUyF
         qlbZSxsfK+uJseTnvEQvv7XybNt4Cd71HPyw1dgGoxQnGdTIU4pT2GU0Bjh0YdfNAG/Z
         xpLBbqfr3w8ZJh2BtkaCT6CnlKVwNiGu6VchR4SKht55cKb2ecVqpOPUBwMHt2qxmVcG
         c0tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNVpN6XsOpbx8pPoTq6LxPVjMFwrhxZEhPffCfjqP7Z06al8xFwZNOy7PotUKzeE4xctI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkVvSY+Ik2kUVajb05Yv/JI8r8iGBKeaUYxrOyzANUM7sKuK6
	OkWo1Z7yCTF4nWwP7aK1kMBgOnkBN/lR2AD+h90/5ji19AbHq0jNx60Z
X-Gm-Gg: AfdE7clNGGeqVpdQg5VZ0JTh0UKHwLuaAFebQu/+Leu8oMV9K7LSyJjvqc8xxV6mSJC
	6Ac+T3HIWwXAt9RNWvpHydTfMClRMiZjKe/2VSEwEZ+3YcOF1Qb402YF7yGBthu1P4lAOnp7E+9
	3e0TC1D5XVRvEInwT8f62nQqsIRx7q2FLp++d8GMgCn/ZxpCU6BQUeyPal3kxCT1QNdHEKXllY0
	f7OzI86OYzTwaE5AIaXf3HOE8rS6GohlMiwFc4UWDGhrec+GmOgmuMdfyzM4Q6U8FaXm6bfFlHr
	NLSeyVw3CMOiXnPgTgHC995paLjb9Lbvq9SUfjgCulZ7WhOjoB0CkPsS/ZPw5ruHVK1Bheacjt1
	nEYooHnrDytIzHb2WAOSWLhRRVEffJKEgGRPqWo1uudRKMF3gLnL7/7l9YCsZZduk82KWfsNAor
	b06m9HPwNeCIs=
X-Received: by 2002:a17:902:e5c3:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2ca7e8dbc1amr9889895ad.27.1782899282902;
        Wed, 01 Jul 2026 02:48:02 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4f2a71a9sm21530155ad.44.2026.07.01.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:48:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/3] RISC-V: KVM: Add SBI extension validate callback
Date: Wed,  1 Jul 2026 17:47:28 +0800
Message-ID: <20260701094731.1022163-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701094731.1022163-1-inochiama@gmail.com>
References: <20260701094731.1022163-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user disable FWFT extension after setting any value of the
FWFT feature, the state of vCPU will be broken since the value
of disable FWFT feature is still functional.

Add the generic SBI extension validate callback so the FWFT
extension can fix its parameters before the first run.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
 arch/riscv/kvm/vcpu_config.c          |  2 ++
 arch/riscv/kvm/vcpu_sbi.c             | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index c1a7e3b40d9c..f01a2860c751 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -60,6 +60,9 @@ struct kvm_vcpu_sbi_extension {
 
 	void (*reset)(struct kvm_vcpu *vcpu);
 
+	/* Allow the extension to correct its parameters before the first run */
+	void (*validate)(struct kvm_vcpu *vcpu);
+
 	unsigned long state_reg_subtype;
 	unsigned long (*get_state_reg_count)(struct kvm_vcpu *vcpu);
 	int (*get_state_reg_id)(struct kvm_vcpu *vcpu, int index, u64 *reg_id);
@@ -93,6 +96,7 @@ int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_sbi_validate(struct kvm_vcpu *vcpu);
 
 #ifdef CONFIG_RISCV_SBI_V01
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
index 238418fed2b9..b68aa830aaf5 100644
--- a/arch/riscv/kvm/vcpu_config.c
+++ b/arch/riscv/kvm/vcpu_config.c
@@ -69,6 +69,8 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu)
 
 	if (vcpu->guest_debug)
 		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
+
+	kvm_riscv_vcpu_sbi_validate(vcpu);
 }
 
 void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 46ab7b989432..b737e9a7a12a 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -723,3 +723,26 @@ void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
 		ext->reset(vcpu);
 	}
 }
+
+void kvm_riscv_vcpu_sbi_validate(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	const struct kvm_riscv_sbi_extension_entry *entry;
+	const struct kvm_vcpu_sbi_extension *ext;
+	int idx, i;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		entry = &sbi_ext[i];
+		ext = entry->ext_ptr;
+		idx = entry->ext_idx;
+
+		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
+			continue;
+
+		if (scontext->ext_status[idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED ||
+		    !ext->validate)
+			continue;
+
+		ext->validate(vcpu);
+	}
+}
-- 
2.55.0

