Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2349C4D9
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409554; cv=none; b=h0YGlUYjW5aGY63hOP9KKWt29pY+dEmBi22aeJx4D46klcIQxtWIhM7IglP22a/iBmNRG86Lb4nUs6Rdly1VDHvsceEIsWBX/6/8mX73Q0yVDJ6v5+vWpkwLAqjy6GunXQLWI6XzPXRSGkFgogVF1BxNKZswYZJ6crWiOCetERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409554; c=relaxed/simple;
	bh=Z7Y8dGSOUAE2MQXoMonDfShLm6KfkAJm+Mr8AwQANRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BbpHCp23O7Uc/NhQUNUaiNEWXMI5Lcf8OqeVNYjZaPKh4B0PPyOKrBXZiO9C5g1hcktMMn/OK5gs/n/khyTIHv1KUfTmCM36jSp6J2uzwnec47ehzBcUyKnwbK8dIxz4UcJp7HENS3/jsLXMe1LEKnS406Ww+QZmsbEt1Fv3d2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbUlZ8Lz; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbUlZ8Lz"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a880e91f0so6064758b3a.2
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789409547; x=1790014347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vZN0JxymvylxGmruHUZ/7Vl0ag7CYvowzU5bHzceTLw=;
        b=nbUlZ8Lz8npVGmwamv0VeCS7gaKt9nyUXV7kns1JffTbE6JNXTYEwddl/jLOc0otEk
         nSb93KKzGptFeWZFjl0CsjiTmSRmmfYRu0cma7PA1J9CCxjviHzjKOiAgkU8kSGyVaaW
         pbMIDpb8snDC7EX30N35PxQBf4Ef4B5omiFkXixVXfpAE+J6vFQaMAF7zuBmn8q0naWy
         867nIwgWU2/ziH3EFocYZ91fGAmJyw0qk1zvPnGbh0LLQgkoR98HZz3R7Uw9qidHet+P
         l9Fbsr2LB7i2hIuaS/pEH039+ZBHPUS5bYaTENwwunps+VyyH+NjkzF4ye4m04SQ4chO
         eSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409547; x=1790014347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZN0JxymvylxGmruHUZ/7Vl0ag7CYvowzU5bHzceTLw=;
        b=fLKVo6l5mPpsMfAqSmzCLjBWhkKV6N5ZD8LzQ9R9dKAr5MRd/Z20KViJgx4yLW9nwr
         b8Y+Cr+Y8rm9xKCR3GlQbbCOHnEI1fR7L2bkSe96C/BxXBoWl7ictemyJxxvcLjRP2VP
         7GQkhYVlaWNxw8ACH0qjq0yxUEM5NQzrrEHJidoSMSPAsOjYetW3quSCejwMOTqod08y
         vCoU/BnBEA1GemH4D9mFq1RhncjdNsODfzKp3AWmBA59r7AF5sZa5aS/Y/OodKmDOku8
         uffaAO0GcMwOovm7dQeSLKuO76ZS9COQT61TgsyT66VeQTb0NqSrIig73CB7IaQB4Sj7
         rJ8Q==
X-Gm-Message-State: AFuF++lkB29F9B3p3cMNTT1b9qdy9aGYr1rLvAx73OS/BZvijtTN/mTs
	KP9xMFKfHUWIIUSgMsJBD7Wne53kKyEVIyvJYpIowviY+bKTDnGCpdmr4ckM2ZDs9tytYxaEi6i
	3sIJt1w==
X-Received: from pfbfe8.prod.google.com ([2002:a05:6a00:2f08:b0:86b:44d9:6a02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3022:b0:852:38ff:b4b6
 with SMTP id d2e1a72fcca58-86f85207cf0mr6989884b3a.17.1789409547160; Mon, 14
 Sep 2026 11:12:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Sep 2026 11:12:20 -0700
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914181223.289061-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914181223.289061-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When creating a vCPU, don't drop kvm->lock to when doing the bulk of actual
vCPU creation, as allowing multiple vCPUs to be created in parallel adds
significant complexity in KVM (as evidenced by the many related bugs), and
all known VMMs fully serialize vCPU creation.

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
 virt/kvm/kvm_main.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

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
2.55.0.1032.g73a4cd73de-goog

