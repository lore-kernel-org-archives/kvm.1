Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BC3932CF;
	Mon,  1 Jun 2026 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357460; cv=none; b=m7PhyHg5XXdAigxsBe8WX3fLjdNJyemOCAaFHA006PXRYVHsrfbKcSq6Ka76eK2SfWPhBaS5Oi4QIoQeXAtkvghnuz6wqWvt0yo5PZOh60QqkGHDxl7chuTEho33w5daZb3IDzjGy+4OAAm+V33k4Ogq9zfJ3YI42nFtN7Oofwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357460; c=relaxed/simple;
	bh=u/bU3vL0mqHY3fC68CcQAk2pnQDrS2Rsylw3gjI+J3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTzaAAQywh6cWrb15jT3aK/xA+e+nveImsrFfQw0o3erKHga/yk713NOuqcG1WyxzuV7VhWPca0hRMDY/imuqjuQrUkDlBo1Qy1PfK49Ovi6qAjkOrRrYFPUMeCnAOxbWD3hOapnMaQpm7T6MvgRMtoBRyptOKkSj4DcUdxUcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd0AFAA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd0AFAA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50B1F00893;
	Mon,  1 Jun 2026 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780357458;
	bh=Iyua04gcQuq/Nd5ldHXL+d8ROI/ESjT95LhS9Rfq7kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gd0AFAA6JdTCXFdaEn/mc7f5QJKVIRVOCJRMK+MgG7wKNxNIiKJKEYO4muTyYJaQw
	 E+2E3jaIqFXAhT8z2o1tKUX3ur9JT0lyF7FffkBs3gVTlHrjhE8Q519fPzKbqvCitL
	 vU4J5k+Dcp5e5+t2Z7nQY3rmVb4AOH9TSC5JYl9WdDxOFVY72Bzt2fgL2gqEx6CT2n
	 eQg5cGuP4HVRW2TIpdnqrss1cgYaweA9h+oq//73h1q8FBYWGU3NDDjkqM1FtdSNjx
	 K/8y8O0erbHNy1lDgr8Jh7WHxVdPnUCrr82v6Fwhu2WAkRXX/Oq1NffRKBte2NbXmG
	 5OJT44N8JB6/g==
Date: Mon, 1 Jun 2026 23:44:16 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 36/40] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
Message-ID: <ah4ZSMzjF9P3Yx-T@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-37-seanjc@google.com>
 <aho4YC1ufeX14HCE@google.com>
 <ah2jynIp6qVBNJCd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2jynIp6qVBNJCd@google.com>

On Mon, Jun 01, 2026 at 08:22:50AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:22:19PM -0700, Sean Christopherson wrote:
> > > Move the function declaration for APIs to get/query pending IRQs from
> > > kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h | 5 -----
> > >  arch/x86/kvm/irq.h              | 6 ++++++
> > >  arch/x86/kvm/svm/nested.c       | 1 +
> > >  arch/x86/kvm/vmx/nested.c       | 1 +
> > >  4 files changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 866d33abaee0..38de6c0dc743 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -2360,12 +2360,7 @@ enum {
> > >  # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
> > >  #endif
> > >  
> > > -int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
> > > -int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
> > > -int kvm_cpu_has_extint(struct kvm_vcpu *v);
> > >  int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
> > 
> > kvm_arch_interrupt_allowed() is only used in x86.c. Probably it wasn't
> > used outside of x86 code after a1b37100d9e29c1f8dc3e2f5490a205c80180e01.
> 
> Oof, and it has x86-specific semantics (KVM x86 very much relies on 0/1/-EBUSY
> return values).
> 
> > It should probably be renamed and moved, maybe separately.
> 
> Yeah, I'll slot in a patch to bury it in x86.c as kvm_is_interrupt_allowed().

Thank you!
