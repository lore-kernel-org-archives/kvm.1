Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D049CF26
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409555; cv=none; b=BzhvY0nDDSddegs3KM7CoXLKKCyGQKJZAYy3G+TP2PUBMHgMkZ0I9Zgy5e0+6yfu+vEJwtNyGxaAtiL/6WQeJL00fIuOlZtk7i1e8SOEdptkhG/7KFjS0gScffoZAy31kcFKfpKWRBg5+B8suTkYXWehjgiQGYe0/oU/glQOkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409555; c=relaxed/simple;
	bh=x0QuQ7B46vZSLWuhvb7Pej5iUeD3ReCFBUcJ7PEUjmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPM8A8O1G4rJNrdZe9msZ3fuWZNG/gwaC5LK12M8xcLJgO76iigVzYsPbxKD5qPqcT07W0dlxsB7ddLD/uFd0429ix9DEUw4+MM8DBd7sPqvIwdxdQbLoRP8FqaossprVOrzropF0RSji3Ru1s6kFcmGQrGRuwKzaFsIp7ifmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6TzLXHb; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6TzLXHb"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a74698972so4126444b3a.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789409549; x=1790014349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vrq15StmiM1CTIka90pdQUrQi6qd2fHaKI/Mz3n+CgQ=;
        b=n6TzLXHbYJ1jVtp596d/POf/6h2dWOS8arTo+unEBbLgR8KTq3gA3PtIQ4zeTZiat6
         b6DXUWkKiL/IhjOylG2yz384swPPztJHNcDMdYjp7gnLRzx5DwjqeJfg+2NF95Ok8FL4
         RL/+SwEI6l06HAMUCSx1rVeH3WjgF3/lMEW9ApREwLISzY2kqQQWkA2DbVqwE6WYLQ+V
         BXeULoVOfYgFoD6n3nORnDgpYlJ/Ge8IffzqY6cIZ2WLbTCimfHe+6jTpXCCK3y5px4V
         xVxm6/RAI2+iKtu3gpribISYGp68y2MSQUBedc9GC6CIOYd+9jf/TsIxaoogDfPjqVx6
         +Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409549; x=1790014349;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vrq15StmiM1CTIka90pdQUrQi6qd2fHaKI/Mz3n+CgQ=;
        b=lV6G6HqBm2OYcKeEkyShbsX5EYxupIhzlCrtM9D4sqchsuP1vvTmFz09sdiCGuxD49
         pG9nglZWYjlFrmihkTHZB0PRCo24wxMF7oC7JkuE7ZlGGQwxvHO2GJ4KV8r1BQIorRHl
         IoZt79QiHm/9ry5vaiDdynVfBJqEf36frZ9hXsHK/33P/xMdEKabaY+eGBamRezr+exx
         HoBOnDWGGTMt+0NVUqZ2Mb7dhaS5/ubAA5WNCpVAWVmdRYi6OTcdqf74zXenx7+sllPE
         w7hhPjUUT4zuVgNLEzpeKAw/OoSTx4EuC+y+OLU7q2LCbajIKYsLuZISMx1ZO/kSevA4
         3QDQ==
X-Gm-Message-State: AFuF++kVoFCIyPvZyrNb+4tmoeg4MVJOCsZidwFoq8Hn/vfB/H3Lb2Gm
	INuGYY/1bpEJ50XmOxIAIQnt8aM5sjT+l06HTGhRPiWn4qn9V1QA+EOvznMnQ2aAbHKj7tkOyQO
	ik0InBg==
X-Received: from pfbcp14.prod.google.com ([2002:a05:6a00:348e:b0:848:4e44:7f19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4195:b0:86c:a9a8:844f
 with SMTP id d2e1a72fcca58-86f831591d9mr8229457b3a.1.1789409549392; Mon, 14
 Sep 2026 11:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Sep 2026 11:12:22 -0700
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914181223.289061-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914181223.289061-5-seanjc@google.com>
Subject: [PATCH 4/5] Revert "KVM: Check for duplicate vcpu_id as early as possible"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now that KVM uses kvm_get_vcpu_by_id() to check for an existing vCPU ID
before doing any meaningful work, which was made possible by holding
kvm->lock for the entirety of vCPU creation, revert the now-redundant
"early" vCPU ID tracking.  The claims about the impact of kvm->vcpu_ids on
the memory footprint were a wee bit wrong: the worst case scenario isn't
256 bytes per VM, it's 256 "unsigned longs" per VM, i.e. 2048 bytes per VM.

Increasing the size of "struct kvm" by 2048 nearly doubled the total size
on many architectures, and tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE,
which was added to detect this *exact* scenario, where a single change
significantly increased the size of "struct kvm".  I.e. attempting to build
KVM with CONFIG_DEBUG_KERNEL=3Dn fails on x86 (the build failures got misse=
d
because all build bots apparently test only CONFIG_DEBUG_KERNEL=3Dy kernels=
,
and maintainers' test flows were similarly lacking).

This reverts commit 97d65b544f48b2ee49f6aea32145e3e7969955dc.

Fixes: 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as possible=
")
Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Closes: https://lore.kernel.org/all/56a4bc35ee605588b7cc36c8e45c12b5f3b506c=
b.camel@guillain.net
Reported-by: Pawe=C5=82 S <spawel523@gmail.com>
Closes: https://lore.kernel.org/all/CABD%3DWFOS4j4hDv%2BpW-eEM9HAM2q2GY_iYd=
AG%2BqvYcUEinUrcQQ@mail.gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..6aab167bf482 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -791,7 +791,6 @@ struct kvm {
 	/* The current active memslot set for each address space */
 	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
 	struct xarray vcpu_array;
-	DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
 	/*
 	 * Protected by slots_lock, but can be read outside if an
 	 * incorrect answer is acceptable.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d5524ac8c5cf..985af39b980a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4185,15 +4185,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
 	if (kvm_get_vcpu_by_id(kvm, id))
 		return -EEXIST;
=20
-	if (WARN_ON_ONCE(test_bit(id, kvm->vcpu_ids)))
-		return -EEXIST;
-
 	r =3D kvm_arch_vcpu_precreate(kvm, id);
 	if (r)
 		return r;
=20
 	kvm->created_vcpus++;
-	__set_bit(id, kvm->vcpu_ids);
=20
 	vcpu =3D kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
 	if (!vcpu) {
@@ -4276,7 +4272,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, =
unsigned long id)
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
 	kvm->created_vcpus--;
-	__clear_bit(id, kvm->vcpu_ids);
 	return r;
 }
=20
--=20
2.55.0.1032.g73a4cd73de-goog

