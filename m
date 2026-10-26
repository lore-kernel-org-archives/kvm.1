Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999158;
	b=wo/ijtL4+A7wUD8j5kne5NZ9gPhuV6O25AAN7iyFZ+zA0/K/o+rVY/72FE1znHGSbUNO
	 TSItWVcr2IiaUyl+uKQlqoD1fsGXhYqk3Kz0mdVroSHKkW7UrWzLLXWauXsx6pDZFXOqJ
	 90B7YagRNlgqcKQ4so1yFBl4W2JIphuP9i5kk1zEVOWnM/vbCxumd1SkAyfUhj+DH3XmO
	 wjR0dx6XRHSvu1kyIB/oq+G17M7Opd9bXDHDl0F5QeRdroneUKtVqxFvcZmWUtARKHX7+
	 bNfVtu66HQIveDhib4a2PRp/1aEumED0qO0dN1ngMw4dpQRjMb/H2SMXsHcCqIyrNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pgNA9ES5pzu/PrIv6QLbL97KrUMwvmUV8dNRJkoausc=;
	b=0/FUax2ETDa68v1L85yNvmFwyo4TsT8cs6rHdPkjQpaC5c+oeL9v27qeqavsaDLU797s
	 oA7D5mYmNisy11yr2W9zgTkNiWWx+3N278F0Rql4jzsuZEPqjMPFm98SyCGkNnTNBclPi
	 5tQFHVJc7ECNipY3C0uKC9MORPnjWEH5sU9B4elxmoYg0v5CnfXCvfucWg1C6SB+6M1zk
	 xEckNVMdxDXaBj0/ZdwjK3MjDDRSAh3N2AI0G5FHk8MRSYEUpuJ7zeyt3d31pIk6oEwSG
	 23T3ovRBykbqxSnq6cA/yqIRFqLz4KrGQ6xMx6hsBVleVqB9kwnCdO0bCwZghYZ7SWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=alOFJpGp;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5A606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EF5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=alOFJpGp
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so6293465e9.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792999157; x=1793603957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pgNA9ES5pzu/PrIv6QLbL97KrUMwvmUV8dNRJkoausc=;
        b=alOFJpGp702Sbo8JIYzXMb2YB4qbNbcYug8GhJLutW9Hv9lhotA1aeZeJJEKH14l4o
         cGffY/Jyqsn18hBjreCkAo5W/BqUp0lOQCKOdFMeiKgUjzz7fegp5kjUPrXzV9/B8Szx
         idWCCPrqhl7zQXE/oKXJ0Cyn+HHaYJhH9KMR1xturFWVqMogU/bs0hAhU5d47XGGDpk1
         dQCtUkOZBqVQ+22v4iZeezKYuZ7yBSad3S7RPYnem+zzq3BBTu2U0poKv4NsiOxWt8fi
         XWoH/OngyESsuan0Y3qkpl/A/TsbQ2QtfYVBBQHAhdu6GzLCo4kDO8RVmGBMsz/hBz8b
         iKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999157; x=1793603957;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pgNA9ES5pzu/PrIv6QLbL97KrUMwvmUV8dNRJkoausc=;
        b=AzxcVh/vTTDUF6Z0RTo2UkAFcX7UsuM5KdQvXDB3iOtpQhovAf2AdCkbB2SKJgIvHo
         6SpuovSlKLBgERmh0eyp7sg7h69kXUi5iD7Lw8ALoxgyJWPBNdwwYROpohYdad8vEJxu
         ZfWrhzLPcTj6ULCZGMwVt5kLYxQ8y92OfVQWNVD5vAmkkvRLNLsDwX0/HSOhCLolZ3qq
         thIDWVWp7YyIzWFhfcOZB6IVPa7eglQmJFld4WBlV8YMNbThPgCvlVVVmTi8/RP6rbaz
         ITQKM2mUaSA35FIirIvIPnEkuns/iw75PYny5vtsMrxAkPh/VXI65EvFm5rbVHV55vpv
         JwZw==
X-Forwarded-Encrypted: i=1; AKwUvBw3AzYBJayPMrLOkkeNdOmopbun3bYJf0oHnPS2xp6HxRbEmFOJ1DyneOToi4R+OPKCgVA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvgweUm+KemcLr9QtkG7IDssFrEK782njkELa+kQZO8sq+Lv3U
	Eq99J0jBMx1kQppHtgmPq4bY4qtK6QC1fiADGkmidTDMiOKQbbYBPRt6CjoQT62UZ7g=
X-Gm-Gg: AYBFou1U6z24Ch8tXuTojzjinwwnXMtQ48uCIbHXQWfSi1heY/M/0V+COF/HQVkDIR+
	8L4GTtF5y9ijwVCvXmkoAv4LgTntgZte6DZSGvjoCusMeg36UH/rIt4KkTVlklSZX3MhFQplf7n
	n9Eha99THJ2CiB9Xnqdnfkh2v1GtdVIENz9CLbHPhPw/es784HC8iDBN1GUJkNybIXq2zLCa6/n
	xqg1unW48/aNzBwRkeBBUdAtMRV3leEHpindWxFp7vqRPzzuc3Bvi/W8BYV2qD9u5mqC76LnnlM
	l31Pdm6r57j7Sevx1NjRIejZRMin1D28wNKifYjn8eQpdlazJomW5EBuvPpzNdE9iYNncsVq4Gu
	KQSTovloIAUlS1QOTdxsmA1O0zfUdd9WIB0F0g0td20MzYtKf9SkgnjlgO8UBQcE7SGndLoSrO6
	VTowz5hqVS8pThJjMdvDO/FBOPNAZlv4yDnDrhozabYJ3KZhYgumDxWPxn9uWJxxueZ20j+qJ+K
	ih09b70mwOQhsMMRQOmQx6D49JyJAQguyDtXCQ1lcD3u17RLuXOHs/CqJsTToFOt51xRBbYo9lA
	uEN8
X-Received: by 2002:a05:600c:4704:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4a35acb115cmr112800535e9.20.1792999156749;
        Mon, 26 Oct 2026 00:19:16 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm12607073f8f.13.2026.10.26.00.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 00:19:16 -0700 (PDT)
Message-ID: <dcf5b271-516e-4fbe-9917-511a517899a7@suse.com>
Date: Mon, 26 Oct 2026 09:19:15 +0200
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
Subject: Re: [PATCH v5 3/5] KVM: TDX: Add CORE_CAPABILITIES to the allowlist
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-4-binbin.wu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261016091422.3182216-4-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 г. 12:14 ч., Binbin Wu wrote:
> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
> directly configurable CPUID feature bits to accommodate the legacy TDX
> module definition of the bit, even though KVM doesn't support
> MSR_IA32_CORE_CAPS for TDs.
> 
> Older TDX module specs define CORE_CAPABILITIES as fixed-1, so userspace
> may expect the bit to be set for TDs.  The bit is redefined as directly
> configurable due to #VE reduction.  Leaving it out of the allowlist would
> prevent userspace from setting it once KVM starts validating the CPUID
> input to KVM_TDX_INIT_VM, which would be an unexpected behavior change for
> such userspace.
> 
> Reporting CORE_CAPABILITIES as directly configurable also lets userspace
> detect that the bit is no longer fixed-1, and thus update its stale
> knowledge.
> 
> Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
> guest access to the MSR.
> 
> Note, CORE_CAPABILITIES is the only bit that is both unsupported by KVM
> *and* redefined from fixed-1 to directly configurable due to #VE
> reduction, and no further #VE reductions are expected.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
