Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EDA42317C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437522; cv=none; b=WNVOU5xRtgiZLaSo13e99f765gxyNSCRiQGnb6Hq/ABKaNLBTtr/EMRLO6M9+ByCuCZo7RLsTLkvzX5xZ0iO2ME7+pQqkYS4zNW9M60p30wjp0HaGAAnSIrwZ6FVQcJXjm0OIboWlsW7PiAwknS7Vstdo50teo6yFzoe9KiErGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437522; c=relaxed/simple;
	bh=GPWUMQCJQZXooUaDPwF4wLNMA9Z68DNNqksDvS8iQAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlhodBOBDhe2j6PhUaVc28Sc/Ofq1xnLi3S2yUjYpmlUguAOzDY9hBzQk67BsSRNI3/xjEa/tG2snfuEkob73nak8d5FCq2GKWNtuVOG2Ud5s9kL/UNA8WKawy0vMNFpvOW0ISmOdlqAdhMe2Cylb4OFcTup7yIwITpgin24Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxVaTw/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxVaTw/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785437519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjwRFNiQrxLxL/d8e/kO0ejkxvNkA/f12If+jYxnBS0=;
	b=GxVaTw/QrjemUnhXVdceWIeY80yLBIHFnS1YvXfXDvxAOOf3ytnpUGe+v7CkSO+ZGYCFSt
	W0jZU5buYDVMtpNeGKbQrAZF6Sh8Dm3KgdtAt20WXMLCtdmBVU5zdPCEOpJudxoMnLEOFE
	NDS+FU+Wvo1iVoenyLPb4jXLhNHmQJ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-b41BkikqPaSIWT5cAfAufg-1; Thu,
 30 Jul 2026 14:51:56 -0400
X-MC-Unique: b41BkikqPaSIWT5cAfAufg-1
X-Mimecast-MFC-AGG-ID: b41BkikqPaSIWT5cAfAufg_1785437515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38052195608A;
	Thu, 30 Jul 2026 18:51:55 +0000 (UTC)
Received: from [10.44.32.70] (unknown [10.44.32.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B779B30002E9;
	Thu, 30 Jul 2026 18:51:53 +0000 (UTC)
Message-ID: <299bddc0-fafc-48b3-a9c6-ec171136a46a@redhat.com>
Date: Thu, 30 Jul 2026 20:51:51 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
To: Sean Christopherson <seanjc@google.com>, Sergio Lopez <slp@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260729072044.25796-1-slp@redhat.com>
 <amuKVfib5kela8AD@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <amuKVfib5kela8AD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/30/26 19:31, Sean Christopherson wrote:
> On Wed, Jul 29, 2026, Sergio Lopez wrote:
>> After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
>> mmap") was merged, a guest write to an unpopulated PTE from a mapping
>> backed by a DRM GEM BO triggers a VM exit with EFAULT, with
>> hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.
>>
>> This happens because that commit implements pfn_mkwrite for
>> drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
>> returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
>> entry to be installed as read-only. This is done on purpose so the
>> fault handler gets notified when the entry is going to be written.
>
> NAK, this doesn't belong in KVM.  Expecting callers of fixup_user_fault() to
> retry a FAULT_FLAG_WRITE fault on *success* is absurd.  Either manually do the
> retry in fixup_user_fault(), or return VM_FAULT_RETRY so that KVM will naturally
> retry.  I assume the latter is the correct approach.
Doing it in fixup_user_fault(), or more precisely in __do_fault(),
seems hard.  The information about the trick (about the presence
of *_mkwrite) is only recorded in vma->vm_page_prot, which is an
opaque pgprot_t.  So it's only follow_pfnmap_start() that knows
how to retrieve it.

In the driver it would be I guess something like:

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..ae913481a42c 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -658,6 +658,10 @@ static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int ord
         if (ret == VM_FAULT_NOPAGE)
                 folio_mark_accessed(folio);

+       /* Force another round to ensure that pfn_mkwrite is called.  */
+       if (!(ret & VM_FAULT_ERROR) && (vmf->flags & FAULT_FLAG_WRITE))
+               ret = VM_FAULT_RETRY;
+
  out:
         dma_resv_unlock(obj->resv);


?  but it seems that the driver is in slightly uncharted waters.
try_insert_pfn() calls vmf_insert_pfn(), which says

/**
  * vmf_insert_pfn - insert single pfn into user vma
  * @vma: user vma to map to
  * @addr: target user address of this page
  * @pfn: source kernel pfn

...

  * vma cannot be a COW mapping.

except this *is* a COW mapping in some sense, or at least it
faults like one.

Paolo

