Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62A18CBE1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306183; cv=none; b=s9bYhVlIbW6RnpoT4WslWClQ+Ih8+pv1rkixdXhX773J2yRzzaSnL78bpDmaJUg+hQWSHGxseHPQu2VXt2+H///V4o6oaSDNq0jpVJ6AaKMLrN3879FZRLesJ2qCHTqAoP2F1oW1XuRg2C0p7qu+fVyvRMkMQ/9uJvjTvxpgVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306183; c=relaxed/simple;
	bh=QDHxV7W+oqGlbIXZMJ7I++MZaMSnKMppWqlbLCG4DYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia94oJrFUZEmxazpeodp9aMronfRPlWBlIxvV4W/5y5PbvWJ347UJcbsb2b+Kck6g3iuUzotHnjZY26G6eqZUJyUKMN40V4Qxk4X5p8++63oSSti+515b6H5PwLoLOEQ22AK6PnuFZSRLnARaxsEu50jnQOU+PkmgUf0cZvQqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkZ7jEV/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkZ7jEV/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf1cda2b17so6293425ad.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782306181; x=1782910981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQUuPMmuv/cgtI0GhaDa2PT2gy6UgZhnkw9/EmvR3IU=;
        b=rkZ7jEV/tzZQwb/cDBkJ1K4iEIhAuurrpXYav8MxGpE7fPeg71+diYbSUhKdnYD9XN
         AgnSKJv2YMp5eU6dOgTiiwNJPAJwFOzqiHckTad10tqZUr2j7YzmQEWbhbffJkllmDFU
         db2x3XvMXFKAJzYpegXsgHOcw2hMlJaeotA00uW+i20TB17h3hq9JHnp1oEbl2IBR1xY
         so+LHN5TiDNW9MKeoCbU4rRrOCGUlBdgIrItb1rVmGo8AFLL77AULSovUwS98q/+0k/I
         rAdH/p9+RUsc9brk7kACOdqANYoWC+vQJhLqJ4W4vOPToNdGozaXWC/2OfhzoWDs2m2e
         TGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782306181; x=1782910981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQUuPMmuv/cgtI0GhaDa2PT2gy6UgZhnkw9/EmvR3IU=;
        b=eEDDP6LWhhWAS5FQDsD7prgkH+tBkRW/7fkVqQlFpbjmbPinO4LDy2TPcRoJN2pMwx
         wOrIYhnjNzDSSVFm2VkvoJKbvIsfF6Nk5vAmYGbs35Fhbi2J5NxnAGi8VDGg6AkYDdg5
         aH4MbZGMy1UHsWuLu8A2BJWyzfCAyYGobBnV8Q1EJ5JjFgqpSpEmqE3lUDOXjoRHbJYn
         M1a3KVG8mg0WNgwprEx0IK5oYfjPo9jRvcuhUg7LmTEhwUe11nmCFM+ZnYbHBrCoqmZN
         q9gj2dqbcgFmKacDCo3omnMGWVem2/H1QtawS9kjzLXiLtEODeauBNIpFObLSx5G2FwK
         KYFg==
X-Forwarded-Encrypted: i=1; AHgh+RpX+0+W7A+Hez1n9l8j5DEg2Ohj11qcqX5GLPa/GLbUbY6rTN31Tsc7b4UTxFE92/pzi3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0/QZBudTDalDe8MUvXs/hI9p2zjj95mFqYJCyg8af1OnSn/m
	KgwD9jRJrV3lx3+q3K8WMom78mQI6EtfsxQmRKA+YXBsIpQip95p3h3+
X-Gm-Gg: AfdE7cmrPGjnxbx8lkKkAO24TCTkY4jdp5KVLJylZi2Z7PtAgusno83cYdZGQEEpNhp
	ZmQKNCbKtPZ1U0gk/S41BjVYaGBP+els2B5DCQZwBMkUkd8w2MxCrE/yY++c7fQtNTnEV+aESXA
	jF51MCP/ucsKHKFw6KJQzeITflHv7j810c6ltF/vEZf9NtvcpOXKwvulkVGmSLCCWBt816/DEZg
	0hojs4SkGYa6+NdCfq+6izXhuB8GzM5pqVBtkooj0VCIXO2HN+YCCdvL/6zF6/zb4I+QPirIUS/
	nc5uwZ52j+eysUxZmxkMW5UcAZQVELQoNLb49xqUIBtwBkCs2vEet/SIUcYW0AxOITIIEKoPhnU
	3MCka8XjbbqdIkndUAWKmnGClpdUqM6YPIMgmcJ+tyEWYP1bU6qeAakIFQkabFhQmGqm/9IAXO/
	ij9mdUzKIpAi7qN+KkAVA4geg/E1Bp8Ofv6wFVyK38PuHi1p4=
X-Received: by 2002:a17:902:e5cd:b0:2c6:a4ed:efec with SMTP id d9443c01a7336-2c7c40168b9mr61894555ad.27.1782306177091;
        Wed, 24 Jun 2026 06:02:57 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad8esm134704505ad.76.2026.06.24.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:02:56 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	skhan@linuxfoundation.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set
Date: Wed, 24 Jun 2026 22:02:38 +0900
Message-ID: <20260624130238.524706-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_sbi_fwft_set() applies the caller's flags to conf->flags before
invoking the set() callback. If the callback returns an error, the LOCK
bit persists and the feature becomes permanently locked without its value
ever being changed.

Move the flags assignment after the callback so LOCK takes effect only
on success.

Fixes: 6b72fd170592 ("RISC-V: KVM: add support for FWFT SBI extension")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index ab39ac464ffd..1342adb3180c 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -327,9 +327,11 @@ static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, u32 feature,
 	if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
 		return SBI_ERR_DENIED_LOCKED;
 
-	conf->flags = flags;
+	ret = conf->feature->set(vcpu, conf, false, value);
+	if (ret == SBI_SUCCESS)
+		conf->flags = flags;
 
-	return conf->feature->set(vcpu, conf, false, value);
+	return ret;
 }
 
 static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature,
-- 
2.52.0

