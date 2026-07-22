Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B02C2363
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757344; cv=fail; b=d3zSM8fodHhImYTTqnoGueHSlz0TY27bk2NGE/z3vBzgPA5S+d19deo46HDJearU1URBOJJNvRs8eHvigxYOpdEXgxGjRkziXA9wiGmTXSXbUrVb/f9FXM+/pJ/gN4dtX+5ismbMh7w5ZG0JnMZmVsC2rB+FycIprh1lytEiUXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757344; c=relaxed/simple;
	bh=4qUHMriZWo0KQ6comDhg2biXfZ6Zo7IQFKLFj3QUD8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEBdT+aU/epC8BOBttOeDqLXH8rDZbBEejt9rwvABUu9bCbbXfWbksuaaLF0T5G5po0WJ7Aizd/LSP2WkJTrdLACR7eCO8LCvmdij1WgkgLC9KapvDM1o3GErv0UAVABKl8nD7JVtJGSC+RwRuZbogxwPFMpo2daq4GOQ4Og3Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+YOJrom; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+YOJrom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757343; x=1816293343;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4qUHMriZWo0KQ6comDhg2biXfZ6Zo7IQFKLFj3QUD8o=;
  b=j+YOJromh58/8OkPvb8mcAV+EEtdnmpxxPQJhnZT2T/2V4iDnXL9j9Ml
   rZ5cQHVeg+jFUmMfDeyUeS9dcQUNXak6r85ryzgxJY3cBvMp+JcuTgD1J
   Rlq4f++GSwBop+CRavGfoYo6VY5fNM9YXPAV+iwv7U9wmPEFfoKFPcOzA
   dgTc7AMQk3yJNDOYjTc9NMDNckqIXuzkI9rZed1ZKVL7xKshu/vNDrDfg
   E/eaEAbyGsMAZRf7+IlEyeSoOZE3XOAIkW/cbcibdJN7jOgWqlduOJ+XD
   dvYysl8L0uyNCfa0yMaSt2bANq2buU01CIGxmKMjyeJ8veeMoAbUtY9jq
   g==;
X-CSE-ConnectionGUID: fi+2GuQMQY6kijwj/GraFA==
X-CSE-MsgGUID: ufUIZ4AZRRKJrbxV0ubgmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85451878"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85451878"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:07 -0700
X-CSE-ConnectionGUID: xw4fO0UTTCi8hd/t6vlRpQ==
X-CSE-MsgGUID: qr79cuo4R8GxmTMLGY5lRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="257673190"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFUhFF7W9T8OaqOncvIaMMsswc36sh5gabxd07ocSEILWMTL+prtho0AcsaI/H9ylNdOrmQYry9u9HUmNrnu6AqVuqvSo5Ltz6HXVfby57/jr5+EXFw56JKQ9BoOqZZnmKy2iVj7xLy4vcX+VQUb532zFwi1BpYJyd8GIcOusg7/aXSDmm9uBvfoMavj+MYCX19u6lyBpb6v+eZQYwh1XKd/0yEiYFKFybEp8n3Gk5tj+orw8iiXUYk73593y9vO0U2ySe7SoSRGN7julXRI4T+zkImFAWqR8tuzzD0m5qfDqBSZ620AL9eHAq8WzB0nu2oDuW3a99aAqO8JvcTnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgZ25TnTya+Y+1aAOk6aoGmHM2FhPB4NTCyUD78IPyU=;
 b=riploysBnMdD1xk5s1D6Isw0cLqxbxYJvnzRq3cBfm5hRl5gCog0NfPDCzR4Ucztfl1GI4wggXIurm0G/2/ai1XZi34Tk6DB1zoXT5Ct4/3Nk0k4DiM6Gl+zzwVCEUd4mD2pKG750CSPXSr6avswgGq4dQzegI2zaE153MItR+GVTmQSXe8SSGjUV+ptdrA/iJn0JQJBGluXDtx4S8RikXBBibSC1gxyd86qs8UNljUysUapVBLIOXkBCp4GA0dcuvdyj8GC/Dd3m53/dm8lvZGxwBwa55UTMepsJ182NIxV93vPV1SGjYuYz7zj2qlpCRHuhD787tIbS6N2FAC4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:04 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:04 +0000
Message-ID: <4940a374-abe7-4ca8-b205-9259f4e92bac@intel.com>
Date: Wed, 22 Jul 2026 14:55:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/20] KVM: nVMX: Propagate extended instruction
 information
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-10-chang.seok.bae@intel.com>
 <20260720181053.B653A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181053.B653A1F000E9@smtp.kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: fc28df04-2af1-48b3-9543-08dee83be314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DenCI1E24KPWZYsxjsBIRISRSgp1WsQAlkyfqKV0pLpus+BFyBHSInsYxmwADb5qJaSKYA0Q5LIqimBAKRYouNWWQsrW/axasVtax36xngHjJSVTwl03BZeMsjHyORL7F6SXTwOPTJYKQQuXrRZ0l7rtfBt1s5y0ITNg4V6Y4WVVGywoZlYFa1yDgf2cLG7wnvabDSYDerUspJmyjfQtTYXq7Rq2ieAlJ+emu3XX2VBD6s4L94zb0PFvlEl9adrWywF0WQVlrYQ4k7yvWT2tjFYKOBGQwwVQRVTf7WII6wRVKpoDoj23dCte6xmBuozmLWEmomjrjPjiwppPB9LTLQiGKF2OQqmSV6XggDISatGhZzPvKosQs9U3d6qccGllBfC9EjkUcWMoZ7dIC+h0XMu8zMZO1W4PlkSTXq7qFX3bbHvD9fCpDmy+diPGQscQP1n7/MwaqTy8ZnmUIdXa7J9BNzepCnJPaE2s2vPJqYbivkdNs0hSvwPP7gTkTW7QvNBFWxGovmdmeF0Ewe482sWWXG9h5gFrHXvygA0ybcxg8Wr0tBHUnk4q4kPfTM+RoeDEJp+4qjp4UjM19Mfs7AAgqQ1vjPBetnUacMb6uR7S7b9D2teguPHLoa294EAprjbzaCCmBRU6o6W/MpvnSxFDs23KwxVX/xksypttPYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3c2aVQ4RlVIcjY4NDlBVlFQb3RGMk9BcUhleUcvbE5vWnhGdnI3RjA1Q2NH?=
 =?utf-8?B?UnFOSmhKRms4ZFIwSGIxZmNITXpGVTNBVHVJdmxCZXRpWlozS1FmWTNzUXhV?=
 =?utf-8?B?ZndhdTgzQVI0bUR6cG8rK2xqdDFIOVJOdjE4NEszNk5zT2ZkaWNBY0NyLzFh?=
 =?utf-8?B?NVI2OVZPWEtwZjZiMndJWDROVkh3STJ2SUJvZVpsc0F0bTNxYjZoUnJhRG9D?=
 =?utf-8?B?NzJxYjFZOTlXd0Faanc3SFp2ZUNNNS9rN0VRSzk4aE5uSTF3Yk5jSlIrcGcz?=
 =?utf-8?B?ZEFQcHNFcloxNHMwVHlkUHBOSVZjQ2FTc0Y5cUxNeXlLTllmR2MxZzBwdmxU?=
 =?utf-8?B?Z2hjalZkSXdUck4wZFJ5Qk1oRlBVVjBDWjFPTE9XdG5aNDZLWGZtRnlybzZ6?=
 =?utf-8?B?ZTlDZ0p0WWlNRVE0dDFqYWdybVpoR1EzamNmS0twVmpITFp4V0RWWWhOZDMr?=
 =?utf-8?B?ZmdEOWdZdllmN1BqcDhqbW9oem1tSmg2VFJxTWIwS2t6ay9GazgrT0RxUzhi?=
 =?utf-8?B?emlwTVExNEgzdjEzY1pZcmtySDdXcktYT0I3NmZvVjJSbHJtbGcxN2FPTnlH?=
 =?utf-8?B?SHhuZlZyZU84K01MTTU3WS9hWmVXZERPS2JMcTBsdkJHaCtFU3pqQmF4RWtZ?=
 =?utf-8?B?MU1rZnV3V1dTV1ZLbGhlU2pDQkxJanRoMHNDcHI2NWxEUy9ET0ZVVjVFb0ox?=
 =?utf-8?B?Nlp4VVhraVkrTVlhZTBIeFU3ZTVlczV1bmtRT1lCRG5BVytabGxlOU9uUDl5?=
 =?utf-8?B?c2pkWGhLSVhFYVp1VXhxVTJHR0F4VjkvUlZkaXBKejBMMFRpQ0pmYjczVnZQ?=
 =?utf-8?B?ZVd0dXNyWmdEbHZUQkxmVmlrWWxDOHY1a3YxNHVVMkZibXZJSEQ1ay9TcFFs?=
 =?utf-8?B?YUY4bDJmL0NGU0phajBFZWRwQmRGMWU2MEUvQnVOclRzSkNlVU9nZjZtUE0z?=
 =?utf-8?B?dFdlUkNSclN4YmlWRFdtWjFKTGpCK0FvaG1IK0c5NmMyRWZTQVBwK0wwSEd3?=
 =?utf-8?B?TEs4ZUdPb2tITHkxdjdCcENjdVY1SE9mcHRFendrclNpbU12THh3QnNGWU5K?=
 =?utf-8?B?Z2Q0RlU3UzhRVTZ6Y0Z0THFrM1lLQ0tEQzBoRjlQVEdJcWgxaG1obVN3OGlF?=
 =?utf-8?B?VzhnTGV6L0dFYmpPekExS09VWmFxVlFoc2lmeWFLWVZ3cjI4RGpOSWh3b2Zm?=
 =?utf-8?B?aW5DQUZwQW1kdGh0ZEdTMHdXUzh3aHNwdi9yWS8ySFVrYXBLQ01Zank1WGlw?=
 =?utf-8?B?Ylp5QVM2UlFpM1RoQXh3YXRCMW1oZkdCckxZS2NzR3V6QU5xcUR0b1ZiWU9a?=
 =?utf-8?B?a3pjTmVWYmV3VFV6TUREUEh1dlAzZXI2STNORDdDdVQ4MjlSUi8vUFlHcVZD?=
 =?utf-8?B?T2Yxd1hvRWpxZ2RxRnBnbmU5UDBHZU9McTE2Z1RlR0ZYMHYxY3kvUHF6dEVT?=
 =?utf-8?B?aitRNldBdmRwUFNoK0svVytaVzAxWFJYdjRGb2crdUljU28rclRXTHpxM2Vm?=
 =?utf-8?B?MnhoM1MwMEVTQUF5WjJ1bXU3NHFhamN5aVFJT3d0eE11TzJhYXpseEtqUUlK?=
 =?utf-8?B?Zmg4V04ya2VYbjRhaTI5S1ZRY1gxdDY1Vm04KzBzQ0dxeW1McUFmTFNmOC9G?=
 =?utf-8?B?UExEUEZUZG5HYXU3YW5jV1VEYWVKU2hBN09IbDQycktEK0ZRdnUxdWN1WG1a?=
 =?utf-8?B?d3BvSzc0Vm90Nyt2ZE0yRWxOOVFLN0hrSWhmWFQrZmw5L1ExUkdCOC9vTkZk?=
 =?utf-8?B?OXR1MU9IVHlpNGZBemZoZjBiV1ptTUdTaVVvc0VVbkNuc3hCWnhCcWQycjF4?=
 =?utf-8?B?ekNaeC8xcGdib3pzZStOZWorZXZia0VLbGluYkI5R2pXb1hReDBHMno4TFVT?=
 =?utf-8?B?RnNteEVCbTNZVGJzR0NMeksxK3ZxdHZvUEdXV2QrV2xlMVlYemtMdUcvQkNs?=
 =?utf-8?B?UWxGQ1ZKN3N6Y2dLbWt3QzVuRGlGemU2SHNVanU3YUN1aG5XZjFWYTcydzFJ?=
 =?utf-8?B?djFXaGg1ZHdyMFF1MytsYUk2UVROQ3N5QUs4dGFyZ2hLQmFjdjNST21lMkhZ?=
 =?utf-8?B?MnpPeHErdTBBMlltc2hrMElGUWYwTmFmUWFMVlg5bmhESStVa3Z0RFczVUY3?=
 =?utf-8?B?NytaaE5vZlU3YzVPVFBiWHlTY1NTK0NHMnB4dGFZTlJZQ1NFQVhUZnQ3YTdm?=
 =?utf-8?B?a0xNVTF0SUg2Qnk1TGhSSG9GOFZkZ0JlcDBNMHNwVGFMQWsxUVFYam5aM212?=
 =?utf-8?B?VFloZzhoZ2kwV3BLUGtCYTNsMVhBbGxWM2lRLzd5MXNnajB5amVpemt6ZURF?=
 =?utf-8?B?eHRDK2F5dnpVL05TUzBpeEc3UHlZL0Z3ZmdDUHJSa0NFUmdtZ3ZYdz09?=
X-Exchange-RoutingPolicyChecked: ZEhb/oD/zTKVSMtIFnxCXZo/doFDoAFHkezaMicm5JULL3u6kb3lkG87A/tUuOzXL/A15JPD38yJRYVU6lx0FuGxxwivBALN6NNz1q3zCw8RklvnXlNhHiGiXxPWyurkuWG9+EHZx70eDuGBolSKQzUMpxMghJDSKW6Vh+3z6/gIxU66EN0xIEsJQHsTqR71qmxj+uXasJpXzqEW6aWIAyHRGQX8exkKOKKJDwfkpfbAoFv/X4loNkzUr8o9lk3QI4OFE5W876dufkbrTeHsNhYo+gPzJ223Lt93K5/hg3KJL56w/RMwB/1jzyTbN17R9Dy1Kd2qJZ9ZJwqDQ7i/yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28df04-2af1-48b3-9543-08dee83be314
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:04.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT0m96i02hJpAoJsE9XkA9Yut8Ml8Xmg4Jo+tC4VHZ0N469sJKjrLCcF9hBfycsso8X5ppyuvmK472+hxTAue8DNy6GSkwisVAljwitXQto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:10 AM, sashiko-bot@kernel.org wrote:
>> @@ -4766,6 +4766,12 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
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
> [Severity: Medium]
> Will this condition ever evaluate to true without first initializing the APX
> capability in KVM's supported features?

I don't think this can happen with the full series applied. APX is 
exposed only after the corresponding capability plumbing is in place.

Thanks,
Chang
