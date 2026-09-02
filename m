Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6484AE107
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367309; cv=none; b=QuP0gA0SqVRxDsdFABzMQLpmXnFV6bRez+3s/5CeWiVZVwgYbPOx1w8Tx8DDzl3VbKnt/rr/mwpNpUQw8iRIcJ5ZeH00PwwkZs09i5MrwL3fxPNEwVWqyNTikBbkA6//3iF8Q/t2q4HqAIMHsbROCol/vWjzNHWJkPDIPGo/IEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367309; c=relaxed/simple;
	bh=a+smfS4HY4kg5A4IC4+lGdAxAV+Nzj8xt7z5c+G89xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYLhCUsfw1hcnaP9ONjbMp9jtvXFDEqf2daKfqC4HnsnMeyRpijAppqnuhAbYT5Yj4De3Mwke1oQJ797db6chluumA7VP937oCDtMFa2zjHq5kcy4E19UVIHzNpeur4szsiRp1eQVoDAHNmjrJtyElVjYbkFEzOVuUR3l/DkZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiwmPS21; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiwmPS21"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc132709c76so2102987a12.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367303; x=1788972103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F6KFth+wmNcPY6G4yAkPxQ/KQlcOGwTTAk9RODAHfTs=;
        b=OiwmPS21i5FPtKIuozuGY+sdrPc+D+esfQOyzux/OVQ339/UvKRXfxV+x52jGiXJtQ
         +tsuRXSwrC1Rb9jYWJslL0+40NXH+/BYde19yTs1FHaLDjD64wT32D6j1m/oxM/kwMXn
         7/OGgExebZqCo7+z3yh7HNe9oGbFZuGnzVROu5jAnRr/rivkxVA/sItL2x0Bcuc5TtqA
         qkGo10mrEBWhamY41U+7PEmX/nrwrUTIttYf8mKlK0oNfaO9HClGX+XFaTW+3oft/E+x
         VqTW+D1asf8iXUADFXc9K1VNqM2mvudUPl6434KGOs2uD+PXPUajFs1dNcdr0UAUXnSa
         k5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367303; x=1788972103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6KFth+wmNcPY6G4yAkPxQ/KQlcOGwTTAk9RODAHfTs=;
        b=VBvr87efObdyZzQswnJszLHyzenJLusiOohFa8VxsuxMpneqbAHZ7hMCtSP+Tb2QmA
         BY2G0u+9pP8VjrLah0JWWkPL9O6F4+MzcemD10RjStI5+vrppoPt15zAy30heb2Ckf7t
         rJSa18eTtALZ4CKl6ZCE1+6cXmgEAhWewF6/ZQtdv9A9oB+y/WTMC/f8HNjfDz7psPzW
         zxjnagDCTNV2nvG7UPoff7+i6XJEA4HdJ8zuU0DIGxtBg0mzwqiK6pT/D9IDm0LGJ/R5
         nx16h31CPnI2o8xbhnjFCeHd0KrOYzTR6/ErcJwJMBFHQZ/RcszK7yOuh2TU5V+ECU+s
         ty/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+Pe5zB3FoIAKE5w+1PY/o9MSCmyedd4yI3f0ndbhwQA0OXgPqYVsvdGeUDNswRVWV00M=@vger.kernel.org
X-Gm-Message-State: AFuF++lr7zRsSHZCh8+yygePxYgdBXaUUyipfhxa9iDLFCvvNxDKsehl
	iZXsdiT3yWA+gTUUcJ5Nca5A3ZeJa8zY/m2JOzm90cXYPhfJ/o4hl7HKO2hE0/UenZ4gSG91yD5
	I1cYnhA==
X-Received: from pfux9.prod.google.com ([2002:a05:6a00:bc9:b0:847:82b3:aca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9295:b0:837:e9cc:d474
 with SMTP id d2e1a72fcca58-85ed1d07a02mr8719333b3a.2.1788367302673; Wed, 02
 Sep 2026 09:41:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:18 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-16-seanjc@google.com>
Subject: [PATCH v2 15/20] KVM: selftests: Use TEST_EXTRA region in x86's
 smaller MAXPHYADDR test
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

Use the TEST_EXTRA region/memslot for x86's smaller MAXPHYADDR test instead
of a custom memslot, so that the primary vm_phy_pages_alloc() APIs can be
reworked to take a region type instead of a raw memslot.

For all intents and purposes, no functional change intended, as
vm_add_extra_mem_region() is barely more than a wrapper for
vm_userspace_mem_region_add().

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/smaller_maxphyaddr_emulation_test.c  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86/smaller_maxphyaddr_emulation_test.c
index 3dca85e95478..b21798a385ca 100644
--- a/tools/testing/selftests/kvm/x86/smaller_maxphyaddr_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86/smaller_maxphyaddr_emulation_test.c
@@ -62,9 +62,10 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable");
 	vm_enable_cap(vm, KVM_CAP_EXIT_ON_EMULATION_FAILURE, 1);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-				    MEM_REGION_GPA, MEM_REGION_SLOT,
-				    MEM_REGION_SIZE / PAGE_SIZE, 0);
+	vm_override_mem_region(vm, MEM_REGION_TEST_EXTRA, VM_MEM_SRC_ANONYMOUS,
+			       MEM_REGION_GPA, MEM_REGION_SLOT,
+			       MEM_REGION_SIZE / PAGE_SIZE);
+
 	gpa = vm_phy_pages_alloc(vm, MEM_REGION_SIZE / PAGE_SIZE,
 				 MEM_REGION_GPA, MEM_REGION_SLOT);
 	TEST_ASSERT(gpa == MEM_REGION_GPA, "Failed vm_phy_pages_alloc");
-- 
2.55.0.966.g6673acef38-goog

