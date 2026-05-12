Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1091D63E4;
	Tue, 12 May 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545014; cv=fail; b=soUDZ+ERjzOfr4fCk8awZPZ91lPNxuo6bf/UjX31aRBP9dVtuWCo6sZO5sYxXhfk1V02vnqbZg1eXhFt4nkKtIh9R/ZIASvxJE8A0BVFrCBbCZEzR9GHVeiPZFE7UuTKAIrye+TVMSuMngT0VDqg11u9bBE6gUKMshvb83AAIvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545014; c=relaxed/simple;
	bh=a8yFqkFuGhIJ3e/EwqyUnmgotI/N+22li6AvUWHe+Pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tvCTNoD5rOB83MJ+oonjJEJ/N9U2IF7MtX+MvlOLeFGU1ObAdgZaFElsHEajrNKNYCPv9/GECudoW4v9YA2KhRuy7SX/HMz1tfi9KdypmY/Na+VfgpQQc0VMQOolOwKIN7wBSHhETMCPJA0vAEsvr9TdANBIwiNOdxu2xsVla8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CkYdOHX3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qV9wlGse; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CkYdOHX3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qV9wlGse"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6oCr2046672;
	Tue, 12 May 2026 00:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SyO237JmWWneF6BfOmTq0zdf9wNA74b6xNWs3v+J/0k=; b=
	CkYdOHX3LW+h0sgljIv3gmQ/X51K50HZLkFSbJfqDoY0ZaVBb6IIlnDftbF//Dt6
	3Q+n+9tFsqCL6V55Rd7OKFlyqpeAqWUIifa+kUfed5izSWbGMVlqc7NqQW+HWHQR
	Raghk99tjfgG4UFTYkyUztgTsEgqn4x8XxoLNGhL3/5fomqQB3MuwMEtsajdbaBI
	X5u6zJ3cp2kyigprmB3sZArK+bqRO7A28CSKmSrkodwa7L3uZM7/STYmNV30VRYq
	HVy/h3Y3ANOmCh9SmY1BI8OGrf//9sU6bfc49+gcvtYwMflj0oe0ugx52bnbIBZP
	aH0JNvl6XubJgQYb8sKfjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv288w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 00:16:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64C0GGmw021729;
	Tue, 12 May 2026 00:16:32 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne8res1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 00:16:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrGZlLS8+bD7pMsif6VmrKKIiXErJm8fKNVmRmkret2tQfCIt+l2yqMfDF5XH2Ega02rQv5l0Qk5fNDwAP1nLhgOsWy9Wzgg1d9zzEPGp3HRKto1flKRN50OMUAP/Z0NLDb2JBvqh+KvbMjadF5ua3Zhjbn8IGZDVZ8Gd93eYUCzA+FyD26iN7Ieokd145utuOHDx/i+4kvpAfHDlSniBWPBsaLOy2M/1mjMNvPmNuIbU7iei5B4RSRWyTYHHmXuemRllGPYHXNihy4LfIzjl+/dgY/FsiN2pOnjm5FaVOnOD+VkVlCcLmyazgr60HER2EdjpXl1l56a1s7+koJmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyO237JmWWneF6BfOmTq0zdf9wNA74b6xNWs3v+J/0k=;
 b=n2lL/FUQ10K/vZ9DYzcQB20YNI6dA4UwwL167KIUOafoUQtaa4WXOUd9gTk2cgG09g7OWyDum9w58R8Q+7WS6d3kZN/SRdpI6TEyIh2/1FQrT9HCXpVj7aRKVHapMmgCw91MGRqw2ZOxV2MYEDGOCn2qAQsGG7REN4zMm7LQDRjtviz+nGq87LZUZ6UwGf0mn5z+PBwzYI4JgejRdJ6L0uyV39LJhNDur5gRYlDLASxvm2+5gAYxOnRuUIgUohNq5bfcl3PAk6oPC6Qpw/5MALoGsRIbuL6fPAEPiCbwb0Z+5Azwtrov0MgadjJfPPAdQMJQo9PMTlZ8PrlCVdBWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyO237JmWWneF6BfOmTq0zdf9wNA74b6xNWs3v+J/0k=;
 b=qV9wlGseDkdOUVzSa36GSgYpwgr/1GGdxale/xoXOUvtSFNXMkj7K7siOZk7XGDX8Uz+MhBJTd9EsOElWFFm4chN9FHQiNyhJUZjmKhBleTWOXGpvON8A9pza8DDx4zar3L8g2WJv95GyzLTi+o86ghgXC409bO/F7RM0soH/EU=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:16:24 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:16:24 +0000
Message-ID: <dfc032bb-c17e-45d2-bce2-7e09d8b2b187@oracle.com>
Date: Mon, 11 May 2026 17:16:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: x86: conditionally update masterclock data in
 pvclock_update_vm_gtod_copy()
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, paul@xen.org, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        joe.jin@oracle.com
References: <20260115202256.119820-1-dongli.zhang@oracle.com>
 <20260115202256.119820-4-dongli.zhang@oracle.com>
 <16b69905d5d14a06dbb68f29355c58e2c7d2f0d2.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <16b69905d5d14a06dbb68f29355c58e2c7d2f0d2.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:510:4::19) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH7PR10MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b084b2d-6b96-42e1-814f-08deafbbb37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Yj9dVwMhSPFApz5CCOjhQKO9k9DaU+Ysiz9MrLI1w+yi105ptq3RLxLpJaPTL/I5cu3GU8HCp2xZZBJmtBSNRIe/KMFLJWpgTdLni5SIQS5j3BI7ENBr8Y9h6p0ltwR/pQDxN6EcptJBSS+EFcwD1RHspD/MenZHslyLwFWUCs2mB/dSjUzGx4i5L0/gtDfKv4vG0CaJChMjRu7oDz8l/bQ/uizZbOi64hVpoTdhbARhV7PfZnvSKJhBCywPpwUPwXEz/cX9NCsrqdQ3uHmU/u/Htjb5W5KRmcXkU5ITQWxDogLW3T0qn+zt3Aar7cXGj0ZG7ymv7MsUYfoOSb+7q4DG4XaCh7f0ojiKVUI7DyCKPVKYpSI4YOBXxdDoGVcvv+GCNt2056fB/hl0cekOLm3QXFCIwmykS6PbyPq81W9WhT4Kq/9p8FaXUSJNZkFfOR9PeNzgbM0hHMiaIk8YRGDjo1PKsn9SEd6rbom3LJb6yCQVTC/ZDeOgqsr5ZEHhtP3IR0y9nmYqmDL+6sNYTUCI2Ucpq8ar56pMEjWD/lWQcLc+6unqmatvM410OndRIc4u8KsqVlSUNoLo57TTHBzpHYal4KAr3crcV//scHTt+wRFc9lmawaVG5zsLZfWlRH/q33+YMEmd+aqnTUCow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXo2SjhUQkcwYXd4a0N6SUR0eXgrZnI3YWlabHBYR2lnUWMzaFRvMldub1Zo?=
 =?utf-8?B?N3F1OVF4emF4T0dFUnZ3UXQ3dnBnamh0WjQvYTV0ejdxVzFvbDUzU3p2Vlh1?=
 =?utf-8?B?N0FGTXcwZ1BwZnYza2JnQWVDbW5BczVXKy9zVVVrRXVCTU1wZlBXYVF6S21F?=
 =?utf-8?B?VDl5d3gvUXM3YkV4U2FCYk1mb2gxNGRPRzV6ODZyUElneCs5WGdLbDVXVThS?=
 =?utf-8?B?dHRTcnlob2JYYjZHdXIwa2hnaE1raDBFM1ZNTythZUxQRDhJVGMxOHMzWS9O?=
 =?utf-8?B?KzlVMnZrM2hCNkw0cXp1U3diYldzd0thTkk2bHpOa3JESXloV1JqU0p3Z3Yr?=
 =?utf-8?B?RFoxT0FJdnk4cXBaTVRKWlBkbmhqZzFudHNTdDR1eGlSWXJCMHdRNVEyRzhU?=
 =?utf-8?B?RzUwMlhTdE1FRndhSFl6MTNSYndNLzc1V1dIR0RJWTF1cDc5cnJmQlJhZjIw?=
 =?utf-8?B?cWJwUitNbmZ1QkY4eEJhN2lMYmVTMnBmaHlGQzk1VTFSa1dGMzVRWnFzMStV?=
 =?utf-8?B?R2kzOXBvaUJuKzBIS0tIUXNEb1pvVWxjaE9OeURHZVdSbXpNcDluUTdJb2Nr?=
 =?utf-8?B?NjNKNlJmL2xNNmpBQWNSSmIrcDZpZnVLa2FJazJsTGFXdm50TmVGSVRCTUt1?=
 =?utf-8?B?cHBVQW1IUncram8yYzRUTnZ3WjhOUHJJelBsREl1NXlDMExIOVc1NnJqNjhv?=
 =?utf-8?B?TzErMzVVV2xTNGhNL1RZOFVCNmo1bjNGL1NGekRYUkZJMEk1eFFTYm14L1Nk?=
 =?utf-8?B?N2MvMGRCdGk3Y3VmSll2U1ZRMThBdlU1bGJjeXpHZ0hMMUNTQkRLSHZpZjc4?=
 =?utf-8?B?aDg0YWpXRWFsRTQxWHpjcEdRZXNDRTFPaGxTYnc0TVNjNitDRWRXQnlLS3Jo?=
 =?utf-8?B?WHFscU9SeHNneVJ1S0ZabWVTWDFSWUZxSjlCL2hubDRQcEt6aDRQN1hYb21k?=
 =?utf-8?B?T1BhaEV2V0JnWTJvQUlJZFBrck9pNnRUZlVndzlQRU5sWnczTnFCUCtnMWJF?=
 =?utf-8?B?SWxlVk1OVUhsa0I0amR0N3hQaXFGaG1RRWxyYzVkUWF0bUdNMStacHY2K1RH?=
 =?utf-8?B?UHFGYTdibjE2R2tvU2ZxbGt6TEhxdUZQUmNzejAxK0RpKzI5aWxlRUJpangv?=
 =?utf-8?B?d3kwWkVzVjg2ekczMTZ3VDNRNnlWV1pOdk1WdnVJRlA2SS9uVDhqVHBoTHpw?=
 =?utf-8?B?eGlXR0htRjl2K3JqSzMvakRhRDFjUWgwS1EwREEwaUpsanFjMlBsSjZOdVp6?=
 =?utf-8?B?UHNWMkJMV0drajBRNzMvSHBadlA1M2RBc0ltaVErOWM2Uld4L0dxOGRxb1kv?=
 =?utf-8?B?cnhlaGZNWnhNcG01b3hSQXNyaTIzaGpGMXVqcVoyczI0SW9jVFJLTDRxcTlC?=
 =?utf-8?B?dndhYy9UWjVQM1lxRXdqRWdWSFhLcXNHeUVycWhEN0FtVWFvcTl1UFl4ZlBX?=
 =?utf-8?B?OXllemhVdForUFhxdnZGckN2SU4raHQ5NFlzVk5tSEQ4aXpjVXVrZmtkKzFN?=
 =?utf-8?B?TGJDY3o0MkxxT2RmY0tMeXJUZ2psa20wVENOMkNFbmVVZGN3dCszQVhHa1ZK?=
 =?utf-8?B?M0ZoVlQ0eHBPaFlYR1dWcHEvWFQyZ29LSVhYQWVIU1dPN0RZRmptY2wvcXJ2?=
 =?utf-8?B?Nm9FdmtGY2RvYUtIdWs5S1Ivc3QzNGx5NGRKSlNZQVo4cEVlWE9tcXN6ZmZz?=
 =?utf-8?B?TzF6TmowQ1FENWRLOTNGMDZacTNQbkpTTkNsVjVBcmprM1p0anJsVmpRQUh2?=
 =?utf-8?B?cnNSM0d2Q1hCSFVJVlNrOXM2aGZjSklCVmVLa2NLeXdEWUQ4WFFQdnlGZXlG?=
 =?utf-8?B?VDdNYWFHSkVQNURzYkhIVS9wOGg2MHhyb2RSSjExV2x2UHB0OHBnSCtGNlk1?=
 =?utf-8?B?Slo2RzFUMG5LTmNEaUwvcnFFR0ZUdXVCbEFySEtXWFVSU0UxK0FpWG1Vb2lt?=
 =?utf-8?B?Q1poMnNNdmtYZmdiNDc3TWNXUGVrWTFCdGRlaFl6VFBEZ1RSMS9DM1RJamtP?=
 =?utf-8?B?MEJaT1pYSDV6MVVMRndCSDQ2V0FQajRqak53Q2J0V0xJcFZ0Y0R5U0RLWTF3?=
 =?utf-8?B?MTZMalJNSG8xQ0lTTExsRFpDcVFaalFQSk4yR1FBbkZ2N2NvemhXb3VqYm1z?=
 =?utf-8?B?cStITkl3ZCtVc3dyNGFkODE3QU9ubnEwNHcxNlhYWkIxa20zbW9TVmNMNHo5?=
 =?utf-8?B?R0pOSVA2dWpiblhmZ1Q0Y0dNYkZDZnRsSTRWZzJHRW5zOVM1a2FPR29CNlZu?=
 =?utf-8?B?cVMxVGlENURLMEZkMEVHcmRTSXoranlGdUVDRFlEV0ZiQnBULzRoRUhWVjBO?=
 =?utf-8?B?bStlMDR2UytIaVFFcUdKamhUajFQaHlKSEJsYUZpVW40ZENob2lyQT09?=
X-Exchange-RoutingPolicyChecked:
	T9OUkWqiHcCjde5PO0g2+LB8YokI+BUDc8AuHJoKpPab97m8X4I90+bGFKgQryO7AUv5WG1oxwDFPz3HqwWa/T7FnbpwfEPGf4tnHXn94Spbzte9LR/7JHwaUMUnwPKbwkgCGrFAUIWIS2ZB7zo3tRG/JNahYf2qQDL275rrWV0TwUdML98eyl1GPBjFXHr3EuYezHk6vVOiBoceVfYjganCeP+4DQgzC8fWORQ6+W0TdwZXcaawjFdr4NKEQzxmod8y1JUphWlsiv9fEU9U5dCeSfWUNNWN3pg26zZTliiia0u+KSINBJmj3Ga9Oad+y1ZkK0GNUHoYtSKZHPhdaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oDIFb61x/nzAkelsdEAiwVZbmARWRXAEz9kvy+8oyx+xANnl3y7+yowsSZYYG+baxKEp1lEbqzSh2nsZEHK0OGe2H7HkYfMnJP931TH7tf8g9MnvEEqgOXygQwn7xRh3C3DcVUYlhcLlKbejF4B8hxl8wXuTgYef82P/Iyi4GOJKIzUTrkVoiTYzdgp0zn88cSlADrvG6BCRkRHyaV6Sc3H1XDHrmoFgSNlC2b6TyaAfCEoTdjA9mHMTUnRnAlnXenbSQbdoeYJSi+KnD/jcgeZ8erP2xW0Fv/G8ieh5bUiXbz/7ZcTaHOg4ou9pt+2dlirC+L8B8+ro9hSiok0AlPae2oYHexxeZdkPFMX9/C6e4FBly5Z3aEuhtVcwgNhpajq11kY7x55upcpS0SAk7niDIlV4GioCWxFGLH5JU34qYmKVRLTZwSVF8R9k9Usjrlix0NQCsO4ILesJLTCNEODPAnHFSaU+4wkefm3ImL9UdQw+YQxxEpPzSAjbl6xVHDjsAjsjYag4JGI5ITC/KJ23V2+CJe+1b3Ya7OoKlkVJuyfFU7eYutMB4VU2eS6qey8L4ulQMTsO29n5HpbSmcFwut9yb7wHNNcLG9YQED4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b084b2d-6b96-42e1-814f-08deafbbb37b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:16:23.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5DjiNBGlhtq5sOhee3DCMeWcR4dDiWRKHqCsvj/WlgT5srvA1ZgDjN9wqHgZhHCbP86lteL/ewhBLjWCNE50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120000
X-Proofpoint-GUID: 6knNdPZhnBpYECrJhVXWryfW1BBFVI0s
X-Authority-Analysis: v=2.4 cv=ed0NubEH c=1 sm=1 tr=0 ts=6a027161 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=pBOR-ozoAAAA:8 a=yPCof4ZbAAAA:8 a=TVad7cM8Uqfm4GdpaxQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 6knNdPZhnBpYECrJhVXWryfW1BBFVI0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAwMCBTYWx0ZWRfX2o4MC+TJkLvw
 ni10ryHkALAsuVPqCtIORZx7yIGqlL9+c3E89HaSk05NxSonlzz8BAHce215dnjiY/aNRCge8Vw
 ijQyr5oPeaUFgr53MsYagFNN647oKPHi4iDRs5gIn0ip+tvmaiqeD7myKlLrSnNWWxijSRIztCD
 QeDCb+iZQO6W49IJqhBLMyInDk0T5OVWoo0K/pOQOu2ssIP7JI0tcG0VmSKHMJ/sI/UOsOcCM0E
 to2tcjIzf/67pYwe/4bTpZqde3QtN19lj8IfvqCdAIEyv1N6YFFrG+VFeh167qq5qk2o8YViYZJ
 cXi5uNw2SCPAVvVNW4Kues7wb5y16qCKua/CMBzMev6u1VfVy+QY0JzvYzaQAahgFXcPrF33CYg
 eMNqtf+YHgS5FzOm7qLf0xOiT4oeLbL2F3NBFnT02YgVA3MqvXCrnUNg9f5QLeP9X/CE/gyNxo3
 kr270JNwR11fBTeiErQ==



On 5/9/26 5:22 AM, David Woodhouse wrote:
> On Thu, 2026-01-15 at 12:22 -0800, Dongli Zhang wrote:
>> The pvclock_update_vm_gtod_copy() function always unconditionally updates
>> ka->master_kernel_ns and ka->master_cycle_now whenever a
>> KVM_REQ_MASTERCLOCK_UPDATE occurs. Unfortunately, each masterclock update
>> increases the risk of kvm-clock drift.
>>
>> If pvclock_update_vm_gtod_copy() is not called from
>> vcpu_enter_guest()-->kvm_update_masterclock(), we keep the existing
>> workflow. The argument 'forced' is introduced to tell where it is from.
>>
>> Otherwise, we avoid updating the masterclock if it is already
>> active and will remain active. In such cases, updating the masterclock
>> data is not beneficial and can instead lead to kvm-clock drift.
>>
>> As a result, this patch minimizes the chance of unnecessary masterclock
>> data updates to avoid kvm-clock drift.
>>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> Hmm... so the only caller of pvclock_update_vm_gtod_copy() that doesn't
> set the 'force' argument is the one in kvm_update_masterclock(), so we
> are asserting that kvm_update_masterclock() never needs to *change* the
> masterclock origin point, if it was already set?
> 
> The gtod notifier callback in pvclock_gtod_update_fn() also ends up
> setting KVM_REQ_MASTERCLOCK_UPDATE, and is triggered by an actual host
> timekeeping update (which could potentially be from a clocksource
> change). It also hypothetically possible that the clocksource changes
> from TSC → HPET → TSC, switching back to TSC again before the
> masterclock update ever gets to run. Or maybe a suspend/resume?
> 
> Are you *sure* that the optimisation is always valid...?

Thank you very much!

I didn't validate the scenario you mentioned. I missed that scenario because I
assumed that most production systems nowadays use STABLE/CONSTANT/NONSTOP TSC as
the host clocksource, although I sometimes forgot to add "clocksource=tsc
tsc=reliable" to my AMD L1 KVM guest (acting as the hypervisor for L2 guest).

I didn't follow up on this patch because I noticed another issue. I found that
the tsc_timestamp in the PVTI can become a very large number if we simply reboot
the guest VM. This happens because the patch stops updating the masterclock data
when the masterclock is already active and remains active.

For example:

current guest TSC: 122763682
PVTI->tsc_timestamp = 18446744073656540006
PVTI->system_time=196515164269

Although I could not reproduce any bug, that still made me feel uncomfortable.

I think the patch you posted for PATCH 2/3 can fix the issue mentioned in this
patch.

https://lore.kernel.org/kvm/f37f0ae0ae1dfce3ad3c6fce653f5df34adecc0a.camel@infradead.org

I would also test with your patchset, if the unnecessary masterclock update is
avoided or minimized to one time.

https://lore.kernel.org/kvm/20260509224824.3264567-27-dwmw2@infradead.org/

Thank you very much!

Dongli Zhang
