Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77743E9F6;
	Mon, 10 Aug 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392123; cv=fail; b=VI8Ot6yQKgpVoqK6L5vnircESmKmKBRClSQkDoLThMfuMaah7RCwDgprCoeyMM1hadfpdlftUIoe5AjNB5wwH5McUFNhYvLA6YJydFtefrRBq07csjpaeafZnEeNFstigdWKi8ASKeoyIGXKuJuFeqDlpyQlfur1+6bMSBecbcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392123; c=relaxed/simple;
	bh=x87Igh2wqoQHQdEfTLeaFEvhk9rBsS59QilFZ+9ZtXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqMOWFeg7Cwgjb0eSYikeuzFCqiJAaYQVJXaeq2qZza5CTN4qvcwW5hCo1TFSXP3o0jcoFIQwOwLYiN3yfdMgj6lP6AXfuUWqb6AWsOivvN5qfq2A2OwMq3OoUPaaGleIxlE95HhQD5ty/XwFhRbUo0K5frh2wMZGHYWFGZM2v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pehm2d2E; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pehm2d2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786392122; x=1817928122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x87Igh2wqoQHQdEfTLeaFEvhk9rBsS59QilFZ+9ZtXE=;
  b=Pehm2d2E5338GF8rOv6AVyTV121HY+hq5p8iTScZmJPGRXdsWSl3W7sB
   ar1PJBazbwGveMf9QOEYbmB87B+wrJanbVI+ZwOpSR1JU+k9Vwc1KDlHZ
   E3BiUmGVCUlIdyRD13TYd13b8zbrjXdtdV8a3QR02ZJb2CR/t6l9wAgVf
   25AD7Nw51c4VvQSHz/AojumxMxtrPjIr8/UOxb/D4MYkokR94QUVl0LhY
   Fg7ih7KOszVKm4r8jvYeHr6Wk5htDqvtZCQhAbpvRTx3FnY62zua6EQKT
   q3DjpNThitEvvNdCO5a8k7zC0O/brVPjVvCHwwlx+VQ8q41YJ78vntkiB
   g==;
X-CSE-ConnectionGUID: wcdHG375SmeYcDuToj42fw==
X-CSE-MsgGUID: pQqv0K3GScyTSzA+n+Pcrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104448723"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104448723"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:02:01 -0700
X-CSE-ConnectionGUID: vsDU3uTBSB+7SNvm4RsQ6w==
X-CSE-MsgGUID: Sjy9KZmOSzidJXRQkDZEMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259286123"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 13:02:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 13:02:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 13:02:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 13:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH8woiQj5kFNpmonVpeN/RPK4R+6yM0gL4So+Dyr1Rva0D079neoelYEECGsx39kG9EC8KFlZNFadtpkrTmQCJVmDHPwHTu47rzF9zqIU9jix5N04/lgg3kpi78UDFf1ZqLL7naTPvHVrrLtL6sTwLtSljUMZTun/6IRekS7noW+0ToK5yWBKvD12Xd2AW3Uez6xF7IZ586BNijOj6LPoNnKn+TjD/tzdtIRZw+BdROcyWa5p111SNwsipLP1dYiw9BI6VokMr6AMr4Ik7Miz237GqVbkfO6WYEj1REtOayBosOEpj84V0RMISkwJ9J6yIk0/P40eRudMY086Q8SDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x87Igh2wqoQHQdEfTLeaFEvhk9rBsS59QilFZ+9ZtXE=;
 b=Tai/mv/V73XFp4Df07R+FAYysz9WLoaL6aE3B+l5EHXrBYdZjdviHyBiWIgH3srOm02zej//IkxZOFtfYIcy4hfxH84OPbZOIF1oy4sezSTz9teSFiJnxqewGR4MW13SUTbhquClVyQoaV7Tw8de9rpOicsgsob9fOjWcJ90JbKpRpcqRf5DjF7dueaWAH3sEE/UpmYF4uaw35EWLWvyyD5r+xJpbE5MVZgJqhgVJrPVlsNr8Qxwd+biIwyHPWiUHqPavPRd7fRIPmd8WPY6u43CQeCwYouYE4z1jOYeXbdhC3+EuOpxnSrLrFIMwl2O/h/37s9fNDI17aV8BmVXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSVPR11MB9767.namprd11.prod.outlook.com (2603:10b6:8:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 20:01:59 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 20:01:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Thread-Topic: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Thread-Index: AQHdJexJ+xgPRKIpBE2rBNksi9KIMbaTCjqAgAAfQgCABJDeAA==
Date: Mon, 10 Aug 2026 20:01:59 +0000
Message-ID: <5f7cc285ea55bec73dd4b51391c4657432953c17.camel@intel.com>
References: <20260806214050.78058-1-seanjc@google.com>
	 <20260806214050.78058-3-seanjc@google.com>
	 <a05089fa3c5aa0ec9cdbd88d8aefc7b9ffa77e0d.camel@intel.com>
	 <anZZsiNZAxcg3FPH@google.com>
In-Reply-To: <anZZsiNZAxcg3FPH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSVPR11MB9767:EE_
x-ms-office365-filtering-correlation-id: f90bb893-3a07-4dbd-b451-08def71a3ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: DhjfVPTScUghNuGxtnpGvhUZX4Wv9Uzaey4fgoAfLLW/9vRBoFp07Fz6ri7sIcOsFXefhqy5PSygEs7ITOIe+7MYvtAzIkrqbqy/cTyeXyL3eRqUiMFbD2FQ0ov0tiXJzcGpiaNY9bypaWmNNClFYlCFVKNnKBAti18VbKzY22ic05iEAEhxxd9+ettOcWnGxX5HVRmxX1z6LKOh5H3sAPBForm1dHl2T0LxvR7OOihYvvIDQl7WYASoaG+UbfJNwQQRWIxhNPpZvp3hLcLIn3wOOlGsXZu4yfU+ys3oXr34dWe2mW/2UPEhQDSvbUmKoJmG4Np1q4pLDhAErJynerk7NKjZPdmyN0heVUFCsQuQ+KBbyGKGiokIiokMJ8aGWihvyAF6UXS7v0TNg59rDvsY/sqdl2TwB0S04cADjLHOxeB7neY37prTsHeFsE9IJ90sG6KoQAP4puoaxjj97qoDTWSOHjjqUq8U0kksNnlEN7BMQC+sBxR0vUXaY6iC9x72C+1pbtVLu3ip37/cU/54+gSXqJkcdq6xDe7AaS3Hvr+2Okv5fGUQRRzBVelWl26/NWLPmbW37Hid5DtUbuTiOfCQ4gpybDCklRphtJLDH/jmsDwcf+1HHVSVTPt+LISFVf0Wae5bGsoGvcNXiRyv99nV6GKgwr9SPCAEgJMKvYlfB7mrmI8sn9cPzPtihucldgVQBMbtTiUc1YcLzfuuK6qQOx2sU5h5WjQrhYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxtQms4SjVSNWFTMStWd3lsTTh3N25OdFJJSmN5M3IrNkZHQ3U0VHR6RGcr?=
 =?utf-8?B?ck45SENzbWF4N1ROSVlYU24wSW1jcHdzbGhwd2NLOUFvcXlxYWVPU0RtS0Zz?=
 =?utf-8?B?QUxHWE9nL29FWGgzRWJKWVcwZC9remgxTHI2K2RKSG5UTXhrcFZWMzgyZ2Jm?=
 =?utf-8?B?Q3dWaUxPcFluUFNObkc4QjVFcUtKdWgwbGNFV0RJb1UvNDBISWowTU1saWlv?=
 =?utf-8?B?aGhhei9WTDRFMEZrdjZFSzRFR1lEU3BQZWlidXVycmtEUm02aVlBdnk2bnBV?=
 =?utf-8?B?ZWh3ZjRFWnVXUUVJQXZGWDhzTXFaMGZUWmwwYlBzeERuMlJVbDA4MDRuTHl3?=
 =?utf-8?B?VzFzYk94dHoxQ3M3RTM3Z2tuNzlJN2U5OEVqN2VsR1h3a2RINE1Oc0hNZG05?=
 =?utf-8?B?SDhKaHRUeFduWUZFUzg5Yk5NYkc1Wk9oY0RSL0dJUjVSNjhRbXlCNVJhSDY2?=
 =?utf-8?B?dHV4NEVjZHRqWmtyVkcxMkQwdXdBY25wd3ROVlNnQVIwOWpyWkJZQlhhUEtm?=
 =?utf-8?B?Y0RLSktWYlFiaXNNNGNPTklHZWxHVkJuQ3dIUnJVemljSGxXalFJeklESCsy?=
 =?utf-8?B?R0pWQjlGK2ZsK1JsUk5BTitkZkt5cUtyQ2tnMFJNT0lLdHRxZEFvN1JWVkl6?=
 =?utf-8?B?cEh3aG5hVzBrNFovdUliVkk5OExhVHNWS2VoSWJsRlV0T0YxbURXb2piTUFp?=
 =?utf-8?B?Y3BEdnJKaVRoYVpZRzFiU2VLbzgxd1ZFQjNYL0RUZWVjcEdTRUxZRjZsQ0Qx?=
 =?utf-8?B?MDRJV1VWNzN5QzNCZHZFVDBGK0FZU0RiYXlyU3dJWHNtZVU3UENReHN1VXAx?=
 =?utf-8?B?N3Q0MGdmVUYvN0Jlc0lScm0xNUR5dG9KZ2UyMTByZ2I0REVUY1JoQWxra0tU?=
 =?utf-8?B?TVFaQzRGL3JTN2ZPMENOLzJRdTA5MzE1eDhuZEh2Z2lDNWx3RzlRUXRuanRY?=
 =?utf-8?B?bW13UGo3ZnpHOTQ1eXRpeDNIcDB2TmR0a20xUWRQUEd1cTJWalBZZUthTzRO?=
 =?utf-8?B?cGRzNG8xdDNzTk91RUlIUm1ITVFrNlNMelcwVFFZQU5KelY3bVpBbjlxZHdt?=
 =?utf-8?B?cUs1WXd1VEhtdE1nbHdCS2VEYVBRVHpoQmE0WEZaaDR4Vm1XUHNEbU1UZlha?=
 =?utf-8?B?Y0IrQUxGWWJOaFQ4VXhzMkFDQWFTMVBsWUhyMjlvQ0xqT21ESHArYjlZcTVs?=
 =?utf-8?B?d3dRU3VDeXk3K0ZMTGNqOTZJUHFOSDJFdU9xSXpIcWpBeHNURkhsMDltK1BV?=
 =?utf-8?B?M0JlcXhKS2xCeE9uU2RSNjNiZTQ1cmk5d0ppMWFobXlWRVR0T1lVcmF0U0l5?=
 =?utf-8?B?T2l6UG5oV2RFSmlvUEdmdFR1Uml3c2NHY0xPelFZY3BnRjlaV2gvcUZGKzNW?=
 =?utf-8?B?dWdwbHQ0R0p3SXFYcXBQNmtHcWdzazhWSDBYVkZJNjR5b0loaDkwQ0RuNWdT?=
 =?utf-8?B?TVNXcWJvOHVudUxTOEVxUGJEV2ZpNk1iWkFMd1RlbXljQTZ3dzBQb0ZnMi92?=
 =?utf-8?B?NXN2Q2lFZ09ZeDM5ZmFLd0kzNTVQRjFMazFsdXhmcmZkaVp1WC9QQ215bTNW?=
 =?utf-8?B?VkJtMURVVXZIQUllTXdnS1pJYjNWMDhoeFkvZkY3Nkp1Unloc2VONDlMOGxF?=
 =?utf-8?B?WjBMY2hYWWlEUVZpYVJId3N1VCs0ZnF3MEJUV3p4SnppSTVidTg5YktMYSs3?=
 =?utf-8?B?czUzcm9UK0o1b01RakcyaWdtamdKWFZpWmVtOGg3amR4UU5yU0NGcUNZZi8y?=
 =?utf-8?B?cDNVRzZKUFNBWVpoY0NMM3NBZTYzQmU5YXFmUVlRODUrdk9JVldQbkJwbnJy?=
 =?utf-8?B?bjlXYTFCc2hlNERFQ2N0ejR2eVhFb2RiSGhXNnhIb1NxTjMrZWJkNDkrNnEr?=
 =?utf-8?B?dFJ6OHBoWjdkcXo4d0NPVFcwSnkyNExFZCtEVUI1UnR6c3RQVHF4WXpTeVpS?=
 =?utf-8?B?N21rd1lzd2trM0VPb3VuMGdqSnM4NTdDZWRraWtITHVYWFJpZG0wckF2ejJw?=
 =?utf-8?B?OERLeVRmMW5BTHdHaXdHTHBnOStjZnNtak5ERDZNYmFwdktXaGM5MFIrTjFL?=
 =?utf-8?B?Nld2TVZDQjAxNWlJZERzaUZLbWVXUlgwblpyTzYyN2RhUUo4MUorYnpPZ1FM?=
 =?utf-8?B?cXFkMS8xOGNDeTdOTUlZVFZFa2tKWmtjcUdyUGo2TDJBYTJWT3ZJYzZLbGhl?=
 =?utf-8?B?RFBaZGRISlBRVW5PcWh0MzNnOE5KZWdFSTRkNUVsNmV2cm5YZUcvYy83VUc3?=
 =?utf-8?B?ejA1STQ3V2o4eTZJY1B3T3E5UW1CdE9YekhpSHFhMVBIcjFUYy9iVWlSczBk?=
 =?utf-8?B?eGkyVFdGdnk0cHdwcU4xMmVzOXYrUEE5eERQWmJ0c0tZYVhyWFU3elBYRVBx?=
 =?utf-8?Q?NkQRxdodsLyM6J98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <726E2DE10157134DB4E81829829798E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KVzJ8luyvjiq33ob826ayRxclyPMOzDuRzmYaMHZzwSoV1H6dAwTSiPUwZUEESaojOqYLMZVYXOYoKRbXQwxEC1bcNIuWHC/OzyTBzarxNYW9WDWA001rfVMlgfhtzfE+rDpSvpUo0IRci6QZGyLZFA/mHoNy5Ag4WIX2uNPGw/nuA0ZRfy36pXhB20VWZxXYMt8fCJiXXtlIR0kaV+/PzL0AECHWeL3pb7XvPtd3WDagb6vEZZoHa2ul3Pndgze9ixudKRteQ02roCyjWGA4uAdi3zzKDxQhWyOwaoicT7MgKsrcdNhiWuJ/ljbSUFkmNlsYPP6TAz1BnqQ2whDTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90bb893-3a07-4dbd-b451-08def71a3ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 20:01:59.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba7UEWOnkE6fiLGeGIAo69A6QysJcfiXe1PTTQ8qRjQdveD9+N3EGGvUthsOmupj2JTocnyZ4Z/Ss4myqo63yJyi0dII7PLtXNcfEBgdwds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9767
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTA3IGF0IDE1OjE4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBZZWFoLCBJIGRvbid0IGxvdmUgdGhlIGNvbW1lbnQgZWl0aGVyLsKgIFRoZSBzdWJ0
bGV0eSB0aGF0IGl0IGRvZXNuJ3QgY2FwdHVyZSBpcw0KPiB0aGF0IEtWTV9SRVFfTU1VX0ZSRUVf
T0JTT0xFVEVfUk9PVFMgZG9lc24ndCBhY3R1YWxseSBtZWFuIHRoZSBjdXJyZW50IHJvb3QgaXMN
Cj4gaW52YWxpZCwganVzdCB0aGF0IGl0IG1pZ2h0IGJlIGludmFsaWQgYW5kIHRoZSB2Q1BVIG5l
ZWRzIHRvIGNoZWNrLg0KPiANCj4gSG93IGFib3V0IHRoaXM/wqAgDQo+IA0KPiAJCS8qDQo+IAkJ
ICogQmVjYXVzZSBzbG90c19sb2NrIGlzIGhlbGQsIGl0IHNob3VsZCBiZSBpbXBvc3NpYmxlIGZv
ciAqYW55Kg0KPiAJCSAqIHJvb3RzIHRvIGJlIGludmFsaWRhdGVkIGFmdGVyIHRoZSBpbml0aWFs
IE1NVSByZWxvYWQuwqAgV0FSTiwNCj4gCQkgKiBidXQgY29udGludWUgb247IHRoZSBhYm92ZSBN
TVUgcmVsb2FkIHdpbGwgZG8gdGhlIHJpZ2h0IHRoaW5nDQo+IAkJICogaWYgdGhlIGN1cnJlbnQg
cm9vdCBpcyBhY3R1YWxseSBpbnZhbGlkLg0KPiAJCSAqLw0KDQpMb29rcyBnb29kISB0aGFua3MN
Cg==
