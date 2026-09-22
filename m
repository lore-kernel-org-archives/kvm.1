Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0341DDFF
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117027; cv=none; b=DVc7UPCvrKCwWeGUFemsQdYPYDW6pKsVc/B7ShoFFP7VHpAB9EQna+fCv1/uPdV8dV3Nh87bXU2uNSQcB2X5n/jt9CHJtH3j/Rq6TDoUrkBYG40QXeOELK4eNT7ZL+Un+gSWRJGVajCfdJGlAKdyQEYi/gOlygqewlXNxsZoTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117027; c=relaxed/simple;
	bh=TNq7qZv6We95KhCy65nIeyeboOhZEhkFGiez636Srtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLU/fjHCZVzBb+/YBcLUMIWU4ULEk741DT3FdN9Hsn6gtibWm7AGj4mRnLY8sMs6fK86i/A08bQfvfZqb6MGL0gdvvYJpoHeTfoQC2XZ1o95F9y9i5TXcy9HE3TpUmAdx98yCt9a3oYM30oInFcg0xD76O/9dj4NDBkeu59lAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OFNcuMXm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fT7FbsEd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFNcuMXm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fT7FbsEd"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7Csx368038
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kg/OR840iDQhdwyUp7pmwJO/JhoDMeTO5E4K79nehm0=; b=OFNcuMXmh7AGmV10
	knsoRaEgW1DOXMPkqE6axrjTXY+QI16SKZIKboXNKJD8Kc15XTfM8fMpkusI3SQB
	8CH7dzkYILyelxqMjsuIlmXORALfUutonB2Fbs6VKMtVs1roC1vztFKrlov1xzw2
	hXKWqyb3DTdebH1ZTrkH0nzOrORjvr5ikINWS/yib7JiWlHVvjaEGc3nXzWM5Xy5
	MPolplbsyrok+Nnjgow46lGAHmXPvPsy2UkBo7NfGyx9oUoPoIZ1eu4ABfNTyhhl
	IyfCoyKZUh9NeeQ3Wn3tS4pPdM9L3MNv/m2vfUeCK5Npev/TGbIV+aKk4UUutna9
	Mqk5rw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurntbasm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:43:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3286d2bac04so292980eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790117022; x=1790721822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kg/OR840iDQhdwyUp7pmwJO/JhoDMeTO5E4K79nehm0=;
        b=fT7FbsEdEmqJnX1RqP2iKe9U5pPl+2Co6bihfuzUD8rjAOEWbjen3BVZr8XPLk94T+
         4l9HYwD0vwpQQMjN/AGUn2dwlvhnL5cZvIJyH7UIh1MAckvGbOzOOn6D0/ohfpsAWxN7
         etBkYJhr3GyekZgCX19dEpmrvVT4Ip7mWh+J+gGEi+/2/aXAqRFXdP5lpbcu16dTi0Xj
         HAD7awJ1f9doqcJeySK3djlBV6vAmzY5Y3wb6SoZn6pCQARrunOl8eGmMzg+znE3jGHX
         /xw9pgnq7oP2dEjF8ORDbK4ChM53IDUYrBqlB2w5htdWYw8Z0zcvnfbhQS27z/tGNuYr
         vvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117022; x=1790721822;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kg/OR840iDQhdwyUp7pmwJO/JhoDMeTO5E4K79nehm0=;
        b=n6ujv3P4thFgjKnll88hhBOlaMKghnsOFuYbcYSSQAjP8PYPW92W+ouFVwKKAaCOfU
         P7qi+WxSOTCBnniL6c850dIqeHUPErINSd7Xa7RFbke/z94V31KQYQ6c4NZ0AERS1ojT
         KH9ihFfcZlOrIjn/PLMvaDzfkh+N+uIn9Xqi7M+MHe5UrDFtU8XpR5fNjcniQHGEFzJM
         lmrCLXsV6mnBxPBWDJaHyyplIAxysS0tHoTCNQk4j0ObOgEzEiENM9Zxw0BHVbkx8Wsp
         O2SGwBTPwcV+5DO4giY4i5wnO5o4k+8xWNvICr/WlTbZf8u7V8uiRnnstUxzWgIbZuRA
         nLBw==
X-Gm-Message-State: AFuF++l9r9aIQXT78cI7T71uzk4BrQBJr2ZCjczACcKZRW38cQfnNrwe
	jUr8VJaPIDhRPWYZ00yqoJvzpoaN39/iWuHG/r9ED9Bhi9iprLaxLWI7Ei2bV+cQmSnyGkulGTs
	xxgcHU6GtzwZRTyuQQDTbLHRwHhYISjIyMK7zja6NMUl+MVH46avxy9Q=
X-Gm-Gg: AYBFou2GMm7e1jqgnNactQxtsbCdvHLrWnQXhCMFKajl5Ty7r6i/ipwkX6NE8KlmZ4t
	S5ERIejSJpB/XZmYd89xBchEnvDNI21TYE94mKWBy8C+rg4kcVypxMi84bwznbejchrKwivXOI+
	7eB6jxPbN/WdpqRIRiqad+L8NNtT4vEGNmJfkfGN8T8So6jtBXkVoyJjqTpXSsQ8xXcf+uhLrHk
	pjTsVWJgka4VpD2SNc62HQ/z8qxzyZ1IOjm+uc5E/XGD5eiKOQ0Jjap7FWXVZhjNrc2hAJtfhuE
	8+V0NqRZJg6dtAmtkDiPqB5JNGUDkPJO8NQGgy6+7h49fa9bQFvfVDKIwSYcI+j+EIHmOiYuaSO
	VP5hOxk1uat3vWGgU4jXPiU/OPcUR46PaivkJa0fvJy+1ozclTpsHcQ==
X-Received: by 2002:a05:693c:638c:20b0:33e:3f5b:3ff6 with SMTP id 5a478bee46e88-33e8ca260d7mr785964eec.18.1790117021784;
        Tue, 22 Sep 2026 15:43:41 -0700 (PDT)
X-Received: by 2002:a05:693c:638c:20b0:33e:3f5b:3ff6 with SMTP id 5a478bee46e88-33e8ca260d7mr785932eec.18.1790117021259;
        Tue, 22 Sep 2026 15:43:41 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258978sm1124102eec.14.2026.09.22.15.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:43:40 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:43:37 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v19 12/20] KVM: arm64: CCA: Add a new mode for
 supporting Realm guests
Message-ID: <20260922154337.0000762f@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-13-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-13-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qmSNrK0Hlok6PimPfLWSC8ndc5uHOcbC
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab3049e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=btJ7bRNyUFryZYO5LPIA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfXzD3bTOUjjfvy
 3LTuudzjARcecef/i/jCfXcArGNkNyRBUvXP3HyIbLkZMiwSkSybJ27oLPjatxb/ngy5IjKBbII
 Y3PEeZhmGyS9cOjzOo0RZ76NSdquKUJYNBUsGTywjWuGYki4Lw+A2+AeqdqTMrH+m7omiCB8LWu
 EvUOANXF8IFsEgoPFm6qRxPYYjwGPKdkq19jNaD5+uNgNSrnxAEPCIm76dtdqTLd9ChfgjnMSDO
 0OIUoC35GVx+Evju0bvpzaPya3S1Pa785whIw7G5BflFt78Tmsnv/Y2QaThhw9wxVggif0e+1wR
 p5AXOYPQYf8GrR2/yVVfZRiLZXOgSQlj4xoi00HmQM9Z1Kk0etViPg8hzW3plkdO6kkm5fVTeMF
 FFPzlptJaAAUIFKWyOuexT8f6ULfOcA5Nx9Sa6nuZNHpeUr4sxXK9LWyUzMBKYV4C4EJ56jQ8J1
 m207hpK/8s2uJUzH0cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX6HAr6kEwCN9l
 ty4D1VoEksPs3l2b3FiPt0tMikvBEZD5qlKM98tTIkoQrrQm5n29JvNQcohfZVPX721WL4WgFob
 V8onOXUf+ofOcYUE6eJfD6BFpBg0ADw=
X-Proofpoint-GUID: qmSNrK0Hlok6PimPfLWSC8ndc5uHOcbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220303

On Sun, 20 Sep 2026 22:28:37 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Add an explicit mode to support Arm CCA guests.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
FWIW given how simple this is
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Mostly given so I don't read it in v20 :)

Jonathan
