Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A23ADBB4
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552941; cv=none; b=pWH4ocvk0mMm0q5Fi508LDAkfGGNdZpCFSjQnDrp77KUb05ti5zzaRdHh/eJTtlOZQ7YkeGeBs7YgvP2/+VnagXIWsKmNqcl3WhLsxcmFTf+Ip0sbVv2t3yZKQEmiCoxELFBD8+KrIC+wZLCbqkFJgAmnmVJd9A8i9kWSvaIPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552941; c=relaxed/simple;
	bh=55jutqduzYPo+j4DN4BUpNQ2SSPeGj2U2jk2Ewq0do8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKG3m2NnRFWpKvd4OO7MJySTWHWNJL350/GVzd2l84AUnS1WAk+AijyzmlomMgL86pazXLuv09D0txJucS07cMo9BKregpInmURxocJKb3gCWf3+AEfR/NI/ziFnFnh0f9BZGhV8CJwepXUxRU4QG8Flc0kOS8LpI8C/hTj1iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ22SqZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ22SqZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78D01F00AC4
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552939;
	bh=sm8UA+ArwVDFHJ8xUdfknq7v2oXv6RDV3jWvZMnnSoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mQ22SqZHVWoib3A1zBSuMmZD0O1hYOPC2FE5l9JseM8v77qYNVfF0lOUtLKe6Np9K
	 t7WcfQqOsWtHB7wK5nJ+ctInekdmSsHTFNZifmN4epksFmK+O5i6elaZMZEoEg2EWX
	 nbPPWcQwHidNm+2oBivGGm7kxHgLpm+mfwWWNGztiuGcIOpyhwPPRIm++JBTNeSzpf
	 Xy9YDThlZ3c+MJQBvDfy6fKwSizaJh9878gCbdm0KwTdqOjPzswrxEHVY5hQRpfmIL
	 17RQc6WhsRHF7MGmpdAfrrG8eVMInoRjUeau8aKcE5ELOgJRp8i8mcs5liAJJl4qIR
	 TcEbFOc5mqX9w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec429c2bb1so532133466b.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 12:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Y62KkQxmaUu4wj1TIrhRM4v61igLZ6MFKziSc8nGwbOgWbkHPEXxIW6uGoLaXxRpBBpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEQwe5cqF4kqfOC08xWQRdmCGxLdwZO9hR46TggdxxFBKESzI
	tsLIJIMue+ewLZTvFHHXaBR8DmOznxZdN3xXrDpQ5Duyb+6eDvFWSl+YZziRPh8GcoXUDMbhbQl
	QmJl19Zjacgw5M4uUtWEzzSapkq4zgI4=
X-Received: by 2002:a17:907:7fa3:b0:bec:157:a63a with SMTP id
 a640c23a62f3a-bff499220dcmr587725966b.1.1781552938815; Mon, 15 Jun 2026
 12:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com> <ajA1xaafH-IkuugD@google.com>
In-Reply-To: <ajA1xaafH-IkuugD@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 12:48:47 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNFk287zeB+0nrUvcCqpn-wi3CZo6t-9COQGkdd3POzMg@mail.gmail.com>
X-Gm-Features: AVVi8CfeGu7CXf76e1jh9Jal2h2Sy6s7fGR7PDSEQGwHo7vP_5d5VRV3RiDTG_g
Message-ID: <CAO9r8zNFk287zeB+0nrUvcCqpn-wi3CZo6t-9COQGkdd3POzMg@mail.gmail.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

> > The code makes sense to me but I am trying to make sense of the changelog.
>
> What part (parts?) is confusing?  Honest question.  I'm trying to reword the
> changelog to make it "better", but I'm failing miserable because I don't know
> what's wrong :-)

1. For kvm_vcpu_has_events() being unaffected, the explanation in
paragraph #3 is focused on the code path from nested_vmx_run() ->
kvm_emulate_halt_noskip(). I don't immediately see how
kvm_arch_vcpu_runnable() is unaffected.

2. More importantly, paragraphs #3 and #4 read like this patch would
regress kvm_vcpu_ready_for_interrupt_injection() and
kvm_vcpu_has_events() if it affected them. Maybe clearly state that
this patch is the right thing to do for these 2 functions as well, but
they are more-or-less unaffected by the bug anyway? For
kvm_vcpu_ready_for_interrupt_injection(), maybe just make it more
clear in paragraph #4 that it currently incorrectly treats interrupts
as allowed in the problematic scenario, but it is not a problem
because ..., and it only results in a spurious exit to userspace (or
not even that?).
