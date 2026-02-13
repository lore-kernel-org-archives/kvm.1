Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD4EADC
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943129; cv=none; b=HHeAubPbPFG2j4emK1JTUIUFqTcM02m5MqXHGLel4RScHfw5jiVri40bTlbMqG5DXXTf9DhsS5VxE4ZxKAB4jsFRIEjCI9yP5RchWxmM4ah2GervFGE26MGqQXDqXd1W+8PD4KB36wwkQO78JHFAgTznccpz8zR3ff2HCHIhkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943129; c=relaxed/simple;
	bh=2DagQ7Z6PSdAo8VfOCBjXEyAmoENTvDEySAijPoTuSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5LgdEkmlhv11h3UXlUEC4l7TV/y/V8DW8IXymdTGCI98s1Oo9CiTvoXJSx+td+onoq3c2z66I6vuZONZ+QEvymUvZMEmEXqrkgaU4RyIb9R7Z6jnTi60CEWgmi5ogR7K0KTl1FlVT9nMOQKgQRkNKi7PtTucL/bjCQ2bRShX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ebDmN24w; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ebDmN24w"
Date: Fri, 13 Feb 2026 00:38:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770943126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aysiS4ZcRobHWrxwadZjJ43xW2yhlqYR6hHZ8TyDg0=;
	b=ebDmN24whAbbbAtaKfyFRMsayDnDkXz27MBZvwuNGgtA5Asmbt9ULXRpKP/mq5zbiGLvv2
	GsitylfSvWR0PncgJiLMITBvglbw6iPf2n5P5nTjNSyTCtfDgfdXRsFBvVGNLPCnpH1NHY
	D+k0j4nb9xDj+wG+qp2G+wSCrHaQQeM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 7/8] KVM: x86: nSVM: Handle restore of legacy nested
 state
Message-ID: <akwkdvqgoaee6eklcomghwfi5edlu547pruh24ixhwvuqv2q62@wkpdfaa36tiu>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-8-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212155905.3448571-8-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 12, 2026 at 07:58:55AM -0800, Jim Mattson wrote:
> When nested NPT is enabled and KVM_SET_NESTED_STATE is used to restore an
> old checkpoint (without a valid gPAT), the current IA32_PAT value must be
> used as L2's gPAT.
> 
> Unfortunately, checkpoint restore is non-atomic, and the order in which
> state components are restored is not specified. Hence, the current IA32_PAT
> value may be restored by KVM_SET_MSRS after KVM_SET_NESTED_STATE.  To
> further complicate matters, there may be a KVM_GET_NESTED_STATE before the
> next KVM_RUN.
> 
> Introduce a new boolean, svm->nested.legacy_gpat_semantics. When set, hPAT
> updates are also applied to gPAT, preserving the old behavior (i.e. L2
> shares L1's PAT). Set this boolean when restoring legacy state (i.e. nested
> NPT is enabled, but no GPAT is provided) in KVM_SET_NESTED_STATE. Clear
> this boolean in svm_vcpu_pre_run(), to ensure that hPAT and gPAT are
> decoupled before the vCPU resumes execution.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
