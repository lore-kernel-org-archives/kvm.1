Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E623FFAD7
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095706; cv=none; b=MWKiuZGAt11Me8wT8nXKqTvdwlTqwO0wl2FoVaESGWt7Dr6S+ugVxWZoacuqlAhmYcLKyfd9HOUInarCHKIlWgSLE+RVwyeFPmt7R/LVsIjIzkaax3Fe5Qth57UfnJh5fh128XukywcIKxjiXqhrbM83KEsql9lU9rJD3PIpmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095706; c=relaxed/simple;
	bh=Y31XkwIuwQTJXeg8ZC5KVfyvvvcpOlYKgg3Rn+lQh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjX5nyX15VtGu0EhXoArLsWYUObEcbwxCqPWk3n7vP0SBov3dewPt7hpKPWJIlvdzEwKc4ePOsIRLmE5th+ZFiKGE9k4hW4uW5nAoSybS2LlRSuh4CDReI9xjTv2ytKr7yHwtROw5dn4MXyt873Qj8KB4TOspHzfxh5xeKXQ9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxO+K1Ku; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxO+K1Ku"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso4668607a91.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095705; x=1781700505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AEmDg81pB30v/Br0Irm0sFgmM4aAhJYvvee5RH7rUM=;
        b=sxO+K1KuGUJTy62fUhLp1Z7khRhxfzT5qa/uy4B4YIeWa5ukePrdhPh56uKkZhjSVc
         sQOOCCtIIW1ZAXjXS0uQ8HmmWzZb+rOVXY9szNe994123cRyU+W1PMhzNVtlP7kveHs9
         3PG+CMq8iUP57HbPFYysArO/CcYuWMcGU6M7AqhRtCuGfEaoLRm394Ea44BQ+JCf4XUI
         ZB0GpjLpYDmKhILqWmoiz4sMbdiVRd/1dOTv3rlR/gr1TO77WS91bbcFlC54+A3v04UF
         b+Vbo963/2eaExkaIgxLKVRsYPXk4TzHvLNf136ro3omJr058p4Kr05UToGEJxMq88ls
         uVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095705; x=1781700505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AEmDg81pB30v/Br0Irm0sFgmM4aAhJYvvee5RH7rUM=;
        b=lc/hdbHCCIbRplxZXYtOnANnrlYbrFgb3wF1ExkP37kBstZPHrsG6MACj2wmrGI4CO
         t0LZsC6etLO8zdjuUXzMfPEkZIDqrPbxEt2aNtqKoSRdIoAqO3phBq1DWSn2Ekm00pOD
         v9yNLenXLWpaPWVEfKlqXbC7f/Sv4F523qHzkK01zqKV2nRjdqt/dE8hxQb2RJHqqa6V
         +paumptyo4yIFyeUt0Bb4kB9zYAau6m/ED1JZbfq0+EZztKv+jX7/QfBfd+OknXfkmD+
         af0FJ30ilp1Xg11R2OgMPOwmjbOWzXwetOn898YsAZZ4iv/+R70yotprXU44j6wEpfQj
         iuxw==
X-Gm-Message-State: AOJu0YyMbOGcSrqmXbLJlbdBt9/XojDqFbbJz2E8y+Go4g+64KPTQ65i
	0yHjs6plhhNld/Mdy6b/pIPB81wQP8wheHqRbhzDCy78+jLNecH8fn0YAogP7w==
X-Gm-Gg: Acq92OGCF+djrm3Bm2swLGnk8zm8XC+4R+vSjFjqAL/ode1jMi40shxyLb7h/dvowH6
	dplMQKw0cuYz4GjyHOjAm1w/XpqQA9XXo7JpithhMyI1OT+y3TvWK6oL41d+K+NB3M6bHO69/b+
	+ErZi4Xrd5825hfFnsOI0ZF4qOUMFGpzCOv62q3Yu1py8yYKi81W3JugOfUVF3Ec71GiXZQpZN6
	osRC8LRJ4cywqEaDLwMeOILaStig2e6UEBC8vqdwpyyVscxCLUMX4UykepVYN+pd+FFxjrW3+Fs
	/SA7rQQ/8hTIHKB+MEJyfZPvyuXuU28M+Dvc2UsX+ud9u4z2UogwNduMO+mLOXVm3+noaPDNcvT
	Sx4NVJX+IdLNTg/PS7Aky1yKqTsD9cN906tue00R10qRb0vP+L3brhH/lxJZshmBeMXGpOMuoTO
	cKQ9irP72nSiCz1Ss/HnCx6sU7z+djT0n57/IeQEk5JNqvmRKMIW6pepVOvtmaCA==
X-Received: by 2002:a17:90b:57c4:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-370ee64373dmr26186012a91.5.1781095704856;
        Wed, 10 Jun 2026 05:48:24 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 08/10] KVM: PPC: selftests: Use u32 instead of uint32_t
Date: Wed, 10 Jun 2026 18:17:24 +0530
Message-ID: <5b6a7a730a8a35fcd661eadcb3dc6687a6c75b84.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0c3a8774692aa ("KVM: selftests: Use u32 instead of uint32_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint32_t/u32/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/processor.h | 4 ++--
 tools/testing/selftests/kvm/lib/powerpc/processor.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index cbbe390ae244..95ec3debc83c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -22,8 +22,8 @@ struct ex_regs {
 	u64	lr;
 	u64	ctr;
 	u64	xer;
-	uint32_t	cr;
-	uint32_t	trap;
+	u32	cr;
+	u32	trap;
 	u64	vaddr; /* vaddr of this struct */
 };
 
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index ac5c3421ec81..0a65fc3a8d9a 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -312,7 +312,7 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	const size_t stack_size = SZ_64K;
 	gva_t stack_vaddr, ex_regs_vaddr;
-- 
2.50.1 (Apple Git-155)

