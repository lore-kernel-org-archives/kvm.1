Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916661A682C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084187; cv=none; b=QCu9DlGEvQ7YAmbFNb0/2JOG39+xJ6X/0O/ZuIfaaCpDf6TQwIBOPLN9lbrWrI9PPnS9Woxq+CwTM615GqxuhDgRj7Ib6hZGIsZaZW4QEXAezlc42icfx0MP0c+fm7CaunXvIfNZNbgMOsLpRw1pMt06qRHhidwxEk1lpSNAeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084187; c=relaxed/simple;
	bh=RJwogXKZou9Bf/qKNoOg3SXcldHR/gx7WiRzYJSeM/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N37Jr42qjGQshz7U7dA4ImH57Z+Nhses3FH9XtA1Pwd44cckzYKXJKdECQZBS2cLqvHHW6Tz2rFHvYaEr5Vhufaem34730OMx5rf6AWsTCO7DduXB70N9o/hO+1SSaQxLoncoT/rcbADZ3p7CF5rPWTsIQGKSb6X4yaa7CY2T/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i6wMwFhu; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6wMwFhu"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-49041e84237so66762555e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084184; x=1780688984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgZBm14Uyju02XQkgmWQYMN4Aqeyrq3QWm64d0lF2pg=;
        b=i6wMwFhuusgwCQmuICxSb2yJBoEMjPWRv0pMcBiATgqYtaePSJ+ZtIMkQKIXhDPsnC
         7ntZTMtT62WvmfeZjFOKZ6d+5toRyX0o394dkbcTbfQ4v+rjSIzuMkQYnqJb4SBoUSuR
         +wN6rnsSPoz8MschtrINMWaG9yLcSNR9sVWKU8gq/9Oo57k7yLxTXKXbxz8+mj5Bbbyi
         Hhyl6DGNsnR4qdUY6t5N1NsB+13B31nYbzdQqUT6bTC4iXriuEq+f4bghebBTZr4XdzI
         3DzU0AEs7g+2HB8iWWf+pyInFzpkKhHIVs5n8IjUN6+f8baJEjsYKlsmb1ns2+uTjlMR
         Gvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084184; x=1780688984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgZBm14Uyju02XQkgmWQYMN4Aqeyrq3QWm64d0lF2pg=;
        b=U/Axg3wrV/2EV5zIhY6jKWS1IIM+q1E6/K+9uYYjzHqDWTFB8bD630L6WeeQHy46fy
         kEk6AFD+qY8ngRvliAE9eymTWqEvSrQIFw8LK3KpyHYVvpd1zVSimlFvrbPIkdt8BKFI
         /h3uRsujUHevSdF9ZIxLFQY/Vz6MvdWXD28wjxPpNxsSqwjG8VVEC39mCVScyjHbpPHM
         jJQ4+TiGvy7OLX+SFN9bp98GXwmbjtQ7QXGsUf/Cu4BF5JNm7oA8ROkdGQlFA/4kVp6P
         KhFMdQGK+8yB9EU7mUAOMIpnWq4eZaH3v7XTM39JxWorqmXPtfiEi/8yjZhZkpDOMPzO
         Ah0A==
X-Forwarded-Encrypted: i=1; AFNElJ8CLunwS+CGA0+gv/t2hFWcm1hx3orde2qLVxmaeAXIHo1pCNptQWdnLJWQFJzEWtQVdJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSiR7qFQFlCj8adAgMUfFWKccyO3ElUT6rvznuaVZARFUAGvz
	10zHN9LKxy8DM9kQK0NfI10dbjeEQPVaBzx1Bnyy+pR2s2iYUWiRjzYsWe0O0J/Z6TM=
X-Gm-Gg: Acq92OHmMfSOPZS3pFF2Y8BsGY+/bo9XYft/YHKf9/Uoq2J6WKF/SINATJ0hNpMmwby
	i36LU4o1W0Qqt0ZY4ZjJkz68rPLD4Cf61vbdrtxkJtD3ELfxDR/xYm9o1oBFFzA12L9+yBj2xhB
	UCMAC02pS5LASn2DNxIos0PvWK4ZtCdEY+3j7i/bJ2pOru5QGehQgPhpdaYtPq6vuBnq+ted03V
	orG0aKAaEmuChbFsKvJhYc1WtQK9Z3Koi21AIHiOOFk1ur2WVbXpQQR49jqNZExDq7PAOQDB+Yo
	78gzZPHRKlRdY6ht1a1wmBqcp4Kpa6kDpaj6aTZgHDMUKb9nqyAc+vJ2U3qKFxLXO3oMKb26AZ3
	S88lYhoJkFPGiqMpnZvE6FuSAyPQgekaJmPk4fG7NGJnyr8mo86kTW6sa5++IKAEgZbVVHWlGvs
	4sOLGfWmwbP+zNEW4L5LVzDGow+zjVGAwoZSJW0DFIlE+Grtmjg+AbCqJfBj1tQ4GuIQ==
X-Received: by 2002:a05:600c:64c8:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-490a2a1f07cmr10902485e9.5.1780084183971;
        Fri, 29 May 2026 12:49:43 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c103baesm20533745e9.17.2026.05.29.12.49.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:49:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/17] accel: Remove need for AccelCPUClass
Date: Fri, 29 May 2026 21:49:22 +0200
Message-ID: <20260529194940.97143-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Could get re-review: 4 & 5

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

$ git backport-diff since v1:

  [----] : patches are identical
  [####] : number of functional differences between upstream/downstream patch
  [down] : patch is downstream-only
  The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

  001/      17:[----] [--] 'target/loongarch: Remove unused 'accel/accel-cpu-target.h' header'
  002/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_class_init()'
  003/      17:[----] [--] 'accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()'
  004/      17:[----] [--] 'accel/hvf: Remove need for AccelCPUClass::cpu_realize'
  005/      17:[----] [--] 'accel/kvm: Remove need for AccelCPUClass::cpu_realize'
  006/      17:[----] [--] 'accel: Introduce AccelOpsClass::cpu_instance_init handler'
  007/      17:[----] [--] 'accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  008/      17:[0002] [FC] 'accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  009/      17:[0002] [FC] 'accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  010/      17:[0016] [FC] 'accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init'
  011/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init'
  012/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_instance_init()'
  013/      17:[----] [--] 'accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize'
  014/      17:[----] [--] 'accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize'
  015/      17:[----] [--] 'accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize'
  016/      17:[----] [--] 'accel: Remove AccelCPUClass::cpu_target_realize()'
  017/      17:[----] [--] 'accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h''

  diff --git a/include/system/kvm.h b/include/system/kvm.h
  index 2c31fa6019e..a249f076763 100644
  --- a/include/system/kvm.h
  +++ b/include/system/kvm.h
  @@ -225,0 +226,3 @@ void kvm_irqchip_change_notify(void);
  +void kvm_arch_cpu_instance_init(CPUState *cpu);
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
  +
  @@ -367,3 +369,0 @@ int kvm_arch_destroy_vcpu(CPUState *cpu);
  -void kvm_arch_cpu_instance_init(CPUState *cpu);
  -bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
  -
  diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
  index 113a23f2384..edad3c1acea 100644
  --- a/accel/kvm/kvm-accel-ops.c
  +++ b/accel/kvm/kvm-accel-ops.c
  @@ -101 +101 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
  -    ops->cpu_target_realize = kvm_arch_cpu_realize;
  +    ops->cpu_realize = kvm_arch_cpu_realize;
  diff --git a/target/arm/kvm.c b/target/arm/kvm.c
  index 7d194ea112b..0f1a98b430f 100644
  --- a/target/arm/kvm.c
  +++ b/target/arm/kvm.c
  @@ -1785,0 +1786,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}
  +
  diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
  index 5d74ca6fd56..536bcecd7d2 100644
  --- a/target/i386/hvf/hvf-cpu.c
  +++ b/target/i386/hvf/hvf-cpu.c
  @@ -58 +58 @@ static void hvf_cpu_xsave_init(void)
  -void hvf_arch_cpu_instance_init(CPUState *cpu)
  +void hvf_arch_cpu_instance_init(CPUState *cs)
  diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
  index 10ab7b2a4dc..2973e28122a 100644
  --- a/target/i386/nvmm/nvmm-all.c
  +++ b/target/i386/nvmm/nvmm-all.c
  @@ -1214 +1214 @@ static const TypeInfo nvmm_accel_type = {
  -void nvmm_arch_cpu_instance_init(CPUState *cpu)
  +void nvmm_arch_cpu_instance_init(CPUState *cs)
  diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
  index 9d844c4905a..167fdd515be 100644
  --- a/target/loongarch/kvm/kvm.c
  +++ b/target/loongarch/kvm/kvm.c
  @@ -1497,0 +1498,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}
  diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
  index 013f5e852e1..894962d509f 100644
  --- a/target/ppc/kvm.c
  +++ b/target/ppc/kvm.c
  @@ -2354,0 +2355,4 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
  index 2e4f435c537..46730e72a92 100644
  --- a/target/s390x/kvm/kvm.c
  +++ b/target/s390x/kvm/kvm.c
  @@ -2613,0 +2614,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
  +
  +void kvm_arch_cpu_instance_init(CPUState *cpu)
  +{
  +}
  +
  +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp)
  +{
  +    return true;
  +}

Philippe Mathieu-Daudé (17):
  target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
  accel: Remove AccelCPUClass::cpu_class_init()
  accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
  accel/hvf: Remove need for AccelCPUClass::cpu_realize
  accel/kvm: Remove need for AccelCPUClass::cpu_realize
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
 target/arm/kvm.c                  |  9 ++++
 target/arm/whpx/whpx-all.c        |  1 -
 target/i386/hvf/hvf-cpu.c         | 25 ++----------
 target/i386/hvf/hvf.c             |  5 ---
 target/i386/kvm/kvm-cpu.c         | 25 +-----------
 target/i386/nvmm/nvmm-accel-ops.c |  2 +
 target/i386/nvmm/nvmm-all.c       | 19 +--------
 target/i386/tcg/tcg-cpu.c         | 28 ++-----------
 target/i386/whpx/whpx-all.c       |  1 -
 target/loongarch/kvm/kvm.c        |  9 ++++
 target/loongarch/tcg/tcg_cpu.c    |  1 -
 target/ppc/kvm.c                  | 27 +++---------
 target/riscv/kvm/kvm-cpu.c        | 33 +--------------
 target/riscv/tcg/tcg-cpu.c        | 28 +++----------
 target/s390x/kvm/kvm.c            |  9 ++++
 31 files changed, 95 insertions(+), 305 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

-- 
2.53.0

