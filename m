Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5C2D238F;
	Mon,  6 Jul 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369429; cv=fail; b=exwrilMhdWhmCK+rqQkL/r9N/VCfi2bYXgLnFS45vKSJ4GFYt6YAw+EZBfuuECxvqUBkcLKucassc040hz4nCeaVs9VdkwwUr6IdXiMvPaNJpHMVmpoApncKF5qa3BWuuDJ0Zd95V91P3r9fFyk9yjQQ4xG7kMDZYWj6S2CK32o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369429; c=relaxed/simple;
	bh=OdiX452pz4Lyd9jOJrmXeEPs+RTTSlobFV5XIvKPJNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CHU8CM+H1iL4qNzrdOfsIMF6Zod1dQNcdLvDP5eebrobhT93jA+DItJTWOORCcyrwmzMNzwQaRjbXWQXUR3alqh30tKRhwFpBSPp3MQ18SLJSZ+Li2sN6l/iBnCZXyERkLDdPTxP4SelpeH7+un32rmlSnjcp8VH9SkZXi6tSqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTNoLRlc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTNoLRlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369428; x=1814905428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OdiX452pz4Lyd9jOJrmXeEPs+RTTSlobFV5XIvKPJNA=;
  b=FTNoLRlcXJwqdVZHPorDHjIiYrLNruXufrZZt88iUTgZu6U2hV5cirSv
   RVXw/++Il6f/hjymrWXNIzQ+QLemE4pJG65h/s4ZodDKykDlUpCVNpS80
   pA0OlqbmNfo8oQByQf3BdyDMOd/qxkL2JByq9Nf3TORkYr01wXmTab+vf
   T6JVcJs7UQKL8nusIt3iLn4WDG2TLnukXduxtwI1HgHQM+1PkOAAEgOMM
   TMYRI92NRLYmPSmPmK6+YomnQCPvUK3zBVwoTXZuQmtBTHRir0gqKwj84
   T6uaLZR3OBFuOGQM6kl/R3aSE0GMjk37lBL1pBEF2oYAMpRLX4HUZNso8
   Q==;
X-CSE-ConnectionGUID: ehQMC+y5Rfqk460tQBSL+g==
X-CSE-MsgGUID: heY5icDNSkyWFYxz7cOfLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109556879"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="109556879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:23:48 -0700
X-CSE-ConnectionGUID: dRSnyrCrQ8mRjoOKLtF+vQ==
X-CSE-MsgGUID: 6LI4YrukSTW+GRJGhsp36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="250456360"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:23:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:23:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:23:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5mcN/cc0/pZYIYbDQjQZ5JnYp5gkFMx3KHtWP9Sl+JFjhNuyx71I+ng3FX2r+zzAuVzbyffaIwmKjmKFFJ42+iQq/QqZoWWK5lEnr3PXJ+15RVZKOemNED4ob73PeX5tGoVxP2aC9EbW2O1bPUe0Vo0qcWW5AboDghnpDQWlPbaC5KPiEjfiiNVafg4ZnYGez9dVLw/e6jdlGNhDm3QBiJACcwGjUomR/V6cvmfvM3UPCX5bqokeCyKXbmRsBWSi3Yjk7vWyHWm4H0V5nbhC0ZVq857Lxy+6gF88mrX21wdfF1lWDvKzu3SNwfzfRydpubDCtCt+L+YYWfdHupduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdiX452pz4Lyd9jOJrmXeEPs+RTTSlobFV5XIvKPJNA=;
 b=QrajiMQM4aPv9sKN8uOQzveghImt5TP/ufoOJRiAUsplf7TyblAkhNDXLTJ4jd4tdRY+B9rttFYhkvjcHR/40RrwA7x0g7AxiLl50TGABAETscFSnxA5ao4IJJDePWuI7CIepggWrdU/9vLJLVnRqjoaJEuxqKE2B87pgugZgjtzZ5KLFphgtIDu9PasEZuKQU3eXnn0bmrR1C9bj9o0BAb0Qmt1oBIMeiiArm5Z9qP9V1jeF0Imt7FO4phORe4cxApHiKI1EBKBIJ2A0opVI10KxuW0kT9ICO2IFtNen5m+bGqPiZgVYitu0ucMyqYq+Njd1ACXPBbjlgTergIduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 20:23:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:23:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHc7LhWCooE6IHqmkuIiSt8p5dGSLZgrToAgACD/wA=
Date: Mon, 6 Jul 2026 20:23:40 +0000
Message-ID: <039d5cdb3bc57cc97177037fb95b9cba98edce32.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
	 <akugEqMk29Q9DJUY@intel.com>
In-Reply-To: <akugEqMk29Q9DJUY@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB8269:EE_
x-ms-office365-filtering-correlation-id: 215ef618-bd34-4a78-d01b-08dedb9c7816
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 8WHswzc9ArHc9L29mwKKLXrDZQev9Q+MPrjfMB4sn/pc7sWYpKJwF8NSTKVlQ6U7E6YloHbQzr4Uh76vbeXe4MozcBVktrySXvMxO8w7xf956S5XrW4ry6HNdaPvCrjn5lgy7mbOdpnmRI960mDAcU91aGINTwtv/G7YqqowzsYOTIerKlaFokUa7mEYN2yps7QlY3nJSvF1Bb14up0hDq8OtKcJdYy+0caD+9WVLHmrspbQUV8DCrmlLLn9WYxjC93OwW0dr/RZ/cVMZhc3GXg8T7QkGKw2N9z/4r5OIZ1hJKVBN9v1UqOfOiE01ix9iF0Xh4l3JvLT5H9YfunaBLLFKxiX6RDYTn4sM1AoJDJTyaZP+Vtn7HINl64oZkRiNkMjatbrazCS9E75oigFpJrF0kwMiRIehifFlLioeCUFDsk7aD3QxNlGT8JTt9xJlMKfHqTrJ+0YKqH3Owdp0PmpS+YoLyp9vNrBLpEwndOkYW4O5Vg8wL8yJdyEMQ1THO1eBs45EOKaz4H1JFacF7/DDLJfcSbB/V0b83e69zxJ4PUsQkT+8gjiAw5Vds7e1mVsVq8QeWSNDn2K5lV6XyG4hCMYn1et6TRjJ1PRKOA/MBtswtO3jIKPMShVT11nXg/jl7yJgyfSDnLYkC1yisKyxEr35Qg0MBn/N6SKkFGNh4MNAKGeXNK8l1EVO1kGcOvmqxgiyqzz1VRuhGEkvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1KazlvbWZ5OWtUbS8vcTgvcmlhelRveFpUaHFRQzRxUDlHOEVncStxMlo5?=
 =?utf-8?B?ZXdweDBPbmE1RHpPcTVBaFFIKzBEd3RHU3JWK0NGN0ROWmR2d2VqUjhZOXda?=
 =?utf-8?B?Y1BvMzF5K2xhUDJxbFo4NExuS2JqcFQxRU4vMnJTWndUS0tubU9IamRSR0VU?=
 =?utf-8?B?TUs5QWFDSXFTVUt1MEt1M0F1Um5FQXZhaWlVYVhaYTc0Ym5lRWFkU2xqT0ly?=
 =?utf-8?B?RStXQ1VyMXErZnp4R0FBOTNzV3lQRmNWaGNPUER1YzdqeldxdkcwVjVyUndt?=
 =?utf-8?B?Rm44RmJTWmVmK2xYSGRtYStseXAzbUdzOFlFMW5adXJHT09lZkZDUWJwSHU3?=
 =?utf-8?B?ejRIaW1iR0RGV3JYR21SdTlZUTBPMGFXS20zR0k3YjcycHovSXN1d2pkWGZa?=
 =?utf-8?B?L0xka29PRjhBV3BCZDZUM3VIT0hadHFLRGJCWGtvUG1FMVpsVVJHaWVUNXhz?=
 =?utf-8?B?bHZxUWxYSldkNFJ5RFJPNUtRVTc4RUUvMTVzUGU3UkZIUUU3eVdiQmNZK0Ew?=
 =?utf-8?B?Y0hQZ0dWSUMwY0YrL3M5QTcydlBPT2graGRLcm4xbytHTXNNME1uZEY4YVZx?=
 =?utf-8?B?dFdHTzZKUng0cXRjS3MxL252Z3QxM1hwWXFKUmZWK2d3cFVKZ3ErWE5sa3No?=
 =?utf-8?B?TzV3UVVKT3VVUi9aajdEZE00QUhmS1VJamcweTFKM2FIUmR6Vks3SUJRWlBo?=
 =?utf-8?B?WVdndnl0Slk3d2RnNWFubHZ0RW9KV0pHa1lKVHpFNGVtRGhuMy9BSW15a0M5?=
 =?utf-8?B?a0QzVEZtRW80c1c2eVVLR2FtbElHdmdjZ09jejN3LzVNZjhKSHRvNnBrYkZx?=
 =?utf-8?B?N202Z0k3M0g1OTVRUXEyTmRhL0lFd0VHMUlETS9ENUt1NkxIUWNweldVTzdn?=
 =?utf-8?B?NjdhZDQyelZ1U2R0emFzTVlTR1RaWWo5RjFydlBWQUYwNFZCWGk5VDAxN3py?=
 =?utf-8?B?WHY4bmZ3U1pySDFjb1QxYmJ5cWZwUGwybnpoNG5XWHd0ME5QNUpkdWQwRjJW?=
 =?utf-8?B?cXllYm41YzMrWHRMSVBVOWNyM1pIZG5lWHRyNVJ4b01jeHFUakpKZDRIMDEr?=
 =?utf-8?B?ZGZoRDdtQXR3b3NCd1B5bC93S05vRElwaFExdUJGYTlHUU5RdTJCSjV2QzJG?=
 =?utf-8?B?dHB4anpyT3BObm5iWnZiK3FJRko5NzErVEJRZCtqVTNjbU9Zelo1dzFMdmRm?=
 =?utf-8?B?VXFVRXFmaFkrM1djL1ZyYTZaYmp0bDhYRUQxdHc0V1JYanczTWZqd2NTYXZa?=
 =?utf-8?B?bjJBaitYOXFUTEZqUUc2ZFhNMW5BSEdkZkVhOUducHU5dzEyUVhCMUFJa045?=
 =?utf-8?B?dFF4NTdQMnl6OHZKZmNaMGdlWS9hYWdpdTExOHMxTkF4UVhPaW5uZjRZN0dx?=
 =?utf-8?B?ZzVMNGlPTlFzN055VVpxUSt3b0ZYOVdueWNSRVdpL2JzV2RTb0I4ejVKQmdH?=
 =?utf-8?B?dlBRbURHczdnWldaY2tjejg1dTFUUzN5dzVOUUlqY09UY3hFOXhibXZ2elc3?=
 =?utf-8?B?YXBUeE5oRVZLQ0J1Vkl2OHFHbTc4RGZXT3E5SXdTR2hWYTRnRnlqdUJvQ1Bu?=
 =?utf-8?B?elRLQVpVU2RUQi9QRTIyTVMrYzlwaGpXNWxCMkNQb1dkVHNWcEI1SUFrdHNr?=
 =?utf-8?B?MVIwcFJVL3pRcmZUbDFTWkVhTDF2TjE4ZE1HUEVDWGRoTEJ2emZSVVFycTBk?=
 =?utf-8?B?QUlOUkZnbXlhcGxtaUJiL2dtWGtxQ0FlNVBvNlBHcDcwOEVJMTgya2RzSHc4?=
 =?utf-8?B?NGZXKytuV3NuK2hoNUlNWjRUd1NyQmFHVGJpRjVFL0s5RlNBM0NzKzJpUndp?=
 =?utf-8?B?UXNhUTRkaktNR012aG9OQ2xMVW42M0VubU1ZdUF5UDMwOUpMWlFTQWZaODAz?=
 =?utf-8?B?akJZSEZjV3NOT0ZGSFd3QndvYjR4WTRKZUZEMldNbitaZUxTMTFOaW82ZGM5?=
 =?utf-8?B?ZzVIZnNwa29rN2tLN25DLzhTYXp2VXFDWElTLzdsK2ZzeGIvcHpaNG5GV2RV?=
 =?utf-8?B?dHJ3VVNHRVR2K28wTThkKytaNUJ5WSs2dmN5S04zVlM2SzVNQ21LVUNra1o2?=
 =?utf-8?B?bTd3VlVCbFhpTEhmeGNiU1ZPZEJCUmdpNVhLL1FFSWNqOTd1SlNXNVdGU01x?=
 =?utf-8?B?QWxYOVhvb2REVEJEL0Nvb0FIN0N4THdldHQ1TVhGcWdSSG0zeldlUVFmUUVx?=
 =?utf-8?B?T2hHRkt0K0psT3NPb1JCQ3RJMnhMNmF1UTlTd1VySENiOXR5b0xTV1hHMEIz?=
 =?utf-8?B?dDhsMVIxWXpIcTZRRWlrQXhuWkFjNGpoYndja2xXM0VENThCOXYyZXE4NGFG?=
 =?utf-8?B?RVZjM242YTl3ZUZibzRNam5jU2pDNUtDd1BJc0RFd3hZT0ZHM3p4WTViOUVs?=
 =?utf-8?Q?dghxN2U3mwUmdU4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C7D730BC163CE4F95349A51A2E9AE7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q02ICslI7VQgG/wPfzJx2P6bHpcD9h/XczuZhvV5zD1Y57YDk5nHEzc37y4ZsAcITRBY+zPSSe+9+rUTfA4rjhPYkjoWOUCeg6F0ve51PWMUH25armR+unhx8Qj/Gg1qbIJEkCwppj43C+jqOJJ8cH0FY63ishFiGcxagKxyJBvLwiH/hNDvD3HqnlZ2F1QA7BWWhhGMtElL2SQnWQ+dBdQqc3RZNyoSnUG2whAMAciSf9V6KpLi4CCQSTPV75AivfpG3HR8F7gg1+rvKdKiatLpFmHJ1ZlXvPiahtlAcfgMBF6BpN7IWegqZsI6sB/jtuGlJJM2ubgMT547bdGDag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215ef618-bd34-4a78-d01b-08dedb9c7816
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:23:40.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixnNk7Up2gOTf7ivi5zFv8C41Sl+Ol/7Z+zU30rBmi33VaepX8u9sTvnJ61MP0Wr7pXua0uea6cnF+ZvaS4QMK7AR/s/2J/h3Fbbh1NIHoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDIwOjMxICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MDdQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gRnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gDQo+ID4gQWRkIGhlbHBlcnMgdG8gdXNlIHdoZW4gYWxsb2NhdGlu
ZyBvciBwcmVwYXJpbmcgcGFnZXMgdGhhdCBhcmUgaGFuZGVkIHRvDQo+ID4gdGhlIFREWC1Nb2R1
bGUgZm9yIHVzZSBhcyBjb250cm9sL1MtRVBUIHBhZ2VzLCBhbmQgdGh1cyBuZWVkIER5bmFtaWMg
UEFNVA0KPiANCj4gRm9yIHRoZSB3aG9sZSBzZXJpZXM6IHMvVERYLU1vZHVsZS9URFggbW9kdWxl
LCB0byBtYXRjaCB0aGUgZXhpc3RpbmcNCj4gY29udmVudGlvbi4NCg0KRG9oLCBJIGFjdHVhbGx5
IGNoYW5nZWQgdGhlIHdob2xlIHNlcmllcyB0byBURFgtbW9kdWxlIGJlZm9yZSByZWFsaXppbmcg
dGhhdA0KbW9zdCBvZiB0aGUgcmVmZXJlbmNlcyBhcmUgIlREWCBtb2R1bGUiLiBTbyBJIHRob3Vn
aHQgdG8gc3RhbmRhcmRpemUgb24gdGhhdA0KZ29pbmcgZm9yd2FyZC4gSSBtaXNzZWQgdGhpcyBv
bmUgd2hlbiBjaGFuZ2luZyBiYWNrLg0KDQo+IA0KPiA+ICsvKg0KPiA+ICsgKiBDYWxjdWxhdGUg
dGhlIGFyZyBuZWVkZWQgZm9yIG9wZXJhdGluZyBvbiB0aGUgRFBBTVQgYmFja2luZyBmb3INCj4g
PiArICogYSBnaXZlbiA0S0IgcGFnZS4NCj4gPiArICovDQo+ID4gK3N0YXRpYyB1NjQgcGFtdF8y
bWJfYXJnKGt2bV9wZm5fdCBwZm4pDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGxvbmcgaHBhXzJt
YiA9IEFMSUdOX0RPV04ocGZuIDw8IFBBR0VfU0hJRlQsIFBNRF9TSVpFKTsNCj4gDQo+IFRoZSBj
aGFuZ2Vsb2cgYW5kIHRoZSBjb21tZW50IGRvbid0IGV4cGxhaW4gd2h5IHRoZSBwZm4gaXMgYWxp
Z25lZCBkb3duIHRvIGENCj4gMk1CIGJvdW5kYXJ5LiBBbmQgLi4uDQo+IA0KPiA+ICsNCj4gPiAr
CXJldHVybiBocGFfMm1iIHwgVERYX1BTXzJNOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBBZGQg
UEFNVCBiYWNraW5nIGZvciB0aGUgZ2l2ZW4gcGFnZS4gKi8NCj4gDQo+IC4uLiB0aGlzIGFkZHMg
UEFNVCBiYWNraW5nIGZvciB0aGUgd2hvbGUgMk1CIHJlZ2lvbiBjb250YWluaW5nIHRoZSBnaXZl
biBwYWdlLA0KPiBub3QganVzdCB0aGUgZ2l2ZW4gcGFnZSBpdHNlbGYuIElzIGl0IHdvcnRoIGNs
YXJpZnlpbmcgaW4gdGhlIGNvbW1lbnQ/DQoNClllYSB0aGF0IGlzIGEgZ29vZCBjb21tZW50Lg0K
DQo+IA0KPiA8c25pcD4NCj4gDQo+ID4gKy8qDQo+ID4gKyAqIFJldHVybiBhIHBhZ2UgdGhhdCBj
YW4gYmUgZ2lmdGVkIHRvIHRoZSBURFgtTW9kdWxlIGZvciB1c2UgYXMgYSAiY29udHJvbCINCj4g
PiArICogcGFnZSwgaS5lLiBwYWdlcyB0aGF0IGFyZSB1c2VkIGZvciBjb250cm9sIGFuZCBTLUVQ
VCBzdHJ1Y3R1cmVzIGZvciBhIGdpdmVuDQo+ID4gKyAqIFREWCBndWVzdCwgYW5kIGJvdW5kIHRv
IHNhaWQgZ3Vlc3QncyBIS0lEIGFuZCB0aHVzIG9idGFpbiBURFggcHJvdGVjdGlvbnMsDQo+ID4g
KyAqIGluY2x1ZGluZyBQQU1UIHRyYWNraW5nLg0KPiA+ICsgKi8NCj4gDQo+IElJVUMsIFMtRVBU
IHN0cnVjdHVyZXMgYXJlIG5vdCBhbGxvY2F0ZWQgdGhyb3VnaCB0aGlzIGhlbHBlci4gV2h5IG1l
bnRpb24gaXQ/DQoNCk9oLCB5ZWEgdGhhdCBpcyByZW1vdmVkIHdpdGggdjYuIEknbGwgdXBkYXRl
IGl0Lg0KDQo+IA0KPiA+ICtzdHJ1Y3QgcGFnZSAqdGR4X2FsbG9jX2NvbnRyb2xfcGFnZSh2b2lk
KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiArDQo+ID4gKwlwYWdlID0g
YWxsb2NfcGFnZShHRlBfS0VSTkVMX0FDQ09VTlQpOw0KPiA+ICsJaWYgKCFwYWdlKQ0KPiA+ICsJ
CXJldHVybiBOVUxMOw0KPiA+ICsNCj4gPiArCWlmICh0ZHhfcGFtdF9nZXQocGFnZV90b19wZm4o
cGFnZSkpKSB7DQo+ID4gKwkJX19mcmVlX3BhZ2UocGFnZSk7DQo+ID4gKwkJcmV0dXJuIE5VTEw7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHBhZ2U7DQo+ID4gK30NCj4gPiArRVhQT1JU
X1NZTUJPTF9GT1JfS1ZNKHRkeF9hbGxvY19jb250cm9sX3BhZ2UpOw0KPiA+ICsNCj4gPiArLyoN
Cj4gPiArICogRnJlZSBhIHBhZ2UgdGhhdCB3YXMgZ2lmdGVkIHRvIHRoZSBURFgtTW9kdWxlIGZv
ciB1c2UgYXMgYSBjb250cm9sL1MtRVBUDQo+ID4gKyAqIHBhZ2UuIEFmdGVyIHRoaXMsIHRoZSBw
YWdlIGlzIG5vIGxvbmdlciBwcm90ZWN0ZWQgYnkgVERYLg0KPiA+ICsgKi8NCj4gDQo+IERpdHRv
Lg0KPiANCj4gPiArdm9pZCB0ZHhfZnJlZV9jb250cm9sX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2Up
DQo+ID4gK3sNCj4gPiArCWlmICghcGFnZSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJ
dGR4X3BhbXRfcHV0KHBhZ2VfdG9fcGZuKHBhZ2UpKTsNCj4gPiArCV9fZnJlZV9wYWdlKHBhZ2Up
Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfRk9SX0tWTSh0ZHhfZnJlZV9jb250cm9sX3Bh
Z2UpOw0KPiANCj4gV2l0aCBhYm92ZSBuaXRzIGZpeGVkLA0KPiANCj4gUmV2aWV3ZWQtYnk6IENo
YW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQoNCg==
