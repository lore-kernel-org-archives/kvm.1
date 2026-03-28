Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340433033F8
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717118; cv=none; b=JWQYHXe+oZLOmRJraL3hw/9RrIKVr1Wovscv1rqyW/jtCSGUOVhS+Vyt3O9vAKpnyk8j73UCebYeHeNKlv4JfHTydQIRUa3TXpg/3DyzjEv+ECMuZCL4jBRUUoZjJi6RX9vu3siswalZTLE7Ml46Pj/SQVfvWuDoTY8Dn+c1NG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717118; c=relaxed/simple;
	bh=8wCUthfU6XbvbMShliwKFh9botH45zOIx84BUQr3ka4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1mITzgt6/pZNDZD7x6R2GSzcd/pvWInCKR7JGSrRB7dWyk9XCZV93weRKmlzkjS2K2zD/EJWlnXYVcoq7LW3IWQU2I/++/hmloqbccND0k5S3O1Lqnf0L9sLbmic5h6k/BdOg4tV+5Pd1c5VR+NIj2jQq9T2q2Ev+RD+cSqQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/mS1NRz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzH0stfU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/mS1NRz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzH0stfU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62SDCASr1813544
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 16:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dOXDh1jRFL68kZhVUrzJRyyP
	1HcBqGuF0AHCrWuMDAg=; b=d/mS1NRzQXngfrr5l0/v14SwNRknDeDT8XK1k5l3
	mxhleQfatgmhAAyLv8duLswzX1UyCKwDs2iyONylNiON8LLUBm8fhGQtuWkyWJjb
	CgTXwxk/5ton5D2iY+dSuVWVxyQk6lh0CkoZvavW94oMPqQ1hmhHOdCPGKQZa78w
	nT3dPsivROIKJwn2rdRVATMFtOnetwTK52EwIWr7jig20Dfn2NfLVLlPCywcg+Rx
	jgS5hSTbeKgovtSBygm17g2zOaC/zUxl5Q4GYZBnnMElULmsJodzrMdD6DwARc0M
	OX1ny+CvZnHRfzY57Z6ZOfG0izR/RuvAu7sjvgcTg/FWew==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d66jwh93j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 16:58:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c3b8880ca9so984867eec.1
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774717115; x=1775321915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOXDh1jRFL68kZhVUrzJRyyP1HcBqGuF0AHCrWuMDAg=;
        b=DzH0stfUe33N9q7AoWpnSMMSREz1jS8Xjb7iGPuiPr49LZITBtLVV5YmzXqk6mdftb
         tAuPT4PixIbWyvJoHzqJZvBc3DZVxuUlV+VpozxG9IxWl+G1JUrGv5TVZtYa9aj1SI58
         v4MxlPi8fikLhmYqpflH766CJKROj6BVIyq+B9Tly2MjCHikyeNRV1vW8rFudrhP0L/u
         BX4AbSBVC7Ia82sBb1S2gZOlENHlugV3vXfIpsiy9FZ6DtR7SlX0kR0slfFWLGgpKkDv
         FT5YxmCcLXex9x0oswgd49v0pB4hh+ekoUUFws+LSGVw8RtYFVHg00Six6iLlWV/Gp+d
         BPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774717115; x=1775321915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOXDh1jRFL68kZhVUrzJRyyP1HcBqGuF0AHCrWuMDAg=;
        b=YRICvr+HVhqdsoVnjdzcMtzs4TX0V0za85erhpuvmdiTUgn0si18usTDU8vHbVq1/B
         ArUfIquoxaloPLQoU4jqrrX+T1Pt105Ps9ZY3eAh+u5Y9EdGL0w3NX+ZVb463ZNerMrn
         dyylTPwA9f1eR2cUpwgKKMI3KGRwXqkDWD4aCx8IY9bBeWlcKw1D7lLA/TAZpVhvTQP3
         x0CeyAqZffGt9KEji9RAXrsrE/OnmvB2KRV0Z1FbWer4WizN/hvUkHgEdn0aB9AE5b5F
         AHo6G+1pvrByTeaKYjbTY88oWniem/zr7JORMVmJbcHzVd/Ca0WbiuSek9CZoaqaym1e
         tqUA==
X-Gm-Message-State: AOJu0YxIDELIFfPltHAkJSvTuYA+1feSljl5hLF0YWxgvqOf3jk5wy6Y
	YLLue+G0la7vSRsVuN9xzFNEBH48XJ9LX2EClSKO/35pFxGl521jAuMaB7E1Pfn3Gn1SqWYe4W8
	Ec0i/DkmX85xL5P+sIvRyqwHq7Qvi5sEBgdhHNRND90RkvVxm/Xz8LjE=
X-Gm-Gg: ATEYQzy99v08FixoepZzpKYWopK0qsI2xaaQCYaG/ayW+f1Hv+6BILl/ca7G1M9r9+r
	gUFgbMaca/qdEyPaOwbFyoEx3nb4wp2qsAxEwXWd7tpDn2nOw5Z/IEwqyf8pGzOwIkJsm7DbcKo
	rrb8NhzHDKz2cSAMhJPMeuZ8NFNh3mEJllWYpzkdauzhdlZZ53XRvmoNTJHzpNidxidg019kBpv
	QekQzoec3EMKzJDmL+f1dsq6vRD7HXskq0O3gRdEC9GXThPxHucs/cRsco3SVJI+LuAWnMT1bUT
	0TlW3aT/y4pAondT5EhGeZtwZQcoboEq5efxHw/QCpsXvPCH+MWyI0jH2K1PrKkfW0VDUtV7Gjy
	OaKt95oq/PX2XAsPxvnjLTV8X305L9Vc=
X-Received: by 2002:a05:7301:290b:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2c185cb6ec1mr3779635eec.8.1774717115043;
        Sat, 28 Mar 2026 09:58:35 -0700 (PDT)
X-Received: by 2002:a05:7301:290b:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2c185cb6ec1mr3779624eec.8.1774717114444;
        Sat, 28 Mar 2026 09:58:34 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c46a0d06sm2339596eec.10.2026.03.28.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:58:34 -0700 (PDT)
Date: Sat, 28 Mar 2026 11:58:32 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Zongmin Zhou <min_halo@163.com>
Cc: kvm@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] riscv: Add Zicbop extension support
Message-ID: <riw3sxv6a2bu552ytqm3d2wjiflu2rwbzlqymyusla54nfn3u4@aelulytsgwqj>
References: <20260324020227.214445-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324020227.214445-1-min_halo@163.com>
X-Authority-Analysis: v=2.4 cv=I8dohdgg c=1 sm=1 tr=0 ts=69c808bc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n2bYqAgIxU8ZZ3vdQ7cA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: RkIFKKKpFycsN3sZeblgtbbzbBVIMql2
X-Proofpoint-ORIG-GUID: RkIFKKKpFycsN3sZeblgtbbzbBVIMql2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDEyNCBTYWx0ZWRfXzYt1ldTdKm7B
 LpF1S8Ji7WMmj5pHzoXN8STPxyakuGO7K5nNPWKtE/fqkVb5k2EXN18mwrMrjxhNtxBa6CCGII4
 2HQ1yKdLxYQq0y9RgimQeaQL9HdgErhUvOZx2qvad7zb0O636c03luWI5GujMoVSWmqEKPCyeX2
 PRIhURqlCPMGPwgfRWxnmhOGuJ3nREmsR52+GZdgAAXiO64yFvSrT1al+7h6Who6nBJXhVaNsDp
 6nbuFOb/JBiUvLWMEpO0vkXqcYDOTBXbA7No72cht5tz7yb9F+iVSFuseuJaT6Btyr3blYiK8bE
 25lE+6kw1vO/+tACFpjbgsXF19NDqkON4mZrxvEeZmeUIZOft9gwI2yYrI2MRHYu7jUOY4aQ2eH
 C9z7EIGdZzRz/K3y5wBdL2cl/MxZNo3W/zZDdbevxn6+fPnx5HkeQ1l/Xj6WZS0R2R6HBgmBFif
 d1wa/IF8vPkWdL4oYUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-28_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280124

On Tue, Mar 24, 2026 at 10:02:27AM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> When the Zicbop extension is available expose it to the guest.
> Also provide the guest the size of the cache block through DT.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>  riscv/fdt.c                         | 12 +++++++++++-
>  riscv/include/kvm/kvm-config-arch.h |  3 +++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
