Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8772E5429
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026020; cv=none; b=qG14mu87oEGRp7jS+tn7uy5oUTF5tjOBXVTkE3f1oQCD+TH7OCJ3+qIhCz7vsyoHvNUHcgFAGKCb6964SOTpsoSI6743m9bnPMYfSXoGnCbQhJpzZe4MPQXZ1Z1ui0iHw690lsvsjGhpkVluacxmZlLCvkEP38b845ikq2LeKdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026020; c=relaxed/simple;
	bh=GWDDEBFK4UV6oh3D2Y6clgByd5Sbu9uOoMyMXpuipgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+kjqqv0r0Kwcax47crfwBY/O23SrziDIQ3ekcQO14KHMZdPhoC/OUjjyd/mofFRscXD5xuRTRaN292WJiiWdOcUvZ+sani4QnHQLEfXGuaQgc5YXtMptiLp26ZDpv5H2U5xl2H4ZzhUhXft4wW/jWq16EsHWDUnI7tYpFedWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmg6m5yB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmg6m5yB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786026018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lqM5DhL7cQc3NtPkwSxrUkxMOKqGJTIctAl0wdWotjI=;
	b=Mmg6m5yBKhi7x81h/G1ad4HvXoq9m6jMq0rQJ7CReoGZ1B/O75cBNqwA7KiuNwUCoS3nPM
	0M9ye+kCEMfKNjosl/EZsKZPJXUOToUzXUi6noZJ11hOJKChPQmJztC38g9yGEGezunfjy
	4BxixOqkC7fKZzFhVirOBvxZunx5yqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-oWz3rM4fMGOVbMi-lDcYew-1; Thu,
 06 Aug 2026 10:20:14 -0400
X-MC-Unique: oWz3rM4fMGOVbMi-lDcYew-1
X-Mimecast-MFC-AGG-ID: oWz3rM4fMGOVbMi-lDcYew_1786026011
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5632180136B;
	Thu,  6 Aug 2026 14:20:11 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED96B1800346;
	Thu,  6 Aug 2026 14:20:09 +0000 (UTC)
Message-ID: <0e9c3989-c7cb-493c-8fa7-4005e1d772f5@redhat.com>
Date: Thu, 6 Aug 2026 16:20:04 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: SVM: Serialize the owner's mirror list in
 sev_migrate_from()
To: Shen Yongchao <grayhat@foxmail.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 8/4/26 16:54, Shen Yongchao wrote:
> In sev_migrate_from(), when the destination KVM is a mirror, the mirror
> entry is moved from the source's list to the owner's mirror_vms list
> without holding the owner's lock.  All other writers of the owner's
> mirror list (KVM_SEV_MIRROR_CREATE, sev_vm_destroy()) serialize on the
> owner's lock, so a concurrent COPY or destroy can race with
> KVM_SEV_MIGRATE_VM and corrupt the list, e.g. leaving a dangling
> mirror_entry that is later dereferenced.
> 
> All kernels with SEV mirroring and intra-host migration support
> (KVM_SEV_MIRROR_CREATE / KVM_SEV_MIGRATE_VM) are affected.

More precisely, KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM and 
KVM_CAP_VM_COPY_ENC_CONTEXT_FROM.

>  The mirror
> list mechanism was introduced by commit b2125513dfc0 ("KVM: SEV: Allow
> SEV intra-host migration of VM with mirrors", v5.18, 2022-02-18);
> upstream mainline is unfixed as of 2026-08-04.  Triggering requires an
> AMD SEV-capable host with CONFIG_KVM_AMD_SEV and a local user able to
> create SEV VMs and mirrors, racing KVM_SEV_MIGRATE_VM against
> KVM_SEV_MIRROR_CREATE or mirror destroy (instruction-level window).
> 
> Take the owner's lock around the list operations.  The lock is taken
> after sev_lock_two_vms() and the migration_in_progress flags prevent
> two migrations from interleaving.  The owner is a third VM whose lock
> is not held: the destination cannot already own an encryption context
> (sev_vm_move_enc_context_from() rejects SEV guests as the destination,
> gating on ->active), and a VM cannot be its own mirror owner.  Hence
> SINGLE_DEPTH_NESTING is sufficient and cannot deadlock.

You need to use "2", because SINGLE_DEPTH_NESTING is already taken by 
sev_lock_two_vms().  I adjusted a bit the comment to include this 
information:

  * Writes to the list of mirrors take the owner's lock.  It is
  * not possible to have a deadlock, because the owner's lock is always
  * taken (e.g. by KVM_CAP_VM_COPY_ENC_CONTEXT_FROM) inside the
  * mirror's.

and applied the patch, thanks.

Paolo

