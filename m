Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC8387374
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303465; cv=none; b=moOei9nS53vXnbFDXs9ZkJg3F+HT1KAxJbdL88uLPozRmUKw/OFcNuL/QfDSGJLjAqci3PLWLESaX89AeMfhTHJzsaTPC5f/a+sn1vVD8zdv1ulBnlFqIfBJQuVyuL+ZvHLAF6R7ZxalGIx3UJ0SVGOcwGK8GVtWqhg+L55GuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303465; c=relaxed/simple;
	bh=h8lwCwpBvsZAK2xSMui6cpZp1xkNbU+SVH73g8ceUx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb7ipwQq6FCrZXNC4Qvc4mOUhe2JcamkimwkmP+szEbYaIBS2l0v3hCau9NVfhtvuHWR3cHp9nohgoimY8pfxxUCp6BmNRJwQ9MhMyWl7UfIHGHQtlOoe5UvKBz3nl3Y4Oms40WYjAngKwOJ97lGBumThonk4wr4tr5+EYt85jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjbXNHuA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjbXNHuA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf30d530bdso24808275ad.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303458; x=1780908258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS2CUg/Sh/44DwNmonmJi8mUsAkNkldRmQVB8GPLmro=;
        b=bjbXNHuAP7LFkvBLGc5IqNXM2HTlbnHM8i1/WRKOpr5xEK3TPZ01Ul+H3NAUgR9LcM
         CHTYlzm6JOF8ACaPJNn+4/oAJFw5JwctRF4rOaO/54Nz1rqcwuyBbmyB49JPITpLrOq4
         NmDW6seldzadDFbVBXJUb/b/jOzodsDCN9l7D3wa5h4nY2sUcfi+0+DWXRSnTxGOsaZt
         xKzodV0nBgLqFkzDGc+1Mp6NLHvE+N2wa/ZEhzUosGf7Gt5WWCJpSa7aoAHQwzqsDyoO
         nYchj1BZlCZKe8reTOkb95FWqbgOTyq9JGXZaYQ6FAt+J/UK0isyazxgSMRWu9vfK0zG
         TXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303458; x=1780908258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fS2CUg/Sh/44DwNmonmJi8mUsAkNkldRmQVB8GPLmro=;
        b=JZcqbpwu0t3ibkDZjdZsao8kwXpSyulkFrKUOmRF+jkY98d3SruCCGmlc1QVV/Uqnq
         LFGc+aJWl9QSyx8Rd5j1ao90hU4RmM9UWyFVmtElNqZKNavtJ+BmD8vrPplv90DwEenN
         8DcltyaFY3pixZtDjCg+y4a9MvBWyC4LYbdRYKs6IC9shiZ137JA5CDyJwxdv1nO9tQK
         e2h+dzh3nvYukSoT+WozkQcsBKyXofOzf7W6j5gt9QB5nLK3nsExFh3X/XELGdDYZn7Y
         MKYvPE21cyVe3yQFrx39DCOXq/O4PV6l8e8EAefb03/2GizkvsNvf/DOMP2xiYSm4yJ1
         pfxA==
X-Forwarded-Encrypted: i=1; AFNElJ+QgT2fv4qPPxHh5AbkNeQsqdolG5IIlX1yicEf40b1/lKqyQaT0J/Pog22Sp+V6mheZtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3K9mmc4zLvWJ1749GrGI8fVxZgIgd/GzhcDfAJNKgFUFBOjG6
	Y2iqbR87aee+nxp5bQha7SYFg68i/GTMwCoA60j526rAnJTG64exOEtH
X-Gm-Gg: Acq92OGPAtOzOimZdyjNXqf4EbASXFe45NVmfu2qw6AZV3Hg3/mg0ECSNjEMvpMeLAj
	+Jq0/A2HF//UJDO+1/65XjmIHqmoHaCCaPqOBkDMHid5U6Huev2UgHqfeuidlswpDkLh1+t82er
	TkqsbfTQiVBY/h/gJNfPjemYJLNK6OzVfkTKEF2RSyKWFJKTM9gZ3ocasMlLmkJWoTVsag9jWV3
	t/31CvLCGhBmITbEIfNkeosvWpc4/va1xR+pmL22qlmO08R6+LqAsV6UTkTjpk0tHMhuqZFeyj+
	AQfqQSTgwT5y2TCdQkq/xFjSFIGVKXrlDdQkDhdmln4XkEzGf4u8S7+9q/gB2tIwlBEGoK18HAG
	edlOj/V604qfd/H51hW3AAX1lumt5AxOMN6MyGRNUEt9Hm7Wnce8Bd1MkXdPtSYk62PA4joqNOe
	zHuR+KKmRFWA4ZBDonjkMBo9dKwege/IQAGA==
X-Received: by 2002:a17:902:f70d:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2bf379b561cmr100522325ad.15.1780303458099;
        Mon, 01 Jun 2026 01:44:18 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3eb31sm92807725ad.75.2026.06.01.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:44:17 -0700 (PDT)
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
Subject: [PATCH v2 7/7] KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test
Date: Mon,  1 Jun 2026 16:43:35 +0800
Message-ID: <20260601084336.2601675-8-inochiama@gmail.com>
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

The KVM RISC-V allows Zicfiss/Zicfilp extensions for Guest/VM so
add these extensions to get-reg-list test.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index d88edef77ccf..4fab3d2d0b43 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -89,6 +89,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICCRSE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFILP:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICFISS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICSR:
@@ -552,6 +554,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZICBOP),
 		KVM_ISA_EXT_ARR(ZICBOZ),
 		KVM_ISA_EXT_ARR(ZICCRSE),
+		KVM_ISA_EXT_ARR(ZICFILP),
+		KVM_ISA_EXT_ARR(ZICFISS),
 		KVM_ISA_EXT_ARR(ZICNTR),
 		KVM_ISA_EXT_ARR(ZICOND),
 		KVM_ISA_EXT_ARR(ZICSR),
@@ -715,6 +719,12 @@ static const char *sbi_fwft_id_to_str(__u64 reg_off)
 	case 6: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable)";
 	case 7: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags)";
 	case 8: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value)";
+	case 9: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable)";
+	case 10: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags)";
+	case 11: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value)";
+	case 12: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable)";
+	case 13: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags)";
+	case 14: return "KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value)";
 	}
 	return strdup_printf("KVM_REG_RISCV_SBI_FWFT | %lld /* UNKNOWN */", reg_off);
 }
@@ -911,6 +921,12 @@ static __u64 sbi_fwft_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value),
 };
 
 static __u64 zicbom_regs[] = {
-- 
2.54.0

