Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317E370D43
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056644; cv=none; b=d63eEpf1KSl67s0MdCPOXUBzGPOxyTIfhRWHObjXzfmDbCdvw/OvkNf6q3jqMyCLrypB5/jZw7DCSihvks67MjeJ1UzYtGTmqfdnkLvCoG/nKCo4wqN0QhBtSQPmnCmSei5EYzHuhwzzLvDx+en8FPTKh8hdX4aG/4M/ZjnEbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056644; c=relaxed/simple;
	bh=E9w1IKAFIcAqw1xJxYAe9jjKVA0XB3nWgkMqdnNQgtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1bIiy1Wif++E80gkkTfJSu/u2C5smv6KJICmQXWJrezRnQl2vAkv2WaAxmIOKgEVM4bTXc4qAaldnFHoXAHjx0gNrm8BjH1/K38pPR+aZ+725lq52xjmaMCC0NeucAsFf7slk01Paxt2BNBNyc2dJIpfprPZPHvRhUOvappLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZsL+Y9x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xtzuaekp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZsL+Y9x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xtzuaekp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631E9xeE3675760
	for <kvm@vger.kernel.org>; Wed, 1 Apr 2026 15:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h7yUWUv2PWwRaoiut2kdNPq7
	/5OKlL3IhIX45mSsbCk=; b=EZsL+Y9xRH0dW5XD+Fo5XD+UxBDrThOuUtRCKcJd
	vHpsgCL3covzPncddm2+brjS13rA88R10wuhFu/iyR5gAbQ2Wi6m2MwVQe1iFyeV
	hrHe696mrLgqtssGpCprwCqRjT7KS20lQP/NXqI3q+0Fy0FgG7ivgVUoNqhgtIba
	rwmcB+cTatF3z4oMd75LDwrTidLr1Cy6uJqCb6PBj9w1MmBX7NcA16sXGFkOUhSC
	E44/Gj8fDM3HylJTtzm2/Y+k8opXVHPS725w8rHyLlLH9CQ+oMXkUn9S3nF55TAU
	GCpUblbeD9xManlvzMzWbCuxhwRNkaHNZLNsK+zXePpELQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d94vvga20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 15:17:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so13138450eec.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775056641; x=1775661441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yUWUv2PWwRaoiut2kdNPq7/5OKlL3IhIX45mSsbCk=;
        b=Xtzuaekppat/q0ODJ3LRF/oX2ZSXRpJmOilPzkkxwTn6dGUuA13LY9o+GZ+qRTxuhA
         ttAvj0HMa6F+tyKanveiLWI1Go0dG4MkM+8umnQ5YP8x7OKQCykIQQmumtU83T/8vHeK
         ERGro2uX2MQjNHP3yFsa1e/0Yb4LPY9yXYQ8eM4MrqtUX+l00ob/q9y7lidUTGlZg8hF
         B1LqkYShBAP59TSnK2wwrm86FvTeOVaD52rHOr4camGJc6eShVvj+d6EMjbdK7CD0bUI
         uTq8TJp5LmD+Rnk8Z+xXk+diy03fle/e5qp2CfIiDjcXfU7LvNt6sEGkOKxlAvjCpYdh
         WBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056641; x=1775661441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7yUWUv2PWwRaoiut2kdNPq7/5OKlL3IhIX45mSsbCk=;
        b=iuaFiTxIkm4O4ZzPgHK/0cNlGbhctPI2/UJ9Lw1d2tqFYdw421wdlU2JRFXcc7XJ7v
         uycpbL7UKrrQezrcdqxIDonnJAaqBQOrHPvEBUcyWvqoNxSuoyctXH8RlUYrCc+/Ratm
         3ub6cQ5+z1pOyCOAqWDVX9325NUUEr47l51CEyZxZp2wjxfjwd4KI/wC+yBdWjzd1Vnu
         Xe2cvfDQRcOkRHJLYxNMDJ7XmvanxZca3fuT/vhvRKM5Sdy9tSXOcSRZvkfXouawOFM3
         WkssuJRpjnEpaZ5Ma/HDhafQDdSX4hUegnalWIn0Ju93ezgTIFhhJex0TfWonZD8oeof
         orEg==
X-Gm-Message-State: AOJu0YxyM1ZEfV0YazM54C0xpoB0ZHOehYvl87j9so0+f+uRDhGShn/f
	HVjDZVttZbJOvBPgB6aWLHU7tPPusJhoAJcIfYz/XHpr9qJhf30PdNWqNE4AzZdicrwzbsZF96g
	kmc4tzHY7SeLAuULkN9NG89Z/q2mCdZDUAcDaq5+5MUzZA1SwKrdNGHs=
X-Gm-Gg: ATEYQzw1ogAw+W8ac5D7e6smwbsQvSRbR7zRyKgLOjYW/VHaYOZvT2XLS+9wYnob90m
	gS72GNfOYsSEoV9//NNnYC4pP1EVO6Qfb5BjblETiMreF7hUfzvrJpwcgc9JLjWC6fqtfpRtR11
	/IEo2QiACGq0whnGfS3fuho964XNwEOIro9J4x8A1bYzzlH/sEycCWcIFE9WLhzCWJF6VLvTqz8
	ypYc6+xvknfFXH67vpBl/0sLIcfI/Old/AE18QZEKpk5DAtMc8ZyLdxLeoGhiWronfIMbvk3SSk
	cQQdTlqZf1saduu5W/neMCVtuuuluYN/84scZedj1esh2MTGyPDM3m99UyPq58CqNUYkwQ4MrL1
	IMHWeGUPd1r7ER9+EJL2XCN3r6tImtOk=
X-Received: by 2002:a05:7300:3aa7:b0:2c9:ee15:a0eb with SMTP id 5a478bee46e88-2c9ee15e80emr740493eec.33.1775056640817;
        Wed, 01 Apr 2026 08:17:20 -0700 (PDT)
X-Received: by 2002:a05:7300:3aa7:b0:2c9:ee15:a0eb with SMTP id 5a478bee46e88-2c9ee15e80emr740473eec.33.1775056640094;
        Wed, 01 Apr 2026 08:17:20 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df8942sm14681eec.2.2026.04.01.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:17:19 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:17:18 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Zongmin Zhou <min_halo@163.com>
Cc: kvm@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] riscv: Add BFloat16 extensions support
Message-ID: <rjc6p2qupcx3gly5qgbz5llt4qxntu5spgjcfvbyijnhpvi7wb@itvc7tka36ku>
References: <20260331094614.123614-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331094614.123614-1-min_halo@163.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0MyBTYWx0ZWRfX1lL1a3vH3w+8
 Z9wss/73IQjnX/+R0VE+TlZmgczd88tVxER3qlOrQn04PKnQ4gUMEYvdcqPxJ3g+K5zp7LXRPe0
 ScG2lC8AriECe/91AE/LPm97UMR+UDim68/MW2uoVUGxD1c7927JmMIdcEr7SsYEZj8g2TNPXDF
 feI7xVNiZGrSOiJTVErO9yZq6ecvMb2taUxvwzvzJ1jRyZGeJhOJh9J+ovfVeMu7HrdF/UU/9Gh
 x9OFCR2ngqtCmYHgStu1rHRKEXu7/irVc04rUOfb7c5Iz3az7GL9TeEYpakfj3aQj0JojRvbQMt
 5zIncXArzhtZGeJFjrRQKed1J5abPfv6TyN7mRZs1h5DTS5JfEHGebBJm155K7KKBlryrpUJKgx
 F/P1+p+beF05/8Fji8jpfYkzZK2UhHP4Bjo7Kl6kxCD5eSCxDTZF02aPM2cLnUna8ADlIdspmsM
 LdODra7YIGYH6QH4Mog==
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=69cd3701 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cAVfIu9dZpYJDgIh480A:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: o1CrYCumQfQtbt6RtRCXcQnXeZDnugwA
X-Proofpoint-GUID: o1CrYCumQfQtbt6RtRCXcQnXeZDnugwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010143

On Tue, Mar 31, 2026 at 05:46:14PM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Expose the BFloat16 extensions (Zfbfmin, Zvfbfmin, Zvfbfwma) to KVM guests
> when available in hardware.
> Add command-line options to disable each extension individually.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>  riscv/fdt.c                         | 3 +++
>  riscv/include/kvm/kvm-config-arch.h | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/riscv/fdt.c b/riscv/fdt.c
> index 510641e..2368c19 100644
> --- a/riscv/fdt.c
> +++ b/riscv/fdt.c
> @@ -55,6 +55,7 @@ struct isa_ext_info isa_info_arr[] = {
>  	{"zcf",		KVM_RISCV_ISA_EXT_ZCF},
>  	{"zcmop",	KVM_RISCV_ISA_EXT_ZCMOP},
>  	{"zfa",		KVM_RISCV_ISA_EXT_ZFA},
> +	{"zfbfmin",	KVM_RISCV_ISA_EXT_ZFBFMIN},
>  	{"zfh",		KVM_RISCV_ISA_EXT_ZFH},
>  	{"zfhmin",	KVM_RISCV_ISA_EXT_ZFHMIN},
>  	{"zicbom",	KVM_RISCV_ISA_EXT_ZICBOM},
> @@ -79,6 +80,8 @@ struct isa_ext_info isa_info_arr[] = {
>  	{"ztso",	KVM_RISCV_ISA_EXT_ZTSO},
>  	{"zvbb",	KVM_RISCV_ISA_EXT_ZVBB},
>  	{"zvbc",	KVM_RISCV_ISA_EXT_ZVBC},
> +	{"zvfbfmin",	KVM_RISCV_ISA_EXT_ZVFBFMIN},
> +	{"zvfbfwma",	KVM_RISCV_ISA_EXT_ZVFBFWMA},
>  	{"zvfh",	KVM_RISCV_ISA_EXT_ZVFH},
>  	{"zvfhmin",	KVM_RISCV_ISA_EXT_ZVFHMIN},
>  	{"zvkb",	KVM_RISCV_ISA_EXT_ZVKB},
> diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-config-arch.h
> index d3e1f56..d56f9ba 100644
> --- a/riscv/include/kvm/kvm-config-arch.h
> +++ b/riscv/include/kvm/kvm-config-arch.h
> @@ -123,6 +123,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
>  	OPT_BOOLEAN('\0', "disable-zfa",				\
>  		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFA],	\
>  		    "Disable Zfa Extension"),				\
> +	OPT_BOOLEAN('\0', "disable-zfbfmin",				\
> +		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFBFMIN],	\
> +		    "Disable Zfbfmin Extension"),			\
>  	OPT_BOOLEAN('\0', "disable-zfh",				\
>  		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFH],	\
>  		    "Disable Zfh Extension"),				\
> @@ -195,6 +198,12 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
>  	OPT_BOOLEAN('\0', "disable-zvbc",				\
>  		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVBC],	\
>  		    "Disable Zvbc Extension"),				\
> +	OPT_BOOLEAN('\0', "disable-zvfbfmin",				\
> +		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFBFMIN],	\
> +		    "Disable Zvfbfmin Extension"),			\
> +	OPT_BOOLEAN('\0', "disable-zvfbfwma",				\
> +		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFBFWMA],	\
> +		    "Disable Zvfbfwma Extension"),			\
>  	OPT_BOOLEAN('\0', "disable-zvfh",				\
>  		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFH],	\
>  		    "Disable Zvfh Extension"),				\
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
