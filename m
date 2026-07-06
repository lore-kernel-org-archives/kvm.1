Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066737CD3D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304506; cv=none; b=JlgpDcV/dK6hamUW3hORh1cJIn5rkgLwj2Ika+UuGRZEucSq91/n1ExQBIdPqPAwq820DwAvaD//l4UoT2Qr69uIhizNcJilBVH1LQJ2rWtc7K9ym4Ky4og4nW6KScI0pExubbFK9TWSqhth3ZJUpsMw8q0ZStXo0ZHWHu9M9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304506; c=relaxed/simple;
	bh=8W95h9pioucOk6mrrNHL0UllepTkkotEJTZXjD/sveQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsEEIciU0XfvVg1yxd1WpzlIalGCzxuWC3+qfXahFr9QBH0IXf06lm7k+p/LEPmirSa38St94MWle5Wv94D7M36ikBkXhrtD2VPAdEjT6AdMXZNEsualcCNWisBmm2WSooHAUwMH2xn9GiA0kDSTAm1inuDOHRCl4ZyWB7ask1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuDXpZIE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuDXpZIE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so24144315ad.2
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304504; x=1783909304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=TuDXpZIE4zi9iKDad2qiVplxc0TlFAS5/7O/x59SDFX9O2yEQijgJNbDv1UfFwewUe
         5/tN+k+c4xP4pvp7xayMdRyqXDXYPwcPHbJg2SPt/WSU4C5qZ21P+dANfPXxeHlUnU+K
         8WkI+XP4l81NB4zjBmzbB92IyZUP4p+vvHUBVMAJqsVvxemOiT4rhsUJY/ex0Bw5LMYM
         1GYhbITnI1hKNtxWglovMdVBQ3FUP3I/ktkREwcv/fifb2piSM3OGoMHl/cAst72t/nS
         OFyogG4tanM/A4wh4f5mt/9AFdKu15e0RydBR8Cr+YwHzhswheZX0ntfOs0uVEhz29qM
         OGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304504; x=1783909304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=ZIZ5FeRYXNKf04QeeJHVX35oGNKOUhq+60DOjObdtvIBFeOPcfKGOjsbtiB/vTSkJy
         5HZEqLSbBhjBUHDEUlR1Z7yERO/Xr7drUGrgkFAoF/BnLqyWiuBEnOHjmFvolLGhEl5y
         I6T7NCxdw1BQI23xWHIVxxtCfbMFbBLDv8ZSDVKQszFQyX5ln5fvUTH5R/YipQUz2tug
         7pAwX1FXTmfTVQqFp+ZpdLJYrD1xzrho1pVN1cQfbqsOhgXMjat2vhJEvre7w1yNnKQl
         JjfcHGBR33k9vW/uvhM/95ww2iobCH3rgUsBCFLvJ8mVSrA2s7De/7IeSgodZIgihzVq
         QGTg==
X-Forwarded-Encrypted: i=1; AHgh+RoDOtWzN1Y4NAq3cHQXxaMjcsV7OktQJuXtHgm8S1b3PBLjoUpMD4G+J3gMmqx77h2f3mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgaxl5mv/yoNwS9Bp/gS0ehKTTlBVXY1Z883S9qnkVEu69oq9
	qvdu9GSWDeZk4W4MN6huo/ajqlR3GW24xv83exAsGxrMz51YvlZESgPw
X-Gm-Gg: AfdE7cnoJ6YiXsbsoS4+EsvgVOuN5X2XuuSNK3/wceT+Jz9VUDTaMnYFYHh+yb/M609
	5cyYIA6greeATWJbg08sNIr+1DqTTemkOjxr4o12oEjRd2J96VbDETbOwZXM+otyUV42lh7Xd/M
	4ExQuAMPSw6tPcSYT4wY9r921p8t2DTevKggYLqMa6lfOd7ZSHNK8VnevwzNHktnGyh6GAXGCRI
	itBHwWTxcZRe3/es8VdImCw8KdMre2dNQ5kN6Ldi7wIOUOzh5j2p/6Yuy+gSiCnON0zjOptwYs+
	fUic9nqjDNPR+Gy6CLOA3NrMQO6w9kHMLQ6n50vSwFyLg2qoye98iJMIeKZdJiegRQAQdjC0LiK
	FUou2uTC55FiB7cxWuqgEUUwzViaXuZrew21cGSS6SjoI4NmwilMEz0wQSxCVFqIA
X-Received: by 2002:a17:903:2341:b0:2cc:864b:539 with SMTP id d9443c01a7336-2cc864b08c2mr41134205ad.6.1783304504462;
        Sun, 05 Jul 2026 19:21:44 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad776516dsm39837995ad.52.2026.07.05.19.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:44 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v5 5/8] RISC-V: KVM: Handle software-check exits for VCPU
Date: Mon,  6 Jul 2026 10:20:41 +0800
Message-ID: <20260706022046.214956-6-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706022046.214956-1-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
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

