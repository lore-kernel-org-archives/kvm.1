Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D753C4178;
	Wed, 20 May 2026 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315746; cv=fail; b=lplOSqS2NPv4EP330LuQsRd+q2866C+aPHVgp1t2ssUkiH4utPVPxBlBPjJ5Qj4T43R4WX5JtIzcQZU+fPE5ZfBbtldsvLQmtGfE4zKc0dmp0dVOurVtw4K5WiZ/S7ZvrfK2sqQDRwzbPt3ybiIYW/HLqBJi9V0L5N1qoDoI0IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315746; c=relaxed/simple;
	bh=p5Xaj1lOZvEtZtyo4tCyrkXMqRBvr1yuLA3+0eHG3h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aiOc1JIDdilaTWFq31+U1xbgza5Sex6JNx/L0Tov9VRrZdonNvnXgytqDH/Vh4tZBr2+HZ9Z/oz3doxrUvp/TzUl1ZWRauqJ3aoHUIg3BOm0YQk9vj8vvXa/t0CJ+6nh4qeyX7dTBk6Mw+ghTPs1P/CWY6uDGOC0fi0LonQrQuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVBKaimq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVBKaimq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779315745; x=1810851745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p5Xaj1lOZvEtZtyo4tCyrkXMqRBvr1yuLA3+0eHG3h4=;
  b=OVBKaimqPR5ul2pPEaBYZRG0Gas+d3s57pb7uy6Jx6v8u8x2yvwoU19m
   +8FCKgXuv+b8xDQOfkBgW2Dkx1H8FPqcpZWwqjROaTHvoDe9aTUYdl0Wz
   rh792fVd1DiN/mXfV/cPTu3ZgnpAvX1yj/ktsgNy29sj091COCvKgc3jB
   NHRFNwDZxTYVjwYZv/9ImcExhOGKizChfHRd+f+b/tCxxsCd506ytVIN4
   P/YvxnUFY5nXo/CLH0YnSy1ZldeH+vO/m6c403OtoHRH5m8ND4xmWWBW6
   B2OPzroYcwpFdqFHzKVAgrEDiVO8Gn9T+I2rxqn0DXYzCMuxo3ieuM5qN
   w==;
X-CSE-ConnectionGUID: sK2lqxk3RjujkJ8eEr1ifQ==
X-CSE-MsgGUID: AxipVV0RTXWCzf6kpQTaUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79255096"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="79255096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 15:22:24 -0700
X-CSE-ConnectionGUID: 6bK37J5dQfqMUMkWyYliCQ==
X-CSE-MsgGUID: T8Sk30N5SeeXA8Djf7Of9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="278452618"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 15:22:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 15:22:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 15:22:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 15:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyO3H1X/9key+C4ymGtLeIXMw5fTiPQzGqJTQfnL4TgRZoIl3XlKKAeQP5PrxwbHJxcjUwBbdykBzLUnvkAbKKk9NrQJigB6Ky4LIYMKIbfN6G+OiNtY4WTwUs2iOnEoVLRljlUYfJ1+KFsZAgl6cSQ1fxK13Y1lGXqpBxpzJHBgw5fkleuuvu74zUpUeq+WVJ/oiS7UiyCr1R1eMkC9jxfqZt4RT6YVx4dT08g0oTB8CGQws3Agf+EXaiVbo7Z07quCt05jcI8WTffNKAhs6TSe9NtTig3lIkyzY2uE1ZVSYMlfQF/c1gIYuXCrXEe7u/M9uDLMjoM5ds6WoCXnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5Xaj1lOZvEtZtyo4tCyrkXMqRBvr1yuLA3+0eHG3h4=;
 b=S5bRBebExN0aO7w0Tu/IPz/ZpuipaksqTLdDd3gNdiBOhMhNE3h7n8DdcxJpS1SzX9KWRY6zHqkW99kO473u1ceAqKpPrIs43ERvZjDP2Pa9gVn4xU5osWCNRV1LbrJEiZ+6ZRp4xrZNEBgE362vg3bx27LkNbjT7XkI6DXBwG9+0cg1cDDPuzfuijwZiVDzXDvxfJmusN/b4WtMnED2xybPtHe5WtLzN+704li6DVTshIfGXZtOIVvfk0n9lkqM11qj0TCqVLeUHwOnlonVmyXWlT9C2tXng+xqBN5a904WlxHUp+KS4qZSNPCp5K/jMMs/f3xeoF1TyBA1uUWo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 22:22:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:22:04 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"paul@xen.org" <paul@xen.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Topic: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Thread-Index: AQHc4+xAhMVQIxjW5UeBHPSlwKOJO7YVStWAgAAu1ICAAKY3AIAAB2oAgAARyACAAQcxAIAARgyA
Date: Wed, 20 May 2026 22:22:04 +0000
Message-ID: <0ed747418eaef45a8c161ab5a9e28a12c604f9ea.camel@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-16-seanjc@google.com>
	 <074e209fe4c78a735868099f13d76b9dde2c88e3.camel@intel.com>
	 <agx77QB3UVmJr5xP@google.com>
	 <729c4191d16e4c768c231ffb9bb8420306039210.camel@intel.com>
	 <ag0NlJ2FEIL7GJIj@google.com>
	 <4a918cb38dccd4ef7a2d84d16f5044472d069f7c.camel@intel.com>
	 <ag35RgwowvR9Q4hA@google.com>
In-Reply-To: <ag35RgwowvR9Q4hA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7681:EE_
x-ms-office365-filtering-correlation-id: 11bbc0f6-4247-44bd-ad07-08deb6be38b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003|6133799003|11063799006|3023799007|4143699003|38070700021;
x-microsoft-antispam-message-info: 3gJ6lf+/vjrEgCZ7NgMc0uihaEZRszMPPFyqr+Kd4rog2mVqxjOxd4CFp1Mn1+eXsoTwYgLL40EOvDJ3CGcHMT5tvvM+GNjES2NvwqHs7XNg4THChpD9/9AheTmF1vWs9xBPn8z3kzDwTzyX9Kk0MkAV+5QHT5DSirMdCScGSaGTP0+Fq2YJBynmJqNxOiZTSalFW157dpA5AEbf+6XQQb1kKXOt/XtONeYHZyGuQ96jt51Ba7kDh+KiOIcMgtXjtLPO8d2Ur8pzy9c2cywcZBHktTCBGynqzAX8VjhRPjJKc4uKvAkuMpbo2YJuMDbbH15tqin0iRUTm95uun3EMUBFYGZFtymaspPn9ZHdmibp+X3F4gdcjnjrjcTALVVWwBC9eU2Atfl5blMD1VGT80166BQXhvJvK0Le+tOd6qDhqvM46AM9XIiYtvbhH0t3jo9F4flXAIdIrkwNWu0C6PZ2ia8fVZvFBHG9C9spN8lZcwE4zTeGx7O+mgxMutgFHKWu/wjsFjm7qXe3RV72iy9IIICoKNS6mRfs9ZfXFxGcl8TiFemMjbA6nncAR2sn1cv8Pv/CwGxHRSW1oBAzoHbGj4SpAAa99HinpI3UUhHx1yXmp+/cu86SIlZk7D5PJwJ3E4ucC0A9pg4Cf0yZygB5NF1JpHCvtJ5Q4Ue4jHT+uNslAJG1ZgkOU7O9bbP2YFrUVk4IGAa901OAjtGhssBUJpYlLOhSA+VSbutLEyLndNofovD2W0DdnfKMK9Dh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(3023799007)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHd6bDVacnd4SVlXdzdkVHd6TkdWRkJGWFpLYWlDbWxvei9ZRTNVNlptZmky?=
 =?utf-8?B?ZnJYWHNPdjJ2QzhYa3hyS0xuZ1UvbXVxQXlkU1BTZjBtSXlRODF4dkxlTHBt?=
 =?utf-8?B?bWZmcmUxRjF0aTRnekRkank1aFBwdnprcTRYMGhGNE9LbFlKbERPV3F6d1F2?=
 =?utf-8?B?dHljWDNLOU9mYXpxWUZTSG5TMDZJTXZhZG9CQzZvTjV1WC9DMEhkR2tmY1h6?=
 =?utf-8?B?K3RyUFVIbHhFOVBBVDZZcVNuWlRodHpkTGJtdFN6NGhkZno4R003N1hpQ2hC?=
 =?utf-8?B?VGczNEs5Ly81clhzR1h5WDBLTFNyVGVXeUJyVHhPQlNwUmNYWFo1ejhyOEQr?=
 =?utf-8?B?cytBam0rZkc2U1V4YTk5ODBUbHgxUlRsUkovc01jcE9vUWR0Ty93VmVmeHFU?=
 =?utf-8?B?Y2I4V2ZMcjZFOE8yZmdzelFoV1pBbEVMK2NleTJBZmV2ZnZmTDZ3azRSekdT?=
 =?utf-8?B?Y1ZtdllwSGNxS0kvbGFRZ21qdTluVXpRSU1CSVBrQmYvTmV4WVVieG9vVFA1?=
 =?utf-8?B?UFNubG9xTk1FMCs2Mm04VXYvUGRDUW5Pa1pIYXZMSkcvQU1DTjI5RWc0ZHlT?=
 =?utf-8?B?SitIcDJXci9rSWFzblhxOTk5UGFKTmovYmM2Qk1qSlNHVFhSeURXNUV6Z0Ju?=
 =?utf-8?B?cVFIWXZpZ2NJSXp3VStHSzFWUzg3cllUMVBDNnVlMDlLMWwxeTVUblFLbXNw?=
 =?utf-8?B?a01tRk5Pb0RZT3l0YmVoUUZUTm4reXF0emZBVnVTVnVYTFJNSmU4TUx5UG9q?=
 =?utf-8?B?VjR1YUJJTCt6V09VWFAvZzNiam95M3dIWDN2RHhScXFEOWNCQmdOeWdpbStJ?=
 =?utf-8?B?OENUQU82SW5tazR5dnNEU00rS2dERGxRbjNMT2FTOEFBUzNqY0xNSktMdmE2?=
 =?utf-8?B?VnNBVGtLV2RZRHdHY1Z3ZGdrc1FzZGlYY2JxVnVjb0NnK1ZHb0dwdmJaQVNs?=
 =?utf-8?B?SDdjZ2FXbC9CVGd1UEs5ZjlmVUlkNGlQSkpUZnowalk0K1BoMGt0SDFvMXE4?=
 =?utf-8?B?VDJMbzZ5YWJBb1JabFRmdGxRbmI3citaaDZpMDc1a0d2OWFKY085ZTc3cDNp?=
 =?utf-8?B?R0E1Y0RVSnJsZ3lzZjVmWjQwUVRIZ3lMdE9KMkhlREpLRk1Kdk9MVUFFNktn?=
 =?utf-8?B?Q1g4bVhwblZVN2Y2OUhuMlNNTXFDbE9XTkNSS1hvNVRnbkFRSEx6eUkyTkl3?=
 =?utf-8?B?b28ycEtQaWFKS0dmVjY4LzB5TklLT25UWDhub2NmN0NkdGE1L3Q1Umh6ZFlz?=
 =?utf-8?B?Zy9wNklqZHc1THUrMDR2Qm83N1p2U3RDZlFCSGdSdDNXSll2a1QwZkgwS2tx?=
 =?utf-8?B?MHdPRFVmdGNBVjdpWDVNTCtLWDBheHJRaTlndlVsMjJpUmxRTlRJL3RXeFdC?=
 =?utf-8?B?clcrOVRJdWZsV0hiaXk1V2VSeGJHY2lENjkvc2FRQlFoRFBLT25xbDgwMUNo?=
 =?utf-8?B?S2NSN3I5djhSMHFPd1R1V2l6R3MwdUt0djVibjdoU1JIR1NCWGdveFlJMWNw?=
 =?utf-8?B?SE5OWXJ1dXAwYWZkQkZEUk1xRjRWYXc2SWU5aXRjTzg4a1N4R3pVbG9rOEhG?=
 =?utf-8?B?c21NWXl3dG9hcG9lOHAxZ3orSXZ6Qk9xSVBTQXl6UlhJR0JNQ1lCbUVicUMx?=
 =?utf-8?B?QVNRNi9YWkhDeWlZelZDRG9MWlhzSk9acW1yMjQxNFI5aDNjMStzUlFEdHk2?=
 =?utf-8?B?NklpQ00vVXp3L2Z2WllUcTVrbjRQenhWUGRMN1BCcjFjZThtbFVWT0lqTjg2?=
 =?utf-8?B?dmpTVUNyUW1mekFMVUNSU3dqV3czdUpZa3lHQXFFaHdCVjc4ZVJHbUxZL3hp?=
 =?utf-8?B?dFVndzRoN0tTTU1OcWVjWTVYM0pTL29OZEkvSDdqY05VR1AzQWJCQldZbjFZ?=
 =?utf-8?B?bE1jcXVMMzFscFRPdVdmSGxlUjhieExRV2QvY09TVWFoWi9GMGIvMUFDeFB2?=
 =?utf-8?B?d1RBbzBBcFhMZlFOZEZ3YkFXcWpyeE9OUDhEaGE5b3lvTjRyRUQ2YjFaWi9G?=
 =?utf-8?B?SkVxcGx0UXNRNldKYjE2cENZcjd3MW55Wmw5OHh6ZWNoT05SSHRBRTRrb0t2?=
 =?utf-8?B?ZlVoOTUrN2xCT0VVNWhnaUV2VzRkdzhqSHBNSzlhSEVTcDMzWklCOXRCWEh1?=
 =?utf-8?B?NXc0QzVmRXJMeUw0b29JQ0w5cG1LR3JJaDRLdkJXZW5XR2tZSC8xa3h5OE9P?=
 =?utf-8?B?eFZ5ZzNkcHVqbThUV1VDSURzMnIzUjNSNHdjdGhHSGlubGVmVkQ2YlFtSnda?=
 =?utf-8?B?Sk5qaDYvUiswVHZDWTZHR1Y1NmR3NnZPcnBHYjU4dWhKSWhBVGpNVzc3ZUFU?=
 =?utf-8?B?RGZBWE9CZHhSR3BzZHVZa3hXYXRCeEhXZVpsZTBuSDAwNVBqeG8vQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE8A4CE727D2A418A11CA78DBB512F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xkb6BPpZAqnxeLBzwo9JcoYnqXrSJ5icMzcM51GsvWb9TMTnmPdfG0FnCwdizq6Pnor92DT8eyE0yK5b26AyHhzQBB3tSnDRMs8Sxxxu7GuI+4FaBq3DiazrE43J/JDp0FZX2tpCcS0dImYk+l1Eiz17COCZyQFDGDzAEfu7jj80NomqyyKOk5jEirETxu49pKbSYmEBhBEBRcoDVVIYv3mI/m9uU57MaomYlrRmxoiCiXgA+xklcnmoMf38GIDmN30YSOf2Nn1mTz3JsvANijgB37Y/pxK6bnoVnZ30NirLUdaFvMCncbc9S4DVq0dS97rRz+MPkT6D85t0K/dVDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bbc0f6-4247-44bd-ad07-08deb6be38b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 22:22:04.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyM8ZqzWJW51xe6WiQak2gIXczof7SvStcU3p5OcKVVURiAF1NXhOaV2bcSaJAd+veSNzLQ6XiSiziXY8+nW9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDExOjExIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIE1heSAyMCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wNS0xOSBhdCAxODoyNSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE9uIFdlZCwgTWF5IDIwLCAyMDI2LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IEkg
YW0gbm90IHN1cmUgd2hldGhlciB0aGVyZSdzIGEgbWFuZGF0b3J5IHJlcXVpcmVtZW50IHRoYXQg
InN0cnVjdCBrdm1fYXJjaCIgYW5kDQo+ID4gPiA+ICJzdHJ1Y3Qga3ZtX3ZjcHVfYXJjaCIgbXVz
dCBiZSBmdWxseSBlbWJlZGRlZCwgYW5kIGl0IHdvdWxkIGJlIGtpbmRhIHBhaW5mdWwgdG8NCj4g
PiA+ID4gY292ZXJ0IHRvIGEgcG9pbnRlciAoZS5nLiwgdGhlcmUncyBrdm1feDg2X29wczo6dm1f
c2l6ZSksIGJ1dCBwZXJoYXBzIHRoYXQgaXMNCj4gPiA+ID4gYWxzbyBhbiBvcHRpb24gdG8gY29u
c2lkZXI/DQo+ID4gPiANCj4gPiA+IFRoZSBpZGVhIEkgaGFkIGluIHRoZSBwYXN0LCBhbmQgd2hl
cmUgSSB3YXMgZ29pbmcgd2l0aCB0aGluZ3MgYmVmb3JlIHMzOTAncyBsb3ZlDQo+ID4gPiBmb3Ig
YXJtNjQgY2FtZSBhbG9uZywgd2FzIHRvIGFkZCBhIGt2bV9hcmNoLmggaW4gYXJjaC88YXJjaD4v
a3ZtLCBhbmQgaGF2ZSB2aXJ0L2t2bQ0KPiA+ID4gaW5jbHVkZSBfdGhhdF8gaW5zdGVhZCBvZiBr
dm1faG9zdC5oLiDCoA0KPiA+ID4gDQo+ID4gDQo+ID4gTm90IHN1cmUgd2hldGhlciB0aGVyZSdz
IG90aGVyIGNvZGUgZG9pbmcgc28/IDotKQ0KPiA+IA0KPiA+ID4gVGhhdCB3YXkgd2UgZG9uJ3Qg
bmVlZCB0byBtYWtlIGFueSBmdW5kYW1lbnRhbA0KPiA+ID4gY2hhbmdlcyB0byBzdHJ1Y3R1cmVz
LCBidXQgd2UgY2FuIHN0aWxsIHNpZ25pZmljYW50bHkgY3V0IGRvd24gb24gd2hhdCdzIGV4cG9z
ZWQNCj4gPiA+IHZpYSBrdm1faG9zdC5oLiDCoA0KPiA+ID4gDQo+ID4gDQo+ID4gWWVhaC4NCj4g
PiANCj4gPiBJIHNhdyBiZWxvdyBmcm9tIHlvdSBpbiBbMV06DQo+ID4gDQo+ID4gICAtLQ0KPiA+
ICAgV2UndmUgZXhwbG9yZSBzZXZlcmFsIGFsdGVybmF0aXZlcyB0byB0aGUgI2lmZGVmIF9fS1ZN
X18gYXBwcm9hY2gsIGFuZA0KPiA+ICAgdGhleSBhbGwgc3Vja2VkLCBoYXJkLiAgV2hhdCBJIHJl
YWxseSB3YW50ZWQgKGFuZCBzdGlsbCB3YW50KSB0byBkbywgaXMgdG8NCj4gPiAgIGJ1cnkgdGhl
IGJ1bGsgb2Yga3ZtX2hvc3QuaCAoYW5kIG90aGVyIEtWTSBoZWFkZXJzKSBpbiB2aXJ0L2t2bSwg
YnV0IGV2ZXJ5DQo+ID4gICBhdHRlbXB0IHRvIGRvIHRoYXQgZW5kZWQgaW4gZmxhbWVzLiAgRXZl
biB3aXRoIHRoZSBfX0tWTV9fIGd1YXJkcyBpbiBwbGFjZSwNCj4gPiAgIGVhY2ggYXJjaGl0ZWN0
dXJlJ3Mga3ZtX2hvc3QuaCBpcyB0b28gaW50ZXJ0d2luZWQgd2l0aCB0aGUgY29tbW9uIGt2bV9o
b3N0LmgsDQo+ID4gICBhbmQgdHJ5aW5nIHRvIGV4dHJhY3Qgc21hbGwtaXNoIHBpZWNlcyBqdXN0
IGRvZXNuJ3Qgd29yayAoZWFjaCBwYXRjaA0KPiA+ICAgaW5ldml0YWJseSBzbm93YmFsbGVkIGlu
dG8gYSBnaWdhbnRpYyBiZWFzdCkuDQo+ID4gDQo+ID4gICBUaGUgb3RoZXIgaWRlYSB3ZSBjb25z
aWRlcmVkICh3aGljaCBJIHRob3VnaHQgb2YsIGFuZCBmZWVsIGRpcnR5IGZvciBldmVuDQo+ID4g
ICBwcm9wb3NpbmcgaXQgaW50ZXJuYWxseSksIGlzIHRvIG1vdmUgYWxsIGhlYWRlcnMgdW5kZXIg
dmlydC9rdm0sIGFkZA0KPiA+ICAgdmlydC9rdm0vaW5jbHVkZSB0byB0aGUgZ2xvYmFsIGhlYWRl
ciBwYXRoLCBhbmQgdGhlbiBoYXZlIEtWTSB4ODYgb21pdA0KPiA+ICAgdmlydC9rdm0vaW5jbHVk
ZSB3aGVuIGNvbmZpZ3VyZWQgdG8gaGlkZSBLVk0gaW50ZXJuYWxzLiAgSSBoYXRlIHRoaXMgaWRl
YQ0KPiA+ICAgYmVjYXVzZSBpdCBzZXRzIGEgYmFkIHByZWNlZGVudCwgYW5kIHJlcXVpcmVzIGEg
bG90IG9mIGZpbGUgbW92ZW1lbnQNCj4gPiAgIHdpdGhvdXQgcHJvdmlkaW5nIGFueSBiZW5lZml0
IHRvIG90aGVyIGFyY2hpdGVjdHVyZXMuICBFLmcuIEkgaG9wZSB0aGF0DQo+ID4gICBndWFyZGlu
ZyBLVk0gaW50ZXJuYWxzIHdpdGggI2lmZGVmIF9fS1ZNX18gd2lsbCBhbGxvdyB1cyB0byBzbG93
bHkgY2xlYW4NCj4gPiAgIHRoaW5ncyB1cCBzbyB0aGF0IHNvbWUgZGF5IEtWTSBvbmx5IGV4cG9z
ZXMgYSBoYW5kZnVsIG9mIEFQSXMgdG8gdGhlIHJlc3QNCj4gPiAgIG9mIHRoZSBrZXJuZWwgKHBy
b2JhYmx5IGEgcGlwZSBkcmVhbSkuDQo+ID4gICAtLQ0KPiA+IA0KPiA+IEkgaGF2ZW4ndCBsb29r
ZWQgaW50byBkZXRhaWxzIG9mIHlvdXIgI2lmZGVmIF9fS1ZNX18gYXBwcm9hY2ggeWV0LCBidXQg
c2VlbXMgeW91DQo+ID4gZG9uJ3QgcXVpdGUgbGlrZSBtb3ZpbmcgS1ZNIGludGVybmFsIHN0YWZm
IHRvIHZpcnQva3ZtL2luY2x1ZGUvID8NCj4gDQo+IE5vdCBmb3IgYXJjaCBjb2RlLCB3aGljaCBp
cyB0aGUgdHJpY2tpZXN0IGJpdCB0byBoYW5kbGUuDQo+IA0KPiA+IEJ1dCBpZiB3ZSB3YW50IHRv
IGhpZGUgS1ZNIGludGVybmFsIHN0cnVjdHVyZXMsIEkgZG9uJ3Qgc2VlIGFueSBvdGhlciBvcHRp
b25zDQo+ID4gZXhjZXB0IHZpcnQva3ZtL2luY2x1ZGUvIGlzIHRoZSBwbGFjZSB0byBnbz8NCj4g
DQo+IGFyY2gvJChBUkNIKS9rdm0va3ZtX2FyY2guaCBpcyB0aGUgb2J2aW91cyBhcHByb2FjaC4g
IENvZGUgaW4gdmlydC9rdm0gY2FuIHJlYWNoDQo+IGFyY2gvJChBUkNIKS9rdm0sIHdlIGp1c3Qg
bmVlZCB0byBhZGQgaXQgdG8gdGhlIGluY2x1ZGUgcGF0aC4gIFRoYXQncyB3aHkgSSB3YXMNCj4g
d29ya2luZyBvbiB1bmlmeWluZyB0aGUgaW5jbHVkZSBkZWZpbml0aW9ucy4NCg0KWWVhaCwgZm9y
IGFzbS9rdm1faG9zdC5oLg0KDQpCdXQgaWYgSSBhbSBzdGlsbCBmb2xsb3dpbmcgeW91IHdlIHN0
aWxsIG5lZWQgYSBwbGFjZSBmb3IgbGludXgva3ZtX2hvc3QuaCwgZm9yDQp3aGljaCBJIHRob3Vn
aHQgdmlydC9rdm0vaW5jbHVkZS8gd291bGQgYmUgdGhlIHBsYWNlIGF0IGZpcnN0IGdsYW5jZS4N
Cg0KPiANCj4gPiBCdHcsIGhhdmUgeW91IGNvbnNpZGVyZWQgcmV2ZXJ0aW5nIHRoZSBpbmNsdXNp
b24gb2YgInN0cnV0IGt2bSIgYW5kICJzdHJ1Y3QNCj4gPiBrdm1fYXJjaCIgKGFuZCB0aGUgdmNw
dSBzdHJ1Y3R1cmUpLCBpLmUuLCB0byBtYWtlICJzdHJ1Y3Qga3ZtX2FyY2giIGluY2x1ZGUNCj4g
PiAic3RydWN0IGt2bSI/ICBJIGRvbid0IGhhdmUgYW55IGNsdWUgb2Ygd2hldGhlciBpdCBpcyBm
ZWFzaWJsZSBvciBob3cgbXVjaA0KPiA+IGVmZm9ydCBpdCBuZWVkcywgdGhvdWdoIC0tIGl0J3Mg
anVzdCBzb21ldGhpbmcgY2FtZSB0byBtaW5kIHdoZW4gcmVwbHlpbmcuDQo+ID4gDQo+ID4gWzFd
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MTYwMDMxMTguMjU0MDY2MS0xLXNl
YW5qY0Bnb29nbGUuY29tLw0KPiA+IA0KPiA+ID4gQXQgc29tZSBwb2ludCBJJ2xsIHRyeSB0byB0
YWtlIGFub3RoZXIgbG9vazsgaXQncyByZWFsbHkgdGhlDQo+ID4gPiBzMzkwK2FybTY0IGNvbWJv
IHRoYXQncyBwcm9ibGVtYXRpYyA6LS8NCj4gPiANCj4gPiBJZiB5b3Ugd2FudCwgSSBjYW4gdGFr
ZSBhIGxvb2suICBJIHRoaW5rIEknbGwgaGF2ZSBiYW5kd2lkdGggaW4gbmVhciBmZWF0dXJlLg0K
PiA+IA0KPiA+IEdpdmVuIHlvdSBoYXZlIHRyaWVkIG11bHRpcGxlIHRpbWVzIHNvIEkgYW0gbm90
IHN1cmUgd2hhdCBJIGNhbiBhY2hpZXZlLCB0aG91Z2guDQo+IA0KPiBDb25zb2xpZGF0aW5nIGlu
Y2x1ZGVzIGFuZCBjcmVhdGluZyBhcmNoLyQoQVJDSCkva3ZtL2t2bV9hcmNoLmggc2hvdWxkIGJl
IG1vcmUNCj4gZG9hYmxlLMKgDQo+IA0KDQpSaWdodC4NCg0KPiB3aGF0IGhhcyBmYWlsZWQgc3Bl
Y3RhY3VsYXJseSBvdmVyIGFuZCBvdmVyIGlzIGVmZmVjdGl2ZWx5IHRyeWluZyB0byBoaWRlDQo+
IG1vc3Qgb2YgYXNtL2t2bV9ob3N0LmgsIHdoaWNoIHNvdW5kcyAqcmVhbGx5KiBzdHVwaWQgd2hl
biBJIHBocmFzZSBpdCB0aGF0IHdheSA6LSkNCg0KSSBzZWUgOi0pDQoNCj4gDQo+ID4gQW55d2F5
LCBzZWVtcyAiYWxsb3cgbG9hZGluZyBhIG5ldyAob3Igb2xkKSBLVk0gbW9kdWxlIHdpdGhvdXQg
bmVlZGluZyB0bw0KPiA+IHJlYnVpbGQgYW5kIHJlYm9vdCB0aGUgZW50aXJlIGtlcm5lbCIgaXMg
YSBnb29kIHJlYXNvbiB0byBkbyB0aGlzLg0KPiANCj4gTm90ZSwgd2UndmUgc2NyYXBwZWQgdXBz
dHJlYW1pbmcgbXVsdGktS1ZNLCBhbmQgSSBkb24ndCBzZWUgaXQgZXZlciBnZXR0aW5nIGFjY2Vw
dGVkDQo+IHVwc3RyZWFtLCBhcyBsaXZlIHVwZGF0ZSBpcyBmYXIgc3VwZXJpb3IsIGUuZy4gaXNu
J3QgbGltaXRlZCB0byBqdXN0IEtWTSwgZG9lc24ndA0KPiBoYXZlIHRoZSBzYW1lIG9yY2hlc3Ry
YXRpb24gb3IgdGVzdGluZyBwcm9ibGVtcywgZXRjLg0KPiANCj4gQW5kIEZXSVcsIHRvZGF5LCB5
b3UgX2Nhbl8gcmVsb2FkIGEgbmV3IChvciBvbGQpIEtWTSBtb2R1bGUgd2l0aG91dCByZWJ1aWxk
aW5nDQo+IHRoZSBrZXJuZWwgb3IgcmVib290aW5nIHRoZSBob3N0LCBpdCdzIGp1c3QgdGhhdCB5
b3UgY2FuJ3QgbW9kaWZ5IGNlcnRhaW4gc3RydWN0dXJlcy4NCg0KUmlnaHQuDQo=
