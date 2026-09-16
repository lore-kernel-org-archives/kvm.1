Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCC48CD7F
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601501; cv=fail; b=S/uKFIV5mKjC+BmfXMMrQUjXJzeAuWZX13EphU3yQxwSyVCWUG++zhdUFLiaOVf5Z8wM11FKuldv/xixxKHmMe5e52mJsDvnQNZuLp9xoX9ODlW3fLiVo6yc0M4Dcs2JYis1fISTOkfz9HGf2XAVVDkDzP2P1/Yg/IruHs2gdt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601501; c=relaxed/simple;
	bh=/UH0Whxp45lmKKRZMvr+/LO8IpobT1fmRGxAjweECHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnJ38N6batD0b9VSxB1m/nMyQNG8vfCMODPVgjFCgPMFf6bGM/O5fVa1huPbLART/kfVfCYtz15xCfxd6Zyl3l5844JlyyIuLXYJzADC6+8zfcHcTOF06DQUIdjGFnTzwR1MlY20+orUxB9oPFuHhyIc8MbhK5QY9O/9JA3SGw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RPckePkn; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPckePkn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8HhU8dvVnM1iyGqT1InyKmeLsxVaRr1UJ8gyPPMmh5fG2FauInzSd6XWnZWDNPB3guOJ5JK46eyszf8dzDHUz2jJw0jPGaxfel3TGpoe9DtdTSbzYawSRp4HyUXmSbreaVTAEi21FcWc0S5UVlEZcii2aHSibeh0cA28Go64qq4f3lZE10VOzbtkCi2jIRAmJRnFTaJPzNbBW/hfoae7a03ADt50aASUVA1fKJiECBizwnWoRpiIuVR4ZAeJGS/ZXhvWJX6y0xRc8um5HllwXVBUSKl05VGrfW57oiEoHTvThy8lrsYtAWMKihapbP9uSp8+0bcmHl2DGt2kT98Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SNgFNJiD2nyEOR6xoH1PtliI2UjI7v0svl83gpGe2Y=;
 b=LjT2qzmyEt3NO8aEP1UDerQgyi+3jqs2+Tyv+2Pq5a6veU9eU61sLD+IuRCd7+rYSilWoB7XlYQoHgBteNKUVoBdovSkRnpIn639dOyMdSIY/qIXUDXnuIrwVgTj9riNiQk0w48397RduwjQEFgwPHN34EdaOb2cWOJboN+eu75dzE5f0blxUXN0SR03kXczww96HwGZkDyGTzHaUDIHr7B8iklKCZsfCE8g5Kp7hPgLfMumgjWHZhMDXboU4+lMg+uIaqQsodXl0ZS0p7/pZGoY+Vb/mIJ5EL7xQvkxvwjUpSmq9M2D/fYwBynpXe9q695/Zyy+nnZiN23e5FtGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SNgFNJiD2nyEOR6xoH1PtliI2UjI7v0svl83gpGe2Y=;
 b=RPckePkn/cG6ryRLOl98dIHoDhd5vCB/la+FUYRxJy9WC2lzsR+LRj/hiYhcdBNvzL2EYEeMgRTSlsqOhJgR2vRXpa5PzMcgQQTqwyKdLGebouqxuK+Ls58RFKTUWwVUASRVIJQEw0bR5AoYswwpziRICISEnwLdB4xuuPkSJ3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 23:31:35 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::ae6a:9bdd:af5b:e9ad%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 23:31:35 +0000
Message-ID: <c1afb35a-f9a3-48c6-81e4-91a4299f0cc1@amd.com>
Date: Wed, 16 Sep 2026 18:31:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/5] x86/sev: Disable CPU hotplug while SNP is active
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <cover.1789594774.git.ashish.kalra@amd.com>
 <cd6962a88d691a020c2bf40fe77a6a3f3852fdfc.1789594774.git.ashish.kalra@amd.com>
 <20260916223630.C5E1C1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20260916223630.C5E1C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::8) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: b20bf511-74c0-43f6-0c5a-08df144aa5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	jYOMalcM3JEDcsMuKMkUFUIUO9PIRLCmWRy0L7I9S7ofBGYKEhyB/1EvmXvBx7mR7Fix1bwuOs8FHkxqlegh06jCOjWUgTUM+PeJdAL9h7azes7QbsI2fJTKmS0fJcPE3Yk/ELb+GoIWdBFgqvEokRly2dSDt8TmbAj9ByJjI+2zTWWnqUzFfVrW9kDadeHfLsNtAJLILI+zxc+ZsTDuV5GcBqrcJUomOGy+F+YxwoBKMcXf0tAVcLEZbVBJbAB2aec5oGBOJtwuQWCt+HLCUTkSTfxrDbqXLfDvTpQMoMUn/X/rbpcOfmVoTaq23oL3NIIJL115nSiDhD6YH7lb+t8l0O3XkGF0gJv+N62zsOld4HEu7Riyr8NPdQ8qjI96gfzh0iKYRwpAwT7SO+bRbFpk5bodh2AjabEpaikI59HqHf3oyUr0g6aXfhdZaCBGupV1GmbA0s9VjrOKWWHE1BybU5Fjf+rjqAEV1W4rUt1Zps3/xfXiygV49ng1oYzryt9cPAGoWG3E+LqO7NtKrwZFAfnOy34x4N86IS9Xk11dIh2mlHX2ss0jyJgD5SgSBwA2G34wmEHnRfhxow8W2XQlOGoBd3QXBFjyxjminuyB5US07plf7IQArPOBRKh7iGnHN7CvMXTVesRTsgPehyX1jw69iW8GDc0FApvmBLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGF2UWhJQitoSFo4YmRWY1EzRjJBaGRjeXorbmpqWFVoYVVxclBaSWdnWEVK?=
 =?utf-8?B?ejZrUnoxRW9BblBIa2NmdFNYYnMvb2NPNXBBMVJtY3ZjcTlSUDB3WGg5RVl6?=
 =?utf-8?B?bUtQS2JvRkpNeGNXRXlaUW51dERTeXNEekZab3hJeHRUTk9Vdk9qYy9Pejc4?=
 =?utf-8?B?cksvZE1KNFpuWjJ1Wm96VEhVdUpVb2dvN1FmSWlvRHlTaFNVamJ3WjA5Q3Zv?=
 =?utf-8?B?L0lqTmRPLy9WNnViQ21TT3UveDhXdTByUk5PL1Ryb2dGY2tLQVRPWUY5N2s0?=
 =?utf-8?B?Smk0NjNqZWFvdnQyQ3JZUGdvVy9UeFM3aWtmMkh5NTY3b1A5Z1hNUGNQdEg2?=
 =?utf-8?B?S0owRE5qTUZGc2l2NXNCVnBCSmxNbFd2bE9ZbzVqazVZNE9lNmpFNmF2NE5C?=
 =?utf-8?B?eXdWQ1pRUXhiTzhpRStZanFBZFFDNW43OVV6dXhVNGliTTNYRnpPTk91UkNE?=
 =?utf-8?B?Z01Fa0lPNEFRTjlXRHlHWU5QQ3llOHV5S2prRXVndlo4TlRubU1ORFlOSzRs?=
 =?utf-8?B?UzJ1R2ltUWVRQUVsWmRaaHlES2J3WUZuTnBsZG5oeG45LzY2U2w5Z1JralI4?=
 =?utf-8?B?Y1pXQkQrNzE5LzhXaXFHVGxlc045OFVHcjJSOTcwOGtsbTNyZlJkeXE4b21P?=
 =?utf-8?B?bCtValBvRTcxdFNKSVdaU09iMmZnditEK3hoaitLcURvZEhxMkgwSmxlUGx5?=
 =?utf-8?B?K3d0NmJEb2JyeXlnMW80SlRVbTlEaW9vdmY2R051eXZRTTgrc1h5U1VtK05F?=
 =?utf-8?B?TVBacjFzUEVGMTdIM1hEekdONjBqdmszMXhPeHVrbVphaFVhRXhDTmZzWkt1?=
 =?utf-8?B?WUtUd1VMVDJYK1hIcytmeW01T3FsZHpnVE94N3c5b2JJMUFvYnRTL3JYa0Fs?=
 =?utf-8?B?d2FxY2xvdVNmS2VKbGpRdGp2SmYxMFl0bE1ocWcwd1FiaUFyRVZ3NWpjVWFl?=
 =?utf-8?B?VnhLZk52UE5Ub2sxejc4c090T25oazZXdXc1c3dVY0NmOW02NW42NldpY2RU?=
 =?utf-8?B?eG85ZEk4ZndQWmxxVzBWTVowMzJtMXJNYTJnM1dNSkN6aWROWEtzMGVncUdP?=
 =?utf-8?B?QW1aejcraldCZWU1ZW52NXZoWTA2YXFMQmtQdGlyZU1FekxJY3dVREhnOWNY?=
 =?utf-8?B?djF5MkZjOE84QlVuZm5TODJOb1ZpaGRCM2NxaG9yMDlXcFdhcHFhemZPSVlT?=
 =?utf-8?B?SXBvcXBWTVJqbkVMejNtNXAvSHNnMWVUS1pia2pUY2kwT091MVZ1N3dScVNI?=
 =?utf-8?B?dERaczJQbFBGdE9xeXBEUjFLM0dJTUVReEIrSFJad2tQc25PNm44UzgyNHc5?=
 =?utf-8?B?VkxWSHExb3luU0UrUSt0MXRqS1JoUUZ3T052U3Uya1pzUG1iTUYwTmFUOXMr?=
 =?utf-8?B?Vms3djRLTlpYOGkvb0VoS0hBb3dScG1lamRITWNlVlJSazdOMlhFbDMwUFl2?=
 =?utf-8?B?NEwzL1VIaCtEb1h3alZlcGVxS1htUDdxMzBvSTBqMnZ5ak9KdmVwVVIreUpH?=
 =?utf-8?B?MWRSaVhpZTNmV25CZHQ2NlZrWVdBRkgzRXdIYi8xaW4xK1I4cEhJQ0FRMEtG?=
 =?utf-8?B?MjlQYUlOck5oL09vUk54U1JzZlIrQXMzZm1zWTZVZHBGdmV2YWh3bzVNcWox?=
 =?utf-8?B?Qi9LKyt5SzJyWEtQN09FQnozT09WM2c4QU5oUkcrZ0lKeFpkY1EyNkhtOHhS?=
 =?utf-8?B?bnpkMi9kYXg1YW1JZWZnQ3EzM1JVQXZDUnFEV0tEYTNwS1BZS1BsU1czbURr?=
 =?utf-8?B?MldLaXlrQVg1Y1JuY0NzUjhNaDdZRWV4MjllRlI4TG5iMzZKYzJIeDVmeHVR?=
 =?utf-8?B?bGM4TmYvYTVVdnE1ZlZtNG1zOGZUQWM1cEFablVMdU44dGRBRFJkeDJZT1pl?=
 =?utf-8?B?cERQSUhPSEhmQyswbUNwOWJHQmFRb1RWQlhEdS9ZMHpZSms3YzdMTnVTUW1T?=
 =?utf-8?B?cHBXNGZNdDljYlF2NnR4YVdKVm5ySUVtRmVjSk1uVFphbklJUTRHN1NhcWJv?=
 =?utf-8?B?dGcrNkxZT3RoWG9RTFlpcWo5THAvSEVoU1N5aXk4eXpMQ2xxWWdtNTV6SFFY?=
 =?utf-8?B?NHpGUHp4S0hQMFJKVFdtTjliRnh4cWgvVHJwMklIei9lNlVNNDBXVmZjL1du?=
 =?utf-8?B?K3AyeXp2Sm02QWdxeUtqMDdkVytqY2ZDd1BYTlpvSFhrT29nZkd1VVFkMGRq?=
 =?utf-8?B?Lzd6cmNIcXpEcm9XUXRJYUdMTVFDSHpjc2V3ZnRDKzdXcytBdDV6YXRiRXE2?=
 =?utf-8?B?d3FzTHNjU2NqNFRkRkFyMFluSlFJdHRoR2p1SlRkNDZIbkUzY3Z1Z2l6MWV3?=
 =?utf-8?Q?xoklVA+GvhPIXI/OGK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20bf511-74c0-43f6-0c5a-08df144aa5b1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 23:31:35.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFX7vedhxV+DjsVUzU3ucU5ii1siJgY21MdjMZhKw4xo8nRP0UoJSK5832yJzyb+dLdEA12gicqch7jWI/p+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836


On 9/16/2026 5:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] x86/sev: CPU hotplug disablement bypassed on early kexec errors
> --
> 
> commit ac084f2d7188c520f2ee3ced2ab76e4c068df91f
> Author: Ashish Kalra <ashish.kalra@amd.com>
> 
> x86/sev: Disable CPU hotplug while SNP is active
> 
> This commit disables CPU hotplug when SNP is enabled to prevent SNP guest
> memory from being broken by CPUs coming online without the SnpEn bit set.
> It ties CPU hotplug to the SNP-enable bit, disabling it in snp_prepare()
> and re-enabling it in snp_shutdown() when SNP is disabled. It also
> explicitly disables CPU hotplug during kexec if SNP is already enabled.
> 
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index cff285d8ad8e3..558f7924a3f85 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
> 
> [ ... ]
> 
>> @@ -577,6 +582,8 @@ EXPORT_SYMBOL_FOR_MODULES(snp_shutdown, "ccp");
>>   */
>>  int __init snp_rmptable_init(void)
>>  {
>> +	u64 val;
>> +
>>  	if (WARN_ON_ONCE(!cc_platform_has(CC_ATTR_HOST_SEV_SNP)))
>>  		return -ENOSYS;
>>  
>> @@ -586,6 +593,15 @@ int __init snp_rmptable_init(void)
>>  	if (!setup_rmptable())
>>  		return -ENOSYS;
>>  
>> +	/*
>> +	 * On a kexec boot SNP may already be enabled (legacy firmware leaves
>> +	 * SnpEn set across shutdown), in which case snp_prepare() bails without
>> +	 * disabling CPU hotplug, so disable it here.
>> +	 */
>> +	rdmsrq(MSR_AMD64_SYSCFG, val);
>> +	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>> +		cpu_hotplug_disable();
> 
> [Severity: High]
> If a kexec kernel boots into a system where the previous kernel left
> MSR_AMD64_SYSCFG_SNP_EN active, and an early initialization step fails
> (such as passing amd_iommu=off on the kernel command line resulting in
> !amd_iommu_snp_en, or setup_rmptable() failing), snp_rmptable_init() will
> return -ENOSYS before checking the physical MSR hardware state and
> disabling CPU hotplug.
> 
> Because hotplug remains enabled and the CCP driver skips initialization on
> failure (bypassing snp_prepare()), could a subsequently hotplugged CPU come
> online without the SNP_EN bit set?
> 
> If this results in a mixed hardware state, does it violate firmware
> constraints and cause fatal RMP faults when the new CPU accesses memory?
> 
> Should the hardware state be checked and hotplug disabled unconditionally
> before the software configuration checks?
> 

The SnpEn‑already‑set branch handles only legacy firmware that leaves SnpEn set across kexec. Platforms supporting RMPOPT advertise SNP_X86_SHUTDOWN_SUPPORTED, so kexec clears SnpEn and a kexec boot leaves SnpEn=0 — the branch is never reached, and no CPU has SnpEn set to form a mixed state, whether or not amd_iommu=off or setup_rmptable() fails. On legacy firmware that does leave SnpEn set, such an early failure makes snp_rmptable_init() return -ENOSYS and SNP host support is not enabled, so the system doesn't run as an SNP host and RMPOPT never comes up; the resulting SnpEn‑set‑without‑RMP‑table state is a pre‑existing base‑SNP condition, not introduced by this patch. Disabling hotplug unconditionally before the checks would instead leave it permanently disabled when falling back to non‑SNP operation.

Thanks,
Ashish
