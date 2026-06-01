Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EA388887
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303453; cv=none; b=iswD/WqDZkwgyStmctrWa3msD2ErjIsxo8t/StxaN5pnsOLhRS+YyO0WGZZKC2OyOxvVoKcmuhh5OsseuLtm29GEtIw8+oZ6I9WB0ia8+iabb8Mlb5oHehQhGmAMqWxX7tp20vXKxVmeNAVz+1T5Nr+7jFE4ugeo8fujeb4qwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303453; c=relaxed/simple;
	bh=CATGD4oGrzQh1/EsHsvVFO8RwSsQAdGWsawSj+YcGoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTzBEqn16+FNrHpwd05GNx63hSwYgwuEH/dwmwUCWBmkudYkti7WHxOBn5iZL9NLYD9jr0rpGYf+ukPLp9gBKSnJD4f9Hs0YI7OCyb4znXBgPEpObyLs2rNMCPIKEZyKT5u/Sp+CfS/VSsE6hy42M2qVp35v1GNHJpMRlJyr3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgvdr/qd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgvdr/qd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf3781ca51so18812765ad.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303452; x=1780908252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RmuO/Bh/pyYNP3lYnfVLduBl3NGvkZrBTGIwUHKLT0=;
        b=Fgvdr/qduOaN2q0nr7nHzDMUatg7H3zZrCitT7tDVsVs7ktgDgakNxrrCSaTstJhmD
         4yfdVtJXoM2ow8G6tvFpXXOo4rM3q9NgwnZ/7minPSSWOrD3CpWK4HaXnY4uV5RwLS1V
         Ck0mpH5XpdkqA9LoybifKm8q3GwLT36mwZq9ZzE6OZ4iuiYkaXj8F4PYrbPIblhiSIP4
         ql5Tg9GxpA6XGJrJrm7Yug50sCMQhsv4NNlAfFR6nAg4hXbfpPSAub/L6PZpBLEeV97V
         IXKAblVsqQZgsnt02ZM8FdXhuDMV3TWe21Uvovp6rvsuFaksGJ5RKpG2s04azMeVz9+N
         zhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303452; x=1780908252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RmuO/Bh/pyYNP3lYnfVLduBl3NGvkZrBTGIwUHKLT0=;
        b=GcNMbASj+FX6AayDS4mO66RQbmuG3puhO3EQr6eW7YE/lyrHszjWr6nca0MqqTzSO0
         FhntCzY14HwPJTR5Nu5O9DyZOBAYS0iByMq6NF7aTOP0ci+mOztTLEd76phMbSx3MOfQ
         pg1wgGbS5KodfELMgZKPdVtvQR8c5EsoWcB1coLggWHYkH683C1v8eAzXxduR64wv248
         ZyVLniN/1pYGnhZYBbTjNSkkWvQRdpIWggIasmG0uY5iwzRGKRbM6hC1OQ/SKZV6vhx9
         YuDkvaDUThP4bZpogX635hYGGh4/BmFMZbi8OR87QQxTj6gjjxrCav568SbTjiv7tlpS
         CXqg==
X-Forwarded-Encrypted: i=1; AFNElJ9CZDnUd0ga7enzMW4coLK4eeFEJHiZfL7O+N+KE0jI8srT82acS9eeWOKkTC+bV+mE93E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxzRNOe19BpuYC8MXdFd95F1SD+wzNQUe1jAGvd9wAEG/tvMX
	qs5zt8jA1WAAgobeh1gkDspVksaWKw7H98E8EquHcqW7FFtxpIp+r9jm
X-Gm-Gg: Acq92OHy56Ziy4PBG+Lgl30GavQ6E5fTvmSsZNG7PlD6+avp4kOzLmMHIuqPMOHpQRK
	PoyM9YWTbWQU0VBjfg5IQ2rSSGFilDRAFaPoOxh5wpSHx/frlxfPrR26yyDEZTZSG7xEiAHQ7lA
	/ZrHOAaZoao0L/hIJaEUshefUVaFArhbdAt46lNYNyZ+n9Rb5Apl/adqUN9FHqNWEjxYLR36ukf
	IOnGo0nB065ZDb4vywjffhdMQyZTRZ4PVJ+D/wy6fA3fmlQfb36vf1tYbNz3QXVaGpfOM5t4onl
	ar8ittF9lQwLBX7KdBuvYIjiaJ/dotuS5fDDkG7l3DJEfsPeo0egFdqjOtHEruioYTOoA3SRv/s
	T2kSpy9ihAAxve2NBr5AmyJCHV0QUQN803VwcRpPnhRtZlJD1H8Neh0PGFwo8SlySelrEGluBn7
	aRB2utNMQV5b521IeHlpfhH83ZstOBmBi3RGiQQObIr3Tv
X-Received: by 2002:a17:903:41ce:b0:2c0:bcff:e198 with SMTP id d9443c01a7336-2c0bcffe31cmr77989875ad.41.1780303451867;
        Mon, 01 Jun 2026 01:44:11 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd8dbsm101815365ad.21.2026.06.01.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:44:11 -0700 (PDT)
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
Subject: [PATCH v2 5/7] RISC-V: KVM: Handle software-check exits for VCPU
Date: Mon,  1 Jun 2026 16:43:33 +0800
Message-ID: <20260601084336.2601675-6-inochiama@gmail.com>
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

The extension Zicfiss/Zicfilp introduces a software-check exception
to the privilege architecture. Delegate this exception to VS mode so
the CFI violations in VU/VS could be reported.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/csr.h | 1 +
 arch/riscv/kvm/vcpu_config.c | 4 ++++
 arch/riscv/kvm/vcpu_exit.c   | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..224af9facf1f 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -117,6 +117,7 @@
 #define EXC_INST_PAGE_FAULT	12
 #define EXC_LOAD_PAGE_FAULT	13
 #define EXC_STORE_PAGE_FAULT	15
+#define EXC_SOFTWARE_CHECK		18
 #define EXC_INST_GUEST_PAGE_FAULT	20
 #define EXC_LOAD_GUEST_PAGE_FAULT	21
 #define EXC_VIRTUAL_INST_FAULT		22
diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
index b2a1028106d5..dbe4167ac4f1 100644
--- a/arch/riscv/kvm/vcpu_config.c
+++ b/arch/riscv/kvm/vcpu_config.c
@@ -65,6 +65,10 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vcpu)
 
 	if (vcpu->guest_debug)
 		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
+
+	if (riscv_isa_extension_available(isa, ZICFILP) ||
+	    riscv_isa_extension_available(isa, ZICFISS))
+		cfg->hedeleg |= BIT(EXC_SOFTWARE_CHECK);
 }
 
 void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..5ab8e87ed248 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -243,6 +243,9 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		run->exit_reason = KVM_EXIT_DEBUG;
 		ret = 0;
 		break;
+	case EXC_SOFTWARE_CHECK:
+		ret = vcpu_redirect(vcpu, trap);
+		break;
 	default:
 		break;
 	}
-- 
2.54.0

