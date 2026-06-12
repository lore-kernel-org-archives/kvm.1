Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543E27FB05
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248624; cv=none; b=Hof69km3MrqqkK6JnTd0RI+/LwnSqj5XYQMDMmBlCdQU7cMaKLp99nAksyNa7eeJWWQEZ/VaXRF4e2GvpcpJwWYM94W4tTTrSMWOzUwQSAhYc0uTCZhkg37V4ZQDOJxc2oOhZf+x6akdAa24Gjt4anDWBGIlbC6DFuysEr38Xrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248624; c=relaxed/simple;
	bh=9255wrk5wMGVnIalFRmsHgmhN08kHu2eMdLD0vUju+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd0T8bFaptfd+E8uKe0jnDBRu29FKUEFTx9VDY/d2oouMsNEnYxSoTUhWTCKy9reE/C7nttW7uNk3KzFRUcB2eJLnsZ+KIUJ4m5n+Ut3/F3XjoYqt7p0vF53nav+Od3NeIUZdX4hel6tmgfGNZH3GtbBnoS5z2df6AWjoMkOpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AExPkReM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=INa7Vnjq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AExPkReM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="INa7Vnjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781248622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
	b=AExPkReM0dk6X1tXGTWe/Jc/BJ4gz5le7EnSUARVTNO9pDP7fVVgpxw/fHs1lYntVFEkMB
	KfOvdDw2u7bzBJOMhcIy0HV/D15PGg0Tlb4jVelVMbyQHuHzhutCSx9N/XpPF3rn2EcG/u
	WeszPMpztlE59mRcvo6qWWi6Yazb4Eg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-JE9zq6BCN0mrmzh950TWVw-1; Fri, 12 Jun 2026 03:17:01 -0400
X-MC-Unique: JE9zq6BCN0mrmzh950TWVw-1
X-Mimecast-MFC-AGG-ID: JE9zq6BCN0mrmzh950TWVw_1781248620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b61243easo6858425e9.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781248620; x=1781853420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
        b=INa7VnjqUYFfPnzJTKtoPfbz+0fTX+F47FoxfVPHU1OnZ6bwj4CovUIhg0//C8FFRP
         cS8fZPWvviQFHTgmV+/bzjm/5FUTkJp170BiDVHKUroTqTr3wig1RhtmxBLmM2sJmplf
         qFwcUV2l9LCvociBTIqIc5RjLnups24rli5pH+/q3+lI3jahs/hkNh8+7G6RNeV/8FUQ
         16U6iviUlFT/Y55DBeLQxvJUR/Zn3wIM+CH2pd+gPBuFwbJgHvUmvC0F5HFNBclnT6FP
         Z50KJwvrWW75jXVLeqtX4mSDU+YEeqv+Q2rTWYYDAQwgHBCWraGwKZknGFY7bT68RIUJ
         GAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248620; x=1781853420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
        b=qVEA4/tXvspy8BJlF5UXn05LnBNQfEllsUTL74CB6ReVbVfx0POsPuLID2zJ5mFUzw
         zJgpGOhWhiaJxtCAw9in56XlF1aLTcaGpA72uFo2FoPlRNQZTDmJYkGW4ntjsKuLHDtC
         FS20VOjwFr9WvpGHuyu2/dxoSDdDgKCZtakJIvXeuynnAEEjz4J+NbDCRID8cr2Lp2OJ
         ScCwnBM2h+mkogsC0JBu4QuO8X+ILxSM71fA7LaiCKsgU1eW5R9AttFJ1x1pFufP32wE
         XXaKOAGEgQBy7M/Kx3d5g5rAcg8kjQ0oEMK+R0/w0ingVCyAICjUPM9+HYyfWjkoN/BP
         dUKw==
X-Forwarded-Encrypted: i=1; AFNElJ+G+jaWjdDFqthS+EUmYoNsletyAe6GZCrHjYNWALcw2WGqXrR5wHEC7hMylN/TiK+KVT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVQMG4x/gzDg42KsjbXMxkEQ2mi8xXDm31g44nYLJmHdf/0OQ
	tchoNta3PmSqfXYyhiF6gHRC/xXfEXSRq3YUgsS1lQQoyMfbX7kOWoHqvIgvgPOT6GZOkAraX3o
	lkdnPnJhu2xuWl2i+sJALBQNuLwrrmBbWRAoI4Liad41beilwuckSog==
X-Gm-Gg: Acq92OESNd13y4ptwLed2y75XAJ371Pm6jB/AfQ2rTIvspZzIniVO18vUt0gd1xSKTl
	5AsMSz8y7RJMuqeIIRgwN5E8hZHjrhH9q53N9tzVexpuxFA5VYzC0Bme91OAGgT4xnlmumyF4O9
	y09bi32KcBKlOuiguXqMueJA8rYXltDwL/abP1UIgcJK6F3CgH3pOgVROt11zQd1M5JIYtFXnsq
	Xd/u/pDWuBSRYwCsOYpBvVwvzIh02VTP6vfF6aERLP6U3MPXjuiqz5bDmbNJLCJVQuUCRCGcc00
	SbfMKuag4jmgdMZWA4NuW3Z4KrJF8jDDW9AZXL/yRy8wsPgg72el9FCG0I8XE+vkkoqwSuqRXRA
	19CjQgNXNSqUBF0VbJz7ET56M0MQyNXH6/B0qKUNqIs6rEOJkW+36NeNutf6W
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id 5b1f17b1804b1-490ec4e7569mr16959195e9.18.1781248619771;
        Fri, 12 Jun 2026 00:16:59 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id 5b1f17b1804b1-490ec4e7569mr16958755e9.18.1781248619293;
        Fri, 12 Jun 2026 00:16:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a128csm52846465e9.0.2026.06.12.00.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:16:58 -0700 (PDT)
Message-ID: <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
Date: Fri, 12 Jun 2026 09:16:57 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Miles Glenn <milesg@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 11:08, Aditya Gupta via Devel wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
> CPU definitions for the cores
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/about/deprecated.rst | 9 ---------
>   target/ppc/cpu-models.c   | 6 ------
>   target/ppc/cpu-models.h   | 4 ----
>   target/ppc/cpu_init.c     | 6 ------
>   target/ppc/kvm.c          | 4 +---
>   5 files changed, 1 insertion(+), 28 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc91..3930ef08ed4b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
>   is theoretically possible to use QEMU to model them. Let's keep the
>   CPU implementation for a while before removing all support.
>   
> -Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The Power8E and Power8NVL variants of Power8 are not really useful anymore
> -in qemu, and are old and unmaintained now.
> -
> -The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> -be considered deprecated.
> -

docs/about/removed-features.rst needs an update too.

C.


>   System emulator machines
>   ------------------------
>   
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 26b6debcfc96..aa13654e83e8 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -734,12 +734,8 @@
>                   "POWER7 v2.3")
>       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
> -    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
> -                "POWER8E v2.1", "CPU is unmaintained.")
>       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
>                   "POWER8 v2.0")
> -    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
> -                "POWER8NVL v1.0", "CPU is unmaintained.")
>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")
>       POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
> @@ -918,9 +914,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
>       { "power7", "power7_v2.3" },
>       { "power7+", "power7p_v2.1" },
>       { "power7+_v2.1", "power7p_v2.1" },
> -    { "power8e", "power8e_v2.1" },
>       { "power8", "power8_v2.0" },
> -    { "power8nvl", "power8nvl_v1.0" },
>       { "power9", "power9_v2.2" },
>       { "power10", "power10_v2.0" },
>       { "power11", "power11_v2.0" },
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index a439eb37ee41..ef019cdb1f3c 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -341,12 +341,8 @@ enum {
>       CPU_POWERPC_POWER7_v23         = 0x003F0203,
>       CPU_POWERPC_POWER7P_BASE       = 0x004A0000,
>       CPU_POWERPC_POWER7P_v21        = 0x004A0201,
> -    CPU_POWERPC_POWER8E_BASE       = 0x004B0000,
> -    CPU_POWERPC_POWER8E_v21        = 0x004B0201,
>       CPU_POWERPC_POWER8_BASE        = 0x004D0000,
>       CPU_POWERPC_POWER8_v20         = 0x004D0200,
> -    CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
> -    CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
>       CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index d25f69f13ba5..87186ec32179 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6310,12 +6310,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>           if (base == CPU_POWERPC_POWER8_BASE) {
>               return true;
>           }
> -        if (base == CPU_POWERPC_POWER8E_BASE) {
> -            return true;
> -        }
> -        if (base == CPU_POWERPC_POWER8NVL_BASE) {
> -            return true;
> -        }
>       }
>       if (base != pcc_base) {
>           return false;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b94c2997a07f..78a1c4a8393e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2437,9 +2437,7 @@ static bool kvmppc_power8_host(void)
>   #ifdef TARGET_PPC64
>       {
>           uint32_t base_pvr = CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
> -        ret = (base_pvr == CPU_POWERPC_POWER8E_BASE) ||
> -              (base_pvr == CPU_POWERPC_POWER8NVL_BASE) ||
> -              (base_pvr == CPU_POWERPC_POWER8_BASE);
> +        ret = (base_pvr == CPU_POWERPC_POWER8_BASE);
>       }
>   #endif /* TARGET_PPC64 */
>       return ret;

