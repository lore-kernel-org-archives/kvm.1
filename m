Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1419E819;
	Mon, 18 May 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145864; cv=fail; b=j11GFAcEUP4FgGX75VrCi+F6puUDaxOb9IV7d702B0L/ERaVTWaocRUZquuu9KgWkXiktW5QyXvT6jPBJGiCN3ZXBhVTJ+Ma+q/+cDox0ZeelSs5USEnBOUiMOck/AHpEqh0lMvcOVjoO6zl1HOPeQ2ETZyaRplGtlYEKydLYLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145864; c=relaxed/simple;
	bh=ZaXOtwMPtk+N1KaaABoqancEWQ7CqwMI1y2uq+BM8ag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OppgLpqn9khTXY+Pluut+y1DfbbBblM39F4u+JwdFCDVwkgDKc9JUZa7J6iuLNLa1AAUswfUrolAKaVad3u+io4dABCFYOeooxaL0WtX+GUizsQbNoA3T9+s+8t1Up2QYv7McOuNR/nNTHbFZ/pl/qrG2+e3Fgiew+Heebys2mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWPOgL+H; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWPOgL+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779145862; x=1810681862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZaXOtwMPtk+N1KaaABoqancEWQ7CqwMI1y2uq+BM8ag=;
  b=EWPOgL+Hu3dO/ShShVM91Br7tZR1da0uKmC4Ige+pi85noawI2V7pz9A
   VyKmmMYSkfuAaGZoi+l9fpd1lCfFvcjVMnP+g38LjglWE+eE0UJOwprfa
   pwEaVB82mgPqcCquIMCjzTcp3kJx6l95IqtusJe5zVrYxizYnco6j9UoD
   gjPAeSNjK0j/zDg3FUtJRUyMfbF18qpZFegH3PLAf9nmb+EKw8cqrVqDy
   wx6avskXl6FqNzMl9/OrFGaVR56y9+/rkEtUxJke9IeGy0D7YxkC4GxeY
   8muqSKdt6Kk+X1NYD/P3kSU3WWsVo/bTGd++rBXbgx0soNlbFPS5l2ddM
   Q==;
X-CSE-ConnectionGUID: Spx+jH8ySCiBDpNcrOtGBA==
X-CSE-MsgGUID: dj1B4wppTPuAAyzklV3bTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91406446"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="91406446"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 16:11:02 -0700
X-CSE-ConnectionGUID: VcUEwdXjRdCncCmIUe4t+A==
X-CSE-MsgGUID: HBgPOFSjQ1m2IFsnStMz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="236950815"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 16:11:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 16:11:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 16:11:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 16:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmS1taKI6LxTj7iwKqXeY+W52BDHvwxs8MZ7rlJZmpQN8iiptLDYGzdY/dkdTJ1YCWKBl7+t86OpvtA2Kk0R4cJOX2tnfnJP4pi7CTBFE6miIiuCMvZmedgmfDzm7mIWLasMi4TJPGatQOVm5vnbdPq4zxwaQ+gCWoFqEwKl4FcgL1zqFeIfxDBH+TUzm+5mWQcESth/OZd+D2DDr8UawECECpgcL1Bji16r2XZbTNhsKW/1EfKDtY3Ad44PixY1yZgC5ek9BL6DFSt2CMWEP0bEXFriYbwTbv8xtHGTVsp1j44HuNfJzkmE9ab7LmtUjB+h9WGhmJ3FeyvudmBInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS3slgLVDCy4WNrfPzUfifqlVoP+AsA1LdIQK0SR63c=;
 b=bVO46r/uzeIOIHFBnqPSH+c1flhIe9tYuVYWlsXPlgWgqeYlx3WVxxUiuOaWPv2dmw2Yuav+B4PtZ/AYdzCYPOP3MVVXgfoPBl3oygSQ9Bs5srAQhdG/yaKmGFcFGmRE0HUFQMEFn7OdrYX93gu9EFhtnvIjZ5nc8BYx8WaPGj3KIaqwjxGRgGAgNbFL2iIAa+zoOW3TduO/VnRJor2UV8kd92XS0tnqghetmKISSrATNNjogG/cO4D8e87V1uXcIzJ3gp+jFwv8H2RfWaVlDyG308UW0rxYvsdxm8dhzGTOWx3i27dkS85bHOARnsrfbD2U5wQI0w2aWsl1lkrIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 23:10:58 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 23:10:57 +0000
Message-ID: <b81cd916-a93f-4a8e-b534-2df59e61dd5f@intel.com>
Date: Mon, 18 May 2026 16:10:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
To: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <jon@nutanix.com>,
	<mtosatti@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
 <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3315ef9d-a48b-4f7b-3417-08deb532b7eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: w9tpwyFFKbMfLLXldWIsmsdq52O//mjHP6pUZFLkxsIaQgICs/pcv1shW/USlfa4JSmzRcBVLntB6VO/Hi4Nz2QRZPBq/lo7CMUQRXULXcPaAY0n+a6+wo6qe1/qP+lxPOArLZ59WZyAEtYBiqaB3E7eR8I3yJrxZ1XP/TXeORptT837l4waREiIZ4Ji6UtYAcOq3STXOgrqUneI6uaWhLlS92e4wzitUgFmz+zivGb8wVJIFPXdNH0HAZ3WbgGwseEfWm48LbXDQeioC42jWhOFu+HRPJEi1vwesikP6k0JsmzzowW83PlrVzmE+yxuX6bcb4JHmr2wCvE9ALHNLDoT1CDJs1R7aET2LZDDAIJyXtOCe5r1cYDD1fl1asYSyoA9TlOKZDkdrhMNizu76e5yVexbwr7LmXxq1N8ysqYGBmNIUQmDNfXV2XrY/Lg830q603yG7J9k/49SQyH+Bn7vFIxMr4eITufPix1vEjJUaRIqgcTPxJgTtwEI/tUtoztTEKKXEyvj5lE4CkmpUy6Ms0gKbznu3b7sHbNF2IRWK6iMXf8vVmot0fYONVtK+vNCvEY9R94cX3MT0JDczqHpUDvmzn4k/CabrWE294QaHFw236RWnBgiPPls2d/MRfbWQ7ZjUCLJAUxrlM0ZQ1uSc9d8Z9JYKLoQbVGHMwScfMQXFYlrWTr7g/fDQK2N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS9vWHpJbFBka2FMelV5OEZzT2lMSlRVRzBzRHArMlRSR2hxdEhwd25GbmlY?=
 =?utf-8?B?M21DWlNBUW8zc09rMHczNVUvdW5HM2pQS0E5WU05YnBocG0ySnM1bnhBVEJm?=
 =?utf-8?B?b0RBeVZvZUVJWDF5Ni9nZUpHMzhIRnhtNmpNR2t6L29ReWg2bk1RaVo2b2V3?=
 =?utf-8?B?a2s3Nm8xaGNaeFo1S2hNMXdHQVVUbmdaTWdxSlRtekljSktCU1BuRzR5aXdR?=
 =?utf-8?B?aW11RmI2WnFaUUVaelRzVFlqbFFxUXJwSFI1RDZ5ZXEvS3YwVm5DQWw5a2dr?=
 =?utf-8?B?NEdmNktTU0xZbXBuMFJmUkFueWVoWmxJaE1DUGtOTktCV09icVZtKyt3Yldj?=
 =?utf-8?B?eWNmUzdEVW5MajZqWkdBcGJhcDdiRUtQSEppTmhwbG1oWktkOFRqZ3Z2Vms1?=
 =?utf-8?B?bFZqN2F5YkYvRGw2NFBNaU13djhQSm5pVkdCcGRJcmtSTXVlQjRZOVJlN1o2?=
 =?utf-8?B?bCsvRTBFcCtHTE5odC9UeHZGenZ6Q3dTME1rNjAzQ3M2N3prTnplZVNBZ0Rj?=
 =?utf-8?B?N0NhWG9TWWpWK1RMQ3hMTTBNaWNjN25oQTNHS2dpdTNKRk5DczNqOVNBNUJy?=
 =?utf-8?B?Wnpvd25YQ0xUR0JaV05HQ3ZWcytRT0J5U0NxS2FXNjBJczJibWh6QUJ1OE95?=
 =?utf-8?B?UGhLKytPLy9IUVpyZWdwcEV3a0JLOXBqYTlzc3ZNQUxDaWNrQ0l5ZGJVcEtB?=
 =?utf-8?B?MkkyREFsK3BlSlIwSzZBZU5vOC8xZmhkME1iNCszdXBTYUltTTZnWFFHL1Nq?=
 =?utf-8?B?TW5WRFB0elpHNXd1RWRjQTY4OGtudzBhNnFVRUFURzRjbDkvLzFQdTlpN2U5?=
 =?utf-8?B?TVgwODE3dXB0VHpkV3RPeEplMGY0dmx1eEcvRS9YdkowaitPcEw1cmRTTG5Y?=
 =?utf-8?B?V2VIL0s5d0NlaEhIUXZtRXVOVUdlRG5oemxZS1ZXeEk1eDZzZkdaWlBxamtD?=
 =?utf-8?B?cVdoUGtEYndSL2FZWUxvVnVXSlY4Q21IbklsNWRlUmNYL2JScHBsMWlNbWkv?=
 =?utf-8?B?U3lKQWgwaXJKbmExMnNxUTRWd3VNTmNmUW4zdHdIMkdqZjhNZllabEV6bS9P?=
 =?utf-8?B?WVF6am9hTXlCQlowWFBSMEZORlUrbUdCYTYwL3dCa0JPTGFWSWRXRi8xN29U?=
 =?utf-8?B?dHJPcjRoRThadHZXUEttMURxWEF4bGNCZEg0UzBTa0NpVDRjSndLbEpDNWxr?=
 =?utf-8?B?eHFMRC9JNFZnUW82L1N2c3l5bm5DRjEydFZRYnhsUnpSVXczL1RuVU1udFlT?=
 =?utf-8?B?dEZXMFNRM1Q0VWxCSDBZTXhBVmQ4SWlJSGlQZThXNUk2dnJYRGUyVnhkbGlP?=
 =?utf-8?B?WXFxVE5yQnRGZ01CQ21seFNZOEdWMEt6Q0x0d0psYWF0WEhXSFVRbFZuOVl3?=
 =?utf-8?B?dStkMDM1WVBaeE5iMHZsMXcwdWFPcmJaV3RwMTBXQmxpc1Y0MlBZL28rOEo3?=
 =?utf-8?B?QU5iZ09KZFVZbDZTVlhWMWcrZWwya3NoRDlFRUJOd3F0eGliclJaQmEzcVp1?=
 =?utf-8?B?QmtGbngrWUJzeisrb2ZhNE82RityM0V3UktNSTBjOVVaMm9BTm1Pb2t2TjN1?=
 =?utf-8?B?TlkzQUcyTzFiYS9YUWo2TDBLSWluVW8vanl1N0V3c3ZVdCtsRTR1RXM1Wjdo?=
 =?utf-8?B?di81cEd3aVNFNW5oWThkMDBxejUxS0FxcExKRngyTGNsaCtWVVpFK0hqMUg4?=
 =?utf-8?B?S2x5aDNzUjlJTXlrd3hiQnhvSDN6K1IwVXpSMjVpWmhaa1ZmOGxhdi9HOE1w?=
 =?utf-8?B?ZUZ1bHFyRU8ra28xUVdadGFOVVh1SW5JQkRSTTB1aFNzZWlnQWJtVkFkbTU3?=
 =?utf-8?B?eDkvSHBiRDgzdzI5VFVtVmU0Z1Qvc3BCNWpzSXRuNUhHekNLVkpibmJkdHY4?=
 =?utf-8?B?UmU5dGdKVzlOLzZvWFlQd0dUdVJEbENTWm1RbHhFTDlIYW1qNzUwTEx4NHBL?=
 =?utf-8?B?QUxCcXpSU3pCZ2dkb3VCWlFmdEdsaVFQdmRmREFtWUFUQTFDNXUrZ3A3RWNt?=
 =?utf-8?B?WDVrcTR5UGR2alpDV2VDZnNHbTJEaVBGM0M5Z2twZzNYZDNlb05kUEVXbi9m?=
 =?utf-8?B?RVl2alFEQzBnN3pqUWV3M2ppQ3hLWkNUeW4veHpBK0ZRS0F0dDVRSG5mQ0VT?=
 =?utf-8?B?dmtadm9XZUxXbXQ0cWxDdTFEeE5RMlBaYjdKRWJ4US9seEh6ak1Ha3RFZUlW?=
 =?utf-8?B?TUtmOFgrQTQ3aytXMVI0Z1UxbGZCWFpTYnZGQy92VGxvUk9aNllKdThiOFJv?=
 =?utf-8?B?L1hZWGNXZS9RSTNZVWJXSlEwcUIyZGNZUWErNnpGQndoejFvYlJaZi9jL1I4?=
 =?utf-8?B?eDY5QnN0eUtzOTN3a0I0MFp1VGM3dnlQdEJkK21ka3VLOHpRaFEwdz09?=
X-Exchange-RoutingPolicyChecked: wW4OJ2wTsu/qDk4uGUmPWrS7EsMRbYINaEVJgd0tG7HOv+AUS2aVNBPKejeqCnmec2TLtgrCTy6brA+oTDLnE/ZSMG3uUq8Vi4tqEipvn6czzSqTKZbunLFexIOdg1zu2r5fJiaZ9O2PmSc0TnpbLAGNFcY2o+XQjBz4+/2wxen6cdcQb0rpy3CpsxmzyeI3tVLSfKC4j9cvlGbudGiD9UKM35ozr5L/QWGowA4YevF9L4zAiHucElj+SI0ElwT+LNqlY0uQPBLtz7Plx3bDmaipdLOxFDAOMMj2XZYKko5zX26XZ7pkkOQCBvrEdfN6ZFcVXeVQuRXsyCLN95wbng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3315ef9d-a48b-4f7b-3417-08deb532b7eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:10:57.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxxTBamrWseP5uFquXL+JW3+TwS06FFhJ5B3M7DCOkU6KUzJ/wKxvmHuA3IlmOQzOoWHfXjZBXYBPoiXhPxsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

On 5/13/26 2:36 PM, Yosry Ahmed wrote:
>> @@ -6767,11 +6748,11 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>>
>>          vcpu->arch.mmu = &vcpu->arch.root_mmu;
>>
>> -       ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
>> +       ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->arch.tdp_walk);
>>          if (ret)
>>                  return ret;
>>
>> -       ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
>> +       ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.cpu_walk);
>>          if (ret)
>>                  goto fail_allocate_root;
> 
> I admittedly did not take a close look at the series. Just wanted to
> chime in about naming. I *love* that we are getting rid of nested_mmu
> because I can never immediately tell the difference between guest_mmu
> and nested_mmu, so thank you for that.
> 
> However, I can't immediately tell what vcpu->arch.cpu_walk is doing
> either (compared to vcpu->arch.tdp_walk), so maybe the names can be
> improved? If these walks are tied to these MMUs, maybe name them as
> such (e.g. root_pg_walk and guest_pg_walk)?
> 
> I also think root_mmu and guest_mmu could still use some improvement
> but that's probably outside the scope of this series. These are
> essentially L1 MMU and L2 MMU, right? Maybe just mmu and nested_mmu
> could work? But I am not sure if we can reclaim the nested_mmu name,
> it's gonna screw with anyone doing backports :/

+1, and I wonder if it helps to name the walkers after what they walk, to shape one's conceptual model. E.g. cr3_walk (instead of cpu_walk) for the walker over CR3-rooted tables of the currently executing guest (L1's or L2's CR3), and nested_tdp_walk for the walker over L1's nested EPT/NPT when L0 services L2. tdp_walk alone felt a bit vague — it read as "the TDP MMU's walker," whereas this specifically applies to the nested TDP path.
