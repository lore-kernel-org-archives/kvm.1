Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73633F36B
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684908; cv=none; b=NeIljMCBBthlxSwrYZxIpKyGiEpZS2U9HIjUsTGwT0SkLQVqdeEE+4PHYWc0RznZm9SAkHB8GAFVnWxgE+GGgcglAWGd9AWP1/I5DBpB1c3rW2QYQNYxpsdFkyCP/GAdGk35TnFiAPddsrRoi2jOPDgmu84rzcUJMxMmVPyPtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684908; c=relaxed/simple;
	bh=SErTzb81g73jnNYmHwc9NnTONvcW7esTWfGxr2U3eFQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m3ony0VQvISDsW36TIpQGjSObmMdv8RYQD5naQU308GFpQ+9/J6wbkzMlp4UhApJvp/D9MtDP7Ba1r0XtTXyy91Hln5Wx8KbCoRua5TjiNjZSqPKadpbUEV+LXXM9bNGBdILGmgGtnjtxInmPkEcEBWkS4jMz+lfjwdwR7yFPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkGpMuZC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkGpMuZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775684906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqd5OkMxkLO6uVFoPPIdOIS8h9ZCUOE53ly22/dnnmQ=;
	b=YkGpMuZC/y6ur2tTqnbOiyqwDUD3ulM0GOpWcdun4AIkREoMw+YmQPfCPQu+0DV+oECFdP
	ojo2rsV/V7Ui+DhMV7DWX5SzfwMOlW0wF7MY2Un4JSHWSM4ct8c2e2GxUPVHX2G0UDDAcO
	J7ncQnUjDSKHO4AJznTrlxjBL7HOPPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-RdnEFCfSMqCh-lOcYnO1iA-1; Wed,
 08 Apr 2026 17:48:22 -0400
X-MC-Unique: RdnEFCfSMqCh-lOcYnO1iA-1
X-Mimecast-MFC-AGG-ID: RdnEFCfSMqCh-lOcYnO1iA_1775684901
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F6991956053;
	Wed,  8 Apr 2026 21:48:21 +0000 (UTC)
Received: from [10.44.32.2] (unknown [10.44.32.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D11180035F;
	Wed,  8 Apr 2026 21:48:19 +0000 (UTC)
Message-ID: <3a97a7d0-2bd7-4908-8028-2b6c83b9be3b@redhat.com>
Date: Wed, 8 Apr 2026 23:48:18 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with
 RESTORE_HOST_SPEC_CTRL_BODY
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, chang.seok.bae@intel.com
References: <20260408182213.522713-1-pbonzini@redhat.com>
 <20260408182213.522713-8-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260408182213.522713-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 4/8/26 20:22, Paolo Bonzini wrote:
> Reuse the same assembly as SVM, just with alternatives instead
> of cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS).
> 
> Due to the dearth of registers in 32-bit x86, save/restore %eax
> across the restoring sequence, keeping it simple; the main alternative
> would be to leave vmx and flags on the stack, avoiding the need to read
> flags from %ebx.  It's not really measurable difference.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/vmenter.h     |  4 ++--
>   arch/x86/kvm/vmx/vmenter.S | 25 +++++++++++++++----------
>   arch/x86/kvm/vmx/vmx.c     | 25 -------------------------
>   arch/x86/kvm/vmx/vmx.h     |  1 -
>   4 files changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
> index e746e1328d3f..d822dafc75f7 100644
> --- a/arch/x86/kvm/vmenter.h
> +++ b/arch/x86/kvm/vmenter.h
> @@ -55,7 +55,7 @@
>   #ifdef CONFIG_X86_64
>   	mov PER_CPU_VAR(x86_spec_ctrl_current), %rdx
>   	cmp \guest_spec_ctrl, %rdx
> -	je \label
> +	ALTERNATIVE "", __stringify(je \label), X86_FEATURE_KERNEL_IBRS

Actually the other way round:

         ALTERNATIVE __stringify(je \label), "", X86_FEATURE_KERNEL_IBRS

>   	movl %edx, %eax
>   	shr $32, %rdx
>   #else
> @@ -66,7 +66,7 @@
>   	mov 4 + \guest_spec_ctrl, %edi
>   	xor %edx, %edi
>   	or %edi, %esi
> -	je \label
> +	ALTERNATIVE "", __stringify(je \label), X86_FEATURE_KERNEL_IBRS

Same here.

Paolo

