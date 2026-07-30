Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A144E045
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435878; cv=none; b=cTuAU/pOGbEELhQ2VjTUoLniAt9Xpk+ONH2MVczK1ahNPYmntykCUdKs5/ufuULfFi0pmtoqGP0sLUFmsP93nF0ma/NJZwVRY4Vg3cYTffTmg00E9NSRj/V7NAlYkZo4zCUArFlUX+KBmMfMzPq04RjRXzwR6LWlJr2JCllvDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435878; c=relaxed/simple;
	bh=9sV36zm4Pp0vB7jfMDxNs36acLATXLKZM+RqCQGuQ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFgbep38VJK91gPA+q+KDgr21WH9GPsm+jL6jcD5Fbecx7H7tkpb3UieMZ7DNMxCf7GI/eXKwrnx10W16GxGya7iF6rbbzAXy3a0PriqbGYCVB2OEG7/dO8Wx92PWWeTIUeSkfFQDFnya/sUK7930WisQrYBNSMRtDG0QfE17Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lA4v9oif; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lA4v9oif"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso576755e9.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785435873; x=1786040673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbirN5OGmG09g2d8b+3odPVgp6feGkgDgocLsc+TSTY=;
        b=lA4v9oifTrmHcH0q9YjSwQFIx8ZCeXR9qLlohFodYpAW0KpLprAw/teOU2VwGVMj3T
         FVNO73xKVIO1Vt6ylTLLKBpKJRn95cSP7sgp5SrP+nk5UgB5OQRolhRInRv7JmARllxY
         wWl6+vNgl1KYeodD8fncqEsKmL6hkfZdLDTW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435873; x=1786040673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbirN5OGmG09g2d8b+3odPVgp6feGkgDgocLsc+TSTY=;
        b=oRRSpHd8R1hnopdkSIncW1r9C6aa3KiCpS977A58wKw+mkaUdnl3sj+YSV4YKarZbm
         DHiSrnvw9eYmQBpx8JZRbEN84LLMH/3aJ2XcGMsb1IOFEDVfKC0yt52Fdn7NvxCSN2BO
         iBwRb6xFsI4675aCDVR5qbxSX1qkot4S2cymfH1eT22NwOjDqzl1+ZlhT0X2Fy69WANl
         pv+f1D+YYlSn545lcQYd4Q4fZsfH0bN28fOUeegRvHgFl6X3FfUH6wzSKMz03HS6l6Bg
         THUTFodWXHitgVdJmvQ1E3QV5RuIC5sFwVOLH9ivHAnuM5pK5goV7xExw7vnqkVSMMd9
         8jTw==
X-Forwarded-Encrypted: i=1; AHgh+RpdNYVPqSagfsHXMSTebepJWOSUH2jcmyuyFL3xf4WsdHBX92RF/9Y0ozfNxo7s136Tf7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrZrcHVvW74CZ8QMN4jbNjh4ADEoHadAAxtoZhfg0fzszvXka
	M9bgOPVF4E8LltfpDxBXrQStPY/6t+4qGVMI26GgnVm9dZmINJinJkOnJuo5CD4IPw==
X-Gm-Gg: AR+sD12pXmYe6hDdmy4A0y55CVEfsbwqwy3IOJW4KyfKHYYEJ5qRdlOOP/MhelLJda+
	389M/86r2J3cJ5T1SesADg3yzpwABWBMpwT5fez8VBkjj7xK9gFeEmDCNLkGg3oQDSnaf5HHcKN
	z1gAh7LfcKMiG1B9A+hj2wK/p6WaX4ect0v9SkjqBwn2lKDhay5YjK8WR59zOHPXZkKdIz9kc1b
	upDpyQdQdFkpqQu6PMQVJI9OHi6VAW9+M+ENtCCPgdFPNAS6vTMlXKmjCtrMDjVKlAIOdkWsClE
	1OS0aLQLyZNKOr/P9AqCCiYaOWJkrCgDWRXphz7dIEec65L09NVOwAvcdHbBsma6+cLz0R9bUiw
	8zhn6zUdqHzmzteLlmiFJEKsxa39n8NziTCsc1h3RCbnAuhXnC8h3ajYt/TJVJmT5519fIk12nG
	vV7U4kXmui9pSM+TLoR3l11kXEluBkhdE0g5U9q9cl6YIT79Uw21F1FjooA/+3cJdmfcdps2/hV
	ZWFkfaunp/HmGjd7Oy75r4XLoyTgyl978fYA9RNYVjA3i0MyF9dI3U=
X-Received: by 2002:a05:600c:6099:b0:496:c18c:f998 with SMTP id 5b1f17b1804b1-49800ea2197mr53831885e9.19.1785435872774;
        Thu, 30 Jul 2026 11:24:32 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aade3sm84008685e9.14.2026.07.30.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:24:32 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH 1/3] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
Date: Thu, 30 Jul 2026 18:24:23 +0000
Message-ID: <20260730182425.1223530-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260730182425.1223530-1-dmaluka@chromium.org>
References: <20260730182425.1223530-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_CAP_MAX_VCPU_ID is (confusingly) exclusive, i.e. the maximum allowed
vcpu_id value is KVM_CAP_MAX_VCPU_ID minus one.

Some tests in x86/max_vcpuid_cap_test.c and kvm/x86/set_boot_cpu_id.c
mistakenly treat it as inclusive, in particular, assume that setting
bsp_vcpu_id to KVM_CAP_MAX_VCPU_ID is valid and should succeed. Fix
those tests.

Fixes: 4b451a57809c ("KVM: selftests: Test max vCPU IDs corner cases")
Fixes: 438a496b9041 ("KVM: selftests: Test vCPU boot IDs above 2^32 and MAX_VCPU_ID")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 .../selftests/kvm/x86/max_vcpuid_cap_test.c     | 17 ++++++++++-------
 .../testing/selftests/kvm/x86/set_boot_cpu_id.c |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
index 7e2bfb3c3f3b..43f16c052de4 100644
--- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
+++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
@@ -30,22 +30,25 @@ int main(int argc, char *argv[])
 	if (kvm_has_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
 		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)MAX_VCPU_ID);
 
-		/* Try setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID */
-		ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID - 1);
+		/* Try setting KVM_CAP_MAX_VCPU_ID below or equal to BOOT_CPU_ID */
+		ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
 		TEST_ASSERT(ret < 0,
-			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
+			    "Setting KVM_CAP_MAX_VCPU_ID <= BOOT_CPU_ID should fail");
 	}
 
-	/* Set KVM_CAP_MAX_VCPU_ID */
-	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
+	/*
+	 * Set KVM_CAP_MAX_VCPU_ID. Note: KVM_CAP_MAX_VCPU_ID is a misnomer,
+	 * it actually represents maximum vcpu_id plus one.
+	 */
+	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
 
 	/* Try to set KVM_CAP_MAX_VCPU_ID again */
-	ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
+	ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 2);
 	TEST_ASSERT(ret < 0,
 		    "Setting KVM_CAP_MAX_VCPU_ID multiple times should fail");
 
 	/* Create vCPU with id beyond KVM_CAP_MAX_VCPU_ID cap */
-	ret = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)MAX_VCPU_ID);
+	ret = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(MAX_VCPU_ID + 1));
 	TEST_ASSERT(ret < 0, "Creating vCPU with ID > MAX_VCPU_ID should fail");
 
 	/* Create vCPU with bits 63:32 != 0, but an otherwise valid id */
diff --git a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
index 8e3898646c69..1c4ebdf8e82c 100644
--- a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
@@ -39,8 +39,8 @@ static void test_set_invalid_bsp(struct kvm_vm *vm)
 	int r;
 
 	if (max_vcpu_id) {
-		r = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(max_vcpu_id + 1));
-		TEST_ASSERT(r == -1 && errno == EINVAL, "BSP with ID > MAX should fail");
+		r = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)max_vcpu_id);
+		TEST_ASSERT(r == -1 && errno == EINVAL, "BSP with ID >= MAX should fail");
 	}
 
 	r = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(1L << 32));
-- 
2.55.0.508.g3f0d502094-goog

