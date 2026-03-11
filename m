Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C72F39AB
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271122; cv=none; b=WV+FKrbgD0o2/z3R62fBYYUU0maKuLQO/R9I/ujmtMgVSdR5KV0Wddpj5WYFNFqdD5acSCXYaG8I/FodMRiAFNdHtNjlqczIj1nfieJ/dOc3x9VOsqrswb5j663ORt+pAvjAmklG7OVWmsIf1ZWm9/5KmXec3o7RBD85QKhmN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271122; c=relaxed/simple;
	bh=T8TEJyz8kcyblPtbhT0zewCP5AyJ5vZtAEr4d0wvJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gM6pUgdQ7SxNcp3Nv85Bhq7h/l7TW9TFPvZge2eBbTJu3XU+1floz140l9m8ninAGmSJQNTK6me+A0yM9ViTgc3VWtCWH2U4sn3MZ7YyDhMyP1iH5ar2fjlzJ6nQ81u0UMpvE8G3b4QHf+DARgJEo0jrp132shyn1Qoweo3Bc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAEhbn7T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAEhbn7T"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso3041895e9.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271120; x=1773875920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/PJeovjjoGLMcedyN4Hvdo++XuOQtv9Fm+hj7Ucl68=;
        b=AAEhbn7TzdFD2838XSY4jblB3aOu5Cp8ru6iQRfK5Lj1o/biUFUuwIVLmc9BSAIEUr
         X92ALtXmZODUvotL89tCSm0cWBahJxwVnyB6LH2xU/kklGlw3gYY+wDEzZF3ckjA41mE
         SNzMAqo78klOrk0VdQ/VUrKVGHMrw5aQdlOCzBFlG0WkxKgsUOFigky7M9BLiGPHPLC3
         7nwnT3Dm2JtZbNt1qgl/KOgypzEyKTJdbls6+2M8PfwGVfGeuWNJWGRqTmCo0RU4LFBI
         gH8Oaeqsaxg1SKdZFdKVIXfuHpHbIozDjNg78c3rFK8MCpMRROAC/KQ/T/7ZNNehKxaz
         Dfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271120; x=1773875920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/PJeovjjoGLMcedyN4Hvdo++XuOQtv9Fm+hj7Ucl68=;
        b=J+p+5HIYArq6WB6/d2NhgCdWisV75iP2rWixjZsvoVxcKDiyBlFg8PxFLVA1dIQhUo
         Uh1EBRPItqln92R9M/xYbxxRcKSAtr4HciHRYQcFcQYlzF4FMHDbJvg7FAwetAfx7fdL
         ER93trVDkKUlEblVWURFbTd+TpCswS9lCGPjUkBNsnhfO1RsCPWPD9aE7Uidg7ZNaDGR
         +Aor7Iv/sYjAzjbNJTywEFsEDSIIQRuVXLuLUY38sZmZtCJEIvVdYaE0FzBVnZQCKwNL
         EsZtFK4NiqPNXhvcO0wMFIwwCHnnhg1pi6lsqJqlvp7apS2LvJhDlFj/tRGqyY7AMH74
         qYYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOLgNAQPLxzrtievd8brt0QIgARAPKHcWCcBzjnUlDu8at2II/mseaDJ+Ttp2FUYFM/lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7gDacA8VJBzbc5ld/5W/puZ5Bed9n3IAA3ach2jzhx3UqxHl
	Rc0gwjRoB7xOCIGnodPj0wU446LAy3/CGATtTQMi8iAqzPRnOGqjPvOSSkRmbtDW
X-Gm-Gg: ATEYQzx1aJuuOkcfDZCyGonmSCjH+Sl5DHZ+8JwCXVR9+h+lquYEgw/Q5v2JBjY79aS
	tYI5CdsQc0ccItZqpL6+esb1LlExQTtLBH/b1FsrOeJCk9DQy1JS65ScseSiOwoCYSxYw5M/P80
	XKWU3/FsbVH03o+0onyEhuFzbkjnx2ubk6tIIq4/yTFETZ/EcHGWzMYwhZBZ+as0lGIYPpgSxn/
	AeQq4t2w3tHLvBMSlCQ8xm+nLd+bIoMMpbv5kX/FYj0rhkXuUcHrwHbQW6PdD1rNGxOfBQ644D/
	1RFYsg8Ou1PQi3KRk/13lbkVSpxbz28ncQvPWJk1FTRHs0965fCV2xnumYxloPDZUjrLZlvoAtv
	kKOUb9tDLZ7dRvS1Eaby4yCdNA/+t9xw6fDBIUEZC7zW9vS2OerkEFSBwULgzbcx3jeugjxyBjg
	fFCoib7B5w2OcXVMGs3597UndGiYK76cZkc5vGy5S0lSdCJHjx8wvNhtFrLHVr
X-Received: by 2002:a05:600c:1e8f:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-4854b0a6c39mr71236095e9.5.1773271119975;
        Wed, 11 Mar 2026 16:18:39 -0700 (PDT)
Received: from osama.. ([156.223.222.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6bb4sm83586675e9.4.2026.03.11.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:18:39 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PATCH v2] RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
Date: Thu, 12 Mar 2026 00:18:32 +0100
Message-ID: <20260311231833.13189-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When saddr_high != 0 on RV32, the goto out was unconditional, causing
valid 64-bit addresses to be rejected. Only goto out when the address
is invalid (64-bit host with saddr_high != 0).

Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
v2:
- balance braces properly
---
 arch/riscv/kvm/vcpu_pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 4d8d5e9aa53d..ec0c15726da9 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -423,11 +423,12 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	saddr = saddr_low;
 
 	if (saddr_high != 0) {
-		if (IS_ENABLED(CONFIG_32BIT))
+		if (IS_ENABLED(CONFIG_32BIT)) {
 			saddr |= ((gpa_t)saddr_high << 32);
-		else
+		} else {
 			sbiret = SBI_ERR_INVALID_ADDRESS;
-		goto out;
+			goto out;
+		}
 	}
 
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
-- 
2.43.0

