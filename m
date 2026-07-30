Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7E45040E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435880; cv=none; b=ZczxvXUBqyUA6+kxn7AoPejRugXUh4PsjSVuUNHzFCf8xEvv2KM06I0Dk2gg70obL93hJpoxw8Ax0x7D48wWzlYJEIrME1kT8vJhEUohJpsoDXV8oFVDabXZWGTjYxdIR+ojmafTFSSNzX3Kld/Zo1NBJnHiM9D3pAnaDkfIWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435880; c=relaxed/simple;
	bh=UXU/5sPrRMMjD67ui/3POHpRT2doFWGnNkcKzGUyi4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJReEEonI1ZcxV9BEmcYFN+2HEHq3IkiESRP4QkRMs1F3r1hI8A8iYuI9GLAk6edyDhfgInDXrcUgiQsWZxOe/4oHR7aqi3cBlc6QC+ss9LXGEXoy/gtOz4HYXf0c0p9yYUmJU0E5JcYcFkUSaxmDwqTBkXS62sZAWN90tgXzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wt+bgFyf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wt+bgFyf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954dff6536so569705e9.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785435874; x=1786040674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYrW4b/0joKOvqhU75nrHLcpc5zn0NBzDI0mlsk/bj8=;
        b=Wt+bgFyfZnlmGyWwTxxexHXs2RKcHaR/eEghRAN6XEPizAiLboz040unGBwS9Bt5dN
         jLTrhb5BNLb0/MuI+lNknsQf0Bj5XAD5H7ekGgYTdM1dz3uUI01cIhL+Cm91F3jl3EVx
         kXCmsXJUdiHmALcInMhTEwHK/2aliT7Q6ui/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435874; x=1786040674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYrW4b/0joKOvqhU75nrHLcpc5zn0NBzDI0mlsk/bj8=;
        b=X1SlsK4rmWUorJPtZCJ3vwoRnFdikVuAsR5144mrMr9As8cyrSoPsADJADdP85KllA
         POL3hkijuGx00rzhlq6qFdzN4O6iHxoYslCU6HGEt8UX2OYu/dz8HflT1YG3JR8sUbDF
         jYq75UnkMoTjyHj2rUdWg/nbleb4Jfo+mfS2hzcaEGgy/0kqFeoeaAM5PWqT1bJ5lftm
         NZr6oL54AnDAZcjxsuF/fLY0OZwORSTQYd8QSX4xp47giCt1NJ7b7JPTuMucfVXUbi3d
         aOwrKwIkB6cBI5iSPrhSWsxmCL3gQoA0zq+kDp24h+qIr7O9JF0/pRmmPtpjFnf8ImYV
         5GBA==
X-Forwarded-Encrypted: i=1; AHgh+RpZfMNLImU7BGr1YI0aRpH/ncmrW8bYsPfil6AbbABWexHnHhKYDGbvXvgnC/XA4jJnVxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rhQAJhR4DNhSl/LEVpFq44oh7qJA1zNFtgwRzSuf1cWXrtP9
	mVgEhA1nzv6ER26h10KLXtWl+3tUi5FKS6WIV2NlpePJRFH8vxv0LCpbkaipUFrrjA==
X-Gm-Gg: AR+sD1199B1IPfL9CTKWCPElY45XsqAQhNTSrnhRJ+WNZnj+4lttAIA/RRTaadXp2Kj
	hM4/HmoJqlD0r27WDsbG7QLkx2yAKF0HK1IOyNXzb9lOzvq1XYMi9GjFhQyXvjuGXajmvXp8j2S
	Dz8ESe1Nuf8pwS0NlLMEmKB4pJqax4h4Z2HGbgKlhEHyKq8AzDsuLixuHWtMcG8oApan0XAW5gO
	ZRAgLxPlWkn4shwHAmrLIUTWzGHVjiH3AlhGdb8cngTxlvxpHoemKGvu+i94dl002LmEE4enDTu
	bnYnlUfgw1fF20185WQ7GI9W+Ozo/ALXJ8MzwRmGCGczAjWKStcpF2ES5D/4anFsKCazvCTMQfC
	snHCLJxXXNDT3QCBdeDMchyxBdhmbRqARH13scPOyCivdLKjw1n0f1IDY635Ezm6iLqJzrkYBrl
	o6ltnW7ix49Uyq8tgv6y1e/qM4VWhXZgqX/7CeWDwP75hB0jVGSxmKFNLm5wwLxhyubYb4TkJxu
	k5oXWsKB2suW0fv82IvLKNNtue9bm9jVQMDIkhrknwcN6DNGJOykBU=
X-Received: by 2002:a05:600c:4693:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49800ea1ab2mr53695485e9.19.1785435873918;
        Thu, 30 Jul 2026 11:24:33 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aade3sm84008685e9.14.2026.07.30.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:24:33 -0700 (PDT)
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
Subject: [PATCH 2/3] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
Date: Thu, 30 Jul 2026 18:24:24 +0000
Message-ID: <20260730182425.1223530-3-dmaluka@chromium.org>
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

max_vcpu_ids and KVM_CAP_MAX_VCPU_ID are exclusive, i.e. the maximum
allowed vcpu_id value is max_vcpu_ids minus one, not max_vcpu_ids.

Fix sanity checks for KVM_SET_BOOT_CPU_ID and KVM_CAP_MAX_VCPU_ID to
fail when bsp_vcpu_id is incorrectly set to max_vcpu_ids, not to a value
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

