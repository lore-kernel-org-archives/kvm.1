Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E63A1E67;
	Wed,  5 Aug 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941483; cv=fail; b=auvAbtn0uhu44U/iv4MKkovXd++9NzZ2YxCrtSW/nUr5b1zhjiNzsjE0JYhbwbzlGJw4ZBezm59SI9EzI6mdD6a0MsjVIqb7jSZ3edD1VmRZNBgSXhYiBAx/5P0W3fDilp2jvfRWjQ6FjnrqVi6LhHCIF6lud2F3YLuzOPOPJjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941483; c=relaxed/simple;
	bh=M/LG0rdTBWCpsLOEblYyGZe987XMByJ0MMn/bS2jqAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lAH1JuTorpe3M4TxKbClWBPVIHjmwc+j8Uz0AEBWwL+8C0Ej1ThArMmbYLsppgy7yIJ6VsIR+o/BV3i75qkvaI7Xxv/5ZNypSXsuF9oWAlvQYp4kOa9/AqRktz1L1uY7JjI0XeQOz65BW3z/tQSGiDNcrI6Nr/sjsiZJH45vWFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BAYR5vBe; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BAYR5vBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUJoka4sFza18GhyvD8vwfxzPW8lpUgECdVfJyFjYBb34wNbi8aMbUXlo29llvJdWi0xSM3M2tiTesFSq7g8fFq7x11yVOIPHLtbepZ9TxMtKnsR4Olc5MgEgfUYK2uSz1Zccj8lh+1sRX+SK5ojdFXh31uXRYPXkI+AQf0X/t2crcjTvES5xC9rZytlJCs9ddt4hwEvY0S/fVyF7OlGEq+eY1K0R8fh38+KyZDyvTT9gkkwpOY8y6/ACy+/7kA7qfvIdODadsNUCBYM93Q+yrKHJrRYlhRgutkjTf9bAzGjJxYHVOjRvrq8YrUizuyEzqdkuqC+Hg9DUziPTFgb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjZ4xzI5ZNfqtDZvMrDXKpQt1zNdHjMnTeecz6kgqrU=;
 b=Ucsd8E7Jx5nR2UrVpxO/wOBvlXjubI7nwpSsDE9nFaUXhu9aXMRqJ52woM2yJ2R1h545xeMPnXoqLyBA2icNHjo91teVWeeOx6TMsnJ0Pi/mtioZqVLs1WM/YTd/r4Vge7xWHzE4Un/8tOTrtMEG/2U0MPFeYV66tZFO8n1RQtAhImNcVfe0Vs7O5Aoi491rqxo+nY+l9uc9RqaNsgu2QXohEK7kAjoaNErFdcDznBL2cdMeQfNO6/W3cDDobQPfQsCiUOpPqSnmU5DFBHRsP4CDLZ+VR1JVAwWUXG78vdyla0mFtY6z8G4QReMmFiAPfS40yqJp3lsJk1AKMAiniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjZ4xzI5ZNfqtDZvMrDXKpQt1zNdHjMnTeecz6kgqrU=;
 b=BAYR5vBesXFEcndoU8s/ojTyL/qI7nglyYo4B95JCJJP4ZZGDvcK4Y6XSiEQ85j8UFo2fytfFVl/U3pZqfW8398Awj2oSs5dEmIQpbM1D7qoOvTmDELGdD9dUdiolu6Omd3HJRoZ9k1/z9srMzDNAXDlmoZwBx3GrWEr2U3FNNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.19; Wed, 5 Aug 2026 14:51:17 +0000
Received: from DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb]) by DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb%6]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 14:51:16 +0000
Message-ID: <65d82937-113d-405b-9399-b70973e84c50@amd.com>
Date: Wed, 5 Aug 2026 09:51:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] x86/bugs: Only log missing retpoline when it's
 actually the missing mitigation
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Naveen Rao <naveen.rao@amd.com>,
 David Kaplan <david.kaplan@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
 <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::23) To DS0PR12MB6655.namprd12.prod.outlook.com
 (2603:10b6:8:d0::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6655:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 71810817-aff1-4194-e4ec-08def301006d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qi8blWPUlswBWegetb8Gik5po1g0P0LAJfeTtTG1HcnhOWZGsxQaF3l2TTwBoDqwvJRCfruKUUZe+TMPf6kouz/5L8de8Af0xMfEL6BQssqopoy+icMzAEOrO853CsmGgV6Y0cX9e6sTydZV1q59mZoO1CJ+EdaKdUb+VszQMVe6MPKwi3ql6orJyrAZXBNs/O0vNGbjSR5KeLRq8QRYu2J2pdeYQtexpTyILIYFoHeCfa1gQapQAPmHgufXOImKbhcOM4SRQ/ltbYXXBWGnt8dPAUlqTWyY0GiiNNhZFwcpdvEAsiAmcZ518iQKstgG5Hcg0iQPudkb70nK1H5a+HAXJcYy3ytM8Jw8edkrLfoHZSGjp521NdSJGKqCV3Cv47gY1ZoCZDaLSJL6AJCVT0y7rzr7bD93+LdaQzUqlwWUqR2vtJ80owWj6PTT1iUJDOJrh2/37//vnt3sym/Z8xdOPpctR4kXqfvYzXmGB4vqZ9KCy/g6ws06znEeF1kbfjWUFaw5V9cNUktY27/jRTUU1nlIagLwpheXwA+DstJ/hqIdORsyYVzUlUL9n9JcSgL4lKvhRHCwX4gPaTjur/dqT/3i/MmVyG4pTsgnqBPzhSqDq4bspjf8zrjw6/hBR76pIdbd5gT2ws2o4cKcpSnjmt4myoUAu6Sn8dbQWcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhzaGpNTXdVVDcrdXI3akZyYnJjVDVCb0dkWllLMmNIWVlCOHNDTGlnU09k?=
 =?utf-8?B?ZlROcVQwQWZrdmRrVFZEeUQvMzZudVkzVkNvakJhZGw2K25tZXVFUzhLQTNK?=
 =?utf-8?B?elArRHpXVTd1UG9kdTVQSVN3dll2S0JXakJtWHc5Z3VpajgzdnByN2ZndUFx?=
 =?utf-8?B?cjY3WGdOMFFTQzNST3lYVWQvY2FDSVJuU0JMQkwvaHNteXRTd0VQU0pNWU82?=
 =?utf-8?B?cjJWQnBzajh4RlFMNG5vN3JITWZBcVQrU25yVTdYN0JFNHNhblROc0hoS1E1?=
 =?utf-8?B?eUdyY1hvYVp2TjViNkdkRkdmYnliSEMrL2xoekdjVVdGRTB1akR0RCtVbnRD?=
 =?utf-8?B?L1F3eFVaWEpXenlTK0l5OVFvdTdRWGJtTEdlVERrdkc2MlQ3N0RRSWJVM0x1?=
 =?utf-8?B?SWh4Mm1SM29aVDBnRTJYQVVXU0sxQkdXRzhtUUN0NmFwUTZkZ2tYL2RPN0xN?=
 =?utf-8?B?N3ZVNEFGUVNXN2V2ak4waVZ2RmJmU2NTMGl5eTkrMmpXWUM3cW8wK3pNSHJU?=
 =?utf-8?B?V2ZUWFFLVld3cFN6T2MrcW0vYk53b0VTTzVISkw2L1VmczJYQng1L0tUT2Zi?=
 =?utf-8?B?SGRFa2ZSdU1MVmhtY1YzUS95WFN5dFZ0UUlBQnZzK1UzOFRsK2FBTHBNSGVn?=
 =?utf-8?B?akdvbGdJUEZ6Mk9pVVc4SFFLYjNNMEtiR3ZlTEl5VjY5dVJlb2FkcEl2aTdn?=
 =?utf-8?B?dTU0SHlzMjIvUE5uY1NVOFArQXZxMGhscndpeE8ySi9BWUVkdG1DbEJEV2w5?=
 =?utf-8?B?RDRTc3daV0QzaENUMDA3aXIyajl2QW5hUlpSKzRZUkZST3ExVHdKZ2lJUFhK?=
 =?utf-8?B?VDZzNFdQRDQ0bzJqWmppQUNOYW1RVjl5alFBVWxEbnNXRGtSZVM0RjJHaGZH?=
 =?utf-8?B?VEJzOXk2amcySU5PYk5HRXVGVUluN3JWdGVKaE84K09IQmxkTEgweGNGOW81?=
 =?utf-8?B?WXBiOE5SaStvdUpOWmR4ZHpxME4rblFvSnBTNHVvaGkrTFo4cDBTZm1CR0N0?=
 =?utf-8?B?bUQ4eXl6Z1JzWDhBOU81cDgxTlBjNjlQOThvc1NXbFZNOXZQeGl1aEgwd2ZF?=
 =?utf-8?B?clc5SVVTaUlhUlFQcHVSYkJPT3BqMUJhSDVaU2hZZDdGdFVocWxPLzF1NGRs?=
 =?utf-8?B?aldORmNKQTNQUG9veG5GY3FCOGt0Q3lNSFV6YU53U2U5Z3UrUUpFcjF1OThs?=
 =?utf-8?B?TDVXWms4aUdxbHpyVXFZdUZiYU9PTTBxaE11V3VJY3czTHdvLzBqWGtQdFRu?=
 =?utf-8?B?VVZzMDJDQWUyZjUzcHFMZTNuRTJubFpKRmpOWG9Gb0dFMFpVS3N1YW16SWhP?=
 =?utf-8?B?MWs2VGh6dWZRVHdBZHE2Qkc3UEVuVGZaQlY3anBNM1lBbVZSNDhnT2FPMmFj?=
 =?utf-8?B?TEVneEgxRCs2UmY4ZTRZTGFGdjNORkFjQUliWmVkaDBtVVNrUUdEUGtQS1hI?=
 =?utf-8?B?cDFzREZDMS8yYmxUWGdnNmx2NUkrSkpNUlZROGNmMHljMitJT0k0eUZhbmZz?=
 =?utf-8?B?UnNicWJNSlJvek0yWGpxeEZZbFdBUEVuNkxJbG1rOWtaVHBZZ1VFNmdiTm1q?=
 =?utf-8?B?eTNkOW41bjZ4aEp0MVlJdElmNnBaNnNDa2lUNVhTMkpERWJqZFdMeHVRNlgv?=
 =?utf-8?B?ajNzcHcwZjF2cWhVVFEzdk1WeXdCSW8rYkVmYysvT1hsQXVnZ2V6Zmt0Qk9S?=
 =?utf-8?B?VTA2a2MvQW9HKzEyTHRDcUk4a1FrbVQrUUJQWUNUVzQ1UGF3VXF3U3hDbVhx?=
 =?utf-8?B?NW1ka2oySjY0b1Nxc2ROWW81YlI1MFk1WjRQeXptMVRPSFgzeGJFV2JrUnds?=
 =?utf-8?B?enY4WTlHb1ZxSUdRclVpREtwUEJETFlQRWFsRTZPR3o1cFVpd3J4WXdEVXBo?=
 =?utf-8?B?Z0ovanF2S2ozUmVzYmFoZXAwZTA1R3lVMjJVSFVTcjdhVThkNWZEYy9iSTR2?=
 =?utf-8?B?M0duMnB4OFkyN2dZaXp4OGd3a1ZnMDR6SmNPM2xxYUxyUkthRGtoOFJqK2k3?=
 =?utf-8?B?M0VHek9QUE1KS2ZDQzhMcHcxVEMvdnh1WHdJSXZ1YTdzRXd1YjdnY2tQT0lJ?=
 =?utf-8?B?aXF2NU1VdjVDcnBwRS9RNFdrWG5pT2NRZ1h1QU5PY2lnczFWVitrbjVlQTFp?=
 =?utf-8?B?S1hoM2lNVEJSODlSTC81RzhySTZ5OU5taEZ5MUtQbEVyMm16RVA2TTlDeS9l?=
 =?utf-8?B?SmJucDB5YkkxMFBIeGVSN3lyTHNQcU9xcE83L1hHUHNiQzBVcnZWUmJwbXVO?=
 =?utf-8?B?NE9mWnlKN3RjdFlOMERsMWNpcndFUTM5VkgzZlRpUDdlWFdSYTh0aytWZWoz?=
 =?utf-8?B?L0k0SlRTRWRhcm16QTZUczByU0xGd0xtcVM4Y01iQUUzbktNUFJEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71810817-aff1-4194-e4ec-08def301006d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:51:16.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3jSKolOIr3KnnXIkL/WvVBV/SYTGNUqFLCLYspTHSkN4heetO0Xpvk/68kCRN1NjcdUoc3bf3m+CjGsc17h9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

On 8/4/26 7:44 PM, Borislav Petkov wrote:
> On Tue, Aug 04, 2026 at 06:56:02PM -0500, Kim Phillips wrote:
>> spectre_v2_select_retpoline() unconditionally emits a pr_err when the
>> kernel lacks retpoline support before returning SPECTRE_V2_NONE to its
>> callers.
> 
> Unconditionally? There's an "if" there. :)

There's a "when" in there, too:

...unconditionally (emits a pr_err when the kernel lacks retpoline support) before...

So it's saying there are no additional conditions than
!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE), when there should be
(which this patch adds).

>> A caller may then select an alternative mitigation, making the "no
>> mitigation available!" message alarming and misleading to administrators on
>> a system that is actually mitigated.
>>
>> Drop the pr_err from the helper and emit it once from
>> spectre_v2_update_mitigation().  Guard it on
>> !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) so it only fires when retpoline
>> truly cannot be built in,
> 
> This is explaining the diff. Doesn't belong in the commit message.

Ok

>> and restrict it to the cases where retpoline
>> was the implied choice: SPECTRE_V2_CMD_FORCE, or SPECTRE_V2_CMD_AUTO
>> when should_mitigate_vuln(X86_BUG_SPECTRE_V2) indicates we actually
>> intended to mitigate.
> 
>> This avoids the spurious error on a
>> CONFIG_MITIGATION_RETPOLINE=n kernel where a caller of
>> spectre_v2_select_retpoline() selects an alternative mitigation, leaving
>> the system protected while the old message claimed otherwise.
> 
> This should be your first sentence. What the issue is.

I'll see about rewording the commit text according to this and all your
above comments in the next version.

> Which begs the question: why?
> 
> Why do we care about a CONFIG_MITIGATION_RETPOLINE=n kernel?
> 
> You either disable all mitigations or enable them all (distro kernel) and they
> get then configured at boot time. Why would I want to disable RETPOLINE only
> but leave spectre v2?
This patch corrects code that already cares about RETPOLINE=n kernels, but
it's also useful if you know all the target systems for a RETPOLINE=n config have
alternatives to RETPOLINE, such as {,e,Auto}IBRS.  This will become more and more
true as time goes by.

Thanks,

Kim

