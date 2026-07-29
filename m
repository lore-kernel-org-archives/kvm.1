Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FC4446E6
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326865; cv=none; b=PRcvucVgKbmEs8s1Q79zpZSflFCEEzWKH5EhkgmR6WSOZBWHPcgi+OTuY3UEqFBe9NJszwDE/qa0Gbe9Rp5hFufTOYI8DST7+38LBma2FGHBFIvS/TIgvwKH+u5oeGmfwqyjeIrqx4ugAc8e5lnWW8ybFate7C7EYU/npC+ESaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326865; c=relaxed/simple;
	bh=CB/kmte7e6VY+VaJOPegkGtB3qVnaYWtkgn+D4/w8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIyqv8yF0nCPd6RwGEW+Ysme4Vq6r+q5G08bcItVTSHyhw+ywl7+pqll/V1mQmV6oU9pevPV32jBXUCQjLcqb53zBJU1J0J38RItcyvVcViEcUDoCUzo37FQm3mP09VwvBzq9v1bG/B1IY+HpmMq/Boz3cKr6fyk4CJgZQUuAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc7jkpv8; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc7jkpv8"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca696c4b152so264673a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326863; x=1785931663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyJMaQ1sYDuVfSZMuwHiwzVH9paIzHnqdE6/bJyXJ+M=;
        b=Qc7jkpv8uT8etdfvn9vw8LcDpgHD88XqFpL3JE+GFHbQsQGmLPI0jI1WS/LpyLaiCr
         tKxHfkq0B8kmh7pgGX8MYCE1yYdyrduzCiSy/aUiF8dYQfZCiMkk6mi7Cglrj+5UrN4X
         VGfh1ce6sCzc2iZXwGCRSuefWClKllx1IXwTtJwCMbQKrfDh0vmyclkCU99vWva423B8
         5HZQRNDMgB3ordFIBAsPvAhPqOgWqHNC/9qn6a/p7p1zTuID24xXI8qTrWkJnZF649DP
         sT83O1Ke2Jqk25ZfqSSxaHLeVep2JGpdm9g/+RxF+yWnYQHV4c//KQy6+y8oh/4biqDK
         0HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326863; x=1785931663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KyJMaQ1sYDuVfSZMuwHiwzVH9paIzHnqdE6/bJyXJ+M=;
        b=BM0uZElMyTxwj7QNZ6oCsMFHCqky8sSQp9JHKWd41Ynkc6Zt+gIn+79IYcW3k5Aqg5
         G6xgt2lUp9dC6geqni8BfuQg8Xh37DkrzMrYRIgi8yQ8kZIvLFmM9Lj6QorgXe81jR/+
         SfQfuNPZOpCOONGeIVvHbIgmELB/AmhAcPzTRa5gq1MIfLN0fpek9bT9eupe2t13bBMh
         xL80t9qAmBjaH7a96mfpqDIPP67l+CJDQHvfZMi83gKEfg0fNYFR6buTxBmSRPVzfrB6
         oaHWJaxXDI3FE9gyjYtaL66sdDuy6Fvo0Eo5cDM0317betO0Ouoxz/BoAhIIDX8oufZW
         zM4A==
X-Forwarded-Encrypted: i=1; AHgh+Ro+Cr7MBy5h8n6VQ8aFvBeEeJlKOgxLOf/0jIDyjPPa4dbtrEPJMsxmfL0zRdhv8hoQYi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uO8F5fvTiWp6aslAUxHs5mnBq9wgNOm7AGeP7y+IPLW85DZN
	AnSJ0JXzdQBR5B+SckFYFUnkSj7r3+AOSnDPWM57Q9mhy4Dr0CHFZWDt
X-Gm-Gg: AR+sD11QG2j3YxozHQ+XCKij7QbYZS/qShytS1XtnznwxM8cPhuaeupBAHd0MTRRTBw
	nIunNgvZpTufiZRkbejWrPWbI/QyxnJrF13VnbntyHt6BuRathofNFCCIqDKsYHc46vvqdUBSAK
	ITKCwML0uENup80EBy9XAVhVeaNwaNbWtqpvpUgGTUZvgy0zPKR00svpujEB4ZSkQXGwnjwjqmw
	7GBBePi3UYg3JyeebaBVovwBfwCNVV5uKm9TYpTjE9AuZIIPItakQ9tVkpFLprI1adMq/T0+v1w
	OuhYIQ1ddoBGzkSosG/mMOr3zMlVdO5pl9B9tKwzsIv9mUiHyYC9fwlJwZmZLmBh7CICTM1RVBG
	JLFpmSO1AVSSesMxT0JEpnq9tCQBJtmSUURwfnuTYFIoMu07PlqsV3LUkWUqNtgR0vOOSav8WAK
	8b1rBJxkLB3Ucnj/m9e11uWgx91TnZPx9Fjdy59Sj9T1t8X2xCQRbp8/zQvCSEZloazlvrUiowo
	WBErBMfKhGTBQ==
X-Received: by 2002:a05:6a00:b4e:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-84e932ca245mr6604434b3a.9.1785326862618;
        Wed, 29 Jul 2026 05:07:42 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055133sm1309570b3a.18.2026.07.29.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:42 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	stable@vger.kernel.org,
	Bingyu Xian <shanbeeyoo@gmail.com>
Subject: [PATCH v3 1/3] RISC-V: KVM: Treat -EEXIST from G-stage map as success
Date: Wed, 29 Jul 2026 20:07:31 +0800
Message-ID: <20260729120733.829457-2-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729120733.829457-1-shanbeeyoo@gmail.com>
References: <20260729075230.743030-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a concurrent vCPU installs the same G-stage mapping while we are
waiting for mmu_lock, kvm_riscv_gstage_map_page() returns -EEXIST.
This is not an error -- the page is correctly mapped and the faulting
vCPU can simply retry the guest instruction -- but KVM was treating it
as one: printing "Failed to map in G-stage" to dmesg and propagating
-EEXIST all the way to userspace.

Align RISC-V with x86 and arm64, which already swallow -EEXIST in
their respective fault handlers.  This also lets kvm_release_faultin_page()
drop its "ret && ret != -EEXIST" special case: with ret normalized to 0
the regular release path is correct.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Cc: stable@vger.kernel.org
Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 8a0aa5e0e216..943d8dc72105 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 						vma_pagesize, true, true, out_map);
 	}
 
-	if (ret)
+	if (ret == -EEXIST)
+		ret = 0;
+	else if (ret)
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
+	kvm_release_faultin_page(kvm, page, ret, writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
-- 
2.54.0

