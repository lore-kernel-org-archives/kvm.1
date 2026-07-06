Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EC224234;
	Mon,  6 Jul 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369661; cv=none; b=jDuKHx1XIyPFxKmxSQjTMO+lLf9zkw7BAZfZ1P89ummaVEUTgWf1BjueLUSBU1MR4GGkBmPcStxwFzP37/0jLwnqL+UiEipuJft14j4SZFMeX96ual1F6eXzHS1UNzg9pEq1AwE5xVCRD7+eDBhXxKq5LYbgVel2UM8fc6eP+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369661; c=relaxed/simple;
	bh=ruk4ghMtfGUg8LdOIeQzIRN0vCtLVvttxP+DbnBNFdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5UI4oc9l1fVxOB+skqf5f/NYrl8Re0gCYbvyRHVQb+CII2dl5eS2yUjiuzDaUeVnvCGi20UDnHxgqEHbcZE9nmbRLDm+TdFXfRwao+RRnxq2pT33+RqOwJceYwGjthB/kGQ/iOWptVFDgXuDcCVtAaT83eFtvIv4RzGjceHkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsIV6eu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsIV6eu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DFC1F00A3A;
	Mon,  6 Jul 2026 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783369660;
	bh=RgSANOAi8PLyheoucZJxrl7ZZT282P/QUXx34yulS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fsIV6eu0avJBVcHutLu7OHtAIhwSmYUxFCVBbajdyfYnxlJZxV5kXtkDCXEizXDRT
	 FBRpxc97O7K4hqEQQrcrHavAVrQmSqO+bvxGGSpNNZKM0x5JOw4hjI8E/9yWBagDa4
	 5H6s44A1lg1ojbU5taz5gBOtsTzNEEAedEZ1bt2KIX6yWCE/S2VdEOJsyy5MFxQ/qO
	 blv2bScm+67/W0TOqjVxPj4Q9FrR5doKs0wSj8WozUTXsatFYQVgmQDiip1ZgYYvtJ
	 llEpZ7nZGMJ0SR1kXnq9YtuBdl6l9dkm/SIs/qKtweAPiG9MP+O1ik5LR6gP355cdL
	 ELzbTCzLTbq0Q==
Date: Mon, 6 Jul 2026 20:27:38 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 6/7] KVM: x86: Move supported EFER bits to kvm_caps
Message-ID: <akwPqttHzRDzaqtb@google.com>
References: <20260706195413.1966458-1-yosry@kernel.org>
 <20260706195413.1966458-7-yosry@kernel.org>
 <20260706200533.8A79C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706200533.8A79C1F000E9@smtp.kernel.org>

On Mon, Jul 06, 2026 at 08:05:33PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Leftover function declarations for `kvm_enable_efer_bits()` and `kvm_disable_efer_bits()` in `arch/x86/kvm/msrs.h` after their definitions were removed.
> --
> 
> commit eef68f2b444ee82f826a87d9dc12393124877c19
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: x86: Move supported EFER bits to kvm_caps
> 
> This commit moves the supported EFER bits into kvm_caps.supported_efer_bits 
> to allow them to be recomputed during vendor initialization. It also removes 
> the kvm_enable_efer_bits() and kvm_disable_efer_bits() helpers in favor of 
> open-coding the updates directly to kvm_caps.
> 
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index 10669c5418da3..66fa7140d65d9 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
> [ ... ]
> > @@ -650,18 +647,6 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  	return 0;
> >  }
> >  
> > -void kvm_enable_efer_bits(u64 mask)
> > -{
> > -	efer_supported_bits |= mask;
> > -}
> > -EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
> > -
> > -void kvm_disable_efer_bits(u64 mask)
> > -{
> > -	efer_supported_bits &= ~mask;
> > -}
> > -EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
> > -
> 
> [Severity: Low]
> This isn't a bug, but did this commit leave dangling function declarations for
> kvm_enable_efer_bits() and kvm_disable_efer_bits() in arch/x86/kvm/msrs.h?
> 
> It appears the prototypes were not removed from the header file when these
> implementations were deleted here.

Yeah, this needs to be folded in:

diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 89f10447cdddf..4cb9ca8bff979 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -58,8 +58,6 @@ int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 int kvm_get_reg_list(struct kvm_vcpu *vcpu,
                     struct kvm_reg_list __user *user_list);

-void kvm_enable_efer_bits(u64);
-void kvm_disable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
