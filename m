Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA224437845
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510547; cv=none; b=Rqwo3NEsEQ7TdeNYGNRn6gHFY65a7LpICDUkWYdl057Z9ifHH1NAvYrRslEG2EeLaazVrywk5jvDs7qEfXDCau/D9I7Bw41NGQmN5PzQjFLCi0Z/aa0D1dv82TbI+SbnyahgC+HXtmQ/vN5LHRdU/ZJXtBbnZlyhc/Z1mQdZjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510547; c=relaxed/simple;
	bh=AIVWrh6CF4CKx4RF7vzN6YiuXpAZvS5KqSwfzePjOCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h53OVXrNh6sLoM/LiOHstNJHNbehe+fCwYiksrZmtYt+Ji1D/vFnsoU7tDKYy6fKntwtAyIX20KPKmiJp8pkFE75V4ffWQTJ7nXNFtOZvfuU3ZaVqj/x586r0FX5N+DNC37i92ri0uZO1UfXfKsJbL5tKSpURsGBvHbWLPfUgv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JkGWWF5g; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkGWWF5g"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15dd4b9132so173073466b.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785510534; x=1786115334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOaXPDNzFmfCcFZASeKm4HD2Emk8ASo1ynV4rSmHLg0=;
        b=JkGWWF5gOjxkMrtpUQnC0kHCKCA3ttjqTCMdQPIQE2A5UYwLq1eZL4gKLP0DQkuRt1
         n0DZRcuOr9wrD1JRrLw8AAIUsjdiLUdraGfE14xZ/yooQKHdvOBT4aDlBOe41XykaCSh
         9csXID9vksGdyUNwsRh43D2hL2GY3ojFIfix8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510534; x=1786115334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOaXPDNzFmfCcFZASeKm4HD2Emk8ASo1ynV4rSmHLg0=;
        b=pp6xpxgD79AzwHI+koLJL0L2xjt2MoaLuHsIRdKiBE+wFF0SBREXczds8hxeIeDsBc
         ErAzNv/jMW1HscxXh3TtkThxGb7OnK5XlFRztTzoaknNY/oX3SYbs2lgc4311w9WqmkR
         o059BMRnpyXyl+RryTQuEGt8LFauLORP7EKr4h3rUteh91XW9JTin1FcKggzd25gm7nY
         l1JcV+QDop4aebdpiIQBKpMnoUcEqwcmGbPzIZnp7+tSgv1itB0ANFEFWmVnFd1i3IpM
         ROBwhfIHiCuGy9yovijOg3YLNOoZvEczD6187lq7koodVHnYYvPGX7WKhW6nYcmxDUxO
         xqQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGjvOwCCEm+bgTEoXIs1M9SMS623b4Jgpfcyb1aRUkd4Mc47JSYCGPORVG5I/w5FPYOhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tnMM82/Q/Td5mLjTGKQFQT9S+SxrX/EssG56OaPBzqdNl/Xy
	GbIa0mPwa3bueb++wClNEWszAlW1d2cpLCPC8RtQUGCig95QP9KrLvd+lX4/1vPgoQ==
X-Gm-Gg: AR+sD109QNse3TlsjhezqXT2XzYQjleexBtulFWy6L3kS9bHf8UqTF2obrTK6wMmgLG
	KvfEDuw16v9wudPTqKvDux6BhgUHHJ9RN3gSyqXHS6vrcIgtectIjCdEcaeEzMSnLCbEVcCEpfB
	YRKV2KTpwfxtEq8QHU3I8X7BW8WtdhfW1uNtKgftZd9vCtMbGNofUId+hmFxg36vhAjnnJFuAU+
	ajON0ElGkbrdoY6h19v06P9o9l13seiwfOrOjLI9l8o4PjuR23mAFNsaPcTjPMXpA6UZonecGeR
	t0Lq0gbw+8NQdUZnA7IJGRtojfGXkmJEf8bs4OJ5XqvztKrYU/kH7PD/1xqzWmdPFdx++sAjbyD
	4PIho6fks02jGtYDcVm5WfrWAHuVNpKOGP5bdVyxqrGmONa2rpHIqMSxKtoWA+XlKAnzUfl19eD
	r+UYSyTPT4JiqM+57yqScwcyFiy12fVEIbQHPuBQoIERuOJBgkRJxZZ3H6piSNnXJoyTi1gSBTw
	KUWl17vuHd6MWJ9e4PRKuKcKeevRYpkaLl/gmNhcfuEh5axpwOJDrA=
X-Received: by 2002:a05:6938:a08a:10b0:c1f:e172:cf16 with SMTP id a640c23a62f3a-c1fe172d0aamr53127366b.46.1785510534451;
        Fri, 31 Jul 2026 08:08:54 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5647974f8f.34.2026.07.31.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:08:54 -0700 (PDT)
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
Subject: [PATCH v2 2/4] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
Date: Fri, 31 Jul 2026 15:08:43 +0000
Message-ID: <20260731150846.1728164-3-dmaluka@chromium.org>
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

max_vcpu_ids and KVM_CAP_MAX_VCPU_ID are exclusive, i.e. the maximum
allowed vcpu_id value is max_vcpu_ids minus one, not max_vcpu_ids.

Fix sanity checks for KVM_SET_BOOT_CPU_ID and KVM_CAP_MAX_VCPU_ID to
correctly fail when bsp_vcpu_id is set to max_vcpu_ids, not to a value
below max_vcpu_ids.

Fixes: 7c305d5118e6 ("KVM: x86: Limit check IDs for KVM_SET_BOOT_CPU_ID")
Fixes: d29bf2ca1404 ("KVM: x86: Prevent excluding the BSP on setting max_vcpu_ids")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47cb9eba113b..b576b46869d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6908,7 +6908,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 
 		mutex_lock(&kvm->lock);
-		if (kvm->arch.bsp_vcpu_id > cap->args[0]) {
+		if (kvm->arch.bsp_vcpu_id >= cap->args[0]) {
 			;
 		} else if (kvm->arch.max_vcpu_ids == cap->args[0]) {
 			r = 0;
@@ -7478,8 +7478,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		mutex_lock(&kvm->lock);
 		if (kvm->created_vcpus)
 			r = -EBUSY;
-		else if (arg > KVM_MAX_VCPU_IDS ||
-			 (kvm->arch.max_vcpu_ids && arg > kvm->arch.max_vcpu_ids))
+		else if (arg >= KVM_MAX_VCPU_IDS ||
+			 (kvm->arch.max_vcpu_ids && arg >= kvm->arch.max_vcpu_ids))
 			r = -EINVAL;
 		else
 			kvm->arch.bsp_vcpu_id = arg;
-- 
2.55.0.508.g3f0d502094-goog

