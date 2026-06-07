Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E02980A8
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819880; cv=none; b=ET4+6Z8dWMWM/FKTtoZyGdr1M1sC1zMjKZKizowhqVL2Zc5ZeusWtJqFWZKTOVyGuyQhKn0Vdjn3AVc1F6NirhbOJaH6NUOw3kpqpJm7NAPUhh4UHRngH9rSPw0fj+NSS+boIpDRyt2G9g65aICKR/h57F0mlo/wWykm2aDsy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819880; c=relaxed/simple;
	bh=mNSSHCC+VNLg5dfwXNVIWWtEdjjLYD1hruSKZs7mCA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyMwiBJhafjGLi7ogCZ3YL/S5YUptKCFV40rDVFoOv5CZBpshMeK4H24Kdv+yaNMkBqIcoWmPuk4I9f00ypClXy++E5yJGR+D7ARBVI2bGtFc337LF8tCba2esaZ1ZH2sFlV9mUibIT14i/8KQPqlNzrxiUJ7gf1XGD02RcYyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTAIsMni; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTAIsMni"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3315c5dso35760175ad.3
        for <kvm@vger.kernel.org>; Sun, 07 Jun 2026 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780819877; x=1781424677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EX0GhOhaSuN6IFI88OLaSPa41+0yBYDClmtrszme7Pc=;
        b=PTAIsMni3Wl+/U1ETXRZIEdCvMd1CSYF6FW+NcTQWrXn2Jyak6PX0oM6jhdIWP0jp/
         O/NxLWvSskBUj+2cEk2WcvfDVC5Jy7OnTrLNy27ClMkhPqHHHtHWe50ER/eb62kK4con
         kaf1yW5E6QXl9jS4Hd09yAkorA7OwEiQUr1h4QbK3yfVPHb0vGe5kwnZ7yc3ICRojSV2
         EJeCRL03t3SnEcIUWc0LPClg8BulLyRMO6TwfNg7z5z8e3+oHPi5KgKyu4rynisS/UIL
         J4k/kZYrQ75WSbMbu6Mw1LQYUwNYyCvnytmKsEEZYcaIVM9Klfgp6HFVtfZVfTWehusJ
         BiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780819877; x=1781424677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX0GhOhaSuN6IFI88OLaSPa41+0yBYDClmtrszme7Pc=;
        b=XKICPNtU2lJnEHGg6ykf3InPxOzF2rv1Cz0ZtbyP7fkZ4JsutBj2NLFBNKL2Nis0wG
         B+GVUmVr/qFKJ9d6KzyM9JbXxZF/CxfmXHHmJuuYEJsNYwUTrv1eEEpOKGkhWPibMSOC
         VRjuNomwaE3b2Fih8oMECeGHdDoaH0Cc3OAquYspdyA5Ow7QGzFgjqe72jztTy6/5KZU
         KsT/VwBgBN7jH5n7HpQ+FK1J/JVg+lvYZE22Q2Z76pe9ogiwlMaOnNBuvkbKtFJaFiJg
         iBIGQLP1dbIjK+YIKIbaKCxaG5ykzLrdAtJ2JzGy/K1u4No96Wq03w4ut760tBntkUEQ
         hKwg==
X-Forwarded-Encrypted: i=1; AFNElJ8usKSXvy8H4I36Tpod+OUco4JtsaLnPrSHHo/KYWaP/ljl7ufOGACBLfZvdX00ZH/4ebo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDL1pRUcYilHCR49Q3EeKZ67azbU5yE0tnT8gK/o1JJGDZnwDr
	44uM5Jzp/sRC3XIL+7cF8oJqVZfbe9t7OXzw95fxk1j2sM5Z5vuAVJlZ
X-Gm-Gg: Acq92OGFEUOfeaY7BAD9tudeRSb9+M6B1Ti1I/MZnwEMRzfLcYB0ZPL5gx1A5bHCTod
	8FovOW6H0UBS585bmWunUL/gtsN8Mt0nbin+wZNuYarWvcBdmiE0uurc+kTUEjuNeoHEx3WLkVd
	SdJPpGLgnJT/a2mk4NhPsRFPCdM9iz6DbZct4RjxRAYYvHHwkAPzvrwVzdMyE4usILZ1nFyW0uB
	7FpOjwrpyWvSvqteFnPVO4cXnSlHt/EUpbaVpmI7cPUty9tpq//yqGwc/cx3XeV9BNYyObXpHqN
	9/O4AoHrpq4zSVBIwP94sEKqOfu03MLr+s8onsEByJ8hBi5/TEvr8y2q75k2NruXdw8/vnOWIU7
	v3bja57u9+ITqCed6I3EHJMKZLXq9fMmntrDFz0nqmMjUzD7MShBBfngICAXwuOfyLsKd3N3iYB
	k4smAcp8jQSNNRcgVOQQELUale8e3HXg4hAQ==
X-Received: by 2002:a17:903:1252:b0:2bd:eeb6:ff28 with SMTP id d9443c01a7336-2c1e820dae7mr117272165ad.12.1780819877063;
        Sun, 07 Jun 2026 01:11:17 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm146385915ad.3.2026.06.07.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:11:16 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/8] RISC-V: KVM: Add Svadu/Zicfiss/Zicfilp FWFT support
Date: Sun,  7 Jun 2026 16:10:56 +0800
Message-ID: <20260607081105.993908-1-inochiama@gmail.com>
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

Follow the patchset (Which is queued for v7.2)
https://lore.kernel.org/kvm/20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com/

Test with the patch applied
https://lore.kernel.org/all/20260522142358.87589-1-cuiyunhui@bytedance.com

Changed from v2:
- https://lore.kernel.org/kvm/20260601084336.2601675-1-inochiama@gmail.com/
1. rebase with Yong-Xuan's patch set
2. Add SSP CSR context switch/set/get
3. Move the software-check exception set/unset into FWFT
4. Only delegate software-check exception when Zicfiss/Zicfilp is enabled.
5. Make KVM SBI_FWFT_PTE_AD_HW_UPDATING depends on both Svadu and Svade
   enabled.

Changed from Quan's v1:
- https://lore.kernel.org/kvm/cover.1764509485.git.zhouquan@iscas.ac.cn/
1. rebase to the latest master.
2. Split Svadu change as separate patch
3. Fix all build error from the original series
4. Remove the Svadu check in kvm_riscv_vcpu_config_ran_once() and in
   favor of the FWFT.
5. Remove the LPE/SSE setting bit in kvm_riscv_vcpu_config_ran_once()
   (kvm_riscv_vcpu_setup_config() in original patchset)

Inochi Amaoto (8):
  RISC-V: KVM: Add support for Svadu FWFT features
  KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list test
  RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
  RISC-V: KVM: Add ssp context save/restore
  RISC-V: KVM: Handle software-check exits for VCPU
  RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is
    enabled.
  RISC-V: KVM: Add support for control-flow integrity FWFT features
  KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list
    test

 arch/riscv/include/asm/csr.h                  |   1 +
 arch/riscv/include/asm/kvm_host.h             |   7 +
 arch/riscv/include/uapi/asm/kvm.h             |  13 ++
 arch/riscv/kvm/isa.c                          |   2 +
 arch/riscv/kvm/vcpu.c                         |   6 +
 arch/riscv/kvm/vcpu_exit.c                    |  10 +
 arch/riscv/kvm/vcpu_onereg.c                  |  66 ++++++-
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 182 ++++++++++++++++++
 .../selftests/kvm/riscv/get-reg-list.c        |  88 +++++++++
 9 files changed, 373 insertions(+), 2 deletions(-)

--
2.54.0

