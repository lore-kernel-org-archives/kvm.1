Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E0488233
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164716; cv=none; b=I796UHIK2eKyh2MMCoySQODI8SPapgJbiNDEZgi6EfTz+LcJGQQ9tNQZNxg3Mrsdc3MiAOEAN+Fh/NRQvqDs11WCSdNUdQ5UT3+p5qXA5S6mcWHGJfRlGENjGhkvQCH5w7Ppomn4yx10kJA0Qq+02piKYa5vykKTy1sy/VcBNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164716; c=relaxed/simple;
	bh=rnqsZPXYSagqFKkg9Q69pwDVeCIBpS3jc/teWefmvTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTQBuQQMdORAZFtZtBRW46CIz7flNhcD5RG42stlob/E0dRzaWMj5T8zPEnRPKLKzh7+nFWahDiojis91UpdvagyjaO2/dX72I20RHcBNpKg4ZcbInuQAqzxtQEf2jiTtDV2Xy4fvq+2x3h7Bfh+th9Yrp+guJNgCZZXwGtWLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G6VFAUPn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G6VFAUPn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so5480175e9.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790164708; x=1790769508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9A8wYxIVGsH10Bdo4rxzJQUGF4dm75Ur8pO9nrlugsQ=;
        b=G6VFAUPnqz622uxutLI4S2RoJH+fIgyr0FqlVMc4SKBOh370ALNrWEu+yTllH4lLUm
         ydY8vSOyCpyvqaiM/FCMOZeKOnWHm/n9tC1jw+6vqOr87Arrv8/8UprIEquErGFagcKz
         vOWmmo2jiWT06/r7jMM4QDC087dx77wsnWKBsK7sUPgLWt3mh+2GGSdNWk3brVS/L5sE
         vE5LbPR8K2cx1WuKdYwRoYpk8IjxCpeLGTdVvjMjov9dr7mTADRxy/Ttuoskm1d9JdLx
         ItaPLgoAh2ctiNnVOmupUxb59U7sLhQI6rJHre2bwKpRWuxtt9w8NZl6nB4L1ylKAggc
         Vc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164708; x=1790769508;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9A8wYxIVGsH10Bdo4rxzJQUGF4dm75Ur8pO9nrlugsQ=;
        b=rPqDsSs+nPe8TV44vJ9q8ipC7zVj23W0wFKntPHM/lOQ1OE0/Vjafr9n2PUeNSfyR3
         LuyVv4rXuY/NbRn2Ru/YWU0DtAS7fDHF+cNiWJRG8Y/B1mwwd7JroDncdT/8Va1+tBS8
         BuxZ86gWEexcTMTX3CQGzvBJT6L5XwevReP6UURdtegVB0uISrsZvblNOSjwAVzKH67B
         ZAv9eq1/lWSVPRFjJqw+MoQzOO9fF9LebYxn3cr0OZHQiV/bhKfb075HvxoCcujek0Pr
         Ne2db4A/I6lfkdiDp1lHPgc5AntEgqwCzpl9BOhaa7WUsxGB9u8Gqn21UMWyjB2GNNmC
         J0JA==
X-Forwarded-Encrypted: i=1; AKwUvByVLaIauzLDKDbC94DK7JTiP0lt2Y6x0LFSJ+2vhdONOwVVeIFcUchJ6ul4o/uQFa42NeA=@vger.kernel.org
X-Gm-Message-State: AFuF++l6kG7ogLi0lGBHzoX90lgHCBrSu0BBBqJDmymcBQK6LpBNGM1E
	TK0pf9oHzey+DocYNtlIisy+bUUU4wi6Xg83UxRLP5WF+E2BBKb3u1VsMA1pFo3BDOI=
X-Gm-Gg: AYBFou0ZTxLSRMBtuk7klJ9ytvDFCfvgxCHsOlyPHBfrmpvcBUtMwaj9zOYHyASNwLd
	QLjp1Tnd/PUTE9oR4yPvHxR9Wc06bKVA1Uci/qB7Osv0d9WNq5vz8V8y6VpCgnXpS3KzWshfKZQ
	Fiwy6uqhfTNftDBaZ7E6xN3lMmSH604Psy3P0ZlVnolYLJ84eZYLjuzUNrE667sUozjpgFabgCU
	wOyILD60VyX5+xQSPrq7CF0ohjVe+P0XbqfGxBr6GbNoqEPSokdboXPUJM3zjmJKaLH3su2RxOW
	prdNRc+wxz7bo5sKCN/w99OqoVAxSz3uwImTMaqerHAgJxpggZpQA3hn82rXeABTaf5VA+Shljs
	S0seBmce2YMRd0wilQNvD8MfNX9dp/zzhTDggUd/L5UPUo3iE/bjn27oA61krJOeM/qqebAx/qP
	L3N+it6kBWjFFURR2Ts3a7gzq+Uy0Cco6/5qPZZfhCl/Yf5C4OPvedrTy6D3oSB8shqaDHuwDBz
	PDhXvf0xVWbifvAH9e4x28=
X-Received: by 2002:a05:600c:1f90:b0:49d:1de5:ce0a with SMTP id 5b1f17b1804b1-49fdf0f93a4mr28227655e9.13.1790164708556;
        Wed, 23 Sep 2026 04:58:28 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c64dsm6585044f8f.21.2026.09.23.04.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:58:28 -0700 (PDT)
Message-ID: <86d0237e-80a5-4592-8e34-67960de70d8f@suse.com>
Date: Wed, 23 Sep 2026 14:58:26 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, pbonzini@redhat.com,
 dave.hansen@intel.com, seanjc@google.com, x86@kernel.org, kas@kernel.org,
 adrian.hunter@intel.com, yan.y.zhao@intel.com, binbin.wu@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260922205215.870563-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.09.26 г. 23:52 ч., Rick Edgecombe wrote:
> The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
> requires some memory to be flushed from the cache before being handed
> to the TDX module.
> 
> During the initial TDX upstreaming, it was decided it would be simplest
> to just always flush in these cases, rather than checking for the bit and
> having conditional logic. So currently the kernel flushes in several
> places when handing memory to the TDX module.
> 
> In practice this bit has never been set by any TDX module, so flushing
> is unneeded. Going forward the TDX docs will be updated to clarify that
> CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.
> 
> So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
> handling.
> 
> AI was used to review the change.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>


The code change itself is trivial, however nothing in the code being 
removed is tied to CLFLUSH_BEFORE_ALLOC directly. And from the changelog 
it's not entirely clear which those operations are (as per other 
reviewers feedback). Looking at the TDX module spec that flag is 
mentioned in relation to the following 3 operations:

TDH.MEM.SEPT.ADD
TDH.MEM.PAGE.ADD
TDH.MEM.PAGE.AUG

Whereas the patch also removes flushing from MNG_CREATE/VP_ADDCX/MNG_ADDCX


So concrete references in the changelog would be much appreciated i.e 
whether flushing for those 3 additional functions was because people 
were overzealous, or they simply have been omitted from the public 
documentation.
