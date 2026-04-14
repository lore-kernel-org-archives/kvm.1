Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5B34750D
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180836; cv=none; b=QepZdfn6W6TsVVW2fxxUJA4PTcQLOki8upLmkZDXkQuAVWQYajtOilGih8ZjKWYbgCFLa89JtIX/A4B9w5LVd68rYzZ6ktyatFYmHRWnv5cOldzoU9eMk5cYlcHhrO49p8Bh3ahPf+V5peLChLsqa68BEqKgDzynMzhnHjcXooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180836; c=relaxed/simple;
	bh=DOoy0X8wjR/g3JwoHLpkK3Ihqf4CtoI67BSblzrOmbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHg/BaVnqARL/FrmAk9xx0DYStlOApvfAKRkHxqF0TWlcO07cgsSHDZ2C7Sisx07Xq1ikPJ7FDDeBPO7ChqjMyCxHBzaKl9g+uZ1KGFh0bkOfuOcrR1ofY/QzwcMXT3il3giqfeAcz1yrrJaerCYee/6W3fQ82O+irUx/jNXnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDOhqkVg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDOhqkVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776180834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mppVVY7Fz8K3II7gMQt+UKRYh47XhSuX59ylxtvybXs=;
	b=IDOhqkVgzRpgQqBBjrLaOMasCAAA8RGOjZn33Hxkqjqmz1HPF5HaqdPS9T9d/rrnANe1f3
	WzKsIzpLMWZPApHKBUSpEcMjVF2eWJQRdGVaxlAtIEZgg/4a/QfRBLmP8SQUaMZ+OwvVl7
	IZm15KQi/GwS8eXbY4uoPFXPDZGXrn8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-SZTTJxikNUS6j-bWqg-S1Q-1; Tue,
 14 Apr 2026 11:33:53 -0400
X-MC-Unique: SZTTJxikNUS6j-bWqg-S1Q-1
X-Mimecast-MFC-AGG-ID: SZTTJxikNUS6j-bWqg-S1Q_1776180832
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0450918011FF;
	Tue, 14 Apr 2026 15:33:52 +0000 (UTC)
Received: from [10.32.181.49] (unknown [10.32.181.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CCAC195608E;
	Tue, 14 Apr 2026 15:33:50 +0000 (UTC)
Message-ID: <ef9790f5-38ff-4cae-92c7-fffe527699b4@redhat.com>
Date: Tue, 14 Apr 2026 17:33:49 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: use inlines instead of macros for is_sev_*guest
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260413170009.380778-1-pbonzini@redhat.com>
 <ad1jFw5IPY78nDDw@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ad1jFw5IPY78nDDw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 4/13/26 23:41, Sean Christopherson wrote:
> On Mon, Apr 13, 2026, Paolo Bonzini wrote:
>> This helps avoiding more embarrassment to this maintainer,
> 
> Not building SEV support before pushing to kvm/queue is certainly a choice :-D

Fortunately, the part where I actually do more than a build smoke test 
and push to kvm/next has some automation... but the bots are too fast 
these days.

> As called out in commit 45d522d3ee9c ("KVM: SVM: Macrofy SEV=n versions of
> sev_xxx_guest()"), use of macros is intentional as gcc-12 at least generates
> suboptimal code if there's a proper function.
> 
> That said, gcc-11 (I don't think I have gcc-12 laying around anywhere) generates
> identical code for all of kvm-amd.ko with and without macros, so maybe whatever I
> saw a transient issue?  I don't have a strong motivation for caring about any
> version of gcc, so I'm a-ok using __always_inline functions.

Yeah, it seems strange for the compiler to have this problem except at -O0.

>   #else
> -static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
> -{
> -       return false;
> -}
> -static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
> -{
> -       return false;
> -}
> -
> -static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
> -{
> -       return false;
> -}
> +#define is_sev_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })
> +#define is_sev_es_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })
> +#define is_sev_snp_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })

BUILD_BUG_ON_INVALID isn't great because it doesn't have type checking.

Paolo

