Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928163B058E
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785528; cv=none; b=pMstLUd7s0uweglF32ljJG5L0jYUEBGHixeBhqlHiMHj2keHvtlZgI8MBd62KtQxD25yRDTwNU2G+hJSSvbDA0C1eg8tzMU3cFFxZzC0jD/RI4KreJgQgJUrORDq8CGRCPR+6bfiUKiPCfSoNDy7EPUHkq93wstpepL0Wu0jhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785528; c=relaxed/simple;
	bh=lDyYEYe/N4mhHSMmROmNTfj8SUYUweA+PUQNctk1vn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZAn+M1urpvlTLzxfi9oPVAyKDCUB5zbmLUr6h2bH5qB1GEY+9z4PLsB5FkPc9m3rrSPQt0PuYSFJZiQKxo9Ry+JobwlMCYYWRwOCEaut+MAseBpBTiOz/6RI5I/aOQvA3KNUCyma/srbaQwdYz55Q+TcnZ53CArQUcMtiiw4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBtxNGxg; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBtxNGxg"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso1868315ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785526; x=1788390326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nkGDVNWv+E37i1qgZxGANcWGk8EcR4uX9VZBG0WIwSA=;
        b=BBtxNGxg3krk4mAvhxSgY8jlwiBzzaX9bWxm9jpVEjAh5jaN+7aCYp4XXze/RyfFTN
         yx25c6MC5q3R296HPJe5js/bj9Pz2x1q1ZN0Ie1k6vru+tLXhDMQyTrgwt0mySLTXZ/M
         D7k5fPS+cGu+C3j5jAmZFcbpkTfgqy1CqJpqom79b36GVcUkVbdTFhgCiJ6r1XCFaeYn
         rR+q52pzw+Zm149LaeMf0OUo80YBWgPmihvzG5975lK6PSA1awWeED1bxX7cW4POGNSU
         jbg7KvF/YgZcnT1sLa7Jq3/TR1pwOigdFQxJcc4CFaC/+cpRHFkc4Z3627vhLDs4DMmF
         /v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785526; x=1788390326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkGDVNWv+E37i1qgZxGANcWGk8EcR4uX9VZBG0WIwSA=;
        b=ApidqMoFK6fpnP39VYRtygHYiPgqsxVP8AjeDsDGfapvuIrbPn5vLpg/fI5yedijL1
         8fsYN6FKRhA2aKK+FsQsb3orxzQRYJFQl9WbefCybsvHuTQ28o4SiIKcBt1TceYbg0k9
         fs9R0I49Yz8Zs1PHmUrjgGHGi6Lf2lYRxogMIR4Sa5VSZxQd3DuHC1NXLFVxG6b0EPnc
         JCIPn8RxE9QcLzZiD5uCnDC33uT6x2K9WkDbt3cKfgfT3Z/4qdfsM0adyk7gwa0t/Pck
         xapsWrgEhMF6o6iM6lpPtx4smIv4ZwvIsZfL/IQT5cuoiqZU6jXy7jrnm4A2SbJjByyA
         3/7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpXLCEXXIbT68abufv+ZFITnDw3y1BpzvgX71vDjOuDTA1N8ZvouI9va6Vf7oqKCmYMuxk=@vger.kernel.org
X-Gm-Message-State: AFuF++mT73WUKfEucHQ12SQFyaIr/Z7fXy4aLKSdw5g9i3WjVKGjs3gO
	nDknlItmJriNa5zH1+nvdzhRKhiNyJNCUsLlz/dmMdZAhJ7/CoZHVbnCZO67X/J9PcSHjmCiYq2
	VAB2krA==
X-Received: from plblc14.prod.google.com ([2002:a17:902:fa8e:b0:2d5:62cd:db79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ed:b0:2d7:107c:917b
 with SMTP id d9443c01a7336-2d7107c934fmr164734915ad.0.1787785525359; Wed, 26
 Aug 2026 16:05:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:59 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-9-seanjc@google.com>
Subject: [PATCH 08/20] KVM: selftests: Use the innermost page allocator API in
 the memslot perf test
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

Use the quad-underscores physical page allocator API in the memslot perf
test in anticipation of converting the outer versions to take the memory
region type instead of the raw memslot.  Stating the obvious, the memslot
perf test creates and allocates from multiple memslots, and so can't use
MEM_REGION_TEST_DATA to communicate which region/slot to allocate from.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index e1299611be32..844ea9b7bb41 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -339,7 +339,8 @@ static bool prepare_vm(struct vm_data *data, int nslots, u64 *maxslots,
 		if (slot == data->nslots)
 			npages += rempages;
 
-		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr, slot);
+		gpa = ____vm_phy_pages_alloc(data->vm, npages, guest_addr, slot,
+					     false, false);
 		TEST_ASSERT(gpa == guest_addr,
 			    "vm_phy_pages_alloc() failed");
 
-- 
2.55.0.887.g758fc8c411-goog

