Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9C389114
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303457; cv=none; b=fIGMhU5H45Yhl71jrvdOCTPXwF8vmT4JQJ6ILhcAPdrmwaQnQxWR5VU87QrWAxjZTcBqRLqZYw2jaYvHC4upy/nCFZEZBL5tzzSlqNl6A2lu7gO4ozs3oNZVTB512ipUcEnJyzoUEpqz/fa2fFnyEE6W4yErf1oOT3jv4hY0HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303457; c=relaxed/simple;
	bh=rSw8xLVMbspmhOI6/O0Zaty2a8gG9W16fqgOYoREso4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgv/cc6Kk6t4eRtkKZBUin/FoAKakQL3pjdAqb3kagUKVtYzp3ayGk3zMZnhYQ+FNe4Sb/ak/nmP1kDkfXhFUOwnYMLa6EnAl5DXvECj4edRyQu8V/42MJph+rgi8PyPuykVaSI0PXwImiUHTuw9qU8jFzw6XmaUtoOQ+OVVI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv50/QHh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv50/QHh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf1f074a12so31010735ad.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303455; x=1780908255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZP5r0J73Q2Ucds4N11ve2c25N4gijVaOCy/mmdW+YU=;
        b=Qv50/QHh4XPFkhcvvSkSILmJOMfYZXQCtFTHl/Y7BuEEn+12Axhcj/n0L6eDUXhSfR
         IKO0xS3gS91k3loynFwFqT5rHEw2GV7pH/BsYsjj3qVJdAhTYVf64F/OPTbvBscRYnZq
         8OU7FIw4QUYVrwwTgBHQeJC8vNWjYPDfbb/Qx/EtwyxPOLIJ9DA8j7g6l+uTlArT5XJG
         dQgfykfvrdyMd54RhM5VqHPNQV2IFRmB6b1RJQ97r1UoLYHjvNudjUMXkwS40SBLgT4z
         Eq43vheK9TyOh2SgKuA6zZ88F1WWhS7FnQQZHRZuhNwewK9+/KdgDTgWbKrEPMemheDl
         JBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303455; x=1780908255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZP5r0J73Q2Ucds4N11ve2c25N4gijVaOCy/mmdW+YU=;
        b=iqsYXincVXOuOYzpF92qlo9lKQkCQF7KoAknPLlUrQIa6HHXQibHp5pERqlVu9aADp
         ZTYimug7xGiwmdijiDnLL1vT/FpM+xeFZuV+CEtQulgJOIoyggWLT7Jcor+rcyKPeSxe
         n6pzbRKTo894AR1NwmE3/2q3KxoycCYIG9PoW/Eu72lXnqflXWXm1Dlctr/DQ8wwUHmr
         n8y0P/zqPCqk+x1SBiHs4z8pCjP5XUINau2bpnpYLKcyyqpJlB1IN6Lv6ZbTGjunFJYo
         0OL/nKun5CyBqbPZ9Ev/VTl0dBCRjvmPfwMIzu+35RjUKEKdFS266CBJnimef2hSU50R
         ndeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Pn5Q1nb6zseIs2G/SE+r2oZVQZQryUdSgCUrylGo1Ci16Tyd1k11S+OIrmD+rTDqmnCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz0bhPfk8fVZ0GUMFMny4qBJTsFyfNpH+8YwwZ1YbnHkxlsxI
	NJfNRXC1VE+MIGOWpJ4DXils/q3uRtWEZbImMC5MuhaCN8tCp9tb+HrE
X-Gm-Gg: Acq92OEIHtlG5H4oPGmRqrKcgbDqBZfw7FMZ7Wa1spVZALe/ChVZUbGcikIbhYPhF8z
	STXoHlgTshhZXAZF2PmpVOKDWuRgEsKdO9Y1jNsKTuz77V+GRMaTV7GpGOk+kKU2Bfkn7CiWg6K
	s5qUina1EbtKDRKAmRHbydXPBKr7cFWMbXmOTRtkY2zNmypuZHgTJChQKPQatWr8szhV8QQAEH/
	nlA7i5816coCrrBEEoMbSxmPij41K2UQP/8AexvCz+I4YfEJkysXGKSz115ZZgTwaNcllrOMRSv
	Fg4igMvw82wrVcz8IAIvJCwE9Qj4DlvtN/XC/e4Ia6AefG/iRV2F3Q6bgs/FCjhMrGv/83kckTy
	mGNM2c3yh0qqmSXgU/8vqM/p/iWlKAKkBK38TOnOJHUq6RQnYWbwHL1rFWFcG8mIRaFG8zxA4gq
	0e6cUnj+NEQW6T52fEd/ReU9fu142pHYAupA==
X-Received: by 2002:a17:902:e749:b0:2c0:b4f5:41d4 with SMTP id d9443c01a7336-2c0b4f5428bmr82594955ad.41.1780303454902;
        Mon, 01 Jun 2026 01:44:14 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c26bcesm95822185ad.65.2026.06.01.01.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:44:14 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2 6/7] RISC-V: KVM: Add support for control-flow integrity FWFT features
Date: Mon,  1 Jun 2026 16:43:34 +0800
Message-ID: <20260601084336.2601675-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084336.2601675-1-inochiama@gmail.com>
References: <20260601084336.2601675-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Control-flow integrity is controlled through a WARL field in henvcfg.
Expose the feature only if the Zicfilp/Zicfiss is supported for VS-mode.
Allow the VMM to block access to the feature by disabling the ISA
extension in the guest.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 375269e43c13..278eb95b97de 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -163,6 +163,58 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
 	return SBI_SUCCESS;
 }
 
+static bool kvm_sbi_fwft_landing_pad_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, ZICFILP);
+}
+
+static void kvm_sbi_fwft_reset_landing_pad(struct kvm_vcpu *vcpu)
+{
+	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_LPE);
+}
+
+static long kvm_sbi_fwft_set_landing_pad(struct kvm_vcpu *vcpu,
+					 struct kvm_sbi_fwft_config *conf,
+					 bool one_reg_access, unsigned long value)
+{
+	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_LPE);
+}
+
+static long kvm_sbi_fwft_get_landing_pad(struct kvm_vcpu *vcpu,
+					 struct kvm_sbi_fwft_config *conf,
+					 bool one_reg_access, unsigned long *value)
+{
+	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_LPE);
+}
+
+static bool kvm_sbi_fwft_shadow_stack_supported(struct kvm_vcpu *vcpu)
+{
+	return riscv_isa_extension_available(vcpu->arch.isa, ZICFISS);
+}
+
+static void kvm_sbi_fwft_reset_shadow_stack(struct kvm_vcpu *vcpu)
+{
+	kvm_sbi_fwft_env_flag_reset_helper(vcpu, ENVCFG_SSE);
+}
+
+static long kvm_sbi_fwft_set_shadow_stack(struct kvm_vcpu *vcpu,
+					  struct kvm_sbi_fwft_config *conf,
+					  bool one_reg_access, unsigned long value)
+{
+	return kvm_sbi_fwft_env_flag_set_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_SSE);
+}
+
+static long kvm_sbi_fwft_get_shadow_stack(struct kvm_vcpu *vcpu,
+					  struct kvm_sbi_fwft_config *conf,
+					  bool one_reg_access, unsigned long *value)
+{
+	return kvm_sbi_fwft_env_flag_get_helper(vcpu, conf, one_reg_access,
+						value, ENVCFG_SSE);
+}
+
 static bool kvm_sbi_fwft_pte_ad_hw_updating_supported(struct kvm_vcpu *vcpu)
 {
 	return riscv_isa_extension_available(vcpu->arch.isa, SVADU) &&
@@ -288,6 +340,24 @@ static const struct kvm_sbi_fwft_feature features[] = {
 		.set = kvm_sbi_fwft_set_misaligned_delegation,
 		.get = kvm_sbi_fwft_get_misaligned_delegation,
 	},
+	{
+		.id = SBI_FWFT_LANDING_PAD,
+		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, landing_pad.enable) /
+				 sizeof(unsigned long),
+		.supported = kvm_sbi_fwft_landing_pad_supported,
+		.reset = kvm_sbi_fwft_reset_landing_pad,
+		.set = kvm_sbi_fwft_set_landing_pad,
+		.get = kvm_sbi_fwft_get_landing_pad,
+	},
+	{
+		.id = SBI_FWFT_SHADOW_STACK,
+		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, shadow_stack.enable) /
+				 sizeof(unsigned long),
+		.supported = kvm_sbi_fwft_shadow_stack_supported,
+		.reset = kvm_sbi_fwft_reset_shadow_stack,
+		.set = kvm_sbi_fwft_set_shadow_stack,
+		.get = kvm_sbi_fwft_get_shadow_stack,
+	},
 	{
 		.id = SBI_FWFT_PTE_AD_HW_UPDATING,
 		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pte_ad_hw_updating.enable) /
-- 
2.54.0

