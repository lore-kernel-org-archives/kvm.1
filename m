Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B04F797D;
	Tue, 13 Oct 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911743; cv=fail; b=N1HyrRqcZeJAlBXTWMH7GPzyOKtuIzOS0m2UNFQslXuqRL2AtO6nyzxMuR4YUKaL/01LgTDCvaTCTxygMWmbMaE4Fk4zIS+h5Mz8nUNZ1nRxBpVC41da+m6JU0qVPv+qwIs/NE+50iVjGu6hKgPdOcjoQ2JHLYEkng+3kxbiolA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911743; c=relaxed/simple;
	bh=pZFhwO8/YyiS8zQbYlvpjoa1jjfGY9C4P0sMOAlwolk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8TiWP60mRaLZWzKQI1zr24c6OeGnwnFgqCb2MkwBW9lZzYeSW9ZR9xjI15ztdhnfZ2L87s+vG3APsLYRVL9wG87QbPX2a2zMoQSYfVoJUiz5b6G9nDnuwVaX+i2CSVmWGcFKs0G+Au3pFSQAdCQudliC9koR7183ShSIlqbdRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMmYN1q8; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMmYN1q8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791911742; x=1823447742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pZFhwO8/YyiS8zQbYlvpjoa1jjfGY9C4P0sMOAlwolk=;
  b=KMmYN1q8Y5DR25QfObesJhFe+o61p/XRoa4A0mz14iay8XdEteojMvzO
   dwTIYtCNMmZwdYL8kpMSwq1z/0XWhxs9ofBnZRxhD81wbVKXFvtdcC4c3
   lfkFovnmGch39q9XpuIlU72vDFFoSnrCQwI6Ykn+lF3wGwVtf0kH3V7FP
   3fk5NLwSPFHVWG2npwHerfZCgxvsc3OVAaM0yQ5sGRTltKQ+ssiOkKGA0
   FSryI5FFmit8Qinz3wc+YKCIwi40bK0XKPfzLkL0t35tx74oCI3Hdd5jm
   Gf+8yx14KZudB1eoYeuWFjN1m2JBKDkOp6AB4Gf9AjImJg3AJK4qUPL8S
   A==;
X-CSE-ConnectionGUID: mSRNdPbqR+SFqCveWolXsA==
X-CSE-MsgGUID: HxlUU8coS3uAdIRbgdS6VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="654526"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="654526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:15:42 -0700
X-CSE-ConnectionGUID: eMk/HpVYRtyOVhVkOp79Jw==
X-CSE-MsgGUID: Ny/PysuESammeXdC2ebdsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1275647"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:15:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:15:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 10:15:22 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atB93XQ8hX1zRn/NlhjDwWIJEWKvXOOibSLd4Nqacvb061erc+x3BlPnmEEcdphdj2bdQXsluO7zIkcZmahFNesng4a4RlQ5UrxiTxt43w/foeOmV5epJmfEYuaInOHC6hh9ub7wavAlpjTGWB0e7Xl6p8cer0mE/vLk7qFvWLSgBHUp80UJMaY+NefDYzQYPIUkPV0FUs+W1MwhJJHPt3BC0J2AzprsC23ignejksmkYOpWumMQaU+gTSQ3qsQOKMJkphK8U61MYcbo7OE6XrkFy5+h+PMHCH1DlxA8wcsnqape14kt4qQ8MRPbBiFTQKw9QQwI73euQM9oY6+Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZFhwO8/YyiS8zQbYlvpjoa1jjfGY9C4P0sMOAlwolk=;
 b=iqsvVe01pcHGN+hPv8imeWodJabL7s7guhlp7Xj8T+c4hRjucoHxBIBMi+c68bHIT+1ctQz3F97XT5wuHU8wXfqI5MiZfn2TYvokQZSDOmBSYiz+d2asUJ9UcKHYKj64vlf8XtdzjTn8bG8UT62r7IkAXVQMS/ZRf2WHJhnWn6J2xEkVhixUvNgi+ymGP4BjPSRaCKekaI+nH7nAHnqIllMllJ27TBMkB31MenMG1/4APoyTDYjDKpwelt0/W73FuxEj+tHHCM91WJg0JfzDgA/uoYEe/f/C7RfbIvSePIf7rY1qZ6iHSxfTM/vrfRV7IP2jYn8ix6SeAVLyFVHzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 17:15:16 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 17:15:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Topic: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHdVPFz0zR0HzzweEaT4mqBwwRpsbb1nHuAgAWwYwCAAHYSgA==
Date: Tue, 13 Oct 2026 17:15:16 +0000
Message-ID: <c1f2676c3b8797469ab20e26844f262bcb86eded.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
	 <98326b43a055030bfa4671df5c00a78dfc16322a.camel@intel.com>
	 <as4EGEMR2fQqnPMA@yilunxu-OptiPlex-7050>
In-Reply-To: <as4EGEMR2fQqnPMA@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: 1fec0d06-5b4a-4b33-68a6-08df294d8ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: c7bBRIKmamXA+6WPBrTWokZ5Y2MWPa1tnznRoxrgi9cC3tauZf5eg6OYqBoaR7t720r4eRxU5Q9TVgV6s0Dh6UdV019OI9yzVAwP+/EVpwQD/f97tCKvMRGbV9LAT+hqCwCm3YfyteDpWFwG37YqS2y24UPVPOrlTqZ0AK5LeASv/MovOeVuPm/hC0IsKxrLbcCCGVahwmtVAa4LT6Oe9mcL7pZr+uAE4lX8C+KuNgGlK1bwocUXi6Rb3rVrrPHMMEXieeWRvlUvnfd+AylZgU7BQiwFTzIt+Itky4ETPuQKw+H7rHUzh6o2TcRfiUuKhRAOmlndK49d+NxQCTTfppL+NH5Xs8qnKzzczLHGyGa4llWQPeiOeJ5lUYe72x7SQ471b3BSlzkHCX18u8Yx/pBpyf1BSSHRWocbMTSpyCAQ/9K0dq/hyqjrkIgXkZd+jsYCx4sGvo/84OJR5CkMDUDB44g/TZJzvmN9x3wOZJw2qzeUB7LeK+v+7UGddxkARV0RMpQIpQYWO/sMjtG7WI2RPRgbihcffPy5hpOlUADKlm+hvXc21LiH55pZ5PjY/Q38TxQHnCoHV4KPwRgZhJISUjbhC9T4t6mKtElOkwqzwpnXNwzE0/A/fTHO74iEBuD+g5UJQeKqbQGCPXMaLSsQQDQDCAoEmt1YXlTVleq6hzFly0v0FAtkgM3Z4OsOR9KPNJezshB4N08C93ZX3gf9kPOlYvgl7B0C0VPBhKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnpCWFhETTYrM042Y1dRWllWM1MwVUIxVkVUYUZFL25DVjJFYzVHQzBFYnk4?=
 =?utf-8?B?VmdzQjhneExXOHkxTzFBWDdEVVZJNGx1d1l1aWNhWFY5OEl2TldpSEZOaklZ?=
 =?utf-8?B?VDhUbElVa2NQQ0tMN3BHbFFFa2FHT05RMmFXR0IxRVo1cm9iUjdTRGltZU80?=
 =?utf-8?B?b21JZFU1Y0J3ODM4T0xpNDU0bGtFbCtDQzFaaTU3RUhUZE5iWGJJdEZJV2pD?=
 =?utf-8?B?TDFBU0pRSDlqZG9zVDdmYy83R0R2c3JUWXdZeG9FQjdIeWpHMnRhOG9FVG01?=
 =?utf-8?B?bitQY29zaTVNTlkweEt6ZXlVc3BhZHB3QWtsdlppellGcnVFSTBMRGpJdHhM?=
 =?utf-8?B?M1pqNzNQeHJNd0VabndSclRWckJyN2orSmpXWXJlMlFNVDdqUmRBUk1MOVZJ?=
 =?utf-8?B?S3hmK0gwOEVMZnRTVGxSRUtveUNhMkpxYVBadEZMbzUzeXhrU0dLeTVBUFFT?=
 =?utf-8?B?eFBJYlYvbTQwRnNyUmxwZWpPSXFpUWd3anhSNGdBeU5rVUk3cGp2YXlaUU1y?=
 =?utf-8?B?aTJzeU5PS1BRdnN4b0dNTkhrMlZVa3NNSlVVcytsdERDMzZVVHg5eG84Y0RV?=
 =?utf-8?B?V2crWUxYSUF5YlhQblZtSVhrZUlqQlZuaU11ZHU0Vk1pUlUweXFTRHI1SkRQ?=
 =?utf-8?B?ZTlUenUwK2wyUmw4VWRIOHRDSFBNV0hlYzBYVnpnTGJsSjJscHQrZmdFNlYz?=
 =?utf-8?B?SXBwY1cwK1ZCdXZWT1R0eG9WYjFPeGNBTDdHNHNoYkJIT2tsaVNGb3R0b3ZJ?=
 =?utf-8?B?R2ZIS2o4aW1wVHMzbXdhYmQySzFYUllMLy9zVGNrV0ZuT1kzeDVjaDZSNVdS?=
 =?utf-8?B?eloyT3I1V2Z3S0p0ZEN3QzM4OVJpcWdpOFdzMXR0K0oySFhnalRhSkZiT1Fk?=
 =?utf-8?B?MXhYeHdDeGtrenlaS3dyTkZibkFhdElKLzFVNWV1UzIyM1pRZUNiVjFSNlNi?=
 =?utf-8?B?Sy8vOGE2VUhRL3FxR0o1ZmtUTmFLRTR2UmJwYmJHMUJ3RGtwOWlMQ3lRNU1Y?=
 =?utf-8?B?Y1VNcE51dWkvV21kUW8vaHhIMVA5ejNrL1JQcFJkRjZudm1uMUF6N2V4TEEx?=
 =?utf-8?B?ZXlVTUJEb0I5ZVhiMWFVSjVoSDdaZTd2ejlpUkZpK0JCVUkvbFNFdzd1eWJG?=
 =?utf-8?B?a3YzZnlLYllqcEs2NWdjeDlQb0x1dmt3Z01lLzZPRzhkQlRIS1MyUjJLR09X?=
 =?utf-8?B?VVN2aW41TU1FUUFNeVZYbFZGN1pxb2FXTUhUNXdZOHR1QTNYRk1pM1ZJMFIr?=
 =?utf-8?B?OXVsSWgxRDVzOUlFQUs0SHNIeGVsQVAzRjZEemdxbytWK0FmU0RDbGRtWExV?=
 =?utf-8?B?cDlnRW1CYnU0T2FuWFVsY0VnWXpocmUrQW1JaEpuWFlwWWU1dHpoNHZzTEsx?=
 =?utf-8?B?ZzJXUUdRV0g0MVRLMUowcHBaM1YyUmNrU3MzUlJlMTQvYUtpdm1HcGU1Tndt?=
 =?utf-8?B?MExKc0Ywd2l2TGlUb3graEpQRFFseVBuUE9jVU9vSWlCcWV3UGlYTUp3MHBF?=
 =?utf-8?B?RmN3L3NnR05aL0pGYUJwYmlnRDQ3aW9KMzhUV3hidDhRSHA3cVFaV3Q3cHN2?=
 =?utf-8?B?VXBDSzJ2MlJTTDBNUHJybERPcGZZUlRZS0FmbmZ4Uk5vckVIcmE0ODhFbmdW?=
 =?utf-8?B?dnIyeEpPWjQxYWFDL0dJS2NURS9mUVBTWDNyZFM2NDNyc2NBQTVTTXJSV1N6?=
 =?utf-8?B?N1F0M015ZTE4VjRuOTV0TWNGOUNla1lOblNqZ0JrU2lQejhIelpEcnI5b2ZS?=
 =?utf-8?B?ZjdtS0kvcXdKdUwrVlRGSThnTlA4d0JXc21TamJhMktWSkdESWtLc2NJeFNS?=
 =?utf-8?B?c01pdzZ3U0pQSE02UXd0VDg5dWtEY1lUVDRSRTJPZWZkZHZNdFNIbEdONmhL?=
 =?utf-8?B?aktBZ2tzZEN1cFdPZVg5SFk5TWJSYm51cnB1WVVlTmNuUTNzZTl5dmRxSlMx?=
 =?utf-8?B?R1U1VCs1NWF2SHE0b0hzb0gvY3dKaHM2OGNlUENGdjR0R1ZBTXNmN0V0cVFG?=
 =?utf-8?B?NE4yS0dyWHg1RkRNVWJjWVRMRENTTis2bTg0TzJaOGk3UXNDTFlTdXh4TWZG?=
 =?utf-8?B?dUJNUmpqQWFRdW5sdVQvUUl5TEhWdmhkNXB6Zk9uL1dWbzZLM3NFcS95cjJq?=
 =?utf-8?B?bSs1Z1VtSmw1eUNFSWozTmdNVjRmT3pzYnpGRXBQTlJ1OEJrTHpqajd4WXlS?=
 =?utf-8?B?OURHcGRXTmJ0OHNubU5ON21ReEVYRXBNVGRzd1laLzVLRTAyMlRmVnRCci9y?=
 =?utf-8?B?OEdFVW1jNkFYdWlGSnFhN0VtZm1NOGZIZ1ZTM2RNbGZKem85SVNXdlRVdnd6?=
 =?utf-8?B?cVl1RytwRGgxT1N0M0tlUHk5ZmY2eEJPY3pFTEl6dkVWK093UVB6S1RXa0ts?=
 =?utf-8?Q?NyNZAKKJnWLxaRxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EE5B002FEED945B8D5C7CDE9F66785@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vmdByLUxZGSQyGrW0y4R5r+s2mjZ/V8hCYbn+aqOR6acHlbbFgg4Lp+a7cUGMy9puBaQGq4gIq4/lsz5CqibXl7b1uu3JSkjqeITmkM8E/Kxy26c6rIwQj6VcZeG64Z/o3Ni/uIY1i7nJ7nCrt9JAXvdhd5bGMjSBSta6fE9p0BBjjURWSHTJboUO1/RLFKQW3bAzVGynfUV5wcu3RH8avFj9uqvR3b3dbg8tiAvieBNm6JXXJ1nVBnL5dw0XQFaFe/WRBTRp/ezs7E4kMXjfdbTHGjdq+YQOfj4CCS7Yhv/s6Rn5EeLp8fhWOrD5GiRTTK2XccYZBFPAtVuZfjkkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fec0d06-5b4a-4b33-68a6-08df294d8ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 17:15:16.2165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8rBoAPf1riDvRQQndVGWlBW87XbOiITdspgi0a1xEhXPvU4wKHEsTIFCAxG75nf1WUZnQgsj0nFHq5R3+gL2ZTjfwD62S74FFlGf0LB46E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDE4OjEyICswODAwLCBYdSBZaWx1biB3cm90ZToKPiA+IFJl
dmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21lQGludGVsLmNvbT4KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiBBSSBzYWlkIHlvdSBhcmUgZWRnZWNv
bWJlIG5vdCBlZGdlY29tZS4gOikKPiAKPiBJIGZpeGVkIHRoZW0gaW5wbGFjZS4KCkplZXosIGNh
bid0IGRvIGFueXRoaW5nIHdpdGhvdXQgQUkgdGhlc2UgZGF5cyA6KQo=
