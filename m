Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370C3D25C2;
	Wed,  5 Aug 2026 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952476; cv=fail; b=iCXIPBPdMyRj/zq8/WlGjNSUsu6NFGTmk1IuL1LW4qIhR37Lhu8P6pjCILdBuq1JsEQty0lYll4WoPooVoEU8mf7OdRcXiuV0wQSLwVUd2S/YhKJPyg0ceV6SbSrnOp99wf6cbBO9AFNIkdHJXPFeipWwl/+pIx3mQtVGbglPcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952476; c=relaxed/simple;
	bh=3uPz3VO6SgWfhXOeeibRtvyX+kN2p+EXrcpQhqVjPDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWzrZSXmTV+ZfEZVcKtwd/419aqOwYDvbI4a/RDfjexImQfqzm0yz1pqhp4JlMln5ebJgIEhpFG1pI6/U5q+GWBJc+fGFIiT2+7YXTQMI020T5WnMT+RFSPxOP+w8HjsW2s9KARioaYgkTzw0lh0l7J9BXEtaMFob2DFImDqgd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgKeoDB6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgKeoDB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785952474; x=1817488474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3uPz3VO6SgWfhXOeeibRtvyX+kN2p+EXrcpQhqVjPDg=;
  b=SgKeoDB67moPnFl7+PW7M0xHM2iZj5CtDaY84I4N3RQgGwEIjs7IOsTH
   fVAnDuzzl5fx1a4W/uPiHOMJj4IzCXgGrVzwHP9B0Qad3l8l5GdN2Lbo8
   e1BenqlB9eNj9IW+s2b4cuEwgjAId/D0B68Kt3+Mc7oG/ZWH3Lf5WJnVw
   YNbfSU4mE6hzqDrDQzMCw4Wp6lgRjaUcJUee2s2TtXgbBkeb9ykLK0dr/
   TGsbqni5+WKuoQl5L24Il1jnc4Xa0esKwU0FZK5YpGrAm7lJbP7sN+UiT
   +mv6q3pOI1wLaLPleBzR+zMxMUHfkvZqh+IV9Ck1ZrYNUsnEGTxWhwKLL
   w==;
X-CSE-ConnectionGUID: MPTvfhaaQEq9s/VhBesztQ==
X-CSE-MsgGUID: 0uOYNo3tQAya0obmeA8jVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="74071251"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="74071251"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:54:32 -0700
X-CSE-ConnectionGUID: w4kGN5MfRR+TOgVry+Q7DQ==
X-CSE-MsgGUID: T+ZGMKYRS2KjUDwxFwJY4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="286532596"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:48:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:48:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 10:48:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Re9MMj0FCDnjv97a+SRRG1LdeoVxjn0SNv+A3ADkhzMsz4OcVUZEhrvk4AMDUCTK4+BAtra49zb8hpa3/fJo4evTUJw1QSxVA1PK9BqZ/F3iDWOkA2xxL76tWxv9ir/t4b/tbUYjKA0eA+F8W+JJkP3E3eAViC5srhDWWm0RwlWC8A394Hg//qy90u7qdlylHDv+MUcVE9J/+mGBnZFM8LQ+5CGtesd0VfLQx7o5ut/aHKtB4PdrE0E2c5KXxKEvI9I3B871EwdEtAsLd6PpsJndDuoBNDBFzptQ3QNFAUgD/qyLQAgJyZRn/dnzWxxUZFDiLQIYhN4BtHN5+QkECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uPz3VO6SgWfhXOeeibRtvyX+kN2p+EXrcpQhqVjPDg=;
 b=aF3aiS0qWew/5uJgbhvW/0vg+VQJaMRP6LRtEpe2ro5396zMjwbaxMjkckmUPfMVliROPUhFB9fGx7yMi7xrCGFY5ZSXY9YHgvLrdwSJ9Rdc3lIhKz8Gpu4Tyjv7JTpTOu9gg+960AF5AwEUG6naVdi5JKsWsQI3r+u0zusoajlk45ZWGXmGSQ4mGxUXJ9URajztDo6VKh4tGK7XTtXCJD1p7ceWqnW8NOkJnC5lYOpv+Ri/GVBQ7QzAvfgDeN2+KvYtCFYP1KGAaCSDiZunbIe264saWK9oN4KJYNcCBknlHpesrZ0raYtGxo0lAXuiD/+tNUeCfKXbLKqfKOJTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 17:48:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:48:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global
 metadata reader
Thread-Topic: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global
 metadata reader
Thread-Index: AQHdJATIbfmORPI/QESK194kuaOqBraPvg8A
Date: Wed, 5 Aug 2026 17:48:11 +0000
Message-ID: <5e0cfa980d9fe53545362acb81e44e8a653301f7.camel@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
	 <20260804112941.19894-4-chao.gao@intel.com>
In-Reply-To: <20260804112941.19894-4-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH8PR11MB6951:EE_
x-ms-office365-filtering-correlation-id: a33161bd-7e8c-4443-924b-08def319b7b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 3WQVgka7Uhn4+jg7ceD/5ADGUVXSKzylrPjTifX77IAEQScXkCo+fFk2Bu5n/XpnxDqFBWHe7wItSDyV2zty/MkE33gVqkOa5exlhsi7PlGuXBB5uf5kjFP2OqlmtjorlbvWlSEXOOAjpkTLh+sLXikfJdEv77Zdno6wnvMWj+DZdnmuoLWjpD+Iyri4XO4aMUdyVZfwB56noi0kbw/HsuFcfXcvgUb1c+tODARADwbgkrPPgNyWYSxnP13sflzExXOf5tcpG3JLhsHWvZH/jrqDKkSguah03IFIV2FhsM7Du6Ym8Tq5NcYy+wiBU/xkcdehVWLGIjIb281XbLxtcpKwwIwK9RhKFTRbp68G/ub8F0hJh4lJvL7deO7vACYWecvZw9OAQB7jX7qVCK4mSLq47ISeJpPAqMpl8td9t8E9tlhkFQpocX/72+qc7ddRtInb968pURkdLsgiTwPENengHYJ0c9FWNQULtePlCO+iNCR2pMA/sHGE/fW+/wTD6BavM8AjeWTGJsmaGVkCAkIJY8SkpNc5nGMmq/4Z1xvglvrXZAqEjUiDY7OvBJF4rg7OkG8Jlqi9WFtcKTIR3FXiLqa5AFOlCTI9iyppRzIe2ROtqZjGgxdH8oG3+CBZtONXY/+510+Px0JbuyCD1MnILtoj1fvNxG6zkZ+nDiEz6z93Q0tSXvMK9dVEYunh5iXi6bF90aYkpW46tfSqRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXdaQk1pOHNrOERFTGtZSmFqaVVVMTFRYmo3MHhBang5UTliZ2I3V05hR05s?=
 =?utf-8?B?VUcvQ3l5UnZuaDR5aFdyMnI3VlZrS0JlRFV1WHNVWXdoaldLOHVFZ0plS2VO?=
 =?utf-8?B?Yk5Jd1p0NWRyZ2NybUdGNkswOGVmRTV3WXNnZ2paQ3k1Z1haejFSV0JSb2wv?=
 =?utf-8?B?dGhDYmxHNFZnSHRrUU5hYWVPT0JCZ05BeFFxQ0ZRYktyUzBRYnZ2YTlDNHd2?=
 =?utf-8?B?RUIzVU5TV3NtNG53a3FpWEJ4Wnl1M0FlRzRQZ0hJOWp2UVA5cGwzUkpaZHoz?=
 =?utf-8?B?R1VsSGgwSnRoNzlhWmpuOFhrRUtzenZNMHZIdkxZSVN4cldSWDd4MHQyeWRX?=
 =?utf-8?B?QXk4TEJQRTdtRGg0K21lWHlSKzhXaEFuYUFxM2JQVWlGb1VYbjg3UVJ4S3Bj?=
 =?utf-8?B?VDZEalIvbVluMS9HTloyUFI3VGxxVkxoSG1UbW41SVdac3RaSStFOThsWG9s?=
 =?utf-8?B?V25kTWppb3pydUVGNVFvOWwrQUdKZDFoL011YjZyazNVN05XVnNsZDJVb3ln?=
 =?utf-8?B?bU9vMzYraWVIQytjRjFWbWhqMmxRdFBpNUlUc3BsOVBQUWovc2JwQTlOcGRz?=
 =?utf-8?B?TFhuWEJBbmU2WHplTG5ZNHdSM0M1YkhDVWZSeE9hM2NYamxuQzlvNDE4Y2J3?=
 =?utf-8?B?bExlaDNZSit0Q3NVNklEbzFaQ2xqQnVyZzJEc282QXVaSys3UnpXdVRXZjBM?=
 =?utf-8?B?VUVOWDFoUUlMUitETmZibUpoVXFJTGgxS2V5b2cxZ2pxVUZnK3lPOXBIZmhO?=
 =?utf-8?B?WXF5dDBFT0l3Zzh4UGwraDBTL3JVUWxlb2x3TVJyd3NGTS9najR6bjI4Tk9R?=
 =?utf-8?B?OE11R1RobGFHbFk2ZUlieGZuU1R1M2ludGtuNVN1Z1g4NVk4SW45ZzNzVmNu?=
 =?utf-8?B?bmZ0ZTMvdVo1OHNiK3IvYUJVbm1HNWJwSkgraEt5d1pUYnBsN2N4bjBWRExr?=
 =?utf-8?B?MVFOaDZ1enByTHEwK00rb21LRmFDZE1tanJxK1dYK2hVaU0xdmNiZzVIN2g0?=
 =?utf-8?B?eGgyS1Q1MmczZHo1bEVqZHlOcnhJNFZqZVJBSGpic3FsU0UyYjJ4djUvemJp?=
 =?utf-8?B?QXFKaEk3V2l1RHRqVTJtMm9BUFlVNTVwdTUzMXpPRWcxUTdVUHBKcFljbklU?=
 =?utf-8?B?bTcwQmVBaHFUS2dRa0NRMUh1RndhQWhYT29Fb0dKWCtRdFVZQUdGMFdCZkd2?=
 =?utf-8?B?RXRHNVBQZVBLQm9JdjBCYVNmdHZBWkF4bWlaQ0I3VjFDWFhWRXlvdzZ2U29S?=
 =?utf-8?B?a05ZNzJ1b0lvQ1V2WFEwQkZ0NnZ6UngvRnRqelRLWWdIR2dCVGNPTzRpRWJD?=
 =?utf-8?B?SWcweTExcjE1VkFscTdhY1FkT2E3bGE4MGFhUjRsWVhSN3JOMzNJbSt5SEFw?=
 =?utf-8?B?U0hHdlBoTmdLcGpKdWxkWFF2bUFHanlLbDJPUC84aFdBYXpZdExIenNVK3RD?=
 =?utf-8?B?czR1VDc4eW9SWjNycVVvQXRNSnRUQ0JIKzY0aHB5MDNiZnNJTEpHT0dGODlI?=
 =?utf-8?B?dFBHU0t0MzQxUnhDRDBra2MxRExXNG1TcmFENzRSTTQ4SWJvQnE3YmYrdVdJ?=
 =?utf-8?B?ajZ6dFJEN1J3ZHJvRXBXUlVwajRRQ2p0ZkY4eUFiZDhMZll3cFRNTUlhNzJ2?=
 =?utf-8?B?d2pVdzhKOW5ZTUpLVXZ4Z1pwYml3NXVaa2hQWFgwR1RxQWFjQk01QSt1S1BT?=
 =?utf-8?B?czg3bFFqZk5TTjdUODlrTGtYMzNFeHBQTTFDZHlLYVBXaUJBSE43K3hIVFBm?=
 =?utf-8?B?Z3JvSUdSQTUrZWxLWFhSUGEzeUt6MnlqWE8yNXZKbFRqcWcyMG5JSVpweGQr?=
 =?utf-8?B?andPVnFhVzNEZ3lLUjYyUGtnNk9UcTRLMXpjNysydkJTNE5oV2xKZ2hjNW9i?=
 =?utf-8?B?UXZmNFhnQ2x6QU5VTlcxc1BWRm91VTVRcHJ5VjhuMDYxN3k5Q2lSN0c5Qkts?=
 =?utf-8?B?TjZsQlNYUWxqWUE5TzY1Z1ZEYzA4Yyt6TUYzWVJNRVVXR1FXOU9zcTJNUkxK?=
 =?utf-8?B?TmFwek8wSEd3eWprNUpFTnNzTXFCYWVOQ3NjZ0lTNnh2M0FkVnFmdmNkRklN?=
 =?utf-8?B?WWc2MEM4YkNkRitxblJxNWlsTDVhYjFaRWxtTithcnBOL0RhQkFLY2NaTDYr?=
 =?utf-8?B?RjNMdGQwM24yVkVMQUppMmpIOUR4NEY2eXVCajE4c1ZUbHVZU2JsdXo2ZndU?=
 =?utf-8?B?dVIwcDNqN05nbnRkbGNNYXhJR285NTNERzdQWG9MckRoTHNOeUM5eFdvTTFD?=
 =?utf-8?B?N29ZelhmZ1hueE9XbmExOEhRTTJTNEtVS1BaTVhLMlVUeE1qRis3cksrTUNU?=
 =?utf-8?B?VkJpNHdyK05NU0FqbWpzbGtKekY2TzBSOXZZTFZyWm4wWU9WUHNnTDYwNFV5?=
 =?utf-8?Q?uS0N235minDKnMLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FED1E641A46CA43A1A5357269D7A3DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kq/9WsAzonINwTF/5l8TGckpk/1ESBCX3NH9LZ3nftOSfMiFyVWwcE4x0BxTHIiornDcT6j1gmSlySs+njTi4J+5jC+sqSmFnfcQ3WxX3r4a4+R2bon0hjbq+OnlDocrsk+efdLFbzl8tDJE5Wrxflci0yfsNggoAExkoC8T5NNTpe3q2qvaT50c5gLrLHaiKqydZgv/C5YUESkowLBZKY+rmrsdSgsYECpmOjNvP+HUoDEupdL2iHI8zVjGs5sX0fLxaFzLoEjBHIVMx7fvI8Y0vmU6ncieirBqUDa2HRN3iU4NKuPnJwZ7YK9rcbetANnUVLn3KR8WbJgZFlRvyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33161bd-7e8c-4443-924b-08def319b7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 17:48:11.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEGcXEUpsGRQED9xJiMbGisJ5QSQcG8U3m7J5nweaOFDk7pQHAA4XJJRK/nlT0cxHWBgyg2Ynk7HYGCi/8r7S19t8m0TTQNT7wTBh2j5NlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDA0OjI5IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gKy8q
DQo+ICsgKiBNYXBwaW5nIGJldHdlZW4gYSBURFggZ2xvYmFsIG1ldGFkYXRhIGZpZWxkIGFuZCB0
aGUgQyBtZW1iZXIgdGhhdA0KPiArICogaG9sZHMgaXRzIHZhbHVlLiBVc2UgVERfU1lTSU5GT19N
QVAoKSB0byBwb3B1bGF0ZSBlbnRyaWVzLg0KPiArICovDQo+ICtzdHJ1Y3QgdGR4X3N5c19maWVs
ZCB7DQo+ICsJdTY0IGZpZWxkX2lkOw0KPiArCXUxNiBvZmZzZXQ7DQo+ICsJdTjCoCBzaXplOw0K
DQpXZSBhcmUgc3VwcG9zZWQgdG8gYmUgYWJsZSB0byBleHRyYWN0IHRoZSBzaXplIGZyb20gdGhl
IGZpZWxkIGlkIHRvby4gV2UgY291bGQNCmxlYXZlIHRoZSBiaXRzIG91dCBvZiB0aGUgZmllbGQg
aWQgYW5kIGhhdmUgaXQgY29uc3RydWN0ZWQgb24gdGhlIGZseSwgb3Igd2UNCmNvdWxkIGRvIGEg
c3RhdGljIGFzc2VydCBiYXNlZCBvbiB0aGUgc2l6ZSBtYXRjaGluZyBiZXR3ZWVuIGZpZWxkIGlk
IHNpemUgYW5kDQpzdHJ1Y3Qgc2l6ZS4gSXQgZGVwZW5kcyBvbiBob3cgd2Ugd2FudCB0byBoYXZl
IHRoZSBmaWVsZCBpZHMgZGVmaW5lcyBJIGd1ZXNzLg0K
