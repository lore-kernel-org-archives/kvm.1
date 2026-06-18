Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9103128B2
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815900; cv=none; b=lJHrd673uL+9h3WwobBl+yrLNzFjXZZIMEWJN1oE8fM4k/2QHt2f5dsh5uCHEFVPMJ6enhlJ0BTfu/xSOYCzw2Lbuxy9rSYdu09X5cpR8xce+ojLJWyWV2chbos7tasEheACBFHgXEYebfafgJtBkih0+z10/PTNYRbU6eOAyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815900; c=relaxed/simple;
	bh=egB1+gVtDSu/TCWNGq2lmnLePogzStV9bQYVBJCdR4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW5Z2jUuo0K3m/Na+8B+ENnxz8Oa44VeI0cmp+f9UUyJZ5WfvkhlI+1ADQqJRBoq3p0FvxISBkwZdvBpK1EKjSWP+UN+11p+4NVRD+i8MgyXWJ56cbzPcrdUicU6md2PI/rbNMm7CUkCYb5vZYl6VJI8/L5o9I1eOTpkvhdux7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX/hsXZ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fti630gq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX/hsXZ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fti630gq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IHrjpk1878939
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptbe4y4AW6tVSqoarkNqu6Ie+8WvPfZMWpNg1/yxZYs=; b=PX/hsXZ6W8vybzjW
	wjDZXz0774zSZvPwCe/WVSYLoaaSyjHKmpTLM077UYKgdv0o/SOL/t3/ptEOyJt1
	ZfYYBUBKtkCgoxYB1eF3aqHqLOuJjmO3aDtNquE89xjLSbTd34GgbUKM+vGWDG0M
	ActYN0wMbLUNzvZOmkz6rgOL44zRb5FaPOwsp8iuCdCt3qASxALSV8pKwTTzTyO+
	9L8wonmwPSDJLjTUb9s/jNrkF+do6PvdqMDI1K/XKQHSWVvQePgV48L6PfanF7XK
	6lHBRwO1h2Ck+zLOZqTfkNGxRcWTfKDQU3lRkPgiC2JrnHsfcDpp3FwdVoqbQfsn
	PWTyuQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf18eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:51:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91574ad681eso236370085a.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781815898; x=1782420698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptbe4y4AW6tVSqoarkNqu6Ie+8WvPfZMWpNg1/yxZYs=;
        b=Fti630gqz7xwRkQrLai7LsU6YvXNCFOCBL5V9LCd5VIcHxVYBckhGJFgcKt4oipNTd
         8YqwIuo/V5Gq5CmRCOSX/lk+KlbmGy7mhk9XEkvbOlNeyWQfGQHEpueURR58LKZmoaxg
         GwOOn3/DTQWh7ftBFUdpFS/kKMyAKNFWkuyfvmcQj/Zjbg7bSZyVjY7WSUqFbaA1js7O
         JAOmnk1p5+s+eQNGoPNp7tdj9Twug9uxQraRsrZSsxVsg+aA6jemA07dOmDNKa7wYVCC
         kMmhSiGjFV1JDiaiHhng7G+6fBSyOmKXtzHpt4HWqM7nuIqVbHBWAgcCRY5eESS5Mh9a
         kXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815898; x=1782420698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptbe4y4AW6tVSqoarkNqu6Ie+8WvPfZMWpNg1/yxZYs=;
        b=DmybapFqq+fnU1/K8bItufSPgjlIIKEPav3K1RtyBlfyQ/MAeUHCMIzxWFfejtHDd3
         2sbZpI7xLEkkWHyDP/6LHQcE7xuMf6pzNkdcjYM+LJShE4Mc9o4QC18b2tiO5VGLWTKh
         dMTDwg9RoZDOVrPAXtKAmFFJbHspBLShaqyqoiqMgPqmixOX16IxERSA/C5Rga2Nu9dS
         Xk2oYsPUHvDx1p+fEwC6aEtzqeHbZibdUbKt/5WWfbFvvTlZDIy3n5h658b7CtOLUkQ1
         xWH7DCPbdMe5fOykQhmqEbpA+bn3hmhityQBRb+TOX02LgaMNDCloP3EU6iBmkcLBisM
         C08A==
X-Forwarded-Encrypted: i=1; AFNElJ+C4ZDB7/D6qQydgD8LT57jPnMrecxl1VePkeoeES2xivHb1gIpvCOAYXHnc57khTfv2co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0rGQ7+TEU7NbDPOXRwF9IRxrrv/qBT7Z6JN9jk0CQih29m5/
	I6Xs2bcPSvNkBzycaw3GPIeglNujDtteAusgIV65qU+0IWOYkaMhuNOzRtVOeILVlg2w7tMmsex
	F8f/dGTOflRgzbizztlcSI9Ylii5Vf2w4P3ynWhDiL484SuzBOvw8jYA=
X-Gm-Gg: AfdE7cmrkOA1aDiG7qcC4Xlz/ChGkAyTDuTv5+Ojm70/62OJoqG/AmY0XK/KUTWq3zT
	9hAqJZYUT2FemRKRKliPrQWK1bWbe0SLmWZ2c7ljSFXSPCfVM4CVNBF90ptWifci2+xvwzromwa
	i4T0pRq429C3K+0VbXFPjORUKamu8nJEzXWCMtss1skk8ZyZX0P0DhORS8lO00xo+xRAR10V40/
	QmyfC6fSALP8rwgxhSMruaj816xgNaT0TlDaPvR6wM/QcvYOjjTbiz2NA0GewrI6l2GT8Xd5s+s
	fcIi51pJdF8tT3HOgtO16fAdKmiRzpelwUUIisBMDmEG/PII5FsK1RB1yzP0oJcjXqqIoDXO55H
	0dhqq6/obU8nso8EsP5+R8hnkxUOdcZfE4keLemixbVLacVqhModWHAXkZ86Low==
X-Received: by 2002:a05:620a:6493:b0:912:1:b41c with SMTP id af79cd13be357-9208c333b49mr124659185a.0.1781815897609;
        Thu, 18 Jun 2026 13:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:912:1:b41c with SMTP id af79cd13be357-9208c333b49mr124652985a.0.1781815897052;
        Thu, 18 Jun 2026 13:51:37 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fcb6db0sm11380765e9.0.2026.06.18.13.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:51:36 -0700 (PDT)
Message-ID: <8a5fdcc5-c6d1-4baf-8ed6-940006a20a86@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:51:34 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] system/memory: split RamDiscardManager into
 source and manager
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
        Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
        Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-1-5768e6a0943d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260604-rdm5-v5-1-5768e6a0943d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE5MCBTYWx0ZWRfX287Uf8C8ij7Y
 NpnqJ9JmACG/b0SShckde8Pewp6DFjIseEd3dYOe2boWd89dNMjhxm2vEnFSIhvmfW/eVvq3Jem
 vuJDNU+UhdvOnOILeuMohO9lzfVW2DM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE5MCBTYWx0ZWRfXxgnilMEi8zbd
 FZBSrEFeHVP1EWlcmtumW019PlLtbCXSJeWEzyrA8Ynvwp9p8i5Hnp4soeZ0kinhrDpbNalruBJ
 peU67D3CiqnZQZ4l/Is7ZOfAct8OYjfRdeDBcaajJgj4lqT2UaoL3BIr8lYMRxc+962pSrsnBAj
 nMDybVBjEnKq+IEIQ78PYBJhmGfY26T6es5AcoDHMWVAPGmoKLqEla33KHX2JdHeU9TGYgK++Us
 sS1z+I1smc+sjMG3JMN/iw97Zz0UwcDQnjAmpAjnYW1LXRfGOYdpFHmk8a1V7QFX4AQU6L45efK
 xwVJ6cZQLFjspeBNcfH1fKAJPwojUTN+zka5vlvc+GXTBHCZUTJKhbAbe5GVcUcftc8Hh9dkV+i
 Yi2Vby76l4liyB++tAkSQKWl6lCXlMHlTn7wNoT4mDE/2QXLA8vKaJ9LsFz2CCZQjjjpsmTIQDO
 a6a529+Zpru8ogljFtA==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a345a5a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=A-yEnD0DAcmAWPwwjsgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: NBBiGkGSdH1Z_lhXm6MtpKE71VR0na4y
X-Proofpoint-GUID: NBBiGkGSdH1Z_lhXm6MtpKE71VR0na4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180190

On 4/6/26 15:43, Marc-AndrÃ© Lureau wrote:
> Refactor the RamDiscardManager interface into two distinct components:
> - RamDiscardSource: An interface that state providers (virtio-mem,
>    RamBlockAttributes) implement to provide discard state information
>    (granularity, populated/discarded ranges, replay callbacks).
> - RamDiscardManager: A concrete QOM object that wraps a source, owns
>    the listener list, and handles listener registration/unregistration
>    and notifications.
> 
> This separation moves the listener management logic from individual
> source implementations into the central RamDiscardManager, reducing
> code duplication between virtio-mem and RamBlockAttributes.
> 
> The change prepares for future work where a RamDiscardManager could
> aggregate multiple sources.
> 
> Note, the original virtio-mem code had conditions before discard:
>    if (vmem->size) {
>        rdl->notify_discard(rdl, rdl->section);
>    }
> however, the new code calls discard unconditionally. This is considered
> safe, since the populate/discard of sections are already asymmetrical
> (unplug & unregister all listener section unconditionally).
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Acked-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/virtio/virtio-mem.h |   3 -
>   include/system/memory.h        | 197 +++++++++++++++++++++----------------
>   include/system/ramblock.h      |   2 -
>   hw/virtio/virtio-mem.c         | 163 ++++++------------------------
>   system/memory.c                | 218 ++++++++++++++++++++++++++++++++++++-----
>   system/ram-block-attributes.c  | 171 ++++++++++----------------------
>   6 files changed, 385 insertions(+), 369 deletions(-)


> +int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
> +                                        uint64_t offset, uint64_t size)
> +{
> +    RamDiscardListener *rdl, *rdl2;
> +    int ret = 0;
> +
> +    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
> +        MemoryRegionSection tmp = *rdl->section;
> +
> +        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +            continue;
> +        }
> +        ret = rdl->notify_populate(rdl, &tmp);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +
> +    if (ret) {

(Pre-existing, reduce scope?)

            RamDiscardListener *rdl2;

> +        /* Notify all already-notified listeners about discard. */
> +        QLIST_FOREACH(rdl2, &rdm->rdl_list, next) {
> +            MemoryRegionSection tmp = *rdl2->section;
> +
> +            if (rdl2 == rdl) {
> +                break;
> +            }
> +            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +                continue;
> +            }
> +            rdl2->notify_discard(rdl2, &tmp);
> +        }
> +    }
> +    return ret;
> +}


>   void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>                                              RamDiscardListener *rdl,
>                                              MemoryRegionSection *section)
>   {
> -    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
> +    int ret;
> +
> +    g_assert(section->mr == rdm->mr);
> +
> +    rdl->section = memory_region_section_new_copy(section);
> +    QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
>   
> -    g_assert(rdmc->register_listener);
> -    rdmc->register_listener(rdm, rdl, section);
> +    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
> +                                              rdm_populate_cb, rdl);
> +    if (ret) {
> +        error_report("%s: Replaying populated ranges failed: %s", __func__,
> +                     strerror(-ret));

Pre-existing, should ram_discard_manager_register_listener propagate
Error*? For example the current caller provides an errp
(vfio_ram_discard_register_listener). Can be improved on top of course.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    }
>   }


