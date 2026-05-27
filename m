Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE439B498
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901458; cv=none; b=OncBIkwh1JxU3RoYj/m0Qkm704BSqOtmVe4282+gXQYIA3mTMYl9XvRTiJMOQlc3TEaFjrYLlkw3fhMcuw0q7oneoDBXRSvTl/+ZM07eDZhUmlOSXV0WWDw4HDv/PZrjwfddp/L7dLDKrvpZ7NMQ2TLc69bS1mk0GsYPSmqZdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901458; c=relaxed/simple;
	bh=HsASMyINEQfHno0rsw+42YhTlmX4Nb5LD4aBfiSfkGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqhbwgyAw2Nj9wzIqgZ/9Pt+PeL5nFiKClE87zunV90Z2bjL390vtMYXFvrbbWZFXenVTRixQFc6ToWBnTC/W5iDFy93o9VwgIKlDKJGmtiRbyOBA0PHxi3m4rskbvmHm/wr2iu+D9k4RG8RwXph9h/udbCqggUcggVMLRlmXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BEhQsBXL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CvMZssfb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEhQsBXL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvMZssfb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RGiPtE195636
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6nha1feETo1rSKy37ATFEomW
	axLqzR6X6eFWdjB9xhc=; b=BEhQsBXLxYXh8B8T4cuZBzpDXJy3V8d+KSBqaJlf
	8sMlakShjajq9oljZ3x6QQUTUWxdjaS1K8zrY51pShQoNAtfCHbkF/qRVQ4806fX
	8Awxj+JRtqVusORT3KT+sztSa4ZJ2PoSXh92SrF6LKQlyhDhkCf9XIwov8+bcOb3
	t+lN4BDuP+oC99RaAC3XHQa7hX0pVxJtgMyxkU79vGGYD0FjiVv3YkvMIA+p62je
	1UPexMftSDe7A3quTUDCsQxZwKkysqk+ZtNzIxnIF0Xp4NA03HH7XflYoCUfNSgx
	ddqPAfK7LBeaGvoEanBhjSxltpWq0ekeP06TbBLuE6Gqog==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxce9nqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:04:16 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-13509e2e47bso14495824c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779901456; x=1780506256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nha1feETo1rSKy37ATFEomWaxLqzR6X6eFWdjB9xhc=;
        b=CvMZssfbVL2T9P7QWlFa7kLGFpWlAX9tPvtt1fwcIV+VZP5mgTcmbrIJ9ZM0/lvy+R
         huzjf0ZeNrhplV41tVhJidZhzNV1JaaLTqhhV4Yaz5ArUIQF/8zvCbkEVKoP3b9dxzvu
         PDvQstcqSSWpD+MiSOlzbF8LuBSv9sJQ/apkFA6N7HK2+Rbp6pfwxEyCjPFBJu0ul+5T
         ZGylOJGuJ1mxR2NPqlPWVcFrtF6TqsYsT29vKZnymdCwlmWPLh1Gw3Jg1DzHisfe2oIL
         jXuAJnoHxnDaQG3SmryrGjIL7cC8Yp4ciDZjeMQ7MVRhXLhv4iJKR4UcFYg4wMrQrXVd
         KQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901456; x=1780506256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nha1feETo1rSKy37ATFEomWaxLqzR6X6eFWdjB9xhc=;
        b=SaTL8pslSkR030g4xeosdeY8NoXuyFlAqpgtD9kWHcEjmFA1rZZKoNkShMwcW8IdhZ
         Ws/MYwzj7IerElcx+/ZHEfHthR4DuRciMkLchDD8WeyiNxh3jbrcXKIl/fQI5xinZCor
         b3zbW8cDTwuquppDlkLj3g3Mlc03p5pWa+bJCn4Y7+5v5BJ61OnycvtSRie/xyAJmUk0
         ty/rymRNMu9LIyeaF/U1LCUqVeUJgfMZaH9xj+uDvJv2ccWXdHkR9vRLs2SSdOoiMsVb
         Qw1F/qauobi1KpjK8wWm+Rt/8F7RNTic9OeKNqmUzUymK1L5Pm0BSLzBjAyZIXF9/qti
         GGEg==
X-Forwarded-Encrypted: i=1; AFNElJ9srd7bhyV2g6xl5PAphE+O5/1p2baUz9KINibd++uDdNCX/AipyC3Kb7WxaPlXz6tVKrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2x3Fg8QBhhjs/045+ouYmbr5UteoWbU2LglaGuKApi8Xzbr9L
	eFfr8qcr7ToJtyiIm8g0VDXzxTtaIbf+M/Ix20m/gxp+77HZCD77mtsC9DltPnj6i2n8sNKGwYf
	BH9n937DqLx67njZLBRx1nGUiVh+mAapX7J5V3devJYwryr6/iDX8qEY=
X-Gm-Gg: Acq92OGne5QeiRgZzpiYw2/gvEaU15lejvJhh8yN94UKGHjeXKLNzM8gWWeOI5a0SUj
	e/M7jmgEVE4ogqH5RSFKh7PvOYXgUw437zIqw7/E/P0MwlJN3zdReCHCYtxDiTJXvuRIrGPHCx1
	dN6UMxajqpU7XupLFo4HOgZMcAiTWbaheIrvzCyHj19RkEc4dAf6waw0PO/MkPHMxLoONYmSnsu
	xp46R12bL6CWjhdP/7e8DS8uVpWwzOjwYGxBvRYK8j8qzyi8ErP59gRvPBQZ5c9T1tV1ev5DL+r
	W0Lvy3qaydoWMp1T/p0KH2uhM8FhBL6aqCNEUKPBhMe13zfRsd4TpUf8sonxp89f0E/wlhvu0ED
	eB+S+qM+t2GL67IRJ8iXE2CaJxq6y386waJMCXyF8GA==
X-Received: by 2002:a05:7022:258f:b0:137:6c0d:b990 with SMTP id a92af1059eb24-1376c0dba8emr719574c88.25.1779901455913;
        Wed, 27 May 2026 10:04:15 -0700 (PDT)
X-Received: by 2002:a05:7022:258f:b0:137:6c0d:b990 with SMTP id a92af1059eb24-1376c0dba8emr719548c88.25.1779901455346;
        Wed, 27 May 2026 10:04:15 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88eccsm10819104c88.9.2026.05.27.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:04:14 -0700 (PDT)
Date: Wed, 27 May 2026 12:04:13 -0500
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
Subject: Re: [PATCH v2 08/10] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Message-ID: <bfap4hslksgmfosoy2c4g5qgrhk6ofd72e6f3f2qxpojey5yuc@74jvqlfe3urw>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
X-Proofpoint-ORIG-GUID: h7j4eZB4y74o6ANiRFmc6EKjvDcxKu4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3MSBTYWx0ZWRfX8UI/bQQMI00c
 7q0iod/qJl9z3MxpzXoyICwk74a8Gp0v3lj3Cfetg2HXGdbBUnBT1/j6RRVYqjVR3OpiNBDzECG
 N/T0GlVY0MtD9iCLxS+DGThQjcN5/wCStz/kEA/K6mPKuTJ0QoL6LQtah8RzxIs6QIKUJH214MK
 juo6hPh+93WxlAeRiKwusj8IKFWBEKEONguC5TokEkw4TdeatRYA9NdCsRW45q7kFZL8J2rs68p
 0qCso8rYwiu5nEwJxUwCnXQl1qcOZ+VjxKL77tqA181OETgxDDSM0qBMMR+OrQl1AFnaoiIEHsP
 KYcSqmauSftmsrh0HFehRyqmdtMEIb/9btsTn01ll+p2uGHVYbyb6ALPCnxG83za/bA4meUw9t1
 ckN2UKrwGKlQD9igk/YA2xG4pnhSIR9BYSPWdl9IeZr9bqtu8BOycxRVeT2+JvU8RA5hpeLdLCY
 f2tOVg86vs5lO8EDb+Q==
X-Proofpoint-GUID: h7j4eZB4y74o6ANiRFmc6EKjvDcxKu4w
X-Authority-Analysis: v=2.4 cv=SIpykuvH c=1 sm=1 tr=0 ts=6a172410 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=DOyYl3NULbmlVlinG0MA:9 a=CjuIK1q_8ugA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270171

On Mon, May 11, 2026 at 09:34:53PM -0400, Guodong Xu wrote:
...
> +	/* Zic64b and Supm with PMLEN=7 */
> +	if (riscv_cbom_block_size != 64 ||
> +	    riscv_cbop_block_size != 64 ||
> +	    riscv_cboz_block_size != 64 ||

The only mandated RVA23U64 extension we don't have ISA string support for
is Zic64b. I wonder if we shouldn't add that support too where it would
have a validate check like above.

Thanks,
drew
