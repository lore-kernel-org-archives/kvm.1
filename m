Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409A36E483
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819891; cv=none; b=nSsXJGNlPplDsUUz/iJssE0Y3POmLkpAYeue7D8hWQowoFpfTZfpizLusii63dDJ3K2mDk7b+VBJvk9uVaeRu62ZfNNZYypwWZVXYEtpc6noyuPqTz0Ua8LqPb5unf8obEmzGYwo5dHFVAC4mzOE+Nz9ZOL8btBZv41hGyHGFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819891; c=relaxed/simple;
	bh=8Wu5DYY2ASqkhMET+Fm818M8hWVqHPHtTDXL6Ca444Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgMtac75MRfGxt+FSyBp+Mf5NeSKuF8HZgX0iYi3u3AQz1dHTusPNTqcCypewZMvTTYFOdsAiFPRye6TVygycpXJDqVpEioOsVThDhAmHRX7NtN1pWPAuWa3w2x2pJ6rvXJhxjULqK7vJAOpcJV3PbdIpNvP4iVw8EvC1PXdZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8nWlKac; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8nWlKac"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so2230715a91.2
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780819889; x=1781424689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzHGULD5HxqQOVF8zdlCFjzG5/aQKaT2bot1mulDc9c=;
        b=Z8nWlKac2EOgwGUJqz3FaZFQKMPOHaTnwr5W7tsfD+1iNkrxZa8lz1nzpA0uk0BPQ4
         aogGxElip7MBm6UQSlzOeReH1hA3e86Qm3OoeAm69UDtttIrvVwQ+4URFTzKZ1ZL6idU
         t6dUxo5+5aEk6jCgzoJsvhKJyeiG/KDBaeLiZxpdS7q8I0qqbDcXDjpLPfG2MjX8zez5
         YA2LX1CxGgMZPTXTPjR/wBtPYK+beZ6b++j2yARS9lcDy6KTv+XNQighFcAzWYOOvSk/
         DEcw0uOPY9DfueQE1+d8Uk8f4aV9R6fcXn23wkQ8uwFkX8U/p6MY9sPhgCcEXSGaLfxJ
         jlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780819889; x=1781424689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzHGULD5HxqQOVF8zdlCFjzG5/aQKaT2bot1mulDc9c=;
        b=sgn/TRV9t9zmq7AcsBWwqw/KH8P3AxeWLKIA/s5puhbXgadhRh07Ruvz7D8P4sC2Qj
         ufsbBFR/Sf21jnlHWPPuMRuciVCVNSJJPFh1NNj/4jtPeYPc9vesVEE8oqvl6VZAdYrq
         ZYSFyBkwclbcKc6iqSUn+bvTWWX2J5o1kMi5T9NLvBoM/iPjdmpGe0CMvmol9dpYJQdP
         4zKND5eSAd4xWZhzfyGju5KawG+uVaGf6D48RE4OyiQQJRv3BoQrpH5X0FMW36Pbk5em
         rBy+BbZQw6p81uGY400dRUy5T868ry//dr8wR0Pb6/lyhxkI5F3abT4ixTLtK7Km1DkE
         cePQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mERFfogVZsspADIywqcGAijvbUdWxMJU6PWjxbgK7JEQe3zbeTqrQrqUdiyTd9hdlko8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQkatoKt+Q/O+5KbMtGZDsqMQbmN1Mt7L1SeHmyrqkmUb2AXg
	mwrZOzRlLiVvSHhdMvunykGr4fU5jaZeWVxq5cCsnK19RPs95B6eZxHU
X-Gm-Gg: Acq92OFic0ntRVKDXzdEwmtVzvJjaBZ1nARYrVG39A9bn9t1zViSTYObbDL/E1HlmxW
	g7WM0diCVhQwUIxsGqVZi0T2bkz3FepXzRjDNHiTnerbzHpzOtEN5qXN1aJRja0jla2zv19B/31
	cpQeq3ZsbLABdCDw0B8fhdH+mYvnMyuA3pRYfX4badXGGmY24j9FGhq7tkbasyiY5Kn6I+7fWun
	7Lz+nkua7/3TADlksPmBFYPkrMj2WGbBa9lMApswfR3+Xh7H4+fUpwGW82PYnZZOWDhyGDC6pGu
	55RJOWA8P1mNrnqCgmM7sHM7+1KUDpANDgiw6UcMH3NQQhj7NKscKZfA3j0C/8Eamyn5wkbsaNw
	AB3evzJYIVJgFcx0xXLzW9Hemj5d/UmWizr15FqweNJlac4ezfrqf0EgQ31zXvqautSnFKOP6kZ
	xo0NvSosbQ8E5LxNQw1/2pygz34hfYsR4zYQ==
X-Received: by 2002:a17:903:4b46:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c1e8979bedmr117765615ad.37.1780819889340;
        Sun, 07 Jun 2026 01:11:29 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa3a5fsm152139445ad.36.2026.06.07.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:11:29 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 5/8] RISC-V: KVM: Handle software-check exits for VCPU
Date: Sun,  7 Jun 2026 16:11:01 +0800
Message-ID: <20260607081105.993908-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607081105.993908-1-inochiama@gmail.com>
References: <20260607081105.993908-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extension Zicfiss/Zicfilp introduces a software-check exception
to the privilege architecture. Delegate this exception to VS mode
when vCPU enable Zicfiss/Zicfilp so the CFI violations in VU/VS could
be reported.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/csr.h | 1 +
 arch/riscv/kvm/vcpu_exit.c   | 4 ++++
 2 files changed, 5 insertions(+)

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
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..12eebeabdf14 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -243,6 +243,10 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		run->exit_reason = KVM_EXIT_DEBUG;
 		ret = 0;
 		break;
+	case EXC_SOFTWARE_CHECK:
+		if (vcpu->arch.cfg.henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
+			ret = vcpu_redirect(vcpu, trap);
+		break;
 	default:
 		break;
 	}
-- 
2.54.0

