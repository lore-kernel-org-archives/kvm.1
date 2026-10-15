Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645937E5EB;
	Thu, 15 Oct 2026 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105442; cv=fail; b=s1oIPBFC0Y7wwlsWUFyRuYfKeXk617n2laxCrnu/cHNG498qxpAMugvqfY58x7blJajwQRSd946F//oLO5cGsP8NuxBS9RjFho89wknFVOpcKeD1BX8jewkb4yuPa9EliwycA6fa1X6r2As2t9GwLK/k7hryWsFF2dmMoauvs0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105442; c=relaxed/simple;
	bh=94tLOYcuxiJeXmD11TuBb00XhQji/LNwAXPBYRTweps=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=os4W3MNrFnFxdqSSl/zVvbKL4ysgAdE+0JLdcYVKrnrWnqnXAatDpb4ehk+HrIuMxNH/wuXiWr56mohYLOpOSSI1HXXFOImaOb725yupnq9K/PsvIwk96y88zbrwbw9SkDgy1ovkdOb3pq0put7bXGe6fnJcl+t25FjK6ED3N7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpRLqwpa; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpRLqwpa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOVUBZ82TtXin3KBiY1A22InucjMXYXKXofrK8b3xncQ+1PRddAOnhk0QRDSiWXcHEJoxBDFMDUXzH8Ux+cXBL5o6OXXz5gKkrQriE5CYbWfayvDbA+JciOyOEyaJhDNoNphOLKu2eRp0ZS5mdTOBTYPhDMPzL8178sf/U25llJKi+nK6IPLOaJ5q1H4dyQ5wVRUMetq2wKpudaUJr0G2xJcsxEq6Sz4TnVxMxNC0OX00KUqpI5X8baYpwLlr3gaZxV0gKKJHflEAxmngQ1aWGZVIsD4J0lJi7OjJR4Nmf3YzzEp9yP7jyxHj89PgOilI8MUE06yyVh6if+B9cu4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkoj3nJRfWkfRiDU34eNADOyPlXur3WQ+t3IfNzg9f0=;
 b=L9UbWiWrZGfQUpsP/dLP7QDX+IG0D23cAFcarLQJjDDm0k9AZQW23f0YslKJ1ez2GNxsPA0FaWq6XSvxNO8oGbGFR9TdwnFkOoShBmatzP8VrLJiiC1zVORG8UZdj0R/i8tISX0vkQE0rftjXUxhXCupb0rSp6xIp91f76YjzNEd6GmOnnBAHHZyZOTv2+9jZVMumB8iz1teXinrjaABBn6bpvTp3MEr+ZIQXFZ99aePJXvymZSGzV6ATHl/kUIOp71hCCj1+Hdz4Ake5wzg9MxkwPJ0mS+JFV0dOM3mumkhozjXqWLLqMUSDEpN1Am6YZhbxLEqDwKghuAl55getQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkoj3nJRfWkfRiDU34eNADOyPlXur3WQ+t3IfNzg9f0=;
 b=mpRLqwpapiCEAdovNArgM3BU6xRAdCZfrND7dJoi+ZvF56tTFdWT+RCg2e80sT9obtqkchLACc2UF55mqF/33YU2x0ElUOtm6Di5r7jIkLe89SfXLmrQz8jAXdcqWZQMAd1NnBbM8KkFCW0jgwyR7aHnjEKnh+O9/W4A7qETq2E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 23:03:50 +0000
Received: from BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1]) by BL1PR12MB5320.namprd12.prod.outlook.com
 ([fe80::1876:4a6d:2cf5:b8d1%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:03:50 +0000
Message-ID: <b688c125-c2bc-4e3d-8c02-cc912936abec@amd.com>
Date: Thu, 15 Oct 2026 18:03:41 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 02/18] x86/resctrl: Add PLZA support to command-line
 options
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
 <bc2e144788fd42fdf2a3b4920e3d9a5b79c175fa.1790867441.git.babu.moger@amd.com>
 <5c10567d-0092-401b-9fd4-b0b85485dc44@intel.com>
Content-Language: en-US
In-Reply-To: <5c10567d-0092-401b-9fd4-b0b85485dc44@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To BL1PR12MB5320.namprd12.prod.outlook.com
 (2603:10b6:208:314::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: af81a0ef-ce36-4e71-de02-08df2b1093aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9CwX+8fNM3Q/pYkpG1spjuIfR+ZO8If18tvb94w1wOJ9g5nVtN9VR7G4aNCFlLMDcg8e9le9/t+l3yPkHCvAEa03mqzNh/ys3fZVD2njEiTTfgB8jCGM0N9xiKLIIKPK09RzQfnW9yr5f75qS9uxsqESqwLbGEsqeYc69JDDdeQrXq/a3Ptn84BeLLWTgLzHI4qqOeHkaJGE7V5EDQhXWHeF+6FDQbxZ8n+ZuB868fjO0CREzcAyt7g71S4z4Lk+YjpRk0r9UgSUAVBlUrwkCFkZMEdLDOnz++KRjroOXs8hdZGkNG6efJvxnPRCz5yRkmuUxpOiBsdHFxDaQbItZ5NbgcI+mFFFj6iq2uj6XZVkspY5ZgAQVZyFZtVfQ0Pdck86YWsb2wTiJ/TB65/CtckynXQX2NymFxk1/wbBwdB3duz6jBKak0CkrrH/3Is/In7es+B/+D4bQYPaqhA73eQP311uy8Of/sF3/DZeyWZjFsKN/JKswJi0Uxy5Pf1hbzN5MXm5KVb0UvWdPXWUpwxes4uVXqBBbqn74d63HRzzVK9wjG/+pVrfehpwj2MbxAqASdk7hIjkG0NVi0azjOqtpPXucEwl+HPMs5IPA0Nh3O4Ue7hxrRR3r1dN+dsqSzKhqNeRK7gZFP5uP4Hw+u4nzoE5oEBOcX8uKeiEFYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxwT2VIOFhlN2JKdS9DMk9xSkxHYTRuelBxNHpTN1hKSkZtRFNPelFnTEQr?=
 =?utf-8?B?Z2RJZDNlUm9ibml6ZnBrQVlSZ0FjREdQU1JuVmtEUmNXRFY2cWVZVkpNWHZT?=
 =?utf-8?B?TmhFcHVrYjFnTmlncVFpVWd5MFh3U1lRcmI1TUJjWTdoa1p1MjlkWFFjV3pN?=
 =?utf-8?B?eUFyUXhGcGEwUXJMcHVHdW5abzVqZWxWbGlFRXFoUHhGUXQ2QjlLNkFqdDNJ?=
 =?utf-8?B?cDVOelJ5K1BrZzdZOXlNSCtCNzlVQWlqQ0gzYTluWHRWZmlPeTgxR01leUhi?=
 =?utf-8?B?Zy9Dd3d4RkwyRzhhTHZNUG1FLzZzakNOZDluanN1Z1RQTDdNNzZsRUpkNjZF?=
 =?utf-8?B?ZnFFSzA0UWFIRzZFS3c4MUVBTnVhNWpSWDZaMEFKc3UvVWFiLzhRMWF6cndB?=
 =?utf-8?B?bitlaGZyd0NoQkRpOEhNUnVWQS84MkJJbGl3eUFQdFdESVRCV0FxQXVCSVpU?=
 =?utf-8?B?NGwrWFpYU3BLdzJwVDVGRE1lWEx2R2pybHVrb2pDZ0FaN3FncW8rcFBiQ1k0?=
 =?utf-8?B?K2FacEtDZFp1YXJUeUw0blNiZWVkYVZKRVF6VVI2VXNnbFkwSUdLUFRoUCtk?=
 =?utf-8?B?a0NJUXNXMDBLbzMwWW9kUHgvYksyU3Q0aHRsV1JjY2VaNmRvNEREWXk1Yk9V?=
 =?utf-8?B?L2ttMWxmK3BjMnlud0RtVHdtbUdITWVQd1pMMEk5eElSdFhKbjNQQzNyZ0ZH?=
 =?utf-8?B?Q3g2RkxNQjUvK2JlNkE5TzBtb2dDMDBGelNyTXJOUlZnRXhYSVZlK3luNFdW?=
 =?utf-8?B?UjNaZk0xeVBFclN5WWNtQ2Y3NnFORFc2c2k1djJoVm1kcUQva3ZzQk1KQlBC?=
 =?utf-8?B?YllOQzVxSFp0amU3aGlpVjB4NmhaS05WQmQyT3FKdUJWTlRUM2lKMUQ3clp5?=
 =?utf-8?B?Y2JTeVljMTdnTi9ydHdKK2xCZi83TjNPbTJ4VFlJalJqcng2ZWdEcXJrQXdo?=
 =?utf-8?B?YmE5MnF6YnlBc2EzSzU2c09kNVZmK1E3RzBDUUtqK25nMElXUTVmWnFpZDFa?=
 =?utf-8?B?c21ieXVsMEF3bUsyTFA0bVJKK25OQlZRT0o5Qk9VVlh3T1ltNkZ6U3lzWkg0?=
 =?utf-8?B?QklXc2RYbHhNNGdFT3N1Q01LTE5ERzdUYU1YUXRJMk16dFBKL1Q0QVdVL0VX?=
 =?utf-8?B?RmFCblhTVVl4RFFUUnZVQWJOUVpJQ2cwMHhKSjlISkt2ZEVqUzZMcCtlaEIw?=
 =?utf-8?B?Tlc5S3J0Ukt1alptZWE1ek1CME5ZRUt6em9UMWM3RkhLSEdPTzFTbzlvM3Ra?=
 =?utf-8?B?Z0kxSVJWWThJelo4ckd0cExETU5BUEJKK2NGanA0ZkZqNzdsMmxvalJuNTd2?=
 =?utf-8?B?SHYyZGZVSzZreU9aTkN2UE5uR29hTE1xZVBpcDRMZ3RqME9VVjRRT282ZFc5?=
 =?utf-8?B?N3ZQd0hEaTRyTXU3dzgwd0lVa1luVEVzSll5Q0Vqd1QzWnRBU2F0ZGxwK21P?=
 =?utf-8?B?eUhtK1hYaXVjVnUxbWpxS0tCQmZpZWV0ZWZleHdOTGZXbzhNUUREREUvQ3R0?=
 =?utf-8?B?SXV4cmx1bitZQWh2QjZxT1cyWTBLUklwaUFkNE1LcGFXdTNzcnVLT0doWUlj?=
 =?utf-8?B?NzhMM0I4N0E4eDRMZFphbFVTem9qODJ1a0hpZ3NrUEVReTR0dDFyMkJqVUhu?=
 =?utf-8?B?L3U1V1ZiNEk5a2o2SVBGeTd6MjRFLy9wVWthcmtwMXRBZC9hUTVUMCt0bHhK?=
 =?utf-8?B?YkVmaG1XcC8wUjMxN1M3QTNXWlRCNktRdHhQckNqbm5SVklCQm5WYUUrNDBD?=
 =?utf-8?B?ME5iQ0dwN3lPK1FQM0t2bDh5NG5JaXUzUkVETG4yMDI0SEZVREhJVllVOENl?=
 =?utf-8?B?WlZ0cnpzdjNWQVU1cXFISlllMHNWd1ZhYlBpU2g2ZGRpeUMySGZMTzEvaG9P?=
 =?utf-8?B?VVdDK3lQc0RUV09vVWNzNDRlUEZ5V09EcHhKTzRmQks1Q0ViUXRDdnQyVGlL?=
 =?utf-8?B?SklHajFoUngvenY2bkpNUGpJQWFZYlNrWWtLVlh2eWxtMUJlalVCbUM3Mi9y?=
 =?utf-8?B?dldJZ2d4RVhKd3E2UDRxNEY3bEV2Sm42YnkwWHZCSUFMaEp4TFZ4amE1bXBN?=
 =?utf-8?B?Q1FxRFBHQXR5S0hzaDQzY2RHRWpBRVZMVjZYcUxuSC91cVdQcXVkRWoxVS9l?=
 =?utf-8?B?bXNwNkloSUFudFJTS3FHdU9uV1U2MUw1Wkp6RUh5RWI0WGVpQS9wS0Y5aHlH?=
 =?utf-8?B?V3M4TVYwY041NTlyVjIrRjdxUEJzczllaUUzbjNWM2J1RXd3UExCOW5tOEFn?=
 =?utf-8?B?ZzhUb0ExcnJ2Zi9PSkpjV0FZZkpQUm9LZG1OYTkyQnlPTnZVelFmeXFWZ2hw?=
 =?utf-8?Q?j1c5O4jczkdoOCT+G0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af81a0ef-ce36-4e71-de02-08df2b1093aa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:03:50.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6urEBk7tLPpJBkp/1vMChVQs3XgKo9Om3KzaLQv/ZVl4bkZiWgxo8g+aVCm7b72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

Hi Reinette,

On 10/15/26 09:17, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/1/26 8:10 AM, Babu Moger wrote:
>> Add a kernel command-line parameter to enable or disable the exposure of
>> the PLZA (Privilege Level Zero Association) feature to resctrl.
>>
>> This allows administrators to control PLZA visibility at boot time via the
>> rdt= option (e.g. rdt=plza or rdt=!plza).
>>
> 
> Apologies for not being clear in previous review. This changelog has a
> lot of repetition. Above two paragraphs are redundant, paragraph below is
> sufficient by itself. One possible change would be to spell out PLZA in
> the paragraph below. Spelling PLZA out may not be necessary since it is
> spelled out in the patch self, so up to you.

No worries. It will be:

Add "plza" to the rdt= command-line parameter so PLZA (Privilege Level 
Zero Association) exposure to resctrl can be enabled or disabled at 
boot. PLZA is exposed by default when supported; rdt=!plza suppresses it.



> 
>> Add "plza" to the rdt= command-line parameter so PLZA exposure to resctrl
>> can be enabled or disabled at boot. PLZA is exposed by default when
>> supported; rdt=!plza suppresses it.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> With first two paragraphs of changelog removed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
Thanks
Babu
