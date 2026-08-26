Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B33C98BA
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785544; cv=none; b=JG2rnN3TEICi03eW/+iPPCWsA+s0dnXmOx1ajD8aybE1f7EcLJdDqIDoMCCfuskTZgDlIXIyKb1Jt/MTPBDHNJXHzybnb21ZgERBPReUf2yv7WRMi0BBBLEfzBEoWuGKPByipI0tYycsl+3diHCRBsMUnKSr4lo70eE8GzY4iIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785544; c=relaxed/simple;
	bh=lKXQlA+oesJrtxD7c4frkF+V9E3fuZX9xGPyHMdrXvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SBo0IytBcWK20if63PzFEeFecrraVsaO8/6Sy2baQvADCDloaGrnnCu1SLvhEzo6eviFCij+gB+xc/drm/X9M8my3mxj+cMMPt6LEasC7BxqO7pWNC05z6cnawOBs2vsuZ3z91rP45K5BbZyhnEizHk6M2QxuxDaSfETNjQT0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5fYD3EC; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5fYD3EC"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso2110717a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785538; x=1788390338; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=heZN2DuvfOxZirlVdynH6v1916EkfGJKRv4e6fIVLjM=;
        b=u5fYD3ECN63cZG6LVwmXOHdxe4K8N8vtjGMIsOqRPv8taiWDDmDOX6riooYkFHufnU
         ivSD6slgS30NwbpDwLsmtjBWEPSwvVe6IAXNCyG62V5u7P1Dun7Sg0RP8nbyAaSP0VLk
         qyjRo80oyO0pZfajhrZau16J7C76WseRjCoc/nGiR/pd5siLgH02YaJ1A+/Qjgjw2jlt
         eWFLTxHHBsIQoVAUanJZcWHcA6mv3tWEOIspxznJuUgnBIZM+O3+Wt8Ou0lYPYx3KAjT
         /84jo9FN+iqcHVEhU1p+wcBpCa/eU1Oh6E++qCV+PYIkDUeFeCzfoPtm+m3MJebzW3OM
         GWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785538; x=1788390338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=heZN2DuvfOxZirlVdynH6v1916EkfGJKRv4e6fIVLjM=;
        b=aVfmdIM7wKJtFbjcwGSEF4BMxgmOM+ntOBfmhBGLgUp7IbkeNGAeQrSqTyWWz1yp/w
         y7tJKUuNYHGxDBG5dAjzxQvV7JhWvI6hJ55NWbPWatBlj4ASEAnO+P5uD7VzNRqW5P5p
         g7wYcomvPOoi79mZ5pJkpvf83wHeKgeYSL+zSjTH39zUue2HiPzEjLKv6gCD2uMLIcfh
         Nniq2tVGCw6lPaQ9Q6JL2EOKNt8s6YJvN0IBC31NJYYXatMElwRfBnfF0HciqNiRiRI2
         NnjTQ8Agm7bPfatUFlwYyIP7ZzKoKv//cFoaiDqtO1Pan8PqFblkX4W825hdJ8MAjyt6
         z1+w==
X-Forwarded-Encrypted: i=1; AHgh+RqwmT5+3kCl74LFUeViUmwJH7fU06ksuSRISu7gV0CBzDyI1hAUiGfd9Hv419ZJfwrQ+M0=@vger.kernel.org
X-Gm-Message-State: AFuF++khTA01Dh0P1YRJi672V7bSplVA/HHLaEAVQpSgdDHGz4rR4uvx
	88fL+2KqywR2dhtICxb0cR/GD/85HZCBNeb7HU4ioKRtXKSrplOUBUikSNTcBD+ypAaXGvtfH5j
	aaO8v2w==
X-Received: from pgce14.prod.google.com ([2002:a05:6a02:1ce:b0:c9e:3c0b:5818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2013:b0:3d1:3c2:85b6
 with SMTP id adf61e73a8af0-3d103c28dfdmr4039415637.5.1787785538103; Wed, 26
 Aug 2026 16:05:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:05:09 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-19-seanjc@google.com>
Subject: [PATCH 18/20] KVM: selftests: Use TEST_ASSERT(), not assert(), in vm_get_mem_region()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use a proper selftests TEST_ASSERT() in vm_get_mem_region() so that bad
input is guaranteed to fail the test, and with the standard error message
format.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 783f060faf9e..a0cd1b6598d4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -198,7 +198,8 @@ memslot2region(struct kvm_vm *vm, u32 memslot);
 static inline struct userspace_mem_region *vm_get_mem_region(struct kvm_vm *vm,
 							     enum kvm_mem_region_type type)
 {
-	assert(type < NR_MEM_REGIONS);
+	TEST_ASSERT(type < NR_MEM_REGIONS,
+		    "Invalid memory region type '%u'", type);
 	return memslot2region(vm, vm->memslots[type]);
 }
 
-- 
2.55.0.887.g758fc8c411-goog

