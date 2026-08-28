Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84A3A9D80;
	Fri, 28 Aug 2026 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955840; cv=fail; b=TaD8rUicih39WTb2i718w7hG656agcSUvpArET65HiW98pWTyksYspt1qqdZvu3cLPG0LhMiBxUNFwfEV5AzL2QCVvzHn+gcoTuinOuv7nDBlFdUgThkdhWhsYffYOBgDJKSbgTzMh6OrpiYUU5jJ8bqt0T1IQb97UoI8XC8EGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955840; c=relaxed/simple;
	bh=sjyBShTRbYw/14Nd6IX+q0QouYBbb7WIKwzmwxRshbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UcUuWEtIYduecaQqcs89ATJGZfdAr0OJdva451a+5LXfGXEa/yexxpSISMXUY4WDT4nZLRSa5TfUoEugMKz867zemH7+N2wu4ggaKf37j0Gg31BkZyjnuX9qjs0TkiRCdBIdVqD7mmkdtzIl4L7anotuCWRjqD7DBriO1LC19aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfbfDT8a; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfbfDT8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787955838; x=1819491838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sjyBShTRbYw/14Nd6IX+q0QouYBbb7WIKwzmwxRshbc=;
  b=NfbfDT8acUBPEJTEg3Zj3ZzV2qcGVAqavD80+Qwtw8IuoFDNJ5H4RZ0v
   VM8Eny3YTFdTe5YxeHejNJ+UunClttB98yGr+mIpv4e8JW1Zk8abnVrzW
   l6J8lA3EmK00WvI/FciUB8Uf0TxZtoHBi0r9Q9P/Z3brkqjVc7ZpwLcxr
   vJdRVjlP8GTZR1L8kPLRbrumZTRB8LlX6bJzbQgYIl36UIO1GbPQBBj0+
   wD+lHxeebRZqwajqbRWHoJEXa4I+V42mRsU1l5aJ7myhcf3u2iBRwfPg5
   FPc2KW2+pYiKmf5x8MuEFIVfEtJvP2oFgIvsY9InQBAY0KE/1g7INk3dB
   A==;
X-CSE-ConnectionGUID: wEsDf/JqQh+L6K7ozhGoDg==
X-CSE-MsgGUID: GpKooRnfQumC0sGtVau4pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99978592"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="99978592"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 15:23:57 -0700
X-CSE-ConnectionGUID: rR9Xh3ckRgeOA/Ub0HXKxA==
X-CSE-MsgGUID: pnIneP1FThyJuHIVxIabYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="266963871"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 15:23:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 15:23:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 15:23:56 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 15:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVanMGp7LDrSG/nufEmRTnVlXN3Uz/eNxE4zgNqGLJBlHRlZSsCWsro3Xip/gFOmxajS3qCwYpQGq7H9TuYKUS4feptMWrpQ1LWjDqpLWbbjvtM/RoB8P8e+o8/xndf1detJjb7KKmPJ6HJHVmkU3IDXZcGauAo2zFIxfZPkRI9lzjds9EMgLDBuFqlaCo1hO0mMlg0ykDtAxhkwbm5WsceMmRAueeQUwvnXn0Qf+/LGPwlhDgWoEZ3YmIUlmrmqBUlCf4+WCxr9QLHBa+pJ4oQKuTIe0nYxzY25Swr+FmiFSn9ksJZYg2Zc9XWPH76xQZi5u7Z5xN4AK85EVSqyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjyBShTRbYw/14Nd6IX+q0QouYBbb7WIKwzmwxRshbc=;
 b=TrwKqYg2sQigrE3c7bz1Zd1UIs8EC1Si0Ub4YqkQ5rFRKj6lqASycDYpqKhUUybRoYI7IATk0IYdzjMQ+7ewQZ4Y16U9Fw4uSbfbOiTgNpuMrn8s6aZliDZOBGOH8d63ARXVojzlMlvdgv9ofiQ7BGgRcqWx2yGAfokhahh2J+Ak9iLUtb7bh68pjWKr46gStvHQ1yGJi0J/sePo2OitShmoWQ1b6lgW1gd6qhuOBuHhvBFAKhaq+yAAn4/z+lffh80TTukK5NVCl28rc7I5QCREnoPHjlhmJ+Yr/ehxgRfEQvyyd5MfO2SlLEyo10i2kT6xHJ1994EN+rPibthQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 22:23:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.006; Fri, 28 Aug 2026
 22:23:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hongyu.ning@linux.intel.com"
	<hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Topic: [PATCH v9 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Thread-Index: AQHdJUiUgfNOhpex5U+4sSzG4igyzLa0AnAAgAAqyIA=
Date: Fri, 28 Aug 2026 22:23:48 +0000
Message-ID: <9c0048b72834e7e88cb278476ad8d19f57373aa9.camel@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
	 <20260806020850.1221381-4-rick.p.edgecombe@intel.com>
	 <CAGtprH9ERb_fFG-4JYR1Bjxyyvnk3Ys4q=9ioQz0Cq6QCXtVBw@mail.gmail.com>
In-Reply-To: <CAGtprH9ERb_fFG-4JYR1Bjxyyvnk3Ys4q=9ioQz0Cq6QCXtVBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB8221:EE_
x-ms-office365-filtering-correlation-id: 7858c9a0-a105-44ec-d1f5-08df055307d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: n/zJHDKSedxVHele8PUpkec9rUv6W6oJk0tDoHqqKd6FyFB+8LT8GhO9eZB8O/iJ7KSxUrKl6GK2mZWvmc+Fe1c4juZ5FQWJP9Q/rpHNrAhgHF7bFNctjjioaK3QngPaNSLe0WlqJmphwcw9wN6qOgaLUJ42cbxm1Enphlp/9Mm4QYvr4ehlrHvrMd73O08fdb0TN1Dnq9hmSiY9KwLXea7YG1Q0mA4f1Y1AVNI0lFzsTUuXM+SVVzAp+tDtjC19P0CbsmNqn0SY0pyLWWPeklreUVZ3/1AzL+jcH3iAJ/bdLV0o3xcQF2En5AItHxSjX8BbW/ng+ieMd9+ArtgvHkyl6ehB5zFl7JLaH1XqjTjbngrDldkYQn+ygwrCubZFSUq9fztgozUMP0KuwI7V1al7ouM8qM+mtMGfD3h+VFteC+0zLLWQ8Ea8Q+ipBJQRrysgZmuuLJNbn1ohmmr/fYh6eOsm2KZ2KtgqhYtPLAimqtzPI7MdwX5NIOItQVEYSd0I3DnJLSrSEckyRtVkykLD47iLTCYNiP3/LbUlNa63usLgdDynymJCII1tEOmOeyB7yx+ev7GGc2g4wRiL5CdErjWEb5BDqeirrO7vyc5+t3IuSmbWfaEZ7zXFBYGATIG1RRCV81EYZyYjXwVPSyQ/k343uy4fVNVPBid+VNXZCgWHMAIKJRFTb99faRGfl3xUZALVhPUKBF8HJkjF9Dw0NAoMOu0EXN2XJ9NEBuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RVU1QxZThHci9tQVMza1I0WmJ4dFJQeHRUaFlmM2NCM1d5eDV2aTVPYU1u?=
 =?utf-8?B?WDFBVExZbStMT3lJVllvKzBlYnZLbmNJSXRpaEwrNkI3TmNBL0tMOHU1WllE?=
 =?utf-8?B?TXNNMW12VjlYNXlnRmFzdXFiOUxzQXFmYlhDQ1J5dEREVXBUZWZHTTJZSlkr?=
 =?utf-8?B?NlpUd2xaU2hqSVlMNWNqc3FSYktyUHRZRnJuNEI1V0RJSlM4Ums0V3RBeW51?=
 =?utf-8?B?TVVINk8rbmp0U3o0OFIrUkdkYys2VkNKMmRwTmdYTStyZklweWpJcUFibzlk?=
 =?utf-8?B?OEFUYVNkVVAzbE9MWURIdzI0VDlORDlBajB1YWhBTUJpZWpmOWtLeW5UeXhu?=
 =?utf-8?B?TUhDMS9lK2J6V0NDWktmUGtKM1dVR0hyWjJqNzcxVFU1aHRuRk9HTGxFb0pu?=
 =?utf-8?B?V1YrTldpc0RoSXlLMDFaemgrbS9TTU5DM0dhaDNXa0lkRFYyMHJuUEI0UDVx?=
 =?utf-8?B?VEFEYkZOMkY5U2xPUW9XL1l6Wm1jTDJnSFd1NTh4dVF5Um5jSEk1MHlna1hM?=
 =?utf-8?B?L3Iyd09EUDh4d2lJcS9ZTHZsZEZ1REgwOHROaWtZdnFOTE5MN0NCUVNneXZI?=
 =?utf-8?B?eXdIQUM0a3JZV2ZvTmx2Qk1STHNQTkJHc2o3QzVFZXFqaUJPMWZRWnlqbzhL?=
 =?utf-8?B?OFNKbUt0eG1iTkFnRm5rL0Z6WVV4MzN0c1FGWkwxUTVBMWRYYjdzNS9vdGh1?=
 =?utf-8?B?T2J6dVJjTVVWeVhxSUt1OG9zdHBhYnNOcG1lOFhLT0RrNFRmTFN0TEM4eTNp?=
 =?utf-8?B?ODVyR0hwTHFyZFRtRS85Ui9GK3htc0FRNzljckZyVFdJRzJzVHZDamhnaWtq?=
 =?utf-8?B?QXdWZFhBWXFoZnE5OFlTUkJmbUE3cEpLYW9JaEs3VkhiWi9Hbm1SM01kTDl5?=
 =?utf-8?B?ZkJxVW9Cbms1Z2VDSWE0d3JlMVpZdEI2RVF2Uk1xTUgrNWt4NGlhc2MyUXJm?=
 =?utf-8?B?dE4zWWJ6cHhqbTV5YXd6M3Uyemp1cldNdmNPMDh4NkZOMWpBYnowRGhybXRF?=
 =?utf-8?B?MndUQlJBT1o2YUM3aGpEZ3lHMmZoQ0FDSkYvVGlNbUd1WkZCZFdrNklmYklS?=
 =?utf-8?B?MVZqSE1SU2V0Z3RmZVZpejZxamZuMVZOVlp6ckh5ZWErQ2VGSWZTM3NPcVlm?=
 =?utf-8?B?ZHhyNG9KeUZEd1BTK21adWV2T3hDdWxEQ3Jic1ZFN2NWdE5GUnVzay9XSlBv?=
 =?utf-8?B?RUZIRDdOUHg2dVdoSURvV2hBbGk4VWErOTRIUDlkc0ExZnREYWpxeDFKSzJy?=
 =?utf-8?B?dXJPeVBQS2NCNTJvalJiRE1kdHZwcXo3cHI4R0ttYWlIeStsQmU0WEpqOFdo?=
 =?utf-8?B?TWhKdjhtVFFDSURzR1FpSXk2bkhnc0d5bFhDTm4vZzJIS3BBTGFGZ3RPeFBJ?=
 =?utf-8?B?SzIxdXpONDJxYnNsNUY5NlV1RFRyNXRycjRIbGdVdUhpL1M2Y01LcDRhUjg2?=
 =?utf-8?B?dkQ4b2J5anhYYkZTWkhMam5RZFpXUHFEa2EyeTBUaW9jM0NGalZPaTlRYnRM?=
 =?utf-8?B?bDE4U2R4QjVMNU5vd2txZDRCdzVOYUxZSTBwSGRMVjdHYURuQSszS2VYWlZF?=
 =?utf-8?B?eWpkZkVKODV6ODJPR1JUa2hJV3hBaDA4cGhIaUhDYkJuNHY5OW1UZGhXMzhW?=
 =?utf-8?B?SmgxWmtMWlZjb3ZGU1hSMk1rcWZxSkhWZ0ZzYTBrckR5RGE2ajgwUEkxMGNV?=
 =?utf-8?B?eUc1dENyc0lhcDFxVHlLOTNtTFZIN1A0Q0IyMUZGL3JPWnZsL1dPREtiakVS?=
 =?utf-8?B?WXdiemFvOWVPdmxlQlRQZDliUTV4R0VjSDNRUVRjRGJ2M2Y1elMwanZBT1l3?=
 =?utf-8?B?YUxqbnRJVCtLM2RpUDlXWU5QcjJ6bFlUSUdWcDBXRjJmZnRJeHdUczdDNEFK?=
 =?utf-8?B?WFArNVdkcUcydXdLVlM3V3BGbFRNck42UlIzNXdGMmYxQXR1ZlpUVFJNK3V6?=
 =?utf-8?B?Sko4WWVVZDlCRzZBRVQxYmp5b1NDTnF1bDQ2N1RhMld6b3pvcURTV3hGdDgy?=
 =?utf-8?B?M1ZjOGlCaUc3UUlpcU9kdzZpMTN4dHBid3BRak1yV3pBUDRYSTdITUhhWURr?=
 =?utf-8?B?cEhlYUE2VC9xK0FNWnJZMzNoNjBGb3J2T05lems5WmF5NURQOUpUb05idE9X?=
 =?utf-8?B?U0hLT0x4UEdnU29sYmpHdUhWRUpEbmkyUUo2WFZZTlNwZlhwenB5RFA4S0M0?=
 =?utf-8?B?Qm5EQkpnb1IvRTI5Ymx0VmRPcGxaYWNjU3VBVnB3SGJzMllqaXNTekJWTVJn?=
 =?utf-8?B?RjJTcU5sY29NMFpRM1M2U1RYakpscHQ2ZG1mNkYwUE5Obk9nZWkrUEZRa0dM?=
 =?utf-8?B?cCsxVEsvWVlaMG5hbWxOMmFqS1NESEY2VWMvWmpKZFF5N1dmdXkxRklMSG0w?=
 =?utf-8?Q?FE+VvbjG0k7MEUxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <745B8580AEAB7C42845B80C72F7C2384@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WWXqg9/AcP++Nj7IEURh3Euqltn9DAMxTLQya4Iw6Ee1ebQJQW6FnpN1pXBIX3T3LQqNRaCL+wZHc+lz5ldVB4/l9ZSzE2S6l2B46qxWqkXaUKVSJhKktgKa5WsY6Vjr6Dwnk/YvDvo3E9tkicWRVeDOK9SsRQvMy0VnnHEfRJxwU9voQGV1aewfylOQkZhzGq5hoteiPcjC/VIm2OSYYcfLQ9jIAmE2cvHBIMm5rBAfnO7fZYoB3vl4JtKffNT0NhZWFFWI0kWLCN4yPHu+OOn9dD1xbS61PIdnq7pwV84dvrD92BB8Yt3bUBEqjampV1BbK9f06l56ltAlWeT8eQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7858c9a0-a105-44ec-d1f5-08df055307d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 22:23:48.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVxP1bmeI9XuPkxXjpD423z+xPu/eUer+qWM7ZzzyLFiqJ1gO+SY4XGJQV8f/ztCM0sEKDcBIDpd1zSfoyWLVfVig50jOuYXXbdFrp8axmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDEyOjUwIC0wNzAwLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3Rl
Og0KPiBSZXZpZXdlZC1ieTogVmlzaGFsIEFubmFwdXJ2ZSA8dmFubmFwdXJ2ZUBnb29nbGUuY29t
PiBmb3IgdGhlDQo+IFNFQU1DQUxMcyBhbmQgdGhlIGdldC9wdXQgaGVscGVycywgYXNzdW1pbmcg
eW91ciBhcmUgc3RpbGwgdGhpbmtpbmcgdG8NCj4gc2hpZnQgdGhpbmdzIGEgYml0IGJldHdlZW4g
dGhlIGN1cnJlbnQgYW5kIHRoZSBuZXh0IHBhdGNoLg0KDQpJIGxvb2tlZCBhdCBtb3ZpbmcgdGR4
X2FsbG9jL2ZyZWVfY29udHJvbF9wYWdlKCkgdG8gdGhlIG5leHQgcGF0Y2guIEJ1dCBEYXZlJ3MN
CmNvbW1lbnQgd2FzIG1vcmUgYWxvbmcgdGhlIGxpbmVzIG9mIGp1c3QgY29tbWVudGluZyB0aGUg
bGltaXRhdGlvbnMuIFNvIHJhdGhlcg0KdGhhbiBkaXN0dXJiIHRoZSBhbHJlYWR5IHJldmlld2Vk
IHBhdGNoZXMgYXQgdGhpcyBwb2ludCwgSSdtIGp1c3QgY29tbWVudGVkIHRoZQ0KbGltaXRhdGlv
bnMgY2xlYXJseS4gQW5kIHRoZW4gcmVtb3ZpbmcgdGhlIGNvbW1lbnRzIHdoZW4gdGhlIGxpbWl0
YXRpb25zIGFyZQ0KZml4ZWQuDQoNClNvIHRoZSBvbmx5IG9ubHkgY29kZSBjaGFuZ2UgaGVyZSBp
cyB0ZW1wb3JhcmlseSBwcmVwZW5kaW5nIHRoZSBsaW1pdGVkDQpmdW5jdGlvbnMgd2l0aCBfXy4N
Cg0KRG8geW91IHdhbnQgdG8ga2VlcCB5b3VyIFJCcz8NCg0KUmljaw0K
