Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37A4AE12C
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367314; cv=none; b=J06+KJNwxvJsvJg34IUG9b1n8jepupDP1M+EG6PvhCgbhEHJCpVOL4KG0a24q4LUHpbloJTwClM6J/nN98yE3VCpH0CjotT8D2fsYR1rHp+IYfC3IQr8OFvpsZagcfSRQ9kIglqsPTL7kXSmqufNr0sqKaSTjYqLnkWubj0C1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367314; c=relaxed/simple;
	bh=OA10wlnKKQ7EEM6YlvfJ4xQQrgVCfQ10w2yj5EgWY/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iVwpRUdOvpwVAKJM8xnOkQWIUy1xZqLQOIPx85W1l7tkah6PJeg+GQCN1peOw6BlvbchbxJktVGoSX1/3rNzeaJec/L55ocw7B3bAB9kN7FUsLwx1AC0eAZdf70mH5UMzxqvj2uADzut4xsF9ZEoCBx8dRWsKl31JFyA+toVlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRdPfYeD; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRdPfYeD"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1884673a12.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367304; x=1788972104; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSZqPcNxcDapPNldInB7JTSEZaOXSqhsga2ZRaSmlrM=;
        b=ZRdPfYeDuF2PI96J3h2s0LwwuVEN1RcPfvmFxt8gjmmgjFkddvmlQeugIuTJ/aSjg7
         eawo4QBP1/CzVzhLK8z8aGPHeDiy0WO0X0LXp3J/mTzBQqAPyReJP0RpLI+cXOybh9xp
         yb11PUUSlNb+XO/ILXqlDZzokMarBzqG/59PNIt1i/0xXp9ukBQNqhyl0X/aLNLFoqjQ
         9jwdeXumWNiFEzvYA19G6a3veIDAV8Y/+tuu5yTzxJeHGXDPgJjqIh+kJkaUbAeMnUFv
         8mFCcp+uRC9eM/6TJgdRmvCgWQoyZGm6TjSpKKg9PXivCKCQD2/MhGhWnpPd1WMyM0zz
         QTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367304; x=1788972104;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSZqPcNxcDapPNldInB7JTSEZaOXSqhsga2ZRaSmlrM=;
        b=OeqwLQ1hUHPdGUDBGP/SqivGncqUPwSfG6Rcw3BbpkRh9iLEgD6QEbzmQPs0L8D4PM
         JU9nI5Jbrcoo9M6EJMq4ewyFKblUY2mfO54txbA2qcUDrmnkmHsn6AQQg48tQqImWj8S
         RdDgYa+pRacjQRZ5TEiYJu841leaCq4riT1daE3gkAvQUfclYNq4FdADCU6HXKsGWwj+
         ZcDC4VvBBn8fbQ/ZBrXgJFTWM7Ov9WH28KulvnVZXcper7PHRc2M/9OHFbVMelV9PGbq
         UlUV7VP6IkEKaUMVOVo9+oXvDU5ITkYSSkkBMnbILHQfh+qhKxOEJTpNpWyLks4gzMxm
         XTXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh2+BfcA82liW4RryXM0WsUF0rcZlXWYGjg3+w6nX6UG2pzpyWv6pJMvinYXU3T+kmuq0=@vger.kernel.org
X-Gm-Message-State: AFuF++m+iCU7Da0ZyCDe5WLFzAvQsp2T/MWmoD7ONh5qIKyBJEoHIa4e
	zVGM0wBo356HzV1iyYTeYu1NeBxP8aQqfThTcBEv4/REFU9zvD2WmqXhcLdMQUo1OhAPli0l6Mm
	mGVJ9vA==
X-Received: from pfbgv8.prod.google.com ([2002:a05:6a00:4e88:b0:853:9149:8801])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:238b:b0:85c:c8db:8e4b
 with SMTP id d2e1a72fcca58-85ed23dea9emr8785308b3a.6.1788367303872; Wed, 02
 Sep 2026 09:41:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:19 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-17-seanjc@google.com>
Subject: [PATCH v2 16/20] KVM: selftests: Use TEST_EXTRA region in set memory
 region test
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
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use the TEST_EXTRA region/memslot in the "set memory region" test instead
of a custom memslot, so that the primary vm_phy_pages_alloc() APIs can be
reworked to take a region type instead of a raw memslot.

For all intents and purposes, no functional change intended, as
vm_override_mem_region() is barely more than a wrapper for
vm_userspace_mem_region_add().

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index dffe9654f45b..9d21594e2f81 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -116,9 +116,9 @@ static struct kvm_vm *spawn_vm(struct kvm_vcpu **vcpu, pthread_t *vcpu_thread,
 
 	vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
-				    MEM_REGION_GPA, MEM_REGION_SLOT,
-				    MEM_REGION_SIZE / getpagesize(), 0);
+	vm_override_mem_region(vm, MEM_REGION_TEST_EXTRA, VM_MEM_SRC_ANONYMOUS_THP,
+			       MEM_REGION_GPA, MEM_REGION_SLOT,
+			       MEM_REGION_SIZE / getpagesize());
 
 	/*
 	 * Allocate and map two pages so that the GPA accessed by guest_code()
-- 
2.55.0.966.g6673acef38-goog

