Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D7340405
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006379; cv=none; b=qdxrx4bOq8Y0gONf/8OM3b8gXMzWIkXPQ3CqdFQ+99GeIBRS0wsoyaAiC0jbDSrmxoa/0TjA0HlcaeInn6zwG5nslQuU05JptFkdkSUOL2hit5G+CQ55An18cxGQ5D3jW3QpgYTm0SBrtwO+cx894h9f09PmhQKiUMFlj38ON/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006379; c=relaxed/simple;
	bh=jgbqz6eIQF58YkyQEmzEEc2oMlTbRn7MPg4Jz/evSCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyszFL7k1hk7IQ2p5nVIb8QdlfbGdRadXTxIugi13bHBaY4Ifl07z0QPnNAMxDE86u7bf2a7H7XD2nWyk0Zav5av2ZUp9jWAMIm1CEM4sUQwK9q3RmSWDYJHG4FqO9k1oYM5zJXCnQ6gAck+uKTPBVb+gj3rBBkP+NYdBTYR/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ1JLxYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ1JLxYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA4E1F00A3A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006378;
	bh=ewqX6HNUiCn2x5rR1E0zpP4kogsLFhvBW0yMF9l/S4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aQ1JLxYovBWEGth4BfgDzElPeXXLXcBFx+ZJ8tnrKolA+0tSWCRv5Ymw3AiLq/UQn
	 QuWuvIx6b4iKX5nN1w1XD9G1dnKER7TULxo8QcRKz/4uNKZr4ujajzdvidLe3DYIqh
	 DIFq5g1HT9lFgARfDBG1tpuEO0EbbutNGteVmpuFC9Ha2XjLBxUfBuyyjgxyGX59xT
	 GlsdYzEH+g3Aov3mUNhL+O3+GG36E+9FcivDfM6+tC2GpFMLxVg6F1yZtumf3B+qD1
	 pq1iZOSLrod5nOV+Py0L9ZoKgnWpFOXvDsVmkGuJMlyZWkRJ2/Q7Gc/fm6Vj8+IrOK
	 C6C0yacg0daOg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bce57c132b2so2352568266b.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:12:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ86jEXkfsyc5MZG1emKn3Fnu6yp62upN4J25uX+fZiq/ZG0y4/snGfCKQn1kG9LWtpriLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYs6FA4xr1eizxD6P7GpIrG0PJzeUvnOUBwKOxGosc9KMof2Z
	DSnMl4Jk+U4/7elPPrRxS5VmlAWKHLmOffHjUcQe93sJbvohk0KpqYqAla+eqludkX/XHI6B9SW
	xd/VDp/lw9Vx2PdmJ+HCQEd8D4sDiMpQ=
X-Received: by 2002:a17:907:72ca:b0:bd4:8286:466d with SMTP id
 a640c23a62f3a-be9a5e40e50mr18546566b.12.1780006376881; Thu, 28 May 2026
 15:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518202514.2037078-1-yosry@kernel.org> <20260518202514.2037078-6-yosry@kernel.org>
In-Reply-To: <20260518202514.2037078-6-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 15:12:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNqYA6CACeGTVLcyj4bJ2XPAzEXL+y9tLuCU5Y-F=D-WA@mail.gmail.com>
X-Gm-Features: AVHnY4KEKQ1lWxVA2Fh4mMSVDYgJWgPC8N_82F-w679hlsEdWu04PhhPOSH1odU
Message-ID: <CAO9r8zNqYA6CACeGTVLcyj4bJ2XPAzEXL+y9tLuCU5Y-F=D-WA@mail.gmail.com>
Subject: Re: [PATCH 5/8] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index caefcd12df8d2..6708fa8b6a304 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -343,6 +343,17 @@ void virt_map_level(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
>         }
>  }
>
> +void virt_map_page_tables(struct kvm_vm *vm)
> +{
> +       gpa_t gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
> +       struct userspace_mem_region *region;
> +       u64 pt_size;
> +
> +       region = memslot2region(vm, vm->memslots[MEM_REGION_PT]);
> +       pt_size = region->region.guest_phys_addr + region->region.memory_size - gpa;
> +       virt_map(vm, gpa, gpa, pt_size / getpagesize());
> +}

This is wrong. It tries to map the entire memslot for MEM_REGION_PT,
starting at KVM_GUEST_PAGE_TABLE_MIN_PADDR. The problem is, the
memslot is shared with other things like ELF. So this tries to map
everything from KVM_GUEST_PAGE_TABLE_MIN_PADDR (0x180000) to the end
of the memslot (0x291000 in this case) using identity GVA->GPA
mappings.

When using clang's LLD, ELF starts at GVA 0x20000, so this tries to
remap the ELF GVAs to a different GPAs, and an assertion fires in
__virt_pg_map().

Without LLD (when I did my initial testing), ELF starts at GVA
0x40000, so it's outside the range mapped by virt_map_page_tables().

We can fix this by creating a separate memslot for page tables like
other archs do, but I think for this case, it's probably simpler if
the test just walks the page tables and maps them. It should be one
page at each level.
