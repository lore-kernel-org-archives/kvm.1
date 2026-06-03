Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6103D1CA4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496551; cv=none; b=t44UppMkTdp7ogv8bafTwJalPWxyoYSP4FtSrOgyrCwLyV4UEWiOYNoJuvHa1uBFHdw+eF3G+0mfaeHRo3UK2angLY4hHlnwwzQLZHnBAkhcaxlAqnlKySXaNbeal1q+Jxz/5+VdXBn9L872+tYH82Fumsd73dtmWPM1WkgjPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496551; c=relaxed/simple;
	bh=obaUumRSEaiR1Wty6Xgu6N15cGNjCTMsp1x89kLIsEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLrFO9HxusZWEplpHpAOzlSRVXaExJzp0f9z0eU7KaYEm/5WfevS3TehwcuZ0CGY9mDlQk6Xx/dgZ/J1yle75azkkJxTp4b2dNLwsyVxFPyZgqKFzmr5tyXPzii18rkhxXHy0ojsqdMLrOc6NHm3TjtQVvTa0Kc2r1Vuo6HalhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=srLuqfx+; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="srLuqfx+"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 652MRxtY2239955
	for <kvm@vger.kernel.org>; Wed, 3 Jun 2026 07:22:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YNScBoT6fWRdM9NkrxjASUlxGuUaN5ox/szwoVCoD/M=; b=srLuqfx+FXuC
	bzE9LkokrAimE5iY6tNN+9tUNfEUn2ef7Lf+87pai3WStxYfRanSdrRxchFrsRaa
	hVp4NgdWnzJDmE0szjBwoM0UI8p/Oe1nmi8cfpFlZ72sJ6MKjrvWVKWCW7EgqGZU
	WY5n4wx/L7mDEsXGDKTFRggrDyDhnviCYwZR1mFhx23XQN1Hossmfj02lNA97hnq
	tldmWLaYSlQaubMvRXFHZmLKUM4/IZrzYGEXU+A7/okfjXt0q6FEFIPesfkDIXRX
	kiDV5EiNC27PctqlfT0z16mTfJF9Zn8GQkNgtJFwMsBAzv/dJKpmMRbazdFqdpR2
	coUlXhATAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ej0xp7fns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 07:22:29 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304e4636205so16045865eec.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 07:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496548; x=1781101348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNScBoT6fWRdM9NkrxjASUlxGuUaN5ox/szwoVCoD/M=;
        b=Nd/4gmo+MFkJqmK2j889PtS1hHmHKOgAvvd/ecosA+PSN38Yhb5ruRlsn+ZlHf8uOe
         xdhXmZcaJ0PuMmcc7t8+KusFkIDwR6SVHl/JzFlWkh7oDinfF5MzEnZ5bcCDA8ne3qqR
         mmfc2+qCwlqHB9gJrqncUKA9vFxZU+CGbLXkMeCRCUuEnYZ8l9L1u58Y0Le2bbxYQxQr
         5KM7lLOk89kg1mT0eRCmxrFXxmp1xrq4nOa/P92hI0kckuNY0zmZiMwTG7BZ+3Q0FKWP
         sZ7CgXe0Kv30VUXaT14GlLDDWd7RgY9i3rUmJsnthN0RZiGEDlIOggYQhoc9BKf+G6w3
         LT/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EWAGd9UbHfhrP3YoErpvx+vS+WlkTYbnJM7/sE31v3HmnGcZJcQyWSCska0GgjFtnPAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ51OuvFF4Z9QflNT7krYKDVpqDBmSZ8LWgbt8xqZLOcRWTHp5
	Ikj/yclat0iUhgKYWJ7Br69e6GiOrhko33FhgfILtkID/LPi1NqQ18JRSTHtyrPvIqW1Vs7+c2M
	eOCKaNnqr8k0/8Gvf0zzj/fBCuy51CF4fyHBWxMNiyQdl7rMRmRoh
X-Gm-Gg: Acq92OHVBHYMhVdGBbL/y+h7INQUnr7oGHEeP1JPHbNljipLpw8ovvlEZBZi0YVLOjk
	t3WUkX0kejxeY0fGTmWQKLh8jzA335cxijEoMaSGrceWXLfJdxvaTRqrbZqxrKXukQsBWwibPtr
	5FwdUiP1PIUFX8f/6+nDGMDKluk58Qg0me8nrfr0fz37ThDYqipSHPu2MFxABR/1iRCb/h4X1D4
	p66teLg/lJQokG/eWkQJ1v0eYpbub7JFBwvchNrzXqB+zLTA4jvktxzzuGhZgTqRFSG2yeGs4r5
	GxzWhWmQ0GxLP7CS2mx9RUyzTRbea6BSXeYPjGgY35pmvA7TN68gplVE2E9wBXJwzsY4H/38P+m
	PONBpajYtKHVxJa9RxquYmOObHYkfPMrluzI/80qK
X-Received: by 2002:a05:7300:2142:b0:304:630d:e4c4 with SMTP id 5a478bee46e88-3074fab7663mr1925012eec.10.1780496548233;
        Wed, 03 Jun 2026 07:22:28 -0700 (PDT)
X-Received: by 2002:a05:7300:2142:b0:304:630d:e4c4 with SMTP id 5a478bee46e88-3074fab7663mr1924977eec.10.1780496547695;
        Wed, 03 Jun 2026 07:22:27 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm2504082eec.16.2026.06.03.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 07:22:27 -0700 (PDT)
Message-ID: <b7635ebb-c746-48e6-bce3-a10bd288e0c7@meta.com>
Date: Wed, 3 Jun 2026 15:22:22 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
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
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-10-mattev@meta.com>
 <20260528171432.771a1a30@shazbot.org>
 <8854824e-06c2-43b3-86c2-8c2c28f9ad63@meta.com>
 <20260602131417.41366391@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260602131417.41366391@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZPHnX37b c=1 sm=1 tr=0 ts=6a2038a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8
 a=AWNa1KPf0UDjnrnzYgsA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: UZXJRNOE7uZUC2EAuiRiOLM7Y7e2PPRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzOCBTYWx0ZWRfXx+C2SslEdt1d
 IXzAFRSFJNfwI9iNCHNQvpcENs0UVFijHc+3lKdVrFo+JW3GM+yes1F2b12lDKdFFceQB3MEghn
 /8fWrTyWjd2CKXPCBtUwkxI0KXmKlycFnD4G8Zo3nPUbOMId/dy1BSo7/gFkfLNcz4FLUmo4ggP
 PCPv/FPvmh/zLlSYlA6XI3ANZmmqxUJQLgQzwz0GmeI3ylNPlwGPkr/BBRfeFIQPc8xTw+IecTD
 enEC7D3HzJ9ZvL0iyAHNcbutSxRTgn7k6lZq+NeiFh8u3sk35/RMHEhSbaJvtqm/67XROnkPwBZ
 gYEhr3R/BC1CdGjqELEgdGHzmX04BGpKB6y1x45UKKSlHFhv7Nq9VRk9oqO/5Jp0w/18vV3alpH
 yOd6b8p1GMSXECDdlCbxL8c7HZcgTMiTqoEbboHjwnFQ/OWhEzhIZAA9R1eTT9IOBQVINx0IZMv
 i+b06SIp9NjODhVgLJQ==
X-Proofpoint-ORIG-GUID: UZXJRNOE7uZUC2EAuiRiOLM7Y7e2PPRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01

Hi Alex,

On 02/06/2026 20:14, Alex Williamson wrote:
> 
> On Tue, 2 Jun 2026 17:50:04 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 29/05/2026 00:14, Alex Williamson wrote:
>>> On Wed, 27 May 2026 03:23:12 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>> +		uint32_t old_attr = priv->memattr;
>>>> +
>>>> +		if (flags & VFIO_DEVICE_FEATURE_SET) {
>>>> +			switch(db_attr.memattr) {
>>>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
>>>> +			case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
>>>> +				priv->memattr = db_attr.memattr;
>>>> +				break;
>>>> +
>>>> +			default:
>>>> +				ret = -ENOTSUPP;
>>>
>>> -EINVAL
>>
>> I'd like to push back on this one; ENOTSUPP distinguishes trying to use
>> a wild attribute value from all manner of other screwups such as
>> trying to GET (with it no longer supported), passing an fd that isn't a
>> DMABUF, etc.
>>
>> I'm not wed to the value ENOTSUPP, just something distinctive versus the
>> other errors userspace might see, and that value seems appropriate.
> 
> It needs to be a uAPI errno though, aiui ENOTSUPP is an internal NFS
> errno.  How about EOPNOTSUPP?  Thanks,

Ew, right!  TIL, and it's caught by checkpatch too (which I fastidiously 
run but still missed this somehow...) :(  "ENOTSUPP is not a standard 
error code and should be avoided in new patches.  EOPNOTSUPP should be 
used instead."

Fixed.

Thanks,


Matt

