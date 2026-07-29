Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5603C1D72
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344795; cv=none; b=pInXKWekow93VAfcZFV87sx/RICi7buvxb8wgyNBdA76OSeV3/OoaV2B4V1/oPL9jDGdtoE3kQSEJ3uu1imsFxdblcJP6xoWxxVtDxj7NkvfjQcan/TGBR2mgApB57nQI/kQ/7qfBCny92ckNAZ0Bp789r6Sb+sYn8f7bv6TPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344795; c=relaxed/simple;
	bh=gQV+oA8dHAh9NyVh4jmgVndq914N0D4KL5WtvsnYJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qndzymB7OTV6P+7TudHXiASkFgoSkXhIlcuonXERcvWFL45QAi46U6YR7leB57LpBfThuLh0bc/SSRkHXkc4FWlfagGLAl7dZV46NJrqzQV7G2qh7RIZIJPs40ggSnVu6xeD0zeAzdhn3KEyWvKBC/VggYqJfbIi+OpIcM1yzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UmMTrauO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmMTrauO"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15dd4b9132so190978466b.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785344792; x=1785949592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjCULYYFmjqcqzs4KKnIVY3J9skRPRrh5u08j6m5z2o=;
        b=UmMTrauO87dsVz3YiQf0xvrugQ9WMxqDY6khCHF7PZTPYoNtVLHHDRDVcr5aa/m81s
         WzEnV5DsKIH5UfQY5Z4Ea+W7FhNXugoNvGPlsNHjYq5jVWRaquqP8xgmstvejV749Dgr
         U1zEMOA78sNKHLrKHwIEBcpv9tHXKqkd+2uCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344792; x=1785949592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjCULYYFmjqcqzs4KKnIVY3J9skRPRrh5u08j6m5z2o=;
        b=Jmkg76kl0mTR0mXRMXnz2m/uphmKPSDUgJNQVayUDjKC874RItW2PCLAPwOA1vZfDd
         YvXHm393fEHKA8nKPEcZVIE5nxgezd4cV2IJ63ZRIGE9s2mCta1+9YM+Pk8gW0F3crRc
         wCDeP2ngPCyuTlYbsPy7JMiu13lce6UL/JzjLizIO7sIkAcchHoIZVdXnwoSGD7wCbQq
         oHLRVbYloi/dxsFA+LeH9cRsVCyhtZ5+vaNnWU7KqJqD2PD0t8yO6QRJ9QAwKeJttcef
         PTr/NsboFz5BFairRgqZqJ8Wxc/V8L0IU/aBt0VfdqUAxHdNdKzc55phwL633/IULlsY
         a83A==
X-Forwarded-Encrypted: i=1; AHgh+RpvzzfcCnZ9QVWQLfFFiE/qAuy+hm9e1LrC4SE51HId9aB6b0HW94Z3PDcXiJkoJkgx4yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqOcrc8BrhJGa/vTkfREXNG0vLNUbRNq69QuroWrRuFFQXTlx
	j0/EKK9bB5h60Lm9fM8SfTnmpoWA8VHu7K1khgSME3VK6JiMeWKM/0knFUwzUd221g==
X-Gm-Gg: AR+sD10Xq4VpBTI+n5PjCEq9NJbswXpfq4y64fLOoEOdd8OcbcT/3RGWBlBk240e5MU
	0yARIU8O+fe5M1mvpf3zp5vNL9MQQrXSOk1k66J1bAYvD6dEx2b14qfCvt/lfvtfi0frLLAo/X5
	KX26Lrf5z92OSdBGx5PdSg+5+ElM8oLrYLvh9qJekKtBKHOSiCS247dR6Jxucv0T6iAl7PQIr63
	fmS8BMt8o+nhJ/LYlTKyVKW7XWD0fpl0cTRJ8Wqrtb6pyGZ9ZdMmt/bs73JmdXpStFRqbgha+0n
	ArbKD4Mdu1TmQuijP8J2w5C8H4KahfTI2lKtnOPgPMVQDyHjBs2yxs5nMH31WAwF3WQ7uhE7zv+
	0vHLKKplx/CSydP9ZhMaKf2toSm1o17D1h0C6xOJV4DqXcBxJH4JTVynVWiua455pTunDXtXjk+
	heTwXJXRcQgdElUolAM+oJkg76ihtVu4Z8gwsE0TnKaaIOjnh2/wgxPlVlT5Ij9zTuKrkOTjGCj
	rDOlx53LZtgII2DtvBSQwnzocFs8HtZxFA5jx4lYlPt/Of/XhvGyKA=
X-Received: by 2002:a17:907:60d5:b0:c1c:2c32:1163 with SMTP id a640c23a62f3a-c1f720fbe49mr419330566b.25.1785344791879;
        Wed, 29 Jul 2026 10:06:31 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83c686a8sm142753566b.4.2026.07.29.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:06:31 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Naveen N Rao <naveen@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 1/2] KVM: Check for duplicate vcpu_id as early as possible
Date: Wed, 29 Jul 2026 17:06:20 +0000
Message-ID: <20260729170621.308809-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729170621.308809-1-dmaluka@chromium.org>
References: <20260729170621.308809-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If userspace tries to create a vCPU with the same vcpu_id as an existing
one, kvm_vm_ioctl_create_vcpu() checks for that and fails with -EEXIST
only after it already created the vCPU via kvm_arch_vcpu_create(). As a
result, even though this newly created vCPU is destroyed in the failure
path, the fact that it is temporarily created with an invalid vcpu_id
and that there are temporarily two vCPUs with the same vcpu_id is a
potential source of subtle issues.

In particular, this prevents fixing the VMX IPIv issue fixed in the next
patch: a stale entry left in the VM's PI descriptor table after the vCPU
is destroyed in the failure path. The right way to fix that issue is to
clear that entry when destroying the vCPU, however right now that would
have a nasty side effect: since the same entry is used for the other,
previously created vCPU with same vcpu_id, clearing it would mean
effectively disabling IPIv for that existing good vCPU.

So to avoid this and similar problems, check for duplicate vcpu_id as
early in the vCPU creation path as possible, before
kvm_arch_vcpu_create() and even before kvm_arch_vcpu_precreate().

We cannot just move the existing kvm_get_vcpu_by_id() check earlier,
since we drop kvm->lock and then take it again, so if we just moved
the kvm_get_vcpu_by_id() check before the first unlock of kvm->lock,
we would introduce a race:

1. vCPU A is being created but not installed in kvm->vcpu_array yet.
2. vCPU B with the same vcpu_id is being created. It passes the
   duplicated vcpu_id check, since the check doesn't find vCPU A in
   kvm->vcpu_array.
3. vCPU A is installed in kvm->vcpu_array, vCPU creation succeeds.
4. vCPU B with the same vcpu_id is installed in kvm->vcpu_array, vCPU
   creation succeeds.

So introduce the bitmap of vcpu_ids used by the VM, in order to safely
check if the given vcpu_id is used and mark is as used before releasing
kvm->lock first time.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/al6eg7C-2sDBEAFD@google.com/
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..6f883ed82581 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -791,6 +791,7 @@ struct kvm {
 	/* The current active memslot set for each address space */
 	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
 	struct xarray vcpu_array;
+	DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
 	/*
 	 * Protected by slots_lock, but can be read outside if an
 	 * incorrect answer is acceptable.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..1e3714c5daa7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4173,6 +4173,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		return -EINVAL;
 	}
 
+	if (test_bit(id, kvm->vcpu_ids)) {
+		mutex_unlock(&kvm->lock);
+		return -EEXIST;
+	}
+
 	r = kvm_arch_vcpu_precreate(kvm, id);
 	if (r) {
 		mutex_unlock(&kvm->lock);
@@ -4180,6 +4185,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	}
 
 	kvm->created_vcpus++;
+	__set_bit(id, kvm->vcpu_ids);
 	mutex_unlock(&kvm->lock);
 
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
@@ -4211,7 +4217,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm_get_vcpu_by_id(kvm, id)) {
+	if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
 		r = -EEXIST;
 		goto unlock_vcpu_destroy;
 	}
@@ -4265,6 +4271,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 vcpu_decrement:
 	mutex_lock(&kvm->lock);
 	kvm->created_vcpus--;
+	__clear_bit(id, kvm->vcpu_ids);
 	mutex_unlock(&kvm->lock);
 	return r;
 }
-- 
2.55.0.508.g3f0d502094-goog

