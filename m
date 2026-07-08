Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A0420896;
	Wed,  8 Jul 2026 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482646; cv=fail; b=sGcrc3tQ1/vLY58lQdteersFP0zEv/vyiDDMs7rSWAO33TZuoUZfyCiIxzw9wTGruoh9kLdm3ciy/LvQzYOhq13OlTbqVWgHIufUUtVcxd42Pj5tMfzhsC1Lj5mlRcI7v5Hr1inSuZtt1FPJLQDUAp7pzdMCjOOoY89t2x5j3aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482646; c=relaxed/simple;
	bh=TQTwuNWVoHid0Iv/DT8P0FRgg7a58S3sYg6By8jlcP0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSg+ekwerBl3i8sxDP3KlWYXuB7zpwYuVqIx/0e2E4NLdm89bTl2Nno+vcrRvPYOpywjuO+sYDqUkS9jvZbVk6Rbop6ks9YtWcPszbRxuSMgldZkdbZaHxhaH9UfGCPtt0jM3rq+m9beh/QuxKZS72zB3cyfZCsVvAYiOMh6NlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkebjGG7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkebjGG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783482644; x=1815018644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQTwuNWVoHid0Iv/DT8P0FRgg7a58S3sYg6By8jlcP0=;
  b=JkebjGG756yFiwLoE2zhLl2eJm5vqPN6dQeTcjO62YSWEUtnNEZ7o9NQ
   nKjXZHJpPusSGiBpZyGN3gXyGZCsbdReEyQ9dFruBzggfRc88onn2L5wb
   Jg+8SXPv83r4HektA8t7ahWWh7UN/b0AW95FJBVVlHpE50SCGvC5LPXD2
   QJaLEy8H+SYBRp90MGPzcqVXYju1PUdT+ybe3BiXJ22QswEHoCu/si7Iv
   NuYhqBStiH2408bAgVD8Kli0cP9RoD926ZSYRILGWtnrcIeg5e6ZTP4a5
   EIVa65ia7/YjGk0/wFwuyKybMv7GfFj567lecwoJYLEZpGUbwpHW3nOaC
   g==;
X-CSE-ConnectionGUID: BcxhvIkkSTSO5DSqQphAVg==
X-CSE-MsgGUID: NtfIXYW1Rt670Mbwe0s4Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95654684"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95654684"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:50:44 -0700
X-CSE-ConnectionGUID: RZcDbpvESjil5K52JXbvsg==
X-CSE-MsgGUID: FJafSj8PSaSakLt23UY+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247795187"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:50:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 20:50:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 20:50:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 20:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlW9Rbgh8Z6SNGimChjH1v3Cg0oIOCH4n0Sdcco9qxfuP/hJjypybyHxGJtOnV6mxAXMK7guhT1aiN8UUN6ZHdOeuD9jvRl/QRr7zqp7tJ2mHmA0+QNzxFWEyjURR0KeMHQVufVk816ajqfw46mjPcsJQdcMJB+u4SIJnGipSqwiCj8RshKGbC3xVVFfMIRoTBjCvRb1J8COwZK1rbDC4hfjdZDpcFEh76iN/rzmjtT42Z+9cDxVwKjJN1jjrxGb4bt6ZJ2d2jOb6TvTZjAKWEm51ujnTJ6chbEut603TEjU7SGc5d74S4qb7X1K9Yko64VNo1uRfTWw2TIEp7C/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XppsJnSI9UL3WLBZUObM3bTAgB8sVQq1wK9bEl528YY=;
 b=gU47tc63LMd3CEF0IxfrtAEtsOfJ+mChJ1OAk3V7KqMBiHpycFDBlYX1aAvQKr+1umAARyz+pgwFFyHhw+TRnetoGuDBvDRfQGoHybnXzc6iU6fgCQglR2c9n2FycxldOcRQP8IVrpQam8H4sN8dT6eFhVg0E5E9MYZQU6njXiVVaqklKIzVp1x82vTQrcqcdKCYKLOLzfySN6FGfaoaJuU/o3qFdtjRudNgKZAGara1++fTlLg2y59ld7nTU7whwwTsYX4YOHSpvvpB1D+AlSxVx+NM4nE/pEyaCw4Xs1/BhcmfeMC9CAB106b3LIgAIljgebUa7n5uVyb9ba2SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 03:50:32 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 03:50:32 +0000
Message-ID: <7d39a92a-0555-41cb-91dd-96dace318dcf@intel.com>
Date: Tue, 7 Jul 2026 20:50:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <yan.y.zhao@intel.com>,
	<kai.huang@intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260526023515.288829-4-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8305f615-0398-423b-5f45-08dedca40f25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: pwKT/4r8VmSqTfOCTIZ0YS/5LtFcIWr7RGzinkRKRLnhIk9aPUHSYtqPXCsPU48SKiFDAAhioJc8vLaw3g/gs1bxfMSkgbn4JceFeru3T76zd1BHY7Xm63uVTi6W8iQ9+cXWs1IQBmOC5Wm0SN9vzthEMm8ML7SwincFr2VI9xRquUCQpOiO15aQv8jgrU5/s3SHWk6QVrV1xS7LUWhfJl2BeS+ebDmM2LEgqxaZg54BGxnyXegrsnbR/wRZnaFpvpSKuxOfbz3hTMgwYpHTHrbqezRCm07XAEVqZGkYt7kbi8PzRts0u6ZgtqkTdT7R5+TewsWVREw6pzq7qwKoLz7xBK+py8NqIZHnfnlEGbbAIeG+9IA362N5qULy6MZqEgiWrL9GL+d/M2MRiY084NVCM075QF/6/4ArQnujFuh5Wyzbx0J929FanbJF15+sKYls+8td5x4hT/90aK/aCoQaQZRVnI0n4PE7D48D8C38fGKqMi+4+HZsBvna+yfQno15l7iSbw1KMuZCIrlxJVKlDOwwjPf5Wdp30XaTBWxxrvW70yc4AThR8OtZ0fnDz0dK5CdZmKr0dmn40oszvRJhsRClOf9tjsW4xAmT7TCpoogaVw056KD/NHWYl9J34leoWclj6nLxu9K1ILQJCT3zXFbnQX/ntWS4qicJUFXeeUhAUOZTSeZl6t/J3k9P1Q1oM9ya7tESjijbihg2Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBpZjRkMkEyUFJWOCtyZWdPeUlJVUU1RUxHbE5TVVhQM1pnWkowTlJtS1Bz?=
 =?utf-8?B?YkQ4MWcwMmNsRXkzWEFEUmtJRUNRU0dlY1d3R2xUaTNKRE5wWkQ4SGNWVzNK?=
 =?utf-8?B?di9sMG9FYzJ5eXY4aXhieUJTOHJTeGorTjJSRXBQK2FNbmFiTGo0K3FZd2ZX?=
 =?utf-8?B?RDU3bGtickpkMExnOGxLL0UvMmFTMEF1WHFsZzhrQllUMTZDc3c3UTNWZUdV?=
 =?utf-8?B?b2VFMWxVeXFSYzcyR0xSRmZzeHY5VGZzQkp6N3NrQmFtTEgybTNsS0w0U3pr?=
 =?utf-8?B?S3dMc2lHYjJGdVRmbnpKeStGVTJwbFVnbkEwRUFyQ2JmWU9jcDlNcU1wZTVJ?=
 =?utf-8?B?NVh2SjJ4eUxYMUFCaTl5NFk3eE16aVd6SUNacnJySEhUL1lQMTlibzlHb2Ny?=
 =?utf-8?B?dlZpSlBBMzBVSmkrQnNYdytCVmZ4bkNGR0NCT3BUSHFQSytrbUxFbU9mSXli?=
 =?utf-8?B?MG9NemJMTWs0QlF0SUpwSC9SZXR6Mjh6bU1YbkthS3NBaHJxZURueExJTmZ3?=
 =?utf-8?B?bEtlQjF3SGdrandzYVhzNXBRTXhxMXZpQVpZWlhabm9nNi9Od0ZYMU5XNmVa?=
 =?utf-8?B?RktTNFZISzhSTjc3bTFkUUpuZnBiMEVuWFJ3SVZERm5HdEhweFV5SUVwMkh0?=
 =?utf-8?B?LzlCM1lJTmsyajFacnVjekd3YXdQUEdkdDk1VURPZC84QUtoTTNybHEyL3I1?=
 =?utf-8?B?SlRqbnN3dEo3ejNoT0N3QVdKeUZhTzFqMmxlUERZMXpjNHFZQUFKZWU5U3Ns?=
 =?utf-8?B?SU9yZS84Q2dYaHdxUHFyZTg4bmlJajNzUURmOFo1TzhZNXlOcUxpOXY0eDYv?=
 =?utf-8?B?NzZlbU90VGszOFdtcGVjbXVjME9NSHNuWVR5c3JUZFh5NER1Zm5qbUNKS1dn?=
 =?utf-8?B?WjlGUzlqVmZzR2huRWovN2ZlNjNMYlFSOGF1b3FlQUV3LzYwamJ3LzF1RVlo?=
 =?utf-8?B?YTFXS2d0cHFiU0EyMEQ3d3ZxeWwzcktlT3QycDFXbERPZjZVT0d2WFVEcm5u?=
 =?utf-8?B?dzJuNjd1QVNyNU5TeGxzTnF3d3ZFZ1kxUWpKSzFVYXAvY3VYazY2VE9tNnht?=
 =?utf-8?B?eXJhME0ra1BGcHJvVTNpOGJGYjE1SldJdm9oK2hJcGt3Sy8vcXVtc05ESzdK?=
 =?utf-8?B?anVMWjMxakpqakpWSjR0eGw0b2EzWG1HRTZlWDkwbmtxZFhmTUVxYU14aXhm?=
 =?utf-8?B?dk5taEtJbjRqb3Vta0YybklybHVIN0twTzlyOHhnZk5ZV1o0a291Y2w0eTBn?=
 =?utf-8?B?RWJuU3pxSSt0b2Z6RHU5dWlJcUJtRlBmT1FSZUpkeS9xMXFSZWxReC9UYXpz?=
 =?utf-8?B?OXBvd0d4SkVJajlNOTN1c1YzQm9qZ0FabDVrQXZWb3Zla1hBRXdnTUdRcGdH?=
 =?utf-8?B?SnkxdytER1BuRHlFWDFtK05CWHhQWUxxanNmSFMzUm51Z3ZsZjNOSHNqMkI1?=
 =?utf-8?B?MHZMbzVuQVhyallManJUUWx3aGM0cEFYZkQ4VnU3S01aZGIwdDZEV2RhVEV0?=
 =?utf-8?B?bEo3Uk1VcDEvSThSeFdlWkFoNHgxZWdQZnlmMWtiRDJRZVlCeEFad2E3ajBM?=
 =?utf-8?B?cUtvTGJpay9iWngyYkZrVVRKV3kvNlc5bWdBQ3l3cG83YXE3c2xpMG9xZGxi?=
 =?utf-8?B?cE1hSmF3N2poeFNPM2pVM3U1N0tsZlI0WElGcUFBYkM2VDdnMUdGRXpjaENL?=
 =?utf-8?B?UjQ5RWxwMjZ5RWprVC9JR25pcU5oQ29MY0RpVzh6RGFJS2JUSnp2dzNNZk1B?=
 =?utf-8?B?THBHYzRFenlHb25zc0xLOUN4czZpUjhGamNrcmxoN3U2bW9jTWhFcFY2VGRv?=
 =?utf-8?B?Y2kyenhjYmhoNERoUXEvRTlFN29wZVpIRHRlb3N1V09VQXZtdEJLK1lZMEZh?=
 =?utf-8?B?T29TQjllT2pEYmJFb1pXTlpJRnFpWE81Q0NzTkhneXE5VTl5YWhqVnZ2amkz?=
 =?utf-8?B?eXN0MVVjcnJVN3FpYllOREFjVFM5aCtXWVZUNWxhSEkrU2RKYzRBVnYwMW51?=
 =?utf-8?B?Y3NnZmpWMkxqQWRONHRXbVVtK2VScEhVM2M3S1FiTmpjb2xDTnRtc2JYVCtn?=
 =?utf-8?B?QlVWa1o4MHFzaVJhSUJDSGpORllwODJaei9rd3FUR3RRb0dKdHVKb29GQTZx?=
 =?utf-8?B?ODF5SDI0TDRZN0o1TnNHaUZaUytHZUlIM3UrZ2N2UkorWWxCK21PeHIvMU8r?=
 =?utf-8?B?MGgvQUkwV2xYb0lobUgrZC8xQ3lpTm9qL2RCWElnc0J5M2oxemt6cjJGVUNr?=
 =?utf-8?B?YzNLWFdRMUgwNG9BSldIZWNvSlBFckRHbWUxOGhPTWZySWk5LzRqM2FaYmVJ?=
 =?utf-8?B?clpqWGlvd1lQcDVlSzVRNnVXa291SjMwbUJHQW5MQ0NDY3NkU0xiQT09?=
X-Exchange-RoutingPolicyChecked: j0WcKXoRliXppFkSevAE7L5DSJE+oLsd54XvJRbkf7l5JYveW+hZQuJuPKt+CoIWisXPoyZjLg67ziRAw9KRRyobuHAiNfSa9bjM440H8lGdLtML8vaW1YxJufNLtaBebYvYVIATvObw1AEQ4rh8faJPHhoLCQMWdpJxC7MdyxNpKqqaZVQmAOI9y6iQb8njbI8oOe5SBGknqdZ24LC9CmzRiJqVZ0A67LhIGFLauNIfGGhC5onUIUB4gGvTJmE/8p+Lb3BOOAUrCInX3Kb87nPOB+SCoxxRbQm/5Jbnq9KckqAlfnHTIW6sTKfPVmqxhUVJM/ObETk2Z46MTBNZIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8305f615-0398-423b-5f45-08dedca40f25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 03:50:32.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHkDU0BcvuDjNLWUDc8rifC5APm5ngYv8layXXraRCSS3/z9QoW7GjG+rUMZnmWJWZWuBfZXeByeJ31RJ0wovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8701
X-OriginatorOrg: intel.com

How about?

x86/virt/tdx: Add tdx_{alloc,free}_control_page() helpers

On 5/25/2026 7:35 PM, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add helpers to use when allocating or preparing pages that are handed to
> the TDX-Module for use as control/S-EPT pages, and thus need Dynamic PAMT
> adjustments.
> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So for pages that TDX will use as 2MB physically
> contiguous pages, Dynamic PAMT backing is not needed.

I lost the continuation in the last sentence. Why does it only talk
about 2MB if only 4KB is dynamically allocated. What about 1GB?

(Probably due to my lack of TDX knowledge)
Similarly, why do these functions only refer to 2MB only and not 1GB?

pamt_2mb_arg(), tdh_phymem_pamt_add(), tdh_phymem_pamt_remove().

> 
> KVM will need to hand pages to the TDX module that it will use at 4KB
> granularity. So these pages will need Dynamic PAMT backing added before
> they are used by the TDX module, and removed afterwards.
> 

...

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 82dc27aecf297..74e75db5728c7 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -37,6 +37,7 @@
>  
>  #include <uapi/asm/mce.h>
>  #include <asm/tdx_global_metadata.h>
> +#include <linux/mm.h>
>  #include <linux/pgtable.h>
>  
>  /*
> @@ -160,6 +161,12 @@ void tdx_guest_keyid_free(unsigned int keyid);
>  
>  void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
>  
> +/* Number PAMT pages to be provided to TDX module per 2MB region of PA */

	^^^ of PAMT pages


> +#define TDX_DPAMT_ENTRY_PAGE_CNT 2
> +
> +struct page *tdx_alloc_control_page(void);
> +void tdx_free_control_page(struct page *page);
> +
>  struct tdx_td {
>  	/* TD root structure: */
>  	struct page *tdr_page;
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 9ebd192cb5c17..9e0812d87ab06 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1919,6 +1919,165 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
>  }
>  EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
>  
> +static int alloc_pamt_array(struct page **pamt_pages)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
> +		pamt_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
> +		if (!pamt_pages[i])
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	for (j = 0; j < i; j++)
> +		__free_page(pamt_pages[j]);
> +	return -ENOMEM;

Add a blank line before the return to separate from the for loop?

> +}
> +
> +static void free_pamt_array(struct page **pamt_pages)
> +{
> +	for (int i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
> +		/*
> +		 * Reset pages unconditionally to cover cases
> +		 * where they were passed to the TDX module.
> +		 */
> +		tdx_quirk_reset_paddr(page_to_phys(pamt_pages[i]), PAGE_SIZE);
> +
> +		__free_page(pamt_pages[i]);
> +	}
> +}
> +
> +/*
> + * Calculate the arg needed for operating on the DPAMT backing for
> + * a given 4KB page.
> + */
> +static u64 pamt_2mb_arg(kvm_pfn_t pfn)
> +{
> +	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);
> +
> +	return hpa_2mb | TDX_PS_2M;
> +}
> +
> +/* Add PAMT backing for the given page. */
> +static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = pamt_2mb_arg(pfn),
> +		.rdx = page_to_phys(pamt_pages[0]),
> +		.r8 = page_to_phys(pamt_pages[1]),
> +	};
> +
> +	return seamcall(TDH_PHYMEM_PAMT_ADD, &args);
> +}
> +
> +/* Remove PAMT backing for the given page. */
> +static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = pamt_2mb_arg(pfn),
> +	};
> +	u64 ret;
> +
> +	ret = seamcall_ret(TDH_PHYMEM_PAMT_REMOVE, &args);
> +	if (ret)
> +		return ret;
> +
> +	/* Copy PAMT pages out of the struct per the TDX ABI */
> +	pamt_pages[0] = phys_to_page(args.rdx);
> +	pamt_pages[1] = phys_to_page(args.r8);
> +
> +	return 0;
> +}
> +
> +/* Allocate PAMT memory for the given page */
> +static int tdx_pamt_get(kvm_pfn_t pfn)
> +{
> +	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> +	u64 tdx_status;
> +	int ret;
> +
> +	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
> +		return 0;
> +
> +	ret = alloc_pamt_array(pamt_pages);
> +	if (ret)
> +		return ret;
> +
> +	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> +	if (tdx_status != TDX_SUCCESS) {
> +		ret = -EIO;
> +		goto out_free;
> +	}
> +
> +	return 0;

Blank line here as well.
> +out_free:
> +	free_pamt_array(pamt_pages);
> +	return ret;
> +}
> +

