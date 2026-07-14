Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4C3630B7;
	Tue, 14 Jul 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023828; cv=none; b=eRA1P9BsrmC4ALxJuj3dlBuWTLw3ilzr3AK5M/PGpyfxuTGj8061GLyvmLZ+FHrn/Z70SH/8Ig1fLojquAuPxRo4F/wMkpboTtWQqYzyzoXzuUR3x06xg713ZeahQrbA0LT0/03gR8YISZ9BkRtYWb7RfQVcPotoCeYtNRqr2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023828; c=relaxed/simple;
	bh=wfNQV8uoSTWcGifP7Xz2Rw4z1vDZp9TVrfbASBgUydQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN6szq5aTGzcSndoZ+irJIu9rpziUpGDeSIfDdzjNhKu6Tqq6rmDI+liUjfuRkCoAdelunQCZ73iZnf8aKh5fn0bGN1WCcUwLP1jEpUg+SL1mHW4nyk5EuHPSWp18rv+twmsQA/rbDKyzH8TcX+5bBwGKp92gHX75PSWXVnqkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2pk87NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2pk87NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864B41F000E9;
	Tue, 14 Jul 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784023827;
	bh=XLxFAvblOWwuw+gs2L0IZrJ2IwfHebNZNOaAMJkwvrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g2pk87NF5dRW3KWmItRxYx712BJGi3QjO2NoLDkgKd6Z6hvzCewxaU+VolujD2cbR
	 8YFikZR/dttwAYgbWOZA0Fi2utNKC766Y6KUFtDlg1HNbyew4dyd/3mZDP0s3m1gV6
	 CqeBnTy3D3IjsasnDOs0tIOXY64XpYZyxOLa7vrw1q3g8LBn/+EOVuH7cgNtUkSkRN
	 FA8w+Z1ctrvxYeL+2KPF4aFD6MPP6jFtwO9thRC0mPWvjHoSZwoVtaZZSK3oxybxOK
	 NVqa2XGQtHgBoEZ1qeuhIgS++a40yeNIGeTV2no5kt0q46Fo3RMWYfOVCsBp1k2SbX
	 RwGcuSIDAwEEg==
Date: Tue, 14 Jul 2026 15:33:11 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 04/27] x86/apic: Use AVIC_INCOMPLETE_IPI VMGEXIT
 for Secure AVIC IPI handling
Message-ID: <alYEqXm0AG-S24oI@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <97a8081fb548567f004f31e2afb02bd06d7a9982.1783490022.git.naveen@kernel.org>
 <29a8e63c-d317-4717-ace2-9471e9866eb2@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a8e63c-d317-4717-ace2-9471e9866eb2@amd.com>

On Mon, Jul 13, 2026 at 12:59:50PM -0500, Tom Lendacky wrote:
> On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > x2apic_savic driver currently uses SVM_EXIT_MSR to have the hypervisor
> > emulate ICR writes and to be able to deliver IPIs. However, the driver
> > also sets APIC_IRR in the APIC backing page of the target vCPU, so the
> > expectation is only for the hypervisor to notify/wake up the target
> > vCPU.
> > 
> > This is incorrect since SVM_EXIT_MSR is for requesting full emulation of
> > a certain MSR access -- and hypervisors expect to be able to _inject_
> > (set APIC_IRR) *and* deliver the interrupt to the target. This can
> > result in duplicate interrupts at the guest (assuming the guest is
> > allowing that vector to be injected by the hypervisor).
> > 
> > Instead, have the driver do AVIC_INCOMPLETE_IPI exit so that it is clear
> > on what the hypervisor needs to do. This is the same exit used by SVM
> > AVIC when it has already set APIC_IRR in the target vCPU APIC backing
> > page to request the hypervisor to send an AVIC doorbell/wake up the
> > target vCPU. Add the newly added exit ID AVIC_IPI_FAILURE_UNACCELERATED
> > (ID number 5) and use the same to signal that this is a Secure AVIC
> > access that is not accelerated by hardware.
> 
> Except that the GHCB specification doesn't have this support, so you can't
> really do this. And if you want it to be part of the GHCB spec it will
> need to be a new feature bit at this point so that the guest knows that
> the hypervisor can support this new exit code.

Yes, will drop this patch for now (and the related KVM patch #22).

> 
> With the current guest code, can't the hypervisor support know that for
> Secure AVIC it only needs to schedule the vCPU since it is assumed the
> guest updated the target backing page?

I have more fully explained this in patch #22 of this series, but TL;DR: 
I don't think it is correct to special case SVM_EXIT_MSR(APIC_ICR) 
handling in the hypervisor for Secure AVIC guests. Especially because 
there is no reason full emulation of APIC_ICR WRMSR can't work if the 
guest allows IPIs to be injected. i.e., this should be a guest decision 
and so, having a way to differentiate the guest request will make the 
hypervisor changes simpler and more straightforward.


Thanks,
Naveen

