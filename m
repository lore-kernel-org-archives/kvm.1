Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B436BCC4
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819885; cv=none; b=r7EcmwM1B9lx7ghbulmchLPCsa/l6CXMuUUXk/tai7SLb4pYsWIpim9sb0VoQDtrCD6Nq8b7LzPz7OBZP5Tar5gx2ecn77NJY61a8l/ojD6aZl6fZYtKVZ027j4FYfigyeQpZ3lJa++hUdTW7KTy8puW5TOP/RLLIwpH4QylIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819885; c=relaxed/simple;
	bh=P9oXlIsV+MegZELpI7GDef37LAa8lF8oXfLkAh3JFiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjhQHk8w8t61PpWpmDaE4IZsBVv2xp0O05M09vc236LOC1iopwMLFpNY5Sr2GLPFy+3eHa5OKHox8odFRR0jzMyle6RDABiW/uBru+Q+UMtBI9ybwLTBs5eHfre01EU+AIEmUhl6YwIZWkYS4ud1K6UOFQA8PqXG/qZAacJlfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK3bZgLz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK3bZgLz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso22682255ad.0
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780819882; x=1781424682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nysJeNyvG9UILI1DFzn2wsHy9N8jdjLD2gqQX3bP48I=;
        b=nK3bZgLzyge5RA37eHJ1QWVS4JOoDjJLI8mak1XkmONAPMuaDgxaiSx2sK8ckO8So1
         ggKwguGMpZiRVYiicPcIE77CJIO31dQQQGIQtHL2hpid+22ewF8xv1dqobBW8NJ8ZBF6
         K2nr8cB42mE/Icm7g/TksWm+rGe7YYddDDNwR2j4M4SW8WrBcl1+bLwgVxukbTwYzpNY
         TN6OAqEEffJHqtH2ZeYkCfV0ZsRgGZZnDiEiYXy0fm/cy4CCgJusarWGomzXVBg9tdkR
         0+8EhnhTngJ/YwAKjw9yH4aDT/m7GFJiS4yF8vLLfDzcKxB6UalGoKH+paj8dGUC4048
         71sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780819882; x=1781424682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nysJeNyvG9UILI1DFzn2wsHy9N8jdjLD2gqQX3bP48I=;
        b=er4gW1y6Wp2qdk71aJ5lUzQ5ibdy6gjTBsw2v9xa0Lj6tvHYJw/ASyhst6ikf+xPtm
         sxV3gUaDuwwaB4hdDFYT/Zvq20E3Fz5hxx8FkPmwe51NdKAUqlhuh4nJWMMlAqGuPMOm
         ntdpf+5Icc7QV0A3rT3hCXwVeKah287z4WbQf+LoiNNd1L/hCLXC11MCakMnhBSjCIjR
         jQXrNj2/izLXhX04KvbHC257kpMY2xUE7vLWl7RUQi1zSWuiNtqNzJiO1hLCQRfbiqHJ
         37e/ilDC01C/QJP2H6yA4XzMtVo5wC3RadKKnz31udOIlPyowngB99nIYUAUtzLedl7i
         KaOg==
X-Forwarded-Encrypted: i=1; AFNElJ9bxs1sbbCuCjliv3OlM+gk6Sl2hb6jMy8OlG7ICkuFgyl26hApzhgOBryEZXZn/0AhHXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDQTdbYu/b+S0+zqSfcqObsIoE0sCRpgTUEFYCXwhMrwhUAz4
	aNM5P6+smqVPo9sFko4MGNZeZic6cjbFZIV/RsZtcR2OUXvTB2SA9oud
X-Gm-Gg: Acq92OFTRPJ6rcbDqVqzTwKdC/p5Cn8M3W5nyUfoOafzjy8vqZmhDG0IRh/n2pueGkA
	OwCxfMzPbKxbCPDcYnIiOiaqANiGXWym7OcfP8YCtW+s+887U5Y5qduNXUALHqBrlCyQ5SgC0oJ
	u0kxDjmEhgDCCfrCys3n5DYe/4IezsCfbCm1NWlSuFduZkgHZyfeF/bdKd+zwl84YUIHtdf5+Xh
	L4Dk6qopi67w+r/eIFh4xSNjcLx8M2iOj7nq+B8rK1SCvzVKAReVX8fsTWNbqTENblPl8N/MDUL
	D24gX6NWQnl+pHyTyty16Pisry+Jz7ABwLg10zG8BCwnwxKQu6slV8scj6WjFpnqskeX9UcywoU
	1IAauNMuvHNu7NVEkQFj7s94hzMzaXuOqhhkBVm6Af0TRnN1pyPmuwhJz3cZ8M0+K1JHHmWYxze
	dLNFhu2LJrNHIBqqgmbezzyXr9oJd0s77k+g==
X-Received: by 2002:a17:903:2987:b0:2c1:88a1:9830 with SMTP id d9443c01a7336-2c1e7e74ecamr126056945ad.17.1780819881941;
        Sun, 07 Jun 2026 01:11:21 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm15223135ad.38.2026.06.07.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:11:21 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v3 2/8] KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
Date: Sun,  7 Jun 2026 16:10:58 +0800
Message-ID: <20260607081105.993908-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607081105.993908-1-inochiama@gmail.com>
References: <20260607081105.993908-1-inochiama@gmail.com>
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
2.54.0

