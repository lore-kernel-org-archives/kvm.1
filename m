Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B529992B
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017274; cv=none; b=KLrLxbwADKBIpkLWyKBh4k9MF3z9k9eH110McATOr4cCwT4yJRCdoDqJLjsFcXOyvHPLr+tlk4zoc0imJtGVIGkppQG9dVLTDVH7zFy3yccSWySEDaB7I7ZzAxzmkynSXtGcayX0jqIsh0EOMCWJutDDZIEQUYYHRB98q3cyHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017274; c=relaxed/simple;
	bh=hquWfDfAFQGiIvCw6xQD75uAqUU9pzovahxNfUp3T9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZFQ9CgdmaQbhgVporCbT7719Gwq0LgPhrfqSWpGQjpQoFVD4bZhHZeINh/n6mF+RsamegGYLZ/AhmuqiuBmTvo7M+ll30jtWGLkhRBxsxzSG3SMnW2i/01BMaLDSt5PqcdLkNcc8RJtvWil+exYsCaHMh/4bbDDQqKQF6X0bDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxBWKQk6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxBWKQk6"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82ce49785a0so448278b3a.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017272; x=1775622072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7FDr2kDvu1n5fVDVKC3hI/+/zkjyMNWloUzLCrsbjE=;
        b=PxBWKQk6yNmdDVa9c8wag4eWxKL7lJvmbzzF4EhXe7tkQOVZ6NJWVHbRUFBMIH3PlG
         l5qSJLfpnR5TLyuvc7l8ZkRlzxrtBlCRuiwHXO/QSwwMr7D65hMkEBPeElxjRw7G3huG
         JpjwhPAzxKydCnTZcqMlyyvS+vKRw4dmBrJoBtkMLpNd4W4ConBJaAG1cFHp8yFAb/ko
         w8LN+VL+XuhBLNWzrt/x8m5fFdmWk3lY8Do5NIozqXLGHXKLkz/halWWHIhBloXmNFqC
         +Tcrf99mcp1gDFhEkoc9pcYWcF4c9xkzxBPdFDUlmm0W2lx40S17mRNuE5MfUEqD/J//
         2GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017272; x=1775622072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7FDr2kDvu1n5fVDVKC3hI/+/zkjyMNWloUzLCrsbjE=;
        b=NbpTXqSuqbLfjETvR7w3K5PSh9vbb5lcNryH88R8/WUaAVO2OEyAJkNTBqGtVNSkCh
         aX1bXTRxGvKPPzAS1UTU27piSNzhw1DQ3vGVZPp5uX3YXXoTekSj0cmMGJcGJVPdGTq/
         drjw1rqRMQKlqYFJrbAO3hsDcHcR/uTKDC98qhylHswugYTHcS2oSRwG5vpjxChSD20y
         Bym209HhPbrWr3n/g8f245IlNiQdnJmhGGEFN1rooYKdkXOPuZTiw6XMgLxGOHpPGuvB
         /73gKpQkhFP0jlzv6byh0NZ2YoW/YqF62VIWQLnyiGc+NkpskRbn1H/Z4uSDAmL7E8NF
         /WuA==
X-Gm-Message-State: AOJu0YzSUBDdBwsNS66f+3UZyJeCMUsrVW7dHDzMG1xbQdpoHQhpVTXC
	du0TRn6UOPX+dH4Bb133RvcyKM+oOoYmaiSRW920Pj641z2onMyDLS02zWLFc2a2Hxo2q72H
X-Gm-Gg: ATEYQzx9tdXKexuy2cSE7T7o2iwqbjn3J2LNecpOcQ7A3XXf+Zqj2w2UXM28Ozy4/Pf
	7+U4kOQJR5f+rhRW54fP47kPxbZw65LpaVnZto2KkypAf6na3k+gaI1+trXODSzXAG0p13+FQk5
	5/h44zThyleGy5+pxaBZeNLlmuEEdFm1HyXQfVQU+fQjGQT0qqPyQ+5DQi11rnWdcPwWjZUUmbb
	i1fxRN8Yyh5ebQj1yqMrWFxGUKoHxxcokInhBcwt5yfQp/Wv+8fbK06AeQeth6N6wBjtx8qUMJ9
	UNXC9CLpE5hA/upXxWo2qqgBlGTQTk3nrzhb0Ryx4UtdCxE6LzbLuYvgebD5TlbWsbnQ4nWOW5u
	HXZjfyTQhz53kzC8sNRzNIAdday3W4CKiTAUBkFiGLnSjyOWfUoCfmk6NhzSNkGzQcAjyhYorbU
	IINcy38Af9+Zi2CPx/v28bCrTZOqjgxfNVtiuGjsi8IKqENcBypfJmkKkEAx+0+l0C7w6LBg==
X-Received: by 2002:aa7:9e52:0:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-82ce9ccf6fcmr1300631b3a.9.1775017272293;
        Tue, 31 Mar 2026 21:21:12 -0700 (PDT)
Received: from tmp.QEZdWPZ5kd (n058152109154.netvigator.com. [58.152.109.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d019dsm14260354b3a.29.2026.03.31.21.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:21:11 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: ryan.roberts@arm.com,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	vince <liuwf0302@gmail.com>
Subject: [PATCH v3 3/3] arm64: Sync guest instruction patches for GDB breakpoints
Date: Wed,  1 Apr 2026 12:20:34 +0800
Message-Id: <20260401042034.755639-4-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401042034.755639-3-liuwf0302@gmail.com>
References: <177457996500.86179.14991222733583648054@gmail.com>
 <20260401042034.755639-1-liuwf0302@gmail.com>
 <20260401042034.755639-2-liuwf0302@gmail.com>
 <20260401042034.755639-3-liuwf0302@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 arm/aarch64/gdb.c |  8 ++++++++
 include/kvm/gdb.h | 10 ++++++++++
 x86/gdb.c         |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/arm/aarch64/gdb.c b/arm/aarch64/gdb.c
index cbe854b..7872686 100644
--- a/arm/aarch64/gdb.c
+++ b/arm/aarch64/gdb.c
@@ -203,6 +203,14 @@ size_t kvm_gdb__arch_reg_pkt_size(void)
 	return GDB_REGS_SIZE;
 }
 
+void kvm_gdb__arch_sync_guest_insn(void *host, size_t len)
+{
+	char *start = host;
+	char *end = start + len;
+
+	__builtin___clear_cache(start, end);
+}
+
 /* ------------------------------------------------------------------ */
 /* Helpers: which SP to expose as GDB register 31                     */
 /* ------------------------------------------------------------------ */
diff --git a/include/kvm/gdb.h b/include/kvm/gdb.h
index 623dad0..8e10cd7 100644
--- a/include/kvm/gdb.h
+++ b/include/kvm/gdb.h
@@ -90,6 +90,12 @@ size_t kvm_gdb__arch_reg_pkt_size(void);
 /* GDB signal number to report on stop (SIGTRAP=5) */
 int kvm_gdb__arch_signal(struct kvm_cpu *vcpu);
 
+/*
+ * Make a guest instruction patch visible to later instruction fetches.
+ * host points at the host virtual address backing the patched guest bytes.
+ */
+void kvm_gdb__arch_sync_guest_insn(void *host, size_t len);
+
 /*
  * Returns true if the KVM_EXIT_DEBUG exit was caused by a software
  * breakpoint (INT3 / #BP exception), as opposed to a hardware debug
@@ -133,6 +139,10 @@ static inline bool kvm_gdb__active(struct kvm *kvm)
 	return false;
 }
 
+static inline void kvm_gdb__arch_sync_guest_insn(void *host, size_t len)
+{
+}
+
 #endif
 
 #endif /* KVM__GDB_H */
diff --git a/x86/gdb.c b/x86/gdb.c
index f0fa941..91d8a5a 100644
--- a/x86/gdb.c
+++ b/x86/gdb.c
@@ -107,6 +107,10 @@ size_t kvm_gdb__arch_reg_pkt_size(void)
 	return GDB_REGS_SIZE;
 }
 
+void kvm_gdb__arch_sync_guest_insn(void *host, size_t len)
+{
+}
+
 /* ------------------------------------------------------------------ */
 /* Helpers: read/write KVM register structures                        */
 /* ------------------------------------------------------------------ */
-- 
2.34.1


