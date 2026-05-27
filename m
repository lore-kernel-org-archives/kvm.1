Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26189436347
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896532; cv=none; b=UqdpkAALiJAgLcpeUHRQXisTu6axITV709eDZRifX504vIgBJsAH6nWYej9miA1aq4bTxACfrEOHj0UPFGjSbsLlWvGVzzxlBJFJYJxFHhHtuvbeqLNscFETtayX9Y8oaltdn9QLSJ7/1gfqcEusgfWUWa9E7RwxvIfe1jCz/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896532; c=relaxed/simple;
	bh=l30Sh+8l3R3eLexGTlydQgvg+2LSMsG8ZKeJRgfYqig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKATRrgtukmgzKQ6+kfznDRmYcDsITWMbJaUGRABq7iU9uvzUrFSSxt5i2Ktra6bybYoHXzE70gjUmOaKjjC5RnPlWoMlLBukFTjpHBDgmMGKlk6M6PSsTGuOCVuk1M5wBLRTqtoBFUsj5zT1heMsoxcilYepH4xYA7THaSeMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0jWXAli; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJQVX4fA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0jWXAli";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJQVX4fA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RAS2fQ1575126
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yrZ7fByGdAG1n0GYJXTMCaPm
	clgKYcrSXuiTG7s2eLg=; b=D0jWXAliEPaG0t86Jlq+EqqrT8IlZcnPgJ4As703
	R9IVbhvNt9posO8KWP+BJtFQ8jY7DAwrZBy2Nq9JgsuddOrHjeQJqswkdTbqJn0s
	bBPvWvxryJZXDM8S3Hyxswk6ZTCLLH7cUzb26Vnx8Adkzm/QyC/0QH9Qp/nnvgjM
	BOyATNxcOn+X2DdOyKAH5N9pofXFXeq0BSi8mOD6oZRDfu6BoZodTjRK8YQdIB9X
	/04kwDyCQDX++TLOwGPSIHtQlsqnYkAVo/cbwZi+M5h9fToOsWdJJzMPO0DH5AmF
	h/d7pa3Ly1iz0H+AHhBrH5wAuU7cI7X3GTeZQUdF9eNb+Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxvph6hn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:42:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdd327d970so7164950eec.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779896529; x=1780501329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrZ7fByGdAG1n0GYJXTMCaPmclgKYcrSXuiTG7s2eLg=;
        b=PJQVX4fAnFNSvfJz3Lk2wfEglXJpoCbeRVw9y/N2hp0COLP7wDU7trE1CyxvEUelFn
         thlbG4mKUxEsvodpffDozrAbWuoPugpRV4Yg4m8IFGi0hYgrs4Sw0OnNYpXcs/Xnbcx9
         Qipd36h6cLoDq92VDIuIdBQ4ZKgM/f9R1rLHoHZDk/JYFESFMAMw1iYXoSE2rwsa+ox6
         1jMrWEhskA9OXdQZcIncTQzMvXs/V9EW4fEFOM+ZJkxOYHrTEvmfhraXP8tEgAlqXDU+
         dS7Axo0qFvyAPRifBiyriadjJmNBUzGroHNNe3obJuE8gTUWhGH45nc+HTHwYEjj4Ni2
         EQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896529; x=1780501329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrZ7fByGdAG1n0GYJXTMCaPmclgKYcrSXuiTG7s2eLg=;
        b=F20ySOwpqFuvhE8P8m2M1lBWc2vZmX9dgASTCLkNadxliB5ENGMmqPLqNUPl5Mig+W
         OgXlyVNLkqRaeKlHldr00G5n+AVUvi+qF9K0HLVzS08vPLwfRs4q/MUV4IR+W25eY0Y0
         TA2yUDTWI+nyTHIa5RZ2uzodXls8ykmmE/gX8xAMz2PqpJaVaCJhMjvkZFIKKDoVOHZC
         EE+oHDey6aprwKterdmcmHqqr3+AOuyNeuqF7AfE5UxI4gI2vYTpuhczmzJLr6KaskCH
         F56xrxdyuUXUfL8XTiFX4cSJ36m/djKN3c2AelPrK91nPfWayJ5e8kS4Ah6RvHtbEQR6
         slHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jz5qk9xfvgfYjNkNAu/TM2/Ou5DWzj+KRU6d4FLsKH7v973h5Jm0sWBWu+oEslLjjpUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByzQF4wpbeoOd9+z9cEP4yrKuk7Rr54skO3u/i2etvgSWA4lw
	fbIf+PQheYd6ySWWPQprMsYWpqMPNW/MErHzo/hxQa1lP9pQxJYfmaCE/b3i5Rwl237VplnrxgU
	kgBrv7wmrP0oIBuiNVPDDErYpW11PFGuhNBXXv6qzLh90FTs7QAVAf9Y=
X-Gm-Gg: Acq92OECpDLkcabbrMkg6/BnKry8ufMCyUHBWzLFMDIoJSGiO4oVvEpMRvt6OLk8hMa
	KVbZM/tx0vKTbvLBN5U8PX2BJ2ParkBBT0YabskmUZPFIuNM91pSmJHgN+/COw9ZzoJRIYO5dRj
	bTcXRswD8E8uZ7k14+UeaAIG9UKpPwCuVQogJl+NaGrrUdKc52KszyLl8FjzmJrqIQdEhGa3tat
	iP4q6zE9kPVKymFYEWRAKejsMchKaM5eW5we0C3Lhx9AkZAKqVw35fQAS2Nx875zbczSZZBvFKm
	GDgzqHRfGqlpl6lAcxhr3AvBid7qtoMwSUEGLUsKWMlG311kgCQ6xCPxSSuxVXR6DNxR3af0918
	V+sZR5LtKl6yf01Ug4vVAR98THh9MmmCYl/MiTcvHGA==
X-Received: by 2002:a05:7300:2147:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-30430f5a25cmr11505067eec.14.1779896529217;
        Wed, 27 May 2026 08:42:09 -0700 (PDT)
X-Received: by 2002:a05:7300:2147:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-30430f5a25cmr11505034eec.14.1779896528627;
        Wed, 27 May 2026 08:42:08 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm12480494eec.26.2026.05.27.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:42:08 -0700 (PDT)
Date: Wed, 27 May 2026 10:42:06 -0500
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
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 01/10] riscv: hwprobe.rst: Document EXT_ZICFISS
Message-ID: <7ammujmvz7n6hmaseqns2x6nfypc662i6znvsm26rcxcvntdtg@vn4poummj4vc>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-1-21c5a544f1dc@riscstar.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-1-21c5a544f1dc@riscstar.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1NyBTYWx0ZWRfXySx63EpJjfWK
 93MrAfd5wVf6OZND9A+SreL9hDJhG/pZaswzqTV8lDfOqnav4d3/qoLTKq4iZu5BEeTANsRrIsk
 r6dbwmp88GWQM5P0Jf+MPbqyHq0eW2LRRjsFQKqi8N5SLGzO0aCXj8MPn7OxbQl45QhjWmIE1l4
 BnHfKWJ/SdM4seV6mXFpo94mjosdlermdBzcnm/Kqp4s3t3mm2XYV2FJlx0IP7UYWPX9A8nFpRT
 TO8YjlNcI2MbV1xJEXzWkqAdMlW1jnU6i3CB4n8V8W408tJJ+IMofyz9H9wlfnMSAKLOUD2pkSl
 BxLwdcN4o3/60pRuVqD5YtPvFsOruRLnZHseD29gHXoIZpzUNJ7JGCDJuvf5IN5J0sd/udYfL1S
 d0b7YbN2YkymhvF+wnxBOwUXGOlGZnuPTRuQay4XWpobJ2Q/U/1+PU20tjlZy5peCI0hEckbdaT
 J1ILYOUP/T6oe66o/eQ==
X-Proofpoint-GUID: kHEZaui43pA21yDix1_ZTh-uqxfAGfSw
X-Proofpoint-ORIG-GUID: kHEZaui43pA21yDix1_ZTh-uqxfAGfSw
X-Authority-Analysis: v=2.4 cv=VqoTxe2n c=1 sm=1 tr=0 ts=6a1710d2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=MJPy3T5N_tYcTtQqpHkA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270157

On Mon, May 11, 2026 at 09:34:46PM -0400, Guodong Xu wrote:
> Commit 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss
> enumeration in hwprobe") added RISCV_HWPROBE_EXT_ZICFISS as bit 0 of
> RISCV_HWPROBE_KEY_IMA_EXT_1 but did not add a matching entry to
> Documentation/arch/riscv/hwprobe.rst.  Add it now.

We also need to document RISCV_HWPROBE_EXT_ZICFILP

> 
> Fixes: 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss enumeration in hwprobe")
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: New patch.
> ---
>  Documentation/arch/riscv/hwprobe.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index c420a8349bc68..b1a84ac06da75 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -391,3 +391,7 @@ The following keys are defined:
>  * :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_1`: A bitmask containing additional
>    extensions that are compatible with the
>    :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICFISS`: The Zicfiss extension is supported,
> +       as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
> +       extensions specification, ratified 2024-07.

We have a variety of indentation in this file. Sometimes we align under
'm' as done here, sometimes under the first ':' and sometimes the second.
Not a huge deal, but maybe before documenting more extensions we should
have a patch that makes all the indentation consistent first.

Thanks,
drew
