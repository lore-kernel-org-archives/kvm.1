Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721884DAFAF;
	Thu, 17 Sep 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657652; cv=fail; b=A3BwijboJvbXq5bRcDMZWcz19ihHMjKlw9IiXxLHaDnDAKhwJPK8n/qaBUUymuiga6QKDOIX1j+u+DMgjMLJI0DW+8mPoDqKfQNKo7BGuhvYQ+Nx6IWQi0S3NvbfomST5jozrEzYL2ELaPM/7bfYXIYHwzdK8sHaUdsGoVhSuRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657652; c=relaxed/simple;
	bh=wWhzsXREqdbIyjW5Cv+fHRGS3bdYtHWvAzR6F4HXq7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pN3inDzjcqWk7g7E/8aEWtj957dZkXnppzsRtToDIjW3G5DHJHxlCzhL4AcyKLHIfiL8Glt/PUjEhtD5MftADqE/r1USxseB1MJHvFtJ5bqi/FlKXbvBu+k0FtScp751sV4W4iguRzE47ouvGnQiCkO/BSg5wB4NHsBXa2L8WGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3GFXhqU; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3GFXhqU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4c0De8svsJ9VJQhu8CIFoK7v+b6ikuuD781fi/J+TYwcn7i7EJI1Zh88ZlSXnwyA/3nlBVHL5Op3kq/5irLV1SuGzQ6Q2wz9G3AA0v0PriAeuaIBZiuwX1gHOTtShrb+GOs0+LA6ZJKvzuzMYXXGJfOP8kz5pchdsyx2b825+5ZY/wVLArmd2SuNNa0YdlfcdtiIvQKdVXbyLTLeyUbNVOwH87Jr6a1v1/id6o+uDEdd7ygWBG6CO5kmjSPTR0xwfgGODPpL6M9iekaxwEZzSKXSiZKuf8viJj767IARNWDPof5yaPTlAKmWY1md1v8ydZinRL25UuOvUHkECq1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBb1fWZqqfFLdhp5HARen2yheC+AgnpuTMPQ0le8S2c=;
 b=lbzqsZBszG+opVP+E/1UaKpzJe8Y7y1SLCrEM9UqjzHGg8fJ9DwS3rFW/cKBOWFrAdeIPggOshWUsL//gHEhom+ogbvO25FmHGzw96EusyExUJbrXShNRvULFUudktMFNnWVPrwaNobTy4yuO/a3PySaMI7qAedqxF+J28BL9sRnOd7zj2CrdyLq7/xtcJY/lcHFTLd5+qK0cwmaaVXCRwZjTiOaoKb/LWz4c+tx4a1xc3disKSBhU4R6BpqjhXlZu+OUhC4YQXlRot37Ld2AJCxLXbFszbsjx3KIZLEdroKdNksi4RxQnr6K0ZSTJWq4Q1RVLsSrj6hx2+VRNwGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBb1fWZqqfFLdhp5HARen2yheC+AgnpuTMPQ0le8S2c=;
 b=F3GFXhqU6r0OvteX+60UZWeEGuxQDKteACgIPS+3lTlXJmY5eiXyKjV80dC6i278XEHl0eQEFq2O1EEGhIWVItnHju3mi1xrYzPXJ/McE945HoEEmXJMhP5l7ARCktxvX67FOrs2DDfh4ktY1klFGHdanjmMUCJGdQCOYQSLCuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 15:07:14 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:07:13 +0000
Message-ID: <01f461a3-ddca-4f65-b42e-8835e6f25401@amd.com>
Date: Thu, 17 Sep 2026 11:07:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: SVM: Add host support for Enhanced SMT
 Protection
To: Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
 ashish.kalra@amd.com
References: <cover.1789399214.git.prsampat@amd.com>
 <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
 <20260916195613.GDaqr0XWezJuGjxtgI@fat_crate.local>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <20260916195613.GDaqr0XWezJuGjxtgI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:610:e7::30) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4d254f-c453-47bc-afe1-08df14cd5ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2OWdITrBILUWnyG1VICrmOyLOGPGhu6KWC2M1XPTUPLgucpQyY7t+3iZlhQ4y7V2qhsMr1H2ssKHiD7L7Ae+jFMWqHIBHX9Hy44+ivSOFgIN24d1LuZe6qP2n8AsKuvMAReFOP0B06xhUpfOTdZ3C/6j0YmQPZqHwiFFF4cWX/oqlN6KHYAd3oEVn6XiVYeixuXbKTjoYk6Qhoiqt2xXbwR0kkOo2gjXHe2MiY6BOKNzv0WKanZneu29zPaKl06kdOzq5k7dJ+hzn16eB6ZyAK+D4ARqDXp1j8yU4RyyrcspDM395MNBeflhbTrwWErOAwB/1UChk+oc12ULD07kVD2yTEygEOyGsqD6MTwRmMmZYXnU8YyXI6KTaaVsg9Q/2lfTum5tXfFP8mfuFFffRvXW9IMMbI0yedXMwjoHO838wVUWdLhAOEp14RzrrLePNIlhVQyxZr6ucbm555dpDcQKse3Z0k1neZ9HH7dNNyC0gKY9vHssY3zK2oZxsRefK6h8WdhF5ncJ5939sR6pYtfnnhR6UiH+HyE5iqcqNSxUKC0bY8KI4L2hs0fy+lSylKad+B8+eV6x+pyPC2JzsAHmjIocRHuFMo7s1fzsVCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2o0akNGaG1KZmZpSFZxaWpVWXcyK3VmVyt0TjNJRmpUZmIvWVp5bFBFSVBB?=
 =?utf-8?B?dWd6cEJIMkJXRGN3Zm9DUW5BL0lkV2ZoVjRsZFJXSm12eUFLWHArYjZqVDZ5?=
 =?utf-8?B?Qk5ObDByd0xNMVF1SkZvN2tuWFJidkJBZEtxeVorckVoWVR5bUdRckZKbTI1?=
 =?utf-8?B?U0xrVXJDMzNOMUdTNWw4bnRrQTlZeXBWSW4wdkdyNDgrMGt6Zk9lZFcvNjBa?=
 =?utf-8?B?RThreDB1aDJhbXJkNmNaRHpJcXNaRHA2Z3pKUmIzZWljS0YyOFNGMUZZUkF5?=
 =?utf-8?B?dThEYTRkK1oxTEhPWGxrUVdkMUFwY0tHbERnaGlZZi80eCtMVzd3UzMxcDRS?=
 =?utf-8?B?SkdFVCtOcmtLU2dHMnpOcUxoWGZuUTg5elFIcnk0Q0FPVVNlOEV4NFIyQzlJ?=
 =?utf-8?B?TktFaEtENzJwbE9hK1QvTnVuTURnblpHYzZqUjh3SE5TME0vWmVPL2hXRnpw?=
 =?utf-8?B?RmNtbkVsY2lLTlhMcWJCMlcxQVFmanRNaGF4YzFxd2VGN0ttTndZb014MG9R?=
 =?utf-8?B?Q0IzYm1ZU1p1OUx1S0F2bXcyZ1JYblNhOWpIZUhudXZSbnlGTnRpcVBXalpF?=
 =?utf-8?B?eUUyVjhPcEFTL0VsY1VkUmZHVm9QTGV5emVxVzNvbi9LOUYxajdzcU5FWS8r?=
 =?utf-8?B?YnF3aXphVDdCSk43SEE0M3dCV05nUDBka3p5bmZOb0xTMDgzcmpoeGNqN0dy?=
 =?utf-8?B?bE8yUlhsVWlOWlZIRGlwdVpXQitFZ2pHZFJvRm5pNEo2RDQ4dmI1eFlQOWx4?=
 =?utf-8?B?ZDg4TWVpS1gwVWwyNUR6bUVaMXVnRG83TVZnMGJEa1RSYVFBbkRpRHFmczRG?=
 =?utf-8?B?ZEh0K216NGovRlNrYU4rVS9ZRFFXdVYxeFBwelIyeHJaTjV1TmNQUkNSdCti?=
 =?utf-8?B?QnZvSU1IS1lUOWdjYkdVTjc2bU15aE4yaHBqUi9wS0NtV2dkZEZ3S2RUczF2?=
 =?utf-8?B?Q0w4QlVrQnhhUnNsV0dvWFM1bEY4UkNUR3lxS1BrU05xV3BxUVB4aUlPbjFv?=
 =?utf-8?B?eHhCcTJxanE5RmNMN2lza0JQeUlHSFp4ZzdLeGMrTklEbDM4a0NnODRFZ1oy?=
 =?utf-8?B?M01PK1RCWG1TVjdnUUpYY0hENTE4YXV3ZWtPeG13aFVmbzhtZGk4Q1hUdXlJ?=
 =?utf-8?B?bFJ3Z0srZi9IMlR1M0VxWFdDb1lVYzdES3lvRHR5TnhvUlpkVzZNMjRRSHJR?=
 =?utf-8?B?OHBBL2hTLytJWmszci9PWDdHN1E1eUpRbG9HK0J5czBkc1ZkZzV2TU1vOVB5?=
 =?utf-8?B?MTQvVCsvS25kQWhhRG9waTl3TVNVcnBmN3NoUklJM2JPaXBMamsyNGFyYjlZ?=
 =?utf-8?B?SEdoTlMrTTZhd0d3Vm9tY3o5TjdWV0owb3VWYzlvdSt6VGptaTh1cjY4bjhz?=
 =?utf-8?B?dHh1VHluRkgxblFZOGVoTmpMbWRtMlFINmNpM0RhY1B1R0tLTkl3L3V1Wm9n?=
 =?utf-8?B?MjNBajZtcm9OYzhGVEFzdk5aZUo4OVczTWlVbkFqRDgvQVd1L0k1cnY1R2tR?=
 =?utf-8?B?MEYxUi9tSHVqT2Urald4Zlp2VTJGVDN1U2hTYmhPSk1TdmRXSTBjTXNTMkdk?=
 =?utf-8?B?UzFwbE9qQ3hzR3BkK0JpY0RnVVZIQWFtTkJZcmlydGhZOUpaK28zL1lydlRY?=
 =?utf-8?B?MFR5OC9rTXp0Vmt4MldiTDRteThzQzVWKzN1S2ZOSCtrNzYwSE9FOFpzNTd5?=
 =?utf-8?B?K1dHSmZNSTI3dnNRRmwyMHg2Wm85NjZXYm1xS3RrS2dBNGdFMCtybFZ2Q2Y3?=
 =?utf-8?B?Q3ZIK0F6YkhxMTFaRjMvc3FDMVk0bWMxTW9uUGJwd1pPQU5LbG1jcVJCeEJm?=
 =?utf-8?B?M2lBR3BOY1FrK2htaHV2T2xDRGxZcXVlL1BDUndYTDgvTnBTaW9ZZmlGd2pD?=
 =?utf-8?B?L2dOVGs2OWt3ajVIVGppbkFqcERmdlBBdXJwQXBOTE1VYm1DUU54b244WUJx?=
 =?utf-8?B?Y3g4RXplYStiN1d6NmQ5Z1J5ZmltL2FTcXFJUnJXdzFsNlprM1VHNEIzZjRX?=
 =?utf-8?B?SXYrUzY5ZTRPUERIeTQ3T2NjMzYyQjZQeTIwVDlycngxSFpkemlYNWFTVHhZ?=
 =?utf-8?B?Y2xBR0d5QUdxQ2pUYzN0SUNmTTB6WXowY1cvaXNhcjhKWEp5cHN0MEdpc0JJ?=
 =?utf-8?B?dE0rK2hqQUdOaXFRbVdJbEIzL1Jabkp0NkhaL201Yjd0SjRXMmZla0hkT1Mx?=
 =?utf-8?B?WjgrS1BxUStvNEpIalZLZUNDSlJGRnppZGVndlQvUUgvYjk4NnZTcUphY1Ev?=
 =?utf-8?B?ajh6VGNEN3JkbStrM1RNT0licGt6dlpRcDE1Rmc2YjdoSXpXeXkzaE1WU3F3?=
 =?utf-8?Q?imNPiT8uU4nT/w1aUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4d254f-c453-47bc-afe1-08df14cd5ac6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:07:13.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB15HgdfgdFf1a4/Hko53Udwz8GizIv0kmeAJ5WR6Y67qvP84njfsK9EYLmjvqigfyf6Q72AeiCCxVBj5Va2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955



On 9/16/26 3:56 PM, Borislav Petkov wrote:
> On Mon, Sep 14, 2026 at 04:55:55PM +0000, Pratik R. Sampat wrote:
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index f70ee74b5f92..4cf477e95c58 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -529,6 +529,7 @@
>>  						      * and purposes if CLEAR_CPU_BUF_VM is set).
>>  						      */
>>  #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
>> +#define X86_FEATURE_AMD_ESMTP		(21*32+21) /* AMD Enhanced SMT Protection */
> 
> For the non-virt bits like this one and in scattered.c:
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> 

Thanks, Boris!

> And Sashiko has comments:
> 
> https://sashiko.dev/#/patchset/cover.1789399214.git.prsampat%40amd.com
> 
> Please address them: if valid, fix them, if not, explain why they don't need
> to be fixed.

Ack, will do.

Thanks!
--Pratik


