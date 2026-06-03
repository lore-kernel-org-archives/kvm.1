Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25B4611EE
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492089; cv=fail; b=SBvH6Gw3fdYwkbbZ62nYs96xasT9IP7Y9VQ6C6ijQdwFdciY11TcmGJiFhf6IS5/8c58DU+Xe2QmDGJct0ZiFa+HOWSfJeMNtCaquNak092cek0xdHkYyrj9eEHZlyKeZcx5VuCox01ErkVPSonG3azTT1tDNaqjwa8G9XaLi5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492089; c=relaxed/simple;
	bh=gkfkxAoQPF4bocYSDm47D7Pv6rGDskGV7INEnBbhka4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DXEeOR//HdDA+bhn/11lfCvvSSEgZ7t6kPWNnPLOWd5ZcOBwL5gzZ7prO7SXorCarVjwUjCGuomBV6Kotz293fCulQhKeccgEpqbalz9V/IKq9SOBRSgDz5qL1MybwSwg4H5IvPyzxINPraeIPEhZsDAJOk6pK4/AXtnEJhyH2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SUVSzjE/; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SUVSzjE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avVuuY8pM3T8/KVuR2+zs7Tu0B7RL1/N/WVDPeMRvbXXcnnkyxdSinhX6AGb8plbca4bexD3S6KDqQWWpjHCtGpnCHTfYyTsifNzaGEr3sxCil7600ikm5SmbXEByL4zezJEU2dCCsNK4BUU6k+zhqYjWclcLEtzNGNPGDWP+OkkMDUHGnw12xJGr+DHU6wJmHQVPvM87oGTcVoTly3Qsg1OWpCTDe2/HsDqn7jOcs6P5y3lRGs+zXGs3mfWJ0wDgXADhhLeSfDxji3uqgqyHPUfD+gwbKLVK77okpWp5fys/WLEJn0fD5tUUaeKBBPbGNzECj/O53+M/OQ66qF1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak553t2KJ69OongPKvHQ8IShLlbhGJJ07MRtW7Wu3vM=;
 b=YD0DMLuVy75DipakOPsG2qVcTNVFmvQ8ylz8c7GWn8Qg8I7f5Wwx8Q8fRIfDssQe1BZFqMLAhtmZITSzXluo4QjMRJvuQMvDGrjSr9Y6MM9yH5YzuCJL99ofqa3Rm21yDe6B3LBHUc/TXG5kFlww0Yfvj/Fdg8msx6Hjag/klpyiSO4VCl3ZOY3phk1AXrGjXKapY0Pnt0ZVCjv/uFlakwR+VRwIv1ef2X49GI2tdkz9yjX2hGzrmIQ4s40wYcf6qVq9DX9WyK8WBhRXaaTyUYEbo0FMJorLSShDjSKz5ZYDv6hrBEyIPKuY+IuyI9T4dtsfr/lpA15O0m3e8jatMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak553t2KJ69OongPKvHQ8IShLlbhGJJ07MRtW7Wu3vM=;
 b=SUVSzjE/H0szKOBXS/l8yhZH+PiTtIW+YMSEYQdPXINXuCI3lGaHBXIBcI6ISHyiWLGhkMFweti4g/RvJpkH8GDbZdFaTy9vjSYcnP4/n3c0wxKf0DU/X60YY5qmYYa3OtpDKDynRhLqV52t+Vb/d8AKanqpb5lFrbI/Qbe6xGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:08:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:08:04 +0000
Message-ID: <2ae6f15d-695e-44d7-b2ab-905f83e78a6f@amd.com>
Date: Wed, 3 Jun 2026 08:08:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
To: Atish Patra <atish.patra@linux.dev>, sashiko-reviews@lists.linux.dev,
 Peter Gonda <pgonda@google.com>
Cc: kvm@vger.kernel.org
References: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
 <20260601231728.C67C51F00893@smtp.kernel.org>
 <33dccdf4-45f7-40b5-a0cf-3f99b26d46f1@linux.dev>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <33dccdf4-45f7-40b5-a0cf-3f99b26d46f1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 112cbd60-fe36-42b9-3697-08dec1712599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ROfTAhT5MVkjGmMaq3AR0zfjW1VPj68qmNoQ5j1JEwIpQh5WIlHjpqtPxtKf4wgB18V3nkJMBRJI5srLPO/L35nDtrgPsCUCaJf4xvU9/2fTa62K+8XUaka1x+42gviVFCIJJAjYilMgICtg7p9VN1LAUtmcBrkzEqVywTBbJ8ZKC/YPNyBpEowgNVc5oaNvP6sTupyeEizziOmvBlqApAw46mcaL/NcpFk6RY3PVoG1a+qNtkhGQqZgWKyu80yfGU0PNDyQ6Cq99Y9cwciaIi9mWvyFWXjkTNy0cAr0fidj78yOj4H3tBIW8HAo+XsvlbyCGvS7dJlyucRZr0TLTOhxmYqdjbLIZYXlvm5mK23hiaQf8FoSI9UAwshNB4utNml5dO9juXM0hBuEIslDpqvenLGGmkutTXbEj1dptG8Hms0WnRST4h/7ULwIm2m8BftsDxvB2zox7on7eyLUQcsV9MiXbg9oWvSdyWZrA8R9x3S9ZOv7ch2xkVafU16Aczn5m/vm+Zidy5Pkm1hxiJs/uYVJjTwjYSaAbuuCAEFMQAJLs+ZKcSW1A2tfsRlFDMXvSrL139BXrPxrPu4YCCvZSYNPLLOLjRmve1JIO8b79q2AzRSzxLwXByolfEYW68CVfkqU2cVhCTpmsjoXgbUEgKOfmE+56dYgqAbjvToCoLNisbUrCOJ9ze69pJeT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZwMTRhWmtJTm9KMW5MM2xlSG1RbkxqRFY5QTdDNDVwdER6YlNCcEUvd1ZC?=
 =?utf-8?B?cjlwaWNDUnl2RVovay95elU5TjZ1ODRHNkRvbmcvTUhpb2JyRkJzKy9UZmdy?=
 =?utf-8?B?QXF1REx1UUkxQ0gweThTY25Fc1BLT0taR2RwQTBjK2ZpRnlkek1nRFZPNDlU?=
 =?utf-8?B?emtRRlJUQUhmWTFsSGN6ZlVMYm5lK3JhKytGRUJodjNOL2lvSzJuWmRSYUox?=
 =?utf-8?B?d3o1T2xacFJMZ3ZVQUl3UFA4dEVubTNNZzl5T3ZMQ0kyUjZ2eDlLR3g4b3ps?=
 =?utf-8?B?U3Z1UCsrN2QwU29oLy9tNjNJM252VXdXU2dsQVJFSlFHUmlFdjdYNnArVWhk?=
 =?utf-8?B?aktYQnlGQ3JpTXVFS1BBdU0yZm1hZmFjOWJHN0JISHNmdXVjYTJEYTAxbVUr?=
 =?utf-8?B?OVJ6Z1BlSXBaL3RLTWxFbEFNVFR1MU9tblZpcHI3b1hBVnNUaEpQVGg1cmJD?=
 =?utf-8?B?WVU0QlRVZVVDL1MzS0VCZnNHcEhtckZZRzlOam55UlpyRUFYbVpzQlZpRldx?=
 =?utf-8?B?RkVOa053UzFFbExPKzg3TStFOExQbWJqOE54Vm5lT1dYeThEZzVFeVBKSFhQ?=
 =?utf-8?B?alZGY1RzSVViMlZjMEpTWk5RNmhXUDBHZXk1aHRuRENIWXp0TlFyY0JvZDRJ?=
 =?utf-8?B?STlnY0tJL3QwemFKZmlPYitkNmhkc3BkUXZpaGlnemEwS253eXpab3RZZnRX?=
 =?utf-8?B?cXRocGJxbUZmU1JMVEZNUVFwSmZtckFKeWRqcjRqUFJjaFlTMFlCUWJlRGtY?=
 =?utf-8?B?a2xINlRvcnVZaEpWVWQ3QjhvbnNnNWlrY3lBOVUwdkpZNjZwby9EenJEN1Q4?=
 =?utf-8?B?REYyUloyVXRhTUtkZ09NSDB1L21EVy91OUt1WGpVampzMzFCTmE5QVdnUW5R?=
 =?utf-8?B?NnZHeFJhVFN5Z3JORU95M21QSlJ0OHVLWTJCdTlNRHM3ZWozWXoxUDNGcEta?=
 =?utf-8?B?bmZlY21EdFZRQkovbFR5ZFRCeU8zd1JJNkV2TFFvdFVrYnBncFMyZCtPSFpN?=
 =?utf-8?B?Z0VEdVVWS0lWWnZGSnB3N3hQVmhQRjdQRHJMQTFnRlNodlJyZGhCZmJjdW4r?=
 =?utf-8?B?Qkwzd3VQY0kzSmhsd3B6SkxOUUZjanFrRS9ZcjRoZlRBTzF6N2V3WVJJWkY5?=
 =?utf-8?B?b09zTUZhbU05TjE5V2Uyb1pmNnlCUStPamlmajd1RDFBVkpRbU9tQVVYZ29X?=
 =?utf-8?B?NHpmQnB2RnlZRHdINzFDK05HbVd0MkRLSnBySVdnWHdxb1lpK0dMMllwMkVS?=
 =?utf-8?B?b2gwSDRaa1RhSWdtMnpHZFc0LzE1UEQ3L1h3L011NENlMXJ6ZVNCY21hL1FY?=
 =?utf-8?B?Tk5KK1NtQ2hlLzhXZVQvait0TnZDdjgxWFFiZWw0aENTbU1kSHhjOS9Cb3Bs?=
 =?utf-8?B?cGUyR2ljNENwSkdEMFZzZk1YTU1Ra0NPT1hlVkNPY0JPZWRqNExlbXNyekUy?=
 =?utf-8?B?ckxhQ2pnSTEvbzJkRGJwQzl5ckNXT2p2ZzlvaEV3Q1AyallxUDRsd1JBeDB3?=
 =?utf-8?B?b3FCU09kSTh3cG9jRnVmRnBwNUFheGEzKzlDNmE1WEdEUHhoMytwNlVJK1JZ?=
 =?utf-8?B?T2FUOTRkMHd1a1NzRHFKb2toNUZOYWhDRWN6M1R2Zmkzc3EzbzNWdmU5dmNk?=
 =?utf-8?B?K29HRGRPeW9ZenpCckphMXBEdmRuaDV0ZlRSb2V6d1dEeDl3dnoxUUNac1ls?=
 =?utf-8?B?Z25kU3hCZHZURm5lZ3ZqUEZ6WUE2YVRTTGQxb3ZqOHpSWVRxSmRDUEdqWG1a?=
 =?utf-8?B?UWVxZG9Rdkx3ZkNDVWQ5cmd2R2RrUGdaQ05oMUg2RWxGdE13aTZRSDJlMzAw?=
 =?utf-8?B?K2RJckN3RXg3b0RBV3NteGdNZ21Xb0dsbmxwa1laVjUwMHQ5Z1FOWSttUTNv?=
 =?utf-8?B?Z2w3VEF5Vk1LVXNNelJYWXR1OENuczhhWVowaVpDM3A1SmFMUzJqVTFaZVkz?=
 =?utf-8?B?WGROcmpzckV0bXE4ZzJqOGdtUkxIMEdVbFJFenNTN2ZCMmhtMmtnbndtMHVy?=
 =?utf-8?B?WVhTTEd2aUpsOCtENm1WaWxIckhmSkNOb3ZpdksrZi9xL2VTKzdXUy9ZVG1j?=
 =?utf-8?B?Q2J1U3ZESXZxZUQwOVBKS1BWT21LT0xOUW9WWGFmRVYrYmZRRUFlUld1aHdG?=
 =?utf-8?B?WmZQUXRxNFBpTjVDRk1LVUZUN1VHWjFFVENQQlhkMVRFSHpYQW9JZ24xY0tF?=
 =?utf-8?B?S0grK1JyQ1ZpM3ZBenBFQi96UWlNTU1uUDBNZGFydWcwSkZaVWhtWG5NRjls?=
 =?utf-8?B?M0tEYUsrSXB6cVZ0OEM3L3gvSy9hUjFNSGdvOEVjTVdBR0FxOVJMMlNaZ016?=
 =?utf-8?Q?95+N0xQKB1YRxU7oUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112cbd60-fe36-42b9-3697-08dec1712599
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:08:04.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJWyS8llWu3BdtGftl6Luo8qr4L4JVL5YQLDYaWnl68fhJ2Y5U3Pgxy4bf93Q4tiQjNckMb1FUHcisBWRoUEBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198

On 6/2/26 16:55, Atish Patra wrote:
> 
> On 6/1/26 4:17 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider:

Adding @Peter Gonda who knows this code better than I do!

Thanks,
Tom
>>
>> Pre-existing issues:
>> - [High] Missing `kvm->arch.vm_type` validation in
>> `sev_vm_copy_enc_context_from` allows creating structurally
>> inconsistent mirror VMs.
>> - [High] Missing `vmsa_features` copy in
>> `sev_vm_copy_enc_context_from` breaks SEV-ES mirror VMs that use
>> features like `DEBUG_SWAP`.
>> - [High] Concurrent list modification of `owner_sev_info->mirror_vms`
>> without holding the owner VM's lock during mirror VM migration.
>> -- 
>>
>> commit 5adb8a893221b0569310f07fd9fc7abca8088651
>> Author: Atish Patra <atishp@meta.com>
>>
>> KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
>>
>> This commit rejects SNP source VMs in migration/mirroring until proper
>> SNP
>> state transfer is implemented.
>>
>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm
>>> *kvm, unsigned int source_fd)
>>>           return ret;
>>>         if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
>>> -        sev_guest(kvm) || !sev_guest(source_kvm)) {
>>> +        sev_guest(kvm) || !sev_guest(source_kvm) ||
>>> +        sev_snp_guest(source_kvm)) {
>> [Severity: High]
>> This is a pre-existing issue, but I noticed a potential locking race when
>> an existing mirror VM is migrated via sev_vm_move_enc_context_from().
>>
>> Locks are only acquired for the source mirror (source_kvm) and
>> destination
>> VM (kvm):
>>
>> arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
>>      ...
>>      ret = sev_lock_two_vms(kvm, source_kvm);
>>      if (ret)
>>          return ret;
>>      ...
>> }
>>
>> Later, in sev_migrate_from(), it updates its owner's list of mirrors:
>>
>> arch/x86/kvm/svm/sev.c:sev_migrate_from() {
>>      ...
>>      if (is_mirroring_enc_context(dst_kvm)) {
>>          struct kvm_sev_info *owner_sev_info =
>>              to_kvm_sev_info(dst->enc_context_owner);
>>
>>          list_del(&src->mirror_entry);
>>          list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
>>      }
>>      ...
>> }
>>
>> Since the required lock for enc_context_owner is omitted entirely, could
>> this concurrently modify the owner_sev_info->mirror_vms linked list if
>> userspace creates a new mirror via sev_vm_copy_enc_context_from(), which
>> locks the owner VM? Would this result in kernel list corruption?
> 
> It looks possible for SEV VMs looking at the code but I don't the know
> code path
> or the mirroring/migration use case well enough to judge how likely this
> scenario
> in real world.
> 
>>>           ret = -EINVAL;
>>>           goto out_unlock;
>>>       }
>>> @@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm
>>> *kvm, unsigned int source_fd)
>>>        * created after SEV/SEV-ES initialization, e.g. to init
>>> intercepts.
>>>        */
>>>       if (sev_guest(kvm) || !sev_guest(source_kvm) ||
>>> +        sev_snp_guest(source_kvm) ||
>>>           is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {
>> [Severity: High]
>> This isn't a bug introduced by this patch, but this block seems to be
>> missing the kvm->arch.vm_type != source_kvm->arch.vm_type check that
>> exists in sev_vm_move_enc_context_from().
>>
>> Does this omission allow creating structurally inconsistent mirror VMs?
>> Userspace could potentially create a destination VM as KVM_X86_SNP_VM and
>> mirror a source VM of type KVM_X86_SEV_VM into it. Since KVM's core MMU
>> would treat the new VM as an SNP VM (due to arch.vm_type), but the SEV
>> code treats it as a legacy SEV VM (because ____sev_snp_guest evaluates
>> to false), could this produce an inconsistent internal state and allow
>> attaching guest_memfd to standard SEV VMs?
> NA. They don't have to be same vm type as per my understanding from the
> selftest code.
>>>           ret = -EINVAL;
>>>           goto e_unlock;
>> [Severity: High]
>> This is a pre-existing issue, but I noticed another detail in
>> sev_vm_copy_enc_context_from() just below this diff.
>>
>> The initialization block for the mirror VM omits copying vmsa_features:
>>
>> arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
>>      ...
>>      mirror_sev->enc_context_owner = source_kvm;
>>      mirror_sev->active = true;
>>      mirror_sev->asid = source_sev->asid;
>>      mirror_sev->fd = source_sev->fd;
>>      mirror_sev->es_active = source_sev->es_active;
>>      mirror_sev->need_init = false;
>>      mirror_sev->handle = source_sev->handle;
>>      ...
>> }
>>
>> This omits mirror_sev->vmsa_features = source_sev->vmsa_features.
>>
>> Since SEV-ES VMs use vmsa_features to track capabilities like
>> SVM_SEV_FEAT_DEBUG_SWAP, would a mirrored SEV-ES VM incorrectly
>> initialize its vmsa_features to 0? When vCPUs are instantiated,
>> sev_es_init_vmcb() checks sev_vcpu_has_debug_swap(), which would evaluate
>> to false, resulting in misconfigured VMCB intercepts. Could this silently
>> drop important execution features for SEV-ES mirrors?
> 
> As per my understanding, that is intentional as well.
> Is it common to mirror SEV VMs with SVM_SEV_FEAT_DEBUG_SWAP enabled ?
> 
> @tom: Please let me know if any of the above statements are not true.
> 
> 

