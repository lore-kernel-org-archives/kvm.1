Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020130.outbound.protection.outlook.com [52.101.189.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0113EEAE2;
	Wed, 26 Aug 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748610; cv=fail; b=FF9sKi4owZ844Jpn86LLBZ/zWYOyfcjkfiy1XE6wytaxaPhVxSvhdcGdElRTeyXeLCc/8c3MTcOJRZyEFI4q2xVDmxwRGLTMN+SFSjZAbO/EOqVEFMkK1hqeU9F/lq048caqNRZpS/5qRpBifps32Qj+XAGWxq7shokTPQJ88t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748610; c=relaxed/simple;
	bh=8zHpHdZE8Ui0Cm8HCEdnIIaN6UVhzImOFDHh/IWdjC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jM4Rb7asASXL2wX7xkJBSmXJ+GAXpE8BAu6/phrD99LhhYc3iriZ4AO23QJtPNi0qQ5QIPxVFf9YEM+Ek3TLTW9EauwLbcXOEdPcUjfoirlwyvZvInlKRbOgANlJonbrNKYB6MBSF0E8ngN2oLvP1bi/k4JEmeXFqqbPko/oDc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pAE5tdS+; arc=fail smtp.client-ip=52.101.189.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pAE5tdS+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWbk6UGOd9joJlYHgsN9G1NU+QJTtC3yYZeqFzS0l2Hp4qAz5nmp1TmfGyXdyfj4v/pZgzocwCUoB+y7QGiMTv0gxIa6cOGSiu4Fq5x6hIiytzTxoNe/0AVB4ijpWoWS2VKl4MaS1ad+mR+rJrTFgANej2orIQwbOlrjFKefNeEz8CaHQcH5CMF1re2VTSBP5WeEbBpUpuldo0IP1Rk3uKgHYtm5IgJh8iggRmj3dnpogNDQ4u/ks4gT8cCANupsJ997XwK4YjwtZD5lUivvwX0/ZlE6uJaYkYHMD6iIE7Kiao3e4EK25otTnxTt1vg3Wo4scWp3IBgQC9GF5ze3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idXXcZHlOtp9oIv9nqV/3Kzlfw1H1Z/0Sxdw+Vi07gc=;
 b=Sluj+I5i3g7imktAxOb5v3Fr2pQicjjpOAezPWqFmwm478TPI72teCpGlXNjAr+ZyN+fW+ezkMikYU3b0/QjieBIYmoFjt4pmXeRbpXC+i65x1Nz5gfh6MPDa2zy0PFbA0nMEuB/xIUQF/mLQH6AO0ZIXw978sSbpseBlNxqLbToTCw4J590MxcRcwdHRqRC8vVqaeIRNdwN4mVbsdQbuY8Ae4uy2F7XU7x7QXdbXoICRcVR5pjDcQNxVgawKDoEY7SDCRKlhQaovDjmVFbGHGyC1SoWEjC79ltL23TsB5ngDaP03xkZoYHv8FWmTfPRCLh+hdEykeQ5plN8ZNzR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idXXcZHlOtp9oIv9nqV/3Kzlfw1H1Z/0Sxdw+Vi07gc=;
 b=pAE5tdS+P7qLPUVaFBpCryiIS/BHlnKaKveqqHTBXxEMov6KKjbr+c5yAMRIj/zj2PacfWdRBsQNvDJJVnhxowV6SxyBKAmKnDVMhe4Dt9JmoMa2EjnLFFsqUbyba+NBiaKeNJgMsSOI11AHKNjSz+sCWMeg1Q9z3nuIRd9HVz8K4Ug9Mz/qAjKaQCkT9unNTCEc3VCNPQKgDsZQ29wEGIbj9QtBQOOXy27l1RfwV5t/KR4eXuTjzNwQ/OeCZBZYo745BAFszJMuHdlQkoiSK7xJZT/9WjvA/CdIy3AvGTDhNiuivEzCMtPRRU3aKtjnKuuVLauHO2EpYcSPpHCVaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 12:50:04 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%4]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 12:50:03 +0000
Message-ID: <41b1723f-fd53-40f4-951f-d1736e78abb2@efficios.com>
Date: Wed, 26 Aug 2026 08:50:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] KVM: x86: Add support for cmpxchg16b emulation
To: Sairaj Kodilkar <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-3-sarunkod@amd.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260826070004.8100-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: beeb4b00-6826-4714-d2a2-08df03708bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|921020|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nV4UmZe4ma8/al13L93PprG+T7ZM2Dq7akQajY7NwVUy/+6uhOvje67deIrAjRXuo3a4q3imBbAtVurnxN25Top+zFu6q8Y47oUWd77hIUc/xpxI+NyEtMOmPdI26IfQPxw7PSw5CwM835DzWCJCdg8vyhiGRF787pANIKLrUiY469nF3inf+cB8qu6fOxx+8utFeXhQGeK6W+7f7ATeOoNaMSmlyIF+aFOBii2vENdhUfZDULaAdeYXNyX0w5ln3DMNyGjEO9yd4I5Irxy+urmqvFJqsZ4yp2TckO544bikoNAfvoawYGkvC+2UddbFnHKrgyZUobvl+ujSb2yXYda2cPZfjVpk+l3a5z8uZfs0e2G+W4cHXNOqEZednF98gZ90pku1lyIujfJtevNtpuaQP2S7Pyu2IyOcalNVAG/1VgAdtz35jYPwZ4+FiLZlzKrnZl51hrKd4/nMp7sk6ymVn4XfI9cr4BES+iCWwWNRTrM7iJ/Uz2xpFAtmzIyifx6PlDFLukNa6BXnsGlLjEIAOs/vEtUqhO0jdb0jFsaGq2ipk4aT3nMBjgu2vMagCAj6Xu5zlCh3zaigVSCU0qlxnRDn4ZxqfTsUdIswvv/mUX4wGOwgbqTOT9ssiVME7pddxr1vd22nVeXpq3DSlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(921020)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDNLYWI3QjllNzdrV0s1bzNWbzl0VlROWXdnQnIvRVZGSmFuZ0pld205TGpV?=
 =?utf-8?B?WEZjV2JpRUs2SnlYTkxOTFlBUzVCZEpyUkc2emtKRW9jK2xoQlA0Zi9JWkdt?=
 =?utf-8?B?ck4yK01kb2gyL2h6TjFRMFZlMkNsd1FFUXNSNnBUQlRQUDV0Q1AwSlczRHU0?=
 =?utf-8?B?Z1A1RlFMTGl1Y0FKUFUwT3hybDdlRzZWNmJCdjNGaWR6ajhkdTVwNEIvQUZG?=
 =?utf-8?B?bzVTT0tFWEhRalRkd0gra2I1MWtVK25abittbFlRaTZOTUptcklsZG5UWVFN?=
 =?utf-8?B?b2tGZ2l5NC9DanpCZHZURWpZZXpuUkxTRjh3RW1OTXhlZ1JNeWxNb2xFN0tr?=
 =?utf-8?B?WkRlT3NodXkyRTlhQlQzMC8rVzROVUJDeVpkRHF6TGJwMDZwNGpmSTNkMEsz?=
 =?utf-8?B?RytlN0M2c1lRUzU0eVl4L0RQY1d3NnFIZWhqQy9jYmtKZENUZkJobDQza3hO?=
 =?utf-8?B?ZjRKMmR2L3Q1OHVwRXRtOWhNVmNMK2VSdnh5c0Z1eE5rNjZKVXovek54Z3Bw?=
 =?utf-8?B?QWNQM2JoS2IvMi8wZlZQdEhKcGFpWW1HaVdOcFB1ZmRRQ2lWcVB4OXlEdGt3?=
 =?utf-8?B?RG1wS3lTSjJpLzlhcEt0VUVub3E5cE9Cdk9rTHZvSExwT3Q1NmEyVzBDQjRL?=
 =?utf-8?B?UTFYSGN4N3NqSU4zZi9wbEZjUmovNndtUS9ZZEU3WjZvOTBKcjk2bXNwN21l?=
 =?utf-8?B?anc1d081V2grRFZ6MVloelhlcEpwTFFJbkpCWlBJSkJMcE5veXIxV1dCbWNY?=
 =?utf-8?B?TjBaM2xMTldRanNmaUNrZGhEbFFqc0pSSkdmdTlYdUIvK0l5WmY0blNtNmZF?=
 =?utf-8?B?SmM2cmFqZlcrWis5Z1lGdWNSUFJmekJVKzB1RUIvelo5cGtLQ3c2d3ExR25u?=
 =?utf-8?B?Vlh4S01MVUVuM2E3WW1jS3V3L1c2UjBzUVBZMUV1eG9UOVc1UlZCRndXR2R5?=
 =?utf-8?B?QzErREJEUFo4enVOMmw1ZlBWdERwQ1l3OUNKTzUwcHVNcXRsRHpveHRkaWhF?=
 =?utf-8?B?dnB1MmdWeDdVZHVXQTl6S1h5ZHpqQTVHWmdCU2g1T050UERIN3BMdE1wVFQz?=
 =?utf-8?B?WDBqalhYWVhsMjJiMmd0T0dTQ1NuRlhJWDdoZ1h2WS84VnFndm1hbkpzMS9y?=
 =?utf-8?B?L21rM2NEQklIYlNGbzdHTnU2K1VvQ3JWbXp4YmJVTWJ1M2tTRzlpMm5PUWhv?=
 =?utf-8?B?NXhOZDUzeHFjK2VqZ3FQdXc1V09Gc3lXZDQyZFZ1OUhZV25hZHIxNGNJVGZv?=
 =?utf-8?B?SkpvN3VpWUQ2QWhEUE5TNGZJdCtYcUhrT3ZIYUwvZFNGRXZ6RDNRbVJKZWJB?=
 =?utf-8?B?ZDQveE5wZzVpUDFwbmR2VVlrUHBzaGFoZW9UV3V2RFpNbUpuOG1vQmJabCt3?=
 =?utf-8?B?T2dYYkZ0NE1ZanFKaTRXODRiYUhveW1MNlo3dWg2U3BTUm9LblJDWitHaVJ3?=
 =?utf-8?B?MHEzODUwRjVVMHN0ZVh4WjhlWVIyMG9iWGZHNmlVbERLeGZTSHRKNm5HeDlS?=
 =?utf-8?B?Y2tCM0FlS0Nza2VCOUlFTnR3RERHZHNqOSthSE1TM3BCZ0t2Z0NHaHkwYlJi?=
 =?utf-8?B?c2lMT1lYV3NtTUw3aU84Wk05bm5vZ1J5Z0M0VGtrK0NnRU5RcmdmTmc5ckhC?=
 =?utf-8?B?ZGhTWklWS25CdjZ6eUZ2b1lKaVB6M0lGRG1JejJRYmZwc1ozT3k3aVdEOWVF?=
 =?utf-8?B?KzNxR1lBeFJrWXptNjM3QWQ4ZkJ3Njh1bzBEMjdIWWxmNWhaUVVUV0VHL2tE?=
 =?utf-8?B?eHBybXpZL3VNWjdSeEJ6TlNzTjMyaFVSdUVYbHVpd1BiSWF3aVRycHQzbThT?=
 =?utf-8?B?NnlNdFVWZWVBcW9zN0VDS0VodG1uamZUZDM0WGEzWmRoOThnZ0VZcFJJclJG?=
 =?utf-8?B?cjhUbjFpOGJoVVlHNlNocmRMWmlKRStTTDVMd21yaVRHOCszK3dkaCtiSC94?=
 =?utf-8?B?NVFnL3U0a2M2YnBWVU5PMnI3ZTRuTG1xcmkwQjJ2c3BNcjgxaEVBU3A2R3lG?=
 =?utf-8?B?ajRDZE1YZkFScm5UaEtMSE9CZVp5b1Z6QzlpQ2FsbmFQanprS3ZNS0FYRGVs?=
 =?utf-8?B?RmEvSTEvMmxXNktjZzFmQ1FGY3RkblZTNEMzVHNydkVYMjhUUlVVdDJabFYv?=
 =?utf-8?B?WE9GRjdEc0V4SDJQSm41UXJjbHhpQTBjbEY4MXRDN3M0MHRVRzNmblBxMk5J?=
 =?utf-8?B?WGNmaUVjbUpGQ0ZidDc5UmJDOGFxdzNXajIxZ1ZFb015K1Nkci8zS0tORUpG?=
 =?utf-8?B?TmF0cFdOUFd3RDJkVDU5VEZUTHRGS0d4KzBKMmdIQ2xSZ25FMUk4ek8vUnRG?=
 =?utf-8?B?Y3dQclgwNmZBbHN1YlVqblBsQnVKTlAwZTl6Ukk5NWZLVCtvWmsvTmxyQ1V1?=
 =?utf-8?Q?QnZVx8itS+eQvtYlzvKxTa5quOqWZdeghmb6m?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beeb4b00-6826-4714-d2a2-08df03708bf8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 12:50:03.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFRN/7RaAdHDzttrx2wtu0KgAgh8E1BRqrezGm0lz31ZS177H+cB/uGf8A5kvLQjMjWYGJR99GHlVJaigoBuoaPuJCO4sbWlZgtNOHlY9yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6072

On 2026-08-26 03:00, Sairaj Kodilkar wrote:
> AMD and Intel both provides support for 128 bit cmpxchg operands using
> cmpxchg8b/cmpxchg16b instructions (opcode 0FC7). However, kvm does not
> support emulating cmpxchg16b (i.e when destination memory is 128 bit and
> REX.W = 1) which causes emulation failure when QEMU guest performs a
> cmpxchg16b on a memory region setup as a IO.
> 
> This failure is seen on the AMD IOMMU driver which writes 256-bit device
> table entries with two 128-bit cmpxchg operations. For guests using
> hardware-accelerated vIOMMU, QEMU traps device table accesses to set up
> nested page tables (see [1]).  Without 128-bit cmpxchg emulation, KVM
> cannot handle these traps and DTE access emulation fails.
> 
> Hence extend cmpxchg8b to perform cmpxchg16b when the destination memory
> is 128 bit.
> 
> [1] https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8_amd_viommu_20260106/hw/i386/amd_viommu.c#L517
> 

You may want to test for the X86_FEATURE_CX16 cpu feature and only
enable this on 64-bit x86 CPUs implementing this instruction.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
