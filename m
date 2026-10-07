Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3D371071;
	Wed,  7 Oct 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417469; cv=fail; b=ahljE/0bkZ7zTHXo9IREvXvTHAiaMEpeQN9G/H4cBT6hPlYqrJKAuWZZekg6GlsjG31tB4lcLff+p7dYqUU40kTmwXHV9Xzg+1UqEeSg20yjB5YDudPiF2CQB1PrG4yNravEERbUhsxoXrxdOWLKUWfml3C6GKwHulg1YHfs5II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417469; c=relaxed/simple;
	bh=nwWqLFLnDtA/Ko9pJ8Y5+ab5k1T7yh3qmuoUZcFRS38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crq9rfTzeH1/+Sjy0V4Y1jXQKBRw2P+U68q06J/gxk2GuItNJrrl8CvK7yEOf8qZ7/U8zKLyw6vztXJ6efHrTT2PP499gIaI2+CiQ0cMB3XAbRRDLuq706+d4IWbxZtSUBTyTKpSQQQyxQDHJR72nNZi3bYL1zRlP/BloV2SWbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7LYjZQH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7LYjZQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791417468; x=1822953468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nwWqLFLnDtA/Ko9pJ8Y5+ab5k1T7yh3qmuoUZcFRS38=;
  b=N7LYjZQHMBh81fotXBpaqCASXcXfhhktaizRgnmyAFzvmFGQbtHXtquI
   5LG+vpWCmeTdzodHxQSr+9crXtxeDsYoKWDFAWMKyZF1A6UUmbIZE3dwD
   YWvLcM57fjiBtzpx5ni1oh2CZmg4NHX7M76xj0fljMClRh62lF+Sjaya8
   GzqFuFwR7peajjphtlUE9bdkdd7stgCJehCXO2UtRcpMOHRhrqMcKHbJy
   O2NVPGqWV44I0MwsjC2G66QQlUffN8GfhpiOm7DsrQ2VkWFXU2RLWIc1e
   dNh2nffCXrYwUUnoK+L0gU5TIRMzsl6Mkp19PfnjovKWrDrxwZMpMMleP
   w==;
X-CSE-ConnectionGUID: zuN/PQY5SbSMYMtXytOFxg==
X-CSE-MsgGUID: 2P/Qx7e8Q/m/Heh4iWg7EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="202305"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="202305"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 16:57:47 -0700
X-CSE-ConnectionGUID: 4t5LQ57RRzaF9YZsyxjVJA==
X-CSE-MsgGUID: bvurU6GZRIivPlhugCzzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="315617616"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 16:57:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 16:57:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 16:57:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 16:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chuD2N8Qicj0TxP4hepBrKU6hKer52jA/ouubwl+3tT00hZEwE7wliHNkIl/Y86yh9oQ8BmcuQxrC2+qXPX410sx6wwO3LJmU3+sCQpW3zGXNAICvSGMt2QVYst2nHwhJQzta23l6TKe3mvQSzhOSPcoODZaaHCLQJP+1sNhChzVchPba2ZOEr6vQHh3VMbJzutIWwmG5hP5+YoBjLcuxYeGzAjZmN8rufQWJrVcTeGhHrBE8PYdsNO5um6jciRX3xrFUkB6HOeKD/0CS5hKUP9X5OjnwNfamAxdW+sHHsLbe+Qk111M/96JXAonFC0J37KtbTR6wp4rsK7bjc49pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwWqLFLnDtA/Ko9pJ8Y5+ab5k1T7yh3qmuoUZcFRS38=;
 b=h3JW65FXHlJA72SoCidG98oFlVt719pH1FNvhvCeRK332CmxrumKGQeQ42A4DDLcPW6UglS+GzGfYdkmxNPMjms0Dz6ZvjB+8gHylT4WLdSVdpbI0rZxElbKsbtbS2BZQo7tKkg79NYTWGnk3gufaxEer8ElbSvM3Jr/Kb7NmNVTbiuhK1WJnppwnuqwF+sIAoYOykp8w0kRZbkjvXTr0FjRWEuY8W1ZoTMkvaA7r0x0Lz8awGNbDnwHTVe0qfmbk317/YB3e6yTfvExJpWIhaq0E5Ae2zDBYINoE72Zf56Zy+e9rwL8SWImp5FjDDmWyuswXHwBhrsA9U0nOl1fUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 7 Oct
 2026 23:57:37 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 23:57:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 09/17] KVM: x86/mmu: Introduce
 hugepage_set_guest_inhibit()
Thread-Topic: [PATCH v4 09/17] KVM: x86/mmu: Introduce
 hugepage_set_guest_inhibit()
Thread-Index: AQHdTylcSawk1U4ZJE2t31KwWjDZ+bby0O+A
Date: Wed, 7 Oct 2026 23:57:37 +0000
Message-ID: <a8f22a0650c25f37472e505c7666c7d66a8ce401.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091049.15615-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091049.15615-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB7535:EE_
x-ms-office365-filtering-correlation-id: bc4fb0aa-b10c-4d1e-c707-08df24cec3b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|22082099003|18002099003|38070700021|56012099006|10067099003|6133799003|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info: 5rH447DMNHA+l0zDBTuu7jWJ4/VVTTs7A2JOIeLrbjuBiTCzymcvwSbkM2iEIT3wDyIJ62HFcjYZsNP4W9TvXoFOK7HGw2Ghf7YEWBosXkXxLjgc2oKjTZAyB7uy7Iz2aNGd0LdLnT+k73n2cHC9Dm3fhCnELxmUOWc8Zl2gV1Osu83xJ7wtmE/0Q7BO2keaeMKsZtOuUH+NhbN3vJ6az2xFlCpUL1vXH710EwbjaeqC0+K9wsf6Fb1XTcze60Nk9ecSRf3moywBpzCTL6qv1MOMOhOVl4ECiHQR31KWk+lRA1y4nFYDlYGXjKfpXwZtXz6IQDL9egIu9veT6mw6sDjw1IP3UtS0GK8HPrC+LdBs+6ANxwAsNqlIEK3v9haCC5uhar+V3kOiozao8F0/8+QQgm2Cv2NXtSQGJ7fWYO+SdYaaBGiSLvHWqhx0xb5Lpie34wjGk5rYxvtQdbZcnsL1dxlaqherbJljcUIhY5eXf+HnC+eak3D3l/IYK0h0E/TYh3jnZMy0lluIxZOLEvCkGOQsPvy0w8VumDZyIJA31BKKsrVDlRf2hL6HZLmugIXHWreV8q6O3WKqBjSHj3bmkis7kbLL1j+DqtF82k86Q24itMvwDa1xtZlSYVOMRukcdvtCsnENBA8URgOKzPtbNYSNsAripIm9xp8j82U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmtlTEdpWS80T1JWcWl0Um1pZUlWRnp6NDJOaWJrdm9Bdm9XNVU2azYwL3BP?=
 =?utf-8?B?NHVWL0JINVZiZjFmUWNzMXZoNUJKS1NWQ2dqOWVUWnQ2eWdVZ1M2ZUtHeWh2?=
 =?utf-8?B?WWd2bXc1RENUbUxWMEhqZXhKS3N1MTNVUWVIU1RudldPajNRalh1YUxueFJT?=
 =?utf-8?B?b2o5TVdNcHFNRDEwcEJsbWcwTjE3NXRhMzdmMTF2a2g3SUpzVFdpeHFHbllG?=
 =?utf-8?B?eEk2QW1GQjhHRFFvT0Qwc0lhOXlINmw5OFRBdDdBSEpjbTNMcVNUV1BEMWxO?=
 =?utf-8?B?OUt6bEJXZ2hVQ2hHUnRzTDY2NDIyUVR1MklSYmlMaGFHdkJwck5yZjBBYVU3?=
 =?utf-8?B?dS9mbytobUF2TWw3MTRGd0Fnb2VaMHJuYUprV3hvcXZrSTNCNms1NDNldmhs?=
 =?utf-8?B?TjNmZVJsVGJlcHhDT3duV2hWWktFQk80Y2xMOStzSHY3Y2VSalc1SVRsNFFB?=
 =?utf-8?B?ai92T3pVM09LZFc5TlFQZlpuRjNhcWpNamFjL3UzaTVwL0hzS1N5eGN3VVpN?=
 =?utf-8?B?OWVTUEdiVHFaeEdGWDVZendLNzFIRHc5WERzMUdLdSs2UnNUZmFiTGRONVBw?=
 =?utf-8?B?ZUlqalc5NXdPWDZndmZ5M1A0Vnk0RDRHK21kcWZJRHFmUHY0M09PUmFpNGNm?=
 =?utf-8?B?RC9aVDIxSGZoZWVlWjh2OTRWU2xzTzVLMEg1bkFSdk8rdkVQRWNUMGdzbGxj?=
 =?utf-8?B?UmlIdWozRVJGTWRZVktneVpNU1dEc0VCYlM2MWR2NGhVZC9oUGpkZlV2R3FV?=
 =?utf-8?B?ZDBmWElobGJwTi9HS01SU1lwMVQ0d1h6ZDE0ZitYdXpVTUNBTDlMME1hSWlU?=
 =?utf-8?B?eTRjYUNSZzZldG55ekdxbGtzSmN6a0ZLQ3g5aHFNblYvcVV1NHE5ZEZKK3JW?=
 =?utf-8?B?ZkJTUkNFWGhYdk9YVTg4dGhNSDVsaEt5bDNnWWFGMFNnYW10L2hHUzJ6TUwx?=
 =?utf-8?B?aFA4NmI3ZG5PcXdIYWJJdU90bEtKdFVMVW5KaDMwbk5PWVlsYWcyTThBT0RH?=
 =?utf-8?B?MWVQcjl0bUU1ZDhqbFNvbzFaYXdPZkRiVEhEZDQ2dzFob1RWVGdQR0NMd01n?=
 =?utf-8?B?cU1NV3lpd0tCV1lOSEFpZTd2dWtlOFpkYzBzZUYxZ1ZKR2ZvOEVSK0Y0OTJN?=
 =?utf-8?B?dXgwNngwRlc3VHBpanMyRlBNS0JDREpLZEczR3l4MmlpbituL3A5OXdMQmho?=
 =?utf-8?B?OFRPbGpvTlYrbGREdEpGZ1dGWm9yeDVlZ0R3cjRsa0V5OXR2U1FrNFM3aFls?=
 =?utf-8?B?S2xGUm04a0lZbEZKcVpCcEQ1SEVoU2Jpc2Q0UkNLWmZ5aGtyeFkyL0taYkZM?=
 =?utf-8?B?RzdCMnZhdmZaWTJDdjM2RDRPaGFCM05keFp6c3h6Y1ZJcGZ3aGdBbGVheW1Q?=
 =?utf-8?B?YVlSRzkxVHB5MVl4c0dsU0VFZG91b01rSmNBZ3NZOTdQRHFlVjBIdmQrV3RF?=
 =?utf-8?B?TnNlWXpmaU5QN3lCQVJCTitSVnF6OU1La1hlRS9qYjJaZmVGNWF3dUEyOTFV?=
 =?utf-8?B?MEVEaTlDRVkzeTNQVGlGazRtckFNY1hRZVMyOFhzaWgycGxXeGZqN3cwZnl3?=
 =?utf-8?B?MGVveURyLzRMYkJ6bktJRjlYTGMwQTcxVUc4eVlMelcwRVY4aVBnNFBoMHNK?=
 =?utf-8?B?OHlKcmIyeE8rcEt2eDVFOHhPMGVoZ3BsWFFUeWs1VjVLWkYvcGhNZTJDLzds?=
 =?utf-8?B?NXU2bWkyV21NUEVER1JCTVhjWmVoNUM0V3NLeHFNWFFJWHN0ejhCQXFFR0k1?=
 =?utf-8?B?S1ZIVkpvQWNuN1h0eDVOY1ZFaTAwQnJLL0paU0RWS0xQMDdnWVRVM1o4aks4?=
 =?utf-8?B?aWxyQkhiRDEzcWJWRkZ2OEFxV20vTlc1Y1J5aXVEM1NibmF1SFhLbVFsd0J0?=
 =?utf-8?B?NTFVOC9Uc1dtbWRpb3MvVnRRUHNrTFkyOG1VTVJzVEdMd29ZNUMzaFY0SUFq?=
 =?utf-8?B?VjdOUGZRY0ZheFNLbjdva25teU5uOWtCK2Z2QzdJZUJVdno1bTA4RWsyNjNV?=
 =?utf-8?B?Z2g3T3VpaEFpdVhLQldmempzRHFWaXhySGZoSlYxQU42NkNJSG83NjV6L2xu?=
 =?utf-8?B?d0NZVVgzeml5eTRjU1Z0YzNlc3hCS0QxN3ZIY3NPaEJQZTFjOUFKQkRjQVBi?=
 =?utf-8?B?eW5hMVNsTW16K0pwb0NwMnZVRXhESWI2MEQyRERMZjdhVUVmM29wRzIwT2c1?=
 =?utf-8?B?Q3RYR3VGR01mUm5KNzFjR3pCcGltemhDM3d4aDZWaG03dmh0NnQ3T0w4NjRU?=
 =?utf-8?B?d3VPT0ozeG9xVUxDUjlZRy9CZ0tIT0lzd3JvaUxhQWhhSUFNZDNucElhMlE0?=
 =?utf-8?B?ODNCdE5kbTNNYTJkR0s3U3VqUnltNWNnYk9RdTdSWm5wUUVyK20zR0E3bDV1?=
 =?utf-8?Q?LdfEKBlOpP2AweQo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <914F33AD6E29694C9AA139B15C591B4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C+QkcZUEU20gY3vVpIFE0ECxX8YjVsIizdn1kxzln5bWeOJI+IkaFe/tPkVuP69lxTutGqE8wnaVBp/rpUo8ot8odiy6aHlAWQ/lNKMnkF1Ogg/3u1ZcWXNR9Cmxk61frWWON224c5N/6fT8cemyZnOiNDZ7WZ/H10P1HQ4quOgC1iMGG9JrVuAJ49uqQTESLvJwRIPXNXeDTxtmKst5cRfEhIDVk552B46oW+CtB/7cWReF3euqky6fXFuFB25c5F1HcHBhRWB3HaCfswOor5rf/oJ5Cb+/3WjhDLmuW9AFryi3sSgPtgNA5TO0wi/rRQpXcZPeUikg14/VsZCxHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4fb0aa-b10c-4d1e-c707-08df24cec3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 23:57:37.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUXQ6glc157KHlFaq9jX90tGDT9C2bmiMZZ3FmZkSjdj5mY9A7t7UdTXTWBOpYajq0juI6QCEk8zgjF3AcmREKTO124/56EPb7S7QfTYd+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gVERY
IHJlcXVpcmVzIGd1ZXN0cyB0byBhY2NlcHQgUy1FUFQgbWFwcGluZ3MgY3JlYXRlZCBieSB0aGUg
aG9zdCBLVk0uIER1ZQ0KPiB0byB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgVERY
IG1vZHVsZSwgaWYgYSBndWVzdCBhY2NlcHRzIGEgR0ZODQo+IGF0IGEgbG93ZXIgbGV2ZWwgYWZ0
ZXIgS1ZNIG1hcHMgaXQgYXQgYSBoaWdoZXIgbGV2ZWwsIHRoZSBURFggbW9kdWxlIHdpbGwNCj4g
ZW11bGF0ZSBhbiBFUFQgdmlvbGF0aW9uIFZNRXhpdCB0byBLVk0gaW5zdGVhZCBvZiByZXR1cm5p
bmcgYSBzaXplIG1pc21hdGNoDQo+IGVycm9yIHRvIHRoZSBndWVzdC4gSWYgS1ZNIGZhaWxzIHRv
IHBlcmZvcm0gcGFnZSBzcGxpdHRpbmcgaW4gdGhlIFZNRXhpdA0KPiBoYW5kbGVyLCB0aGUgZ3Vl
c3QncyBhY2NlcHQgb3BlcmF0aW9uIHdpbGwgYmUgdHJpZ2dlcmVkIGFnYWluIHVwb24NCj4gcmUt
ZW50ZXJpbmcgdGhlIGd1ZXN0LCBjYXVzaW5nIGEgcmVwZWF0ZWQgRVBUIHZpb2xhdGlvbiBWTUV4
aXQuDQo+IA0KPiBUbyBmYWNpbGl0YXRlIHBhc3NpbmcgdGhlIGd1ZXN0J3MgYWNjZXB0IGxldmVs
IGluZm9ybWF0aW9uIHRvIHRoZSBLVk0gTU1VDQo+IGNvcmUgYW5kIHRvIHByZXZlbnQgdGhlIHJl
cGVhdGVkIG1hcHBpbmcgb2YgYSBHRk4gYXQgZGlmZmVyZW50IGxldmVscyBkdWUNCj4gdG8gZGlm
ZmVyZW50IGFjY2VwdCBsZXZlbHMgc3BlY2lmaWVkIGJ5IGRpZmZlcmVudCB2Q1BVcywgaW50cm9k
dWNlIHRoZQ0KPiBpbnRlcmZhY2UgaHVnZXBhZ2Vfc2V0X2d1ZXN0X2luaGliaXQoKS4gVGhpcyBp
bnRlcmZhY2Ugc3BlY2lmaWVzIGFjcm9zcw0KPiB2Q1BVcyB0aGF0IG1hcHBpbmcgYXQgYSBjZXJ0
YWluIGxldmVsIGlzIGluaGliaXRlZCBmcm9tIHRoZSBndWVzdC4NCj4gDQo+IEludGVudGlvbmFs
bHkgZG9uJ3QgcHJvdmlkZSBhbiBBUEkgdG8gY2xlYXIgS1ZNX0xQQUdFX0dVRVNUX0lOSElCSVRf
RkxBRw0KPiBmb3IgdGhlIHRpbWUgYmVpbmcsIGFzIGRldGVjdGluZyB0aGF0IGl0J3Mgb2sgdG8g
KHJlKWluc3RhbGwgYSBodWdlIHBhZ2UgaXMNCj4gdHJpY2t5IChhbmQgY29zdGx5IGlmIEtWTSB3
YW50cyB0byBiZSAxMDAlIGFjY3VyYXRlKSwgYW5kIEtWTSBkb2Vzbid0DQo+IGN1cnJlbnRseSBz
dXBwb3J0IGh1Z2UgcGFnZSBwcm9tb3Rpb24gKG9ubHkgZGlyZWN0IGluc3RhbGxhdGlvbiBvZg0K
PiBodWdlIHBhZ2VzKSBmb3IgUy1FUFQuDQo+IA0KPiBBcyBhIHJlc3VsdCwgdGhlIG9ubHkgc2Nl
bmFyaW8gd2hlcmUgY2xlYXJpbmcgdGhlIGZsYWcgd291bGQgbGlrZWx5IGFsbG93DQo+IEtWTSB0
byBpbnN0YWxsIGEgaHVnZSBwYWdlIGlzIHdoZW4gYW4gZW50aXJlIDJNQiAvIDFHQiByYW5nZSBp
cyBjb252ZXJ0ZWQNCj4gdG8gc2hhcmVkIG9yIHByaXZhdGUuICBCdXQgaWYgdGhlIGd1ZXN0IGlz
IGFjY2VwdGluZyBhdCA0S0IgZ3JhbnVsYXJpdHksDQo+IG9kZHMgYXJlIGdvb2QgdGhlIGd1ZXN0
IGlzIHVzaW5nIHRoZSBtZW1vcnkgZm9yIHNvbWV0aGluZyAic3BlY2lhbCIgYW5kDQo+IHdpbGwg
bmV2ZXIgY29udmVydCB0aGUgZW50aXJlIHJhbmdlIHRvIHNoYXJlZCAoYW5kL29yIGJhY2sgdG8g
cHJpdmF0ZSkuDQo+IFB1bnQgdGhhdCBvcHRpbWl6YXRpb24gdG8gdGhlIGZ1dHVyZSwgaWYgaXQn
cyBldmVyIG5lZWRlZC4NCj4gDQo+IFVubGlrZSBodWdlcGFnZV9zZXQvdGVzdF9taXhlZCgpLCB3
aGljaCBhcmUgcGxhY2VkIHVuZGVyDQo+IENPTkZJR19LVk1fVk1fTUVNT1JZX0FUVFJJQlVURVMg
c2luY2UgdGhleSBhcmUgdW5uZWVkZWQgd2hlbiBwZXItVk0gbWVtb3J5DQo+IGF0dHJpYnV0ZXMg
aXMgZGlzYWJsZWQsIGh1Z2VwYWdlX3NldC90ZXN0X2d1ZXN0X2luaGliaXQoKSBhcmUgaW52b2tl
ZCB3aGVuDQo+IHBlci1nbWVtIG1lbW9yeSBhdHRyaWJ1dGVzIGlzIGVuYWJsZWQsIHNpbmNlIFRE
WCBodWdlIHBhZ2Ugc3VwcG9ydCBpcw0KPiBpbnRlbnRpb25hbGx5IGVuYWJsZWQgb25seSB3aGVu
IHBlci1nbWVtIG1lbW9yeSBhdHRyaWJ1dGVzIGlzIGVuYWJsZWQuDQoNCk5vdCBzdXJlIHdoeSB3
ZSBuZWVkIHRoZSBhYm92ZSBwYXJhZ3JhcGguIEVzcGVjaWFsbHkgdGhlIGdtZW0gcGFydC4gSXQg
bG9va3MNCmxpa2UgaXQgd2FzIGFkZGVkIHNpbmNlIHY1LiBXYXMgaXQgYW4gQUkgcmV2aWV3IGl0
ZW0/DQoNCldpdGggdGhhdCBhZGRyZXNzZWQ6DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21i
ZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCj4gDQo+IExpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9hNmZmZTIzZmI5N2U2NDEwOWY1MTJmYTQzZTlmNjQwNTIzNmVkNDBh
LmNhbWVsQGludGVsLmNvbSBbMV0NCj4gU3VnZ2VzdGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogU2VhbiBDaHJpc3RvcGhl
cnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IFtzZWFuOiBleHBsYWluICp3aHkqIHRoZSBmbGFn
IGlzIG5ldmVyIGNsZWFyZWRdDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24g
PHNlYW5qY0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW4gWmhhbyA8eWFuLnkuemhh
b0BpbnRlbC5jb20+DQo+IC0tLQ0KPiB2NDoNCj4gLSBFeHBsYWluICp3aHkqIHRoZSBmbGFnIGlz
IG5ldmVyIGNsZWFyZWQuIChTZWFuKQ0KPiAtIEV4cGxhaW4gd2h5IGh1Z2VwYWdlX3NldC90ZXN0
X2d1ZXN0X2luaGliaXQoKSBhcmUgbm90IHBsYWNlZCBuZWFyIHRvDQo+ICAgaHVnZXBhZ2Vfc2V0
L3Rlc3RfbWl4ZWQoKS4NCj4gDQo+IHYzOg0KPiAtIFVzZSBFWFBPUlRfU1lNQk9MX0ZPUl9LVk1f
SU5URVJOQUwoKS4NCj4gDQo+IFJGQyB2MjoNCj4gLSBuZXcgaW4gUkZDIHYyDQo+IC0tLQ0KPiAg
YXJjaC94ODYva3ZtL21tdS5oICAgICB8ICA0ICsrKysNCj4gIGFyY2gveDg2L2t2bS9tbXUvbW11
LmMgfCAyMyArKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9tbXUuaCBiL2FyY2gveDg2L2t2bS9tbXUuaA0KPiBpbmRleCAyYWU3ZjllZDRjZjguLjg0
YTk2YWM5NGFkYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL21tdS5oDQo+ICsrKyBiL2Fy
Y2gveDg2L2t2bS9tbXUuaA0KPiBAQCAtNDEwLDQgKzQxMCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBrdm1faXNfZ2ZuX2FsaWFzKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuKQ0KPiAgew0KPiAg
CXJldHVybiBnZm4gJiBrdm1fZ2ZuX2RpcmVjdF9iaXRzKGt2bSk7DQo+ICB9DQo+ICsNCj4gK3Zv
aWQgaHVnZXBhZ2Vfc2V0X2d1ZXN0X2luaGliaXQoc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xv
dCwgZ2ZuX3QgZ2ZuLCBpbnQgbGV2ZWwpOw0KPiArYm9vbCBodWdlcGFnZV90ZXN0X2d1ZXN0X2lu
aGliaXQoc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwgZ2ZuX3QgZ2ZuLCBpbnQgbGV2ZWwp
Ow0KPiArDQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvbW11LmMg
Yi9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+IGluZGV4IGE5YTdjMDE1MjU2Yi4uMDcyNWI5MmI3
MDA4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2t2bS9tbXUvbW11LmMNCj4gQEAgLTc1MCwxMiArNzUwLDE0IEBAIHN0YXRpYyBib29sIGt2
bV9nZm5faXNfbHBhZ2VfYWxsb3dlZChzdHJ1Y3Qga3ZtICprdm0sDQo+ICB9DQo+ICANCj4gIC8q
DQo+IC0gKiBUaGUgbW9zdCBzaWduaWZpY2FudCBiaXQgaW4gZGlzYWxsb3dfbHBhZ2UgdHJhY2tz
IHdoZXRoZXIgb3Igbm90IG1lbW9yeQ0KPiAtICogYXR0cmlidXRlcyBhcmUgbWl4ZWQsIGkuZS4g
bm90IGlkZW50aWNhbCBmb3IgYWxsIGdmbnMgYXQgdGhlIGN1cnJlbnQgbGV2ZWwuDQo+ICsgKiBU
aGUgMiBtb3N0IHNpZ25pZmljYW50IGJpdHMgaW4gZGlzYWxsb3dfbHBhZ2UgdHJhY2sgd2hldGhl
ciBvciBub3QgbWVtb3J5DQo+ICsgKiBhdHRyaWJ1dGVzIGFyZSBtaXhlZCwgaS5lLiBub3QgaWRl
bnRpY2FsIGZvciBhbGwgZ2ZucyBhdCB0aGUgY3VycmVudCBsZXZlbCwNCj4gKyAqIG9yIHdoZXRo
ZXIgb3Igbm90IGd1ZXN0IGluaGliaXRzIHRoZSBjdXJyZW50IGxldmVsIG9mIGh1Z2VwYWdlIGF0
IHRoZSBnZm4uDQo+ICAgKiBUaGUgbG93ZXIgb3JkZXIgYml0cyBhcmUgdXNlZCB0byByZWZjb3Vu
dCBvdGhlciBjYXNlcyB3aGVyZSBhIGh1Z2VwYWdlIGlzDQo+ICAgKiBkaXNhbGxvd2VkLCBlLmcu
IGlmIEtWTSBoYXMgc2hhZG93IGEgcGFnZSB0YWJsZSBhdCB0aGUgZ2ZuLg0KPiAgICovDQo+IC0j
ZGVmaW5lIEtWTV9MUEFHRV9NSVhFRF9GTEFHCUJJVCgzMSkNCj4gKyNkZWZpbmUgS1ZNX0xQQUdF
X01JWEVEX0ZMQUcJCUJJVCgzMSkNCj4gKyNkZWZpbmUgS1ZNX0xQQUdFX0dVRVNUX0lOSElCSVRf
RkxBRwlCSVQoMzApDQo+ICANCj4gIHN0YXRpYyB2b2lkIHVwZGF0ZV9nZm5fZGlzYWxsb3dfbHBh
Z2VfY291bnQoY29uc3Qgc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwNCj4gIAkJCQkJICAg
IGdmbl90IGdmbiwgaW50IGNvdW50KQ0KPiBAQCAtNzY4LDcgKzc3MCw4IEBAIHN0YXRpYyB2b2lk
IHVwZGF0ZV9nZm5fZGlzYWxsb3dfbHBhZ2VfY291bnQoY29uc3Qgc3RydWN0IGt2bV9tZW1vcnlf
c2xvdCAqc2xvdCwNCj4gIA0KPiAgCQlvbGQgPSBsaW5mby0+ZGlzYWxsb3dfbHBhZ2U7DQo+ICAJ
CWxpbmZvLT5kaXNhbGxvd19scGFnZSArPSBjb3VudDsNCj4gLQkJV0FSTl9PTl9PTkNFKChvbGQg
XiBsaW5mby0+ZGlzYWxsb3dfbHBhZ2UpICYgS1ZNX0xQQUdFX01JWEVEX0ZMQUcpOw0KPiArCQlX
QVJOX09OX09OQ0UoKG9sZCBeIGxpbmZvLT5kaXNhbGxvd19scGFnZSkgJg0KPiArCQkJICAgICAo
S1ZNX0xQQUdFX01JWEVEX0ZMQUcgfCBLVk1fTFBBR0VfR1VFU1RfSU5ISUJJVF9GTEFHKSk7DQo+
ICAJfQ0KPiAgfQ0KPiAgDQo+IEBAIC03ODIsNiArNzg1LDE4IEBAIHZvaWQga3ZtX21tdV9nZm5f
YWxsb3dfbHBhZ2UoY29uc3Qgc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwgZ2ZuX3QgZ2Zu
KQ0KPiAgCXVwZGF0ZV9nZm5fZGlzYWxsb3dfbHBhZ2VfY291bnQoc2xvdCwgZ2ZuLCAtMSk7DQo+
ICB9DQo+ICANCj4gK2Jvb2wgaHVnZXBhZ2VfdGVzdF9ndWVzdF9pbmhpYml0KHN0cnVjdCBrdm1f
bWVtb3J5X3Nsb3QgKnNsb3QsIGdmbl90IGdmbiwgaW50IGxldmVsKQ0KPiArew0KPiArCXJldHVy
biBscGFnZV9pbmZvX3Nsb3QoZ2ZuLCBzbG90LCBsZXZlbCktPmRpc2FsbG93X2xwYWdlICYgS1ZN
X0xQQUdFX0dVRVNUX0lOSElCSVRfRkxBRzsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfRk9SX0tW
TV9JTlRFUk5BTChodWdlcGFnZV90ZXN0X2d1ZXN0X2luaGliaXQpOw0KPiArDQo+ICt2b2lkIGh1
Z2VwYWdlX3NldF9ndWVzdF9pbmhpYml0KHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKnNsb3QsIGdm
bl90IGdmbiwgaW50IGxldmVsKQ0KPiArew0KPiArCWxwYWdlX2luZm9fc2xvdChnZm4sIHNsb3Qs
IGxldmVsKS0+ZGlzYWxsb3dfbHBhZ2UgfD0gS1ZNX0xQQUdFX0dVRVNUX0lOSElCSVRfRkxBRzsN
Cj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfRk9SX0tWTV9JTlRFUk5BTChodWdlcGFnZV9zZXRfZ3Vl
c3RfaW5oaWJpdCk7DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGFjY291bnRfc2hhZG93ZWQoc3RydWN0
IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21tdV9wYWdlICpzcCkNCj4gIHsNCj4gIAlzdHJ1Y3Qga3Zt
X21lbXNsb3RzICpzbG90czsNCg0K
