Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188940B37C
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187234; cv=none; b=kOrwANynXLdxHFiW3tMWyECZ32QGSzj5PnvM6oZIMu4NKwa3KyCPB2CyeVSeQ2TFyhDvbaaVIYJYZ4T1CncRlZlK/gH+C7874GJ2VqxbVHRF05VuHehCNbhIe4EvBndlX9GKMCOjYSs6144JBPEFLvjsoPHj1yHnPaDprk28l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187234; c=relaxed/simple;
	bh=GdL5wAdY4kfuYmHeJumdYg7zkHGthU8TikaocMw13j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKgDaRPztKs8AiFJUHQMH1c9P7GwZjZT4d/RjzDXKEupCSMNsGhRQ1BxDHUj3rfMWcJBAbRAyueFKKhwQs/yy4Dpc62Ju/U4tIDLuUJg444KYPkGtua+uFsyFYoNw4jGNyBbnDldm6z2e4mWkEOYhkwWkaXlYsnsNcSZlElGg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 02D741C0F90;
	Thu, 11 Jun 2026 16:13:52 +0200 (CEST)
Date: Thu, 11 Jun 2026 16:13:50 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
Message-ID: <aiq_X6c5eEiuXIZs@8bytes.org>
References: <20260611123528.572255-2-joro@8bytes.org>
 <20260611125628.C61421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611125628.C61421F00893@smtp.kernel.org>

On Thu, Jun 11, 2026 at 12:56:28PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this sequence trigger an RMP violation? 
>     
> When an SEV-SNP guest provisions an AP and triggers svm_vmgexit_ap_creation(),
> KVM replaces the initial KVM-managed VMSA with the guest-provided one using
> sev_es_set_guest_vmsa(), which eagerly frees the old VMSA via
> sev_es_vcpu_free_vmsa().
> 
> For SNP guests, the old VMSA page is in the VMSA_PRIVATE state and has been
> transitioned to the hardware VMSA state. To transition it back to shared
> memory, AMD architecture requires reclaiming the page via snp_page_reclaim()
> before issuing an RMPUPDATE.

Calling snp_page_reclaim() is only needed when the page is reclaimed before
LAUNCH_FINISH. Once the VM is running, which is is when it issues a
svm_vmgexit_ap_creation() request, then an RMPUPDATE is sufficient.
 
> [Severity: Critical]
> This is a pre-existing issue, but does dropping the page reference here allow
> a malicious guest to crash the host kernel?
> 
> When a guest-provided VMSA is used for an AP, KVM resolves the GPA to a PFN
> and immediately drops its page reference here. The physical address is then
> programmed into the hardware VMCB.
> 
> If a malicious guest issues a Page State Change request to transition this VMSA
> page back to shared memory, host userspace can handle this by calling
> fallocate(PUNCH_HOLE) on the guest_memfd. This would trigger
> sev_gmem_invalidate(), which attempts rmp_make_shared().
> 
> Because the page is still in the VMSA state, rmp_make_shared() would fail.
> sev_gmem_invalidate() only prints a warning and proceeds, freeing the page
> back to the buddy allocator while its RMP entry is still guest-restricted.
> 
> When the host buddy allocator reallocates and accesses this page, would it
> trigger an RMP violation and a host kernel panic?

This is not an issue because the RMPUPDATE will only fail when the VMSA is
currently used by a CPU in guest-mode (== its VCPU is running).

But in the sev_es_vcpu_free_vmsa() path this can not happen because this
function is always called in the context of the affecting VCPUs thread, which
makes sure that the VCPU is not in guest-mode.


-Joerg
