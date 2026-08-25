Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6A3E6DFF
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647073; cv=none; b=uumNGy7SoSHpBHbKoFs4S5r5Seq1qIcA7SSiD3BAycm3ZE+L+m0PdD/Lmj0P96i0C1PmTnTBL5H9Mx2Saqj4M1f/eFsr/xOkuvZQIG5uMk8RA1M7QovS9ZRfkRGlS/MaR66JDx61ZQDl2H+9y16BoMuywbaxJhkYaSspbpVfhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647073; c=relaxed/simple;
	bh=QzU+PHGXaMJ/27WJb6wJphrvbMmQUjQ1+684SPuRm40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K90MfZQeDPIYE5eQWgPcdZ83Rjey0c5rv6yvrOJH2eI07drljIEYDKCOS8EWZZVxrwJsUSgIInNwL/Rd97vk+L20EbQyqwF6JfkQtxDOExX2IboEH3atvb3lQb0l/Lb4bdyL+W8Z28GAs+/dZfv1kM+P4wpKFjmCQvFCOTc+MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFtjCu02; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFtjCu02"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso3293966a12.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647070; x=1788251870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlP9O0s11C5YW6Wj3Uolvqko6ksI3Exocfu05SFa8SI=;
        b=fFtjCu02pj76VWU/qcQmdw0V6Q1XPZgMBAPUZWl5tPQojrSehi2O4azmznomKDcxAv
         xokqOIIsDQzmtOE+fKCLklaFUT7Z2GMq8vpk9qiZISqfJCt8UvFTYguhlMRBnQ9dCd3i
         7BWWCnpxZF8SH8zdiIBZaujHkaUUTaFVpNNDGfxKZdBEMUxoMKJM1HavA36kE+uG1W+7
         DrEkqDhTNusnHr5gu4ghBLU8bf8P25pquCLqn1AiF6lMtjOMgUg2yTZaY48pvf+wpBHy
         cPbom/VeOkBMHJ55m1DQC9Y+ksJ4SC1N1x2M3oFzmnFulkEzJdYWeTPB91w2wCdtpTkk
         0/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647070; x=1788251870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SlP9O0s11C5YW6Wj3Uolvqko6ksI3Exocfu05SFa8SI=;
        b=jwPp7Ug8oiDkhAnX80SfyqcvetkY7K8ZOXShYcL+JqL5t1Q3LViM8trTxCFZPFRiqY
         XewTiGN/i6+1WTNFqpHJmgxfkBkW8Pc+vqFNeoxU6LW03UVERcaChLCfqbABLm1057tS
         CavA5/Ymry1SD/SzIvkwL3j2WkcT7apgMyXv3KZVzdqLlWv85DzndWVDoqNHsJyi4EFd
         p15L5Xk4kVQvqgzZ880+AlTnpOUcvEQh2MuxrPOJnZNacSq1NeR6L3jbiK1TWNdd2ZAI
         oXtpC1m7IWRi6U74QxexCQ5F9R4Rk+qQTM+RIm/Wk6CqIuTdnnvjoUIfNX04eUon1orw
         rWHw==
X-Forwarded-Encrypted: i=1; AHgh+RrnW9Bj1+ZJZa3WnRlj4+2buRxGioi3cZVUIpqbwNxqn8ZOEfNnwmpBvW3cuXoEZXI6UQk=@vger.kernel.org
X-Gm-Message-State: AFuF++lLqJsdXt42EdhFU1a01Z8pSFw8NpGLZBQkVo3bPLLgoJBSmYyk
	tI4HcLIieEjgwHlFnRZd9IrbpjWY5A+SJvmadHeyiJ1TkFuoRGFBQpUy
X-Gm-Gg: AR+sD13K5LebZpRhGqMbs91XlZtGYi8/klbylXiYbGY5VD8IncGQ5jOzRERg3fAYw2J
	FcmUG7MnEazi27o2cpLDEeSKwp4QbaEIdJjfUWUkmC4pW+pp2b3thSyxoLZPoxXO17MNkye7Fri
	Hw0X7M+P5Aez1m6nZ/hxBq/GejUg+8KSBtpCDi8ytVMtL+baSrdtuHjq2nBuTpOS68OLh0XJ5yV
	yITMdYBIJpBsh+eElN8CT5QZi4iFNA4XkO/FvRRAK4pTBjNBrmpjTaoToP1IBnwM9523BpyU0GM
	vDoxa95XVh0jHclqQ30tTdH91PygCV7RK7Ht7ysyOfeFxbIhdcY/hTXtQxWFgUcoGNuyocTe/z3
	57Z4gGL5VEjLo6jN9MbogSg5MpQnQvSDSaD8eMV+PDWGGMot3FOhsjU51/lrQi5c/LNc4Ux1owN
	GLITjSBgpRthhiAd8j537nQZuH+Ki9VsRY1roe/nWwosHLZLHvTtwVgWXKOmZPn5TWg6+vptE1F
	UmQwAXiGX6k
X-Received: by 2002:a05:6300:6bc7:20b0:3cd:9f99:3381 with SMTP id adf61e73a8af0-3cd9f9933bamr400900637.0.1787647069755;
        Tue, 25 Aug 2026 01:37:49 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60abbsm1835887a12.23.2026.08.25.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:37:48 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	me@brighamcampbell.com,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 2/3] RISC-V: KVM: Report snapshot write failure to the guest
Date: Tue, 25 Aug 2026 17:37:18 +0900
Message-ID: <20260825083719.643970-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260825083719.643970-1-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kvm_vcpu_write_guest() fails while updating the PMU snapshot area
on counter stop, the guest may receive SBI_SUCCESS without the
snapshot being updated, leaving stale data in shared memory.

Return SBI_ERR_FAILURE when the snapshot write fails.

Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 56dd5b1b2846..45dd5233340d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -723,9 +723,10 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		}
 	}
 
-	if (shmem_needs_update)
-		kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
-					     sizeof(struct riscv_pmu_snapshot_data));
+	if (shmem_needs_update &&
+	    kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+				 sizeof(struct riscv_pmu_snapshot_data)))
+		sbiret = SBI_ERR_FAILURE;
 
 out:
 	retdata->err_val = sbiret;
-- 
2.52.0

