Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D53F9F2F;
	Wed, 23 Sep 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187743; cv=fail; b=MD6lWsT5CPbzonE0gMEjGCq2vRrBAPB/nZNLBUqpSxP+z0uoIHTWqy/605hHPVpjFoVTAOK71Wx4o2fFqjN2aad/LTiyd4554N3q8wZ3OSMDbUQZtMSCY7tUSBOSio2III3HS9cJ/EIfAOOsW7xYOuP60alUL5V6rlAxSjEwQVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187743; c=relaxed/simple;
	bh=uOLlTb4hJxiXl//Su+QAORcqR2kzYTTLYKCiKCKe634=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWh+UBydURyRhZcleZMspikrDUojy3lXdPPmBBQxyLM+A/eIrrJBP05IXVc7CUeK1ltTzEpAejDR1YINEPyXhKz2lFRK5+5qg4fxKWKrwdg+tx2IhbkI+1VWlHzHq2786fTVkBz1NyV1/C2xWKmhzsRW6Z3kZ6wdk1H1e5v2mjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7azYsHz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7azYsHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790187742; x=1821723742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uOLlTb4hJxiXl//Su+QAORcqR2kzYTTLYKCiKCKe634=;
  b=V7azYsHzZjH6VZKvOtVC2Y58pVVTQheLxYc61llWe+T3P+UQcAJmRzfB
   poZl2Mc9b+mUtW8KqUwhZpV7tB0pPzNrCsBnh+qKDGXL4G1G6zCNuhNXl
   a25vVx7fuzQHOydRqWFgd18IkjUbl/9l5XhMteh3dATSbGDkqKbFNVoha
   iosP+tAfvGyzD3SYtC3eLPJ5G3IVpqRhGTQ3PWf/v7p3tl8xG7UdwaszJ
   vsgAdz5Fimsq7BUsxhRPV3xv4SgbnOTOnZMBpYJSDNL0PRGz0Pw6BApnY
   WadZEIsZFB9HqGXlTGnRaVjKr3AmaAhS6soO/ZcNGdJzgivsXmSSm6H19
   g==;
X-CSE-ConnectionGUID: +dz5SxmHSnaNd1l0cFX0wQ==
X-CSE-MsgGUID: zcDoaAl5Sw2siEM1NThQvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90784226"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="90784226"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 11:22:21 -0700
X-CSE-ConnectionGUID: txPyI+EMQR6/A7FeXeYdlw==
X-CSE-MsgGUID: Rntr3sDiTBSPnvVxrfO7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="281808261"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 11:22:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 11:22:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 11:22:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 11:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKkyBiSDyQy6BOIgBgXRcGbIu9NQFjgWxwEzFeOih4ZmZ+47r2wYQr/ziuLDkRzs7l4YoFV00QuPVEpUsMiVbY5jti5iDjPcpWRvWR8lN/y+SThho4L+86dcf//z40T0FoZ0OBtR02o6ssOV37mqezK05EI+5SiC5OQmNy5xebPMSleaqOyOPKErZ5ix2w8DLkz0nS47lEzPXvrbTqyNZ331+BiYsePrTBEe+Pi/sBH4Yf71h36s4scq6zk3GiRxUDjW6XFWd/OOmYKpi+U78RJuKU+e8jSdRWmlrUUL/a9F4bxpwbN+kizkkoKJ7XCzcfiCJQKc/BP/Ax1EwKhjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOLlTb4hJxiXl//Su+QAORcqR2kzYTTLYKCiKCKe634=;
 b=jKI/XJKhA9ChLSFu1bt+QqLI+9D2HxVjRlMCFetd/WIdIQ3L9rvqDYpdEDMD5/3JQ62S8LtnNsHtsTboqcvE25c3cwvm1QFNvQYgKzSm/vRlpb/tvn2CXPG3LOULtmd0/RcdsK0OM2ibEXCzfYYrIVXqP9D1cVppJLXpNCtEEqzP8rIFK8c2tkYTvcMS0/akiwtq1Jju7sefFM47JfG15FppOQ/lw0Zyib0fdsvuqxb2ZPDob950KNFe1QZ9PPoQJw2dt0j3e13vLaf5gk7JSr5k/lF/LARm2A3dFDP7FRMnjWgDXTI+xpOIHXMGU0EgDVEQdHvmjmxneaZtvp/4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 18:22:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:22:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Wu, Binbin" <binbin.wu@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Topic: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Thread-Index: AQHdStRWGuydSOFmwk+y3PD7PUHSErbbpq4AgADUdAA=
Date: Wed, 23 Sep 2026 18:22:08 +0000
Message-ID: <a13938b8a50e43f8302eec5e8a3cffd69f0ecf12.camel@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
	 <20260922205215.870563-3-rick.p.edgecombe@intel.com>
	 <arNmhCROSxo2H/kO@yzhao56-desk.sh.intel.com>
In-Reply-To: <arNmhCROSxo2H/kO@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 547e2924-5793-4fba-f5ec-08df199f9444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10063799003|10067099003|4143699003|56012099006|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: AhfayLTooMc5Kklcn0LAz6AAIpF/QLlRZ/QQt4TBfQc2od3Ze8+AsH6FtHsF3IFvYBKLLILOMBGoq8L0Z5RbXupBaHxbfMZpXgf0q9baL2QW9Vtp/Y9gWMBPy/bNTMu8blpRx+WG5UFa2f8MRfFMoX/1RGWnCL0SL5jy26NJbE3S9V0hs6dbC2usjtxqYk2Nbwhr1x2ihJgjNUeoZXxji2l9b7GwyrHrUoSzJ8+stJb3RqqT/p6tit4oKhw/+F2q3ki1hJ1bDF3GznJm2fI3p6NEOTNQi44z0Cx3YUYm8ODl1faYObEGuSk7h9FgdXfwGf/gdUZ+DdU7SYcsyCc1HKp9cOl+WF1zMS6B9ohBszWaCCITI8Vj96fXA+AXTvVZworqHx3jlRSjbW9b+fG6uODroX4XfL8n/6kSkdWZvqs6NAYfGF6gqUnsfWePwVTsDGFg+q8wEBmVWfXZ8Y5mkpy1aS4KZASuSWnN6hW2adThS0LYK3AXeSA5lFFpl0FnNhpD5rn8AwPAIdONEOIfaWbA57KMD6XHUdiLQbDZGQP7ILxM+V2pHa999RaKLQP7EqhG2EhRwF0QGBoe3LL89I/+0L2+lToRVyRsFSTn1mWynjA527qwoCzttK4Wqmi+Mnj1NyiHJWOapzUwLAqiYXnsPiXLl1t5IZYkO5e7bEnpO1XcKZ2Aw49n8LTk83JwDtvXhcBSfZrUqGnRW5ufQ93DHUkrjVPr4L70418iHSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10063799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RWZW9BaVlzM2lUOW53VmFpcTFuNElhc0NHaFBZWVI1SURNdDZ6MEhqeXZo?=
 =?utf-8?B?bEFlODd6SnVjTzU0TWRta1EyK3ZaQ0I4Y01sUk0rTU1Md0FCS1pJY2poYllh?=
 =?utf-8?B?bmdyZmhCaHRrQVRoYjlWWjUzaDhidFNoUzUxdkFYQSszTCt6dnJsRmtPZ0gv?=
 =?utf-8?B?SUd3eWt0VU51QTMrSHBBalJyTWw2VitoNmhDYzM5ZEk1clZKVlo1dXhYY2Ix?=
 =?utf-8?B?WG5jZVhzdnlGWXpGU3hrMUhiL2ZONlpCeWpjTE4rU3lMV04wQTFmYTg1cDh0?=
 =?utf-8?B?dzRVbHFMREo4eC95Snk1bGN4OGZDTjdaUWU4bTZjK0k0SnhUSjZJZ1Rpb3pZ?=
 =?utf-8?B?alg5dUl6RFdncStMVEd5aWF6bHozbzA1RGlWUlJVY1h0b2N6eGJWL0I4d0Zy?=
 =?utf-8?B?VHNITGg0UU5XM1A1M2R2NVZxd1NZSXBTbHJweHgvUisyUW1jclQwU01KbFFq?=
 =?utf-8?B?N1NxZ0xMOFJUeWVjWWFZUDN0QUlsTVk1bGk5eUZJNERZOHZNRWFxc1JPSzg0?=
 =?utf-8?B?TW1mU09TYm8vZ2QvNlMvaHU5dzBRUkp2cjZYa01zS3ErUm5Ya0VmcGhzRkQx?=
 =?utf-8?B?ak5zS0lxdmNGQ0oxN0NkVFFQcjFOWDlacHBabTR2QzNoQVF0MkRoT0ZPRktL?=
 =?utf-8?B?RDV6WTIzejFLRnlIb0VmTmt3Yk8ydVhyd25mcllCeXcxYmg4SytrZlU3M1Uz?=
 =?utf-8?B?U09rTlNMU3ovaVkvU1hNZ21Ud0kvMmFuNlB1Y25yeDdSMXZDUm9NQ3NySHk3?=
 =?utf-8?B?bk9yU2Vja1dCMUZISXdSVzdaeG5XSXhmLzJUVDFMTGZubFA1U1lCNnBpNG5w?=
 =?utf-8?B?aTFSYVpuN05PTXRBL3lTODZQSDBBZ1F4d0N0VUU3dnQxbDJYV0I0ZktlWDR6?=
 =?utf-8?B?T0M3a1JUV0cvVUlNQWd3RkFyQXdmMlZPUlJnN3RWSnJhdFpSVXd5L01VL0F1?=
 =?utf-8?B?UHJ2bjZXbVRXZkhMVW1HVktNSXB6OVpla3VtOWNmaEtDTFNZOXVQVjNHUTlR?=
 =?utf-8?B?ZitkM3p1NTVIb2NBMS9VTEdqVlhLTjk4bThuNktxSU5RZ1RuRi9wZm1VdXQv?=
 =?utf-8?B?SG1MQk1Ra3ozMUw4allyTnByM1FTbHRHQUZVQ0dRM0xTdHo4bGZ3aHo0emFw?=
 =?utf-8?B?WjB2K3AxQ2R3MWhESVhmWGJFRW5WMEtHYU5qVThwTTMxSEFFWmkrcmQvZW9Z?=
 =?utf-8?B?UEcydGpkMkRHMFdCOXhKL3NaeExnTHlqSkJsNjRpSjlJWHNHbW5GdTIwdEpD?=
 =?utf-8?B?cG56aUhsMmk2QTIxeUlrazNzRWYwdlVhaXV0OUVTS214YUJxd25UWVhnZVo1?=
 =?utf-8?B?UWxuSjluWkJHSng4czZRTE85V2htemRWTHBxM05XTDhQTTd2SHpuMmhrWTJq?=
 =?utf-8?B?ZXhxQVdybWNDMk94c081cXovenFXMWpoMzdBUjJqYWFiUUQ4dDVIczFCbUtS?=
 =?utf-8?B?MDMyenI3S0VMcExoVUlzR2s1bXc3aHk3Y0NqWUJnY1ZtS2NySTZGbW9aVkxS?=
 =?utf-8?B?ZjRLUjd2c3hZRHVMWEI4Z2hXSzJOVDRXS2tjdUhKS0o2Ti8rNnFzK29jRi90?=
 =?utf-8?B?WUF4RkNrODZEanZGZlFCaWxucUZOZTErVlJGRDhIUkl6KzVmS09aYmhtUi83?=
 =?utf-8?B?Rm5SMlNKUm5nQUZrSWN3SFFKR0tlMTR4c2JqQ0o5OFh5VkRHOFkyekpNbTJs?=
 =?utf-8?B?YVh3VDZ6L0hOUTFncnNZQTRyRGlmajE1MVlNbVh1TWpOTGR1WkwvVFh3cEVL?=
 =?utf-8?B?UDBlaG1uWGxjSFhzT29RTk9KekNFa3NPNkx2L2xWZ3dhOUllb2ZoNjlrOE9k?=
 =?utf-8?B?MnNMTmNqYi9ia2swNDBtcWhPWjg4OHhFYUJkU3JzQnNCTWdla1ZHQ0dobnRT?=
 =?utf-8?B?Mm1oMzF4T1VpV1lZSGx0N3FBR2cvRk50Tk82dmZlZytLZ3ZzNlFFeWdaTXpR?=
 =?utf-8?B?RlMrVjRoRnI5WkFBcmVoMStTNmVhWmhYVEVZNHk1dHRmdzFVdlM0THhpSFVU?=
 =?utf-8?B?ZmZjNk9HVHpHclFpZ0dueUNrUTVPbmlsZmYrQnNMU1FBcHZjTDFNbkhPcEZN?=
 =?utf-8?B?bldyOFpUeHJCTm1vOXo5QzVZdUlBMm16UEV1bjJwcFVtVkZVcGFlOUlmK29Y?=
 =?utf-8?B?bjNtZHVRcnF3c3l1OHF5NmhWckR1L0xxNklYS2hyRExYWit1MTJKcUJNNjhS?=
 =?utf-8?B?ZWtZK08xVGc5cWVlTE9CLy8xOVNwbnZyRWUvNUZpcTBPd3l3a2dlSHB4bzVV?=
 =?utf-8?B?SG5aYncrdzNGejkxMEhOZFBuKzMrRmRDdEpWOWdSTGZTK21FZW00bEp6OEVh?=
 =?utf-8?B?WnZwb0RJSVNWYytoM0xFVHZhN3J4T0htWUFuQXNHeWhaWVRITkZvcnpTeTkw?=
 =?utf-8?Q?6FPqmn2ctvw9S95g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C6F5377A5D3940A5DC276A3538B85A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y85C1n5/OlnekdyDxhsKGjKQsyRCFUIUbi95IjRy7HOIYmI/3J60M7XSHAVaOxT/hk/2gZmsSJFozAT2Y7RYMmdHyk4D+8Qofrd6OUh7m9gIwQH17pkoqFDoO7KqyuUk7Q4Pyb5ftRE8cmxqw5OUiWZiizRJVsw/EpdKrf6mV3xzEEsz94DbnW5C52ij2CfyaLVvpBvZeXMtUtUBBWkufcpO6Fae/JZtfXU3LjuEubXpz8QtIka4/FLBejCPFgzQoBZv74aNklOwjFMhjExrgFiZJVLUoPDKhMcuEdb63gEbi1yHaYBtN5U7wTGY1fO+PWUEEEy2UF91Bi2RI7qzcg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547e2924-5793-4fba-f5ec-08df199f9444
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 18:22:08.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2WYAh9eRc81a6+CKRZ7SHQeauFVFNvlDOjYmTGmRh5K7SHpqurVtLDVsQbt02ly0Rr4o2fJWoKPREPdUW05ws/4h+5gdrMPVyB9zz/v2kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDEzOjQxICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VHVlLCBTZXAgMjIsIDIwMjYgYXQgMDE6NTI6MTVQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gSW4gdGhlIGVhcmx5IGRheXMgb2YgVERYIGl0IHdhcyBleHBlY3RlZCB0aGF0IHBh
Z2VzIGJlaW5nIHJlY2xhaW1lZCBmcm9tIA0KPiA+IHRoZSBURFggbW9kdWxlIHdvdWxkIG5lZWQg
YW55IGNhY2hlbGluZSBmcm9tIHRoZWlyIHByaXZhdGUgS2V5SUQgYWxpYXMgDQo+ID4gZmx1c2hl
ZC4gVGhlIFREWCBkb2NzIGRlc2NyaWJlIGRvaW5nIHRoaXMgaW4gYSBjb3VwbGUgY2FzZXMsIGZv
ciBleGFtcGxlIA0KPiA+IHJlY2xhaW1pbmcgdGhlIFREUiBtZW1vcnk6DQo+ID4gwqDCoCBGbHVz
aCBNT0RJRklFRCBjYWNoZSBsaW5lczogdGhpcyBpcyByZXF1aXJlZCB0byBhdm9pZCBjb3JydXB0
aW9uIGR1ZSB0bw0KPiA+IMKgwqAgY2FjaGUgbGluZSBhbGlhc2luZy4gTm90ZSB0aGF0IGFsbCBj
YWNoZSBsaW5lcyBmb3IgYWxsIG90aGVyIFREIHBhZ2VzDQo+ID4gwqDCoCBtdXN0IGhhdmUgYmVl
biBmbHVzaGVkIGJlZm9yZSB0aGUgVERSIHBhZ2Ugd2FzIHJlY2xhaW1lZC4NCj4gSXMgdGhlIHNw
ZWMgcXVvdGUgbmVjZXNzYXJ5Pw0KPiBUaGUgbWVudGlvbiBvZiAiTm90ZSB0aGF0IGFsbCBjYWNo
ZSBsaW5lcyBmb3IgYWxsIG90aGVyIFREIHBhZ2VzIG11c3QgaGF2ZQ0KPiBiZWVuIGZsdXNoZWQg
YmVmb3JlIHRoZSBURFIgcGFnZSB3YXMgcmVjbGFpbWVkIiBzZWVtcyBpcnJlbGV2YW50IHRvIHRo
aXMNCj4gcGF0Y2guDQoNCkhtbSwgSSBtaWdodCBzd2l0Y2ggdG8gdGhlIG90aGVyIHF1b3RlIGZy
b20gdGhlIEFCSSBzcGVjIHRoYXQgY292ZXJzIHByaXZhdGUNCmd1ZXN0IG1lbW9yeSBhbmQgVEQg
Y29udHJvbCBzdHJ1Y3R1cmVzLiBJdCBtb3N0bHkgY292ZXJzIGV2ZXJ5dGhpbmcuDQoNCj4gDQo+
ID4gRm9yIGEgc2ltaWxhciByZWFzb25zIGFzIHdoeSB0aGUgQ0xGTFVTSF9CRUZPUkVfQUxMT0Mg
ZmVhdHVyZXMwIGJpdCB3YXMNCj4gcy9yZWFzb25zL3JlYXNvbg0KDQpZZXAsIHRoYW5rcy4NCg0K
PiANCj4gPiBuZXZlciBhY3R1YWxseSBzZXQgaW4gYW55IFREWCBtb2R1bGUsIHRoaXMgZmx1c2gg
b2YgdGhlIHByaXZhdGUgS2V5SUQNCj4gPiBjYWNoZWxpbmVzIHR1cm5lZCBvdXQgdG8gbm90IGJl
IG5lZWRlZCBieSB0aGUgZmluYWwgVERYIHNvbHV0aW9uLiBIb3dldmVyLA0KPiA+IHRoZSBURFgg
ZG9jcyB3ZXJlIG5ldmVyIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGF0Lg0KPiA+IA0KPiA+IFNpbmNl
IHByaXZhdGUgS2V5SUQgdmlydHVhbCBtYXBwaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yIFREWCB1c2Us
IHRoZSBURFgNCj4gPiBtb2R1bGUgaGFzIHRvIGRvIHRoZSBjbGZsdXNoIGl0c2VsZi4gVGhlIFRE
SC5QSFlNRU0uUEFHRS5XQklOVkQgU0VBTUNBTEwNCj4gPiBsZWFmIHdhcyBjcmVhdGVkIGZvciB0
aGlzIHB1cnBvc2UuDQo+IFNob3VsZCB0aGlzIHBhcmFncmFwaCBhcHBlYXIgYmVmb3JlIHRoZSBs
YXN0IG9uZSAiRm9yIGEgc2ltaWxhci4uLiI/DQoNCkxldCBtZSBlbmhhbmNlIHRoaXMgcGVyIFlp
bHVuJ3MgZG91YnRzLg0K
