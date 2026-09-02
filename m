Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CF4AA3FB
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367288; cv=none; b=WMlH8pIB1Qvxl3QThSUuucyQ6lc40YG6nBO3sVO2fVFyJQ9wxZjQPcCYbFIeEbe6rHTGVkwKD+qCl6/xK0v2BJp2cHklm9syA6LIYXlINjCOblYOAcY9200L9k+yDd8oZklPTuYajDTpROahSSaLeB1oyUbI3JjYJ20h4BtVYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367288; c=relaxed/simple;
	bh=HSDUOoQrDrmlHFwLRcHbs3L5ZjzaqYAkiuTkthsWXI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJzflVgw8157lPPck8xMBVDxlw7dijjhQfg54/abC53RyMMEg6nMMhqyAo6S1YU1TF8CmFVH/ERlZbbtLb2stKI/w+esiOhoMTjO1l/OSU7RkaPU1no6bfJBb9acMgzMPBqc0J3kAIwZYezAgoY/rhT5UcwwiJyc0GIBV2SbAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGxOuW5W; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGxOuW5W"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6df0a1e18so23623425ad.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367286; x=1788972086; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=377f8tXnWvaciY/JLF+PS/DOVpUUGqN5+0rwp4hwx/U=;
        b=JGxOuW5WZ1m8AaDa+yi1k9fePu3TilVix2Uy9+kAFQaWJxbDCfaTccWAjs/Iqy2Pqn
         4WDOTg9vq701lSvxWWGvB5GGleZn1CEq2JUG78EUG5srJbrf+P1a9jlI/Fa1PNMgpqzT
         hJWqt+Xf7zbMCBRulLk76vsowAfNUwKis6TtInQkHIvqMAR/aT6OdzS5o9Rbpwv9WKCN
         L2TJaZghBAuK866SVyxKrnVIl863K6SzHYilykU+Q1JwPEKXNHcopWjC51D0N/ptFcv9
         xjxNcAm7iwmYaHKGlZdYDp+8ogbi/l4EpawEQt1DWFcX22uD6s4r1hnVy6JWj8vk0LV/
         vqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367286; x=1788972086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=377f8tXnWvaciY/JLF+PS/DOVpUUGqN5+0rwp4hwx/U=;
        b=jxo6rmnrivASFAvvBQtDwq/ZfFy8dLS5DS1PKWwNBADFLao+xZcqNE4OBrvWM3jh/P
         laSSmVu87jKM/85SxLG8Nq/hYLCO5GowBW8+gS8m3h+tJwnSQWqKjV04eo5XWAOLdHqU
         9G0RXBvgnPNynFTR4dvCW9RXrq9qASXz5JnxE/qdf9DVRa+IIvBESHwH2STSlUES2vxX
         J5Ux2zIRD9CW8qklpDprRcxeSOCeNvWqx9FZocSUO6DWKaDNLBIDh/Q8KVqeRlrNqLHR
         Qpf+mCgKtLxthVPQld+ZLC6uJJpKjZO19LkoMFOtgfvxLzYwcv9G3b2W5o6ybsnSjC7F
         zzGw==
X-Forwarded-Encrypted: i=1; AKwUvBxEh34WwwSWd4OyRBMbMqe+O8A+xkll2cM1NIMsOKY32EPEzLxxstqZl/daSphAsXCnUGc=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Nc8ktPMN+yAddpNQw1LnC9ZKgRvPJOIsnsVMs2DLL4LzO6Tk
	3YXGJU40ZnfKElBMNPlrUyfZixrN3kHu7qfJjYCjUPb7FHYVICSlJxEhYqoCcVKhkjrEBUmcDi2
	FTxGciw==
X-Received: from plru4.prod.google.com ([2002:a17:902:b284:b0:2cc:e407:8fef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0d:b0:2cf:4339:aaa
 with SMTP id d9443c01a7336-2daec6d8a20mr100626665ad.12.1788367285568; Wed, 02
 Sep 2026 09:41:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:04 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-2-seanjc@google.com>
Subject: [PATCH v2 01/20] KVM: selftests: Use MEM_REGION_PT memslot instead of
 '0' for s390 regions/segments
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

Use MEM_REGION_PT to indirectly specify memslot '0' instead of hardcoding
the memslot in s390's virtual memory allocator, as a first step towards
taking the allocation type instead of the exact, raw memslot in the
physical memory allocator.

Note, the only tests that set MEM_REGION_PT to a memslot other than '0' are
arm64-only, i.e. s390 always uses memslot '0' for page tables.

No functional change intended.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/s390/processor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index a9adb3782b35..fb9dab92d4d1 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -39,7 +39,8 @@ static u64 virt_alloc_region(struct kvm_vm *vm, int ri)
 	u64 taddr;
 
 	taddr = vm_phy_pages_alloc(vm,  ri < 4 ? PAGES_PER_REGION : 1,
-				   KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, taddr), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	return (taddr & REGION_ENTRY_ORIGIN)
-- 
2.55.0.966.g6673acef38-goog

