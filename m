Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0EE368D45
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367551; cv=none; b=O8v20bXX40Puk94UUsquMO0wKy8WMB/7UTSKJJ64TvSRnJpYtLHgTfgWxD42jLRrDEn8iDWn3tEcRWCMCsqVULMBOcJXxHgWC7EFKAfyY1bLySy9jC1t3BgaQ3A9jG/nJdI+MnmnviVHYtqZxV0/WDHyPeIF9TeQbm7cMjCp888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367551; c=relaxed/simple;
	bh=dJl0fLMWiJp1FXHaF7fslhtFbIf2M+oujlq+vFCvrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNvDd8CL9g0RMn9z2qdUV/eixnrkCQYrk0SXyS2lem8yZWNuel2A9CeRk+4eLqp0W6Kih9V/NgBpOGBOUvrim+jfIQm2IGuDZLq4sD2zDEgOZU0iJomMJgQcTq3OT4wLAptyw2JGzGEN+CZF2wS4om3LtBJiW5N/MhUn+UZzC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7jUOitG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7jUOitG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so21636715ad.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785367548; x=1785972348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOohDTGKU0Fji4CKKyS8ZYpTWzbljIE/mTc4CCY1QKo=;
        b=Z7jUOitGYPUmx4u320wcnKAkkGLdCv0sTDbcKJz4Q1kOoF9ABnt9aRXPkZCoWLg9Be
         dE3qiceT8FySk3576ivUt6q7UpgBghm6tMZGYKSMtX1CCdINgACewh8yoZuHXKNQQVYv
         dAtgzgRzLDcwXpM99pl5ACU8ihiaXhTc2nPGjzM8/ZGHWNpcjDI+Hrb5cn5ZlCvKXOny
         HdSbbCE3bLYAFMBq2x+0NA6XfwiPHsuChEPkdj4Tn12ERwPRqvK1vS2zXwy+3QA1iVy8
         DbdaQy/I7Gn+9BdtO3Uz4BwbjhDo9CUVG/8o/qEGRil6yA56+UkLMKSB4oHONTZ8/QW7
         KolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367548; x=1785972348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOohDTGKU0Fji4CKKyS8ZYpTWzbljIE/mTc4CCY1QKo=;
        b=Oprt356qOj+4wRDiCp9SMv4f2wRChJp9TfdHkKqDAEv/JWYC55nDiBny9TuHcfSIrt
         jxihhkM1powaVrOS35l93LQOW6VXJcJwAnIEboClDGKIKIo3E3Xck5PHM1d1CLg8yWx+
         nUrk+gPAO06yIDzI7DPnVMM8h2nHVex1U+Ent+C8vabTSJLVvWtB2pL6YEOhRL0lWjVB
         pAo140TkpqKrkPeR06Le9f/mv63f1vAC427HtYVbapJ15VLYVoezYZvSywhxeil2Buj+
         GaQEeRRpB8jq4UB8nuigEJWNluElJRXDXdfUSRsawXKutQlhyk2ZEzgrb5kVDMBMh9mc
         xcJw==
X-Forwarded-Encrypted: i=1; AHgh+RoyKpoyX5qLkEqBIwPBDXcbSwlk6MHkXz6x2acaEGu+AyZ7nh+59/tMpRW4Hm1aGbvJHJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqdWl2uErYLi2PmBqPFW8eiuL7qmlC8mWDRT451yIllnac4tvx
	+ZF6+nXhgMgOD0A3jShWQ7LHZaKsKM+pU2WoVHrmpuhDV/3cnw7sUyxT
X-Gm-Gg: AR+sD128f/7O5NdX9KUCXWZ5uiak9tzbKU2BKfaGuAPeI5UKqC/3+yedsz5QehPo50f
	s0Rbbl3vrHZdhpn2EAtF1lXDVrZ1I3AWU1PV8rYhlnpoVaGKqwmka79pUXwTXntz3QS72fRyFuc
	sU+CDHEmx7UkYLksuiLNJbagnzgz0ldJtuRCdEoLCMP6ghxbkzLMFa9E0vGCtOwpmBv1so4rNCN
	HmhXiMXLHTzPlUOaf/VtPwR3DeBV1uKhTA0u0ciNwiMkRwyEgoUCOF/R84oaJDgUfWB7Q05FwyT
	Gt9QR9JKO3IxPFndDzFvEjMakdklNvXod09ZAFG5sWERpQgU4OiFb4Q9I45ckzLXHxLxZU+yALv
	M5RwG52xpS6WVRo/8FMA0ACougD+3mNOJOLHv9/aqKePkixkdJVmIe0GTGyuct5eqjJYJekI0J+
	oyNJjaKgz+sLAELgA7evcO1JvPHMKZRmp9yr9MWhkOhRKM9TGi9x8gIXwz1/4=
X-Received: by 2002:a17:902:d48b:b0:2cc:80c5:73be with SMTP id d9443c01a7336-2d035d154dfmr3101295ad.40.1785367547941;
        Wed, 29 Jul 2026 16:25:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15215sm17512995ad.8.2026.07.29.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:25:47 -0700 (PDT)
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
Subject: [PATCH v3 3/4] RISC-V: KVM: Reset the SBI extension when disable it
Date: Thu, 30 Jul 2026 07:25:24 +0800
Message-ID: <20260729232527.139183-4-inochiama@gmail.com>
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

The SBI extension validation callback can only fix the parameter if
the extension is enabled. However, if the extension is disabled after
modifty some parameters, the state of the extension is still broken.

Reset the extension when the extension is disabled so it can have
a clear context.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_sbi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index b737e9a7a12a..1c4f874368fb 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -221,6 +221,7 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
 {
 	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
 	const struct kvm_riscv_sbi_extension_entry *sext;
+	const struct kvm_vcpu_sbi_extension *ext;
 
 	if (reg_val != 1 && reg_val != 0)
 		return -EINVAL;
@@ -229,6 +230,12 @@ static int riscv_vcpu_set_sbi_ext_single(struct kvm_vcpu *vcpu,
 	if (!sext || scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE)
 		return -ENOENT;
 
+	ext = sext->ext_ptr;
+
+	if (!reg_val && scontext->ext_status[sext->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_ENABLED &&
+	    ext->reset)
+		ext->reset(vcpu);
+
 	scontext->ext_status[sext->ext_idx] = (reg_val) ?
 			KVM_RISCV_SBI_EXT_STATUS_ENABLED :
 			KVM_RISCV_SBI_EXT_STATUS_DISABLED;
-- 
2.55.0

