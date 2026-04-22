Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055D370D7C
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887314; cv=none; b=m6Rlh4KYma7vQ4Q+PEoDMMNqgqZTEmnrSRGr9DZkX/ozTgJSnmgg7DXvn0NVPpf9njofyDWrGOv098skMuK5PyJbO5G1iYgDKS/3RO+uVMiNlCXcOR7l9DCSAdZwS7pZpBeoMyXI/bDkMdwnwRwtEw3vGu6+Lv0mRlbb8i2JeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887314; c=relaxed/simple;
	bh=8ymm+PEYpP26tB6tAkR0CvH2l1ZFcCo8oea+4ggRZGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBydl2Vy5QXpNyYDZfa/ZLY1/bsUGqqEdG8JOwH4Rurp3q1sU8qPikWLcfpfDmUryTJv+DllXYHUbjt92+IkbthT5QlLEYGofMKK2JMwtygFMPUm3LaPDgV6I6uaxYP6YiAzbkJuW/oj8f5482/F4nR5v9TqsQEnxLlHkenZCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8AK92ko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8AK92ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF4EC19425;
	Wed, 22 Apr 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887314;
	bh=8ymm+PEYpP26tB6tAkR0CvH2l1ZFcCo8oea+4ggRZGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8AK92koAPbRJykWjZZqKXg6PvWiDglaqHSQblwfKHEg8X/7UEUn7XK6w+20Sw5Ud
	 C8tG08NtEK7ajvs8G/mrnN0a6uDzXoBvQ+CoojYkxGTta/x8ryq9hFWiSCGlF3yCY3
	 OZYISCTqBSICDcieeSwEnQYaYwmjgKY2vcdsVYCheSDv0WWnca2bl21wVtHAF/XcoR
	 GvCUEw8zTBUlSri6cHHfx2fMOKvjSSPntIhM3+d6iqx6R22mOsmut7+78rZrHXrxVv
	 ci4IWlXQZMTks5dM4y6Kbp6Ec5Xz8EQAyqBzKx4w+p4oTjZTZe6oFsUHj0c8m4rB3D
	 94T8qUuNC8IyQ==
Date: Wed, 22 Apr 2026 19:48:32 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Message-ID: <aeklToJ47jJ6lMw3@google.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
 <aegCKy-4wxRq2jou@google.com>
 <aegFDBWMUvhR53c1@google.com>
 <4c977b79-e93d-4846-b57d-e63ac878dc5b@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c977b79-e93d-4846-b57d-e63ac878dc5b@amd.com>

On Wed, Apr 22, 2026 at 11:56:43AM +0530, Nikunj A. Dadhania wrote:
> 
> 
> On 4/22/2026 4:45 AM, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> >>> @@ -3253,6 +3278,54 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> >>> +{
> >>> +	struct vcpu_svm *svm = to_svm(vcpu);
> >>> +
> >>> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> >>> +		return;
> >>> +
> >>> +	guard(svm_vmcb01)(vcpu);
> >>
> >> Why do we need this? Why not update vmcb01 directly below?
> 
> Are you suggesting something like below:

Yes.

> 
> void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> {
> 	struct vcpu_svm *svm = to_svm(vcpu);
> 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
> 
> 	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> 		return;
> 
> 	/*
> 	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> 	 * code, but in that case another update request will be made and so
> 	 * the guest will never run with a stale PML value.
> 	 */
> 	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
> 		vmcb01->control.nested_ctl |= SVM_NESTED_CTL_PML_ENABLE;
> 	else
> 		vmcb01->control.nested_ctl &= ~SVM_NESTED_CTL_PML_ENABLE;
> 
> 	vmcb_mark_dirty(vmcb01, VMCB_NPT);
> }
