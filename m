Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3D36AB54
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756296; cv=none; b=jVyEfhXT4KfIp686nTvRxhAIvCIkXeOKoU1asrLomUBUInyL4WevCwPIaAFTI3lupxVfbiOD9fLT6jPO4xdypgUY6x3gGt7UsqN0WgyCzYG+yqDEnIeZDTLoYeg9L80DCeGAl+knbwWj9oeJq13TIJ5Ruhug/VxguVHT2QWKKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756296; c=relaxed/simple;
	bh=q/VShi8y2Rb70ozxxxWRAtjTcKmlnjijX7MzBXAKbSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTRtUMwQm1t6KXhiVRAsoTpgxh+5AE38fNMQFotu5rYxQZ1de59jb4FcjKCY68TuCX1sIkyATObPp/CjPYjaXW1yByoaY3DrBqqfTjxpTuMyV5NqmAJyRrejNhDVPeikbvIWgpbw0VJE498GNW5z3SbveqVN96QXUrtkyRqNcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5IsOPr7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5IsOPr7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-85339ed040aso2322265b3a.1
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756294; x=1789361094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsCXtS0F1ozalP9OgDEtI+4ABXzVdG2gEkR2YSb8sls=;
        b=P5IsOPr7ey12N0SLpLU8R7dFfBG24Y8XVzaq90vJAudj1+lE+7w4p233O+kZfwPKDl
         xcpRHbVUF/3cIOD4OvyU1ufn+QiRQnJ/O8nR9i5N07a4lKIWadHnKDA+raavd/UQJJsC
         0NFt3+PFYxJ0QmeHu6VEQ0vvAqYj1VZLL9JJiBrhqOJ4F31oc+jzIwXsvA/Kz9l8+0bK
         0nEpVDbW/p1nHKxHUG6+Q0ZErT/Q3cw5Mzj9/UYYa/LDamfL8zbihPojcos7R8jirCE/
         swz4mufNnOeYDGhdq3qD/QtzPWnRuH6Tb6yuItwigqf7/tqTEV5WrL/TIuus+ImpO6LM
         grhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756294; x=1789361094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsCXtS0F1ozalP9OgDEtI+4ABXzVdG2gEkR2YSb8sls=;
        b=lTTjYA4LtfKYTnpNAPMR3mMvZ1Ik0GkKoozGEvq/tBxyI9Xl9zObMUZ2Rojj0agvJE
         L0G3kfSO7d/QWFolLRs4kj2WGICmfQbfSqlHNmtqt0Md70KH8Ahs0GBCTyPkXV2CtF4N
         EFr+W3xttesUOJOyCJl8ErvdT9gyWAeLzaX/HQTm33knG73r+bR4YqFicV6+WWVjUe//
         1ckL37nBiH45Qs7AyDnxsCjHiMZvcLDKU1WCFXqry/OCVasDBnqq2h8PyFXUWbe67xzZ
         ZHx6cumT+JlkOG6jFjUe4kLf2RY/yJSkUB4bSKSm7rpfxro6Jdn7MYRWvs2noo3vTpYA
         8osA==
X-Forwarded-Encrypted: i=1; AKwUvBzD3S0/2tRXmDOoTOwJ2O3Ye8BrvjZDHhDr7xJq6OG0gAW/d0ULLpfbqjCEkXXwQZfToE4=@vger.kernel.org
X-Gm-Message-State: AFuF++mrxv+eJdET1O9sXyX05dC7rcLmbHzGKU4UTmYNjqd2e/G/GTda
	UjDcXTdUnDo5hgs+xstdPpsbQTWlH7gJaMg2WmAzbb5vlMbWFd/P01ci
X-Gm-Gg: AYBFou2C/gjh26MiXITIZzhiTCMl5EAkO4jON2eTquWKaAwwFXdiPPeSVkw1QL89E0C
	fBxxzwtlRDkZlbdVEuP0ErzpxUiuwk8uzSnHxNg5hSBnxgPgGi8rtcNnKyqu1wh6dLpFBA7MiFk
	8OEFRtMLfTfyW+jn1EGom5+9BE3tb1e6UQbQHK+l2x/cJnC6N5xUTFcS8hXE3AaDdoLvvlEGA3b
	aDZrWQ7DbJY33zZaGwJ0ePk0eqQ1K3cWv343B55KQ/JrWdnbaf62OXmm9Qa7g6oIDtJl2BVpNOM
	WoubynqJj35OT/ezufEFE9vpHzV31OIcDnGGYq0tX66KNAMz7lSr4QYARQd11avWd/loVYh8E1e
	AwNgn4voREWJTrFvmrmm+a+ZehrwZ3z+xrl97G3U3eSRTwpQGJzye++JSZn63MDo347Yd4JaqQo
	Or3gj9rtTnWdOARAMnj9YAeLq/Ok3pwJS0yEZZdNvTVkUg0lZsn8htjpVhp0RoJj0tOkWU3SM3K
	p0FOL1Ec2mqdA==
X-Received: by 2002:a05:6a20:9630:b0:3cd:9f0b:f7a2 with SMTP id adf61e73a8af0-3da39ee15d0mr32834555637.11.1788756294346;
        Sun, 06 Sep 2026 21:44:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm37823751eec.16.2026.09.06.21.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:44:54 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/3] selftests: kvm: fix typos in comments
Date: Mon,  7 Sep 2026 10:14:33 +0530
Message-ID: <20260907044434.4682-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907044434.4682-1-hemanth.selam@gmail.com>
References: <20260907044434.4682-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/kvm/arm64/debug-exceptions.c | 2 +-
 tools/testing/selftests/kvm/arm64/hypercalls.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/debug-exceptions.c b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
index 7dc5f0b4f6ad..9da6dc5bcfe6 100644
--- a/tools/testing/selftests/kvm/arm64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
@@ -387,7 +387,7 @@ static void guest_code_ss(int test_cnt)
 		 * Enable Single Step execution.  Note!  This _must_ be a bare
 		 * ucall as the ucall() path uses atomic operations to manage
 		 * the ucall structures, and the built-in "atomics" are usually
-		 * implemented via exclusive access instructions.  The exlusive
+		 * implemented via exclusive access instructions.  The exclusive
 		 * monitor is cleared on ERET, and so taking debug exceptions
 		 * during a LDREX=>STREX sequence will prevent forward progress
 		 * and hang the guest/test.
diff --git a/tools/testing/selftests/kvm/arm64/hypercalls.c b/tools/testing/selftests/kvm/arm64/hypercalls.c
index 5d96cdf382c4..a24becda9e62 100644
--- a/tools/testing/selftests/kvm/arm64/hypercalls.c
+++ b/tools/testing/selftests/kvm/arm64/hypercalls.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-/* hypercalls: Check the ARM64's psuedo-firmware bitmap register interface.
+/* hypercalls: Check the ARM64's pseudo-firmware bitmap register interface.
  *
  * The test validates the basic hypercall functionalities that are exposed
- * via the psuedo-firmware bitmap register. This includes the registers'
+ * via the pseudo-firmware bitmap register. This includes the registers'
  * read/write behavior before and after the VM has started, and if the
  * hypercalls are properly masked or unmasked to the guest when disabled or
  * enabled from the KVM userspace, respectively.
