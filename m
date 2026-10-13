Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803994F5DFD
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893603; cv=none; b=f9PmANNCTssux/DRnOKyMkw/zp4DNKDO5PHSm0NYTbmvPzlMxkbS5eJQiU25TJEjTdePD/RMGpupZDKocbUvBri929IZnkdG0InctBQfcFuc2BOHPqKyex2Xemk9A08cpPtHjSHCwoUjz/1078l4xUOv2qmruKQhE3kddeteEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893603; c=relaxed/simple;
	bh=GmewS9MX/pMt0TQtYhdFbnW64zOueYVprrsOA812m8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz0o0vyD94hH88lCcvrhkg+HLM/iEl2kMMshSUK1AvPGW11JvROyaZdNbOIbaomiXmUqGZ1KuM5+R/Tz79jdZUpvtagoaTFdV9Zlbh4sgkuoifaUV5owoeSnoBfVpPg1lGSPm83okAJ4OKS5KUu/aHhoZcxZkcBpxSkD7oeW2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4mdUKVv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4mdUKVv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-486e70f2457so1259812f8f.2
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791893600; x=1792498400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edUU9Hn3hyFtM1ngJWHa9pnhQIwExXlb5OPfjcFEs1c=;
        b=e4mdUKVvX2QFZFAqZhyS3XKWTDGe5WE/vFc9b8SavFE6tFHsNpAMveofzH8UIR7X6W
         BUQhPA2FVNP/q7kIY04R3J3S+YgzWfbdD+5GHDag8pGQ92byF9roQhOM38qHvri3NPNm
         5AWBqxNNVhTLNX4r/hJtnA4OuoV90f2yFjInaMMXjTvg0hyJ+MBF+xoeWyXXhyqh4MW0
         RutMB6IiwwjaZHWbUOi/fjrCFsBfwlTcMkHdlfBHnEPrPocoW+CuehAmVuPZ9oXJ+N7X
         NdrHeBqQMG5rW+2FP92Oek8Smiu7aLM7AGhIXuDUNIaRS9Jlk4idLSh8aelDhfHD5fLh
         188A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893600; x=1792498400;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=edUU9Hn3hyFtM1ngJWHa9pnhQIwExXlb5OPfjcFEs1c=;
        b=ch5qkdEoJKCqPC+WJ/jE10REo4MKBY6oppg5kCsfydq+1Y4w0FgnNxUFp3eV0mqRv1
         zSdcwpn//Y8hEDznxRHI9rzwoXSZE6xL4kOZZ3iysHfGtJCfmomwM1V4vn6AQl+89I/J
         Gc/x2SBQEloN/JAbzweXWCQyoDetE+EApqp36H/y46zR94noNM2YimUDGXUhsZ6TBouK
         rOIdrPaXY15+o5UwQdNSoBZsKn397pS9sZQBF5R1AF/n/K90ruSvjAjiKFKp/4GY5Epx
         c7Y6ELdaKBSWB1u0SygSa6WacLSUNwYd4H0GYZw1Ko3UHJ1UzoweXvST3xqezQWkI9CZ
         83vg==
X-Forwarded-Encrypted: i=1; AKwUvBy5PPtXIR5Z6sCq8oByrEM8Zsb9K99Zhss0FiNLULKC45rBM8q3nSj3+1zjZG544qYFivs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeJvMnY5L3AFoliujld0xXRVpk47PxA/UflmPsf4oawrKoh2FF
	0jg0sWmhPUrg3XVVT7CAzn25ht3MGltj+HMWQVuEKo0vIQC4YZBpJWc1KRCfRWNYRk8=
X-Gm-Gg: AYBFou1i3I+q206OkXQs7Jl477O0UNZiL/yg/ctLuQuQJLqEPZbso4TM8SGiTFg1lnX
	Vc171A5VFIGRnhOrkxpCnlbEGt3AlfmqKrQLcT/uGQJcnF9JNUT7GLXH9ie0UJZ3JaktzIDU1/8
	VvKDpYszDtmAcJQyyQDL3lPQoWf8tTYmbvULh8qJR4cGv0sYyUU1YMYnxaC/ozatYzzx+uteQ4B
	nclCAzxipfks7BdUMDXkfArIgpWKW1zBbkXZPc1iz9v/Sm9VnrzuX1tXlpcWZHEBFLAFPAyAuvw
	2k43LGSx1ubc8/iovd/Z1jefKim9mL3tqHKUD+LgNpSrvYj7Xsq3k7kFjVSjN1rPzdZi87fvXvL
	TD9+AgzekfOZ/9ro5mZ1k0Lp9UHLKK0kr2mCcH3/mAloXoMWkYNOSHrYs/uR/N26daH6A4NO5JP
	zm6+V+xCoveR7l0WRA1lTbmJ0ACJSPF173dtSe0ec4cOZQMUYZHeoCX9fHu26RBP6jTklKyrqqw
	klyXlIHYOEhQG4TNEKljlU=
X-Received: by 2002:a05:6000:491c:b0:488:8751:e78e with SMTP id ffacd0b85a97d-48dba9bdd09mr25645157f8f.16.1791893599634;
        Tue, 13 Oct 2026 05:13:19 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5991sm5087349f8f.29.2026.10.13.05.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 05:13:19 -0700 (PDT)
Message-ID: <69fb13b5-857c-4819-bc8a-b87d1e7a1e28@suse.com>
Date: Tue, 13 Oct 2026 15:13:17 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
To: Vishal Verma <vishal.l.verma@intel.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6.10.26 г. 1:50 ч., Vishal Verma wrote:
> Background
> ==========
> 
> TDX guests have early_printk support, but it is through a roundabout way
> using a #VE exception as a functional mechanism. The exception handler
> has to use TDG.VP.VEINFO.GET to find out what faulted, and then issue
> the TDVMCALL. Simplify this by using a TDVMCALL from the guest which can
> directly perform the port I/O.
> 
> Patch details
> =============
> 
> Patch 1 is a cleanup that moves the port I/O direction constants to
> arch/x86/include/asm/shared/tdx.h.
> 
> Patch 2: Add a new earlyprintk=tdx option, which calls the new
> tdx_serial_in() / tdx_serial_out() helpers to perform the port I/O
> directly using TDVMCALLs.
> 
> The serial earlyprintk path is left as is - TD guests using this will
> still take a #VE exception, and the exception handler will perform the
> I/O.
> 
> Testing
> =======
> 
> Added a counter for the number of COM1 port I/O #VEs handled:
> 
>    no earlyprintk     -  ~63000
>    earlyprintk=ttyS0  -  ~61000
>    earlyprintk=tdx    -  ~35000
> 
> The new tdx option nearly halves the number of #VEs handled.
> 
> Additionally, ran the usual suite of CI testing, which covers KVM self
> tests, KVM unit tests, and Avocado KVM tests without any regressions.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
> Changes in v4:
> - Rename the tdx_inb()/tdx_outb() helpers directly to the serial
>    accessors with __noendbr annotations, and remove the config ifdefs
>    from early_printk.c. (Kiryl)
> - Rebase to v7.3-rc6
> - Link to v3: https://patch.msgid.link/20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com
> 
> Changes in v3:
> - Drop the ttySN and baudrate option parsing for earlyprintk=tdx (Dave Hansen)
> - Link to v2: https://patch.msgid.link/20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com
> 
> Changes in v2:
> - Rebase to v7.3-rc4
> - Move the TDX hypercall helpers into coco/tdx/tdx.c (Kiryl)
> - Add a new earlyprintk=tdx option that implements the direct TDVMCALL
>    path (Dave Hansen)
> - Link to v1: https://patch.msgid.link/20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com
> 
> ---
> Vishal Verma (2):
>        x86/tdx: Move port I/O definitions to a shared header
>        x86/early_printk: Add earlyprintk=tdx to drive the UART with TDVMCALLs
> 
>   Documentation/admin-guide/kernel-parameters.txt |  8 ++++++
>   arch/x86/include/asm/shared/tdx.h               |  6 ++++
>   arch/x86/include/asm/tdx.h                      |  4 +++
>   arch/x86/boot/compressed/tdx.c                  |  4 +--
>   arch/x86/coco/tdx/tdx.c                         | 37 +++++++++++++++++++++----
>   arch/x86/kernel/early_printk.c                  | 20 +++++++++++++
>   6 files changed, 71 insertions(+), 8 deletions(-)
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2
> 
> Best regards,
> --
> Vishal Verma <vishal.l.verma@intel.com>
> 
> 

For the whole series :

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


