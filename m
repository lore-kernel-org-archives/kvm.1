Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879B261B8D;
	Thu, 15 Oct 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105388; cv=fail; b=r0gnJhU42h5Uqbqxxh/5NGIs5gp4aWapRIi0zrRto9JdFC5NZH8U3+K+ROSFi5IQ8ct0tkkEyolJ4IZM6WqB5Ziisuhjk3h4i2ykHhzo5w23UDZGwZocL8qpCKJ095Ga0Cq8B700wUjTSAcQXU1v0eXW8P++Lp+fFn83viSBBk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105388; c=relaxed/simple;
	bh=uKFaY0KmNIbmcAro4yAepfb29rsWqYwRq1qhvJ/1gFg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BsE3etor095K/avOJe6ZJYWXGpyo5IwXJJ4xdMGQvaAcYQFo5+rxUjmKHxZDUzRQ3FMeEKrPNSrGlFFBFA6COYGfPO5JEwYIFTrR7eVVlzgkOGhvLVXtDPbGPgkZHBS48iokhpEtkRUr4tO0yT2ZoRFkqdnJlGEU77ecyRxgAbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDCzg5nQ; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDCzg5nQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDI0mVSd2d55lHZibl4zztdZaiJw32O52zJhFLDfhObmYYPr3qPrLiimpLGkSOb53PxENsmmKM95qS0+Kr+1paXwVEN+ye2S+J+rK0KObIXcOl38Ry711DNT7vgA5WsaSeCvOYprCkglg8Dy99BBt5fH0U9Nmd1dzXc4cC+bByQV3V/LecUoChB0TMgdPE8/yqWsJh4MH3doPkCgRmcvM1kUKyCSHwq+s21VSRHhtDGkFyorlLij5UUvydTR1kMaL8EKPWTfWQRGwZn8OsGymxJCQ4zdhkzJlFYV5mmVKId3ZMZ0IAWKR9pz0J5lhm5L2bbO/YphF9kgc5gw67IaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEByH+5TKB50076HLLnMlO6M5Js0IgTW9QGG9cLLDaw=;
 b=BMc0UuPfqaMajE2Hi2v8GBfAXaqza5OW+2PEDvnf78pCgS20ASF/9eFC1dWv64y/9fpVzlYu/JmizypcTLuFMVLzJM6MiwqPX6mHbVGkBRyHuxtcFqQ5Efomnuh4JIhowOc0AjLgFcKBUODeBUluuOitM4LQNSmLd9aQtO+dc7EGGNDtv4Si5cE/E3FWyB8BwsulDDEkUf6rnvcErB1FvCDP9O6GcN5KJgFXpqa2+SPwdeHkgUQCt/t1F4bRoZhPnqfIJ4cyeZJcEizlqmwtiBqAAnYpJ3MdnKsNd1aULnAGZJBjX8Q3h70wtxkZ9MfmqFzHbtdNiq9jVAph6DRnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEByH+5TKB50076HLLnMlO6M5Js0IgTW9QGG9cLLDaw=;
 b=uDCzg5nQfdwLKTG+qu0vSsRU9lR9hCitz1jVTE0z9PWyVp1OaAVIXvgaFskBOmFg6wrRkCnITpP5DgN/0hwnbw/vGPsYcE7AjynOTWe6b5wGDIW5iGn+MSfFuaXfNIMfEf4Ik6YJN7PGWiT4vMPe1C++as9E3UZrPpyRwOIvc1k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by PH0PR12MB999089.namprd12.prod.outlook.com (2603:10b6:510:38e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 23:02:59 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:02:59 +0000
Message-ID: <bb34cb89-5270-4544-9b1a-4dd50757fdd3@amd.com>
Date: Thu, 15 Oct 2026 18:02:50 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 01/18] x86/cpufeatures: Support Privilege Level Zero
 Association (PLZA)
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, ben.horgan@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 fenghuay@nvidia.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 akpm@linux-foundation.org, rppt@kernel.org, dapeng1.mi@linux.intel.com,
 elver@google.com, enelsonmoore@gmail.com, jlayton@kernel.org,
 kuba@kernel.org, ebiggers@kernel.org, seanjc@google.com,
 ewanhai-oc@zhaoxin.com, binbin.wu@linux.intel.com, peterz@infradead.org,
 ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
 prathyushi.nangia@amd.com, kim.phillips@amd.com, ackerleytng@google.com,
 elena.reshetova@intel.com, naveen@kernel.org, darwi@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, eranian@google.com,
 peternewman@google.com
References: <cover.1790867441.git.babu.moger@amd.com>
 <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
 <a421e579-f6ab-429e-aa00-4fe8e02a6773@intel.com>
Content-Language: en-US
In-Reply-To: <a421e579-f6ab-429e-aa00-4fe8e02a6773@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:806:21::26) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|PH0PR12MB999089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9a24de-ed47-49b1-4405-08df2b107515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iZn9bXdOpciw8XNFch3cMQEOMS1rE8wVY5WvDsjBybFeTg4WTL/swJr7kpfIV6zc71jAH+Elq+viJNdsnlvZiimVo3smOqLL5qzFuKsuUbuUQz0HVuBMvNuWYiHnCYvRgU94UGwzr2oc9bQCcrBFnECld3V5Za5RcL/Gmmh7aeymADMTfKcuuiGwGISYKV+r7CLoklDFh5QWjTaODazGNHVFeIbzfL4j9XFX9Q2UfylEaorCGRcVrw+7SxE02eSA4AcfIUAgidyoIkccXKSO4bGfkZ4hCpJP4F1Y4V7qx28H7/m+uWU63vlqWvUVBh/m/SToIojv7mPoyr7wH7P3KzH3VllW9bvqCmmBYTVBjxtTwoeuV5ghmdEZdBK5QUFBIucl1usDkMhw0OAwBdk6BCD0ETgo/yBrvH0ogi42C/OtbIPp1/lwEuy/vimec0RcHNYtjjdM1pJexDW0WWPuluVuLquM0btgYECeGbaMGzYwKOKNnKgSw0+YjTWRM/jbn9KWxR+PG/K0MdYd5hHKW2qfH6YdTLTIs9tg/YPEZP79QE0WPbD4NzaDAwpSS3N23/k8iiD/SP2pOkk4m3J7aeft4qtqnQjfaJIYEwaXd2V1SVn81HDNG8dMupyNzLXq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek9nNVRwYVErVjFyZE9tQTNGdkxqZUg5dllCRjNpSlplMUtYV1l5UjR5eUZr?=
 =?utf-8?B?bG4yaWJYOFpEN0ZWQW05SUI2czJUbjRnYWs0SEx1dWlHWlV3VUE3REdtT0tj?=
 =?utf-8?B?V0dFM0RlUGdYVnpGWWthRlFpVGdINWZCS1FRUDRDWTZPd1BKdWMyZWp5ek5q?=
 =?utf-8?B?UGl3QjZCMkZvbDI3RDk5dmRyOFh0QldjTVFUOHBHRnFDN1lJZ3EyT1NRY0Vn?=
 =?utf-8?B?dUwrRGVaVEhYVGY2d2JqMjROWUhkOVNSRkw1Sk1tdjVJMTBxaEhLSDFxTFpE?=
 =?utf-8?B?NEg3aURXM0Q3YVltek0vcXUyaVN6elRPaDk3cnNpVVhBSXpjNmNiTGxQK05W?=
 =?utf-8?B?YS8xTDNwZFc2eldnOEJVdDJQU0oyUFdnYTRPMTlVUENuRHArZ1Noa3Y0S25h?=
 =?utf-8?B?c2F0NFVaelEzdVdPNE5UK1NqR2Q0T1k0Y015b2JBWHU0RDZTcnMyek5WZ3J2?=
 =?utf-8?B?ZW4xbDlQc2RqNEh4WFBpNWh3RkN2OVpEVml5S3QzUGt0bWVRSXE0ZXU4d2tz?=
 =?utf-8?B?VFhHR0JiT2hlWHZlQ09mZDkyRzF2VWtLU0IySkVZQWc0L2lGQUk0NHp0YkJI?=
 =?utf-8?B?bmJWUXo5VW9VL1orVittZjNhSFRnUmd1NTR4eDhUQTQ0KzlBVmp3TkdlSzRP?=
 =?utf-8?B?OWhsT0hFeTJHbEhES0wrWG9tV0UxZ2NjZWxZa1Z2Mkd4OEdHNmwreWJyeUZP?=
 =?utf-8?B?eEVlZ2Q1T1J5emdVSE84eEtOSkE0cCt4QmVvQ3lrK29UeWpNTENGREJpbmZr?=
 =?utf-8?B?N1dhN0JMbC9sUm9iQ0dHMWZSNlNTTmFsSkYvRWFDQks3RlNXb1JWbHZBYXBk?=
 =?utf-8?B?OTBFWnppSzNRUWJZemNPRVBEdDhMNlpkVmRkNGRuejNRdSs3YTFMcEJlRmVq?=
 =?utf-8?B?K0FMazF2cmppM0dlNVFUblRxOHRPNnMwT3QxSzJGdG9CM3RGc1dVNFUyYzBG?=
 =?utf-8?B?SE1icmhSdjQrR0E3T3dqcEVjZnhjcjJQMC8rcmxBaDFaSXV4UFZqc3NGOURv?=
 =?utf-8?B?ckVFQzRkQUNvRUNKUVJERCtKUFBYTS9uODV5Y05HRlZ4SjJ4Qmppb25sdTNk?=
 =?utf-8?B?MllHVmpObTZxeWZIZGxsNWp3anRMNms1MjlybDc0U1Q0L05jbCtIWDJlMVBT?=
 =?utf-8?B?eTFySTZXMkMyUUFUNjNxUkdZRGJIcTBham43UVhVV0VIMEdWTC9EVElPanE1?=
 =?utf-8?B?ZUM3YjNWbkhGYm5zTzhRVXVBSG1tZU1taUxLZ3JmdG5jL0lXT3FadDNhUWpD?=
 =?utf-8?B?SmlzQm4wbEx0NmdrVEgvOEY0T1B5LzRCdVNHOVp3WGFFYXFYMXE0Z1UzVUhy?=
 =?utf-8?B?dXZJU2IwRW9LdVhYNWthL2gwTlF2U3JNYXpjR0ZFYXd3RWg2V05PV2xYQ3Zu?=
 =?utf-8?B?REdDTC8vWXhCWUhwNVluS3dLdFNiVXgveVVaK25sa2xKSkp1ZmUvM0tZamZq?=
 =?utf-8?B?WjR5MnJjRnBKd1BnUjJIaVZzaFVGUGE1cFV2emRlSjZMemJ5dDRIMTJWL0Zj?=
 =?utf-8?B?dG92YTk3c1ZjVWJzWUl0MW1mdUs5V1BRZVFjWlNCdVJyOEU2WkhoZ0RCN0Zt?=
 =?utf-8?B?SkREbmc2L1Y4QXZCaytQQnk0TkZReVJoSWtCRnNtR0RWNHN1QnNhNkZZa3Rj?=
 =?utf-8?B?TVhxR240VHVhVXMwVklURW9ndXdmU3pHTlFvZTNwNlhFeGlaMEVPalRzZTl4?=
 =?utf-8?B?NHhJZjJSbVJOQkxtZVVzMUdvcVExd2Y3c3lFME8rS2FSUyswUTNNcGs2d2Z3?=
 =?utf-8?B?cDY5YXpqNnpNOHZWaW00SlV4MitlNGJUanRqYzFkTkNsN2MzMDB1QXpIRGFC?=
 =?utf-8?B?VTFuVVZ5WkVwVlhiTnlLbTViU0JMZ0VPT1RRTkJrRlpEOWkycURBdUs2MjFy?=
 =?utf-8?B?WkRHTENBRU1tVkxhamxEWXA5SGlCZW5EcGppVDI4eksxZmdGdzZ6bGlhQ0F2?=
 =?utf-8?B?VWUwOUlzMG02UlpGTCtoVWp2UjllYkxLbjBBSmlnOHdNWWZoS25UOGs2Ni9i?=
 =?utf-8?B?bStWK0FNSS9mTTNoL0RtWnpCQVhwcWhxRVhObG42Q09tUmxFbGFIWGpBblpq?=
 =?utf-8?B?bXFpdndIS0UwTnhHMGVDVXQzOEZEek5JQ0pRekFPUlpTTlJUK1R6dTdac0cw?=
 =?utf-8?B?ZWF4elJmWG1zamhiWlF6WFlVL3p1UUtIS0I2NlFRZDJJNFhtdjBqR2F2WVpr?=
 =?utf-8?B?YUwrUHdnVHk0N0lxOTNJdjduekxIRVlQTlZocDU0RmVoL2JRWmdJVlhvTCtv?=
 =?utf-8?B?b1Z0MW53MnpjbEJucTdnMEZaenZzS3Y4RElka0lJQlJyTTRlcFQxUzVjaDFv?=
 =?utf-8?Q?MGRixdzHIe+qRLlKK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9a24de-ed47-49b1-4405-08df2b107515
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:02:59.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DP1FjxF6qfhUe//QwI5wcKWPI92rJmVero+N4r3CSMRh0uxl5MD/fzQEmGWSiwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999089

Hi Reinette,

Thanks for the review and quick turn-around.

On 10/15/26 09:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> When memory bandwidth associated with a CLOSID is aggressively throttled,
>> and a task with that CLOSID moves into kernel mode, the kernel operations
>> are also aggressively throttled. This can stall forward progress and
>> eventually degrade overall system performance.
>>
>> AMD hardware supports a feature Privilege Level Zero Association (PLZA),
>> which allows the CPU's CLOSID and/or RMID association to be changed during
>> the transition from user mode to kernel mode. This allows the kernel to run
>> using a different CLOSID and/or RMID than user space, which can improve
>> system performance and/or allow kernel work to be monitored separately.
>>
>> Note that PLZA feature associates CLOSID and/or RMID to kernel work, and
>> therefore influences resource allocation and/or monitoring for all
>> resources, not only memory bandwidth.
>>
>> The feature is detected via CPUID_Fn80000020_EBX_x00 [Bit 9]: Privilege
>> Level Zero Association (PLZA).
>>
>> The PLZA feature details are documented in [1] available from [2].
>>
>> [1] AMD64 Zen6 Platform Quality of Service (PQOS) Extensions:
>>      Publication # 69193 Revision: 1.00, Issue Date: March 2026
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
Thanks
Babu
