Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700196;
	b=UmIgRY82Ku33fNXWwOIv7JQ4nE2/ZRwIcSmsI4Zp8Jr9MMKVrygy/Z52P/BlDycg9W/L
	 Rqnisik7oJSJmVyyZQyP3+hg3bbJgKTia1gcnhur+Q+ExO+sBuCYhbeG8P3nokgo8Cz0G
	 eQqwskv8fI8L3JtP5v74dCk9n8xApX6DLHgMMW9ETIJvMWNwlPnEZ1906FL325vaZJh+H
	 QnO90aHhaiddkGXPqQFxR7eLJ5exYxOcMjsLXfdEl1t8uV+WoPZQaqpA0ooFZ0HOohO2d
	 wvPVJqTsL7s0SaHkICtGNRhnW+qkSSJJ8h/YCei4FPRwdf0m7lT+I8/DL88bU4XIDzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LEg0SrmO/VhGhY9o8Sggz15O+9RUdwZIrLUomDbcYAw=;
	b=UeuGTXe6BlRPZ8B60XqXxLYpkh8r4ViwGBPfuQeZvRETV1HdcrjspCsv4hHKaLL1U4dw
	 DpLWzwOtYQobHZH8ugqjpHnBaMKEaOTl4pLuXpVe5pSdt0/drhggUix/cpq0VPj10xRha
	 O6Rp3cdoH05A/bepnzB49YMd4qaEP8A+t6XRwYy1jWg8SsqW1DN3xDueV9uoI2yCO4jSa
	 Q49uhe/f8B/epq7K6T78mnL51AhnTeivuRMk7uE/bcE0E2S7Pf7N2JfbsiRiR8UqnvzNx
	 Mao9seuKWW1HlyZ0fc044svrGlxsquXGSoXWbUEXs2VyteSxSGujQunJMzokOVU6a2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b="Wc/5StHW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F239606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 10:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F239606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=Wc/5StHW
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dd4f3f696aso1863741eaf.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 02:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793700195; cv=none;
        d=google.com; s=arc-20260327;
        b=pv6tAImq+l2vSkl36MeLtkzRWYYnZF576vhjFJGs65YgF4k5EIx3ipT7pWMCZtOJuG
         s7yuV6YVoyF+Z7b4nKRHPLeehygROm7HmlB2qAq4NFGlixy8l7vs0GaVzg03/5Olv5OO
         qtp3FiYU928QHOUSD+IrBam/qTDDDZTwXWziMeJsVu0TyoiPgwMd4n1TpfBQDeUJBxOq
         iHT+4A8B0pzTgs7c0qFK7L9XorZYnJOWDh34HEeALimcg/kc+TW/8wjHfqHvCsWTuVIN
         86AASYXjUFGb2WeKURuSO62oArG1t+Odj1QTaLQSxygH8U/XgQKODOFm0OdIpLrH5RUW
         4UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LEg0SrmO/VhGhY9o8Sggz15O+9RUdwZIrLUomDbcYAw=;
        fh=aVTK3ziiKKMjMYpALQ81QX1vHnZDcFNq3sxXVctZEFQ=;
        b=n3Pw0AF4QwjUbHV4ilkL2XBa/2k6J+ce0qm8YHdjQ72JS+zJq1z9DD+mXnAHYKo2Se
         eGDlDhtQloVybuBzPcTmiB6Z0O/G6tfapiHoM8XNTbTLBqEq6JTsMZu970cmhP3+k60P
         CIwVeZhVdCxIeQcKAf+x1rry7VgXfSJEGLDAJNFqtuErqxsLXnJnYQ6JldcBia7PgBr+
         xjXG6OSI2SFG3ItnrTl4lu8aEJ4P/8MbBX1ff/9M5hdRzOvmiJWAuDCXcMQWobGstsGj
         KwOIq8UpJebVr//w1THCbkXdItTo1+p7/VmSVtQKztZsrRME8kHLfcBiUiUulSHrq4IP
         Jd9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1793700195; x=1794304995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEg0SrmO/VhGhY9o8Sggz15O+9RUdwZIrLUomDbcYAw=;
        b=Wc/5StHWz/UU9XkyUuuCGSsONbSwRWNH+t8cv7xyqKudZUFa4tlQC+w3SGxyO/Nq9T
         4do6QEKfbIeEypOeEAtv/sYQ0cGZqFy4OMkume/DWkFe2WHy9eB9biunFqQ/lnfQ40oc
         EhlFRme0I5PWYZFF2OegWlVsn9UVWa0WGI4FEaxPU23s/ko4XPGoo922QLfCpNXvig9F
         Yh/VIj0WNpSzd7YPRIjA+83AwUXndI8net6S3CpzRpyCfNC5rN+XHWpyjYfcxEEBJuR5
         h8ZcDCll2NtULcexdSKQLqYGuh89uRFZdLVAG3l6PIwUyHEX42vEqhORQeQitL73La3E
         +KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793700195; x=1794304995;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LEg0SrmO/VhGhY9o8Sggz15O+9RUdwZIrLUomDbcYAw=;
        b=Ff2mw76cyxKqj1VKZsbBsP3GZFz2HJnS+l0aqk+HHmXeYYYd8LcKFgV7DUBbd6U5lY
         zss2CmaN8iUSAgxad4oaHBRZaZnYQ6UoyzdOM7bG3L/JpIPk86Qw1libGKaBRdjL5RnF
         Lv+cjInR4AQHxhUmUy5CtKPs4IEx8T3yq4w+FJiqMAiIDCu4G+4RovMNDg+2FdMbmPdi
         Z2lglhx9Bz5LBfxcagjtRpNu4c88qefwzbqNQ/75yx6nZksqxfBmVYaG2xsUN9v1gzu2
         koN+j7jPIEfMZ16wzWT24Zm3VThXICQzMSA1R10Vfb2tWUt06BmAPBNjWGBtiQ+BWfLy
         31RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZvnWjHB4AtRvzaucBzgECGJ85yhfgaeURSW4pBYi7y+vFbhjztffjr+Y9Wq48/K1749w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8f9102r8IJxilL7g7h8SynrNZSykcZzP66oi2gWA3jiSC9rR5A
	58+5Wdis/cCr8iJBrosfK9qRygGIs5MJKK9V6voujFlwsJYzZrHL+ZIjSJC9V3HeIU/rCOc8C0t
	iox2HCtGTRXSUP3WpulKbaFBCy68HPU74TnzT4ZYf4A==
X-Gm-Gg: AYBFou0BkPsRJ6xa/B3MgRMVArQuVyAJRz46+zLpSHdAbypSpWEXmwqRwMnSJW1JcaS
	kStLtF5NdmxZKw8WjZXCVgYBt+in8zJA5OIvJZ0hz1Ddp3tVFvKx5DzkRUTVGsvjOfLFUZYrQ3W
	ymG/diRpKQPf4ggpE+/5jCwwaoXsWIQJ8vrjwKOdZ08dfWGYk3xHU63PRdSBkGVBrbttXcLF59d
	Heiohcun4Zr3A4XT4EPsAUwZDCxWOERSWFPfJYmdBtSiHzWcdvMXrBe6Ls+3Qogh114UmgVbNce
	GvTzDJx9TOTJmd0ITc2V90ThUVAr/9U7Zrm9UkCLWFn7oFCagjfTS7iDb95s1NfRzMjxpAgzV2e
	/aNwPuGW7TXL4OyaEWE4x6+1bsdswzZ1n5zcPQdkdA98ptPyphP2x+4VKyi8YLru/bjgj+lsAbb
	5qovUOPYkesdNyywuXMAbkHCQClpM8PAq2QwzKeCXRGIyT2ZCXg2ox05Dkpg==
X-Received: by 2002:a05:6820:340e:20b0:703:10f3:89f1 with SMTP id
 006d021491bc7-714f2965e33mr4202725eaf.40.1793700195111; Tue, 03 Nov 2026
 02:03:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <20261024-tdx-guest-quote-poll-v3-2-6a83bb767314@flashbots.net> <7a832e5c-eaff-426f-adff-7935be265bbd@intel.com>
In-Reply-To: <7a832e5c-eaff-426f-adff-7935be265bbd@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Tue, 3 Nov 2026 10:03:03 +0000
X-Gm-Features: AclHuK8r2SlXD9z5feGLL3zqeEwt_maaNYZRrrX02gKnp7mXSTM9MjCJhTQJcWI
Message-ID: <CAKV3HMNEi6aU8GhLuszn8Tmn4aOZBb9i0Ueq_-xre6KUBYssGA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_2=2F2=5D_virt=3A_tdx=2Dguest=3A_Po?=
	=?UTF-8?Q?ll_Quote_status_with_exponential_backoff?=
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams <djbw@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jun Miao <jun.miao@intel.com>, 
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 10/27/2026 10:08 PM, Xiaoyao Li wrote:
> I think it's possible that the host VMM completes the GetQuote request
> before the first check in wait_for_quote_completion()

Right, the loop checks the status before it first sleeps. I'll reword
the first paragraph in v4 to:
"...checks the status of a GetQuote request and, while it is still in
flight, sleeps a full second before checking again. Unless the VMM
completes the request before the first check, every Quote request
therefore takes at least one second, however quickly the host answers."

I'll send v4 once the discussion with Rick on the cover letter settles
how patch 2 should go forward.

Thanks for the review.
