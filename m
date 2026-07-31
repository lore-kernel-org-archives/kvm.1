Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CD43933F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510549; cv=none; b=Cqs8e1FJVqLm9rr+Dm598pYsWAFstGHrVaJkp2mQ7OfnN2yVXYqTgbEla4RFSn9PeIhgFshQiI2/mWk/xYTzVkCsOK2aTTaiyjClXRIv5XvaZVjAp6g6/bJoOZ8dQ9HuFjlSuAFou51Rtpb3oOPZBpWDEpqj6fTYqknw3HS+qBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510549; c=relaxed/simple;
	bh=tvuGJlpxe994ywBTZBk8oLyVZiPfdQoTV1v2claAJ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aogrhXvJqPCten3dqXefFoAcIRRjtwAd7tkNESOV9yx1T0lQJoEwvXb+ZP/EN5gAd6bNnTzYSVfsP4AI4LuayPEGgJjbc5DC1pFAYIbEYdMx5sAHPJfPrkSerItR9jXFm9qyz/AVv6IqLfHu0P4gOj2v2QoQzigkEUwkOvRVM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oMqG93NA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMqG93NA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso725181f8f.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785510536; x=1786115336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNQVoJLOAt300tBIc7RjPTSBrNrM6NOapAN0DpYPO7A=;
        b=oMqG93NAd1Pa+dw1ySgixP4sB/5dgOY2hXyEFi8MoAtT5Z0OPtV7uPC5tb3UCYoASu
         zkNly5iN3R0EpA+RpjftQRQI96/fSzjrELNFliuBDYfHS4WaWujnjrEJRZDwX2LDw6Ya
         911CbRDCuYsbMpK6v6kWP/+LrdoCsi87FZJug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510536; x=1786115336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNQVoJLOAt300tBIc7RjPTSBrNrM6NOapAN0DpYPO7A=;
        b=sltvStyalDZXvqAfyiY5QcMDnsqE7jkgkMPjtjZh9jrO1lJu46fwcL6fi9am0H2bY5
         xlJJ1frRYBx0i+Ji5x/o4t48SI3bBRilz8mr5BFJsitjcKvNeU/ktjQIQLFHRRucfdR9
         fv9nmc8axwN3n3Vz3cIsHULl4+k5TYTlld2we+fKvkYS+OFQ8iBmgfYqw7iOry34iF6Q
         3gKsvzVEsP+jsFby7RekTghPrGzVbmKDFE9k/IuoUAP8aCtwJZlTyaw1E0LWDLh6gVkE
         P+vxEyC5MrSexYkuLoDaQowriOi4GH/5kmBdltuzOxQK+Qr+GH3yJ7+ZfRNWIIjAIK9g
         eyxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqbo++G89Fyz+CqCk4QRrYhiLLyg0fMzzCYzB/IPAtE7pN8UnSQjXfwVunhhbEnMT2fzqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4P0sp5uhOwsXhy2vIJlsUSEjwxSZVL8l2zXuwnwi16MLq3p9w
	ocEHN5dHOA1IKK09JvSdYt1BYKiKUI2OXuAvalQLWvEvQTS1ZK6o5O96Pdr2XZcxsw==
X-Gm-Gg: AR+sD12n2Weo/qHLQ9KgQVaeJPhBIx2AXQiAEUlYGIOLEcryJk5TYhoY+Og5HDytSAO
	+vVeAjgbpqjh9X61tjJRVR5llW8bC26f5mxTMnaXngoeZCeT6X68qYJTo0zy7PPxT02qnvuabdT
	S5zDTJvkUamnRrDn8FGrdir/n7BlQ/OvJqveRK5tGlwxozgCTyuPaVjbPVhDFIRzn00fqRWJxPA
	+hhkLqe0sENyL7mqqO9eRBAu5ZY23vtCsNK9S9wtviGH5+eJilO9KYK2w6a7UYHm6y/LkPQSLR4
	2laN0II0CT50dyq7R5/xrB/a8LtCMihiX9gCHlMIfQmebWrpY/txEtfEhbJ8lG6ghOjzdUeZBnx
	d5ANsCT6eUMJSCXfijdzICNVoBHuhXFh6qgwMSNUL6409qf94xFRFdAq4IAkygE70Rc0fFeZmDu
	y9zIvgvw1+XzUUvNhWcSkoq03SUfzYB1kn6kYO0HmsG+f3FQZ6jicdTyqqxf9ZqKDc0UsHaFxXz
	Zvvtk7QH9wZb5pKaRxqDdAE+ZzbUhuTDm0qVJDRmfpicVI0TpSvvJM=
X-Received: by 2002:a05:6000:60f:b0:47f:8112:f793 with SMTP id ffacd0b85a97d-47fd72b5cd7mr50971f8f.13.1785510535599;
        Fri, 31 Jul 2026 08:08:55 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5647974f8f.34.2026.07.31.08.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:08:55 -0700 (PDT)
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
Subject: [PATCH v2 3/4] KVM: selftests: Improve bsp_vcpu_id and max_vcpu_ids out-of-bound tests
Date: Fri, 31 Jul 2026 15:08:44 +0000
Message-ID: <20260731150846.1728164-4-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260731150846.1728164-1-dmaluka@chromium.org>
References: <20260731150846.1728164-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that KVM correctly fails with -EINVAL when attempting to set
bsp_vcpu_id to the value of max_vcpu_ids (not just to a greater value)
and vice versa, improve corresponding tests to cover this corner case
as well.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c | 6 +++---
 tools/testing/selftests/kvm/x86/set_boot_cpu_id.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
index 47ee14967873..43f16c052de4 100644
--- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
+++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
@@ -30,10 +30,10 @@ int main(int argc, char *argv[])
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
 
 	/*
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

