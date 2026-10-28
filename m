Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191795;
	b=pcjvcbij+y4duag4kTuE804kxo3Kc3ddBOS3lkEOJIaXE741AnbLgTteFlCAnRJTbDN6
	 Ob8/mtuQYe3L2SYbnt7oFZKmrZvt3yn2sL3/kcsVv1K0BXb5DP9UzSUqFdcI2chhDg93A
	 YXpLSHE/nP93Z7/35euVovN56jHm1fAOPlxV1VA9nR6qRdJH80ZV/Cz36Z0vJj0G9wmBe
	 WmK70od43J0lpKuaEPgucCX4gL+7D/16JRUptfDIeN3MP4fu6oSxPN17fAGS3vXcOvCY5
	 YIpd3FWDsxr8bWYFEIvIBi4anE9CbumR+f0n9suGzO57IS4/ZZHvEkPx8msXd6pksyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZfYYIFc96021z2Ptr5l4lRWqOsC/xE10NBYAqp4BDUA=;
	b=CygbfIBbngDqCNB34xeDSKayZKoRl8syccUlBKBtgHW05NiDXKTfLjEC8TmvR6pofkxX
	 5gWQc4XbFniXPFeNpyL+J2QdCnT8frSGFL108HlOBi+sl2UVm/kAOp2Q2BJ+04wZB8Tuf
	 Ipp5fatJ96q8u9j8f5T05VRlkaMKpWks5d6EKQ+tEkwh1La+fE7sRldW5bHbZmYJamu3T
	 i8g37ZVkFzx+rlD5psbzgWnn46bPqCOfH2DDa1xjAA2JSUaK5i7OFAZJWChWuKm9ZRQol
	 QoaZ8jKXqk5lqzcymJcb4ZKqvjFPiYjhRkaGC4MIZWAAxw2AVVforv4R4YeHUn7qKkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=O2aaWT1Q;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79B606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C79B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=O2aaWT1Q
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfb76b304so142767f8f.2
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793191793; x=1793796593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZfYYIFc96021z2Ptr5l4lRWqOsC/xE10NBYAqp4BDUA=;
        b=O2aaWT1QUG5iHDpwaXyhMod5A3B/CFUFOO5o9xVnVv9+hVyLHlYVUnhjiTBDnvP0bw
         j97TZ+f9XcH2gXfC27ofhf3is0GhaAZ4F2R4EYVvVRwW/1g+HRE42j4t2aUl6tB0RuWM
         eGBGqh857T6SB3Vv01NI9V2T8ARx2MxyadEiHyDbv7IP/9/wvBt9bZ9EVoZ8/MhxRwqo
         FL51cHN41T8oSUloJITZx1Esez3ywHlY7XUe4ySd2ad8pkkRj7ewfe8bh4tEI+nibzRu
         OvgBGi0Rkq/ng1f2kZuM+G3CShg/OD6tdEsxsh0Rzhjk8j33TknS846UEv3L4jP4p0sp
         +mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191793; x=1793796593;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfYYIFc96021z2Ptr5l4lRWqOsC/xE10NBYAqp4BDUA=;
        b=TvJKl6lAESmlTAGuS2FfYJXBgKFyfC2pkqwFqtIgqpRd1eHPh6a/Ivv1+VIQrj4nJJ
         LaeXGwJkU91GyZAGjzPK4AwSaPc5HEYziup6irpwWl4LFLmc+UoxKhhvYsrkKlDn6/dZ
         siPWaL9wsdSj+Xlt2+vVPQjpWGrmEr+LAZ6fCP/g6X8MByZYI8ighTD7Y2d+UUS70G6F
         QcqtKk6y03BgdBQ+8z3uXLFZ+zHzXH/+UAkEVmd/K9CHGqQYHXqRpiUQyO0EE8ecALpW
         f5pm8tLXPiVm5Jb4zpxEXstL1nC46He+yMemufrObqLUnyqV4U/LLrXWkCE3GWGXPXmX
         YIkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAmen64hERkqDlLya6akGSLiJ+rJ8VQFxLAOQmUD9NxnGcekGsjvTF/Q/nvvr5wAQdOs0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjTe/vOFAYlF/w8c96Fxy7XsgD8ozU3h0Fc7obvjzkuL+1ZjL5
	Pkx8bI1BsMHGcYORkDAVTu6Knsp3DZiGlw1T7NHGiYEs6+6uzFHcXKq9oJ7GH69btiM=
X-Gm-Gg: AYBFou34ru7ZgvPvOv7de/9IAzFfX0O8eI6e7Ulzs+jOLas4h/hZ4s6uFhtEiz0mKkG
	ZfZrihYJ0SoznMJFvMV1ojXbbQdvGZ9vglH52gumj1TfLSQ7gd86syan1jNlFsWOPZ2SxQpkJO4
	e0evK0hdRU5Uacc9KrWGytMIsdSb02lLlx5gQZ/QHKs4T6rGUCD3/dUMxpEcu2wjsI9pCVv2JA0
	af9PGmxVztST66Y6h69vv1YbBB/sLBF7hKm6vKIauxXPM3QIrbO2pA2QEwKKIoUFU85wChkg4cu
	tuzHuy7TSDsP2u2ImlaO5kL64D/uIYTVFKXSu+vUxpj0E4Z7pmBLSFxdDx6rp6aYFQyjlkRXHFv
	OOC6pPQYZEvAEPFetHLE97X9mLKUjSkS65EUzqFKlETH+uC17o+8ve/pnx7/TOfbSUAo+GIypuV
	GfNDjf/ve0NwFNBsx5VfE4q+Z1Y2T4Jd+lY+25t/xIODONKxsEc+HD2/K9lC1j9E6SeVXs1jwqC
	EWvr4SRLcCxF4gixexWTcrrJ5aizkNB/ErKHWtT6mxrqldPl2DipZjWD2vqFedA6JjmWe78VSYt
	j9KMc6T3UPV55cUSgK0p+Ryn8cPhq6PALvh5ET21zbACG6H31sq8iQ==
X-Received: by 2002:a05:6000:29d7:b0:48e:e2a:4093 with SMTP id ffacd0b85a97d-48e5d5c277cmr3745966f8f.19.1793191792916;
        Wed, 28 Oct 2026 05:49:52 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm28285252f8f.53.2026.10.28.05.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:49:52 -0700 (PDT)
Message-ID: <567ad0ec-378a-4f65-833b-e40c07ab56d2@suse.com>
Date: Wed, 28 Oct 2026 14:49:51 +0200
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
Subject: Re: [PATCH v6 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
 <20261028081658.1228484-5-binbin.wu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261028081658.1228484-5-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.10.26 г. 10:16 ч., Binbin Wu wrote:
> Validate the CPUID configuration provided by userspace through
> KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
> denylist-based check.
> 
> The TDX module lets the VMM directly configure certain CPUID bits for a TD
> at initialization time, but KVM must strictly govern which of those bits
> userspace can set, otherwise a feature that clobbers host state could be
> enabled behind KVM's back.  The existing denylist rejects only TSX and
> WAITPKG, and thus would accept any bit that a future TDX module makes
> configurable, even if KVM knows nothing about the associated feature.
> 
> Rewrite tdx_is_unsupported_cpuid_entry() to reject KVM_TDX_INIT_VM if
> userspace sets any bit outside of the mask returned by
> tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
> KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
> the bits that the TDX module reports as directly configurable, as the TDX
> module itself rejects any bit outside that set.
> 
> Ignore the index for non-indexed functions when walking reverse_cpuid[],
> as userspace isn't required to zero it.
> 
> Note, this is an ABI change, as KVM_TDX_INIT_VM now rejects some input
> that was previously accepted.  However, the semantics of KVM_TDX_INIT_VM
> are unchanged: KVM already rejected unsupported CPUID bits, albeit via a
> denylist, and userspace has always been required to consult
> KVM_TDX_CAPABILITIES and set only the bits reported as configurable.
> 
> The change isn't expected to break userspace or guests:
>   - The newly rejected bits are no longer reported as configurable by
>     KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
>     won't set them.
>   - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>     still allowed.
>   - The newly rejected features are either obsolete or unsupported by KVM,
>     and in the latter case, a guest relying on them would already have run
>     into problems.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
