Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB922339
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670940; cv=fail; b=gm4oUEk1j1vbJqAMYxXV4zIp+pY6mqJnMrBnw81JvxFwWAvkKoMMOOBzCdWmkGGyFWK9U3gSPGpRKM/XinXwrqT0nBqUXkBQg4SDZfqRCbvFZtzo9x50cJ0n0If9MoZ7EYU0ZwKVJFPCniPz46j4X6j4w0K03lC+CbLuRLNc6ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670940; c=relaxed/simple;
	bh=gIPwRTGwQwRyTaf1krahUYH1LUbGePETcMg1qmWCv3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PB+1g1n1Pmn7xMmrfTO673GUXHh6mrvAXmrxiUEmfxdoiYSm5tc0erzBIsr91KGnMUo/c/da1vQS/waBjiUHbajrUE0d19f0c4c0/yBzzhxbjyO5+/DVsKqJQXcNdsTYAEm8WgSURqJtS8yw7k0cI62C0UXMEsNVOIMZAFIJ/Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=be52xF1v; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="be52xF1v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBmhi626XaJbNTi3K36e2HbLMccNE61ypZ3RGJ7zk1VLdVRlOeERY7ieFFJ/nXiNME465jWFuSq7UWBGvJpKGuFr5B7gMTfpqVWOa41E6mo//522MafSxaJFDAFpiUns31Le7bbPo+XfWhwLaX+O7rCD+rcQGiE9j0r3XeePyyJTp+3zmr9nKr8BHEb7V2aQgDLnp2IXxSVuOFGxXqkiKHrnLUZoCZUAX6ZrIar0CZ03Bo193ASqCp5d87iz2Wx2yBI1WnDeotJNiAWjbYJQYwDXgjIe0D+NcjGKm/E6saZ5wwY6wN2PTzJbZ2nV4zdP5GUyjcxPsu5bhMUYpTpiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unbe0/ME6L9B/PzmHyAI5r4ZLReoIZ+F3Up+tud47B8=;
 b=pD9AoCS97B1hFRs4mUZ1LfHfnzA5UFWUZjt0tMbwA49/c3AJ9OC327GZqZvyzQwVay6q/raLF0GD6McLRbPgRxZyCYZfyaeH1fIHs9S6bFcaruzrC4Sf3ReX3OEVytuIf6ZF72AfMrPRPtg69fXg+qqG9mbep3/P4XR9hZkFgX9J001KPrTHh/nu6doeILx/u6tkW5sNt80H4WMX6bgm+KndnVhpEwOapOHyS7gp7hc2uTKsKzQ+X47PfxG2oX3HAMkhvlHv297Q3/8+HtLwS5zv2pPx1yopR/fbN7Oawvch00GLn7ta9AO05INo6ifj8pcGM/n2xe7RR1LlJS/VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unbe0/ME6L9B/PzmHyAI5r4ZLReoIZ+F3Up+tud47B8=;
 b=be52xF1vJNcsilCMkcEmSUqzaa4vkbUV+7FQxCOeh28ZukX47Y3npST4Aege5g1l+vEuK9UbvrdqTCF3vUA1UEcRSrif8Fg8FED9fCmOf2Cm3gY1493kgOHIZ11Od1fJt+56LZP3DlloQ7ZSeWPJgfEeNVhl7hWUYSR+5J171kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:48:55 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:48:55 +0000
Message-ID: <4ae073b1-c42e-497b-87ca-7eca541581b5@amd.com>
Date: Fri, 5 Jun 2026 20:18:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] target/i386: Gate enable_pmu on kvm_enabled()
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang
 <dongli.zhang@oracle.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
 <20260604025546.19378-3-zide.chen@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260604025546.19378-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0609c16c-4426-4368-3121-08dec311915c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2BHx6usVLjkQcJbZvakXupUR123sImcR/u9sw6cCilxH9D7AaTuelZkuu/DR4aXVL3a++2wMd6OUQ6NAr0S3LPfIT9YtXsrSh5/zo6tZEOzMZy6sxvVkCjrkdUwUsLBBSrz3mDmhgj+bOiJNrB92TILWaXsWYcg7TU2hnDhFbyhwi1LvjnnTH9V2fMzF45FHeMDtxOnH3CCx4ahGYLbpRdQbNIkYCFfoTebempMRsueW4aWS6R6kPiKsAnCq6r9cl4ag9t+0hni7PTeby23THGSC4UBXb5BEG75mG1PkKrNXKp8WhAgH81nSZebPx4RZya7GNouVJ0KA1c7qT5q1xT8qRvwsV4L79dynY+U2flTE5JdQcsWWnvWWT+GDX/XMr/f0cIr6YJWBZKmrd7gwpjt11KG/s02Rp+6Zj9SCsab95AL1kfOow+emwtPyda+6X4Vly8eudqu2F/6BW8PSFF6iBRIJYLU6OwFllSe+ZyXVuR/RPD1WkDdTb5aQm4qcGPIhO4J5ZeiMIJ6cbrPnwvkoSdBe8bEpAz2/NgkC+SA3/n73IYU2BDcfLXWaQIkREq3QWg51xhvPC4IF0huxataPRs/r5Ej39P9XrjTFRqrg+T9OpHR6uXPH+NLHMSH01s8Bmb74W6XGjCMFk4zZB71MdTE7aF2w6MJBVxOcJqv3ow3CgnMQxMYFpXvQ6PSe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNXQXJ0VzI2VXhzc0RPQ3FMZ1hKbDNWeUFxZm9mOHV5b1BWa3BhdjEvdUVl?=
 =?utf-8?B?Y3oxd3NoWVR4QUQwczdnR2xCSTlUTUdKTFVVajB2UTVoZUZxVGowbTlXZVQ3?=
 =?utf-8?B?eW5qY21ad2RYeW9xaytxSFo3TFI2VEk4cXRlWE9nVHhvcER6anNpOHNQOEdT?=
 =?utf-8?B?Y2lUQTNqdGsvZGQydXU2ejI0TGp5Tk0rcXQyOFRqMjdOekhiRlFoVlZvZDB3?=
 =?utf-8?B?Zm5RaFAxR2hpVWVoRTFnR082VGxsK1VMN0JUTWtBdWtNQ0JvM3pCa2pWaXdY?=
 =?utf-8?B?YkpraE80ZW9senNneHpXa3NuNGpQWCtaMGNETGpUNVBHRnphRkc5VFhRRnE0?=
 =?utf-8?B?OXhwdnZOS1JJOFlHZ3M1YklQU2RkUlczN3hNOWJJY2UwV3dXVHBKd2lGVDN5?=
 =?utf-8?B?SUtpT2o0VmtDaDBMQ3hPQ3UrSG1rcXN5V2Z5bVR3NjV5V3k2dm5OcmRORU8x?=
 =?utf-8?B?amRENXN5NzhGN0Q2a0ZHb1VrZ21iMHNHQ3BWN2VZeGdvSjh2RndWNzRMY212?=
 =?utf-8?B?NWlBcG1yeGg5WEJQSGZRQzBVTmVWSjZqTUZGeGk4MnduaCtDby85V2hOMS94?=
 =?utf-8?B?Q0JFVUt2a3RLNXI1WDQ1TlJTdmJ5Vm9RQUZvWGM2K1pYZkFpdVgvUkRnUW11?=
 =?utf-8?B?cG56N2hzVUFvOTA2TW5rMlpKVnoxUkdiSi83eUZZenBIUXUxRXdaQWdBMlF3?=
 =?utf-8?B?UUlzZWpiMmNRd3VpUHpMOWQvTlJnZlB2OEVLZzkvNnFWb1MwTWpsaEdybzhK?=
 =?utf-8?B?WnFkTk13RVRqcktTMUUwS0ZBb2NsNCtYdmhNemV4LzhQOE0zQTNIbXNuSndD?=
 =?utf-8?B?QkNycEVFSHArRGxVSE85bkNHVnBpRHZIQXUyR1paZUxYd2FwcEorMDNzczc0?=
 =?utf-8?B?Vk5IKzFHb1Urdm5aMU9rb2ZWeGNmRUtZd2FqQjdOc1RSeEpyMzZyeE5oNXYz?=
 =?utf-8?B?OTRHU2FpU2ZsSHpBWG11MHZLdDNRMVhVeS9PeEFqZHJaN3JWSWE1RW9RaXNL?=
 =?utf-8?B?WGR0RGN4WmU2WjNjczF0M2EvbHhFVTAwMTNiTXdGWWJYSFdNYXdWMkc4N0pT?=
 =?utf-8?B?WnUyZnFlUmdOSnJVcitVM29OaWV5NHVJcHBOcWJQdmZ5RDF2b3VkWGg3dmhF?=
 =?utf-8?B?Tm10YkFBUDVReEVxb1kvY1ZONkxMVlczeFh1cmRSRGhXaHdjVlFsRklGRGZh?=
 =?utf-8?B?R3hPdmJtNnhkK1dPdnVWMVRvbjBWSGlTcVd3aFVuWTBBSHNMZytuWUMxVTl3?=
 =?utf-8?B?eEw2RDB2a1Nmb3liL0xQMTJsY01RZ1FYMDJUN3h0ZFFncmtQandmcHl0dlpB?=
 =?utf-8?B?Z1BYNUMrRk9EajNPU21Pa3lwRFBjNzYxVjdpc0V4cmJDWVkreGt5ZGlEN2FS?=
 =?utf-8?B?RW9Fb2Q2elNjRzVDeHdpZk52djZEbDM2RE5NUUh0NlRxd29BdkhnMkFEeUZ4?=
 =?utf-8?B?UVFNUEgrWnpuOHpVTmpwRmd5M0krMGcvZUV3Z3o3R0NNWEw3dFo5dFUzRmxL?=
 =?utf-8?B?WUE4eHh2NW1FWnpEbnM4TWFEYkJ0R0sxd3hNaGhBYkVleUhIZWdxMHhaNkM4?=
 =?utf-8?B?UUdVZXZxM0dWSU1nSFVsODlIc2lMZXI5a3dDRm40VGlDMUhGeHgveU8rOHNp?=
 =?utf-8?B?WEcwV2RVWS96enRUaEluOWVPUzRMRTU4MFpiamp2R3Z1U3pXUkE3U1p2TzBB?=
 =?utf-8?B?bW1xQkwwcFNJVFA3VXpPRHNXRStRdDBOV0x2UjMwVy9FZFJERW0yekpOeVVT?=
 =?utf-8?B?MHdBcFFMclJ6NWFFNXRFNi9ydHNHRlY1YzJjM3dmVmk0QjBMdStvekJOcmhQ?=
 =?utf-8?B?TVFUb1kxYWFGQ1pZdmJzSGxuTkp5SmltMGoxdWFQNVI0dERDTkQ1MjlDQ1NP?=
 =?utf-8?B?bER5ZXJocFlaTHVITnY5N3dwc3ZOQWN1dmwvc3gvWjlXZUcxdWFjeDRuZEZu?=
 =?utf-8?B?V1k4a1JxV0kzWXE5R251bGdhNzhEU2VJZ09MSHRaUXhaRXExVnZHOWpoWlQz?=
 =?utf-8?B?clJadFI1R3R6bnAxWGI5alBYQktoemZzSGNpcFhGSkprZDd5b2VDS1h4NkFV?=
 =?utf-8?B?UXFvb3l1Y0VBVmE5YlNrT0tLKzNTUndXckdZdU4yNDJlT1ZqSkRvejhLVWI1?=
 =?utf-8?B?UXBMbld0TzhjdmNZT1cxb1NBWUgxaG9WNDNxQkZFd0hnRlFSVE1QZXRRT0dB?=
 =?utf-8?B?bkx1MkFFT3pZb1ZPMTVkeDRvU1p2bjFwejVNclE3bkorQWw4K2RNamIrckhV?=
 =?utf-8?B?K1FiTFdwb0RtSG53dGlaRkxoeHdqNldBSzBHUThFN1Q3K0dQZERWdW9COGc4?=
 =?utf-8?B?VUFEUk41OUt2N1FHQWpxOEkrckFEcS9IR0kwYTh3Yll1ODRYeG9IUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0609c16c-4426-4368-3121-08dec311915c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:48:55.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvtThMT4e8Sornn3DDCf6JXl6FS5V1JJdgKdTO4pcfx/7iUSQxdGtAa8dJ+RE+LhT9WotVWojFwrueIl7pcVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

On 04-06-2026 08:25, Zide Chen wrote:
> Guest PMU support requires KVM.  Clear cpu->enable_pmu when KVM is not
> enabled, so PMU-related code can rely solely on cpu->enable_pmu.
> 
> This reduces duplication and avoids bugs where one of the checks is
> missed.  For example, cpu_x86_cpuid() enables CPUID.0AH when
> cpu->enable_pmu is set but does not check kvm_enabled(). This is
> implicitly fixed by this patch:
> 
> if (cpu->enable_pmu) {
> 	x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
> }
> 
> Also fix two places that check kvm_enabled() but not cpu->enable_pmu.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
Reviewed-by: Sandipan Das <sandipan.das@amd.com>

