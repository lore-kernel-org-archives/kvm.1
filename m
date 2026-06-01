Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE538657A
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303453; cv=none; b=fPuF4Ql/0jX9FPzbSNldmj+hVyvfj6k7eDHSew46UxZdW/QgSBTinsJGTdSQtBgJAqX7Ji/eOzBh+tTBXkcYSB9QzKGwxtBsHS1jwwayfLQAG5LVBr3J5d7DhWkpCknbd0vnTzzTDO0NRsFZ2CJFsKz/sivecOdx1sroxzFXVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303453; c=relaxed/simple;
	bh=mkUN0v4wN8ccInklomw+u0PqoFI3IrpqBi/5VrkxjsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+zUgleoZpSVwEyZ71SxNQOXU1q1H50xjl5edfOM9qHx6a1MOWJXbHv0IasncIRdCO5H6jXaY1nj2O4V0lQx9/FDln4g03C2a7HQDNQLz56eCQPEHwsrH84F1B5ixvRpqvxcledI2Zmf+l7qtcahWmlyDPNbEZJtDpWFhiqCSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFXASw9V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFXASw9V"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf02708e8fso28697235ad.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303448; x=1780908248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmdSZ4nBLUBMfkWYeMqXhgmIblXvsbFhjdlvAKdM29c=;
        b=FFXASw9VfTj6IyEFGTjyGbRJ1H5Ac9jM4tm3YZeGAe65x61h5Jw0JpWsOIsY0KXnWe
         eCNJ6eGg8GFIqVBbCnAUvjRYWaYhrRMrAH2HpV6KIsFQiaw3RzJz8qQ9CC1EZzGkBSV+
         YCJ6t5Y/DIEal/ihropjnagPuFx3xvbpossdgD33763VoZpwlTb7TBAU7U22rnEosbYB
         hc8tQA3TiUe66GTfVXbP8119/4APPxrQrjnAM3kd1DCwBKe1Chre2E/32wBFSRk+USym
         V0mXqDgEluKFQgrfZPoNu8bHEBZLRkZBy0i2RJ8+5iXNgRTJsAED5ws4k4jUXAJ5fOHk
         eWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303448; x=1780908248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmdSZ4nBLUBMfkWYeMqXhgmIblXvsbFhjdlvAKdM29c=;
        b=jfpKr8tVVQ+29ZM/X7eeVKh6gKvMYCDtvf5Uv8aG8RRnpOqu36yhehGdhdTF7rcwgR
         I1hw6++swkNl1pFC30HkxLcWjAkgNbNu9dQUFk3ganOBbPlb4DaK6rc5CPpweMk2zR5i
         1HI4d8UYGaynImM9Lj5BcNZavH6r5BRjq13a2Ju7fgRwK+6rDWS7wGa4j8Jmu2XEPLox
         CMuHxMoOPZTGXSajB1rZMiUmj+oUP8TAOOkFlXztQvLGEpwpvmb/GoFdDbw+cV6bN1eH
         0yKDT6xZQfbnpS0vrhfZ1BR+n39nXiyeNfOxMde2gnaO1vJuB/hApaiUdFNn6NkDgv/V
         3Tgg==
X-Forwarded-Encrypted: i=1; AFNElJ8IXFQh+mNdYReQ27bjlwKlX2CRWMF/TLUkS1S/wuwq6jastJuf7+4P9xTZFAWVvrJQkY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyy9ykGQmB6Xs81d8DKV/YGXyk8TLEvRasQpEx0+bmEU8ZqW5u
	C5frRx/1fkJDfU6IzTNxwvCi1gWyfKfLV0PDCHe+GiRMgbiTIrlhMwtw
X-Gm-Gg: Acq92OES84Visx8SErKJIE33QLy6a+mkZeVgF2d8k/RwRdEpGdpdkCoikQ0ITPW8uTX
	PR79+EsXWUVStMFEV9F+ox8VP/yYfZjlVTv943pnTNglNq4Elw4LyrNRf6ojYv+gNecDHPBbuWv
	gKtoH/dytaYfYMNPQXWYxPLEm0ayWyGrsloRi7qmeaNhv/05QQyvxOXMc2quiXymttyruU5tYDf
	6h5xeeOaK6pEVxCZbmBoezoHWCFyEt6nuLlfI6dryypVyWnZYRNWdKFe/UNouQZH2Oqv8vWDLLM
	AsEu3jqVEBv3uDpH59m/Ps6Y00tDNlR8umEDKgkWRSNM/uqAfoTp8EfrB8IbUYkuwrZEYbfTxGI
	sbXFDIWbXfLSL63druemoQ+JoQqfYVNPL/cHPgc1yEZyn+kqJhQWZ6De3K3aQzp6vK1x6l/rTOA
	gd0Jn5GJjWjnNXA/ZdvK6jHZbcL4hB4ejwqA==
X-Received: by 2002:a17:903:3585:b0:2b0:b016:773f with SMTP id d9443c01a7336-2bf367c21a9mr124575685ad.11.1780303448528;
        Mon, 01 Jun 2026 01:44:08 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c43f0asm137898535ad.77.2026.06.01.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:44:08 -0700 (PDT)
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
Subject: [PATCH v2 4/7] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
Date: Mon,  1 Jun 2026 16:43:32 +0800
Message-ID: <20260601084336.2601675-5-inochiama@gmail.com>
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
index 501e4fc60dd2..9f9c5ababd1e 100644
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
2.54.0

