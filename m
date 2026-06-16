Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF8305688;
	Tue, 16 Jun 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652634; cv=fail; b=epOuwZqVfIPySGuh8Rmskjr9gL4AIdJL+/1JbRiLLrg6hezJKcpRGBZsctSPt4zftrsW7PLreH0J9svwDtXcNj5MDUUBiPJwXi3MI3i0V2ZsRYlfv0rNU3zHcR1Gmt+bpcDUPLGThoSq8OLUZvLS30iNGQOeaThLXwziCrZbQpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652634; c=relaxed/simple;
	bh=tB/fCIOsBUyr6h+Lf6aH4+130J/eiNuWueuhFmMi0TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bYkQtHXHisNNusaHq2LU1CIeF/bn92lWZAoWKpq8g+Vs4eTCJT1jxMaqS54nPZJURsooroW6z6VP5yHTeqXSB7qCCn94ywPiUYFuap7aNneSoRk4Xwp80wp3ddJOd3m+uzKSmYbagsOjUa44ToLJoH8GVRokqiUxU+sfLFxZW2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkQ/DFUJ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkQ/DFUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781652633; x=1813188633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tB/fCIOsBUyr6h+Lf6aH4+130J/eiNuWueuhFmMi0TM=;
  b=EkQ/DFUJsw5WQZZ34X+bzyU2hXGqEJ+P5yj4SOzphHDJlXwXXHMQIAbk
   FkzOHwmXbvoDKwtzZzPHKYVCbTBFK4yQp5LC5I3INkkoJ1nFtxedGrgfd
   d3fACADJaZiuL5kYw2D71UPVCQGEPDAb2+ui347nstfPqgafsXUTj+vPq
   5H9AGH13pTwKSQ9cObIuoLVSqabvwW4KNKKXxILjal0yC1VZkFRlsTncJ
   4q6Orw+R7QShh11WBxvY+Q9re9KdnDuPJKRG9CQ6CCEL8fsD3pgXlkNRc
   4YRfoG9FjvRGgIuMA/pXBzDa4JFIC0ykqylGBNgAQnwwG2BWqB5xOKwh6
   w==;
X-CSE-ConnectionGUID: 3arhN9roRpOKDNLL7k8Ghg==
X-CSE-MsgGUID: YdtUa3AsSJGRpqRgj2Cv/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82200425"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82200425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 16:30:33 -0700
X-CSE-ConnectionGUID: Nnj4mxnyRgqDxDEh+30y4g==
X-CSE-MsgGUID: c9OjwFWTThmb4zz+bQ57+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="251820135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 16:30:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 16:30:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 16:30:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 16:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEgDRjPX5kYIQzE1koDyDU4/2WlURlSqp9k3wq+xIFXDKmRW507/g0x5DJ6wIBfCEj9GcERiGB0o6QuYRK4KYVlC34IdRT3B0bPUjSqosBnDmkr+SikfkzvSCF1BZ4pJXaM4YaAKwTsSg1HAZBGi34zQATD3zBfMH8CPNiV8sHh1M5iapELFFwXMDRrNRQfGcPB35JK6qiZzHnQ7zlHwgsqf6/dWPHE5qK0W2CkdmFMjmR4HN2CbicPt4c5HWtH++9His28NoxdMVjw8nifuxG5hqCZlG8vY3dkSZctcCd95Ez2WZlurn2DLXqbpKMU8H7t25GUKjUH271YvTMDr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB/fCIOsBUyr6h+Lf6aH4+130J/eiNuWueuhFmMi0TM=;
 b=ivPlEBlTPHWVIrGUQvHAow4WipZn7GZYvY+TCp/itTY1GItoSN9DmYZs2EASzTdxTNlm52gf+ebujcxQw3YxPvs2vz5lK6HqIoPV0cpUg2CiWlA2sHNKz29gPmn7cKNZrU8MDUOqRj8AEX2ndwqXplziwXi6oCUtMXdT8H8z8C7XVIDHHlyQ7ooKKqma2t8ae9Cg0EBe8Q2ypdxnIze7AyGsj5hEFcrgJlVXKHd4+ESqK7LPL4GVQpefZ7pNe3X/db9o/GTGdqUHIWLODBMg7lBX6XYCCudpvtpTr+RSywJyE1r35Nf7QeBepvH2ROZ7RN/Hppa2eg0Tz7d4eAaD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 23:30:29 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 23:30:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Topic: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
Thread-Index: AQHc+sgqXLeuA1RU9kGzdjSHRH7/w7ZAvW0AgAAQmQCAAAQkgIAAAKKAgACPawCAAHhvgA==
Date: Tue, 16 Jun 2026 23:30:28 +0000
Message-ID: <479741e62038c0e051c0fcfb3691b13afda80d06.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-19-seanjc@google.com>
	 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com>
	 <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
	 <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com>
	 <b6721d022187966290f8ea04766ffb1268407ca1.camel@intel.com>
	 <ajF3il4nLemXBOle@google.com>
In-Reply-To: <ajF3il4nLemXBOle@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|SA2PR11MB5020:EE_
x-ms-office365-filtering-correlation-id: 0bca7796-d7dd-4380-c672-08decbff4046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Jkv7gIFcofLEn+LZr/KPVDvlN3KGF6iMULWFPF09+3X/CkDZp5W6mIjd5vWJBYGBoxyQSzOohNGM6oBqt32uLuLP2hOaflsbaSXIwXJiyoG7CDCAzEiBOTVjWm5KnxDs8VFAD3o8NrGlOCPZ3cVbqov7NLEkFEb/LZof65fWjdsfCv8Jx/1m+KNLTKC1hKydK+dVXVqBF8uCUjjyUAMXilEyayDh1smhOOjs1tbPSkAP7KOFMMVe5DtfEHOJlOVdb+K1nKBw/ATudDCkbxrdjB4pmAemEOgCwo1oyf1JUKXHI4vlrK4v5Qz7bWwW7oWb0E8uPqxwu18v2IIHb7QNYD9WHXCNoPSgwvaxBBd+D1eGAS438SrjD2LlE1sg1fGVn7aNeBL9gNPyjOR4xceK+6eOML3om4ix2+JbCDNQV1q1+h548rPrMSpk7qKXTMcot1YfHFN63avy9GfvXm3IMlsDClWPLA58s0wkQy0B+DQRDLb8l0p9uzdEL9oPvGLJypXN8x4bfX9sy4slSQy1r86Bigay0mTIIT8SlpUjh5N4+REv3wXmQNLufAO/stVjTePHltInle2NU5xYnB70GkZDK2pkrOeYhGLi/8bG/Sus6tOsGCRsyZH3hFjnRDdmrELbyBkIZxoM4cZ7ZwcJCrYqpWzSiLwEueHFEp2cgb8FgPaA/sKMX07bjSQADHZ8bX+hNjtXvFIgKJ1UA4Ccf/cvmsrDXZs2cFIRNfVIEsZHsmlNG1j/lt6hQaUwUukO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRaQzI3WmFpb0dDRFhrc1ltT3ZkdWZLckJLM25yZldUZTN5RHZNcGNHbkNq?=
 =?utf-8?B?MHVTRlJqeUlYWm03YWRIck96L0J2TFZIZXFwdUJYb0txdHNVQnZhZTg0VHBo?=
 =?utf-8?B?bytIRlNwWkY0cnVCV3dTZ2IxakdtR04rNFl3ajErVWpsVHhPNDlOQkZQK1Rl?=
 =?utf-8?B?VjB3OXY3bnRSTEwvYnZ0RG1UUHZWejNQeHRkWFlQcnJ4VktRV1hTYis0ajVL?=
 =?utf-8?B?OVM3UmVTbXJBRWVMTFVUU1dvMFN2MDEzT2x5dTBEeU8xTzcybVZzVnRsY0hK?=
 =?utf-8?B?eDdsWFp6SWhzTnRndWJEN3FrVUZRSWJ6TnduQytBMklhNnU0dkhtb3lLWG5x?=
 =?utf-8?B?Y2d2N3ZLWEJzWWFRcm9FaUhnbzBiSTRWdmtLYWphSjR2SEg4ZWFRcUh2akdU?=
 =?utf-8?B?U2U4d0s3M1lXRVJLTGpHY1BqUkxnVGYvbEpxc0IwdjJORnZNTWFndlRWQ3dn?=
 =?utf-8?B?MUFQSEk2N2NXT2pqd0cvNGZScjB3NkcyMWNLNklFYS83MGcxaldPZzR2djd0?=
 =?utf-8?B?YjhOTnBhTjM1NTd1TE1MSHUxZEw2U3JObkI4a2V1NStVcEE2T0lBYXR5R3VL?=
 =?utf-8?B?bXRGcWEwKzNMRC80eVZRTUNRL2kvaHZ1RGVFR29sYmNWZDUxR2RKZU9PTDdR?=
 =?utf-8?B?NEhhZTJvdFVmWHA2akpnUURQaWhHcUtLM2ZyT0dRV2dKNHBXWk44bFBhK0ZY?=
 =?utf-8?B?TGoxc2tyaWlLSU1SM0ZMMy85YXRPVDNMWlYvekpXMWlVY2d5YWxCSjRkUVZW?=
 =?utf-8?B?ZWNwWlFDZzZvZ3pHMjlZWFdVYlpzSkh2SjEwMVF5Z1ZKdmw4Mk5zVHcyTTJm?=
 =?utf-8?B?ZEFRYm5uZnBDMGlCYXNNVUlhV0d0UytyYTJNQkd5NmRqSUo2SDZFVllEaFQw?=
 =?utf-8?B?cTRtV1BsMGtTVG9aTis1MG9nTjdkUkFWVkQxSHQvZDFnVHk4Q2VJRXd0bUV6?=
 =?utf-8?B?YjFlOWdsZ2JGL1ZlMmZPcVFTZDRFV3RiL0ppNmt1VnNhVDl3VWU3Y0FxTGlZ?=
 =?utf-8?B?ZGhVREV3dmZsU2RZNXF5dHNUcGN0TVZxd3VnZnE3RnZSczVKcGE1bVl0Rmx5?=
 =?utf-8?B?Wm4vOTFxL2dwZWVJcnBVNmFwUGU3WlF4SlVmUGJqd1pvZDRRbTJpSTE0NXI5?=
 =?utf-8?B?QTN0UWJVWVVPSnhLMGVOeE1JNmQvMnY2MExOYnNkdVVGQ29xcG54RkIwSWFQ?=
 =?utf-8?B?MWtuWkZHWmJqVG5hdVBxNTBzYnJ0ajRIUHpxdzhWNTI5Q1VvS1FZN25SVEVT?=
 =?utf-8?B?UVhQWTNDcGhWeHVGUDN4SEd4Y1ZpT2Q5c1pzNHdjYmI3VlU0NTdtd01aRVJz?=
 =?utf-8?B?YVJtcGd2MUlVVGRGRDhXRmJEZDJ3eDNFM1VRVklJWlJoOHRwZzkvS3FOVFUv?=
 =?utf-8?B?MXN0SExaN0YzUkFXY3R1M0xXOHhXMi9hVzhBNVBlOUhwbzZsWHpDQTVuMHlm?=
 =?utf-8?B?MmpzNU02SVJaVEp1Y2d3Tm95SnVXaE1Qc05WeG9qYUExaWxIelpXaUtNOTZn?=
 =?utf-8?B?UEFuZWpFYzdXOWEzL0MxZytIK3N5V0R3L3pZekJZZjNKK2pkazJGWm1IRnYv?=
 =?utf-8?B?ODVocTBBd3RXYjZSTnVkNWtLK2NMNzJ1cTlBYUt0aVdicnZtdmEyT2pQLzhJ?=
 =?utf-8?B?S2JsQXZVUXRnVkIyZ21IZzRHc0FZN3FTQTZ3cS9nSGJjdUZaclJLdHZvSDBM?=
 =?utf-8?B?R2RJNG1BUndCZnZ0cVRPVllhL0hoMjZmNzh2RXMzdm9QWTRGUEgwUzdhVU5G?=
 =?utf-8?B?T2YxWU8wamhCTHhYY0k1SDZKcW0vQlZDSVNDaWxWUEFKdE0xaC8yOUJCOGtz?=
 =?utf-8?B?eUxRc1Nvb3ZSMSt1SUVJb0Zpc1p2WHBVU3dDd1lGQk96czlhY1NTdmlaZzNi?=
 =?utf-8?B?Tk9vTkJENHQ4YkFsSDZrUXRrdndSamp5ZFR0U2xBVUFHQXJMZjNidHBuWElQ?=
 =?utf-8?B?TzRXM0lURWxjOHdicFJzbXdOTnBpUnNwQWhTWGVhNkpCZHVlbWwyaHNoU2hk?=
 =?utf-8?B?V1V1NVJhQjh5OWwvYlQ0aGdURUVSM3F4eFFvN21VSFRXTC9PMDJzMmZuQWox?=
 =?utf-8?B?QkhTSnNvekR5OURjeXZ1Z0xMNE5vVms3QmdMVGhtaDErbDZvcmNhYzhrZERx?=
 =?utf-8?B?ZDlTKy9iSklwUjhqdWpHRGhOTno5bDFicXRpWER1enZyV1JBTGJuanJMaVhN?=
 =?utf-8?B?dHR2UGMzdlYrL05aSWpscEc2by9waExQVXA5NDF0a0JNSHFiWU9QMnp5cHZa?=
 =?utf-8?B?K2ozakdNM1pDRm5BOTl2OTcyT0pMTUlneWNobUpXOGNCWmc5ampZdFpvZ3VG?=
 =?utf-8?B?Q0UxSUtDUVJQYzVVS3RCRkZwblBpMWZyQVhqSExXV1JxRTF0MjA4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5255F0C03C483D409A15951EA9A79DE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dFvj40usXcNvo725EQ4Qt28E7oESLoDKZO/WvgEvsdpVMYaGbxYw7EYBIOHf8ok70ayGGAX1rdoyqPy7lFqC3KvOxRbWuezony7oORbw+ChF+Jdo70KSms/B1hlwoOC5aIH4Gq5CsWWCCUjl26YOg+bKVmNJRCcDd1cnDVi6pFFqO6jCqApOLstVn3UyOHWpOHCK8V9HRDAZ7UeGdbPBYU4Rpo7c9bjWj5KrmOgd1udA07hUmo8BYNG91R4RXFFjCexHs3LaH+q/e2w6dAJE1ZQEc2NbdupsE9Y7Lzs1fLvSmOxQ2kSE/v5JnsMcFo0vzMvGQ9UQ+2dBHKR7Dflh+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bca7796-d7dd-4380-c672-08decbff4046
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 23:30:28.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK7yPzb73Ly3RM4Bt0pWbZuxZeyqMI2nYOi+UPO+2ooPW2kAJmI7tFmaHKNNHga21a63sU2p89UY3BEuEkw8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDA5OjE5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIEp1biAxNiwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wNi0xNiBhdCAxNTo0MyArMDgwMCwgQmluYmluIFd1IHdyb3RlOg0KPiA+ID4gPiBI
b3dldmVyLCBkb2VzIG1vdmluZyB0aGUgc3RydWN0dXJlIGRlZmluaXRpb24gdG8gIm1zcnMuaCIg
Zml4IHRoZSBwcm9ibGVtPw0KPiA+ID4gDQo+ID4gPiBZZXMsIGl0IGRvZXMuDQo+ID4gPiANCj4g
PiA+IFNpbWlsYXIgaXNzdWUgZm9yIHN0cnVjdCBrdm1feDg2X3BtdV9ldmVudF9maWx0ZXIgYWxz
byBjb3VsZCBiZSByZXNvbHZlZA0KPiA+ID4gYnkgbW92aW5nIHRoZSBzdHJ1Y3R1cmUgZGVmaW5p
dGlvbiB0byAicG11LmgiDQo+ID4gDQo+ID4gVGhhbmtzIGZvciBjb25maXJtaW5nLiAgSSB0aGlu
ayB3ZSBzaG91bGQgZG8gdGhpcy4NCj4gDQo+IEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gZ28gdGhh
dCByb3V0ZSwgZXNwZWNpYWxseSBzaW5jZSB0aGVyZSdzIGFic29sdXRlbHkgbm8NCj4gcmVhc29u
IHRvIHVzZSBzcmN1X2RlcmVmZXJlbmNlX2NoZWNrKCkgZHVyaW5nIGRlc3RydWN0aW9uLiAgS1ZN
IGlzbid0IGFjdHVhbGx5DQo+IGNoZWNraW5nIGFueXRoaW5nLCBhbmQgdGhlIChTKVJDVSBwb2lu
dGVycyBfbXVzdF8gYmUgcHJvdGVjdGVkIGR1cmluZyBkZXN0cnVjdGlvbiwNCj4gb3RoZXJ3aXNl
IHVzZS1hZnRlci1mcmVlIGlzIGFsbCBidXQgZ3VhcmFudGVlZC4NCg0KWWVhaCBhZ3JlZWQuDQo+
IA0KPiBVbmZvcnR1bmF0ZWx5LCBldmVyeSBSQ1UgbWFjcm8gSSBjYW4gZmluZCBkb2VzIHR5cGVv
ZigqcCkgc29tZXdoZXJlIGluIGl0cyBmbG93Lg0KPiBCdXQgSSB3b3VsZCBzdGlsbCBzdHJvbmds
eSBwcmVmZXIgdG8gb3BlbiBjb2RlIGEgX19mb3JjZSB0byBzdHJpcCB0aGUgX19yY3UgdGhhbg0K
PiBleHBvc2UgdGhlIHN0cnVjdHVyZXMgb3V0c2lkZSBvZiBtc3JzLmMgYW5kIHBtdS5jLg0KPiAN
Cj4gVGhpcyBtYWtlcyBnY2M4IGFuZCBnY2M5IGhhcHB5IG9uIG15IGVuZC4gIEknbGwgc3F1YXNo
IHRoZSBjaGFuZ2VzIGludG8gdGhlaXINCj4gcmVzcGVjdGl2ZSBwYXRjaGVzLCBhbmQgdXBkYXRl
IHRoZSBjaGFuZ2Vsb2dzLg0KDQpGaW5lIHRvIG1lIChzZWVtcyB3ZSBhcmUgaGF2aW5nIG1vcmUg
YW5kIG1vcmUgZnVuY3Rpb25hbCBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzDQpidXQgdGhpcyBwYXJ0
aWN1bGFyIGNoYW5nZSBtYXkgbm90IGJlIHRoZSBjYXNlKS4NCg0KRldJVywgSSBhbHNvIHRlc3Rl
ZCBDTEFORyB0aGF0IHlvdXIgZGlmZiBidWlsZHMgc3VjY2Vzc2Z1bGx5LiAgSSBvbmx5IHRyaWVk
DQpjbGFuZyB2ZXJzaW9uIDIwLjEuOCAoRmVkb3JhIDIwLjEuOC00LmZjNDIpIHNpbmNlIEkgZG9u
J3QgaGF2ZSBvdGhlciB2ZXJzaW9ucy4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYw0KPiBpbmRleCA5NWIzYmM3YjQ0OWUuLmIzYzE4
MGUxNmUyOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQo+ICsrKyBiL2FyY2gv
eDg2L2t2bS94ODYuYw0KPiBAQCAtOTk3NSwxMyArOTk3NSwxMyBAQCB2b2lkIGt2bV9hcmNoX2Rl
c3Ryb3lfdm0oc3RydWN0IGt2bSAqa3ZtKQ0KPiAgICAgICAgIGlmIChrdm0tPmFyY2guY3JlYXRl
ZF9tZWRpYXRlZF9wbXUpDQo+ICAgICAgICAgICAgICAgICBwZXJmX3JlbGVhc2VfbWVkaWF0ZWRf
cG11KCk7DQo+ICAgICAgICAga3ZtX2Rlc3Ryb3lfdmNwdXMoa3ZtKTsNCj4gLSAgICAgICBrdm1f
ZnJlZV9tc3JfZmlsdGVyKHNyY3VfZGVyZWZlcmVuY2VfY2hlY2soa3ZtLT5hcmNoLm1zcl9maWx0
ZXIsICZrdm0tPnNyY3UsIDEpKTsNCj4gKyAgICAgICBrdm1fZnJlZV9tc3JfZmlsdGVyKCh2b2lk
ICogX19mb3JjZSlrdm0tPmFyY2gubXNyX2ZpbHRlcik7DQo+ICAjaWZkZWYgQ09ORklHX0tWTV9J
T0FQSUMNCj4gICAgICAgICBrdm1fcGljX2Rlc3Ryb3koa3ZtKTsNCj4gICAgICAgICBrdm1faW9h
cGljX2Rlc3Ryb3koa3ZtKTsNCj4gICNlbmRpZg0KPiAgICAgICAgIGt2ZnJlZShyY3VfZGVyZWZl
cmVuY2VfY2hlY2soa3ZtLT5hcmNoLmFwaWNfbWFwLCAxKSk7DQoNCkJ0dywgdGhpcyBtYWRlIG1l
IGxvb2sgYXQgYXBpY19tYXAgdG9vLiAgQW5kIHNlZW1zIHdlIGNhbiBhbHNvIG1vdmUgInN0cnVj
dA0Ka3ZtX2FwaWNfbWFwIiB0byAibGFwaWMuaCIuICBXZSBjYW5ub3QgbW92ZSBpdCB0byBsYXBp
Yy5jIGJlY2F1c2UNCmt2bV9zY2hlZF95aWVsZCgpIGluIHg4Ni5jIGFjdHVhbGx5IHJlZmVyZW5j
ZXMgdGhlIG1lbWJlcnMgb2YgdGhlIHN0cnVjdHVyZS4NCg==
