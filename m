Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6293C8704
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186524; cv=none; b=J1v6JF87C6z2j+cccibV4T9W2m3LB/bGzcHj+v4PLROFn3EYs75nhqNw/Jjo6FerzZj3/p+IMUv/enrhubhtBlY1ODe0w1o95xpRsFwPCqsCgzoRGp089MMXSLE+ODDS9NpQLvpH46vzO0LY94m2WIFKqQLEZVmW3KygLJ72cxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186524; c=relaxed/simple;
	bh=wCT56whpBWZMgqHPWbSdWWOQ4rqPp8/QKwF0p6KcqTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yo4Izy0FrmRaMy2833BOKsdWhkOe6wYaZnFtgMU13/t7LHu4Rmggiw2ZbHlHiW/iyvhk2N6oJ3MxaaAuNTiZ/zjBIORZze9eApcKeVaRoVZihGjiFPHfSrdG8AWsxpkY1hZ5O13inZUO7Y3XkYkMlxdi3+GvKp251put5ixwrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTG40A8o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTG40A8o"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae669a8ff1so402696115ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186523; x=1773791323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W84stS8+3WuLFZ+raEjrLuySDqRuwilAh+kUtsTzbCI=;
        b=MTG40A8o8HFRc56mbZoD+RnrWksX9sLnJSborcfiBrgXuZQ04LD3p4aEAd+o83xzRL
         IAhnpqxz3qn7Vu5HcS7cnV2BzvgGUX/QTTaPW4ftnEbNdx/Qz5c3Pxxt4bdZLWEdkHa5
         OrCn95ETrY28pRhjsUBDt2q9EaVFjG+DE3EdTaa1bQcwWu/RVQRLYek6UkYHkKc2aiUJ
         FXjWWKR/1HbukBfhMvIRTCR1kqTViA1+ZVNwwJuGCiXjSwNBaWTkwu6GG1JUMXWQofdB
         lb4eJcO2ei/ITzSBXts9eW0zRnPlJWVDJ+S357Ab83LXPkCI/cbRm6VGnOu8t74IPi7z
         zRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186523; x=1773791323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W84stS8+3WuLFZ+raEjrLuySDqRuwilAh+kUtsTzbCI=;
        b=Oz0IzEo7PZ4WK5nu6uIsnXdiEdhBLNA9LMEEm+cCGqSDDj0fne92rk7f6+GeCq++k1
         YT7vCSDvHmyHUnekY82gJOEpGrms6wZKuHa27aF/vXDPPCnEaA2JBPbKFReBdD8lvdkR
         3jc3CbbfrM3gRxtU8OzX6QaBYPJ1pdKlGwgNDonHLSxM94fs1ANVCzG3+I5NLSjLK+FO
         QVxbAmZ1pCXuTWOZ2ZqkhOS0OCehDyV0oShXOqMm43UFnhpq1t1u1eobWAOxL9AaJPMS
         HV2vtWKDOYAPCR1KsH2/gFG13E6+fIyF1r3+i2lmZqftzdAckVtMjcLkS7S5aYLU9LSP
         wgng==
X-Gm-Message-State: AOJu0Yx/XreEfStDSqlHYBMK+qaR/33Dl9zcA8Z4QF0iAXOl8z0Z9+AW
	fCiAl1Lun6O1o7nA7S0ja2AsKCW1JcKr3DH1Kc++1Bd6K5o9We0sLD6CFl7ZojHC3A8oi5xjd+i
	1fo64jg==
X-Received: from pgbcz14.prod.google.com ([2002:a05:6a02:230e:b0:c73:7981:791d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:2ae:5723:afb2
 with SMTP id d9443c01a7336-2aeae90050bmr4364395ad.54.1773186522529; Tue, 10
 Mar 2026 16:48:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:12 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-5-seanjc@google.com>
Subject: [PATCH 04/21] KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively
 being created
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Reject LAUNCH_FINISH for SEV-ES and SNP VMs if KVM is actively creating
one or more vCPUs, as KVM needs to process and encrypt each vCPU's VMSA.
Letting userspace create vCPUs while LAUNCH_FINISH is in-progress is
"fine", at least in the current code base, as kvm_for_each_vcpu() operates
on online_vcpus, LAUNCH_FINISH (all SEV+ sub-ioctls) holds kvm->mutex, and
fully onlining a vCPU in kvm_vm_ioctl_create_vcpu() is done under
kvm->mutex.  I.e. there's no difference between an in-progress vCPU and a
vCPU that is created entirely after LAUNCH_FINISH.

However, given that concurrent LAUNCH_FINISH and vCPU creation can't
possibly work (for any reasonable definition of "work"), since userspace
can't guarantee whether a particular vCPU will be encrypted or not,
disallow the combination as a hardening measure, to reduce the probability
of introducing bugs in the future, and to avoid having to reason about the
safety of future changes related to LAUNCH_FINISH.

Cc: Jethro Beekman <jethro@fortanix.com>
Closes: https://lore.kernel.org/all/b31f7c6e-2807-4662-bcdd-eea2c1e132fa@fortanix.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c   | 10 ++++++++--
 include/linux/kvm_host.h |  7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7da040baba1c..5de36bbc4c53 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1030,6 +1030,9 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = mutex_lock_killable(&vcpu->mutex);
 		if (ret)
@@ -2050,8 +2053,8 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
-	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(src) ||
+	    kvm_is_vcpu_creation_in_progress(dst))
 		return -EBUSY;
 
 	if (!sev_es_guest(src))
@@ -2450,6 +2453,9 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	unsigned long i;
 	int ret;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 34759a262b28..3c7f8557f7af 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1029,6 +1029,13 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	return NULL;
 }
 
+static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->lock);
+
+	return kvm->created_vcpus != atomic_read(&kvm->online_vcpus);
+}
+
 void kvm_destroy_vcpus(struct kvm *kvm);
 
 int kvm_trylock_all_vcpus(struct kvm *kvm);
-- 
2.53.0.473.g4a7958ca14-goog

