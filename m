Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691537B023;
	Mon, 28 Sep 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620519; cv=fail; b=cjaRaJLztS5MKVTpY0dqTJnokr9YMuJUmisOk2ajsRbkOc235h5nw6hlwPDDhIgbnA00M1RojZ0FAzq+2YukmhOmfy3x6+9Y3oqKA22xn3aphTgwFugbOXo5sXQDfTBgJ6XV/u2GIgsJcw/qCrnOgC3+UMsOQPidD5MAgBqMKkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620519; c=relaxed/simple;
	bh=7vPuu150obyeDMflbYnE+yMm8v0n/GDtxYunGCKFdTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stZrZKepb6+3aos2uHQ1XWOBmsRTNO/MchDtfZcPhVtLEYhMah2GxPKp6DDMi3pDTwaMwAUH8qV2NCjMGtOLuMmG1je6FZj0v83qRuZiBhIIzTvBn+bZG2tdGSfz6bstcg+S/YTeI99F4KJtBC0u39B2CSmW1TWynd+Sq4XNGBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1YqwTDm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1YqwTDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790620517; x=1822156517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7vPuu150obyeDMflbYnE+yMm8v0n/GDtxYunGCKFdTU=;
  b=F1YqwTDma5+djYcUJljy6rjJoyicHHrV3oKymYXD4shZ/CP7TvEASl+t
   GvHi7MH7KJD9RbwMGyHjgYHtbf2y7lX11ZcX5FwBGbpqI+htIYqx9TdEp
   EKy4/X3qXOSx3M3+kQId+Pb5gf5dXohFzi7PesL9sVmI4NnCgzawQEt4V
   zSLzoOFCpyw71YydgvxVg/OTF4DGGwR0sV92PevmGsoPzC2TFEXCUIZpj
   mj/aPOmskR4MjrDc5pM5o235K/z19LnIU5+8wjjUSHKA3AU6MS/5mZpkT
   lxz7PVmgZRZsjrhRjXJCo1Lk/PHefjyEuAJW+RG7/Q7Z6129NC85yjU1q
   g==;
X-CSE-ConnectionGUID: OLPI7n1kRY+eY6JDP8ygNw==
X-CSE-MsgGUID: pHgkvDVxRlah6cL9oiioPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="95142250"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="95142250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:35:16 -0700
X-CSE-ConnectionGUID: 28OcGw9bSLCmiXXuD1d5jw==
X-CSE-MsgGUID: 6DQ5N7IEQe6i3JcHr4ImzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274673354"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:35:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:35:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 11:35:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 11:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7xCf67lrdbjT0sNMA833rosndZpmAuCuyv0zgPgDVn0fzbOq0DeZFBsp1znY+r5CXsJjNm9CUIoqgGmSQmHXO3WVIn0OLfWN01ZTiR+bCxosBo4VXWVZOP9SQu7aFHIYTEJtFq4EHIIMo4zpVerT3eHK0S1YN2IqVC2mXQXYwK1tg4Jh9SWPgm0ktTlJQ0C17SIxc0+PJ6SK/fL3I5w/uO2YCH7l6QYueqtL/U7ygYhIUH/3lGFvyOTxfCP4emQ8/n27Cb2BpgVgBnN4gb35/fz4K4T155X7AQzZlJzrM46hXwxC0D5Q80p9WdQ1iYIBSGckBFf9R1slYv07nWdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vPuu150obyeDMflbYnE+yMm8v0n/GDtxYunGCKFdTU=;
 b=w86j8yT0xW3fidxvzmmVoJVEAsy9RWwSQQS2oplda/WA9T5vEzn1ONjeDX+BlV1r76UOmX6dRIe5RJpkzLtm9PrrdGKTnRoQjSYgMSe9/gtVNKmqlqQiPa68WGHV0LgkkulugQneolnwgAEMlWlo/rAdB/jnYCvJHBK+gC5LejuAhbOxqV2ZmuW47ecdIQbh1ICjI+XZh5nSh7O8/eJvLldn8xfYY4Jd/AiRAVszTWoDNg1beJrUGmUPDFeG2coC+xsmyBdi6L1+TV+YZy+gdo1+aKKL2+/6dyXjAXO20TUi8b2ukNzy7qcmLjz+A0iJwRF0w8J4ZNHdB6OdUEPNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ2PR11MB8515.namprd11.prod.outlook.com (2603:10b6:a03:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 18:35:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 18:35:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Topic: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Index: AQHdTzGsoGIHh9qePk+bCG/ii8ItOrbkUcsA
Date: Mon, 28 Sep 2026 18:35:11 +0000
Message-ID: <8c573cf624eab4c76098f1ccc21afc3e9e40849c.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-6-peter.fang@intel.com>
In-Reply-To: <20260928100913.2265687-6-peter.fang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ2PR11MB8515:EE_
x-ms-office365-filtering-correlation-id: 9fadc5b0-e310-4282-6d90-08df1d8f3aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: eMQrnHrpS9R1O+q+yqE9RKwBGiEsMj/0SSu9D2N9sYiwXHPB5mSQ4m/E5uKSBg7iWljp9RgB2gAGNtN6vBgOBcx0CRNLWEsgkoQn0CwBCuc7vrE6zGKc+3MOkzkIl+whkQ5jL8TbFJEYF74cjhkaByocLYDLl1GIEtJMoLEcoIWaNdkXFaNkDUTCrz8vvp8o/6GtU2u4bFKnDOZgP9+wxdZl6y0PmHvnwrQbGmibAHqRItNL7wyCqFFwY0E5ei+eXK3UGla1wK/iG5qcjDZKd7+1DNgiZlaGM4IEoqXLDNQArkokfNL9jggBlv7zC0WG648sK49wvWzJEmleNn2TeWYdoBrEOmkSmCssqCIx4YlN3c3z+dzCOoBG85vajJ88607lMtMPmm5mdYzBuR96syVrf2oWyJL9jLEWLz7K+nGoCXd1UhQsBnWomc5uzV7715P6r2jsWJLAdmEiIJOWKxR9CI9Kggi2b8yYFQtv0TxuMNWKjMJ3ZV8Km/zoqQphzfVNQsB2v75PJySnfVFD/SzUKphTOBLy43JUfrrveT8cCQHhDJ7ZmMkQgbjwCTVSt6p+DnplgezE31q+hO4kIke4kNHjHZxBGTLLLDKl7Pgo/q+b87EjIKWhIjHcsoN6rLWzdQKQThgbhXbM0fUerWAVbrwd5csYiZ1/gJobNGVBCsJfatiq2CfwrHNJpLPIjbXYuMJw7nG/aozCdxVOsDXy0IXq9tMTC3iFcBS1b60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHRycDJzQ1N4MGN3MG40a2hXc3VnZVFPckdFTnNHZDl1NEJTcGsxOFFwVEFy?=
 =?utf-8?B?OFJvdkZRYnk0QlZTVWk1ODJTcmsyRlZWNXRYY1p0MFoxRUp4RWtkU3hEek1k?=
 =?utf-8?B?L2VsNURlUzYvYWVMREZ5b0JodC9jbFVWb1o5OE5aWGVmbGdxUW84NEZLQi9Q?=
 =?utf-8?B?K2VTQmkvcE55NHZzMStjRFRXOWRYcnNyK3Y1UDJ3UExSOC90TnpIV0hnRUVC?=
 =?utf-8?B?YStUaElqN25XYTJCN24vR0RaUmkrR1F5NHgvMFpOQ1JicTc1eksreDh1Wms4?=
 =?utf-8?B?TFBIZTlnQStGWHJIS1hmMFpHZnZIR2w1bXNhTW1iVVIwR2ZGZjBNQmNmMG5U?=
 =?utf-8?B?Q1VGVFhLUHQ0THJmUTkzRW1DRDRuamcyMllDL2tycGV6aXlURTZqTS92LzJ0?=
 =?utf-8?B?ZjlpazBwUFU4OTRKTWJOMW0wMWkrZ2lYWEthMHNWMUdvQk9NUEppdk56dWQ1?=
 =?utf-8?B?SDNMZEovRmV2cEcvNFdJY1ZXV29DK3E0UUNGcEdLa3pqSDlQYmE0RWIwVHdX?=
 =?utf-8?B?Z2pORDNnbFJjMWl0SFBJZC9ycEUzelBDaDdKdDUvTk9zMlNwRWs4T2EwYlY0?=
 =?utf-8?B?bnlJRnlSaEhYcVY5ZVRWTHdrSTFaUU84eW8rQTZTa0JFUWtBMDRvY2M5V0Vi?=
 =?utf-8?B?bjhXUW4yanUrMExTQVZKNUdWbEJXSHBHKzZzczNoKzVNa1l0RkVpM0RPdlUx?=
 =?utf-8?B?UU1RdUNRZDQzTkhpdjN4bkVvcFcxOE42K3l6c1ArYkNZbW5CTExjSUtkaURW?=
 =?utf-8?B?NTU4SzRXQnNLVnhzcUVvVnVub3pjclA3ZlNXOHZHdXl4MzhoUUpSOGRwZDh2?=
 =?utf-8?B?bGxFaFNYUDlKSWtlNWgyVFlwVEtIUk1ML3JCdFowZzBmMm1JM2VVejlZU3k5?=
 =?utf-8?B?SEhhWG8wWW1mYWhBTktWRkJmWGVJY1VCR2hhZUh1bkJSTWNoQnhZWTB0eWkz?=
 =?utf-8?B?cVJJelZwK2dqSlYxQW9NaXowbHFrakVJNWkyNUgwT3EvUXA3bHJITm8yR01B?=
 =?utf-8?B?eWp4emNUamRNZEF2VHI4ZWRER3pMYW5UMjVVaWtUbkMrejE2OVp4aDJQcm14?=
 =?utf-8?B?RWU2MXY4T0p3Wk9GODVCY2JZMVN4VDZFUFg5dFNWTlNiMForUkhyTGVzWXNa?=
 =?utf-8?B?TUtMZERvRmJXak1hZ1ZBYVpLZ3o2TGRIczFLVWY1bnNwYVNWMFV3bTNsOVgz?=
 =?utf-8?B?T28vejU3dlg2bkVVU05NR0F3TTJXbnRHS1crUGdtcDdkTEJVUjVQZnBaeWFV?=
 =?utf-8?B?WHdLTWowTWQvNy80eStxZzFKamV2YUJjMWxwS1dpb1dsMkFKYS94eUlhTUJy?=
 =?utf-8?B?Q0tBOHQxRFlBWlpQKzZDbWg2VUNWTDBweDVncmxVQVAvMElCSlBIUG5GQ3Ns?=
 =?utf-8?B?MDNoQ2FMQUllNUk3Uld1WDVabUVhQkd3UW56YlcrMkRCNFlQVjBPMm4vcGZt?=
 =?utf-8?B?ZzVUYUdWb3FjS2J1OXMyTXZqbENqVnFSeDBRRHFaM0RQbk1rV0s2c3VkQThm?=
 =?utf-8?B?TmV2VjBjQ09PelF1dThOeEYyaHo0bFNsTmEyYTJqZGlrL2tGNmloVDZGZXhW?=
 =?utf-8?B?ZVk2eVpXZHZQU3UvbnE1K0Q1RDNkL2pzZkxkVXNEK3MvZk9zbmh6Nk5wZ2Fm?=
 =?utf-8?B?RWRTQmlET2Fiem5aY1BoUWxTbFBwWlA1VUNBZitWOFlFZ3NrcUw4QkVBTUVN?=
 =?utf-8?B?ZDdOVFpwbi9UMFVnZmxXSVM3a05OR3kySFJ2TjdZbnZ5bE5hMTNSRkN1T01H?=
 =?utf-8?B?UUxiVmkzM05zTTRTS3VwazUvMW45S2tIbDgvYnhRMi9mc2NMQXRFeER2N2Fz?=
 =?utf-8?B?Z2tlUzYxakFLMzlRR1pqMnhmUVo5TVZHVGtlNlZsOGdSM0tGSisyZkVoVHdx?=
 =?utf-8?B?dkwyMndYeklWZTNhNmdwRTk2eS9mcnJLQ0JHdHl3SmMrajc3RXREWmQwWUJk?=
 =?utf-8?B?K0NUQk52YnJwMGsyczNBblIweXV0bVdTZFg4UHZqZWNFZk5KelJkbzFWTlkz?=
 =?utf-8?B?elU2ejR6MkhjZlQrUWZwZDNsTGpBWHozSzYrVHNBRkdka2hSZWphZUppTEc2?=
 =?utf-8?B?ZkZ0WTMwWDdIVWlYS1pBelhoQmZ5MHAwMDIyREhNZjN5cUpjdWE1amh3L0tp?=
 =?utf-8?B?NnJMWEVGb0dqcGgyMUpJNVJiYnR4eDF1d2pkTzVCcyt3bEsvWmlIQm1Pb1lN?=
 =?utf-8?B?d24wM0lXT2VremVxTU9MUzJzK2dyUFhHUERKd3ZQQ3doOEJxR3ZSNlRGMjZO?=
 =?utf-8?B?dWpYaHBqRVZOQW1kNnZxSHVPcmpTRmlOWnpUUjgrYjhNZy9qdTZ1Wm5DWFI3?=
 =?utf-8?B?TlFLUGwxZkt5dEZrWnp6OFdkdUhhNi93Si93ZjU0eERWYm9nZGpFK2MraEpX?=
 =?utf-8?Q?dvDgklGEZpos3N38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F010425FBE0C1247858BA66C21D9BE94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BQZcgNWlIagQI1vphquYa2Kxb6pQqCU6uQTtAtJY4h6upI6XHzh74mRbrG4qahzgqkqeeT5tToysnqDN5XLNJyHM8tuFJrDRht9IXyF0zniiSS/qddw3o08keGZh6O/oHNOnO28VNAMwPXHli6aX40PWHfKOLokg6L22nKc5UG2J4ebTNrAEJTHVn50gTECOZLcmDwse0YjTfEI26OVNgtiFBwDhoJM6Yx3MR+E1P0BiOwYZGk/QlB5GycRTwa8xpZ/lSKE32mtcMX9t8QK4SXLRj0zOLFBzjK7s/BziJzga3fwd2MoSgnEuHY8X/aTkQi1biPs8pvdoHQkUZRb/+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fadc5b0-e310-4282-6d90-08df1d8f3aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 18:35:11.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiwB5uBzVwPEdapq2LG/kxKI7eNX+ue19W0qOKUfCefdQbBzLcEzOPTRZVBUCSq2QzBVzHPV6bvcCsPntLL1U2NSiaybJ1MKD3bQaqjjhao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8515
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDAzOjA4IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBU
RFggYXR0ZXN0YXRpb24gcmVwb3J0ICgiUXVvdGUiKSBzaXplcyBjYW4gZ3JvdyB3aXRoIG5ld2Vy
IGNyeXB0bw0KPiBhbGdvcml0aG1zLCBzbyBndWVzdHMgY2FuIG5vIGxvbmdlciByZWx5IG9uIGEg
Zml4ZWQtc2l6ZSBidWZmZXIgZm9yIHRoZQ0KPiBRdW90ZS4NCj4gDQo+IFRoZSBURFggbW9kdWxl
IGFkZGVkIGEgbmV3IEFCSSB0aGF0IHJlcG9ydHMgdGhlIGxhcmdlc3QgcG9zc2libGUgUXVvdGUN
Cj4gc2l6ZSB2aWEgYSBtZXRhZGF0YSBmaWVsZCBbMV0uIEFkZCBhIGhlbHBlciB0byBxdWVyeSB0
aGUgc2l6ZSBpbnN0ZWFkIG9mDQo+IGV4cG9zaW5nIHRkZ192bV9yZCgpIGRpcmVjdGx5LCBhcyBp
dCBjYW4gcmVhZCBhcmJpdHJhcnkgbWV0YWRhdGEgZmllbGRzLg0KPiANCj4gVGhlIHJlcG9ydGVk
IHNpemUgY292ZXJzIGV2ZXJ5IFF1b3RlIHR5cGUgdGhlIHBsYXRmb3JtIGNhbiBwcm9kdWNlLA0K
PiBpbmNsdWRpbmcgU0dYLWJhc2VkIFF1b3Rlcy4NCj4gDQo+IFRoYW5rcyB0byBYdSBZaWx1biBm
b3Igc3VnZ2VzdGluZyB0aGlzIGluIGFuIG9mZi1saXN0IGRpc2N1c3Npb24uDQoNClN1Z2dlc3Rp
bmcgd2hhdD8NCg0KPiANCj4gQUkgd2FzIHVzZWQgdW5kZXIgc3VwZXJ2aXNpb24gdG8gY29sbGVj
dC9hcHBseSBmZWVkYmFjaywgcmV2aWV3IGNvZGUgYW5kDQo+IHdvcmtzaG9wIGxvZ3MuDQo+IA0K
PiBbMV0gSW50ZWwgVERYIE1vZHVsZSBBQkkgRGVmaW5pdGlvbnMsIEF1Z3VzdCAyMDI2LCBURC1z
Y29wZSBtZXRhZGF0YQ0KPiAgICAgZmllbGQgIlREX1FVT1RFX01BWF9TSVpFIg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiB2
NToNCj4gIC0gRHJvcCB1bnVzZWQgRVhQT1JUX1NZTUJPTF9HUEwoKS4gW0RhdmVdDQo+ICAtIFVz
ZSBhbiBlcnJvciBjb2RlIHRvIHJlcG9ydCBmYWlsdXJlLiBbRGF2ZV0NCj4gIC0gRHJvcCB0aGUg
dTMyIGNhc3QuIFtEYXZlXQ0KPiAgLSBSZXBsYWNlIHRoZSBrZXJuZWwtZG9jIGNvbW1lbnQgd2l0
aCBhIG9uZS1saW5lci4gW0RhdmVdDQo+ICAtIERyb3AgdGhlIFJCIHRhZ3MsIGFzIHRoZSBjb2Rl
IGNoYW5nZWQgc3Vic3RhbnRpYWxseS4NCj4gdjQ6DQo+ICAtIFVwZGF0ZSB0aGUgVERDU19RVU9U
RV9NQVhfU0laRSBlbmNvZGluZyB0byAweDkwMTAwMDAyMDAwMDAwMDcuIFsxXQ0KPiAgLSBQcm92
aWRlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBtZXRhZGF0YSBmaWVsZC4gW1JpY2ssIEtpcnlsXQ0K
PiAgLSBEb2N1bWVudCB0aGF0IHRoZSByZXBvcnRlZCBzaXplIGNvdmVycyBldmVyeSBRdW90ZSB0
eXBlLiBbWGlhb3lhb10NCj4gIC0gRG9jdW1lbnQgdGhhdCBhIG1vZHVsZSB1cGRhdGUgZG9lcyBu
b3QgY2hhbmdlIHRoZSByZXBvcnRlZCBzaXplLg0KPiAgICBbVG9ueV0NCj4gIC0gQWRkIFRvbnkn
cyBSZXZpZXdlZC1ieS4NCj4gdjM6DQo+ICAtIE5vIGNvZGUgY2hhbmdlcy4gQWRkIEJpbmJpbidz
IFJldmlld2VkLWJ5Lg0KPiB2MjoNCj4gIC0gS2VlcCB0aGUgZXhwbGljaXQgKHUzMikgY2FzdCB0
byBkb2N1bWVudCB0aGUgbWV0YWRhdGEgZmllbGQgd2lkdGguDQo+ICAgIFtCaW5iaW5dDQo+ICAt
IE5vdGUgdGhhdCBYdSBZaWx1bidzIHN1Z2dlc3Rpb24gd2FzIG1hZGUgaW4gYW4gb2ZmLWxpc3Qg
ZGlzY3Vzc2lvbi4NCj4gICAgW1NhdGh5YV0NCj4gIC0gRHJvcCB0aGUgQXNzaXN0ZWQtYnkgdGFn
cywgYXMgdGhlIGNvZGUgd2FzIG5vdCB3cml0dGVuIGJ5IEFJLg0KPiAtLS0NCj4gIGFyY2gveDg2
L2NvY28vdGR4L3RkeC5jICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysNCj4gIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaCB8ICAxICsNCj4gIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3RkeC5oICAgICAgICB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyBiL2FyY2gv
eDg2L2NvY28vdGR4L3RkeC5jDQo+IGluZGV4IGJjYWY0MTgwYThkYi4uMzIzZTFlZmM3OGVhIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9j
b2NvL3RkeC90ZHguYw0KPiBAQCAtMTk4LDYgKzE5OCwyMiBAQCB1NjQgdGR4X2hjYWxsX2dldF9x
dW90ZSh2b2lkICpidWYsIHNpemVfdCBzaXplKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwo
dGR4X2hjYWxsX2dldF9xdW90ZSk7DQo+ICANCj4gKy8qDQo+ICsgKiBBc2sgdGhlIFREWCBtb2R1
bGUgd2hhdCB0aGUgbGFyZ2VzdCBwb3NzaWJsZSBRdW90ZSBtaWdodCBiZS4NCg0KSG93IGFib3V0
IGFkZGluZyB0aGUgImxhcmdlc3Qgb24gdGhlIGhvc3QgcGxhdGZvcm0iIGRldGFpbCB0byB0aGlz
IGNvbW1lbnQuDQoNCj4gKyAqLw0KPiAraW50IHRkeF9nZXRfbWF4X3F1b3RlX3NpemUodTY0ICpt
YXhfcXVvdGVfc2l6ZSkNCj4gK3sNCj4gKwl1NjQgZXJyOw0KPiArDQo+ICsJZXJyID0gdGRnX3Zt
X3JkKFREQ1NfUVVPVEVfTUFYX1NJWkUsIG1heF9xdW90ZV9zaXplKTsNCj4gKw0KPiArCS8qIE9s
ZCBtb2R1bGVzIGRvIG5vdCBzdXBwb3J0IHRoaXMuIFRlbGwgdGhlIGNhbGxlci4gKi8NCj4gKwlp
ZiAoZXJyKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgdm9pZCBfX25vcmV0dXJuIHRkeF9wYW5pYyhjb25zdCBjaGFyICptc2cp
DQo+ICB7DQo+ICAJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0gew0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vc2hhcmVkL3RkeC5oDQo+IGluZGV4IGYyMGU5MWQ3YWMzNS4uNmYxMDZkNGIxYTU4IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgNCj4gKysrIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oDQo+IEBAIC01MCw2ICs1MCw3IEBADQo+ICAv
KiBURFggVEQtU2NvcGUgTWV0YWRhdGEuIFRvIGJlIHVzZWQgYnkgVERHLlZNLldSIGFuZCBUREcu
Vk0uUkQgKi8NCj4gICNkZWZpbmUgVERDU19DT05GSUdfRkxBR1MJCTB4MTExMDAwMDMwMDAwMDAx
Ng0KPiAgI2RlZmluZSBURENTX1REX0NUTFMJCQkweDExMTAwMDAzMDAwMDAwMTcNCj4gKyNkZWZp
bmUgVERDU19RVU9URV9NQVhfU0laRQkJMHg5MDEwMDAwMjAwMDAwMDA3DQo+ICAjZGVmaW5lIFRE
Q1NfTk9USUZZX0VOQUJMRVMJCTB4OTEwMDAwMDAwMDAwMDAxMA0KPiAgI2RlZmluZSBURENTX1RP
UE9MT0dZX0VOVU1fQ09ORklHVVJFRAkweDkxMDAwMDAwMDAwMDAwMTkNCj4gIA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90
ZHguaA0KPiBpbmRleCBhM2MzN2Q2MWU2NzYuLjZhNDY1ODI3ZDhmOSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
dGR4LmgNCj4gQEAgLTgzLDYgKzgzLDggQEAgaW50IHRkeF9tY2FsbF9leHRlbmRfcnRtcih1OCBp
bmRleCwgdTggKmRhdGEpOw0KPiAgDQo+ICB1NjQgdGR4X2hjYWxsX2dldF9xdW90ZSh2b2lkICpi
dWYsIHNpemVfdCBzaXplKTsNCj4gIA0KPiAraW50IHRkeF9nZXRfbWF4X3F1b3RlX3NpemUodTY0
ICptYXhfcXVvdGVfc2l6ZSk7DQo+ICsNCj4gIHZvaWQgX19pbml0IHRkeF9kdW1wX2F0dHJpYnV0
ZXModTY0IHRkX2F0dHIpOw0KPiAgdm9pZCBfX2luaXQgdGR4X2R1bXBfdGRfY3Rscyh1NjQgdGRf
Y3Rscyk7DQo+ICANCg0K
