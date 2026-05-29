Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344642188B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087320; cv=none; b=Qeqk5SOgjhVX1uWpyVZkbXqsvd8D/+WwjDp+9HGfw6eztHxGmd9B4q4+PZUCFpQnGFLGaZbT2VIVifQDGL4KrAQKWUiKE4rlSPVWS9HN2dJ8NUuOFFjsngzb/eFVYjdPJnelFQGpODFURnUR2EyxIYbKCgzttOhuRC+jiwv3KHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087320; c=relaxed/simple;
	bh=xVlGx7BnI4wMU/2Q6xG3jF0JlbSupkhhC8wNthWGtNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdiNf94L+2eZ3f/V1MPWpwQcQ7hHa9m7ZpIEd/oIUPLgPlPlsbgBv8U+cI6e1J8uB9a9Z+AgwCayJqrZ8s2+4y2/Vv1W5zhqPY1y9HtKUxmrFIDxCN0T1AZ8Vj1BOlGKDhI5TWsGy87qjiKWbVjNT6T7XU0gl0DdRNzxu7C0Rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxSvWXkd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxSvWXkd"
Message-ID: <709d9ca6-59bb-4f82-b48a-0aa67a4d6ba2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mN1kaQhx15pvliWs0iho9JsWSVFb7ezXOOYPm7dDvCs=;
	b=gxSvWXkdmFx5M85phRk/GPwI+8chDSsq+n57rADdsc1rwascRrSf8S3czlALuQImAQ8t7v
	rkzAaCOQGgFSdl9pOnQsehE+crgbRd7UGxXM7eS4qMkkzOemAZLymmJ8+VlpcpqXfgz1qm
	MBtiCEqG3IqjXfLBkVGoQHdCciUGkn0=
Date: Fri, 29 May 2026 13:41:53 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] KVM: SEV: Do not allow SEV-SNP VMs from intra-host
 migration
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
 <20260528235151.9E59E1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260528235151.9E59E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/28/26 4:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete protection against SEV-SNP VM state duplication in `sev_vm_copy_enc_context_from`.
> --
>
> commit 6c07753da8cad5a8ac0223da06cf2b84411e6fbf
> Author: Atish Patra <atishp@meta.com>
>
>      KVM: SEV: Do not allow SEV-SNP VMs from intra-host migration
>      
>      The intra-host migration feature is not fully implemented for SEV-SNP
>      VMs which require additional SNP-specific state such as guest_req_mutex,
>      guest_req_buf, and guest_resp_buf to be transferred or initialized on
>      the destination.
>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index c2126b3c30724..aff6a0cf5bfe8 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>>   		return ret;
>>   
>>   	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
>> -	    sev_guest(kvm) || !sev_guest(source_kvm)) {
>> +	    sev_guest(kvm) || !sev_guest(source_kvm) ||
>> +	    sev_snp_guest(source_kvm)) {
> [Severity: High]
> This isn't a bug introduced by this patch, but does
> sev_vm_copy_enc_context_from() also need a similar check to block SEV-SNP
> VMs from VM mirroring?
>
> If userspace creates a mirror of an SNP VM, sev_vm_copy_enc_context_from()
> copies its encryption context but fails to copy vmsa_features:
>
> arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
>      ...
>      mirror_sev->enc_context_owner = source_kvm;
>      mirror_sev->active = true;
>      mirror_sev->asid = source_sev->asid;
>      mirror_sev->fd = source_sev->fd;
>      mirror_sev->es_active = source_sev->es_active;
>      mirror_sev->need_init = false;
>      mirror_sev->handle = source_sev->handle;
>      ...
> }
>
> Because the mirror's vmsa_features is zero, KVM treats the mirror VM as a
> standard SEV-ES VM (since ____sev_snp_guest() will evaluate to false).
>
> When vCPUs are created for the mirror VM, KVM allocates standard SEV-ES
> VMSAs and fails to perform SNP-specific initialization, such as registering
> the VMSA pages in the RMP via SEV_CMD_SNP_LAUNCH_UPDATE.
>
> When KVM executes VMRUN for the mirror VM's vCPU, the hardware evaluates an
> ASID bound to SNP execution using an invalid, non-RMP-registered VMSA page.
> Will this trigger an RMP #NPF (Nested Page Fault) on the host hypervisor,
> leading to an unhandled hypervisor crash and denial of service?

Nice catch! I don't think it will lead to hypervisor crash though. As 
per my understanding, the fault on VMSA
page would be sent to user space and just a VM instance will crash which 
is not that critical.

Having said that, we should close the gap for such mistakes from VMM 
side though by rejecting mirroring
of sev-snp VMs. I will add a patch and update the migration kselftest as 
well for sanity checking.

>>   		ret = -EINVAL;
>>   		goto out_unlock;
>>   	}
