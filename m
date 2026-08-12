Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E33480955;
	Wed, 12 Aug 2026 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555338; cv=fail; b=snJAR+E7mt4ymguArrPuohjx3QiJ4ErBj9b2xavKaIr7EekgwAjeII7ZMOazvAHzGJOccKWowq+A0dVLF/eyd4na3izeHrdd5/wTIftxcVg4ROQ1y/mkopt9AvpHMDJ1UeGEUEg4fBS/VU19vHuh/EljmbxP+Lx4xzQrPMN4ZX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555338; c=relaxed/simple;
	bh=X3rsSJo+N0OHNlI1DvUKTSXK0f3kkL4xrpsdr/mf9GM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/NzyYnYaOeynuqLPuIYHNYK5i2v/BsAcWuI6GH+gnqEHum582XpEbphcnq60NZZ2gzR0Mz6laAnSFbhLJagNggU/SIJ7YPj/C/kRcRg4I4rAXNH2EK5v5Oe9yUw//q2otPAeW1qKgRllmeV1JI2Ipbu4fMPpA1oEW1nuvFy3Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV6Hmuy4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV6Hmuy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786555336; x=1818091336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X3rsSJo+N0OHNlI1DvUKTSXK0f3kkL4xrpsdr/mf9GM=;
  b=HV6Hmuy4px0snkUvRue6Ruf1YOPFRsivVG0F51tVzhLbfhAf960Tsk46
   wyQpHSDsYgIhnQKohIzqrUjQDrCeG4Fk3w3A36kD3Bu2VBa2AtEP2dcWO
   E7wMauT9kLomqR8dosrrj8o3GII+IlmRoM4YyHg2uiXd0DPihunXlH8il
   3Ftr/OyMVQgjyAUZNqop1On5dXhrA3KVNQejU8QRmazuy8zeMXsI4uEYE
   BLnhvCIdjuydp42VxW3TS/jy4exCIAYYo44so6c7DBaJzdZHCW7VwFK7D
   igAHOCWDHtfAnQydzsNRhAPcQo093kx2Ixdm1xs4EkuKLj8t3mBIm4h3o
   Q==;
X-CSE-ConnectionGUID: 8/d4sWL9RlaXaupkT3kfAA==
X-CSE-MsgGUID: OgmcrcvgTnyVJ3/gWUVTxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86996983"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86996983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 10:22:16 -0700
X-CSE-ConnectionGUID: RuCfmt4xS3i6iuKamuevHQ==
X-CSE-MsgGUID: 7Y9LWlRVQRybAdmG/JJXsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="263748485"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 10:22:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 10:22:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 10:22:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 10:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSv/M9uRpakn4FVFY50TsWQWYQoVrSnVIpvqNKXOC4RV28wr2DGgMaKjVfff9iV7hmwjym302jjlGs7M4Oau32Ev97/BbTVbPyZHgoL3sO6KjFxGu1ZkISHsafgQOba395PbotNYveBrtYavgPM47pXbJ3LjCQ6cWUOWVbAHFvbDmd0EWLlVZ03Un6JF2u14PCm5mDCeRgkqS8ykTeGfkUhtW++H4DntNQgdciHQKuV8UIGdMn0ZdO0Ta4BDajRNpwdgrj3ht+tEEy5VIHxs1uOTRMxu1XnlMIXL5ei6pu5Zpogxvnm2bKbh4+9XaU/Ecec8hTpbwQFBAylUmQokbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3rsSJo+N0OHNlI1DvUKTSXK0f3kkL4xrpsdr/mf9GM=;
 b=arW8FOm6JhRkC5rB1TNUgtf7VVk6+ScVGBph4EquroTxRNKY30mpQGD+VS3kzFOuebWFD/oa5Ai/+iRwfvi9A/ZBU9mTKRcI425FVBATAgVWu0f1kVcFkETyjqyHfwC5JeXV0Wqz69udkfZTaPxcmsnTmdM+95d4Gg+RCGoktvoGw9F9DgTdEXk8wUzoGDAi9kPH+4Cqpd1FpOhoUWnuvUYZPWpajseIEaArX+JHhaSZhZAZRfSBFw1+jXW1VdgJoFJ/rFNnvYRb+/huz6pd81umpq8ZNEbCVQxYW08tw/tzcbYem8QKZToiVOM5sWodCj91X2xBaTz4ov0YVNXu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 17:22:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 17:22:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Fang, Peter"
	<peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgA==
Date: Wed, 12 Aug 2026 17:22:11 +0000
Message-ID: <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
In-Reply-To: <anyiwqi9i0NSv0QW@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM6PR11MB4513:EE_
x-ms-office365-filtering-correlation-id: e825465f-7c21-4892-97ca-08def8963e9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|7416014|10067099003|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2DVjJpDtbEgYOsrh2tNfP9yFelQpa2+QN8ui19rztG2Wbq/g+GFN0y+REF7wxN2yvc7dFY/gE3egvDxyzdLQxpZy39/CLwf+9DKZRAzfvWb9h5gb8EzFqY1oYFn91K6MJr3bjVjd25BkLsvzroSAG7KyPKiIbwVgEpQKC2rmXKE68FD/DLtG4g2pjXBNevqSJGaSfFBaU0LFPPLe0TsYmNaAYb2BI1pLTsQrhKG9Vi6ufqI0xJegYsHIuX946N8rbUNUcnSmCVAjttz4S5JTnWioYzaVQtg62canuhaSQEDiz+GR9eB72mSd9GvIsUCpIv9Rtn98I3Pcdsq2dWbtA4H+04XHiTdtDtY6kBMKarFN4YTTsKUrvcj0p1ZwLRqy5hs4oCeQhjDPRNzNq5EoZGU5KGhuPhie69XSQMLNzEX9ldKoVOXZnGKk+NYx9dG+mZLW+zNkwdyynsKfEcgdEvObe2FwHhcx+XaggjDEjXfaeKvD+NkN9fGUDoMzNX9AQ9r0MvHL0eR0YZskiL8Zs7eTstaJ7s89F07o0UZ5yUCS9Ap2TOdPhSE/qfgri7d9WBYYcGWJlQB5O43uSe4Z3m0lOKNSKXk7m/eh23oShOOD1uf0ZcoB9G8ULlc5c1Hux24C44QWwS4ua1kTNFzILCuxKDm34uX63UBa55cj0bQtg+VGNxlZcTY3L6e9LWptTgjWLTSgQDyW1mlA4vDZEetKEr4jd+aGlXYFSMrtaoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkEwTC9LZmhxTUFqU1Avd2ZiSitmcEdvempERmpWK3JXS1dxZ2s4VXRyRzVl?=
 =?utf-8?B?YU53OTgyeGk2bk13UTUxczh1aklGa2k5SEUzV2VZVGZZa0UvUGpGT2dUb2hn?=
 =?utf-8?B?TFhNRmVvZHJ6elordktQTy9teWt2NE1PRmh6YXRyTU45TWEvaFpaRGs5QTFh?=
 =?utf-8?B?R3lUeXN0NURsUW40ZllOYTVpRXpzZWFFYkFBeTJXMytYMjNldGR3dU9JdDRk?=
 =?utf-8?B?QTJ3clljT3JHY0xFclBWV2NzSlB1V0plRWdYeHZDTmZkNmI0ZDl1Nmo3SzNH?=
 =?utf-8?B?VDNKUmVMTGFsNURPWlUzT2JTaFBjMXczYjFRU2h0ZEgyQURJUTlab3k1a1JS?=
 =?utf-8?B?anpXVW00ZVJ3TzZsbHlHTHJ6cjN6VW91cm4vT1BaMHBYYkVud2h0TTRXWWNO?=
 =?utf-8?B?WlJBVmRiQmdJNkk1dFJ3MUlDdDkvaU5md2o2T2pUc1lUZCtITmduVi9GOXlI?=
 =?utf-8?B?ZlhwSGZXM1l1TmZZS3dmdXlSL3RwU2RaMjhWL1I1OUxsNjJpeEE0K2EraFVE?=
 =?utf-8?B?YmRPZFlxMEZ0Z0hJWkhmeUMxaVNzWDF1bGtXVW51L2ZoQzFXSG54cWNranVJ?=
 =?utf-8?B?cG9jUG5XMVZsNEdnbngwVTJTbERPZ2k5UmlOTXhyYmxkSEgvd0xxNlNCVzV1?=
 =?utf-8?B?SDBFM0JKUkFWbEc2SEZWbWdLTXEvNnd5N1hRUUk3UERzeERMemZKQkVNYjA3?=
 =?utf-8?B?bzdRNlRXVlR3ZGl3RUNHQTZQY1hkVStkT3FHRGh2ZXZON2ZiMjBKUXRCbFFV?=
 =?utf-8?B?bldQS0MrQXNXVU5wRXdjZ3NSSm5mREQ4bHNHWjRnRFczV00wbmxpQjF6UW0z?=
 =?utf-8?B?REVjMER6c3Ridy9yNDVVd1F5WHJldHZyNGRhdmc0SnR2dVRpQllNcVQ0OVJR?=
 =?utf-8?B?eXFPcjNCYkp0blRVZVpPem04czJDYms4azg1UXdTWDhqWGRRNGMyeld3SEUz?=
 =?utf-8?B?TTBwekk5SHprNmlUVmJ5RXRVNlBLQVM4WkczNktkK3p3RHl6WmRLRlo4UkM1?=
 =?utf-8?B?Z29NUWtCeUdMTUprc1B1Q25MQjBxWlJkVGgvdWNXa1hrc244U0ZHcjkyb1Rl?=
 =?utf-8?B?TExVTlhvRXlpRlBxci9Sck4yTDIxSnh2TUtCaXpma3FnVHhDcmRyZFU0L2dC?=
 =?utf-8?B?aFpDQWdXZ2UvYUR0MTJET1RjSG5pK0VUMXlBKzJLTDZOVFF2SnJYTUV3SlNj?=
 =?utf-8?B?Um9hb1lHV1FhMDU1MW9TNHZmNzRBR09YR2ZDT0dSVWRHVGpXWndGaWc5bVo4?=
 =?utf-8?B?ZndOVU5ZWHFVVkxoaFc0cFFDemN1aS9nNkpKcURJTTA4YUtDdXMxcXIrSnR6?=
 =?utf-8?B?bDE5MW01blZnVWp6eHhtRFRtRGViLzRmWm92QnU1bW10b2pOQmtXVkNzQ3F4?=
 =?utf-8?B?Q0ZWcUhId1VhUGtSL0lIcFRzUmg4aDBkdDFlUjk4eFQ4RlRlS0ZlL2ZyM1FJ?=
 =?utf-8?B?dEVZaXJLTVdzeVRYb3d4TkE5eTBXVEJzU3o4cVppQW9GRXhnSitRVjBNOUFi?=
 =?utf-8?B?STg2SlVmeENjNnE1cEMxdkFXR2x1bW1KbjBGOFo3Y3NvT0RmVnFzOU5WaEIv?=
 =?utf-8?B?bnQyZmNKSGJ1VFpQY3NzbVZEUDM2Q0c4bjVXTjVRaFhwbExZQnhPT3RDMmhx?=
 =?utf-8?B?Nld1U2VCOFViRHZhdUJ0Mm10QSt0UlZpVGp2dTJrQStoNzhLVHFrbmhtNkZ1?=
 =?utf-8?B?UmJsMDJscGJFRFYyU0NpSTBPbElHbXBBZk5jTC9aR1RuL3krUm1mbWFML3FE?=
 =?utf-8?B?RGZEdGQ0L0hreE1PaiswL2xiWldpWDZRdEFwdW5DRGNiOVdNWUNkNkMvVXRX?=
 =?utf-8?B?R0k1ZlZIaDU1WVI2MnN5MkM0aFJhY1FTd2pFRThyT1hPV0VhRFVYY2hMQWZ6?=
 =?utf-8?B?Z3RlWm9OazZ5cVplR21FcGFIWll2cU9qZnVuUjIwZTRlbWV4ekw0bWVVZ1d6?=
 =?utf-8?B?ZVowM0pKNHZJQ3ZJR2pTT3NnWU9rUkRUVnpFQ0djcFdmcFA2UlA5UW1yV2Fz?=
 =?utf-8?B?SHppeldMVW5DM1BydXZ3bldQc3VveTBVZngweUlJTVZFbGVUZGZpdHplZUF0?=
 =?utf-8?B?ckNJN01YaEFib3d4TmdKeklKaFdtN0RXaDlseTJzZlhPK2Y0TXhIOXBmTEFS?=
 =?utf-8?B?YjlTbGYrTWpQcEZlRG1HbXJTeWVRdlZ5YVJNUUNiblBzSlFPK2NIOHlrallj?=
 =?utf-8?B?UkhiWEt6bzNZOEd6Yi9HRnVuNWJ5NTdPdFZweFU2VTM3U0lFbWVPSUFBcUts?=
 =?utf-8?B?S3NBK2krVFdOUkw4ZHRxdVBTZmh4SmVjL2VxTmZpdVdpT3pVUlo2UVIvL1By?=
 =?utf-8?B?V2s0dis0RkhzY040aUt6bUJScVFZV3E3MkZ3eVZUQ1M1dHVwT2ZTd1ZXRGlJ?=
 =?utf-8?Q?hyljsA5eZ0bAmggI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E436A17504EF1B49998EAB79385D4F27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ibz5RpFIzz+rtN01bU4wB67DHCzflY/pXLSI52Kxg+1XHb8WIn2CYL7anBUMCwytNDz76zQgsrgKY251Yu9lmCpolAj+Gj9b09x4M6l7roy2dHnePFvslHvrt2uPcXl6ovUntHzXWHqLPXZIK3xkFuAQlE0Jr8KO/5R1iONQAAM1ixrH+aVdoopkMzW5fsL18gAjQBsDdGT8BVjEVakLzREugEdgCfmRRp1u7tBgdkUhkyEdoL5MO0Djf7/yJgF4uXFLaMA4yrYUoVzrNg137FtZMu09OhArNhQkWr2xkEKrkRes28oXMXW5/NDD56EpyvZm8GOog5QglgNurTsWgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e825465f-7c21-4892-97ca-08def8963e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:22:11.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUrARFRv5k1oYmHcWDJ6njp7J/XcSlkWnT1VytQl8SzCdClO7iPjB/tEmaY/+znkCZMoogIE2Y12JXtU37NFj2/dUaFhMnnYR8OW1e6w6M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDA5OjQzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEl0IHNlZW1zIHRvIG1lIHRoYXQgZnJvbSB0aGUgb3ZlcmFsbCBzb2x1dGlvbiBs
ZXZlbCwgdGhlIHJlcG9ydCBzaG91bGQgbmV2ZXINCj4gPiBoYXZlIGhhZCB0aGUgZGV0YWlscyBp
biBpdC4gSXQgc2hvdWxkIGp1c3QgYmUgc29tZSBub25jZSBvciBzb21lIHR5cGUgb2YNCj4gPiB0
aGluZyB0aGF0IGNhbiB0aWUgdGhlIGd1ZXN0IHJlcXVlc3QgdG8gdGhlIHF1b3RlIHRoYXQgaXQg
ZW5kcyB1cCBnZXR0aW5nDQo+ID4gYmFjay7CoERvZXNuJ3QgaXQgc2VlbSB3ZWlyZCB0byBnZXQg
YSBidW5jaCBvZiBkZXRhaWxzIGZyb20gdGhlIFREWCBtb2R1bGUsDQo+ID4gdGhlbiBwYXNzIHRo
ZW0gZnJvbSB0aGUgZ3Vlc3QgdG8gaG9zdCBLVk0gdG8gaG9zdCB1c2Vyc3BhY2UgdGhlbiBiYWNr
IHRvIHRoZQ0KPiA+IFREWCBtb2R1bGUuLi4gd2hpY2ggYWxyZWFkeSBoYWQgYWxsIHRob3NlIGRl
dGFpbHM/DQo+IA0KPiBIbW0sIG15IG1lbnRhbCBtb2RlbCBvZiB0aGlzIGlzIHRoYXQgdGhlIHJl
cG9ydCBjb250YWlucyB0aGUgInJlYWwiIHBheWxvYWQsDQo+IGkuZS4gdGhlIG1ldGFkYXRhIGRl
c2NyaWJpbmcgd2hhdCBpcyBydW5uaW5nIGFuZCB3aGF0bm90LCB3aGlsZSB0aGUgcXVvdGUNCj4g
ZWZmZWN0aXZlbHkgc2lnbnMgdGhlIHBheWxvYWQgdG8gcHJvdmUgdGhlIHByb3ZlbmFuY2Ugb2Yg
dGhlIHJlcG9ydC7CoCBUaGF0J3MNCj4gd2h5IEkgdmlldyB0aGUgcmVwb3J0IGFzIFRELXNwZWNp
ZmljICh3aGF0J3MgcnVubmluZykgYW5kIHRoZSBxdW90ZSBhcw0KPiBwbGF0Zm9ybS1zcGVjaWZp
YyAocHJvdmlkZXMgcm9vdCBvZiB0cnVzdCkuDQoNCkFyZ2guIFNvIEkgdGhpbmsgSSB3YXMgbm90
IGNsZWFyIGVub3VnaCBpbiB0aGUgZGVzY3JpcHRpb24uIEFuZCBob3BlZnVsbHkgUGV0ZXINCndp
bGwgYXBwZWFyIHNvb24gYW5kIGNsYXJpZnkgdGhpcyBpcyBhbGwgY29ycmVjdCwgYmVjYXVzZSBJ
J20gcmVsYXlpbmcgd2hhdCBoZQ0KZXhwbGFpbmVkIHRvIG1lLsKgDQoNCldlIHRoaW5rIHF1b3Rl
ICpvcGVyYXRpb24qIGNhbiBiZSBwbGF0Zm9ybSBzcGVjaWZpYyBpbnN0ZWFkIG9mIFREIHNwZWNp
ZmljIGlmIHdlDQp3YW50LiBNZWFuaW5nIHRoZSBTRUFNQ0FMTCBpc24ndCBwYXNzZWQgYSBURFIu
IEJ1dCB0aGUgYml0cyB0aGF0IGFjdHVhbGx5IGFyZSBpbg0KdGhlIHJlc3VsdGluZyBxdW90ZSBh
cmUgVEQgc3BlY2lmaWMuIEluIG90aGVyIHdvcmRzLCBhdCBsZWFzdCBzb21lIG9mIHRoZSBiaXRz
DQppbiB0aGUgcmVwb3J0IGVuZCB1cCBpbiB0aGUgcXVvdGUgdG9vLiBUaG9zZSBURCBzcGVjaWZp
YyBiaXRzIGVpdGhlciBjb21lIGZyb20NCnRoZSBwYXNzZWQgaW4gcmVwb3J0LCBvciBhZGRlZCBs
YXRlciBkdXJpbmcgdGhlIHF1b3RlIG9wZXJhdGlvbiBiYXNlZCBvbiB0aGUgVERYDQptb2R1bGUn
cyBURCBrbm93bGVkZ2UuIEJlY2F1c2Ugb2YgY291cnNlIHRoZSBhdHRlc3RhdGlvbiBuZWVkcyB0
byBrbm93IGFib3V0IHRoZQ0KVEQgZGV0YWlscy4NCg0KT3IgSSBndWVzcy4uLiBpZiB3ZSB3YW50
ZWQgdG8gaGFuZCB0aGUgcmVwb3J0IGFuZCBxdW90ZSB0byB0aGUgdmVyaWZpZXIgYXMNCnNlcGFy
YXRlIHBheWxvYWRzLiBUaGVuLi4uIGZyb20gbXkgYmFzaWMgY3J5cHRvIHVuZGVyc3RhbmRpbmcs
IGl0IGNvdWxkIHdvcmsNCnRvby4gSXMgdGhhdCB5b3VyIG1vZGVsPyBJIHRoaW5rIGl0IHdvdWxk
IGJlIGEgbWFqb3IgY2hhbmdlIGF0IGxlYXN0Lg0KDQpCdXQgcGFydCBvZiB0aGlzIHRvbywgaXMg
dGhhdCAiRElDRSIgaXMgYW4gaW5kdXN0cnkgc3RhbmRhcmQgWzBdLiBTb21lIG9mIHRoZQ0KZXhp
c3RpbmcgVERYIGF0dGVzdGF0aW9uIGZvcm1hdCBpcyBURFggc3BlY2lmaWMsIGFuZCBtb3Zpbmcg
dG8gdGhlIHN0YW5kYXJkIGlzDQpleHBlY3RlZCB0byBtYWtlIHRoZSB2ZXJpZmllciBiZXR0ZXIu
IFNvIFREWCBkb2VzIG5vdCBoYXZlIGZ1bGwgZmxleGliaWxpdHkgaW4NCmNob29zaW5nIHdoaWNo
IGJpdHMgZ28gd2hlcmUuIFRoZXJlIGlzIHNvbWUuIEJ1dCBJJ20gbm90IHN1cmUgd2hpY2guDQoN
CkkgdGhpbmsgSSBtZW50aW9uZWQgdGhpcywgYnV0IHdoYXQgd2UgZXhwZXJpZW5jZWQgaW50ZXJu
YWxseSBvbiB0aGlzIGZlYXR1cmUgaXMNCnRoYXQgYmFzaWMgcXVlc3Rpb25zIGxpa2UgIndoZXJl
IHNob3VsZCB0aGUgcXVvdGUgdUFCSSBsaXZlIiBxdWlja2x5IHNwaXJhbCBpbnRvDQphIGxvdCBv
ZiBURFggYXJjaCB0cmFkZW9mZnMgYW5kIGxlZ2FjeSBjb21wbGljYXRpb25zLiBJJ2xsIHRha2Ug
aXQgd2Ugc2hvdWxkDQpwcm92ZSBvdXQgKDEpIGEgYml0IG1vcmUgdG8gZ2V0IGJldHRlciBjbGFy
aXR5IG9uIGlmIHRoZXJlIGFyZSBhbnkgc25hZ3MuDQoNClswXSBodHRwczovL3RydXN0ZWRjb21w
dXRpbmdncm91cC5vcmcvcmVzb3VyY2UvZGljZS1hdHRlc3RhdGlvbi1hcmNoaXRlY3R1cmUvDQo=
