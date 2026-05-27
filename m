Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D926E706
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861182; cv=none; b=tjLIpj3KexnQ/D4x1wejQiZuqJU10o/de2Ys/2G9u/MxP6c3ewxi+2OO90M9Xk1Q4ZQ+jTCjmDwZ648t4rN9y7HRlFotSX1h/xp1ga86pemEIx8TR01eUJV99BDkosOA1rqoZEjKOxQ9pJxtEHKiFibH2F8Ym2tgi5OhW3WHfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861182; c=relaxed/simple;
	bh=XMtEi6pQMVKyTapHo789HRwMSCgn+nOLhMBYdeAM8y0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u3H/xUtjnKVF67+9j95hc5gn9KtzbS1iuCU9wxcNIG0BFVBxADReAas4j3Go7bQ+8Yms5P7Zc6atsKypYPijcAXsZfHTuS+nkgrkKNxguPlQs+deMtMoLGBEM/POqLYLetK06xM/RDtZP+UYEWXKk58cop1gasOF5sYRU7l9LnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VXAnVGsv; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VXAnVGsv"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3045c195251so4690171eec.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1779861180; x=1780465980; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mv8BPWe9vjiV7eG5zhSWNmlAlLaLwUax0FP44WMjBLo=;
        b=VXAnVGsvG8BUl0wEjzNSTEQRi6tNzlYVNIZEm3o/FF0/7j/O3+1p0C49KhZLkeQ2xr
         hkZ+J5GgRNpEO1nDj5I7pkJ/j8xWVpXYqiPbSBlkjAzdz7+5tMDZLXY+6FQU5VhD23oG
         0UCXA8sQ4tEgkAqfdjDELPU2kGLmFeij4EybLSyMKvHJNGic0JvnZENTEzURM4kIQiBl
         xOraXGFXdS3FG2gH+qtFWoAwtegKXGwy/TISXzbRtmlKY2fnUxwoKbyTJO6uuhuR+9uT
         k6aT1uENL3H8tftrsi0tR58FU9Je4Nd/xcn/zgvYafFvt2XffLns40DgOzJkzZmxx7QA
         tCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861180; x=1780465980;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv8BPWe9vjiV7eG5zhSWNmlAlLaLwUax0FP44WMjBLo=;
        b=ZOd3M+yhmsDu8iOHUeGDWWCCvm4F9iWYbyWaaEE06qq1+vzh/qm+sLHHW8G34LRvx6
         hzMJiFiMRzBvouNdu2Vy/00wlCth17psxPGdMXv1RFY1xEeNKAiEwl9JAsSXRPdZK2Go
         FXv3NpLNgSmCcbTjTlLrr2xHz+snwDx9ukExIH3WodZknG+MrHymr+/s5jK2g4uSZIFP
         r9tFO3NlhrAPdcy6bewOKEveU865LoCghnrqavEYNMC5GEKaba6Po679r+XsI0Ewj2dh
         0/NQIqvDYbMQpb4W5vBQB3NXVhNkLtoubwWvq/V3xvDlZLnGW4qkhPDnLQnjdhvePxlJ
         6kCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ycHMIzs+GxTF0Xy7QjY4v6ltMfWLRtBGp/AjxkGs6W9VXxbJBBnkxz4ZVGAMhNSVHtxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8Mz6PVFYnPfOqZYdkVNSRiTVKOnduCGrvNINdzLfHtiilazo
	IshgQfBG2o9DrArAOFcOcn6GAW4bNJ/9z1uhEDcp6oocFGlFZjdlTp3YW3nOOXjgENM=
X-Gm-Gg: Acq92OFCsI91jhsTuCYdmQfVrFn9lfyXWTmyTtwcYICsnAKpltflb7YDFCnL7XS6bxr
	Pc/F02WtBn5UIc21OLv/G/m/E2s+lveICvc4zig/iHFACytuVVeQQibCLRcB/mKn0nkZZO5MegO
	Rh9k3wa096oSevJtu8xwbW/3usjqWPC0bXf5gmFNxqACrKu/IDOgyPyGxJw92We7bTQvtIrLhZ4
	+7oLCEqPA2NJ4TwL+ATOpjmO/Y62r2pwrX1Ag2JKfW2Nz/8InG0NmOlfyFbrZG6LFr1VTaTigH1
	atUywgXkGizuemfnBtNP4KPHDVaqkFnSPCVAJ3waDs3+JevgFmAQoeNl3wjPyB+ful6UEZzOWJH
	sBiyiODoe5x0ZldHYYOnX6r+Pfwh9VqoIikCq+asoOPsKuCfFdGfeSNHPnvG6fo4JuhqpbPluFb
	YVQxVE7ruP4QN8tY2KsTHlArgDfSt9FyoQUiZ84GT7SzjRfikNeZWfyCndJszN2EoQ
X-Received: by 2002:a05:7300:ef82:b0:304:b93a:511a with SMTP id 5a478bee46e88-304b93a555emr669520eec.28.1779861180303;
        Tue, 26 May 2026 22:53:00 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304be0851c9sm613202eec.23.2026.05.26.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:52:59 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 0/3] KVM: riscv: add check_supported_reg() into
 get-reg-list test
Date: Tue, 26 May 2026 22:52:37 -0700
Message-Id: <20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKWGFmoC/yXM0QrCMAxA0V8ZeTYwIwvMXxEZs0u7TJ3S1CKM/
 bt1ezwP9y5gElUMztUCUbKavuYCOlTgxn4OgjoUA9XEdUOM9/zEIKmLErqHWsJM6Ft/4paPvWM
 HpXxH8frdrpfrbvvcJnHpv4J1/QGZJyUldwAAAA==
X-Change-ID: 20260526-kvm-get_reg_list-v2-f9f36961ac6c
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779861178; l=2226;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=XMtEi6pQMVKyTapHo789HRwMSCgn+nOLhMBYdeAM8y0=;
 b=q9jHCAP+KqxybvqnOUcDDbHtKLZ/DyBnHqPDhCTTTHt2gInjOqDb2P9hcABX5fwKgdtCTdq6y
 lOkHTWnkjR3D/UYR6VGzjLbXF8gXsDCK4xZKDIJx7fbtiqW5wHBuyAj
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

This series addresses a bug in the SBI FWFT (Firmware Features) extension
where features could remain exposed to guests after their dependent ISA
extensions are disabled at runtime, and improves the related selftest
infrastructure.

The bug (patch 1) occurred because FWFT feature support was cached at vCPU
initialization time. When userspace subsequently disabled ISA extensions
via KVM ONE_REG, the cached support status was not updated, leading to
stale feature exposure.

The selftest improvements (patches 2-3) enhance the get-reg-list test by
refactoring the extension sublist infrastructure and splitting FWFT
feature testing into separate, properly-gated sublists.

---
Changes in v2:
- Fix FWFT stale feature exposure by removing static 'supported' field
- Refactor get-reg-list test to use unified extension sublist macros
- Split FWFT testing into per-feature sublists with runtime checks
(Andrew)

To: Anup Patel <anup@brainfault.org>
To: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Clément Léger <cleger@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com
Cc: vincent.chen@sifive.com
Cc: zong.li@sifive.com
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Yong-Xuan Wang (3):
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublists

 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h       |   1 -
 arch/riscv/kvm/vcpu_sbi_fwft.c                   |  17 ++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 172 +++++++++++++++--------
 3 files changed, 119 insertions(+), 71 deletions(-)
---
base-commit: c7832534a8160276cccb9a8cc8cafb5614c579d0
change-id: 20260526-kvm-get_reg_list-v2-f9f36961ac6c

