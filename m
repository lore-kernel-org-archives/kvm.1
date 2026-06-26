Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846178C9C
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462241; cv=none; b=FHXh2/zwqN0OK6HF53HRTryl4IWWEiaW+PUDpWeETubYvBP/fTRQvayKUG25weqZjaKG6tqL1y4EOvW5zTR7/oT//wOIzqARSlIOBRP18KGzt83kM0APOW+YOh2jP1mfDaNMIVpuP4+X+LrsYEa+eMdk2UvUhgZp3lISb4VRW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462241; c=relaxed/simple;
	bh=aOcN8mnYJvpUbDHzKnJv3eWv6lFjVcVGulc7fYXjqSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iS43GQWu8czD39+ou1eqbvakf523MNQDf4j1FRWrFD8AOoPwl3jvO3BSIO3P25sn3FJngXdbtboQni5EJYu4313zPmQjOPoseWKDLyiy72W2Y9LDH9qryBD53EvtuSnVMbaIHARn4TTPFSA3ODNxtFmjWN5M+2qWoNTMYXv8a2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VWJMkz79; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VWJMkz79"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13986d61b4eso2094291c88.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782462239; x=1783067039; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ccpgKTbVU35FcpL6ebiWIfE77fSWC1R9tsT9g07kXw=;
        b=VWJMkz79SShA1Q4sdMR6MqOavgdEzgbv6l4fEIucTBdbEgfnc6xeVow8jZ3JQQr8o3
         +ZhxTCtO2Hm0a3HH2ADYqXSJM1XH+hX2AkP17ILP2rh4J7yQlx1toSjGKPpyXaAFY39y
         k5hh9QjI1dxD2fu36zodHoV/QXpIqx/egg9KVDa6I0L9pzlCY0isvoCB0hUCYmWcYTv4
         cUAFuFgozgifO/kIa0QCAexYuXETjr39Z148yqIGgc4TO4LmwqfCULW4LCCKc4UUCmJA
         ffQrrDBNGTjYHCbTdUWBrwXoGuD7zC41ytubL9gP2+FMzd7hiaWqJFSJKDeuE0Bndvri
         tXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782462239; x=1783067039;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ccpgKTbVU35FcpL6ebiWIfE77fSWC1R9tsT9g07kXw=;
        b=jpCM3/Wh+sGoFY8TsPeVG6Qh1s9usEFzIRTLrdbnnyLd7zVcClj5Z2KazhsOs0fLRk
         0e4TkhiZE2aT2ncWwsf8/FzG+GPXgwg0Kt7g0hWXkTn7mqzoqI+XyyZsFAFv1iTdbbLv
         H2yffW9hC4BxArMxymTtx9ZaX7H61Sn81SPdL1EwpPLmII5JtZ8nqKMuOBK9vEshLaiU
         2S05lQvIFHgL7o87/+VTBZ+osPOsHJq7DjzN/XIxbW5kSZfcm5eeDd6LkhrGjjrpE07A
         6ydAXbU9HR5VXukbvCIg8odmUB/LxMuHdCkXPUW6MMDuPV+cSXq2DPzG7+GMPmnAZO4G
         eTmg==
X-Forwarded-Encrypted: i=1; AFNElJ/8d+Nfq2HFTirwDgg1YPxPtJ3LGOwZaP7CzoefBZOJ+BUhHcKbuzX/FI5TJfei/BfdRmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad7UKzQqvFzQ9TCYH0q2mObTT1OJDncvLSFMn6IEIzPsdOruF
	6C4SNQ4iq4ZnvKcHY/7kMzN6Pz/POBO/o26qG7G3Y477ZBo6mwdDtiG/enTgHgaaVyk=
X-Gm-Gg: AfdE7cmgN1whUhp6DT3+aeYMeoM+ZX3Oqm329822KE2b1GLduiSpphWKvxS6rMKzbAU
	AYQA/yBvOf8gCGfDeSfNapde0UITX4SqPa8vfSTQE7Qm38aeAaPSbwSVt1XP+BzlRRNW+aF6jOq
	lT2E0xr0Zf65tTEr4KX3skWtx+fMVsW7wv+dFst5gAuDLgFXGqniwvtqrFMaLiWF9P8QU0bZKB1
	dfgcxP4uMhKGozZKQ7K2PYaIU8iRgsBAMUCXH56B/KBDJcVGuZWu30DNAICx2MI7RATUlcWOJqN
	f/56moI5UmsT9faYXhnSueyQNnHR9JijRSJjVSKcexvK/5AN3LYZLzc5MvJQOVmmDQ6yii6GIDs
	iXAUxGvC87EoBujKLd9F3UumZZoEmP7O3ZNME3gCo/JnjTKH/oGkE0eOdnSDgqXSsn5UWxJSpEA
	DwCmut/kNNGHy9QAKS3Fj65ZTHvZuHgG67WDY3Ol0CS6w=
X-Received: by 2002:a05:7022:4597:b0:136:c565:e862 with SMTP id a92af1059eb24-139dbb529f0mr4508204c88.26.1782462238802;
        Fri, 26 Jun 2026 01:23:58 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318e7sm15557199c88.3.2026.06.26.01.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:23:58 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 0/2] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
Date: Fri, 26 Jun 2026 01:23:20 -0700
Message-Id: <20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPg2PmoC/22Nyw6CMBBFf4XM2jFtQxFd+R+GRS1TGQ2PtNBoC
 P9ui1uXJzn33BUCeaYAl2IFT5EDj0MCdSjAdmZ4EHKbGJRQlahUia/Yo50WnHo8l7KUhmyrnYE
 0mDw5fu+xW/PjsNyfZOdcyEbHYR79Z3+LMnt/w1GiRK1EXZNUJ6P1NbDjSEc79tBs2/YFdeOEK
 bcAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782462237; l=2099;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=aOcN8mnYJvpUbDHzKnJv3eWv6lFjVcVGulc7fYXjqSU=;
 b=giWvwAPg7EAWMUg2prEKaAltGBPuyswuvK1/Q0rWzme2xOkcN1QD/CpdhHYbwsyAYOxyuNWiG
 DcsF+dE2RumAj+v9AFM++BmT1nwPZnp8MWfxtu77AhMM5SrE3OOXSOs
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
 arch/riscv/kvm/main.c             | 100 +++++++++++++++++++++-----
 arch/riscv/kvm/vcpu.c             |  11 +++
 5 files changed, 189 insertions(+), 83 deletions(-)
---
base-commit: 52738352a6f29279e15285fcb7b50241ef867e27
change-id: 20260624-kvm-cpu-pm-94141aecd5fa

