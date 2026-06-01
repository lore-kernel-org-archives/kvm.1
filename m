Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019239B486
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309599; cv=none; b=YRM5rVxONCM1PB+OLfe454XNRSlMnFho2Cwz0Lx+thb1ObyCa6CJ+BHQcKFOVKuBbuu7loNV+23snheLdWcen378zZGRWDF/MyQmxHSlDz2DSRXLMDfdI49BlyPUrEO52IP7UxzxK78QLyFm5ilGMYm7efyGXF+YiiYuJmXS0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309599; c=relaxed/simple;
	bh=TXFt0DFSQdnCviWDHonLXEXWuSs4TELoJXTKnRITfIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjMsQQzAjiiXKMucaI8OZXKnp0nNqqE/lLAjpw//XQG/dOPH2iIRmDwVJypEsrPgiUiDMrJf3bv2k4Nj29guu75wPsosKTD7RrNrrv+ci1VYnpHbkXee3AHGK4Ag1Vkl3DIG49q1h0bWHgfOBfxVg6Bn5hMhBJnMq4AE4Z3+8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OxAj5xi/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OxAj5xi/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304e58292d3so6285232eec.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780309597; x=1780914397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mc0yN1x4RucIm/MT/35mEk+RzjvwKXgES6zMS7u1Uaw=;
        b=OxAj5xi/y5pHO4HM8cvnZAsnW53iHcp34WC3Lcfmtxwt51lwpRlTym6XY/2NMd0rlX
         2HQiEyNbB6C78xziLUy0tXJwWN/gqGPjzzXCirRHJLUXb2VT/iK46WDvAdZrlx+zBXQ1
         so8RYveBWFpCm0MfY+J8EwGkS3wyMU+iHJTWZ2JAjfrlAlf8e/mHGnlRSJEIZmDmLox8
         Qr8Z071IBK+Rr9WM/v4L+yMWBk0EvJoZGTcOf9sj9MnLvKl/QiDZCH9QEL3QPdo7kbWP
         Xp9XSiWiKVJjhU4PQTJFCeCI7C4K+bwuNUu7S45LOfO8WbPujRJis3r6eLSzDy/VyBaF
         37ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309597; x=1780914397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mc0yN1x4RucIm/MT/35mEk+RzjvwKXgES6zMS7u1Uaw=;
        b=JymV5a/UX1WkyfK4tX3qwiztOV4IZIPBMLKYG/XCBVtKygI7JP+d1FzJWwOt4dy0Pi
         yC/1zOBslfYAffGPVhAeqTnaiH+8SDtXGHd8DIYtXDujdy/83SdGTkZdDYe6O/QSSq3w
         yjMZhsgFsjGzgU7mCBZwSBfEDRtlPgZCzESg/R34VB76K7gi+cKUHNq3hOT/T0Baur06
         cLVTCpKAbJBrzxEho8opfMYggvs8SOiKmQR9ai+FJdoaQa/edMoa9FT2h7xPLS1//5f7
         7PAy2lDSHrESZD95Ze8EFWXUWwskIs/bXhpbhWvH6ZhgQYxo5LYaODpietSw5p7Gd4WS
         MtRw==
X-Forwarded-Encrypted: i=1; AFNElJ/eTfQuB2jHZWCZq7+Of2hRJ4S5NbUVnPtMUMyt2h02I0tmD9xon5xoyDJxhpdAKa7RMcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67JpW45+O9/YJXqVWu/5uPoH/1MITbEXlDSwHFmVpcHwdH/13
	66GvXAAkO4Q7TgfxrvhZ19QJmrYlGrU0cAxpb79w90+OCjH8alx8E8gLnNejsnuABwU=
X-Gm-Gg: Acq92OEUQl2x97rCjFCkViQMJweeDKRU1p/g1t/QvZrg5Y8B2Fw98VaJ08GELOXlNMk
	dQIfRskJJ07uiFqur+BQJrFyodRkTlhQymdS4/4fvY68IIgFXT1zNthNokL48zUlt5ac8uR1XKE
	oj8AaRnacoyRe1NDiYYdnTOLMXSxDpC084CUmQxr3FOLPr0mljgU0ZuxP7sUmfOyZGXLs2jEYPE
	JDtRhU94XC7yjneBgN0izPDMD1m4owhjE/cK/hTgLz0gjS7sznfMIlINj/LIT5kbV6yJ2qVA5PG
	/Z38exW2kgg5ci+dTy16oGlZ9Dy1Snl1msoevLK4+nFcmhDNR1d6YK+D95SfSkRXTzos2wdVwo0
	7N4geYR0J1U6HfS2kVn4Hvl6wyUaIc5iVbh8oFh8aI5AtV6971FPumbf3KAUfNA26bTIiRtObRt
	A6x6FUbtamI8eIAMtNTN798GEKwkVCe+k+dGwuZkRgLMk8kXFZbRrOyQ==
X-Received: by 2002:a05:7301:2926:b0:304:d82f:be10 with SMTP id 5a478bee46e88-304fa57301bmr4727218eec.11.1780309596786;
        Mon, 01 Jun 2026 03:26:36 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8176001eec.27.2026.06.01.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:26:35 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 03:26:23 -0700
Subject: [PATCH v5 2/5] KVM: RISC-V: SBI FWFT: Add optional init() callback
 for hardware probing
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v5-2-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, inochiama@gmail.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309592; l=3443;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=TXFt0DFSQdnCviWDHonLXEXWuSs4TELoJXTKnRITfIM=;
 b=qcEndV2CiUSg4lgHuYRsd5aA3etrfjNCxq7IkheXcAXYBJk1dZaQuK988NbgWu4xRLQDpVAvG
 BP0vZ9jMc8fAsWp8ehTJPS9CV54ctGBCq+yHf0goiUICI38bbjxLzLD
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Add an optional init() callback to separate one-time hardware probing
from runtime availability checks. For pointer masking, this allows
probing supported PMM lengths during initialization while checking ISA
extension availability at runtime.

Fix try_to_set_pmm() to restore the previous HENVCFG.PMM value after
probing, preventing side effects from hardware detection. Add preemption
protection to ensure CSR probe sequences complete atomically on the same
CPU.

Fixes: 6f576fc0aeb9 ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 5e4aafb0cbf1..aee951f2b8e6 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -35,6 +35,16 @@ struct kvm_sbi_fwft_feature {
 	 */
 	bool (*supported)(struct kvm_vcpu *vcpu);
 
+	/**
+	 * @init: Probe and initialize the feature on the vcpu
+	 *
+	 * This callback is optional. If provided, it will be called during
+	 * vcpu initialization to probe the feature availability and perform
+	 * any necessary initialization. Returns true if the feature is supported
+	 * and initialized successfully, false otherwise.
+	 */
+	bool (*init)(struct kvm_vcpu *vcpu);
+
 	/**
 	 * @reset: Reset the feature value irrespective whether feature is supported or not
 	 *
@@ -131,19 +141,30 @@ static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
 
 static bool try_to_set_pmm(unsigned long value)
 {
+	unsigned long prev;
+	bool ret;
+
+	prev = csr_read_clear(CSR_HENVCFG, ENVCFG_PMM);
 	csr_set(CSR_HENVCFG, value);
-	return (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
+	ret = (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
+	csr_write(CSR_HENVCFG, prev);
+
+	return ret;
 }
 
 static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu *vcpu)
 {
-	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
+	return riscv_isa_extension_available(vcpu->arch.isa, SMNPM);
+}
 
-	if (!riscv_isa_extension_available(vcpu->arch.isa, SMNPM))
-		return false;
+static bool kvm_sbi_fwft_pointer_masking_pmlen_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
 
+	preempt_disable();
 	fwft->have_vs_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
 	fwft->have_vs_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
+	preempt_enable();
 
 	return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
 }
@@ -231,6 +252,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pointer_masking.enable) /
 				 sizeof(unsigned long),
 		.supported = kvm_sbi_fwft_pointer_masking_pmlen_supported,
+		.init = kvm_sbi_fwft_pointer_masking_pmlen_init,
 		.reset = kvm_sbi_fwft_reset_pointer_masking_pmlen,
 		.set = kvm_sbi_fwft_set_pointer_masking_pmlen,
 		.get = kvm_sbi_fwft_get_pointer_masking_pmlen,
@@ -365,6 +387,9 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
 		else
 			conf->supported = true;
 
+		if (conf->supported && feature->init)
+			conf->supported = feature->init(vcpu);
+
 		conf->enabled = conf->supported;
 		conf->feature = feature;
 	}

-- 
2.43.7

