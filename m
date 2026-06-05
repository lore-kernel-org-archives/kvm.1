Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A8472793;
	Fri,  5 Jun 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645836; cv=fail; b=jQgeaGHr2T4mApm+LrJsE3yYxRf7SFOawt3f82ZeBs6S6rNCE0hE1jxZP4W8Qo2OVvOfFIA23Z4/RCviLoNGolWqbHZ372w7xLXvWuLHJgVEWOTl30zkWtN0babXhO+1yeoM8qClpUlbYGWEFQWCnj7mKrPFJCZ3A5wNfMlNG3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645836; c=relaxed/simple;
	bh=pptWRfYWCTWTpqaZbh/MOaq/vcTffjQDevzyts1HvWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J55lTIqeHc3n+XbgS6+TTCCtftmj9u86t0hDXPFN0JNxxxw+FY1M1XcC85OBMScPjhJc9Gk9Bh9UKZ9WlI7qhx5Ht04tKkC84KGhwrpMDBaj7SCGzMc7GGFcgV0VZyQcU0uAVUvJgcwu1HJ3A2QbULK1gp01dhWGcFlflID/lYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggC3VP8j; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggC3VP8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780645834; x=1812181834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pptWRfYWCTWTpqaZbh/MOaq/vcTffjQDevzyts1HvWo=;
  b=ggC3VP8johOjQUGad6bxZP1hgNKY9i9tHFwKD9f6ALt6i11K97XDb2x7
   7nyHezcVVqZPPgZI3CYajCGQsnUz1Qkfnw3zF/Hswho22712Z0D+hxf3/
   ZWQ2mbI1NrnUIbwNA0GbLGpxsg10L3E9JXkVmIIjASHsTKd8Q4sVrcfQs
   j0/09Z68glFwNQT5bXK1RJ+yX0VlLp7WhAU44iUhxzUP1wVvBJMUBRqny
   uiPr+Z70zicJP0PTyEt63sbQsbOaBvSHYqbeQ+axt0uX1m7319TJJCCFa
   gYXaCjViSGtRhtQKuleBZBokQqZ3PfzfV7pSC0+eFfOO/41By9drRqzP8
   g==;
X-CSE-ConnectionGUID: EzQR4ni9TPOWkNrFfjl8hg==
X-CSE-MsgGUID: j1FY9RkAS0ah84S1ZdKiog==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80616533"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="80616533"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:50:34 -0700
X-CSE-ConnectionGUID: yMXYhrycRNSTpq7xybQuFQ==
X-CSE-MsgGUID: EhHz0ZtmQNuA/0BYRvm6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240591123"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:50:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:50:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:50:33 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh96hWhy851EU/6j8ms+iTkGZbApD45Xwiz9uGbnluvIz4uubDohIXK0ZOzw2PZOh5bq8JF17/LdFImvvkjYnNAXRhcKjFdtNAfLLyJwOe3l+tVBupSwtYOooeubnvPjuMoiVDBVw5E1GxuFPQqKlrqtxkkLqUSsN4/06MUlzlb8qGbQsaukPTdSBGkA6hFLKNbYQKtvTLf4bUTbYA94BdgeB3Ptrgl0TIPv9YB+/GuOPF1OUjUYF1+R8o0JgblnRMljNGThZFanqDWt7T1GoyAvQWjUc5lPi4mx4AV5zga++3BWZ2/vDl6uFEHdiDGLv0PdPQJ0nYAWTx+QEkETRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pptWRfYWCTWTpqaZbh/MOaq/vcTffjQDevzyts1HvWo=;
 b=b8BV4GeGjvtTqgk5oN8JxmORfJQnHcJbrn+76OISTNwa+kLEevfxHoFo64oCam5h62bkaSfEti264knPOYQdolTl0PO2uUJezOsjkrV6/lhOiBDjbw/3wyKn8yHBBPNBW5GgdhF2JoyMXRmpfuc37lYp1uz1LUdvjkwH7WXRAoaEIYxppUMi/xReH0nH/bqpDMdS1KAEhAb6uSRd9ZNAY9xea5hdCzIGPEYavgiVSziMQwp7qgy5MngCuztAbNpXxh5uIt03HW6Uf8/UgFZYllRu5F0czCq6C2mpNeOUgSbTFsGtoy9nt7I5EqvWQoF485VRHmd3YHXmW/T5fyJ3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Fri, 5 Jun 2026 07:50:28 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:50:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Topic: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Thread-Index: AQHc77nLxoh5kHwb2kaKk0hzQ9PktbYvoH0A
Date: Fri, 5 Jun 2026 07:50:28 +0000
Message-ID: <e1c32d6ba008a443797d26dba21cb9ae59b39f93.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-32-seanjc@google.com>
In-Reply-To: <20260529222223.870923-32-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH8PR11MB6832:EE_
x-ms-office365-filtering-correlation-id: eb98fc0c-6490-46ab-6187-08dec2d71ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: nvobQcj1tlzEllkxsXQrEdhT6gb24NouiR3KZwpYYsvWFw4AMvHi5aoa5MIzQhDLmDMIPIsFk4tl2+f+J383Ey+Us9wIjqZlYMR7s6IATl3N/f4746uywfkfeVJSil2qSCSpHt15WK8QqOPbN7Gf5qnIckAGtB9uDla6XKQlStz4M+0qg50cXoyhEr8Qsq4O4rUTUoZTTHYSAVwjnLBRavFAFpqCtorIsyxubmHnJ+HF36bHbrtKGT545J31adu7azcuhp5Z4U5FbFb5xt+8XXbT6pvufIY5oG31N88xR1bdisT1kMooH0nLnTlgANrXY6TAZDHut0KWE7zBIB0AWoM+E/uv5O5te4vX2wiFscFehxJ/3AoG7WywdSTgUHLs+e07bHIBpZPImvxR4QNyA8UfiYp+zzJGaE3tEa7M9g3RLEndAp1TcRl5TwG/cA2slcDAhsxJnoXIvQRewPDLAqeonfJzArhFWgjXGLveVf/DRQg0m1Ygs3zzXtCYhA5T0yoy+tzdKlXtVu5q6eTQ30bumlh2N1mC2IvB56LAsEUR6RbxDlnahk/+Cq8jiGl8IdShVHgqDiFFKtTanwVEMNmOYuoVt9YGhphBvWGrtPdcivugDJznj8Hg364hOEORk4p7tPoFMkIVFdugB+Oxy+4U//kgcpu/kRp37r7UctqzDZHv2+woO/BIXza4kWtijeqjCXUhSoRmJ5j2yo+tPYBLHefz+pO54qxekXcozGGZIWCacBUJAmKQgd+AA+nw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckMwSTN4TnNpaUpTaHNwcjBwMmpBQzFWU3F1dklYZzdMb2N6RXRSMHRkaGlO?=
 =?utf-8?B?d0I4dmhHRkF4bWlIaWpmeHFPcnd5MEFQMHRsUkhybFFUODJhaEN2MWJrZzVB?=
 =?utf-8?B?UVRicEg5c1pFUjBBelFNT3dJTkt1aW5RQS9SUnRWRytmS1QwVk5qUXB2YVIw?=
 =?utf-8?B?L1VrRW9Gc0NvUE4wRVArWmZIUXZPVDNFT0xLVHlaTVpaSkZKQmp0Q2RTakxn?=
 =?utf-8?B?WjBnNko5RFpTZ0pVcXd4bG90TlFVOWRFajErcnFzd3ZrdmY3RGdwUXZncVUz?=
 =?utf-8?B?cUZGNXNQSlJoWkJGZUZBMkh6VWNrcnJiYzlDM2VwOVRJWTl2dkZsN0Z0bVQw?=
 =?utf-8?B?bUJsOEpCQit0bjBnTmNzbGtxM2txaXBLakpJVVhPVFlRdXErQjRaR0tVWlk2?=
 =?utf-8?B?YlprbDJQZHU5ODZnaTVjM0xEWXBvTzN4cEcwWi9VZ0VRdEV2cFJ3L3hzdVVD?=
 =?utf-8?B?cGtMczR5M0tEaG84ekd1RUZCQ3J0YVUrNXdKWEFBYnZDR1NPUjlEU2xiRHlq?=
 =?utf-8?B?akU0eVB6VlJ6NW4zaXMzRm9PNVRwWXB0MWY3TDJTNzg4RXUyQzRTUThDazd5?=
 =?utf-8?B?V3NkZTFOUGVKSm1iZ25hdWYyS2lpSkN5blgyM0hFWm5hRkt0OVlXRGR4b2xE?=
 =?utf-8?B?Qm0yZ2RQaG16MjBMT0Fhait5M3NrWVpBa1lmOTZNUGtkTFJheldHeXF0M2FG?=
 =?utf-8?B?bEVPak5BWlIvTUpUbnYrWlBEVk9ab3Z3Y0RPZlkrckZ5VkVWSXg1Y3lkZVRj?=
 =?utf-8?B?TndYY1BBTTljS2hJL1lLbWxWdnBRaFErUEFMZlgzaW4zMVhhekI1c3hIU3pw?=
 =?utf-8?B?K3VST3JDMU0yL21mSHFFbElSdGdkKzJaTndYbGt4Z1kvY2FaeGdwVFA4QURC?=
 =?utf-8?B?bnlmczZvNFNRSXVqc3ZvenpuNTlrYXU2b1M1dklGYzl2QXphdFozVE80RUtr?=
 =?utf-8?B?YVFSU2g1cmRhRGZVM1crZnhyV3M5QUEwYVlBc1ZQaUd1VHd0UUxFWjNwczNI?=
 =?utf-8?B?MXZFcVFCV0Qza0c1aVFPNDVITXBMZjRPOGdxZzE0a0lwMHFTdXJtYTczZ0NP?=
 =?utf-8?B?K2l5aVVrMGdnT3hSYXpzbDkrc3RHQnlnZTBEY3Q5VjI5VDd4WmI5SUY2aTlP?=
 =?utf-8?B?WktCNjlDV2NMMzZUKzUzRmcyOEFuSWZyTEUvOWtiMDdocUl6aXlDUncvZVE2?=
 =?utf-8?B?dlN3UmhENDFmYjM2UHg1SUJvK1BSVVo0enRmZEFSM3FXRE1acnhuNmFhRHRw?=
 =?utf-8?B?NGJkSGxYd0toSkF5OENTRktyMDVkRE5ZclJpbGFxYXBjT2ZQcjdSNTZ2MG8w?=
 =?utf-8?B?MnpBQU53bCsvMFRGd09TQmsxOFVreUJPZ0IwZDdkVU5HbThxNVR3cDlURVdZ?=
 =?utf-8?B?cUtleTNPSDI5WXVmdzlmNi9KamthSmtINGd0cGRZeUJnbmFBVDROOHI1UXpY?=
 =?utf-8?B?NStKUDZjUklDYU9CN0Nad3FMdkFLS2hGdVA2cUtFWEZmdDcvVVRMdXdURlBv?=
 =?utf-8?B?eElHNEJlb1kxOTAzdFB1eHNnT0NQRVpHMEdXWDhGdU5zMU1BUEQ1Zk90eEww?=
 =?utf-8?B?c216cEQzdTNONW93Zld5cjdON014U1dVMkNoaWpsTElVTncvc3dMTHhtK2Fa?=
 =?utf-8?B?TzUxenhHNHVjK1daNmdjc1IwNFI1SkNrQ0d1QnJXRGlzV1RaY1ZHM0pJT1d5?=
 =?utf-8?B?cjFHN1VjV3h1TlE5T2hKVWFUN3A4RHhHM3ErYWdXNkw0ZUk5bzRNd3M3NkFU?=
 =?utf-8?B?L0lpUkdDd1FQVnFCY2wyMmx4WDd1aWRSWVJGc0xBQTM1VTJHMTBqTmhUZmts?=
 =?utf-8?B?TC9UelpYMXVUZncxTHJ1V25OSGdMaEgxRWhoeG1WWitCcnllWkV2eDdaSnky?=
 =?utf-8?B?Z1FPcyttUlJQZ1p3cDU1YXNidG5SV0NxUFpMTDRlZjFQSXFuQXlxdEdXcURW?=
 =?utf-8?B?MEIxS0pSRTZhSmVlWlFjK0ZOU05NL2ZtR2VwblRYMjYwOXZibktwTmZsRVZG?=
 =?utf-8?B?U05UL1dFUC8wQ2M4RHVST1FDUkFDUURzbGhJVW9ZMm9hcVBmdDRIQ3BsNk5y?=
 =?utf-8?B?TzQ0Z3V5Ty9EcU0yVmkvcGpkMnVyMzk2SlpNN1JmVDE2RGRHczVKeGhxaDdO?=
 =?utf-8?B?MU1uZ0dGNkNJQTk0aVdJN2MwQzV1ZXZHSlNoN0laaC9mNDJ0WkZNL25oWlU1?=
 =?utf-8?B?bFp6blZObVA2M0U1Z2tlWFcrdFZwRUZaOGFoLzlkdXRIY3FVaG44WWlEL1l2?=
 =?utf-8?B?dUZvWWl2STlCRWdlOThsN1lrUWVnUUdwZGhEYmtXLzBRNGRUT0tWaWpuNkpJ?=
 =?utf-8?B?N2YvVzRZTkdPb29UcGRINElpMXVMcG9oSEFoTURtWjN2SHZyZ091dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EF8545A2315C847A2C22E409CE451C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hw3hO4HBglwKKn7zxioV9RJl0Ew4VGA2aF1Ps5OsB17uhQanwKZbgf5W/EPoN3GLNahiLaCTDgYbdczctkEtRQiEcpTfWZQoFErP+Lz5mZvD0gsnpc919/333aAJy7zsBRaWD0lE9MgkYm0hZubFln2ntBU1sqV0I5qdBz3fsGaH1/pvRY/VNqEAje+8+1q+Yhl0nSNYuHm68g8jBxIZYSWYtsLsmlpOSaBxTyrLJpu+v+z59FIDBVUqrsIiCBya4oanTZUQleNBIYJAh6hRNk3PpyC+XRcenW9iAM+jaL7A7CO4ICZAeKnaRQ+PZf6n3eIPuY99fofy5fgFbdNVBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb98fc0c-6490-46ab-6187-08dec2d71ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:50:28.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzONw7wgHNhvS/EW353vDOIAiKxAB9d344FxDsmSuLVGWY7fKXG9wLmdTMuZeqKFOfOyJBdb0ux8Zbyv8GrnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+IGluZGV4IDExNDMxNDA1OTJkZi4uZjIxNzQw
M2UxOGZjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+
ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCj4gQEAgLTE2MSwxMiArMTYx
LDYgQEANCj4gICNkZWZpbmUgS1ZNX0hQQUdFX01BU0soeCkJKH4oS1ZNX0hQQUdFX1NJWkUoeCkg
LSAxKSkNCj4gICNkZWZpbmUgS1ZNX1BBR0VTX1BFUl9IUEFHRSh4KQkoS1ZNX0hQQUdFX1NJWkUo
eCkgLyBQQUdFX1NJWkUpDQo+ICANCj4gLSNkZWZpbmUgS1ZNX01FTVNMT1RfUEFHRVNfVE9fTU1V
X1BBR0VTX1JBVElPIDUwDQo+IC0jZGVmaW5lIEtWTV9NSU5fQUxMT0NfTU1VX1BBR0VTIDY0VUwN
Cj4gLSNkZWZpbmUgS1ZNX01NVV9IQVNIX1NISUZUIDEyDQo+IC0jZGVmaW5lIEtWTV9OVU1fTU1V
X1BBR0VTICgxIDw8IEtWTV9NTVVfSEFTSF9TSElGVCkNCj4gLSNkZWZpbmUgS1ZNX01JTl9GUkVF
X01NVV9QQUdFUyA1DQo+IC0jZGVmaW5lIEtWTV9SRUZJTExfUEFHRVMgMjUgDQo+IA0KDQpbLi4u
XQ0KDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11LmggYi9hcmNoL3g4Ni9rdm0vbW11
LmgNCj4gaW5kZXggZDMwNjc2OTM1ZmZmLi5hNmI4NzEyNTNiZDcgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gveDg2L2t2bS9tbXUuaA0KPiArKysgYi9hcmNoL3g4Ni9rdm0vbW11LmgNCj4gQEAgLTE1LDYg
KzE1LDEzIEBAIGV4dGVybiBib29sIHRkcF9tbXVfZW5hYmxlZDsNCj4gIGV4dGVybiBib29sIF9f
cmVhZF9tb3N0bHkgZW5hYmxlX21taW9fY2FjaGluZzsNCj4gIGV4dGVybiBib29sIGVhZ2VyX3Bh
Z2Vfc3BsaXQ7DQo+ICANCj4gKyNkZWZpbmUgS1ZNX01FTVNMT1RfUEFHRVNfVE9fTU1VX1BBR0VT
X1JBVElPIDUwDQo+ICsjZGVmaW5lIEtWTV9NSU5fQUxMT0NfTU1VX1BBR0VTIDY0VUwNCj4gKyNk
ZWZpbmUgS1ZNX01NVV9IQVNIX1NISUZUIDEyDQo+ICsjZGVmaW5lIEtWTV9OVU1fTU1VX1BBR0VT
ICgxIDw8IEtWTV9NTVVfSEFTSF9TSElGVCkNCj4gKyNkZWZpbmUgS1ZNX01JTl9GUkVFX01NVV9Q
QUdFUyA1DQo+ICsjZGVmaW5lIEtWTV9SRUZJTExfUEFHRVMgMjUNCj4gKw0KDQpCdHcsIEkgZm91
bmQgYmVsb3cgZGVmaW5lcyBjYW4gYmUgbW92ZWQgdG8gIm1tdS5oIiB0b286DQoNCiNkZWZpbmUg
SU5WQUxJRF9QQUdFICh+KGhwYV90KTApDQojZGVmaW5lIFZBTElEX1BBR0UoeCkgKCh4KSAhPSBJ
TlZBTElEX1BBR0UpDQoNCiNkZWZpbmUgS1ZNX01NVV9ST09UX0lORk9fSU5WQUxJRCBcDQogICAg
ICAgICgoc3RydWN0IGt2bV9tbXVfcm9vdF9pbmZvKSB7IC5wZ2QgPSBJTlZBTElEX1BBR0UsIC5o
cGEgPSBJTlZBTElEX1BBR0UNCn0pDQoNCkFuZCBldmVuIGJlbG93IGNhbiBiZSBtb3ZlZCB0byAi
bW11LmgiLCBidXQgcGVyaGFwcyB5b3Ugd29uJ3QgbGlrZSB0aGF0Og0KDQojZGVmaW5lIEtWTV9I
UEFHRV9HRk5fU0hJRlQoeCkgKCgoeCkgLSAxKSAqIDkpDQojZGVmaW5lIEtWTV9IUEFHRV9TSElG
VCh4KSAgICAgKFBBR0VfU0hJRlQgKyBLVk1fSFBBR0VfR0ZOX1NISUZUKHgpKQ0KI2RlZmluZSBL
Vk1fSFBBR0VfU0laRSh4KSAgICAgICgxVUwgPDwgS1ZNX0hQQUdFX1NISUZUKHgpKQ0KI2RlZmlu
ZSBLVk1fSFBBR0VfTUFTSyh4KSAgICAgICh+KEtWTV9IUEFHRV9TSVpFKHgpIC0gMSkpDQojZGVm
aW5lIEtWTV9QQUdFU19QRVJfSFBBR0UoeCkgKEtWTV9IUEFHRV9TSVpFKHgpIC8gUEFHRV9TSVpF
KQ0KDQojZGVmaW5lIEtWTV9NTVVfUk9PVF9DVVJSRU5UICAgICAgICAgICBCSVQoMCkNCiNkZWZp
bmUgS1ZNX01NVV9ST09UX1BSRVZJT1VTKGkpICAgICAgIEJJVCgxK2kpDQojZGVmaW5lIEtWTV9N
TVVfUk9PVFNfQUxMICAgICAgICAgICAgICAoQklUKDEgKyBLVk1fTU1VX05VTV9QUkVWX1JPT1RT
KSAtIDEpDQoNCihJIHRyaWVkIG1vdmluZyBhbGwgb2YgdGhlbSB0byAibW11LmgiIGFuZCBidWls
ZCB0ZXN0IHBhc3NlZCkuDQo=
