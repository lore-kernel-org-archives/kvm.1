Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930C493634;
	Wed,  2 Sep 2026 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354820; cv=fail; b=l9hMA27AKP3e947+PGp5w3a49Xky/taDhhBMKusvVo1aIzrwkWygURbAXYVR7RMj9HJBdOVRV9K+CubcfP4N7JDAH3HNJXgrOu3E+4LitUZ/KjIsdxPTfw9Bxmtwt2qCOzvhwgrC1PzsTpZPiG7cjCNSVWzS2XD/zWi/UPCm0qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354820; c=relaxed/simple;
	bh=9S1HS4CDuoAjZF5q727MY0Ltb89Tbb4hQ0o9xcH+UGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1gLJUB2sd/aFzqhO+TK5uMnLLC5BQyIOMf/zAj+idK585nGkbMqWPgCP4+uOru9YZ4FT9j0Rn0XaG8n477j9w4YciPAFpBMvPhkPHoX3GG1TAFwTG5YKGJAGaPFkk67kn67sfiGheVl5WrtM9h80LjXG+93AeuupG51SmpHZg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpN1if3B; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpN1if3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788354818; x=1819890818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9S1HS4CDuoAjZF5q727MY0Ltb89Tbb4hQ0o9xcH+UGc=;
  b=LpN1if3BsY1p8Kzr8wti+onUuWpG5fKKU3lVq5+Cl04MDjTqfjZzf7rZ
   Er5sQfoN7q1r3ShoNuxLxxi8GXBtX7FHMqlQzDjZ4QdpmgRBUBPCbVbUx
   RXdPGsGqGD4dbP32gFn+mm7dDlxGNohXMC8g5r15lq1Jf7iMiGDvPcbKt
   CRC2Ut+CpmVCbEjMjiEUBZ6EHlOTvwjT8fdJaoLp4dVMtHnIu6yY83pBC
   6+PEQRV/4tXwi28L0ZIx4+/wB50XOWnrG5Wds2Hj5fo0pXJLVbHM9E9Op
   7grioBJqL3CtECwWhXmEWp2iA6DdO6TwjnzM4vA8r79y39Ep2QltaoEy7
   A==;
X-CSE-ConnectionGUID: 5sjC1y98RP+8m0xPcR+tPA==
X-CSE-MsgGUID: 0SBnud6XRiy2eOM4+4mKSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100325852"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100325852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:13:23 -0700
X-CSE-ConnectionGUID: bjp7sVxDRtOuvrMz6DVOFg==
X-CSE-MsgGUID: IfA5XYVhT3an3dLr55k9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="269973816"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:13:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:13:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:13:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzPx5jXWLtT015zqE7pLkmM0rX8YsZikOWX2CUu5V0pJyf8qamzosbybNGgop1G3g7baF4bHJO6eu/tXrdVyYgZhOwdwZM3nsNI0S7p+WcaiksOxyAkMfJ+ifFzlPAJ+yXcyHBDxMVRUbVNCQ9bEVSNTz7bahdZtHajk3uGjQMGoZ8voN2/dH0wspEco1NNgqEMdeRRcLBWrhq03MZJlKLq6h8RvAyjka+n/AM+G1VWoVV7El0hLjg7ruZmlpnVXfvtaPgyxdvZLnQy60L2dkSQRz2ecQW7tPz5su6bbiqGIKXsUliYBOxC5RSVn1VxVmizJ6fqitU9UidKYK+ni2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S1HS4CDuoAjZF5q727MY0Ltb89Tbb4hQ0o9xcH+UGc=;
 b=CagZR9sz8/tMUH00jbpIJa1nHZnI0LVFHRNNzmLrCZ3zoXr4dFKhmE9d64Rq0gKKy050Tz4pJdFYR9lPmmZE/nsHvhRg/Ow2Mr9Vn8I6IeyIU3jtN0zpj6U++S7nR86M4l3msA/SS+p5bwKK+PCyyULcVx/srEHSYc5gLPGg5EJY6xcJnF4j3Ysd9YTdhOrS5VlkO7SrJWMVyhbXUYNfEpzCBuBuKzdgSLEXnrA4xOppcDAmC5+UemYn6POoh/Kk19Fn+AihYALGJmJfrN/kcOCRp0OEA/3T2FBoiZ/xU6smW2a0apiSc6GlGX03PtzpN6L8TZtd1Dj+x5fcDurZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:13:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:13:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLaySiAAgACCPACABrNBAIAAhwqAgAEZoACAAC2ygA==
Date: Wed, 2 Sep 2026 13:13:13 +0000
Message-ID: <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
	 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
	 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
	 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
	 <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
In-Reply-To: <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7478:EE_
x-ms-office365-filtering-correlation-id: 09cf563e-8924-4b6c-d52d-08df08f3f1ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: fvovv+ASe4/Yk4tYslRRolCmsulKQBPXSYqIDFHCdli5w8N0mPX9bbsW790uRanv1qyDw009X1kc3InY4X+CQWYtCNNFpS+zrOzgLqnj8faLKdAdVzLPjzWsETY6OFb+8mU22PTSuLvYhUZNoK7z7g9U3v7azVNjO0yxpEeBOQeyJyxehCT1F9Nwut7E17ZAObvQqrkD5lqhOG6T2hKWCfN5Vi8a46fu3a79oZB89y1mFw4xd2/hnYaC6hv+h5NCiH52gFYqzu1y9b/8GUdM1xVOqU9Lub9styl5t1ic/7PcIUghQWwRlEPuMkJehVHXtc8eZBauG6Nm+f1PTbCi44tYFUaJuXzJhCcV4TumvrSN9+f+9Y+cZgi4thZQgW5d/0ui5uWbUyAC1LHblnE/HjyngjAA4INtIcafhrSC6YyakO6CJVBgvfwC8KQWxxGdRPJ0hwlwY994/pMM6OA/U6hdxTfnN2n6RFVriN4CCaMatrL/R7nOPSNNStXtqN/kpE0FURmnJzQITucURfs4EmkmzEwPsl7/qiZLcuX7gqHvCa9OH0cNoJVFlZ1OiAPENF5DzNDFxjoEEvcl3ncNFcVGmDYGjJ5aC1/+ry2VSkCCMXiLovy/RZWJvzIYykCm6A4WutfgWceLp1dpNcOBdPPF0hSu8yjCDkZDXIPrLDinzoxMw3+5NSJoDhSomIjTXDP1fZkhhGyEek1uxjf6ijYyn6m+RO1OSicMbkZdY2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEdzQXJ3Zy9yakp6L0cwWTQxanZRUFoxbWdvQnpQTlRzcFlZZXV2TmVkVklB?=
 =?utf-8?B?eFJsZ0NWZWQ5N0g4Sm9KMWtDTW9ob3lEY1pybmRxUG1JZVJ1RE55aDVNUUIz?=
 =?utf-8?B?MDRYSzZteUU5TzZPbGtBRjF2Y3dBSGdaUStwVXhGOTIzZzhtTHFMRHU3cWhw?=
 =?utf-8?B?dDlVMlZBMnFKdDd2VUpreXlGVzRQRGNMMnFkTTdlZTJNUVV6cUxyak9rVHpu?=
 =?utf-8?B?WlVtZFBQSEZjZlJnelY3ZG1lVCtYSGI5amlIRnhkUUE2ZVRYbGNmcThOZGUx?=
 =?utf-8?B?V3dqZWhhKzR3T3RxZko3Y004WGtUQS8reEsvS3V5b2ozenpCajVHbDJOWUtO?=
 =?utf-8?B?NnhIWkRsZUJqaDJVVnA3cVA1TzRxanZnR2N5THRmdUJJUHFGT3hzbFZxbEh6?=
 =?utf-8?B?YzJha0dTcVQ2ZFdHNThEMWticlNzUVRaQVNlS2gyVjhKbm5tSFd5bmdmZWIw?=
 =?utf-8?B?YUx5L0Z0VjdJSzI5SjFnR21kKy9nTW9ETmlyZ1IyOEcvSTFxQ0REemJUa2FS?=
 =?utf-8?B?ZnFxWGhPeHROMHVxU2JOam9zcHAxUVJoVEhrNForbURtNU5rZTk2UFNFNTNJ?=
 =?utf-8?B?Q0MvWjBFNjd2d3pCVkhXNE85TlljQTU4TW1IVDFaUURvbnMrRVVGOVRDY2g4?=
 =?utf-8?B?bGVVa2lwMWNHTjFVdlVQamZyV0pQZExFeENWK0QwbzQ1a1o5ek96cnhYKzhy?=
 =?utf-8?B?VGtMSXBnVGo1WE9lMWh3QTRtd1E3NXdndzZGbXpkTGp5OWhPME1zZ0R2UjdS?=
 =?utf-8?B?WE5jcWZTWFVqVXNrU2puSWttMUE4N2orY2lYbUFlL2JiMHRzVE81VE1GbzE3?=
 =?utf-8?B?aVBiZTdRSml0Z2xKQk9BV2FQNzE5S25KMmtnSTBjanBTbHJrL1E1YXdsQ0w2?=
 =?utf-8?B?c09oOWYvU2JHdTh3WEJiTURCczA2Qm82YnYzYmltb3UxbzJ6elR1T29CK2Jj?=
 =?utf-8?B?NDdBZHdtUHo0ZzFEdUJGZnBFVCtXa0QzVEdlZnVObjlYd2dRRmZhSld1UkNP?=
 =?utf-8?B?YlQ3VUE1NDkwbE1vQ0pkOHl2Y0s2bjNRb055MWFlajJSRG1tSGZTK2l2bUJZ?=
 =?utf-8?B?dFVMSlNPZmVhOWJpVVlPS0JKM3gvUk9uSjFzYmZsUWZaeHZ4RlZXVmRlM3pG?=
 =?utf-8?B?TFBPZVZZQW5ZYzJsUjA2bmh2M1F5ZTQzS0ZHdS9KZzg4WHo0TmFIcExkKzl5?=
 =?utf-8?B?c2VQUDRLZDRpVWVoVG5aaTV0RTQ0Z3BHVW9wVlQybUlNalRVeGF4WEpjOEk4?=
 =?utf-8?B?bC9VRDAzTnNIcENiUi9wUzd1cE1oOStLdDBKOUlwbnRRRnpsRHBxY254TG5w?=
 =?utf-8?B?Q0xFaU5Qd3liRkx1TVlZKzUvNmY3SFp5S2pkbU9XSXh2czBJSkxUejdyc052?=
 =?utf-8?B?K2xjTkY0cCtZOWladGozblAyOGpqbnVTYTh5bEwza0xWcGJlNGFHT2p3aUhD?=
 =?utf-8?B?WCtwZXVjeCtZbGg3N2dyMnFRNCt6L3B3Umxqa080WGQ1WS9jd0NrSlh6VzFz?=
 =?utf-8?B?a3RjNklzajNMbCtrbTNRTE5qTERuZEZGRFpaK3MydUQvRWZLNk03VEkzQ3RS?=
 =?utf-8?B?RktWTE8vMkYyd2E0aXk4UmNSaDhiTUwwZ2xsdk9HU0FhY1EyK3dnTFYzbkU4?=
 =?utf-8?B?d2cweHJuK3NXdEVVY3I1SDB6aGxrMXFaQWNlNmlVSml0Y0JKMURvd3FtdUYr?=
 =?utf-8?B?elZJYzM1U1QwbDdLQjhaTThIeHRYa0pOT28wcGRXM2w3UWZDdFZucVo1amdQ?=
 =?utf-8?B?NklWYTlDZjJiVi9kaWtweGdwaUcxeDE2OVd0UW91ZzNaaWNxbkMwZnlORWg5?=
 =?utf-8?B?WnpSdDFLS1VCdEJzMU5HQVZ2Yi9YYlJXWTYxMklYUUtxN3BZMnRxM0lzU3B0?=
 =?utf-8?B?K2NKcStrc1BGWXBZMFB2eFV6ZThMZ1dQdnVqNVIxZGd6eWwvRjdkWmhNUkdn?=
 =?utf-8?B?YzFCSWh0TTRaZ2VxeEFENHFuNXNpTnh0ck9xcGVsVVZSek1tTnAydmVRVlZs?=
 =?utf-8?B?bFN1Ni9XdWdDSWdhaiswL3pubUt3WmEwUUJGajQwMzZ5dlBMc3ZHRldweXhy?=
 =?utf-8?B?R1pibzlnTitoeGh5WEpzandPbWdua0daaUYzR2ZUUjE5M3ZqUEJBOWw5aURj?=
 =?utf-8?B?YktvN1Q2cEFmOGY1eUQ5ZEVoRlhGeTJqcXY5RU5sMURORFNkcHp1SlZMKzJU?=
 =?utf-8?B?TlM4UXByOUR2cUtISDN4SExSWjhIbFhOVzlBdVJSMU9JZWxlYk1PZG1HSUs4?=
 =?utf-8?B?ajhtSlBzeGVEeXA3WUUwNTY1THE4dFdqNFV5UDFtNW5zYm5uWkd5Z3laSW5o?=
 =?utf-8?B?SEllTGVObzV6Z1hLRjhlbEp3QVRyazU4V2VueDcxZndxbWtZZGc2TnptRWxR?=
 =?utf-8?Q?v6KhKvyp5HSBZEpg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC9A7F1D7A30944DA62A327E6A278299@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: To1aTjpUl9ZoMJ2I1fS6qjixsyxN2RvTz0v4BxFKQ8wzy/C8CJcL3g5idBi3tVhnFQT2yqmYTEu5pN2y9z+/gEMBlFlUPK1uENibQaFY28giT3KfGGzloeedHwVMuCDifKkdftfAS5Bi+l2Jp+UkKgd/yTRhNgKzo+3N6JCjUX4d6o3vreqYt/BHn00JQwUXHTHUOy+qeoa3nfsFaUcrofsKBRMH0kyVKlByQFQc1SsEGufZXQnsVuHl0qq49fhIBoPpEgteHDb5YjaU9QeNG3t8TINOdVuazoLHnyGv/zWm8AB6XRNWWrX2FhDyHt5ZWPw67DT6DOHbKaDC103sFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf563e-8924-4b6c-d52d-08df08f3f1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 13:13:13.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhIy9QYt+yYg5sLlmH/aQlRQDn9Orsg6luYHOeruOqy+z1f7xQHWe27sc96G/mYvokk7jjfN9e4ijZpARjBYKnVVeClj1IO+Oy+kVNAamkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE4OjI5ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBT
byB0aGUgcHJvcG9zYWwgaXMgbWFraW5nIFREWCBiZWhhdmUgYXMgaWYgdGhlIHJlbGV2YW50IFZN
Q1Mgc2F2ZS9sb2FkIA0KPiBjb250cm9scyAoaWYgYW55KSBhcmUgc2V0IGFyb3VuZCBUREguVlAu
RU5URVIuDQo+IA0KPiBJbiBmYWN0LCB3aGF0IG1hdHRlcnMgZm9yIGhvc3Qgdm1tIGlzIGp1c3Qg
dGhlIFZNX0VYSVRfTE9BRF9YWFggY29udHJvbC4gDQo+IFNvIHRoZSBwcm9wb3NhbCBiZWNvbWVz
ICJJZiB0aGVyZSBpcyBWTV9FWElUX0xPQURfWFhYIGNvbnRyb2wgZm9yIGEgDQo+IHN0YXRlLCBU
RFggbmVlZHMgdG8gcmVzdG9yZSB0aGUgaG9zdCBzdGF0ZSBhZnRlciBUREguVlAuRU5URVIuIElm
IG5vIA0KPiBzdWNoIGNvbnRvcmwsIFREWCBzZXRzIHRoZSBzdGF0ZSB0byBJTklUIHN0YXRlIGFm
dGVyIFRESC5WUC5FTlRFUiIuDQo+IA0KPiBJdCdzIGEgZmFuY3kgaWRlYS4gQW5kIGl0IHByb3Zp
ZGVzIGEgY2xlYXIgcnVsZSBvZiBob3cgVERYIGhhbmRsZXMgDQo+IHN0YXRlcyBvZiBhIGZlYXR1
cmUgc28gdGhhdCBob3N0IFZNTSBkZXZlbG9wZXJzIGRvbid0IG5lZWQgdG8gcmVhZCB0aGUgDQo+
IFREWCBtb2R1bGUgQVBJIHRvIGZpZ3VyZSBvdXQgd2hhdCdzIHRoZSB2YWx1ZSBvZiBhIHN0YXRl
IGFmdGVyIFRESC5WUC5FTlRFUi4NCj4gDQo+IEl0J3MgaGVscGZ1bCBmb3IgaG9zdCBWTU0gZGV2
ZWxvcGVycywgdGhvdWdoIEknbSBub3Qgc3VyZSBvbiBURFggbW9kdWxlIA0KPiBkZXZlbG9wZXJz
Lg0KDQpJIGRvbid0IHRoaW5rIHRoZXkgaGF2ZSBhZ3JlZWQgdG8gaXQgeWV0IChCaW5iaW4/KSwg
YnV0IEkgdGhpbmsgaXQgbW9zdGx5IHdvcmtzDQp0aGlzIHdheSBhbHJlYWR5LiBXaHkgZG8geW91
IHRoaW5rIGl0IGlzIGEgYnVyZGVuIG9uIFREWCBtb2R1bGUgZGV2ZWxvcGVycz8NCg0KQWxzbywg
SSB0aGluayB0aGlzIGNhbiBiZSB0aGUgZ3VpZGVsaW5lLiBXZSBjb3VsZCBoYXZlIGV4Y2VwdGlv
bnMuDQo=
