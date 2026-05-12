Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2B3C09F0
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620236; cv=none; b=MdmpUf+/bvT79pwRXQGM2pXkQY69N7t+N1axf2zNTpfeb9zYZodF1jsSg5ao4zDJGiEQ+9FD54bW7gWti/aK4JlBWpmApch74L2YOmKME58n+dhxOjqPA8hWXETWssWY8Ki2OHCmxBOle69lHUTJBPSOObQxjoiHo2DnvO4WRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620236; c=relaxed/simple;
	bh=uBHMCskfBSaYnyaqioWhzZvzpVDQIOeEvV9K2NZ5eoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loM5/poz/rRg+YGRKaVxrr/pVYhweNXMK8YYMX4BNKcQLKC8xH62SaDla6BA206bqpMC+jYMZ7uPhqTa8iNcc23fIp5bfxcwe53iJqZBuWomnQVpqylo4WVQBlM91/pm26m8GM//wlxBQBimGD/wFEEVyk57Q+p/tSYak+jgrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx9V9F+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx9V9F+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U3+iT7cntS6UopIIR+ZaGFcviAq70fCD9O0+QvEgzZQ=;
	b=Jx9V9F+uUb+p1nIxRk/ugNFVFOl28QxIPe3bNGgukFtTUbajgglVDOYLosKIZDhvQhzn9o
	kFm5fs7PAr31034igCFLsIe7KU8Qvbkb8LlmsVOF51WtnHfLG6oj40pYzg1TCjQGkhuFyE
	stwbe3JNTATsei1rvubrfMuVvw32+Yg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-FrgLGK-CMVSXh1sRy7yfWA-1; Tue,
 12 May 2026 17:10:32 -0400
X-MC-Unique: FrgLGK-CMVSXh1sRy7yfWA-1
X-Mimecast-MFC-AGG-ID: FrgLGK-CMVSXh1sRy7yfWA_1778620230
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27FA318002CB;
	Tue, 12 May 2026 21:10:30 +0000 (UTC)
Received: from [10.44.48.5] (unknown [10.44.48.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 816A719560A7;
	Tue, 12 May 2026 21:10:23 +0000 (UTC)
Message-ID: <9b76002a-dbd4-4f8f-8279-96ea0ff3966a@redhat.com>
Date: Tue, 12 May 2026 23:10:20 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 5/7/26 13:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
> trap, but on SVM it was not always intercepted. Unconditionally
> intercept ICEBP on SVM to match VMX behaviour and ensure correct
> event delivery semantics.
> 
> Add two selftests exercising ICEBP:
> 
>   - int1_ept_test: verifies that ICEBP works correctly when the
>     exception stack page is not present (EPT/NPT fault during #DB
>     delivery). The IST stack is evicted via MADV_DONTNEED before
>     executing INT1.
> 
>   - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
>     task gate, exercising the legacy task-switch path for #DB.
> 
> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
> of after it. With the fix, both tests pass on both platforms.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/svm/svm.c                        |  21 ++
>   tools/testing/selftests/kvm/Makefile.kvm      |   2 +
>   .../testing/selftests/kvm/x86/int1_ept_test.c | 116 +++++++
>   .../selftests/kvm/x86/int1_task_gate_test.c   | 298 ++++++++++++++++++

y u no like kvm-unit-tests?  For the task gate test it's much simpler, 
as all the infrastructure for 32-bit IDT and GDT is already there, and 
there is no real KVM corner case being tested.

See 
https://lore.kernel.org/r/20260512210847.3039048-1-pbonzini@redhat.com/ 
for a conversion, which is about 1/6th of the size of int1_task_gate_test.c.

Paolo


