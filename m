Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FE30ACFB;
	Mon, 13 Jul 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967568; cv=fail; b=VPTejosJgumcpHERdrFC2HZtoarU62bzNPxID2P+wYZ/tlN7XOyuvX1VWPFs30/OmtOjGsoLdg8wfG131EbRzs5vV8dqOEA6w++S8rxe2Z424isyyy8dfsms7pvvJlEqUMnbLLksgviqi5rXnBJISfcs7vKuL96T9iciRqnNMGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967568; c=relaxed/simple;
	bh=GkEb/6NvzIYi8JegO0gXW4mLRwkBJq9Jq0LTJGyVP0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqwRgWXS7v0oocWxEaqSgFVb0wbkF3n3uREMHUWC/1wYqcLpc/wfpd+Bi/DKv/UiY6mgNexmA5jHfGglq5kUPobHuVWBGp6n7mhqJVkj8kdlCJ6zxJRpIO7PVwMycXF4Apx/xh6a3RaS3VxABY2eMXJ4jc3GEgSgj32e5zkTiXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjyaDWh3; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjyaDWh3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1lwLE9c5Fg8Km60NjRs/6tO5eDcIIGAd/dRl3CNuhSLwSf7Vs/bkMCrCPRcV30ugm3G3OWX8TBlotAi1F942hxQqaD23Ku6YngYpjahlpVretMI/7WhHuFxOWgyfvRtE7WpanaQ7/refhAi8QtB4FVKRdrP1Fz2eZLXJ6Ij9Oux7RTfMDsle5lnp2TXaXb/WSV2q/pb/qji9q8oJlJKUaJLOEQ11gE1IlUZyFgqdcuu29aTKYn5bKe+mihFCBkYEBYfynuB/bSczYqn0XVvB4qpIMoCDY8ju15Kt2hedCQ1zks8hLtzMcSUOJ5zqgfKam3aSWkbYRRcMCO4KWE8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFO5qHrB9X4tCrozeFa+iBQjLWQ17WN2WAE9hAmISC0=;
 b=HKdqWFafGajIrfa2o77VrWpI6CWyziAZrs2z/HvPVALtn6KFnqcSCecgpb7I+R1Rk+S9SAuT6duu56mGeWtZyMTKMPlUenxQRehRNX/cXU01qyOofFHhfRY3V72Se50H3Qcr6be/4uIceBn5EkrEVHm37VaQli4x2lsJtynFwlPnRRDhVhQRQfObrAMwQATdxbEjNHtADlNmqQhaYbzrpR2P1MhDyDCq9TJUzJFK2w9Za56JJ54OzKN3wJ+HxrCa8t3oXryKtpHRHQ/Lis7H3cQq1Lwtc7iR2NOJZx+X2lqz5jJmLp3hdutKZHHOj0sEUD42HYwP4au5uBnAhRgIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFO5qHrB9X4tCrozeFa+iBQjLWQ17WN2WAE9hAmISC0=;
 b=fjyaDWh3ZgvKRIjAy2jbvr/5yh3Qr6PDd550bAVOzipeFEHTHN2Bgd52lqK37vrP92zwj+GS0y+7dp2DxyhCDPSitjCC/VWndbJPiofdNY5flzlwQAaxKmj1tpS/ZcpZAiyIM7ShMP3OP1zlSZ2SeltrzXazCoZiOiTI14hwru8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:32:43 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 18:32:42 +0000
Message-ID: <8d21da31-9e62-4455-85fa-a16b88338e13@amd.com>
Date: Mon, 13 Jul 2026 13:32:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/27] x86/cpufeatures: Add Secure AVIC CPU feature
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
 <0aa478fcd5cdf5f6835b1ff943d9655fdc8822a9.1783490022.git.naveen@kernel.org>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <0aa478fcd5cdf5f6835b1ff943d9655fdc8822a9.1783490022.git.naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::8) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: acb44c62-9184-4be2-6fef-08dee10d2054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ckYw91yulqnmECun/NWP5HD0/U3HQ1b8JMRJKzZcvK33KYF1flPuxLsmFgTtEEP5eYy+kJhsTLP8MYjqRQu1qmtYivAvYjtyNgsXCH+Cz1b0vFR0t79jDOxw0iY5rxWMtC7wNCJBZNS2hSXpr3ag3iUq38txqYLsyM5iJTRvUSS/0QK7drW61ul9asmOkpc3XB7yw5lNUdvMBXVBuqfhVNzK0NhbHGBPmy9UZstrlmVFFGAUnX36yNl8viKon+UEQwIh4fR6P8bY8hQXLM5NugUS7ju/lTuBXxvQPT5hzZWUjhaM6dvuLb1Mf39gRPtjGsgem+OpMuAy0qchw1hVakYBcwm5do2sw4NP8kU7rtcf5Ut8Yyb1pTn5IT2lx0dh8YA2nf6IhYmMnd9t9gXfayq1b2j7xCtJKAMHD6D95h45p3kPsEN+ljkXM4nmYMGbQXL8QGhKAW8ebmWDtXjdh6eDyZAImOtItqNoFI/ZBFuUR/XPbueEMf7bnn4ANuMScmFMWl/Pg1SwetG8CFlYIhZLtVGmsIA9/PwwiATTrkl9fnHKNG7VtaATjcpLUQWkFen5fg4VthhueXq1XPa5nqEvU3SSMTslDAiBvMtjedqwUAMZrA0+wTtbOCP+c9wRUULTCsD0xvmKU3bDR/ShvvmqNrOfNOZIZUTsHdIo4Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdrQUNlMFliTDRZemhHY3FYbytDYkdRV1VaL2tZaU0zVTdOS2dVU2RyT2Nj?=
 =?utf-8?B?TmJQRTJpRnRYV3FpUXg4K2lpQlB0VXpRbHBLLzhoOXEycW1Ec09VNnd0S3R0?=
 =?utf-8?B?cDJHVWFjdHN1cXFMeEVYQmRuMHVraVl0QTNjbHpYa3AvdGphdFRKRTk3M2NT?=
 =?utf-8?B?RzVDU21yTnp4dFRsK0p2RmdVeGY0ZlhCYldjd0QzMjVZNG9KMVNucm02bzNZ?=
 =?utf-8?B?NUJYRVZBN2huWElKdVU3WGpDS3psMkx3b1kzOXdhNlVsdUgzTnY4Wk5WZVpw?=
 =?utf-8?B?a2J4MFRCdjU1SG9iekYrQVI4Tm9BTmttUzRNd3A2M3ZVWUhWbmgxNU1Yem9m?=
 =?utf-8?B?YmxVSEsvekN4dzVQMythRlRadDQrbE9YZmhPeXA2eHBlZEJHakVnOCtsZkxY?=
 =?utf-8?B?Z0dVVmROS2dNQlV0ZG1rY0EvanJTd2d5UXBsdGl5cXRvUUN5WklJdFJGUWov?=
 =?utf-8?B?YXVESDkxYTBQS2kxWjJiT3FVMldkTGxPSnRQV0ZlYXZPVmZHZmcwaXc0b0hP?=
 =?utf-8?B?TXQ0QWZMc2Fsc3hId0dhY1ZKQSswQTZLYWJVZXh3S3RKSCs0emk2Nm5OTHNv?=
 =?utf-8?B?ZmIzSnR1ZEhhM2l2UU9rd0pNanRUWkxMcWRQTzRwclNHOFZYNkk5S0RFWHpp?=
 =?utf-8?B?cEVuWDlxZlJvaGR5UVp5dFBvQldLR2F3cmxxM0hTeldMNTRjd1RXNzJTMVFo?=
 =?utf-8?B?ejFMQXBINmp1b2svNjZjejVuQ3BwQUU0RWtOMk5DTDBuZlU3ZGlRaE82UlFE?=
 =?utf-8?B?V2p1czR3ais3eHRhYUdwRWtCa0U0S0NUQjdBSm80a1dPYkFpeWQ3LzVlejN0?=
 =?utf-8?B?T2lqZmtCbi8waC9rMTBQTU9LQWlJQmlNNFJrRGFYY3hPNFA2aEl6d3NGT1JS?=
 =?utf-8?B?ZkQ2bjFsTHFQcnZwaERjSmVseDd2elJoWWFPYzl4SEpVVTVUREZ4TmtnbVox?=
 =?utf-8?B?UHNlODVBdnJZNEJCY1FVVHJzN1kvNCtKRFpwUE54dUtyOEJGTjNqU0NUd1RQ?=
 =?utf-8?B?RnVZRy96d3JyMWkrd0NMWGtYTFYxMXNFcE5jbjYxK2RSWVhxSDhGN2FSalVM?=
 =?utf-8?B?RXRJUjVVcVJaUm1UN0lJR0trbjFkRVBiT0ZFRFZ2WG1MQnF1UDl6TDJVcS9x?=
 =?utf-8?B?V2VKSC9xNVo3MHRuVk1OK3d2WUJ6NjNJL0JiZmlieUtOQ29IbExlL1lkald6?=
 =?utf-8?B?SkcvVE0xV3NBM3k1VHFWT3F6ZGJDeUtGT1U5QzFSTzAyR1l5WEhxcVQrTUNm?=
 =?utf-8?B?VDBvS25WWU5oeWJPZE4wSTZHM1NoS3dRbys5YkUxSTVqdU5Pb0c0QVFLaVdU?=
 =?utf-8?B?MHJTczZucmxaUmpQR0dqYjVYREVseTFDZWNTdjRTVHU3Yjl4YVhVQUk0clFH?=
 =?utf-8?B?Z3ZWYWJ3cWozZ1preXhzNzJsSXcycjNZTGlBZzJBVWFsN3RTRTd5ZlgxRGJy?=
 =?utf-8?B?eldkeUNyWEhsTDhHOStOZ090bkdSV3dqNjZkT2FOTURiT0UyMTV0ek1VRU5q?=
 =?utf-8?B?ck9RelJMcEFNT21abkNFd3lJemRWNGZNVGNXbkRCaDEvUU8rRU9XQmJNY3Jw?=
 =?utf-8?B?YnpQTGJES1V4RHdOTjQvZVc3TzhXTGVhd2g0enFZZFRMN25GTUhwS3NPaEVL?=
 =?utf-8?B?Rlk2TTA5MXhBUm1JNjJaWTN3L0M4RDRIOTR4WVBjeTNyNkJFNlpnRzBodzVG?=
 =?utf-8?B?cFp3VUt5Qm9USjl6bk9ia0Y2Rng3Q3l6ZXdYZWJETHZIUDhlWTZ3dzE3M3Jm?=
 =?utf-8?B?di9DeGQxQkZrcWIvWFlTdmVnL0prbThuVGc2cnBmRXdKaFk5Z2cyOW9JU2ZY?=
 =?utf-8?B?bHNBaWd1MjNVSkx5OUNycVZNQ2VhNXEwRXYwRFk1YzhrVm5jclhyS0gxaTA5?=
 =?utf-8?B?VDNGc0hDaktKUGR4SGNSeEZ3VkpuNmVhYUNjQ0U3L01HSzU2SFdTdkdIaFF0?=
 =?utf-8?B?bkd1aDFZaFBFQWtacTNVdEx5OHkrZ3ZGc3BKejlJamg3dXdkMEw0K2ZiS3p3?=
 =?utf-8?B?TndsRlRqVXZwc0lHK0FJUE5kbEJaVGZDUFdRQzE3UGF0MVFXdTZKQkFNQVVY?=
 =?utf-8?B?OUJSamV6RVQranp5SFJuSFk3dUFpZkZucWRtQ0F3b3hFNVk2NUI3aks0MUNM?=
 =?utf-8?B?Qm5qU1VlbFMrajh1cEJ6MkV4YW1TNnhJN2lBYXQ0eEQ2MkpaZTRsVVRYNGZX?=
 =?utf-8?B?cCttMTNETWdJSjgveE9XbnBBaURlNklLL1MwdjBXVjFYampWMzRRUTZiUmx6?=
 =?utf-8?B?c3RJd3JleU5nYUJaMWdsSkRuT2htbURJaEN1UkowcHV6cnlld051SVVDK29s?=
 =?utf-8?Q?4/GJRa8t1EEAMrpqFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb44c62-9184-4be2-6fef-08dee10d2054
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:32:42.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPyVPKdOG2vuuLn2pWV59MQIe7A8jgdxJHYS9b/z2weNWz2XTaJyJLiI/HFGGCKeXPrwQwwTpz+9nLn3KcHPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> Add CPU feature detection for Secure AVIC. The Secure AVIC feature
> provides hardware acceleration for performance sensitive APIC accesses
> and support for managing guest-owned APIC state for the SEV-SNP guests.
> 
> Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 35a2a0f9ab32..d538db618f24 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -457,6 +457,7 @@
>  #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
>  #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
>  #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
> +#define X86_FEATURE_SNP_SECURE_AVIC	(19*32+26) /* SEV-SNP Secure AVIC */
>  #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
>  #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
>  #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */

