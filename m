Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586384;
	b=nKtuenrv6tUe11CFeqyYVXS142nKju9dGhSjl2FrC/2p1b09dzHEz+iV4tU/SU7W/u7w
	 SIYbCYYbWkw15o0yJx6m4K/NQX6Jh9JS2JP93rxhqHTbW5Pg3ShUsfZpmAMQPd0aMd+OC
	 zSzVGWqs9hRzmFWgS056yDnBZiR6N92jwjDizM0k84NmEFKuiBNSmrvWQQJu8UBtDO8zx
	 QPAlM3NmmxzKkkfwyz+68ptuyqwmGOYFJFsAjN5CS2AjJ1zD0pfR/UnL9+CwI2xpF7Y8E
	 d1SQWEZdyu65xc/OMSx0ooSrlZB/FdLXdHl6pPW7yZkZ4jLYdronH/3AE6o56/7bFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uBhj5ZT/wKvt1cB2ZHQUyu1GVRILA+V8UDZgyKlKW6A=;
	b=dKqgqrvIYIuPdFXh1fqG+fHicSjoAnXaaYyt+7sBDyKB3QL/8JB11X32iRBfqjEwq+6e
	 k6Ivtb726hd3frhNNqQzUIOzgC5UbrzLGEnBt9WmYAaRjL8Wo9aw05DB0ldJ8Oskl5SoX
	 daqg/FGbKHrqZ+bC4Xw5hUU0EcaQbH/dRpG6fRU0QXzb9cmfAD4mIm7jhOUg0hOCnDzgx
	 khFwvr4MP7YXaMfYX9TRMFgR6GIJDguqBw6OhrHjGp0SWlN/D5XbNBYvugxT6rkmjDYEX
	 awzKRVUzJ2+gb0QTZUUqQpNhLH7vl2tpJWsM4K8RtuF/AkO5wOZj36M1zGrOLjjvddw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JQmTVlP5;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B7606A891
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4B7606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JQmTVlP5
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491d1f66968so411095f8f.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794586382; x=1795191182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uBhj5ZT/wKvt1cB2ZHQUyu1GVRILA+V8UDZgyKlKW6A=;
        b=JQmTVlP5ZiOlcIc2zz9AksAjuPn3HqjHFW2kgua0zm1wzf4QbyCXiuiBpN+yZ7/ol8
         x+UJ7CPdzLaeTEp2lvexusQZ5FW5Dv0k+uylRLINRYqC6dXwRhepupWQh6lWVLPXmTUb
         WmtNOu2iUUxAEIn7F8WNFrmBJtChzh3sXDL1jO+s4EEsyfAzM12p6jK5W2Bi6wtFv3QC
         QcJUrLa4a+JRdYSSh9m4x/fVbaD5OLuxKGGu01Vb6BmwDmvbAwaOYIc+0SHm3gwryLfs
         aRzZvuSe0D8ixpqxbasc+kBpCgJMlPqUKj/FjajSX2CWRZb13rCJu+QrzgXEmHT5H7Ln
         UQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586382; x=1795191182;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uBhj5ZT/wKvt1cB2ZHQUyu1GVRILA+V8UDZgyKlKW6A=;
        b=DPZW1TeVS8mcLbsrnphwScrWWFqyT3N/MfsK7SM7rlTfMUjbBMkzwvz8a5u0qDt8Uu
         gOWn9Ogdpg9KwAt48OAVB4iZGbJID5oqaWQITAbzlSNkreDgRKNfxhoE6znS6NQx3G4S
         ApxtbPbfnyksBtC5XD6H1v8ZFY2ghIWafOcfxGkK7L12NtP0EdEkxqKO1gInCr+oO+R1
         /xQ4J6uB0xz4cVr2UJG7hE1m4WnyBYTGhacz2E2nLdMdCk8/h35ZEIJUrIetm1c1a1P2
         M8dlwlT1MkXZ6AvIImjQtZSqIgoW47482BAS3AFNjM6VhQQAh7uEmWa4HrN/OuD8GBPA
         TIrg==
X-Forwarded-Encrypted: i=1; AL+hErGYtlccOL7tmGsViv8nxht5xSm8RG9NJYW3IRasa1DXCw1iOATRkERbGhcERy2O7xMgkTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z883AsWqGiNmYfuMCOr9unzyUUivIsp5S36T7OPm1XLMNHw6uCE
	PRsEkc57WDvW9L/GSXaehVuYhVrB/vV10eMo9J/4EaDCnJW0rfkxz3t5NhzFfJGHnIMvWkhYT2Z
	Wt5cblMA=
X-Gm-Gg: AYBFou3dNAdKUwRMfTw2uuv+QG5PpKPpKe08rFoHH6gNm1LTdrSAew26B0KYM0mS9SI
	qw76XP+PP26BgR0Un2fo1yPEY9gsykiSBfewTJ5Alr+WZLrNeNaUw/VRmwTvCaaBFyJK9I0gCwi
	mBEjSEBDa+hDEriCMRXaE72ORY+TyssO4CdCtfPKM/C9BmC6UvuS5GOfnmok/WszrqcZzhQSfzK
	SSBoDGiUBKlIF0EDorY3ItPLq+ZavL8uXj7MaisEfncwsgnVsm0goKReOfEkJqAvwhgtd7sWAhQ
	gXcBaXs6cvMmS4Bsmxms1iwV+YZyibGHsFn2800K1Hu50wobx8MVCiqlxNrZXor/rmKZfhShz29
	Ix1XPXds6qxC5UGhI3lw5iNa48hbCNoYUG7vealvm3X6EkEcQWAabbIp9mlLc2ZIOhTJb7lgWRG
	mMeu6C1O73AnJb2pdpkLuZ1Hza/LBf5gdWTdeiKfxS+5dN1nGo21R5puVVIpJxCaLoi9HeImEr3
	9GaZUPnNq92d4vcv8oHKldFyFQ2IvD7tCxii5P16QVwJvsRRGmIa1kJXGjFacpbsr2vsGqzmAfC
	J46W5Y0C/xkhv10wlas1uTgkRD81O3QE
X-Received: by 2002:a05:6000:480e:b0:493:f3f2:2255 with SMTP id ffacd0b85a97d-49c70542714mr6244595f8f.25.1794586382025;
        Fri, 13 Nov 2026 08:13:02 -0800 (PST)
Received: from [192.168.0.20] ([212.21.133.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c607d12c4sm5658167f8f.41.2026.11.13.08.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:13:01 -0800 (PST)
Message-ID: <8826c56d-8fa2-407d-8362-3edd8c281cd9@suse.com>
Date: Fri, 13 Nov 2026 18:13:00 +0200
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
Subject: Re: [PATCH v5 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
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
 <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.26 г. 5:48 ч., Xu Yilun wrote:
> Continue fleshing out the extension initialization process. At this
> point the kernel has provided all memory and the TDX module is ready to
> initialize the extensions on the memory.
> 
> Initialize TDX module extensions via TDH.EXT.INIT. This process takes on
> the order of 100's of milliseconds, during which the TDX module loads
> its internal extension image into this memory and builds the execution
> environment. Once initialized, those add-on features can use their
> SEAMCALL leafs normally.
> 
> Note that TDH.EXT.INIT builds all configured extensions. The SEAMCALL
> leaf fails if any extension fails to initialize. The kernel does simple
> error handling - just fails the whole TDX initialization on any error.
> This is OK cause all extensions are considered necessary for security.
> If a nice-to-have extension appears in the future, this can be
> revisited. A potential solution is to have a new metadata field
> indicating which extensions get enabled/failed, then the kernel decides
> whether to continue or abort.
> 
> The original changelog was written by hand. AI was used to help correct
> grammatical errors and polish individual sentences for better
> readability.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
