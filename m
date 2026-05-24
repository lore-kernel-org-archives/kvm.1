Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992363B9
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779608471; cv=none; b=fXT/EJGki6s6GMvkTipK87iHmYwa0S14GGCSQ8svIIyzZFVi0GlR/5Mq3sC+iWlC21i/kue9rUfsgRJ+QCdg0GGzM8OZpkanSE1sCQ6iB+HSjgykxbakvFV6Byz9C8PiIHNY2vN3ET4QvlTPRa7nEt1I0uubYFz9OtVtytL6u8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779608471; c=relaxed/simple;
	bh=nOp8jjGq5V9hBzjdsY3KMGVxlmO39EiHtBRWB9fGPyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss8bY5lzff6Lm8BULrB20OBxm3zmAt9bJd5Q/Y9YWp7LmkxSsMxMWwpu/6T8UpCo5peV5YXDSUatiOktLlXo4wzYxF3XbmWJVFvvtbq3tOqxzRIjNlkh/lI+3rviSdm/9sRWTNE+qMrLQCumCFS5LNkG2XLybTh4g/ykiDr1QQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhiqQZSu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhiqQZSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779608468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A3rd1sVuTBw0rT3pQVGAGUb98jc4+qx51P3i9XL3UT0=;
	b=bhiqQZSuuIOcRcYzjjCl3q4z20M0n0BF85n6QNU3Fjjj6Us5a1ZIqwDmghyLo20SMgLF3C
	C80bnQQfzm3Vzc/EKO3kb4it+/pv2nXs0DdZaXbenBkDmUILeLAJbCXO2SnvNAbDDYm+FU
	MMGM/D6QKWgKARNj759Q316Gts8RczU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-B2g9SXkiMbGsLoiZ0LARhw-1; Sun,
 24 May 2026 03:41:06 -0400
X-MC-Unique: B2g9SXkiMbGsLoiZ0LARhw-1
X-Mimecast-MFC-AGG-ID: B2g9SXkiMbGsLoiZ0LARhw_1779608465
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C91D619560B7;
	Sun, 24 May 2026 07:41:05 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BC5B300019F;
	Sun, 24 May 2026 07:41:04 +0000 (UTC)
Message-ID: <96d1ed59-6a8e-4b8f-bbfb-0214b2f438a3@redhat.com>
Date: Sun, 24 May 2026 09:40:58 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Email reviews from Sashiko enabled for kvm@
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <ahCGijy722ITkND3@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ahCGijy722ITkND3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/22/26 18:38, Sean Christopherson wrote:
> FYI, we've opted-in kvm@vger.kernel.org for email reviews from Sashiko[*], so
> don't be surprised if/when you start getting review feedback.  Given the broad
> usage of kvm@, Sashiko is configured to email the patch author and Cc kvm@,
> e.g. won't blast an email to the entire Cc of the original patch.
> 
> If Sashiko points out a real flaw, you'll likely get asked to address the issue,
> but unless the maintainer(s) for a (sub)subsystem say otherwise, there are no
> expectations that you respond to sashiko-bot (though it's totally fine and even
> encouraged to do so).  In short, treat Sashiko like any other bot.
> 
> The signal:noise ratio for Sashiko has gotten pretty solid, so we don't expect
> an onslaught of slop, but if there are problems with the volume and/or quality
> of feedback, we'll adjust and tweak as needed (again, as we do for any other bot).

A couple more things that are specific to KVM generic and x86 patches 
(though, generally speaking, none of this is a bad idea):

* if you see a false positive, consider that a human might be confused 
in the same way: adding a comment about something being preexisting or 
not expected to happen will often be enough to silence Sashiko and might 
help people reading the code months or years down the line.

* while you are not expected to respond to the bot, it can be convenient 
to do at least one quick reply somewhere in the thread noting that 
you've read it and whether you are waiting a few days for human reviews 
before sending v(N+1).  This is not mandatory either, it's just kindness 
to the reviewers.

* the only thing you *are* expected to do is to point out, as you would 
for human input, any changes from the previous posting that were 
suggested or done in response to Sashiko reviews.  This is nothing new, 
as it is standard practice to point out all changes, but please do 
mention the source of the suggestion.

Also, right now Sashiko assumes that all patches are based on 
kvm/master, which can result in failure to apply them.  This should be 
fixed soon on either our or their side.

Thanks,

Paolo

