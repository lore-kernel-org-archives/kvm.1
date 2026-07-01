Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4671367F3C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871710; cv=none; b=Rl/zBktGi1X+8ybwENd5IETmfl1pq3NNhOmOu9dVhe+1cDoP0U5yMonQgXuWdY7vlu7aB7M5YQqxgOb8X2mrspezb07mSiEZ6TGFlzxGaWQhT5Ibi+oUW/AKq03tMcQQgUanW3L6mq14pDptB0Ayshj3M1zrEARdia8pvnJL1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871710; c=relaxed/simple;
	bh=8W95h9pioucOk6mrrNHL0UllepTkkotEJTZXjD/sveQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4ZMa/Bm8CXT3MicHH6UAkkk8+1rdWS6sVhD9t2EX4vxw8NIkwCBEephCrUvViUtkfH2By9bYUiOdrGQg7w7D/UUbpzDuUWMhPHNpIjOQ9bmouFuZcX2Y00VESP8XNMXZjAFzN/54epx4vrSPSfhlcg++fpbc+XQDfAH7oRVFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czgex0fM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czgex0fM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842338c18e0so102644b3a.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871708; x=1783476508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=Czgex0fMMDOEe63je5QsPqiTlirekc244s5o1A7kCN5kdpMKziA1qS2KNdUAjMKpkJ
         2ZXhR1BMLcC/GBn2Ci7J56xPADKnvw1a41vrlyW95zg9QZQUzEUA7+VW0huPZjYeCh8M
         Zbc5x0Ui3iiR9dzVZ/sTlaX/w3JYspse90ZWxLHDAgmKFSW8RmP/yDhC8s7vtaE2/kOJ
         P64x8ZsOXZWIWVLplNtkwtI+UNL2sAB/v7tT8TZferM0Ysxo7hMOeyEw2dBqcRRa29eS
         rNaQcvHfuH3yHswvJyXic7YdFs12apG2RjpJvvYUvMq6UMvtg4fd87y3TkIc/MVvtb/T
         RfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871708; x=1783476508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=VevHNO7RcY/Jy1EWS/WDF0iCYGCWZrHQg8kgq8fd7lyqPyV8X8jbwwC978qGugCbag
         lrGWv7aXLQPDLJo7u7xljQpy2rEa5E8ROMmb7At1XELkre67ojlFsIsodwjNJ2w1ebsi
         m40nulJYdJMqcRUU48DE77W9ohdPMVqYIoFVSG/Ya/FA+CWCwtYoEkMAEykQeGsJcjWw
         2eTSkKrhlpwnAb6HVLfk+xgqwCbmy5yu0MaI6NkAa9Vdg4gp13t0c0A115r72oIGI5Fi
         3nAts4DyKv7wNabBP369wwp+03dT4dmxQgi6lm8AvSzklikoYsCgYxTAJthSlnHHrnpM
         4exw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9WuGjDaPoZ1fVWwz6JlJaeN7MDGwVPhbLJEgSBe9Ez+rFG89Wnzg2hylHfsqxMhpuF5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4VN8r+YDRDF/6mL5DOmzxUb2WpvbRZgqu6e+Ifq1FNss/N8Y
	XjBw4gxrdGnhICnIQ7+wLBEY5eB6/btsDPJhf0UFW+cbCMtIgDkkL2ut
X-Gm-Gg: AfdE7clTnBIdRBXkIWyOXVVz+hL35gLj8zvDFd9PPglrB6U84JP9yDfLLzuphKUvW0P
	QmdCM3jz1MsqFaeXQP6wKNuzK2PFf5iGRvi5MquDwmoQ98YyA6EFjXQ028OQwZ+BHynMh0khuEP
	SJaHueIgxr8eaWkzug2ae8plJ8jf2X4tPEvsK1cBGIrDJIs+a4RMpie+pRcaV9hW1+qOtuSTv+l
	EiviednIZa3blPbuMPgEbnoQmshXqIwXgVVmwD/mxchBdvKfvbnvBnc9s7B4ybu4Z3PVuMTf97Z
	Xz5u1EZfkNv/Z0yjnvvnTrvZDxLg1EpkCCnNCu8dvqVRrQvnkodkH2BGty1XPLwdUhoKhxHFor5
	4wFyea4d+0z62cIEO2TT7ML5TQJz8jHoCdVTF2M3xI+Wls8QwFvsu1iN/GQwWqX2YmF2MiZWNIH
	4Kl0Ut8nallRE=
X-Received: by 2002:a05:6a00:988:b0:845:e44c:2e5 with SMTP id d2e1a72fcca58-847addb218amr2835089b3a.22.1782871708161;
        Tue, 30 Jun 2026 19:08:28 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d41c0sm2957918b3a.33.2026.06.30.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:27 -0700 (PDT)
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
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v4 5/8] RISC-V: KVM: Handle software-check exits for VCPU
Date: Wed,  1 Jul 2026 10:07:42 +0800
Message-ID: <20260701020746.170157-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701020746.170157-1-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
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
2.55.0

