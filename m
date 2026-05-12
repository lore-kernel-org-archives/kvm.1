Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C12F12AD;
	Tue, 12 May 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628803; cv=fail; b=ONVetKcazkGEjYfnl4rSqM+XyKakrrSWgH+j5SuD8oXH6n+t7Qz+LVBDCUGliTKw+CeycXEUChu2D/5NcL6mlNwuB+Tbv7jTbvrt+H2U2yO3sMQPDABig7vOfWDEk/7cVSduipRq8YLKWbCiTYIkOq4GjzfJohjF7zRyLGS47kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628803; c=relaxed/simple;
	bh=lprZTlHYpF1qwYWrZ7D+oVATF00D+ubVIkjPD8spgO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFFZPfXa2mECH8hkbGWwUpfIV/QOGhftHzA5jGT/MvnFn45WVZGw9fgtTPbeWHlaWGUq6JD7lzHSWVc6GKWW7c9Ui4Q9dgqbBa0sj2q5/3fvdkZo7lzbrx5SMvnZSYZNToUcM0zGZxBZ2jCXWUWA2vCg5b+qALS5IMiUCEtX3Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FpyKZhUr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcwi2dT3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FpyKZhUr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcwi2dT3"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CMtqJ61846922;
	Tue, 12 May 2026 23:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kBbiZnr3K3CywVrKGAUjWnCyAIz9DUAdRzeH6hzWizo=; b=
	FpyKZhUr4uee80E/6Xu03FUV2ExxoNsZ1EiPpTRURYuI8clGsjDNhxmt6e1Tdp/b
	PisHmLUCdnZrI9JKZnQNCK/aO0QZvDWskdW+Rc9rkBGe8T7NHE0jKES+pGKdGtRp
	xli/zZbKxPKX2noAhHFKHIr0mSMXNtcCdYOWiAmTcPpbWxMgn4S6j39ckjDV4IyV
	smgKaYR8q92yGPsgbQmveiUqMIgkggxXAEgdYMV1aTABOIL493OP27Gb2UnOzWDA
	ayW4nbbhvc9EfrAsduFUyE/Llc3EC61rg2vAuAEPE7FchnPxQZqpRSseu4M/qHxl
	05VspUzob2oUdVodnMFs0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c9785mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:32:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CNU3GU005658;
	Tue, 12 May 2026 23:32:44 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nehpgev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:32:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr8BM9KVEJvPnOqh9jnUNFwYzO2rpanx4ho5uoqJG5xx6gF1F87UyGXKqd2ugBkirSLS/G41ZctvgbDFB2Qkepgn5Tfta9e60UzJtmRoxoeQc1lEc74TWIzYypyhOiYs+HKNM265lRGLbRHft+7z/bWe2hPkOrxfODGDUhjSYdOsFN7cHEOwnK+vS7whgZiIXXQZ+3nATQ3/wHm9VX7Cy2pZgchSkWlXFE2sb6Oh03JebwJIkJbQlfrngZnZpWgkhhfJMo7YvlKxwCwDUcdhT0Sw+6QIHVAzSrrFMy0Lx9dRa1UjF1QpHYccRyfPU+p5UI7aPMlT2Cfwmc/l7nJLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBbiZnr3K3CywVrKGAUjWnCyAIz9DUAdRzeH6hzWizo=;
 b=VPPmZDkmiNJXsIKwGF2VdKnhA/CTTyCcVrFAXQpC+heWoGoRXsaeRXMSFJpKHhtWAnHECcrazQBX15usCByMXT1QHEfIGQ8ueEHC57y6a8PCtg1GJYu6b1FmsIlgCzrGnBckKC+kkZg+vlSESO8jOTXZKyJsGlQslpl7tCp/5cYmxuV0pywMRJbQWpKP6r9TkyGxWrhDduijjaCbLdpDbHwQoAya4Y8JpHFFxdlYlSlJqGfEDge5LasNhJUBMtvXCgRN0eB2UcHzjFrPZ0XCzCW/XKN4fIhntj7CVxe1NQLCK6jIHkZ5fYoELlo/5gXdRWzZYvtBMMVtUfwqGfSLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBbiZnr3K3CywVrKGAUjWnCyAIz9DUAdRzeH6hzWizo=;
 b=zcwi2dT3Cq4K4ym8lsMxnwdvIEJcVMqxAQVhKs2Qw8ustCchhWA32O4/1Fa+EEr20Obw1rUhlC8Tq89ytR+dLYCiXWbeRP+qccnl2GzSwM53ATHe2yNoV5UhzEORnnzpMZSI7unrQhF2kE8k06ad/M19iGMOms1qXnqt4O68SfI=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by IA3PR10MB8540.namprd10.prod.outlook.com (2603:10b6:208:572::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 23:32:38 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:32:38 +0000
Message-ID: <a76dc36a-f0e1-4553-9ad4-4db754839a41@oracle.com>
Date: Tue, 12 May 2026 16:32:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] KVM: x86: account KVM_SET_CLOCK downtime in steal
 time
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        jgross@suse.com, joe.jin@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kselftest@vger.kernel.org
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
 <20260505003044.78693-4-dongli.zhang@oracle.com>
 <09b261dafa3b50d358debe1fb13163703bc6e0a1.camel@infradead.org>
 <2C6E66BA-B225-41E7-A1F9-E6B2DAE0B392@zytor.com>
 <87691b4969fa963b332b0be209361d6f206f493f.camel@infradead.org>
 <87ac4d82-a121-4666-bfa1-8a279133c683@oracle.com>
 <82bd3ade27e251ce6bebc03a2c8d12144523cd35.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <82bd3ade27e251ce6bebc03a2c8d12144523cd35.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::22) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|IA3PR10MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: f1671073-76b7-4b3e-a18b-08deb07ec0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kUC9dl4/FzSR2QnWr7J+NmMyNeEzzQes69+R/BFz5cUcixcDc5/lOqKH/4D348BNJ7ZkGZTDBnA4Yf5vN5i4fO2XZ+UpohopuUBsYbpYoLBf2C3ECEZOXTlGUM/NhoSHkn6bOV4ahbR3s8v3Alxd5Bv+/Cr6/QiodW2lFxM6FJ95c2i2iDpuzgwzyRd4hbs8hmzFcm2mnm8KOiXB1XcGZY67mh8el37cLCWEBGdOM2HZjjP3q7YB1anZ6gHe7vaalzIa4a2fsrQcw4TtVYsNefkZR3vXcUcZqVwymXa3aSyZ460K76HYRuysLZjfFMuiHjRPB17wiG/uXs4h73WKN3rvYMHBxmiAS/jHT4yqzrm9qMaICVlVt/0BvQOewiSPaLcDybsYzm9hyi3KRg+g3rqaE3AdgavI/0tSls0F7caxd/JXfF3i93FmwzIi1zNFt25IIZKgiROmiaC3Rux89/5zrJXzNHFKs+DzZhMpFM+a73NQvXt0RpFwNOBIk3Pk+5NvDQKhNMbLzvhWCd6mwUFbKb7DJ8EbCGq8mtyBKH+zNirEBkhHeLnvHui08RHpLKIb6KIUceGInMv3wsOq9mhQx57RYFgNXp7MTUhoMweQjh5eDhohakZZ8mAWPi/4mFGfruhtEo6mI9f6dZZtZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlRCdkc5dVpuVXdCV3cyS3NxcVlZeFI4dHlKSzVNNi9YRStEMTFKTFdFVEsz?=
 =?utf-8?B?blZyMU5STmxqdkFCeVBvSTFsRng1MlloVWdRMitIOUdiQ1R1bnVRMTFqdkc4?=
 =?utf-8?B?YTJtdDgxeVhCSXZBUmM1WGU1eUlmTmhtRXNjY2ZoZkIwVXZaR0ViVEpzNUp6?=
 =?utf-8?B?UXlLQWJQQjlFTFdlQ3JlZWp0aXdpZ0tweDlRdDF1OFhNYzA2K1h0NCtxMHV4?=
 =?utf-8?B?a1RWVVlXYzNyMStHemM3RFVhUnZ4Qi9nVjRnUm1aSGQrT25BUk5hNkpUTVN6?=
 =?utf-8?B?NGJ6bUZ3Um9HWUMvMWViQU50N0p1WGs2N2ptaWJFcEt5eitEVFlWa3BheVYr?=
 =?utf-8?B?Rzh6MjcxUmlFaE1ldlQ5bnVXOXltdUJGNUlOeGFQcGNxMVVVVG9FOHlzamsv?=
 =?utf-8?B?MHZGT2ludm5jaTQyOSs1WFVqN29sY2JDK3NmT0I1ekhuNDBqMXpWUVNFdXdD?=
 =?utf-8?B?Q0g3QUtNY05qNWREb3d6R2xJY0Z1M3BQK3BsYjhKL1BKWmdzVmhDRHppR2Rh?=
 =?utf-8?B?dW1yTy9qTE9uTEI5VnFzZ2QxMVpRUEdYZUN5MXRKcXpsUjJzV3d5ZkpncU1E?=
 =?utf-8?B?VUZ1MVRTUHZCVVUrNW9NSmZpanZ1dWNZT0pSaWxuU2lGdGhMMWxQZXUySUY2?=
 =?utf-8?B?d1Fvc2VvQ28vRmFqU3pkUUljaDhxTVRtWGlCbU5EZG9WcGhUMW5MZHZuanpN?=
 =?utf-8?B?cFlRNGhqUzY1ZjJvVFdoWjBjU0ExL3J1aVZVajNnd2pLanJJUUphd25YeXlr?=
 =?utf-8?B?aTZwbytscWtRYnBzRkNqU3h2ejdmZEFKN29PR0RaQjRmSFQxVVowU3drc0VM?=
 =?utf-8?B?L21DdmRTMnhDVWVJT2l0eFdnOFZiSzNtR01SbGlROHJZa3djdjd1R1BsdGZk?=
 =?utf-8?B?d3N1T2NmZFZ1TmN6YzJuRTRTRzV3SjNQMlJ3d2RuaTJZYWZpOFpSYk9NSnVz?=
 =?utf-8?B?T0d2N29nZDdZQ1N1WGFxd3dtZGtKMldvYVVJcnp0eFptNWIwVW41bmUvWnZD?=
 =?utf-8?B?dG1udEpVbDBlWTFyeXFmSXdBZE1BMEdkOEU5Mjc1WlNJdE9JWnl4SjNmb2d1?=
 =?utf-8?B?SWlQUTJNOEFOZ0lEYno1VklxSVhsSXRrUHJMbEt2dWtxbmVkYm92THRyOVpw?=
 =?utf-8?B?ZkFnd0tCVGUyeWpXMU9PMW53WmYrQ1d3ZDIzRlQ0UVJQdTdBNEYwMG83RHVM?=
 =?utf-8?B?Ry9iL09vT2hRTnByOEdNZkNySDdIbjc2UGFNQ2JwSjJ0NndtMEwvWGdOYWFJ?=
 =?utf-8?B?Lzl4R0xBVXR3SlRrTXdFSFhmSkVOUWlDTUN5dFVjZk5qb2Zid3ZGZVBCNzg2?=
 =?utf-8?B?c3Ftc3J5QUxiNUJ3akI3bHlOUDY4dmsrOTVLTWpSNUc1TTFEMzZOcWp0bWcr?=
 =?utf-8?B?WFFvcE5paVBKOVp2OEVic1NzZEgxZ3NSbHl5RGN1V0NTcVdRdkc4WTlKVkQz?=
 =?utf-8?B?OFduaWJZeDhmR0ZWMStuTENqcGd3dVR4WVMySDk4YVZZRDRveGpqcWtHUDU2?=
 =?utf-8?B?dVZrVFplb0tBK1BGV3R1UU1TV2hQY0ZGVWlBOUg4N0JZUHdSVTA4SWt6MzNJ?=
 =?utf-8?B?SnI2VXc0SS9OcjcvcWwraXZpVVdNVE5HNjBWelNWQStVS3RhZzdVRHJ3RFFI?=
 =?utf-8?B?VCtBRTZZWGw1YXJPUWVNMVk4MzlaUDl4Ukl1U0owbzBxOG0vRmltRExJVHlh?=
 =?utf-8?B?REI3TE9yazFKY0tBRWxtYTNSU2gxSlNzajZOeXJ2cEM4eCt3MHFtMFlwUDJ2?=
 =?utf-8?B?bnFiVGZUUFM3TDVsUm1INUhqd1FLYWt2OStjNDF4aStuSW5VNzdrQjVsMkVN?=
 =?utf-8?B?V0ZJa0ZhemhKUC9qWUxmSGxORDJvL0tBS3hDK1ZmN09BVE9HL1dpQXQxNUVH?=
 =?utf-8?B?NG5Dd00rOGxDSFp5dnlPVXBWUTJ5VHFONURjRnVvR041amQ1UHg1bEkrNTZy?=
 =?utf-8?B?dVRsa1hDTWt0b2ZJVU5vbjNTZElUd3FDYkh1ZFEwczNoc09DTC9qWFBpVWdi?=
 =?utf-8?B?SlYwOXo1eE1XUmZIVUxhZUYxYzF1cGx0ejlkc0NJNis0d3pxVU1NZ1hYRFpy?=
 =?utf-8?B?a2RpNm12VkEvWVFhZmdacVNmdlg0WVZhdi93cGlETWxyWTBra1Q5OXJpY3Ar?=
 =?utf-8?B?SjNtWk5yNGNteXhJQUNZaVl6Y3Q4U2NLYnR2Y2FIakk3R0JiYXZGc0ViTDdL?=
 =?utf-8?B?ZHhOemVobDU5TllpZWRqdTNLQnFPdXBhd05wcE5aVGVpZnQ1aGhjVDA2dkZU?=
 =?utf-8?B?cmgzU2s1R0RtRFloQ3ZGQllDNVJMUVlMOGtIUGFZaGJQNmRlNEluNkk1ZkZm?=
 =?utf-8?B?RFVqNEdFajB6SlZETEtGdHQrcXpONXJLTG9XdFlOUHlTZzNMZUZhQT09?=
X-Exchange-RoutingPolicyChecked:
	B8fc9VlRiBR+9s1MTJHwrq0co+9oSKV7frJ2npLkckE57kuxfJHCxYPQ3ykX8r3J66SB31OgOB7DDh6cXbf16Al2CWO7nit8fhl/TRT9BSX4Kadro77L0vdcC0yiXL+4B9V8a0+4TiOhZ7LCv2nJ9fGDBD9VyGA3MdgGhzokOpMxzKg3ICL9dY5+0ExHGbB6gAtddhAzLq1hLdb7GOxQ1a9ZnaBQ3cD+TXyQoU84AtQ3H8t/21r3AtKkyyt9hy3WKi7ngV+2T2kIMRCySm36UIl2TZD25//frvx2QtfgF+GsbPi3B8yyF5PVD48lFTiOU6OQBuyv2EFMqrIaPuFnaQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CC+fGW5hkVrLT04LN3gm0CPQN1PEDXztSErh5NeRoH5NevsTG9B5ilWaKoiG+BjZwhXixCP9CUfGyEHSHARqO+Q3sPafF23x/IEuDaQfC4Q3W0z6KxloJcjWkbXHUgOFN+GaH8Fw98tUNyodRO8H/u0zLAIbFcu9Rwt1DkMwF/IT0IyD6XqVl/uGNQFTyjp5rjkQOuaNVg01JjhXfPKEvIa2zzizAUKvs2D5Zlk6eEQb7+PHIxUI8nNAuBZrvp0dWQjH/l8n12E9uL5HNW7IOyQeWDiGkZTABkk4HqJAbe6DnzyDm+/5VKylADCOGh6IENb18hrxaZREpMxvcw69hpGtRNiItQ60cm08E3UYlTMzft6nvBTR6trzffv1DhuH9Q3mAPDNmiWacj3Acvmd9p1OcSFRS4qWB903bV5c39xYe44ivSxNWgx/Nhj+21GQlkqEHgdxdysv9dtj1OkvyPdBAxRVLitubKwS185G+Nb+bvIdwT/pjfX6Gvvr2XvajZhAyo8iJd80iVemi7Jq/JNuQcfV6H75N9NI6dOjnfCCqQvvDrxyfmzxP3tO/A7zRyHdMEs3a78Po54RpPBpLLzFU6CzdzZhrdUUgJXXP3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1671073-76b7-4b3e-a18b-08deb07ec0c3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:32:38.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQeaOmj5236mgFLlniwN5ObznJ7g/xBMuAp7EoWAQZKCKfdbrFOuvBDvoeByc8+c6e/EZyHKmjPJtRvZRWylnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605050000 definitions=main-2605120241
X-Proofpoint-GUID: T2hHt9_XXReR1blj6OEMMeZaQhU1rZxi
X-Proofpoint-ORIG-GUID: T2hHt9_XXReR1blj6OEMMeZaQhU1rZxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDI0MSBTYWx0ZWRfX+nZ2q66co+Wr
 EXrQFmU6HnO2ZQYCbsqL0pECz7/zB6xGyHP1kYT5vAkVMX9TDhxx82hHh6SQ2Gf1N1og11llykE
 igTX0tg2J6EgA0ejJZr8AFsg+E+u3YXTSSynk3QJnqXsEk0jZRCmez49mEhiigLcg3gumTdUpl0
 tlFzR/7kghfyR6VlRV84Daz1WG8D1udjp/BIBgaXHUZqmDVGOy9pB5E6vB66ECCsz/ZSRoVoqzh
 jAJhJVCXWuDNIfDDnzLH9LRqQvDMF7WPojoUh9nyovhtr85POrnRFMIKPd9Ym3vtvwnvjG1zloM
 hdDBN4eVfRC7C73kj1BZa3pCHOeW+c/v0JcgJAEvRByi7lNcA1kvdize/iD77S0KmvbejZc4rUB
 yEH/8/oLJZpERsOV3R6EgsJ0dHFgKY0juuDTRq428Y7599JAUgESkTMTnau3iPaagAT7lwgcoFf
 sQs/fXzRGCp6NLprbpjGk4i3Yox4rBJprc01M7GM=
X-Authority-Analysis: v=2.4 cv=Cq2PtH4D c=1 sm=1 tr=0 ts=6a03b89d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=JfrnYn6hAAAA:8
 a=rGqsNasB-ue40rVe-vEA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299



On 5/11/26 10:34 PM, David Woodhouse wrote:
> On Mon, 2026-05-11 at 14:46 -0700, Dongli Zhang wrote:
>>
>> Thank you very much!
>>
>> Based on my understanding, you have two main points:
>>
>> 1. KVM_CLOCK_REALTIME is not preferred for live migration or live update.
>> Essentially, the only acceptable use of KVM_CLOCK_REALTIME is to adjust
>> guest_TSC. After that, everything should rely on kvm-clock (especially after
>> KVM_SET_CLOCK_GUEST).
>>
>> 2. Regardless of whether TAI or KVM_CLOCK_REALTIME is used to adjust guest_TSC,
>> the calculation of the steal-time delta should always and exclusively be based
>> on kvm-clock values before and after the adjustment.
>>
>> Would you mind confirming whether my understanding of your points is correct?
> 
> Yeah, I think so. Let me rephrase it as:
> 
> 1. Any comparison with "real time" should be used *only* for migrating
>    the guest TSC to another physical host on live migration. And not on
>    live update (where the offset from the host TSC remains constant).
>    The time nerds will go on about UTC/TAI and leap seconds, but you
>    can mostly ignore them.
> 
> 2. The KVM clock should be set in terms of the guest TSC, using the
>    KVM_[GS]ET_CLOCK_GUEST ioctl. (Guests without ->use_master_clock
>    will sadly have to use real time for restoring the KVM clock too.)
> 
> 3. Absolutely everything else should be set in terms of the KVM clock
>    (nanoseconds) or guest TSC (cycles), never with any relation to
>    'real time'.
> 
> Take a look at the selftest I added for Xen steal time, prompted by
> this. I posted it as [PATCH 33/30] and it's in my kvmclock5 branch,
> collected with a couple of 32-bit build fixes I'll roll into the next
> series along with any other review feedback.
> 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/kvmclock5

Thank you very much! The explanation is very detailed, including the part about
the local host live update.

Dongli Zhang
