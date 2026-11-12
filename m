Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521688;
	b=x8dt7y5EsUz7Ys+LDJlDIIAmETvYQuMz1O0fHTDf1dcq2tAGOtvdOFJhH+LWdUP7YwKx
	 yJqYixqU4Ny/j6mM7TdPKsP+P88F5MjokjXwRH7UvjZLkA/m8L45K4SKLR+1QHviOOag6
	 qVa30gCVv4xDsBymmyCzVaBGl/rlGmrPUNLbqFRjuZxz3h0NVi8qnMtY/Mb0fUbaKUBzb
	 ryKC+JmetdbPhVqAghb6Os4eld9glJCl2aR/9J9voBGi+Yy3zyvE5t98SUZ0OBjdcWhOk
	 yasTJyU1TLynON6/w/ndSA41WsOdSMBE2Lm5Sr91d8AIEXviJJnCc0JV50jrrXcch8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521688;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7XTirb6Hj6QyRMPdcPAxooRkBi3VSNvpy8OjENB+njo=;
	b=iIjP/M8AGLrr5U8pVfV8K6xlftcjr36dcEh5JYKCQud/4VEqdbstsemZmU3+Sc4NmAy5
	 PKm99W4RjY8MVpjgZs3BAIzg392D8wdNJAWRJfLngTRY462y6xjknNotXWgsOtP/XHdXo
	 4TcZO21ckubMm89c7iOHhyEiTESbD1yE7sjz3P4mUGJxsIfdvNlq2KFouCSRZ25t+C2EK
	 55X2bsAFJa75f6UPMeodupZOnw+VIeIrismrYL7g9zVk6rVDLETDcgwCRI0dfrYQXGVrr
	 gQ2aRj0gqMDpWP28TAGJzG4HYfXKTnUyAOlptVe8mzrnlclY1zsCTF/kF0tKRIh58cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026102901 header.b="X4HXgj/6";
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AB606A31C;
	Thu, 12 Nov 2026 22:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026102901 header.b=X4HXgj/6
Received: from [IPV6:2601:646:8001:6901:cb27:19ed:d7a2:a981] ([IPv6:2601:646:8001:6901:cb27:19ed:d7a2:a981])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6ACMDaBM1210494
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Nov 2026 14:13:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6ACMDaBM1210494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026102901; t=1794521617;
	bh=7XTirb6Hj6QyRMPdcPAxooRkBi3VSNvpy8OjENB+njo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4HXgj/6OSwkOxqsyWljcVkVck+r/y6L5i/11v8PZs4qnUfLXQ0B+paObySdU8q98
	 cOjEeFwI2fFmxmO69XAD5MOSbJ9rr4XwQ0k0DTiWOlHhwTs5g/Oq0TLm36Rf1QYa23
	 OlQfhFL7JzjSX4uqdCUJFz20QX+mKftVeYoQkwfarMCcQueCWFgJO+uLLMbiMSXk8k
	 u+RJFWJbuvtfvUPRHN8xFVLZDnCyiFfGpDqV6x0y27CziMcasvzkHmiIfWpYovGmHP
	 dchXDRPCvhzUsZlIl49fHNd+Am1y4sYJyjgxsSjqgxoF8v4OtT49bjUmeVKeagufak
	 gKHA6YV7Xya6A==
Message-ID: <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
Date: Thu, 12 Nov 2026 14:13:31 -0800
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
Subject: Re: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
To: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vlad.wing@gmail.com, security@kernel.org,
        kernel-team@meta.com
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
 <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Still, I have to wonder if it really makes sense to fold these leaves 
like this, since they are going to be populated soon. Surely we're not 
that short of bits?

	-hpa


On 2026-11-11 20:57, Borislav Petkov wrote:
> On Wed, Nov 11, 2026 at 08:06:21AM -0800, Breno Leitao wrote:
>> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>>
>> commit ddde4abaa0ecc8395e0fcfa3e92f65d481890cc8 upstream.
>>
>> That cpuinfo_x86.x86_capability[] element was supposed to mirror CPUID flags
>> from CPUID_0x80000007_EBX but that leaf has still to this day only three bits
>> defined in it. So move those bits to scattered.c and free the capability
>> element for synthetic flags.
>>
>> No functional changes.
>>
>> [ leitao: Required on 6.18.y: the 6.18.61 backport of ae1d2082d93b
>>    ("x86/bugs: Adapt SRSO mitigation to Zen6") put BTB_CTX_ISOLATION in
>>    word 17, which here still mirrors CPUID 0x80000007 EBX. The flag is
>>    then falsely set on Zen3-5, and Zen5 silently loses its guest->host
>>    SRSO mitigation. ]
> 
> Good catch, dang. That's nasty one.
> 
> Thanks!
> 

