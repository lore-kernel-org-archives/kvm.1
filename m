Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA684B04A5;
	Mon, 12 Oct 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823302; cv=fail; b=HTbD9WS9MsPiyR26vH6tJzwjQZzTL5PAuLr4qtXVKFXo0CApqDG8kxYQ8pf12CKV2SeDpGLKKz2ELKnavCi3RL6Fmr9I0ExN48ix29YnMJHyepRz/8wJHvOaiE4rSyKCqhziQyx22E+po4rLpkaxqqZFEzXWOT/fkGFfpIhY4yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823302; c=relaxed/simple;
	bh=QnISnYje3DbtXT8H3v3FK8THG5gxupJvss9M3KQ97hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTNS/hoYdg6qANd8PMlTa70KgyK1tWzfQd6evnXOVVFkWzeUZiS785Qy9y16eCm5RSXOfVGx2e9Og35BrOVYhmKJfgmANiKgk52qou3vKr3mNEvkFbhlDXJ65HhuTyu337gEScamuXklVkSM42nxmDUo1fvTkHpDaL0et03NSVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0VWnqyJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0VWnqyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791823300; x=1823359300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QnISnYje3DbtXT8H3v3FK8THG5gxupJvss9M3KQ97hs=;
  b=K0VWnqyJp7QzY8QRvgj+e3Jf6UTXiLKaiM/JiRvRPN7fPszTgVEoKpfJ
   F+Yw9MwFPZhRalWR5+iR03DZ0QOc0tOJOWDimWxaN1Yw/ohr73Hj5MSS+
   yNdv4XVbGzghQrzSujAyqR2gehbJTT+7//f1SoixHylT3w7JFa3A4ZDB1
   c/bDuYn+H8hFYERRNl+S0HP3hkm6d6DiX3i/FY3Hu7VwsnFOvkJu40rY3
   c19h0yJ/TfxEj1GlPR0lxnudy3lttipLxvIOz+qwzma9WjdIZCkXSNjmP
   ClErqBcC1GC5rWSBqpAmM1JpJi/nOO9/IYwemkAGy8odWehYG06FPOlTd
   A==;
X-CSE-ConnectionGUID: ieJtFov3QzyJDCWfTdI4PA==
X-CSE-MsgGUID: 4DZlfuVOQyiAw0gbkb8ugA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="550811"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="550811"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:41:38 -0700
X-CSE-ConnectionGUID: idTHqMliSC6Z4QsCqK+GNw==
X-CSE-MsgGUID: 9mNS2zOoQheaLQYUJ727aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="896866"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 09:41:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:41:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 09:41:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 09:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hwrd84rlBKU5EXUEqhYVReMY6/PCneacFLvKKBTdDy6HVk0wCWU/trN7fSnIxpl7VRLt8G788Zo2zIgrkCzkV5DM2OsUa/rK8Ea6hJIWl4BfwS67hReuLYBe0aUbjouz2qp8SCNz24I694r8iIvDou1xYeZ3+ptTmnPBIGK7W/bkXGkJGV7LZ2mgWKFVTo0yhtrUCZcoSmEHQUq45cEEKQL9Q8RAldbHXuoq6Qvp8MjwGiLYy4sXEd+a7yWDz23IjGvgVB7dBmYwzOknT2/5pAixFa21YJab1poWkgc7fYeKxWxFL9/TN6c99BQ21UCwZ/KsRlNoZz2L1n124A9q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnISnYje3DbtXT8H3v3FK8THG5gxupJvss9M3KQ97hs=;
 b=LojNOcDlzAhbuY1Rn4gAYwRJnfmVkAu55tWuUr6c7hcVCZdAKNtliINrD9naDg7iRyc+K+gMKNxcds2OKQTWfm3YqTuMtyW7dGdtKnCLsadDfClT6D1am1rIf3LVo6QX2jfHXtNmSj9wR2yNM8VLVm0EwqEutPWUG2+FdwZruQWOKvotyg6Xs8uy8T0lGfFBamFthmFhVCaxc33AUPG5yzwMatXtNefKg3ajs72se6Rp5T0hYN1twviw8obiiXq+i4guZcn3OJvy31NZdxFkSStGtLQD3nPDewCLSLMrwp4LWXEyjQ8W5vyi+JjdIQ0I2tRsHvrN9B+DkN2aSRDItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:40:53 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:40:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Thread-Topic: [PATCH v4 07/17] KVM: TDX: Add core support for
 splitting/demoting 2MB S-EPT mappings to 4KB
Thread-Index: AQHdTylM/3bB3XCq10Ki8poMtj4b7rbyrdsAgAO2roCAA84FAA==
Date: Mon, 12 Oct 2026 16:40:47 +0000
Message-ID: <12a1d64dc2f0c05a9130e291e0733f7d7991ad95.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091021.15583-1-yan.y.zhao@intel.com>
	 <90ecae2e769c85d5c32a2d31f004dd007f4f6774.camel@intel.com>
	 <asncgdZbLRuPAEhu@yzhao56-desk.sh.intel.com>
In-Reply-To: <asncgdZbLRuPAEhu@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: 3c314600-be5d-4b8a-c602-08df287f91a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|38070700021|56012099006|260925021911599003|260925021311599003|260925022911599003;
x-microsoft-antispam-message-info: EIl7s7JE4dI5gVe3Yv8idKiXABwz1a+GeHxr98FciDrBhZQOpCBlloULQerDNOn4hGztE2oKdHPor587Rpy1YjoiGBydhIHkgwTNXvX1i12kgLxhHTcJQti95AuhvPFSC3deWrN3LtWXNvhLHhq7N0Hm1Qo2ryIafjdCKTU1+OK8IDo2Y1lmOMNYOw0x+9ctxsnn4gE/l046v3Edh0U/Ug9gotmLfJ02sE/ohJB13SiShB2yw9bz3leMfyq2jXClBWSZwY2/QDhhRSx9xD2Gi5spVAM6+b9Mn4JW+w4kAcO5vD7y+s99vfyocX6IXtJBTmz3/ba0RxJf39m1G3AbnDHr5m3FCeF8SGAF1bdgDvpdLuPgOQBcPD35aGHPIayMy+kQxxyM2r4v5HlkWiEO6RPYAGl2W6F/6CF36mkVwuxxCrRT5Fe5T1+DylvdgAHpEc5DwL4e6cgPy1MnzCWdIA690c8u7sOVEmXNzSKM0p/xZFIKh5MYZYxcxC3lE8gtNsPTxPsG9URCw6AdSQEp7d1V3okoNDNYA+WQklbd/8OKa6S6y6W0COKdYtE/OoQnxuEjq6cI/i4XICqVzk+FTUG/BrZvk0OVULLOSoNqtq1tb+cF5DB+zBrwYVwXovJJNomg/rpUQ++KXXxLXpfjcHFY7wm0j16XBNX1st/Fcwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHF5dXFsN0xJaTJ0WFFJcnRjQVZ1cHpDNU1NRU9GK3lrZDYyWXF2OGV2Sktw?=
 =?utf-8?B?M1cvam12ZjNMZUVMUVdBUldWK0d5U1A0ZFRCNVVqVDJ6KzFxSGRnMHgxNHRF?=
 =?utf-8?B?VG9xcC9qR1gwYnVjZms0TWc1b0hvMlE0dmJnQlhobmFSUW5uSWh6OFQ0VGpQ?=
 =?utf-8?B?c1I0ck9TL0RaYjZaOG9RakE3Y1JQaHNlR29GcXkwL3Y3ejhNNjRpMXQ1NGR2?=
 =?utf-8?B?SG1uWlh0SThTelRJaUJrU3pIdHI3VFFMVm1vSmY3MzdwOW1GYVFEbDkydllG?=
 =?utf-8?B?RTVOc21xak4zMlVxbDh1MEVKekcxQnZueWdsa0xuUHA4dmZlV2xKSXZWYmVV?=
 =?utf-8?B?WWQ5YjNpODJVWXdaMzNvbmwyMExkN282MDhCVnlaZTFzMGdiZTFkSnZNNHNR?=
 =?utf-8?B?VlExQWpzakwxM2FiVGZpRVBIZHdBbWJBUmk4RU84MnF5V2M0S0hOWDNiWjFa?=
 =?utf-8?B?TkZQeFNTTHFuMWkzZDJ2UHQ5K0tRSW9lTFRGNnRSV3R2eHY4S3dOcmcrUGZl?=
 =?utf-8?B?Vkd5OUYvdUJzaW9XQk9jcW1aWTFPdnlxMFA3N2t5c1dxeVFpNmpoSGFxbXJw?=
 =?utf-8?B?eVM2NmFDZmdFYkxNa0pydmZnZ3VSTnVGSy90dVlLZGxsdWQ1V3J6cGZKeVZr?=
 =?utf-8?B?N24vR2xhdHY3bzJKOTBWTzRtUjVWK0g5cW9XeS9pWjlUU1ZLZE9FVU95TWpa?=
 =?utf-8?B?YkxZVmQvQk1WSlpXdHFQdVltVjZYZFV5K1Y2aGJyVU0vOStDbXB6RG9pZHpF?=
 =?utf-8?B?RGhGY2Nlb3NVY1R5N1ppaUxyNWR6ZTFkTzRVMHcwWEhieHJTcU1kaDdFSjZ2?=
 =?utf-8?B?aW81YlRvOXlpRGxxTWx0MjRVSEo5eEszSC9Da2RaNTFuT0F4dVNlOFN1K2Y5?=
 =?utf-8?B?SmxuUGN1TFJ0SmwvaGN2ZG8vRHdyc3MvK095MmJGVmExa2VJUlJFeENwYzdZ?=
 =?utf-8?B?Z1MwMHJZTkZtMnhWQ2FYdWMvME5lRHM2WFNoUFE0OHBkNXVleERlcGo1NW1X?=
 =?utf-8?B?dlArRFpManZZbk9EWllpSjBuRDhwZHNmaFo0SXBQdzlYdVhkYWhYcDVqZjkv?=
 =?utf-8?B?S0ZvTU1oY3JiSmVMR0xKTjhsYk5EYjZ5dldjbEVyckdlVmUzN3ZUUitlMzhv?=
 =?utf-8?B?bXJDTk0wajBRRFBGODV5WjZtNDRFODBtdVRFaUFqT2hJQTk0clpvaVF0WnFF?=
 =?utf-8?B?cjFObW50Ti9YTVptVGVvMzFZVmQ0SE5BbHhmNVZvTWtlZFlPMEJoNktDeWVt?=
 =?utf-8?B?cENUMnJKdG5LTjhrYmk4c2l0T2NrRDhqTGFmSTBUNjltQmFJVlMvcGlYYnpB?=
 =?utf-8?B?UkRQNDB5bzBxVmFFTVI4aFNvcVJZNFp0cnNDNVdHeHhocmdpYmNEaXlDd05s?=
 =?utf-8?B?UXhzbnFQTlJoVVZsRGlPMlBuNldvak1RNUc4ckNTQ1dkdGl3RTBwQ0hrWjh1?=
 =?utf-8?B?MDJZR2o4bTJmbHdLQkhwY0s2UzBHMjk2RmVYQ216dTdpbEh2WWo2aUx5M2E1?=
 =?utf-8?B?bUdQUGRtdHR4Rmg0QUxZTUgyRG1tUnJ3K0xob2UyNmNyUkVOR3JicDdESmsv?=
 =?utf-8?B?eHN3QW1xZG9kWGUwbkZIR3J6QTVpbUgvM2dJdGRYQi91eFBXWEp5UjFnQXNS?=
 =?utf-8?B?RVN3czBia3pkU09zME83c1djV3ZVNitVaHZ1TU9HcHd2bGcwRkJuSmE0Mnda?=
 =?utf-8?B?NVNpU0VuVkorTW9oeUR6d3lGbjZLMHVVZnV2elZnYnY1ZHY3NmszMitiZ0Rv?=
 =?utf-8?B?aXBpVUVrSDBKbmF4NXJwUDczSFVER0pLSkNTc1UxdTJZanBpVFhZRlpPbEZD?=
 =?utf-8?B?QUEwTUNTY29wOFkya2JlbmtoRTA2citMaWZyYlU4amVGWU5nWmZHY2tJSkow?=
 =?utf-8?B?cHdQV2lBd1RhTTZSVTJjWWpkZHV5VTdycTJVWlpSRTViRkxoV2orMzVHczlW?=
 =?utf-8?B?aitmVWhtV0FiTlR0T2lkcW1ncXZuUTRYcHJGcGIyKzk2Y29ENm5YUkFaYU45?=
 =?utf-8?B?QzZUdjh4OXlxSlJZYXNtSkNpWkdwTGtrN1F4Q0lWTWsvRE1aZG9JQTlLVHpk?=
 =?utf-8?B?VkhXQktPSVBEQ0pVWmRIUXJMWHVOM3JkeERkQzFWV1YyV0dzczhkNjlPeVha?=
 =?utf-8?B?bmcyWm1FTXhTRndGYXJXVzRTTDltcVYvUzkwRzlOMGswREpueFZZL3ViL0FK?=
 =?utf-8?B?SHp2Q1h3d2g1M0I1V2tGallwZEpDN2drYVpCWjJ4djQ5NnNhemtWblp2Tm0z?=
 =?utf-8?B?bzRoaWxua3l1ZlNaUlpEZi9GRzQxcHEwZHBaUDJwQ05RYWsrUUlteGRNaC91?=
 =?utf-8?B?d2krS0lKTVJrc1BHVy9tQmQyVmpUTzNPWXF2Mng4di9HZ1B1cjdlb1RVQlhn?=
 =?utf-8?Q?zopDMrW2NjU07zOE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D5651B5B048A409246A10D796233DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ohAgjOhrTIYh3QeHRWpU/kTnWNJHWnSV9lCbSn5pnxeRFtSOEm+VGQX1IuTs2qgeQr2YFr8tbCMHMG1n9ZwJ8oQL63kOdUkPn8Rl6W4JReh53lYKyb1SBh16ss+I6f2YQPUvws/hFgZgmnSBI/MMuVmTZt56TXk80HJt0NPJequR02E94xVP78GzoL7AXGBSSITQH2YNYJwHRj0WEATWS6c/aIru6LBUJE/soAFIkgRPyHJfEij8XdylkOkvCJqtvGcTjMMTgTueT1Z0NDiaw6/Trrgf5czxFixc48ii3wMXhLTCYauMMfQs7l1I5fdziX60hnD8P41/8zJBhtnSbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c314600-be5d-4b8a-c602-08df287f91a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 16:40:47.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xA2adZAoc7H0Kz9LbPtTmwgT66MC3WmdsQDrAy8BWFJ/0auBOqwHcCKDvolQrBnEvWqDunXHal2a0tUSgmQTj2dE9DNuGDKahuJr1oBrJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDE0OjM0ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiBU
aGUgU09CIHNlZW1zIHdyb25nLiBZb3UgYXJlIHRoZSB0aGUgbGlzdGVkIGF1dGhvciwgYnV0IHRo
ZXNlIGRvbid0IGhhdmUgYQ0KPiA+IENvLQ0KPiA+IGRldmVsb3BlZC1ieSB0YWcuDQo+IFRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIGhhcyBiZWVuIHN1YnN0YW50aWFsbHkgcmV3b3JrZWQgZnJv
bSB0aGUgb3JpZ2luYWwNCj4gb25lDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9iMzg3
ZGNmYzQ5OWQyZjE3ZTQ0OGNkNDU3NDExNWQxZmQyNDM3OTIxLjE3MDg5MzM2MjQuZ2l0LmlzYWt1
LnlhbWFoYXRhQGludGVsLmNvbS8NCj4gDQo+IFNob3VsZCBJIHVzZSBPcmlnaW5hbGx5LWJ5IHRh
Zz8NCg0KRm9yIHRoZSB0YWdzIEkgZG9uJ3QgaGF2ZSBhIHByb2JsZW0gd2l0aCB0aGUgYXV0aG9y
IGNoYW5nZS4gQnV0IHRoZSB0YWdzIG5lZWQgdG8NCnBhc3MgY2hlY2twYXRjaCwgdGlwIG1haW50
YWluZXIgZG9jcywgZXRjLiBXaGljaCBJIGV4cGVjdCB0aGlzIGRvZXNuJ3QuIEkgd291bGQNCmhh
dmUganVzdCBtb3ZlZCB0aGUgb3RoZXIgY29udHJpYnV0b3JzIHRvIGNvLWRldmVsb3BlZC1ieS4N
Cg0KQ29tbWVudHMgbG9va2VkIGZpbmUgdG8gbWUuDQo=
