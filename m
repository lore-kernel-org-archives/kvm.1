Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943FA2DCBE3
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188189; cv=none; b=uBVzNfOGyDKnTPm6alQEhV/pSWg+7pezhIlFvZooa/B4NC4Pu82mmZhbm6d9uiGCbJrBi+rocRWq9GDE25M6D3ENXTd5MYf26hqAyRyDQfXD830umI0n+lXf1hT+BUm6x4Dvq1yXSbdp3bBjzjausiF2BhvXGXwVmEwjVU4V1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188189; c=relaxed/simple;
	bh=yZkY1TvvDeOjoeT7w5jFP2vy029EC9BtS3xUAUt1pdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfI/TuxfvaNkbU7fvbWdhvhAuiggND0VajrQnJO0lEYOW54rFCVF4mNFHWtm01U17KeOweBXPKVtHsuCWgliJa8U4jDSc3oQHlZRbS5pnsZXx7Opc0OMNLVg305SSsp46Kt0qUh/gFu0DhWlldOyRHc6f/3s9MusLWrz+DSh0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A25251C1C36;
	Thu, 11 Jun 2026 16:29:46 +0200 (CEST)
Date: Thu, 11 Jun 2026 16:29:45 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] kvm: svm: Defer VMSA allocation to LAUNCH_FINISH
 stage
Message-ID: <airE9DZRDk0jg1sj@8bytes.org>
References: <20260611123528.572255-3-joro@8bytes.org>
 <20260611125813.A9DBD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611125813.A9DBD1F00898@smtp.kernel.org>

On Thu, Jun 11, 2026 at 12:58:13PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does this error path leak the newly allocated VMSA?
> 
> Since sev_es_sync_vmsa() now allocates the VMSA, if
> sev_es_vcpu_vmsa_make_private() fails, the code returns via the "out" label
> without freeing the VMSA or resetting its state.
> 
> If userspace retries the KVM_SEV_SNP_LAUNCH_FINISH ioctl, sev_es_sync_vmsa()
> is called again and will trigger the WARN_ON_ONCE() in
> sev_es_vcpu_alloc_vmsa() because the state is still VMSA_SHARED:
> 
>     if (WARN_ON_ONCE(svm->sev_es.vmsa.vmsa_state != VMSA_NONE))
>         return -EINVAL;
> 
> Can we add a call to sev_es_vcpu_free_vmsa() on this error path?

Yes, this is a user-space triggerable WARN_ON_ONCE. Usually user-space does not
re-issue a LAUNCH_FINISHED command after it failed and doing so is not
supported to lead to anything productive anyway. The right fix is to remove the
WARN_ON_ONCE().

> [Severity: Medium]
> Does removing this allocation lead to KVM's INVALID_PAGE sentinel being passed
> to the PSP firmware?
> 
> If userspace creates a vCPU after the SEV-ES or SEV-SNP launch sequence has
> completed, the new vCPU's VMSA is never allocated.
> 
> When this vCPU is run, sev_es_vmsa_pa() returns KVM's INVALID_PAGE sentinel
> (~0ull), which is loaded into the VMCB, triggering an immediate #VMEXIT
> (SVM_EXIT_ERR).
> 
> If the dump_invalid_vmcb parameter is enabled, KVM handles this by calling
> dump_vmcb(), which then calls sev_decrypt_vmsa(). Since sev_es_vmsa_ref()
> returns NULL for VMSA_NONE, sev_decrypt_vmsa() erroneously assumes the VMSA
> is encrypted and passes the INVALID_PAGE sentinel directly to the PSP
> firmware as the source physical address for SEV_CMD_DBG_DECRYPT:
> 
>     data.src_addr = svm->vmcb->control.vmsa_pa;
>     data.len = PAGE_SIZE;
> 
>     ret = sev_issue_cmd(vcpu->kvm, SEV_CMD_DBG_DECRYPT, &data, &argp_err);
> 
> Could this direct hardware exposure to an invalid page address risk firmware
> hangs or IOMMU faults?

This is not true. The VMSAs are allocated in sev_es_sync_vmsa() for both SEV-ES
and SEV-SNP guests. Both code path also propagate the VMSA into the VMCB before
LAUNCH_FINISH is complete and the VM can be invoked.

-Joerg
