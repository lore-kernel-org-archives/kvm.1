Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF9411FB2
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419455; cv=none; b=VhFKYNEhTzAWRHqGd25VxTIRcuUMAZdUB4E0z3aBKk0kpc3/wclzFjnvLTLu5zMXbsN66JJwbXayPdl6vUBwze4QonxKE8SbvvV96PEN/cdF94f2vIQI3q54/sqpu6SToSLKV3EPOd24gGc8+ArHWgY/SUYEpQ/a/XCg1NE2K3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419455; c=relaxed/simple;
	bh=6fpG91MXXQbhpol2AXqdF9dFywJtNWGjaLWU4oYG/WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFko1p4c7I3NAK4gxEW2daY/1ygHrYWJ8dpmVTvLu8tvNkm1tE6ZJA+MLfk8H/YLUUNvyAAAKsPr2xTW0TeAb8eQhmt5AOAdhdC4gvUmxAU6k7dR7iAIDio/P66t/f4ZLA0sXcNTtDPq3wpORYcWZqVgtK+9exntwPUWkoI4Dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpPyjpE0; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpPyjpE0"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a0dc47fee0so211276a91.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790419447; x=1791024247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4odAGIPcyvnNWb4sPZdqKZBZfrGmbPznm9W/871R/J8=;
        b=gpPyjpE0W2/iAPPLe+T0ZBxcdXnLLgAw1ptx2Wd0eimx/Qx+jhrLJA/kIW5WXrtBpw
         HJ3Z+MKM3PTMOHNdvsKT4CvHd5nsa2IB7/Ro1rtHcoi3CTaLE/JLu1xdTMx1p7lSaliZ
         rs937LRjezREoomDOuciwdlR2SrefkeBkdyxWPH2GIF7jezpSc4oeL/FWTrpZYM6jwFI
         jQ4jO2RNovidbMbmE9i9IU2M+E0TYlD6u33L11AjuooVU3IvBFI+WvMY6nhM+8dGq8pR
         NhFpHgGxptetU7j+vay1tc3dau86ZnSuSoyCQCVH4gnC5zha+iEP2cI3GKO2huFyjAK8
         K9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790419447; x=1791024247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4odAGIPcyvnNWb4sPZdqKZBZfrGmbPznm9W/871R/J8=;
        b=VlGX1pty6Rzo6Oq9iSXHfKgeJx67PvzaXFoJViaH3hfcP793IGGLes2nP7hgTnK0ku
         1veun8PON4ymgMsHjl1yYnbz6wX+xEZpOXzJ5oWvhTsOhW5anhS8SAenBFmDbRKR09lf
         96tSnXmYZMAtbWWLEMJIXBbK0XnzKBy11dcYcbAVUNX01jr/xuTcIilMzHbJJj19gKxB
         GyJw4UF8n5+hwvXmzLWnV2uUTtBBPCKb+L+XspilU9vjnydrZCrtagyOj20BICf+Vli2
         z0UEoSm3OEtHKzYvIlgvmaoZDfExbRT+/kQQHIB73aw1NwKQyy7zVnQH9FQnEZRyQYPf
         cfJg==
X-Forwarded-Encrypted: i=1; AKwUvBxQJOLgKY7fjS7UzDp89ZfyuBSegnQ2Y1idqIOt1pG+nzua5S0KdGERDEhmjmbo8eT+bX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYINh5UzIOYa3siBYhkK2gqwnkrIGjQBvJWABhVLGxLDoKVvQ7yY
	WpVqIGBBM8UMeqZpadd8mGYGsEkGEQ1LNq/TL6oitXXrYaic8YbcYqaA
X-Gm-Gg: AYBFou3mOTEZYyE8yHKhSvwRc08scAckHo+kA0mXMpHsYg4Mb/aOZkgHxbuHCLutWMn
	OCMzVQvdkR+6LVQr44vPMn1ji7UsKc0pDwg3kwylrl5quUjbWbHv0xScQXa1jZS3s3/kGEGXN0K
	mYQzKNh/boEKyOzHYUGFmL4kdBs2LFBh4cUzNnKDA6BCS11b/i+OTCCxOZ/fvP2BmmMVYDyi68M
	+e/KTfepVvZZj/f2YwWlB8UZmsrQwmgD3qm+9p66oou8s2gRz0UYYpC1IJjRnT57VCTvZ5czUIv
	ViG3HCgS3LOGhU+TywKfJv7BpRq1YGe8nQVumGu35ugCVsmNl8tl8Ss2VLErwb8r5zhiM4ZUet2
	x/WbtKgAfQ90jcFuZdoS0e2kvpdg+pTZqZl3wX97vdXL4B5iyyFd5BfCFJ/FQ+Y9paPnTYtzSgp
	SBLMZo93xojJ2L9hJxG+L8WxJUNY0yRwkICFthUQTdZncc5Hb3UsYCeB39ef1z3YpX3iP3QTv8s
	CF47NXBK6FOY9JJGd0Rk7CWNQobGxtMxg==
X-Received: by 2002:a17:90b:1f90:b0:39e:6c69:f47b with SMTP id 98e67ed59e1d1-3a098d4085dmr7176558a91.58.1790419446869;
        Sat, 26 Sep 2026 03:44:06 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:819f:6ccc:5ca5:5f73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm15800578a91.6.2026.09.26.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 03:44:06 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH] KVM: selftests: Verify KVM_MSR_EXIT_REASON_INVAL on reserved EFER write
Date: Sat, 26 Sep 2026 17:43:55 +0700
Message-ID: <20260926104355.13697-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The msr_filter_deny test covers the FILTER and UNKNOWN MSR exit
reasons, but nothing exercises KVM_MSR_EXIT_REASON_INVAL.

Have the guest set a reserved bit (bit 63) in EFER while preserving
the other bits, and verify that the write exits to userspace with
KVM_MSR_EXIT_REASON_INVAL along with the attempted value.

Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
Tested on Intel Core i5-10210U (VMX). Not tested on AMD.
---
 .../selftests/kvm/x86/userspace_msr_exit_test.c      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
index 2808ce727e5f..7446e1404264 100644
--- a/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
@@ -309,6 +309,9 @@ static void guest_msr_calls(bool trapped)
 	/* Invalid MSR, should always be handled by user space exit */
 	GUEST_ASSERT(rdmsr(0xdeadbeef) == 0xdeadbeef);
 	wrmsr(0xdeadbeef, 0x1234);
+
+	/* Setting a reserved EFER bit is rejected by KVM, exit with INVAL */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | BIT_ULL(63));
 }
 
 static void guest_code_filter_deny(void)
@@ -627,6 +630,13 @@ static void handle_wrmsr(struct kvm_run *run)
 		TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_UNKNOWN,
 			    "deadbeef trap w/o inval fault");
 	}
+
+	if (run->msr.index == MSR_EFER) {
+		TEST_ASSERT(run->msr.data & BIT_ULL(63),
+			    "MSR_EFER data missing reserved bit");
+		TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_INVAL,
+			    "MSR_EFER trap w/o inval fault");
+	}
 }
 
 KVM_ONE_VCPU_TEST(user_msr, msr_filter_deny, guest_code_filter_deny)
@@ -667,7 +677,7 @@ KVM_ONE_VCPU_TEST(user_msr, msr_filter_deny, guest_code_filter_deny)
 
 done:
 	TEST_ASSERT(msr_reads == 4, "Handled 4 rdmsr in user space");
-	TEST_ASSERT(msr_writes == 3, "Handled 3 wrmsr in user space");
+	TEST_ASSERT(msr_writes == 5, "Handled 5 wrmsr in user space");
 }
 
 KVM_ONE_VCPU_TEST(user_msr, msr_permission_bitmap, guest_code_permission_bitmap)
-- 
2.53.0

