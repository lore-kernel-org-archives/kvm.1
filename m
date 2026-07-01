Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B31A275;
	Wed,  1 Jul 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864875; cv=fail; b=UmVLJFgM1vLIdtDcIHiYqiJzczKYU+jfmmBFEi6o/g0Gc2gVUzqSj4M7y2vtn3t+5n2SNgTnYo4rX/cC9vYafxr2Mlhlro/abEm57y7ZcUj8gendMDA1FDoHozm7L60FboU8gRq0j7dIdz1c3TPJyu61n5GhEVFEfHaaijhLEUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864875; c=relaxed/simple;
	bh=PFretfYA34BazL5A8JIvuevIztpWYU39P/kV5pZPrRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PvUrCXo6RWL8cpmoaN5ym9S2MFfxYn1K8LlrbhFqg4Lpvj6wAinaVczIyUASb4SPjh8l9HzI6C2NE48MDsYRa8N9pqUJ24hk5gEUESz3PfHd/JUxBf6nEf/al6D+rKMeWtAdnsraKBxSHIBi9rhcTFxlc0m1Lr5C05ACKZwoBzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huIbOx8l; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huIbOx8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782864874; x=1814400874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PFretfYA34BazL5A8JIvuevIztpWYU39P/kV5pZPrRA=;
  b=huIbOx8laD2enobv//lzldCxHHTpiEtj/UvsGFxCIBRgppi9l5dIG7YT
   B1UjcJr87ZkO3rKOB0BgZILOfy1GvtJfOVoef+7E35V9ZdjcL4UGz9E8k
   fGtrsv95MJmsq2XA2kndcd3wL2x4r/xF0qRGkV6VMdTgpqGBZ4VM59VDz
   AIDrfGnQdi2QcPkU44OoPN3cLgHPA6MK6MlCQrDglLQ2bZihJzzgBxbB3
   KO6OSM586WYfAb/Yuwc2xpxZnormbXbZVsLLmqxKoHoYOsbTgLG4DeSdu
   I5cQ410wcbnmLNJomzE/CqmpP68lgKvPpsUIbawk2NOb5qfmf+2KuYvv1
   Q==;
X-CSE-ConnectionGUID: BjzUVjF0RCyg0crbN4qkpQ==
X-CSE-MsgGUID: LMe4Olr9SWiJBA1KMJ4+aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83461410"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83461410"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:14:34 -0700
X-CSE-ConnectionGUID: o9VTcTeYQTW+nKWSZYJqUQ==
X-CSE-MsgGUID: ev5WZJlxSMmnBlx+r9ccbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="247932437"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:14:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:14:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:14:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWSqxwUSL7WyQv8ONXiE2P3diVy25HX/zvlsgpKC6snrRTse4UwG6K/LR8+XiR3aNiBAdJUpfb1eDqAa6MPD1AR7bRrMT/a7lemQVff7OQ+nLInnUjoW1Sn7DpiI8p0SEaphPcdFjaGD5DlIe9mt3e7liaTbjnTNuuK5vxkLdeCSpIeC4IIGvZdyfyUP+MHBfYXxWAYMlPn9rb3tJS/FeBRJhiHu4FOo4DvYoYVYbJ4iMCQ9X4yFYXnqXNhDMC3CEyJ6wxMTi4ZmspkYwmd4VoQjCwxikj3+gEzwon5HTMVz52fYaXkpFaHlVAqRjC6bgKnKkeDetZNXJZVvLtqFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFretfYA34BazL5A8JIvuevIztpWYU39P/kV5pZPrRA=;
 b=XJc7IMcn5PuxlvdpRe5ByrguhotUoDWw3xhqw/D/qxOBiAS347G97CJz18N2Yv8C9XQgHPNZzypjAajZGLlyvSkd5Du4RgEvJ4SJO94QkbBpx1/bAZp65KJLW6aXCIbfkV/ToIJ7JXUSm1wEHz23vjeyA2Mj2v4MnkW9Q9irX4KOzfNhdNCQtvnE3uDigdxSt3KhFjkLpM4NYNUgeBfG7dlF7iZ74nqrTJmIHEX7GNx744FbwSE6XT9Iu0v54zPt0VsdJ6s27oYn36FqZykrvuE7K6erMa+HAHdnf63xF6c29mLzAKCrOudxPFQQqgcO19Bin8UMotf/2CVHmJUdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:14:24 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:14:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHc7LhSIZlCRlcQpE6fbqoCJ0ANmLYuoOqAgClixwA=
Date: Wed, 1 Jul 2026 00:14:24 +0000
Message-ID: <f9f64c377cd81c06eeabfafc5355d026d802e1a4.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
	 <aiGi36_YpJBRechp@thinkstation>
In-Reply-To: <aiGi36_YpJBRechp@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|CH3PR11MB8752:EE_
x-ms-office365-filtering-correlation-id: adf08245-80eb-4395-205c-08ded705b4c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|22082099003|4143699003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: vVDbqUGfvfp0Ma+PZay7Odbrd4um2lu5+n4n/oL+HXWLGVo1biuklAaEIAqN2cqQ8lBgnzRZFYFTX7VWehVvbNlEPhZVYHY2GoTJblGbh3KhCusTByAyjG3pd/rGA/6KlkKNSqdRS5SXNJofG6WJcneUHgjt95v9DzdJcRARJ2kUnH1r1fnAsQdXcCsinPD0I2zaGr7XZ+4rdourTucg5eTmt3l4lfM0Sa58d5tMpLTxVYXQDKQdb7BhdswY0Rv0BfoP4q17bOJfPJ/ygbydjuxAvOSdF52X+zWCMuqVIELFKjh+r8H+1uCMxXEXAnFeg3BCy3ioNs7mZMSYF486iOpHqsyhUSXoB7tmy5ZBZ2gq0i4DmhJ259B7XLOqWe76dpphWv5+e4i1lxwLpimsavYRyDmT8wkikFvdZHhlPlzeYsf3uCugZd4YifdMVuVyNT9PX0TXdzq8lPLI0Ul6s+1srn9fj8jrFDdTXhfJH6O1ZNuFy1Ru+Zrp1H0Spu2Gz53wRGZU9Y2K3ICoo67qR0pKGkY/E9/UUHjxJK1+fpKUjhDEYw63sdC6fEAn+mg4siiTMjF3Rax17TIMJHN+Qe/riEDs5ZQ3TNxGtteqKEzaaVs8aBfm0yj8srdnlVti/zNIdNZuLQP2YK0DhN+RFUTmD8kuw68kswzn7ri9hCFFJA0QaEGF98nEo7hcy7yvp3DIEzCaqdrRHkcieCJGO59G/Ivxlz5GiABj+2JvQWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjRRcFNGZXhpa1Jkbmwrcks5akJuc1cwT0wwY1hUSXpRYlVmQk5ueGIzOHFi?=
 =?utf-8?B?bzltQmpBMFp0bnJWKzc2WVluWW9jQXVENG53SnBiUzB1Y3FYcys5Sy9Qa0VQ?=
 =?utf-8?B?VnU3SjNBUlRhUjE5SlpQSjcrcFdXdlJYZExMb1ZlU3Mxc2pkTE1yUnBXSHdW?=
 =?utf-8?B?V3FzaFVqTlRJK3FtUDhFOWdVRlo2bnJXSUhLVHJQenVYSlBPcGlIaWNNekdG?=
 =?utf-8?B?SUhzTnlYelVQRHdKcHZzeTBndzQyc3lSL3A0elBsUlNGcFBnbXNpeFVXZXNU?=
 =?utf-8?B?bmxVRkYrSDFPaWp0VHR0RG9hSGw2OGZVcExqV2J1ejR6QzB1NWFySkRjS1dW?=
 =?utf-8?B?T2xYZkNycE9mWisxV1g2c0pFalBXRHRrWlUvRUNWT1kzdytwSHdrdHZHUExz?=
 =?utf-8?B?K09Bc2piVUVwTkh5bFdmSERSZDBmMysyeGRESHNBV0s2OVJpYUh3ZkFEWnZO?=
 =?utf-8?B?Q1dKeW9wZFI5b3o4ZU5qNWg2WENJSENmeC9LY3hpMEx4SndlTmd2ODM2SGVC?=
 =?utf-8?B?SGwzVll3UFpJamZZL1V2a1U2bXhtaEkvQzZvS3FzRmx4bm5CVWhKVmJ0Y0Ix?=
 =?utf-8?B?cTBTcjdOU2JpZGY5TDlpeFppZ1pKOXNaSHBLYUFCT0hqUGY0clpjNXcrMEMr?=
 =?utf-8?B?S3hpYjd6ZlB1ZTNYRWxjbjR3eGFtbG9MT21rS2pHcVVRa1lTaURKWTErNXdy?=
 =?utf-8?B?aTRlNk0rOEJZc0d1VDRkS1k3Zm9GRTVlQjQxSnA1TlNzTEVFaEFlaVlXUjlz?=
 =?utf-8?B?QmlabG50SENXY3BLZDdDd1ZOTXptOTVYa29kUlI1YmlSUDVRRUgyd2VpNXBq?=
 =?utf-8?B?Tjc1RlJpUW9CZzJLY0xCb0Q5WHBCU0l3NGN3OExwRlRUWUVUY0g4eWw4aDdR?=
 =?utf-8?B?VkZkYjZUN21JUTNhOUxPT2doS3VLWitYZGsxdlVtZGF0VlFOOThUaFdCU2dJ?=
 =?utf-8?B?RnkrVjhvZzI3NmlBWlkzc1hmVHVSMDZqVGlpSkZVN0l2anJ0b1h3VWU4NDJ2?=
 =?utf-8?B?eUJQVVI0cVpJc0xjMXg5VzN4ZW11M0RqWWZ3amxCUVVpWEdlcUtISmdaZGQ0?=
 =?utf-8?B?SzRST3BUeTZnN2I2clRTOXE1NjJ3UWVWM21iZ3FTMFhkdGp4cWQ1ejFVVHY2?=
 =?utf-8?B?TjJNa2luVDVhazI0eVE3cFhlNG95OVRVT2dENXVZbjVmamhWM0xRalpLaDR6?=
 =?utf-8?B?Slk2S2hhMXFrZGV6aWIvZmNSZzgyenBzR1NtZThYd0NUNmNQa2UybEZzWC82?=
 =?utf-8?B?aWJ4RFhNbnV6cHdkNUJyR1NwK1cvN1l5cDZoOVVhSEdsR2ZCQmpLYVJuV2xM?=
 =?utf-8?B?R1N4NHQrZjF6QzlvcUhoTHA1UzBKOEJtWFJYa2lBajQzbGtITW9RTnBKWmth?=
 =?utf-8?B?bFJHT3hyUE9GRVd0TkhCUDBFdmgyLzZWdk5EWTBnbWZmYk5JQUswN3NRaGNz?=
 =?utf-8?B?S1l5UFFYdTZneXBiV0hkL29yTU4wcDZnanB0MnBDVXB5UElheE5US0tHVlpr?=
 =?utf-8?B?VHA4YlJBMUhQZnFlcmJuVkxZYkNFWGE0dndsRXdua1lhMWJiTjUvRnNtNmhH?=
 =?utf-8?B?ektiSlNsOGNlS2l4aFYvRGhkNG9wTGN0SmpYS1FCM3dMVUZLMGIvY0RJRlNT?=
 =?utf-8?B?VWlCWDFQQkdYNmNMYnZjSWc1M0FQMzRmRnJnYUZHWjEwcmZKejdqMW0walYy?=
 =?utf-8?B?M0QyZlhnM0lmMWlMTFlNSnNUODVNeExFRHNqV1BVdDJ3OWR2NnludExCUGFQ?=
 =?utf-8?B?M2d5UHl3L3JOQmNRQnBxdDBic05neDFxNUJheXUvWnpoZjFSTDJqQnFKOUZv?=
 =?utf-8?B?MkkvQmE4VUVaaFZRZzVxQ3o3YTBvMkRZQVo1L3hMQkQwdXRkV3lTV0lHbmdh?=
 =?utf-8?B?QmNGOHBvakZMQ1pYTkp6c1BDaUhXaHkrMXFVSEFEem9OdnZTOWg4bTZLM05V?=
 =?utf-8?B?QzY3WGp0TDNvMUQrTXl6WllWR1VRajZGelg2YmgvZ1FBK25YYUhwZjV6aXRk?=
 =?utf-8?B?R0JucE8vQnBoajZVSjk1QWtTOXpkb0FFMEZsWmw1NVhxVUtLY1AwZ0tRNTI1?=
 =?utf-8?B?eDFySHBkQkRjTU1RK3pFSFUwMFQxMURSZXFqN0tPeXpxOUFkbnIwQUhtMEdB?=
 =?utf-8?B?T1BRblJBYTFabVFHZy9qdXkxQ29WR1IzWk41cTRiZkRaVmNHSkk1MVFWVGZI?=
 =?utf-8?B?UmJxb2VYNlRKOFlab01WbWNwQS9QaklHeDd1SThwTzdvVWhweDQ3RGlFckIz?=
 =?utf-8?B?TTJjSUtZT0ZpRGc1STBpUFhobXV5SGw2Vjd3Q1VPS2grb2xqdHp0QUx4ek9z?=
 =?utf-8?B?aEl6K2VHR2E4cjYrYmN6WmxnbGl3OTQ4UWFxS2xYZUV2YzBPdGxhcjFSRGRu?=
 =?utf-8?Q?nuInjSuRF4jcV4ss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1263DCC1704C4B4FB796C5F3A357FEDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UKTYusiq4XsjGTdogjS0PdDSfDf9rFRrnuuLrFmd6lgv4pyhs7DYnVLfYLKKHHFQO2ssg6DOBP76VvwG6dTvsWznh4FG9HDol5l3ebkr9+gcEUa9LKs5hyfS9CdGTm2JdJUW82XkXxvxNbG9ew+wwfilvIjUskxDSJc4Hrz/xZxzwOscnFj7m9smqfZj/HuCLY263LSSuwhfSneDgRLU3RsTW486zgtGYp17cWAryAbeezm4eGO3QqKQnufDYx4I1x6uMysy7GrzRdvnuJv4uHYNdyUDsD7acS+u7J2NDLDhYnHwnXFzk5FbXGG+a7NuvdMwalBj/sk23o0gGEFFow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf08245-80eb-4395-205c-08ded705b4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:14:24.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9n6x1LZL2QqTWIiSAAx/ivbP+Kfe4oMPka764rIu063jDuTKwOlEFoNpgDP8aSgRXRXaclcDXyBfbdIdiXcsR9TlDrZRPGU/EqS1a32utQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTA0IGF0IDE3OjE0ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE9uIE1vbiwgTWF5IDI1LCAyMDI2IGF0IDA3OjM1OjA2UE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEBAIC01NzksNyArNTkxLDEyIEBAIHN0YXRpYyBfX2luaXQgaW50IHRk
bXJfc2V0X3VwX3BhbXQoc3RydWN0IHRkbXJfaW5mbyAqdGRtciwNCj4gPiDCoMKgCSAqIENhbGN1
bGF0ZSB0aGUgUEFNVCBzaXplIGZvciBlYWNoIFREWCBzdXBwb3J0ZWQgcGFnZSBzaXplDQo+ID4g
wqDCoAkgKiBhbmQgdGhlIHRvdGFsIFBBTVQgc2l6ZS4NCj4gPiDCoMKgCSAqLw0KPiA+IC0JdGRt
ci0+cGFtdF80a19zaXplID0gdGRtcl9nZXRfcGFtdF9zeih0ZG1yLCBURFhfUFNfNEspOw0KPiA+
ICsJaWYgKHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoJnRkeF9zeXNpbmZvKSkgew0KPiA+ICsJ
CS8qIFdpdGggRHluYW1pYyBQQU1ULCBQQU1UXzRLIGlzIHJlcGxhY2VkIHdpdGggYSBiaXRtYXAg
Ki8NCj4gPiArCQl0ZG1yLT5wYW10XzRrX3NpemUgPSB0ZG1yX2dldF9wYW10X2JpdG1hcF9zeih0
ZG1yKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJdGRtci0+cGFtdF80a19zaXplID0gdGRtcl9n
ZXRfcGFtdF9zeih0ZG1yLCBURFhfUFNfNEspOw0KPiA+ICsJfQ0KPiA+IMKgwqAJdGRtci0+cGFt
dF8ybV9zaXplID0gdGRtcl9nZXRfcGFtdF9zeih0ZG1yLCBURFhfUFNfMk0pOw0KPiA+IMKgwqAJ
dGRtci0+cGFtdF8xZ19zaXplID0gdGRtcl9nZXRfcGFtdF9zeih0ZG1yLCBURFhfUFNfMUcpOw0K
PiA+IMKgwqAJdGRtcl9wYW10X3NpemUgPSB0ZG1yLT5wYW10XzRrX3NpemUgKyB0ZG1yLT5wYW10
XzJtX3NpemUgKyB0ZG1yLT5wYW10XzFnX3NpemU7DQo+IA0KPiBNYXliZSBpdCB3b3VsZCBtb3Jl
IHJlYWRhYmxlIGlmIHdlIHJldmVyc2UgdGhlIHNpemUgb3JkZXI6DQo+IA0KPiAJLyoNCj4gCSAq
IENhbGN1bGF0ZSB0aGUgUEFNVCBzaXplIGZvciBlYWNoIFREWCBzdXBwb3J0ZWQgcGFnZSBzaXpl
DQo+IAkgKiBhbmQgdGhlIHRvdGFsIFBBTVQgc2l6ZS4NCj4gCSAqLw0KPiDCoMKgCXRkbXItPnBh
bXRfMWdfc2l6ZSA9IHRkbXJfZ2V0X3BhbXRfc3oodGRtciwgVERYX1BTXzFHKTsNCj4gwqDCoAl0
ZG1yLT5wYW10XzJtX3NpemUgPSB0ZG1yX2dldF9wYW10X3N6KHRkbXIsIFREWF9QU18yTSk7DQo+
IA0KPiAJaWYgKHRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoJnRkeF9zeXNpbmZvKSkgew0KPiAJ
CS8qIFdpdGggRHluYW1pYyBQQU1ULCBQQU1UXzRLIGlzIHJlcGxhY2VkIHdpdGggYSBiaXRtYXAg
Ki8NCj4gCQl0ZG1yLT5wYW10XzRrX3NpemUgPSB0ZG1yX2dldF9wYW10X2JpdG1hcF9zeih0ZG1y
KTsNCj4gCX0gZWxzZSB7DQo+IAkJdGRtci0+cGFtdF80a19zaXplID0gdGRtcl9nZXRfcGFtdF9z
eih0ZG1yLCBURFhfUFNfNEspOw0KPiAJfQ0KPiANCj4gwqDCoAl0ZG1yX3BhbXRfc2l6ZSA9IHRk
bXItPnBhbXRfMWdfc2l6ZSArIHRkbXItPnBhbXRfMm1fc2l6ZSArIHRkbXItPnBhbXRfNGtfc2l6
ZTsNCj4gDQo+IEl0IGFsbG93cyBzcGxpdCBpdCBpbnRvIGxvZ2ljYWwgYmxvY2tzIHdoaWxlIGtl
ZXBpbmcgdGhlIGNvbW1lbnQgYXR0YWNoZWQuDQoNClVoaCwgeWVhLiBJIGNhbiBzZWUgaXQgYSBs
aXR0bGUuIEknbGwgc3dhcCBpdC4NCg==
