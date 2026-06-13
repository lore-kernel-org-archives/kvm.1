Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863571547C0
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309032; cv=none; b=TiHxZ+9/GyZrDfBJraK0xZDOMIHWH83GGg+PQ3JqY6sWGKv7jSF6QsmhniWXVGCZZmd3+7JAkfgzEGdeSsMKb+yZ8bQ57VWgU6l44TNPYzGfmOZRZgq0eDaQGfDUK35ioHpZQzqbHJQc7a+6ZAdNFsthDUE9xhfBKzUpqMYCoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309032; c=relaxed/simple;
	bh=b9LckI5BehWixBdPmRylIw5e7Y2lMreQZ8ECyuA630U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fjvlan2fUiqq5CRuyiC7/hTA8oMSX6i/VViVrslfLuJw+4DWn3fUbwSjICgG9pL2iALLEbWJSE8VMcsolR4JImPk5zOvDYafFcFzbmjKM57qcpZIfjJdQt6et1F5BOuPj6n6oParJbQLRYZoAwKoU52C4nqbkgkCTeLBomCJ+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eB6SgkF/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eB6SgkF/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8428419982eso1492586b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309030; x=1781913830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GbJY9rNxcfaJ1FMU+x/PiGQu0gL919x87Z1mxhGNJDY=;
        b=eB6SgkF/oFuzr2TcxTbp0fpMEFIW6DQncJny8dLnrhV/Weml0YcXzxwxoMuNpTZW9O
         irBTAYja5+U2LCOe5lFwG0vRs1E2Hf0yWCQnAu26+A/2GbVCkSH+TbNupZXjEodQVe1G
         ph7EUbXv8JSrg1YXQgvM7WJRgXfKDDJt4v3KgXux9zEpoWvJI8zXSHTcTVCdwyYS5kiU
         7CfFyFPC46dcKCTu9+hV592a/bvyBMTztfm8LsInTHy4i5xnr/3vk5h3wLUNFkt3COu0
         l/+9ePICIIlIBxtqL7p8vcpdnEDdRQfSWtkn9RjzVDTt8zRU4zgOHnY607/ye8ObVfF2
         QRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309030; x=1781913830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbJY9rNxcfaJ1FMU+x/PiGQu0gL919x87Z1mxhGNJDY=;
        b=BSulc7cVZdoaEgU2cRk4yk+CN5sElkC/MZqlFqfxyR4nTa8gC34czK3A7kdxvOwFGi
         57nP6bHVHL7ZKSvwL+mbjjgOOock2BQXNQToCuKKfNOkvy4ZvA8mRseNSMsmHIO0c/On
         EZesarLH4KcwdU8A5Jw+rH5uBDAY4kjidVCqUPx+dlUlrjqFGvOrnoz97S7AZ24yJ2YN
         FfExzzXCJh5QXgirom96ZZAzpk1yWI9tRaWfnNPv8X8VUTbyXjR3HHRqcwOtvPWbaSn0
         AgtQYUjIz7fBHSEh3xUVp0suy0IJ7mprKPaF4itS1e9/gUsDSreQ/RG5svuDLB1XJMyb
         KfEQ==
X-Gm-Message-State: AOJu0Yxq9VSpnGdjDR27madM2mfGHaj4CppLiXd6cAi83SzYpZE/aJtz
	EMo2/vPnRps4CtnAc0zTeee0lWJ1a4vojbgr1Ksci7aW8a1U0bWQ+w70MOsB2Qtc4eQ8kSoHvsC
	LxkE2XA==
X-Received: from pfbgx5.prod.google.com ([2002:a05:6a00:1e05:b0:83f:1682:d119])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d48:b0:838:127d:a167
 with SMTP id d2e1a72fcca58-844e1987135mr1965105b3a.16.1781309029709; Fri, 12
 Jun 2026 17:03:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:11 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-13-seanjc@google.com>
Subject: [PATCH v4 12/30] KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extract the code for getting/setting MSRs and MSR lists to dedicated
helpers in anticipation of moving the MSR code to a new msrs.c.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 135 ++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8f9a1572a39f..ece8d53fb7fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4602,6 +4602,61 @@ static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
 	return __kvm_x86_dev_get_attr(attr, &val);
 }
 
+static int kvm_get_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msrs_to_save,
+			 num_msrs_to_save * sizeof(u32)))
+		return -EFAULT;
+
+	if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
+			 &emulated_msrs, num_emulated_msrs * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_get_feature_msr_index_list(struct kvm_msr_list __user *user_msr_list)
+{
+	struct kvm_msr_list msr_list;
+	unsigned int n;
+
+	if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	n = msr_list.nmsrs;
+	msr_list.nmsrs = num_msr_based_features;
+	if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+		return -EFAULT;
+
+	if (n < msr_list.nmsrs)
+		return -E2BIG;
+
+	if (copy_to_user(user_msr_list->indices, &msr_based_features,
+			 num_msr_based_features * sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_get_feature_msrs(struct kvm_msrs __user *user_msrs)
+{
+	return msr_io(NULL, user_msrs, do_get_feature_msr, 1);
+}
+
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
 {
@@ -4609,32 +4664,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	long r;
 
 	switch (ioctl) {
-	case KVM_GET_MSR_INDEX_LIST: {
-		struct kvm_msr_list __user *user_msr_list = argp;
-		struct kvm_msr_list msr_list;
-		unsigned n;
-
-		r = -EFAULT;
-		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-			goto out;
-		n = msr_list.nmsrs;
-		msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
-		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-			goto out;
-		r = -E2BIG;
-		if (n < msr_list.nmsrs)
-			goto out;
-		r = -EFAULT;
-		if (copy_to_user(user_msr_list->indices, &msrs_to_save,
-				 num_msrs_to_save * sizeof(u32)))
-			goto out;
-		if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
-				 &emulated_msrs,
-				 num_emulated_msrs * sizeof(u32)))
-			goto out;
-		r = 0;
+	case KVM_GET_MSR_INDEX_LIST:
+		r = kvm_get_msr_index_list(argp);
 		break;
-	}
 	case KVM_GET_SUPPORTED_CPUID:
 	case KVM_GET_EMULATED_CPUID: {
 		struct kvm_cpuid2 __user *cpuid_arg = argp;
@@ -4662,30 +4694,11 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			goto out;
 		r = 0;
 		break;
-	case KVM_GET_MSR_FEATURE_INDEX_LIST: {
-		struct kvm_msr_list __user *user_msr_list = argp;
-		struct kvm_msr_list msr_list;
-		unsigned int n;
-
-		r = -EFAULT;
-		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
-			goto out;
-		n = msr_list.nmsrs;
-		msr_list.nmsrs = num_msr_based_features;
-		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
-			goto out;
-		r = -E2BIG;
-		if (n < msr_list.nmsrs)
-			goto out;
-		r = -EFAULT;
-		if (copy_to_user(user_msr_list->indices, &msr_based_features,
-				 num_msr_based_features * sizeof(u32)))
-			goto out;
-		r = 0;
+	case KVM_GET_MSR_FEATURE_INDEX_LIST:
+		r = kvm_get_feature_msr_index_list(argp);
 		break;
-	}
 	case KVM_GET_MSRS:
-		r = msr_io(NULL, argp, do_get_feature_msr, 1);
+		r = kvm_get_feature_msrs(argp);
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_GET_SUPPORTED_HV_CPUID:
@@ -5719,6 +5732,20 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int kvm_get_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_get_msr, 1);
+}
+
+static int kvm_set_msrs(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs)
+{
+	guard(srcu)(&vcpu->kvm->srcu);
+
+	return msr_io(vcpu, user_msrs, do_set_msr, 0);
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -5823,18 +5850,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
-	case KVM_GET_MSRS: {
-		int idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = msr_io(vcpu, argp, do_get_msr, 1);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	case KVM_GET_MSRS:
+		r = kvm_get_msrs(vcpu, argp);
 		break;
-	}
-	case KVM_SET_MSRS: {
-		int idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = msr_io(vcpu, argp, do_set_msr, 0);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	case KVM_SET_MSRS:
+		r = kvm_set_msrs(vcpu, argp);
 		break;
-	}
 	case KVM_GET_ONE_REG:
 	case KVM_SET_ONE_REG:
 		r = kvm_get_set_one_reg(vcpu, ioctl, argp);
-- 
2.54.0.1136.gdb2ca164c4-goog

