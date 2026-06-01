Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2A3890F8
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303444; cv=none; b=olc1fJhydnP74i+A8exxXIdVxAD05wqoSUVEYRayfvf+I4mHXmv4EO6s5cpyQALNwFPCxbVyXIs8sW5GkLwBkBO8jNypjS3MpwdKUrY05kcsBL249ZdQyigjcFzSVM1gZggD6Mvppp344X5r9b2HzaqBab7T5KTmbU2SshaAJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303444; c=relaxed/simple;
	bh=sMii3fcp84xgrUzG/3AkSPmm2RWBWNn2SHl6UbCXr58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWEmGi+s89W5CkPh+z6zdUaN661t8wyj6kLZ7sTMPQKXM/1KPLt9w5LmITKYzSju6q/KjEh9n5ymKueuPdT1Vy0tgMVPqwhOtebqdAy/EhT/Z5OxrGm1DCy62WmvUiquzxmGEpNw1q3INneSR8YTsveE75TayiBNOd5fUqHovC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSncP3mp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSncP3mp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf30d530bdso24806645ad.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303442; x=1780908242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSRGQKpWCLbV+j0YDeovxMcfa4aON74s/dnTPwpNiss=;
        b=rSncP3mpc4hJ8UYDbDY3aBlLI+nPtJZ3DtxcfcH7R63NXbn42iFd2ZvDsrOkK9Y6+a
         Z0szbUk0Siw86BPdl+4FHCHXtxF/o8UBJJMEf0t1h2Zdxh8lHidnWVAdAbcQ4Jk1zTFN
         zMOQhaautKIsc7UfStlZWQ59iJRKEHAGbLaF773y2ryjZL2ulwzpwODbkfSpLdgDxqdy
         dWgSEtICIi1XyRmFla3eoJ4b3agSneejJQ0MhLiCNJl+bAuZaFD8oaCxpkyI6Cf0lY6Z
         XXW3l4j44ksCUxrKCygSDCu1D9eroU1H8mEl5fbGVG8BSR8q+M2i+3PnuDPG+VSDrljy
         qQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303442; x=1780908242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSRGQKpWCLbV+j0YDeovxMcfa4aON74s/dnTPwpNiss=;
        b=PxiEi5+wyb5lqImn32jP8PVmGYc6eU/pFUJFhmbwGoOmhChWSX/6/aaGhS02iyJ/jN
         mLEaCeX+lD3xvJ3U3rYYSD+syxmfKSCWAOw7TI8s5NElGewZxfjv949E8BS4OW0UhRVR
         q7t9/BBU8wDqOUsdpQinbAls3J1zzocVENV8aq3AD1fRYkRiI2KI3KGmCO90Bt9/DBtY
         I/U1tmhrSt/rQ0fUFQStIMcy9lntHcRkBflT5MmqWyfgn0bg2w70YJhw/kFu6qitKnIa
         69jdrR1UkjUv6Vcek/bbxEGueqVGhjTP5E+Tl8Q8+0QRsNUi5CVzsT/qIul0cmqzXF0Q
         jssQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Uip2bcDVo4800T1ZKrm6g2l3AED1Is8sJNy0465bdTrLSxS4jgvCSapMZjy8jrmiufCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/WvBpOETMx5O6F4NH5okykScykX30QRZjBmdCSj6dGha0LsL
	TYU7hMkAbaTK/O/M8veg8ARug8EiyWmjaU/eVNRQ2E8haKMO5VyplQ6C
X-Gm-Gg: Acq92OF4O9uC8I2C6BZr/EU8kntyTEEMEUHD4vKa3oOKjXmf7zIw02mbzx0Ujs5uCSW
	5btN/oz7aUO4ghPrpPw1i0UC3U5T4Gya+bqvCyRqY49b9snfm+gy9X+Vr5hmnSwe0bUpBrxrT49
	D2Zc2b+pIjLe4q2Wab+mxeg1EV1R//9E4yMNCfTlgfZ0tZDhzoikIKrn0dASjMyNCpi8gqH9F59
	2a2sxcUqpFnt8w+6FrlngrX1/PRlfOgpfF4e4/HvHqTf8JYZNACSr/h0uz0+0Ug21zV2zpl33Kx
	5ipt+FBoaRjL0s+tsjnmJSjnAGh03kjmY+S0NErihIeiwgd8bO1c1RgZCVKe3g/uP99UpYpLlJ3
	ELiVTZjRn9Yd8742uAEHxMuu/L+oqgKm5nIkfVdzKs3P3FIvY4jBysJIi4pmkWijgD01zqaYP1M
	s68eVVSaHz40UhevNMTvOMjZzvFhgLiewbzj18iaOY2EUR
X-Received: by 2002:a17:902:ea12:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2bf367aa3a1mr120210065ad.16.1780303442300;
        Mon, 01 Jun 2026 01:44:02 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm99949505ad.78.2026.06.01.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:44:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2 2/7] KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
Date: Mon,  1 Jun 2026 16:43:30 +0800
Message-ID: <20260601084336.2601675-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084336.2601675-1-inochiama@gmail.com>
References: <20260601084336.2601675-1-inochiama@gmail.com>
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
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8d6fdb5d38b8..d88edef77ccf 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -712,6 +712,9 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
 	case 3: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable)";
 	case 4: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags)";
 	case 5: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value)";
+	case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable)";
+	case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags)";
+	case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)";
 	}
 	return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */", reg_off);
 }
@@ -905,6 +908,9 @@ static __u64 sbi_fwft_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.enable),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.flags),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pointer_masking.value),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
 };
 
 static __u64 zicbom_regs[] = {
-- 
2.54.0

