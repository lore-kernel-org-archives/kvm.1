Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86183F4128
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368477; cv=none; b=OFrb/UD7jvSk3Fx/AXqC2lxBq2rfCu84EkRlHeksWl0fLMdFLkRRWe8Um9EjNI4HT0Ef7EUFYaBxZWYLMbXbN1ku9Ez/scjp+0PdrE+W8eGR+VH45OqOcpwt7MfSk2W1SKdj7Z2A6Xf0KN/bXZbHfCwf7PDXbEXhGVEOxkWQUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368477; c=relaxed/simple;
	bh=1tgdclz6bcycNffPV/Sn02o8+H8osMcdLadmFT5Vkbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHyJP5gzLnvNES9FbNMm0fTyZPDhzewT2od+ZR9QVVoILDuSsGsCHnpXQiuuK9Cc4HF041/2RDA8usqI0sRVwNvx0LAzdNL3Pa4v1F8F7orDjGBpQlu7MvLfKKm/lDv/aYOEh041Mby0WAhMniybg1f2B2HM8D6iie+hhN+Bytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyFGhB3D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyFGhB3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785368474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+QLMKQBArtLJwp6Y4RfMEvpJ8KBe62T/BcLE1sf3YRs=;
	b=SyFGhB3Dgw3dmbp7oRspt0j+nAuTW/4VMu4Y16wX+SE3v6jvEW4rhRUVfiAhHZ+B/P/xDK
	cV6BE4uqnnhwDn6sjoqpgMNDa94OGvO9nVkKTOLmh6gj8SASUYbLpE82RZXIY6MQ0g5zxn
	D0C891GT3E8ch8j1jauzwPeWoqbbg0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-fin9x3EoPt2wkob_jMUXXQ-1; Wed,
 29 Jul 2026 19:41:13 -0400
X-MC-Unique: fin9x3EoPt2wkob_jMUXXQ-1
X-Mimecast-MFC-AGG-ID: fin9x3EoPt2wkob_jMUXXQ_1785368472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B012019560AA;
	Wed, 29 Jul 2026 23:41:11 +0000 (UTC)
Received: from [10.44.48.33] (unknown [10.44.48.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1AF6300019F;
	Wed, 29 Jul 2026 23:41:07 +0000 (UTC)
Message-ID: <bb63796e-37ad-4c88-a4cb-198bd6da65e3@redhat.com>
Date: Thu, 30 Jul 2026 01:41:04 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Yosry Ahmed <yosry@kernel.org>, Tycho Andersen <tycho@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
 Sean Christopherson <seanjc@google.com>,
 Alexander Lougovski <alougovs@redhat.com>
References: <20260723094419.630204-1-pbonzini@redhat.com>
 <ameuTMWJUZfleIbk@tycho.pizza>
 <CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/27/26 21:58, Yosry Ahmed wrote:
> On Mon, Jul 27, 2026 at 12:23 PM Tycho Andersen <tycho@kernel.org> wrote:
>>
>> Hi all,
>>
>> On Thu, Jul 23, 2026 at 11:44:19AM +0200, Paolo Bonzini wrote:
>>> As to the workload, Alexander threw more or less everything at the same
>>> time at the VM:
>>>
>>> - a full Windows Defender scan every 30 minutes
>>>
>>> - a disk I/O job
>>>
>>> - a loop doing repeated mmap of system files (mostly to hope that
>>>    it triggers some consistency check in the Windows memory manager)
>>>
>>> - SQL Express 2022 + StressDB (1.6M rows), with the host doing queries
>>>    (75% write/25% read) via sqlcmd
>>
>> Can you share the code for the mmap + disk io + DB content generator?
>>
>> We're looking at this and would like to reproduce.
> 
> Not sure if this is relevant, but I see that hyperv_tlb_flush is flaky
> with npt=0 on Turin at the tip of kvm-x86/next (commit 567329869b9c7).

Same on Milan, but ept=0 works.

> It's not likely because the problem fixed by this patch happens
> specifically with npt=1 and not npt=0 AFAICT, but it is a weird
> coincidence :)

And also because this patch uses, in the end, the same flush mechanism 
that npt=0 and ept=0 already use.  So that bug is probably in npt=0.

That said, I'll do a quick experiment of running hyperv_tlb_flush in a 
loop with this patch.

Paolo

> Maybe something is wrong in the Hyper-V code that manifests
> differently with npt=0/1?

