Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D76466B5C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093393; cv=none; b=tSoNtw/kO844ulQGq0C2EgWTW8nIA8k+/wBkjjyUfR1uwRKBc0tGkLWYbbBXHKWZlGCoBROzDmSaDTvDgJzN5yGd6p03QroJl93MABHalP7mCYnYjrjMS0bTwF5MtHPqFheJJeIVCqn2+nEDZMQVpJVm8jjiTBzwOiERl09PCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093393; c=relaxed/simple;
	bh=U16q5I4nJv94rNXxPlbWDmKybiGw1J1K0KEk+xMy+jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koFcqQ3icvX20Ex/vvc7n08FzqO1SrDcYl2B12X1SIb8JK2Nb2rPiVj2+vpYnyRpMuDCkC/eE1Xa0OKVD5F6lKaIF3lCeVKXkpGeXfbX2BMeYQnNrStrwATKORQmQ6PqKvqBY5i0WjuUNjV5BT4ID5k7VqFatnrQz5WydOPZxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrCH4fgx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrCH4fgx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b9106b0fbso1632488a91.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093391; x=1780698191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g41Ygn6Uf+1kQN9znuZTAZ86kg1U3hWntwdYhg6VgHo=;
        b=jrCH4fgxpAOldu3iKMoydnGt5gEkDhHaphzg7y1EsF8GvAQ1+OAoycVlPudH64FI1c
         tISjjglPLx7yVoBb+PwIBna3a7mHj2tkjev6G9bosur1mozYPaLblKox0YB2DszbI6RR
         shUK6T+FSJKrNgkDyRcwjpD7vswL/LkvvPU3asdMAT8R/mKG58Nm1PcpJyO4+6mSaEFk
         bJJnOj/OCVVImm3RqRhwARNsNxf1GOKFX7233nhaSE7snNIn4CBfBSupTMWAcnLSpC/N
         D8ZE6J3ZSbhjuLOChiloHKxIv+OGQx10ODWpcsVI5im9GEc98Auz38bAQrf6LZzaVO5R
         YUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093391; x=1780698191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g41Ygn6Uf+1kQN9znuZTAZ86kg1U3hWntwdYhg6VgHo=;
        b=ZVpjUAIYQa61Jcqz3MbWmFJebxkC7NZD34A+kRhZRIi2REQLuZzEnF/vqB5ud0NV2Q
         W2n2F7KrVFmgnXeD/1ve9gEKxC/MrEi3KhEZfX+fWKm6T08bBzCY6N7z6jRBwf5s77Ob
         +7HbLqJOsZh/2mWfziO5c9MPyk4L/6jRx+mt2ryhPP2PXyWUMeaniPbnAMVY3W9bm1uw
         NPGz98iKzPxbzLuv/4Ix1YrF/zvQf4oNrNL5C2aGAqxSSMP6v/eTDke02PJiaDIl7AuH
         gehVyBujj3G0o/RQ51t1lMKDYGx20CT1YupLN1HUyERPjG4u9CoVVvAGUZkjPpmCZhWB
         /nvA==
X-Gm-Message-State: AOJu0YwTHvtX2OsWXxnduE8vUwmrpxdnyTJBQ5IzPf2HskOh0CoaIwz7
	rnKYEWZKwetjhx/4qagtgCCP1LWjGmHI3LpMZ6+EpAk0OJ6DF4Wj4kirJ0ZaHlU1hxVC67iV+ky
	raq/awg==
X-Received: from pfbfx13.prod.google.com ([2002:a05:6a00:820d:b0:82c:90c5:5e0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:439f:b0:3a2:c7e1:ff89
 with SMTP id adf61e73a8af0-3b4267562bamr1285241637.7.1780093390874; Fri, 29
 May 2026 15:23:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:07 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-25-seanjc@google.com>
Subject: [PATCH v3 24/40] KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extract the code for getting/setting MSRs and MSR lists to dedicated
helpers in anticipation of moving the MSR code to a new msrs.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 135 ++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 56ccb6b77abb..64c3680d889b 100644
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
+				num_msrs_to_save * sizeof(u32)))
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
+				num_msr_based_features * sizeof(u32)))
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
2.54.0.823.g6e5bcc1fc9-goog

