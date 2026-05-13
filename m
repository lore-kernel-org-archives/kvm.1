Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0E3B9943
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708204; cv=none; b=BR774F+V5gpKqNsLB0O6sQ8PhIrSdzS6mlKtlj34mLuH8Lp875oWdbXUfN/a953ylLpec0se6fftRRyI+voWf10Z91PNxgq03WPi5xBltBfRX86iKmN0NSFzCrO4E0wmhYjWAxcpT8JlemGmQ4gYt0DmpqZF6yy68KxyNwHCyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708204; c=relaxed/simple;
	bh=QAmX9hJ42sRHMJOVurXZ+Th1L3rUZPkMiBdvMHe4SJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDgyMb0zF/gPgVlOeq7YZB7IQKFlcV/UPIEd1ZwwjQbtPYcECnhUZS3mfOG0pbBiXtE3l3bkqD9+0VDI6juOf4IrhD9StqwOxa+afGoyScQmVVBEM/wLwhKJe2CvbGRQTaXadrj5BTQ+J+87rWCyBp/6FTxfeIoMrI8QBLgNJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SshVeM7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SshVeM7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E46CC4AF09
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778708204;
	bh=QAmX9hJ42sRHMJOVurXZ+Th1L3rUZPkMiBdvMHe4SJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SshVeM7gDIWybAdQ8+vK3RoKf9JhHzTl6NPehNV5/bZRTq5tqRs9IPtpX77LLt5pb
	 zUG5e4pgh2sK7/MG/lKDW8a8y+TS279aaw5KA8w0QkMzVURJVH8GsE8hSKtn4LwHiY
	 6cWbXpJ8C16oVh0UGgZO49LSJ7Z5FYMxMRMXP0mvMXB/4eJLmyWkgwBDmnGfNqDy5v
	 MSxl5fa2tMsj7Qi35X/eBxFyGuQmiv1Z+Pt5DMI/Ma2XXqpz91G0+IygnuUfDm83QN
	 00+DoqW3Reyrobvsfr6IeUpaZSduEz1m3g5RXAk48CBABWLwZFtXEJ8aNz7iR576Z/
	 vzZcePKLn5+Eg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso5776726a12.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 14:36:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+MUBQGTqxEfQxGQtNPDkiFXvmDJj+FlfPLKMCwlRblV+z7/FwJoAPhKA+b9Qzean7RP7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfK79Ku9lYpz0oIFR1XmfvT7oD/BG+j3wOyXRRA0JgLFrxmWtZ
	in3DNqrzoYYaligp3p6ssc8yzpzzh7rlZP2XLs3bu338rgUCmzfhX8JIfksvBWzld2pkNr+mWq7
	xP0oDM/gOP5U4VfzD4O/npBokY0RV7OU=
X-Received: by 2002:a17:907:fd17:b0:bb9:c23:573d with SMTP id
 a640c23a62f3a-bd3c161ec0fmr372432766b.31.1778708203273; Wed, 13 May 2026
 14:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-18-pbonzini@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 13 May 2026 14:36:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
X-Gm-Features: AVHnY4JIVXp98mclgI1HOoV07k5zUAoO4VF9uPiKBqXTDjtzd4G3ALIVCaXpInE
Message-ID: <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com, 
	mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"

> @@ -6767,11 +6748,11 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>
>         vcpu->arch.mmu = &vcpu->arch.root_mmu;
>
> -       ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
> +       ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->arch.tdp_walk);
>         if (ret)
>                 return ret;
>
> -       ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
> +       ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.cpu_walk);
>         if (ret)
>                 goto fail_allocate_root;

I admittedly did not take a close look at the series. Just wanted to
chime in about naming. I *love* that we are getting rid of nested_mmu
because I can never immediately tell the difference between guest_mmu
and nested_mmu, so thank you for that.

However, I can't immediately tell what vcpu->arch.cpu_walk is doing
either (compared to vcpu->arch.tdp_walk), so maybe the names can be
improved? If these walks are tied to these MMUs, maybe name them as
such (e.g. root_pg_walk and guest_pg_walk)?

I also think root_mmu and guest_mmu could still use some improvement
but that's probably outside the scope of this series. These are
essentially L1 MMU and L2 MMU, right? Maybe just mmu and nested_mmu
could work? But I am not sure if we can reclaim the nested_mmu name,
it's gonna screw with anyone doing backports :/
