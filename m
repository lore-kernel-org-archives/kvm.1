Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BB1CEADB
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382751; cv=none; b=jvlyR0Vv7yoeiZTVDYJz82objCCWqtEk65Plv61gFSeWLhVyGfRfmHIk5anaSY6TuO6TRwxDUFACBBfWJHg3i55c7Tou9LMqcGStb8gnx75tAl8f88Kb0IyohSmlRXjQfZvW6owivVLRwOUacT9QrTdIXkMh3v8qQpe0fHz4hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382751; c=relaxed/simple;
	bh=r5as1pTWd+aduqQQfK4iANhX0H5ndTJhEMGBbiDRlOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4DIXVCG7w73Do8KosYlSjKShZpJ9g5jF/4OdhzPFimLN7wD45dJej88rdmlobaLPn9bNKX/Z4BsQuVg3nIIIemIFMGIJH6CMLQqZZUW17o+Rcn8Zd3HnT/wq1tIEPx0hJAwAopo3Z6TJbKzaMFIuE/KLh5ackwRED1HfGXjMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=oCHJB0/3; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="oCHJB0/3"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L4rdb03995258
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CWXhqC6USMmHwbvXG4lRqC1MokHi8SLoSyLmZ/JVuu4=; b=oCHJB0/3RSag
	aDrrBU1FfDBNXZ0XXGsJmI+2GX6mQFdAd/ctraoEH7HFsLCBq0Eh9xEgEfMXuD2W
	whDZT0eeV88rgrkI9hvZ52D4er/h2hczzSj3Au9RXwxbq3ab0T0NzwQQjqfap40l
	zJcdvW6rseQw7cK60dt25hvJEI3595bsQM7lGb8HlRsHOlTXt82e028nXvDDRQDJ
	OAHm9Qi6q8vlWUvZftyGgZVIuw4YeElUTEXtcvNx1+KHtifewP284hiOr9Fas2dn
	8TNELe9LMcuIIqnAKaJcornOdKY5jxKOV2Fq+a8xesnJ60OfNJjAJHmqdNWUzr4r
	XYCXHy3EJw==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8xwd5fa9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:59:08 -0700 (PDT)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a52d5e572so4681795f8f.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382747; x=1779987547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWXhqC6USMmHwbvXG4lRqC1MokHi8SLoSyLmZ/JVuu4=;
        b=sbErqXb1qfCimWWrXQsa3NDPoAzhcsVAgISZz/OZSTLWYONchM9m45rzjL9BqnhIdU
         a3WbWXxaH7hUFi02qThlghO1H8BtF9bms5j2i8UcYqB8V2SEmZCKr1WgPdg1ymx3c9wl
         cOH3jLhuiYoy0hEsg0A21FWyY8dqFXOfkreUq5bjDTj/srQbVDbLwALsfT8bQDfOiWlT
         fe1JsfE0FkP9ekeFwEEgQUQQVIBI9N/hEbJ+kyyR3ucGhmh4MiP8Dmwha3jHauw41RuA
         5hBh8j3wmDtL4ipvJEBDdf+fyR0IVV3vyizhHV/hye/LzKQyJ0hNV2ymNGwaHH1QZwUk
         gVMg==
X-Forwarded-Encrypted: i=1; AFNElJ8PytsgclNP1dQggLhCWypCi3ViRP2y+msgBTY65lgIiXCbbonRJzaEfjvcJIeRmZETWsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybei+h2mASqco+ASkHTtuPLTpdFeR7rhlUwOy2AWzXrfnRFNji
	7kNM083yuz090pK6ixse0XN6HZZxS3SCxiURB8MTeStvKLRs1KXmMbYxwyWn00X4IjET8+0j+F9
	fTph2OrBVXDy6FTePTWLYoLn8CaULionYbrYnnzIxIyYUyfqa3lFVoWCoJaL/
X-Gm-Gg: Acq92OENhOF0phA7YKWd5OKpZseNxmIh2dkOfdBIWNArRwRk566EvjnSW0Ka31uYU+g
	jfbEdQZFr585YsQtDpZSHboJ/kTA0+C9HEljLj1a3uEEqQ5x2SNRyRckWjkHZRomJ3uW00PFnpS
	h7X1WnRHzW/+qa8XC0TyljSHixC/wbIUcN1vZjyDOOvs1hsG/MMg3bO1fhlPXksucXFRWcFtxOf
	qKh3iGrPLKjSMDHua+XWYFQWCpAsNbVC7tQiRSXaDo79jB90tlzE/QuUPu9uRAFDoOeW1JWkrWs
	1Hl5tzll1ZlU2zgMvoewFWJh0PU1erg1arurP8/q8NlfJf/x4AxAKzpr4FJaMHKCPzSKg1FzpUw
	SLYJDfYoxrw225dIoP3laBNjgCYNLuP/Pm0/SJffUD4rHS79qQ3fY67DqzKeeAc8DZJOkG2xu+u
	HH5howQvEjNZ5nAg5D7J4IPWIYR2n7yM6UMyy/eBPzMWIgAPUeNWU+RBGxnvZ0WcUwWFs1d1ouR
	FOyiNYLmtziUjyVIzVB+S5BOAEHECGDvA==
X-Received: by 2002:a05:600c:4448:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-4903f7a17cdmr15904595e9.16.1779382747120;
        Thu, 21 May 2026 09:59:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4448:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-4903f7a17cdmr15904285e9.16.1779382746639;
        Thu, 21 May 2026 09:59:06 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490417a3efasm389285e9.8.2026.05.21.09.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 09:59:04 -0700 (PDT)
Message-ID: <ef311ad6-3563-4251-85d0-0f8f03aa55a9@meta.com>
Date: Thu, 21 May 2026 17:59:03 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [awilliam-vfio:next 11/13] include/linux/vfio_pci_core.h:247:31:
 sparse: sparse: incorrect type in return expression (different address
 spaces)
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <202605211601.U1OvmuqY-lkp@intel.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <202605211601.U1OvmuqY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SafHsPRu c=1 sm=1 tr=0 ts=6a0f39dc cx=c_pps
 a=I6ewnrIBtnKHmb6SxpX7Vg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=2wJ86P-fu1irUxtt42EA:9 a=QEXdDO2ut3YA:10
 a=MqNruPmfsT8GavliLQMe:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: rRf1udeSeM3yyQXNOuZFn1tk11_Kwykd
X-Proofpoint-ORIG-GUID: rRf1udeSeM3yyQXNOuZFn1tk11_Kwykd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE3MSBTYWx0ZWRfX8JcNbZX4JqbI
 5645DDjKjEt1v1JnMz2ZYMQrSabAgLaGJr0DIO/TFYdR+kHrnmpUZToquzP4VKfUBANro1emReN
 /E4MAw1G5caVXuOoxUQO3CCUy0lyWLV6eoTM1nVgQUJR8nmEUvXYQJ+uRVKGBIwnparqYSiQH0K
 /U5GVomW+ovVV6/70UBjpSAjJKpPIb3VMiwBL5o9qsn5snjVKwiZ4vuxG0Sla/DXhbRqushgqp9
 SzPu+TysOFNyHk1WfWPpAYVXNXgZmY68gWioR+QaGNkM/sC/pxQHKoRNHizcu4iebCUcuXau6/o
 LJkKCci/ZxqGyyto7IAtBnaUgHgmrDeImqeD5ckW3n8gmSAgwzn2+COHfJHJm9NcrklGRIDlLyF
 6SRN480FtW0erBUsIr8OJ04pfOqNF2P1I4zRL9FQnYfqN2hOtcHOroDsgMps+QOTTJh+sDDhsrj
 oeLOD4IP8PLiR9Xjitw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01

Hi Alex,

On 21/05/2026 09:07, kernel test robot wrote:
> 
> tree:   https://github.com/awilliam/linux-vfio.git  next
> head:   b9285405c5f6144f4444f97bf3048d865e11cc1d
> commit: 859dc0f6253b0d65fd4d79e29aa29b3d939c51a9 [11/13] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
> config: alpha-randconfig-r132-20260521 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/config__;!!Bt8RZUm9aw!-MeA4YCZqVD1LgfRaoW0lgRz_bEdlvVRk8RWaDsMsFVUXAfMxQ3YFOteZOcWJ88tWRlbPA$ )
> compiler: alpha-linux-gcc (GCC) 8.5.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/reproduce__;!!Bt8RZUm9aw!-MeA4YCZqVD1LgfRaoW0lgRz_bEdlvVRk8RWaDsMsFVUXAfMxQ3YFOteZOcWJ8-nGduJOw$ )
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605211601.U1OvmuqY-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>     drivers/vfio/pci/vfio_pci_core.c:274:33: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:274:41: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:278:25: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:278:43: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:278:56: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:278:65: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:283:25: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:283:44: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:283:57: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:283:66: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:291:39: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:291:58: sparse: sparse: restricted pci_power_t degrades to integer
>     drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t
>     drivers/vfio/pci/vfio_pci_core.c: note: in included file (through drivers/vfio/pci/vfio_pci_priv.h):
>>> include/linux/vfio_pci_core.h:247:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>     include/linux/vfio_pci_core.h:247:31: sparse:     expected void [noderef] __iomem *
>     include/linux/vfio_pci_core.h:247:31: sparse:     got void *
>     include/linux/vfio_pci_core.h:250:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>     include/linux/vfio_pci_core.h:250:31: sparse:     expected void [noderef] __iomem *
>     include/linux/vfio_pci_core.h:250:31: sparse:     got void *
> 
> vim +247 include/linux/vfio_pci_core.h
> 
>     235	
>     236	/*
>     237	 * Returns a BAR's iomap base or an ERR_PTR() if, for example, the
>     238	 * BAR isn't valid, its resource wasn't acquired, or its iomap
>     239	 * failed.  This shall only be used after vfio_pci_core_enable()
>     240	 * has set up the BAR maps and before vfio_pci_core_disable()
>     241	 * tears them down.
>     242	 */
>     243	static inline void __iomem __must_check *
>     244	vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
>     245	{
>     246		if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))
>   > 247			return ERR_PTR(-EINVAL);
>     248	
>     249		if (WARN_ON_ONCE(!vdev->barmap[bar]))
>     250			return ERR_PTR(-ENODEV);

:(  Yep, these need to be IOMEM_ERR_PTR() also.  What's easiest for you 
given this is in your `next`?  Should I repost a new version of the 
whole series (even though the 1/3, 2/3 went in via the 7.1 RC?), or a 
one-off repost of this patch, or..?  Sorry for the silly Q, IDK what's 
best practice here.


Thanks,


Matt

>     251	
>     252		return vdev->barmap[bar];
>     253	}
>     254	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

