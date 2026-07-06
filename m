Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FB37C923
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303957; cv=none; b=ikUKNTT+Aw7vrJZhlN4vZit3XfxoLotDYOkR/hs+bPFbRcvtM0HBw+OJd9lkBdZlz4wsuH9aHHJ3axxtHYK73EtgjgM41wXZJ4vtjVf3PMOwMEf11ftXfEYjjJkSe34MmH+XQ8tyswSIqMLtN0pKQzGVypp/4lMN/fhwsNuAtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303957; c=relaxed/simple;
	bh=U9DQGPROwJOnRQToob0nRWEH2RGcqydB6+hnMh20fUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaJ+z0Y3/wSMS5K1NhcE5kGPDiPs0Uf/UC182p0dJqC69lLwWPifBl7WRuQ/98hl3TK0DM+d6FSrCoitiuPSDfPbkTnL6pTqQAxwND8uI7jdIl8b5dmgJfXq5mnwchLuf/DiF3YfeXyEs+eLcU5LEMsEK0oX5H7E0YPUWqp4UvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5axyH33; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5axyH33"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cae1a3a744so17418475ad.3
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783303956; x=1783908756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YsyBUeISRtTsmCW0fRgq5oh/PaolZ1FgVZ4dpWHLHI=;
        b=F5axyH333GjrPmGYG4GZ9ie4j5cschYe8EI4V7dI86152iAGd0+zqVdciNZfZugndM
         ORTLlZt6MJK2Bs/jTw0mCbpXIqTbx/40Jf80P8h+2ZifmumnFSjy4zYmBkqWc8FlA5Jf
         KxSlsUB9ZwgSZWa7S7nebgegrgx2+LM/D05Khzxq9L/ut2nHvf0L16b7yo7gMaM9ui07
         U11wZib4gxQF+UWiBR0gEzZqaKkRdbRSFFVIJIjgwbtms9jYUwKSmb0VvzM5kVm9IxnJ
         Oswzg8B480OeK8HOhW2bvWF6oL1BeXZ5ilRW2JRnXauQBpLq3aQM8J6WaKxec39jdkVq
         yJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783303956; x=1783908756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YsyBUeISRtTsmCW0fRgq5oh/PaolZ1FgVZ4dpWHLHI=;
        b=kgPIXYLVkVPrAo9gmOS215mpnX0pH4HJEiB233x1Ol8flLi3npdhnMFvlA9SFpXn7P
         Bxeqcpg0opkmvFJXQfd7xFfglxxvacDBfFRStDgVpMEIMLKSTjvv5c33szbwTAxWhpjb
         Cl5/YhQEKgB+VLtYBzAnpp41Gj/RO8wQX8dgR6Nqlm8zgIYVUINZ0mkQJ4mF7vpLdoJr
         +sQyxh+84pi3+rrg3CK23FbCwgGtGCcoDffvEKOccvPHREpYQ2CJ5Ra25TRp2uqUK8oA
         qicrbroI0nAmgeHhWh6etUvaFyVTL74x7YzwjthMVWMLiLNt3ysiU2Y4i9XMkAX4mVfl
         eoRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEI8lwEMsd7KoXrzHvK0qWJk1ig2dX3gky7qUVtcBXTAp6XBmluTLtd/6/ZnF0UE/L5sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmdsoXaYCoeGuhbW95PAB01ifX3amyH9Pss27vMcuYSYAMp3X
	bM5Al7lN6Z5kGX2Ya/5J9PckC/YE3GHWe60WBsc4kvVOQjatRcRspDCm
X-Gm-Gg: AfdE7ckZBK/GQBe6a+zoBM0FSoPew+43FUcOYedwR3kfk+6Bch4fbkkoOuXJdkqpwCc
	jq3XLyufFFJeJc0SnToCas/NpQ8GiTbb5fTSCeNjnCNPUYn7XyUBqcHEfloBThm09W2mcrAfDyt
	cCBVaAXr+hURMhqiFjl/IblFABJLS7D2rc0LpIrGc8AqBuRP8VpMIhXqP59qacrHi/a++czv9A4
	K8Wobh1N80VzoCpc7F0k+VFiQ/IgENYyl8N7BDE2DP04KNW3kZygw2+66sxNGXU2UcuGTWv54IN
	loQsuhJXK81APOPgKhkVKAucNS9AIsexmyl44smwKgyyMuGdCQ3isFQJXKbteLfR/FyXP0d/feP
	adepR74Twz+ffcrTfSZMC1QAFGwVRmPj+O7sZwvlARB2tqIlIXyQ/ij2gNCvdrIYI
X-Received: by 2002:a17:903:3bcb:b0:2ca:e08e:9e70 with SMTP id d9443c01a7336-2cbb9f479a9mr84564265ad.46.1783303956077;
        Sun, 05 Jul 2026 19:12:36 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71270e5sm40338495ad.23.2026.07.05.19.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:12:35 -0700 (PDT)
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
Subject: [PATCH v2 1/3] RISC-V: KVM: Add SBI extension validate callback
Date: Mon,  6 Jul 2026 10:11:50 +0800
Message-ID: <20260706021154.210289-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706021154.210289-1-inochiama@gmail.com>
References: <20260706021154.210289-1-inochiama@gmail.com>
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

