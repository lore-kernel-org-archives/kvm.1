Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DDD36EA80
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065428; cv=none; b=NP5aVKpSd4lgFkDzoZPj7fSZ6ELDX5P5qffhR6NzsNTTHt+6CfhSqTMeiuZha7mCzG1/oMklygVzdjBJGfS7QDVrLo+dxFmay9U3RlJ+fhfnhiY2t8yHKIHFb4gewIpgvH7FiZ30PS2OYyaGjVuldrLy2930nvQbU74pK/uMuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065428; c=relaxed/simple;
	bh=HWG8Sz5OtbFuD11nfUVW578oC2IllQpqrCtgiKUiGkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTTWKpERwTYVDclmUge5gfNGqpXSp+a/NgONNSD0KuY841ItaVmVmsjxh/EyuHUGwh8vdNcCH91UHd05rGDBO9aEp16ySBpQB2sUFRX+rCp9UCKgXCWBsX85THB9sfKoxDbnPc2JwUjkqNdrfB39jDyIs85Y0FVrwQy/lB2V8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VRDnTHwn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VRDnTHwn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-476d8e647e9so251684f8f.0
        for <kvm@vger.kernel.org>; Fri, 03 Jul 2026 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783065425; x=1783670225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1yJhLwAuRQ39oUEKAohufcXKhiNT2bhqWZWs88GxXtU=;
        b=VRDnTHwnbJDu1JKH+kuxv5mNQFJ+dFAeqIt4NM15mKvmWsAH6VECtvQSdZggYzCWnZ
         m5IpKiCt4oID4/oRbTGNOnAy8pOUZ20vR8/eCIXrcvEcPVTXbHw7l1OCISP0VxI/PoY+
         cHDPCNZ9ntv+MnJAEmYHowfLE28/rwECG+20BlRZd9bm4XDWqBoK9uTf/mu4BZP0m9kR
         CviNqZ7VyLaqXe6BHWb/R25StfEwJcKVxoR26LldBmNSMuInXrdt0RXnxalKfEhES0KC
         QNBdEDeimM5phqZXBfV/5urEl7GxmxVynuEhZSxSNu/stVD8DdHVZ0lSepRku+qKlQJS
         O/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065425; x=1783670225;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yJhLwAuRQ39oUEKAohufcXKhiNT2bhqWZWs88GxXtU=;
        b=OgPtXPnLAErbGw8svnUzMuBMLErJjOTLbwf7o4B10MU6PE8o95dw0PplhEvLIPRgd7
         3TrG0ReRs6cBc7Q1OxNZRCrt4CbwU+5k3TAhaqOErXzViQr//5h/9RnWQ2K4uJpKe7KA
         T2DByAIfo9LyPJLDyOf3VVDDBC1X0UsVgeeG5XRl8yBZoEE4TrOII0Og1HJdFnHAFJb/
         C+YzcFLbTmyy1RsM9jMzVR2ugB1lcW08Y3z1W7pZi5yzbN6nEVnVrqDzyPXujkxE0k7l
         vpi0n2MRsCln/jaNJJbjYJ8MtdxLybDiknR4tZaIKRwXHWIM4ETTWF7rovHQzVr9K9EZ
         YnKA==
X-Forwarded-Encrypted: i=1; AHgh+RpZvSAZVNjavlHYHZR3u+FZjYZBJ1RnlZu5BacmeR2YnCghbylzbuVTrI7nKPc5V10A52w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTclLo6A8tLIrzVDYk7zhNILe+rIBYNIBF6amJYpsdTBsnzGR
	0eKo5/cfP9wsOKy8pA68Oqb4Ztrb6zKEZ6kQ++K6q/TKegjsmcKppf3vn5xynxr6SBA=
X-Gm-Gg: AfdE7ckrvsgMenbgoOxvswP8msO6zo/sZxeviLVCu45EfDsvzXCzotgKqZWyheRgl4l
	8F7kjTkwUHW/yTykyrvAqsCXngcsJ0XdKIVSHTcW5knFq/Cpk80TyzdZGv/94jh+mA98xgZj/6h
	UqL1AGaJUW1LeetMyfakmPPMrbeo5dDhq609PWm9B5lkWpLm2AzwOasGBF086LPos1ah0STu9Vv
	VFFYsE0ZHTBoK5C1ZI5lKOa3NI28lVYh15AhRHT66X01+bd/rSGcCJxh5Uy7ONpSxnLDK6pF5pI
	vyOlr6+TZX8i1GNSRmmzf3sL46PLxaC2s1RKW+j8C/hiLjRgjgOomsrzSLjQcMLeIgDazTlw+vy
	Ne97MtXWWM4wgNqNPFQl9cqayEAirhmGQRk05NIUt2KtkOuiXXovaVECdLQAaLQXRdzGOm+TcH6
	bzerU6dForwdsdU+OYVUmK8DkYZA==
X-Received: by 2002:adf:e5cd:0:b0:474:83d4:9916 with SMTP id ffacd0b85a97d-4775a2efc07mr11580909f8f.17.1783065425388;
        Fri, 03 Jul 2026 00:57:05 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477d766e0b4sm15094509f8f.0.2026.07.03.00.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:57:05 -0700 (PDT)
Message-ID: <15b253e2-1a2c-46b2-abe2-bf152d704523@suse.com>
Date: Fri, 3 Jul 2026 10:57:01 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, xiaoyao.li@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260522034128.3144354-16-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/26 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Enable the TDX Quoting feature via TDH.SYS.CONFIG when supported by the
> TDX module.
> 
> The TDX Quoting extension generates TDX attestation Quotes via a
> SEAMCALL, without using a discrete Quoting engine.
"Quoting engine" is a new term, introduced here, better say "without 
involvement from the VMM"

<snip>
