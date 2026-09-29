Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930F3A5459;
	Tue, 29 Sep 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699634; cv=fail; b=oh+pxne9yetD5DyT9axKcccMaWAmuqSEr7UBGKtYGCDqbqrBEC+YEEgbgKb/vf4Tc8mhFcxsyTBpgqbHHm5W7q0UyLJAIjD/xdaBCP2QJcYM+rb6Q93trLmtiq9tiNMoxoAjeaCJ93g9I+KuENHdgpTeCXKS2+geSBdYvwFzkfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699634; c=relaxed/simple;
	bh=Dn8VlMAB8GHlCR17gs81SVRxckP8TWSezbTMrKV+hUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSRUh8LdRGlE7HkXYASWWdiWNLeUooMhKFhycvnpEnKioiDEBuxkcLjV/5/ZymJl6qVqaNdElZqmamg7GrdjoLgC0VpJMZaC7TtKBP89/D4z9a9KZ9aIOYSwWUKNZVPMLXBvRZecgvT8p5y0ou3uWBhVbhJEwYSQmrUeY1w7iTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfJAHp7Q; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfJAHp7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790699633; x=1822235633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dn8VlMAB8GHlCR17gs81SVRxckP8TWSezbTMrKV+hUE=;
  b=IfJAHp7Q9xyH7IBbbk+vT0S6MT3ZpOq57tIoKLqnwv7YfgN9NHk3Xl2P
   kIRb/P+GV3cGC+JOFtZPZ/OeaEae1TzsaSrGLphNHTNWC1VHlelG7AdIj
   KL61wJkputZlfhk9oDQgYDaQAOu1MkCfcoeTh7pfVDQ1YfiovVuACv05y
   n1XUl3GWpyYYOTdz41EukODMzUiEUfrVnmaPKp/Uuq/1Cctb2Y0TL4h42
   rRDsQfRdutBWW8aM79Sm3VWL9F1L4DPn1n8BP7LVdu4o132jz8idIjpJ9
   W7JYC43w+Ce5MU9JBoB9e/BHgQgDBCkA2JmYWKUkQ0i1QoI9rI2NrTHRU
   Q==;
X-CSE-ConnectionGUID: 97t4BXTBTd2yzCQMkuZMYA==
X-CSE-MsgGUID: DdwtBSyoQjur0ZQ1SWWOIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95237063"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="95237063"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:33:50 -0700
X-CSE-ConnectionGUID: DyVMJ4hDQHmiWtSkEzhnbQ==
X-CSE-MsgGUID: BPZpaLZtR1adznMzyB/Agw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="301683782"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:33:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:33:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:33:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpQdC6ab+jQcbYFSfKGi+fMNSf2rDbbOBD4zCVt+/BuSorbshwf8TGMVUqR2rmiAHCrIRo8TCAW3+ctBHmaSt4dWInHdKcuTAdrI+bHUVujJhQq2ISw2y8chxpLJvEIAB6LCM96os4N0hZsC3LaAVM/itvprIJwbMvZfHjqBd2JVeYxxttCr4tBpUSwhxd2dM7MWJ8v37jFbK8bxy1e/l5YrzlCzFPTwGHB4sjn5925enle8/XxIMMrKgnvPd5flED8JLi2+tEF1ZKtK3XmwHtTKk4rpNl6gCH0EJ6efcdFEcR3gLaZUyfLURn5vwE/clxM8Lfsq+UtqDNREY7iB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn8VlMAB8GHlCR17gs81SVRxckP8TWSezbTMrKV+hUE=;
 b=JUdoHpQ5Y/V2K68hITdW0fhf7+0lJuSpeoaUjIEgblnPqDKkX6IOcyFe9JwJdWKFzA1biY8u3uLKsJLU0kStSvASuyby3Ksm8n7nK8VF0OYOA7vx5aaWctsv+XLOQeiDb3enW6dId/Z4ui15ZYR17FxbtmeRAH2yjIv8B/VsQwBkmZCQOJDYKBl+/4j6HlFnOlGxugcvxE8qD9yf6aizvCoY76yxJ6MkpB2VENe/IYEixV+N69LL/JY2iPWKNThrzFuhx+OZxvU76nWLQeoe3E6gU0kxM0Tlkmgwpvjy9ly99QWoJyZ0aQ4Dm0vw6fWlXTtiyFKdB8HTODdh9jRgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSVPR11MB505860.namprd11.prod.outlook.com (2603:10b6:8:3e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:33:43 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 16:33:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xu, Yilun"
	<yilun.xu@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions
 initialization is required
Thread-Index: AQHdRPzRHohuXeHMhkaF5CbyB+xzBLbQJFoAgBRsEYCAAM9uAIAAdsCA
Date: Tue, 29 Sep 2026 16:33:42 +0000
Message-ID: <5b64c44c06a416d1f38e33639923d1b09f14d561.camel@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
	 <20260915102658.713079-4-yilun.xu@linux.intel.com>
	 <8c7a630c25f04dcf5b19e29d3b271c611bf90378.camel@intel.com>
	 <13ff769fb55f37a9e7a68bdd40815775ddc4ddb1.camel@intel.com>
	 <aruEyEetjbruotXB@yilunxu-OptiPlex-7050>
In-Reply-To: <aruEyEetjbruotXB@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSVPR11MB505860:EE_
x-ms-office365-filtering-correlation-id: 557eda4d-7dc6-42b5-74fc-08df1e476cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|56012099006|6133799003|10067099003|11063799006|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info: RTW+mvMVhj9iiksmIcCY12fGwo4GQztiaBrUnIxY+SWzsxKGdmLgU9R6NfJw3hkMrT+4uTBJ/1GKGxmgwTcnHXVCHYLb4yY6x1s3ACwauv+TnhPBuBG9tkeSYxEGc0fj+hW00mtx5j+yLlFCAR4KGrtg+AMS+f6+8aR5iM0YRwDtXd7xCU8ZYQh7dwlAmH1h2p86i7MY5NTW8/1kAMl4WkY10tPDdbXDikJe+EqB3029dOc7Qd/uB4FUQhEmR9BQaFcXo3oTJzNDKrjSxJtw8Laj0WOI9HMpX+OW7x5wLo20jtT7dvqITk9oJLoyHGTLbvFBeyBaquZ17bttDGSxU3y0gLq+WI7lO+D4WzHla/7IstEbCdmiRcTB7x118Cpss1T+nNMZCIq3x83QO1aLnrzzioSQnBi89BYRPA2ED+l0bkU6YhYhteX6B2Sj9QB2picovI4rVwq4XYfQ3uKjyBPe8Pv6ZKGP1T2BtxzRdKGwyKemgheReuGSfTJynVpnrjrmQydQQVAm/GY7LNZXuth+PfksUCIETHJAMC56UZUxHuvxKERiaU1kBz+y7HY8Pzp2F4UqQLQoa1Arfde1qhaybJQXMCRcAQqieUtVMqJPbMhhBaG732SCsIxbHH/fzsbgtfEbiHGV8YlMfe6HUIk3fy+rx1IsqJsbIclJ0aNhMdt+vfHECemum8Tr5m6wf0QoaGPYA8Bg6cgp4BAhhMkp63k5lfSmZpjzKlJVJbY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThlc0Z6Rnd2Wm1waTFlMTJKcXpkcnA5WkNLSFJ0UTBBMzZGSXQySDM0S3Nj?=
 =?utf-8?B?Qyt6UlpUQW1yWUtqNFd6eXpxWjhBSmlKbS8yUDZJeFNTTStLZDdlS0VQTk0w?=
 =?utf-8?B?V3dKUmhYWUlsMWpNVlY3NFBCd2MzZnRCUFhJbit1aVBsZVliWStFcmlraStq?=
 =?utf-8?B?Q3hSeTlhTENqWVdHOE5ZTG9WTUZKaStvVVNUd3UzT1J3NWJlV1prTGl4UmQw?=
 =?utf-8?B?L016RzhrMjRMNHFQNHFyaDFMOUltUk9JeDNDMmVBaG9LU2xRNmovOVh0VCts?=
 =?utf-8?B?dmw3dGJYYm5VRUszcmlPUXN1cjVXT2F4bXlFMllrK2R4OVNmU0tSMnh3ZUNa?=
 =?utf-8?B?NDFRdnFQS0hkR2NSUFpBUmJpU2huc1Y4K2VTTEJZdXpXcVBMRE5xaDRpN3di?=
 =?utf-8?B?RWRvZ2hrTWZvVzlOWkMzYStCaVl4b0crK2hUVUVPYlB0b0JYSWRzd3lGUVVE?=
 =?utf-8?B?d284N1ZWZFh5ckdTQllteG1heFdFbzcwdmpsb1pKbjlsTk1lN3ZLcyt5c1do?=
 =?utf-8?B?QXp5UFU3VnVTdnM2MU4xZHNiUVpTVlJDS0ZVdklGa0FEWFp4by85TG9XcDhz?=
 =?utf-8?B?cTdjMEpKZitIL3hGTTIyZmtkNWZlLzM0Q08vZmpYcXo3TGV6dXBybVFvd3o2?=
 =?utf-8?B?clBtUTlVdXpmN1BIc0FpK1p5QnAxdTNxcDk2bU1UdDVxRDRzSEZEeUJjaEQx?=
 =?utf-8?B?WVQ1dDhMekErclFSODgzVXZENzJycjFIeHZMTFQ5VFZkQUJpbFVOMUo3YVdY?=
 =?utf-8?B?ZkZId01Bb3VNRjV0bnNHaytUYXZuay9BNWtDakJ0VnpxSStncXd6Q3RoU2Zp?=
 =?utf-8?B?ZGcxTDhhM3RKckIvZ3dGcExOZ1BaTm1zR0Jub01IRzd4Q2lOZWRtWnVIemdr?=
 =?utf-8?B?L2tDc2pOZjRtdkJGQ0E0ZjVESHJVV2Y1NG5Mek1LbS8yNjlDY1M0NnFHYklG?=
 =?utf-8?B?dTQyblRzc2JFWXljbzRQR3VnTmhGdm41S2E5QkRjSlcvYWxEWU9TV2grN3cr?=
 =?utf-8?B?VFRHQUxPc2pDRUVab2RWT2xuVjVla1hIZm5lRFJQUm9wUDlmWXA2RjhjVEJN?=
 =?utf-8?B?U0IwV1g0c2FscXhwcWdaOG90SVQ0ZFE1amJacEZxOWtNU1Z6OHRNQXUyZUgv?=
 =?utf-8?B?M3UrbEVwS2crejdRa3RjZ0NOZTk0NWgwOG5KUW9xZTlmZmNCQS8rWXJyVTl1?=
 =?utf-8?B?eHF5cnNLYzlRVzdvWWw0OHpHdkUyZXZmWG9KVSs0dzR2UGwvUVF4VUF6dXN6?=
 =?utf-8?B?UjVsNlVYaFV5VGpTMEdRcUZxNFZQako4RVA2akY1M3JrWHFKS2hsNnBERlUr?=
 =?utf-8?B?QnBYdmQ2T29OeGlzeXEzNDZCbEorUDByQTZ0bm9ncjU1S2tPYkd0ZWVvZmtI?=
 =?utf-8?B?V0F2R1FlMW9wNmljdFh2VHZWNGFqd0JEbGhVMFppYmdJTmNmSE82bFc3di9W?=
 =?utf-8?B?ckxQeWFGdmxqS3JWZmYvY1hJdkxtL2l6SDlQTlFMSFp0elY4V1BJUmZvc2dz?=
 =?utf-8?B?RUh4dVEwZ3lqRUFDVENtRXpQQzhib0xNQ09pTmNCbWMxcG9jNEtZZXZvR3lE?=
 =?utf-8?B?UW9nNWlDNTMvT1FCWjIrakJ5cDgzNlByK0FXOGtremRHUW9hNEpIT1FyMVVs?=
 =?utf-8?B?R2ZKOHQyZXkzdDdqL1RTMkFnRDFUL3NmZWM3bU82bVJpVjIyTytLaWYvUSt0?=
 =?utf-8?B?cDNZQnM5NEhuL29vbTh2S2VUelF0QTN6YnpuMXRkdzQvTXdhQmZVdFdFblJH?=
 =?utf-8?B?bjF4ZVRHL3NJOEJJR0NwK0t6cXFxRCtic0hwd3JlNFNJV1JsOGhqRnJ2blhI?=
 =?utf-8?B?OUE2eWZPQnl1MUhxUmt4ZFV2VzNDYU9HdjN2U29tdW5hRDZrbllyeWp3aFlK?=
 =?utf-8?B?R2d6Q3lDVmRRWktZWXdua2IyYVVTOU90TFNFV3M2QTgrd3MzcnVFVXJkMmVt?=
 =?utf-8?B?Y0FFSDdFdjlLV3RpZ0o0K1VrRGptWmRpWjFndElQcElSM3lhdHZ3bkJrUTJw?=
 =?utf-8?B?b0JGZE5YeUp5cThGUFF1RzVDSkg2NkRia2lQeXlUbm0xRHhpVXFmUnpBZVFV?=
 =?utf-8?B?TDFScUZhU3RyKzgxckViVnNQVDB0T3huUVdZU1ZoOEVVSjdqM3R3aVRqTHdi?=
 =?utf-8?B?VkVyYlF5UnU2THZnbTRLSEhyV1ZaeGk5ZGxTZnpuSTdnSUQ0Z3RHNFMxMWFF?=
 =?utf-8?B?Q25NeXFlT2JUWTYxMDZBUXVBdm8vZXMzc01MbEtsN3doaEpqSEQyWS82ekhI?=
 =?utf-8?B?MjhEdVZjaVlUVVJ6NVExNXYvemRTVjNna05VQUt5aXR2SGMxV2VWMDdnOHpO?=
 =?utf-8?B?Mk5sUkFtN1RnZm5TOXc5bSt5bjVhUkpjWHhab2pod0lTNGZXck1YbWNvRG1B?=
 =?utf-8?Q?hOWyrN+PLIbRYBOo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2441284258C62E48BB258F2B01915792@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g4Zo6H6T+nrFMxeOuNztE+GReHCZ2Le9F1fseEtqPeuxgIv4ebOU9AEB+0J65W3VLsrizShB+Ywr9UILrmn0zHIAEy5rAFNu8bzNezt7SSFf3lXnl3IgrALXs09aeizNsyJdeU5pdwTL/bsdO7jgdkfYRGIGD6wYJzn3Vka0IxjuLIlOtz9tCz3nsXIqzRO8nmMxKZN/bYrUkoRIun9qh4AA6XIWq5ejhlWBPkF42hbXz/8RCUuTshlyOTFbelecCRTdDLCW2hXHfjyYsd6YiKlukX0HCOOMNNDccNSBsnsE1ZZ4WMg3UgMszh9SCctM41v3HlEX1Q9w7S1WT4NHyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557eda4d-7dc6-42b5-74fc-08df1e476cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 16:33:42.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoG/oqrgEE4kUamZFClvJasEsHNWRyxP1cEpR3QhZu/mscv0C0TNevJ7iZUltfFLCn011X1edH0e/2VhNhUvVBhJkrIX5roRnlYgYlQzyKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB505860
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDE3OjI4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQW5v
dGhlciB0aGluZyBpcyBhYm91dCB0aGUgYWRkb25fZmVhdHVyZXMwIGFyZ3VtZW50IGZvciBUREgu
U1lTLlVQREFURS4NCj4gSW4gdjEgLT4gdjIsIGluIG9yZGVyIHRvIG1lZXQgdGhlIGdvYWwgb2Yg
Imp1c3QgcmVzdG9yZSBldmVyeXRoaW5nIHRoYXQNCj4gd2FzIGNvbmZpZ3VyZWQgZHVyaW5nIGJv
b3QiLCB0aGlzIGJpdG1hcCBhcmd1bWVudCBpcyByZW1vdmVkLiBJIHRoaW5rDQo+IHRoaXMgYXJn
dW1lbnQgcmVtb3ZhbCBpcyBvcnRob2dvbmFsIHRvIHRoZSBUREguRVhULklOSVQgZGlzY3Vzc2lv
biBhbmQNCj4gc3RpbGwgaGFzIG1lcml0Lg0KPiANCj4gwqAgVERILlNZUy5VUERBVEUodjApOiBU
RFggbW9kdWxlIHJlY29uZmlndXJlcyBzYW1lIGZlYXR1cmVzIGFzIHNwZWNpZmllZCBieQ0KPiAJ
CcKgwqDCoMKgwqAgVERILlNZUy5DT05GSUcsIExpbnV4IHdvdWxkIHVzZSB0aGlzIFNFQU1DQUxM
IHZlcnNpb24uDQo+IA0KPiDCoCBUREguU1lTLlVQREFURSh2MSwgYWRkb25fZmVhdHVlczApOiBW
TU0gY2FuIGNvbmZpZ3VyZSBuZXcgZmVhdHVyZXMgc3BlY2lmaWVkDQo+IAkJCQnCoMKgwqDCoMKg
IGJ5IGFkZG9uX2ZlYXR1cmVzMCBhcmd1bWVudC4gRm9yIG90aGVyDQo+IFZNTS4NCj4gDQo+IFRo
ZW4gd2UgY2FuIGp1c3QgYWRkIG9uZSBwYXRjaCBiYXNlZCBvbiB2MiBzZXJpZXM6DQoNClllYSB0
aGF0IHNlZW1zIGxpa2UgYSBnb29kIHdheSB0byBkbyB0aGlzLg0KDQpTb21lIG9mIHRoZcKgbnVh
bmNlIHRoYXQgd2FzIGV4dHJhY3RlZCB3YXMgdGhhdCB0aGVyZSBpcyBhIGRpZmZlcmVuY2UgYmV0
d2Vlbg0KdXBkYXRlIGFuZCBjaGFuZ2luZyBjb25maWd1cmF0aW9uLiBGb3IgZXhhbXBsZSBUREgu
UVVPVEUuSU5JVCB3YXMgY29uc2lkZXJlZA0KcmVjb25maWd1cmF0aW9uIGJlY2F1c2UgaXQgZ2Vu
ZXJhdGVzIGEgbmV3IGtleS4gU2ltaWxhcmx5LCBjaGFuZ2luZyB3aGljaCBhZGQtDQpvbnMgYXJl
IGVuYWJsZWQgc2VlbXMgbGlrZSByZWNvbmZpZ3VyYXRpb24uIFNvIGl0IGNvdWxkIGJlIGEgc2Vw
YXJhdGUga25vYi4NCg0KTGV0J3MgZm9sbG93IHVwIGludGVybmFsbHkgd2l0aCB0aGUgVERYIGZv
bGtzIHRvIGNsYXJpZnkgdGhhdCB3ZSBkb24ndCB3YW50IHRvDQpwYXNzIGFkZG9uIGJpdHMgaW50
byB1cGRhdGUuIEFuZCBzZWUgaWYgYW55b25lIHllbGxzLiBJJ20gbm90IHN1cmUgdGhlIHByZXZp
b3VzDQpkaXNjdXNzaW9uIGNvdmVyZWQgdGhpcyBjYXNlLg0K
