Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21269239562
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780757; cv=none; b=d6EYsRt9/09+F8KI1MqjXkjC+oWjtOJSvnU3KDHY3+74py19yio+ocz9DetKa06dVkjacnL0jP1i8O3ckTN41k8k50RRcoJntMjtXF2gr1BQI+hY6Kfc5xzlTvG5oLRmjdSbqV2yJazLRp+RuLceBYKeJzSUsC0Hhp6GZ+1CCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780757; c=relaxed/simple;
	bh=a2g8T9YPVYARhdNelG7/izwn39OqgM1/XZdJ3lfqSR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZZpVPUXVn8Mm3DYMfEzgeGLOiujyIl9Gb6HSZnWkc+Dv+rsMJpQ5KS8CwYu58D8g+0NfJG6W701rSnhHAkne/P49ZOzRcNURD2iJWChfeJbGrNb4/SE24XcFmdFQq2vaEaE0iaTYZmBT5y7THPt3/rqssPiNqk4sX35QND8csM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DetUVmfm; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DetUVmfm"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64EFYxA33168928
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=QDzNi8ttoDhR7lPW7dh1etIO5/FdfLvWANoerePC104=; b=DetUVmfmoE8N
	WGLQmc2B59nkMnM1wHrtXE/QhfTjkTn9obMFosrpOARi2s0NA2+LFecCkkdiH8Na
	SexDGT0Y+Mb0jB069D5lXjSdvamW86/nJtLfwse1sHzuBYeDzgi9//vjwmCDfMLR
	lF1FU3ErBc6gFWYBnilaXnFP8yMQh9Q0HDSfzOKrTe6+GyIkS4vx50EpiEqh19Ya
	znEjUZnqIv6EyyLzwIaDGm3neRN/6b9LzPuFJ1JTQ3JT4lXgl7E1wgr+PE21A57b
	CHead5CQinl81jmXsxRumGZmPD+egpSVLRQPjV7PEvKoTLshNtA2UXvXudCMWply
	A9Ret/cU6Q==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e3nw7s899-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:45:52 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fe44ce385so2880135e9.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780752; x=1779385552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDzNi8ttoDhR7lPW7dh1etIO5/FdfLvWANoerePC104=;
        b=T+L1Na8VSEU5uJ0FBu55udtfv8mcrhwXR3FET83jy5Cw9ajIb9Pou4snhpDYLU8LLd
         ztwcLT6UBfq7Pp9xSu2GZRAbUfZfRsKq1/LV2Nm5LZQTBOo5rmTeN5frLwa7+g0+c26L
         N+kEYLFaXQ9/leTseLZwgKHukuX5wOCH1a0tOd0e6bE4sSfY62SeYFiUQl0zgQPfh/O3
         7/lLVbduiHx5bSJG+PPQcd+LLGl0YP6WbyyCnNhNXCdgmqaoZEju4khX2YS4kbCO31rb
         RoQL4sDiNOgLJ7HLXh8TR7rGePFPx+kvuWa7NSSXbflRdS03g7jTV+rOY5/6suK8YVaN
         /Hkw==
X-Forwarded-Encrypted: i=1; AFNElJ9XBP80mf10Fgsn6bwyrKJnyQERnbhgJDN80fiXvwfWH0kW2Zt7mPGI6YWaFofDifIJ9J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycwev9aYjyoLqVVeRhlEL6HZ2zGfBuQbv45WZeuQGKFh7tGeTI
	M66ofPOCIwe04hqAadHvv0aAZSYqC2yIYhW2gq22ysglbhMFUU2LtKNhkBJbTIOCyy/nq49reGc
	J+Im3Rkib7MRFc32X3+RUSLZ/wp3//77X0EynwObfl6sUEXzEC6aR
X-Gm-Gg: Acq92OEpp2PpZOH9HqhCythFzBgKJelsstMTVThRQElxRWfPjQivuhcvwrmlPtMOAUI
	y0pnJyZ5Yi01EcfLnZqtzlHtUyDTizDRLLP3hwiL+6QxgnymJjzRkXnTfl8rF0aJapwjyxr4dbN
	UmBNOmTiHAxve4qeayRi1AaZqreytVVS7sCFWUdXXhMvNgZ5XeXPFKCscfKj7DplW/zN6aHwsSF
	dkn9UspwHu5iXWPatKBn6wSMZlSm4Bn2jX9ikCc0s2I1OJW2tGVo4nyc4Ut8gBadGRBxBDIzmVR
	f8ycWaLX+0NYCOvbwezWvyW5GCuBAyluc/5R9tNW5E2xvnon+er3PtXAmQwI0b/2yzRbKj7KQkW
	zX7oirznjiI6XtqY0mqiIO0e+ru0yHfnWtbu/2pCXcFZCeev9Xy8MQBlAVks41n5rQFSLR9aWON
	1cAnuTG8J1vPuShxhlc2+Akdd+4j5artkfboT0lkdOVc60ua1CX4RehfhUilvs5dqc98gvQEdxN
	96VevXsOQy7NLPooPu6y3I=
X-Received: by 2002:a05:600c:8b18:b0:48f:de5a:4a6 with SMTP id 5b1f17b1804b1-48fe6515806mr5476115e9.26.1778780751674;
        Thu, 14 May 2026 10:45:51 -0700 (PDT)
X-Received: by 2002:a05:600c:8b18:b0:48f:de5a:4a6 with SMTP id 5b1f17b1804b1-48fe6515806mr5475725e9.26.1778780751254;
        Thu, 14 May 2026 10:45:51 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd769141fsm22775085e9.32.2026.05.14.10.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 10:45:50 -0700 (PDT)
Message-ID: <923eed09-6637-425d-a8fc-123c9e010c33@meta.com>
Date: Thu, 14 May 2026 18:45:49 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [awilliam-vfio:for-linus 3/4]
 drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in
 assignment (different address spaces)
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        kvm@vger.kernel.org
References: <202605150023.lXFibOM0-lkp@intel.com>
 <20260514111731.5ef8faa4@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260514111731.5ef8faa4@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Iqwutr/g c=1 sm=1 tr=0 ts=6a060a50 cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=dFtbKyHJh52wRT_GfbIA:9 a=QEXdDO2ut3YA:10
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-ORIG-GUID: Kl5TBA7UwxsMtqrbL8oF0uO_ktIcbvS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NyBTYWx0ZWRfX4DukNwenA2ya
 wKK7Ib/0tgIpyyDmST6s2YLNgzVhIgEUe99eOpT8l75WqpCGqc7GPOwuXNtdVfUQAc2Wr4hXli2
 fAWJXBu8err3x/+eb/U9qKVIgAQFpQVIvAdYbC32I0CwZF4+uzsRGn9fKhHB8gCqQ5iwsAcX2yV
 VKL7hQylqo9xLtTInRZ/0EZDPAimYdQ/8VAlikE6BOht0uc5lZqTq5GUgD2FBaQ2+GCbH8YvN54
 c0EwlJmprfk4/4m01cIYJ49gJM+frUSyIHOKhIY15S1aBz5IHx53BUgvfCqgJ8YpT9+L0/LJn1T
 P6Tb7KQjKSx3dhS7WSRIaX1JwLWcfiaBnxMeBahIQuMfq9IWjBn95Vuxnljmuk2O7QL7SJ8UOVJ
 I1MFGgj5LL7yd31tKW7UGYWecb4mVS3nW5Wk4zyUYnHpVpz2Y/iLkEt7qYC1siB/YvMN6rBnHaA
 eMvVOrG+rHNry4MVH4Q==
X-Proofpoint-GUID: Kl5TBA7UwxsMtqrbL8oF0uO_ktIcbvS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01

Hi Alex,

On 14/05/2026 18:17, Alex Williamson wrote:
> 
> On Fri, 15 May 2026 00:39:50 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> tree:   https://github.com/awilliam/linux-vfio.git  for-linus
>> head:   a8a3ce989a94db08f77968a4e75b34eaa6d40c9a
>> commit: a975fd177726e110f30b561dd0707b78f21ffe66 [3/4] vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
>> config: parisc-randconfig-r134-20260514 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/config__;!!Bt8RZUm9aw!4Ml3rrJPR5hgJ8qM0OCxOwEdJwF-k0mYiuEeBClnnKNLCVzue2QGcVDL6uji9tVJzQBE381sJg$ )
>> compiler: hppa-linux-gcc (GCC) 8.5.0
>> sparse: v0.6.5-rc1
>> reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/reproduce__;!!Bt8RZUm9aw!4Ml3rrJPR5hgJ8qM0OCxOwEdJwF-k0mYiuEeBClnnKNLCVzue2QGcVDL6uji9tVJzQDT2Jsk6w$ )
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202605150023.lXFibOM0-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>>     drivers/vfio/pci/vfio_pci_core.c:274:33: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:274:41: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:278:25: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:278:43: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:278:56: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:278:65: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:283:25: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:283:44: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:283:57: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:283:66: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:291:39: sparse: sparse: restricted pci_power_t degrades to integer
>>     drivers/vfio/pci/vfio_pci_core.c:291:58: sparse: sparse: restricted pci_power_t degrades to integer
>>>> drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>>     drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     expected void [noderef] __iomem *
>>     drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     got void *
>>     drivers/vfio/pci/vfio_pci_core.c:506:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>>     drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     expected void [noderef] __iomem *
>>     drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     got void *
>>     drivers/vfio/pci/vfio_pci_core.c:514:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>>     drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     expected void [noderef] __iomem *
>>     drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     got void *
>>     drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t
>>
>> vim +499 drivers/vfio/pci/vfio_pci_core.c
>>
>>     484	
>>     485	/*
>>     486	 * Eager-request BAR resources, and iomap them.  Soft failures are
>>     487	 * allowed, and consumers must check the barmap before use in order to
>>     488	 * give compatible user-visible behaviour with the previous on-demand
>>     489	 * allocation method.
>>     490	 */
>>     491	static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>>     492	{
>>     493		struct pci_dev *pdev = vdev->pdev;
>>     494		int i;
>>     495	
>>     496		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>     497			int bar = i + PCI_STD_RESOURCES;
>>     498	
>>   > 499			vdev->barmap[bar] = ERR_PTR(-ENODEV);
> 
> I think we just need to convert these three ERR_PTR()s to
> IOMEM_ERR_PTR().  Agree?  I can fix it in the branch.  Thanks,

Oops, sorry about that!  Yes agree, that would be great, thank you.

Matt

> 
> Alex
> 
>>     500	
>>     501			if (!pci_resource_len(pdev, i))
>>     502				continue;
>>     503	
>>     504			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
>>     505				pci_dbg(pdev, "Failed to reserve region %d\n", bar);
>>     506				vdev->barmap[bar] = ERR_PTR(-EBUSY);
>>     507				continue;
>>     508			}
>>     509	
>>     510			vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
>>     511			if (!vdev->barmap[bar]) {
>>     512				pci_dbg(pdev, "Failed to iomap region %d\n", bar);
>>     513				pci_release_selected_regions(pdev, 1 << bar);
>>     514				vdev->barmap[bar] = ERR_PTR(-ENOMEM);
>>     515			}
>>     516		}
>>     517	}
>>     518	
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> 

