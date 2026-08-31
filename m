Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3812DFA4A
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156000; cv=none; b=oMrMSYy6jaKe/M5tw8oSKqBz2RB+RCxkhDeKp+w4zaqjmJ0r7Ae6bN4Sdp5/PDIpghi/ECK2njURj9p6ycgfmjkrGoT2JAlAI4FA8EdvM56Z/NmbxKZVl2Z7aXfYPCUqZrZEbgTdhVSb5wYLl5rfN66VJ0Bs+5Yh85vVVikdB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156000; c=relaxed/simple;
	bh=bGtlLNHZeXwTDuqeOaNrwGY3uLSH0iJMGMCr95unclU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGAbdUk27/45rBSzfIky105Wxi2IRjabfqpdSFo86f+2pCUZdaco75RAdzksXQxW3GSMlcYWikkyKhem4QmXBCeAhSahq+RG2rKPs1FW6SNISpqmf/Z4aFc90hpZd42MvAT/CWXnLhE4jxn+1BAzQ4PgFFQLd2ba9yAQRnriRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3xj7/IF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3xj7/IF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e61a34e5so957280f8f.3
        for <kvm@vger.kernel.org>; Sun, 30 Aug 2026 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788155997; x=1788760797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfxbA2i+f23qwNxWpVJUWwp2eUr44EFO/Ti3rWFq6J8=;
        b=n3xj7/IF9PB8BcIKcHffoy+jJQvVaSGxxM1DmK91/CAoTAt2IWkPAyONtCyDsjjWvY
         6nvN8ngjhfaVpicCW7t7LzfyZr7w5MMarWIWb+D7PCDu0ey4klLCqI3NGwzEOpc8fdDf
         JgqI/NvF9CAoxossx1sjDnTn0LDVILaLpMG+x/IrsJ6n57QM8rE+heCtmPqWXl+2YpeM
         zzKdvhWobHPE7lb0LY5Eayb9IbSvepg/RhVywfGf5Rhgy1IJhvPy5ZpN0Y9KnwEDzknh
         lQ3wNLH6N9fWNeQHPZz/l/cH45yEMJewD5+RdLUuB50bmqUibmJWLpJHoSI/cQhXKTcf
         KySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155997; x=1788760797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfxbA2i+f23qwNxWpVJUWwp2eUr44EFO/Ti3rWFq6J8=;
        b=noIoeIl+1IV6m8+SxMDZRiwmVEMAnJ0pQUUD24+4flIS9JcA2k4QA2iwwYyIUTF8hY
         ZDggW+ARMU93H0B4LJAjeW/h0OwdmmFb6mjpQGtlQE0wWtlnfHNVFEzJL82e6M6f3/mY
         w+EQHkImPb0Rm6pCMvMzKpExWvEsXkJK8OxYYSmfYLlqPYII+SrVld0MmGAdN+GRrSTE
         XtP2b8s0qh6Z8FPWKcX5jszQwjibhEctZ7Yrtmjwiek9OWjq8fNNwFRnmK/iLwKSKFEz
         D50wgCvmDqIZ526HTHmJgBerchJiACVyKjufwBprrkU6XW9pT5s3jsrF24ApoQhF9Igp
         /7Nw==
X-Gm-Message-State: AFuF++mn6AfErdVdxF/CP4CvrRrsAhPS7pt2ckM7zFsaAmrAq9r/pEAj
	zIr1FPGjkz/CkcFsznjcawi55iX8Hu47o780zuFn8/N9DA9yTiyZVFHQ
X-Gm-Gg: AYBFou1zXFjEAyaA253xdUwULSgmU2Uczhv/64stDuoPDa0CEG/i68WIXkSoyF98LnO
	uImVawctVpy2RO9uscbzdneWPMJswpYu9c+EOm9mYNbBWDdr5mPY4A89VwIYKOwKzRJJTwMQhmF
	xEN778ZarjBdPkOg7TYJ4tIfGkK8szKV7KoHixtvH8v5ukl5eA6hP9QeINJ7kBFAZxGDhijGBFo
	e8QBcKDunRLSTsJlBrj+C8a1CDeVx2pFxX4f0pXZWzk1Ht0XqpTWtMwmTpsFHtl8B7OzzcYK7/X
	bXCC/z5+itUlcnbSQtIXiaBQlJ9Q0Om/giU4YqxgXdQLfp4kC2+fd82+X3M5mrIMn+stcIDX9ki
	Y1v9EtFdkMhnY7YKG4nxumWKQhOsCAFVIyo7ndb7RXozFHRMm3iqBSe1uuk6z4QevV4QmB6PB6U
	rJkTN4pfKOR4FHWeKb2muqm15kfcfwNfPnMViv0MuPS6WxLxNO3OCehqI9Ls5yk8vYug==
X-Received: by 2002:a5d:5f8d:0:b0:482:ee81:f0ca with SMTP id ffacd0b85a97d-482f79c94eemr36614562f8f.12.1788155996487;
        Sun, 30 Aug 2026 22:59:56 -0700 (PDT)
Received: from [192.168.1.109] ([88.230.40.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843ce8b015sm3251163f8f.13.2026.08.30.22.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 22:59:55 -0700 (PDT)
Message-ID: <85c66385-7a28-4779-96d4-6b34f53b5994@gmail.com>
Date: Mon, 31 Aug 2026 08:59:50 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/xen: Convert evtchn_ports from IDR to XArray
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, x86@kernel.org, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, paul@xen.org,
 xen-devel@lists.xenproject.org
References: <20260706081311.13633-1-frn1furkan10@gmail.com>
 <efe39d24a2621ce23f9d53471b3b587feaaa8526.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?B?RnVya2FuIMOHYWzEscWfa2Fu?= <frn1furkan10@gmail.com>
In-Reply-To: <efe39d24a2621ce23f9d53471b3b587feaaa8526.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 12:16, David Woodhouse wrote:
> On Mon, 2026-07-06 at 11:13 +0300, Furkan Caliskan wrote:
>> IDR is deprecated in favor of XArray: see
>> Documentation/core-api/idr.rst. Convert evtchn_ports accordingly.
>>
>> kvm_xen_eventfd_assign()'s single-slot idr_alloc() becomes
>> xa_insert(), since it was really an insert-at-index, not an
>> allocation: -EBUSY replaces -ENOSPC, still mapped to -EEXIST.
>>
>> kvm_xen_hcall_evtchn_send() drops its explicit rcu_read_lock(),
>> since xa_load() takes its own RCU read-side section internally.
>> evtchnfd's lifetime is still guaranteed by kvm->srcu.
>>
>> xen_lock is left in place: it protects state beyond the map itself.
>>
>> Signed-off-by: Furkan Caliskan <frn1furkan10@gmail.com>
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Thanks.

Ping?
