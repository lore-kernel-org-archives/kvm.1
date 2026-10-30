Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395283;
	b=c6TSkA19jSr1evmBfyV0pEd6lsbzQiWmXoUCy0gUmWJ/8nduO0FBgiw9IPnrBpGOmHCc
	 6KZPSZMhechzWfrjqh/hxBpoURnusMnYbst6lwp0kEaCg+0YxVw3DUgKI2FHef7g9DINU
	 1VutaoR71aclM+FsfL6dahRW5s9ZC3gdAgvlnyRR8S1/Jv9h7fcBqpAzdb30TtspTyAzm
	 t2BcVzMoUKarF54veyGrdUkh2ydC/7uAmJwWlSVRBHF/D2JMEnzBX241lfWFqvmn8XT+Q
	 RiO7np7L/9SwkMOn8X5PDj4bre2JCu1J5DtjNWDPm+MaAYVnV2MKt6TRA/CsHFuyBkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
	b=lzpnnDvTjy7UMERARbqwYjh+b+E0cDaEpPAvnoBuYDyerwuUXZlTGNquRB6AaUhzX2B+
	 rzqWGz0R2IC3mtQxpHM2XJy0GKDyJvk3zak1WyvqvNjPSSmr1LJerI5UbkN8gxRZCSErk
	 TteWdfP/wRUSNdlk5Hc9ReRepqVzwhWvt9ynwHa5roMBOyr8x4z+oZ+woh86L1D9RP/mA
	 Mi6RmWmSw6aioP5EFLwLvf9Ss3nBZdK0pyE2oWKKTuJam4NohPT5UVn4anzUdiPnViaTy
	 0ob/7XPSi2SBPZy6g16/wcf2XfcvUsMV+SxBCP/LgMA8V3/bqia8wlj69/s1R3GOrew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i84KDOS3;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE060A6F50
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DE060A6F50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i84KDOS3
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so1011826a91.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395282; x=1794000082; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
        b=i84KDOS3kqQZ6WObTbiRKt2xyGjsnSR69JGmLrgoZJrTkHU1oQGPe5XRPyg1uZVRiz
         KUP9SwUihq9C+DU0n+B31VkB9yRrZYwGhrYcrXQ0PBv+2/0u0rCQ8qcTRo7/S8NxkADw
         OhkU1+zao5RZcW7YkFP9bABaQMjnvX4EJjgnV+B1s/3vSU9i7Yzj/+m9U7CIsHa10Rga
         GFxsZpK9+Fn8+oL24w/iqPBZjgYtpfa9ot75D5RQqe7EKcg5GbuNEg85xMxXRpwtwbKD
         GUlrx5oPEhXtu+zBl9KyPUbaZTBmMMHowOziomqql7syVmRLTZSGuxB/OJFkZZIJ2clI
         StZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395282; x=1794000082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ffYJqqyy7PxUyTG9nWCiYNGOf2D1TYjdOFe2IcBzjU8=;
        b=k81GRI/yk+muBDLbIk2WSjOBESpU7Aeu7f7gvLqD3gn66fz1UIEj0vFuIBpFVCNqze
         SMukIf/Kudm83/0XqULEQaEcvvY7+Kpc5kxegwWlfTHoMw+Gcp0pQnGQ4vYXCgn8KHmk
         zU2COI2blxIG7/6u0bZ409yvkgnrzSFc2MkLA3HFxlG1yORc78sRkJzB8MB2SNioP3ir
         qSm2RbV4pM7bkF+7RBwPLtynRVQP52CznY6Dv0Q8nWpGVa4u4iYelbsrN44B+HNDtD0+
         an8r379I/gehrAJI49sdcbEjKuFxWD1CTtPAg2xF0eGXuLrAq0p+J8rRXKETDonvDJYX
         18NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSqjQkpZ4zuvqeESkFPs9q2R5/j6RmY1zbCnJZcjdRv3/1B3kIcp48fzxXdGEqjdN/r7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz/VyVIHTfAGz6W5dW8+8oZru3N9AMiUT5hn3ICRrx+mrHt6gi
	cr4GjDM9amDE9SCLVOsL9J7hOztE4PgcekkOS+OIny/CvcI00I4pbM9zJed8qlVDQ5u1JEhzY33
	QzhJ1wA==
X-Received: from pjbhl4.prod.google.com ([2002:a17:90b:1344:b0:3aa:dfda:ecdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7
 with SMTP id 98e67ed59e1d1-3ae897aa7aemr3117147a91.49.1793395282021; Fri, 30
 Oct 2026 14:21:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:55 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-8-seanjc@google.com>
Subject: [PATCH v4 07/23] KVM: x86: Delete non-SMM internal memslot if
 creating SMM memslot fails
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When installing a KVM-internal memslot, delete the non-SMM memslot if
creating the SMM memslot fails.  Leaving the non-SMM memslot in-place
makes it impossible for userspace to recover (not that any VMM tries), as
subsequent tries to install the internal memslot will fail with -EEXIST.

Fixes: 9da0e4d5ac96 ("KVM: x86: work on all available address spaces")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 489631686ba6..326f8a9a5d18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10006,6 +10006,19 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	return ret;
 }
 
+static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
+				    gpa_t gpa, unsigned long hva, u32 size)
+{
+	struct kvm_userspace_memory_region2 m;
+
+	m.slot = id | (as_id << 16);
+	m.flags = 0;
+	m.guest_phys_addr = gpa;
+	m.userspace_addr = hva;
+	m.memory_size = size;
+	return kvm_set_internal_memslot(kvm, &m);
+}
+
 /**
  * __x86_set_memory_region: Setup KVM internal memory slot
  *
@@ -10062,16 +10075,17 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		struct kvm_userspace_memory_region2 m;
+		r = x86_set_internal_memslot(kvm, id, i, gpa, hva, size);
+		if (!r)
+			continue;
 
-		m.slot = id | (i << 16);
-		m.flags = 0;
-		m.guest_phys_addr = gpa;
-		m.userspace_addr = hva;
-		m.memory_size = size;
-		r = kvm_set_internal_memslot(kvm, &m);
-		if (r < 0)
-			return ERR_PTR_USR(r);
+		if (size) {
+			for (i--; i >= 0; i--)
+				x86_set_internal_memslot(kvm, id, i, gpa, 0, 0);
+
+			vm_munmap(hva, size);
+		}
+		return ERR_PTR_USR(r);
 	}
 
 	return (void __user *)hva;
-- 
2.56.0.385.gac671c819a-goog

