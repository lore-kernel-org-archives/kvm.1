Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726938AC6B
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259686; cv=none; b=B5cFRbyu53ZrgawR/vCpzskLIBu4F8ulg2jx2ZK97q7HDP+TUS8AXQu5y2Yq+DoBNamcrg0QOd00Jd+tdT66OeKDArhI5pbTE4u+qD5mpa6xFhaBJ2IGjBUpOtbRj0uBV/z+mSEGiJrbsYLaoynfys+Tr9PURZ/XYrQZublDIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259686; c=relaxed/simple;
	bh=aXkmEBMFRxLk7YEe5QX3DIGgMrHhuObLP7PvBTYKa5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXp2trmI1lzoQXtDcPuCggPmLI8k7OZBLmuvEChSaIXB1N8lwYSrCKRO3AUdI9fRkZyLAbfcaZ92rF7GeYYS/oj3uHqS4zNgjFbre2nszg6zYTQxrhAa9VGGZ/gqgnU8R+nqD8HC847mONY+B0ahIuwot/3CZWLgvomi4xj/gRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox6Fc2hO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox6Fc2hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF8BC116C6
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773259685;
	bh=aXkmEBMFRxLk7YEe5QX3DIGgMrHhuObLP7PvBTYKa5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ox6Fc2hOscg+FTThBri9P3gzYrsptiMGpPUZK31w5HPlH267v6DqMeM9hYMrprG94
	 DhJuzPyeV7ljpOl77Aea03vnhLnS8LRpSoPQlvy+rfoDoJ+sWrwxZ6exREJNWCWFvc
	 3rIyTE2QPlyvgbm1tl7fb/yubhJQdaEKkExjpxNh1Cn3DsbUHTAn1dwxxCqECoGQJ+
	 HbmGAi2ip1sa6UMwexpQAp/jhkrhz3ZQFI1HtUZKKOWw4VFwknc56lXE5FI8HFUjKL
	 /6FvJT5kuu6KFqCffueOVPLpbBOIG84hbyDt/b6BXZLOMXbrfVAro6tRSs6vB/1SRT
	 xvKN5FNJRJUcA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so26489666b.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:08:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNqIg6HYkOzHMuE0K52AlddiFp5tNJJS6vSQEhNT1SYgvwaKC12CKbqYXX4X5+hPUBalY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtAMFZToZH8X+ambuMq7BADKHwXblenloefsPvYc5TLWqv5G/
	wU3vt1rIwDwYHBUv43GRqZI98EI+Ra4Pd157ZzlEM6ON2Qsl853DndS84woblzXc/SNvrWfzskV
	+95fmxCklD0ZcQABhTZFC+WdfLdOlK8E=
X-Received: by 2002:a17:907:7ba0:b0:b97:1009:7536 with SMTP id
 a640c23a62f3a-b972e1b10e3mr225519266b.15.1773259684597; Wed, 11 Mar 2026
 13:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-2-yosry@kernel.org>
 <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
In-Reply-To: <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 13:07:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
X-Gm-Features: AaiRm53ZrnHrtDBrJxbFm-c9aSV5gGG_rbhuRkeeQJZuvRMUyUjiW-RzRHLbPcg
Message-ID: <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:31=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Fri, Mar 6, 2026 at 4:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > > > > Right, but I am trying to have the #GP check for VMLOAD/VMSAVE be=
have
> > > > > consistently with vls=3D1, whether it's done by the hardware or t=
he
> > > > > emulator.
> > > >
> > > > Consistency should not be an issue, since VLS cannot be enabled whe=
n
> > > > the MAXPHYADDRs differ. VLS doesn't work in that scenario.
> > >
> > > Why? It's only broken if VMLOAD/VMSAVE is executed with a GPA that
> > > exceeds the guest's MAXPHYADDR, but not the host's, right? So only
> > > broken if the guest is misbehaving.
> > >
> > > Taking a step back, I am not disagreeing that VLS should not be used
> > > with different MAXPHYADDRs, I am just saying it might be.
> >
> > KVM straight up doesn't support that (see my other reply).
>
> Sean, I intend to send a new version today with 2 main diffs:
> - Use cpuid_maxphyaddr() here instead of  kvm_host.maxphyaddr.
> - Use a common helper for checking RAX for SVM instructions for both
> the emulator and gp_interception() (see response on patch 4).
>
> Holler if you want me to wait for further feedback.

I just realized I cannot just do cpuid_maxphyaddr(ctxt->vcpu) in
check_svme_pa(), because vcpu is defined as a void pointer in
x86_emulate_ctxt. Looking at commit c9b8b07cded5 ("KVM: x86:
Dynamically allocate per-vCPU emulation context"), I cannot tell why.

I was going to move emul_to_vcpu() to arch/x86/kvm/kvm_emulate.h, but
maybe we should just make this a normal struct kvm_vpcu pointer and
drop emul_to_vcpu() completely?
