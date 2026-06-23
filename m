Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B12F7F1B
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236092; cv=none; b=QeigOLhphLb1F1pPJts7P5h/DM8HVXiPOWDDbdGAe/kcLDunX5w36wGqSRvDmvmGb3uykan1qj6C43SSIiz0bbyAjFwbF7tAuEjp+B0tmdWMD96xumMl10LhhjJr9csrUu0MiSR7bb/zSyvs+aG8UWcoW/UyTXxRHvzZQOtl9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236092; c=relaxed/simple;
	bh=VPgj+iaPb8s6r7X5BwS/V7zX7/9vmoxbqQh7SVzyNEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T2Ugujt6fW1xJcbAz7l0JsZDdNqPbyDfKIiOrs6hnqCPiNVVlRVG/R3+zUO7fao5opaj03nukAnGy7chBXCpwvO9xQxUyCoPpXkDNaCYHAHIWvlsXQfgVL/2L3q8T/sbNftyp3iHLm+TjWaXdtE4b0IXup2I94ZO4hf4GGzEloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TXsyZ5YU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TXsyZ5YU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmRdS1805308;
	Tue, 23 Jun 2026 17:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=roiNz4
	KKyZOpHcBuVw3i9PIsnqu7+nfAHre4gDQZqmw=; b=TXsyZ5YUYyqKsmPd4rRi/e
	d5S1C2l5dzBc0pFeXtHxb6MecrfB/Ou3UgakYsn0we8QJIyCf0aLbZZfkJgDNzHv
	uElrAciBKXSGKe5WQ7zKrvy93p0tQk8vW9FpETkWYpeXG5pDxGXJeW3MWRLQRXCa
	Wyh/m1ZPJfLTFpnYL1D+yl4HUD8RJnNyAUT4xtAxAZXKIXRpF8duPGt0cdV+7vub
	jSruKMsuMHX4b+1Fwi6dhvFzBliK4OZ3jA3K3+OfT7JuOlPJzO5stSID9YX6jrcY
	5YdIwu1qakp8+gIEsR3lx1waMINhgbYqn4YDjjw/KaT2dcQ7jb+GPpkB5Q+XDYng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gfwuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 17:34:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NHYhhq021543;
	Tue, 23 Jun 2026 17:34:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwcn7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 17:34:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NHYkQg49021212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 17:34:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706A32004B;
	Tue, 23 Jun 2026 17:34:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48CC220040;
	Tue, 23 Jun 2026 17:34:46 +0000 (GMT)
Received: from [9.111.8.225] (unknown [9.111.8.225])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 17:34:46 +0000 (GMT)
Message-ID: <69ed9c5d-e57c-4c04-87b6-611f7547e63a@linux.ibm.com>
Date: Tue, 23 Jun 2026 19:34:45 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: gmap: protect entire guest top-level table
 when shadowing
To: Naveed Khan <naveed@digiscrypt.com>, kvm@vger.kernel.org
References: <178223359030.58041.119573473883113694@digiscrypt.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <178223359030.58041.119573473883113694@digiscrypt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4QguhTgg7WRm9LOi-bxawi4U1oAQv89m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfXz+QRA8yP1uMx
 g9K3SX9prM7Scli544YDbDA2A0d7fIJsBvgqOe6+U+7k56JtJEtz5alnbfbTWmnCHrajEEIcCYr
 2Xi4IHxDHYeQ1IAmLG+2SvNE16ELwSc=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3ac3b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DWeQ9qxvAAAA:8 a=ZezDE1mnLR29BFnUlDAA:9 a=QEXdDO2ut3YA:10
 a=H9FfVFjNSCz-tzo9QOUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX1QpRZzU89+1c
 HD1zKYu7lZCw6KOEVgYL6O5jENPHcqNQvZj/1jeT29mbcljU0wlyfMfmGH0PPvpzhNyNcUqa0WM
 MntRhz2LGeXHJVdeBHH8LRzC7ubjJGhxIUJDYGO91NCqhwmWk58k6xYdVgCZ33Y3lq2cIihyLqQ
 7jzfCcNjq6YTDimx78x0dNJ8ig5inZQyOqkW+f8b3wxf8zkL89KSgNUhEOF9XLS+KP90YDDP11p
 ILwOgGLGKiwAXfSWDgNveJSUGqXuW7cKkjEtYzk5y61F+m1zJcSvvqaCnA25/4nkVYc/wAUXoC3
 74OZEXZVufKtM/uQ0WXpfhi52A4vBNNnJIjkJmVtns1e/5ISY6KnLs6eRFfHVbCQ/sp5o8kA+uW
 YAWM3+WHEIys5X4wCTl1TbwcFLAXem6BQvB8swJxiI73lWb4kyzMxkRTlfnJPhPzTgOG2HTspBe
 YPwuXhIGCWvqNL5n8YQ==
X-Proofpoint-ORIG-GUID: 4QguhTgg7WRm9LOi-bxawi4U1oAQv89m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230142


Am 23.06.26 um 18:53 schrieb Naveed Khan:
[..]

> Fixes: abeb7eb57f16 ("KVM: s390: vsie: Use mmu cache to allocate rmap")
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 77829f787d..e1e734cbc0 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1287,7 +1287,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
>   	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>   	smp_rmb();
>   
> -	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
> +	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
>   	if (rc > 0)
>   		rc = -EFAULT;
>   	if (!rc).]
there is a patch already in the making for quite some time
https://lore.kernel.org/kvm/20260623153331.233784-5-imbrenda@linux.ibm.com/
https://lore.kernel.org/kvm/20260616165110.360921-5-imbrenda@linux.ibm.com/

This code area is currently under heavy work and we do read sashiko reviews so
there is probably no point in doing LLM review in this code area at the moment.


