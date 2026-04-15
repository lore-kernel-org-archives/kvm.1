Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D9386564
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291027; cv=none; b=sAxwKCXjsGsRQW/Tv7F7fo80nZlxuBzFiofN8CCj0fo3wGubw2dNamuSsWChjfmTOP0MnL7L/ikP4U5vbwSBleFNsz50SN/QkpMeDJhiSXwoxSMtppfQRkfFRGe7Nm7ZKoq7z+mXmHUFotJ3IlrC3GAXvSW9sD78Hru/VsIVt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291027; c=relaxed/simple;
	bh=7ky9IOejzSPpcBRd5g6mNvHEyZcIQPVEk+KhFyMaA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4c8JJdNEMZRPHr2fozZ5vOtBbr9mfk22um7lMngfZCDi7hzA4iuxQ4wWwELaWMa1mAdAVlmj5dPovOL3wvxn+JaXacE5WiLA769khWyuYrMEypjorO4XzbgDlHQQaLd8RYuenyRf2iynVbNY4RaFUZJjCP1FdwJMAarFCli3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSVNGwuz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSVNGwuz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a29e6110so77701825e9.3
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291025; x=1776895825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu9AQw7MI1mCAjsGD/n0+Be2DCItWXbhRChOUsm24MI=;
        b=oSVNGwuzVrxYtp3+1pW3Azl1CTvvgXE9tMBBs4geG+cWmA40VKFjxXBjn08HHmJieS
         OwO237/JGsbUw7UbRedNhiib7y7c8Sz2MmwjOrIIvXErqNCZUujmmj9zOMjyMrfxaPGY
         oAk1ndztyQQSqBRr7bQVq9nSBIzsDMiRnluc7SEAY6H7Pn4zkXb2twXyvj34blO06VKc
         dGjixp3Lz35dSPjJHUS9414nN1n8yXDM8ovT2ZhFaTM7AbMBOR/iidOe1eWfME+E3VUP
         VcNSoKY0yKYB9IiZ6vHTiK73Lte08gc+zpgWIxzQfBNgiuhV9xXqA3a9mktHRQqvSl1l
         R7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291025; x=1776895825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu9AQw7MI1mCAjsGD/n0+Be2DCItWXbhRChOUsm24MI=;
        b=DQ8SulCLb0yfo+g6PPX8Wi4P9hULvqDTQ7nbZZ7TXTzmg0sKx2W0A0cGQZvnTRW9w7
         Dx4uHg8AC4kqzZj59+Ob+Qz0pGZIH7KxqMVn/oXK81CPHr5piQqYMy+eGuBSpHmGM64+
         SZL/AxBTzwP7PB//IAjwxwdu/NGejfhsOL2CbrNF2uUbRx9pVcYWXD0IVvL5f36lTA3d
         492J9GOrtyhHkxEfkFznqmwRLbVu8ixA7oDiPXpnhep+vHxvJyG6bz1ZUtCdbUHev0lK
         yrj/jUTtLF4JkX9CLpEem+L0GGHFxk0gwiMnJjgREvz4RMp6rAdXs96xbZceiOcNkbtO
         sz6w==
X-Forwarded-Encrypted: i=1; AFNElJ8xlbNAcOdSaEnpPKDPjQ50MMvujazAX8B3o4mdaH/aimv8kaM+zDRUpyuWOZtgGAtsFXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBFd2JCqHQUh0LnIK+Wd37EK1IdQx/XnPvyNOMDHVrOPE8QJP
	/KAl4RORkeFLM7QRayxQtJhgtPtXJyE0W4F+wDtNJ1NmdIBlXhEAThaF
X-Gm-Gg: AeBDieuLztkZ2K9Fl516SV1WIDhJPv5pxMSlbm85qe1WB9I4USjnDpyFJ4ywucMG9oj
	dYvOJ+MsBLg0U4pfDY8qJU+570m52W5r8Gt47CJxyVGu5O33nXbxpuLaWAMbf1O/cZ8E8zVwrKQ
	U3xm4FQd/kdsV8bUq+uloXzfzQ+mj229nR3TACw2frUQh4cOEOjneqBkC6UNmPN1umQxFyjBunz
	TIpwjGyOK8EI8P6HGFTY9dSZcifMYitmZi1ZuBV6Ww5gjxinB6y2C7IsMPVb7JeOp2bWqwkVEYH
	DopGW4WRhFKgMCBxhE+F4QVyv+KOgFvuIRW2bWOT3JQHbOdJF/cxIPTVdcUz1NZDK4OZlr9Wk5v
	eVRuX0rqSgFRK39tEOWJPlGH9QiDur5VkovCrkKB99nrejZRUvUJMcNbKH4BJ6iy5RQ6uV04xB2
	UmdbJcFhjlH67la5nFGv4TjZFybLFZZ/kkZMlLP5Q4RFKaV4G/Salmn7h+ENQ=
X-Received: by 2002:a05:600c:474c:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-488d68101edmr302262415e9.10.1776291024748;
        Wed, 15 Apr 2026 15:10:24 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d20f:daca:461:1a54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm2095695e9.5.2026.04.15.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:10:24 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [RFC PATCH] riscv: kvm: return SBI_ERR_FAILURE for PMU shmem OOM
Date: Thu, 16 Apr 2026 00:09:30 +0200
Message-ID: <20260415220930.287592-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_vcpu_pmu_snapshot_set_shmem() and kvm_riscv_vcpu_pmu_event_info()
returned -ENOMEM from the SBI extension handler, which caused 
kvm_riscv_vcpu_sbi_ecall() to abort KVM_RUN and surface the error to 
userspace instead of completing the ECALL with a negative SBI error in a0.
Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
handlers and kvm_sbi_ext_pmu_handler comment.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e873430e596b..f36b099f447c 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -435,8 +435,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	}
 
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
-	if (!kvpmu->sdata)
-		return -ENOMEM;
+	if (!kvpmu->sdata) {
+		sbiret = SBI_ERR_FAILURE;
+		goto out;
+	}
 
 	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
 	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
@@ -480,8 +482,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 	}
 
 	einfo = kzalloc(shmem_size, GFP_KERNEL);
-	if (!einfo)
-		return -ENOMEM;
+	if (!einfo) {
+		ret = SBI_ERR_FAILURE;
+		goto out;
+	}
 
 	ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
 	if (ret) {
-- 
2.43.0

