Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4D279903
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861184; cv=none; b=XnViTmr8tWEA8+fVZA0L0HXdwuegqqVfvBODdsXX5N70meLHeG3hxCVSuzgDUpeUSiIrmlfPBYTl2knntG7IrPDPNBA7iaRfUfCovdWWoWKyJOh3lsH2IKCi41+EiiEk+IcRd0Gr5DwMu7GSYLkh9dVJjHwq2YrfLVXZ98pXtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861184; c=relaxed/simple;
	bh=8rCDNvc2TJDmq0o9jKD+SWttG8Vm4gJbAUgSdeBhahw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOdMGaIpcNtIVjg6mIb4wb17sKMmhSiGUQcdb57zyE11LyzX+Vi42bg2tlRmOriP4alRkDR6+pdRhBmBmpom10bWivNkcrsAM5nFrLlXEcKOFnltKHpZfIpg3o9M56NrwQ8J8LGtVt2TTrqBDnpTQzR1V0YDYn9pSWsiV0m6EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Z1MFMamI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z1MFMamI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3045c195251so4690189eec.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 22:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1779861182; x=1780465982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUn9PyzRfhMmuzwTZR0m7Cfkjy913gm4r/60L8bBEqo=;
        b=Z1MFMamIeVX52SpL2FPOA8sZpQHEH6gH2IOCb8IjsJvxwl+hIm1I6XTTSjtgMlVvgj
         qivQr+KcgwvmzXXpgXdS8J94Trk/mZ3LLZLw0omPzj/vrQvt1QGf+Kq5BrAoE9cka8gO
         QQ4XnYVjYWsERFJtK62MGM6l8Ur8if51GFlL3x3TWhdPEZnAvHWxjnTEaFSrMhuDL/5w
         nFW7oC2mgE+YTtamdLAIUGWvKf9GUGydkCjw/HVcoLXTdCs5rNoinBemOHummx2vtNhs
         lQJqmDxfEEqkPdeqi57TUkszIfH/IuaeS0N1uN8MqWF+1K8M/WErXiUNfKNhNAQ+vJfK
         2K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861182; x=1780465982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUn9PyzRfhMmuzwTZR0m7Cfkjy913gm4r/60L8bBEqo=;
        b=jteC7fxgKfMHzFxINJmRB2vKRnReEeUrHoR5ytS5S2D7i++fS8RQSEZa7mGIvwERs3
         z1CdhAB33OSC9WsuPKPMnEghhsrpK5MgKFNx7/g4yrtNaOiWaDwkCyvbvdLkw5latXCH
         pxf3RiFLWN1x1pKCOA7tIKy06EyUMPOyZFfk95w0yMEajY7ie9XDYQaqs/9J/Y7rV/Eg
         qmihOCwNM0FnL3xVVbEh4ces8xbuPT1ez6WEvuilztyn+xt1kYRqzx0pvaBsELg+Wbwm
         ++dZY4KnbemyhoaRaUdW6bznkusZxgoF0GuBrvbU9rUNvW8qcms3LJ99TJBb2bc5jmk9
         Zf6w==
X-Forwarded-Encrypted: i=1; AFNElJ8+sJ2XhwOHNKWiLd2BaXZg0w6xPgmMf+oA6x+pO3CkT1qu4gBLYGUeQdwF+MywKcLQprI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fc8PQo0BoKm/AzlJz2PG98wnbKLk/3COUQ4UDH72Z0vqK4g+
	xgiXL4ZT4W3aUCXHIiU4Q+IuHT2wLvbRZzVglzRxiMlv7pcx9eQRxyoVoN761bLS3DA=
X-Gm-Gg: Acq92OFsIiO5xZBhPZ6fEP0qSqdeRexomYmEcsS8ZR1Xy01XKGTc6ze9bVBLuxT6ota
	X828LAZaH5VVgh8RD9TXp/nOvqYD1PO1hZLJePFWA4POFG+cq64Z5STHmzA1GUAUzunSsK+WU0Z
	TVrtcQCQadDE1jhWWN683xORyqHitSw1DHhcEG9Xi/nj/KlWTgYWTnDuikr9GXLuzKmZHIJZd2X
	4uX+33XCFHldRzSQ0WV/pFqm1aQNT+GN/YyUTQI5gz140VOP1OeLE4ZCMzOU924v9cT0EddAT0J
	NwaFvvVQo4vbguckyFxrSTjaGKLyn4uUUu/T5s1PLltBHQfWpiv8pQHvlmuNRKXY+KNYypGmGoj
	mKkGFm0Rk84ZZcV5YXtRpcM5tALej19dwQeRlYsfkcaJDPebFmKcQyY9Hhli2bZNo+zVYrcwVhv
	FvoUTtO1x80AwoUQNg9hA1khFmtFESosZh72Dv4c2Ig38=
X-Received: by 2002:a05:693c:69ce:b0:304:6782:d596 with SMTP id 5a478bee46e88-3046782e6eamr3796621eec.4.1779861181594;
        Tue, 26 May 2026 22:53:01 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304be0851c9sm613202eec.23.2026.05.26.22.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:53:00 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 26 May 2026 22:52:38 -0700
Subject: [PATCH v2 1/3] KVM: RISC-V: SBI FWFT: Fix stale feature exposure
 after runtime extension changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-kvm-get_reg_list-v2-v2-1-7940a401454a@sifive.com>
References: <20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com>
In-Reply-To: <20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779861178; l=4044;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=8rCDNvc2TJDmq0o9jKD+SWttG8Vm4gJbAUgSdeBhahw=;
 b=AfhaUDr6EDvzRR8AckzFU4mLJnayFuZt//mAddpv5TFe16Wy03F28lBbX2zJK5NPIj/ZCUBLU
 sDKiVJUb++NDY3CurknxqrlxIaH+V8PPFsplhKxsEtPX1j0d3+NfVcx
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Fix a bug where FWFT features could be incorrectly exposed to guests
after userspace disables their dependent ISA extensions at runtime.

The 'supported' field in kvm_sbi_fwft_config was set once during vCPU
initialization based on the initial hardware/extension availability.
However, when userspace subsequently disables ISA extensions  via the
KVM ONE_REG interface, the 'supported' field was not updated. This caused
the following issues:

1. FWFT features would remain visible and accessible to guests even
   after their prerequisite ISA extensions were disabled
2. Guests could configure FWFT features that depend on disabled
   extensions, leading to undefined behavior
3. The static 'supported' flag and the dynamic supported() callback
   could disagree about feature availability

Remove the redundant static 'supported' field from kvm_sbi_fwft_config
and replace all conf->supported checks with feature->supported(vcpu)
calls that check the current vCPU ISA extension state. This can ensure
the feature availability is always determined at runtime based on the
current configuration, not initialization-time snapshots.

Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  1 -
 arch/riscv/kvm/vcpu_sbi_fwft.c             | 17 ++++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
index 5604cec79902..837431867c6f 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
@@ -15,7 +15,6 @@ struct kvm_sbi_fwft_feature;
 
 struct kvm_sbi_fwft_config {
 	const struct kvm_sbi_fwft_feature *feature;
-	bool supported;
 	bool enabled;
 	unsigned long flags;
 };
diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 2eab15339694..d3be059c3822 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -279,8 +279,8 @@ static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, u32 feature,
 		return SBI_ERR_DENIED;
 	}
 
-	if (!tconf->supported || !tconf->enabled)
-		return SBI_ERR_NOT_SUPPORTED;
+	if (!tconf->feature->supported(vcpu))
+		return  SBI_ERR_NOT_SUPPORTED;
 
 	*conf = tconf;
 
@@ -361,11 +361,10 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
 		feature = &features[i];
 		conf = &fwft->configs[i];
 		if (feature->supported)
-			conf->supported = feature->supported(vcpu);
+			conf->enabled = feature->supported(vcpu);
 		else
-			conf->supported = true;
+			conf->enabled = true;
 
-		conf->enabled = conf->supported;
 		conf->feature = feature;
 	}
 
@@ -406,7 +405,7 @@ static unsigned long kvm_sbi_ext_fwft_get_reg_count(struct kvm_vcpu *vcpu)
 			continue;
 
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
-		if (!conf || !conf->supported)
+		if (!conf || !feature->supported(vcpu))
 			continue;
 
 		ret++;
@@ -428,7 +427,7 @@ static int kvm_sbi_ext_fwft_get_reg_id(struct kvm_vcpu *vcpu, int index, u64 *re
 			continue;
 
 		conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
-		if (!conf || !conf->supported)
+		if (!conf || !feature->supported(vcpu))
 			continue;
 
 		if (index == idx) {
@@ -463,7 +462,7 @@ static int kvm_sbi_ext_fwft_get_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 		return -ENOENT;
 
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
-	if (!conf || !conf->supported)
+	if (!conf || !feature->supported(vcpu))
 		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {
@@ -500,7 +499,7 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 		return -ENOENT;
 
 	conf = kvm_sbi_fwft_get_config(vcpu, feature->id);
-	if (!conf || !conf->supported)
+	if (!conf || !feature->supported(vcpu))
 		return -ENOENT;
 
 	switch (reg_num - feature->first_reg_num) {

-- 
2.43.7

