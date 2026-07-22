Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FE3B71B9
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757316; cv=fail; b=c/IefZmueBRfe40h7YIGvRQcY9gTJFVNAOsh3Vwob5y04nKuEORDXVOBiWW8aml794finTva/+O2ut34N2wnp1FjAbEt8YF9c5QWq0hu/jZAbNesKczNOpUc+8E94SNR8swr3vTBo5u7zB9nlruHBWKgIZ7Vu8JcQio0eZrthTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757316; c=relaxed/simple;
	bh=kAfN7O8lP9LkcPrpT+9t4y5LKURu8CKsdhzp5JKbB9g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WtLWJtGWHjsXWXabULIIhpieWkc6PFdh2Xx4I1QuT23JeLk5rAMWyAbHgybgPKEIqw2WtmETrGvjnkKWpQ8QWqKIP05nPlBGG70jo27DFnH7lBdaHto4wAw0AIzAyVYd5jjZzc297eEbd/DYviV6YxYKxlH5zhTF3bg7IcAVoy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkotSe0o; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkotSe0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757314; x=1816293314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kAfN7O8lP9LkcPrpT+9t4y5LKURu8CKsdhzp5JKbB9g=;
  b=GkotSe0oTuKBn4re2eNRoS7nv6xRFDNj/obT66wO4GHQJnlCx98t0SZ+
   tnIqzOZcZhHJWfIHnNBL+/Iy2rfYsKM72nXXJU0Gw/44xq3r8ixXIClqE
   O+xUA59vYwamKCiPec7g4vPwpLaZvqq2bzUGvF2QpSfbrb2N3WbiEL2nj
   Jmw3fv72nXo39yaIwfX+UIG1w6Z8vBAa82xsBYCxjFS7BWEsYplqj6tSg
   tWFa2ZVnEepl6jsrpSqIybXgmqtay+CK+f2NzcdIOIJ5asx1PpIAcL13A
   0QwhkEcF+1f83AjknBTHnQuzETjSG1dqsqh/yLo8PwiGOk7nsoZuFq9rd
   w==;
X-CSE-ConnectionGUID: lNS/6k3YTAmdlbEu/RiIxw==
X-CSE-MsgGUID: yDOCLm2XT6qT1fJNYVYkQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110949180"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="110949180"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:12 -0700
X-CSE-ConnectionGUID: tRoVsrNeTLig+1gJPkYUew==
X-CSE-MsgGUID: dXKjJTvxTvWqdwS9agLWcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="288213043"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJtqjybqBBI7mIwTsbUTWOjJp4dCduyYPRyRsZKECAjkC8FeyTmoSpMoTHj1LxnL+g7AWfMZKKUahJ3KyGKwNZxJIMvG2QOOgnuB20qcttuPoss412aYuw+g4KS6sSfWB46L6K3YPuB2L11cuz4+HgzwR2qT12p+Mz0VER6TZM2fMT7RqZL/2azEdvQO+ebQ892bIby0aXXaeTnyefvqD/x1CtxY09T646R9esgfeM36H7466TGpPCLmiQj1GYFD0/63MgHgwSGm8YQIDkRzs2kQjgg/7X6iW+/dYBoPgWAeWQ6uwtKUldGZDL2iAiluZ6RvSWbkf16p42rFpnkhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSYVBo1+FiNvp0N/jGxD76/WjEygLSpWvDBD8Whaluk=;
 b=E5UIJaPF/wE0Rtnre6i1jY58CEQmhtiWZK9LP8FN65c55lMGiDTAlAQOg4MajvIHIfHaEd2L5/hy0Ql9gCJfmfzg4IPHvTIXUlhBPAURBiB5qMaAGE4mlCSCDwT7oy12ZQWPxwVRfA2MkaHSYIVsEufO+PkUNvi96aDU55LCtnrR2KyXM40H8pxRKMA1eaHZClWngl9anj3QtxMC/b5UHRFLJiTXaG/Ouz0lwGHUQZU28saRNvPU/EvphJniLaMPH2JNVEChXsyWHM5P5rdozeCfjv4f3e4slag5gc2V/3610/H/D8+h+z0EGfjhTDPdO0gtz44CRPmo6qqSwzDjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:09 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:09 +0000
Message-ID: <6bdc1a64-0304-4845-a36c-5f309b0b40e0@intel.com>
Date: Wed, 22 Jul 2026 14:55:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-12-chang.seok.bae@intel.com>
 <20260720181849.6E9711F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181849.6E9711F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dbd321-c91f-4622-6539-08dee83be605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|5023799004|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U/DBk01YqCCcgobvAup03yCJ3Sc2c0jTlaSxwKbbLVS33PESIRrnz/DStaJH/GUQnn7VtYonWxoZoiECuFHyNpEHTVJOY+BD62+ZXGHi0ixzHVyyu7Fi5Sl/Nxx5SZExSdG9/rWeiZFrNUTziuyDYTZwtE7dUbxwy/XAyne1t5qzHhxl4Z+kSanrKHY7hUR5Qvbe1CapyoKsG7zLwctI9Pv51mArLbFUOjIjeqCOyliNrV6Qgbn29+xXPKOfPQBcu9JRTT7QBub2sQqLPOLAqRhjaKwIxU1Bv7F21H5PI/qO3Bc4U8N+8iw/WHmbFPHh09aju2lD74S2ZHF32LmEgFqFDnl56MWd3cWC3/45++NKS7DhsHjrgAgr11a/SLcU/GyDsSJhxWUTzmKyR8Jbn3BLr4CdeIabffknNDKmo7H8NctVWeDJ6KZDCyMjPECM9AZVV9K0vQ/n6YyBsIw55ScJvzSdHh6faHmeFmQ8Fqp/QGsLW+2IMgVbH+ME0pab/f0cbrA8Fcr8ftws4C8BpM5bopHkQwkFmqhi+k+dfLKBpDr1H5ipFZe4izoI1CLersdI9sHlprtvEBzgGyEIPWbESE2mgZsp7vLseoneOvhv1WgAIoDgnqq8kSusesnlci/Zp7bIeUIPxTvEZqmLclgCt0I4GHnulU23+tape70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJGbHBWczV1V3QvaUZCbVNBRjBqaUF3MGxhVjdpV0JuVUNjeXhuaEI3bjhJ?=
 =?utf-8?B?ZUYvUFVrQTNOUkErT252dmdDOTFDUTVpamlZRm1nR1dVVWVmNXBMV1RLOTNP?=
 =?utf-8?B?Y2VoaSs4aWxLMWlaMUNvZDRIVG1HZS8yZy9WNFk4MnpabEJyTnExY01URWlR?=
 =?utf-8?B?TDhEMTlxczBuZnNPTEM1ekRTT0V1SmpyYTB4MTJYNExPbTlzR2RvMDdxY1Iv?=
 =?utf-8?B?R2Q2MnU0RzRrclcvK3RGL1ZEd1I1SEdvSzZUeE1hYTQ4dUpKaG43L2cwMEhm?=
 =?utf-8?B?UjloRmpPL0xGUXQwdFJpdVg4VFdubDRvKzN2Z3I3WTY4ZUF4YVRJdkN0Z0s3?=
 =?utf-8?B?UmZWMkhhdndxWlRQRk91RFM4TUtLNzRxU01QcGxoVW1DelJRc3RIcjhmK1Fx?=
 =?utf-8?B?YkJqRVA2djRwSkROY2wxZ01LU0M2MldlNUM0WUJNVmxxdk1NOFJHZHR4VVpj?=
 =?utf-8?B?N1R1dmplRi83a0xPUjhwcTkxTEowbHFOSFVOTnkyTG9WcnFBUThYTnlqV0Fr?=
 =?utf-8?B?UVdvQ0owTGRzcm1DODE0TXord1RuY0FFMlJ3bEtvWTRkdkUybnZXQkk3L0Fq?=
 =?utf-8?B?UTBOS2FhK2tpOFdxUThKcTEyK0JjaWVkWnpYMm52WWFpMnIwS21jUUpmcjVk?=
 =?utf-8?B?ckNJVWZ5cHJOQ2VFejVHWnlyUkp1MFJNRmVTbGQxc0JKZ0c0ZE1zamZXRHlE?=
 =?utf-8?B?a3Rrd0J5THVWUGk4TEcvN3Y5emI5U29NV0p1MUYxY3hFNWlldUQ3N1hMTGps?=
 =?utf-8?B?M1ZvalF1NzhkTll0UExCUFB0OHlkTmFNWkF5Y0tDTi9RdnRCcXQ4d0V6cDFW?=
 =?utf-8?B?OG03d0pFYWFIVjhtdFhXQ0pQVDhTNHpRZDFlbEI3QVQ3dE93N1RnYUNiNDkw?=
 =?utf-8?B?NVBMSGhsbERCY1ZSMEo0N29BVTRlNzArd0hrbDJKb1NKeEhnSFpQakc2cWt0?=
 =?utf-8?B?bGlZK0dtbEFnaFJzbjdtckhlV292VGpCZ3l3ckFXTUJmaTVFZWpkUG5uemZq?=
 =?utf-8?B?Rm5peFFUcDRlNHVPeFJudmV4TWdlbWNvc2F0THNMeE00ZDl2blpmOHZGOGQ2?=
 =?utf-8?B?VEZDclh0TjRQTlNMdnEvdHoxcEw4WDI0VXU4TGRxNlh1NjMvN1BsNWl4ZUpD?=
 =?utf-8?B?NFQvZkh0OWNuTE9yMHE2a2JmZjlzSkJiWmk1cmU2aFQ5MXJoOTR3ajJ0ekZH?=
 =?utf-8?B?WDdvUlZ4ZFFOd1pmRUhqd3RSNUIxUENDYnA5amN3RUwzZFBNL2hqTTdMVDBS?=
 =?utf-8?B?VWMyc0x3RzU3TUkwMGdlNW04MkQwQXoxQnNFRTRWT1J0VWVvMzFCazJPREE5?=
 =?utf-8?B?YmFTSG1sbVhtSUdOMHFBZ2tscjJhR3B1R1BxeSt6YjVNNlIyQ0ZUbFhhbEJZ?=
 =?utf-8?B?NVdGdEtqcUplR2lDKzhHSWRJRDlrUjZrMG9vcStBcWVYTlVsS2FjU3VtYjVD?=
 =?utf-8?B?alh6L0NPNzc1ZUpwVTd3QUZ1a3ZEbEhHQ09FcTVhdWEwblYxNHhFcE9POU91?=
 =?utf-8?B?Y1FuTE1pajZmMU9qNm1sRXVCWVhGdXpzSmZadkttMkxsVHVHN1g2NUc1VmZX?=
 =?utf-8?B?Um0ySzRrMW82enl5QkdsL3FYbzdXMDVuc1gxbDdaaUZJa0dlTUhBLzkwKy9R?=
 =?utf-8?B?SXRtWUNvSjR6YWpuZFVjV01pclMzeENod0xwNHpFNzI4ZVB3RVByZFRzTFFx?=
 =?utf-8?B?dnZ6L3FhY2ZlRVpPK0V5K1JnbFM5UnlycVlHWTZpR2YxS2ZjbjRwVVcvM3pm?=
 =?utf-8?B?cDl0TktJeHpLRHNCOTJQdmNvVkZkM3hIQ2JwQ0RQWHFtVHA5OExmWStsSFA1?=
 =?utf-8?B?U0tHQlZrS1hiSWJQVENRMTVxM014R1RoUHJXcDA2Z1g5UjZwbzJMYTk1MElY?=
 =?utf-8?B?VmhxcEN2SVlkVjlRWXJLY05VZUtMa3RNQTVpM2Vla1VLNFp3aHlNWGk4RXpD?=
 =?utf-8?B?S25uckNXQTJaOXE4Y1J0bHppK2kzQm4zTHdlUkcrR1hVL2lyalUrdEJ3RU9Y?=
 =?utf-8?B?em5FT0lKMEJvVEdSVyt0TDhMM2JwMFl1SXBac24zSHBrdEl3MWw0VDQ1VWhU?=
 =?utf-8?B?T1ZMb1Q4NDJ5ZjRDaVQ2a081QnkreGFYL3pSWTdPdVhLaW1JenVwamc0SGV2?=
 =?utf-8?B?VVgxbSs2KytNb2U4SmJpZGR1U2l2TFg0M2k2UzFWTGFGRzlYS1g4WjYxaGw0?=
 =?utf-8?B?cm5SMVdhczhCakkvTjI4OE5mVVNnb2hGajdYVUM4c1pjVkdPWEFXVEFWQis3?=
 =?utf-8?B?K3h6dytiSHBxeUtnRGhMU1hGUmNzcFBKaDZNejlWWGRiWCs0YkxMSklLSUhU?=
 =?utf-8?B?b0V2YldZZWRJMEJXaVg2MTRsNkdRM3VVSFQ3OXJzTFpaaWtMZ1dOUT09?=
X-Exchange-RoutingPolicyChecked: okbrgKb5euA0vj281Xz5wb6zqbUXU4IcDoN2yGkzNHWpY+UfLrNwIXZfiU2wXMOr8wno4McLTH8f3jB0w0w6RDgBbIeAKOfpyySB9U8dQBqbdtx4zhNjfNYCepSoNQwD3MKKN9meH0raA4X3+8WH/dXFM60IWaAbBSZyL2nk17R9BbBCO8vDqpWGxfa4pXHSlGmR9HbIa46Anrz5t6BbGc6QkWZ5t9ms/08RYEOVw9ODdtODJdbIDiHwtH2kOdSJL3ys47tfPBf9ctVkrg1iB/tY7g599Trq+dtg+cURoqSwAKXZfHqJFQZI5YcWCnSeLZodMWqQb0nRWqWKtrk/zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dbd321-c91f-4622-6539-08dee83be605
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:09.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF0xVYzUrX4WXKvTb77J+8Utk3UBAJYBFyL8CSOAl6t/VuaSDvVAHSMD+r9Mdie+8/4dJ7AiWbxSqoos9paTgC1v7tVhM5dR8QXHVyLVAOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:18 AM, sashiko-bot@kernel.org wrote:
>> @@ -1118,7 +1129,7 @@ static void decode_register_operand(struct x86_emulate_ctxt *ctxt,
>>   	if (ctxt->d & ModRM)
>>   		reg = ctxt->modrm_reg;
>>   	else
>> -		reg = (ctxt->b & 7) | (ctxt->rex_bits & REX_B ? 8 : 0);
>> +		reg = (ctxt->b & 7) | rex_get_rxb(ctxt->rex_bits, REX_B);
>>   
>>   	__decode_register_operand(ctxt, op, reg);
> 
> [Severity: Critical]
> Can this extended register index cause a host kernel panic?

APX does not extend legacy VEX instructions; EGPR access through vector 
instructions requires EVEX encoding. Since patch13 explicitly rejects 
EVEX instructions, this path cannot expose EGPR accesses through VEX 
instructions.

>> @@ -1137,9 +1148,9 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
>>   	int rc = X86EMUL_CONTINUE;
>>   	ulong modrm_ea = 0;
>>   
>> -	ctxt->modrm_reg = (ctxt->rex_bits & REX_R ? 8 : 0);
>> -	index_reg = (ctxt->rex_bits & REX_X ? 8 : 0);
>> -	base_reg = (ctxt->rex_bits & REX_B ? 8 : 0);
>> +	ctxt->modrm_reg = rex_get_rxb(ctxt->rex_bits, REX_R);
>> +	index_reg       = rex_get_rxb(ctxt->rex_bits, REX_X);
>> +	base_reg        = rex_get_rxb(ctxt->rex_bits, REX_B);
> 
> [Severity: High]
> This is a pre-existing issue, but does this logic calculate an incorrect
> effective address when the SIB index is 4 and REX.X (or REX2.X4) is set?
> 
> According to the Intel SDM (Vol 2A), when the SIB index field is 100b
> (indicating no index register), the REX.X bit must be ignored.
> 
> However, KVM initializes index_reg with the REX.X bit (value 8, or up to 24
> with REX2). When OR'd with the SIB index of 4 later in decode_modrm(),
> index_reg becomes 12 (or 28).
> 
> KVM then checks:
>      if (index_reg != 4)
>          modrm_ea += reg_read(ctxt, index_reg) << scale;
> 
> Since 12 != 4, wouldn't KVM mistakenly read r12 and add it to the effective
> address, causing it to read or write incorrect MMIO devices or memory?

I think this is referring to SDM Vol. 2A, "Table 2-5. Special Cases of 
REX Encodings". The "no index register" case applies only when the 
encoded index field is 100b without extension. When the REX/REX2 
extension bit is set, the full index becomes 1100b (R12) or 11100b (R28 
for REX2), both of which are valid index registers. In other words, the 
extension bits intentionally distinguish RSP from R12 (and likewise for 
REX2), so this behavior is expected.

>> +	/*
>> +	 * Instructions marked with NoRex2 ignore a legacy REX prefix, but #UD
>> +	 * should be raised when prefixed with REX2.
>> +	 */
>> +	if (opcode.flags & NoRex2 && ctxt->rex_prefix == REX2_PREFIX)
>> +		opcode.flags = Undefined;
> 
> [Severity: High]
> Does this check fail to inject #UD for numerous REX2-incompatible opcodes?
> 
> This check evaluates the NoRex2 flag immediately after reading the first opcode
> byte, before the GroupMask evaluation loop.
> 
> If the opcode is a group descriptor (e.g. group5 in opcode_table), it does
> not have the NoRex2 flag set. The group is resolved later, bypassing this #UD
> check entirely. As a result, REX2-incompatible instructions inside groups like
> far calls and far jumps cannot be properly trapped.
> 
> Additionally, ModR/M-less implicit instructions like hlt, cli, and sti appear
> to be missing the NoRex2 flag entirely in opcode_table.
> 
> Will this structural flaw allow guests to bypass #UD injection for these
> instructions?

The APX specification explicitly defines which legacy opcode ranges 
become reserved under REX2 and trigger #UD when prefixed with REX2:

  * Legacy map 0: rows 0x4*, 0x7*, 0xA*, 0xE*
  * Legacy map 1: rows 0x3*, 0x8*

This patch marks precisely those opcodes. Group opcodes are 
intentionally not covered because the specification does not classify 
them as REX2-reserved specifically. This implementation therefore 
follows this specification rather than attempting broader filtering.

Thanks,
Chang
