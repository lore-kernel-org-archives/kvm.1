Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB31F03DE
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487312; cv=none; b=cbZDM1ueePL20McyVvwy2qdbF+jWCA4smeBdtEAyWgDT+amt/v6Q3/DoKXqwZxXTIQ6ciOpz9XZoKa1bv4vh6PNqDNx+Tc9tilvR1MKEpvqYaYk/0mmZ19AfF8YraojVRcqf+Lr7ndGc721zRiKUW1Cb6PGOahUfHxZSkSpzS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487312; c=relaxed/simple;
	bh=ZYfzh8xsAvFbzjlOd/2vannWNjmCFFIAj3P+FCZOoM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N84sbB7j+kWLEQN543cNpAxpuuuXRZT/9lzaWAuc1xJnD8/EkA0qEwEw2qVXq3Io9fWA95BlCtZ3rT1IklWl7rn9xgIOIG/S/6L+h1C69ZIwON8rjy9gtHN7oAjqUIO5zlpPDTrqV6I15KwFY+iEmgQsidS7L+QPp3mheG4uEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NaaaaLRw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PFDT37s/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaaaaLRw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PFDT37s/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842nEh1625660
	for <kvm@vger.kernel.org>; Wed, 8 Jul 2026 05:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=; b=NaaaaLRw7K1ISHTK
	HS90Qjx2eSpnq0cekODczZeutGr1t5T+c+IDQo6vVVwYQ8sthniRCiwvn0yROv1r
	57VZNtPb3mZaccDHbHFxBZh1H3CfJ1/zprKs5cjFCGHhNL5286WjEj8JYHeLo6QH
	yVJCwfAVvrFXPbSoMcjQ/wElFjG6T12LvisrL3W1Z8mjHpCUt9IX3RYaPM5JqfWq
	ywpxBptqwFriZBCCjqwOsdDTpFZuUvGA0Z2NjxBJZ6eLEx6iiCRFu/r/xDJ6AO0p
	ZzRpy8c2VH97NuoqZRPZ4OamEArmeRLIf9fnf0CKaJx0QLZwD3LUtSkdW4tLqyl0
	Utelng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2qgs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 05:08:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so5482821cf.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783487309; x=1784092109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=;
        b=PFDT37s/Ti+KdLgYswXWuE6/lV0j0dIfbk8A78Z5EDtAOTQaLQwW++I9CKXQJ13AWD
         kVGPsc+0wMINDgYanXAPZwNfvF/Ez1oEwAg4cLzpT0l9r0n8Rb3tZ7GiS+3Qe4CYbVtP
         Tfp8nD4zyLOHjxKzVfNYQx1GM7z2TXvlDQYkNOlBgmzz7NKk9ZUuTd1fvrY1OPumIHyp
         sZaeaGkmMZJPVL/8oqPD7VOjXGs4CDkXgje9eXJjOB8wBF1n4mGz/KeFLqtqdNp6HFpZ
         iDL9Rhyt9q6+LAzxR8XW1ezBgXyOThvoBhZGyrznj5cMLpoSMU+oB9/d+dOyWFvQE4mX
         x9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783487309; x=1784092109;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgR4wtmwP7w1QnHwTnQyNfbdL7Tc1aCAgLTf8gtHK7s=;
        b=CRPFjq/oPxXcyoUs1i26nFX4NEMDoMZF60/pRwtWEnfz3sv7UoK+kMKb8B2k3iOJMe
         V/TUJ+F7cHDMgQl2lYTqXmnky83+Odq9zzQPharwvuGc4tUv7AbUJTvpJQEyrGsBK7VD
         m5oEk+VTV93CgXoxaA49gGFTBeoG3BT+BtNACcwI5LKo6WnRmkd868O+kTobT0xHZLls
         w5dWBFyYmemY/wr13MWfD/7qyeKc7rGhJM4ZSq+fVAKqfTJ3JIYl+Lgd9M9wbR4jmUvD
         VhbEErbavd7NKNTL8Py8onngRngrnslqxueWgse1A8nl0qA1PKfpH4FMNg6xikfTOZvU
         9RdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2xTTyeyG5xsNQb82ORQRwZJOnFOKfur8n4xtOTxuJ5LeIiIV1eQsxp+X9XyU6aZUy8Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykmo1d7Wjmyrx06h8RZwss/Xzx7Zymdo/wNtK441v76DbPFT7f
	CKTKmzUnyjF7wpiIl3juwMtWQFXHSbIHnbdBod4twxxrGJ26pv9mWo4K4kbuxRUf9b/JtkX3c6F
	K7BDbjCV7Ihb+rMj3h8Wwrv9KCZ31RddGpgCADINEzXvzmhS1m58yl3o=
X-Gm-Gg: AfdE7ckcWY1lnVBVeuxBb2mjBJjYPVhHrgrTyJ+BL0s4cImKXmhB7OPgyuSGKoANTLu
	mldxynY7YjrgSwKqBOHnduFy+rvvGPxV7M5lsM4tZuFM8Zr0gbDQYsS5z6vRdh2GD6++viZZtez
	EyiPH9NONFpJ6xMGVVW1WdiLXAN+DB82D5Zi12Q6Y9VNYAOZ93RpN4YlieOAHXVWjAAd4qXV9U1
	WnfjgAYsQ06KNSBQJBaXOV+qkPo6e0cnII5l1G/DRYX/hnG2vvet92DwmH/Vrs7eKo51Tw4g0sI
	kqOob6MBmvUOcVrY2hlpwMEK3+fiz+Ke9SLIbRNb2OUw2aJCCleO0MIJOG6CjgbNL9JykIoum+I
	uBN5dgeM9oINCn8zmiNkPYs7vK67pGLI=
X-Received: by 2002:a05:622a:258c:b0:51c:c67:2042 with SMTP id d75a77b69052e-51c8b49aabbmr9682701cf.53.1783487309587;
        Tue, 07 Jul 2026 22:08:29 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:51c:c67:2042 with SMTP id d75a77b69052e-51c8b49aabbmr9682551cf.53.1783487309181;
        Tue, 07 Jul 2026 22:08:29 -0700 (PDT)
Received: from [192.168.69.209] ([88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e54a067dsm27608265e9.0.2026.07.07.22.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 22:08:28 -0700 (PDT)
Message-ID: <a1a9ca36-7742-4c4c-bec5-4de5fe92bb7d@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:08:25 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 02/25] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
        kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
        peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
        jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-3-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX//+gnG0lRLsR
 c7BITGbp6bGuaOASEWH8AAJHqFoRmsQor61jHzvXj26uFJ+pMUDKEMnBs2azOo7h9ciuD9D3Wrn
 bbUi65WRT5gobzCOJ2xmSqP0/wpWEwelVEL6Sv55g+BwpzRJOlw3TAYJg31+f/TZuPsSQE9KPSH
 Df4lV5QrebLHGtrwg1v26+tQDfa9Vbm3pTWb/nvoJ0bhvnGjUVaCVuK/kFeX9D9hTTAAzw3fUzg
 RaqVs/D7ZpQ0UA5hpMdYPiO3vwoD+8v7r4Mr9i1S1whyEQ24x+U9EF/iY8NKDy0Ka6BSjX74lx0
 f6iBIVSRt96lv/jdDgum+UE72BQuy6SCCFLIyIxVwSPHbLU4KYuxhxW0TrE64kWCfjd5FVDcqCm
 iZY5sRj9b++WKax9Sj3iBbJ94Bdwg9mWCC0zIvzAEzJ6UL0TBbwKFPkWcpVJxYvvopnDbS53d2m
 JRAAuqe6yJax4KqR4rQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4ddb4e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: csPET6IiQYwc1Rn1xyPhoxlDle9BcdM_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX+tZeWgevAvKc
 9HddTbSSet9DPbJMZ2D9dbDpbQvDnk0bxwv8Uqnep5p3apI8eXdDY2mHE89wPABdX1GutYeNSzM
 K1IDChVpis9FvzezSNg8kgOC257f2YQ=
X-Proofpoint-GUID: csPET6IiQYwc1Rn1xyPhoxlDle9BcdM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080046

On 8/7/26 00:42, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Returning an error to kvm_init() is fatal anyway, no need to continue
> the initialization.
> 
> Leave the `ret` variable in the function scope because it will be reused
> when adding RME support.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
