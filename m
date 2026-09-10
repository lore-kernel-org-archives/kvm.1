Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C4470EB4
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039533; cv=none; b=YqnjTTN2zKnOukaQOpS08w7eQGpb3xKgZHjgOBGBeUaY+L44kr3D7vdAMH/IjkVA1zOWBAsjGLnzp62P1G/SlmsV8dgWjmCqEEfhHg4si/K8OPnPJBvEWRZ5zPsxiOKcgomky/Ya3EXI47RNRT6WcvsulG8fRCWg01Vv6+dGobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039533; c=relaxed/simple;
	bh=DzaaWZMUxb/8rJWyFS7HLbxklJPbE9+saYd1xLzHX/Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=c2mZLyJ3i5qqEF2FU45cCVK5E0DnAJbkdWqftqCfrDB8PLImPQwmizJXzvI90V7O1Rap10Hba52wK/Un2Xwtl81AkQ0d71Ef/wvfzyoQvEHAkZ8w5NDFoB/7ORt487HQlZQ/LQ4MbQIIxghhQ+KIMSRuep85LiCnxnl9XbC1mbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eing4fk5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eing4fk5"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b333de9451so6170519b6e.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039529; x=1789644329; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rKoYJ3dn9mRGunMRInGIver5jTSz1tQREqhFgol67GU=;
        b=eing4fk5KAONTKTXzzEKrsaDMKcjaYa/LOqpRPovIhpZIOEVvEvOZvPmmHP9rNPxP2
         nQKutm/P09DrB4/mXDb8SwjEdQ12mTmGbimWt33D8m5epLlzX3x9+yWdETdD6zFf15e+
         KPHIb1n3bgEGAhG5oOE/+lp0V4uAHdPfEzTGZqBDwFuf09mY+usTdwrKSMEe/hOipvE5
         FX6WkGQyA/FjeIqXgRfEDbvk4S0eNDjy0se1c72KDyWA7IhJAlCR2j2eXHMfjCwklx2b
         C1tHQS3gnYcbfnVfMh8NxaKHxHs6RpAVoVa2LQRPnq3v+8xNE2bJYNb31d7pyODgeeVB
         N92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039529; x=1789644329;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKoYJ3dn9mRGunMRInGIver5jTSz1tQREqhFgol67GU=;
        b=S09h1+SYjSgJgRjJjpF0vPrzNEtPF05J3tI5NO911J6Zt7SpLCJhQikXkHir/kaCTy
         /PkwyhSRBoMXVpP3mrcvGYonf7LDG/13UzZqvKr2qlNva/4aci5Rd9U3xfE2hmELReGj
         rLv1tpX1JxUkyfdJqVwbRdM4zUNqeiStBllYJHMTBLbUmuXGHXr836b7nf7xgEmycHwD
         EsEnkv5isGTmy9Kg0H3xKs0MuExhPgvo22CYZAC/y+w6OvKITULhSCOC29vdUTycN3YZ
         h1S2jS0Pl/kGPDkQh1Xi5Kxhz9LOO2asjTPc/xpNZdMd5N8MsA+8EhRdBKVlQrYl759G
         riOA==
X-Forwarded-Encrypted: i=1; AKwUvByLNgmjuzEz4V+4sfZJCqjDNPAka4sTCD6GOEpxxlvRu+1BOjmR6uNcllLY6rqnnqEbkKY=@vger.kernel.org
X-Gm-Message-State: AFuF++lj8NEygUp7wZbTxZwO3A/GCIS595fHvh2OEEN+23Esui+LFEZb
	l1KDDk5yZtKVldQrMINyMYOc0Ms6upP+QSdQkqQqHmq7yeCoZ/hMfp0l
X-Gm-Gg: AYBFou2/+gGfUXMlUFt0B9VMMlZZYw7GFXgW2hY8du0pQ6ZFJ++LU9N01KVgsMtLtmD
	mB1CPE3HJoqXY8dKvF+Itt6avA3PZkiHBIIpkAlYg0aMlYtL64+21/uGoiLJ2YDqknHmORsP9Gb
	CiiOMNmDdR+FyoivRCJGBYAM19tyDsiK/2a6SmGCcH8TdPH2aN+6V65i3kMCC5QjtHisJYcID4M
	VeBAllE5n+kOHckEc3qDq4TfsEKsFLXTg0CKfivwrf/1dn2ZlUhgxbH88mRoZyDCu/0MMFHuDhX
	NA185PNEu8Dww1bGet5x1HORxStb6dS3+x+v6H3wjy5w03oKqfDGkLpGpPiZsGiG5rpVPBI14NH
	eh8Tq+TCOUyH0y/bgv1yZ7bkZD/9JBNgI7PpXbkCwouHDAG1EAXsYhhk2MEPxsCZlHqT24kE5VD
	JEYMJY+0WUgh2a1/m/510hATZlNthJYX67bcw41oaa+V5xQfqhxKfdoVqL6RMErOliVFqedAe3u
	XJ5iJy0FB+RFxzgNVz8u1J+IrBU9ypk0k6SlaSlFCLpgmGg12OC6A0=
X-Received: by 2002:a05:6808:bca:b0:4b9:e6ab:d086 with SMTP id 5614622812f47-4b9e6abd362mr23531944b6e.38.1789039529448;
        Thu, 10 Sep 2026 04:25:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm6444309c88.1.2026.09.10.04.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:25:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 12/20] KVM: selftests: Add APIs to override memory region types with custom memslots
In-Reply-To: <20260902164123.2546762-13-seanjc@google.com>
Date: Thu, 10 Sep 2026 16:48:26 +0530
Message-ID: <5x0d1hj1.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-13-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Add and use APIs to override memory region types instead of open coding the
> logic in tests, partly to dedup test code, but mostly to add some amount of
> protection against conflicting overrides.  This will allow converting more
> tests to override memory regions without taking on too much risk of bugs in
> the long term, e.g. due to silently overriding a region multiple times.
>
> Deliberately "unroll" the loops in __vm_create() and the CMMA test's
> create_main_memslot() to avoid filling all memslots in anticipation of
> adding an "extra" memslot that is for test use and *only* test use, i.e.
> shouldn't be configured by core library code.
>
> Converting tests to overriding memory regions will allow taking the region
> type instead of the raw memslot in the physical page allocator APIs.
>

May I suggest few changes in the naming of these APIs:

static inline void vm_override_mem_region(struct kvm_vm *vm,
					      enum kvm_mem_region_type type,
					      u32 slot)
{
	TEST_ASSERT(vm->memslots[type] == KVM_INVALID_MEMSLOT,
		    "Memory region type '%u' was already overridden with slot=%u",
		    type, vm->memslots[type]);

	vm->memslots[type] = slot;
}

static inline void vm_override_add_mem_region_flags(struct kvm_vm *vm,
					    enum kvm_mem_region_type type,
					    enum vm_mem_backing_src_type src_type,
					    gpa_t gpa, u32 slot, u64 npages,
					    u32 flags)
{
	vm_override_mem_region(vm, type, slot);
	vm_userspace_mem_region_add(vm, src_type, gpa, slot, npages, flags);
}

static inline void vm_override_add_mem_region(struct kvm_vm *vm,
					  enum kvm_mem_region_type type,
					  enum vm_mem_backing_src_type src_type,
					  gpa_t gpa, u32 slot, u64 npages)
{
	vm_override_add_mem_region_flags(vm, type, src_type, gpa, slot, npages, 0);
}

Those "_add_" and "_flags" in the function names easily gives away
the difference in the APIs, rather than differentiating via "__".

However, logically the change looks good - so feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

