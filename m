Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649269;
	b=R9AlLl6pk9izf9AiuPsD2D+Asf2dTQr7LMmb2x1By7c1URlPxFRn+5beqQUqCWBvjFHh
	 /LnEtN9Hc6hcC7V4UpZcOh28G726b0iBxE4VwYxO7jsO2p0tsZx9tM648saL+p+dJHh6y
	 X4vps3q5MImiWjNEk7wsYPoekxxY/RcpvQLe59xVAovSz2hLosjreXKwy1TdSWShVfD6e
	 PlFhplouEMTrklerBW2TrLgpx1XpV40UiT/gH2jtrIyz2jyHGJyC0cRLJuhpqQJPYOn2a
	 jBdRcr4IORxpZfzAs+tealMhPLca/xg+GU/xr7ArKKFg6QuxC4mkjNg8D5cJveu8L2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649269;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jvFCHHa6vIlgfSAuB4RUcZLgFc89wvAcS35tbn+fkcE=;
	b=jgM4xgaxLrgr5fdp1zuFrmIzam/sQBX+Y4uPftys7q0P/vPnSORdlLbWO6Mp+RXuLKse
	 iSjomy578hNT5qn/EfHHjGB6azPuHINsdrSTWilaOOgk6ahxPuHH2nZOufQaCQ4txyq8F
	 9N50Pi94F3RjWZArG7O7YpyM1KloFWaOksErZcyhJ482LpaZf3ytEaN88FFEiQybFBH3p
	 o4c+iU791/4vQ7VL+fXWe06oDAH81XGeDE4dp345jo2kMdLWWWrR1RktaLc7j5sK9c5km
	 B0VBLmckWeJ7jIA1jSvpPRVO34pQ3LVTFfgCul9SOmI0o4OyPTol9NCO5nYFjYVG0GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5nCrjxMO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5C606A335;
	Mon,  2 Nov 2026 19:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA5C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5nCrjxMO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMInJtG9Jk0tF3/xIe/EwfcueBDKe3WF9O9p9JkvUqnG3xdQrnxX0r4roCpCQA3GUuL+2VnwLPYu9nMJgqkKV0GPWvYWjUW2kj0q5oyKK5+4cJYIDcGrJxO6YEwUvcH+OiiAUv8Byogzwl1UZ907muArwkliwAX6PuiS+rYvaOrqxcYALrstqIu5Ncz8XO/L6OU0CkhU5lOhzbZyrMSQaRMWtBc8eFJGgRSrLsZLrZh8Kopp4W7R7+H8dri4GAeFTlrhDSA0vOqdYWKoE2cv6s8Fsb4m4QEJVqAkjWjHsF/XKUG9qls3EMie+H5UCoHVP+NzrJl/bLOZ5WxzHr5seA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvFCHHa6vIlgfSAuB4RUcZLgFc89wvAcS35tbn+fkcE=;
 b=f/7aZDkPYIJjYAhJfCSaKXmrz1u/QXsYl4QEXvtkGnDRXaSjrkIBr+xQ92P0fQ0l02I8GvSH4NeILGxcuEhhHMEPvF2wiuxax6ngsUcqaxwuB7zkrK2SlNyYJO0ytlxpJt8ybEq07odnsqGaRqNTLf8m5gA835cWyu+u9Ar9g1VKumnBdmhG1kgMsjLCgyth42Gcb7Sjka+sq4eGBPLq4vr75oO5fdg+R+QloVnryNpEZrpziaDepTOZ3SQcc71pXLvgsDRLnAIQps6aZh7k9PfqBTdRIrMafCCdlwoSNoYxChW0qoeGpzIjcg7U+hzTrs6+ckN+fW3c1859ELIRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvFCHHa6vIlgfSAuB4RUcZLgFc89wvAcS35tbn+fkcE=;
 b=5nCrjxMOXshumvrQjE2oBs69rRu88fjuAfmoB149xZMdCVAP6KqV//QNXcBGePpsCO8kdw6WHG96hTn9dxqQBVxsP7Dk/LCZVj9XxjQxxhHSOFdzPGRJD4GFZHXLVwB4IxoSpaz2cvDgwIynVdaJR/abViey1gbMSeXF9LwLUHE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:54:18 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:54:18 +0000
Message-ID: <4d7fed02-5ec9-49b9-bc52-83571fd368c7@amd.com>
Date: Mon, 2 Nov 2026 13:54:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1793392128.git.babu.moger@amd.com>
 <c1e5ef23e83ea663e9aa969e301fac20723a988a.1793392128.git.babu.moger@amd.com>
 <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <3ebc7028-c559-4add-800a-614b29d66ba3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c947364-25f8-4175-0fc9-08df391b1452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|4143699003|56012099006|11063799006|261022105027099003|261022113327099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	2QB5C8CAn0T9fcdQXgwNCe+e83dL2A1FoUEAf2A7XLmLNMqOQ5Pg/SugPwGSllIJWmz7y0fadS32PxOF0bY2UCQp6wgxxCE/0JrNK1U6txi36AIfDWUIKkUGBwTEGjMWvD1DjlPtjzRUIUvEKro/qv5cXCtRzh2qosrcrIWixERd9pPigc1Vlv7BbaD/xngeqYwzBWmsP49kKqt5e5u0PCCcS1V40R7N8itCkV0+Lz0fk1jRZwXQLTeXNmTArpZW0tckZysfm3VLvTMTw/E4UxwJIUoK41RWmjANutRlX8XrPbzwYTc0djrSCmSNk4QNYZ9pCbV0aNKunSiyhx8vNO6SLulwz8L7hQc4eqh2z0ltF3RkMgfn611zYzQs0y32Qgh47E/MKzglq4qv9cD24+3VbIWsOpyYs4Ub6jjuTOcyW7rCxdkC7sOWcpmk0j/+54KVkdOPKJPol2Glht5TI3F4zFQ0s8snW2d+7N919EEEyR6QTdLAMvfIG8fQiINAIXGMMCZAZmILkXmdvTzJ9IdgIoKGV0Kj8/EH3imb/wl/YfGL6GsAkaLGedlAw3eii/BBsEjOafSfLgHqTo9ccZck4/vpMy/7DgEvz8mmS1O1LvQj+U7eX1iY5Rd1e/bW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261022113327099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UER1TWFabWNYWXBCU3ZURnJyU0xtb3lIU2RHcEtZTjBWNUJNU0lDd3k0MzRy?=
 =?utf-8?B?ejVObERlZ2U5RnZjbU1ZMVo5bGxnQ2oyWG9PNUhkNFhSWWNhbFFFNzkrbzhK?=
 =?utf-8?B?NnJFVUpPTEcrMGZSSHZUcWE4Q1JWazAxS0tXVmpFZ3ZlbXhVR2hJT1VOdjY1?=
 =?utf-8?B?QVFad053elBOWjMwZjM1NGtmekJHRGhHemR5Q256aXN0azdOMFlTelBIWkp4?=
 =?utf-8?B?ZkNTYUlHdU0xVnpGUlNNSER3ZmJDVktGTVE1T0VFV1lxMHZjV3dpUGdXbGtH?=
 =?utf-8?B?OWN2b3owR3lzUWlIZ0ZjT1A1ZDFoN0pPZ3gwL0kwTmlpVlpKUkV2NTVxbG5V?=
 =?utf-8?B?L3BjcjVIZ1QzWlVCN0M4U3V6VFhxMFVBc3pjcXFKU0t3SVBEWTdnWndVMnFV?=
 =?utf-8?B?MVlmL2FFVUNYd3ZxUFN4QU4wVDNURkFXcmNEQUptNWxPVWtsWWhod3k4eHl3?=
 =?utf-8?B?WDhodlRBOEFVMlNRZnM5VVlaWVZCWlFNMEhoNVRwckc5M09IOXl5aEJZYkd6?=
 =?utf-8?B?ZkVZVDZJeVBaQy9XdVFGZ0pmcVI2TlpTOW8xNCthSnM0S0ZxeW1NY1A2cGJo?=
 =?utf-8?B?RFZ5Z3ZWKzN2cVZzMzA0UUd5TXg3VVNSUXREY2w0QjV3bEViMFdKT216dnpu?=
 =?utf-8?B?bUVUV1BXZ0pGb0Ywb3FnMUhwWTlUSzBmUmNwdWNHKzh6cHNuVjFrUHNZT0VO?=
 =?utf-8?B?bFREUjVQWVNvWWhOdDRKWUhNN3Y5WE5ObFgwSFJoL3loRjlTcGVKcGUxN1Zw?=
 =?utf-8?B?eDNRZ3prdVF4R0oxYUpUTXB1UTdlaTdmV2hVbnVrWE1La0ZlUkptWENJNmhh?=
 =?utf-8?B?ZWduZ3Q1bWZNQjRUZ2pxL1dIcXk0ZXBHUlIxK0p6NEdDOVByb1ljcGxsV3hZ?=
 =?utf-8?B?WEQ2U1kvREJleUtZOXdyNi9ib01OWnFBaXRDWmY3UmtubDN3cmxnUlNqbzdz?=
 =?utf-8?B?N29VbnVOb0lIRTR6enl1d2F1aS9BbVZhWVJXNHdqZHpMWVdzQTMyeWNLTXBu?=
 =?utf-8?B?UzVSTE1vanRjcU5tRktxU29vMWRFbGtKYXJoU3dhb1hrNHc0dkZoZjZxbkll?=
 =?utf-8?B?NCt2MFR0LzZGMlZRelBpSGxlVFJLRUJ6dlhVdXIyOEFrUkpBUVVJVWlRS0Vo?=
 =?utf-8?B?VXhYVk44dm1VYWdNVk4yOGVzMEIreDJER1A4dXJVaTcrVFdUbGtvRXJ1RmF1?=
 =?utf-8?B?SzFPb0tXY3Y3YkFoc1B4Zko1TENCVUxiYk9IQUJYSmJ0MHpCY1BWeGVlTkZ2?=
 =?utf-8?B?ODVtNk5WVnFNWW5XYkpXcnBRQlVYN1ZQTzlpc013RUdoYVZ1aWVHT2RtekFu?=
 =?utf-8?B?S01qeFZsNUE1SkR2UzFZL2lVa05xUFpoUUlxbllpdHdDdW5pSFZjY0RJemti?=
 =?utf-8?B?WkNEaWVENWZTQTVxb2F2SHExQ21kWWUyMGpaM0VKeTI2V3B3aUhJVWt0YVhy?=
 =?utf-8?B?Z0tPdjVYazE1dGFUZnB4ZDVPWEQ0aXErSUlzOThGYnlUQjVWVlpXbG42SDhX?=
 =?utf-8?B?ZDN5TVJCVUZ0eVRpTkdDaGx1RENQRTFnZ1NWN2c4bWMySHdJUm9pZ21vWWZr?=
 =?utf-8?B?NXlnN0tzck81bjJSUVc2MXFHUVhDNWMzYzBFTGZHdnhKckpzWks4ZktCQ3hQ?=
 =?utf-8?B?ckFBaVZWbzBNaHBTYzVWNy9zS3VXNiswdHpLSkNyZ2wvejQzTWtNemJSSEk0?=
 =?utf-8?B?dWVjdXFVWkxCMjF2eXJidUFPeVJlUzVGSDNySElxS2EvVUdNWVYyeUFGMFZG?=
 =?utf-8?B?dE44eEg4VDFPUWxLVVZmQ3R5OXR5Q3NUNElNdUdZK0pENEdUam1RNWNISFNk?=
 =?utf-8?B?Rmw3cW9jUGhzMmd0MjlaWEpnQVBicEEvYlFPcnlEbmdDOVhOdGJwdGM0MjFq?=
 =?utf-8?B?emlhYUxGZVFKTGV1TkFzR2EwQnpnZ1VTbDZseUdOYkVtWU0vdEorUEt0NVlC?=
 =?utf-8?B?cjJRZ3NMSzRSOFZoU2xkektSZVBWc1dDbDlnUlFOV25JOFBwWUo5dGwveVND?=
 =?utf-8?B?NG1pN2dMRnQxQWZmNjNIR0tqcFhmTnlsU01zYTh5eC9KUm9VN0RKSDEzSHZu?=
 =?utf-8?B?eExiSXllSDh6bzZlVEF5eXhOLzJ2QWtlOHI4bjBzOFJUY1RRa2c3YUdGT2lo?=
 =?utf-8?B?UmhZTTJ1Q0VEWlQ1ZnNtTjdseUh3UksyMkd6ajZJL2dYaGFDbTVvdnV4RHBU?=
 =?utf-8?B?cFVJdlBkRzE1eUZ0UFdOQ3JzUjRMZi9TS3N0aWlPMFBrdUd0bzg0Rkx1cFda?=
 =?utf-8?B?cGNyRlJmdURIcno5cENBdGIxVmM0dW9mRWwvRnQ0MytFY2RPemhDNkc1R3dN?=
 =?utf-8?Q?2ncxZT3iGndADk2QaF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c947364-25f8-4175-0fc9-08df391b1452
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:54:17.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtDELy5OgYNKqCM3XWZPxnOATEEuzJ60glrf9DuoD6YYLCxOxGzqY8cq2AWIUQvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

Hi Reinette,

On 10/30/26 17:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/30/26 1:28 PM, Babu Moger wrote:
>> The mbm_event mode assigns hardware MBM counters to RMID/event pairs.
>> It is intended for deployments that need to manage counter assignment
>> on platforms where the number of monitoring groups exceeds the available
>> hardware counters. Hardware counters are scarce on these platforms, so
>> mbm_event mode suits workflows that monitor a subset of groups at a time
>> and rotate assignments as needed.
>>
>> x86 resctrl enables the mbm_event mode by default on hardware that supports
>> it. This breaks the pqos tool [1], which assumes the historical default
>> mode. It creates 16 or more monitoring groups and uses two counters per
>> group. On a platform with 32 counters per domain, that exhausts the
>> mbm_event counters pool, causing additional groups to read "Unassigned".
>> pqos interprets a non-numeric event read as zero bandwidth and reports 0
>> MB/s for those groups:
>>
>>    $ sudo pqos -m all:0-4
>>    CORE         IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>       0        0.69         16k       192.0         0.0         0.0
>>       1        0.40          3k         0.0         0.0         0.0
>>       2        0.44          1k        64.0         0.0         0.0
>>       3        0.39          1k        64.0         0.0         0.0
>>       4        0.43          1k         0.0         0.0         0.0
>>
>> Leave mbm_assign_mode in default mode during initialization. Default mode
>> uses one counter per monitoring group. On existing AMD platforms, the
>> default active counters pool is 64 and may be larger on newer hardware.
>> The active counters pool is the number of counters that the hardware can
>> actively track in default mode.
>>
>> Deployments within the active counters pool receive accurate bandwidth
>> measurements in the default mode. Users can create more monitoring groups
>> (for example, 4096 on current hardware) than there are active counters in
>> the pool. Beyond that pool, readings may be misleading or report as
>> "Unavailable", with no user-visible indication.
>>
>> Default mode is still limited once the number of monitoring groups exceeds
>> that active counters pool. After hardware re-allocates a counter, a read
>> may return "Unavailable". pqos still treats "Unavailable" as zero.
>> Successive reads can be a count, "Unavailable", then another count. pqos
>> treats those jumps as wraparound and can report an inconsistent rate:
>>
>>    $ sudo pqos -m all:0-4
>>    CORE     IPC      MISSES     LLC[KB]   MBL[MB/s]   MBR[MB/s]
>>    0        0.76         60k        32.0         0.0         0.0
>>    1        0.45          1k        32.0         0.0         0.0
>>    2        1.57        107k        64.0         0.0 17592186044184.9
>>    3        1.62        276k      4928.0         3.2         0.5
>>
>> Users that need stable measurements beyond the active counters pool should
>> use mbm_event mode and rotate assignments as needed. Enable it with:
>>
>>    # echo mbm_event > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> Fixes: 0f1576e43adc ("x86/resctrl: Configure mbm_event mode if supported")
>> Closes: https://github.com/intel/intel-cmt-cat/issues/311
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> Link: https://github.com/intel/intel-cmt-cat # [1]
>> ---
> 
> To help future readers understand how we landed on this I think it may be useful
> to add a link to the decision that resulted in this fix. For example:

Looks like Boris is taking care of adding the below text.
> 
> 	...
> 	Leave mbm_assign_mode in default mode during initialization as decided in [2].
> 	...
> 	Link: https://lore.kernel.org/20260804191608.GDanI6eK2Q07w6pNcb@fat_crate.local # [2]
> 
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
Thank you.
Babu

