Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC730CDBC
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699528; cv=none; b=BU7wpGvcdpJXs0g2DWVsDh0HpOuePUv57xI5j3oe82ZhNZ3WMDbxKmM1aP75W3Z2gs3J03ZY4INWZMqn/XQN6dOa/HIDc/TJ5TzeyfyWtKn2bNFGwWimTWwEzs3EMz0MBO+pZdTbdXO6URNJ0B+z9FdtAmkD43wqDyoGjkoaO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699528; c=relaxed/simple;
	bh=E8ESqQTJHQds29ywYe98l3PNnwPah/MYc1or4uViX2U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J5ezPiRvMfKfgkW83nJE38sTXkQue7eX01bVkhLmw07ZikHhQMkJMxnKkOUkEen+CK1tAFN9OsNZetfW7ai3rHJG0HaUyP4jtqKmTgqUihS4q3so4sEAfV3uT/0ZkWjzPXwio9JOEVXJVoCXrpmwz8lcD7Q6cmHicDm4pRIwdr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lLhTyTbQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLhTyTbQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-caf707e3a70so3616570a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784699526; x=1785304326; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0UoHHKoOPl3ZY84JSAlc+YP4ytsZ7MKt8w4OspWuvXQ=;
        b=lLhTyTbQ3GIeKR32L9o3McqapvjbIpitopJ5k2C7MraS9pgro45MLcI/NXdLecxJM0
         ae+nb2+VtaZDNpcX0vroPZkX2c881VBcBL6sJrmSOJoYNFioFuXYcpd3nYmcGiknZj0j
         MtAk/kJYasjsIgKpg/4SY0QTFvyUF9bw1JiiuLz2cRRqcBwSpXTj6DDe+if+XRcCvMtT
         a9OeTSbxw/nVPvpy+rShiVeA6VL/EbqFaA0os/say5/Ei9NTDHdbWqbIhi3pUJInzi6/
         Jy9rKC5ImRjpLje1tRhkpEQn2ncoFQdt2i7sIM4/WiiF2aTkPFoHcW+yxOiwcwNf9crl
         cWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699526; x=1785304326;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0UoHHKoOPl3ZY84JSAlc+YP4ytsZ7MKt8w4OspWuvXQ=;
        b=aaROv9m4+3OdOxyoFbyOwOTpeQui1n0ZWBI4WgQJJjzMp+aFeFgb6hU3TphTZ8P8jD
         xZCxlkFcyuhDePjcy9omKO9oa0eFN0Vaf27eq6mZZcpmHopFwqtyL1mCTOG1j4UPcjVa
         jR6SA/NSDt9kfia7WBTg9ELYKg4lpHGVCgvnLFagZ8BxRiddkY3x0/K0JlUxHwwQr92v
         uo9aEI5JiZ+N9cKh/xBk9JN62NqJ0wHHHz9SUjj+eqEdb8tL0gsNa/P6xg65U2NOJeQj
         ggcyDdih6iJoF2TXHqguoVhPv78xsHlHQ0XYPs8yLDLzkWCCSOPHQW5YR3MvPX8HBICY
         9Vvg==
X-Forwarded-Encrypted: i=1; AHgh+RrUC7BDzawLYXIiwfyt1p6UtCRsjzjHhh0dlOudHeaN3cT+AiQfqYEn4K/pkyoN32FtYJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYfj8Eo1KBJLbSZIvlLU1oLik/VgW5i+PzfJ2E+sAtz69FScXv
	Rr57ajqeRap6ZOilk5lP82Oyo3CYQAXg/jvGP2QbwAykC7R1O6PF/3adwTiYsC4wAFY=
X-Gm-Gg: AR+sD111cdKvNn9WehUzIAw2RZHWcuNL5gCwTquTYAA1czmTskf9G6/HPc5+iDfoIk0
	HXs+83J2S0+nIdvtrIkMLwIQkTVps10fUh6YPgk3rZj8aZYe8It6t8hZ4fw/E+gNouGHz6Jq6bu
	IaS19xW6yZMchiGPLRSeE9BYIKVzVUMeioxflxeNu3Ed8Jw01tfF3AUKmjdLqg6fGKnbFInvT8c
	d3RcJw3JcwoXibUgxKFEkNh1suC5KnyjqWoGu98xn3RTk2lCtW4t0LC9C2s2Uw9b6r1foGrRCUD
	ZYsBZPQmxbEFoLWydA++l0B7t9kkHKznqztiKpJjBWtL7A4XalydE25ThTh5seh+TgjiNnCdk8r
	0HqbYpPFAfxtdt+TeKFx2LNXG35ia9qSIpj/DQ+qesLb+Il/pYiupyurpBR9VQx5V5Ju/wtB6Ju
	m0WckPNgAVjxBS/4DGLtEy9w==
X-Received: by 2002:a05:6a20:ce4b:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c42921dfadmr2765901637.2.1784699526235;
        Tue, 21 Jul 2026 22:52:06 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081985sm5133138eec.23.2026.07.21.22.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:52:05 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v4 0/2] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
Date: Tue, 21 Jul 2026 22:52:01 -0700
Message-Id: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIFaYGoC/3XNTQ6CMBCG4auQrh3TlhbBlfcwLtoylWr4SQuNh
 nB3ATcSdfkl87wzkoDeYSDHZCQeowuubeYhdgkxlWquCK6cN+GUZzTjAu6xBtMN0NVQCCaYQlN
 Kq8gMOo/WPdbY+fLeYdA3NP1SWC4qF/rWP9dvkS13P8ORAQPJaZ4j4wcl5Sk46yLuTVuTpRz5p
 802lgMFcchRos1LU+gvm/636Ww1UsmUslhotbHTNL0AMbxDpC8BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699525; l=2510;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=E8ESqQTJHQds29ywYe98l3PNnwPah/MYc1or4uViX2U=;
 b=/5y2v7B+7bTyOPu2zSHbzaY5YFy8gy6seqqoYgbD5kzYDcC9ez988VYREXyaW+hQ5ijlBUPj5
 7KOT25te1zxAUrVtf1zaP7UgrWbXX0fbTE4P76YZwoYZrrcdCn2Ri8C
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
Changes in v4:
- Remove the system_state checking (sashiko)
- Link to v3: https://patch.msgid.link/20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com

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
 arch/riscv/kvm/main.c             |  89 ++++++++++++++++++-----
 arch/riscv/kvm/vcpu.c             |  11 +++
 5 files changed, 178 insertions(+), 83 deletions(-)
---
base-commit: 52738352a6f29279e15285fcb7b50241ef867e27
change-id: 20260624-kvm-cpu-pm-94141aecd5fa

