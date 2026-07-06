Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFF37CD3D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304501; cv=none; b=K773k0ODNp5W/B5FD5bFe5PoHaNNyB2ldiaH6Kdv21z/iJQvatcuCqWMT8wfwbppb48H9gd+wfdGQG3o+ZDxBY7xPaCOcUGwM+A//MRASPEP/YrGpxWPxfgwbBEkCcdyJCVT5fV47z5SEoFMjQgZ6561igYSg/5MhilmIXClSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304501; c=relaxed/simple;
	bh=jKX7yCJzLXTBm7/RoRGPTwNXXmYDIrIjrn7OXhM9jJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF3eIqFbEh5+Eees78PPkl5sAsE2LBuq5Cap8AB08j4LDuJdRcfIJfxozM0/SQ2JvA7fSdq9Ve5lWtJ+tiOOlhXazXUINL/o6j20m26/DnlMMHbRazNVWhmkMaVcWqILlWIHJJel0Rs6wE6Mz7921LxMVBFt8kvCAkITBzmJNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/xHsHER; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/xHsHER"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1348081a12.0
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304497; x=1783909297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=l/xHsHERqhNkO5iImfJJ7KP/4NEPnEN1jSnpi7AXSDNJ/ilOMa369kF35n+VSEsFk0
         Z5iVo5MLmalsfclaAj7Y541OnlTbvvdGLI5okLUCMF9b+1LRE0kvuz74/5NdoX0GGd5N
         xTDV5tjzo/stA9sR3zusSRT/ptb307KNQFFJL+bqF+hzmM3MA/dgVoOJthHKuFaQHJt7
         A8WqowMPa5SI5wUxPZEQQ+whgVtbfj7FtmWKH3pbqqQM3vGgKnAdI4oyu3xkw/YNZzky
         cE8RAsE/lOI54IxTjeRK0KWVfkale6NFa+6ATVbwzH8O+VhWwKLWGWoebaVU3V18KHPz
         nQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304497; x=1783909297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=PvAybADAeQciAWbM7dJAL3rw3QM/rmsMxCmBaaMLlkOVOBjd3SbEHqQUsLPtvplfp8
         FDNW5a1JDpIK3c5q3sNesEYX+caEyX/QTbdN4V3nFm85EFbBQTKapOWUR0t9h1FT6U29
         dIkNXL5AuZNrNgeffOXEKtA0gFmK9tG7mtii60hcMbfeqVJXo6YTWm8TljZcgTlXatV+
         UMOxf1xg7LxnikP4BpyeBHLikpO1exZirk3WXou+sbhEbAJbwroflsrCP8ufJUeAaGdx
         qeZj36zbJCXQIHoL2Ov6Lv2mzZ0xxEgmA6NSiwOUK22MXdp8BqqcMh+z+R/Zcjf0MEyw
         1YwA==
X-Forwarded-Encrypted: i=1; AHgh+RrWkiac8zOZo3TTSJDngdTWzxlgp2d4ZqJxvqjLSB9iRTnoEA7G5Ps6jDdcXYnp1OqChF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlQFdH/Ts0795afFpMS59iD1+j1Hj1SVYlP6Oykk6F+w4BuR4
	xNWt7Sty7szhfc5pWtpYAcbIf3vSzPPG562NDMoi5c7VklfUvOQ9myr5
X-Gm-Gg: AfdE7ckvcussjLQFaJ9sBqGwyi4ymiURP+KPTXH6vH+IilO0o7AamsfyoDBPwnfIOak
	cHZRkn6RfG1uqUKhXjEYLyv03AQNhzXqHU3r/ngs8lbagV0RB+ROQc4gxLC0GACE0HlDXlkYLvE
	ynUGYOSfDGJIaTsUAEfCgglJBn+e4+xZIPp//22lnLJfEjHm55aDtPrg5ACLRr9foveQpSqzGZo
	fdbs+AgSb6zRpKDaahx6WD1fA8bI81YP4qm3OV6ItzxfA9Gylv8xJOf+t8un9gX8QC94DZ3H8++
	QJniiQ+DssMvozBpBTUjtBXnm/PaUC+rB8UwUWfvYXfjr8qzpYjftDkMrstcatOqNJv3jS2ryjv
	38f38jD2rcibZn+e5d3S5gArkHPqQ5fe4kGFBXmPYduutMrJhvMaKpqDbMIaghgFCyQ6qJ76ZXn
	4=
X-Received: by 2002:a05:6a20:e211:b0:3bf:990d:3fc7 with SMTP id adf61e73a8af0-3c01caacd28mr13139722637.20.1783304497212;
        Sun, 05 Jul 2026 19:21:37 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b0a2c4sm4953589a12.19.2026.07.05.19.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v5 2/8] KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
Date: Mon,  6 Jul 2026 10:20:38 +0800
Message-ID: <20260706022046.214956-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706022046.214956-1-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Svadu FWFT for Guest/VM so add this extension
to get-reg-list test.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index cb86cb6b3635..94e33b2ee796 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -745,6 +745,9 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
 	case 3: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable)";
 	case 4: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags)";
 	case 5: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value)";
+	case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable)";
+	case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags)";
+	case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)";
 	}
 	return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */", reg_off);
 }
@@ -944,6 +947,13 @@ static __u64 sbi_fwft_pointer_masking_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
 };
 
+static __u64 sbi_fwft_pte_ad_hw_updating_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -1259,6 +1269,16 @@ static struct vcpu_reg_list config_sbi_fwft_pointer_masking = {
 	},
 };
 
+static struct vcpu_reg_list config_sbi_fwft_pte_ad_hw_updating = {
+	.sublists = {
+		SUBLIST_BASE,
+		SUBLIST_ISA(svade, SVADE),
+		SUBLIST_ISA(svadu, SVADU),
+		SUBLIST_SBI(fwft_pte_ad_hw_updating, FWFT),
+		{0},
+	},
+};
+
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_base,
 	&config_sbi_sta,
@@ -1268,6 +1288,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_mpxy,
 	&config_sbi_fwft_misaligned_deleg,
 	&config_sbi_fwft_pointer_masking,
+	&config_sbi_fwft_pte_ad_hw_updating,
 	&config_aia,
 	&config_fp_f,
 	&config_fp_d,
-- 
2.55.0

