Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED09426687
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896720; cv=none; b=dec4nOIwnYVSuhVrZQTvU4j1bkpCCE+MOFrqHwdPZe4ujEwHObvxnk8M4hPIW7fg1t3PsWwPllH1N8R04Qj5oZ3xaFV3UkiXdE04mH4TYX+r281ir+FGXQEcG0Ex5Pr7xw/k8gdMVl6kmcSao9YhvmPW3yG+d3iI3iAjtQNGMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896720; c=relaxed/simple;
	bh=UyFTo/w2M+a3Jns1IeE99BbPeqspH1jAjfYFH0sjf30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ8p5CkexpCEvcGq9Eo4sY4NyWr2Tie8kB+AY/ekduY52sgTMtwFBd+Yr2eDqRy5XHcPnTbHkKTpRVYuNzg6VjPS6amaCvsE/FYRz8mbVPcQmUviPOYEVAipJQqV8krpS61QqEX3DRpxN0dlVhaFFizOY24MWPzRwNtZG5faC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+rfGcjE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SljQj2iz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+rfGcjE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SljQj2iz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RFJ6ib2282549
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/CAOuwABW/NK0zT7PazBOrFx
	nm1aaFtR/UaMUOazE7M=; b=f+rfGcjE/MvH8t9xNntcx8C7P7IfG8DTuuzgOCkH
	I03Q5Zuf9XBmluzJN21mXjtcHKeV4X/vCJ4vtrVNrWGyM4cRmgh9TaiCWe8k12wo
	Nd5MgZXlVqSNdPFv4JsuNagnvvFVzQ/E/rvrUi4DBIjTmxcypxpNYzh58HzrBIYM
	fmEOpQLZrSu539xc6h04TM3o1gCIynTdm9VIDMhsVF+IDHUKfSGyI742Cz/NuXdn
	35oMa9wu0ZiBanVUadE7rybAeSH11Zk0syW1sSSnqG4nnn5YJ4MI2lOrQN+kJysD
	9ly/U640HIBbNkuJK5lHjNMZs5hcVZAIZO+Xx9ikyEEp6g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edtvct84t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:45:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30457ff05b8so4751688eec.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779896718; x=1780501518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CAOuwABW/NK0zT7PazBOrFxnm1aaFtR/UaMUOazE7M=;
        b=SljQj2izyTaBNEiumgCOrIHoK5WSnK3JLVjvChwrwnd5VqVX7WehpIbqmJw9BCTHL4
         j/DtUigHlJv5b+apa3YPZvQ4lnEspDxOA5jdfnRR+ejtB9Q+3HNnDV1HpLWQgKW9tC/D
         OawLVf+Ic0anSJpUvE0cjkgIfgq9AF50mFE6vus4khElhFoWbbqER5vNgRJUcL7pc1Ay
         zZwxHJZ6g9fCAYZBaGtt3JrXGjfJCQ14YScdbM9VflzUgewrivrvgRQzkLualu1zPGD2
         E0lCQ2qChNw8yUY5xAfwPpfPTiNhLsDrjrLshLldzL7Kc+44TqxzLL7jMkTB6TuPjOgh
         6T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896718; x=1780501518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CAOuwABW/NK0zT7PazBOrFxnm1aaFtR/UaMUOazE7M=;
        b=cpPwpymG6CUWudPVulC1oQb8JIR+/Z5m6L0dW3HXMPX/K/d9DIGeGx1CM2wGgW4j/o
         Cp6OfTij/9E6Fot559m9y9v/NvdBTAQYWBKZGPMZYsbpfM8In93JU+ypnjvIljvmokiX
         AnIbqo8AmVOWFyIyxIF65LdL2fAV7KkcV0C7s06n4a4sRGdOIQCs7eJkDO4KTbRJpshS
         jPcVVzg2myV+Hka8pTmzK0MLjbaq2Ztv/hrnheOFxOSTwVDL3oIXWW9ttMfc/2wAXBP8
         QR0RghYW8mME1UG+oQ2GeCAVEMzlXMecgOZDOWkCDWA6K11qgnI+3PCAH30VY7yXvbkJ
         82Qg==
X-Forwarded-Encrypted: i=1; AFNElJ93HCO77tHpW9ltiI6/jyE4tQlkTAsuhWvLfTU1Yq7q9IzICYabOif3Ka4HYqPhZqpi53Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVMgYvP1huKH+/4v4KxRnHHrRPdcobyPcKM3TpgGijhXxMmDo
	bUNIMCy0cr2LuTRVMsvPhPAlPO4IyEH7SjEoXxRmRKkM7eOcW91gwr7ff/N6GNrPzYvfbQd/VPz
	V76NIy1LW8NHrTguZ49a9E4AyPHC8ZefHxIkLz//61YLRyFGGRbLq3U4=
X-Gm-Gg: Acq92OHbuWjoCeFm+trAgW94HtEHKtETMXjuSXpXO00QeMeZX9IIfaTXnSaqwZgV+FW
	SywmdEKQRZw/Tp2S6H0ogrbxVm7oyVqlCyykrOP9ydjV7lrsypKVbvFpc6z43rJ6pF3K+Ul5G2D
	ls4N26VMxcv/r235s3BpIbE0p3FcBj4hg7o3Gr4YLJf33EdWZx/PdLALMmHa6qUrZnu0Y2O3Hxi
	xVF2+xZHsnmA9s40/GjNvGwbWvDQKiq6quNM+eDUpD3HX/J3GsFXjjUY0UTllNcNpblNfgOjNwa
	4It5qILmzyJEdUTzM3pLRQ6ZxHLDbuKi/uvX6eFtXXTXab3LM2msot065zu0OZuzwY2OMkRW+yy
	bic5dyGa49XHfg2Mxof7G5tFy30PoQFI=
X-Received: by 2002:a05:693c:65c7:b0:304:562c:2338 with SMTP id 5a478bee46e88-304562c3085mr5987651eec.14.1779896717867;
        Wed, 27 May 2026 08:45:17 -0700 (PDT)
X-Received: by 2002:a05:693c:65c7:b0:304:562c:2338 with SMTP id 5a478bee46e88-304562c3085mr5987616eec.14.1779896717248;
        Wed, 27 May 2026 08:45:17 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4af0sm13044572eec.3.2026.05.27.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:45:16 -0700 (PDT)
Date: Wed, 27 May 2026 10:45:15 -0500
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
Subject: Re: [PATCH v2 02/10] riscv: hwprobe.rst: Replace tabs with spaces
Message-ID: <4otlnil7qj53dzlbvu2wd3gvzzgs5cszo3merkcb2qbbiudw5n@4i2k47coybf4>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-2-21c5a544f1dc@riscstar.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-2-21c5a544f1dc@riscstar.com>
X-Proofpoint-GUID: e2yHD46FYAidcNRb9Jb1PjUfgox8XeIF
X-Authority-Analysis: v=2.4 cv=CY84Irrl c=1 sm=1 tr=0 ts=6a17118e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=p7TuRdreTiM3c_8AigcA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1NyBTYWx0ZWRfXy7EDNYAMF6Tk
 XPN37TkJslqhc7NDmBy8StilRdXanAhz6sdgeNJCmHX7cvBFKH1MchxK0SUxtnf/mO+KQRyAAek
 BPfLg59Xs/hpN5V1HV1Q9gta5hPEn5eopN85WwFNli3PW4ilfKGEJLIOTFm/xj1i1wKJxxwjxGA
 rA37mt4MRbIlVvQTeiUz4oSHzvPVtgJXS84rvdZtg4kq2LbM2aLr9gM53uSaqyY/QM/PkHIjy51
 Q4/jUilxcDpuYkNSUwMp9u6UB8JONbNuKH+5yNprHZDYcAAopkHTeKkk4X33nDhupW0XMTo0cAz
 8JTuwiQFLt1ixpsx5LhlYou4S/qtxmzUkDyNWc2gJVbPTn/ERtjGuJmcbV/c6pJCzyjFePT+4wC
 XUR0zHAK+BiFFCj8L0SaJFn5D+wrYJtqiEAAI8TIbcR67E6p6khV6i6LmLlihAzPTNNwE6KOYGG
 ZLHLTWGX2AiNQkhJ63A==
X-Proofpoint-ORIG-GUID: e2yHD46FYAidcNRb9Jb1PjUfgox8XeIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270157

On Mon, May 11, 2026 at 09:34:47PM -0400, Guodong Xu wrote:
> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> A handful of vendor-extension entries indent continuation lines with a
> tab character, while the rest of hwprobe.rst uses spaces. Replace
> those tabs with spaces so the file is consistently space-indented.
> 
> Cosmetic update, no functional change.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: No change.
> ---
>  Documentation/arch/riscv/hwprobe.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

We could just move this patch to the beginning of the series and also use
it to make all indentation consistent in order to fix the consistency
issue I pointed out in the last patch.

Thanks,
drew
