Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DA3DC4D7
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795621; cv=none; b=HlyhfcFrdig4hg0F1swCf1VXrhMhcmjUTCTbXKZ7eCXoot247WsJNzCnudpOpi/vbPmYoH8rlmppYevGGYIb/v8hcHBowJkywjUYGnmHPGvfzYo4gf1zGYs8aVbskDRK6SMb4wWZiyjWe9TWbd7hflp5HHFXuIboCM/MGaaKcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795621; c=relaxed/simple;
	bh=DdVLRcT0RgYnIJ6C0Dq4YoF2M+Wdxu9nk5PCXqGCRFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0NrnBRuHysqZAPzU68o39AbZ2mluEXJ3c2nHt+RRQppTwFeAeRquCCP7XWCPKDGEKqy0Osw6+eUcJF5QaaAwiaYO7oFLKOyENSWzRjTFX8yMs9pTUMA9GjhfF+ik1aGm+uXoVpB1cQ1FME0Dd/s1Dn8EHZQOOE5qmjBEbypY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aIxRWlXa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3Ie1SQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aIxRWlXa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3Ie1SQu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N7Br6e3372988
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=; b=aIxRWlXaDf/JMeJv
	9tEB/Iiqkwpu+hagfAn2wGi4aeVmrj3PtPxHJ+/VbJO/opVVRo4B7Lj4lYykhUXG
	ufSP2Hv1/WFFMvIT3AjVm03Il2JY8NWBNWOK05bzJrLelWCNqhe7Eim1pl9cYl2R
	wsGqaFz5N0U2xiGBZkQqx6gTxt3PjQanpzCCIBgi799rr6H7wctFwOAV2yRP5Nve
	cmyH7+l9DOJ+L3vmg+VCVRSPrRkD0Hy1cFMfbKN/f8TTM3rLpAbENOkylZZqP3/5
	6pSXaW1SpqrFsHSMwD997+DM6nFeJ8xsji501pVPdtjUfUroF2GwVNDv4+70yTOd
	TOX8rw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qgb89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:33:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c083f1818so6492081cf.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784795618; x=1785400418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=;
        b=R3Ie1SQufTp/9ak+ykaRSEcNr8eA2fL+055k5mikHiLk35UxQhHPk3/TJww1Rb+cb5
         WVzJRhioxj2X70B4G9cR68UiwHJJWyp3HzHIQlZPqjmm5fPFpK40KA6PKrFNKxe9fd/D
         bRcf8PdSwatmJwy8IfnkeobI1qlTD69rrrbQFne6SZbVFhmkeHWrV0E+AmIuXoRWiZcD
         rKicvS8E25gc8Q+0ExBTrzf+oeQLJl3Q8o2yTO8X1swAqF/jqWMJSsYiOZsdM7J1zfPS
         yMzV+9P6yXQ3+J4EC73eORsBMFpqtXsDfpo1a2WibX/1PuhxfzJfiHa7dg5xZwK8CuLb
         A35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795618; x=1785400418;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=;
        b=fr567nA3OCUt3ptpghGE+4vCdrun1fo8ZovFzw9a+AvHVUk+c11HZ701KBqa0+//nR
         9It0zujDXz1wkD0vCnMcxWvo2NJo1JjJ9LYUTfwqPQLt3OjIGv2H7cbbABwK64OuJbfT
         t0aKgb4kDZnD5fQaecgEAXxyh1Tmr0l8NBPEls9QZ1BqJ7GK84RyHLZA7jo79gUF0PNh
         OMlXrZvFL6xvYxoe2MGvAUDnQ1P5ySHK5DRy2Kyt4CQeKwd9C5e3TW38c2WpkhmlB40c
         pXbK9utjLgHEFJfgCF4/Vw5B78klnq1gD1jBlfEMpjRO2wQB+KurWJ20PoEnWgRQ6og8
         t2YQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRWyBkdu6U6Sf0JSeNh3NqS+3fYl79uoE/u1v0e1Tf3tJ6fi+c27Nqdsjt+DDTgh1k1Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFx3+1Yw1U9Fds6OpKLfleTsIuYcVgoEiXCi+sld3OK9O6uAU
	DGB3tbjh83jmL0IvUY/GVhbntJ5RcGpZvP34pOG4I1JX2Q9IYvfoslAd0FjTWmno0BXtFPXYnGq
	1UEV+fy2/rm2NtkrtMDXILuTqK14SfNL/ijEjFOvXNSqPigStvzBVqYo=
X-Gm-Gg: AR+sD13E7dSAegbjn7610h0n4Jeb945sRt+CxqwmkOBOYDeF/1irl48/XKOaeXdMlfS
	0tl9+iM3pCeRpVBB034lKlK3bfKIhScKr9Il1PVbIhbDKFs2nJPY8MKQk8cug9eV2FiiB/kE2lr
	2vYcmkjyPXjUBbKvEkE7p/r1j8Ge2PRYYtc/cVTFlJeyjFxyBVrls0oCXufUTRfnr2uKNWvDWd/
	kOW1/Pyb8Sgxqm5NC5BO80xhZfFTWFOG49GWD8IbB95D9/rSQu4AHHCuyPRP6y/F4z6R2pL/RDK
	vQCBn8MVRwmGAbKrfhi8utHbhckTRUX9ILHeGxFKW8DppvPnuiuG/W2Rms6d8CO55i9OnCGJliH
	My7gg1tWd88W50qBKy2uSxlpN922wvrdagSoYYv1R1sZB0iIliUY=
X-Received: by 2002:a05:622a:2a12:b0:51a:8c9b:649d with SMTP id d75a77b69052e-5283df77456mr16860981cf.65.1784795618077;
        Thu, 23 Jul 2026 01:33:38 -0700 (PDT)
X-Received: by 2002:a05:622a:2a12:b0:51a:8c9b:649d with SMTP id d75a77b69052e-5283df77456mr16860881cf.65.1784795617657;
        Thu, 23 Jul 2026 01:33:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5d9sm12856725f8f.5.2026.07.23.01.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 01:33:36 -0700 (PDT)
Message-ID: <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:33:36 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX43z6IwDQbwhy
 +yaDkVQIMV3Wn8xv4b19PZJSV0zKbwuM0FWOBanMJe3b1XE0ed25LhaAqnErw56pukbPIjAz12r
 D7/cyBb2lusla7dnI+x6V2v6pZCbvP4=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a61d1e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=27Jx0McfqUJ7E1xIHb0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: a4azYECkKBVmUnu0AqeYUhNODVZl-xZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfXx1U3fk0aea/x
 UuSr/00vTy6rN2+V5o+myZbXLJe0Z0dO9LD/lnhWDKSvcRY2c///1zZsEnkbGtUf3WgQp2YHS5y
 85dIwC+wsOuz6ltQXcDLwpTPu9bjW2nf+ncmCd8D2NbVulDHVa5sak2vvbWaT4dYVd+L8l4+dL1
 Nh4ctJ/K/vRpfxoxBejeyZJW8vPcwQ4roDmESOke0FiRDJuimzPxy7G++50hbT1HwmJgrlVvo1b
 FupZE1OnGy78NkuxVkDwWacBz2snMHyEMyF3/GvFHxSxfkxNTRCzmQrGsPoY/pPkqd1a0rVcUR0
 aIHTPn2Nirf71VLQ4R71mypmjayoc7ZuoLpoVu+YFbawo87EJTlLTR5RYn7Sc4FnWKAxVkBszx0
 rvKzMBw7/iU5EbFA1jhE3ahMtD3HteTSe/nOXc1YtPl+IW5BeocbZpgZjpBSLyYp1RzxY04E9cS
 KnO6o6l0FNLljB27L4w==
X-Proofpoint-ORIG-GUID: a4azYECkKBVmUnu0AqeYUhNODVZl-xZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230085

Hi,

On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.

Comment orthogonal to your fix; odd to have a non-monitor code
call an undocumented monitor method. Should the method be moved
out of monitor/hmp-cmds.c somewhere into system/ and documented
(likely in system/physmem.c, also moving the declaration to
"system/memory.h")? Besides some day we should be able to build
without monitor.

> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/system/memory.h | 2 ++
>   target/i386/sev.c       | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d9..53f65a224bb 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1343,6 +1343,8 @@ void memory_region_ref(MemoryRegion *mr);
>    */
>   void memory_region_unref(MemoryRegion *mr);
>   
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
> +
>   /**
>    * memory_region_init_io: Initialize an I/O memory region.
>    *
