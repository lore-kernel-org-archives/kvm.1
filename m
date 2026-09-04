Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D440099B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528726; cv=none; b=dhZJzBJLQq5bBuI78BjzMqaSyXEocZ3ndH10LfEjxra/isF6ZKZZW6ArBuOVWaa2rRZS62rjwY7l8glzlYrgPMjNuakhcwKkZHDmhkdsZVFFSBMmvJeDU89NUOyGjKxfhNBGgTWwjXKe1AYGSWJYVq/SqLfSc3V8DkZ50dSaXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528726; c=relaxed/simple;
	bh=C7z5V731jarmZubJ2K9Qx2K4A5sVH5GDaEe3NpPUqZ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VAhbNkYSjgQ9jwQcXWVGHBqamaeAqTP267QgB8BJXv1IwAJ3QFN52vigv/oDSqVHt0YrblvCxAMSjP++Y6iROYM2o6rvXrQLIWkUVELf1RZzFwUhZ44h5hvO31wVNOa+HRr6Bm6kE2jS3WHgo3jiCZGGk/ia/Qy/MzshQN046N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkA/yc3e; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkA/yc3e"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so1127332a12.2
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528724; x=1789133524; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gE9P4GObqZliYweF8gHdbLVlqBxBO1frIJ8W7HGnk/w=;
        b=jkA/yc3eZJaYPySAXYUHwcTXw9tyrOGyuJZ/VV4r77F/ozSKUF0GR7U6J7TwNzdSNh
         zY9HlZo5md2NvEKA9q7f6aMJxziRXyaptqqUnSH0WwUI04Wy0kmhwa5/NcC9srzynOP3
         TVinUzqElRH5I6uO4N7ibY0L9AsfsQkifeo1qWqJ15g+d3Daq0RjWKzCwXNYqAHCK/DU
         vp/+BfKsNU9qbeQA+36s+tPc4V2/t7NIdD81huT3Da7GV4Nhz1GSvZbAiPoXPzGM4ROX
         lzWKVzW8yJTzHaUNHW5rdjZ7GBzPk6Jzei9YdwwGRoMFG1a7oOTZzV1vSHRElU7panVb
         932Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528724; x=1789133524;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gE9P4GObqZliYweF8gHdbLVlqBxBO1frIJ8W7HGnk/w=;
        b=jR2q1CkHTmT8nf9oJkmmUyGwLOVX27MMD6J75bN9Oo12JX5V0eWgByVggOo14aIfn3
         NyZE4gm6bK8XGBmd58gH1rHi84aZin8G6sPQiFEm6z7VvjQX/SWl53ncc4ibWNTwKRol
         iuCaIrOmJRVZweCygI5YzmbMQOigBYBbcG3UAFSpzJiOczo+QYyv569dPEqyaNZ7ZYK4
         c+Bb/V5HhCM40/CtBM05Ndyj1wgHD3W55CBFwcr83+IfvEhABbBcYisqF3+CVpb7MUmu
         yOgsnyS3P0bBUatochc2VKoF2ZiVhb5XYrsYCua6J26K88zXlHof0u3YAR3oRUw2JdSM
         FKTA==
X-Forwarded-Encrypted: i=1; AKwUvBzYPX5wJ2CsLekrmJABGirQy5+l4LpQIa4yPolFyb03blh/mRtmeGasNeFaYp/zTloL1PI=@vger.kernel.org
X-Gm-Message-State: AFuF++nDgG/QJaTggZdio3Dro9HxqcjTTtqLrNOxdqmqTzfaYgGX7Kvu
	NxxO6LEQfmNu1fBBHYKbQ1283RaqzPEI7qsTtpG7dCXbEDd+zbD3oCWW
X-Gm-Gg: AYBFou31nTZuTN3XC3OH1Kka6hje3nwOMEQyFxPMiGpJz+ygiRMtpqjX77GtizSoocb
	U4RI1UY5ZlDlmiCzi1cFxveEj9TCDT7UJTqC4jy/sgrw6RDjmROjVXUVx9deKu8yYM/ZXfpacdN
	X3Z/ufaM9m04qbDvM9WcIVdsNzpYphZ+LpQstOan2U4ZQ5f1yNJy40RiqpVbAYSIhsXMXqPeOLh
	iTl4hJj1r01vsE7MTOb4n6t3v22RVQMLkCI7apNbxCZ6Ela8gjwVWnR5SncnKjStcNOEgro0Xpe
	U4ZFyJXc/hvcRC5dv5X0hAlKKSKkfmqgnH4r/tEd6YOp/dN7sLysXnQuQ+ycb3qmFldlSE/G4iJ
	Bi7ddx+PhUAHN07Nlh6Y9NC3V3EWVIIuXnt6WmE6CIxEq9dWHplwuCZ6MGqhU+KyaQF5ynnFqbC
	IkPzo0j9WFk/VuYz56GYSrZhhbRYweMFF2X0oh3n7jcDlWI7QjM3UVDqVf7jai4LkPLDnbiObFe
	pdEmeGpNkZDuKL4PKyn1vVNInfNY9DJkNA36o7m6iRx
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr10859346a91.11.1788528723581;
        Fri, 04 Sep 2026 06:32:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm7083483eec.5.2026.09.04.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:32:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 04/20] KVM: selftests: Rename "num" param to "nr_pages" for physical page allocators
In-Reply-To: <20260902164123.2546762-5-seanjc@google.com>
Date: Fri, 04 Sep 2026 19:00:16 +0530
Message-ID: <ecf9ta8n.ritesh.list@gmail.com>
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> Rename the "num" param in the physical page allocator APIs to "nr_pages" to
> make the unit and role of the param more obvious.
>
> Opportunistically rework the function comment to drop the superfluous
> kerneldoc style, and to very explicitly call out that success is guaranteed.
>
> No functional change intended.
>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  6 ++--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 35 ++++++-------------
>  2 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 5a7a455b5387..95bc0a78d2bc 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -991,11 +991,11 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
>  const char *exit_reason_str(unsigned int exit_reason);
>  
>  gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
> -gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
> +gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
>  			   u32 memslot, bool protected);
>  gpa_t vm_alloc_page_table(struct kvm_vm *vm);
>  
> -static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> +static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
>  				       gpa_t min_gpa, u32 memslot)
>  {
>  	/*
> @@ -1003,7 +1003,7 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
>  	 * protected memory, as the majority of memory for such VMs is
>  	 * protected, i.e. using shared memory is effectively opt-in.
>  	 */
> -	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
> +	return __vm_phy_pages_alloc(vm, nr_pages, min_gpa, memslot,
>  				    vm_arch_has_protected_memory(vm));
>  }
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 9ddc047d5c27..b071d77dd301 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2025,33 +2025,20 @@ const char *exit_reason_str(unsigned int exit_reason)
>  }
>  
>  /*
> - * Physical Contiguous Page Allocator
> + * Allocate contiguous (guest) physical pages in a given memory region, at or
> + * the minimum specific GPA.  If the memory is protected/private, also add the

at or "above" the minimum ...

Otherwise looks good. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
