Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7A3537F8
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303437; cv=none; b=odvLR3SaRiZ9tHI42nBkg00FPQojpvuNYcnyxu78Yp7iGgR+7vd/Az0Ns8+VNdfSiaMjylnU2ipLZA9ZqAs7AHgB9aEjqZ2mbsitnWNIIbxWmKWQAS+ZJmpD8dCYvKHIVCQzHDl7P/TTwkrjoDCrfSXP4fa/qHXy1oOh2Xag5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303437; c=relaxed/simple;
	bh=TPYXcb7NTPeTtSBE0jbJJ3YqX1brvRp+y6VAFNMl9U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bx+kQtCBR6J/EHBlNueSLOiTxMG964SKamPJutWA65NHKMJGgdLc6j4wg2AGqbQYToH7mzNmJDNaPP+6gEEe2QqjIQZW9wee14aP4zw2iRSA6u1XkAOIIypDtdm9j3UX+wrOdNvgi+KMS44/SyAyobGh01lV+GqA4x1lHmD5YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz52vw4E; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz52vw4E"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso777852b3a.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780303435; x=1780908235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMOIBVqvBN09I3lKcw/r64Gz2Mu49nZfhySphfExOPY=;
        b=gz52vw4Et1TODApcj6xibkKpThz1OeokL5r6FOtEUg8NN0cNlwfzvi7DD558Vpc3rM
         RORYyx+5/7oxczcEPVkbxJyWIL2Asp9EWVvlOK4JpC8yJTTDy6gNQgKV62sOBbmplM1G
         OKwTsbg52YZt0STCLKmnMlbX9AutguDzw7Y/pF9in7z5exJxA9N8PlTZ/w9tUGmugIYM
         0IH/EjZDvc2L2Q0CM/iQNOllPQaq3mOTA5VBJ085Jl8jQTEEjA++h75CZagnG382cqkl
         BnpybAOU85BYm6ljI1d0j1oxOeXSOjsfO1W7LWI1vCl946rtXEyuhPdGfV6QLs0djAmj
         JU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303435; x=1780908235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMOIBVqvBN09I3lKcw/r64Gz2Mu49nZfhySphfExOPY=;
        b=GeJruGNbcI5/QcjZY3krhsVYbbWZg6EpZ8q91CM4xNr23n58iLBSzy1Dd+xoHs+PFk
         P+S0ipuZmnHh3FoTha9ke75S/gZ7vLwZfI8wKO2RPgne693+lzB4DKAJpAoAHsF0dEKQ
         7tu+7sdVNzfV0sfTWDZLp3xY3ONkGPyArflcWDeP7qD9Xiwk4T+ZH5e4O7WN/VHNmCx6
         5jNVSGIyZRtLv/bN5Y6D0gg/UZjRn6EykTOfAmV5tA4vOF/W/wSgG2/SiBpDaepSShIv
         Hp1OgAZCy/e9eIaIY0x7Y6JZxVH7CGMiKwyeIWMG+mRAZGtFmM2sZkg4sIwpSgRNE6sX
         LSMA==
X-Forwarded-Encrypted: i=1; AFNElJ/gPD29vR0AYGPnL39GWVy7roro46VehJ3hmsjd+v2QdqHjOXPtIvuN4ENI9cKzkYFjxII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnSjKRYrJLDNW2B0KISplIXq5QOY0d21e5m/b9Emct7Si8bB9
	6DjWyRbbFcCPc2Q4WgEB6bRpGVh1wicN7LZL3eqbKXaLbjKBxqem3d14
X-Gm-Gg: Acq92OG5SfLlVRULFmnauISly/LohN5vnfi9NC+2gWmrbSeWObmxZv/B5v8W3sxAecM
	SoMWdzln6f0ygsFyn7xxKiEK1TJcUxG2QEOrYjmeeVu9xEN0YT3SIFScKPXmmxqTARqwrphuLNx
	/CriUj/BnOh8vCRQ3iCggy65XxC+B9AaCyFPF3T2u/Ic80+/jLef4fMFkgYJpIZthP2fxtmQU5N
	qJD4qDSHsd14Q5ucHN417CiZvp+Io4c9ttwp6nCmKJdyZ2t51lw9RBlYECgho2ycyiKZXye80c/
	5wmXdNaiPtR9vysNAu9A1c96VVtdBPsTt9LHNUR67+UHi3iJT0VmCYZY4xp27wvrBV151KinmsN
	/DH/Qgq5Z8tNsoDXN8iN+x6iRhi8ZTc9enSqNmra62hba5CHcToy13Qzye393Jg2afsaTneIlzk
	dtfq9nOXFwSO2plbcmvbWD6yXlmG2wL0UvQw==
X-Received: by 2002:a05:6a00:b50:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-8423aee3251mr6260126b3a.23.1780303435411;
        Mon, 01 Jun 2026 01:43:55 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423828159esm5376710b3a.35.2026.06.01.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:43:54 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/7] RISC-V: KVM: Add Svadu/Zicfiss/Zicfilp FWFT support
Date: Mon,  1 Jun 2026 16:43:28 +0800
Message-ID: <20260601084336.2601675-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset based on the patchset "RISC-V: KVM: Add Zicfiss/Zicfilp
support".

The patch includes all the function of original patchset from Quan:
adding the Svadu/Zicfiss/Zicfilp FWFT for the RISC-V KVM. And this
patchset already passes the KVM unit test.

Changed from Quan's v1:
- https://lore.kernel.org/kvm/cover.1764509485.git.zhouquan@iscas.ac.cn/
1. rebase to the latest master.
2. Split Svadu change as separate patch
3. Fix all build error from the original series
4. Remove the Svadu check in kvm_riscv_vcpu_config_ran_once() and in
   favor of the FWFT.
5. Remove the LPE/SSE setting bit in kvm_riscv_vcpu_config_ran_once()
   (kvm_riscv_vcpu_setup_config() in original patchset)

Inochi Amaoto (7):
  RISC-V: KVM: Add support for Svadu FWFT features
  KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
  RISC-V: KVM: Only enable Svadu extension when Guest/VM requests
  RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
  RISC-V: KVM: Handle software-check exits for VCPU
  RISC-V: KVM: Add support for control-flow integrity FWFT features
  KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list
    test

 arch/riscv/include/asm/csr.h                  |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   5 +
 arch/riscv/kvm/isa.c                          |   2 +
 arch/riscv/kvm/vcpu_config.c                  |   8 +-
 arch/riscv/kvm/vcpu_exit.c                    |   3 +
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 142 ++++++++++++++++++
 .../selftests/kvm/riscv/get-reg-list.c        |  22 +++
 7 files changed, 179 insertions(+), 4 deletions(-)

--
2.54.0

