Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183FC8CE
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904636; cv=none; b=JsOavE0nPqW5cE7q9inocrbIuP2HxzmCqWDwx+yFVgnKyLrcRPzRtoqtL9Lw+llVNs5i8R8s+MzZLE6LzP7vRGMm9QbjiZbskfZSi8e/27i/YCyQsAndQcf1YhJr91bZLNXxImNqM+spOaA0S4AWmtzHhg4WUjHP1Jh+gwzOpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904636; c=relaxed/simple;
	bh=jKX7yCJzLXTBm7/RoRGPTwNXXmYDIrIjrn7OXhM9jJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upl2DbAsiMTuONLk3J0bW1LZUaOvrqAmobUluyJCIDNH+59G4YBuyKbW7qzo0Gpfbm8TNBPyW26v+HXU8gVKcwdrOVtWXPtO639ZzTVrsxmB1e9feMBwqgiDG4ZYoy36aVIIQfueCUY2KadoT60gG82RhgtcMVnmQpz2vnmAB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8xM5z2e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8xM5z2e"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc73e322dbso27486515ad.1
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904634; x=1784509434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=Z8xM5z2el85KExbg2nd2ZXUOuGVt9dtLL+uub/EEgQ3U/bge92iNKmKh/eMNmN3EO8
         nV6E0bixZZUYhICn5DeJ65RHLwh2GlF2ZpbZgMsxnueCr8Wez4acScnjgbANWmS1TJyU
         zwuRy95S42ufRymLRdiBJQy/idVt4xw5otYOWB+8yhb0n8+fW2bNi4XI76aFKd+zIIYV
         c+TP9OzzwdFVEszAJJDB3cm45N2vDo34ycU3rmWjV3+lER/gDF6Pr+xSuaKNXD7onXA0
         Pwlki9zXqrzRKX1Pg9Fwfxgwb24qRsLNxgACqzCHcU/YwycrA223TUxYDi67aIy2oZji
         4KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904634; x=1784509434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=kaKHd8pa7Hv/ZqbXkN6UWnECC/17ReuBh/A+rO9J4bFdmViTNP0IevlPpy0Rv+LLet
         DPP4MsYD6c2PBSZlR6iKjkojBW+G6q7MziVPDr/ghNZKED+aPaORm2UuGFT+tHQ4VoWG
         tSZB1QOQh96ngZH7+q7WTPJOrSMYfjQtxgVFUMFm6dVgEf4lyJY6laDgyFN9rjKWqQgu
         rB+hRJRyKkes1u3m/Zb21fXNU/EbjOxPJGX5KPOxYiihaGAMZUyJMOgx7HgDF9mU+cZ6
         jzuJ0Kh9oUbUhfuDTt8ZBBeMmtuv8XG6bSw1SXQob5NheIQ2+dsKsAF+9rJdGTyHM5Fj
         OAxA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4K/B3tOhrZx5r8YZCuTpAJKKVM+0vK0gLx6Qi81OX5/LmT8juxOiuaoBrxXq63yvw3+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+YxzMoDFIT2Z1YymnO1ugs3dU9enIOjjiPXLcRpB/T91rYQU
	M7nG7Hwx1uxfB+OzzwkYFcjK94YxUgPBgZ9R+lOHSCPfdfpcuEtYYTRi
X-Gm-Gg: AfdE7cnnrAWpEksxw8gOoMYxLIygFAhj2OeywnvnkU+PGMpEoDiVdt138XGNyAx8WCs
	SwJacoGnFDfH7tO2HviSoMmP1DTmEyHOyswkgp2ECP03RnZJVFZ0zOfyjK8jM1YeNwM3ns0wzvQ
	hubDNpTEXbiqXqWpybYqSXVbdc49ydd29sZ4nQc+W0djBNMMWLuvIBh7g5TfH1pKCVIUhNifEvD
	yQA7VEy4lEebJXlQIzLOdi9YhBZnwTFK0g8HU5k4CTLV/HBgZxy51z9wPOV3ilq2VRLhPng5NNb
	661FQMvXEXlYHg8l/F4bvJ67HiWNey/XLgAk56ctQStmqayxHpKeAVIV5DSbnuvx9PRKPldVkmY
	cy9WBgquL0j4puh3FsXFDl0dv4gjoJaUiYx+WYgjC6a3OzyJEGlR9NEdTZhK42vzkNDUQP37tqn
	vCPkcsbIfTdzk=
X-Received: by 2002:a17:902:d546:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2ce9eac212bmr74630405ad.17.1783904634295;
        Sun, 12 Jul 2026 18:03:54 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm89409935ad.19.2026.07.12.18.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:03:54 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v6 2/8] KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
Date: Mon, 13 Jul 2026 09:02:55 +0800
Message-ID: <20260713010302.303278-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713010302.303278-1-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
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

