Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911318CC13
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026650; cv=none; b=ezvaPb+2ZjeiYDpXD07tCC8qIxYk5nEPeSNvVT6kM10IXeEF/zXWPZdDJVVVnF0mUcRoU7fWBs1dbD65L7ngtjgtZt1pVniirvkDbgZRpH2c5RWn1U3xYVhxuN5nj2N1EIp7dcK1+Byx4w63K+iE+p26cd0gGOFZ3EA1QEoRQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026650; c=relaxed/simple;
	bh=JHF2V1eIaSL1WSne1A+nFuXjTyywKpp5dtKutEfWSRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9p8ut90+En7dTugztVjIgH26mFeEO1rwTFvzmgulGHUc+r1SReUHNioIQEOqzT7LP2FuQ0GQU82XLKewz2RFd1XgXHKscv4gYSeu8x6eKxwtE3zEYG4Y3YuAsdroNotB6pqTIgPW2BAFj2/JzCKbkZt/K50n1CT5Z65az+c97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csyaGPKQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csyaGPKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786026648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BZRJJGy3AzjBGmSZrWzib4BdwhxQRH0yxUJr55ajUIc=;
	b=csyaGPKQ8C+sBd38J2UZWb8n8CmEVcyNIZJ7KRODqkRnHgacySp72nKnV0m+vG2fWdC4Vf
	hNlnHogLqpQs/alY+b3139xzmBqv2mevVle59j+lhfLloUhdXhZgVmorM5FrYTi/LuLh2Q
	gejoSPoo+VEhh6z8ZJNbh6TzZAln3Ds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-vTFxZRfGNV6EiIiyWNC28A-1; Thu,
 06 Aug 2026 10:30:35 -0400
X-MC-Unique: vTFxZRfGNV6EiIiyWNC28A-1
X-Mimecast-MFC-AGG-ID: vTFxZRfGNV6EiIiyWNC28A_1786026634
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 125A418007E7;
	Thu,  6 Aug 2026 14:30:34 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C07541956094;
	Thu,  6 Aug 2026 14:30:32 +0000 (UTC)
Message-ID: <e2c6f458-564e-44a4-9fb5-df774cd7ce92@redhat.com>
Date: Thu, 6 Aug 2026 16:30:30 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Re-check enc_context_owner under the
 owner's lock in sev_vm_destroy()
To: Shen Yongchao <grayhat@foxmail.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <tencent_DDC4E4352EC91CAC05A9A8F4E55E8C96730A@qq.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <tencent_DDC4E4352EC91CAC05A9A8F4E55E8C96730A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 8/4/26 17:00, Shen Yongchao wrote:
> sev_vm_destroy() reads the mirror KVM's enc_context_owner without any
> synchronization and then locks the returned KVM.  A concurrent
> KVM_SEV_MIGRATE_VM (sev_migrate_from()) transfers this mirror's
> reference to a new owner under the current owner's lock, so the
> previous owner can be freed between the unlocked read and
> mutex_lock(): the mirror's final reference can be dropped while
> sev_vm_destroy() is about to dereference the owner, dropping the
> owner's reference count below its true value so that kvm_destroy_vm()
> runs while the owner's fd is still open.
> 
> All kernels with SEV mirroring and intra-host migration support
> (KVM_SEV_MIRROR_CREATE / KVM_SEV_MIGRATE_VM) are affected.  The mirror
> list mechanism was introduced by commit b2125513dfc0 ("KVM: SEV: Allow
> SEV intra-host migration of VM with mirrors", v5.18, 2022-02-18);
> upstream mainline is unfixed as of 2026-08-04.  Triggering requires an
> AMD SEV-capable host with CONFIG_KVM_AMD_SEV and a local user able to
> create an SEV VM plus an SEV mirror VM, racing close() of the mirror
> against KVM_SEV_MIGRATE_VM on the owner (function-level window,
> deterministically reachable with a close(fd) primitive).
> 
> Take the owner's lock and re-check enc_context_owner: if it changed,
> the migration already moved the mirror entry and the reference to the
> new owner, so retry with the new owner.  The owner cannot be freed
> while the mirror holds a reference to it, or while a migration that
> takes the reference over holds the owner's file reference.

The problem is that the *old* owner can be freed between READ_ONCE() and 
mutex_lock().

The patch narrows the window, but the cleanest fix for both issues is to 
stop protecting enc_context_owner/mirror_vms with the owner's kvm->lock, 
and use a global lock instead.  This also fixes the other issue, so I'll 
send a patch.

Paolo

