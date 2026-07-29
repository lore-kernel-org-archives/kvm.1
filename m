Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288A3FBEC1
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367546; cv=none; b=RQBJYgMbRpFCoApl7qQFk9xIhLL9W4E6QjOA5Hb3WNQ/Of6r2U8zAfC0A/WR7N1u1vD4rZgH2L6wSzEOHIZB2foBYvgokrtZ3EitS4n+EU+T1oLq8tZi3S+w/NXCMV6MxEveNV3gi88E0U4ch0dFX/QsiNpPD8p0rP03EhkkcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367546; c=relaxed/simple;
	bh=VRKBcrvkkTj50ug1nsBr/nbS1UFJ1XmMlvIvUd69GHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5XIeEfAVJKobjWqB/CWSbUP2n2I6uyp5dtghfJf2DAeM+LirxpeB/+oiLW4JeHXEXOJ5z7yMEbyD2Bpi/37zU08UwVZaN5A8H6oLji+mIJVjL7GB87VhqrELg2KyitehrLQgNIMyMG9E3ulRXRzV//QnULMd+7CcOArYX+R56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ71dAbb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ71dAbb"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso891817a12.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367542; x=1785972342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5uwqzdU+bRfmUzUhku7H1r8OyjJF5nGSMJqcdrWCrY=;
        b=dJ71dAbb2vXWkRrMdWy5XmYnKnDFuMkB+0aYfs6tNbd1ZoptYNLFGotGRl8OiFUy4u
         Mjw9PTRj0ghZAPwvs8cPDJLUb67a79X+um1VuXUsdco3WnkL2DhjaR/Ugv/XVQ7KEtk7
         dhn/XLsWCM2X3bgSwijT91glAqjyKO1wYQCOsKBbwbrRlky/llT1mwPJhWNoRYFSNBnR
         ITQ+gQJ45V/TlzQCr7qvFFiPjBrxLeOsXJkfpzo9fin9xKjrJriSkLPaxmEINDP0d/ZP
         O+PesOjJxkHe2t0KS+epHIJFLLd8Uk3LfvPWQWxZmdqTuyIX3wziOZnXk33KNf4Wh3Km
         lAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367542; x=1785972342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5uwqzdU+bRfmUzUhku7H1r8OyjJF5nGSMJqcdrWCrY=;
        b=WnoM7XMThLO4hNgAUIl9Oagm9/tu/fCe2FoAeXBdknTty8L6T2T/PSX34Eb0ONOZv1
         qI3WAc1C0wccyovGZZkDs2pKs7upSD6fJctkTDxuGoFkCfm2FS3VensXPHG9fXVSv3b4
         pAxc7GN3O6t8YZQfIp1ScbLf1dwVaCKZTLHG4tA9rA095V0JaGbIHcdTwwcIUkPa4pjL
         quttFmCgV1A33RlfjvLQo73zORvsmsy6wpy6kn+RbD5WYeXWxHe9pfk8WEAPbp1j+tdW
         mGGcgYEZngMw4pmeMDeSUct5BNEeIij5Qbbf2Ghme5WgqAwFuMmkFUeru2En4l1Gx7xs
         jJfA==
X-Forwarded-Encrypted: i=1; AHgh+Roqk8dwOHeW9+3goXeG/xMy/MC7AI33dCN6x5R4dogwHWB1ti0KCegXK5dFOPZy4CQoeZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0jKe0tjzeaYO9bFs/XFWihqdQjoCQmaoHGpTBYPPTClUuRw2
	SX+AZxmLDf4d3QZotjCO4vQJ6Ldztq/gxFdnDJzw2RGAshjEjZo4VXQUmWa0NH8p
X-Gm-Gg: AR+sD11DVKCp29h/HJz3ulzXv5ilKo38e3HaYu4EbICyA+XZUK5+OanC5EfWppAzlMI
	WLo23nKQSgglUutdHTYqYP98OPFg29dSVTYwS2MYiFihwCmyHOif78yUGkwTW9e4AjQIC+TaiUr
	YtnXhbyGIqtOD2VijSyPGJSu9BGC3blipcutPr3IrJhC7tAar+yn4glvccqF/Fve8iU42+MfuaQ
	+371GVcokV7hoTREV+67eK+PrdvBFtvEEyiqgXmSvNTJBSmhZydtlF8EGhVAyMBCzwIUbtgFGMq
	LG8QtYG5SlE5PLWbHuE9J5ymoh3uTUB/5sPhddiLjYT2ISER5QNcVDXD4R+1zg1Xs/vSeIUyQEr
	PsdpbmeooKWi4O63Kmu6yCWkbi2A4MqGGfizI0h5pxHZCu0DCMfZT08EB4YbJXXikcWwauzXaI8
	fp5MyfRuhEfT8PGg/ZfNZNDjABAHIBERSgG9Z9olY72JNXnXwIYTfT9R0nAsU=
X-Received: by 2002:a05:6a00:330e:b0:82f:38df:681c with SMTP id d2e1a72fcca58-84ebc1eb51amr328381b3a.6.1785367542040;
        Wed, 29 Jul 2026 16:25:42 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm1992558b3a.30.2026.07.29.16.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:25:41 -0700 (PDT)
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
Subject: [PATCH v3 1/4] RISC-V: KVM: Add SBI extension validate callback
Date: Thu, 30 Jul 2026 07:25:22 +0800
Message-ID: <20260729232527.139183-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729232527.139183-1-inochiama@gmail.com>
References: <20260729232527.139183-1-inochiama@gmail.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
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

