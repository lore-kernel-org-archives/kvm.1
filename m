Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4E47D452
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326867; cv=none; b=r+LSieJfojvvCXRq8JjR2MFH32RvglH9bfG/Bu4hvgoJPsxonQqogt5NCoYGeV+dyhvnE0LHgMoAHuNBtU1eP1bFdBUgXwTLbaYmicqaTV6Zce3imTwkM054mweLGTdSNnB3V3iQA+/gfA+6FieGuidnBTdNbGdmtsndf4IWyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326867; c=relaxed/simple;
	bh=ygPgZoMqXOC3wZUcyQcGEydn+a2bqNHY9YgXlHDuSpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG6X/OaM2aaGGNh1DpsH5T2YKZ6+t9Xpw2/SmPuzXtosxkNr8kQCsrWp60ayRMAuyXX3TKCFUULniyGYxMT5PIJYHlDSiuhPnhrysZhQVdi+LnGEXC8OwPdsdWw2/dnzk3y+2/lPH3n/8Pw3kM87UqVU4VnrnNTSfj0ztTTg3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekd1O/QT; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekd1O/QT"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb8ebaca74so341963a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326865; x=1785931665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Reyg7Uf6tDZ8+7RMN+GpyxgR6kpVXfUwi59Uf40QnCY=;
        b=ekd1O/QTrHbkba9BHBYgvzooYKoWAf/hDBOoVbelL63EUMNU1a2oRaIUyQiSphbyYg
         lMiiJE2NZJhu6fYTK4t5EmdSjADnspB8ojCCSdLbSQ4ld5NvjkmoELF7cSRiFn6zvFo0
         jZOR/Eehaj832a732BR726fkGX6O/hkKv5BzgXKRAQ9UqbCqXIR6lI5Cz2XDJTGPCXgs
         oiPqn/H2oMYyDr/SezHYq/TTjXrIeIqnSQNQN6+agYDaF+uFtYFDROs2y2J6d3VZWnkT
         bGmNdVHguuy1hrNne7IuC0ZU+Sqt+/SAv9ESmaOJWA6NwvmY7Nh0NC8pnxlvSM9iOP6i
         jN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326865; x=1785931665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Reyg7Uf6tDZ8+7RMN+GpyxgR6kpVXfUwi59Uf40QnCY=;
        b=eby2xex4IoGT/yBgePzvajpCzi5M0fALZ43MQRYW+E740M0i1Y6DF9wlluNF6XD5vw
         roOxnDF0/JK2XikWPw6ly3qVD6BCu3j6GZ1/+k28TOfcsHnOxYv8Xub3NuiGb+jG2oNC
         xWxDKIgGgxrjTG7ryvgU7MRGdDTRbCvn/5sypJ8UZcU6voSN4WFqaXEpW8DpPdktpXWF
         k0m1R2nt1uSwH9pngOmbAx0CEOZgZyKKVS2vc4zZgPhVNc0LBfoYZXKLbTvlRfyNAasa
         oteKL1/YsuDRL0SodwumWoRhR1OgWbHrKXO759H6jTGmMgEtC9g6rSFb5hoXr8z5oup5
         Qv/w==
X-Forwarded-Encrypted: i=1; AHgh+RrJN+rwiEOR3Pc0XSAAqhToQMypmLL6DUq9hqLEWCB0++qql/Btv+lPFGUNGikkhp9WDh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sbpl9cOH1KyaF9vnBBfvlLuIhgniMxJqZHUmNrkr4xbl9+Us
	AmPJITo8hl5Y8e34on+XUQQoRdK4sbnQxh1nWo86YvN1TNrVcnBRTiJZ
X-Gm-Gg: AR+sD11qLn70d203Gs0RHZX02VbazP8wP8Fw25SJU9ICgbtMVgB8g8tJ1BIzltef8pT
	LgEdKmjjovkb8/MtsNnaZLdK+FwUWRxJT/+wv7IjJreCvaKdCyn2RPfbNC+Io69r/uN79tjIhvW
	6Y9pZ6P3tpypf19nNgpXytj22nxOqdXY0rtcFKUZ7lE3y6JvRVzfvRK5FOrlyJ7ryWsuZL7ydrB
	Qm+/553k9Jnbhs/rQwVZpaNjkKXLR+XjMSUfYvtVhNI59oGo7jphtDdXnZLUYJYSwuFpwzv/BGT
	Bi+dG7FDpSoQ2vMwQxJielT5IYk06NmmfzI89apAuSDiJ7VJjVXTaOWf2w3WpqNoDRH+DpC9lFg
	HGxDzURIk7iv+C2z6Qq/StYo0q5bhZ1QeRqleWKWTDpNB7TZ5n8FBZ2qklgrIZMPYSEx7IoPaT5
	2Yj6sKyzJePvEHarXWYigH0j1vNskCc5Hb8nZPiVTxTGaXov0QaHHV23xQFnV0Yr1+cSSdXDQiF
	OQlFjeGDPIL8noFX/AE0Hogrw==
X-Received: by 2002:a05:6a00:4f83:b0:845:c7f1:29fa with SMTP id d2e1a72fcca58-84e93250f57mr6434871b3a.30.1785326865329;
        Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:45 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	stable@vger.kernel.org,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [PATCH v3 2/3] RISC-V: KVM: Use unsigned int for vma_pageshift
Date: Wed, 29 Jul 2026 20:07:32 +0800
Message-ID: <20260729120733.829457-3-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729120733.829457-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vma_pageshift in kvm_riscv_mmu_map() was declared short.  Use unsigned
int, the conventional kernel type for bit widths and shift counts, in
preparation for sharing a common struct kvm_page_fault across
architectures.  No functional change.

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 943d8dc72105..d2a06a54be17 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	kvm_pfn_t hfn;
 	bool is_hugetlb;
 	bool writable;
-	short vma_pageshift;
+	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct kvm *kvm = vcpu->kvm;
-- 
2.54.0

