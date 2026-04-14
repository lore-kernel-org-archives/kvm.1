Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EF28B4FA;
	Tue, 14 Apr 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205229; cv=fail; b=STSPSjsTzeBKGc6GGTRgHGRzGEj6bbJbEhzlI6AdYeX4wCopaBzn0GXNclPLolAFEBH/dBX8O9VIMjPMQ0DzRbIBbnfU2rMRgb0Ecd/FVzgxI1uTgO0Jkrt2FBJDaBNuvIwYT2pPpEsQ6U8VZy68g5weIIVusQElvSlsHEsHJRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205229; c=relaxed/simple;
	bh=QB48SEDMNcMlBQpDWfS1ycPwEDxshfX+SeuuUAF/nmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YddJCW95xZlXmQH5wGyCgKz/91p47/XaoVis3FKQ4MjdrhRocp2Thup5xdSOON0NvPw+kgj403d1XwAVlzX7YAFB2Tj1UUdXkcyoW3BLygSc6rZ1BO30Xinw8pF/+sfIH6cI0YHECgnAARu3ysJcodEUJSDB/YuVOEexvvLbQ94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIaY6kAe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIaY6kAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776205227; x=1807741227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QB48SEDMNcMlBQpDWfS1ycPwEDxshfX+SeuuUAF/nmk=;
  b=gIaY6kAetUKW2oSQxVzOvgxrqikce82BAivxQg9ESAuew5pF02GxDwXM
   3vWlXsDsW4Jh/AAqM9KHkTYEvHfb/zNL1g8jyAZm1A4xRJG7RdUxOJJo0
   d7EZHNowJP1vfCg+oiXDGcZbD5Jb6sAaiePEPILSJAS85Y8e76b/d7RET
   UmSQw7/cKkEsKvNEqFo67tU9rRLLtjBoNi9/YKkLGVH2AyJidzBwXauDA
   k04I5xu2/GteDc/5zhmuweBDGbLPXOpRYoW4QahbHIjHOV0nbCFxYXDZ+
   qe5Nfhm3jXBqX8MpHhkutVJFWz1q7TC8NLUPjT+7rNYUW3zcNtrGe5Fx4
   Q==;
X-CSE-ConnectionGUID: 3RpxZi+hTjCyTmyN/Ym0Zw==
X-CSE-MsgGUID: 2U5FLXsDT9qx6kd90F/Qvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76341376"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76341376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:20:26 -0700
X-CSE-ConnectionGUID: 2JXiGzxDQMSyQxaZUjEshQ==
X-CSE-MsgGUID: iklNIa1cT5i+ZwPoAuYgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225524374"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:20:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:20:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 15:20:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lctL7bWcUmoergVPxB4ivwFWHl6V1JnRhcfamoQfJ/TLxg8TzhgDlYRZ6txWZmReidYlo0gRoq95xCSFC5EtMUBsLDTZdDiCmm/8TfRr9eXWUXwMrn+t9qbBVKjNY2cqvoBIz8gvAhZU0zRU/xkrDpNlsb28ymAeYE0m31XDaFZ03lxQHrBWY4O4yAQiHIaeBe9FF69/Fdw/DEIsVkcJaURjQeHuRRkMUXSvVF6R2b+3sIow/4F6W7LLD3vTDyW/O1ZWgIoiu9kcgjVBzaYOaBALx6fKxaHd05oC5EjiFXHecIga1BLC6Xi88OailL09XQ9SwfdVM2NX+VgSdgQgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB48SEDMNcMlBQpDWfS1ycPwEDxshfX+SeuuUAF/nmk=;
 b=BjJOPaX6DVyamDw+Zw5TUAmqY46vxgHnvVEErn0vjIuuIX31ieqjzlemv3RCxagZWqJ+yW9rW2T3NKIWMCYTFeKjCkoWNPpbvLmQ4y4Vu2tNCflDAy5IIMjkSdtY365tV/V39RqwebxSnuK63KOzm+VSTDHLi/1t1ELwqHTF8rSfVixo+Lo8pFDIrJQaPPNDwLV6WDVGI+PBEIC5zaFOvKszy9jmCXU7EL9fOIZzQV1jKfeuu2vm6XZt+ojg9tIr1goHM8L2ugfDDJC5yGxg1TvP/0TAEgCzySHuOWYcKLayL5f0lFdV6kB+Obbg61wpnfTKxaT4fIxBvYsj/cHvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 22:20:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 22:20:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "djbw@kernel.org" <djbw@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Topic: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Thread-Index: AQHcwQwKfzyh37Ly8UCrIvEL2Q9aZLXfECgAgAAdOICAAApIgA==
Date: Tue, 14 Apr 2026 22:20:20 +0000
Message-ID: <c44a4aebca86584ec33a19fbd9ca464443e66718.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-18-chao.gao@intel.com>
	 <af7732a08fcce4a21ff14b2038acbb85200c6f34.camel@intel.com>
	 <69deb5032ff01_147c801004c@djbw-dev.notmuch>
In-Reply-To: <69deb5032ff01_147c801004c@djbw-dev.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: 6f864604-0a56-4b34-3275-08de9a740400
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: xhY5iIBan66i28atU5VVEXOVTvalzULO4VuINT0xo5MSXmConCOPcTlmFdU0GTSjRxWutXN7iBmG2wLxZsqn7Z08J2HncTVifEqmXoV8qstgXrTbvxnl85xtZ3TWjXN4DZ2Cu45/yFZqaecJBdIwaJGS0Sk0XMfQq1utmiKcY/i75BbRkEAlYqc7UFygnBMTw6Haop628wZ/w0WG1v3DTCTI8P1TK8a7MIcCg8eP5Z2niXe5wDxuuH28cLMmD62nVkbw1pdt5+nWVIkzTqgCX7penW0PWWr9yTxqGakLXBfiVuA9G0ULW6JlueKzJlOwOZi5k8mgBedsHudk2ySt1EEZ7lCqJbqVZPgt0IfSwSVYWGwL5JJsr+EZ7eecL+X2L7NBplVzv08hKvXDJCCDFLL7TsmCK6XN6aOAzsIUfwaVxwKyhK1YcBw69PC7yrDMAgUH7TYXE41/d2+EiOnVY+d/R2SsWGRzlFAuhBjsF3TnJWQpp2zzsky++PcPLmQxt/EXNSUZVx+0smyaWnDyggehknUQKWH4mM67riesP2tiaG6lOX68jfSfhPDgyAkK8P4BFva8rWaUFl9JG1/lgKtJ2V/ZxkhwPZvj+Wn7NNMqGWk9xZdOF2XWmtvsbjaGZbDT6WErzWT7yMES0EgsU316K3ZV0hjz3L89GyudXO9uu4M3mvW7dNd6fbwqb1uxi0h8r2MpKA+tW3GazZnj6O8LDzzBr/MY78YqV4XZIo1fzjInsiUj+d0RBmIN4oAjnyknhnWsyB3nhKbAGLitTfNYUQENSq+s4V2nykJhI50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1lTS1VDY0h6em02aHpnTWZidzlPNDMrM1NsK0c4eUkvZkQzTlEzQXIyVDAv?=
 =?utf-8?B?SE9hMHBaVkMyOUk3VWJ3VFVGU3g1azZRR1FNWjdBZ1R3b3p4UEgyOXRpaGNy?=
 =?utf-8?B?bUpud0szSVZvOFZubTZBNHZnVzJCSlBjdkZ0R1RXTXJCQ1dZOG1LbVdIekt4?=
 =?utf-8?B?a1cwQjdseVJMVWNwTU5qdUlwTW4wZlZKVEJCQzNtS1ZndENweG8rTG81MUhV?=
 =?utf-8?B?RmF3d3dQN0YyOW1RVzdmazlpMXJ0NkhSYmpLNS9pVk9BMDdWOXdCTE9SZlNm?=
 =?utf-8?B?NkdtY2Q2eWw0SzNzWExvYmdqZG1EWk9HM1J6SHBmbC9wamhPc2ZNR3FDcTY2?=
 =?utf-8?B?SUpGT2R5SWFvZUNyb09YcFBpR2tlU3YwRTI4YXk0QXprSVNnUS9ONUpHWm0z?=
 =?utf-8?B?blV5RkxYUXFnNlU4ZldqaEhmc3NsNXJycGJISWdKdzRRaXExMUh3bHBuc1FD?=
 =?utf-8?B?aWxjVllrMFUyZkRtRmZla2pmTU40UUN4NXBSNUpzeVVVRU9jWTR0NThqUkpT?=
 =?utf-8?B?MCtkUENxU2x0TitiL0xzc0FGNGIzVERZbUpFNEhGanJTNHNhMU5wNnNJaGVP?=
 =?utf-8?B?OW12dDY5UUJsVDM2eDJMempnaWFrTEorS1hWSXVCRzBhcmx3bkpETldQTW9a?=
 =?utf-8?B?bVlmMGY3WkQvcEdkZy9RUkdVUFNMQXZQdFFWeEllbmR4NDJsUU5TY2plR2Rm?=
 =?utf-8?B?NmM3RGxoVEdnRk9rS2lOQk1PVzVHVHV6ajlJdjlHSjlnTk00ZmczZlh5MkhY?=
 =?utf-8?B?U2pWT1VqOThTb0xNaklZSnRWZ2hkMHhQNEM2NlVHMmpsbVoyVGxNei9GbS9C?=
 =?utf-8?B?S3pLd0Yxa2o3RWUrVDhwUm9HbUFURGVxd21xaXNhL2EweHdxRlpodkJONmw2?=
 =?utf-8?B?Q3hVK25mcnBQeW90VXF5aFQxK1E1b3o1ZlNpdGFBNE1ucCtEYjNmZzNXcCtP?=
 =?utf-8?B?WE45eWpQUkd1NGJHNjg1M3djc0VqMnNIYXhZSlZuc3BaVU85YlNPYUh5YTBN?=
 =?utf-8?B?UHhkQUIxM1gybjFDajlzT1BseE1HMzFtb0J0UCtmQ2V0S2NncHNUVGdpMWcx?=
 =?utf-8?B?SUVkS3dGbUE3Vk1uSWNqelZuUHZuMUFjd0dISXBrRW9oVFhMMTh3aURtaXVz?=
 =?utf-8?B?cm55NGllKytuRG1UVDR2VlZlWU4zdVgycS9xb280UzBWYUFEU0taZ0lvdmlw?=
 =?utf-8?B?SFpEVlVFbDMxQmgycEZSNGh5dm1LQjgzSS9FcTJzT0o0ZVl1RDhlV3N0bHZI?=
 =?utf-8?B?OFF1VGN6Q2hVMGRSN2IxbmdxZlJpSjlmSUhHV0ZCaUlxckczUWlDMzhFYWYy?=
 =?utf-8?B?NzA0NkhYeVVJOElkTG5xSXN0eHE5M2IxaFBWU0VaS2pHLzY3NmVQTTh6SWsy?=
 =?utf-8?B?NHpvZnJ1WVN6SGtVNU0vUmNualNHNjZlazRNNDVhd3NWa3ZDYWpqeWxUNDFI?=
 =?utf-8?B?OU9VUU1Tc0xaT1hRUnhjVWs4aHMvbFEyeVVHMGR5RzY3WE1oQkdTYVZLOVV3?=
 =?utf-8?B?SHFMNDkzaUZ5eGVDL0dCbmo2RWc5RnN6QTUvM0JIbU10UWhZbm1RQzV2VGs3?=
 =?utf-8?B?dmVwUFJFOFNCOVVVejlKV0hveWJXUzJ0T05rSnRhRWVrZjdUdzV0QVc1djhD?=
 =?utf-8?B?ZWhnRW1jUVh2d0NFVnpuM2IyYmVYckJ4c3Nnengwb3YwWmF4MXJmOW55MGNl?=
 =?utf-8?B?MjBHZHhnSFlNMTIrT1JsMjFDMEcwZ2xlakpOUWJGeS9tZWgvWExXanVsSExy?=
 =?utf-8?B?LzBCRzEzUE81SDZQbVBWcFFib0doUjZNRDdSS3VrMGowNGxIcDhSRjZRekVn?=
 =?utf-8?B?WkFkSnBGMTkxQnV2OE90WWpRQlhBbGVrbkxOMTBXa1QycFdhUSt6emRCRndq?=
 =?utf-8?B?dnB4YjhxSGFQMmZFL3p0ZHV4SjFWOHY2eGJBUVlvcTcrQWdiSVdDZDR0aExk?=
 =?utf-8?B?UFZySlFpSm9ha3FSNjNoakc0Skttc3NjSnpqL29rcWJaUjQwNjhrNXBERk81?=
 =?utf-8?B?VU10UnBMUzIzdGo5RnZldHpSV2hBdG9DL1RVOFlyWDBTM3FySFRDNk1hT0ZJ?=
 =?utf-8?B?dEFpYWkySnJ2YUhGcUphQlFWeVJVZUV5akdUVWIvRHZSa241M2MvYU9EN1Nr?=
 =?utf-8?B?bmpXd215TWRNQ3ZJcDRqdGExVFBFL0dsWXhjWjhpL1dkbHh2RkFWNGJqS1pV?=
 =?utf-8?B?ZXhkZUtIa0szSlJyMEh0eVZ1VnFlV3A5SVozMnZtZ2NjWFlHUE9HczJXMUNI?=
 =?utf-8?B?MWR1a1ZOVjRpTHpGTWRLLysrK0FYcmo0UStzOE5NVnNDYnczRU9iQk00c2M4?=
 =?utf-8?B?ZW02Rkw5VDRtOFRUd2VyYnJwSS93ajJlVkVwclNpSlFZc1d0b1djR3h1NWpr?=
 =?utf-8?Q?56n9uMDAROjKvIcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DEE75C58E218344A8F322B4A899D3D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EiK7yYfGL2GQsXQeN7Z7fi2tCK7xktB5AycqN5exoa3lnVklDTzoEQZA5HhiH0Ai5bLCZuaMdM7HuWrfeQGCJzCEjEeqwPN3fExlDA790sw7uXt6L5XzbX+Z8o3hZWlzRL/nyfZDbhCxdtyr5EIPlV/G5DIBtDp8U8xfAvldLpJPK2aUlbeIu7SKNo00z6nLf/OdEQS09YRwx+NezllOMkbIJjivSHqSfJFtmmTxC5SZ7aW/1J8odm8AT2D0rgNB2lemCdkp6iwa9+reXi+50RI2C/Ga0KAzChZiQ05yVUVJCZ/XE8ecrmBunzE4WOpqzZExo1cYCQSgFKzfJavUwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f864604-0a56-4b34-3275-08de9a740400
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 22:20:20.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpGnPD9ZlHjRoshUNsycw0StSlr5ukHquwPD7rwyiPTHHjgP36QoiavohawBIluxnG0AHR0LRt/ydgDHDhe8TidUCPQ5ZFhjjhuPu3Wu2Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE0OjQzIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
ID4gdGRoX21lbV9wYWdlX2FkZCgpIGRvZXMgYSBLVk1fQlVHX09OKCkgaWYgaXQgc2VlcyBhIG5v
bi1idXN5IGVycm9yLiBJbWFnaW5lDQo+ID4gd29ya2luZyBvbiB0aGlzIGNvZGUgYW5kIGNvbnNp
ZGVyaW5nIGlmIGl0IGlzIGEgdmFsaWQgS1ZNX0JVR19PTigpPyBBZnRlcg0KPiA+IHRoaXMNCj4g
PiBwYXRjaCwgdGhlIGFuc3dlciBpcy4uLndlbGwgc29tZXRpbWVzLiBJdCBkZXBlbmRzIG9uIHRo
ZSBwcmV2aW91cyBtb2R1bGVzDQo+ID4gc3BlY2lmaWMgZmVhdHVyZTAgYml0cywgYW4gdW5kZXJz
dGFuZGluZyBvbiBhZG1pbnMgZXhwZWN0YXRpb25zLCBhbmQgdGhlDQo+ID4gYmVoYXZpb3Igb2Yg
c29tZSBmYXIgYXdheSBjb2RlIGluIGFyY2gveDg2LiBHYWguDQo+IA0KPiBXaHkgd291bGQgaXQg
YmUgdmFyaWFibGU/IFRoZSB1c2VyIHRyaWVkIHVwZGF0ZSBvbiBhIG1vZHVsZSB0aGF0IHRoZQ0K
PiBrZXJuZWwgZGVlbWVkIHVuZml0IGZvciB1cGRhdGUuICJEb2N0b3IsIGl0IEtWTV9CVUdfT04o
KXMgd2hlbiBJIHJ1bg0KPiB1cGRhdGUiLg0KDQpUaGUgb2JqZWN0aW9uIGlzIG5vdCBhbiB1bnBy
ZXBhcmVkIHVzZXIgaGF2aW5nIGFuIGlzc3VlLiBJdCdzwqB0aGF0IHRoaXMgYWRkcw0KYnVyZGVu
IHRvIHRoZSBURFggTU1VIGRldmVsb3BlcnMgd2hvIGhhdmUgdG8ga2VlcCB0cmFjayBvZiB3aGlj
aCBlcnJvcnMgYXJlDQp2YWxpZCBhbmQgd2hpY2ggYXJlIG5vdC4gRG9pbmcgdGhhdCBpcyBtYXli
ZSBfdGhlXyBtYWpvciBjaGFsbGVuZ2UgZm9yDQptYWludGFpbmluZyB0aGF0IGNvZGUsIHRoYXQg
Y29kZSBpcyB0aGUgdHJpY2tpZXN0IG9mIFREWCBLVk0sIGFuZCB3ZSBoYXZlIGFuDQplYXN5IG9w
dGlvbiBoZXJlIHRvIG5vdCBtdWRkeSBpdCBmdXJ0aGVyLg0KDQo+IA0KPiA+IEFjdHVhbGx5LCB0
aGUgZGlmZiBEYW4gb2JqZWN0ZWQgdG8gd2FzIGNoZWNraW5nIGFuZCBwcmludGluZyBhIHNwZWNp
ZmljDQo+ID4gaGVscGZ1bA0KPiA+IGVycm9yLiBNYXliZSBoZSBkb2VzIG5vdCBtaW5kIG11Y2gg
bW9yZSBzaW1wbHkgY2hlY2tpbmcgYW4gZXh0cmEgYml0IGluDQo+ID4gdGR4X3N1cHBvcnRzX3J1
bnRpbWVfdXBkYXRlKCk/IE90aGVyd2lzZSwgSSdkIHRoaW5rIHRvIGp1c3QgdW5jb25kaXRpb25h
bGx5DQo+ID4gcGFzcw0KPiA+IFVQREFURV9DT01QQVRfU0VOU0lUSVZFIHdpdGhvdXQgY2hlY2tp
bmcgZm9yIHN1cHBvcnQuIEVzc2VudGlhbGx5IG1hbmRhdGUNCj4gPiB0aGF0DQo+ID4gaXQgaXMg
YWx3YXlzIHN1cHBvcnRlZCBpZiBURFggbW9kdWxlIHVwZGF0ZSBpcyBzdXBwb3J0ZWQuDQo+IA0K
PiBJbiB0aGUgZW5kIGFsbCBvZiB0aGUgaGFuZCB3cmluZ2luZyB3ZSBhcmUgZG9pbmcgaXMgbWlz
cGxhY2VkLiBUaGUgcm9vdA0KPiBvZiB0aGUgcHJvYmxlbSBpcyB0aGUgVERYIE1vZHVsZSBjbGFp
bWluZyAicnVudGltZSB1cGRhdGUgc3VwcG9ydGVkIiB0bw0KPiBpbmNsdWRlIHRoZXNlIGNvcm5l
ciBjYXNlcyBvZiAiYnV0IHdlIGNvcnJ1cHQgdGhpbmdzIGlmIHRoZSB1cGRhdGUgdHJpZXMNCj4g
dG8gcmVwbGFjZSB0aGUgY3J5cHRvIGxpYnJhcnkgYXQgdGhlIHdyb25nIHRpbWUiLg0KPiANCj4g
VGhhdCBwcm9ibGVtIGlzIGFsc28gc29sdmFibGUgYnkgbm90IGNsYXNzaWZ5aW5nIHRob3NlIHVw
ZGF0ZXMgYXMNCj4gcnVudGltZSBjb21wYXRpYmxlLCBvciBkZWZpbmluZyBhIHByb3RvY29sIHRv
IG1pdGlnYXRlIHRoZSBjb2xsaXNpb25zLg0KPiANCj4gTmVpdGhlciBvZiB0aG9zZSB3YXMgY2hv
c2VuLiBJbnN0ZWFkIHRoZSBtb2R1bGUgaW1wbGVtZW50ZWQgMiBhZGRpdGlvbmFsDQo+IGNvbXBs
aWNhdGlvbnMgTGludXggY2hvc2Ugb25lIHRoYXQgZmFpbHMgdXBkYXRlLCBvdGhlciBWTU1zIGNo
b3NlIG9uZQ0KPiB0aGF0IG1heGltaXplcyB1cGRhdGVzIGF0IHRoZSBjb3N0IG9mIG5lZWRpbmcg
dG8gcmVzdGFydCBURA0KPiBjb25zdHJ1Y3Rpb24uDQoNClRvdGFsbHksIGFncmVlLiBXZSBtaWdo
dCBiZSB0YWxraW5nIHBhc3QgZWFjaCBvdGhlci4gTGV0J3Mgbm90IHB1dCBidXJkZW4gb24gdGhl
DQprZXJuZWwgZGV2ZWxvcGVycyB3aGVuIHdlIGNhbiBhc3N1bWUgc29tZSBURFggbW9kdWxlIGJl
aGF2aW9yIChDb21wYXQgaXMgYWx3YXlzDQpzdXBwb3J0ZWQpIHRoYXQgd2UgbmVlZCwgcmlnaHQ/
DQoNCj4gDQo+IEkgdGhpbmsgdGhlIGNoYW5nZWxvZyBpcyBhIGJpdCBub24tY29tbWl0YWwgdHJ5
aW5nIHRvIGJlIGRpcGxvbWF0aWMNCj4gYWJvdXQgdGhlIG1lc3MuIFNpbXBseSwgTGludXggd2Fu
dGVkIHRoZSBlYXN5IGJ1dHRvbiwgYWxsIHJ1bnRpbWUNCj4gdXBkYXRlcyBhcmUgc2FmZS4gSW5z
dGVhZCwgbW9kdWxlIGV4cG9ydGVkIGNvbXBsZXhpdHkgYW5kIG9wdGlvbmFsaXR5Lg0KPiBLVk0g
dm90ZWQgZm9yIG9uZSBmbGF2b3Igb2YgdGhhdCBvcHRpb25hbGl0eSB0byBhY2NvbW1vZGF0ZSB0
aGUgbW9kdWxlDQo+IGNvbXBsZXhpdHkuDQoNCkl0IGRvZXNuJ3QgcGljayBhIGZsYXZvci4gSXQg
dHJpZXMgdG8gaGFuZGxlIHRoZW0gYm90aCBkZXBlbmRpbmcgb24gVERYIG1vZHVsZQ0Kc3VwcG9y
dC4gU2VlOg0KwqANCisJaWYgKHRkeF9zeXNpbmZvLmZlYXR1cmVzLnRkeF9mZWF0dXJlczAgJiBU
RFhfRkVBVFVSRVMwX1VQREFURV9DT01QQVQpDQorCQlhcmdzLnJjeCB8PSBURFhfU1lTX1NIVVRE
T1dOX0FWT0lEX0NPTVBBVF9TRU5TSVRJVkU7DQoNClNvIGl0IHNvdW5kcyBsaWtlIHlvdSBoYXZl
IG5vIG9iamVjdGlvbiB0byBvbmx5IHN1cHBvcnRpbmcgdGhlIG1vZGUgdGhhdCBpcyBlYXN5DQoo
VERYX1NZU19TSFVURE9XTl9BVk9JRF9DT01QQVRfU0VOU0lUSVZFKS4gSWYgd2UgYWx3YXlzIHBh
c3MgdGhpcyBmbGFnLCB0aGVuIHRoZQ0KVERYIE1NVSBkZXZlbG9wZXJzIGNhbiBoYXZlIGxlc3Mg
ZGV0YWlscyB0byBrZWVwIGluIHRoZWlyIGhlYWRzLg0KDQpJIHRoaW5rIENoYW8gdG9vayB0aGlz
IGFzIGFuIG9iamVjdGlvbiB0byB1bnN1cHBvcnRpbmcNCiFURFhfRkVBVFVSRVMwX1VQREFURV9D
T01QQVQgdXBkYXRlcywgd2hlbiBpdCByZWFsbHkgd2FzIGFuIG9iamVjdGlvbiB0byB0aGUNCmtl
cm5lbCB0cnlpbmcgdG9vIGhhcmQgdG8gaGVscCB0aGUgYWRtaW46DQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9rdm0vNjlhMGMzZDI0MzEwXzFjYzUxMDBkMUBkd2lsbGlhMi1tb2JsNC5ub3RtdWNo
Lw0KDQoNCj4gDQo+IFRoZSBzb2x1dGlvbiwgbWFrZSBtb2R1bGVzIHdpdGggdGhlIG9wdGlvbiBL
Vk0gd2FudHMgdGhlIG1pbiByZXF1aXJlbWVudA0KPiBhbmQgbW92ZSBvbi4NCg0K
