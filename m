Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D637D114
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850810; cv=none; b=LDLVOpJ8yfzl1ZbXsvKCzIbtG2u3z1FjM6dURX0mdY20z66ozaqUfegXcklCtstR/dosu3q7FdWtM011qXQw6m+GdYLCShVBL32M9v83K36oGv6+g2r/f3EKpgFdkvEJNqKQwYUBOuTfvUV3xaUaMs2NYnpDTm9ZF2xYNm64hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850810; c=relaxed/simple;
	bh=N/Nuta4V5z857ZHE4mPILfMr6wYoukzpqkZ7lz9QfXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ye1YF0Dv/G89g42RlKITUN3xRsWhFEsdHnVjugjX6u+dZHaWr9AO0GwU1VO+bzrZejIHVNwVHI8nVYzZPy/mGijNktxuNXd+PMeopuRZZCwY1kz1YyE4HhhAC+a+jekD0Da6D8QFPWbp6FzrESWIPo7DoL1gAX4m8seva49Bgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awFSKa2p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awFSKa2p"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1440006f8f.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850807; x=1776455607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ7qV7zH96OL2L71+arnff/3Q9xB19XbqUaejFBbdEI=;
        b=awFSKa2pzFl90U5R82iULxcYxw3dlwVxCQ/mAH1uLve4SnDPoVcKFtgwY3dqMm7BR6
         Os3lR236aQKSrce3cx1HIImALlrWVIG3EVlfGpms5/7w7HRqKMaGZvew1v4LWlJFkdH9
         +bOCCpjmfa29ReKBonSO6JMD+H1u5cG2dkC+m36ZOgck11+39qup24vGBQJaBYnEAASo
         aQ0drmitZ3IRT1HHbj1IwhsMy+bRUpR7cEhOi/mxxatNeDj15bVmJRgjSVlBTA+kfN1L
         Se6h5DZF5cp5pg9Yh0HGSb/pFLNDgJe/De+qpgrcuhxQEDvdfmE6SOqfsD6opntaeXEL
         Ku3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850807; x=1776455607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ7qV7zH96OL2L71+arnff/3Q9xB19XbqUaejFBbdEI=;
        b=Wh37MBXbYPQdutC609a5UrNmzG2ktAieaAO6/qTepJMP6YeEoZyo2HjynVa8ziKwVO
         eGnzUbrNjRqyeoMjSitcHnFJVrahcok6dmq65ig8aSK3Nrye5xQitLaB/bdoGjITYvn8
         f70DJnxbgzvowQtQdfHFH5sDT9rKKHs5PxseY3nQ1PrTb3fZs8Udk7zqU6P/cvwi5zs7
         Ig+dn95iR3DWaw0yHG1Gw7o3cu1QlgH8K4cR5JTH/uzpCtI63w0zPNxSSqYJtJfINUwi
         ejA+6YLnU4e3iIwPOa9sQChGrHsZBiD/iEAeac/521tXK2FmXlLtRVUIELsjeUzW5dsc
         B2zg==
X-Forwarded-Encrypted: i=1; AJvYcCVxjpeEe/A6uh8b4LxOUVCJorKZW6bIC0/K8LGvVqzPcfBlL0lGZ7Wps9tDwhwnff92hgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3yhLKPI7ry4Pp6ySJomrQeq7CPu3cJU965wGAT4E247hLo/U
	lyEse7Uk1dqjDEPNqtLhH/ikytItMMBxJMkQZmuQCTGw2E9Po8dkvXiCpwxOa04CA/E=
X-Gm-Gg: AeBDievNw3YlkCt+E5JyjhmkQcGY5MEtybgFPjE5TAYF7ipVrq+FNqqJTcKJHaPailq
	BuhdtIsUzyhHS29zxN8KKjyAcIb9UceMUBa6JNk+74UUff+mWcXTmYksxqrJwnVgs26iAP9rTMg
	0ele8MzdBgdUp7kDBI3xUTo1b1YpGoJAmTt6x91ax5T+P3xUS+obMHfGtoGLzkAiRtP1Ks+xrld
	oQKC51NSmP+h8moKrmdYFQLIddVAl2KPXQ+qNERJ7X7NVgqf1IHSk5+JqJpYED5eibXPeiS4qSm
	ai1ccMXGzKi/BfOvDCrDpSI8f05UhHVsYCVMjR7ATGkeeOibeIBnq5PhwT/prFmmwT+Po0kEYgd
	+JxaZii4lnqe5RtOpV5vDqb0SyT9W4Ib36Y6Oho1OSd46BpkjEOeorQ67YayJnkfTpkxR9dXEZf
	oyi4MOgv/rAb7omoFJMXpb+zQbg4yr5zJzCwn9XaO8u1MI8w/4H4bpRnoucICv4qwY2iuE9rgD
X-Received: by 2002:a05:6000:25c4:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-43d64271215mr6998283f8f.17.1775850805518;
        Fri, 10 Apr 2026 12:53:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm9883266f8f.24.2026.04.10.12.53.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:53:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/27] monitor: Remove need of per-target handlers
Date: Fri, 10 Apr 2026 21:52:54 +0200
Message-ID: <20260410195323.17937-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Changes needed for the single binary (and heterogeneous emulation).

Convert target_monitor_defs() and target_monitor_defs()
to SysemuCPUOps fields, adapting the 4 targets using these
'legacy' code.

Instead of filtering the commands per target / device at
build time, add a new field to HMPCommand to filter them
at runtime, allowing to compile the command array once.

Philippe Mathieu-Daudé (27):
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Remove target_long use in get_monitor_def()
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce SysemuCPUOps::monitor_defs hook
  target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/sparc: Replace target_monitor_defs ->
    SysemuCPUOps::monitor_defs
  monitor: Remove target_monitor_defs()
  cpus: Introduce SysemuCPUOps::monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in SysemuCPUOps
  monitor: Remove target_get_monitor_def()
  monitor/meson: Use SPICE with migration HMP commands
  stubs: Rename monitor* -> qmp* files
  monitor: Make 'info via' a generic command
  monitor: Make Xen emulation commands generic ones
  system: Expose 'arch_init.h' as 'qemu/target-arch-defs.h'
  monitor: Introduce HMPCommand::arch_bitmask field
  hw/s390x: Reduce 'monitor/monitor.h' inclusions
  monitor: Do not check TARGET_S390X to build s390x commands
  monitor: Do not check TARGET_I386 to build target/i386/ commands
  monitor: Do not check TARGET_I386 to build 'info sgx' command
  monitor: Do not check TARGET_I386 to build 'info sev' command
  monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
  monitor: Do not check multiple TARGET_* to build 'info tlb' command
  monitor: Merge hmp-target.c code within hmp-cmds.c

 MAINTAINERS                                   |  14 ++-
 include/hw/core/sysemu-cpu-ops.h              |  13 ++
 include/hw/s390x/storage-attributes.h         |   4 -
 include/hw/s390x/storage-keys.h               |   3 -
 include/monitor/hmp-target.h                  |  46 -------
 include/monitor/hmp.h                         |  21 ++++
 .../qemu/base-arch-defs.h                     |  10 +-
 include/qemu/typedefs.h                       |   1 +
 monitor/monitor-internal.h                    |   7 +-
 target/riscv/internals.h                      |   3 +
 hw/i386/kvm/xen-stubs.c                       |  12 ++
 hw/i386/sgx-hmp-stub.c                        |  16 +++
 hw/i386/sgx-stub.c                            |   6 -
 hw/i386/sgx.c                                 |   1 -
 hw/misc/mos6522-stub.c                        |  16 +++
 hw/pci/pci.c                                  |   2 +-
 hw/s390x/s390-skeys.c                         |   2 +
 hw/s390x/s390-stattrib.c                      |   2 +
 monitor/hmp-cmds.c                            |  41 ++++++-
 monitor/hmp-target.c                          | 115 ------------------
 monitor/hmp.c                                 |  53 +++++++-
 stubs/hmp-cmd-info_mem.c                      |  12 ++
 stubs/hmp-cmd-info_sev.c                      |  16 +++
 stubs/hmp-cmd-info_tlb.c                      |  12 ++
 stubs/hmp-cmds-hw-s390x.c                     |  15 +++
 stubs/hmp-cmds-target-i386.c                  |  13 ++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}    |   0
 ...or-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |   0
 .../{monitor-cpu-s390x.c => qmp-cpu-s390x.c}  |   0
 stubs/{monitor-cpu.c => qmp-cpu.c}            |   0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}  |   0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}  |   0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}  |   0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}  |   0
 stubs/target-get-monitor-def.c                |  29 -----
 stubs/target-monitor-defs.c                   |   7 --
 system/arch_init.c                            |   2 +-
 system/qdev-monitor.c                         |   2 +-
 system/vl.c                                   |   2 +-
 target/i386/cpu-apic.c                        |   1 -
 target/i386/cpu.c                             |  24 ++++
 target/i386/monitor.c                         |  26 ----
 target/i386/sev-system-stub.c                 |   6 -
 target/i386/sev.c                             |   1 -
 target/m68k/cpu.c                             |  18 +++
 target/m68k/monitor.c                         |  22 ----
 target/ppc/monitor.c                          |   2 -
 target/riscv/cpu.c                            |   1 +
 target/riscv/monitor.c                        |   5 +-
 target/sh4/monitor.c                          |   1 -
 target/sparc/cpu.c                            |  19 +++
 target/sparc/monitor.c                        |  19 ---
 target/xtensa/monitor.c                       |   1 -
 hmp-commands-info.hx                          |  26 ++--
 hmp-commands.hx                               |  13 +-
 hw/i386/meson.build                           |   1 +
 hw/misc/meson.build                           |   1 +
 migration/meson.build                         |   2 +-
 monitor/meson.build                           |   5 +-
 stubs/meson.build                             |  23 ++--
 60 files changed, 368 insertions(+), 347 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)
 create mode 100644 hw/i386/sgx-hmp-stub.c
 create mode 100644 hw/misc/mos6522-stub.c
 delete mode 100644 monitor/hmp-target.c
 create mode 100644 stubs/hmp-cmd-info_mem.c
 create mode 100644 stubs/hmp-cmd-info_sev.c
 create mode 100644 stubs/hmp-cmd-info_tlb.c
 create mode 100644 stubs/hmp-cmds-hw-s390x.c
 create mode 100644 stubs/hmp-cmds-target-i386.c
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
 delete mode 100644 stubs/target-get-monitor-def.c
 delete mode 100644 stubs/target-monitor-defs.c

-- 
2.53.0

