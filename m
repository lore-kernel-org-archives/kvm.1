Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DD3C343C;
	Thu, 15 Oct 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078400; cv=fail; b=nhVD/0+Z3U+OWZAr+LsQFSPGIngI2zf9lQcIvLp4BlSAWs8D4wDWV8qAJNY/GHLtWqRnK5zHRZQcdhBVWuzEPqv//c8xzkigSskDfT4FYZF99knqAQvwYhLJ183IWZ/4xZo3UGSE8ezxgjPlGs2p6NatpKqOTxt7fyL+ZLfd4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078400; c=relaxed/simple;
	bh=AxSvnNF2OegOe82f4a4/D1Mqs4CIPFY5593G+1TddIQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibs75bwAHv1KokL/sPwcRmirMt8rOHQggh/KOAsBeMHJYx2Ug+ZTUKWIMLJ1NtYfyn4fvPg1UtAsgLAR7aGWcOQR2Yd4O4xBUseq80rIAVFo+O8zv2vijkDkWKqgqf/kX7mkcrrO01vjZF54WqeAafmcoJuJFNQOrdLkN/ZXnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV2VVK3j; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV2VVK3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792078393; x=1823614393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AxSvnNF2OegOe82f4a4/D1Mqs4CIPFY5593G+1TddIQ=;
  b=SV2VVK3jCnkeAuglRhNh0LL+fiormDfKXcmJtsk+FPmLRbafNF5OszLT
   Vc4L35+T92fqFrw99KOEH/gvGBxI/KFdskg3JqXoEitYwhGoo7Z3m3Ztc
   yuNGzKNlzypY6iSVijTT15Ch9KGyZ2kuiTR8AeJOXf2HTK1PAHn7RpE1B
   vNWvXagDE1DgceOejwuNEsCXGVU/z800uODG9aF0hX5ceAZovSwCoXN2Y
   S61M8Xk9kR+hUO2GSLaSFUCI+CJr58hj9HOnH0vnCohuanlN/UbLXSccK
   iq7D369u05cENx+ZLwZPiDoIfviAlH6rw1GbWiDvTEaqsTENKsLzbrzoI
   A==;
X-CSE-ConnectionGUID: HbS0WX98TBKMzVtv3AiYlg==
X-CSE-MsgGUID: OQoIEVK2TXasO61uDHfmUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="885204"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="885204"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:33:12 -0700
X-CSE-ConnectionGUID: lCiFzZTfSBKBiN1SZPlBZg==
X-CSE-MsgGUID: fOyshlSBQ6enlignHsaWvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1776785"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:33:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:33:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:33:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhBtZAYqbe9rgDSouDG4JuNHP1uq0kiqrodZnV0BI/oqhDSpTWi5c59gs1NPXm/ahEcawCs3Skm2kCsVXRt8jfR7w6d5WwitWmU257ZQB2JnsVmwKdOhdjzeoQLeDTwmLpHmDro5+w5AV/8MKzihBvcCHd0oGWOjaNQ8QAzrcWrbfk+II6YO5wSLqUKMYWrk31m3f+0RHKKcAaKI36WcnW84+UtNUOdUz9/27FPjXFXesCQcwNGFwa/iFBrHBz8Y7P2YhWK0SGoW8IKtf4UOxqjhTZq/V9R8BfVMS/kCB/pezqlHMPREPu1Z0x+IIX7aVFej8ABzhRCMVB4Jd3EU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqPwhfFODVS0C/WKBN9RmTjbErONFXoX5HRp/n3jm0k=;
 b=LWOGgBgd/RWWN8rCWw19PsD8nf5hTVGzN5sJthbYcxLKO+1IcdI75yyJPso4ALPJYaD3sYRrK1LYMJqD66Y8r+1ZWoBBpHiFc/xRLbRpvyp7oHBfIg5hbM1K4j7qEkh/JNcc21EHguy7OGAi0Bo89zgEfD/flEiGdogIhbI8TJUadT5Qq6g0GhWnPrk5IOHah9Jx0rBGkGvK8h1QK/gXvNv4Tlcu927w/rs/a0ArO10MXai+LnVLv2McF7zV432B13cSV1rvcpLiFfEuPXay2MWKPlpPo7bwLl98+38eyG7rQnh933nabfEBdvTo5+9KGNoElGSaF1PSguU+Z1pbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 15 Oct
 2026 15:31:17 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:31:14 +0000
Message-ID: <0096fb82-4104-429a-bd69-7f733624c664@intel.com>
Date: Thu, 15 Oct 2026 08:31:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] fs/resctrl: Introduce kmode_cpus/kmode_cpus_list
 per rdtgroup
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <54b0c60041902accde067b48bc3178c6756294d6.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 391c8124-75f5-4d47-5f5b-08df2ad15935
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|3023799007|6133799003|261009223027099003|11063799006|5023799004|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: VZ+0GLuDiH52meFfKzKmlM88QxD8wI2t8897TXjufvn5KGn1h65Bye6sKMZZ8edxBOVSEdky+6TsN3r77T3a8cTTR0K3kBRGSzFBHwLuCp2tD7BEmt47Ig/nPUQ0ngMHn7R2zVS3sRMO8yoN7jD5ZieLypjzjKjywett6EoL8cb5hwFu+sjUrqAPiKcvvgsr6uV5nopf0cv1HHKm/u2V+SMax4I0hrTbV3I4P7NrmvreiS2DWdLNZUbIl0PhdStid0T+OVsktoUge9tlYkB6g/LybOeobsBLsVShfp8TdOchx0cKVF+XoXZ2JT9ll3mnPxuDQ4gsASd4Pq17jx6szId9gKX2vg3TExiL+ZdOYwGWY6hCKWLAkdWXxTh/jqdN1+TuGKcKNYZtpNBxLAJ9W4R5TTQ8dS0UfFpsCMaHAdgsUh+HtntllkKg3ZYTUNywww9towOKSVJyrwDwaJ34S17Fi+WOzE6AxhZ6YVTXwULvtd7bPaZJ1J+QKHmjM1kn9JYHWlJQSie8zJACXJ4DDmUy7pvRL1ZEAkZSlSL1pGwgtimuaMM0ozleSueBnbKe1YQwGNq5XAc84qD8I+r3GkGXQJ3EFp85sjFB8RMl2ohdpzj9mWcTfz3EtsMPPiW50aOVVklER9EdZyMCd8YMTIUTG38YP/KK5kfRfYC9g1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(3023799007)(6133799003)(261009223027099003)(11063799006)(5023799004)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUk0SjJkYkVwWlFTbzZpZEtNOGs1UTltN2hOaG83Y24zWm85QW9vdHZMSXhE?=
 =?utf-8?B?b1hlVXEwTWRRYktBRVNnTG1CY3oxM25rVThoMmRVNXk1bW44andJSHI1amgx?=
 =?utf-8?B?RFZtVW9TeU5qUmJHZWRzc0F2QlZGYW43TjlLdU9naEg1STE5bFQ2Vy9Bbnlv?=
 =?utf-8?B?dVBuQnNJRW1uTlJCOTNlNUNVdUY0bHNFTzNON05kek5aZWdWdXlaZHd6VHFs?=
 =?utf-8?B?bUt1L1lyV1A3WHc4RDlIL01tbU82WWVRMlR2TE8yaDVQdXVYUS8reDBjVkd3?=
 =?utf-8?B?dzloYVFhVXk4NkoxQmRIaFdDY3RBUnI5bi85SmFFUnlKSzJZa2cvYUJiN0RN?=
 =?utf-8?B?cmpIWU1UZTVCdWZ6eklzOWdFK3puMGlhdmNQdVM2eUI3TVJGOFUxNmtOK0ZP?=
 =?utf-8?B?VW5lT1V4d1QxbWJWdFowQkhNWjBXRlFFMkcxejlUaW4vbks1d1lZVEdSQzhp?=
 =?utf-8?B?S1FVdFlTTmlZcXEweUlPMklNRkFnRnJ5OVl4cnJ3M05rNUJ2UHdyaE5haERi?=
 =?utf-8?B?UnBUZVpESFFzYi9UbDV4V00xYXp3RjFoRlJaVXRhcjlTSXQ3OHN5Skx4SktS?=
 =?utf-8?B?TVVVQmJLaUljQWhuZFU3bnBBSkx3RDl6S3RkY29WMk02a1ZySC9KeUpOMXpp?=
 =?utf-8?B?bzV3dHdtSWEwNmFZbnF6ZG9Xamg2Q29NNEFxbWZxZ0VPMUF4TERTUWlSbDgv?=
 =?utf-8?B?OCtQYjJJY2dLUEpLOEFJeEtXWjFwTktDZFdVVUtwTURnNCs2QXZKMElSWk13?=
 =?utf-8?B?NWdGWTg4RE05cEhLVTgzNXg5UVBETmtPNEQ1OVMvZ1UyRW9pNCtwSGRPOGFL?=
 =?utf-8?B?VXduVEtJcC9ab2hYVmIwZTlpRHpsVVVoczdVaHcvWjFPazlmSlJpeXJQM0tn?=
 =?utf-8?B?YlNjTjFMY1VzQndBdmRGMG1LcXlPendodVdUT1RJL09VbE9qSitkRUtSWlpx?=
 =?utf-8?B?a3BxMC95RExBQ1V6UU1PODFhOVluT3JrZW1hN0lDcGRpTFAybUdGWk12ME9k?=
 =?utf-8?B?TzhOYTNGSTRlNkw2cER0SFRmcGFEdVFZd24yU1d4Vm9Pa0g0YjQxY210ZzM4?=
 =?utf-8?B?eUZSYWRlVlhiT1ArWDcycGkrejlFeW95NHBuMmU0bUNWNWxYQ05pTzlkQ24z?=
 =?utf-8?B?OGNESFlBbUNYbWVobkR5ZXN1RlU3ZnY4LzNsYS91NER1RTBxS2VGeFZRZTl3?=
 =?utf-8?B?akttMlJuV1RwU2MwZElmeHVCTUhSekoyQ3V4UVA4WjNJbkFRcVFtQWVoOVlH?=
 =?utf-8?B?RkNaTmxrdEhNNjRRaXFrUjBBdnZCVTBTNys0b2lFVFljRXVKTTFTNS9qVVYv?=
 =?utf-8?B?SUpkS0laMDJ2KzloNnJMazZHMHg1R2hUelI3ckZmWUZER3BNY1d1Y1Q1VXZy?=
 =?utf-8?B?TExLeUQ5ZFlUTDhwVnZkOHNHcjFIeDhkQnl2Ny9xS0k3ajNmdEIzSFF6Ym5X?=
 =?utf-8?B?ME11ZVVSVHU2WkhDMzl4M0Z1QWpPTlc4RjVOcEc3REJZWmt0NlBaZVJVVHFG?=
 =?utf-8?B?WjluUlFuc0NMcWtESFdZZGN5NFZ0UnZnRlJnKytwRlpwOU1lNnNkY2JjK01V?=
 =?utf-8?B?elQrOUw4aGV2VXRXWExLRGdCa2h4VTdvNjRzcmpTd3JmaHFPZHJiSk8wNzg1?=
 =?utf-8?B?clp3YlhvTk11QWVCdjY1OGlWUXRQM3BuRWIwK0FWUXhkcGZac3Q4blVJdmFz?=
 =?utf-8?B?NTdEeS9tUWw1SE51U2t0d2Z6R2lxQXFlbk1ONE85N28yZkZCTFJYbzl1VDlq?=
 =?utf-8?B?NVZHRlZwNHprZldPS1p0emM3ZzFmL2R2aHRpNnVjS2htcFIwZTEzbU5ENGhz?=
 =?utf-8?B?SnZoeVZZWHFldGdibHNJaldZUVV4Qi9NOEx4TlBveHl0UlBnYzkzMkVwSUpx?=
 =?utf-8?B?MzVleU9CMGVBYkNqZ29LSzZsZksvT29HdDZXV2xXenhnbThRMm01VTJ2Rzlr?=
 =?utf-8?B?UHRHYm1RVFArNUR5a0Yxa1ZGcjRROWhSVEpPU1hDcnYrMUhWYU0rZU5jZFZI?=
 =?utf-8?B?MWVSem1tY2gyUk81cHZ3cEp6VkxsanVocFRRQTdYK2R1ajRabVlWTmZEL2lO?=
 =?utf-8?B?N1B6dWFnNnBVRkdjb1J2bDVnRnhjcEV4MGRkYVFjY1RNQ0lNSWJ6TVI2cHVK?=
 =?utf-8?B?MXRrdnBxemhyajEvR3AzV0FNOGRZcG1PUEtvSVVzcytoc0RWWkU0K3d0LzQ5?=
 =?utf-8?B?em9qWldRQlNHcFRUL2tIQ0w4TmFib1Y3K1k3KzdWajdONmd4NE1HeW1RaXVx?=
 =?utf-8?B?ZEhZaWVUTUtuL1FSS2x5Z1hrZTFBV3RHYXh3NXlNbDQ0UWJHbU0vWlJZVktC?=
 =?utf-8?B?SkpnT1dNUEFaTGFzTm4ydlNqQ1BoQVVZc1JMVEs2QkIyNzVKZjcvU1VHQmdy?=
 =?utf-8?Q?6zCGJikhH2HWDxvw=3D?=
X-Exchange-RoutingPolicyChecked: z5S7gFGPbYAunnnOfKAXuTi3vin/CVlwhHB5DtvF/Nzo5SCaMFm9naCpc7REJu5t411aYapTTC2xBy/IaGOB/8mXQgqNc3xesWNbaXqxnSGdh382u85A8ikn4LRbN90EbjNJ2pOj9v8/55mchOFVmeYFzPqDKKg0NRedMrx63/9QJ7R4sY/IY3MJ7iyU+Xxrr399uUzeIwCz24/STOvnUC1D5u+lA3epbHzm42ccf+KBlkfx6wutViso69d96u4i4JRlp6QNoLDurZ/00d41DArnaa3YC3SvgJpNPS990OxNxT4d3Ucg1s4DpSKjn+Aa/Yxf0pgXLsMpejEfrBOdKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 391c8124-75f5-4d47-5f5b-08df2ad15935
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:31:14.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCSEd0FOwBDUPPHWBsrSwa657BZSHo9LDY9amU+mBhx5no/YAugsiW+kC1LgazZWWdInCY8gJOjLwKZRKdROCkQwnLHW5bXbYWgwkCQXQio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode allows tasks to use different
> allocation and monitoring associations when transitioning from user mode to

Could "different allocation and monitoring associations" just be "different
CLOSID and RMID" (in places where this is what it refers to)? Being specific
and consistent with terms would make this so much easier to understand.

> kernel mode. The mode is enabled/disabled on a per-CPU basis.
> 
> Add kmode_cpus and kmode_cpus_list to display the CPUs associated with a
> kernel mode. These files are exposed only when the global_enable_per_cpu


"a kernel mode" -> this is specific to RESCTRL_GLOBAL_ENABLE_PER_CPU kernel
mode node?

This switches from "RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode" to 
"global_enable_per_cpu mode" mid changelog.

> mode is active.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...> ---
>  fs/resctrl/internal.h |  2 ++
>  fs/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 986b9c942fb2..6b8d14c4bd83 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -216,6 +216,7 @@ struct mongroup {
>   * @mon:			mongroup related data
>   * @mode:			mode of resource group
>   * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
> + * @kmode_cpu_mask:		CPUs in this group's kernel-mode association

Could there be a caveat that the value is only valid when the resource group
is backing the RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode?

>   * @plr:			pseudo-locked region
>   */
>  struct rdtgroup {
> @@ -229,6 +230,7 @@ struct rdtgroup {
>  	struct mongroup			mon;
>  	enum rdtgrp_mode		mode;
>  	enum resctrl_event_id		mba_mbps_event;
> +	struct cpumask			kmode_cpu_mask;
>  	struct pseudo_lock_region	*plr;
>  };
>  
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 46b2cafd9411..0e638dc654c1 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -385,6 +385,31 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +/*
> + * Display CPU masks for the kernel-mode associated resource group.

nit: "masks for" -> "mask of"?

> + * Supports both "kmode_cpus" (bitmap format) and "kmode_cpus_list"
> + * (range list format); the output format is selected accordingly.
> + *
> + * Returns -ENOENT on error.
> + */
> +static int rdtgroup_kmode_cpus_show(struct kernfs_open_file *of,
> +				    struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +
> +	if (!rdtgrp || rdtgrp != resctrl_kmode.rdtgrp)

Could the changelog please help reader understand the patches better?
For example, the additional "rdtgrp != resctrl_kmode.rdtgrp" check is
subtle but very important to maintain synchronization, but it is
never mentioned why this is used. 

> +		ret = -ENOENT;
> +	else
> +		seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
> +			   cpumask_pr_args(&rdtgrp->kmode_cpu_mask));
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>  /*
>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>   *
> @@ -2256,6 +2281,23 @@ static struct rftype res_common_files[] = {
>  		.flags		= RFTYPE_FLAGS_CPUS_LIST,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +	{
> +		.name		= "kmode_cpus",
> +		.mode		= 0444,
> +		.hidden		= true,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_kmode_cpus_show,
> +		.fflags		= RFTYPE_BASE,
> +	},
> +	{
> +		.name		= "kmode_cpus_list",
> +		.mode		= 0444,
> +		.hidden		= true,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_kmode_cpus_show,
> +		.flags		= RFTYPE_FLAGS_CPUS_LIST,
> +		.fflags		= RFTYPE_BASE,
> +	},
>  	{
>  		.name		= "tasks",
>  		.mode		= 0644,

Reinette
