Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1D32C8B
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102788; cv=none; b=OQqDAgCTXCuI1kY5+76lZ+3+I3xkPz5IARwdqr0qPEbfsmJ+zlxMPswiie/2Q88UpkG3/lqy9Nz51UDyjVhgDLqCl+TWGxzleYffM1GQREnqgP5PJbq5nexXUWpQ1O3KTuCaFZZxJziGbB/5lMZifrYETDALNudbhH4FEsBof/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102788; c=relaxed/simple;
	bh=P2oNbUgzNKbPC97q99tgXWb/Iok5vLJAaFSYPNe8o2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vm+I9ECgKngeYCCnP9ty84BdDegHkmJdi/qPdetqgqjGMf0SXM14V1wAm60rMnzHqPWont6T13G8hDh0P2ERzDL5l7wP25iSgugj+98hqtMyoVVS4Cqd64K2bL5qArsvxM1UFbdPi2ucE3tyQJ8+qfyFEYjImdAX4+2F3gxCkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekHOAbi+; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekHOAbi+"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so229184a12.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790102779; x=1790707579; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wsMfNykkK/cvGUxGrrzkLoJGO5iJ1c5hJgEqfch5614=;
        b=ekHOAbi+hrIDGP5HnGxwI2etEUQxYRj0wGvz6jB4CC1kT9eH9vNNf8T2qgXOkEoqoR
         IEzRBccGesk15NkIaZcYmOqA6D3c3Z73qd8t9i139KEdv+3/OHGNL9x75IeoIuqBwN15
         c2/ERCpg7DdDHfFNMo+MH8e/a73y5IfdB5xNHJY5sZqb7u5Ntn46Ts0sMS0xMbaa7noN
         R/1E66trjXajolmZ2k6gm3Ytlhwuh5mM7nJ0ggNaOTx3erTglnC96+ZX3Sh2iGrRvVtn
         h4nUdAkhIP8zbc2pzKbcMhVTInevuAv1zutv+pyUW1D5TYUeq0vdXOhpFMNR7uxKk6Kr
         WQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102779; x=1790707579;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wsMfNykkK/cvGUxGrrzkLoJGO5iJ1c5hJgEqfch5614=;
        b=VMyojoS9sl0qG1rnAtgvwJWbk5ATv1xnaiVSqv7+9/ybW/ULb4nUsiubzfrWOc9Cc2
         D3fs7BPtgstrfrHvNdz1rjI/CLP5wjrOy42FPmdV+wlH/Ubze/faftktSRAYLUd2akrm
         +a1iIXtQNjdvs/F/U0tpEeqYC/EAgJC8M34MADhzN3Ntn2pmluJDUH+diSTykaKUM+pC
         3PiNLFwMkCGMN6VjHScsIl31QJ0VaVhfmjOF7d2qTfHSGWkUUT8uBCEyF2RcuQm0xLg8
         KyfoBv+vr9/UJNA7BU4GuGUKNkD7pxrF9BO8RG/7cvCRaJfv6JVBeZPKmX/HB2qDOuJc
         t60A==
X-Forwarded-Encrypted: i=1; AKwUvByyz0Qnp3o5W5uWn355bV6Z5TNvH7+krg82H0KYXBX/3oC3t4g04nLm6jaFTjJ93gG2i+E=@vger.kernel.org
X-Gm-Message-State: AFuF++kJEc85bHoP3XB+Qfecvboeff003Iv/QmZVxY8XvP2oYiHzq9bO
	Cy7NUzQjiKy4zXh7WAOE+BSimMRCX5oFtW9LqSiUl94QUz2zuzAhLvykCCmhY1bnMsgengv/WbT
	hS+Jk7Q==
X-Received: from pgdh8.prod.google.com ([2002:a05:6a02:5188:b0:cc5:1d7c:ddeb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc3:b0:3dd:a197:cf2a
 with SMTP id adf61e73a8af0-3ddf82c4849mr289558637.78.1790102779162; Tue, 22
 Sep 2026 11:46:19 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:46:18 -0700
In-Reply-To: <arLJ4AbNN9Y_IUna@gremlin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org>
 <20260922-kvm-arm-prefault-v3-1-787bd3bc7e3f@kernel.org> <arKxjsxuO1F5ExrY@kernel.org>
 <arK5n9HrbZMCOHOt@google.com> <arK5ynpRi7VbY7Ek@gremlin> <arK8seJVT9wYgVCP@google.com>
 <arLD-eZ6dRvfZ52q@kernel.org> <arLJ4AbNN9Y_IUna@gremlin>
Message-ID: <arLM-vJDoO7gQJXM@google.com>
Subject: Re: [PATCH v3 01/14] KVM: Allow architectures to disallow pre-fault
From: Sean Christopherson <seanjc@google.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 22, 2026 at 11:07:53AM -0700, Oliver Upton wrote:
> > On Tue, Sep 22, 2026 at 10:36:49AM -0700, Sean Christopherson wrote:
> > > On Tue, Sep 22, 2026, Lorenzo Stoakes (ARM) wrote:
> > > > On Tue, Sep 22, 2026 at 10:23:43AM -0700, Sean Christopherson wrote:
> > > > > Rather than have kvm_arch_vcpu_allow_pre_fault_memory(), what if we add a more
> > > > > generic kvm_is_vcpu_loadable()?  That way we don't need to worry as much about
> > > > > the return value, the connection to vcpu_load() is obvious, and we don't need to
> > > > > add another pre-check if future (or cleaned-up existing?) ioctls want to do
> > > > > vcpu_load() in common code.
> > > >
> > > > ...this is exactly what I started out with.
> > > >
> > > > But then you are in a pickle, because _really_ you need to do that check in
> > > > vcpu_load(). Which is a void function. Which is called by every single
> > > > architecture all over the place.
> > > >
> > > > So you'd have actually no way of signalling the error back.
> > > >
> > > > Of course those places are arch code and you could say 'arches should know
> > > > better and if they call it it's fine not to call the arch 'can you load'
> > > > function.
> > >
> > > Yes, that's my vote.  It'd be easy enough to clarify that "rule" with a comment
> > > in linux/kvm_host.h.
> >
> > I feel like trying to make this generic will wind up under-documenting
> > the single example we have with the pre fault ioctl. Putting the comment
> > into a header practically guarantees that nobody will read it either.
> >
> > I'd favor doing something like below and sticking the comment inline in
> > the ioctl handler. Unless I'm missing something blatantly obvious, I
> > don't see why the x86 or s390 pre-conditions can't be tested early too.

Oh, they definitely can.  I'm a-ok with using kvm_arch_pre_fault_allowed() on
s390 and x86, the only option I am against is adding kvm_arch_pre_fault_allowed()
but then not using it on architectures that obviously perform that exact check.

> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3961,6 +3961,11 @@ bool __weak kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
> >  	return false;
> >  }
> >
> > +int __weak kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +	return 0;
> > +}

There should be no need for a __weak placeholder since this code is guarded by
CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=y.  I.e. force architectures to define the
API.  I don't think it's a coincidence that all of arm64, s390, and x86 ended up
with restrictions; pre-faulting is far from a simple operation.

Actually, that's an argument for a dedicated kvm_arch_pre_fault_allowed() versus
a generic kvm_is_vcpu_loadable(): it helps force future architectures to actually
think about when exactly pre-faulting is safe.
