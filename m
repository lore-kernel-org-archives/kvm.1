Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72937C0FD
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897216; cv=none; b=V6mOFEkyuF6ShMAa8s4rmKdn7V+xhsP4wamrIF+QGNvkTnP9IbbyyMz97WVDvkP0ZJAELHQb0Qiup11y8WShzgd0TFUJr2ttO3yIMtk/74a3JHAmE78Rht4HfyRo9Ep+uKSFcH9BQJ9ZLXxCCrDkF3iiNlOTmxy278ey+x1sgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897216; c=relaxed/simple;
	bh=aMOaOXxbn7uzKZEZSSEH6o9GWFeHy6At97V7ylHYvB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWC+R7tpmE+2yQbk2cbJP/8u8aughb4mhAx6DdXQ9Y0wJS5hjmpYS4CSAswtkabO+Q19uXrVzxtRA+ae8ydyhV6iVTpbQ6ToaRVoo3mfWNlMUz20f0rGkL/vCMLEgrB+mwg3+ar32NWniI/PnX/kOzXxIgVhhDABNtBO3DQR9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gQN4r0Zg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i5XiYf5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQN4r0Zg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5XiYf5k"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFjXRV1176638
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TjJldvT7FSi/xrhKmKtEzNTk
	czqnTLHADBywYWMgN28=; b=gQN4r0ZgLx+XsiOlcrE29Zz5Vl81aCXbacw27mXF
	g38Vz5TPdBTqq+ezM9Jf7bCtfCTz1kxPsnUYUkLf48k/abCqUCQrHWtbhPVlQEqf
	S/NcU/DuplQEWDep45FZIH+6ITPYc4gPCzJouApBCxxZ1Oxav37U0uRWN0MQ8mWf
	FDe5k4SXcHkDEt1k1bHURNPehZHzxk+CIcmtMiUFZ/6phyOOcxhmdflMHqONS+vD
	pTWCS1Un93n210sb0A+nlm5ymKWcVVZPDBKAPU65ulveECcn2RIycvskDx1bpRCD
	EjcbLuK91uAuMKZxxV8NL23EmOhCgXqqZVjJDLOl1vUkEw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edndnk9tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:53:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304ba38f45dso827048eec.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779897213; x=1780502013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjJldvT7FSi/xrhKmKtEzNTkczqnTLHADBywYWMgN28=;
        b=i5XiYf5k2eWQjRwRHtIhgR0v+AEjqBoUbpK5eO8Mh+ukXFetmYO8ciXBjqNNzYBn7P
         wt4fWQVfeGsjsigbLHRQFzilmvwWlNcO+Eeog0l98iDElEy5IyI+rwv1J9MoX6rO8CgA
         pWjhTvcc97jp3sIhWM1+lV9Bk5hUUeQQziw7Iqiue64mXCRNvhoXxCMHntLQhxR8VOYv
         ONiABET11ZN0NeH5JTuPh9m9MEc18OFpq5Iu8DPTq3JvftmRkfFpMGT2NjqwhZEovHld
         n2afYGVQpB5QLEeex1M7iMJoTDDthztCAWX+1+RQdnv46575ONw68LPVYoc1AOhX8chk
         feYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897213; x=1780502013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjJldvT7FSi/xrhKmKtEzNTkczqnTLHADBywYWMgN28=;
        b=Nd6hIbQFCtz4fwV+3FE3GyeB8b76pY3XTsGQfGwaBfVvefA5T5yFX/sHp6xyIxcZjs
         9P28Rjd1sI+SWD9K7Qj5AvVscZhbnJQeraw1cfu1tiAKHA/o7hrzL2hHeIvEDcJzQOyO
         sxJ9uB8UmbK8SBixeO+JNNmSj6iqhIqz6NCTaM/ebbk2pxH6v8j4a0qrFuHZYADhel+b
         roIGiYak+bOuh5OLuJsfXJBDnzGu+v6oBe96QiESILw3XF45L70AAdrMjP4A88YUjAzu
         u9V1iPLBeX4Ub1i717LU+HFCb8NEfEr9njyefhmCBSEpYIk+HdjUkeU6Zf/rARka8b5n
         7jNg==
X-Forwarded-Encrypted: i=1; AFNElJ+5SPs+lFZ8y+cFdX57NNAy/V8PbUGVL/UsC/Fl5QLihBEq65Nrv2t3TmmpOv/7kdaMvGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCU/fJKt6YWjIj3bHm9r+H/kBsDoqAupB74UKRlQI/4L9mvGK
	DyblU5bSKOcSNcehpTsHlBKByMVtJXazp6dc5sq1u8s+JMzgO5LOeSG84lkR67vWeXPOBsHukfn
	KG0yFb87cpeoH8Jc0bVdk4c6+wI2t8CSuTrxBwDGXBB2miRSzadB+lwA=
X-Gm-Gg: Acq92OEgPrADSklaNNBlFx6Y1H/CzBca2Nxe7jUejJ4E9E1zCJzgaq8djEG5QHltjGz
	/iZocL1fN4Ev+E/1WfQHDo57Muyv9KPL9AaL92ovg3faP2O+MawmugyUlbsKGFogYtBfTU2hO7W
	vwCj5hKWclwzMuWhIs1hrpj8Fu1MFMm6amgVnXhJibJSHOOJzksCkSmCnHoGFSCBsHZ9J+4u8ib
	x7Q2qSUyNP7uspppR8bTRPcoNkcQdJX/fsfYf6X76TinSF+gTw/8iklVAHRRWzHIcbdem9TDAYL
	33cTbfuXL292/+wy40nbZY4ecIH80tpP/4ZBRtP3YnOLj20CGzWUmIKDBAGuCUmXdNwe/YnjqiR
	V8u99ZDZcussZusHg37ZCL1jeTCIlD5c=
X-Received: by 2002:a05:7301:4008:b0:304:ccdd:594a with SMTP id 5a478bee46e88-304ccdd6451mr477553eec.5.1779897212912;
        Wed, 27 May 2026 08:53:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4008:b0:304:ccdd:594a with SMTP id 5a478bee46e88-304ccdd6451mr477541eec.5.1779897212336;
        Wed, 27 May 2026 08:53:32 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef3273sm17889766eec.2.2026.05.27.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:53:31 -0700 (PDT)
Date: Wed, 27 May 2026 10:53:30 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Guodong Xu <guodong@riscstar.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>,
        Christian Brauner <brauner@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Jesse Taube <jesse@rivosinc.com>,
        Andy Chiu <andybnac@gmail.com>
Subject: Re: [PATCH v2 04/10] riscv: Add Zicclsm to cpufeature and hwprobe
Message-ID: <ssov52bc63wlfnrcxbjt56wi2jxl6yzce4lyerwkix5p2xlgri@r5tjrax3nfnc>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-4-21c5a544f1dc@riscstar.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-4-21c5a544f1dc@riscstar.com>
X-Authority-Analysis: v=2.4 cv=PpSjqQM3 c=1 sm=1 tr=0 ts=6a17137d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=ee_2aqc6AAAA:8 a=h0uksLzaAAAA:8 a=XYAwZIGsAAAA:8
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=x1z8LLhTheR_cLHN9ccA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=VOpmJXOdbJOWo2YY3GeN:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: czLt1MeAU7qe_kzn03hFwq4woEn9JWJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OSBTYWx0ZWRfX1qTWI3EbeWLa
 +Z4JyW4SP+AJSk/cVDtcfz+OuUcOMXqBU65+hikyzxD9/nw7lbeWnRvsZfYDN64Debc2vM2Tcqf
 2zH/zF/ij20ETt7EIev6DnebnRKpnkP+wSE081/FiZso76LbySKK6ALTkNe69YW4DCLN/hsKUKM
 tjndw1IzSrSnqi6xAFxxbL3qmbmsIIuSQcW1Mvzz/FsrwGSk01oTQjq7r13yv+CVCgDyqPU05qI
 zlgqMx1K+lyCrn1B47Sm6R/XvdI+iGZ9HDtfFieGKAuytIXbFx5MglV1qHoCW37gnQkAMHLgo74
 /UdZAGET5lGJo6JCHeK37HIjXcoybr+xOv8JuW81/fH3B/5ea+1fAICQPew/FZmjAEZeUieV9tA
 Xo9DBAmc8Iwxs6vTLUkrgcWmi3EaoalsAqpp2eG0AnpzSHAkUEwL3xKy/NwNntE5YD48wQBGq1E
 5aqESSfXu4+XwcxJx/Q==
X-Proofpoint-GUID: czLt1MeAU7qe_kzn03hFwq4woEn9JWJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270159

On Mon, May 11, 2026 at 09:34:49PM -0400, Guodong Xu wrote:
> From: Jesse Taube <jesse@rivosinc.com>
> 
> Zicclsm requires misaligned support for all regular load and store
> instructions, both scalar and vector, but not AMOs or other
> specialized forms of memory access, to main memory regions with both
> the cacheability and coherence PMAs, as defined in the profiles spec.
> Even though mandated, misaligned loads and stores might execute
> extremely slowly. Standard software distributions should assume their
> existence only for correctness, not for performance.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> [Rebased, rewrote doc text, minor commit message revisions]
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> 
> ---
> v2:
> - Rebased onto v7.1-rc2; moved ZICCLSM to IMA_EXT_1 and
>   allocated a new bit for it
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 4 ++++
>  arch/riscv/include/asm/hwcap.h        | 1 +
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/cpufeature.c        | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 1 +
>  5 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index c3bb26d70c748..05f746061f679 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -289,6 +289,10 @@ The following keys are defined:
>         defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
>         load/store pair for RV32 with the main manual") of the riscv-isa-manual.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is supported,
> +       as defined in the RISC-V Profiles specification starting from commit
> +       b1d80660 ("Updated to ratified state.")

Sashiko[1] points out that now that this has been moved to IMA_EXT_1 it is
no longer the correct location.

[1] https://sashiko.dev/#/patchset/20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc%40riscstar.com

Thanks,
drew

> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>       mistakenly classified as a bitmask rather than a value.
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 44bf8c7d8acc5..e8f4a7dd96a93 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -112,6 +112,7 @@
>  #define RISCV_ISA_EXT_ZCLSD		103
>  #define RISCV_ISA_EXT_ZICFILP		104
>  #define RISCV_ISA_EXT_ZICFISS		105
> +#define RISCV_ISA_EXT_ZICCLSM		106
>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9139edba0aecb..6819df159c51e 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -116,6 +116,7 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE	15
>  #define RISCV_HWPROBE_KEY_IMA_EXT_1		16
>  #define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 0)
> +#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 1)
>  
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5cf463570229d..4b4a8157277a3 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -502,6 +502,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
>  	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
> +	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
>  	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
>  					  riscv_cfilp_validate),
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index f8f68ba781b45..9cf62266f1890 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -205,6 +205,7 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *pair,
>  		 * in the hart_isa bitmap, are made.
>  		 */
>  		EXT_KEY(isainfo->isa, ZICFISS, pair->value, missing);
> +		EXT_KEY(isainfo->isa, ZICCLSM, pair->value, missing);
>  	}
>  
>  	/* Now turn off reporting features if any CPU is missing it. */
> 
> -- 
> 2.43.0
> 
