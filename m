Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CC3644C9
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871702; cv=none; b=qkSSZuufHJMANMqs7oc0Bi2K/9DVkijTXmS6ftmhMzQPDW0Yy/j0ju2eZwVgI2Lw5jpLlQkQ3EoaR7Dcwa5/gmevbh7rKwqCr50wv8yHLmOd6n7ZdQcTDKg8e3Y0uxVwhkcNQkoIuM1VQe9TtxFTuSAzsEVZ6oJqCpRfkew+gTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871702; c=relaxed/simple;
	bh=jKX7yCJzLXTBm7/RoRGPTwNXXmYDIrIjrn7OXhM9jJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV6QV/v3qWGYjRcowkQBUxi/iuvE8Cwq9ee35FnxtEcM11yuHbyRNmqWWVg8HN9WAczhy5YVWOLSugdMPC9ULQgmTDc4B59UFkOxdvsFGlihK22CGSnjevQ5Yw+Q7CnDhtwNyEz5DuiTRnJoBej1RdUneQoZk1KkrtXxUB0bnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsCrXe3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsCrXe3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso74365a91.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871700; x=1783476500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=iIsCrXe3VnO3v4l0dxWS8me0huAeTpkN0yis0L7smQJfK/hpHppmy/nw4Vsr6USv8L
         GCF1cV30rovv90VhDRP5lintAprqoX3EL+2UANC3is4KL5rWyY+jxBH68MIgrnZavpFD
         QKopcUf2KZzJvzy4IvR0ppm5f6zZn/pmm7+6n3PhlNAQ9KDxkIyRwKKN7o4l9CQTjEb3
         Njjqxw3cYvgHx2/8p1WjAdNyXMO95LIRU42H8RfaK1vpyNtS6UEPIT7u5Eft6Y83twle
         eraphhNJ5D7iAjVDxVWAPdCfxTyH9jQY0en97NmWTRU6pWTy35kIEoVRheG9MHt+Ph1u
         5K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871700; x=1783476500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MI4l7nifRnfxUSWJkRHmALVeDUyVcPjbpLqiu+zme2g=;
        b=XnxKPPQUjM+YSLvEAz1Gj3ydn9UnooXS9gPkIGlxjonztEHemzjGApHBkZP8KGM/kc
         TVvj1lwEvOTfd7vAu2RgrJWxTj3gyyDZ+1zD8NPHt9eAH+M3DHzVgbZ8DVQRjvp4Xs/Z
         IEIrDSHl/mmQWe5f+sTNfvvhdNzd4zU6blTIgao/MylJdhEENTeYgNTXv7HuxK9G1Yv6
         158FtH/55Zuwbs8Sx0uctwdmqSR+z48HEBLONOp+xyQHVO9kBqCQc08tq06sBnW8B9Ly
         OEInY3J7jePnduy79aLT0IXFdC1owBeAJjnUc0bJTtI5TMBC2HhZxAK6xSLddJHkHLiB
         Hnzg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy9zJaWjrnXH7S6K/INwxhVLnpyYveFt9Z18Kvhu066+k41nGWRAVhZBH4WR3xZePUs98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrHC+Rwv/8c1n0p/Auvg0nrta1aj6CWu+q47CUrFFSrQ8C3A8
	qDTvy7e5qlKEw0i6gBgcnpolXIG35v2KNmM5aKwxbdv+Ui8rU7bZI+VFzBd8N8cd
X-Gm-Gg: AfdE7ckX6bgL4JzYO4xhuKIffbOI+cUbi4pZjMrthspRqDf6jkBmGlqDFHi4YwUdfET
	bzKrPmesg4DI95lp6rREDLHmtUcTbp4HVmjw+wModNR0xtNRODUCz7TArtJbsZr6/howk9Ke1eS
	mbNLDf/tNiMEhpkefY1wbgDtY5nWsA8lxlRnPRpyp8FF3n7GxdEdQOv56cVynmyieszf4r3CtEj
	RjEnNkYGWYzKyyKyNFn5jeXzO0KaGSrohp/fW0VCELp5CEIOUxe1aU3adR9QYhzkIZGdnseiwbC
	XDt7tMlrhlNP4DCiqUQBNcyy3bLQEJtg/RzMjqYwNKlI4f7/qk511ugc88nPFRmSvwa0r+XBiTZ
	KLEqud3tINeG2f0dn3o8xWJfzBY1/1F9NN1w7Vls272Z8VIN1PyNoPDPCdhWenNdawJza5cjdRm
	ie/hb1UpEJ92M=
X-Received: by 2002:a17:90b:5204:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3808bd62c54mr2410952a91.8.1782871700388;
        Tue, 30 Jun 2026 19:08:20 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809645185dsm801518a91.15.2026.06.30.19.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:19 -0700 (PDT)
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
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v4 2/8] KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
Date: Wed,  1 Jul 2026 10:07:39 +0800
Message-ID: <20260701020746.170157-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701020746.170157-1-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
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

