Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1421A434
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904641; cv=none; b=p8K9glkOj3pRlBW8GhVHnI5H8oSPwM61pqqrwpQwNKaw0/7eDFyDyPmPavUCjeZIfrPIJWGmpk2aO/jxPnR54zI0lNCynrTRzHhZS/3iK0hHAjbR6WHFacQK929Wg+sHx2lt328kPS33VBlj/IuQfriQON5SaH+apFZr2IKp58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904641; c=relaxed/simple;
	bh=BtT0ls6YmM9d9nGGoTkQaPA0Kw5pw1Vw17vs5G6vw7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt9EWOUZv7EvMa3zcYmzrcSWCgCJUNDRWxrOzSGw5rea5SQ3e9Eh3Er6Uat+9QbzVxhQvwG9yUTTY3SiOCixA5CEtl4GqSgPseyaVWt2KbaPpGed4v5eMUtBkPz4bvE2sx6pzukmOrIeNoea+wLPIEluhitQtO8qvn5rBBiPBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ+SJFoC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ+SJFoC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso2415010a12.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904637; x=1784509437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=UZ+SJFoCP7d6Avl9rGmaPJ7E7wong/iaLX+vKvIUfaXE9Td28SM83f8Iq5IDPxmtMp
         JtF1nHbZvRoa/hnT70limYeT6TMTXpINmJcGJuMSv3X3ys31gORnZxydPCSiL3GI9wrR
         i3HuB19lFkbtt2zAtglWuR81VOmH8wgQsBV4ObkScZeYTgiygmVQ8HFTxGSI1lyzgzMx
         1VgsgNd0DCIy6VywpBCL/SB18mhH0xvL/yikqdhJRsyIHIfd9tOipEDk4xuro1WvYEH7
         lw+roRqe77HvCi25A5DxozP4tGYI4n2PgxnoGISXkMuLvOK9rnVc7sDS1ThEeMLYGkE0
         /ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904637; x=1784509437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=n9ljnvRKGnI4j/UXstfh5kAWONw6SaaluiNDrNAHDnkd/i4PABrecsonjN/6sRlrPD
         fBW4jjJqOrLAL6j7dIuosXra7slXDLYet9hNPEIpLBzAwrTvqsFNbFRUzqHYPGSkKhHd
         Xta9ReBZRfe+FxAbYya2PIlJeBA8u+fQwWqWIE9VcZmief7HnkVOGeSQlpFfbb/5Hf2M
         8eewj0qy050ztmDxJbl6HPbZkn691IdA4er1uGZ9EWtoQ60jqdFtHFAIK9gUiUJGcuzZ
         LvPs4sxwuI96XApNuvZ8Z7AhbpLvJSqqZsJJMu+YqzML2L8nKrb5WlBLeCddlXu9hr9p
         A00A==
X-Forwarded-Encrypted: i=1; AHgh+RqT+MyVOF4+qwu87VpwH43fF6W93TIyfqLxsitP3duN1OikPq588QarF+GUjiq/84wkhWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrqLcKmqy6Bk6HXaJkHvisjl3pg/GugKp7wUmKfJ6dy8rhymL
	DlGSJbN/Va2nrd1wRlJh/yJniLOvsMdZpWO06saLfCh44p/XKRCAPHvK
X-Gm-Gg: AfdE7cnUCoSCUZ7vIh53zxs5NvcbFbPHf0u7S/mfeedWUmcbFYzKXctxK22g7V3USwq
	QMvaSILW/pZ5/jnxujhZe8aDNKfdUSN9Gi+whnXToZDPKce5wfVjQ839p2g2fi3sOHviRR5BaXv
	fIhmnmf7qfMXZoJ8XW4J8W2ApGk94BK2/BcdP2AXHF789UcV4Mpj8qIgzx2gXLJI5gKyj+Lq4Rk
	EfsH8wCmlxS/9Xf+zGZra0GmEum/b2f4UHDzZjIE5X7kAIhoTrpoDKm1nUhdTU65ps754x/8+aS
	2stI8V1wmSIWJLj+ZVWSQQqzh/wNUKQNKc697pwLTp7rcwGU1PqJUE8Xn3PUb/ldyUf3GUJMCnV
	TucZCXr0waTqnO9VwvQkeFiBEr0Fgwpk1tjBpCRhSQ3SBEo6JKF+rv7H214YiwtXz0NCMMNNQ51
	wQqFP3TQuH3Rg=
X-Received: by 2002:a05:6a20:431c:b0:3c0:9acb:3fd with SMTP id adf61e73a8af0-3c112e0b020mr6533016637.34.1783904637089;
        Sun, 12 Jul 2026 18:03:57 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643cd6sm7790717a12.26.2026.07.12.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:03:56 -0700 (PDT)
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
Subject: [PATCH v6 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
Date: Mon, 13 Jul 2026 09:02:56 +0800
Message-ID: <20260713010302.303278-4-inochiama@gmail.com>
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

Extend the KVM ISA extension array to allow KVM userspace to
detect and enable Zicfiss/Zicfilp extensions for Guest/VM.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/isa.c              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 7bbea8812d92..a27de850fa4c 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCLSD,
 	KVM_RISCV_ISA_EXT_ZILSD,
 	KVM_RISCV_ISA_EXT_ZALASR,
+	KVM_RISCV_ISA_EXT_ZICFILP,
+	KVM_RISCV_ISA_EXT_ZICFISS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index 1132d909cc25..9852a91fdecc 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICBOP),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICCRSE),
+	KVM_ISA_EXT_ARR(ZICFILP),
+	KVM_ISA_EXT_ARR(ZICFISS),
 	KVM_ISA_EXT_ARR(ZICNTR),
 	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
-- 
2.55.0

