Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8C3D811C
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365940; cv=fail; b=CGfPPUvIx4dZziJ2x33rxfKCUMzIj3HEuIHsp6WqV70UHKYQ2tYDgFqzFFYiBFVnDsWzL2Htyp9mvwPVphHa5pHuJkzl+3DkZvyCBYuFZ44uVvKz2N1beTYiwB7aXr77A8dBkjzUoPDIdzBrcpvojoNVHa1bEcVnCmZWJ0ouETo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365940; c=relaxed/simple;
	bh=ZxJ8ytFcw2JfjBsymbkxwVW06jYGi4jfFkCIYJimKFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qh0R65WC6mOyLJihI0eNF+ajSgR0wXLKgWKx+inYmXx62HOkjfW9QISDeg1G4RyopIQ3LeXGjp+duv6Js30R8m9jyjhwJXjugTCTib6wot3xnxKBDy3EY/bbcYL9r/8XI0co/IdmuJzYaxx0oRAii4oyLVgJ62qY2xYrpsWDZsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I+KAIg99; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I+KAIg99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhVnTrKSK/TtZxNFsthrY/cCZ2u6pRVCMjAQA01h2unbfFVbyMogaYixOZyhu6/y3RGY9h14ArQzE+5N2f6+fV82LGhhqaXuqcmzPOoYTdQJ31BLG0mQJZ27txIK9PVBNa3npDzv+73kmE+fPD8glprZqAu/FLWbJ0qQv9u/ADuE+IyEWpSg42ion3qW/CimiGWHBku/8lv5PpOzFle1bP0a0sMfTMDpiKhfT/aB9g70EMPyPENfLTsvKAufxeVcAFy5QaesXArl2F40nyAG3Jk8A1D71+un187WBHzh3focpgVYtkqID7esYnK8WJuaP3duEEcSj4DRxwLSnmjg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuIIyPj46lsdj1aiI/USeFYlTbX/9yBHg18jZV7vhhk=;
 b=lh/Pb05GVhjQunIZQA1Fz4snYDsV0Ny2p3bHHgcP3GXHxEYv8XyXJ3j4rlN+s9hOgpg6r5sApBJFCQnttpxNaCr9kw6tYCSmNqHHJ2kIRMQif44NtvAv6jYbC+KCXg5R+3Usr+Y9rUNtCnK+CQBNLsNsP2P9MgAMZasb/p+XHI9told1wvdotCR7Ziutu72NMytGf5VDuiSqB32Puc28vY68DXQ6vOo6aWRglgTKN0IPB1dxyHwipVXJfuTgS3EaYMQ9qDR1Bo/J/70wRWTZSK9ULm/y9gD02atfAk39J9HezHu0hK7dvZ/m9mdL2y8qbxGXaskGEFFuQWmNkuKfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuIIyPj46lsdj1aiI/USeFYlTbX/9yBHg18jZV7vhhk=;
 b=I+KAIg995HqNxTYFmiTzBWts0SIIb+rlp/2tSuXAQg1f8DaWiLeSpt2wrrQhjameBsJF4YmkHfioMpM6T2nZPkGKtuMhyYcfmMUwf7RzL4RSvhTQuCevFVPTinf0dHL3eiof9TG0sN1pMRhLfhOMFpIQ9izf7H4GlNX/Qww7rZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 19:25:34 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%7]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 19:25:33 +0000
Message-ID: <87850ace-589b-4f71-b33e-a099c86a5217@amd.com>
Date: Mon, 6 Jul 2026 14:25:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] KVM: SEV: Perform RMP optimizations on SNP guest
 shutdown
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1782841284.git.ashish.kalra@amd.com>
 <3a5df8dec32da5c31998bcfa775ca92c80cbc1eb.1782841284.git.ashish.kalra@amd.com>
 <20260630182421.8C1481F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260630182421.8C1481F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 573fc9e5-426d-467e-defe-08dedb945940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|5023799004|56012099006|4143699003|6133799003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5bqIAhhRhVSiuS1h00VLVe2ucyNqvJVsUZlaCvxcwQypINuHIovaJolIQwrWxhpS9rov+oNPpnKr/8PviaLQJqzTL3+og/K/gBbZG9MLqO6rpghlB198lsWbaWPiBztnYw2ZFGFeD6bjBTZQGkKoKeZG8eG6aDA92HsFAzm3b6nGlt6V/UgPGdV/RianEltUfxns+UbG0ydmbH2WCfXSa0MN4swH22KUQX6o74DmNnmdZiPtLUdoJt/H/bL+8YrAVqCjUCtLxQ7vLGqNYwo7/o+9x9P2Lu5b0dEToeSmNGLiuzrn0IEbRV6EX00qwfgA6YwJ4dy/Xpv8hKAnC4UnCtTU7jVsmbPAUqiwHcIcAi9FOhladpOsMWfGrImDHDth7sB+S4wITlojzKgtkrDSDnwNch2yap6t0KD9C4d0GurDxVUyDuPtEAZJdAsd8AiQM4TXZ95RksuJT7XchnP7ilLmfm+u4mhetpyjWAtNyRsEdFScuhjepmlpSYdX2wE+avRKfFuCn5dk4vaZjvumlMOARSyaotcTucPt6ZAbkNxIWuPUhuv0I78MjC9w8bAevb/9bMP3l5Y5iqoAnVe3dgXR1vYuw0TQ1eq4qaPuF8OetttgyTYBomlTG+ZMatfTLlaDgM7W2UyekVtDh/dz+Bf/8eMURw0r8eo0BdGmpi0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(5023799004)(56012099006)(4143699003)(6133799003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K29TTnF0ZVhuN3VRWVVkNitOTTkxdDQ3c3V3MzYxd0xNMGtCc2R3dm1VL0pK?=
 =?utf-8?B?anowVU4rRSs2TlYyR3Y1OFBVa0xidTVmb1praC9QaWpsZ1M0RCt2NHpCQ3Er?=
 =?utf-8?B?dzFMZ3djUjhua3lOOFIvaUt5Mk1DckRJa1FWVll2bVpqUzN6anlqR0oraFNU?=
 =?utf-8?B?Tms0Zi9OajNNS2toZzErZDhIckFIclAydE51dzBxeGxsanZBN1kySTVuNUly?=
 =?utf-8?B?OG02SW92cE84VHdYbkoyN2QxSU9ycit3UmdmcE5RdDJMcGpvQVpLL1hCb2Nq?=
 =?utf-8?B?bGpWeGx4MmpBdk1HR09jV0VmdVlGRDRseS9UTCs0akQ1MGp4ZXRLSEEwbU0y?=
 =?utf-8?B?WDI4bHNwRUJkVVA5N0pmMmErS0pNM3ZCdHVZSG42UnBMNG9CMk1Ucm9xS1FO?=
 =?utf-8?B?Tm90SmNzNWpXT2dZUVczeXA4Y0FxUUF4TGQzbkVLVzlmRFpPeTNlN05tREgy?=
 =?utf-8?B?S2FjTGNFR3YyQk1zV1FYU2NOaWQ2UFVPUnlLYW0xeUI2SUZJeG1pOFhMTkpZ?=
 =?utf-8?B?VUlVcWpWUGJWalNDUzJaRnRTSVFRZXVUY3YrcnhNWTFwS3hQaGVjNkxIdzEx?=
 =?utf-8?B?RHgwcUYyeWZtQ0FHVnNZSDFDVnZWTjZvYzBZVDVFcVZJOWRwcndNS0hWZk02?=
 =?utf-8?B?M1hCYmpVQzdtaHZLMmVHQjhvdjlKaS9RSGtDclV2R0VCZCt5ZkNWQkFqZTBC?=
 =?utf-8?B?R21MSzFUZWFXWEdSMmZXSE5TQ0N0bUNBU05JZWdqeXpSZEdaTFdoZGRoQXdZ?=
 =?utf-8?B?a1I2dHQ1NTFLYWQ1bkxOODNYdEZvN2w3bzdYSkhKN2ZRUW1iSXhhZkpHcW9o?=
 =?utf-8?B?ZXRRZnhHMGRPTGhyQUNFTGpsRjNMeHJad0NSamN5Wlk3Yis0cFVZd1d1V1V3?=
 =?utf-8?B?VmduSitoNUJjMG9NWkhVQXVCamxRRzc2bTJQajN3SWh2blpjd2Q1L0xsWmEx?=
 =?utf-8?B?ekdGL1FzUitkOEJuNVJYUXhYS3ZSNUF1YmxiOTlUdXlERUsyd1hkOE1kckRH?=
 =?utf-8?B?NTZYSmtGdW1sTi80RTJkOHVkZ1Q5TE9nS0c5NjlCR0dSYXBTMmx1RytQVGNG?=
 =?utf-8?B?RkIwdHJsVnp2RVFERTh6OVlHdzdnRW9TMEFJNlhLSExLejlnaGJZb01LUW9Y?=
 =?utf-8?B?NXBCTzNaZDRyVExYZFZPNkZUOE83Vlpmd0I5WCsrMno1UjJCT1cxSUpYcXhW?=
 =?utf-8?B?KytPM1ZDTUhWWWptYzl1WTFGL0NWYWM5bmtHYVlpalJpYUJ3cDl2dVlYYURF?=
 =?utf-8?B?Sit3NEdwOFFKSGVMWUFrcnduQ2J1ZHNCbzhhQm5JbkhZdHVxcWUwTTVPaDRR?=
 =?utf-8?B?TnQ2b08za2RORW5aRmcxczdjWW8rMkZYWG8vNEdCY3dZNmhXYVhINlhXblJs?=
 =?utf-8?B?cFpCNTBmaTY0NFVock1wQXZqZzc5UlF2Y3VXYmN4NXd3OU1hN0tYOHJLbFJ5?=
 =?utf-8?B?MmNnbm9hNjJzZTJZU2FMZTdqMUNyRDBDZmtqTnFZQmxzTW5vVXBuTldCa0JO?=
 =?utf-8?B?VWh1dWlKSmdzL2pURjJQK3BaZnBVTXJ3QlpoYzZNeGtzQ3BCMnYwWWFGeUFN?=
 =?utf-8?B?dmpOOHA3YnQ4bGlyZWlMdzdCSnJLV1orQ3J1RE9aYnZnL1k2TFE5QTNKTVpR?=
 =?utf-8?B?a0ZKTklNa0ZYVUFVVzNnOXBETnZyblpFZDJTYkp5SjhIeUV5TXVaQVpGMzlJ?=
 =?utf-8?B?N01jMGkvQnUxaWgrMVVIQTBxMHlyNTVRNm8vdEg4cFZYd0hDcE1rRFpXL1ZU?=
 =?utf-8?B?dzdqdDhwblVjWnBxeDBQNld0V2ZBR1JWQVZKQ2NDSlB5QitnaDlQZ0IrV2VF?=
 =?utf-8?B?UUxtUVFmL3FoY1FlMDBkNDZqUUNPY3RHelhNN2NtK3JPYkZkcjV1YkFwL3pL?=
 =?utf-8?B?bDR2TndlTGJqUFJCTHNScmJZNlFpVVoyQkNaVnJoQkxhYkNmZU9HY3laYUJH?=
 =?utf-8?B?aFdDM2dlbDdlYlpLREd3UzMrTkpNVVY4YURhL2VTTTJKWXk5b09LbGswYXE1?=
 =?utf-8?B?eDV4c0VwdXNDR0kwWXJjZC9ua1J5VjhNOWNUM2swRXNLeTNFU0ZCQjVBTjZu?=
 =?utf-8?B?cnYxeENEOXpKNzMrdGpTV1REQ1hDcnZuVndsaC9XSE5tUS9sdEcrYjd6Y3RM?=
 =?utf-8?B?cGhDVWQxODNXK2F5bjJ1Y3hVYlN2V3ZhYjg5MGdEeXhQbU5mSUpNKzBPRWdI?=
 =?utf-8?B?RWhOOCthZnVHbE1vazJHZ2k1bnFhaEJHbWRTc21hY0FoQmx2ditVUVZDeFhB?=
 =?utf-8?B?cW43ajcxckZMR2RjdGFGQlIyYlVOOVplRnNoU2RmbVB5ZHNnNjRPbHdvL0hy?=
 =?utf-8?Q?K2dAMBQADAI3XyQ9YQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573fc9e5-426d-467e-defe-08dedb945940
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:25:33.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXpi3rd2YiLK7arEOyHoM/eCdH1iZRvj1/afRDRN4GkFfEtXyJeIu+qGAk7cPkj2Wtq+dL+SsP+LwS1yA0na6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106



On 6/30/2026 1:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Indefinite deferral of RMP optimizations via mod_delayed_work timer reset.
> --
> 
> commit 5a78324bed688cb2c4b58d363233a323513bd9b4
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> KVM: SEV: Perform RMP optimizations on SNP guest shutdown
> 
> This commit performs RMP optimizations on memory freed by terminating SNP
> guests. The scan is deferred so that a single optimization pass can batch
> memory from multiple guests terminating in a short period of time.
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 4272293478766..c574849b15878 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
>> @@ -2992,6 +2992,16 @@ void sev_vm_destroy(struct kvm *kvm)
>>  		 */
>>  		if (snp_decommission_context(kvm))
>>  			return;
>> +
>> +		/*
>> +		 * Perform RMP optimizations on memory freed by terminating
>> +		 * guests.  The scan is deferred, so it normally runs after
>> +		 * sev_gmem_invalidate() has converted this guest's pages back to
>> +		 * shared, and picks them up then.  A very large guest whose
>> +		 * conversion has not finished by then is picked up by a later
>> +		 * teardown's scan.
>> +		 */
>> +		snp_rmpopt_all_physmem();
> 
> [Severity: High]
> Can an unprivileged user indefinitely defer the RMP optimizations by
> repeatedly creating and destroying minimal SNP VMs?
> 
> Looking at snp_rmpopt_all_physmem(), it uses mod_delayed_work(), which
> cancels any pending timer and pushes the execution timeout back on every
> call.
> 
> If VMs are destroyed at a frequency higher than the timeout,
> the background optimization task might be starved and never execute,
> leading to degraded memory access performance.
> 
> Would using queue_delayed_work() instead prevent this starvation by
> ensuring the timer is not pushed back if the work is already queued?
> 
>>  	} else {
>>  		sev_unbind_asid(kvm, sev->handle);
>>  	}
> 

mod_delayed_work() is deliberate here. It runs the scan RMPOPT_WORK_TIMEOUT after the last teardown, which coalesces a burst into one scan and gives
each guest's page conversion (sev_gmem_invalidate() -> shared) time to finish before the scan — so its freed pages actually get optimized.
  
The only difference from queue_delayed_work() is which state the work is in when a teardown happens:
- Executing (a scan is running): the work isn't pending, so both calls arm a fresh timer and schedule a follow-up scan — no difference.
- Pending (a scan is already scheduled but hasn't run yet): mod_delayed_work() restarts the timer on every teardown, so the scan always runs a full
  RMPOPT_WORK_TIMEOUT after the most recent teardown — each teardown gets enough time for its pages to be freed before the scan looks at them.
  queue_delayed_work() keeps the timer set by the first teardown and ignores later ones, so the scan can fire while a recent teardown's pages are still
  being freed, those pages are missed, and since nothing reschedules, they stay unoptimized until some later teardown starts a new timer.
  
  - Example (10s timeout): VM-A ends at t=0 -> scan scheduled for t=10. VM-B ends at t=9. With mod, the scan moves to t=19, so VM-B's pages are freed in
    time and get optimized. With queue, the scan still fires at t=10 — before VM-B's pages are freed — so VM-B is missed until the next teardown.

    That's a regression in the common case.

    So queue_delayed_work() might help a rare edge case but hurts the common one. So, keeping mod_delayed_work().

Thanks,
Ashish
