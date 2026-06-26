Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D23EB112
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466716; cv=none; b=HcX3Mau/NlAc7fnuZJTj0wCeRf5MpGwQM1cXPWupz9iWKJ00pFTqcqpj4U3MuOPvAbJDi1A3pRq8tKtu55Dzc/ltO6ZoMKzj4G5XQ5yrgnq1xnbzQZc2EgIoDdm6WLxXh521Z+bpAOMeIOCchc0xsMz1Lz1RBCZuqoosbVkrFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466716; c=relaxed/simple;
	bh=qQcMxL59ny4eUfn3dsIk5ayHiwXmBIItrmm62vfeWXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g80AlmVLZZKSCKD/UYn/BjN/NAQeE77vEJszny7zvk7oBGbBCVCUR581+OMAnf9MdoX0bnv3UsJTZVH8MyPlImxbmiiQas4jq8sAHm70Q0QQRK3wQBUVAk96Mig69CX9C287GnG3CfQ+4BC9BwoZkj/hUrFjCjr5reFaaFsQPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y3OL+ae/; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y3OL+ae/"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139b5e604b9so968230c88.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782466712; x=1783071512; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahOJU+va+iCo+TUhPo2SRXKP7ACC+q8Ka0Qw1HybGLs=;
        b=Y3OL+ae/wSfNVDOibORxnWYdl1wAJv/JtMgfKxS44Cw8dufvvDjwlbabrBdoOJfni5
         TNn9UP6cYqhNeXK16RXdErsFEldJ8JuAVm13/OrL886Natq0fTFl7WDtqsUzeDirYlnF
         6gJPgjoOChwA9H7K4Ldxcbo5muFZn6shX8OWQNJXcqWZ9/iecmLfa/xAfyuwUxus2JF3
         Y1yY+wrJp0a331KBo05Gq70whGdleZSI4kumlVvPg/sysNiSOjK0XvSTdbHd+8rHGyNo
         ZSkiLg4aOGkLoepU0RWFx13EMKMAEbGr64aOjoqqN/Cmw2Domo/WoGSMiJScDMY7OcIS
         cHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466712; x=1783071512;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahOJU+va+iCo+TUhPo2SRXKP7ACC+q8Ka0Qw1HybGLs=;
        b=HnePKOTsFYyLWSVHH+IMNCRrQvj2Sk0yQI3qDvgoCSxaK+CY7B4qJryCrQ8zg6tGBa
         8yK2TPjUik/jCzOAy5zdVWSxpfmnpznKI4UgYFdm1lHWgpJ0PzetY04Q1Lw39bm+p/k2
         s6r8hb5a+FOS2yDkKVDTNrUhjR+Wv7YGl3ggtV/zEKj2tTVJC4OGgyL4cQjkpOvcEAln
         rSeYshQpFeawXc7cTIIjObNpEH3ttv6nCfzcyqjCoLZLZfjfwcfqSqcgy1FC+ckK2tX/
         eoQdK64k6u1shUbDRiVYbaULRoHUW+ncXTCXfbcsV1KTN6U7dv2mCgB/BEHwPDOTEB4Z
         ElNg==
X-Forwarded-Encrypted: i=1; AFNElJ+pWwixM842iisRl0nuerN0pjrQq58H6uI8kWG7DD5sCaua37oN3CaepGHou1lAk3vpud0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUv+TPAJ6tMy9I1bufLEynSblJ1iXlBZSeZCk6tLkSbRv+Wc/
	G9176rAja/AYsDVwphLRMUtdrFthhVyeQFB9wTJrNGFeO+EoE+sYWJZlmy4GBAMHBqk=
X-Gm-Gg: AfdE7cmfqfjBqWeFE+hCIhdwfgdMbu1Orj/y/79sKCHzp0pR00CTvVUzDkPlBmAoBy1
	ovkD5hu/Rgkv6jlkuOONnalWrh89hZJkWw0zX+7ZeVfuacF6UM8o3+Jr8NzxSY4njUK/Mw+H4Bf
	yOW7J6t8OpwuTwyYVJJNndegJCuv6J0Bdd4L7Dmq3fJzlXpMzaozHlTsIOHPxWU4APGv4M8Cjqx
	8IuDjrJOWUlOWYGGmI7tWK08/z9byMEQY91fhDlFKFryD7V7GzLA4szfCJhcKqHbRdyUDdqI7i0
	IDtzOK2tEUmQb2Cv/LGpUwFm58AYcMCZGAtATWvKn/cGZGGZ9pIj9GsCV8ozXgTGVs86e0410da
	IilK9tIO/Qh2Cs+0lB3BEtGkpAmSpd4XRbCV+QrNO953ofJL8QUD/gbfRpXldjY+i/dEaYZ1INL
	4ng0EdJ9NWJXrP8zgYsX8jZX4sm4+Q3nQ4
X-Received: by 2002:a05:7023:b0b:b0:138:4e43:6399 with SMTP id a92af1059eb24-139dba390d3mr5179145c88.11.1782466712224;
        Fri, 26 Jun 2026 02:38:32 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e95c6sm24350302c88.11.2026.06.26.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:38:31 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v3 0/2] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
Date: Fri, 26 Jun 2026 02:38:28 -0700
Message-Id: <20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJRIPmoC/22Nyw6CMBQFf4V07TVtbaG48j+Mi1JupRoeaaHRE
 P5dihtJXE5yZs5MAnqHgZyzmXiMLri+W+F0yIhpdHdHcPXKhFOe05wLeMYWzDDB0EIpmGAaTS2
 tJqsweLTutcWuty+HqXqgGVMhLRoXxt6/t7fI0u5vODJgIDlVChkvtJSX4KyLeDR9S1I58l833
 7kcKIhCoUSralNWO3dZlg844nt+8wAAAA==
X-Change-ID: 20260624-kvm-cpu-pm-94141aecd5fa
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782466711; l=2360;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=qQcMxL59ny4eUfn3dsIk5ayHiwXmBIItrmm62vfeWXk=;
 b=H6mYJjzESG/VwDOEeC0xPHpknfIIgWTeSFPTCc1Gi3fXeoF8Wrsnb3Nn4WeRLb/Bx/h/OtRr5
 StJvFjBso9LBOaO9fENW9QWzk2esy0s1GJu+pf/V/7sp5bmpSGDIjrt
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

This series adds CPU_PM notifier support to save and restore hypervisor
CSR state when CPUs enter non-retention idle states where the CPU domain
is powered off.
Patch 1 fixes a VCPU cache invalidation bug that could cause incorrect
CSR restoration after power state transitions.

Patch 2 implements the CPU_PM notifier to handle CSR save/restore during
CPU idle, completing KVM's power management coverage alongside existing
CPU hotplug and system suspend mechanisms.

---
Changes in v3:
- Remove the error kvm_riscv_nacl_disable() call in kvm_riscv_csr_disable()
(sashiko)
- Unregister CPU PM notifier first in riscv_kvm_exit() (sashiko)
- Link to v2: https://patch.msgid.link/20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com

Changes in v2:
- Add patch 1 force restore VCPU after power state transitions (sashiko)
- Added CPU_PM_ENTER_FAILED event handling (sashiko)
- Optimized HGEIE save/restore with saved_value field (sashiko)
- Fixed HIE CSR restoration in lightweight idle resume path (sashiko)
- Link to v1: https://patch.msgid.link/20260624-kvm-cpu-pm-v1-1-52088e127a55@sifive.com

---

To: Anup Patel <anup@brainfault.org>
To: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Nutty Liu <nutty.liu@hotmail.com>
To: Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com
Cc: vincent.chen@sifive.com
Cc: zong.li@sifive.com
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Yong-Xuan Wang (2):
      KVM: RISC-V: Clear former VCPU cache on virtualization disable
      KVM: RISC-V: Add CPU PM notifier for non-retention idle states

 arch/riscv/include/asm/kvm_aia.h  |  15 +++-
 arch/riscv/include/asm/kvm_host.h |   2 +
 arch/riscv/kvm/aia.c              | 144 +++++++++++++++++++++-----------------
 arch/riscv/kvm/main.c             |  98 +++++++++++++++++++++-----
 arch/riscv/kvm/vcpu.c             |  11 +++
 5 files changed, 187 insertions(+), 83 deletions(-)
---
base-commit: 52738352a6f29279e15285fcb7b50241ef867e27
change-id: 20260624-kvm-cpu-pm-94141aecd5fa

