Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE23CFF53
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368720; cv=none; b=MFKvaKow0NyolQUnAOZPZnXWh5PlV6nhoeUZGn38qR/dq6RYvpIFXaA6B5YGtaz+zkFfTHsD31iucP8My51THRySEYao/iDSf+n3xG0i/6TdTjFaaJlVgLijfX8Txifvm4wjBI2TIHc4FvEKkQeD23+kE+xM3Yjqvio/4aZIC20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368720; c=relaxed/simple;
	bh=ZjlV/i5ukXT5Tq7W+6Xy5j0Gf2Sy7PjDt/RTtEmLidA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpC//sVSbcfGu8QIDVbhTdBaqWdLjXO/YwXO1sSmMTKQpDJhaaeYIhEoD9MK6YVwgUSkzw5+r+es7OeenjJf32f8qd0aU+0Ch0P2S2W2Woea3YScW5GxInAqKm1/DF3+rFFrj5gk19Yt1FuZxb8XECIJLMKfzRyANj5N+h1KdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoLF72Ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoLF72Ww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777368715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FBABDasRODg3XHswQuIjRl6rWOH0h47gPYgPpf4JDSg=;
	b=MoLF72Wwv3fWT+5fLVM+l3FnPSUVY8dYSqlpLxEiSQuQmU2KECHZR5SZEIe/DDQsEqY2hB
	iV5ZSaDMtjGm/Q3aMX1WvYt3V3T1KTrTuMqPQTHy2CJcAaDRF7kymdS3dWp/SsdbRSlGWh
	L9Zs1HRI/enpgaTt4DsT43YcFqIFqck=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-mXOd_xq5MWmjfRZgA2tMpg-1; Tue,
 28 Apr 2026 05:31:51 -0400
X-MC-Unique: mXOd_xq5MWmjfRZgA2tMpg-1
X-Mimecast-MFC-AGG-ID: mXOd_xq5MWmjfRZgA2tMpg_1777368710
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D63551800578;
	Tue, 28 Apr 2026 09:31:49 +0000 (UTC)
Received: from [10.32.181.22] (unknown [10.32.181.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C937195608E;
	Tue, 28 Apr 2026 09:31:48 +0000 (UTC)
Message-ID: <d998f4f8-0039-43a8-a7a1-4fabeb120d6d@redhat.com>
Date: Tue, 28 Apr 2026 11:31:47 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] KVM: x86: Support APX state for XSAVE ABI
To: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
 <20260428050111.39323-7-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260428050111.39323-7-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 4/28/26 07:00, Chang S. Bae wrote:
> +	/*
> +	 * APX off in XSTATE_BV will guide fpu_copy_uabi_to_guest_fpstate()
> +	 * to avoid from unnecessary handling.
> +	 */
> +	xstate->xsave.header.xfeatures &= ~XFEATURE_MASK_APX;

I would place this statement inside in fpu_copy_uabi_to_guest_fpstate,
and more in general make arch/x86/fpu ignore APX when dealing with
guest_fpstate.  This can be a separate patch like this:

-------------- 8< -------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: x86/fpu: ignore APX when copying from/to guest FPU

KVM will store APX extended GPRs directly in the regs[] field of
struct kvm_vcpu.  This is done to make accessors more uniform
between GPRs and EGPRs, and partly because x86 maintainers
expressed the desire to compile Linux with APX enabled sooner
or later; accessing guest EGPRs from KVM's C code would get
in the way.

Therefore, let KVM handle the APX feature on its own when
executing ioctls to get and set the virtual machine's
XSAVE state.

Cc: x86@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 608983806fd7..c35cff8dbfff 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -420,6 +420,8 @@ void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
  	struct membuf mb = { .p = buf, .left = size };
  
  	if (cpu_feature_enabled(X86_FEATURE_XSAVE)) {
+		/* Up to date APX registers are in struct kvm_vcpu anyway.  */
+		xfeatures &= ~XFEATURE_MASK_APX;
  		__copy_xstate_to_uabi_buf(mb, kstate, xfeatures, pkru,
  					  XSTATE_COPY_XSAVE);
  	} else {
@@ -464,6 +465,8 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
  	if (!(ustate->xsave.header.xfeatures & XFEATURE_MASK_PKRU))
  		vpkru = NULL;
  
+	/* APX registers are copied to and from struct kvm_vcpu, not the FPU.  */
+	ustate->xsave.header.xfeatures &= ~XFEATURE_MASK_APX;
  	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
  }
  EXPORT_SYMBOL_FOR_KVM(fpu_copy_uabi_to_guest_fpstate);


Thanks,

Paolo

