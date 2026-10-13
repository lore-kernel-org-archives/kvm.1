Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CB2DC32E;
	Tue, 13 Oct 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901846; cv=fail; b=rMRRkKDTnqe94B/AomZyMvZkO2lMbwcp1d0H4fKaRHDF3cd32hriJERZAfqsH1DaATPols0PrS56GN/HTpCd2cmg1LUw3+Niwe563XCZFhnPKXS5ztnzJ8voclPRK5kuw83+Bapa5YLl/nYDAlW02zQVcX8VUqi2OnrE4fP2iQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901846; c=relaxed/simple;
	bh=SMUuzUeVF+97DhTkAKm5FzXpXtsahIGhl21cIevWioM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnNu5nhFopiRFtHOnGx2fqKzlaPj2OEQALs0D6Trkz+6fuqqlzel4I3t7tqhK0GCxwZnvbHl44leGPUFOd+gBDt75p6RqUK0EeZK3JVy6yA1hkQchBctiPE9a8S2hyLgwttVSxOolM2btiT8eOpNGr8aGx7bm4uWu+MMRZxgmcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCUmIIUA; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCUmIIUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMk2/qgRY4K/lYLvfEs3nyzSK8T5Ww/VvqVLK/1SZFmqfrDkBABM3To0h4t2bKXT7Sc3sVDp6LcfwuPDOEstfdIcIXAStFUf5pSeD6yYAjPCB9zCirw5dm201GmVnP6w7mQxIzCqEAF2R5E4AWaxZucHseAkQN43I8EbnKHzdHiEoaRo/WJH37JNHqgcEBYoc4NST3M+RRtKrrSQ7F74cLmW3wVbfKaOHHcprSHtAINFcIPzEyAZXzfv+Reajoz44urQvTx4phLFVu0HAZME9Rce9rEji3xBcCeJmKQDp5n2/AjM7hNk8v1lL1F1LP71gShfL1iuioUkNbYpkMv5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzZg/RO79YqhzNXGs/puEn75uba5jL83zu64kPjMKm8=;
 b=ra7WtCFVXVzTAW99JZj+dBy7L0WLIyWJiXll56AN+TzWS4CAdhu3bXMziGWrhc+k2cTVSXIUY4Mp3Oc+huWORpEbsYosUO0RG+zznQ99RyTS1onCwHzlQHBnWDG9o2AO4zfpfMIO6a2hUAEk/WQO6hpApCowtxsHmtGbW00uAk+xx10SVd6L5+kVRrg08uV8ohqTOfhzXYC4wEdJRU68EPqTFzIfn6oSthSw/FFHCylN0hsxpaeqTFzOjcMcmFnHAJSFAqT8lvjz78m9LoIZDPZKPqwwjJEU37pdsKKDGSnQ+O6KVaAVVNAd8IlylPNMjRgHrtelmy/xQw2xaAXmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzZg/RO79YqhzNXGs/puEn75uba5jL83zu64kPjMKm8=;
 b=oCUmIIUAa2eY44jiw6tB1O8AJ1+BImY7ckZYzTHSoXWPeWuSLAM68WNj8XT7+BLW69e2BwuTBoRCpyhpPkvtE+8PBTqkaSDESxH6dGVsZgdKSDJhcx3HfSd8TOwZXQyM7+J88wE5ExZrSnfyIXEOzPuGDU510CwH0FY5gULBu9VeaFnl0l+hO4WCrftAyTQ+akLn1AWLDzYnQYyLrh15FmoLM76EOZGmkQKDLzybykot3qH8lq+zdj+EwAS1uDkZ/NlB0mZGGpqv9ldcnzLEg5KoKp9Hj3PorSamPvJ/TDSx3dsbQBuW0ar+MIk2GiLy72zlWKKLVKwjq2ZUWywE+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:30:40 +0000
Received: from BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0]) by BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0%2]) with mapi id 15.21.0451.026; Tue, 13 Oct 2026
 14:30:40 +0000
Message-ID: <0438ee57-0597-43c2-a1e8-810fc82780b0@nvidia.com>
Date: Tue, 13 Oct 2026 10:30:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] vfio/pci: Give drivers control of PCI driver_data
To: Alex Williamson <alex@shazbot.org>
Cc: jgg@nvidia.com, dakr@kernel.org, acourbot@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, jhubbard@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
 <20261010134826.55364f0f@shazbot.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <20261010134826.55364f0f@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To BL3PR12MB6548.namprd12.prod.outlook.com
 (2603:10b6:208:38f::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6548:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 80682d35-c71f-4845-c470-08df29368e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|10067099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xq9pjGrZ4LcYpfvC+dxlYXoFMzgkKHkrVhN8r3ir3SFZva8XX22vEKPfieUxCL3WOxqSQ0Rdtx84C+aFDrktNByDHeGzgYTC/apuROgLhJFBwR8b7RjDHt9uBk6z717sB6IC0QWPh96OvH9cj+WxusofyWwCyJo/Qn+FsjYu3NWlh/RFjXBqrNmowliNzmaIhyCPVRiJE6cPUAeS8MWMJ/U1ccGcTxzt+7o+2oCLZUt2p2kWh5LVCf65MKwn2t2y1pX1i+xKEP1nCTT9qIt9UXZbhCljkBE91iNpDa+K4jyya4FAQusTp3ietxyaUkpZ9+RwI4hqOWjeCTT2OSHyCkcTVtNiIj+NBuNuUKdNgMpiO2zrbKSctkR3NR/yaQqLY2xGKnT9s8hXowd/75cPE0rP5xly5ru60HrJabe3+umua4Ftbw/XOkmWORKu8ARig31gi1DtiNK5S0TkRqpDsCN8M/qWeTnnecqsuX+Kaj7CpPXw1oiQcMmz2AOdoni11FMzDvtlmvD2KoHcEiXMcsHaBo/phuHPn0Dqain/ObnsBGm/2fqQpZyCH3fnU8V8J+f2PrUs9L+r5Om/jD7IdjszjhIFo/WY+s0uAvt3nofr5lWNYZ6kcD4+rOY5w8P1cEuaHf//ELmQX2SVN2hdqWnrG1NYoXNR67Yp8ihEjm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTZZb3k5NXNsQngyMVUvMmM3bUdzTGY4Rnk3K1p2QmwrQ1Fsb3F2RDN6bWND?=
 =?utf-8?B?MkpSdGg5dGVRY3E4UkcyYlU3bHhEUUpEVnM3MWlycmNlZUxiRFlUcXkyVkNI?=
 =?utf-8?B?S3ROM3NEOGpJQ1FCQW10S2UrbnozV21HcjluSUFSTlUxbXVQZzhrRGJRL01z?=
 =?utf-8?B?RGl2Yjd2TGdqODJQTU9NR0xXNXIyMkU5YzM5YmlmakdpTHZBdVpyUTN4OXJh?=
 =?utf-8?B?QjJ2RGZtb2V0bUsxK25zcktxcGU4NEV3OFVPamNmcmljbmVPbVFEdWk2dDhp?=
 =?utf-8?B?dDhCdGNVMGg2T0hYZVdOQ0NYNDdaYytibklkenByM0FlMElLSnlOVU5XNFRm?=
 =?utf-8?B?YXRnYU40SEROUFNabjVpMTlaeTVmQ29hbmgrMDdRZGpjVGxhSTRhSGZHY0Ns?=
 =?utf-8?B?cGVrUUNzbkFrR3pWY1VIUzVPd250d1BzSWJsd0psd1hLdnY2a2dQYmZTT2pw?=
 =?utf-8?B?VHo4OGdNam9rMzJwTXUyRHNlckJ5ZFpUYUdXRGpPaE5YaXJhY1FUQ0lWM2gv?=
 =?utf-8?B?cUFGK0pYbXVMR3RuTGttMXgxSVhCNEFFa2pJNjNYS2xQbVphUTAvdEVxRjEr?=
 =?utf-8?B?WnkyVCtwWExxYlc5NEVNa2lCWVBYNENvWDU4RTB4NTQ0RVZrbEdSYUVEazFK?=
 =?utf-8?B?ckZScE1RWFIyUlBOdTdwYnJ1WEtDZHNlaGlvTWoyVUNvY01FM0xRVEFlYnMx?=
 =?utf-8?B?RlFPeXJsZzJ4Q2xBNi9nSlFkWmg1N2MzdzFMbG5XQ0pIVHBxanVCR2dFZUhr?=
 =?utf-8?B?Z0VBV2gwNmFNL1pJUldlQ2Q1aUpSSUtJQit0U1kwUUUvWmtFcWJ5TWphUUZr?=
 =?utf-8?B?NTJIZXF3YnV5TVpQTDI4V29yYjRBcXdyS0YyeFZBY2k3YnNvR3ZSSnJESG1o?=
 =?utf-8?B?VGJaUEI0M3NSSWxQUm9kTXZ6TDZ1Y0Y1RStwOXFCNEJydW1CQXAvMXVqWlUz?=
 =?utf-8?B?aFB3cnRaYlVvbUhaTWExZ2lZR1VoamRGNTlwSkVtbVRsWGw4YUUzZWFhdkk0?=
 =?utf-8?B?TFQ2bHBySW1JOEo0MzYwRkR5TExRMVRyODRoTy85cSs2RmhFQ08ydmRHbWUv?=
 =?utf-8?B?SFlja3hyeGthWU5BS1c1R3hHeWNrcEtzS2pWZUwrb2J0K0MzejdGSHBGY2xl?=
 =?utf-8?B?MUlGMU5GVkxqVTAzSllnMWVUbTRtUnFnWEpjUFFYUVY0SGRlZ2ZCM1BJeGVq?=
 =?utf-8?B?bVdjT0hrOGF3STBkMTlOL3V4L21YczVITnpsRDV4dUxGZ1lydm9VbDk3dUtK?=
 =?utf-8?B?OUc0ais4aE1Zais5T2hxRnFvN2cyM2R0WEhhSnhKS29wUFRzRWIycnlvZEtW?=
 =?utf-8?B?di9ZSkcwYThsTmVselVSdThrNWtDeG1BV1p3SlppNlBRMlVGVjdHS2lUSFBu?=
 =?utf-8?B?aVExRWIwTUZDcEVNT0QrTWVqMGI3OVA0V25tRWZMcUtOQ2FTUkpzbEU4dGN5?=
 =?utf-8?B?RERvQTRqbUVjSE1KSGlkODVPVTdNL2pxMWJUdkdTT3Jua2s5cm1aNnNoaGdL?=
 =?utf-8?B?TGFmcitDd1dyNGlYTi9FU2FCNjJqUmlEVndkZjBkMWhkTjJ4cTFuR1MyUXBT?=
 =?utf-8?B?VG81cHlWamNLSmtiZnNRL3FobkRUbFpZR244dEZUd0hQT1dOQlJGSXlFVzdk?=
 =?utf-8?B?R29VR1pWWjRSRHhnajdyd2lMUGhocWlWdklYYmtLZ2ptMU1IdU9XK0pCSzBn?=
 =?utf-8?B?Tm5MaC9yZy9tczArVHV0WWxwOW9Wc1FSYU5NcHREeDI5cHFWWEVrZDNTZ3pK?=
 =?utf-8?B?enBwYzY3U3V4NjUyNDRMV3JoNXg1MTU2ZnY5SzlRREFXaDk2U3FYZUowOG1Z?=
 =?utf-8?B?WVVCSTNhVEowTEpLTTE1R0JHb3ZsNFB4R2YrdHQvQ3lpQXdrZHJUVjlCbzVm?=
 =?utf-8?B?SSthcDg4VE9hbVVSVzUrQlhvRU00UEp5TFZmZ0pXYmpFOC8xQVI4MXlWaXBK?=
 =?utf-8?B?dWY1YStmL2RoOVRKSThBK0FaUWJEYXUvNHNJOEFsZzFMV1lobU1qNHdFNFlh?=
 =?utf-8?B?VWN0eVBiQkU1S1IyNHBVK09hK01NeDlqRWFvNkdTY0NSaWxINE5GejByOTI5?=
 =?utf-8?B?elYzYzZ6ek9tTXBPRVBRdmUzZkVqL3FLYzlnNk0xQ3RxSzZrUjd4THJCbU5M?=
 =?utf-8?B?V0FhaWZiTDVEdkRlajVFQzJ0MWZ1VHJYMFltYlBKSzFaY1NDV2h6cVlHOFl4?=
 =?utf-8?B?V2xENWZ5QkpPVzduN3g0WHZyMDlPOE5yaThySVJGTXhtSWgwRU1iZXJWZGlj?=
 =?utf-8?B?eGRPaVhrWlczV0FFcm9qaU9lZEI0Rmh6RHVZUlVnbU55OGRnb2lGRUJhYmxK?=
 =?utf-8?B?Wk9mbnh5RHZlMWpsajR1K05ZeEg3NVF1R2hDV2dzM2V2U3dVeUVJdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80682d35-c71f-4845-c470-08df29368e6c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:30:40.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gt8kN0vIgzwBLVQPVU9VtNDH6zHocSdLsnX4tuLBp3huTXWhAR5gSRdfsvNizy17dCzoxO32VMHIr9WaxnPzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

On 10/10/2026 3:48 PM, Alex Williamson wrote:

> 
> I pulled in Dave's topic/pci-vgaarb-rework-2026-10-01, which gives us
> 93d41424caf7.  The vfio_pci_core_device is now registered with the vga
> client so we no longer need to derive anything from the pci_dev.  This
> makes all the VGA changes here unnecessary.
> 
> Applied to vfio next branch for v7.4 with the VGA chunks (shown in
> the discussion thread) and commit log paragraph describing them dropped.
> Thanks,
> 
> Alex


Hi Alex,

Thanks for applying this and handling the rebase, dropping the VGA change looks good with Dave's change.

Thanks also to Jason and Danilo for the reviews.

Simon
