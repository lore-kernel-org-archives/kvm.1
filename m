Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C99C8CE
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904648; cv=none; b=X70DIFRIW0IiM9GOuLznAxpnuPjmOlCDlA8QndvHDwyPGqQBXEFeObCi7uTzGExccePfNTsSSFXjgThcTehcmFkk8W1Defrfz84n/QQFJ70dZRSoplj5fTk/PMKASR8PHf+XhtNnn+ZISF8QvuqC57M4GSOdbKVUZCc9tVjZ8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904648; c=relaxed/simple;
	bh=8W95h9pioucOk6mrrNHL0UllepTkkotEJTZXjD/sveQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI0OQ3feBoQd+Z3m57oqsrX72e0ZjGkAVaEFW8bDOHDSqn9QGhZO1dXOyraX2xdbESU5XjmPndJEpgWNFXGEtyPgoSL+6pJFNPEEsUhIQFjDvoH1EmJgJ/mytIfYQBWSHna2dvFnpmh+SJVAYUAjIaVLruwx7y1Xebro26LNUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD5I4P3r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD5I4P3r"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so23187185ad.1
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904642; x=1784509442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=kD5I4P3rh4PO2aZvQoKIa3PHRjDzWCA0wAJpLokbdZjmWpB8V3gOmYV17tNeMq2bpL
         mLxQSRArAKNeWPxygg4AvotBdRAM5iNwvpjho0krWmwc8oJHl46LbzzcYvspVS/hK8vf
         YaPbnvoU1iBCyc3XuZO/Z+MkZxj4QSYeo8H4k4RSU0urpvfF89EcbSCT8RA+uxn0J6JN
         ZmxX7zQgn/pH2787W1JqbRHdofeFrxvvIyK1amc8OMqCe2Hl4j2QD0ockYhYosXKGf9P
         1ZBiEO0De/evJdxNtL1p2TfGQQXFbcQ0H5ZrTqj7Diy1xSMis4EhAVdnp34R2FH3XDS+
         2xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904642; x=1784509442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rpV1zK6+w2gomPz2kgJsMZZImbuU17m/e3kCCv0XAXs=;
        b=mg6Naesno106u9MjODwdFVHvduojKT844786k89ZXzbV1aVxVxlFclpItFiSSB3bCA
         gAMfSHwznrRU8U0uSiG3Iw7fnjsd4qV29mloABg/9UaCx2vDH6un323fQ2Dk4Nn4+r78
         COAnXO1Rhy33VT/+qh3J40Pzi6x7mOYKDpsfU7oMAZ5+fBFJsqVkEof8k7QgBrMmQ0C+
         07f9YejGfCFWxjFpXQBd9I9JE25HTSTCvllJAv+Hzb0fznwQ49jUu1/IaUeeJXtHkh/Y
         lC3cTnevnbuS8zxvDLZBEnuwTn4DpJexO/vOXWyKHSRgeQBsBV2sNp2/8/aScFZd+0Bv
         ElRg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+dvPQTF25SPddc1TvPH3gOTzdxnD2PVSE/D1+S21y7nAwML4l/YIJ+9cdmFlE7imF7F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMG/s+XM0dGm4U0on5z//VR76XbUBLbsG/iCW2ZcJagdRMgST
	HG3CXXzE98ocrq8lO6YaftfZTore1T2xiyD9ZQ+HEFSeXUsgmcK9XtzD
X-Gm-Gg: AfdE7ckWcKjM3vFFoNEXLdqU5FqWTw7THqoajd8qShoV8XTBzq5HG6sTKMJTTqat56s
	SEKpK9Fby2WdJreYB/R0zcWKI3cQHLJxDU8zb0GrpgYFmos5a2BA7F1sVYbEtJxa8ndUqDDKtht
	jTnB/KQFElTeTjAa1wr0uUf7gvy8nDLmgsfaONACGGlaPchCsjnpZeKRNrkd2i5/qaoN9ZzXbRf
	Ej0qPJhFU1BY5QWgVu9txevaida2M5wMjvOXv3UMOG5DhwTTVgSAQk61L2MwcKQumjaREzKk+lP
	oR7F7H6sUf/t1pB9WOc1fGMzKajlAC+x7iZmsvXJnolUDch5ut2o8fqyp6JXSUxfQvuR+jCRMzm
	YJD2/rWSqde2cJFMekh4e23xkXd8/S7kj16NxCztZnGqNY2NXOfbJef1qFYHrZo6LWH+K4dz87+
	rsB42iwRXbNzk=
X-Received: by 2002:a17:902:e806:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2ce9eac58f9mr71900625ad.17.1783904642652;
        Sun, 12 Jul 2026 18:04:02 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb746sm89165375ad.7.2026.07.12.18.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:04:02 -0700 (PDT)
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
Subject: [PATCH v6 5/8] RISC-V: KVM: Handle software-check exits for VCPU
Date: Mon, 13 Jul 2026 09:02:58 +0800
Message-ID: <20260713010302.303278-6-inochiama@gmail.com>
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

The extension Zicfiss/Zicfilp introduces a software-check exception
to the privilege architecture. Delegate this exception to VS mode
when vCPU enable Zicfiss/Zicfilp so the CFI violations in VU/VS could
be reported.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/csr.h | 1 +
 arch/riscv/kvm/vcpu_exit.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..224af9facf1f 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -117,6 +117,7 @@
 #define EXC_INST_PAGE_FAULT	12
 #define EXC_LOAD_PAGE_FAULT	13
 #define EXC_STORE_PAGE_FAULT	15
+#define EXC_SOFTWARE_CHECK		18
 #define EXC_INST_GUEST_PAGE_FAULT	20
 #define EXC_LOAD_GUEST_PAGE_FAULT	21
 #define EXC_VIRTUAL_INST_FAULT		22
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 0bb0c51e3c89..12eebeabdf14 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -243,6 +243,10 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		run->exit_reason = KVM_EXIT_DEBUG;
 		ret = 0;
 		break;
+	case EXC_SOFTWARE_CHECK:
+		if (vcpu->arch.cfg.henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
+			ret = vcpu_redirect(vcpu, trap);
+		break;
 	default:
 		break;
 	}
-- 
2.55.0

