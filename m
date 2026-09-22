Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186C52FE32
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117689; cv=none; b=sL0JVZbGBl33XCj7e1Reu3Fq/GgCeFsAv3LKOOIB1NdIxaJG4d04+CXV+bi43Mnh5j3ezMK0EIXKvWK2RC+2OIrZCy4t0VUNDLpc0HVzwbZPIvxqAS5M7L1r5H8LwVcDywSQHNHYv98o5Yr65LUyDlr02v+CDwkcMiLYYnL8fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117689; c=relaxed/simple;
	bh=ySnK+hmdvoPJVkgFkjfrLJlNaWN5LOaQraKbC5hMV2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/wT60x5JYUbF2piab6YzfMZG3dllF1KMuB3fkep3bCSgnNhVGBDFvsu8hVXiDAVDp5ZROJF6mC1VoWV9Y1wzUKQuIHgolaUG9DdSfEc1GzOSZ75hgMO6GP8mNiZsuhYBC8vOZOGfR9fb+mSctMJ8QsoYyurpiwL+2ps39NYh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgC+Jg22; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kDdqa0yB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgC+Jg22";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDdqa0yB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MJHMCa3910921
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYxvfTdm3oz7TymPids4imwzrOSBJe+ux30GQWYD/WQ=; b=TgC+Jg227JT54tl4
	P5oAiVK2B3oGJAAJMrXG0Kz8oLZBB5wfKqJ/JTsnu6gDea3KvxyAXIqy06rrQHxJ
	BPTXp5Bw1Cy9Fx8d/V8xAxo+P/+OiHNzL9zUc6Wsok79fsbGQhIzId94CBYHb4bp
	skBUEfTUJYU+vlOqfF0o1arAozn4tgbQaZTjqQGXJKuL6nusRUJBJ3LRUKtFj13l
	aXK52LiNDgboYOpBgBX3YDbe7Ba/CY6ZfpjL8mVgbTDTaYgR0eW/eX3v1VCLU+/R
	aJ4fgVdyZjItZV3h+Jut4PysymBjF7GY/dpYwi6CNF1CHWgEUmcVoZBrwjvk4SCb
	hqqqFA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma0xn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:54:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30f1b904861so385234eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790117684; x=1790722484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LYxvfTdm3oz7TymPids4imwzrOSBJe+ux30GQWYD/WQ=;
        b=kDdqa0yBYDg0mV/ZC5GcsQeqQySDGZzjfct3M8G9JV341symKAQ3eunwQkEwEH7eWL
         Qokvf5HQ0v44eNoE8EcRi+vPNJZVgGjTit3XLSl9jR1ayHarff8TPEA0ParnqjXAWubv
         5ejrDvEce1kb/qs2fSxQdxOTbNq9fGManETXoHxlGSDSqQ0SiXYRP75PeaAS7fx4PfXJ
         YFaHPgupMDbZMmJ6ZRWmlTiP8JA4qQ5HNB3Hqj9HEtbCRfliMFzbUDkELE5imoXSpz/8
         xED2ur5oaDddMXCwxoN9rZDAkTb3vQs3N0vr1TMkgIASRELBTrz8+2uwrA8dswbEMfJq
         6LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790117684; x=1790722484;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYxvfTdm3oz7TymPids4imwzrOSBJe+ux30GQWYD/WQ=;
        b=uHepXvHDDMqEmnOP8b+IRpNysrNaPiEQh9z0XKkY9GjhQ6z5RyZ7hBqgKpYwZ/G3G+
         DYibKH4B3cdqkMVw0Vlw/1g2peRoyBcBMbZQ6qE5aT8dffIObdXIyVTj0yMzE9TRLrVx
         miqWUkgF8qJ5mATI392b1m9u8y7Zn4w3mOdqxA8//qVE5pGUVweKgUQb3ti3LFwtB2ga
         xgek3F4Q9ZYWRz7V+9FiXdKHPcBvgmHWL1OUJLth+vRh3dnUsu35cc4xg+i640zSy9c0
         llyuDCXbgVJzdQJnziBeNVXyhEXiyuxMtjJWIDGTr/oFV7Kcb0anhyG7JdYbMte6/tux
         F/DQ==
X-Gm-Message-State: AFuF++n3FbwR1Y086SQ2SDeyS/A8MtULF8x5riJrDdHNT/UlPXlPVwvw
	5+4KCdVO8f9O+coJLHmV+ZlOFhnNdUNmJfGlsdIdS2wQ9KHLOxpShhoc40ujxu38dnznKt9p+7y
	usz8rrCM2uxWUPKi49dhuGew1NKPAaLwc1sH80TfpkvNnWNHyCDw5dQRT8aVXvfA=
X-Gm-Gg: AYBFou0aYqhNFS8mMH7DlJGNoK5/21fAUUF1bxgGlrR3OTmQOvyeX+vnNtt5tCCFbLV
	qeAfcyLM7txz8hHS9s48STKMJmWjyEsDX8PslDvHVhVxEVHSDqPq1MhNJ5pGlo5rfN32LCH8CwR
	l7gDtOBRpPz6JKtBGPaXwkNNWH1TnemHyt5fmzuVfOXc3eU2rrVZjt5X0kc7m2kAmTJYxGgsaQb
	GeSmzgo/SUEhfzIUvmebb/oTVYWgXvHVwe5Sa5aXsZdm9KAtNjKph/gwS2iYyOnX1L6g1eBY8Hc
	qAjzYuS7i+N40fzSKhQDsptHIcImrDMliXQc+r27w/3F2XcQwC5ZGQraoulJ0HwYkiD0Afmz5F4
	nR6cAy6tA9EaAYHG+i5UHAcZC+RfpiLO6rd/GTaHXor5gfH1586nm4Q==
X-Received: by 2002:a05:693c:638c:10b0:33e:6a54:b3ef with SMTP id 5a478bee46e88-33e8c05f69amr760368eec.18.1790117684028;
        Tue, 22 Sep 2026 15:54:44 -0700 (PDT)
X-Received: by 2002:a05:693c:638c:10b0:33e:6a54:b3ef with SMTP id 5a478bee46e88-33e8c05f69amr760352eec.18.1790117683534;
        Tue, 22 Sep 2026 15:54:43 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e48e3esm1320134eec.26.2026.09.22.15.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:54:43 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:54:38 -0700
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
Subject: Re: [PATCH v19 17/20] KVM: arm64: CCA: WARN on injected undef
 exceptions
Message-ID: <20260922155438.00000f3d@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-18-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-18-suzuki.poulose@arm.com>
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
X-Proofpoint-ORIG-GUID: cWdURUQoNmAg49CtqG-H-lllyyC_OUgZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwNCBTYWx0ZWRfX+zfQQsCj0UZh
 vW7hKCDDchNuWRVwDtpkcMmS0i69GXpXv08HhpU4950VA3GVlChXTiqDrV4Nu5iEiCs76drGbbb
 v5zxgr6QJ3KRqV7odMksgAwb9OoHfbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwNCBTYWx0ZWRfX26PxzqHCBJ3V
 r6ri4iudVa7pT13/koUQOThEKKz2JC6DtsOMwtkAw04OBwF0REWnyVcoT1e4lWuukkTr5OTxO5a
 u8G/baVfJK5qCCp61CnT9GJBjnfGoOnhZBlHb5oJK1ba72vyZphBmAklBXZJLnYdcYYe2bpVPF1
 h4xHZUy61QJACx6qTclmQJymYXAeI2Qq3A5x8SjWxd8+rn7Lt5+NYSQR94wUBbl7qvIceq7kGNa
 /iXgAZg9gtjl+pD5au/Z1E5qQZghVDtTWJrhBPpsc/A5aV76boHeDdFaf3d1eGWwDqJ7J15XFbC
 SQHsIcKrr6bJZ+pGhyLaahkqETltGI3gwK+V/7aJTlWrvq0AqFOd6cKjRc6FrGXwpVlCgl1mgFb
 xQEuJRTWI3wjkLFLogYVvZXnwAbEqU1sLMNcpsiguino+dw5KzB8Zoj0rp1LbyY0NduhAnJzbtJ
 2BVjQKsWpWEZyRFDKVA==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab30734 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=DI-nzRUvp28q1R9r8mgA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: cWdURUQoNmAg49CtqG-H-lllyyC_OUgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220304

On Sun, 20 Sep 2026 22:28:42 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> The RMM doesn't allow injection of a undefined exception into a realm
> guest. Add a WARN to catch if this ever happens.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
