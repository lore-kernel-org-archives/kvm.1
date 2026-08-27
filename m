Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82A36E466
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866935; cv=none; b=O3BMC+h8iYf1uK6XLe/M4jaWCr7Qr2YO1zy+JR74TPKPv6g/UNPNQbJeH0hVDqMrxG1gC0E8CLbucji6v+yLwS6JXVvG0Ti5TqUKCrcF5tBebCFVi06opr3N1o9En8DYvcZn78KPzAX8W2jujuXJ4mWqG9KgNP2WJkXqPf86IbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866935; c=relaxed/simple;
	bh=9tHK6tvUsgxuqmiU95IJiGTH3iXvv2ChShXtSHUzgrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ensIDP7mrC5oLzc7bD6Dx/5+duO/k9/MTrNgQaweVXou7mqurFpJEVztOTCv9Sqdksax8cfO27aJfErYlJQ2DIix1XqjMEJbpuUCaO/HpymwhKPfc3DP1bRW0fffagoEPkySzad0OOU8qwaHzc/1LzR0mq2R1j8elaBznX6c3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfWSWZR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfWSWZR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787866929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RCPK14Ec0AqueyxbiRrbVKvWDjNgHHCpXefmqR1aOKA=;
	b=NfWSWZR4asWlMrhJbNgRrhU8iUkb5TqwFYkQfxmHzBIVD1V/w8gsqDzxl8xk7txIc7SAow
	ZVry+JXnBDx2t0X7CeUaxARvsNeSrWc5tmpc1LI7xcf7OaKQ9RvZjyg//U60NjhprJIWK5
	Qp30JIQ0QoaBIjKlS93le17UU4pgc3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-mmqMtOhQM86VeA_FXXtWdw-1; Thu,
 27 Aug 2026 17:42:06 -0400
X-MC-Unique: mmqMtOhQM86VeA_FXXtWdw-1
X-Mimecast-MFC-AGG-ID: mmqMtOhQM86VeA_FXXtWdw_1787866924
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87A271955DEA;
	Thu, 27 Aug 2026 21:42:04 +0000 (UTC)
Received: from [100.90.56.12] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9F4430002EE;
	Thu, 27 Aug 2026 21:42:01 +0000 (UTC)
Message-ID: <018f411b-9c7e-4baf-9d55-a153eab64dc4@redhat.com>
Date: Thu, 27 Aug 2026 23:41:55 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Teodorescu <fane@google.com>
References: <20260826211844.884951-1-seanjc@google.com>
 <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
 <apA9eLuaMxCLdCmn@google.com>
 <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
 <apB1A5Ln_lGTI4oy@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <apB1A5Ln_lGTI4oy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/27/26 19:33, Sean Christopherson wrote:
>>> If anything is wrong, it's the CR0.PG check.  Presumably that got carried forward
>>> from commit c0725420cfdc ("KVM: SVM: Add helper functions for nested SVM").  I
>>> don't see anything in the APM that requires paging to be enabled, and nothing in
>>> that ancient series points at concrete documentation either.
>>
>> Oh yeah you're right, for some reason I thought it was paging not
>> protected mode. Well then, it seems like
>> nested_svm_check_permissions() is also incorrectly checking paging as
>> well, seems like both checks are incorrect? Also, I don't see anything
>> in the APM about checking RFLAGS.VM before VMRUN.
> 
> Presumably it's covered by the !PROTECTED_MODE clause.
> 
>    IF ((MSR_EFER.SVME == 0) || (!PROTECTED_MODE))  // This instruction can only be executed in protected
>      EXCEPTION [#UD]                               // mode with SVM enabled
> 
> Section "1.3.4 Legacy Modes" describes "Protected Mode" and "Virtual-8086 Mode"
> as separate submodes.  And the tables for most instructions differentiate between
> Real, Virtual 8086, and Protected modes when enumerating exceptions.

Right.

As to CR0.PG it does seem incorrect to check it entirely, however note 
that there is this too (15.25.3 Enabling Nested Paging):

	If VMRUN is executed with hCR0.PG cleared to zero and
	NP_ENABLE set to 1, VMRUN terminates with
	#VMEXIT(VMEXIT_INVALID)

which would have to be checked in nested_vmcb_check_controls().

>> If the goal here is to keep the checks here consistent with
>> nested_svm_check_permissions(), aside from the new EFER check, then
>> maybe we should also check CPL here?
Perhaps, but nested_svm_check_permissions() is not reached with CPL=0 
because the #GP overrides the interception (table 15-7, instruction 
intercepts).  The same should be true about EFLAGS.VM=1.

Paolo

