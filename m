Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21692E0B5C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437367; cv=none; b=imX6AQQI3SYmkVqhqj8rndMDbG3ucSi/Hw4jUhQO1aKxoKMVLGSBMmZZmfEH9PLop+IlKQDbyYPIzppVBEr6jJAT2wHy25IzPQZTMJS4yBJFI/vF3jJhJPhGHMvZvcBQc7uhmOfHqtiklfJiGsAKpRVtYyFpuADkHV+FETo3PBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437367; c=relaxed/simple;
	bh=AE9qpM7nYQbqHZLW8lJrUPKuoZQ14UINWbY79FTZpDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3aAuK0JIu6UueZKI1h3vU6Ah5pJ1Yvn8faVWFAk2ZibV7CQSlyyM4mcI2FTYOmopdlBzb3+q4h+KjaLid7D8pd23T4WQQUmTiEBWySUMe/yEUQRdy3ca+3IP2jQhESTA6MIl7N0VfoogsQxqGDgxCbKfclk1lj/yYquXccJkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kbywP3C9; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kbywP3C9"
Message-ID: <33dccdf4-45f7-40b5-a0cf-3f99b26d46f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780437362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMLhbJ4HXNg/dZXFD4JTH5x+MlzfsBAaNNL9l5upBNc=;
	b=kbywP3C9EdS8FSB1w/ZrbwmmCr+Y5TMCGgaUX8cylueS8ubpQE6xN5au/xNZrSftPG/Ygq
	Uo+ZOOUYF91u2+2BYXxHvtRLm/c6Q1vNi7r932YPBy+sG9q0RV2+707m1VXG4zA5Sr4xDX
	Xx9lOP9nEuvdVEYuqYNNZ/uO0+7bS28=
Date: Tue, 2 Jun 2026 14:55:49 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
To: sashiko-reviews@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
References: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
 <20260601231728.C67C51F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260601231728.C67C51F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/1/26 4:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing `kvm->arch.vm_type` validation in `sev_vm_copy_enc_context_from` allows creating structurally inconsistent mirror VMs.
> - [High] Missing `vmsa_features` copy in `sev_vm_copy_enc_context_from` breaks SEV-ES mirror VMs that use features like `DEBUG_SWAP`.
> - [High] Concurrent list modification of `owner_sev_info->mirror_vms` without holding the owner VM's lock during mirror VM migration.
> --
>
> commit 5adb8a893221b0569310f07fd9fc7abca8088651
> Author: Atish Patra <atishp@meta.com>
>
> KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
>
> This commit rejects SNP source VMs in migration/mirroring until proper SNP
> state transfer is implemented.
>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
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
> This is a pre-existing issue, but I noticed a potential locking race when
> an existing mirror VM is migrated via sev_vm_move_enc_context_from().
>
> Locks are only acquired for the source mirror (source_kvm) and destination
> VM (kvm):
>
> arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
>      ...
>      ret = sev_lock_two_vms(kvm, source_kvm);
>      if (ret)
>          return ret;
>      ...
> }
>
> Later, in sev_migrate_from(), it updates its owner's list of mirrors:
>
> arch/x86/kvm/svm/sev.c:sev_migrate_from() {
>      ...
>      if (is_mirroring_enc_context(dst_kvm)) {
>          struct kvm_sev_info *owner_sev_info =
>              to_kvm_sev_info(dst->enc_context_owner);
>
>          list_del(&src->mirror_entry);
>          list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
>      }
>      ...
> }
>
> Since the required lock for enc_context_owner is omitted entirely, could
> this concurrently modify the owner_sev_info->mirror_vms linked list if
> userspace creates a new mirror via sev_vm_copy_enc_context_from(), which
> locks the owner VM? Would this result in kernel list corruption?

It looks possible for SEV VMs looking at the code but I don't the know 
code path
or the mirroring/migration use case well enough to judge how likely this 
scenario
in real world.

>>   		ret = -EINVAL;
>>   		goto out_unlock;
>>   	}
>> @@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>>   	 * created after SEV/SEV-ES initialization, e.g. to init intercepts.
>>   	 */
>>   	if (sev_guest(kvm) || !sev_guest(source_kvm) ||
>> +	    sev_snp_guest(source_kvm) ||
>>   	    is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {
> [Severity: High]
> This isn't a bug introduced by this patch, but this block seems to be
> missing the kvm->arch.vm_type != source_kvm->arch.vm_type check that
> exists in sev_vm_move_enc_context_from().
>
> Does this omission allow creating structurally inconsistent mirror VMs?
> Userspace could potentially create a destination VM as KVM_X86_SNP_VM and
> mirror a source VM of type KVM_X86_SEV_VM into it. Since KVM's core MMU
> would treat the new VM as an SNP VM (due to arch.vm_type), but the SEV
> code treats it as a legacy SEV VM (because ____sev_snp_guest evaluates
> to false), could this produce an inconsistent internal state and allow
> attaching guest_memfd to standard SEV VMs?
NA. They don't have to be same vm type as per my understanding from the 
selftest code.
>>   		ret = -EINVAL;
>>   		goto e_unlock;
> [Severity: High]
> This is a pre-existing issue, but I noticed another detail in
> sev_vm_copy_enc_context_from() just below this diff.
>
> The initialization block for the mirror VM omits copying vmsa_features:
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
> This omits mirror_sev->vmsa_features = source_sev->vmsa_features.
>
> Since SEV-ES VMs use vmsa_features to track capabilities like
> SVM_SEV_FEAT_DEBUG_SWAP, would a mirrored SEV-ES VM incorrectly
> initialize its vmsa_features to 0? When vCPUs are instantiated,
> sev_es_init_vmcb() checks sev_vcpu_has_debug_swap(), which would evaluate
> to false, resulting in misconfigured VMCB intercepts. Could this silently
> drop important execution features for SEV-ES mirrors?

As per my understanding, that is intentional as well.
Is it common to mirror SEV VMs with SVM_SEV_FEAT_DEBUG_SWAP enabled ?

@tom: Please let me know if any of the above statements are not true.


