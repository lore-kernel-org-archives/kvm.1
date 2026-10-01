Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296A499F1D
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886359; cv=fail; b=Gxu+nD/ys5B6Q6wSvCKw1LUFbSJ7XfO9e7NGMsF5YXErlhGnCogJdwvvotdSDj2kPAvk9QJR9o1BEmBYofCQnmUkx09+I37RE9WG9WODGmnEAhy2i9MWmkKqbaQoudf5bAX1kcvwI5m96T/gw+X9YPg0h2mtEmdRxqdc8ghW/Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886359; c=relaxed/simple;
	bh=LN8iNCVrL9vJexYVpvJVy1oPjHBrcVqFZQ1CrEP8Y3g=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAy185tzv+WPRCog29J/i/D+PdtPbNdcxKQBi/GMVMfsItakgAm8JhuKUgm11LhUEe+wlo2OC6ImORZHGEHyG3+NPMhuRf5k/DU5zZ6tHVxk4XZ37KJHc+AXNjFUujVlVvJs2xGz3TKcUVajyYAEoUF+Kw3dGYK8+iHXu/2z2MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT+9exVL; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT+9exVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886356; x=1822422356;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LN8iNCVrL9vJexYVpvJVy1oPjHBrcVqFZQ1CrEP8Y3g=;
  b=LT+9exVLQLUXRPfiZAkFx8Y7cGB416aDhJGAU5TSsKyIR+LqHStc4miK
   aen+fSK1EEd3MUwhNOUBKLBlAN5teRTcY5teFLRBTsY0SpoIacF7x7f5u
   zuG/cfvmVv8HEuJDlxZyssH3g4whRz6st/1FULvbJrGDrRF2WlH50r+yi
   pW1TlQHIHrjxDONJ05SCEcadsQE+YnVS7uae6p63SrlBjWL0iYUQsoPL5
   Xgs+SXoB+yDfLuBImEpbAdmS0pPvgtSHeTYGb5XJSItEqW0jCHm7Vx9vs
   FHF4gK+iiPK8XbFD/Mj+E/EoK1rvvrTR73/LPjO+VEU4WxFbx0U9WhBJS
   A==;
X-CSE-ConnectionGUID: b3unxjy1RDG34GXLiJLoqg==
X-CSE-MsgGUID: iFhr9IgISHiO/+FNEEzK3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102232046"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102232046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:25:56 -0700
X-CSE-ConnectionGUID: AG1t0gGBQIiRzd7gcTORhA==
X-CSE-MsgGUID: f4WI2Z9qRs2cx5gwTEjPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="280830601"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:25:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:25:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 13:25:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwrBxCWMb1tAgc8UpAvfOmRzo7jO6XO4+mE+vp9kXh7TmlU0TXnEuWmloA3t5cfdyHg7U1TOUtokFPxubLSwtM/mdTi8Yz2tCxGz17+nQVfPHtjdy2mPQbe6tRemUcPS7ScxeXUiqXquYsaCnJ9kGyye0bT1VsaUZoeSJxcxEDOo7gOtAxYbc3bnnUi8oOq12SlCghWQXcO66ro8Vxy/5gSiF2jSb8uL9SJ3OvqI9ehRm4sRrtTsdsCQsHpMAwO2Vz3pAzbTY8hk/l264hFmAgWwLdTQAvoM/YcAx8Os8D51YeFJ7T/GDb3QD2JzkVwxBYH75Rh9WJ3kjzD0fhVTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfn7rvR/MqaUSCf9Ju+VxXyHaDSnaeAqxMop+l2l5Qk=;
 b=Mc4zsFxkciCjoV9zH2aInVKzPWtn/5uJF6FB6Y1XS88zGwYRMIuiM7MPT8rD66ww/ULkoeA+6nxnWK679t8CMKPv7zNdFlFSe4DYbRJy5ZpFllzITOiEBVyRk7KSG4FBmePaUQf7uveo3jMGwFduzEg41jCLDbnbgzW5x2IOfnhj7D9YmaCfFaPYevkTusLjKu8DEzTa0e3aReeO4xQvXGwsRNHyYoyIPCm/hLv4S4DpbmFHQL70Vtu5juFiwgzkeirIR8mSVQb8C9ji3dbWpy5qY+SmRt/ph+op+TexHbfxSaZYchV2ud/xJn1IxyokyZEqQhIGxdq6/MxDc/xgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVXPR11MB9708.namprd11.prod.outlook.com (2603:10b6:408:388::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 1 Oct 2026 20:25:37 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 20:25:37 +0000
Message-ID: <0a3be348-fe88-4f6e-a2b4-c5cfcc9602b1@intel.com>
Date: Thu, 1 Oct 2026 19:58:43 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 09/20] KVM: nVMX: Propagate extended instruction
 information
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-10-chang.seok.bae@intel.com>
 <20260930215254.DC6D61F000FF@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260930215254.DC6D61F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVXPR11MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2058b12d-f808-47c1-3a9b-08df1ffa2732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|3023799007|56012099006|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 58YJEUf/h9nMTmlxzZnWJT39h9ddgpHxHP21WtbaFGVisVEvhoo++RXUrgBvPcAMacrGZAy2Os/nygm7hYDEbuYpchy4/Fx74egRq9HrzbsQCo85z6LM3/HbjPzKyvydYoLsoxux1Bv5N8kciaHU3UnwyiWI/lmLtErqDCNG8SaDX1Lq2/KLthujhA6z+cBmcihL0O2dmmYJ2ZmlDatRJOrKuH5IDkpTWXrSjLLZ7UHtQK5yjPqevd0E5oTQ4ukBqQ/JwrW1GLxvn8a7Wij5Go2XPFxSrKVw3tkK/XNj20FzmkoGO54AU0Eg/pFdRMuZyIS70MbqqAS1Da26wvX+ggMhSvvN/TO4yvMxHEvtwg63CIYr1avMyN6DMsYs9FX56qPCtdsSIf2GQXvrRD4uDs2tMX7RbWwM6+w0LemY/0WPc3ErHz3LJVcrbuxQ1PED0k9SmPlvDrHFvrXxVXBie47tFnRhaavn7+qemX2tZjp88kaAycLXXqQNWPt8J8/QmGaIISNWoVpAaw3xh6WsSl+N5dpthJIGCDYDmQwTyEyofXNiKKKBwj9EmmzWPlHjthsg38yKCMSA7priIFPl75B3sStBeYbtcJPqjAhkSy2hHqEhcyQUYNkWdi4PsDLgYCM1zMnxiAqIzptkJoiwY6k77efIu2WW7+59Z0UChUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldSUU93VTM4cHVlUHhiZGMwbHR3VGxNRzlRbEViN3ROUHZxR0pGQXV0YWpZ?=
 =?utf-8?B?MWMrb2tzcktac01BMHF2VnZjc3pVR0VqdDNGem4yQkF6TzZEaEpKUmNwczBW?=
 =?utf-8?B?VC9wenBCNTdkcUdLTTh1UWFzNEthcVpENUNINFRCb0FBZU5OSERBbmhtMU00?=
 =?utf-8?B?eVVvNDFsUnVyNklrQUc1aVJWd1BBam50Vlduek5pRzJyOWM4eTFHNVR6OUdr?=
 =?utf-8?B?SzRxSk1HU0lkOHZCS0g5aHdDWFZ1ZTgwZGpISktCNVp2NXRQeU5YTGQvVGYr?=
 =?utf-8?B?UzZ5dU96S1pYQWxWOVk5V3AxVXdPM28wY3VXRGRRWnFWMFpJQ1Q4SWczWDR2?=
 =?utf-8?B?UE5YbWduNW1FZGdpeXhVclR1YXZqTExsZVNueW13blVmRmZSZVpVYXBwbStq?=
 =?utf-8?B?ODhGMFQ3UXZ2S0lpS1ZsZmpqRXZXQklnRmlSMTJQWUpmdm9GUmFGaFdkZnhH?=
 =?utf-8?B?aXEvVmhFNVhJS2VrbjEyTjZMZjloSjdTd2FWekVlcVhoM09mNFZwSUtPaFhq?=
 =?utf-8?B?VGJqNFIva25ETnNwUEkwK3lqM21PeWYyVUlQQjVDL1R2cmY0dEhQODFQeWFz?=
 =?utf-8?B?eHB2VE53TU5taklqK3d6d3gyTzR4MEI5K1lxTjJzaUtsSldtVE5ZdTlZeGph?=
 =?utf-8?B?VGxlb0p5TFNQSEo5aWRUdEIwQUlMaFV3SWNQbEtTV1lXeHBBMU9ZNjUzMjNQ?=
 =?utf-8?B?Mm9GNUQxcjN5L3NIN1gvS0pIMWZUZng1aml1MC9EdWVGOGpPTEptZStVN2ln?=
 =?utf-8?B?b1FNQzRLaFVoaEtvTHZ3VXFNN1BFUk9YdlpJZlRVQUlVMUoxZXBmSVpIN0Vs?=
 =?utf-8?B?eTJpWFB4aHZQRVpTeGcydnoxbGVneHYzM1NqMUJEbUVDTDVMUEpuR1d0RUxa?=
 =?utf-8?B?bktrd2RGcG14WGQwRFJoTVdTMDRzdnFQTU9ZR1pBNm1FN09NZnY4RHp3S2tD?=
 =?utf-8?B?MTN0c2lNM0h3Mmd0cnlZWTFVREk5WVd5S0xZYVdiaVBYT2diNHVsS0Z0NkZl?=
 =?utf-8?B?V0V1ZS9tcVJBendqUmFLamFrQ01LeHB3YVlHVTErRUlLUFYxdVZpNGl6dS92?=
 =?utf-8?B?WStPa2psNmJIN1dWV3Yyand3WW1NZlFWaTFUV3JxbFAwVzgxakgvWlRuNXVv?=
 =?utf-8?B?UHI0SjhSNXU4dmsyM1lHeFAweEhWaGdUS1paNjVGWkg5Zk1mK2JxK0duS0s4?=
 =?utf-8?B?N0ErZGZWRkxhR3JINVpKWWNVS2gxb08vK2VHYnFnclpyVE9KSmxyTDFnQ3lY?=
 =?utf-8?B?VUViN3duSTN2QXlBb01ueWRSNE5QZVl4aFY4U1dQK3hOSmZrSzhOR0JRcU9O?=
 =?utf-8?B?MHNyT1hBaGtBL3JYQlVka3V2eXdyWWRCWUROQkdIVTdIMmdMbmJaNGJBenJr?=
 =?utf-8?B?MFBQSkF4TEhhb1pPT3N5RjZFczVIc1lNVU5RTTBvR1JORkJLaUx0Rmo3UWFu?=
 =?utf-8?B?MzllKzJabFBJcTg1MXpKU094YjBrSGpSTHJmbVViY0dncVV2ZTllL3Rha0d2?=
 =?utf-8?B?UTE1ME9GN0VUTDgzQzZmbVpmU0UwNEtOYlB4QnlsZlBwKzZUYW9CSllzL0Z5?=
 =?utf-8?B?YTc0TGsralZVb2FnUkdQcUIrL1VlUEhXamlHZXpxWWluM1Q0aWZ1R2JjbXE3?=
 =?utf-8?B?b3ZxckJFZGk3QUNkV3h2YUJTVjVPRUd4ZHB0SW1iUUpMNG83ZFVEOXB6UWox?=
 =?utf-8?B?MEpjbURJbFlDZFBDcWlNbHY3RXlLOG1NaUdhbjNaNGJNc00ra3REQTZNL0F4?=
 =?utf-8?B?TTVoNm9FUksxUFR3dDJiRHdqMER2ZVYybXk2bm5KYTdjcTBYdlVvSFFBeUtj?=
 =?utf-8?B?cE9uSllkejBHaWZjYzMxeXU3U0Rkd3NVakozYlpCOGRFTURZb3ltMlRqR3NN?=
 =?utf-8?B?dGkzTERLbEhDM09mQ0dMSkw2djk1MUt0WEcrYWNoUjlpZjZtL0RYTEFraUda?=
 =?utf-8?B?eVhmRlloM0Jqb2FaUzVDaVc0NVgrQnJ2NDRsZUdrNThtSDh5RU9JWGtKWHJk?=
 =?utf-8?B?TEx4YklSRWltcFBvN1pvVGVHQTlScXhFWVpSaGdvb2JuL3ZVUE5XTXAwNnYz?=
 =?utf-8?B?UHFaZXFVWjJxNGtMa2hnVlR3V3NIdWhXbzVXUjJXakplNkpDaSs1eTdEMFM2?=
 =?utf-8?B?dHkrNGZRcElCWXZmRmV1VmhuM0dDQ1EzVERKdjRzMGVrbmgrUkNDU0YyN3lQ?=
 =?utf-8?B?RHQrWGtkYnVlL05mMHB0cXJIV1pod2Y3dHRpVEhsUFlFdzZ6SzVWb3VSWjdi?=
 =?utf-8?B?U2RqVGRTWW1NNGtVNEZHalZtRUlDaTZ4Sks1RVFKb2pFUHV5dnZNWTZWQjl0?=
 =?utf-8?B?UjlCYlAvYk1PaWNScjBsbTdSamNHclFuSUF4cVpWOE44ZE5SUVZaZz09?=
X-Exchange-RoutingPolicyChecked: e6Nf1vw2VabzPPMUaGrUJPu7ixMZ3ChWRXKuXQ/842RoRe304xAUHwf9zGsKcDuo7jY+SRKr2X9u8qbQGoTEUddfRlDQzQCNgJWamqG5jjyjGaPtGEOmzbfpEBfWHMYCfG/okcipqbYSW4imdSqVTkCXQDnoceZIkqdsAC971G/3NQAH2RLjlSl5WupD0Eyv2h1R7ZjdzHpVd6v8x2Y6x9IzgczLyOgV1b3+nQO+X0keKy77EUyK3VCXwtt/wkeBEHOBW8XAZ8XGBFuqpT7z+5Nvi5Qrhxl1Ma+oMfxsUyY5t+wM7hhKybZ3ie8v7FDODY2QCKJk8hwgzwNyMLB4bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2058b12d-f808-47c1-3a9b-08df1ffa2732
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:25:37.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgeD+yyoLERxjTwDFiKS5OqZTYebzDCze4tUJ2LUwM+WlF2FYr76fVhe0+JrCK5AkTNQqsMnpXLUQNUXukKc6lvM4KKqlxNQxfvyrRZtEEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9708
X-OriginatorOrg: intel.com

On 9/30/2026 2:52 PM, sashiko-bot@kernel.org wrote:
> 
>> @@ -4773,6 +4773,12 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>>   		vmcs12->vm_exit_intr_info = exit_intr_info;
>>   		vmcs12->vm_exit_instruction_len = exit_insn_len;
>>   		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
>> +		/*
>> +		 * The APX enumeration guarantees the presence of the extended
>> +		 * fields. This CPUID bit alone is sufficient to rely on it.
>> +		 */
>> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_APX))
>> +			vmcs12->extended_instruction_info = vmcs_read64(EXTENDED_INSTRUCTION_INFO);
> 
> [Severity: High]
> Does this unconditional read cause an issue when KVM is running as an L1
> hypervisor on top of Hyper-V?

When it is not ready, the hypervisor won't expose APX to the guest. So
this is not an unconditional read.

Thanks,
Chang
