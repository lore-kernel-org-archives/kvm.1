Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD885389118
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303246; cv=none; b=oPtR4RDaFbrMvtRPCCPj65bQsThmybKdF2iuMm/1BxV1UzGOpbbMdLbymDBczuRvBha6v4Cl4DgTt0XwCdDOIKJcK6W0QO9S69Q8gj0gSAMnapFzqW9Z72tmIb60/GH1WyhG45nFQVOp9VyyP126AwayS9dk62s/d/KuON0y/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303246; c=relaxed/simple;
	bh=v8xk3QHpXNBkj9I0DJjJ1PRYb/tbiijkclCWUxXXvfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XryL8xOGUs30nHVAmE9aIYI+gRtERXpvkJ2r3FlzGwbVR8HlAUYNtUkSmxenXsUMGOuJbs8CWoMh3Nis2Xmu3xYWCXrnbaCu0GwNCL26wrgRmPUXmHcOQjY91t24zjeALxGvvNRGeX0ZfKfPmxugQ7e2ZUL8t8KiO2XNcx5o5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CsL04mIi; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CsL04mIi"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304ec41197bso2558807eec.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780303240; x=1780908040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lscgRQDRbt2yakLS5hYeNYWDRzaYuJMCuwhj5mWoTY=;
        b=CsL04mIiRsNFODoRq6lPI1ws32U4pPaoNG7vSyPyzQ6vb9UvobY4mKqugnMOiQIzRs
         qInV2gj7SJM1mgxfhyKLAycF8gg5AXJF2WtgiH9RFtikZlLefAlpyHCn2gIkLGmpeQhe
         /ZMfXSDY+PkRBdvYi7gtSEw9r0Q41tAgzdsv8GF35dbM3e085daQFagMvhXAzpzwh0wG
         gtobyLK07cfJ9O4KjQSyybNYQzNUtApqJ27ymSPxLlkEoiRdzO4Q7DeLBW7Uks6ee8F/
         /kecw1T8HdXa4HUYonPEsODEz5/mCMEs7KB3esIhbLMx2UaVcRd4x6vfMPROYi4w1LuQ
         95yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303240; x=1780908040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lscgRQDRbt2yakLS5hYeNYWDRzaYuJMCuwhj5mWoTY=;
        b=ndwQqYfCltLoGwm3DAKXlhrBl5j/sNPKVdllkFLDOXIl0qzpdZ1e71GwYYzV31rUfo
         /FK2I2alWWurartiG/I36bmk7vpHW5YojUXGSJ2LrZxD8TG/uX3c8QGJ1C7B+NxA5RGb
         J5opExIGeWXXBQ0gvKJTW3Cn4X11/VR+Phh0VK+2C6Kg4b0nOgE7zNpOSt5oHASk9PhY
         ZykbvvW+0TZfler49VoBaFJKaf1u9bfOrgsO2iCpzQfiwzRj7JAXyzBp9TpTTQJY5dyV
         JJKvH+UEVC0VI01+e1pQXQ8MnJEd9jrDpRFSo3daXz22JS8PKr7An/1kxt1NXzZcCREx
         WjYg==
X-Forwarded-Encrypted: i=1; AFNElJ++nwiYOcwniXrMS5HnJ1IYNVx6fpPiWwG7LVm5OLZ6zLIfFOSP05OuDU+mFCKIib+pt5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ7tg+pLR8qjyiYtImLZ1CPyN4LXUfJKHncDM6l7EiyUbdDo9
	lX4CYXyY5BCO4hTJpSkDjcM+X7mq0V5OjH4jE48rh0tB+faxZAI21V7A3PB0qMw/s6sxXX3+5h0
	PzGmQKsGYZu75z6fMQA0gIdlsXnIRM5yETHsatDW3gmrzryEdcTIm2dVQg+gGuX4lo+LwuDoQgs
	fxg7jnfRX5AOTl22tHBNLb2TVhjr9DoxUk0P+x54RtCLJsFg==
X-Gm-Gg: Acq92OEo7/NDtqhOoOQSdSNga356ImXqFpF/eTZ51aDuCtphv1jQvMHNn+49Tdr4e2E
	VDNUwtpwjpJXWZd22S2WjHBzbIz/s6MDTDRDvbMn7Yoe1p29b83jdN8fylSXNN6eZzDE4jexVPh
	XdWTbvPPAqIXkLCNeyJel6Z+Yw0zEsMwUbN5uADjnu7jMJ0KkfCm0qo7jBGJM52CHTzBYN2ChK9
	+epzYP6H0qcKxPbR49tCdgFHKEwFbcvHDMiTuWGZNE41QPkWX8huEseX+u9te0vHb2+7b6COOMT
	z6nQwe4g3IHmOxZuigAqh0zkqXwE+1UoWAmajuhINXp4NixkfAIhmf+mrqQz/bg1THpCP62zXyu
	uWuo9XIwr2HAqMUrixBVm9BIxqjjXTC5pxwGs5qZ+LSB2uwoMbSMNq/Ttbnya0IbZGikZ7k1iAD
	7EtjqTlL4/h/FebvvrFoF9c0X0hx5Tkgjpq2ITJTkhD6xSsY+/v2AlKA==
X-Received: by 2002:a05:7300:6c84:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-304fa67bcafmr4151923eec.26.1780303239441;
        Mon, 01 Jun 2026 01:40:39 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8011818eec.27.2026.06.01.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:40:38 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 01:40:34 -0700
Subject: [PATCH v4 1/3] KVM: RISC-V: SBI FWFT: Fix stale feature exposure
 after runtime extension changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v4-1-c88abc81ebda@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780303237; l=5776;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=v8xk3QHpXNBkj9I0DJjJ1PRYb/tbiijkclCWUxXXvfY=;
 b=1EORkE6aAPHvwki+++Fi5anJeWWxlG6JgO9U5hx75Vmk/RBJMBCu3oiM1KmnU2PCa3r+OevoK
 x5Y9n8XWskBCXYDCfn/p/NOQSYH6gvcbzqdVTD59VfTevV2mR0+gJAZ
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Fix a bug where FWFT features could be incorrectly exposed to guests
after userspace disables their dependent ISA extensions at runtime.

The 'supported' field in kvm_sbi_fwft_config was set once during vCPU
initialization based on the initial hardware/extension availability.
However, when userspace subsequently disables ISA extensions via the KVM
ONE_REG interface, the 'supported' field was not updated. This caused
the following issues:
1. FWFT features would remain visible and accessible to guests even
   after their prerequisite ISA extensions were disabled
2. Guests could configure FWFT features that depend on disabled
   extensions, leading to undefined behavior
3. The static 'supported' flag and the dynamic supported() callback
   could disagree about feature availability

The fix introduces a two-layer checking mechanism:
1. Add an optional init() callback to the kvm_sbi_fwft_feature structure
   for features that require hardware probing during initialization. This
   separates the one-time hardware detection logic from the runtime
   availability check.
2. Add runtime checks in all FWFT-related functions that call
   feature->supported(vcpu) if the callback exists. This ensures feature
   availability is re-evaluated based on the current ISA extension state.

This approach maintains the cached 'supported' field for initialization-
time decisions while ensuring runtime availability is always determined
by the current vCPU configuration, not initialization-time snapshots.

Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 2eab15339694..2ad269a21021 100644
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
@@ -137,13 +147,17 @@ static bool try_to_set_pmm(unsigned long value)
 
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
@@ -231,6 +245,7 @@ static const struct kvm_sbi_fwft_feature features[] = {
 		.first_reg_num = offsetof(struct kvm_riscv_sbi_fwft, pointer_masking.enable) /
 				 sizeof(unsigned long),
 		.supported = kvm_sbi_fwft_pointer_masking_pmlen_supported,
+		.init = kvm_sbi_fwft_pointer_masking_pmlen_init,
 		.reset = kvm_sbi_fwft_reset_pointer_masking_pmlen,
 		.set = kvm_sbi_fwft_set_pointer_masking_pmlen,
 		.get = kvm_sbi_fwft_get_pointer_masking_pmlen,
@@ -281,6 +296,8 @@ static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, u32 feature,
 
 	if (!tconf->supported || !tconf->enabled)
 		return SBI_ERR_NOT_SUPPORTED;
+	else if (tconf->feature->supported && !tconf->feature->supported(vcpu))
+		return SBI_ERR_NOT_SUPPORTED;
 
 	*conf = tconf;
 
@@ -365,6 +382,9 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
 		else
 			conf->supported = true;
 
+		if (conf->supported && feature->init)
+			conf->supported = feature->init(vcpu);
+
 		conf->enabled = conf->supported;
 		conf->feature = feature;
 	}
@@ -408,6 +428,8 @@ static unsigned long kvm_sbi_ext_fwft_get_reg_count(struct kvm_vcpu *vcpu)
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 		if (!conf || !conf->supported)
 			continue;
+		else if (conf->feature->supported && !conf->feature->supported(vcpu))
+			continue;
 
 		ret++;
 	}
@@ -430,6 +452,8 @@ static int kvm_sbi_ext_fwft_get_reg_id(struct kvm_vcpu *vcpu, int index, u64 *re
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 		if (!conf || !conf->supported)
 			continue;
+		else if (conf->feature->supported && !conf->feature->supported(vcpu))
+			continue;
 
 		if (index == idx) {
 			*reg_id = KVM_REG_RISCV |
@@ -465,6 +489,8 @@ static int kvm_sbi_ext_fwft_get_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 	if (!conf || !conf->supported)
 		return -ENOENT;
+	else if (conf->feature->supported && !conf->feature->supported(vcpu))
+		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {
 	case 0:
@@ -502,6 +528,8 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
 	if (!conf || !conf->supported)
 		return -ENOENT;
+	else if (conf->feature->supported && !conf->feature->supported(vcpu))
+		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {
 	case 0:

-- 
2.43.7

