Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCF30DEA3;
	Tue, 13 Oct 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853242; cv=fail; b=JZayloLJZOkgoYBLkbbzGx3R558A8wdUcH0QFOqZ7d14AyXepQJyuFuP6btv+PWbdv9HdWvFyCYvnxNk8jpq1WZFGcbIhKhgh0EJMQUnEO+78rUwF3KsxxXcCOpjGP/X1HL+/9U/XxpapMKckey0szzTC71xZHhUA7wI9kZTSuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853242; c=relaxed/simple;
	bh=K3o59doHMBlrB4DIESLSCNIEwVUKsBcNVzptHIfIKAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqjbGnrMSiXjU6IBXuppxfsqNBIQa87yvcZ4J7Fag0POpOlKbFYlMk4zSdwoIqRP4jI+9pbfRJ+WmaGoKXv24KwMdYr01QVwUn4TKjO/c3eawmNwGk2ST004Xv474390IvFBlo9q3n27IOZyp9J4G73C/Zt5szk7t/AHK2QRD5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FQKMutnK; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FQKMutnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bk4QvEYlBWJoX38ZE6sY5Ee8HPzQRkV4q/fMekiS9ODPB6fkTCxF4V15gHh4pwlWVY0JJb+c06hWnWIDdxcJE8uPxIlSh7zPswcJ1RwUJgoRBo4vu3Bn+tpmiJ5b4FVBuYAWPOtO8Y1kS05meTraVKNeju/rjbyOgC2/n8Riec43hAKF5VqRGuxe5BDcjiifY5yHvwPwcTQzbnP8HvD3Ti74knyl4jY+Uf83QsX5RMgUr01ijRFfs3oyJwdNzuHiSerme3KlJWZN4686kmu7nvzU0MOAf6xrf5bPLtq291TscCkZj1YZC5yBCmES5uDZMVWEzCqRNOGf+/prHKDvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGxKphlnlw6MLGnSHARDn2gFdQmqhl+FNzycaWnqirg=;
 b=d8d0527UH6m1dIO2x1gJyGBZ0YYMZVtjHU0RZp+2EtJaxF16ZDriEI1W2lX5auAmh7hUKcCWgQWixzjjd9vo7wLg37+WM8UM5DbyBKSFuZ8w4AZdcdoqMygAzt0JfnUvqYAcorrn222DaMTm6EzrD3GXUWfmECX1/a+PhajML6Uh2fl9OtIxnxbB554OYXRScbLdL+7n+zfVWPNqst1552VRkIAB8vP+JzBzFZTe7ZsjbIWjNc2cwkDCFW2vQrzZbUMCvUOEbgBFoZ9dwi/scNeURp+tZWL/Sk3GdvHjCtS3g+l/J4pWpYItydTnGQpI6PfD3g5ZS/+dkRQJIrw53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGxKphlnlw6MLGnSHARDn2gFdQmqhl+FNzycaWnqirg=;
 b=FQKMutnK6e8gKbLPC5uZCKIyf35NMnm+U1wJ/oGR8knQDFQ6wruaJKgWLob+6dJxNbk5dM8i0Ii6r4h56tSNolO5C4ng2pBOd/ochiEwskuViAMck/OykRy8z+XOZXH3YxnrI4Knxv5+ydvbIeQQM2aVMtpNha5xyntvugsFyIQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:00:37 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 01:00:36 +0000
Message-ID: <2d56a760-de60-4a5b-a270-b504ff2ca345@amd.com>
Date: Mon, 12 Oct 2026 20:00:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/resctrl: Fix ABMC counter programming
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <94c453ca762ef0c32680ac1163099c30866a99c0.1791589412.git.babu.moger@amd.com>
 <0ce0ac49-d0aa-42c5-b0a3-08b09b9f130b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0ce0ac49-d0aa-42c5-b0a3-08b09b9f130b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:806:122::9) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db3521f-fb73-4751-0131-08df28c563ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|3023799007|261009223027099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	q3n/j2TU7qPi5pWNVvBPllsAc8XHAy8oDGpclNXf/w52tEO0KqCgLJ6LP14H6DgPC92tFDKGpfpiq0sAQ3FiNE3Ugvx2BWOqFCZPjNcDfub1rkWJzTp/vuVcj5A7rEkqFTc6s3Z+xdn/pwHvd2GJ0oErwKSfoLOLV0MGweL8nDf/nzdPXaSSkkYaaXFOoe91c7Ed6+o5dtbj7R24mckpPot2Z8ec5UkKwww+NiTOCj+7z4vu61XCQsnJDYYt31Pt2gYtEVJgPidW8SkYR/95OdQJa6WT2lZex5zfecJlp4lT2UolSLOpPu4tX5ohNDFkGmv0rIiw34zuq69p05DtdGwda7+KAkCAH6RlKSbXfOBMtG7m4TSO79huncMjfzByooOoDJcUCGVK6AqoJKQa1IrtJjP1MnffxS+lLs7u04pbTgQEbETTTGEQf07OH7J1lkpp2//1LLPIGT/mtw7R5paNIZCDF/H66TdJ11uNowqmVtv5YpJBXgIvUWVbXSOL04f7t1Jpm458BgZ/g9FJl9YRQuAmjYHR1/6zTV3t1yh0JPk3FJPShrqIVIa7vGx4TN7Ux5dnOYgcq78r1Jk9C+pI6qfUIYIPZ3VBXbUZuD1lUJ2OAnwEzwBP9FWf2mnHuk+MAwO2WWsQTXfz+PwKCo0Fb50spQEoUnsa45BXox0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(3023799007)(261009223027099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVl4Uk9kMVNFWW1SVmFzbzV3K1BLK1RKc3hqdDZIMFVKdlp4V2NSb2NSeHJP?=
 =?utf-8?B?NThIcDZlR3lKcnNBSGRDeUI0U0NnV1VTN3g5cysvZnpQb0hhNWwwSWVjUmtp?=
 =?utf-8?B?QzYrWEp6Zk1acWRkcS9XekFsbi9pZmVmclJTRmxvbDJyMDJaNDdKaklXaEox?=
 =?utf-8?B?S0hZMmJieTQ1c2RHTko1MU1IVzh4N1RBTnAyYU5BUDR4NlZJaEdGSEd1V2VM?=
 =?utf-8?B?OXowY282c0wzRFZ0Snh2Skd2Qi84QnBnVUZwZ1BkczhXSThHU21Vb2FabUNl?=
 =?utf-8?B?YURzMWJ0MEpQM3krVy9oVW9jeVlOa0gvS0UyRXV0cFRJNW0xTWtDRGlmTk5D?=
 =?utf-8?B?NUNrVkE2WGwyT1AzR29Ub3BwZFV3cm1VbFZhakROZ1I2KzdLVWgxSnNDYzh4?=
 =?utf-8?B?ZTdQbmpyc1J0anBqRWV5eWNoQXlic1M4U1luazFwR0dUYmx1cWQ5RGtUdW9p?=
 =?utf-8?B?YmYwUHc4NjNLblplTzV0LytvNVQxSk44c3YzTEYvbDFZcjExMEJjWDRqRk9E?=
 =?utf-8?B?TUpKeXpYb1U5c3ZlY09nNFRYQUdocVJwa0ExdURrOTZMamlsN2NEWk9jR3Zo?=
 =?utf-8?B?OXZBRlZjNzRiTENob0RvMHZ5QkxTWVRXK0NxbXl6b0g1UlE2TFdqMVVNUHlF?=
 =?utf-8?B?NSt5akEvRzFva3E3WllleHQ1Q0RmVEU1K0tOU1ZuQ3ExUjdzSFVMRVYzNFhV?=
 =?utf-8?B?aXNaZjBGallvU2NCejZ1NFFrS1NHbTYrOXJHYlU4d2dMNHFBeEJUYmM4VStH?=
 =?utf-8?B?aGFUUnVSRDRXUkFaSE5NYnQ4aWdqMUxUanpsaTgvU3hQV3dkY0c1T2E5VCtS?=
 =?utf-8?B?eFRTOEg4ZTRrTVJTOVhmTkdGaVJCbkYyZThiUFF2aWlOVlRHa0Mrak5MY3F2?=
 =?utf-8?B?TlJBaWJ3aENLdlBCMEJURk42TjZuczU2YjNad1ZjQXEzNWpDN3ZwcXhPQXE3?=
 =?utf-8?B?WnE0dURuRDFSQjBmbnFBSkhoRXNlMy8rR2JBK2h1dDBCamFXNWRPMUZOa1VR?=
 =?utf-8?B?VFBRWDFJMWVvZ1d5TzB4V3VZaXUzalJtTnltUlRWNXZ2eis2SlpVM045aDBh?=
 =?utf-8?B?SXNXdkRQNUhmT01ablN3M3RLdG9mYk5nRWZBbnIxSWJlYzNZbnVVRjlSTXN2?=
 =?utf-8?B?VER4VDlnNHdNUE5BOGYzcklJQ0x6cmttRCtWNVAwa1hCYStIY3hLdllENmt2?=
 =?utf-8?B?RE9oMDAyWXdrbVYxMCtWU0pmdEorK2Q5SXR5cXU2cEdnaU1nRVFTazRUMy9Y?=
 =?utf-8?B?cXNHRVRFSWxSdTQwVE5mOVQyOGVqMWE1b3NFb0FLVVROUmV2QTRDOFhNUnRW?=
 =?utf-8?B?eEdoaHFRQUM4SWJaUUtzcTZMaTAvdlNORkIxZ1hUYWVpUWxLcGs3cXBlOXUy?=
 =?utf-8?B?VW95K0lKd29WcVAwcW5VQUVvcUcvaVFZNlJxWXZVQTNDOEVTdVNuUU5HUGFO?=
 =?utf-8?B?MmcvVHBIejdxQ0JMWVNVTnBWbVJwaEZrY2hvNGZqVzYzWnhKdE1CKytjUEZY?=
 =?utf-8?B?RWExNFpqTENwcVhWTk5udmtJQktyQ0FqS3dueHpjMkFPMjlWUTh5a3g2S0Z6?=
 =?utf-8?B?M2pvVzdyZHdjek03U1RiUGhUNlQyTk5KRWFjVVd1VUlldk9MeW9SSnNEU2Vw?=
 =?utf-8?B?Z3FLYm5QZFFBak9kWUFPSU83cmhRUUJIVUFBTlg0VUpvcExWRHUwUEtkZktY?=
 =?utf-8?B?aGhpWFRKbUg2TnRlZHhGM3FuWlUvWkNUZGZmRGt6N2V6elRYMDZySFU3UnhB?=
 =?utf-8?B?SUNJYTYyS09EaXdpelhpaUFXSnR3eHJRQTcwTklzVklnSndXdE5Ud1p2QWFr?=
 =?utf-8?B?K0Nlc2FjbWxEb2loUjFpMHdzdERhMEJlbkh5Wno1Y2R3ZWFnNUhtMmhudVVi?=
 =?utf-8?B?Y3A2cmhlUlFBMmo3Q3FKV2pjbjJnL1RHME5QZkxjZmFOaTR2bGxocG40Ti91?=
 =?utf-8?B?ZmJkTlN4cE1RdjBDdVVVTjlkQUhla2RzV2Z3clVOd3JJOUF2NHVBcHZrbVYw?=
 =?utf-8?B?ODRBcjlNY1M1ZS8rRnhQbXY1eFRPV3orVEE4bkxNakdOWTNkYlZDcFdGTm83?=
 =?utf-8?B?L0pDMVFBNWU2eGxjaVBiTnEyZTlrTW5tN2JPK3QrcnFFcGxGQ1loY2xVVFNr?=
 =?utf-8?B?THBKNWNCQUNkUVdqUm9GL295M2NkN2lIL05hZzJ3OGZ6Y0d5amo5UlIwaldL?=
 =?utf-8?B?d2t5QnMwanZsY0t1Ym5uNTZjTnRVSGcwU1BTSG44Q2JVMEdTTGZWZUx1OEE1?=
 =?utf-8?B?cGdKZ1A3RTBTVVdGWXluSjFkbjdqY2c3RGgyWUFwemZPSUNUdjY5U1piankr?=
 =?utf-8?Q?knN8wgf1D3Lnk5sS9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3521f-fb73-4751-0131-08df28c563ee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:00:36.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErFCChIz4F0RNMtfoR2jHMUgEitYFPKQdChDCzJdELLc09PaiEy8urvbYleowpaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

Hi Reinette,

Thanks for quick review.

On 10/12/2026 1:40 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/26 4:44 PM, Babu Moger wrote:
>> AMD's Assignable Bandwidth Monitoring Counters (ABMC) are configured via
>> MSR_IA32_L3_QOS_ABMC_CFG; MSR_IA32_L3_QOS_ABMC_CFG.cntr_id selects the
>> counter the configuration applies to. The number of counters a platform
>> supports (the number of possible values written to
>> MSR_IA32_L3_QOS_ABMC_CFG.cntr_id) is enumerated separately via CPUID.
>>
>> On platforms that enumerate more than 32 counters, the current 5-bit
>> encoding truncates the counter ID and misprograms ABMC.
>>
>> The AMD64 Architecture Programmer's Manual [1], available from [2], has
>> been updated to widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id from 5 bits to 12
>> bits (the published revision 3.41 does not yet reflect this; a future
>> revision will). The CPUID enumeration reports the maximum counter ID in a
>> 16-bit field and may therefore report more counters than a 12-bit
>> MSR_IA32_L3_QOS_ABMC_CFG.cntr_id can address.
>>
>> Widen MSR_IA32_L3_QOS_ABMC_CFG.cntr_id to 12 bits to match the
>> architecture. Cap the enumerated counter count at BIT(12) so every counter
>> ID used by resctrl can be written to MSR_IA32_L3_QOS_ABMC_CFG.cntr_id
>> without truncation.
>>
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
>>      Publication #24593, Revision 3.41, Section 19.3.3.3 "Assignable
>>      Bandwidth Monitoring (ABMC)"
>>
>> Fixes: 84ecefb76674 ("x86/resctrl: Add data structures and definitions for ABMC assignment")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 

Thanks
Babu
