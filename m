Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C073359A61
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694629; cv=none; b=iGJBbtZQTq7un9Khm8Uhjv/TT9jYDcrpA5qcCB6f8lnRsLhJGsrESNkZZag/MQzzgj4EDPgkETmPkMIT5I8uhMLroi7lLrp740ECnp61dsakmh4r2f19kQYCOp+8DtP55QA2SeFfqexaqoVuOnTpK6eYm2UEYGZckyw2pZ8HLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694629; c=relaxed/simple;
	bh=VEZmo3AoOSdv4lUpS+OG7Tg3j07xay4d+XQpULYfdtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkOwiejTOQzuv6n82huCBe09UhvNHTlui4APZFX4z6Pdz88tKaBEtUmwutJcmb9clruzerf3OGXiddNPqoqMZFkIA/tlrad35TCT5/2jxRq/8inx/mPgprDGNtAnDKr2I7jek+NfFBAHVXkO4Da/Jrrpa1Ny7P1bm0Gg3BGCeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYSBUsUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYSBUsUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC668C4AF09
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694628;
	bh=VEZmo3AoOSdv4lUpS+OG7Tg3j07xay4d+XQpULYfdtc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JYSBUsUlDqvDSy5ewsDrVTgLuksA6BsmFxZLq9gGHG5hXkkj4JICVndiE7JLggV5+
	 6Zs8FTdy4z6EGaHDJ8BSqZoOAkFIHVhwzOakUT6g2RvV4wAbmr1HsTrCdOjmrAOEKu
	 NqWORlUR8XtveH/u0FqjOPVtn1lfejMEzSYxHZX4ewzklk4C5ltkKML6P6GK0s4amn
	 eT9A5CN93N4T2TIIaIio3KCRDn8TS4gygpIgEYIPZKkyGxy1PifWQMdTwQhlKASFmI
	 KcyMAWK+uL9wWziisQXRx/rAcdKfiqANaBTAuX2IMoKI2kAjvwAHD7rTtF4eAkbgS3
	 hWV4IQZ3IUdyg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6653b589a78so2656501a12.3
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 13:57:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEMNvkt6quHH+seLhRt8isrteUdVT88NMvD1K9jkMSv2vHt+jrW47feDxjj9msRg7Y8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyft3z3csSXdju+oUB0vdReqnWTFXyN7NXnMFEh3zPo9nO4O96N
	dGXT5Z8U3qr/iCxWCNQ2J89d2FXhZezE5koPjRoaBnGeopoZhoTjOGUFB2XtCI94YNlHY9LrW9j
	BesqeijObsB0rqp3nG9cVosZvAHYthvA=
X-Received: by 2002:a17:906:f92:b0:b96:ed21:f46f with SMTP id
 a640c23a62f3a-b9765052cddmr648449966b.14.1773694627519; Mon, 16 Mar 2026
 13:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-2-yosry@kernel.org>
In-Reply-To: <20260316202732.3164936-2-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 16 Mar 2026 13:56:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNuF-0ObcrvWnmR8ed+mn-tuNWmK5BYnVZb=8ySdqkSMw@mail.gmail.com>
X-Gm-Features: AaiRm52SJ3vOSPSbVlUVonlxwWsTTouK9NL-Mw3SrNdGznqK1cQhjSue8cXjeKE
Message-ID: <CAO9r8zNuF-0ObcrvWnmR8ed+mn-tuNWmK5BYnVZb=8ySdqkSMw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] KVM: SVM: Properly check RAX in the emulator for
 SVM instructions
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:27=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Architecturally, VMRUN/VMLOAD/VMSAVE should generate a #GP if the
> physical address in RAX is not supported. check_svme_pa() hardcodes this
> to checking that bits 63-48 are not set. This is incorrect on HW
> supporting 52 bits of physical address space. Additionally, the emulator
> does not check if the address is not aligned, which should also result
> in #GP.
>
> Use page_address_valid() which properly checks alignment and the address
> legality based on the guest's MAXPHYADDR. Plumb it through
> x86_emulate_ops, similar to is_canonical_addr(), to avoid directly
> accessing the vCPU object in emulator code.
>
> Fixes: 01de8b09e606 ("KVM: SVM: Add intercept checks for SVM instructions=
")
> Suggested-by: Sean Christopherson <seanjc@google.com>

I should have dropped this Suggested-by tag.
