Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817349;
	b=PRIWqqwsXzjqhCSEF5RPfWmCHcH6u7fDbE70fs+zlZSMJ2m2Cda40RB9Uijsr6332iSn
	 33Glh8G0MyAUtKq/oBPY0GVbAE4yLSM/vK5hxQokXR1gyjcsq8XeApu2rtMrxXZ+g9Ptr
	 Cazv2NCMVGyMQvoBW0WUtNXVyGPnKoVGqKUJ57bB6gqrp+EDwRnUTqz+nR7L3haFhFnvg
	 vlMNHFLePk7GYFAE/AImsB1YQwaPvJtfHfGZK/I+6SMkbHs/UQyb5mpL+5T73xtPTs04i
	 FuXI2qbGNDspmzjAdlDpRhzRl8PV8s7ZEUUnnf/oNEWYR13YiNfdz64mF9znD+uuSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817349;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	b=PEFH+T33q11nzO35UEsLHyZz4wIGuqXBcsuro0GmS7kDUco5sWoydWcEnXZEhjGkOzzW
	 jQSRrMRcjaGzQd0sQhWSKS1hBoEUnP69ctrvvCTXTkcNrVuB8eL6Yzl1sxvgmTKp20pVH
	 +8F9QVnbTK/Ik44ZbbK18q/viDVhsrx/VlPhCnPI6Ho04IaSwOPZfOkIAdOwuQa0Sfv7u
	 BOV0wBJkbLOam3+cebhW81KZ3dfM5vJCuG7wnNDMwuvhCLr6u0BsTOklCySJDOikYQPe9
	 SySaz+zW93CU3PCReUrH0ZQ13C7jKHoTP08Norehkw4sIklJKh0rnrQ8w99xHfXkcvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQl3mWaA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GXTDQULD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A2606A323
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875A2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQl3mWaA;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GXTDQULD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794817347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
	b=ZQl3mWaAP4/t9kge0C6gTHpKuNFueQq9VnjFgdRqXQxY8abdd4Em5jJ79eBRrCXZnK0X4U
	pFuDLweTjtCimR6nJkkA5Akj2ApWuwwgh6f/KrFhcBaSHhDbGTNgk20IDD17d3UHnpat7/
	gzjt7h7HGOdn7VcYqLJhzXdPxBt15ho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-GNrJ2uGBPaSLmKhaQXC1Mw-1; Mon, 16 Nov 2026 03:22:25 -0500
X-MC-Unique: GNrJ2uGBPaSLmKhaQXC1Mw-1
X-Mimecast-MFC-AGG-ID: GNrJ2uGBPaSLmKhaQXC1Mw_1794817344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb69d84053so7120575e9.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794817344; x=1795422144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
        b=GXTDQULDIs3Urjl0mxne6OsLdGIG4PXrfDTIIyrtiKrr0OA4TCFqnox1noscCkkzRl
         cCsU2k/ed9HatqLR1LWaVpQ3YbWa++MJ9zcJ+Uc7zjr83eiYZdXAKE4SLxNrxg4A5WJv
         quDPt+F+FHdrJdGOaLIxpbb+kwwoKYBZITTYDx2NtucDzCyfaGfQyp2KWUFCGQzZ2Det
         saoLxIxg/AMqSzqWm0mxbC1XD1yRq6laybmZBBEZbP8IAuGrgVQdbCCRxbnKPmy6Ehuk
         KSuqMbw4x0cgVJEepwk2mPlTRHs5GAPxpTIJ9EE5m01YU5pWLtp0bgvtKqM7FbieSi6p
         cd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817344; x=1795422144;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkbR11E3BohH41XWDxNdS79CwwmA1GSYQfGnzJeNU7M=;
        b=Piljdpj5cxFIeOlBS5eJJZLv9Pt8w6Q68vfnbiXr4Ejx1FFSAqW3+Ic0kTF090hI2d
         wCSJGzPxnNvw7KqD6yATlicmoWArNwhDYtWl/bH6rwsVEGtWlB7DkyRVBgJHIlFC8alO
         /YklDMVwxTyV1cdWDb3untWU8ScfrkO7AetCpl06xvBkfvd3c+X1mtM//ni/49t3POpL
         0MFoF6AG5AjVWcEuffxq54ft9T5g+xOe1AP3QJAn7wg/iXa2nza+9skG/sBKypoFyckx
         HgKr0DXOydeb0TZCHY81nrBnDJ75Cjie+8iGVFobqhMs7GvM4U0O5W4oSAhZO7jrPcBq
         +vaQ==
X-Forwarded-Encrypted: i=1; AL+hErF6T9cmsAtFf4cHKOjxjuhg0ADZr19oUimrsbJMj7Nfsm4Tfa0I7jU1/oUU06dWB7rWJgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5kvSklWs/y6MsLsYTjOsKSawMVnxR+4U0GcXXTBOAvodZh4DT
	6fxfwQkLH69tZrmhW/InJ0TPM8iBtcR/vzr0Dlm2rgFZ4J2+w1DSdLWmJpyiK40b0+aGWvG3tcL
	poy1YI1eUB9h5Zch7BxC9WSw+YkRTpuScn+OpvKi55FbebmbV+IFatN5esASy7Q==
X-Gm-Gg: AYBFou0rC35dg83Sj/pv8XTCf3HmTtmkSbL5hdxzp1ebQiLFjV6T4yQri9cUrXih5Dr
	knYA0QfKRw541lbR67vh4nOEV+1q638XegO76hrhktO48wXpFejgyRXcNcWJcjux0dXDNQWEd49
	AECb7l4uo/as0Gb4ZuWvNku8K1KV1vez/qOn2YebgHxv0F1VJmVoxpyIK1cIu/TAwHeqWBII5RZ
	vG28SVDfXMtk9mXaX0bjpLZvIBQXy+6+YrpWPTK0sUADbqbzCk14u27OuH9I8gvJ+iXCacImQw0
	cv8HklW8+54bcRcViRvUISiMrzGCOmrn6MkzV+ATRcPFIdIoH/in85A586p5BbFTbTQm/DHmR4X
	2gijouZBTm3ga2LUcZx05zk2XMtem8O9aOO/2fNkkjPYP
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb69b2d82fmr80275545e9.25.1794817344383;
        Mon, 16 Nov 2026 00:22:24 -0800 (PST)
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb69b2d82fmr80275195e9.25.1794817344000;
        Mon, 16 Nov 2026 00:22:24 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb52bab8bbsm276579265e9.13.2026.11.16.00.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 00:22:23 -0800 (PST)
Message-ID: <942375ef-cab9-4746-ab18-184b2761a8d1@redhat.com>
Date: Mon, 16 Nov 2026 09:22:21 +0100
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
Subject: Re: [PATCH] powerpc: Link with -z notext
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
 <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
 <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4bcbdea1-b2a2-4f09-881c-c6d116b59127@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.11.26 um 13:03 schrieb Thomas Huth:
> Am 11.11.26 um 11:18 schrieb Amit Machhiwal:
>> Hi Thomas,
>>
>> On 2026/11/11 08:54 AM, Thomas Huth wrote:
>>> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
>>>> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
>>>> test binaries:
>>>>
>>>>     /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>>>   Hi!
>>>
>>> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
>>> 44) ... which compiler and distro are you using?
>>
>> Thanks for checking!
>>
>> I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more 
>> details
>> are below).  Are you cross compiling on an x86 host by any chance where 
>> you are
>> not seeing this problem?
> 
> Yes, I was cross-compiling, so that's likely the reason why I did not see 
> the issue.
> 
> Anyway, could you please check the following patch to see whether it fixes 
> the issue for you, too:
> 
>    https://lore.kernel.org/kvm/20261113120101.145183-1-thuth@redhat.com/
> 
> ... that compiles the powerpc code with "-fpie" in the CFLAGS, so I think it 
> should cure the issue, too, and it's likely the better way instead of 
> suppressing the warnings with "-z notext".
I was finally able to get access to a ppc64 machine, and my patch is 
apparently causing other trouble there:

  /usr/bin/ld.bfd: powerpc/cstart64.o: warning: relocation against 
`stackptr' in read-only section `.init'

So I went ahead and pushed your patch with "-z notext" instead to have at 
least a workaround 'til we figured out whether we can and want to push the 
"-pie" flag to the cpu-specific folders or not.

  Thomas

