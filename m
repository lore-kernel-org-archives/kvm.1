Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193542;
	b=ehFVxPWI5csEWbQOevLLS5I40rXAIo7hOh0Krlz5C7Y+F2Ez/8YuuJmFlKSi6H7mQM7y
	 qZltA+AUmzgf1rfWMga0yCOfWcoJT/+PIydNI5oCJhEWLFsTnfvobfYHi7KzPanWYzDkQ
	 k4pfJVGLwqsiYVI2kihlOWMGgmQo9Kg/kkGtCeIPru1x+TEsOhb/JVlsXd1c5Zo9QhMs+
	 XkQ3Ozeob4vZjW9FZIyBf1ZsU1MOI8HrHcVvgBzXIskI6cf4m/mg/rbykRCr+jFJR1/WK
	 1+q5GHmK2BB8LEgIjRvqVwZX6DDRiyVY6pCd1KG4b7dNX+Jw73EA+Aepo3SeqDEcbug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193542;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=jsvgDpLwGXHaRHsHZCENvIqUnp+iMj9ognXUIXq3TW8=;
	b=VRXb0eSeIT/2+HPZ/reRVcRz7S53O7NFCkt93OVthRlVYmAcVHbNiBk3fgZn4hTo/vKV
	 qJzNhqpqc5kAKwI0JcyM9xLn3LOTRatGhlPUQ6/pmFFGDPODMF28Wsz85mEIuVTYFGhq7
	 clk4dtYkXntjrhYSP0dhCA5gWVtpGzV8qhjgLVTx5X48VKEdRm0FUENgqVahs3zQpvwGf
	 jVRoxW6ojrMrX+aI1cp6thxm5pc7D8o9MqpXjLq4OG7SPhG1e3Vz2wcvwZsGgvDJ80Zfy
	 yZoutrROK4R95TVXAH0Z3es1NRg61EK37KYM/Q6LWnA5SlzY0s4pDAduaiSuvS1YbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="c/MQYAR+";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB760A260F
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 16:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AB760A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/MQYAR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795193540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jsvgDpLwGXHaRHsHZCENvIqUnp+iMj9ognXUIXq3TW8=;
	b=c/MQYAR+ySlkc1SY9dqTB3ddG7ZfhAFCCsknf5KMXIQJgSZjHLIPZuEk7UH/93Hg6Z9Mki
	NZyciC//y2bi03daXbnQ66gMYdSpALxQW2vucTiUZiijfKP8mTGUuJFNWrMk6z1MMgOL9G
	lfveSLxRA8rQa+n4bKSS6SDJnEKb0H8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-Amo5EfSZPBevOteng_USZA-1; Fri,
 20 Nov 2026 16:52:17 +0000
X-MC-Unique: Amo5EfSZPBevOteng_USZA-1
X-Mimecast-MFC-AGG-ID: Amo5EfSZPBevOteng_USZA_1795193534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F4FD19540C5;
	Fri, 20 Nov 2026 16:52:14 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C76F1956049;
	Fri, 20 Nov 2026 16:52:11 +0000 (UTC)
Message-ID: <1075a283-b745-418b-b49a-2dfd41faba3b@redhat.com>
Date: Fri, 20 Nov 2026 17:52:09 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] vfio: fix KVM reference leak on QEMU CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, alex@shazbot.org,
 den@openvz.org, khorenko@virtuozzo.com
References: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/20/26 16:47, Andrey Drobyshev wrote:
> When a VM has a VFIO device and QEMU does a CPR (CheckPoint and Restart)
> live update, QEMU creates a new VM and keeps the device open.  The
> device holds a reference to the VM it was opened with, so the old VM is
> not destroyed.  It stays until the device is closed, which usually means
> for as long as the guest runs.
> 
> It is one stale VM, not one per update.  It is also visible: after
> cpr-exec the kernel logs "kvm: debugfs: duplicate directory <pid>-<fd>",
> and the new VM gets no debugfs directory.
> 
> This patch makes the device take that reference only if its driver uses
> it.

There are two problems with this patch:

1) It sweeps the bug under the carpet and only solves the case that 
*you* care about.  If the device keeps a reference to the VM it was 
first bound to, the problem is that there's no handoff from the old file 
descriptor to the new one.

2) Even worse, the above text is 101% copied from Claude.

Please come back once you have a patch that works for everyone and 
anyway only after having read Documentation/process/generated-content.rst:

"You are expected to understand and to be able to defend
everything you submit. If you are unable to do so, then do not submit
the resulting changes. If you do so anyway, maintainers are entitled to 
reject your series without detailed review."

Paolo

