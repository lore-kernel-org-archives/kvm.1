Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5D3EB809
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064681; cv=none; b=g/gqkYD745qgVRZssHD4UemOhFL/BpcNwsewhdlAMkCE5xKzDr7WbX1l8YOte5ldcuNlvbiXPn3f3NDwdYn0hT5D0DWuR/QR5cmCQEQlob8Dj6CbqxluwjUR3Nt2aLHUqiL9p1EH5ZdtNQA83jXCtH6ZlmMy0L2DImFU5sHsey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064681; c=relaxed/simple;
	bh=6e2mTkw8hRVLjkZ8i6OWtKK91FBJJ8zp2H11e4tDv/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDGsWz9VGBWkBrIKr1/pDAaVxzly4yqRicRmPFAnpMVPGTOlII/73ycUjQJ12tXf7nMOBdxkF1OI6Kw4qHwiH+ZU8XzSMMXIWHC3hhsA16RkVpTN3cTCxucFzb9VIlrCSDm9cu/2ydVG0AMSS/yAF2MioGIvZ+2fILEV2RVRchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkj1PBHl; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkj1PBHl"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eea4c0649so1504963f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064678; x=1780669478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5EfljsoPq7fD23spfbA2Get1/4U0Oy4zAkIoz/po5c=;
        b=vkj1PBHl1UxmfGP2RUVBfTJjecKtDEYNOj3dcV9leoir3euPBhliK6H/8PlkbBBD1E
         GWm6frtMWmcCOyjHL0fnHklsVN/Qate9XiWZUFSZpbdOHV6Ji2WB4tUNU43g2VOuWwEN
         EO9+zaV1hshr++zgELnBagzEq1fn79MeQyEnB/zJvC6T+DvMOJTZawv7maD9gMnnyAlI
         Wm56MhdBuNegH9z7QTxmBrUzk3tWG6oYhc+Cz6V8Ecjo1JVRt6BCCjFwzRJj4KI9PNcq
         rpjyBEFfp071GQmzGQH/Rv8Hbz6J5Z+4dQCi7RWzJeF6SbbAIdRz0uu7pRf/Oa+sMb9t
         vetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064678; x=1780669478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5EfljsoPq7fD23spfbA2Get1/4U0Oy4zAkIoz/po5c=;
        b=QcLCWZBUXwVU5U+mVPOe/QZupmEZFTfdgj5gT4yJc9mS2lUI4fx98JZQ2IgJuYAL43
         i+iIgI08ITDZBta6M/WLc0s/G2FBztLHQMCk5GmBvFTeyvbKBhYtnLImgMrDCtTrxgdv
         6wNA/l8Xcv4GHrqtuXbudayJ8isBZ6Z+0vaiu5Vhv+zaEakslQFsK/XVXQiGS9qe7Fud
         gOadUw5teIctAiKHCUeKSb5SCAxha33TNr/QqYYXMG5EFE44UFqxVvR9lKfJuZdNL5PF
         Fe9wk1tLsAys5aupt7swEAMsJyHPrRqzezufQ+3AWWF7TKyNFRPdpMiwLLi0aT4gjtKy
         lyhw==
X-Forwarded-Encrypted: i=1; AFNElJ98IxhRuYF80m3yEBqayAZH2FFWu0eTHOOmg/scpvBE5tG2DcWRs7voMO0Qi42D/Vf4IZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/QR+5zAeQzt2K9mokdFqyRLwYpjWO1sg42ciF0ncsCHNC59e
	ITPFYB5wsMt9xMkIS5Lw4wWyaVQf0CK0xMXO24g1Ugwwg3mk+JQbN5WUaNjs5N6aNww=
X-Gm-Gg: Acq92OHH/9zb3xB2+zbMUbge15ON//9ri1gbkIl84uh72Fo2u996fLQRI0pSowOTXij
	aowLtXmCutSlHUqiBlKDL4rxTszaf/P7Xeg4051TahrhQFC2Pms8v1pBkvCwuHQXCDEadMAnghx
	MygfQmOFNEDRmRRaSBXf4sDEvS+msZvdkpeWdg3y4P+3bNDnaeuoc6OSoc1P9xnecRSY716Q7RO
	TXNCCDw8IKpbg9DorlP3jRVrkrXkVXSQAi2owhNZGArWW5LJZOMEyi7PsQmm6hcLu1RKsYoMKxp
	LEWBlsd9Kp7XvegJY+Eu7T0GfNkt7MAC6cHCpIiLf435JKXjY22VZZ4VL82EqfmV0ZrlMPd/IP8
	LmQ9ILzu5Z3llt7W70s3YBtheTYphsuMDf+FCkkOeehZyZL4XUc/1LlY0411wkt0nA6vGzyXibg
	86hF3n8SQBpaIZnMZwqRDfgNzrCyXGcm91FQcYbkZu55H4yoXF5ZVx2Hn9mT11XqwN1w==
X-Received: by 2002:a5d:4242:0:b0:45e:f381:cd8a with SMTP id ffacd0b85a97d-45ef6af03cdmr62323f8f.2.1780064677660;
        Fri, 29 May 2026 07:24:37 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a03f8sm4275856f8f.7.2026.05.29.07.24.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:24:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/17] accel: Remove need for AccelCPUClass
Date: Fri, 29 May 2026 16:24:16 +0200
Message-ID: <20260529142434.87880-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move cpu_init/realize hooks from AccelCPUClass to
AccelOpsClass. Specialize them for TCG in TCGCPUOps.

This drastically simplifies the need of per-binary QOM
types per accelerator per target (see also the nice
diff-stat).

Based-on: tag single-binary-20260528

Ignoring checkpatch.pl:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    accel/accel-target.c
    include/accel/accel-cpu-target.h
    include/accel/accel-cpu.h

Philippe Mathieu-Daudé (17):
  target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
  accel: Remove AccelCPUClass::cpu_class_init()
  accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
  accel/hvf: Remove need for AccelCPUClass::cpu_target_realize
  accel/kvm: Remove need for AccelCPUClass::cpu_target_realize
  accel: Introduce AccelOpsClass::cpu_instance_init handler
  accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
  accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
  accel: Remove AccelCPUClass::cpu_instance_init()
  accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
  accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
  accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
  accel: Remove AccelCPUClass::cpu_target_realize()
  accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'

 accel/tcg/tcg-accel-ops.h         |  1 +
 include/accel/accel-cpu-ops.h     |  3 +-
 include/accel/accel-cpu-target.h  | 31 --------------
 include/accel/accel-cpu.h         | 23 -----------
 include/accel/tcg/cpu-ops.h       |  2 +
 include/system/hvf_int.h          |  1 +
 include/system/kvm.h              |  3 ++
 target/i386/nvmm/nvmm-accel-ops.h |  2 +
 accel/accel-common.c              | 68 ++++---------------------------
 accel/hvf/hvf-accel-ops.c         |  3 +-
 accel/kvm/kvm-accel-ops.c         |  2 +
 accel/tcg/cpu-exec.c              | 15 ++++++-
 accel/tcg/tcg-accel-ops.c         |  1 +
 accel/whpx/whpx-accel-ops.c       |  2 +
 accel/whpx/whpx-common.c          | 17 --------
 target/arm/hvf/hvf.c              |  4 ++
 target/arm/whpx/whpx-all.c        |  1 -
 target/i386/hvf/hvf-cpu.c         | 25 ++----------
 target/i386/hvf/hvf.c             |  5 ---
 target/i386/kvm/kvm-cpu.c         | 25 +-----------
 target/i386/nvmm/nvmm-accel-ops.c |  2 +
 target/i386/nvmm/nvmm-all.c       | 19 +--------
 target/i386/tcg/tcg-cpu.c         | 28 ++-----------
 target/i386/whpx/whpx-all.c       |  1 -
 target/loongarch/tcg/tcg_cpu.c    |  1 -
 target/ppc/kvm.c                  | 23 +----------
 target/riscv/kvm/kvm-cpu.c        | 33 +--------------
 target/riscv/tcg/tcg-cpu.c        | 28 +++----------
 28 files changed, 64 insertions(+), 305 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

-- 
2.53.0

