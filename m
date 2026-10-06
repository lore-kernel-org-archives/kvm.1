Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A54DF4DC;
	Tue,  6 Oct 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329248; cv=fail; b=MwN6iWBqWvdxHWcByAzo0EdfZAHPiR2CIIXaNY1gZKY5OG+H+v3mbVMv9uPLf06/mKhk8n+jMTe38tt55OW4q7ScdrKvAzGWlau3TCPcbJRegxaKTK2uNgIMGWpU04kDPe+NYI1RekeRk3FVJb37UAqy2dcTJ3cxyWhKRGxnxFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329248; c=relaxed/simple;
	bh=owooq9ajEZhbDPAgoJlomlrWekfd+ehMsqrHWi7zqrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3hw5vCyznLC3KOEFVPFUqVCqtDPutamXUkN/HyuTBXGuzRC018tOjE3DuNexqUGrNmH+HYCfHmkMcdP94SLZARrDPE5ZlMo+JCOwwogHcwdIsEp/tEL9HKIvBOfUygYA9So4XXSX92pOg5NxOaz73SdHZqJMCzEWOdZd+7Niw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbESrYCR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbESrYCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791329241; x=1822865241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=owooq9ajEZhbDPAgoJlomlrWekfd+ehMsqrHWi7zqrk=;
  b=dbESrYCRJ7hrK8FcqvnH2tv6qYgTUhHC5mpLVRjeHOotlM0SS6TNygwF
   X+SG1DWNeEKzK6S/qR9a4d0AtV5CHVqKfYU9U+Sg+UAdmAozeuJhTxl9/
   jCmpgOSwysrCNeut3G+A5zisFcJ6AwAeOjlEB8yqzlANTcutfZBQdCV8P
   KHhm+n/IuwsN4JgFFj4R9zDRdk1A4k2KlHpC1TCEMe/ZqH/lUmXYeFKD0
   UbO8N2r0DkFpLnoQK5vefi4IBXQGpx2U0CxaEzUuqdeBgBXmyHq8L5cOp
   LTWX/TEsa5dN7DDQJpALiV4m5XDaABpBnWuzKk5YM9QmU9g8kW9swh6b6
   Q==;
X-CSE-ConnectionGUID: /aWgBPn6Txme5EVtAxGumA==
X-CSE-MsgGUID: NtaWOIlBQtiUWDIL2jC8Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="77058"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="77058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 16:27:20 -0700
X-CSE-ConnectionGUID: HdGs9jNAQ5WXU6ll54E02w==
X-CSE-MsgGUID: qmKfNI8RSH+MgpPiw5dfRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="315313775"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 16:27:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 16:27:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 16:27:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 16:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aytnE/o4hJfZfeKmunBYUloiygk+1fnmbGmlkq5LqvRv0L2xusJS1PaKnzIGLYhk2H6Lpdfw7tmiKankBN2WTtDAubzozBz8wESNQnjmoI0lCM0JO02ZtGGkYdvoejXR7/VgkJxL9jh9xe1I2jHuAKrD5x/uKVf3rH8N62XkCQfhKPbwn4tQ4JBYcB45vxL9gmJ4gB3l1o0+L2u268r2b9O8EzblyROO9qjMgyfVJ4FvQ8/yrgGtv5CZcbqZD2rJmNJ0mfHWyTXeErPrPtM57jWVYGYfamd5R7Vzua8QQObsU7UcxbZxrKebCDto4FHADJdJ2lj4d+Iqa2ajEiVMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owooq9ajEZhbDPAgoJlomlrWekfd+ehMsqrHWi7zqrk=;
 b=irEXaDYFuYodcqCZP0b8Lo3OVOhz/p6IRht30yRVCFrbfWsDH1qyFoF29mMn5mKUOpyJmxWqppwAN0I28V7KrcWMKgayg0Qpb7TSRCVtaZqIMYUVXUs6UtpNAIf5r18PUs7ipwfWwkUCv5RDAh+gQ1+WFcGgbwrrEa5afn7IuE1v/dRaw82uw8qJRigb8ZcxJAxFeSnEF0h12rWK3Nur1IRONSXzXVH5lQFrbiYl1/n7xtQwvei3Iy0zdLQyVjk/CK2KTxGtQP1xq6DtohR8QuNVE96SgO+PTaebxgvbMy11F+Xlw0y36Iz1Rv9tctAqH7xMZ4sQJWdxWezMtgT45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 23:27:14 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 23:27:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v3 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Topic: [PATCH v3 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Thread-Index: AQHdVPFilq+JkpGKOEi/DbgseSFZrLbxKouA
Date: Tue, 6 Oct 2026 23:27:14 +0000
Message-ID: <b432780c42813f6d44f273f3661e23e79256deab.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-1-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-1-db52cb05b918@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW3PR11MB4572:EE_
x-ms-office365-filtering-correlation-id: 9ae91e31-87b6-4e03-82ea-08df24015a8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: d6WQCO/EGakrZEmhwY1CnkgDTi+1snQ5YDPCln3bx7lesuTvPggCYtPWi+ge0wE+GHHt8I6oFv/ma4zm+PGOqXqEGSV+fktN2SBWpGTJpTBncwziMjf25tA3/nA2EXjmi9S6pTsuMvteFXPtpvSnJ+6xh9s/B0tcUNaG8niFwCmNfhDvesTz8PIy19zIea9Vsg80s8meyjQjDCvTmDJ8Mn1jEkt8uuu4IzNP7Ji1eJKTsZAwzOCNZKwP9lKvAWZF9VtCGiOow7TYGBRzL9gYbbqS+hSn5TmeVBy4WfNETUB4gM+jdc7Ff+Kzq6KPF8yQUNdGyykZ2fWJj8eXqJ13nQdx6w3hBpD19ZY3eR/rsL2eL+fAG916FjlS6bgN+3RuCigQtDk8WItCuYrj+Lu6BZhRs0cPAhpY52Nn4mmCiLcxwjuUUIjiVb43dJpnP/8cpPbv7p+gL5gWT/q9vOI+Vro7SaFe3hZ08M5BLT1PNFFCJNo8cQPu8jf7c1QELlSQIujDQiPGsU6imNei0iHIPzYICUW2nu8dPlcXsMq9l4YYc2QQmTlMbPzSdTOdIREuzUT9iNLffdvSgxZ4VhcMptSCP/kr6sOilEGGXKELkdGUXQhEUAUnppf4F3+z67+akR8DmQCw8V1Y4rCI4s7w0D1zftZyuuFbIBumGB0Jlw6ZbW8S6LW+uO2gmOXbpf38BYITwEuP/U1/7+5AxgJeUjdRipG0UypgKMiOLRHFG20=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFuSWlQRkRWMWtsTlp6OFZlaERSZUlZcTdscWRCd2g4SEN1NWdpWW9aWmox?=
 =?utf-8?B?UEh4N1ovV0F6QUV1YlZ6eDhTYkx0eUcrSllnVGhNYVNEMEVIM2pBaGFoU3Y3?=
 =?utf-8?B?eElXNEFkQ2NSdEd1aEVwclcxdGRyOTNnS3ZJaGRNR0pMeUg3K1dVN21IYWhr?=
 =?utf-8?B?WTNLY0JYM3ByRGFocW9Vd00xZmoxT2xSVlVDVjRRSEh0cithQnhUUEpPaXZM?=
 =?utf-8?B?TGlCVUJpRWx6aGhHUHFYMStqRGxuakw1YjZBQmFsZ1NyajJFYnBnOVNKOU5u?=
 =?utf-8?B?VkwwMVhkNjVNbjlzcGNNN0hnYWVJYnIwQm44YnhMRUR5Y1lVTjhqSURaU1BM?=
 =?utf-8?B?bUpLcWsvRDBSNDVJMEo3MHN6YmY0NFZnQm5sVHNldC83blRVUUd6M2hHU0FN?=
 =?utf-8?B?MFpXVVpSaFZ2c3BSdnYyTm9GWisxU1JnenAyVWNjZTJIb0Y1OXFkdEpNeVMx?=
 =?utf-8?B?cDEzOXRSRFRmT1JyNzFzOVRYWVN0T2taZ1laa3lQeUF4QU9QRUtmUDJ6UHlE?=
 =?utf-8?B?aDUySzFucjdUMHZySjYrNCt5RzJ3Q3FMUEwvMDZ6b2s3SGoveVNyRjhrVUI4?=
 =?utf-8?B?N3FET25Wb1EzbVQycXBHQ2l0am9ib1pFZ01JSFlGK3JTOXFXbHh1d0ZqZHBO?=
 =?utf-8?B?bkxyT1F2RWFuSDRicGNWNEFNaGZBYWdnVm5iRWVwUUJqZktNOTc5NHg4Y25I?=
 =?utf-8?B?WEN2QVczUmN1OXRoR2R1TUVhK00rWGhaSmRweTlkT1M0MTR3R0kyVElaWnhp?=
 =?utf-8?B?bkFDRWpzWEhFZXI3ZUhGc2g2T0ZidXMyNmNlTmNsZnFGQjY3K1FBa2pzTCtC?=
 =?utf-8?B?ZEJFMkdUTGdXWUd3ZUdRY1c1bVgzUVJzZTZyUUdRUW84YUsrN2JkaWgrdWVF?=
 =?utf-8?B?aS9wbnAybnZKaFFRSlppbzBrU3VSSi8ydzN5OXhPZjd1UTVPU3ZjZGpReEhn?=
 =?utf-8?B?MWNBeFkyYUpSTEJZdThIU2tzSWIyRVpQZVdDTFVNRVJwZnphY2tnMks1Unph?=
 =?utf-8?B?YUhTa3F4NzBkWHl5UDA0YXVsUncwOWJNRVlmRWFRV3o4Q0g5UHY4YThwemRh?=
 =?utf-8?B?dzFFQ0w4TS9xS09iajg2dEt2N0c0bHNOelBibC8rT0ZYOG53QnV0c1NvbEla?=
 =?utf-8?B?aE00TERLZU40c0UxNXpiQVlzc3V6cVphdG82eldXQjBGWkVGZWVqRksva2pn?=
 =?utf-8?B?eWJIaldSL2tkOTdlbm4ycWhZSzZxcGdybDU1bHlTOGhLa2xCaG9laDJDVW5B?=
 =?utf-8?B?dkJ0YnVqU0pQeW0zcmxaRzE3SFRFMG5YSlhoaTYxNVJlSHFmMCtHTU90Mysy?=
 =?utf-8?B?Z2xldVhwUmlRajBvbDRmUnFXOUF2U3NMZHVpMXBwY2hTbXhneWNZTzJia0M2?=
 =?utf-8?B?TGVHOWI1Qjd2V2dPT08xTlBkcGpVL3JzYUFSRU9rSk1mcWJQNnYxa09rc2t2?=
 =?utf-8?B?U2V3YWtiZkJGYUpFSWt6ZjJDYjkvWHpYVmREUFhoSWo1RXNmQmxBU0dLQ0dy?=
 =?utf-8?B?aytrWUFvNmFIdVp5dnQvQ1QvTi9menowYitFaDBURThJUkp6Sy9zYUhLdGRo?=
 =?utf-8?B?d09IYlV6UCsxYmNnemtVLy9nYTFxYkhXOWFqaTRSZ1oxOVh0RFlCRndqVXVk?=
 =?utf-8?B?V3BKOFBDd0QvVWZndDFBaXJyV3NYcU1mM0xLVnUxM2NxeHJ4VWpIWmlTT0RD?=
 =?utf-8?B?SVNaREZMbXBpaHJ2ZVozczBPODFvVzMwUmM4cDZvenpuMGNLWFVsL2pDK3FI?=
 =?utf-8?B?L3k2RTRvcTFvOHZ6ZWpTcllwd01MR2Z6alc4aWJ1R0YzY2lPUGNIUXltT29i?=
 =?utf-8?B?T1ZFemFjeThISDc3V0JjVXl3QXgydzdqVVVDNkJaWVRTN1FHb3NuR0ZtZ2hH?=
 =?utf-8?B?cXlEOVFzUnhWOEplZjJPRHI3UEQ4Nys2MjVpcmpkUFpYNWlkWXd2OUdlY3hL?=
 =?utf-8?B?d0JqVDZuS3BpeWpOanlIVGJLUVk5V2dYZ2lGZ2UvVTAzNEJNY0wyVklRNW9p?=
 =?utf-8?B?ZmRQcVVXYW5uYXU0NitmUDV1dlgxTDgvbUFBcjZCeHoyV013RkZlUTZIL2Nn?=
 =?utf-8?B?aGVSdUFFVHhrSTdGTEUvWXUxMnZaakRrWjhpbitLaGsxeTg4NTZ1SExaRGoz?=
 =?utf-8?B?Y3hjeHppT3BXRU1jUUVCZXVpQWsraGpLelNDQnlZYTZEeldCeFZwNkpMQStr?=
 =?utf-8?B?T09QakNHbHl5YnVMZU0vTnZ3OUVhVnRVTzJBaVNodDk1UjJKMnEvOGo4THlx?=
 =?utf-8?B?TUt1aTNxa0hHWStqdkl2NmNHMzhSSGN2am5pZnhadFQzTCt2b0YycjJxWGtk?=
 =?utf-8?B?TzhGenNLV1IxK1psQXNBUDYyNXRiUlBaZ3FBNDlWbHpIa05CQTF3ZjFHZXhm?=
 =?utf-8?Q?qnYFEab99Q5hUksg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E81C769B319E64DB9C60E405727FE10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0VdVNiCvOzXvNjfjhZUwAPCrZu5snLn0qGYQNE4imRhaF5CJuYuiLA7ZkxXbz4a+0G0NiIS1sy9aTup57z99JHMHiwLLjasPDXOFftynoHwWovOLKC79jrfODlGCaxfsNKd7EBkfLRSvk1DOtqFlmf9EeU1q1hZO4kDYcBUzugiaYjWZKUmoZHaCh4JEJBNP3KPq/MH/WtJqx6AC4KN3plByCyNSh3yX1kKoJkyzVvm+PEixVOd8GIK5jCPeRJ5VtvlbPfdGdruFrImQuX7IRgF3IBUjK0knJAPgtENVBMIzvHfgkPuSBfzkux5rBjXtps0IV5Cl6wUOjgENhPBU3g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae91e31-87b6-4e03-82ea-08df24015a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 23:27:14.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USSTOwPYwMNrMOW1cT76pKX7fMwLbznzhksZzCjRuygIvYGr3KlurWxf6qjEvofN0QL95A457fWsNzzrVFtb4MN3xg64CjWlant8qF3kxuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDAxOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSW4g
TGludXgswqANCj4gDQoNCktpbmQgb2Ygb2J2aW91c2x5IHRoZSB0b3BpYyBhdCBoYW5kLi4uDQoN
Cj4gU0VBTUNBTEwgd3JhcHBlcnMgYXJlIGludHJvZHVjZWQgdG8gYXZvaWQgYnJvYWQgU0VBTUNB
TEwNCj4gYWNjZXNzIGJ5IGV4cG9zaW5nIG9ubHkgYSBzZWxlY3Rpb24gb2YgU0VBTUNBTEwgbGVh
ZnMsIGJ1dCBhbHNvIHRvDQo+IGFic3RyYWN0IHRoZSBTRUFNQ0FMTCByZWdpc3RlciBBQklzLiBU
aGUgYWJzdHJhY3Rpb24gaW1wcm92ZXMNCj4gcmVhZGFiaWxpdHkgYW5kIHJldXNlIGZvciBTRUFN
Q0FMTCBsZWFmcyB0aGF0IGFyZSBjYWxsZWQgbXVsdGlwbGUgdGltZXMuDQo+IA0KPiBTb21lIFNF
QU1DQUxMIGxlYWZzIGFyZSBub3QgZXhwbGljaXRseSB3cmFwcGVkIGJlY2F1c2UgdGhlIGxldmVs
IG9mIFREWA0KPiBBQkkgZGV0YWlscyBuZWVkZWQgdG8gcGVyZm9ybSB0aGUgY2FsbCBpcyBsb3cg
ZW5vdWdoIHRvIGZsb3cgd2VsbCB3aXRoDQo+IHRoZSBjYWxsaW5nIGNvZGUuDQo+IA0KPiBGb3Ig
c29tZSBvZiB0aGUgY3VycmVudGx5IHVud3JhcHBlZCBTRUFNQ0FMTCBsZWFmcywgdGhlIFREWCBh
cmNoaXRlY3R1cmUNCj4gaGFzIGV2b2x2ZWQgdGhlIEFCSSB0byBpbnRyb2R1Y2UgbmV3IGxlYWYg
dmVyc2lvbnMuIFRoZSBob3N0IGNhbiBzZWxlY3QNCj4gdGhlIHZlcnNpb24gdG8gY2FsbCBiYXNl
ZCBvbiB3aGF0IGlzIHN1cHBvcnRlZCBieSB0aGUgbG9hZGVkIFREWCBtb2R1bGUuDQo+IFdoZW4g
ZnV0dXJlIGtlcm5lbCBpbXBsZW1lbnRzIHRoaXMgdmVyc2lvbiBzZWxlY3Rpb24sIG1vcmUgQUJJ
IGRldGFpbHMNCj4gd2lsbCBsZWFrIGludG8gdGhlIHN1cnJvdW5kaW5nIGNhbGxlciBjb2RlLCB3
aGljaCBkZWNyZWFzZXMgdGhlDQo+IHJlYWRhYmlsaXR5IG9mIHRoZSBjYWxsZXIgbG9naWMuIFRv
IGtlZXAgdGhlIEFCSSBkZXRhaWxzIGNvbnRhaW5lZCwgbW92ZQ0KPiB0aGUgU0VBTUNBTEwgbGVh
ZiB0aGF0IHdpbGwgbmVlZCB2ZXJzaW9uIHNlbGVjdGlvbiBpbnRvIGEgd3JhcHBlci4NCj4gDQo+
IFdoZW4gZGVmaW5pbmcgdGhlIHdyYXBwZXIsIHRoZSBjbGVhbmVzdCBzZXBhcmF0aW9uIHdvdWxk
IGJlIHRvIGhhdmUNCj4ga2VybmVsIGRhdGEgdHlwZXMgZm9yIHRoZSBTRUFNQ0FMTCB3cmFwcGVy
IGFyZ3VtZW50cywgYW5kIGhhdmUgdGhlbQ0KPiBtYXJzaGFsZWQgaW50byBTRUFNQ0FMTCBsZWFm
IEFCSSB0eXBlcyAob2Z0ZW4gdTY0cykgaW5zaWRlIHRoZSB3cmFwcGVyLg0KPiBUaGlzIHdvcmtz
IGZvciBtYW55IFNFQU1DQUxMIGxlYWZzIGJ1dCBiZWNvbWVzIGN1bWJlcnNvbWUgd2hlbiB0aGUN
Cj4gcmVnaXN0ZXIgQUJJIHR5cGUgaXMgYSBwaHlzaWNhbCBhZGRyZXNzIHdoaWNoIHBvaW50cyB0
byBhIGJ1ZmZlciBmb3IgYW4NCj4gaW4tbWVtb3J5IEFCSS4gSWYgdGhlIFNFQU1DQUxMIHdyYXBw
ZXIgb25seSBhY2NlcHRzIGtlcm5lbCBkYXRhIHR5cGVzLA0KPiBpdCBtYXkgbmVlZCBkdXBsaWNh
dGUgYnVmZmVyIGFsbG9jYXRpb24gYW5kIGNvcGllcyB0byBtYXRjaCB0aGUNCj4gaW4tbWVtb3J5
IEFCSS4gQW5vdGhlciBzb2x1dGlvbiBpcyB0byBkZWZpbmUgYSBuYW1lZCBoZWxwZXIgc3RydWN0
dXJlDQo+IHRoYXQgbWlycm9ycyB0aGUgaW4tbWVtb3J5IEFCSSwgcG9wdWxhdGUgaXQgaW4gYSBz
ZXBhcmF0ZSBmbG93LCB0aGVuDQo+IHBhc3MgaXQgdG8gdGhlIFNFQU1DQUxMIHdyYXBwZXIuIHN0
cnVjdCBzZWFtbGRyX3BhcmFtcyBpcyBhbiBleGlzdGluZw0KPiBleGFtcGxlIG9mIHRoaXMgcGF0
dGVybi4NCj4gDQo+IFRESC5TWVMuQ09ORklHIHJlcXVpcmVzIGEgbGlzdCBvZiBURE1SIGluZm9y
bWF0aW9uIGluIHRoZSBmb3JtIG9mIGEgUEENCj4gYXJyYXkuIFRoZSBQQSBhcnJheSBpcyB0aGUg
aW4tbWVtb3J5IEFCSS4gQ3JlYXRlIGEgc3RydWN0dXJlIGZvciB0aGUgUEENCj4gYXJyYXksIHVz
ZSBpdCBhcyB0aGUgYXJndW1lbnQgd2hlbiBjcmVhdGluZyB0aGUgd3JhcHBlciBmb3INCj4gVERI
LlNZUy5DT05GSUcuDQo+IA0KPiBGb3IgcmVhZGFiaWxpdHksIGFkanVzdCBhIGJpdCBvZiB0aGUg
ZXhpc3RpbmcgUEEgYXJyYXkgc2l6ZSBjYWxjdWxhdGlvbjoNCj4gdXNlIHRoZSBuZXcgUEEgYXJy
YXkgc3RydWN0dXJlJ3MgZWxlbWVudCB0eXBlIGluc3RlYWQgb2YgaGFyZGNvZGluZyB1NjQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0K
PiBSZXZpZXdlZC1ieTogTmlrb2xheSBCb3Jpc292IDxuaWsuYm9yaXNvdkBzdXNlLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwu
Y29tPg0K
