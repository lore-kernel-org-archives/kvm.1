Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999132;
	b=Kc5DbaMu/zzD3aNxJ2rZ0wJuRBqyomtLrnrAEUOXHsQvph7lvk2xj0riMTiw9Vnsvxar
	 4UCC5tInAm9AnWkFLLbeYUgtJfyckfo1fD6hWlkmhKg8G+sVebqohl+oExI5WD9mtFz1n
	 zr1pZ3741FrsbAs2UP6xzYoD/Ij+0kGZ/qQw39VXvU45RP/bQ1SH+cgjn0mjSBIs/AzGH
	 SMpoSc5IVzwrHT9NfkVs9KFJI/buQmVnQ1r4Oc9C8CrOMYxrM+vNtrzLQy1UBIrUKItbq
	 qkui/pzu87s4uglwIHJf6S74UV7F7XUmWC7qPcwtQjPWZH9Gkp/64PpT1a6kc/VDXhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=djhi73/E0YES7rDU6N5TQtgUKhsNPCDgyp+K6uJathY=;
	b=C7QYd4QHQbTFR/EYvJyW5C5xg02ZYLd9WL78i4/lQCLTA25bn2GHFI7fF03vSmSO2Lar
	 g4TBHYMgFffAxyxh7bm6O2djHnQ+yg8iTxsPsWh2IvxgtKFp22vNwnAjs6/ZRdeRm3tvp
	 3lC/7iIVVADn9vdYsbtYwMrpOcwa3D6pijRpMxWoD82eUkLfi0Ww+Qb19TwNxuZUYmk5h
	 7h6EVckg02OfZZl22GZGQ4V7B/UCodgdRMmU/Vn4r+cU3Icwg6gduOF6yBoa8m+oev1gN
	 4zMgj6Aq4zIXZ1wRa3AAZnDRGDoKZF0lSvvgjTR6Egfwpu2TmNcFfYkSO3ivFL2lpoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dtYNlF53;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BE606A31E
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dtYNlF53
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so21378335e9.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792999130; x=1793603930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=djhi73/E0YES7rDU6N5TQtgUKhsNPCDgyp+K6uJathY=;
        b=dtYNlF53tfrvhfPzi0uF1flxN4D7lkFQO352gLd0QGWYo8mO6gPNkNfS6Yhbo0uZAQ
         wHtH4T35hlbmlBs0ggQpA4xuy0zWzpx1ypufashgnjTtLZ7Oi3D/YIrIugkPkd35iXTA
         l/BbYFYzxeH5N/KM6k7uYe269acyCNZsVHQhUCK018f9+Gq9dm4ovwV/Vq6FJe3b4Htj
         eEtiVJViEv6wh+3JV4dlZknuUNAFsEp7Qkxurwto9pt/7QarB2SOdnmeX1ZdpBc//BR1
         d+NmJkaBUbmTPnEkbK07/MNrzryBFVkXDiXPNTXo4TZK10IG1oMwA/qvgICi5iHrf/qH
         64MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999130; x=1793603930;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=djhi73/E0YES7rDU6N5TQtgUKhsNPCDgyp+K6uJathY=;
        b=HeMQlsPuvhku6Jq9VhiySIVWXvjEUZOW+F6Rr5n+oi3C0sjv1WBHWUuN9phgkaZM3R
         n565Z7u3C+6bwKQj1s95GH2UcQwlVOd0lxMjxOAuGKGkSWYuqMc0R3pHH2XyLddM/vH7
         DMDQJMwXKNgCQ3EpqrzsjmuROq/CtKIXYYqyv2FPw9xBpMfXZ/DC3vW+DKE2CUnX9GWJ
         YF7iHIQ/4FrM/D3lAhP5LwyBMRuCFWBH/DcRJj6UZMDRp92Cz6+0oReC6+5Cs3b9WQdF
         MgMpy8/b/tZbd+np/nl8M2VBjEnUeayUWcCs8qlwzhEl058xyBVr1G9Z2aSXW7Sg8Dh2
         k3Sw==
X-Forwarded-Encrypted: i=1; AKwUvBz0Qt8LQ6e6zZmi28abwpDQBt5ie3GFlwNRdDKVK9pZmyCOInCy/8/E12xScg9ZZmh/9SU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGQ8iJR985HDr/2pXZHvpsoPsoeo1vMgXA8ezqpdOPReZe30hd
	7OTXrZ7MgfZ4vJNsc7qd2b3CFadG8LD44iaeHaJOtYjSp+1Xe95sqfXIDegYg35HE2s=
X-Gm-Gg: AYBFou1fX+lWVa0Gy+Zf34AEq/N3z8MkQWKKvlw1KB1y3vdCYzwQvPmpijCSHlqyfXz
	HkOD6q3RpkVFukn161T+LUbPi6ut4sV3GUYZj0uJDU3doILkiaR8W9JouFeDWM9t1DkoIFiNfZt
	rMioKhBLFtsdyI+aBKf4zwG/am3vSM3YpYDG7mLyTu8KGsz6VR/RFfEUZQyZCNFEqLH4OP33kCn
	Rj6Nr7kDO8w1r6Mrk2hApWCo7uOLxhigXjXgMmFfxWFjFa2su5jU6g7dkEL8XUNl5WEhEPTocxX
	qEq1nEoY4uvegDxQTd17ZZtNAeOKCwAgC2r6PsiU9hvvM35otHVetIR5+zpTyMgXZIL6RzxGoll
	q9D+IEwXWBrt1pdR3QC8O1tQ33jpHhCFG+Ch8AYjjI7BPVOOSY+GYftZAGZ32zgCZ/exw1qENP4
	RQ4HTl02pE+s2/6AnB01j/rbGqJ6BvgcPqHq7KNzMqQuzSUy0Wy/Qg2sUzAkvLvw19LvqPpYEeR
	uoziK4SgL91eWg95tEp8fgN1+D+HjPioJafLZfGTaLvTRfSJZ2VKeJZhu1fPV0MEV0zOVTOpLjI
	+YJI
X-Received: by 2002:a05:600c:4e44:b0:4a2:86b7:b76e with SMTP id 5b1f17b1804b1-4a35ac95a17mr100011305e9.13.1792999129962;
        Mon, 26 Oct 2026 00:18:49 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm175964295e9.5.2026.10.26.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 00:18:49 -0700 (PDT)
Message-ID: <5d0a6304-225d-4dd9-966b-ad569d522e0b@suse.com>
Date: Mon, 26 Oct 2026 09:18:48 +0200
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
Subject: Re: [PATCH v5 2/5] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-3-binbin.wu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261016091422.3182216-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 г. 12:14 ч., Binbin Wu wrote:
> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
> CPUID feature bits that KVM supports, and initialize it during TDX
> hardware setup.
> 
> The TDX module reports the CPUID bits that the VMM can directly configure
> for a TD, but KVM can't blindly expose every reported bit to userspace.
> Some features imply additional state, e.g. MSRs, that KVM must context
> switch across host/guest transitions to avoid corrupting host state.  The
> existing hardcoded denylist can't account for such features introduced by
> future TDX modules.
> 
> Aside from a few fixed-1 bits required for basic TDX support, features
> that can clobber host state are either directly configurable or controlled
> by TD ATTRIBUTES/XFAM, which KVM already validates.  Thus, an allowlist
> covering only the directly configurable bits is sufficient.
> 
> Organize tdx_cpu_cfg_caps[] like kvm_cpu_caps[] so that the allowlist can
> be built with feature-name based initializers.  Directly configurable bits
> that aren't feature flags will be handled when building the per-register
> masks for KVM_TDX_CAPABILITIES.
> 
> Sort the directly configurable CPUID feature bits into three categories:
> 
>   1) Features that KVM supports and tracks in kvm_cpu_caps[].  Use
>      TDX_CFG_F() so that they are also capped by kvm_cpu_caps[].
> 
>   2) Features that KVM supports, or can safely allow, but doesn't track in
>      kvm_cpu_caps[], i.e. MWAIT and HT.  Use TDX_CFG_INDEPENDENT_F().
> 
>   3) Features that are obsolete or unsupported by KVM, and thus excluded,
>      i.e. EST, TM2, CID, SDBG, XTPR, DCA, PN (PSN), ACPI, ACC (TM), PBE,
>      HLE, RTM, CQM (RDT_M), RDT_A, PREFETCHWT1, WAITPKG, TME, PCONFIG,
>      CORE_CAPABILITIES, RAO_INT, FRED, and AMX-TRANSPOSE.
> 
> Excluding the features in category 3 shouldn't break userspace, as
> userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
> bits before invoking KVM_TDX_INIT_VM.  Nor should it break guests, as the
> features are either obsolete or unsupported by KVM, and in the latter case,
> a guest relying on them would already have run into problems.
> CORE_CAPABILITIES is a special case; it will be allowed separately to
> accommodate its legacy fixed-1 definition.
> 
> Future changes will use tdx_cpu_cfg_caps[] to filter KVM_TDX_CAPABILITIES
> and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that directly
> configurable bits introduced by future TDX modules are neither advertised
> to nor configurable by userspace until KVM explicitly opts in.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
