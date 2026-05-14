Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B28392C4F
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780218; cv=none; b=qqpxqOxKkc1Uwaljtg+ny/AtTTPr6nNl9RekX12SeMBwBsYnvfUZD6Ps51nYQFhX2ujJ0V/G4qP9PIlq4n/rz1t3wDIx48z6ZXEETMvBHf5pj38jeTv6uFRXg/fOmRy34CRvXdKuWvDVxvm3k7qixA+lQKAjw6zdVcV5CaJP+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780218; c=relaxed/simple;
	bh=aUuQm/h/TUPimZd5XY1jIkt7LbBc2oh13i9KwiogPLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP04VfpmgXCSci2MVjp0EO+kfVEw9Hh5xfpI9EoCkj4Ug8OHewGgghHsSA95ivCEnNqhCWdeVvZTmL2Tc64l1+90ti5sLHHDQHtnjKjydgg7niPWr0qlwpReQtFS9w9eGp+bwZLMwmE9DvvUO68xXS05c1E5/wFPNZJ9LnleeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3cf8Mr9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3cf8Mr9"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe62837baso4356022f8f.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780215; x=1779385015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzOXpklejgsU43guiJHt9ocv4/DBH4gkj5ecH1UKTFA=;
        b=C3cf8Mr9DrGbRgUehJA+1QjDMcn8P4alN5mTj8TU2IR05gSJb5ZN98PcNirz5jsMIE
         BdaqQ75kMsWaITXo6Fk3bo7+Wlbe83aYZuhRTvrmkjyqQM+MVsxDlCicBROwvLSukEjF
         yEImuGaepOmXK9kBEKHv+9hArql47rj4uM99FmWR3khpyBG5nCwpY+M0QCBo9UZR7kav
         6ccs6PheILKXHLVOnk+1tah+Uo2Y5rbRIsLOmNsktym/t775CE61uYZ+k30EdnIp/BiT
         IRb+15GPUi8vgV8DFwpYm8eRk11wGlTOm8nPyL7qb+sPOkp2etYvjUBoIFb9oew1LBlC
         9msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780215; x=1779385015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzOXpklejgsU43guiJHt9ocv4/DBH4gkj5ecH1UKTFA=;
        b=khw5AHgxZ+KticUX/RLccQjvG4khOR0l96vKys+Ohyle+l4yDzIu3/VpaA+kOepQAC
         1/55dIoL1NAGEoSg3mEvKtZ/bF2NgjF/6h98HP/P9WpOradiaL8x3jy3TuBTX0TLgayf
         5TXAuLeKkKHMM3H+arLaZzhxnLPAieOCxG1Hwebr6UzPMBypWr3y+ce0CoCsL38qyByb
         Juj0MkJTdr6V00W0xHpuoCcucpoEUNjcd9Y1V9no87ClgFxPN1f2T9Ti7MllE7yZvraO
         pQ1t6WTcoM7X97ZozDwHCs+ksTayd9ijwE5WZM9mXDClZYhxIEwXHz4oFedxWLGKT4kI
         bOWw==
X-Forwarded-Encrypted: i=1; AFNElJ+j2xt+0QE/fkHt+EGZd6KAdvDwRWgLjX73+U3j340itLwhcH+KuuNe0jYWlMycFkA4G7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkrHMI++923PDjaooJ7/8lnRjV7eonN7odabZ0GOXlF68c3Wz
	tjxbmJWExl6DOGGaOXrvsG9KCkUxub8D+LVFsiJp3umlKabVnVI/mC/O
X-Gm-Gg: Acq92OEXaCRSPYSal/V/RWx9nqPUTYVqoBhJM7wix2V++6h8W5ZpFOGHLlwgacl7YoQ
	c/9iKmzMlbUwvk21dQbtATVcE44G2maNbfWeQbU1Ur/mqw1jGWFAObCYVcLuoiuJoNLyMtVw1Ct
	ZpeNes68ebF4rAcDUcLfGfeEs0etF9HUy3UpJi4hmbudzsbkfnpdFMte7tIOlNLmgoP9cfR0lrG
	+YuhJYM85azPfXu6F76j/Wx0gLObtjHCN7hIavBGNwLALS0iF5HTkVRKYxK5RGrCC6oHiWlR7ck
	27HY+e4nUPPiTaco0EJL6g8w4qO9M2c+7mcZMPIq2NoSYYExoAVyhCuFwFKkEoNPrTyMLUPkvHd
	3r6UfXEbX5sLcZcv+BbzIirwSNpTletawsAOWbNlz2oz2NOzIrijLFkcpuPbFaFeRuRGM7YEByL
	VCWhvwZDGO5iBy0EE+jSwJF9OZlMJ7N1GX1dlbBHZzyax/9dNOvAXF5s5n6OgE
X-Received: by 2002:a05:6000:2f83:b0:43d:7883:87ce with SMTP id ffacd0b85a97d-45e5c595a6fmr80251f8f.34.1778780215294;
        Thu, 14 May 2026 10:36:55 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:4f8c:d716:5699:930b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe222bsm6575063f8f.27.2026.05.14.10.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:36:54 -0700 (PDT)
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
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info OOM
Date: Thu, 14 May 2026 19:36:41 +0200
Message-ID: <20260514173642.41448-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514173642.41448-1-osama.abdelkader@gmail.com>
References: <20260514173642.41448-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_riscv_vcpu_pmu_event_info() returned -ENOMEM from the
SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall()
to abort KVM_RUN and surface the error to userspace instead of
completing the ECALL with a negative SBI error in a0.
Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
handlers and kvm_sbi_ext_pmu_handler comment.

Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 91aa0155a420..bb46dcbfb24d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -501,8 +501,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
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

