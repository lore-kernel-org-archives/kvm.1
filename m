Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582403;
	b=4PQoWIZXtKAZHwi8u4+nvBliLOvuRMejpgsmhiWZbzW1GFBU1/zn7AiKg2ViVv+YDqu7
	 6umqs+KBNXQu6e/ff/kMZPOwVjT2h15j6dFbmp4rkhlg8e6XS7dAW466y8CCdMqp5FBij
	 TGibUE2p8KMK8F+Or/ZZ+YsVFyU9opICjwcQ+RUtmsn3o3xGNkhA4zi+Y+ArVpFvAyaur
	 hqhNk7/rt1qZLR6ZhrUUcH6fAPGQz1hh5pTVYXAvFFdXGGE6e4+RNI6H0TYxnoCxLw0jn
	 1/PjaoTDX9Qo/+tOydxD9gg+mYtuXN4XtebBZS8FP6F/3s3zDOviGXHAtDoA3KxERNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WRbE/ClC4DCa25YOZgoiuOw+fWtwtLO81F/+SZ+7Q48=;
	b=e5CSGeEDYYt88Xp8N1y8EN1cO/EWnmgtO72zycnral2Bn4eAVXTJ015kz763nMFChyuF
	 o8HQ1ptP8iIZshAHvaB36Pau3/Wob/+9KtL5RjlLpTmqWX7ggpTIhcdfQziaaUlG1Yzys
	 ntrv3MtLtIUUIfjOJh3weaX+AtWLqGtOmSCGlf4te1Hduofaz5juz2S16ZgcEsqB3D3DJ
	 KgzrLvnw97KCDcLOQyOG98yCSJLJcrP/f4PYZQzgN+YCC9EPRjs6ZcWUL1zULV6eeftoD
	 JuR+7hxMR1pG38W2en/MBtnAN3Sc/D3FiE5kaZgQlGKnq+VQYrM8ou3q/N+w6Q/Aa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Axb7NsCI;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E96606A880
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 15:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E96606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Axb7NsCI
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so16272425e9.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794582402; x=1795187202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WRbE/ClC4DCa25YOZgoiuOw+fWtwtLO81F/+SZ+7Q48=;
        b=Axb7NsCIAB7p9iSXQm7dWzwN7Y1rvsP17vZUVDrpPSvEN4LN4/Uz1YNMkJhTJXkop/
         mtjC+vJZh2hDO1GwJfXedJxIsLNUs4OAzzMUIrxi1vTsqFN91WtuWK5pkptktbtjEHg1
         lOyxSXhRobIl0FYGW1xZ5+8xsFCacs/qeo/99ib3InqnljMABeegRVOE0YRLRBrSFKaX
         iPaK3DHdAvZSAQRN+uxoHRRKIid5Qb/zza/dIwKwIVi5R39d0VC5dgOCyAQW94FZCaZg
         IN51677Udf6NOyNoeYOmxzyCEFFrBOsrPBLd0Jyn0pMXc/Wu28ArSQOoD2r00FPXH8v5
         ER2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582402; x=1795187202;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WRbE/ClC4DCa25YOZgoiuOw+fWtwtLO81F/+SZ+7Q48=;
        b=ief8c5PlC+SWI904BrPe40zffNnOoBoM3IcdkKenN0+Y0nRQkETpSjK+VaHZUTxPom
         4UJdCzmjv7OOp6csOw5K8CV2oIHK93KQ2GEg6vperUpzlapjOQ1VekZKOc3jRsLIXg3y
         bWq0QAiM2Q46nostu4RcQaAOW5hkYSnoki0e21aGwfJQsBXeaDqnHBhOwBlydk/hm3bW
         LOhrhAlcWQO1GUcAcqq6ESStrefROewXChbPw1p4QPe8rm8xLroFdXnqmi0SPDYZTXxV
         LPPolWI/9ERSmTLV/c0jNjgRQjtoIJMPh3AgjRKd7yDrcoJLaSRoUb18vJODIyxAHG7a
         OaLg==
X-Forwarded-Encrypted: i=1; AL+hErHhhdxUfB90ZYzqR7GlGp3CWfgav60rWXexYNVvPDcVYF038iA+Z0FhA+/zHWsvW14p1DA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q10etRT33wNIxh7o9ro0f7z6aQ9CZppTSwVTtABn9HhbEXe1e
	PT+CFBBwfcIodID9Pu3gwkxhHDrfQu+vlIN92MkumHUWmf9xHMxb5qT3fjq++GeDKV0=
X-Gm-Gg: AYBFou1n/eAutTH+UTECbv/VZPKARq+KNCT+UWd2KtO6JFANSu+lVNIfNf1T0B9H0bc
	Z1bdUoGvfVqtZuMVMV4Cjnm84iqrq8LHk53gTc7JaVQnSyHHZTvJM+QsxnFC/qLcEBYVpioTxwa
	83aipz9vbhMoO5U+eidheQzgh/BnFXSakXKSOsoIXkFGsuqhq0hPp3TPxFxMldbpscM8yG+stN0
	EUL3583mC4fyMC52XBM4wJogq4Z1qTBDWl4j9+S7XuNxWlBczpdaSA1nxNyU+7HWYWA7P4rwm4q
	ufeWMBJi8PQ0s0QenD70WDkLrWG+9CeSpdYMiKFCTd0mxdQlRor6rbTc5H6bhshKhH06XwqIi6w
	dDlUDX8dQ5aPq5gA0eIh6w2anxTuB2z6zbkB7ZMX7MQmMuLZarC8A+5ZZnQgHuxfhJ2SROxCLB7
	iystbaPv+2mb98+eTmdy8Asj+eKEmJ9Tg2wyLbdqzWEZyThcul3Ya7W72IMO6BpV1YJ5HR1i4hY
	Nc0nL9ZAIPeIaT4VbSkT8HAy19GtXGCC88YVr13N/Rug1vTAIDYGmKOF0J/0yEpviMQvWFu3Tpa
	tI1sxw2Mjd0T95wW6tgS/2Vz5GFdMmvz
X-Received: by 2002:a05:600c:4f0e:b0:4bb:5f43:23bb with SMTP id 5b1f17b1804b1-4bb5f43261fmr8025205e9.33.1794582401803;
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
Received: from [192.168.0.20] ([212.21.133.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm40186365e9.3.2026.11.13.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
Message-ID: <eeb076a2-56c9-4864-a8b7-acbfcccb4fb6@suse.com>
Date: Fri, 13 Nov 2026 17:06:39 +0200
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
Subject: Re: [PATCH v5 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
 kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
 sohil.mehta@intel.com, adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com,
 artem.bityutskiy@linux.intel.com
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.26 г. 5:48 ч., Xu Yilun wrote:
> TDH.SYS.CONFIG is currently not wrapped in a SEAMCALL wrapper because it
> is not exposed to external callers (such as KVM), also because the
> level of TDX ABI details needed to perform the call is low enough to
> flow well with the calling code.
> 
> But as more configurations are being added to this SEAMCALL leaf, more
> ABI details are leaked into the surrounding caller code, which decreases
> the readability of the caller logic. The first case is that the Dynamic
> PAMT (DPAMT) change [1] tweaks the R8 argument based on whether DPAMT is
> supported by the loaded TDX module.
> 
> A follow-up case comes as the TDX architecture has evolved the ABI to
> introduce new leaf versions. The host must select the version to call
> based on what new features are supported by the loaded TDX module.
> 
> Before the version selection makes the caller logic even messier, move
> the register ABI operations into a wrapper.
> 
> The original changelog was written by hand. AI was used to help correct
> grammatical errors and polish individual sentences for better
> readability.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Link: https://lore.kernel.org/all/20260904215841.303070-10-rick.p.edgecombe@intel.com/ # [1]

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
