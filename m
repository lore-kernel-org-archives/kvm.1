Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554133B47D7
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666121; cv=none; b=RcE/UtX647t+QQDGv3HyoQC58WI6wTJMk4xAevSeixPYOGTkXjvwXC41bdeLmllb7wM3+8glUVXbnkyCX8qKBhIwKR2TvosfAr9XyG7JQgAGOzkobXrPRY7gi4jk/J0Ipt5nlsYPts3dV/HGonX7+RhsDDXHMEUuGRdOYIdfn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666121; c=relaxed/simple;
	bh=1eg7xfXvqB+X7Z1e0Md87PErbs70YQUknxBBKub28qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFHUiXwiajCT8EmIEzITPAlshy6Zx33WMASzXXYSH+wHrnGhHDnO6aPXwzXPE0wyMlB6nKz0qheaTCTqVTa3qiAPmEsEggVCNEo4wGNP8Wx1lsg0ryNxzGhXIazfSSbUy6OA2ttjN1TiarzLPjwgR9iW/ScROGuDZg89Ckjv6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMZwTzMx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMZwTzMx"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so1859774a91.1
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666120; x=1789270920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=48OUlgZ8oJkokpD3G8IEqvdlANt4AE/H+y5S+7nUN5c=;
        b=QMZwTzMxaDcyYtRpB+rbzJ/vLwndXnmbbn95fDYDUOxqVwqjnOEVzhw8WqdgAJCw7I
         LCle4sGwmE7+XFxcsuAPHe0CZsBV1AzyZ5GoUkwnkFGvkdlvjRX1IfaZiGF2KwKPqZgM
         C02Rz4R/X4SEzLEAZrtcrHvEuusFi+R6O55ESTK3lCFnVliMWtwjCbNA/2ItOKN59oQ/
         0K4M6NOvN6TBaNOeagAjI60ZKTJw/eARciBH3fQqRNZt38ddct/dHaXynG0XpqgeA3kr
         RYXJFP6a3o4+n8JJtWm3JtL/BDurJpMAV97H9d0HXD/uFE7fYSs5izyOJFebJWx52Rm9
         bVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666120; x=1789270920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48OUlgZ8oJkokpD3G8IEqvdlANt4AE/H+y5S+7nUN5c=;
        b=hO4avBdef1grayqbZ4sCyEa2xoy62Yy6vlg2h99BStOdHix4elNxOrWoLsODo5+bGy
         IndqDyQJtucurWjSncfY/TeHO4xyX/R0L9LlOsoMkxXLyFDADKYa500GBzkx7DV0Zb11
         3tk3Ssytaib8KsxJP/+qotxc6qR8Vu7/jZoDAOBZOTMnvRbVWcukXD4f2q83Uvy96H02
         VVX6YQ05+DW0HDaJCBAjzNUbK6fysgKVxtlTQcjwRG4jZZ7hntFupyhvyFOcvOX/oQHV
         N6tAQ+uYVW8GeAxSAoW9yq3AbxSMyZOA3YRWb20T7e9DrmtLWGtV8cf8oM4YTKHFP9EH
         NOzA==
X-Forwarded-Encrypted: i=1; AKwUvBzOO90a9exDzTv6M/h3rIOx0xFYNV9rKwDT8qw2TLd1ABvJxgjNFsI2SucNH7kDkRXhScg=@vger.kernel.org
X-Gm-Message-State: AFuF++nv4tOZSWb//Tp/zpiNWmXCLkrtwU8zHL1gfWpTIrwpKYgOrZno
	F7GiIMb81PqZKFH4sG2m/SAxPdnuutNUaelDuFWir8M8VG5RpoWalByy
X-Gm-Gg: AYBFou2IOeibuI1HutAHMtFfnkhzWpyYuZRxQajI5jzQlktfxSPxKT9dLXPdvLtjkMz
	H/fIzau5YnFutAfoT9Jkw4PtF4qL8BLK0cQVRwfrBNJP3C04uDoBUMF5SgNlroB2M0RxmlpmklJ
	GPmC6QvWxoCJCuupCDFO+l5xxi4zpV2nApgNClN5bQbquT+1vx2GNMmQuf8gMFOYeBA8Nnc2SU0
	NVQFe6i+LLk4wWH+bHB+dJFgL/7Q2TrBm4YcBEPsUa3RzqBWHVtGqpHPfGIWc4O71Goss1ZCQ0M
	DpdOjFxWHBNV5Kfov7Eb4zeGYxtt0826YZyws9ToHduXBwjhOWhpnaeA3oztgdef0HitIjgJYus
	UDVqEF4ofQRV36K4ysATrbI19PD41xi+Jqyhw7SVloVGTtiftW0mFEPR//aNmUjUezN25nlp3Cn
	1UxZ9nWoDFimvRrfc1kqlc1MdmbTyTYCHaJ4vu0123J1XObyOAXM+1JOPPGSzNweDRKf9b1lqVm
	QxQ/aKrZ50qAIeJHr5R4ifTLvRyYXPQ5Lt8yUwVmCpA
X-Received: by 2002:a17:90a:da8f:b0:398:b71e:60c1 with SMTP id 98e67ed59e1d1-39b26208e7amr22343140a91.12.1788666118495;
        Sat, 05 Sep 2026 20:41:58 -0700 (PDT)
Received: from debian-rockchip-rock5b-rk3588.. ([27.130.10.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm22761765a91.14.2026.09.05.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:41:58 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>,
	Gokul K <gokul02k@gmail.com>
Subject: [PATCH] KVM: selftests: Fix VM leak in early return
Date: Sun,  6 Sep 2026 03:41:43 +0000
Message-ID: <20260906034144.14059-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_mmio_ease() returns early and skips the call to kvm_vm_free() when
ID_AA64PFR1_EL1 is not available.

Use a goto so that the early return joins the common exit path.

Reported-by: Gokul K <gokul02k@gmail.com>
Link: https://lore.kernel.org/all/20260808081050.408657-1-gokul02k@gmail.com/
Fixes: a90aac553249 ("KVM: arm64: selftests: Test SEAs are taken to SError vector when EASE=1")
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
Tested on a Rock 5B (RK3588). ID_AA64PFR1_EL1.DF2 is not implemented,
so test_mmio_ease() takes the skip path exercised by this fix.
---
 tools/testing/selftests/kvm/arm64/external_aborts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/external_aborts.c b/tools/testing/selftests/kvm/arm64/external_aborts.c
index d8fe17a6cc59..7836756a38a6 100644
--- a/tools/testing/selftests/kvm/arm64/external_aborts.c
+++ b/tools/testing/selftests/kvm/arm64/external_aborts.c
@@ -339,7 +339,7 @@ static void test_mmio_ease(void)
 	pfr1 = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR1_EL1));
 	if (!SYS_FIELD_GET(ID_AA64PFR1_EL1, DF2, pfr1)) {
 		pr_debug("Skipping %s\n", __func__);
-		return;
+		goto done;
 	}
 
 	/*
@@ -356,6 +356,7 @@ static void test_mmio_ease(void)
 
 	vcpu_inject_sea(vcpu);
 	vcpu_run_expect_done(vcpu);
+done:
 	kvm_vm_free(vm);
 }
 
-- 
2.47.3

