Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7E3FAE18
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170205; cv=none; b=Bah2fxfMaWfqnzuxdWrO2NbOLjFEX5m9/bTQndh9awlStb6/zvbIvKxIw0vRPa34fIrXg2CJIntXW2dFAEVjXcbFhFQArlrEqhIAh6QnlSwP2dUX6e8XAcIzWbYRwCaFiMDjb8U/zpC4IOgVPJBoPR9mU7o5ye6xpWjpxKAk4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170205; c=relaxed/simple;
	bh=xhlnadrHwiFfIWY2g2xSfdQ0B9ev2VRblVYd07DI1c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Emd4gsB8vbTe9g7Rq+lGKWli3BGrEILWD0vHc0eF0BILt+3qE3EbImbTtY1NFfKn5p8he7WQM4atq9ulyuN+tjuOYeeyyUQ5hOmpcTuw+GHpA8i5xnR0MZ+y9aFVanPehB4bwKcDDp5VlSlLVmvvqqS8ExiOXmlxWOzIo+SNZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sC/HxRbj; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sC/HxRbj"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Bmi6b1163058
	for <kvm@vger.kernel.org>; Thu, 7 May 2026 09:10:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eFG1vBkuGjV5WqwCWdKJSFjXXoeKLNuaVc0SsnohSl0=; b=sC/HxRbj/khP
	lauwqZ9En1m3PiufFWhk2MVi8NnVzUAemf9bI6F5CBdj1cHPIggkaXe2/+EQOCEU
	Qfst0vpp73IxZdukxzFpSLZ/U+7vQBDU5pepEIqV/Iud44cWwJgw12gI1g58sTtM
	KksXYFPHQ8h6CUL6YKHLFFteuLAoXy3X/XAZiCtRuXtKlenAOWQS4xrDbUZ67XKR
	BAi7ALQLC2NtDOk9eMoLHqLiIEvmiSJgtKCAHe7XRwq5NbKpCcUkRb+O1q4FcLKp
	jMlfnYMVmysh10DkwwgF9TodXhraCJ5gFNKqgDPilbYYJj3L3jdHUXWSyilWfZwb
	YMz6VepcRw==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e0t6dsqr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 07 May 2026 09:10:03 -0700 (PDT)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44f65835b77so607605f8f.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 09:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170202; x=1778775002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFG1vBkuGjV5WqwCWdKJSFjXXoeKLNuaVc0SsnohSl0=;
        b=ELEJC/spkZs1RevaaEqti7O0zQKW21FLQTvLBspvu/xJHBxKSBQ6U3kesFoOBrcLky
         LaeeGMPWsaoEwjVXU0goT4WMujAc47GOxunpiDeayVdm8c4w2jBBUpByqHVY8ZRnPhdL
         PRUBYcFxO/Nqn8ncx0w/cs+isNjxUQmdxpzyVDQ5oczVUR7QSZ1+PqsstCb2ie/zlpQE
         DYSb4zgfI/QbabxYu1OC/DXCqmEEXSisQhy8vkPU2CYjrFN4pJf1JPUM5pqWSQQXJ1OQ
         KfIIkq/weZwYZNWe4MZIIKtomoO3ia1D4J7NsDXhY17YGPCdHKMI5FIWRfzxr/2TV/TQ
         9gQA==
X-Forwarded-Encrypted: i=1; AFNElJ8bxxV00CV9HEoDvRuO3PoV/xJ9G8Vuw62mO0lDhbcM6L8jEX4T3vPG340vIod1BMFhjbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkawPbIp1rDDgMrckEB/rXWovkfhp2vgQtEGJ8MsR8OVk0dmhc
	ezBorstw/izTQGeM9oqoURCk3Eu9AW4lNjc4Vpy2nS8hea3OEZ2RoNYgMZwDfSjb2X2Y3MrLtDZ
	nhdANvoisoQWHCv4IPsGRU7fVCOvm6RxAIcvX4SjEMaDpj7ZTJEC4
X-Gm-Gg: AeBDievps1rWT2YxSONMrr/A4ENggs2BLFbvaolmiV2xER/PPa1D44OZEAY2PgM8tmC
	zCFVdSN1cz1PbP7lhTrvFhS8bkZvFqnZuSrVx6Sk2Th+8vOkAwu5SuVRmsspVR3qqIZ6K7kM9PB
	z/nrq9A0RI/zETtO+HN/iH1yp+dJ2KHXZMkE7C+czVZ9CEOBwpGhBqaZBfkuh4x/Jsn0zfq40vh
	xvqJFVzShLPlvkfUvcOH0ALlB2vTTP/8jC+tvcw9NR6x+33tYHSFr2h4q+rnkS0tk4MbdE9i1xs
	6jHlnV7Z7/bj0CG8TnIfZ+nT8iVMt1+95zDNiRq116Wt+zAZQtRph71teRQs1PzxniuIzXmp4Fb
	y3YLovAYP1yXs5uuXlpsBQfL0yuhHy+AAUA21RJo4W/egMpVS0MyH8BgLpecq+C0sRN3nLmZX/D
	LKhGjMF/TUABYt1vwqLYmC+W5sqF4EwZAy2GGKHdtnlBaJ9L8dwb1GAzZjSG9oSC+4btB0xqo8p
	6Y91EtV+fiytfRcDsLhNnE=
X-Received: by 2002:a5d:5f47:0:b0:43d:613:33de with SMTP id ffacd0b85a97d-4515cf11d94mr13854419f8f.20.1778170201774;
        Thu, 07 May 2026 09:10:01 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:43d:613:33de with SMTP id ffacd0b85a97d-4515cf11d94mr13854369f8f.20.1778170201226;
        Thu, 07 May 2026 09:10:01 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820454sm149530f8f.6.2026.05.07.09.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 09:10:00 -0700 (PDT)
Message-ID: <2a75c858-5dfe-4b93-98fc-909a2ee5558d@meta.com>
Date: Thu, 7 May 2026 17:09:59 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple
 <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-8-mattev@meta.com>
 <20260424183006.GI3444440@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424183006.GI3444440@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2MSBTYWx0ZWRfX5hKDtpjgoD9X
 t4kfrMgsLrqfeO15hCnfsWlyq1SA4W3rj+OAz6bE0q+rGJ1PU9G+rDxwqLJoWt7/OY50MqISehu
 c2j/1zV9EkBIlDkii8LQrvrvEdaIsCYzHtp45rt5pYwj30Lo+Qo8oR7dn8iLgf+xBE3AzAZT3Na
 sTamYH5RFuBCe1qvZhDRflf0xDH8ClWk+17AMcfAbLsuU6FGj1AfZ+EtU4c8Fzf6JldaQ4KjOa9
 fTg4pMqZ1lLUnyi68cOx8AjIYYNvd27JbAs4HRssg4ZmW7b4f9PkiNUWw3wXWe52DKNHw2SlqFD
 FcwAA+2yzLy5m4tIGoHoz4GdGJ9QYatiM9R64tIrYoHBsE6gAevSEqILyynLtBBHRn52rxCCIHf
 T7U4sqEHb4J9FjAZykSRS6dHyb/WFCSg9RGpZaT3bJWXKLVusZb+tYqVkWqNMew2S+kZsM2STgC
 U/40mKsUwvjfdxZp1mQ==
X-Proofpoint-ORIG-GUID: j4XdOVXnZuT60TlGatdHHpcHFxLsG9b5
X-Proofpoint-GUID: j4XdOVXnZuT60TlGatdHHpcHFxLsG9b5
X-Authority-Analysis: v=2.4 cv=F7dnsKhN c=1 sm=1 tr=0 ts=69fcb95b cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=bfFL6uTa8VbwhnMIod8A:9 a=QEXdDO2ut3YA:10
 a=XGGHjNwGSpTZ5T66x7Ix:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01

Hi Jason,

On 24/04/2026 19:30, Jason Gunthorpe wrote:
> 
> On Thu, Apr 16, 2026 at 06:17:50AM -0700, Matt Evans wrote:
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>>   	vdev = READ_ONCE(priv->vdev);
>>
>> +	if (READ_ONCE(priv->revoked) || !vdev) {
> 
> Why is this read once? It is inside the resv lock so it is stable?
> 
>> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
>> +				     __func__, vmf->address, vma->vm_pgoff);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	/* vdev is usable */
>> +
>> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> +		/*
>> +		 * If vdev != NULL (above), the registration should
>> +		 * already be >0 and so this try_get should never
>> +		 * fail.
>> +		 */
>> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
>> +			 __func__);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +
>>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> -		if (!priv->revoked) {
>> +		if (!READ_ONCE(priv->revoked)) {
> 
> Same here, it is not read once since you hold the memory_lock it is
> stable.

I used them more as an 'eyecatcher' to complement the comment.  Although 
they're not strictly required (compiler barriers at the lock/unlocks), 
they stand out to say "something's going on here".

Revoked/status is read first holding resv, and _must be read a second 
time_ once that's released and after memory_lock is taken, so two 
READ_ONCEs seemed appropriate to show this.

But if you feel strongly, sure, I can remove it (though I'd add, say, a 
/* Re-read status value */ comment).


Matt
