Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361E3812DB;
	Fri, 16 Oct 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184025; cv=fail; b=VRpZl15d2q2vnl1F4Bj+q2uLwxesQlshsadmZcg9A3BGaCT/Jf1rWXdmTtLZJMKbUcpSidCCL31DKqbvH6Nb+NbH+jw4yTiK/wR5nTR1S5Kw8hvX+gLsCGk3bZRDOAyBtBbSeS2iLI2k/HTJG0H5Sg0YIPCPxNIOrn+zjpKP2dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184025; c=relaxed/simple;
	bh=14086800gVworB+I65hSBgA3jifAIE4N7p3Z7vQUOhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8+G7diI1jnyZmpUG1Yo7IX8mFZ/xCOuPaioDUu9ETeRK4Qev5XstLbzN1iV80KcJz1PQmZYLUQRvD+n7In46oP7OnjSyMjXeL9iLE8kUjDpMS+HF/7jjCQeZDUTnDCVAUGO1cvbzmwGFg9kaO0vTldJ5tHGf1rTCk2oBSL9xbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zd3L8h40; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zd3L8h40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt0B8odFc2k8gWISW8OuKX1Fp8mBOvtuJ2ooid7P8Orc9NDMZwTmV/KID91ONxWtrmD6/2x1R8PX2/iE91AcliyVzZv9D8vSWBOSwpSFWbdKAc/4Or0vL6lOIMeb+ah2yQT8PfUt2n6ukHGrliyvE1SwpvB/p/UB+tVhJmM2CrnCbeg4t7KuObtsTvvQUpQp5jLh45CHPtiiYUgoY0IMGpXss6zvuq0BukASS3PcRtctyxO9OuPQ2X/NVRbeH77qIjBQ3jTK1RKKZrYXzOSFvEc3aa3f69+FKBaiNiDSYHYqQV4rzndi10Yc9+8VHS+bT0KBRSdW4wBo/KoZETS7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0mF232IflyvifGc2IXf7P6jXrZOBWgKMb1aq4CLVMU=;
 b=LRak4zKGOqnBarGMb3XP6LVDDq2p/93vhpp+3GOe9WTfxq5pqtx7HLB2QGbcMF+5Gtqg1b+81gIPHfjyk0Kwth87VPeR7ChEH58B2o//piMoNrhM2m4FJkKVG58RRTIDaSgKhXgDAU+Db67iTKuNtijmIimM4036sPu49Bbq+AjAcZEODtZ41Wz06wr+0lRh4pXfLeEDL+q9luIFsg6yOLhf2tJZY6U6Q/uCj7vH+sFYDE5o5xtNaKiC0Tcus6cdMjVE3WwVZgXE0vBEGJ27IrN97EUtRq0QbtKI02kPk6zjxjoNeneiojBGVrKlKsesT6hp9aTehWotipmPSYCcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0mF232IflyvifGc2IXf7P6jXrZOBWgKMb1aq4CLVMU=;
 b=zd3L8h40RUn9lyEyiwmUxlN3zJU50ns4DBs0IJu0QzFJtzhkI+v0hjSRzcO1j2CXBVuKCKrBHkP5QGUME58PZbVSlSF4jLORLgIvLHAznhvkSGlx/QFF3Levjc2YIo5Q6Z7vIrBSauLz2NxVfJJ/IyvdJYAzwp/0re2RbIaiFYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 20:53:40 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 20:53:39 +0000
Message-ID: <89715865-895d-4771-a700-f1a8aaa385cc@amd.com>
Date: Fri, 16 Oct 2026 15:53:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/18] fs/resctrl: Add support for hidden resource
 group files
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, bp@alien8.de,
 ben.horgan@arm.com
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
 <9e770ba6dff365f823e702430ec3872709bc92d4.1790867441.git.babu.moger@amd.com>
 <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0ad861e2-1dce-4179-986c-872a33eff38a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:21::7) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e789879-368d-4f1a-99ce-08df2bc78e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|56012099006|5023799004|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4YhkdYSTx00UXTtpuTkNwfeohAI2r9vcNLSHVkVvOmnbhimuNJNQIEtJfzNyrqlukL1jUr/VhDRi/YYU2LkOayUBY4jhLDYOt02CIhq0SaxMhlWtFKalBU2r/NdkcSxAUmVNQdOCImiEeT/MjK4u49f4FrNc1A6z0n1W0LHx/1wcbdXSkqoVclwBU7ybXDhKIfazAtw1TmlV8RfKe1VdB3s1/IX1beH70GdUl0BJ6u3lz9UuB4rIMgF+0O4alSqMKkbNf2j6Tlx/rO1yY5+zFgwPz6uUnt/vN0rhBjUpNzzaZNWkV2jQtCJEwMyX0gVzMge1RC8DBVEKWkeBQ+WNNRcu5jsHn6IsdjxtYDAFPPIA0lV9EaaoQXnEdzwWHZogmVbHx2VtAOiyFc4yTmYb1aIvO/Gmbct174Ybtqef/sOlRs56lokqurUORyJ0bXZWUuVrV3IjawIFfDZSnSecLu6dpPRK8mX47Oc0GGxEouEEESu4dX2/3p8BxL+m4sCdjQ1Ip7YTM0t6iqgzk+Ua98ifxT/naMJrdGgALSpNMIMHrLeTmCkVRg3gME6tagqVUhe1YpIep2M6ODITEgY9BiX3UbMDzn7kSRuut5jKF65ym7NC+EVABgbuHTCkADY4knwY7U64clZhdmpF3426GfbtuSRn4VcyJF24IdjHkIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUcxZ2tydjVSTGlPclA5RTVSYTV5ZmgvdWltMEpoM3g5Q0F6dVhINUhtcGhr?=
 =?utf-8?B?cW1UbXUrNjhZQzZOdDJIbSthNDladnRad1RRdnFVdllPSDh6NWZWZEZ6bXZJ?=
 =?utf-8?B?RzZsVGhKVmNTaUNET1NUL09nTVJ4WWdQWU80UWpvVmNJZzhrV3BCRUdGTTYx?=
 =?utf-8?B?S2hzMGNCTndKNC80Q21xRXhtbTBKYVUzeWlvQ25SY0JvVWdUUUZvb3MwTHlB?=
 =?utf-8?B?WkxVWTJzTnlYY3VlK3BsN0tTcW1YY09kVEFnNHYzZTFGSUZUQ2lCK3ViSWdo?=
 =?utf-8?B?dllpVFV4VU1UN1JYVjdCN2ZRSW9NdXRkNHJLS2FsNUZDVDhtV2tOWHI4bi9q?=
 =?utf-8?B?bGVTRDVQMHhHSXRqbHZuZ3ZNT05KbHQwSjk4U1UyTS9qOVB5V3hINlJ4Y1Fo?=
 =?utf-8?B?K2xLT09CYm1peG11RWRrZVY5dFlDelk1WEhoLzByNUU3b2xzSm84eTJQL0hs?=
 =?utf-8?B?SGdSV0hTK2dqaEpjaDQwU3ZaMm1xL2wzcVJTcWxZa3Q4SnFaTGdublk4MkR3?=
 =?utf-8?B?dTVUcWJRV0NjWXNEWlBqQ3FEZFdHd2lnT1gvVXlvYmhmS2lUbmJPd2dRTUdj?=
 =?utf-8?B?NStGQ29JZlI1b0VtUU5SSkI1WkhBZEVwYXBwQVVrcUJyL3Q4MHNKUitXc3ZP?=
 =?utf-8?B?TWpzRlJ1UWloWEdoMXVKODFnRlFlYmFkWFM1Z0d3Qm9HbzZRNGozSjloUDJK?=
 =?utf-8?B?eUhrNHJHT0oxcG9JaXhrWFI0MVdqRFp1blVOSVVBZG92cTM3OHlFMkpKQkNI?=
 =?utf-8?B?a3ZpajFiUWlyZTF0SDBlYklMSXRSK3RRaWpQeHc0Rnk4dTVYQnF5WEhWYVBD?=
 =?utf-8?B?MUNXdHJzRWVlOVlvMFJwdW03SWE5dmhMSjhlQk9ZV3Jmc3hqcjdLWWJ4b0JT?=
 =?utf-8?B?em45THQ4emx4RkZYVkVlK1M4SDhwdmJ4RTBESkhCdDRXRG8vYTRtSytCUFo0?=
 =?utf-8?B?MWhnWGVyeTJkdTZ4ajI0TEs3LzZIb2JGOGUzVDZFY2F3U0FFa0xIUVVGK0NM?=
 =?utf-8?B?UHZLalJyc29odzJ6eWl2QTN4MC9kdVdKYnJnNEUxdUdxMkZab2p3QlkvY0hU?=
 =?utf-8?B?a0ZIMU9sUWlkYTZySkl4ZEdIa2Rhc2Y5d3QzSk1GMGgxSU16T2dGOS9EdFl2?=
 =?utf-8?B?L1d4M3EwT1JTTzRIY0dKTUcyWmcwQWpBeXgrbGxkYXJXUVZjZDdqdTYwcDN0?=
 =?utf-8?B?dzFBKzNNOXNsRStqTUFlZWpHSnk5cGpnT0JBZkpZVHl2cDh5bGduaG4rTGtl?=
 =?utf-8?B?NzRYZU9KT3pKT3FTUW9sMzMyQU1hWk1pRWFkejMzdVBJSEU1QVRzM2RaeVBp?=
 =?utf-8?B?MnpWbWsrcTljYklrOEFVcVNFUXJKUXk3QVV0Q3dWV2U2bGNzQ09xWDNZSFU1?=
 =?utf-8?B?S3VBY21TYUs4dFJXR2pQRlJkaUJ3VGFsVDRSN3orQi9ZVC9CSXFzMjBES3Iy?=
 =?utf-8?B?U1FnWEFHbHlPR1FUYWxCZ211QmxaODZOWjVrWktwcWlTMDNoNGlYWXA4dnZo?=
 =?utf-8?B?ZkExM1ZRdVdEc0t2MitSMGRzTTF1WThnNW1FUVVZUXgwM0NXTGoybTlMV3VX?=
 =?utf-8?B?bENlbklTWUU3enhIS0RiQTJhUWZPMHRsNnE0ZFRRUzY5alIrbVkzTHQ1RXl4?=
 =?utf-8?B?clZDc1U2RzFCcUs1S0o3bDlYTGdrN21wK21ocThFeEtMYWJWNmRuM29TMStB?=
 =?utf-8?B?WlZ2THlObzFOVEtXbjVlNysrMmxZdzBPdDJHemdJK2xLdGJ5REt3TzBOL1Y0?=
 =?utf-8?B?Y0tOOUNLMGlVRCtrU2JHbWg1M0ZIYU1hMTk5L0R4ZlZXRVo5SXRDZHFaYkh2?=
 =?utf-8?B?bTFjMnI3VXBzaEZFbDNGTEZrQXRGSjc0TUFyU3VBbEVseTJaMGV1Y3hBWHkw?=
 =?utf-8?B?QTJ4azczZFZCVTVSMkp0eGJrNVZmbmZOSm1uTGlqOEdWQndkSmZBTnExS1lX?=
 =?utf-8?B?ZXUyRGtMbEFVUmhXYXRqV0tib2Q0ZmxPYlZRdC9TU1JWd2k1dWtXTHVwSTdQ?=
 =?utf-8?B?Rkp2b1hJZk9SRy9CMVNzREZaQkhTVUErK0dOcEJ6b1NxZnpqT2o0WmhBWW5u?=
 =?utf-8?B?REc5VGI5M3RTcTVXSEhvZW00L21tRE5zNE42cG1BNXR4YlBaTnkzQmhqWkVx?=
 =?utf-8?B?TVg4U0VZdmV4SjVObnJWamxXdTlGVlc3cnY5L0hDSXpGTVNHM3pPMnJ1bFU3?=
 =?utf-8?B?NGZ5TUN3K21MaENDd2xmZnoyVjE0MEhTTGd6NW42VjBqWXZMMGp0RkhGMmdG?=
 =?utf-8?B?MEtsN0V0S0F0UVN3b1UrM2xzWGNERFAzMWhZMmRRQnFIYTNRQ21mcE95bW1y?=
 =?utf-8?Q?oGbv5ZW/DWGb/yVhc9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e789879-368d-4f1a-99ce-08df2bc78e51
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:53:39.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3Y1nfYgOceigfY6B6D2pt3CJDvIXsqvJzS9med3ZUfd22DEYNYDgfUnaa1k/NlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

Hi Reinette,


On 10/15/2026 10:27 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Some per-group resctrl files are only meaningful once a resource group
>> has an active kernel mode association.
> 
> Could this elaborate more about how the files depend on the kernel mode
> and why they may not always be meaningful?
> 
>>
>> Creating them only at activation would complicate group setup and
> 
> Why would it complicate group setup and teardown? I think it would
> rather complicate mode activation and de-activation but since there is
> no detail about how this will complicate group setup it is difficult to
> compare. It is difficult to reason about a patch when the motivation is
> vague.
> 
>> teardown, while exposing them on every group would show empty files
> 
> "show empty files" - technically these files, as they are implemented,
> will not be empty but return errors
> 
>> with no clear purpose.
>>
>> Add a hidden property to struct rftype to hide files at creation.
> 
> Missing a "why".
> This can append to describe how this adds the foundational support in
> preparation for features to restore visibility when the feature's files
> need to be exposed to user space.
> 

Will rephrase the whole changelog:

"Some per-group resctrl files are only applicable to resource groups
with an active kernel mode association. Accessing these files before a
kernel mode association is established would result in errors and does
not provide useful information.

Creating and removing these files when a kernel mode is activated or
deactivated would add complexity to the mode management path. Add a
hidden property to struct rftype so files can be created with the
resource group and exposed only when they become applicable.

This provides the infrastructure needed to control file visibility for
future kernel-mode-specific resctrl interfaces."

Thanks
Babu
