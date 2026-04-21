Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A47260F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795080; cv=fail; b=GNvAzSjRifHN3I7UgXLYK/9aUYiPeAt4hXuNdUmD+2vD0gWdU6hId/jjDAH0hqW/ijFM8767jQkE9L/oG7aF5E6PBq3zyZ3Mgs89Wz7wtoe0QF1AwO7OY9I0HoBNiKb5JtY1Icf7lldNOKuPRDOsxyu2CUTY2P8sewZkABnK1g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795080; c=relaxed/simple;
	bh=6hb2ffYPT/eAPR/dOY/fBoOM/3TD2ZrvmQJ2DaZ1XJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWHkkDXnaX2dSOrmujQbyNolqqQCxHmZKyATvXMuFTGu+9+eySsvsQSZXYmOQ0FMyQBz86EuDROCMkTEH5DqrWDCNHOPUIRRbBKYYF3GHShVqdL+meH/cauP5Cn9hK2fhbdzrPenMsBVB4jY5Jolad4U3+IbYQSff9q166ou1wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XftcaaGa; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XftcaaGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776795078; x=1808331078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6hb2ffYPT/eAPR/dOY/fBoOM/3TD2ZrvmQJ2DaZ1XJs=;
  b=XftcaaGacSX9SE1vRw0XXcWPDXeYbikLDlGnhWCSQavQudxRQooD7hPC
   Q91aue8mdHtNKKkpSL1ckLgeiUgi9bSfwsI3XlFzTWVOJX44Q3m+A12ak
   BtHSDyVJRg1MoEgHTNWU6XBPikZ6WN8QvOtZ/qmupsq2fznSdwBgyj/xu
   J0KlPgp0jpYU0rHxHTxwmVfvmS4OuVMzQLtY8XfqRTEvs+O44kzVWMy9Y
   Nh99B8xEWs5jBA8JqEm34/3SvEMU0D8prYJ1dr5W7OY6Hgw22wAlqIDXH
   2YzBe9xIiNcpmoc7AD1fC/IwS5zhGv4q7XIQcVTQKaH2R5MzL2xSHO+CY
   w==;
X-CSE-ConnectionGUID: 4wcfLfS7SR+qS9vF1g46TA==
X-CSE-MsgGUID: Fz+RcWFhQF2CwO9+ol+o1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88038540"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88038540"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 11:11:17 -0700
X-CSE-ConnectionGUID: jskl9oUBRxGFpEWYZYmDsA==
X-CSE-MsgGUID: y0tfNylRSHOoVlzcI7dHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236486114"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 11:11:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 11:11:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 11:11:17 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 11:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiRppaz8EWxcza0BMHgZCV1NrU3pINXL4OL4uIqG0vJa77yt9sphCxtjpd6cyEivu6nDmoAqTAofhm+Bzcl4jU8m1mGlU1Ueg/CBul+1rU5wBRiZjYhutkxPDDtLhxfnu0xEVlDEjJwUF9xhlCUOB41x4/z3TyYxQJzbRNT9kTnoPjwVFzdzFEM74bf31J9Na1iSiqmdEbBG6HBFwT39mf4+Saoc8K9JRfSkjG2tzWFvDWO6uDcNCfY7yJGKkPWG83mfc+kTtJ4WDEk0EPZBrgWaOqog89QCSoq52oPyxeR5+SVSkUvtvQCcuAsXYuGpucvF7kCAdIORwafXT7pJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hb2ffYPT/eAPR/dOY/fBoOM/3TD2ZrvmQJ2DaZ1XJs=;
 b=X6I3iz6jRb5bBWMGRzciD3rYBwbNAOQgzA1tNgcDbwKZxKA61185TR68pm0IT0ZIihxzPRL1QYGtmyef1VSaK/KvCYuXvyGHhfk2wQvyLOl4toF/xd6WR3qALLluKCo0PJk1rmlHVa3spHfpGf1/B9+9KbsWydubmpZ14L4QcYvQkqrlpZG6i+aavFgoN4UtA9GL6BEt4hAlwSjM9fvoBAyY7K3ao62TkV/itR7nxGasqDF8/f2h7Yra4kxxA14eM3Sw3lBln18YafgREMPnMOw9viKcTTNZYJ7GGG/ErxSbrwoHjpgoFucny8cBv404AcHYORHgHLE+vz65PDPF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:11:14 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.011; Tue, 21 Apr 2026
 18:11:14 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "Wu, Binbin" <binbin.wu@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgADoVICAAC7QAIAAPWUAgAADsgCAAACJgIAABFgAgAAEboCAABTHgIAAApyAgABOyQA=
Date: Tue, 21 Apr 2026 18:11:13 +0000
Message-ID: <f88a2882b7dd59209b512a41997f7d21cf2bc32d.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
	 <87mryxekxy.ffs@tglx>
	 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
	 <87eck8daot.ffs@tglx>
	 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
	 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
	 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
	 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
	 <20260421120531.GF3102924@noisy.programming.kicks-ass.net>
	 <20260421131953.GA1064669@noisy.programming.kicks-ass.net>
	 <20260421132913.GB1064669@noisy.programming.kicks-ass.net>
In-Reply-To: <20260421132913.GB1064669@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BL3PR11MB6435:EE_
x-ms-office365-filtering-correlation-id: 1ea8619b-51d7-4cc7-d236-08de9fd16007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: b7cLq72JF/8rC3hiuIkLlKyTtNwQHfay2oCA/ioklIHhCSgWwoErIKPrNXlr3kzTr8N6Fo960zDvzStE75yDfdDm+pGwUoKjdWW/1TyLOoElWA0nxV1Vfa0Bk/rcmnwRIZzefUjMowlUqQ41Yir4yBaZuKYJRMefKRqnh98AqRYyWyXmj7gFSAeFSzXFVJGr8zhrSroSIWoWohXK6Fpfe+c8XSUQWvQnT8z/iSDTx4MtC/vZJUR6/BEBEYa7MXotRjWRimtDRETLMkKcN5BgKlDhONLOjcPMysvFpx/VOvK+g62J0DDSGQyN8qlOjxQJlMxBKegfm6fXN2qaqUt41tFolyY9o15QcNykqSFVWV4M8fjGMzWS5rJL/NrMpuPz+GvowSATwGtpl2w47VOutQAzah4pulEXnM3FD0YHZaufmKnBNFTkaYx/lzvUMdMSrGh2B6f8A3/d8kQoQDaA2QC6jJZv51C/Z/o7ls9l80dwjAmsSoGFFCngNQI5ejb4PifB1rrpLK/8uqJpz+kGVCB5ccmh2dRK+v1HGeUcnaYqQP/oBu6rwsUtlSXUVvJNnWvgPtyILWAO2KIRxlJtGM1NxQQAFCDv93D4AcriJVwdjftswxngrrSeIY0emSIOCnBLopRkkaEw3kXAblYlJgKfxB1ZfuLhhrl/Jo4OjtW0ohTYxfV1km1+NkfV823IkdfTkhVqZ2b2RlzQACSNaH98q7Yq7YbhdlDJ5pzBvIgOQ6R1HOVdtBcmb4uDvwC28HESpQkpfEBbeM+2FMtRd5dpT3WQsGkcK++Bg8q/94A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUkrMXJBNzJUTEpvcEhlVW9ZcDRxYVV5aDBKSkIwYU5UQTF2NFUyT0tpalZ1?=
 =?utf-8?B?Z0Noa3R4bm0rQytaTzUzREpaekMxMzBEVkgyNkJxMTY2aW1aeFlSRFhoZG1y?=
 =?utf-8?B?NTRnZFB1TnhZd1JEa2lTaHpGVGZJcXk2enJJN0NydEt3TGxaQTRRbGJPbWNk?=
 =?utf-8?B?bjNxblBRUjlZZFd4RDhvZlNEQ0hzL0d0S1IzVzJOSDVKWEFBZkZvQjZWek5S?=
 =?utf-8?B?bUhraklnR3NKK09GeGRjZXR4c3dKSkdiYzJ0TlpJRmFZcUlqcHVBSXZ0bHZK?=
 =?utf-8?B?TkllQ3FqNHhVc09xeXU1UkplN21OdHA1OGthRktnbDZxQVVCNHBtYUszS1F4?=
 =?utf-8?B?N3ZNRDNOZVlOdDlsT0Z1Wi9VdGRMMXF5WXh4cUN4VjJGV3BIbGE4V0d4a3Fx?=
 =?utf-8?B?TiswNDY1YXlRQVQ4V0JSVVF5WEFHSkxVMm9kQW5wY0h6eUV2RVBzc3owR1RU?=
 =?utf-8?B?TEFjZ1VWZFpWNnRqY21QVkpKT2tuWEcvTzVNNU1lQk14V001bHZzbWVZVzJs?=
 =?utf-8?B?TzNFV1RGVThybE1SaVp5SkN4NmJuN2YxV2paQ09yTVorVThGOVRCOGdnME56?=
 =?utf-8?B?LzhGQUJKWUVyU0QxRVBxY2FMNVlSVjJtZXg0cDNnYTEvSGljMDlQbG1yUTVG?=
 =?utf-8?B?aVI4cm9VemJlN2pySTJCZWR5WmxMdzlWRHM4TnhlYjFFZGdYbEJidXFQT21V?=
 =?utf-8?B?Si9jREdHUmNWT0lLNWZ2dGFESG1tTXRDQkdUUlMreWJXMlEyVHZNVXU1OTNa?=
 =?utf-8?B?ejI1UytpVFhyLzArQW1mbzdwY0luOWljNzVvck1kdGpKaVp0OC9vOHg4aEQ0?=
 =?utf-8?B?M1RNbDYzdnZBOTVOb3lhZVRZS1UwbEZtMERKNlh6YWUvOXFVYjlsYkl2Z1Bm?=
 =?utf-8?B?RlJZSk05U3ordXhqWFZicjhFUjg1eDBHVklwKzhHWUxkVjNJYW1STjJRbDdU?=
 =?utf-8?B?MmZIMGgyUHl2aTVLR2Z5bWZCMjhweHMxOHZLWEhtMk40YXp4UThlckpjUk1H?=
 =?utf-8?B?cEU2ZXBhQWo3V05QeTFuNVFPVnZXZzdhNnQ4YUtrMFJJbEhTbHJnUGZob2tQ?=
 =?utf-8?B?VlEyS0lmTE0vbEFlZHltNGhJNU1iOXpiVVZFWmttU0FOcnBEdVlkMXBmbEN0?=
 =?utf-8?B?ZWRWOE5ETURCNXEwSE9EcS9IcXNSbXFBb1VHUUlxODFFVkF5UnQ5c0UvUzE5?=
 =?utf-8?B?RkRxckxhUmpkeEFqK1hIS0hjNWwvRDl5UnVUKytWcC9vUXE4NDQrbGhOTVEr?=
 =?utf-8?B?U0VkU3pmVVVzeW1vU2dMSk5qWHU5M1lleXNNcGQwTzJQQXAwOWlWY0dKbEE3?=
 =?utf-8?B?c0E5VnRrZjVrT1FNbHN5VS8rWGNZQXVzOU5mTTU1WDRoRnVLOHJxRjI5T2Vo?=
 =?utf-8?B?ZEI0dkI2U1FJaWw5SE5IT0xzMDNtZEkydXBnbnhZZi80TVE0Q3htMmNGbWtv?=
 =?utf-8?B?bHVJR3NMcHMrTTU3dmZPR1pSdU1DTU9JRnFMNFZqQlJEek5lREZZMW90ZmdO?=
 =?utf-8?B?NG03TjZoeTZJY2NndWpMZU9XZU9pUlVGUmwwbnVlZ3JEYi9yRW4wL1YyYnd5?=
 =?utf-8?B?YTlySmxJUnZiR3JkZHJQNVZFSGZpYWM2N25paFN4S2NULzlMTHFtQ09adVUw?=
 =?utf-8?B?UDQ4MzhwR0tURlpnYXZORy9sZTdGQk5Qb0pLQ09OUytvZ3JBRkdZR1VCTDhi?=
 =?utf-8?B?elB5blk1NlcveHpBSFFMNjB5c20wdkJiNnYySkxWVGdlOTZoNWlQcDVWUWxI?=
 =?utf-8?B?cUJTSU9wMEUvbGN6T0kyK3dVdUpLV2NzcXJKa1R1KzU2UytBdnExOGFpT2FW?=
 =?utf-8?B?VzVsWjFoZHZSMGNvemxWa0NHbjhidEl2WW9jbGFSUk1DWTV5MjZRVGRuQ1Vv?=
 =?utf-8?B?UGxXclpUV2tEb0NFb1BidEpyaUpoWlNUZVoyM2FLejRiREhKLzNGNTcrY0s5?=
 =?utf-8?B?ZDV0ZjZQTThmUnJpcDZNZExUdWJNa3ZrdmtvbEhjYlpkNlliRld0SzlVSG1p?=
 =?utf-8?B?NElnUEpJMGlEK2VRSlhQc1dPZERZZkh4RFBTWlVoUXdnQnJ3Ui96RzhGNGhl?=
 =?utf-8?B?U3JVQlNLeVBxQkw4Q3Q4OTFWbVZlSmNLbDNlUEY4Nkx4WGt6UGFCdDdPSlZx?=
 =?utf-8?B?UE0ySjQ5QmhmR2E5QUZtaXBwSmRXRlVSRUtjV3RvRDB0STlWMDRRRVFteTNy?=
 =?utf-8?B?ZXZqNnM1TjRnYndKQjBSQzVhYmZiWGUzc2ZiN3h6cUdUNEhDd3plbXZ2LzhX?=
 =?utf-8?B?U3d4WlR3YzhYTjlYZHBXNlV1OENiaG8ra3loS2NjcHA0bC9qdzR4TTdhMUFx?=
 =?utf-8?B?VTMvdkRmZzBkWjlnWFJFbS9LSXJSTHl5YzRiak50eVZlTDBDVDZObHV3VTZt?=
 =?utf-8?Q?P1/eYQ71QXn+NRvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5E998D7445ABF4DA0EDF7DA98280AA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: egfRrDFMJ2tW9rxw0hHRYNsQdd6hDGwrAfCbt4m5y6TDYBhP9OiWDkV09GLruTC/IhTYq4c/Xz7CF6ZcR1lwPZvCsZggYPdNuJMQCxJyFZisd8evjfaoU78HmK+KO0jflbeSf6WCIvJkq9P0LjFIsY+Ze1pPLRNzqPIdFiAgHYmNt54iHksV0JKEGfQt/hwuFrd/QwJXuUuCLKhsDc8qWc5XXAzdnx2QwnwfwKkPf8zwTQSW90FNpGSFj50vSdG1nieyRdNSB2sEFcKNL87rRf/+a3RTwt3AzaNt2QTV2BIPLPWpJSLJEaPE2medyvBLE2fuH5aLAt/NjXDQ1gndOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea8619b-51d7-4cc7-d236-08de9fd16007
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 18:11:13.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4mkGOUwwIs3vknr5y1bwNRpFSH50es+uAPtLoRXJFHOh/QoGQSQ18j+yhcGnIMW09CVNmsfAg44nCZuBvYLco7g+zGh/3a2/J8zvwnBY6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDE1OjI5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3Byb2Nlc3Nvci1m
bGFncy5oDQo+IGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9wcm9jZXNzb3ItZmxhZ3MuaA0K
PiBpbmRleCA4MWQwYzhiZjExMzcuLmQzMmVkZWZkZTU4NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS91YXBpL2FzbS9wcm9jZXNzb3ItZmxhZ3MuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL3VhcGkvYXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+IEBAIC0xNCw2ICsxNCw4IEBADQo+
IMKgI2RlZmluZSBYODZfRUZMQUdTX0ZJWEVECV9CSVRVTChYODZfRUZMQUdTX0ZJWEVEX0JJVCkN
Cj4gwqAjZGVmaW5lIFg4Nl9FRkxBR1NfUEZfQklUCTIgLyogUGFyaXR5IEZsYWcgKi8NCj4gwqAj
ZGVmaW5lIFg4Nl9FRkxBR1NfUEYJCV9CSVRVTChYODZfRUZMQUdTX1BGX0JJVCkNCj4gKyNkZWZp
bmUgWDg2X0VGTEFHU19LVk1fQklUCTMgLyogS1ZNIEZsYWcgLS0gbXVzdCBiZSAwICovDQo+ICsj
ZGVmaW5lIFg4Nl9FRkxBR1NfS1ZNCQlfQklUVUwoWDg2X0VGTEFHU19QRl9CSVQpDQoNCkkgZml4
ZWQgdXAgdGhlIGNvcHktcGFzdGUgdHlwbyBoZXJlIC0gICBfQklUVUwoWDg2X0VGTEFHU19LVk1f
QklUKQ0KDQouLiBhbmQgd2l0aCB0aGF0IHRoZSB0ZXN0cyBwYXNzLg0KDQo=
