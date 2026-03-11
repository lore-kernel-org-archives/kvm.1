Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E453E0C7A
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248223; cv=none; b=A4TQxlXa3WBNtUXJCNXmSxYdgKlFjT/53YBkOPf/CwNw3KRX2ZMyz1I0KyJaqsA9LTlu039f7JSpOy5qV+qX5XpUqdY9tMdr3H2Jj+om4ej5YIWXd5PnZpSPl+p5Gn68qBCeRUA3ClRiezD089qoK8lHxpub1MpgKXj42mBW6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248223; c=relaxed/simple;
	bh=iESc+D78htgC/ZQYeJxDZ/eix5qID0jlcea3V+Z4W/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcvyFOh7Zj5PV20x5wv+/UOhwN+Eos63BGOAXcuwgQnx18I94P3LQFYK/FAq48ZjmB2aXIF2W2bXolsGH1sO9BHkLYYYEd4eJVYdQx9gFrZqQDi458v0f/SUKQ1jhlEUflx0yucJEInYCm83abg4cD2gRhLB0S/bUYntBDEgigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p3Yax84V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NaxeQ8zG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p3Yax84V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaxeQ8zG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBvQt21439702
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h07YhZ15uUsR3D3PiadCrr4J
	bpjVd0QblfgbHENErsk=; b=p3Yax84VOMh7P/ITtyRHAt3LGt6bA01ccLDVjqBz
	dedYV2H7EfNj2LucW0F/6iH/FhJyyKkM+Rx7uGL7JBMlwCY+EvfR3VNptNwurhJf
	MzNOWTs28fPMTBGiT7l3uCutFRcXlC/p7R0XUefyqGq62RlszlcY/Kx6RNdQjWES
	825hbuHJGwHW5sEFiWAAxkNlz6EUBJxrvT9LqfkWBJ765oAXYMEEUA1PlGWcNmIZ
	KKwraVC23Sf5ZEI6crTiMicVuGTI2e5QbnwhvvK0KbPBM6DO3E/eQ2NTVM/QtY5D
	r1UfbAegAsJ0LOgQ7IOQMbDIZtUkuphG+nm8aIazTS1v8w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu38yj9cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:57:01 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d75b6b8500so1317179a34.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773248221; x=1773853021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h07YhZ15uUsR3D3PiadCrr4JbpjVd0QblfgbHENErsk=;
        b=NaxeQ8zGeyfvUICE2qIShXi+z49crnzTL8M9pXfQJSr500jksuyuobnfWdOeBfcYCW
         63Vfbnt5fZPMClSGkB3bmTwoyPPkb2z/9Xfv9bnY1IP+t2e305NkKIHAdE1Asf4JSs0M
         6vefgvK0c2tNQkdHVtE7Hnp5oo2p+q8Sp96NckU8mmO6QsDJVPKASmig6JY0F74/K9ly
         qqNZ63oeohslw69eawKNeoCdyXmf3jxSv+Cnqldx7N7OGxdfZlwBVV2L4IHU17No1QS5
         h43Uqkr5fkYlnXDH3AsGiKslhu3gU3UEfaNFbpWKqcQSkSTFbNRSEv/FKSOK8Dgs5HGI
         LP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248221; x=1773853021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h07YhZ15uUsR3D3PiadCrr4JbpjVd0QblfgbHENErsk=;
        b=pt6pNCGk69tKJGEiyrLedd4VBv/nuggqMBBXS/MFu1+EGGmU8a0+Cq88cegXpOMxUS
         AV503bhFSf2PhqQR8kJ6TF5SzsvvLYaZ2iF/iEObwfJ6bBGH5jlC838uTfN8E+eI4p+q
         GmHuEqggRPf7vGFwEWho5Xwdooj4s350IOf5iM5vRLnwq2aaNVvRqLRG0KIByXhiHEah
         Q7OOP7mD6HHizOocQyZfeMeu5G/A+oi+OCLHgK5AKle6wPnIAhmlGE62ZshLwHC7tTUA
         d/YifJYDiY1OeFZorivnh7/5iVe3IFnuEym2grh3goD0RyeZ4mm+rDTatW1ZlNn1OkkW
         3wIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcUJmYfYp5u08fuFFRioZ5yxOKq0oagIT0yJcwQvNIh0/gVotnNpBwY+8bc+hlx3V6cGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPSd1sSNarLGeO4GfewBo6giWmibUKt4bBuj2Y/aHKynGUjU3
	avkbwhS1PeYZrFybwA8JcuaugBWKM68+CrPbfkWysaaX+vjZJlfcXsmU49VXrLkwDbpUgnOycYH
	hypxXeoBmY/oN9EvxAUvWI5nyC7KF5OvgGUMFw6ul+/uh61UXg1a9xwQ=
X-Gm-Gg: ATEYQzyZCUkITz1mGQwKATVH6nNSoIMiyEWP/XleWo3Co6e1pq7CLWazMEdxAgQnWp+
	c4CwphHwnuDplOs4dcuhHU3jwF4hPv/bhM4ozra7GEMdGMLZV/M2zheAFQVWAqhYCLEy1QsFdOK
	WKVnpZzr795NO4XwjfSSHH9x/eyqSNtkvT68+y14rF5WYjIOofu8N+eh8wjpYqEIc8DSJfeGyLE
	hh/89wSvTZYxu1t8amTmH2++1Gnv9k5y787nt/R8Z/1AiX8M/hAFtQbCYlFjRgacQmYLgT2N9Vv
	/eQh8dTwrx07vc05LT9+IrcgMQ3SKYxp8VOZDkRy0e0EqO7gII1Bf7+smVJCv7boAE2s2NWYcN5
	JOAIHL4ffQJ4GcaMrL5aU3bPBrj0LHik=
X-Received: by 2002:a05:6830:398a:b0:7d7:4f9d:54a7 with SMTP id 46e09a7af769-7d76a8bd730mr2414334a34.28.1773248220765;
        Wed, 11 Mar 2026 09:57:00 -0700 (PDT)
X-Received: by 2002:a05:6830:398a:b0:7d7:4f9d:54a7 with SMTP id 46e09a7af769-7d76a8bd730mr2414301a34.28.1773248220302;
        Wed, 11 Mar 2026 09:57:00 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae3a18bsm2142694a34.18.2026.03.11.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:56:59 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:56:59 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: selftests: Fix firmware counter read
 in sbi_pmu_test
Message-ID: <xno3pqjszessdrkjayjhtz44avckviidwg3orhgqzuj52gw37h@fjsvuvo6bji6>
References: <20260310055557.835531-1-xujiakai2025@iscas.ac.cn>
 <20260310055557.835531-3-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310055557.835531-3-xujiakai2025@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE0MyBTYWx0ZWRfX3NrRa1UurNgq
 htq7XzmWh6zYgSyPvFqK5lOmogY7PcRvkhjV7tY941qEqYEEhOEf38s9AqYg5O6g/4IfnbMjZ43
 hTbO5VSLH56ZvW+NUTXYAJBF4JHxPOd1CQn6Lz/H0d/2c3Wo34Yyn/ArzkiX5dn9P2YFffATWml
 b11FeZk4aSPD9PC/TlsqFF5TigfU4qRypqpbgabOK1A0POC+NPDIf0ZPkWL3KfkpZQgurUfi2Td
 CGbFrvaTsG4cENtQFJtJeHX3c/haNPCfR+E0GYNFK5iBYtKKeq+58L3gjVGKFKfDj3I0nw2898q
 DlsQmnA/XJyfnZsVgNO7fxEn0wMVvIgdINK3yxLMjyrFTpRU+sBp+2NssHes6cIMdPqF3fST/Gd
 taO6VZmhyTX3Jd6/UE6O9e/YyWLrS/f85oobbnf85W++W9tryLUkfsLEE0sFP5CWozv6uKRCJ83
 2+QUSqob394QZ3O3J9Q==
X-Proofpoint-GUID: 01NXRelZhHsYA42r7SkwUzHLW3nXDm70
X-Proofpoint-ORIG-GUID: 01NXRelZhHsYA42r7SkwUzHLW3nXDm70
X-Authority-Analysis: v=2.4 cv=Cq+ys34D c=1 sm=1 tr=0 ts=69b19edd cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VH6gc7BSxg5OAeS6WkMA:9 a=CjuIK1q_8ugA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110143

On Tue, Mar 10, 2026 at 05:55:57AM +0000, Jiakai Xu wrote:
> The current sbi_pmu_test attempts to read firmware counters without
> configuring them first with SBI_EXT_PMU_COUNTER_CFG_MATCH.
> 
> Previously this did not fail because KVM incorrectly allowed the read
> and accessed fw_event[] with an out-of-bounds index when the counter
> was unconfigured. After fixing that bug, the read now correctly returns
> SBI_ERR_INVALID_PARAM, causing the selftest to fail.
> 
> Update the test to configure a firmware event before reading the
> counter. Also add a negative test to ensure that attempting to read an
> unconfigured firmware counter fails gracefully.
> 
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> ---
> V2 -> V3:
> - Removed unnecessary BIT(ret.value) & counter_mask_available check.
> - Asserted ret.value == i after successful CFG_MATCH.
> - Fixed eidx construction in SBI_EXT_PMU_COUNTER_CFG_MATCH.
> ---
>  .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index 046b432ae896..16f1815ac48f 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -97,6 +97,43 @@ enum sbi_pmu_hw_generic_events_t {
>  	SBI_PMU_HW_GENERAL_MAX,
>  };
>  
> +enum sbi_pmu_fw_generic_events_t {
> +	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
> +	SBI_PMU_FW_MISALIGNED_STORE	= 1,
> +	SBI_PMU_FW_ACCESS_LOAD		= 2,
> +	SBI_PMU_FW_ACCESS_STORE		= 3,
> +	SBI_PMU_FW_ILLEGAL_INSN		= 4,
> +	SBI_PMU_FW_SET_TIMER		= 5,
> +	SBI_PMU_FW_IPI_SENT		= 6,
> +	SBI_PMU_FW_IPI_RCVD		= 7,
> +	SBI_PMU_FW_FENCE_I_SENT		= 8,
> +	SBI_PMU_FW_FENCE_I_RCVD		= 9,
> +	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
> +	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
> +	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
> +
> +	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
> +	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
> +	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
> +
> +	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
> +	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
> +	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
> +	SBI_PMU_FW_MAX,
> +};
> +
> +/* SBI PMU event types */
> +enum sbi_pmu_event_type {
> +	SBI_PMU_EVENT_TYPE_HW = 0x0,
> +	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
> +	SBI_PMU_EVENT_TYPE_RAW = 0x2,
> +	SBI_PMU_EVENT_TYPE_RAW_V2 = 0x3,
> +	SBI_PMU_EVENT_TYPE_FW = 0xf,
> +};
> +
>  /* SBI PMU counter types */
>  enum sbi_pmu_ctr_type {
>  	SBI_PMU_CTR_TYPE_HW = 0x0,
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 924a335d2262..9404577e4ad5 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -436,6 +436,7 @@ static void test_pmu_basic_sanity(void)
>  	struct sbiret ret;
>  	int num_counters = 0, i;
>  	union sbi_pmu_ctr_info ctrinfo;
> +	unsigned long fw_eidx;
>  
>  	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
>  	GUEST_ASSERT(probe && out_val == 1);
> @@ -461,7 +462,24 @@ static void test_pmu_basic_sanity(void)
>  			pmu_csr_read_num(ctrinfo.csr);
>  			GUEST_ASSERT(illegal_handler_invoked);
>  		} else if (ctrinfo.type == SBI_PMU_CTR_TYPE_FW) {
> -			read_fw_counter(i, ctrinfo);
> +			/* Read without configure should fail */
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
> +					i, 0, 0, 0, 0, 0);
> +			GUEST_ASSERT(ret.error == SBI_ERR_INVALID_PARAM);
> +
> +			/*
> +			 * Try to configure with a common firmware event.
> +			 * If configuration succeeds, verify we can read it.
> +			 */
> +			fw_eidx = ((unsigned long)SBI_PMU_EVENT_TYPE_FW << 16) |
> +					  SBI_PMU_FW_ACCESS_LOAD;
> +
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +					i, 1, 0, fw_eidx, 0, 0);
> +			if (ret.error == 0) {
> +				GUEST_ASSERT(ret.value == i);
> +				read_fw_counter(i, ctrinfo);
> +			}
>  		}
>  	}
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
