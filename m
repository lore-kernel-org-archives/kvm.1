Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A83C7DE8
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332407; cv=none; b=U0GDIDsMguJMrYFnXuwVcdqSe+MWxX5x99ue4QUt4dHfdXyAeyun5+QgiD5LoewlsVUN2UJHY3CZ/fO2HbuxxXFdil5Xzfn/EUNCozUF9oY9FymC7wccC1H11Q3vdD43Z4VTHnNC7W/kYmIR6QpMGU1we6uF0KumGq5vnSMTaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332407; c=relaxed/simple;
	bh=jk3fauaN832iIRTlIyZI1qhD/K8FI6embHahcA2wqKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+4J6HiT5YyqqlMqmYHQug6Z1tzLHLXH+NSmwmf5+206iIwueDYSEayVY3jXbvb7gAepK7AT95P/TQy3fqsXs2Leoxhxtfra9nWoCv5EbHc50cmzdRfuOPIB4bGWY4tdYlaVcHJIjL1i9VMRlX80O44+vNVk9Tse/aFCT+KHDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2yL0cJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2yL0cJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60212C19424
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773332407;
	bh=jk3fauaN832iIRTlIyZI1qhD/K8FI6embHahcA2wqKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T2yL0cJKNt0yYQ1aQ95cru4Hg/Czu+awdwYtua+CqqpxvJYzGuVAE3rHQ8+JzCHUi
	 p4WHcsbV1te9ocpZ9mFCnplujYhWvPUqlO4ceuppZ/8aLcantEKM5G4h4V3G0adnBH
	 CpIGlk778NKVR9kaaAeYkGwSOJJ0U+T6SiFQ9VyWJHoPsKgNJLcG2Vrwb2xME0m0Kj
	 XDPk8Cjg0OQyiwRjTFwzuePUl9oU2iNFCaAvz0EVuurUH3/YkiNwawmWk0+0kQsIMj
	 FbUqw3j3NcYH3zIJqiMXAgVmaappCD6XdbgjBR8q5kjkCo1/GCpY5Z7bjENRuzXXdf
	 tekLIbDsF9EcQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b941bb3e23cso203006566b.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 09:20:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8uwWtTg8PCVAAgX7T64QGmiPoFzsysgXDSArhd7njBy6R+imACOF8TE7U7Xtndr21vj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQBQEhHqutOkYZcbopuAb/6yOqXJNS4RDwW6rVtHZZ2Lc0E3T
	21FgW0RPC2HZWsBBqFAfANWKocygHnkcoCU3krfzUWGai3jx51AGITEk3KZj9q600zBqnFfw4iA
	J2SW3fLgGqaDDv6JY1oZAPGK8s0hnYlk=
X-Received: by 2002:a17:907:9415:b0:b96:edf8:5baa with SMTP id
 a640c23a62f3a-b9765100ddamr1358466b.32.1773332406244; Thu, 12 Mar 2026
 09:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
 <abH0RdnM29Xyh_4G@google.com> <CAO9r8zO_Mo-98MqREwHq4JN0bA11H2EpmNmUkAU5QvNm9OGNbg@mail.gmail.com>
 <abLhvoAg17OKMrxR@google.com>
In-Reply-To: <abLhvoAg17OKMrxR@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 12 Mar 2026 09:19:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPEqVNK3DrnFsTxBoFnGa0HR+YickUiUMU8d3GbYZLZqw@mail.gmail.com>
X-Gm-Features: AaiRm50K3adjhkCMWKVCz3StQWDjRuQditaH3RrP_-gYBWlDFNPYaA1-bSPIcqc
Message-ID: <CAO9r8zPEqVNK3DrnFsTxBoFnGa0HR+YickUiUMU8d3GbYZLZqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index e6691c044913..e1223c07593b 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -2294,7 +2294,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
> > >                                 EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> > >         } else {
> > >                 /* All SVM instructions expect page aligned RAX */
> > > -               if (svm->vmcb->save.rax & ~PAGE_MASK)
> > > +               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
> > >                         goto reinject;
> >
> > Final observation (hopefully), this check needs to be moved to the
> > VMRUN/VMLOAD/VMSAVE interception functions.
>
> Gah, yeah.  I noticed that when initially typing up my response, but lost track
> of it when I got distracted by all the emulator crud.
>
> > As kvm_vcpu_map() failures will stop injecting #GP, we still need to handle
> > the case where allow_smaller_maxphyaddr is used and the GPA is illegal from
> > the vCPU's perspective but not the host.
>
> allow_smaller_maxphyaddr is irrelevant.  My read of the APM is that the intercept
> has priority over the #GP due to a bad RAX.  So with vls=0, KVM needs to check
> RAX irrespective of allow_smaller_maxphyaddr.

Oh yeah, good point.
