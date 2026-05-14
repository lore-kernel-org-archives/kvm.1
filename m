Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1A239562
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780215; cv=none; b=XILqu7qiQzW9/6p2VQoRjHNXLV0FH1HJwhNSvMAvVQhw5VIN1Ts1OLG16qv/oyfxUQIKwCmpIi6qdtHPL0cRUAYb6xNHPx6gZJDaEkMks3yk8HQmGvWI/WC+Hpujwl5XcxzVc2X72KTRAeURKHyyqADk1Jcb7s9MxQqB9oOcHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780215; c=relaxed/simple;
	bh=G5RGhVPalTj2Mk16HxwUUdgZI4Tel7YfUCAHpPi9Ub8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTBBB8u3x8bo9HWX+lmipAWqy9oeMzIr/IyrIBOwHU+TGC5ZzD3R1GCgsZzg8fxWIzEYyLwikYpu2xjqewDVnirEV4hT8DZ2WTbHD304nKvpbZDxkwq9sdMelPWf7ZQxsIpNynDWFuqD4aaqTAb7IsHU9pL+WNchn4Kme32lEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXQIOksv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXQIOksv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4526a8170ceso4660875f8f.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780213; x=1779385013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KChkhZSF5dUBGW1dpwhtz2Nd2WW6tFTUrsIGPgeyre0=;
        b=AXQIOksvaBd8G+gzaIURAdzdOE7GXn1spLQ5EklMkyA0+A0shNvjvaRdpnxDuveiL8
         3pwA2JpPcF/0JZ1d/BpXSoe7fYrXajk4sNTIU7bCg/9weZFsnOVonu0h5EvEl3TJojpR
         4TQ/d7KA+iPiWwxa0DZAGueKsByZTaFzEkStOmkX6vcxABuZYxYZzZ6PFfXzgQfI7rqe
         rVzwp0BV816hmY4BauUKJVf3au9PRj2wm1sOuqaW2ZC6vT5G6MxHD73isuK05XlxNVFx
         Q4rlerUYvYc+2KPvflT+m2f0PlX3mFXVQ2pb2hXHenuinhd6U/DUZOMKIfPfeeREVOYQ
         NKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780213; x=1779385013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KChkhZSF5dUBGW1dpwhtz2Nd2WW6tFTUrsIGPgeyre0=;
        b=AXrUMGiS0ugeKzbCuQsfo5IqG8AF8P4oP/aS3kncY4irxEswsJtxP4ZZUMTVKkqU4n
         4wP1JCygkTBUIj1OjpCLGVFvxz0b4wG6jfi/dcqEUvrHwvaRbW+RF2aRR+4F5mpoq+Q+
         wfj7bys7UWRy6ypxRD6qdUCJ8QggWKYfwA7JfPGvotM+gsYxSn/SFM3kXtND9mk4aQHC
         FQ/YtMGPA9GLYACnD6CsDukcm+j580OGoJcCKLhQkxNcUdVWxQkzqD0Yf3udlCPEBANw
         lV+d+S8lgS/eCxOFjIwzuoqKz9NS9xeQeKWbghlt9ft4+VePaPYl7uynQnzGLDrdT0Sw
         oZEg==
X-Forwarded-Encrypted: i=1; AFNElJ9P5FKKE0n9uOVMSMCghl9fhM9R5lCN4U2AMGg3kWGf8purojdPPShHpGYJflRU9g9N+Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRb4LC/clsEJDH1Q4bFNmVp21QRxTFv8GSCuL3v2yweI+IioB
	Y8/WSQuW6aJF2SGcjYmR5Xrj/HlN+7bmjUFeYcQYIc9hR7OC2iVrlwhv
X-Gm-Gg: Acq92OGNrrQ45kBeZfk3r0dnAEVJG0K7MWHqavDtxmFMT2bnLNKCftFDeFBEYQ+LUNq
	mH6QakwnROaooi+yBWSZIAmdaEvYwy+BtZ1uMdY+nvMqetHC9ohLa44XDxs2yw2wvZ4iXwdh9Ql
	g+7KFcNHXz/A8nKWgRy6u3UjSds7b9OIq3lCwUtZaM7+lDjhTMfRgTNjHrCvlPlhZVvtxirliOY
	c6mvNKy/sAftPQBURci0Rqh94tUb6cMK8vbuezHJtZKKy+IkAzoG67Pri3jMYLPZ7vmdlI3XUGs
	FpFXqt1layXD1yzuuIbdlCAq2rvKeJgCOvJf+0pWep0X3pLEHdR3+aCwUMdHL7eCKYBBmkp7KrW
	RrTRP0hJezGAKVVT/UBxOvmjl27l+U2GurhKTI365a6JNM/MJ2nd2L6D5gHjMPuhztBlNviF4v3
	iLZnzzHcNlDsS9QHAb3/JRXKUaEPVbWlvhGqTsOPdQDcElv1gk2eoZIzZ6Knti
X-Received: by 2002:a05:6000:220c:b0:45b:d891:4ef1 with SMTP id ffacd0b85a97d-45e5c60497emr19791f8f.34.1778780212640;
        Thu, 14 May 2026 10:36:52 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:4f8c:d716:5699:930b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe222bsm6575063f8f.27.2026.05.14.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:36:52 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH 1/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem OOM
Date: Thu, 14 May 2026 19:36:40 +0200
Message-ID: <20260514173642.41448-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_vcpu_pmu_snapshot_set_shmem() returned -ENOMEM from the
SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall() to
abort KVM_RUN and surface the error to userspace instead of
ompleting the ECALL with a negative SBI error in a0.
Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
handlers and kvm_sbi_ext_pmu_handler comment.

Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index a935ed96bc17..91aa0155a420 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -453,8 +453,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
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
-- 
2.43.0

