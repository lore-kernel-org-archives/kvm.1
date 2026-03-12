Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF62D7804
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349322; cv=none; b=XMHB3xvMRMmo6qdLs0VxAxNOw553sQKbVaBKaQSgdYd9BvDcd1rfzRn/hOl4Da6xqFIkCuH/9v9H5+7TPoQBJzxQV4IOhsExK7eUYLGIYbTlACGWXec1DqGvf0PrhPN5kuE+qESGcgvnmp0rGCpqaAAekokY1ToLjVD31Kgmoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349322; c=relaxed/simple;
	bh=41b5JliRNXaurE7N0xaH8/k7eOWf0ummk+6mQ6s7pkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4Vxb4tGx+ORbWVbUmyOTl7/3TJmTaRxnXatqmy6+TyHPj1hL/WFGZsbp9lvK0DIgIM1EL3H1V8BdmCjytkcmDz5+jRQJhhG5w70ZE90WhJibxeBNnGfRt0kIRSSEAKPKPwQ2lCc7qhGtV4PVh0/3/aiuLkDFnTopyHoG3q4QVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKEYLd6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKEYLd6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCAC2BC87
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773349322;
	bh=41b5JliRNXaurE7N0xaH8/k7eOWf0ummk+6mQ6s7pkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FKEYLd6hiyL0Oj97rYXKbkBZVZ9ne5cfKNesFwjtxO/Ub2Ad6dW+Jw+UQMT7iTFyP
	 NfF9DL8cJmtTQRk+aB9U7jp97vGSx9YESAEUjunometPW5Qn+/KwIwMRdcEoAPNBCt
	 sAnq378ggGeLKt8XM+LUSNQODPKN2HnLwRKegOo/HSL7XcKm/9z+a4Sem6zRD23U1w
	 8iDNxOQRB3QaP/DzVhx3r3XpSphPe/gEb4nVHZVnIP8XPe1kyMwZjwfD41cey3PVjC
	 9E31zsIh8V5jJhCckSZmCapePczRjGUp/YJa8pz4Dux5JVpilimP6B15bcuQGs3trS
	 HowoYfq+Xr4kg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9734adc503so244838566b.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU47RHTkfiUkJNYzp3gM8wXpVTZFtuVYHVCAyXjO3So8nIhjRF1PtGozyQAYqoVAXyFQWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoluZI88GL+D/NHPZezwhju6CX8CokH1wLJKYvcSttUmhid9JJ
	XlkXsb1osW2HSruuIu4gv/DhcNsKBI1CyiD0tWIheQyTjs2fAEwErEEnOSoXpfUhivECPeP7HEn
	kL/BrYTtIfdZ97NHGYgbOcysky6PrQiY=
X-Received: by 2002:a17:906:d8c3:b0:b96:ecc3:7832 with SMTP id
 a640c23a62f3a-b976516d5b6mr37264666b.45.1773349320804; Thu, 12 Mar 2026
 14:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-3-yosry@kernel.org>
 <abMCWGOoIvob2bTv@google.com>
In-Reply-To: <abMCWGOoIvob2bTv@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 12 Mar 2026 14:01:49 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOXp_th1-CrKA67jWw0m-Y-U04mGckGPUSCjgN-ggNk+w@mail.gmail.com>
X-Gm-Features: AaiRm5191QtAAvScBCvgLRRl-VDYbDInXbEhDxksLpHFqGW-MrOPtkSRSMepgVE
Message-ID: <CAO9r8zOXp_th1-CrKA67jWw0m-Y-U04mGckGPUSCjgN-ggNk+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] KVM: nSVM: Simplify error handling of nested_svm_copy_vmcb12_to_cache()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I strongly dislike the if-elif approach, because it makes unnecessarily hard to
> see that *all* ret !=0 cases are handled, i.e. that overwriting ret below is ok.
>
> The comment is also super confusing, because there's no #UD in sight, but there
> is a #GP.
>
> This is what I have locally and am planning on pushing to kvm-x86/next.
>
>         ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
>         if (ret) {
>                 if (ret == -EFAULT) {
>                         kvm_inject_gp(vcpu, 0);
>                         return 1;
>                 }
>
>                 /* Advance RIP past VMRUN as part of the nested #VMEXIT. */
>                 return kvm_skip_emulated_instruction(vcpu);
>         }
>
>         /* At this point, VMRUN is guaranteed to not fault; advance RIP. */
>         ret = kvm_skip_emulated_instruction(vcpu);

Looks good. I will rebase on top of this and drop the patch before
sending the next version.
