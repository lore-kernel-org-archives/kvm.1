Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50C3B6C04
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421167; cv=none; b=ndb2e1msZ46vD648L3/myqjlkyX2zcAwNLJhvw0yZTmoz/KHVfT4rMV/j5W5DkSU8vZOVcVUSsHp9UMd2vCu2cBedQfs6DRSpMDJAvN0VKM+zVNFaDYBSFqWd1gcj4zPpL09Ko/ILYS+C9YDVZLsTtsK4kD6X46Sq/tvIOJ4qgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421167; c=relaxed/simple;
	bh=fiUZB+Ou8e6nBsF9fzhqI4bviSX3RS6iTpaZBHmnZJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PGia4fH1SPqjjZQhLrdt7hAiyPdfDEEDwnXi+3w796GaQQuCNyYEGYNrbOJJAcwIDCSGjIwRhnKxLgbVJdaV/uOs7gLb+5uZcbmQgQ4lNKZxDNr4KAKbbeiETZsHE52nnpf/gumi4jlcJ7sNLXTM0QqZIOCqX4E8uDU62/2vzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvSVDB9Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvSVDB9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776421161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TONrQ/UPSHoDAhfWuP7z10X3bEwmONeS89oo9eVT33U=;
	b=CvSVDB9YiDITA/znAwwrtq2DOwK4RJJsbBd3G+oCJw7Rr/8V3d5qiPERSBoHB5nmkUlJk1
	EJ2gN6hjWG8hADy/aO7XGhVY0NmaZzDYtYNNxm5e6S2Okw9/Hu5UXaOG1pfPDxWQVxmebV
	zX15eU6eMmaksmeI2nVcVZZb43gM/ns=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-CdCah3z7P5COJ8RlxWdsRQ-1; Fri,
 17 Apr 2026 06:19:17 -0400
X-MC-Unique: CdCah3z7P5COJ8RlxWdsRQ-1
X-Mimecast-MFC-AGG-ID: CdCah3z7P5COJ8RlxWdsRQ_1776421155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F01C719560B1;
	Fri, 17 Apr 2026 10:19:13 +0000 (UTC)
Received: from [10.44.32.154] (unknown [10.44.32.154])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6899300022B;
	Fri, 17 Apr 2026 10:19:07 +0000 (UTC)
Message-ID: <57d1130f-0375-4934-9820-2edbc3860ee1@redhat.com>
Date: Fri, 17 Apr 2026 12:19:05 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/3] KVM: setup empty irq routing when create vm
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Yi Wang <up2wing@gmail.com>, seanjc@google.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 wanpengli@tencent.com, foxywang@tencent.com, oliver.upton@linux.dev,
 maz@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com
References: <20240506101751.3145407-1-foxywang@tencent.com>
 <20240506101751.3145407-2-foxywang@tencent.com>
 <7e958b82-4eb1-4d61-b301-dde6a19312ba@linux.ibm.com>
 <280451fd-63e9-44b0-9f56-d39dd01861b9@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <280451fd-63e9-44b0-9f56-d39dd01861b9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 4/17/26 11:36, Christian Borntraeger wrote:
>>
>>
>>          irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm- 
>> >irq_srcu,
>>                                          lockdep_is_held(&kvm- 
>> >irq_lock));
>>          if (irq_rt && gsi < irq_rt->nr_rt_entries) {  <---------
>>
> Hmm, I guess I misread the code and the problem is likely not this.
> Let me have another look.

It makes sense anyway, together with a similar extra element in
kvm_set_irq_routing():

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 462c70621247..c3e4fbbfed94 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -178,11 +178,9 @@ int kvm_set_irq_routing(struct kvm *kvm,
  	for (i = 0; i < nr; ++i) {
  		if (ue[i].gsi >= KVM_MAX_IRQ_ROUTES)
  			return -EINVAL;
-		nr_rt_entries = max(nr_rt_entries, ue[i].gsi);
+		nr_rt_entries = max(nr_rt_entries + 1, ue[i].gsi);
  	}
  
-	nr_rt_entries += 1;
-
  	new = kzalloc_flex(*new, map, nr_rt_entries, GFP_KERNEL_ACCOUNT);
  	if (!new)
  		return -ENOMEM;
@@ -246,11 +244,11 @@ int kvm_init_irq_routing(struct kvm *kvm)
  	struct kvm_irq_routing_table *new;
  	int chip_size;
  
-	new = kzalloc_flex(*new, map, 1, GFP_KERNEL_ACCOUNT);
+	new = kzalloc_flex(*new, map, 0, GFP_KERNEL_ACCOUNT);
  	if (!new)
  		return -ENOMEM;
  
-	new->nr_rt_entries = 1;
+	new->nr_rt_entries = 0;
  
  	chip_size = sizeof(int) * KVM_NR_IRQCHIPS * KVM_IRQCHIP_NUM_PINS;
  	memset(new->chip, -1, chip_size);

Paolo

