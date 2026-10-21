Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596092;
	b=ADRnqcZtL92fCCo20QRJWT/4IrlWknsMHNlljOPE3ajD7Ts7KOSRIfPT1CY0x7r9rtk5
	 Kjpi8Upyt1CdlRUPzCPsXPCvANczq/B8Y77t3NggSC6PZY/I8UuIwlHE29TD15gantd8M
	 07x1rO2E607UYMFTPFmkI+Zn15n24NhhOIDVpvMa+PCteNsigd8nLzL5dGtTA3kA1ISRK
	 ekrrDG1uGJ/glePDONjNPNPjEF3sY18Jozn14pY/b4mE7n5MTD5gUmMTUbn/fiICFlN35
	 cNjIl0DopWxwgZXfOcJRTt6yNW1hwpoc5u5GA+rfBTi49a2P9MXlNiN9jPeL42Xx7FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596092;
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
	bh=CJCItlzoYh+Yy4xJnF/49Z9TTkjcCeMaxNabWWZxINI=;
	b=jRN5DwNFyd10c3M85CbvoVB2g/y5l1O9nScAnt5JSz3nsZsAm2O8jRSeEzW7ZMHmJQqj
	 iAa8qNElcaIsESdmesma+fFLxjETleNwFGP+SnpEnsp5HR+FbJDc9R7aUlGoo5Ld5BUDf
	 0kJiJ3/0tqiBHnf3iIHRuWKMI/1GU49MGN/XC+AF4K0smg+lF98/hyOFKsN0aQyWQf4Mh
	 NjIhRRW+9fBjzJI5FkFSOZai7lJdwrwUY8r0DvrJPPCyXOJ4bTfy7PL6yrZIYd9EbEV/p
	 lf8S/7eNSb/Twwvqx9y/XrcszW/E2IHCwrlIYh+vyL1OpwWG+8ADiUePxf7MWnwT03A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3b1CFPOY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.32
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B703606A31B;
	Wed, 21 Oct 2026 15:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B703606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3b1CFPOY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky+oUgXaviqz5GO1oslgUxlpnWiMhi9bwQUnqoWVu4+dRrUfFvDZTW0Xosdk0F1TXNXB4eWPGNgwR9B/Enym/uC/74ik9oU+SY4rN1U9mX62h5N6vMk8FlUqKOyLvzjyoqXVbGXAPVWnWepADOqRXnOOjBIOacBdz2UacnXwmgb7bbiqVaEgt4TvmsvFUErcLOTDt6FLZOUTr98Oun2hdAj2TXADq6UzL+snt5ctaA6cZjUr67rW5rHH6E0MKw2980kqmINKnSSSCR0aAu/xwxvsgi3CycwKg9xbdnnl1V3/FaWA22V+8HcVU8Vpbp6imMF/e8nP5TiAwn34rlb4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJCItlzoYh+Yy4xJnF/49Z9TTkjcCeMaxNabWWZxINI=;
 b=XeWFUWQJnAqTuFqav/dN7Wivkxy742Qk06vCBFNp1dK8SWmM6K4I3z0hKuPtq98mxsqpPLSaifAOOihuvic5gmNXYrQo2XJ32E4S+MOj+UL2EMOUJKfD+fixpVDhT7XDAWf1AuYjWJupAxK2MJ9GcYfPlH9G+4mMlDnpnc7vXVeFAbawYvap9i1rj5sBigrBG2iP67gn2sQPPYy7Rh/FneKjUDI/VU/mQxrWGC7nnnzt8ZvVpHP+b7mnF7CrqWSUDTPub1FiG7zP9N74O0MycZ/MZyy9ybO3jjjH+Ft1IG1JNbLkvodxtqbBL+XgoCWZ3wpqPq7K9ztmr3tytlb9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJCItlzoYh+Yy4xJnF/49Z9TTkjcCeMaxNabWWZxINI=;
 b=3b1CFPOYl9me4Mp/wjB5Hz5wFtInqKAVjAlqWLiokW2NFr8qz2ilKtwpcHX8kiAbHUG0NneqU+buPhUm6gXxYgOZVTO0nNXJjufM8ZEFCbSwR3Zikwee8a4VETUp4SXYHwsT0DSEAJRRbN7gSrz14olVFzq8rdBoDonumvOojr0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:21:21 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:21:15 +0000
Message-ID: <a1c0c1dd-7ffd-4e67-b31c-01fa61fb3eb7@amd.com>
Date: Wed, 21 Oct 2026 10:21:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] fs/resctrl: Add interface to display kernel mode
 status
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, bp@alien8.de, ben.horgan@arm.com
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
 <e044c381e0a8720649408bea47f9251a0dfa1693.1790867441.git.babu.moger@amd.com>
 <7d4770b8-779a-4c7a-b5cd-cd3739172a92@intel.com>
 <f0bb62e7-3044-4248-9f4d-c6a8f23de7b9@amd.com>
 <6c1b1e39-4cf9-46bc-94f0-500979986d20@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <6c1b1e39-4cf9-46bc-94f0-500979986d20@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:610:b3::31) To BL1PR12MB5320.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 059dcecd-5670-4cea-1959-08df2f86f277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	55RrqTfYFaNftj8APjxSVEdAIuqAhBb3I4YMFpzT2eNzKjg3DCdJkhg+mGBMR6/+q+bP161HsxKbTZetfUXZ09UBO2KOXKORRW9EVF2+nz87fgeC7SGHbNUslZW7KNaMothqnTyeOVFojXzOANCyLXxPxMFis5h2t7o+YDcqkHpDfD/2dSDlZXFGDJn9TPef7BHTZYxs2cEPPHIgIctxmrrorDWmW3ppfPMUVMsdVxOfUorlb6rlEmWCQSDXLrWEn4EuOtvyzFqfKl8kjjSFcr5fAnc1VMZWZQUj9r8uWd+Rw2NCLYUZoKupr3ay5ZpyvaQhMB/HNUUsqY9HGpcgzKAXD2EH8rfStts5iHwW/qY5VaUenmNFgA8TIpXHYCADxAqVI1eXCCGcvBELpgAyTBdJbkg/Vsh/De7BHL5t5168ENlAYyEd8MhmyvRU9xeXr5vmedBWTiOqDe1VzoZYLprz0Nw7aA0ga8d5OsxI2c2Ei/yN0HBcSbv6vBGBp2uFAELW65BuM7aClimMxlYfDyLFunAMweIzRdtXvjh5rbDnBdddMt6zg3x3E6/qerV8sn5IjoKGUeDvR9LwlabPE+JOFBa4WvaKJFZFIY2sygH/s3pm85E4GSoIBnfaQGt6wGbAeAJkapM5bnmnHgnLIEQY5jR2AOTc1rQG/Rbj0ZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTVkWmQwL3RaUk9INE5NSGZwZDBjUzI1bGRuYk95YzlnQWU1UEVVbTh1cFAy?=
 =?utf-8?B?TUxPWFVjcnlHSVdTZjlKb0orT3hZK3FkMjZqOXhqMHFOWlFCcDlZTEh4bGRW?=
 =?utf-8?B?VHF6bkFsQUx4VHZ4azRkeDllcUVjejdTc281bGE0WUFDMlk4bUowQTA4Wmxn?=
 =?utf-8?B?WEJtdUs2enAxeCtuSGJkd2pab2hCcXg5aW5ZOGtRc29GckErMmVvSURaajVh?=
 =?utf-8?B?dzEySTNBYjBtVkovZGdzeGxUWG9nMElWNW5icmxtck1ZVlNBWEtkMUNVQStQ?=
 =?utf-8?B?eE5Fd09UNFZMQXlyTWQ3OHk5ZlVjSXVZd3BiWU44bXU0VWJpeTMzZ05lWmJ1?=
 =?utf-8?B?amN1U1ZJNlRtbGdrbWFnRTMxcnpIM2RIZVhFU3BRUFVDK0IyZDBPOWVoMHFR?=
 =?utf-8?B?SGNvd2ZKT2duaVV1c1U0b2JRK2prWndYRi94U0tQTFU4WGpGaVJRS2NsZW96?=
 =?utf-8?B?YXc0aHZubVlIZkYwdGJUWVl4MW5ub0QyQWE0UEVlZ1laMnpGWExpUGJXakNQ?=
 =?utf-8?B?MUQvVlFZSDJXN2U1U2JPeGg1R2FDZFdMZWQ1a04wcGw0Kzh5S05PeU1GTXFN?=
 =?utf-8?B?c2xJNUk4T2FDY3RhNk91b2UrOTFFVDM0UEk4S0dmc3lXaUMxVnFLbGZpWlFw?=
 =?utf-8?B?US9GMnlTdlJCVFVZYWxZM2FkZ21iWnFhSlM2d3ZXREpWVDB2MGp3cXNKQmRN?=
 =?utf-8?B?Vkh5Q3NXdmpZMG9DZFJKeTRhOW1HSnhLYkJRR3BlMW1GbWJxWTdLQjZHWEUv?=
 =?utf-8?B?UTJodThsZGJZUW1ISXJzNTdMekcxREVDSXBhZHd1UmxObFRtbkRLQ29id2ph?=
 =?utf-8?B?L3g0WXlKU1ZkMk5pQXFuWWUvWm1TU3NuRDVobzA3N29jQ2ZZMlFCemdDZlBL?=
 =?utf-8?B?TW9HZE9GeFpuaXd4Qk44Y09NNUorTmJpK0FyVFI3UW9zZ2JvSmtEa29sbmdp?=
 =?utf-8?B?ZjhvRWRVZjJIakQ3Q2hMaXVBOEJ5dnNkL25jZFVJRkdQOTI3bnRPa1gwUnFF?=
 =?utf-8?B?YXIraWlkK1I2dDNRWVllaiswZjZQTCs4WVN4UW4rVGpZOHhMcFVLQTRtMEJC?=
 =?utf-8?B?d0pwK3NmSlBSNFZWNi9pWEpNNXhpa3ptSGs2ejU1YTllblBYbUNJM2ZrUXZx?=
 =?utf-8?B?QlFBVXo4bEpGeW1LaDJhNldFTXM2eXA0Rk5PUWZvR1N3VHRwcXhyV05lUmJB?=
 =?utf-8?B?ei9jOHlPSkNoS1VtbjhDZFFUR21LbXljdGdNaE5XQzRjcndIeTZmR05Ldmpi?=
 =?utf-8?B?clpaUzRyZ0c0eVh2azFtQTk3QTZjQU1DalV5MVRWUllLMmMvL3pXZUkwczlM?=
 =?utf-8?B?b3ZScmVaMEVFaDFnSUxUL2RiS1JqOE1wR2NzcXBoNGtjdExaWlFiS2l0RWI2?=
 =?utf-8?B?MXFvYkszbmZRZ1ppM0g3eFdob2JNelFMNk1jK2piUi9NaEJzRitZS1FLSlE0?=
 =?utf-8?B?K0MrSzY2NnBSWWdlZnR1ZlBLenVKTHpEczF2NGQ4WGduWk1OZjdGWnVEYkxq?=
 =?utf-8?B?R1dVWHFGUmVWS21DdWhvdllmR3Y4bDVlZ1BuUkhlMWFtRmZLWmg2Qm5VTHl0?=
 =?utf-8?B?SE55em9zc2VRcGVRa0RzekxPSFNjVHNHRHdUVTRldkc3T3RwTk1ZWXpWeEpM?=
 =?utf-8?B?REVEQWpBc2FhOXpSSHdIb1JnNVNuUlJMdndHYzBvZXdUTXhNZVNGZWl2V0VM?=
 =?utf-8?B?bWl5MUhyWHZaWE1ldHlmbGdRQnhUbVcvOW94OWVjMHBraTRndnJac0xGK0Zl?=
 =?utf-8?B?anpwaDFnYVZlMHN0VldBM2dmbzk2djJYd2NTRFZCNHB5bDFiTk1Fb20vbnYr?=
 =?utf-8?B?Q1pnNHV1L1RvclBvRHYraWl4cUgrTnJxTG94QUVRRlJyRlZGTnBFZnoycVZ6?=
 =?utf-8?B?T3N2em44NklpbTBzbU8yZ3p3eWE4VWVtL2d1Z2JWRWFRMXhGdnRmTVRoWVNq?=
 =?utf-8?B?MndWVjdYSGZXeUdUVzBYMHZDZXV1Zkw2VllMWmRpL0xSTXE3Z3Z2d00vWVF3?=
 =?utf-8?B?bWFiSWRMYmpOYXc3ZHJ2REE5L3JaWUV3OGpWNjd4R2crTjREVnJFSjVzZzZ5?=
 =?utf-8?B?N2dGbXhnSzVpc05lbE9WcGhhQ2YvQkpQVWtsaWxZb3UzamprOTByNHNjU2hv?=
 =?utf-8?B?QkNoaUtySldyWmxHNEs1b2RJdzV2VWNNK254UlQzSEl6YlQ0aXNncjFRNVNh?=
 =?utf-8?B?Ym9VZXlnbWNMVGg2V2RtcndrUEpEcUM3aVgyQi8xaGpTUU9YSTJKUEJMYTlH?=
 =?utf-8?B?TDJsbER4Vlh6RXU0c0xid3UraGVCRFpvWFBZaHdOUTdHd0lCMFZqNjVDQWQx?=
 =?utf-8?Q?lGRrjJePh6/5SsFbGM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059dcecd-5670-4cea-1959-08df2f86f277
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:21:15.1429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEfiHE4WJ7UdSVlU9onwpQkEKr8B19Yu8AwFUfwddgVcWMa3pGp8+fsNevjqMGuv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553

Hi Reinette,

On 10/19/26 11:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/26 12:10 PM, Moger, Babu wrote:
>> On 10/15/2026 10:16 AM, Reinette Chatre wrote:
>>> On 10/1/26 8:10 AM, Babu Moger wrote:
> 
>>>
>>>> +        and whichever of ctrl= and mon= the platform supports::
>>>> +
>>>> +          global_enable_per_cpu:ctrl=<assign|inherit>;mon=<assign|inherit>;group=<CTRL_MON>/<MON>/
>>>> +
>>>> +        "ctrl":
>>>> +            "assign" if kernel mode work uses the allocation
>>>> +            association of the resource group named by "group",
>>>> +            "inherit" if it uses the allocation association of
>>>> +            the user-space task. Present only on systems that
>>>> +            support allocation.
>>>
>>> ok - this is already late in the series but this seems to make it clear that
>>> "allocation association" means the portions of resources allocated to this group.
>>> Thus the earlier " enum kmode_state - Control or monitoring association" is wrong?
>>
>> I think, it should be " enum kmode_state - Allocation or monitoring association"
> 
> Please don't. This is exactly the problem that I keep coming back to. If you
> change the name as you suggest then you solidify that you use the same term to mean
> two different things. Specifically, what above change implies is that the reader is left
> to decipher when:
> 
> "allocation and monitoring association" means
> 	MSR_IA32_PQR_PLZA_ASSOC.closid and MSR_IA32_PQR_PLZA_ASSOC.rmid
> 
> vs when
> 
> "allocation and monitoring association" means
> 	MSR_IA32_PQR_PLZA_ASSOC.closid_en and MSR_IA32_PQR_PLZA_ASSOC.rmid_en
> 
> 

That is correct. It is confusing. Let me try to revise these terms in 
next revision and go from there.


>>>> +        "mon":
>>>> +            "assign" if kernel mode work uses the monitoring
>>>> +            association of the resource group named by "group",
>>>> +            "inherit" if it uses the monitoring association of
>>>> +            the user-space task. Present only on systems that
>>>> +            support monitoring.
>>>> +        "group":
>>>> +            Path of the resource group, relative to the resctrl
>>>> +            mount point. A CTRL_MON group is shown as <CTRL_MON>//,
>>>
>>> Shouldn't it just be <CTRL_MON>/ ?
>>
>> Or We can say "<CTRL_MON>/<MON>/" to be generic for both cases.
>>
>> "The group is shown as  "<CTRL_MON>/<MON>/".
> 
> No, this depends on whether monitoring is enabled or not, or (if monitoring is
> supported) whether mon=inherit.

ok. Will try to handle it.

> 
> 
> ...
> 
>>>> +
>>>> +            sep = ':';
>>>> +            if (resctrl_arch_alloc_capable()) {
>>>> +                seq_printf(seq, "%cctrl=%s", sep,
>>>> +                       resctrl_kmode_state_str(resctrl_kmode.ctrl));
>>>> +                sep = ';';
>>>> +            }
>>>> +            if (resctrl_arch_mon_capable()) {
>>>> +                seq_printf(seq, "%cmon=%s", sep,
>>>> +                       resctrl_kmode_state_str(resctrl_kmode.mon));
>>>> +                sep = ';';
>>>> +            }
>>>> +            seq_printf(seq, "%cgroup=%s/%s/", sep, ctrl_grp, mon_grp);
>>>
>>> Looks like this will print a monitoring group on a system that does not support
>>> monitoring? I understand that the monitoring group will be the empty string in this
>>> scenario but in resctrl that has meaning of "default monitoring group" so printing
>>> this when monitoring is not supported is unexpected.
>>>
>>
>> Ok. If monitoring not supported it will be "CTRL_MON/" (Example group=ctrl1/") and then default group is "/".
>>
>> Is that what you are suggesting?
> 
> Yes. This matches the proc output.
> 
>>
>>
>>> I also do not expect the monitoring group to be displayed if "mon=inherit" since
>>> that presents a contradiction with stating that "monitoring group is inherited"
>>> while printing a monitoring group.
>>
>> Yes. We should not display "mon=inherit" when monitoring in not supported. Will check on this.
>>
> This is needed yes, but what I was actually referring to was that if "mon=inherit"
> then the group parameter should not include a monitoring group. For example, "group=ctrl/".
> Including the name of a monitoring group when "mon=inherit" is confusing.
> 

Good point. This is something new that I need to handle here, so I'll 
work on fixing it.

Thanks,
Babu
Babu
