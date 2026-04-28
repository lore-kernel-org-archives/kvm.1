Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FC3BADA3;
	Tue, 28 Apr 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412114; cv=fail; b=eMsua/pt2Ck55paZiEvXgmSN2J9BRl7kWIrr4t4vAEWT8WoADlNMk9v2FW25ahMEhP4ovJwuCKUHCfFygRX+f7t+ZFKzYdYBHLaMH+c0iO/5jcHTt5atxIfsCEsN2ZmaON8qfvdXlq/W9ZY9t7pxXcMOUvR9JZ65ZkR3DbYNU7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412114; c=relaxed/simple;
	bh=W9cWRv8D7iMdBB7WWQzbpthnx52wY7K1qq8rlgYiIww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beJsLRjjWlubC1j9bPjp5J7cw2dxUhe4qXCF8neuieNNsn83o8EQrsznYgtCEOxL+7PiNNrLNLY8OBfMW2rp6tTD8lrzbxwj6kCqAatX+RPiZhza/GqH/uB5wXnwVKtkvoBzCIm0DcH9v47RUVBhwHBziA0c1OH1A6QIMkSIqIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Go46Rlau; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Go46Rlau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJPC5C/FPFHB233GGQUle8ZEHwBh07JffRYoRD31jJUr0Hl4Z29iXLZooZOzlYtM6glHs/mtWnEui5DBeBKVMZw/baJqPpkD+vMAj+dcPYlEX7IypSDx6S/wI02VGE3iUos+FoS4wxMyl6N4HZDdypVa1nKhCvX245ELVcMGuEYku2eH8WaBPVvBe18WHQx+6p6NNO/F9wvX85ETZoG42XVK2MYOVNs5ooxsRmefy/fRh+tMRgAlgn/XAHeVnIHK0NS0gxCp26cxC8LbOufz+L30kOeVmZP0MSjTawLbtMMTofMpFNUPgvcjZer73efmTJMNG+onfK1AqfQ1IkDLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up/XlEgNJOvGgidBxliCvPIXTU7A8bHhf06yT0Z8eec=;
 b=E2qCHAhsB/cHS/QS+OUtYl5gpYkY01N4g+LIC81q1QvVGfujUWgpYH28wWl1n6z8eYGhSu3M/9eXIYQEl0ReoE74nmT0DqiaPOLjXJInol0FYC4DNdgBirLJ2ofw3l06cLVDcDBfbokDGNvuuu4ZSKBXTq/P7l8LUAMqsWDrHe6vYmwmCd8Seuw0xs/cfib3+ADYtmLLXPMmA7KlJ4s0vs4N2rzJPX1vQZZqASCUVKJ8/CsZNexquprFiv8c4MB/uPkMtZ4D+rWCkxZ8HdoER1PTEfqgprm+yMkFsbBoo+VFZhKG9OQxRlQ7EB74IzXXTcMKPbXdfPzsJv7uWKM82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up/XlEgNJOvGgidBxliCvPIXTU7A8bHhf06yT0Z8eec=;
 b=Go46RlauKubsrdjBRy21ybljJTdjgsp9sXZNVtosSQwtyIMdN8Tbg4Wf0hwYLtErZ+GRvKz8EkQRJdm/HeGWOGaGrMylw79RVIVZUyQruW8g1sQ6jRLNqX3hJdFMPfB8cJVzkl5DHPv8FVP4HVramOhRjsaxhs9CJvhXnMA4Yd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Tue, 28 Apr 2026 21:35:07 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 21:35:07 +0000
Message-ID: <a501340b-6d26-4755-92e0-69e14216057e@amd.com>
Date: Tue, 28 Apr 2026 16:34:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Borislav Petkov <bp@alien8.de>,
 Naveen Rao <naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@kernel.org,
 kernel test robot <lkp@intel.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
 <20260402202558.195005-2-kim.phillips@amd.com>
 <20260428164909.xkxdqhdsguq2wpal@desk>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260428164909.xkxdqhdsguq2wpal@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0618.namprd03.prod.outlook.com
 (2603:10b6:408:106::23) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ad1daf-b865-48e5-4946-08dea56e045e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	liFmtndtvX7lQmArcLkh4okdclqW5WWz3/TR313clSTGFUxcnKoLuae2HyG9OgYrF9VWmcuhl+UwuKgiocphI+WIzYXX/9aupjAzOMjwwJD0jZ3kl4M9GiBfSjchp2sMmKNPxqHzPMdRdqH7YgDVY+1Ng7u2KBM/jwlPlez0BfboCgX67iXEEPsZlVjkifFGQ0BM6EdQOLpmE+iIPoT3KNxTj0EGOiG23lOi4wMvkTNMFXHoBC2TaFGbD55lO9Eed43QCpjmQQuAsE4SfkBvRf/pVTEYCg28hrMvnBe5z9Ioj8aVa5A2qSQkHq1O7nTP8l03vVUmRNBFAUQO8aBKhy6IchMK7fKs+vXcbW+bdd2xomjVxgK2J0FplrAdZYPNO95RZUjp6q8wnp3SSydVXJUxQ7AfcIXCw7kbfTrAtz/EEER42zJFovNElX1TbwrrDlIViEFmPkFndmV9faFogsmYor+NbhvCkkWzE5+a9MAF5gfPD1ISLh9spTGQEuuwnKoamW+hzum74V/bvgmni3dt+wJeIO+O/JHUNDlRzFXeD1hgD/bw2LLIGYFUgwNm1LB0U1EQ0ExENhksFNXJsjIQa7FQkmsmVXM2kAOH2wfCX4M3GqLT5O4hCa6+AVlWqfd0eXjPTKKYeRF3JIbLsJbTpU1tq7IG9Lbrmif6ryGgZp24y1d7URTT+BGABSz1Dz839OAfroCLiZKcrrQFOcRUDUvMqK9YSyKbFFlW1y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUFxbWR5QytFMjBJS1FyQ2ZNQlhpc1ZoQUIyUStCeWRBZEZvUElCUnhBME1P?=
 =?utf-8?B?cU84eng5dm9kaFU4dlp0S1JTOWliK0lVdzdIYWF0cGtMSEFuQ0xUNUlLL3Fv?=
 =?utf-8?B?YWZLa0hWQk9ZSjRBODR6d0tTYWs2Z2J0R3BuUFR5MWJ3ZVJLcThmTWdwQ0d4?=
 =?utf-8?B?aVlHa1hkMmJmQlF5SXU3TVhtSW9OVURPSythWG9kNWkrODdIMWtmb1BMaGg4?=
 =?utf-8?B?bW1sRDRKRTNvRitvSmY2QUFiOEVTbVlDL3VBSzQ3TFdxVDl5Qy9PSld6eU5G?=
 =?utf-8?B?NjUwUkdkeFliWFVkdDc1KzZJVlA2NGk3eW11MG9CUjNKV291V2R6RlBUdlNj?=
 =?utf-8?B?K1A2NXZJOXdLRWVkaE1EbDA5MzRibjBweHRJNWR6QkFhSENMcTM2WklHUTl3?=
 =?utf-8?B?N2hPbzU0ckVhYU1CVFozMUJSdU9aWEVNb3dJMFZPNTRGOWx6MU95aVd3cGpr?=
 =?utf-8?B?S2J1UDQ0L3cxUm5nbHloVUNUWXhaVFcvbVUwSVBMR1pNRzFMbkFnKzZjMXNk?=
 =?utf-8?B?RHptanBadE4rbGhzVnNweWt0WmsvRVVSWjczK2NHcWcyRFpnWHExUE90Zkpy?=
 =?utf-8?B?d3ErbnpkTldFVWdvNnZCUzRQeEZiNHJ1YU0vd0JtSTc0SVlCVVRuRlNwUUJJ?=
 =?utf-8?B?aW9LTHhrQ0dHQmdVSmxRMmZzdmVDV0hwamhFWmJST0k5Y1lIUk4ycTczdEVF?=
 =?utf-8?B?eHlPYUR0c2RPQXlZb3V2MWJOajJyczZSOUxSbkI3dU9pZXo4WkRWenF6YU5R?=
 =?utf-8?B?dTczbFd0azlZNVYvRmNpWTZNVjRDenJTalBQdjJRaGVhTHNHVi9PZ3dDQ3A1?=
 =?utf-8?B?UThJNWthVkM3T09wdEdmTU5teXdFTzZOdGUrUHl6bk9kVEQ4MGpkVTNHSi9X?=
 =?utf-8?B?UnF6djNLaFRqQ2lHaWNlMEJtYzVXeUN1L1RBa0lkS0lZK3ZRSUpmbEk4aDlY?=
 =?utf-8?B?THRpcS82OGZvSVZxektZazZENEdXdzk2VGY4L2F4bk1maFNOODhBRysvT1FT?=
 =?utf-8?B?blgrRzMySUh6K2xETzNXUzE0OE92OGpsT1hSTGo4bWNsWjVqT0Z2L0x3dk1k?=
 =?utf-8?B?ZUxyVWVWM0tlejc3UzhibFFoUnplNkt4NTQyaE9aTHVjeEp1WVEwYTlicEdO?=
 =?utf-8?B?TlRScE5xR1Z3NytWREY0alBPTk1wM1R3d25BS3M3UlNFRWs1MERSQnQvMXdH?=
 =?utf-8?B?dngxQ3ZLK2VPY1pEQW53S0RPK3VGUnJIVzQ1bC9maThPcDcreVo2Y3Rnd2lu?=
 =?utf-8?B?c1RyaS9FSmVqcUt1RGpoYjgyUE05WXQrY2hSSXdvQmxSZXozd3NIREFwVmgr?=
 =?utf-8?B?U2QyTTdIYkw5RXlKN1ZMVVJNRGlQajVLdjJ6TlNlYW5hcnhWOWVrMDlqaTVo?=
 =?utf-8?B?Y0VwMDVtTVErS29wR0RJekFGbGxOYzg1ZkxqQnoxcmRpdiszVjEreHpheWc1?=
 =?utf-8?B?SmxQYXh2UVI2MWp5YW5RTkdEK3BhSG82SUhrYnlyZDZ0dEZMRk1mMDB3c2RY?=
 =?utf-8?B?OGd4SEdhSzh1Zm1wOVNYMmw5cEpudjl1M0hwMVVxQkpkK2VlQ3I2c3Y3Vm9F?=
 =?utf-8?B?TkxXNWw0Z0w4ekhOc1pZcS8zUDM0RThvWmRReEt2am9lS3p3T1J0OWxneVRk?=
 =?utf-8?B?MTZmMEwwOGZlNVVYd3pXTEk5Wm1JaVNJUmVNNUxzNWJLTmdkRG16WWw1WHBW?=
 =?utf-8?B?QTd4L0g4UUhVNXpCZmdPcjdVcVAxcU5zUXk4Z1VQR05nMmM0NTZNdWRzS1Bh?=
 =?utf-8?B?TDBra0ZDbU0vQS9KN0JSZC9LNTRwWk05cmF0UXZSclZkbnlnM2ZyTWQzaEM0?=
 =?utf-8?B?UUR0c1JQS1hIQ2hsUDZSSmtBdUxueW1JRkRMSDdsaWdLZFR0TjBDM2kvVWtn?=
 =?utf-8?B?c3hpT1VDMi9JS2NJZVN5bFlKVHpnTHA5ZWNsRGNqb09jbVBWU2lCeUtaR2ht?=
 =?utf-8?B?WDJFZmZ4L1ZFZFBhN1VTSFQzSXFuZzgvRkZlSGlqUUQ5QkFpT3EzVENrNTZQ?=
 =?utf-8?B?RklCV1ZwQjZVUWJ6b3poaXp3RjBiUXI4eUxSQU00SFRaRkRIdlpEY2lWbStC?=
 =?utf-8?B?RFU4Ry9HVSt2MGhzRklXNFpreXJNQW42TkFyU1R1cWppdU1XbHlJNEg3bDA4?=
 =?utf-8?B?amZTZTV6cGlWWk1iMDhCK2ZGaEpmSFc3em9iWEh0MC9OSE12RU5sYUhRdk5i?=
 =?utf-8?B?bW5LbVJIUTJwRmgzK2hLRXVJUWVHT1pHczRnVDVZZGhOaGFHYjhXbWVtYTJx?=
 =?utf-8?B?M3FxcHlGRGtNeCtUMnVCVHhHSWZzZzRCY0JUampML0RRYURQRFdpRHFFM2ll?=
 =?utf-8?B?Mzk2Z2poN2JZQkNyTTFMb2VLdm90WlRNSGtlUlk2a0Y2Q3ZheXdoUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad1daf-b865-48e5-4946-08dea56e045e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 21:35:07.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j96mt+6kyiHqE+BJ97pD8IUk7hZtVHkbPbQewt0W2JqmlViPGxoHXP/xcWlvl8tWqPgfdBcc+TsPXNWMcJTvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

On 4/28/26 11:49 AM, Pawan Gupta wrote:
> On Thu, Apr 02, 2026 at 03:25:53PM -0500, Kim Phillips wrote:
>> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
>> instead of AutoIBRS (EIBRS) because the commit that disabled
>> AutoIBRS if SNP is enabled stopped short of enabling
>> X86_FEATURE_IBRS_ENHANCED.
>>
>> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
>> decision to switch to retpolines in the default/"auto" case in
> 
> The retpoline switch happens in force case(=on) too.

That's right, for default/"=auto"/"=on", if SNP is enabled, retpolines.
If SNP is not enabled, AutoIBRS.  I'm assuming that's the desired
behaviour.

I'll amend the commit text in the next version if more reasons
arise to submit one.

>> spectre_v2_select_mitigation().  This allows the existing
>> spectre_v2=eibrs logic to work as intended.
>>
>> Also emit a performance loss warning for using AutoIBRS with
>> SNP enabled.
>>
>> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
>> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: Borislav Petkov (AMD) <bp@alien8.de>
>> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: stable@kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/
>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
>> ---
> 
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Thanks,

Kim
