Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E473F86F7
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899288; cv=none; b=DvleMhYayl9eVR+FpIZF+2K3iCe2lilRPlgPZHLdQ2wjPqhkmyX2FbMdNr1YYsAuDHuN7Ub3Ips57bxgd1vdmT3YRb7u0O/boMxvD+zeMcyLWnI84Q0Xw4XVvVkDFpoOEAcF3pzIDnfDJh3c538EYyLUCJFAHabCm3t+o1L6ZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899288; c=relaxed/simple;
	bh=AeBkWpFCnK9T1geyRgRMBAbJluf2M7xepu7o0m11hVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD8IPfwZN5teptOVBr3t6hAFY2ca+8t8HVygKy45W3/nM1KuS/h1mYiWdOLAUR3y59JXxj4o18O12C98XCzD4ZksIB+ZRW91OGeQn/ddU48cz9hN82ukbD8eAyR985R9vrJ+VTQMm7GFEvXOsTR/AifDhxUuwhZE0x9PcHva5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFdPTTeh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFdPTTeh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37fcae0ecb3so214147a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899285; x=1783504085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrr5FtvU4l5TINA7e2cy7RSaKqJTIqgiZF3cWni4toU=;
        b=qFdPTTehvVw1OoA+ikmXlkuiYl/IO4nxlO7n5Z1mJTXrhYOxHBElRueOA9OQJ20ScV
         kNMQZvTXIpkmGFVWFsjv5IttuY1F0G0vaWT/T6abgiwBnZVfLjCnKUI/iYZWZjtwTzh+
         dTeaIK7RQYz78V1WefNRlpPAUw3cQERX8jy6U0egXi5AjDCpVcA5/0Wn0qljo648t7OI
         mtPRoVqDHZwH0WmJSLngN+5zSbsLOK52QfYNyS+j5V/n+s3Zlffm2pyr/sdK0keY1mW2
         0BWyE7KGfh8yYvVk7auq001WI18PJTOmtJsDX2Yp8t/ZM/xiwg8VW7l37qayJTXnW7Qp
         H3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899285; x=1783504085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yrr5FtvU4l5TINA7e2cy7RSaKqJTIqgiZF3cWni4toU=;
        b=e9IW+un0DOCcpH9ayOwJh3c8aTWW3lf6Vbd6et4JEQw5yk6Omy5TdaKXsKv0G6Ozi1
         8qX8uPCIThi9mjwpVIZRo6lTEzPI6MSD2cVCX4g7INoop6wcG0xYl5dUjv1vREW4zqyy
         BisjZVqW408TqnJHTLRylZiCG8wGVzJPaV8BCeaB+Vo+1S9N3aikmPr1/cCjm1hQJvYh
         URq7BzRI9etbPSLGkDZc3hVTCNuFYnOS5XPRcVnSARMnKIxrHsD9WyaPL6LMlkgkhy0Y
         AVOgE3DSBpnJGpcyFwZ5jIVrdTowzBJYNV9e+QLxhiXtvTLECOyPcPmjBkdedRpT62Re
         w/NA==
X-Forwarded-Encrypted: i=1; AHgh+RoGHc9B10WfugcGSbJch1Z10N09p6U/zqScmxoMfwBNgcSMLH4OuVGbIVqhgtJSqmdCnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/G0FpvNByEpA/UeF2oKxdaj4yPPDwZSWctQFN7hoW5uRU4au
	uCjUyohHJBWzVXk5f8dORpvbQ9bKxFcJTQk7Kb+zsFWu02IVQOToI/H8
X-Gm-Gg: AfdE7cmwjE3/ODOALT8Qfe8OKd00kDpgFBpLa9X+C+LCBfrHrAdFyOvglm9oJ/TvYfn
	2smyqGKOO/g7LLYDILK1OQSRvOd88v6aSopQWAKSdo7J03KONzTf07B60DqrAmtzFdr+VmI1Q/c
	C7tmi5RwYXe8xnDY2tEuCP6vqooTC+GMMd06TIr155aLLsM8bHC71n4JTYbR6Q2Ht8IWJEH0JyT
	UAB8LJHBrWoXI6GfHayYhbGWv7nNXXrVvUmAhtnmOyXgvC4nldDVgfC8fbRe1XaOyd7y8CVL8WE
	bt05V6v0BnEDakGd4mgNibtzZx4MV7Wx0HS/mL9CVt2cBwWrurmBDpu9AjZA1Hnqje+JWdJQp2w
	7tLBOmnrhNbrh+XIuf3mJ1VfujIVYHLKhSLmUV4WqfpE+SlqRxEQgQDARdQ1iOtpAQtSzTWFsad
	G8gCoAQZzasc0=
X-Received: by 2002:a17:90b:3b4f:b0:37f:9ce1:736a with SMTP id 98e67ed59e1d1-380aa21ecd0mr967241a91.32.1782899285410;
        Wed, 01 Jul 2026 02:48:05 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095ea9ef3sm1590317a91.17.2026.07.01.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:48:05 -0700 (PDT)
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
Subject: [PATCH 2/3] RISC-V: KVM: Add SBI FWFT validation support
Date: Wed,  1 Jul 2026 17:47:29 +0800
Message-ID: <20260701094731.1022163-3-inochiama@gmail.com>
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

Since the KVM SBI has extension parameters validation support,
implement it for the SBI FWFT support.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index bc514ae6521d..74eab72b2dd9 100644
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
+		if (feature->supported(vcpu))
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

