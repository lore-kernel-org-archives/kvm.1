Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED93BB116
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564176; cv=none; b=b7F5LCwBK/gPcDM2vlQv17NeQ+kg/YFie/7xmTk/3aqUj/i2sSnhFHzcamfSy4FjYP4NK0rk9v7F8ht9udq3+mVGGfG/DULtHAaUaYyGqkMp+QmFS5s2Wl7uLj7/84OxhnA+lWwkzvD/CV5V4HRI8THBR8PAmeSs4BqMHWJyD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564176; c=relaxed/simple;
	bh=bDkXPecrv7ZD+FnW3wIO2Ni0wOvcPxYqaM51+iZCSsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvZCWA1UvISp4dG9Mpq4RdzZDJZxl7dDYCSV4ddTUrl2T0SFPGUQZSkBPzdN+m+j8f56kgISgjLCr7r9yz+TxrTRCRJ4DDcB5J0xp6AS6UoaLZ2rJZY33ZQDYqVGE+bOhYRrr3RyxZyDHlo17EAHp5K6ytVjxVDui14y7L0RTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8HaN0Cn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8HaN0Cn"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423610ec93so3273994b3a.2
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781564174; x=1782168974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVwv2TVfPysI3DzUdG8f9hUqz0gPu0HPnolOP2DEioU=;
        b=H8HaN0CncxAG7X855lzwTAVlZ9eW/ymwNWXHfB/ykA1mLhC9gSdgPLpooPuaGcLRIe
         mgZ5gIzjmQAbkK4eW+N2VqEys1k33VSnUDDMnaHBPyq889Al323Rbs6flbIPwtVm4L4F
         GQMaWagDQCU/7DHpeCqoJ2UglNCDS0oupTYbJAY3Gj7YSybYPs6rRrYmJkWyftTPnbBd
         ctF6xjNG22vmz9Atb/ENmeQvwLTf03/9FYccirRziUZ0qd07lAh4kl2SeokWDpnDpfSH
         A41QNMOsebevvBHWihskDgvL0Ja0sgz5/bskl/8RyjovfWywkXBShLXW9fOd2ALMZcST
         Idbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781564174; x=1782168974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVwv2TVfPysI3DzUdG8f9hUqz0gPu0HPnolOP2DEioU=;
        b=O3nXz/uWQnMQbPJB33Pbic/wka9KTCQfr4UHMz80Hi3LONTUlnY4AhD0yjoJcwz+jf
         ++xtpr16slCIjd+GvphbR6gJWAx+WywQDiLTzpy4vrKu/z2B5mK+pSIg5UQsmqwqiWwE
         C85aXimX2VZx8ViqucQbVc4k07h/0+EGUeVHFpcXODvjZYLxfxz4Q59dTqa8zh7qYGm3
         WCO3S7JC+0j47iF51DRS3puOdpGlZ4OJL4iOVtHR3AXJUn5npt5UIXfOBgf6NinLncwB
         tNcluUZlT9wCWX5RjoLjM2bzmLi+Bw8nIQ0uAQQwFMUoZpsvVpHmyMgGA1xi16y+0qsz
         xxoA==
X-Forwarded-Encrypted: i=1; AFNElJ/yXzl+8y/YrzwrWeoT17yjyyDKa+eTiHwlBh8Yq+y6zhceOd47w5dl1Fin+jYeAk2tPL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsXmg1ynhseGSFbsMfV9HpC+f12IeukWzWTIxQOUqRUOchN+U
	7zQ2C9lVURurscVqw9a8fE8QiGQeZFbtwHLXptpv/mKNR0VAmyReZbxoIMIEctRraQ==
X-Gm-Gg: Acq92OF2H+uPAqkBufjAvohJ0av/DjQ+BmUQkIdTE3/3bVDTH8vqyoq23aOaZYH/4s3
	j6mNtqaUU8iW65SG3s1D3mnhz0Q3zv6fWfoEQhxH+liIy0lGujT0wSG+7A+v9ZT7zOYbinOQcQj
	680g999PpamRZkqowsGH0mNU+uKZUEWGFrqNfL236hQgLVq5PurYcGTDO2y+lbXo561bKGVQjyL
	mKeBwuBNKN/o4ABXZD6toriMPCpzqVAyW+02nCtaLSz1NAlH27xv3x/0LD1wcwYzFk+eoEwHue0
	+dz37KFObcXOvEueTXhrDl8vgpc3eRUUx4ToGtRAe146jZ/mGnfxXo5MF9Qa5rueqPqpNOTajX2
	3CWHLn1NYFrczTrTaRbwhnYg3mJF02ZNm+JjsH4EBDvoEnKtSB34bDPElWV3TCGpxBkXWheDDn/
	cGN4u3oz+aPrudbnhvVGXwBjkcpiH1zOPU9FwznltaSy0DazfNNvTPi3DF01n5lA==
X-Received: by 2002:a05:6a00:3927:b0:842:6004:3fce with SMTP id d2e1a72fcca58-845155f7ba7mr756200b3a.26.1781564173161;
        Mon, 15 Jun 2026 15:56:13 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9df57sm11362003b3a.7.2026.06.15.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:56:12 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:56:09 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] vfio: selftests: Avoid VLAs
Message-ID: <ajCDCdoCqPIqB27h@google.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
 <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-2-b3798415c72a@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-2-b3798415c72a@fb.com>

On 2026-06-15 12:44 PM, Alex Mastro wrote:
> Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
> rejects initialized VLAs with:
> 
>   error: variable-sized object may not be initialized
> 
> The replaced stack u8 arrays also do not guarantee native struct alignment
> for the aliased pointers.
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
> Assisted-by: Codex:gpt-5.5-high
> Reviewed-by: Vipin Sharma <vipinsh@google.com>
> Signed-off-by: Alex Mastro <amastro@fb.com>

Reviewed-by: David Matlack <dmatlack@google.com>
