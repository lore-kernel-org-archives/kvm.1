Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA530C60D;
	Thu,  3 Sep 2026 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477391; cv=fail; b=Hzmq4WXyDmoAkqd+8hr0UIJLnODl3CdpD3Kxbh+L5/X7IAUmMF6L2Y1ePSPSBIhb7DmMeRM/bMRoRFcOvtk5VVG9WTRQtlsJ6mZ3o0kidWLFBJNn8kU7PUhz5AwCg8IYAoo18VHYdYdfiGnjDlPbcnJ1P7EYwvqclLQMEL/+anA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477391; c=relaxed/simple;
	bh=f+6QLATdLoMDtdcLMyXNxeLeD0k0uOxxN6z/mRajiUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhJsHdQoT6xk0RwylNfGqjBE25lnueRWyo95NLDHrGCKdA89baKceUwTiydLL89Fg8diihccgmRJSgK+zUnkPpRItcVfEUzZH/+ITSJffL98tXu4JC7x5GXnTw1UMC26okufkzbgA6gpCOLqtsQoz5DlR0n0/vllhRR02S/y3VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laACcymG; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laACcymG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477389; x=1820013389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+6QLATdLoMDtdcLMyXNxeLeD0k0uOxxN6z/mRajiUE=;
  b=laACcymGJKEU0GangmWzZugYDHtQ0YBtQnpQgsQsCBIIDg+2EVOLxT8m
   K07DjNxH1Kb0M2PfcEWbkslE9VqEnfZtUR/AX67oEBOWo+6DgD0gU0Ee0
   hGgg/F2k1iK18JEIwlfPQ9xJUIvf96AXNfy1ARsP2ZvyUGjlvty9H0f8b
   oLUFQ9oUE6XpQxx3FYg2byS86EVCHkkWQw9i2+2r2t860JqOdykHWgJuT
   /HHMMR7pI9BUVqGzL9Wwfrwbs+BQk4qWCwB7BdWwUMP8LZHoe+cQl5bUL
   4Vtnr+cMLQi3U7/IGSRunzLUz2omk7GSWCAqouqtZUQIn2uYQE1P5kaFU
   A==;
X-CSE-ConnectionGUID: p2KH5e4KRiuP8qltFqkaYg==
X-CSE-MsgGUID: EapnJGydQn2flBR/4Q6PZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89029557"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89029557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:16:26 -0700
X-CSE-ConnectionGUID: UCYSGVkhSSCQ1Mg/9lptyQ==
X-CSE-MsgGUID: Etz32H/RS+eVjrTxaWUHEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299730079"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:16:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 16:16:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 16:16:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 16:16:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXuMcxH/mWRJw/kw+qRB+e7b1tLbJq2Wu1+3f+MJTve1TeYTBBJRbZ1MPmp1j5cVRrRSR55CuX7U+K8oVocbL68cNqjmPXFHK7yHoffbRbD2PUxWCVp6b+TfNE60e0NtxPNkPMg/WAszK0fnibPBicwbTEqZyZ/K41G8VAeZ6Efr/VwlhHdVGfg4j7Aul0dibmqsKIBTEJA/5cn36BIWrqsa5epW0HkHu+883Gy0QglDP1YU/Vn8CcTtfd9TpCYKo8VcBDoLa34d5EcAwld0NN6BTIdc+m3HGn2e55XpZ79Ypj4LDF+CTKc53UxUhN7eEOLrlBv4HmcIGx8KM5+iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+6QLATdLoMDtdcLMyXNxeLeD0k0uOxxN6z/mRajiUE=;
 b=KtdbA27SkqHGVdcH24/RIXXVBPFzg4GBVobSKfs/qNOJOhURCuMLKUgfWPuUytV9FGqBmTPfhXWUkO74pU3+B4Bc8OMMW9/63gjSUNx6rMJGUxxYJ51erWrmuO8ty9hJ+bZPT5Nqicr/ZCDBFRDwbnuMOwfJD/dG9mVUy3Rtn+CZvLLAQGy1IhOzXjEzEV4lT118hagYgUDjKdn8Ypr5AprVNcgtqlFBxElk0x+nzPjkrYfhkfLyOuxtjULeRPz2h4xG2K5UQCldrQ9IVF6zjVw6wFr5fHtig2uD98G08k80LgH2qQ/8TovZlxzsgIUcrUCWLqqC0729hnghoVaBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CHAPR11MB9677.namprd11.prod.outlook.com (2603:10b6:610:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:16:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:16:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hongyu.ning@linux.intel.com"
	<hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v10 05/11] x86/virt/tdx: Handle multiple callers in
 tdx_pamt_get/put()
Thread-Topic: [PATCH v10 05/11] x86/virt/tdx: Handle multiple callers in
 tdx_pamt_get/put()
Thread-Index: AQHdO0bBdZu36Du5V0a0JGmeTKVb67a8GiUAgAFjt4A=
Date: Thu, 3 Sep 2026 23:16:12 +0000
Message-ID: <9d5771db8e3d3ef150d25809654dbc1894034aaa.camel@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
	 <20260903015113.93343-6-rick.p.edgecombe@intel.com>
	 <20260903020303.349961F000E9@smtp.kernel.org>
In-Reply-To: <20260903020303.349961F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CHAPR11MB9677:EE_
x-ms-office365-filtering-correlation-id: 90abf493-f624-4399-b1da-08df0a11585d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|11063799006|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: W9R6Q2Z5x/g0oGErb3804ebwj8dGvzwf8MV7gCiYHvq7kvvaGU/oCcbcayJHaCswt4W7l6vvtnuWc3axmPnjvS+jWookzSOUa3mTlNJ5ictl23CsWvLLUn0mcPX1oDojCxJ3Qnn7mlQjS9WPxzv+Y3MGynwvdB5sQ6m/tBCkO4M8e9vSBePiWFoOWJ5NXYtOK9W7O53s/rfWwXuhz8BzV2OGCd3oL8ywr5OWs6lOEElNM3om3l3rofEyOENX2jaGBv5efIPXzW6YYAsMQwlSNuEytgdZvx0vCQp9uJBivfA30HgeqalloyRQv6jmZzxQs5RISKoyKXViIig8bt7QvD7MnF7i048fTZbHUZHkTAzg4zagiTRyvmUuEWLRrVK1YNJqbH4lfI+Nh4lWaPDQ84cXGErEhe9UNtaVh5NshZvvTBdS/QQHVD5H7lHfvsECdacbvoGjdYdKKJhj0scrqI+QswDLHIW6tIlB8Vs8jfLYW3oWMfFeKqCgsinJc7YSN6VHxvWa3Zr5auhQ8troL232+FUX5/V4OlNeb7RwSu6DClI8P1cyIsSy45ptG9/JLz9UuEYEqLvqwMBQVgkBCbzP+hNyE2UqHpO/Wj4uE8jwj6DKq7pcuO451hgsSAzOQMQH//Hw9CyqqL6Lv2weMx6DX4vU4pd4+Ic7Gnwi0CwmDnwNWilQc4C/v83twj0AkbLSeM+AjJhoUYRwMLUVy2bJBouy7Zn9tJCjNJ/fl3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3hCNnprNGo2NVkvZUhjZERkdHlsT01LeXN2WEhsSU5STytHRkR2bDQ0MnFm?=
 =?utf-8?B?TE9pcDRHcldQUEtuR1dCT29QYjhvRWpyMVZuWlVTK0JRZUs5UG16dkZZUGQ5?=
 =?utf-8?B?bG9aUTJmWGlRbzVFT3hXMGFvcEJoMjEvWkJiLzl4aTQxZjRCVEs2NmIwL2FV?=
 =?utf-8?B?WCt1d2pPUVV5TWV0ZElKTWlpbU1jZW1yMVE4SnNibzN4OE5JbFNmN1JjQjIw?=
 =?utf-8?B?TU9EMlNOSExSbVZmT0xGeFFHeHN5c25oRU1MRGxlR0dhZjRWa08xYnlpZ2RJ?=
 =?utf-8?B?enlkdUlRaFdWY2NCSTk2NmhsUVNjWExpbExFREw4dXhvN3QzdlFWeEJHb2Z1?=
 =?utf-8?B?azNFY0NTVk5MVmRDcHdYSzUva2Z2L3orNXFtUGd6U3lhNGhBQ0Q0aDcvOEIy?=
 =?utf-8?B?TGNRQVNuUjVpeDA5R05hLzRjVnIzcmx0TThTSUs1U2k4SFhxLzBLS1BaYWVh?=
 =?utf-8?B?Z3M5eGJoVzF3M1gxaDlwYk1sQkU2V05hUmpQaUdyWGJyWkhYc2tyRlAyZ0lv?=
 =?utf-8?B?bHhBODR1cUVxSFNCUUlybjVHMEgxWW8zZXptVlViUGxBTWFRUm9wQSswaEo5?=
 =?utf-8?B?SllkTENkODVEMEVxZitRTnpCTTZRcEZTMnRlcmxkbnFKQmVrRmsrRHhKa01D?=
 =?utf-8?B?RGVDSThtUW9XWlBqbTBXL3pGb1hKK2Y5NTRtY25vN2lCeTdxVStJbk1wMVIr?=
 =?utf-8?B?eHhPMDZpMFdTdU1zeTRuSk54eTYxSmZKeHlUaVZ6WDNJUC9NSjdrYWhVcTJF?=
 =?utf-8?B?L1FBekN4MDBTckRkeUMyczdiWWFhWEpsTGs5c0R5K21WTmdQR0JaM2tqek5z?=
 =?utf-8?B?NlNtbTZaZHVYTzhCek5xV3RDVlMydHljQVRKSGtSNTNtY1JWa2FydzhIS0VK?=
 =?utf-8?B?TUQ5ZFpRUkx4ejRzYzQwVVBweHd6SnBCcWZ5VGpVTmpTSGc4TDAvbkFBclR6?=
 =?utf-8?B?aHh1czA2b05zUHFwQnVQZlU0akpGV21JUWFTSG1lQWhHNy9RS0lzbnY1anJW?=
 =?utf-8?B?SkNSM045TmtobjcrQ2tFYmI1REVZUE8ySlFQSlV0aTRRTHcvYmNKcmdMV1kr?=
 =?utf-8?B?eFhHZjV2YkF3aE02amozaFV5aTVrRE9nRHI5RTRSZGpwVjRxZU5tVklkajB0?=
 =?utf-8?B?VTJUa1loays5ajg2UjA3N3ZLT09NUFFCaDlmR093Vk5Wdy84WDJNMWl0ODA3?=
 =?utf-8?B?a3EyODlEeXBPTmZWbThGT3JGZzlrWTJlNGpYc3U0M054ZmRoWkN2SGw1cXNw?=
 =?utf-8?B?VUJqanpjTU5RQnROWkdjU3R4aVcxZEpxaDJ4YWJPdjhZNnRpYWlKMWdlallN?=
 =?utf-8?B?cVpUTHQ3dmRTTXpzV2ZqbHp2b2REWlp4MWJvcW1QVFVERUw0RG9LeFRLb01R?=
 =?utf-8?B?RC9vM2E5dkNaa3pWakl5bGNUT1Z0OEZWVDJaSCtwd1FnK2Y3dVd2ZUZ0Z0lJ?=
 =?utf-8?B?TDNtOXF4TEMrR3FEck5VNS9aYnYzNi9YNENheER4RUQwdzJHSkF2NmM3bXhK?=
 =?utf-8?B?ZVJTMHlzRTNlMHhZa3JaTkFyckM3eVdHQWdlT3VLT0szMmw5R0Jna3JGNGFt?=
 =?utf-8?B?WjJGazludmpEdk1VUmtQZGNDRDBkUkdSZCsvWEkrVm5HV3NnSjV3ckxQdmM0?=
 =?utf-8?B?RmNHUlVTdEpPZWNLbm90bHJKckkyY0JFby9rNHI0VUY4TmZQZmlXMkp5WGpL?=
 =?utf-8?B?ZkJOSHN4YnVQRlk3dGM4R0dsRlpCOTVRREdWT0JZL2VOWERMWnNFRjhwQysw?=
 =?utf-8?B?R01VbXlKRHBOZHlOOTVUUk9xZGR5VFJxN0lRWmpKOExlMitvYlV0c0VsY2tI?=
 =?utf-8?B?aWJIcURjSXdkQ3JtdlFGSUhIeWRwd3gybVJML3ZkaDlzbzRsKzFSb2doWW5w?=
 =?utf-8?B?T2syQlQyaEFtSjVseGJueE5jNWRXRWRJdW1YRStVUjN2WWg2YVRDUC9WUXZ4?=
 =?utf-8?B?Ujdrc3Nkbk5oZXJyZDNVS1EraGhDby94OEFjWmxQM0tocjRWbEl6REl0M1RM?=
 =?utf-8?B?OXBBQVlkQlUyRnFPeThUN0JCRktXQnBmMHFkVU03a0EwaGExczNTanYyMmV0?=
 =?utf-8?B?NWl5eldscDVhRjhBeXNmaEI0UmZvS3Mzck9nSVBVeDR3N25GQ2t3SEoxSHh2?=
 =?utf-8?B?R0YycU1penlOc205SzBEc1N6QzI5Y3RCU042bGlVcUpIMXkzbmNYd3NCRm9h?=
 =?utf-8?B?TmxiN2JMNTJGRk1JZUl3Zkl1dmtEdkFoT1RHMUdlZ0tMSGhHamxWZS9XU1cw?=
 =?utf-8?B?RDc1cWo2MWxqSVdTZjRKdHlRL3oyWGROSFd6d1psL0t3bE5xRDNQRGtwUEMy?=
 =?utf-8?B?ZU9SNTlDU1RjNUdTZ1ROSzNzZ1lEb3Zhb3NPaTY3ekdCUmNXbzNFMmovZkV3?=
 =?utf-8?Q?+gXl22FWpZaEwd/4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E9664BCC40AE049854B1838ECA060FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r6LKBmoc3Rpt/H3/eYGpAsZvQ3yN/9gyjvGYDmcbGa7MIhyjc3Kwd9V5tWmbIxXJ+Vh+paLNhBFDoXp3MGVblDrJSe8B1NE4eI32GrYG6GxS6MzpyrtR0jjWJQ+lgTnbLcqL8+qwp2V0NXPLsSLIcNO+ELFwgq561WhUJiWLcWB0i2FvVfbZTa00rUQGEI1VdsmnZNceQWzaTlB62whVacV0MOUnaxV2RvqnYPoWffZQ4sDF4z94yzs92M3t17gnVCaLQeBABUeuOIYONxTCzzwpYv4k2p7lYCxq0PsrmOCE+jZib2GLo+U8xtkFt1s8rul5+MjwyFcHPTX8aUMRLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90abf493-f624-4399-b1da-08df0a11585d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:16:12.2891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GyRfKZ8iOX9IlZMIBhQ9rCj0BG9B1tEZokLhIMa259YMIdji532cuJpKUdSJf+MOR4HvR1JOpnmDQoJepxUg5B72AKM8BMUqoO+ykLogd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9677
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDAyOjAzICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbSGlnaF0g
dGR4X2ZpbmRfZHBhbXRfcmVmY291bnQoKSB1c2VzIGFuIHVuY2hlY2tlZCBQRk4gdG8gaW5kZXgg
dGhlIGRwYW10X3JlZmNvdW50cyBhcnJheSwgbGVhZGluZyB0byBvdXQtb2YtYm91bmRzIG1lbW9y
eSBhY2Nlc3MuDQo+IC0tDQo+IA0KPiBjb21taXQgNDEzNDc2YTE3NDdmYWM1M2ZmZGFmODcwMzBj
NDJjYjhiMjViYzY2OA0KPiBBdXRob3I6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJl
QGludGVsLmNvbT4NCj4gDQo+IHg4Ni92aXJ0L3RkeDogSGFuZGxlIG11bHRpcGxlIGNhbGxlcnMg
aW4gdGR4X3BhbXRfZ2V0L3B1dCgpDQo+IA0KPiBUaGlzIHBhdGNoIHJlZmNvdW50cyB0aGUgZHlu
YW1pYyBQQU1UIGFkZGl0aW9ucyBmb3IgMk1CIHJlZ2lvbnMgc28gbXVsdGlwbGUNCj4gY2FsbGVy
cyBjYW4gc2FmZWx5IHNoYXJlIHRoZW0uIEl0IGFsc28gZHJvcHMgdGhlICJfXyIgcHJlZml4IGZy
b20gdGhlDQo+IGhlbHBlcnMgYW5kIGV4cG9ydHMgdGhlbSBmb3IgdXNlIGJ5IEtWTS4NCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYw0KPiA+IGluZGV4IGU4YmRlYWNkOTg5ZDYuLmExMjZlMzk1ZjVmNmEg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gKysrIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gQEAgLTI5Miw3ICsyOTIsNyBAQCBzdGF0
aWMgX19pbml0IHZvaWQgZnJlZV9kcGFtdF9yZWZjb3VudHModm9pZCkNCj4gPiDCoMKgCWRwYW10
X3JlZmNvdW50cyA9IE5VTEw7DQo+ID4gwqAgfQ0KPiA+IMKgIA0KPiA+IC1zdGF0aWMgX19tYXli
ZV91bnVzZWQgYXRvbWljX3QgKnRkeF9maW5kX2RwYW10X3JlZmNvdW50KHVuc2lnbmVkIGxvbmcg
cGZuKQ0KPiA+ICtzdGF0aWMgYXRvbWljX3QgKnRkeF9maW5kX2RwYW10X3JlZmNvdW50KHVuc2ln
bmVkIGxvbmcgcGZuKQ0KPiA+IMKgIHsNCj4gPiDCoMKgCS8qIEZpbmQgd2hpY2ggUE1EIGEgUEZO
IGlzIGluLiAqLw0KPiA+IMKgwqAJdW5zaWduZWQgbG9uZyBpbmRleCA9IHBmbiA+PiAoUE1EX1NI
SUZUIC0gUEFHRV9TSElGVCk7DQo+ID4gDQo+ID4gwqDCoAlyZXR1cm4gJmRwYW10X3JlZmNvdW50
c1tpbmRleF07DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhpcyBpbmRleCBjYWxj
dWxhdGlvbiBuZWVkIGJvdW5kcyBjaGVja2luZz8NCj4gDQo+IElmIG1lbW9yeSBpcyBob3RwbHVn
Z2VkIGFmdGVyIGJvb3QsIGluY3JlYXNpbmcgdGhlIGdsb2JhbCBtYXhfcGZuLCBhbmQgS1ZNDQo+
IGFsbG9jYXRlcyBwcml2YXRlIGd1ZXN0IG1lbW9yeSB0aGF0IGxhbmRzIGluIHRoaXMgaG90cGx1
Z2dlZCByZWdpb24gKGUuZy4sDQo+IHZpYSBndWVzdF9tZW1mZCksIHRoZSByZXR1cm5lZCBQRk4g
Y291bGQgYmUgZ3JlYXRlciB0aGFuIHRoZSBib290LXRpbWUNCj4gbWF4X3BmbiB1c2VkIHRvIHNp
emUgdGhlIGRwYW10X3JlZmNvdW50cyBhcnJheS4gVGhpcyB3b3VsZCBsZWFkIHRvIGFuDQo+IG91
dC1vZi1ib3VuZHMgcG9pbnRlciBiZWluZyByZXR1cm5lZCBoZXJlLg0KDQpURFgncyBzdXBwb3J0
IGZvciBtZW1vcnkgaG90cGx1ZyBpcyBsaW1pdGVkLiBJdCB3aWxsIHJlamVjdCBvbmxpbmluZyBt
ZW1vcnkgdGhhdA0Kd2FzIG5vdCBwcmVzZW50IHdoZW4gc2V0dGluZyB1cCBURFggaW5pdGlhbGx5
IHRvIHByZXZlbnQgaXQgZnJvbSBiZWluZyB1c2VkIGZvcg0KVERYLg0KDQo+IA0KPiBbIC4uLiBd
DQo+IA0KPiA+IEBAIC0yMTUwLDQxICsyMTQ0LDU5IEBAIHN0YXRpYyBpbnQgX190ZHhfcGFtdF9n
ZXQoa3ZtX3Bmbl90IHBmbikNCj4gWyAuLi4gXQ0KPiA+IMKgIG91dF9mcmVlOg0KPiA+ICsJc3Bp
bl91bmxvY2soJmRwYW10X2xvY2spOw0KPiA+IMKgwqAJZnJlZV9wYW10X2FycmF5KHBhbXRfcGFn
ZXMpOw0KPiA+IMKgIA0KPiA+IMKgwqAJcmV0dXJuIHJldDsNCj4gPiDCoCB9DQo+ID4gK0VYUE9S
VF9TWU1CT0xfRk9SX0tWTSh0ZHhfcGFtdF9nZXQpOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0K
PiBJcyBpdCBzYWZlIHRvIGV4cG9ydCB0aGlzIGZ1bmN0aW9uIHdpdGhvdXQgYWRkaW5nIGJvdW5k
cyBjaGVja2luZyB0bw0KPiB0ZHhfZmluZF9kcGFtdF9yZWZjb3VudCgpPw0KPiANCj4gRXhwb3J0
aW5nIHRoaXMgaGVscGVyIGFsbG93cyBleHRlcm5hbCBjYWxsZXJzIGxpa2UgS1ZNIHRvIHBhc3Mg
aW4gYXJiaXRyYXJ5DQo+IG9yIGhvdHBsdWdnZWQgUEZOcy4gSWYgYSBob3RwbHVnZ2VkIFBGTiBp
cyBwYXNzZWQsIHRoZSByZXN1bHRpbmcNCj4gb3V0LW9mLWJvdW5kcyBwb2ludGVyIGZyb20gdGR4
X2ZpbmRfZHBhbXRfcmVmY291bnQoKSB3aWxsIGJlIG1vZGlmaWVkIGJ5DQo+IGF0b21pY19pbmNf
bm90X3plcm8oKSBhbmQgYXRvbWljX3NldCgpIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLCBwb3RlbnRp
YWxseQ0KPiBjYXVzaW5nIG1lbW9yeSBjb3JydXB0aW9uIG9yIGEgaG9zdCBrZXJuZWwgcGFuaWMu
DQoNClRoaXMgaXMgbm90IGEgcmVhbCBmdW5jdGlvbmFsIGlzc3VlIHVubGVzcyBzb21ldGhpbmcg
cGFzc2VzIGFuIGludmFsaWQgcGZuIGluLsKgDQoNCkluIHRoZSBwYXN0IHRoZXJlIHdhcyBhbiBv
cHRpbWl6YXRpb24gdG8gb25seSBwb3B1bGF0ZSB0aGUgcmVmY291bnRzIHdoZXJlIHRoZXJlDQp3
YXMgYWN0dWFsbHkgbWVtb3J5IChpLmUuIGxlYXZlIGdhcHMgaW4gdGhlIGFsbG9jYXRpb24pLiBC
dXQgbm93IHdpdGggdGhlDQpjdXJyZW50IGNvZGUsIHdlIGNvdWxkIG1vcmUgcmVhc29uYWJseSB3
YXJuIGJ5IGp1c3QgY2hlY2tpbmcgbWF4X3Bmbi4NCkFsdGhvdWdoLi4uIEkgZ3Vlc3MgaXQgc3Rp
bGwgd291bGRuJ3Qgd2FybiBhYm91dCBpbnZhbGlkIFBGTnMsIGp1c3QgcmVmY291bnQNCmJvdW5k
cy4NCg0KSSB0aGluayBJJ2xsIGxlYXZlIGl0IGFsb25lIGF0IHRoaXMgcG9pbnQgdW5sZXNzIHNv
bWVib2R5IHNob3V0cy4gSSBkb24ndCBrbm93DQphYm91dCBib3VuZHMgY2hlY2tpbmcsIGVzcGVj
aWFsbHkgZm9yIHRoZSBwdXQgc2lkZSB3aGVyZSB0aGVyZSBpcyBubyByZXR1cm4NCmNvZGUuIEJ1
dCBpdCBjb3VsZCBiZSBjaGVhcCB0aGluZyB0byB3YXJuIGFib3V0Lg0K
