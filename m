Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC363C3440
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670720; cv=fail; b=AhBIAM29kxmDn8rVIIxC35mgB96pB80K3JHXM3Lm2bDP2D9wyfio9O4Ik9KcbcGtXLqMguT+AQEpfB/r5gtB+9gMnjrVmuAiplq6KEnrBbFiyVOR5Lw9Od/H4y7o4DQmqHHt9bdziB+0hHjW1ioXuhzx2+2jaYTu7zTJB05BRt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670720; c=relaxed/simple;
	bh=joRh5HhOyJkWcGjJD5SZQxYaB1dRIm7zaNf+gnJ3dH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ogYjasqhdCWrG5Ki+h0GFI5Nz1DX9qafXt5g7bzDTduiG+Saer7Z0jssorehTzaJR+qbF6gieITKs7uiE3Lvg4qGinHdPBA5dGRP80pptz4xG6LWZuC5DMUL4XHu0p/Lu2azQLB5VCfbDcxZdWMn3eF79Tx+YFE+SpC7Z9eS1yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAfCsMlR; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAfCsMlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVG26sdvQRxDxkkSnwaXa9KPCILMTlvaZrpXvmt9iFRBoFPxBhUuZGiQENcUo3oj+cZCvbb1FCIu1MgluBNDf8nsHVVzzD7GhbhdT3QFks3xiIddxqFxKoWmZMhsIGdiPfyq7dkHAgRX9ibOIY3gE/rORLn7UiOE5liIC5xu8uZ/BxdQ0wYshL0aEYWruTmW4CffL9HIrV5Md1RYWAHkTUY5uhb6vE5Blzc6ZaE1H1SVHqb1jLdsjwwc2NBIuDcwE0LumI+qA7QxDBsYjvRISrvqhl/uJJeAE8gskKJfJ7k8g5CQjpabu5gVcS1bo9HFamZ0aQAWcAokRT+HXpKSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8cpVicnt9GmNjo0SIsd1PgHYyDRtJG3xnSDegEvZrI=;
 b=LhNIiJQLx+lGLQoPh5VRPfiPyd07+tmkh6vP0NC3z1Rb6BQULxEWyFrlJpysDEr3guRYIK+dcMwdzVGTN1uwEfLF5Sw3Vv5DcVm11yCyQ2VrOyBKFMlVScbLjKOouh0ahio7i9A/Y8uLkTs9f4X8QeHoz9t6pehWrM1QIsITkf72YpYMKy8AMUmYHvRzdg7Bsk8QE+dnHLcGL4WzLzLf/I696C7prEUefMBO1YCbfDfNLb13AfuV4drw5RTQbaAmo17QC/TIEvkcPyNkdCf7xbmJ86ConptiR4JXXSb2jFdvhHqIpUiVw/j0jr8Tk20jyV9o1E8I33h2TR+tSnpxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8cpVicnt9GmNjo0SIsd1PgHYyDRtJG3xnSDegEvZrI=;
 b=RAfCsMlRzBZox744LAwH4hdfMWfhALPEWY2vedPnDV7S7jMgYok/R9nF8Tj7ZT4LRJfDzPnIoU84wAiCGwCw6j+h3/h0DOAzOIxJsRPqnWXGN3vmKRyC5l69h7sDVHLYjvkrJL4RQR/0VkjDidNHvCeMWK9VNEhDueoUNJqkMeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 14:45:10 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:45:10 +0000
Message-ID: <461adf2d-bbe3-4b65-a0a6-9e19ce1c13b3@amd.com>
Date: Fri, 5 Jun 2026 20:15:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
 dapeng1.mi@linux.intel.com, zhao1.liu@intel.com, zide.chen@intel.com,
 joe.jin@oracle.com
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260325021236.14574-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7686d6-79ac-44f0-fbd1-08dec3110aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ac6l2B06o3UoZcGY0i4C/hudQIRNfemVxF7hvrDQq4jpqAW2nqy6or4lQN+ahKstC7ZH8N2jLlk+B3ZdyGriavV44K9mWtWoAzyT+wGM3KWlTeT7z2dKUjpAw+ZzC7se+DA/DAXvbbo+ub9pV8TiYNbHV1qSKcFqnjna94bRT3Ycr8zrBMkmhxOlCaFNsGxWr+kl3cWi+rV0DAthdhpfUiHhRguE39DAiKmjzXDqn8BMRj4xYT4H+V0G5p2MhStEyBLT2dcJef5H+ffyJUS0qEBMWUYo7Zd1a8D0CcMnvhw7BSedgU9AlzArkDIPQCRAwoHewSovvTqZOkX/l5dHufheWc9IBfEw25T/mnbKmHdrSdEo7C6J8DGQzhsVUH89ZQei6jyy/StjhRXn7mSGia79uCUXPEz3hC3jDiCAo/yz3CHe1yygFwWGBi9uKp5yWao+DdPp2Px1WjKy4Suj/sm8TNqnYJJBxI/ACmXgqmkxhWgjWXAIy5v6mxPXK6WXc1dYu1s43qfbVHW0AhoBMBEUUioNL40gzaM14gK5Yh0+Y6+pG+uL6V7aYl6TfNRgu/oRw5VemrGvET7W+iRMgHmtu3zFcrbweOVFJwxybj9w18e/DHrqR8lF7q9EdPgQD6oWr4vIJvelTw3wey4wUHVZDQuim2UWoX/Rez1Xl9E1glO8UT/TY92JQQhLePMy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTE3dTZuZUNKTURpdmllYUcvVlZyTjRBcHFJdG9sV2VBNGRYekdWVlNlMGQ1?=
 =?utf-8?B?TGFPV1czZ1cxdW9TY2lDRDlZZlpQNGpOdGVXZmtnY2JDSjQ2N2Y3eDlFejNL?=
 =?utf-8?B?d2NjeWUyRmdKWmlXdERhRUxycGx5R2lNeDU5cmZXd1hoaFlnZ0F0NHVlZ0xF?=
 =?utf-8?B?L2dFamZ1d0x3Slo1NXBTZVZVM01FMDc5VTd1TlhrZzVodENyL3pMTzVvODVN?=
 =?utf-8?B?Q21mS0FEeVB2M0poeXdpTjlmTDdxeXFpZnU3MzJuT3hFNUIwdGFFNDBRU0hO?=
 =?utf-8?B?bmhPRVNIK1M0dVkwRlFMTGJNTWpqd1YrWEZoODB3MGVwWHk5cnQ3Rk4ycUpa?=
 =?utf-8?B?VTZNeHRobTdkTitNTkpZeDNvcG5wczNCZFRYT0NXdzVISmZrWCtQRlJ3Rnl4?=
 =?utf-8?B?NTFqZmZzQ1VndURuYkovalQrUXVQd2VyQnRqQzVTS3JiWVRxR25CdEcvTzdj?=
 =?utf-8?B?QkJORFZVWlVQOUhsUDJYeVZGeUNtZ3NRb1BZTGpXelRoa0Q1Z0UrOWpjcUtS?=
 =?utf-8?B?cWwrcTRwUVdRSDRWSXJHUi9QS2ZyRTBLUUNBVW5mMjBQZzNQUDFuNytFUnl1?=
 =?utf-8?B?YTRUTlk1N0RUdFprZmFvV0pVUmFYeExHaVdWV2kxOUhYdXlzR3U5ZFNBUTht?=
 =?utf-8?B?NFVhakpRSVp0RVhMR2tIVVVYTllsNEZrT0R1bTROMlpDcVQzWVMrQ3Y4ZGU0?=
 =?utf-8?B?WVlZZEFPbktqZHI3SjFIMjR2akt2SDhQdWlzYXgzTVB5dTk0V3JWc3FFSTdV?=
 =?utf-8?B?V0VLbUdFdDg0aFhnelhBQXFhWGo5cHZPdU90Mms5Y3R2akp3dEwycDVZdmpm?=
 =?utf-8?B?dW9KclNnS3FWU1hYVnVXTVhCWVR2c2pFVmlwM2ppL3lPc2xnY1dBZ3A2U2FX?=
 =?utf-8?B?L283aUpaYzlwd29BS05RY0dDYUt6anVvejdhaE00ZXhZNFIydkNzdWxPOTkv?=
 =?utf-8?B?U2tWbFVIUTVHOXp0WWM3Q0JNY3duWU93cXZyYWU1dEJ6QWdoWGpTRHFCRWRo?=
 =?utf-8?B?dGxuNEhzTnRzNXlUbktGV1pDZ1ZrWXA1UGlrSlYvVkVkd0hjbVhNVlRheDdx?=
 =?utf-8?B?d1RuYzlVVi9iRVQvZVZ5RW9mSFBJYS8xUXcreDcrTHd2MmJrN0FpRmNaVGFW?=
 =?utf-8?B?ck9VM1BZa3FsTUZTQUlHUXR4Slp2UmRwanBic1ZtUzRnOTMrTjltU2hBL1Yz?=
 =?utf-8?B?UW1OUlp3LzZ3bVdoa1phUkcxY0IyWWs0cGRFYXpUSGJGZWlvVkE3NlJ5M00r?=
 =?utf-8?B?cCsvYjFUa2VwdjRrVWtySFBrOWxQcHRmenJiTXFjdDZyalNtaUdQVHBqQ1RE?=
 =?utf-8?B?eS9wYjUvMjE3Q2RkNzVadWFDKzNhOWE0aDZWTnhTWWhiNXdXbW1nQ1pocVBm?=
 =?utf-8?B?WUIxVTlzTzFPZzRlc3NFM1hhbUl2V1hGalB5Y2xKbC9qeDNSR1FVS3hEWnhT?=
 =?utf-8?B?V1RqMUZ6dVVxUzBlUzNMeGlReWhPRURBRHExTjhjRlVPVWx4ZFpmSDUwdEZw?=
 =?utf-8?B?Mm9lYnRSSUFGb2M5dlJmUXpVRVA5TmthSG5QYllRdzF2bVJZdzlwVnQ3M2Yx?=
 =?utf-8?B?Y2hpZTNuRUNDdUVSK3N0RVlWbFNXUUtySzd2S1JVQnF2a2NHZUVsRDVNaGVw?=
 =?utf-8?B?MlBQZ1J6VlBRbFhqUytOL3JBK3pzL0lObzYvbURoNWxhend1aTh1Rm8zc29O?=
 =?utf-8?B?Sk1TY2NGWTFrS2hvWWlLdzNxaVhlRFFlTmRkNCtGTUtZa2ZVN0NabTNQV1pR?=
 =?utf-8?B?S2NIZHpKdWw3MDJQZmhvbWMwT2VXeFFFSTN0cHBQeXRCby83cW9rVVVQVW1E?=
 =?utf-8?B?TG9vNzA4V1hVeW1pU0NBbU5nQmVGTHBHV0ZNd2w2VkY1cms5L3ZFZHhXUEZq?=
 =?utf-8?B?N0lsd2VCV1lXTXRDVFAvdjlpQWpIdUlMVzE3UmJLbXFQdmVlSFhyZzZwZE8x?=
 =?utf-8?B?ZCs5OUxCVW0zWlNpOXNWa3k3M0gvS0pZT05EaEVaVWJiTTZ0SG1idkVDWjJk?=
 =?utf-8?B?T1N1ZnBibHhlN2NPUFUwSE1rS0Z6TXR6Nzk0QWRYR3FkajZUWUxIY3dJdS9s?=
 =?utf-8?B?MWxJbkc3V1FheFE0NXdzak9xT0lNd3hKTUZlMzBCZlAzaVdhbVhubW80L2tY?=
 =?utf-8?B?U1BoWndQUjRpLzZaQldkZEFnbTRWZEZnYXA1d1hCVEtXeDlBOEppam5ZS1JE?=
 =?utf-8?B?aTV6a1Backx6blRBTldBd2NYVjBHMWsxSUV6ZlFpOFpDb1RmdnVVZk8zcGZP?=
 =?utf-8?B?VnNOcVVoMFZOUWJKbCtBVzc2RUVBWlZMODRnbWtabFpNeGdxd0lUMklrUE1T?=
 =?utf-8?B?ajBramZWT21OM0ozbkxuOGpsV0Y1NHRBSTlNYlB6MllFRkpJK2lwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7686d6-79ac-44f0-fbd1-08dec3110aa9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:45:09.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Lncbc8Ypr25yPaCOte+t0m5tC6jaG8OR5SGAoyfFEuYkPBOGwqNp+XbOMdHLTlgemxLdswJX4GxQAg+PQ8W9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

On 25-03-2026 07:42, Dongli Zhang wrote:
> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
> behaves the same way when PerfCore is unavailable.
> 
> However, once PerfCore is present, AMD PMU switches to an interleaved
> layout in which selector and counter MSRs share a single alternating range.
> 
> MSR_F15H_PERF_CTL0 = 0xc0010200
> MSR_F15H_PERF_CTR0 = 0xc0010201
> ... ...
> ... ...
> MSR_F15H_PERF_CTL5 = 0xc001020a
> MSR_F15H_PERF_CTR5 = 0xc001020b
> 
> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
> counts and env->msr_gp_evtsel[] holds the selectors, so with the
> interleaved layout we must translate the MSR address back to the logical
> counter index instead of treating the interleaved slot as the array index.
> 
> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
> the end. And in the reset path QEMU simply zeroes everything, so that use
> case still works.
> 
> However, the live migration is broken. The PMU state is stored at the
> wrong indices, so the destination VM reloads mismatched selector/counter
> pairs. Fix the getter to use the logical counter index rather than the raw
> interleaved offset.
> 
> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

