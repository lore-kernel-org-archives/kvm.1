Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07354EFFA9
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012695; cv=none; b=QNjW5ccFL4zUVVDbpJSNSfUMIpeu0we6p+wsvR+BxZGtQa67cwBDjtaziLw+OLoCkaTCwP752TJTVccNd49beQbb4MYcyqftmUZ5Atocwkc2vF6ILNlWGwwkr+6DFchAyDmxssE5smuceXn+PLwQA0L5UCjsaHVV9047RJpbqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012695; c=relaxed/simple;
	bh=+jjHjwnLcMcNsDxPCbMB0oqiroo6BVNoCF+l0EJJBnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScpqoCbyusSFn8xYS8JPfFrOuS8A3rqNUOsU28C1YvF9cftuHxwirJNzP0QYiLwHvl/3yHQgB1uA29lJySAxnShx8Z41naATYL8jAADOCw5S3vpc6C3id5lb6P13LSD+QjV/kF5S2pctl5qcL2XYFrJEBNoR+DCtppu/CpIY/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rm3PuT63; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rm3PuT63"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8538a72b430so3495047b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012692; x=1790617492; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qeiicXWgTPk3n7JADXXm7zikz8BknOrQz3jHJRoDF6U=;
        b=rm3PuT63S+dY+XPYFxDqxexEhVDCVqX1jgmMMclHxaJj/+V4RMvCntEhCshJ1RlIPe
         a5RsaUjONP6J/WStYdJsa85x0MO8TU4QOU51LEQJmdCDLf145UW6GNFfgQjooe/fzdpz
         RSmuq+Kb0HEI+z9fiS8H9uKy9hlagY1fftCcUx6YSBVrrVKhrvCtKIFG8fFTX+DHR9n1
         4JcrUhDHtzc3juJSrNBtZK5isPIdkjnIpIM71LMlQNirOyO7pCXmS8uppbhqTaNUKD0v
         9kPTZZja4CCqUy4cPcPDWoq0HpvDMWt4oLmvK2TJTmHczxQpCn5DIl6jVLdAGvcNDA/f
         BbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012692; x=1790617492;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qeiicXWgTPk3n7JADXXm7zikz8BknOrQz3jHJRoDF6U=;
        b=sYYuKECzzWTtGWEv++4C62kq21iqOOEWkZZZ1sCzUGm1B72d0qDiTbdUsoWqiqWDFt
         JkXx67TU8DqWg7qUr54cPIaG/Lh3U6RNJ8l6XOTb84tuMT71lHlKtfaO79b3tNrKI6iN
         YBkzuaRdOk4hO4XeRx9WC5xeyvU38MCGjP4NZwXRkdUg9xJ5SEh3lbtP9TQ6UUsM/401
         Z3R9Lh7Crp4pAL+9Lzbpmf4xfIcP3WWS6qyrLAahQ4t3whYBlfaifRF5KhWFxLQOpZbi
         gND3A1dddL0Qd9dIAD6quEbL0JeSx4JgCBz1+L15hddEPYvU7mxsdFmL5PTTesNiN6es
         UDAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpriJEgA4Wg8a80k1MUqcv5mitza78WLy3A3eRGCfHTBRAA/M+6cP0g+nNVG2SBitM7KU=@vger.kernel.org
X-Gm-Message-State: AFuF++lalCP+2/zznjZq62LNKjivPCsOOIWDZJPqedz3/WPlCebHCARW
	mBgmyOplvuMVDVjEYxms3TDR1tpEzk8MEb8c861n8vc4sPTshk/QUceQ8y3Iw+UyehA5lLfB0Oc
	7eOfA8A==
X-Received: from pfw3.prod.google.com ([2002:a05:6a00:a263:b0:879:1348:bebf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f06:b0:857:727c:a1f1
 with SMTP id d2e1a72fcca58-874dddfa3acmr14506041b3a.19.1790012691865; Mon, 21
 Sep 2026 10:44:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:42 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-5-seanjc@google.com>
Subject: [PATCH v2 4/7] KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When creating a vCPU, don't drop kvm->lock to when doing the bulk of actual
vCPU creation, as allowing multiple vCPUs to be created in parallel adds
significant complexity in KVM (as evidenced by the many related bugs), and
all known VMMs fully serialize vCPU creation.  Remove all manually locking
of kvm->lock from kvm_arch_vcpu_{post,}create() for obvious reasons.

For many years, "everyone" has assumed that dropping kvm->lock was done for
performance reasons optimization, e.g. to allow userspace to create all
vCPUs concurrently for latency purposes.  But as above, no known VMM does
that.  Looking at the history of this code, before commit 11ec28047118
("KVM: Convert vm lock to a mutex"), kvm->lock was a spinlock.  I.e. KVM
*had* to drop kvm->lock when doing the bulk of vCPU creation, otherwise KVM
couldn't do normal memory allocations.  When kvm->lock got turned into a
mutex for unrelated reasons, no one took advantage updated of the change to
simplify vCPU creation.  And 19 years later, everyone just assumed that KVM
continued to deal with the complexity for performance reasons.

Furthermore, naively parallelizing vCPU creation in userspace is likely a
net negative due to the overheads of task creation.  Unless a VMM carefully
avoids the extra overhead related to parallelization, e.g. spawns each
vCPU's thread before creating the vCPU, creating vCPUs concurrently is a
net *negative* up until about ~64 vCPUs, after which the times are a wash.

The absolute speed of light _is_ faster if KVM doesn't hold kvm-lock, but
at vCPU counts of ~16 or less, it's probably in the noise when considering
total VM creation time, as the added latency is less than 1ms up until 16
or so vCPUs.

On top of all that, KVM has had a *lot* of fatal bugs (most often found by
syzkaller) related to vCPUs being created while trying to do per-VM
operations (basically, see every flow that locks all vCPUs).  I.e. the
parallel vCPU creation "support" is actively harmful as the only "use case"
is for misbehaving userspace to exploit KVM bugs.

Serializing vCPU creation will allow reverting commit 97d65b544f48 ("KVM:
Check for duplicate vcpu_id as early as possible"), which had "minor" math
error: the worst case scenario isn't "256 bytes per VM", it's "256 unsigned
longs per VM", i.e. 2048 bytes per VM, which doubles the size of each VM
and pushes several architectures into order-1 allocations.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_hv.c |  2 --
 arch/s390/kvm/s390/s390.c    |  5 +----
 virt/kvm/kvm_main.c          | 22 +++++-----------------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0409ac9e7b31..30f7095a156e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3058,7 +3058,6 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 
 	init_waitqueue_head(&vcpu->arch.cpu_run);
 
-	mutex_lock(&kvm->lock);
 	vcore = NULL;
 	err = -EINVAL;
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
@@ -3091,7 +3090,6 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			mutex_unlock(&kvm->arch.mmu_setup_lock);
 		}
 	}
-	mutex_unlock(&kvm->lock);
 
 	if (!vcore)
 		return err;
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index eca4a4359ab2..cc628afbb850 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3579,12 +3579,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
 	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
 	preempt_enable();
-	mutex_unlock(&vcpu->kvm->lock);
+
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
@@ -3757,13 +3756,11 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvm_s390_vcpu_pci_setup(vcpu);
 
-	mutex_lock(&vcpu->kvm->lock);
 	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
 		rc = kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
 		if (rc)
 			kvm_s390_vcpu_unsetup_cmma(vcpu);
 	}
-	mutex_unlock(&vcpu->kvm->lock);
 
 	return rc;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 78cc090435be..c17cc8dd371b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4165,6 +4165,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	struct kvm_vcpu *vcpu;
 	struct page *page;
 
+	guard(mutex)(&kvm->lock);
+
 	/*
 	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
 	 * too-large values instead of silently truncating.
@@ -4177,26 +4179,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	if (id >= KVM_MAX_VCPU_IDS)
 		return -EINVAL;
 
-	mutex_lock(&kvm->lock);
-	if (kvm->created_vcpus >= kvm->max_vcpus) {
-		mutex_unlock(&kvm->lock);
+	if (kvm->created_vcpus >= kvm->max_vcpus)
 		return -EINVAL;
-	}
 
-	if (test_bit(id, kvm->vcpu_ids)) {
-		mutex_unlock(&kvm->lock);
+	if (test_bit(id, kvm->vcpu_ids))
 		return -EEXIST;
-	}
 
 	r = kvm_arch_vcpu_precreate(kvm, id);
-	if (r) {
-		mutex_unlock(&kvm->lock);
+	if (r)
 		return r;
-	}
 
 	kvm->created_vcpus++;
 	__set_bit(id, kvm->vcpu_ids);
-	mutex_unlock(&kvm->lock);
 
 	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
 	if (!vcpu) {
@@ -4227,8 +4221,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 			goto arch_vcpu_destroy;
 	}
 
-	mutex_lock(&kvm->lock);
-
 	if (WARN_ON_ONCE(kvm_get_vcpu_by_id(kvm, id))) {
 		r = -EEXIST;
 		goto unlock_vcpu_destroy;
@@ -4267,7 +4259,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	atomic_inc(&kvm->online_vcpus);
 	mutex_unlock(&vcpu->mutex);
 
-	mutex_unlock(&kvm->lock);
 	kvm_arch_vcpu_postcreate(vcpu);
 	kvm_create_vcpu_debugfs(vcpu);
 	return r;
@@ -4278,7 +4269,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	vcpu->vcpu_idx = -1;
-	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 arch_vcpu_destroy:
 	kvm_arch_vcpu_destroy(vcpu);
@@ -4287,10 +4277,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 vcpu_free:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
-	mutex_lock(&kvm->lock);
 	kvm->created_vcpus--;
 	__clear_bit(id, kvm->vcpu_ids);
-	mutex_unlock(&kvm->lock);
 	return r;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

