Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9243EC828
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367552; cv=none; b=td9dnzap+6fhY8km7I+GfvZ/dc7Df90Fdjjv9ZjKC9JtwqOIz8glQ8f4k7fOBQi8bKojgmmCK6W8orrrzpa6dMxWWvuLDblpdyUQw3R5vRQcmbcNV0FByQMoM9ZIADvi4lP5fHbsagCRqxDSuPzyyABpj8Zuxcz86QW5fLUgEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367552; c=relaxed/simple;
	bh=V/yxf2TD8QMPSEy15KCzxvZjUma5eehsdXsnh7J2CEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwqCZHwwfiq4+3hlTFz0tBBVyWSJJoAg3ndYRwxx7yvnzLWSINFtfsPJgibPLpvZYq4ziX4bGPaj2xVJQociiD0Ee7eeGVGhcGnmauy4we6Tj6yjG0VfzU9eBGbAuee3c9784JxALIGewtFr5qPHnnIIbsWGuY44lEnIZkVUGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNE0wLpo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNE0wLpo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1165570a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367550; x=1785972350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kW8oqLZffY6X0abqSuvd+PUmx3S3p3riWWcGYu4Az1s=;
        b=mNE0wLpo5gPEskC4yDeZaXSHsuYcbaEF5qH15ATI0yIfE/foefGQUHJDLJKBCzdC/y
         I18a3u6XHMRuuTZ8on3Knfb6u/eV8t5iXLNz7LdCToZVCZOt3FyV6kYbP/oAbPOAUXs8
         wdhJL3+jaIyqZkIxl2z6aXeIXCCeudTgUCgzkn5FEAxUriNnyl81MtPgrVmZcm3MHNNl
         3Z48t6v+sk0M+sLvzj2jkFSvAvI5FYkcszfGRi7fYMs7VOA1FaCRU6lS5E0FdXAVXOZA
         5nzaaKeMF69zI7LyEORxGN1LTVVjiO+w8h+mcagr3M20jW4W9PYv9eil8W6LXT/V0d0A
         mNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367550; x=1785972350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kW8oqLZffY6X0abqSuvd+PUmx3S3p3riWWcGYu4Az1s=;
        b=oM8f1NdGcEl9gFwRiqrPcciN+Fjbcmz/z1EjHkmA540D0bFGAZII0VZtI8L9X1wcNU
         +L5SEtYVzMqLWQQNGVS/Mgli2GE/aO4jz6LgDvwpMK+geM1SoFkTIGh1z1t1hAqA2JAk
         Rfk2SexubgytXQ3KE+L52JIBIzzgalYvBuUT6f2LQOLKRcO7FZ7Zfl31Mc/1dToSW/cv
         nq/IFj4CNFSo2GLLo89YsFf40kXCzhSS4EpdHfmXrGni3QIdU1GdMKCG/VB0AGueVeBC
         WwzQ/0YniUn1nehdA/5VlAREvzd21wW43WZw3JkeIRJWZq383KEfTSQIzNXBLztgfo40
         pFgg==
X-Forwarded-Encrypted: i=1; AHgh+Rrn7kwZg6SzzooYz4Az7p5cPOjlPC8kylSYHRM0mhCLbrR5+t2q71z0CN/gwjinh4qpKRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SXiWlrZRHeU6LlhaKdMQqXp76EsgsPiLckCHCsnqB9sChkUd
	5cPJsq4NgrHBmi2aFW3dDchYWvdp+mN6za63rVYYFv6RTGfy8FSLL+LV
X-Gm-Gg: AR+sD12NxxO7YKCvUCAZnyVTISdNDzPHExxns5yRNnLNbXsL/sUJWReESZtU8Iu0xGl
	ktzisKrLcJHFO/ZvAoU14lcAV5mm2czeHb1TLwRgLkTFlrRXiEBhswpoe9aVp3oRqfHgU1cl8Wg
	Fxm9BmD/2EhauJHvehc5ju2kL1FqPBefVPtQrrG5qolcEJPbiSE/Xj5Te2FhQBtQaEaY9IZ6Gew
	wF02UBGe2NZv3aefLyoDvXNeqDEdoqkOl9U+u6bSW+2M+u2GunHc9KkdKn9lpn2zBZdBHcw75B7
	AhaSIIyyy9cHI6IkDt2gdFvIDmVMLCBJcArxjRfVMHdz9EyWR4DeulK3zPPjEoG6f+7oK0zCRSm
	snraopfyBldHfHJel3m5co52EUuVC18t6TWElBe2qAPSIrZTbpDsscV5u8OVgoup1QJeWcrDziA
	mb2vchAsWo+Oy3rYCW3Cute5WesmX5k7voWBTrHhX4E4JbGc5eDf0SFl365Hg=
X-Received: by 2002:a17:90b:1b43:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-38f9c032891mr269925a91.34.1785367550506;
        Wed, 29 Jul 2026 16:25:50 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b7ace53sm90033a91.17.2026.07.29.16.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:25:50 -0700 (PDT)
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
Subject: [PATCH v3 4/4] RISC-V: KVM: Mark the reset callback of FWFT extension always dirties CSR
Date: Thu, 30 Jul 2026 07:25:25 +0800
Message-ID: <20260729232527.139183-5-inochiama@gmail.com>
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

As the CSR is only flushed when the csr_dirty is set, always set the
csr_dirty field in kvm_sbi_ext_fwft_reset() so the CSR change can take
effect immediately. This unconditional set should be safe as all
supported FWFT features change the CSR state currently.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 56fb59afe02a..2e35e7e12327 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -601,6 +601,8 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
 		if (feature->reset)
 			feature->reset(vcpu);
 	}
+
+	vcpu->arch.csr_dirty = true;
 }
 
 static void kvm_sbi_ext_fwft_validate(struct kvm_vcpu *vcpu)
-- 
2.55.0

