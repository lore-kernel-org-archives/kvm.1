Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C449BD68
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398994; cv=none; b=M8wLCjDrWq6iL+bGHmtd79Wqs6drTPOHZePy6UYNCPp+sBHi+LpgbpYh9toO6V9KAxl90KcgTwPuxinvNxMjyg10BNnvnYymVF5VPD4zkJY8BTZvpu60h5xlv1IydxqGuNrsp+r1PPW19lpakYrjyPQZ0pimc9XtuptICq9lsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398994; c=relaxed/simple;
	bh=jvkufMnCK6+TM5rFnqnL5STcZrtz2K0CE+9TJJWhtBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j2RgCvbJEUmQ8lLFWS/wBeLgCM1R0ZPAMMz+zn2b6W6fR6XYXaPIOhg8QyTud6xXIkOJCcXeWq2dUP3zn5OLor5l+cH/mPO7LM7MA6axbfTMgUJ6LoeMniGrrrXe68Gas6KFwtLjwZMUDHFjcETfC9dvsbTWFuDXRPnjQCwUJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cX7DQ13r; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cX7DQ13r"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so15941365e9.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792398990; x=1793003790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtSEnTlxA2nqz5Q8OG2vIxpnNZg4DAWIVYR0RBOqUDg=;
        b=cX7DQ13rXYNXNKuN8ekqSwas+ptQWa64k80/x++MivC0h7t9NjXAQkmJw8+UJL/i9j
         t9HWPC3trNU/VszmpXjr/3VMGkOD+jRx5pLkTikUwUknfGrzbUCk9/gHKvn+jZFZFssE
         bQ1xxvqMFOKzmeErG9fSo+gOjEmAupn3y2CSe15E5a1R26Xo8oCL5PMRxWD1/H13L2Ow
         efKH9vbGNm8A++cTjCdRuH04agRso/MwLuJFOTbKmj/A0BrvgrEWzmWhuGjJc5jUNscs
         xNhowurVMnrLVCW8R3jt6FUNKCri7pIrJs+FpJXASGNSr97wyDetas6Qzao0cDBXpLZq
         0IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398990; x=1793003790;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtSEnTlxA2nqz5Q8OG2vIxpnNZg4DAWIVYR0RBOqUDg=;
        b=2HdkQpTtDCJ6ghtmskJbbcwYniQjXUYOxzOAxKZx4jXTXXCHkcO0sFQT9aUUiaEdun
         /L3TYlsRqiZ6AhWYtuZrwLjdYMHhrSDBr6Ok87iWXFtj7jweN2KZITN1mUO2MhU7BbWz
         fY6/8WRbg4mAJu9XuVjjkwTPkx/dAG/QwwD4ZgB940NNBBey64uRwkDV/vyYfXzBYS4D
         T833tnmtxneMdi6f2kyUgKjNw5N5u4KSMgGWJGi/d1I7xipZo1PFRG91nqpcnVbVV0C3
         h3MVdp+X/GisrTES9KZgiGkXzR1PigytlSELx1OGz88ANpQXqakCcd0veOS7kNWvKVgN
         FdKg==
X-Forwarded-Encrypted: i=1; AKwUvByKiY1ePTeT8i3sUQFPM8AWhVRCoPkW9C6N9WRM0s+8PY5LHu3a9h1qr8ZPirP28W45Qy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV6r0NZ+7QaJydGHYhwIijabE80pftRba0D/yIn9cmfV6y3QFL
	GtuecQw54zvfEp5xbzePI4/zETWNepiqNINoDvJQxLLVaU7mCXuiKO2bYcitMUeR7XA=
X-Gm-Gg: AYBFou2Vik+inRgqERUkv96GWB53n4VshOOvlmGQK4qW/kuVkpGXj5/Gr+mZEChG1Ia
	REmPu96laJEjEz9zQwOIrZegOht+RyJrZJybig6wBEw7lOBeNWPai46g0px8Xj9jqKyChncP/BE
	c4503oMiV1ciDcK5dGFy5fyuFj6vrQbcTx0SzdHlQjxgLPsVjW8rx6PWJfTDCgsf29UjUBeKlLa
	WxSUKHWyPU7rMJVOkjTv+ipkfxTu/ykItz9A+lVxbOx5M889s1yMqNcm1RVhoHAcVqXKcR1PTsf
	fJ9iE8yOfekBhybfC60sN5PIHa+n+H5fb9zW8/MtQ9sm87+XgWN2TFjvULnNOyexjSSbML2B4ir
	ormPK+p+HonCc7siaGhoAZtrlHnhkWngBZEpZVOQrTRGdAU07HXdpRpQevos78QNhv00EitonwN
	g0xqCagZbL0YQFhaYOLc8oXvMIUvEENUZKnE2uYbkm+nB54EDCIlQ3vSI6WxOdhKLAN1ZS3M1v/
	rDDN13t4QEwepAjMlDX68Mk
X-Received: by 2002:a05:600c:6994:b0:4a1:e11f:b2ec with SMTP id 5b1f17b1804b1-4a1e11fc152mr98694355e9.3.1792398990053;
        Mon, 19 Oct 2026 01:36:30 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ebeccda5sm29801375e9.3.2026.10.19.01.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 01:36:29 -0700 (PDT)
Message-ID: <a6d14650-b978-4256-9874-61cd1c986411@suse.com>
Date: Mon, 19 Oct 2026 11:36:28 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Drop unneeded cache flushing
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, pbonzini@redhat.com,
 dave.hansen@intel.com, seanjc@google.com, x86@kernel.org, kas@kernel.org,
 adrian.hunter@intel.com, yan.y.zhao@intel.com, binbin.wu@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com, tony.lindgren@linux.intel.com
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.10.26 г. 22:17 ч., Rick Edgecombe wrote:
> Hi TDX developers,
> 
> Can I get another round of review before we ask Dave and Sean to look at
> it? I'd like to pick up a few more RB tags.

<snip>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


