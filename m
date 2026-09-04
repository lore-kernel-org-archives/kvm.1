Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171EF48AE06
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524703; cv=none; b=LDtVRcPBmr05gQM5Y2JnIJmx2YrcmgZx+fysDLx70MaS8RfNB1enFcyutyte6F13idqsRo46dxCh1FHIVHtQ3GYvnf9u7JY+0l11ZTeSmU3sERlc0kbI2m+h5lzdfDtN5wm9AKiB7p09p6XD5xqu8qANOLCFAELvcETDGovCDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524703; c=relaxed/simple;
	bh=PqwhrNyABnZAOTbk3+DQqjSMv0diEZDOtPwkTzZvqnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5dFBFV2T8kUqML000o257VEUD6BUaVjpyMJRySP55w5EKNqcwPgX6dz1U6JSYKgDM1h9ytdzsMY41pSgt8obn/kLoFKhPuePWpZpY6PAYP4BUthzVF/b86jRK+53AbX6q5A4lpFD0Qz6O8n8h9fPxDgiLUYnl9+rQuoSmD1VtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj5Pp8Dr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj5Pp8Dr"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1b766bf01so417718eaf.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524700; x=1789129500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kjXI7c1o2fMUZ4gP/lf6VLU7Bny6ysM8MfilUau8IZs=;
        b=Fj5Pp8DrO5TxcBGWQjFVk9OBK4K1ijbZC2ykvUs0F3N59XvlpcGpjwhXcumcGH2O21
         fXjaGunVSfxhNOEXcmrcX5E2MKndQtmgTSG53Ft2E1K9V3xGPOMJeg/7YYBfJWwPLtPu
         iyTAo7a1OfH//yhL3LCK0ExUnt0a1mARtsy1lDrphOblJvaHNPZl4YcAtGk+M6v2zNdR
         zgf5rRolOGvWJA1J36fJZNFz7pJTvrscjalX/d2A+kJ+eO7iQHA0u+SADuT0eUz3Md7t
         GyD1lmUfLDuIkClMr2tWx9/2PuONnz5mSJSJKsnTpEk2V/iQZlIsc069vKmkxd5QUPte
         A9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524700; x=1789129500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kjXI7c1o2fMUZ4gP/lf6VLU7Bny6ysM8MfilUau8IZs=;
        b=cfZ24vkZYnImzuLlhZrmLb58uR6Ts/bwgWZbYycYRru3CyBS2SNfrMCiQ5pazQlcTy
         n71XGijZFiM7Bkm7/5k8i+eWmVaX4xZcoSlvsJSnDgjd0Qo20D3r+6maI3wf1RlGLWxe
         H42QE6N3cku7I+E1+nAMjTxk5/OuijCOQqiSpDB8oUgH2aV+LoozZwnsoRYDQa5TuR1W
         C5vj0QukCjocfnukCFkX4H3OMCZnV+gCv5EMZW24XqbWc8vmqFHF8zgQZ2X7Uxtezi7u
         rQGTXocmr+EQIAYe+71QSiD3007Q7q3G2R1xIKXVkBO+F1Kpr1JuwRI1/h1Xj1m94RkF
         xvBw==
X-Forwarded-Encrypted: i=1; AKwUvByWv7BOY2uyfAaXznUcwAvfJ30wJReolL4WkJwkliTY/mzEgixRwz9EhTaJM5s33wCFIHI=@vger.kernel.org
X-Gm-Message-State: AFuF++l57Ap+ZEo2gf8XRDXZXoNNn2Sy6iLQYvP0C42fSaliq5cRl9nc
	PtHmtOJSf4SrYDXWIRIJyL8dHBAY+pP2xS5GFtXD2118+IgN5owQzQZS
X-Gm-Gg: AYBFou23dxk8sHKV6JAVfbugN0OjC0Azk61FZFNck1IioE7+QU9Z6TzXP6Rb8Eq2LPW
	KzNkEbFGGXy2P8lF4uwjpPn+GfsVcCQB1CinragPRghxFJcDSAi//842qg9QXP0pHrtmuwvXBfc
	aqhr7LFt8oMMIPnaAYX1XzJ4/r6ctPlTpw3xXpRrqI9zmA9aTgCQn86doxS4qtXcZFQwNkKQ2Qc
	Nd7Y/IhkvBft33c4OJ744uDHVIAH0jEh/I7JK+vkUQdb86CXeErEVXhYCN1HXHhVIWZ/NT5NiEH
	F3K4+C0eIJiVzf7HJy4XH9Spafd4I8HRaZBfZrNCnzXVC8/60Z8m1tYS7Q9tCXW2dIKwUprJcN9
	By9nLJU7QPU6zpOK9Vx9FPgi1LVTGbkmNDNx1GnzcmKrd/6pcuRZJiDsZ084eUhHKQl62Ox5AU1
	SWTBAvrR7IzvzF1JjM9lcn7ZhOki9M3xogWCT1cVAHRfB5izCmve83dqWY+W14pe5+kPyOwa83t
	P/KjUa0tN5NjFE=
X-Received: by 2002:a05:6820:160b:b0:6b0:1b86:fb0 with SMTP id 006d021491bc7-6b6fe59c86dmr3821145eaf.31.1788524700176;
        Fri, 04 Sep 2026 05:25:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f787esm5880860eec.23.2026.09.04.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:24:59 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests: kvm: fix typos in comments
Date: Fri,  4 Sep 2026 17:54:41 +0530
Message-ID: <20260904122445.31163-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904122445.31163-1-hemanth.selam@gmail.com>
References: <20260904122445.31163-1-hemanth.selam@gmail.com>
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
-- 
2.48.1

