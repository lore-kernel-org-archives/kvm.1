Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B837C912
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303963; cv=none; b=hFOLVwOCbZ08QcN6aKFhEUzBpO1jsdtlgpyAO5yfS9NZkg/qGuk0FXcIzx5/17574uicM45Ep33sJEQVAfUv+2x+G8NSrdDJXyWJGTmGKTM7guJPRvQxfxwHHFIINJuHU9ZP1v4d0yG/uOgYbI3SM3L+9gukYxRs/yw0B0ryrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303963; c=relaxed/simple;
	bh=aiDZ+54LfaP8u1o9K4MiqtZMkaRby4kAEKPeVxysb44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8suPknLEtBMUnMu4u/LlOFwfpULMS/S5OpOwq+KthenjjuxncdiZfIuzKYYH9OyxOJhoSykYkevnrVBNAM5rOfEBAX5O0c1obQmZxT7spOnxdvim5yw1oaoBBx7gjzQmWDSZ60tu/KuczUYGy9XUmDVQkl+d1Uh64REVPyxVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qh+favLt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh+favLt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1689271a91.3
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783303958; x=1783908758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SEkM1NCzGGDiH3CjwqUYg+RpOTMUxR/dI++pF9WMd4=;
        b=qh+favLtRTUo7IYtWYQseHHE1ddAFmeDqtJsK2zYmeIdZMi/yup5qStKjGsUuXHePq
         mYAWhXlptO8GBvLiFjSta0NvX8wBETvgWZLYBUfqEXW0Z3CeWk6gqtiRnW1k/BY/WJ76
         yudHVnmbywY9laRzBepTzWZKDBK0caj6F+YgpRpSfzraSdhagcH15dLwFTmfaCXewm/7
         SDpoBXOYKzFk/K2BFLeJr1D50eAQOQ1ZWw2EYvDnA3tipLOB4+d00IfBlOTGv7i8xYLz
         hseoX9Vgbe/jbuKUxGh3+Z085dQ2lRylv3KTmBXg2J0XDMRHkQH1E/VBYRN4kjAl1OLD
         NRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783303958; x=1783908758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SEkM1NCzGGDiH3CjwqUYg+RpOTMUxR/dI++pF9WMd4=;
        b=sL2LlwCjgmfurZrwyFmJyQaaFcq9wHhGGIU5PEh2vr1H8oa2GjF/u2z90wMumZyv2k
         mUhsyIVyVJWUJcLT0vDTOnwUCQvV9teRjLovmuiTMmhWOD03fJH74eGXIELeHh2NKwfr
         w5lxlov9cjMACIoFTADNTA7Yf4jZuEEC/OKJC8nlIXc6xizf65+TyVBx15386JJ2jS+Q
         KCd83HT7HtjT68llAj3Pvb5ySt1gVfUy+SIMH+dtQqlqPNNbHDnBH9aPN9vm//uxXWjP
         29PjIVbqwplKwKh4yH3RH/zomAk5dJV7b8x4iMhWNcc5nPD4X4VfVsU2er9jdMp/siTs
         GHjA==
X-Forwarded-Encrypted: i=1; AHgh+RoeafPVPDsLZTSYenwcNfuxd1v0i96FBnSnJzeJ+64c3dSVUoHgxPjnIu9olWwHUeqS4yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPukdCIiSJXRjSpvD4zauwvLnuLpcr8gT6PfPv0F/PKvrnD1H
	CPoMcgSLpivGYr6naXZUe++s/jtdenhgQVKnX+mdFU/1AuK4RkEM+RqS
X-Gm-Gg: AfdE7cmaKuhBeTvRkj8ntYnJt9ySv659MB0WjQh01nP3Ht/1Bgmq7hJ+5laQcZYrFqO
	VimtcGQPE/zAy1riyE7ijehuP3IOJecJdD45J1tqtKrvuv6gyWMq2ljFfvU9Hh7i28OIiD7+gmj
	6ziM08ENUh3Q4OcwQbDX7lERmRNvbixfJHlEXabXXywrAc5svt+fkbODIsj6xjDefBtVJiXx9u4
	BGPTJodp/VXIudq5+Jj0I1aiwmtzt2e1yd+wWa4WORlzU8ea7NvWhHYeDNDiyfNfnCHhGVS6/iK
	6BVa3uYbUjyJHALED8EIJEtNZA0+6Z1f6Qc1JsbTlrGj34KGzCCP441csFj6aPNuDZbA/uf/Di+
	HqJdCebjgW5rxqf4p14CYkVPVCQhvNAbvYxKm4NLQyqgjNNdpZlrArTtiyoEPSLRO
X-Received: by 2002:a17:90b:4d0f:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38280e98e25mr8543507a91.15.1783303958078;
        Sun, 05 Jul 2026 19:12:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c1c68bsm4006978a91.7.2026.07.05.19.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:12:37 -0700 (PDT)
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
Subject: [PATCH v2 2/3] RISC-V: KVM: Add SBI FWFT validation support
Date: Mon,  6 Jul 2026 10:11:51 +0800
Message-ID: <20260706021154.210289-3-inochiama@gmail.com>
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

Since the KVM SBI has extension parameters validation support,
implement it for the SBI FWFT support.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index bc514ae6521d..0aa1f9a57c90 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -604,6 +604,30 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void kvm_sbi_ext_fwft_validate(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
+	const struct kvm_sbi_fwft_feature *feature;
+	struct kvm_sbi_fwft_config *conf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(features); i++) {
+		feature = &features[i];
+		conf = &fwft->configs[i];
+		if (!conf->supported)
+			continue;
+
+		if (!feature->supported || feature->supported(vcpu))
+			continue;
+
+		conf->enabled = false;
+		conf->flags = 0;
+
+		if (feature->reset)
+			feature->reset(vcpu);
+	}
+}
+
 static unsigned long kvm_sbi_ext_fwft_get_reg_count(struct kvm_vcpu *vcpu)
 {
 	unsigned long max_reg_count = sizeof(struct kvm_riscv_sbi_fwft) / sizeof(unsigned long);
@@ -756,6 +780,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
 	.init = kvm_sbi_ext_fwft_init,
 	.deinit = kvm_sbi_ext_fwft_deinit,
 	.reset = kvm_sbi_ext_fwft_reset,
+	.validate = kvm_sbi_ext_fwft_validate,
 	.state_reg_subtype = KVM_REG_RISCV_SBI_FWFT,
 	.get_state_reg_count = kvm_sbi_ext_fwft_get_reg_count,
 	.get_state_reg_id = kvm_sbi_ext_fwft_get_reg_id,
-- 
2.55.0

