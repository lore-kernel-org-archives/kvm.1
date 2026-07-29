Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07712368D45
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367547; cv=none; b=IXDVTLUECa1gqVneB9tWo1NPRNATmmNCBUwKn+u+gIzvPhGL52EpSxlFfry3FC7TQM5PSIOxdpvTtsSBlrr0awGrgnjS0HTbgoP1jfc7095qi3ngeXbMzoXKgvmFMi8KFuPFvv6+JB6a0SJAKWHUaQidbvwCEoBFyqHrtihnV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367547; c=relaxed/simple;
	bh=q8qlrs4nCmmr/1qrzy3ueNPoW25hLnxO8i8kBJxKgj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNFcv1iPjyd4ADd89DoMJCmTV980toRUOmkMI6qNRss5uQ9AO5qHrnL0564vDhOE/xq8QkZY9XN5zo4ujVvEVW1vVDJTxwZ3S+rdtVUgQj2vKxHG18x5WodrvmdJH5Lrxasfd0Y6BOH7lDZFtdXAk6HKHUUGNmvPWyx7Kv/Ky80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgqN7mSi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgqN7mSi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso162054a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367545; x=1785972345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ig1ihYaIcCdMTQNvyfvc5KxHcD85RFL0JcLOryGs+LA=;
        b=hgqN7mSiv1/t9TwapJHBm4YAAS6dgkdv+9KRUYz0Y4hBCv7S7G5a/GHjUxvZODwCwt
         rdByhdSdjY/2BhUyWYQ4Lk63NROJnN3OCO+KZAG09tS1rDIWvpxOyQIKc7Dc6g6v9x1g
         5N8+a49+xxlpqbT7FmOC0gkJYXzyU09ljff14M6VQ1WZIh6sHLgSHtceMOw+Gf1OJE4s
         rp7KdPODv45OLEKIYikHIjCojPEE8yQjBj6l/s/nEuGF4hokUyAsOZa+kvnQ23wcal3M
         UdWAwBcsjQhS8sZye1iHUppf8kGVhLNwkIecP+JZrtVB0SMCRqfrLoGg0e0sYUk53yJn
         yIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367545; x=1785972345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ig1ihYaIcCdMTQNvyfvc5KxHcD85RFL0JcLOryGs+LA=;
        b=b25iDKQ80LY+m+LBjTyZOj1LtBwO1DXRu/LaiBLSo8rDD3MDsfDaxxT17+Tw0LN6Y4
         b5iMsa2/G2LChM7VFuQwtLGL3CYT6emIMt+x93xH2sM8R1WgIBfi6OuiFvcb/nSB7pcP
         PEo0JWDVGbNSlAxbi59n2NFyF3Sa0xYBZXiq1vvDI7dwKRW2fV7+m0efZE9kAn+UI5Zi
         vD9EMDT3NwMYi1u7HPfrwS1L5nHjE54kmTSs/NO8TiL3HQ8lW5ra4b6hQkqt1/KoqCST
         jiKaPasacnJ5YopIgfWN1YgBngO8mLYhDLSBazFU0DG4UYWqzbCwvydV4/YZYBu0NtZe
         drgA==
X-Forwarded-Encrypted: i=1; AHgh+RrwBafMhKwaMByqPHryYqk9z6xjY+3S8IQZRefrArNsQu7tnhy1OKPYUZY8ULBni7biUrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/DsH7OchyO82RHLuMP+KCUxEsZO6jx/dHdkyRW4rNvqHBj0N
	58XG2UNJu05WtCutFa0zmOX9gYgnv+WChE94HxaVU0SPA9SS1rsInrwJ
X-Gm-Gg: AR+sD12Evz+WiGqqlrHx3ul7D80KHG5HJU0zjRIIF06mdbCvbmYtZTpZk0gzcFqPMcy
	T7k5TwVDXV7sQq8b5niSSe3EB9IfcnqoWTYzBb9W3HDFUZ02i5D3JW/MtMXauYA5WG6eyM0W5ms
	QxTm1tZc1v0Uwb+6/FZG6aneL9iUCikypwQIt3iNxcBk/Pjt/iK6kYFL0se6WF0JwoqIgynsR+i
	oOdKF5+B8eGaWH1fndY9EY0fp7KYICN4zC+tueZkv0VzT3dnvE9d4frMlFovLjz37a9TqL3VvjR
	5y7PM+5Wyn9DYdUjXOWoMhHzxpXY9zB+2wJBIdcBmEjqtP7bWmI/euC5StYnJ0DLNzpEJN95TqH
	RyIgxyg4LB4d7d25fErEXoUYUsKXm6pkTyNAkbajHYaRyj/IecJb4IaxoKlEeY6DDFvS2WPSkAu
	UCII6wCBOLDdxJ8qGItvysUVPfNgI/NvnEp0h4S/uuQtbm5KUdnWjbOwKR7R0=
X-Received: by 2002:a17:90b:2b4e:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38f9bb15cd4mr230876a91.13.1785367545337;
        Wed, 29 Jul 2026 16:25:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e54sm90102a91.13.2026.07.29.16.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:25:44 -0700 (PDT)
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
Subject: [PATCH v3 2/4] RISC-V: KVM: Add SBI FWFT validation support
Date: Thu, 30 Jul 2026 07:25:23 +0800
Message-ID: <20260729232527.139183-3-inochiama@gmail.com>
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

Since the KVM SBI has extension parameters validation support,
implement it for the SBI FWFT support.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 03153fd8d15f..56fb59afe02a 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -603,6 +603,30 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
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
@@ -755,6 +779,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
 	.init = kvm_sbi_ext_fwft_init,
 	.deinit = kvm_sbi_ext_fwft_deinit,
 	.reset = kvm_sbi_ext_fwft_reset,
+	.validate = kvm_sbi_ext_fwft_validate,
 	.state_reg_subtype = KVM_REG_RISCV_SBI_FWFT,
 	.get_state_reg_count = kvm_sbi_ext_fwft_get_reg_count,
 	.get_state_reg_id = kvm_sbi_ext_fwft_get_reg_id,
-- 
2.55.0

