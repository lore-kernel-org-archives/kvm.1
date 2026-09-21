Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524E4D990D
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012698; cv=none; b=jtk/W1s0C0GNp1KE7zihALZBrhtq7U8BLEbixugIS+aEEthm34XxdfKEBUrBZYIBDyPbTIg/foMkwvm9EQQ9UMM0zXNfD3GrSLJAsKoJOn9ZVYLNdjeupuDeUr2I4kZ6fBHChWbPH+REL2EGTcZjlQDQkLv+sgodqj6RFpq4W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012698; c=relaxed/simple;
	bh=d+HwDcZ+iWoQ8qx4aIkqNrZBIcx5nx1EjGGCYbcSOIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qOoJR5UOK8j9dpku4J3s+j6WT7/VUlqoeymIB4U341FVPc+XlsX9WUElMwEsYMR1MkX+j8rw7ybTp97o3fJLsC/ZgfKsKw92FV9hFNDqF42kIxS2bkFH5rWrbY4qZEH4IsLf8ABRn1OKlBUWXe4unXA8GPtLMdEXQUuk6O/rMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oR7pcUxj; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oR7pcUxj"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d94a158dc8so57856665ad.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012694; x=1790617494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1dhUTiarEg5c5I3QHkxBctKjtcsAKr4VX6TAcrbU/Q=;
        b=oR7pcUxjaj4SbpKWfaSO5aN7XvFW6vVf6dYuBv0+kQt6H2AuyLkR7i5hdi04NuNhYm
         iYbGu5pFraRQYA977A5AEEPRThWR+tZYD263mJyydUmJmUM9JSyucL5HrEDfmop79FsQ
         KbvdiPfN0PgHsfSIkU1Ifjom3oDfWCZ5wDE8TgvDGztqkCJIEY/Y6nkfDaEYUzMjt2kB
         Hr96xMs/6DjjbQ2Q+lHmZjCOOqnid/gAlFoRH5f2iXEj6JDv2/7lJ7VCoZAzF8BMbwpH
         VpnN1zXrRMbA+kYSm2ILi3i5nExDWTq/oQIPB0f3LWCl0KfMvenNg9rharxDm2fGlBm4
         4BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012695; x=1790617495;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1dhUTiarEg5c5I3QHkxBctKjtcsAKr4VX6TAcrbU/Q=;
        b=tKHeqn+G9EfBbvejA1QajYPBLIN8CKRDy+l/RRY8epSTTh1jM2Ty+dgBrnZb4Bs9Tc
         Qn5vvvdXEG1ohkR+we819+RxUgGLxX7jC+crGuL1iDLq9abfDWl2Emxv3esVLkUPQhdX
         nPYT1mKy5X5soWtdoKLd5JPHTZloAM+h5JLel9Yv8If19rjiVGwAepdGRjEZyNPIzhKo
         qUI7YUlb7kAhHTBBrnF0luwMwSmTgu/xI9vvP4/7DoeLY09S89JlcF9NMPLJdwJ7+HvS
         rTRhsrAePAI5eGj3ToSrx4zZPzSK38IdESZWAB0yEvZn2epiPY5gLnQJTo0oGrjb3NzK
         3d7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxQcPVq/3FuiM7nVAJAILkHPZr09Uy2VzmxoVeKhYt6LXJvRqHWN2x3PzgxvcvFIqR0rVA=@vger.kernel.org
X-Gm-Message-State: AFuF++kr52FGZxQyZwkX1YFE6ahoi91rRMjx+W59CPs6imaB6sksZuro
	wrkFi+TJ/WVVNUelNg6F877qGiBixqYSljd7vSudwu5b3F879uNSsNvey6mWUrOI1mR0tRIJxfy
	84vU6UQ==
X-Received: from plao21.prod.google.com ([2002:a17:903:3015:b0:2dc:5417:2772])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d984:b0:2df:3b09:664
 with SMTP id d9443c01a7336-2df3b0909cbmr71040325ad.32.1790012694298; Mon, 21
 Sep 2026 10:44:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:44 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-7-seanjc@google.com>
Subject: [PATCH v2 6/7] Revert "KVM: Check for duplicate vcpu_id as early as possible"
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
Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
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
2.55.0.1082.g2b9226bbc0-goog

