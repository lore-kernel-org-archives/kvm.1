Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48C146D5A
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742247; cv=none; b=hHEVV2zRqT9rDiYjFLpGC1AP3KuSrJhrzO5uemVe22IKV/kbOY8eegdrW8W3k/dgUOKMBOMtZn1MTCwtxr/09XwHXyAFCkkFcceIpiOHG3evwGcEcfjLHWU2K7sUC1xOtIYjgenCKo5Y0YaTVFx7SKUD6UCOK71bisOvi2VUUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742247; c=relaxed/simple;
	bh=UQCTdm5xqezdONXtHOI89VgMxCqCt7KEC8aa3RgWTpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrCzXIXTxtOjiuyS9JSxhebPpofp6KKPbxfBTsIxQSEmMmRjicRdrteKxZTlIgEbg/wmXAiVnLWIXY2JMmCsjgJRstev+yR3kdBhWeAjvyPkAIsxubhsS9MhN+B78ewvNzM2oSkCxeHcMJZ5ElstORcvB34khVddh8amt9Mbwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MttKOsL4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MttKOsL4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so3618525a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787742240; x=1788347040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TFfx1kRfOQ4Nc/ceLnW2laaeOesh6GMVW4RW9KML+2c=;
        b=MttKOsL4GJsYR5HENVdVb9JQn1Z5kprT1jmc0kij5DHzyRAftdrW+EMoZvf9xBEhwY
         jbAbwnqbvt7XKkwV6BFUZNdB+qgEchtKiE+KxVl0fSzLW+VtAsJe/AZThw1eD5WZZXoI
         4/krxMuLb4oxWkGPMomHHk0aH8qmh3SU6I6lKKSRMqMOFH6p1VXNgeY2ifoRN+Pb1p06
         Yp48KjQIVCwakWGO7SGV1HXBFkoDRSB+t/g/CUvWT3EeaYXwCST76ZK9y0wuEJcAsmIm
         mAMv1mC0WpdAmQEMEYxn8gcZG02xX5XTs6YGhoO927kmLGI4SmOUWiIyD3Gydn0D4VaK
         Apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787742240; x=1788347040;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TFfx1kRfOQ4Nc/ceLnW2laaeOesh6GMVW4RW9KML+2c=;
        b=BW6CAGS9occ28YHVYr6LGMGQwTl0WanmdyI1pp4EV60BruoniSbvrhuGPGbbkpERT/
         TnLAsJ/2VndAV+h0KgL8MyRAF+MUY4B+0bWOoMXHh145mLsnpso3u5WDh/iK1GeTvL/h
         Am5cMFfvJo/TvWpd7syU+LgaRBUhYeGdYUt8D/j8TuAXTXa/waEQQ//EReKjZH1GOqsF
         8sXFbcrvG4MS1b3w4rNJCciJ4CHfBGAyKmM2/MyzfWiJk52/v09lLWchQB01FIfTE23q
         4Corlz7UEBMaFGRsvFbGtJQQ+gs6CYDJSY/HDCmPVn6Sm7BtSCVXwcJp8Pkyk350ZYs9
         UGbw==
X-Forwarded-Encrypted: i=1; AHgh+RpPH9ZrBM5KVf9trndC/dVHbPOB3vNyjTkV+pBIjDpOoqN0wMYwTGOYuRjeUIR+80KqDSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzAYzjSWKSVrLtVxJ5jtbLk+e8kud1hJHoy4wwvNsOvDZcb8SE
	Me+70llZH4l4hFuC5b0nti3T/v7sL5UP8yma/SRoew6TsjK3k/Pk8lGg86hUM51truo=
X-Gm-Gg: AR+sD10dYlgKkSL98808OJQQmVgk5YuiUzW8NYmKbgZAUvgUVDuHlGS42M6w3CVTzvw
	tpQK8gKH9m/i6RFvFAu3UqXb7zTfD8u/CrmRePb54Cf4oys9Zy6LBvGpU6mOFTRKwVHrWBj++uH
	rM8+CkrzXZYkcV+YrqbcJvBuvy+7EQl7p5/cNbZJoLIhEVGOJ4EBBSfb3Grh34C224IBvrzMsEH
	q1H4fQ9AhjIXqRePdCT8ChVxreEKN4rsOuEbBEjns6gux4yCqOgAVWWi0cZlSe0+pGc63A7tdLE
	ljl5jymBioBZLd1RG13KNZj/obf/Lwrk7i74on/2HatNGziPnNf2Gy6TNB1wgPYrJpY7xl9ZSyG
	+KMXg0u1Vw3kfH3LiT4TqfYPw3NHu+jcosVf4WALKTF6hHKL/aWnBYwHmx4IMVAexowXrMcjvr0
	axZS+/Jh/FgT7FRutaX9/vatZsrV/giVWLJyTtfi8L94zjnzl/8fi5XM2Yv9+uuLI=
X-Received: by 2002:a05:6402:2111:b0:6a0:a46b:ad3c with SMTP id 4fb4d7f45d1cf-6a5df11bc67mr6692139a12.1.1787742240194;
        Wed, 26 Aug 2026 04:04:00 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d21f8sm4139483a12.11.2026.08.26.04.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 04:03:59 -0700 (PDT)
Message-ID: <d9d4264f-eb8f-4407-951b-245d144b3ec8@suse.com>
Date: Wed, 26 Aug 2026 14:03:58 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] KVM: VMX: Consolidate the exit handler for VMX and
 TDX
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-10-xiaoyao.li@intel.com>
 <5426d2f6-3e67-45d3-85d6-d0da67edb486@suse.com>
 <34161383-a382-411b-9278-098dab6587d8@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <34161383-a382-411b-9278-098dab6587d8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/26/26 13:43, Xiaoyao Li wrote:
> On 8/26/2026 6:03 PM, Nikolay Borisov wrote:
>>> @@ -960,7 +978,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>>>       .vcpu_needs_initialization = 
>>> vt_op_tdx_only(vcpu_needs_initialization),
>>>       .vcpu_run = vt_op(vcpu_run),
>>> -    .handle_exit = vt_op(handle_exit),
>>> +    .handle_exit = vt_handle_exit,
>>
>> nit: Why isn't this vt_op() for the sake of consistency and introduce 
>> needless churn ?
> 
> I didn't see how to make vt_op() still work here while dedupping the 
> code. Do you have a better idea?


Indeed, I saw that vt_op is actually different for the TDX/!TDX case. I 
guess that function is always bound to have some quirk - i.e it has an 
#ifdef guard inside even though is_td_vcpu() is defined for the !TDX 
case but tdx_handle_exit() isn't. It's named VT, even though it's 
defined  in the "vmx section" ...

Oh well... My RB still stands.
