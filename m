Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F017BCA;
	Fri, 26 Jun 2026 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432654; cv=fail; b=AZeCVfpw8RVn7e96fusWo4mLOv0zOdDZJpQGevRSNH8ciJihtPpU5TWG5//KWqTtLj4jHFlGgrN3pR4/hNrECwfayXLyvg2aHG+3X2d7gYTN6FVIBfo7UOqEmQrljlwQyf2l/QkLDbXzdK+ZVBjICNPSdbgX/4bQ2KOGpVBikI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432654; c=relaxed/simple;
	bh=+alEShlNYaNo5a9xqIyEMohZO4WbwrKTmQcOWPgQGwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qbyuFRDtfK7Eqt4HwNzVSAj9n5MGQ+Xtnr/16eyR+ztMIMVCuCGcmdx9sjR/q7MYxpYKFeo+aTx/SBBUCP3U81GNZhT6pzJuRPeRvGlW5IaqRjOzunymtJH7L7tsfd3iTvsjEZ9f+pwdXG1m8VqFut87FQl+gsVZ+2/PNI/l5rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHkDJ2nm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHkDJ2nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782432653; x=1813968653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+alEShlNYaNo5a9xqIyEMohZO4WbwrKTmQcOWPgQGwQ=;
  b=BHkDJ2nm/dbFQuYw7PjfQj00g2dtPWOrEoHgQcZ4EhiPkaXzM5qY0Zfn
   hatArAQi+ah1B4akIh8LBH37KBJx1VfjMJuLDe7WP/IzE8uaWuUaK+xDN
   FxvAg8mEzBjlCL1Ji6ZLa/7y1kOfh/NAwVy64fLX6sY55afOZrrJ3ZNpc
   sjtF6kV0DQ0c41nQy1fe/X9hqYPFt0fMoGlBYF6ianZfjUzF5n24J+oEb
   fqfGFTOkEeFi5z+mLcx1ooWCkfcxqhT5cjRw0oJyKj6yeR666Bt0QM8wB
   d+9r5lck6Cm4tuXJBtj8g8+EGEBVGrL9hNR7OSAp+GOZOkAPTHcLGb4UA
   g==;
X-CSE-ConnectionGUID: Q9yS6BhIRv+nJ7ipkk+Rcw==
X-CSE-MsgGUID: Yk1/f8KwR+y9HN2w4TKQoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83424664"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83424664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:10:52 -0700
X-CSE-ConnectionGUID: EUnQCloHQPeXuOWtOtrQ9A==
X-CSE-MsgGUID: QoawthHuQoO6KnGE/DH0vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="255595240"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 17:10:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:10:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 17:10:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 17:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UncLRTWrLZAJMXaBPDUN+qI0DyDCJ/r8TgsX7wBclvHovbVsvFbj9IbwEtywhWKZhTYxu4NHWchHHMfO9hozfT4QEMdzz9vq1ZQ/8aZTT6xocEx1mU5TsNFvkVPL0jLjVdzMHasS7IQz7x7mixLdAXax9kHMp9Tsm1Dg3xblfVRV2GJbBw2jemJ63tfCkdwrdsIuS36WlnvVj0Aqng/P+gXGV9C/9lJ8jGHrNp3QytnSHVURbKSgD60Hsdt6m0Wg94/tkjCI9in32ZTR8RntOHo25lSMdbDHTSvgXI1Yx35UMZPTH833L4bodLBxbqmnmkQ4qOnggsVWsO6N9uMmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+alEShlNYaNo5a9xqIyEMohZO4WbwrKTmQcOWPgQGwQ=;
 b=vkKDbzcoKagO5CsK00n+tUkGoXsWzOyLLpXQLItremue2OGYvpP+lMx/6y/Jr5dAUxNZLli6SlWU31hv1f1OqDhOa8bZS9gTNB/eqdKwbqZm53PlacU9/F+T475jzpKhdRwsZIsy4SvTVNeRDajRbn+hrj0BmNQMHisZRFJyaA941YHJK0292bf+ak0nViWncc93tMRQJwrPt+ZmQPLL5Ic9DxMB9vu8/8jzlmdhW3SfDCb5/kOcx2CaOQA9MnEV1plG/9KuNysc+ICFuC+9F2lh55swWst58sqdkXRWeb0rWyNfpKOH4aIDPMGjFVicQmmpgLkRISI2wEytCiHRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 00:10:49 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 00:10:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH 1/9] KVM: x86: Move the "APIC attention" macros from
 kvm_host.h => lapic.c
Thread-Topic: [PATCH 1/9] KVM: x86: Move the "APIC attention" macros from
 kvm_host.h => lapic.c
Thread-Index: AQHdBO6u9QldR5FGgUKNnRVwoIB0t7ZP9psA
Date: Fri, 26 Jun 2026 00:10:48 +0000
Message-ID: <4be83098ac73020458d6ca2f38f4a8fb8de9d4be.camel@intel.com>
References: <20260625220450.3354415-1-seanjc@google.com>
	 <20260625220450.3354415-2-seanjc@google.com>
In-Reply-To: <20260625220450.3354415-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH0PR11MB7614:EE_
x-ms-office365-filtering-correlation-id: b42263dc-edfd-4cc2-114b-08ded3176080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: hsEfG9vMaS0PST2RirPfLLtXP/1+VTl9OSlp8fDLyWGdYHVF7Spx50k0g7lsvYOvxZo8V70vMF1tOsJJ6/srueys7W5LrH6c4umYrg+qnf+mn9uCLVAvB8NM2zR7BEYc5qNG3+tUs6kNWfsXBZ8IXYjFgpfaVMrGW8Em7qLezhTwV5nrJyXsrLmNl/zl5wxWzTbF+GmjbBU1oxOXr5DNyCLV3XRFlMniLjo9Tfm3I4YVnQIBsSfT7PXkq0SF6BSkv0N1WplgRSvwviamAs81D5QYtnywXfPvJGbJoMQ+jBsb2LSCvIMltc7LR25M+7VTZlYMgFCPo+jOAu4VGT6sze7VolemSELduhJKwbPyLeYQ61YKswAXQlhZC84MQ0zJtFyeLI9e1scEjcyVQCZi4XMiixAGkItaEmlIQFujLhiJyTF39nggXGX0l0Cghr+wyj8+GSCFch3bzxJ4uI8pZpNKCcZAPLEbqV1Bfq0D2MSOUGkaQZhfl5tefZiGZ6EfhRxDLDYy1EJsQ2dRcim3GfvrUO8C79M9EfOk1D3xVPykXiVLsaENVnXEdBJSUL6f4/IZCsjkeysf3gOd4pdc2PaHCBpHfK2MyQn6nLlDsc1s5MNNH+dMzNrMoico5mvaATidlEAGXlSoDQti6LibTEJdf5fDiwhIb3bpz9WgBiaYh5x1CO65sIm3kA/G7BuwkKGt1pRL6oNQ3LuWtfgzAEt91pXPrsAX0Xd0Fe9D/DY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkV2TXVIYWJSdjdCaVZSeXBKbFB3dEJScG9KTG1wVFZrV2txQ1YxTWF4U29Y?=
 =?utf-8?B?NjZBbSs5TkNhTjNlNmRaYzdqdU55VHlzN2RaMkJNTjZYb042cDRHeW5Wd2FR?=
 =?utf-8?B?MmN2VXp6aythOHhNT0tlUUtCcG1iVXp3Vk4wYWZCOTRiQ3VTSVVxVDl2aG5Q?=
 =?utf-8?B?SEk1NW1OUjBTZDRwMW56eVNaZVd2TnBkNFN6NEVNUWdTOFNjSm1zd0tXWFh1?=
 =?utf-8?B?QWwvR1cwOTZDbEMrUTNja0lBaWFEVHBFdGpDYkZvR0o2YVZDOEpqWG1UclUv?=
 =?utf-8?B?YUhuUVp0dExxd0llNU9VUnJTNU5zb1E4TE51NGh3SEpMUzF4WEU0U3kvZzMr?=
 =?utf-8?B?dkFkeVRrZk5HQkhocTJEcXFLbEF6UzhIVzBGS2VSc3JPMTFSMDFGZ2l1QmdI?=
 =?utf-8?B?VzNKL1RpUDBpazBGTEd5RXB0NEJmYXc2Y0JYbFJNZWlFZ2pQUGJxWmZJdGNB?=
 =?utf-8?B?bXhNbXRPYy90eUY0NE9LdS9xRFZJb0pOaXQrT0Irc1p1eEJQemJadS93Wk93?=
 =?utf-8?B?N2RDMVp0VkpwTVhselRxdzhvTHR0eUI3TmNFNmZna2JwMXVQcnF6cnRvdS9Y?=
 =?utf-8?B?dy9pQ1kzbFl5eXcrT3YrbGdwa1hZYi96Tnpzcm5FYnVRMTFINDc3VEJrcUhW?=
 =?utf-8?B?NUl4M1BVR2U1TCs1VlNOUUo3dkIvamhOWGsxaVRTaUhuZzRHVWplRTVkNUZS?=
 =?utf-8?B?Zkc4ZGxhb0FIaTdVUHpjRTFKa3VJVkxhWGROdldQd1pjbFRzSWpoTWFGS1ZT?=
 =?utf-8?B?d2pFdFJ5NkpNdjZTa2RacHhZVEZXcEhPS1hDOGgrdnI3QXVwUjhQUU9rWE1C?=
 =?utf-8?B?N3NrMEFwS1VkMnNqZnZXdWNDekxZOEZIYXFibDNDV0c5T29jeHFlL1hNTzZJ?=
 =?utf-8?B?UDI2WkwzVEJncjhxSnRybEg2ZFdWdTJVUW0wV3M1MTZJUHZzOUJJbGlja2VC?=
 =?utf-8?B?d0hOeEpkZVByWE9LTjIyYjdad0JMQUE3WXltblgxelpobXdsRGs1YTFqcXJk?=
 =?utf-8?B?TkhxdTNqRWVrcENUVHlTdklpK0pueXFQNkROdlZhWVczOHhTcUZQaEl3ZzBN?=
 =?utf-8?B?cnhNYzJRWXU4QlgxbWpTbW9FYVBTUFhhSXdjT080bngxODk4dy9NYjVVdzRZ?=
 =?utf-8?B?VEhGT3o1bC9hZ1c3MjhjbE41V1Z3V0hCQk0wSmswYXE4c3lOZk1aUFd1RTdF?=
 =?utf-8?B?N29jbFZXVnMrazhrNE1pMkM4ZEhmS2x0di9kZFBnbWdiQjdHNUZTWXZBOER2?=
 =?utf-8?B?M3F4Q3JIb1IwMTNBYzJycEhnQjl5bm1VME84eERQQlU2M3hqaEkwd3doY1Va?=
 =?utf-8?B?UEZGdW0vV0lCOG1IbG5qTDRCMzR0OEgwTkU4ekd3VHZRNGwrME8yUnhZWXY5?=
 =?utf-8?B?QlR6NzQvYWxMNVQveGlqUko5UHdJV3h0YnlmQTQvUlRab2o5RngxWGhrcGJw?=
 =?utf-8?B?WlkwQ2E0NXROUkpIblA2Vzc3RWZFcW1nanl6Q2dBb2lKZWZXQ1h5aHpQNi93?=
 =?utf-8?B?dWJQb2NYQnBOTkNsK3hDSCs2MWZmTGxoMngxbFpWWmREelBRdkhjeHgxVk1N?=
 =?utf-8?B?UHk3UWRLdmpSUzdZSEVaNkFIMVNwV1ptbEs0dGt0dnViY05OeFV5QThZWlgr?=
 =?utf-8?B?bDc1NWhHSjlGVkJJUk9YREVUandBekpDaVpJSlBSRU12d09RK1BXNmFnTStV?=
 =?utf-8?B?Q0JwNGZVdXdDYjJuTzA5WFIycXk3cjRFMHlWZUJORUx2UWhVUFhTdGUvMzJU?=
 =?utf-8?B?ZCtuenFEelVrNHl0UURKa2VrNWsvZ0dmUGZZTzA0MUxDYzVDQUVRbEk0Rlc1?=
 =?utf-8?B?d1BxWHZKaSs2cFI2ZmtNRjRla1RxOWsyaXFVV1ZJQlBFUUVXY0ZLWTJGUkx3?=
 =?utf-8?B?MWJ3L20veWcrME8wdDVvZmFsN1BNZU94bGdhUUtiOGt2bmNJcHd5cHc5Nncw?=
 =?utf-8?B?WmFSOUxybHdBQ3J4TEltaDVNcHVrRHQ0TW02QjZQSDEzaUF5dlNTaUs4NVlU?=
 =?utf-8?B?SXBPdFBIbkJUVU9VSDl4SkdMZ1ZOVjZJV1BwelE2aWMzR3Bhc0FxTEFzeHh0?=
 =?utf-8?B?TjZHQ0gremt6MitPbC9uK0t5UmZ0YitneXg5TEFnNU9QZUliWkE2cmNGZUc5?=
 =?utf-8?B?RWlBK1JHLy9XNGFOZzl4OWF1Nyt0ZGQ2RHFBOEVKbWpYNlVBTG1YUERFYjVy?=
 =?utf-8?B?Y2g5T2RwOWlsNDRrc0JIVmlCeG9WdEc0QzhBYzc1bjlSWEdKMnlVMmZnWlNr?=
 =?utf-8?B?dy81YnZ1eVIzdW80SDhXRktzdDd0UEpacmRxdkJCNnd3aXJKNmVrd0EwSjJK?=
 =?utf-8?B?d2FTNVVXZ0RYU2YxOHN5VnNiY3EvWC81V3p5QUFESm1ad2djSXhZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2EEEEA55D246443A04F72695E458591@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V0m/1/TSkxsVCEaObludUxjkW9EYo8Fpckc41OhrBK8QNKtkkFU7vvZncJnWdHkxHLWzJnQRh0IBVGXcqOny3S9RuYX3ssOux74I/8Tx+bFT+1yjrxzRsVNqGE2aPFZsOHvcR2eUdsrLxf/B5+DKtwcmTxg8+xUrFSBgMmnNv+MmLD+aOwPimzGE9hfzU/mKt1I+940LwVAbS4gdAA7QCjy4Qz6kcz+J/IwNIlvmEMFGj3IO/+j0L3Am0tVWHK1ZLh7vZGL8ys15KpKVjEq5exrwvr3BMtSMQBT5j8qi87c8xcAqHQOxY+3GfcjjrqJ8DaXKknEA6E3Ylhz7OYdjvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42263dc-edfd-4cc2-114b-08ded3176080
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 00:10:48.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFUojQ8zMlRDnVsMrac/5mraoHYKKdYBwDN9U5hHu5hXwPAwZ4eWz1ZQEm0h4McxmrvKEclrt0g4ctnpPMb03g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBtYWNyb3MgdGhhdCBkZWZpbmUgdGhlIG1vc3RseS1vYnNvbGV0ZSBh
cGljX2F0dGVudGlvbiBiaXRzIGludG8NCj4gbGFwaWMuYywgYXMgdGhlIGdvcnkgZGV0YWlscyBv
ZiBQViBFT0lzIGFuZCB0aGUgcHJlLUFQSUN2IFRQUiBhY2NlbGVyYXRpb24NCj4gYXJlIDEwMCUg
aW50ZXJuYWwgdG8gS1ZNJ3MgbG9jYWwgQVBJQyBlbXVsYXRpb24uDQo+IA0KPiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3Bo
ZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpUaGUgY29kZSBtb3ZlbWVudCBMR1RNOg0KDQpS
ZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAg
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDEwIC0tLS0tLS0tLS0NCj4gIGFyY2gv
eDg2L2t2bS9sYXBpYy5jICAgICAgICAgICAgfCAxMCArKysrKysrKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oDQo+IGluZGV4IGI1MTcyNTdhNjMxNS4uOWJhOGFhNzM5ZjkzIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oDQo+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCj4gQEAgLTI5MCwxNiArMjkwLDYgQEAgZW51bSB4ODZf
aW50ZXJjZXB0X3N0YWdlOw0KPiAgI2RlZmluZSBQRkVSUl9QUklWQVRFX0FDQ0VTUyAgIEJJVF9V
TEwoNDkpDQo+ICAjZGVmaW5lIFBGRVJSX1NZTlRIRVRJQ19NQVNLICAgKFBGRVJSX0lNUExJQ0lU
X0FDQ0VTUyB8IFBGRVJSX1BSSVZBVEVfQUNDRVNTKQ0KPiAgDQo+IC0vKiBhcGljIGF0dGVudGlv
biBiaXRzICovDQo+IC0jZGVmaW5lIEtWTV9BUElDX0NIRUNLX1ZBUElDCTANCj4gLS8qDQo+IC0g
KiBUaGUgZm9sbG93aW5nIGJpdCBpcyBzZXQgd2l0aCBQVi1FT0ksIHVuc2V0IG9uIEVPSS4NCj4g
LSAqIFdlIGRldGVjdCBQVi1FT0kgY2hhbmdlcyBieSBndWVzdCBieSBjb21wYXJpbmcNCj4gLSAq
IHRoaXMgYml0IHdpdGggUFYtRU9JIGluIGd1ZXN0IG1lbW9yeS4NCj4gLSAqIFNlZSB0aGUgaW1w
bGVtZW50YXRpb24gaW4gYXBpY191cGRhdGVfcHZfZW9pLg0KPiAtICovDQo+IC0jZGVmaW5lIEtW
TV9BUElDX1BWX0VPSV9QRU5ESU5HCTENCj4gLQ0KPiANCg0KTml0Og0KDQonYXBpY191cGRhdGVf
cHZfZW9pJyBpcyBhIHR5cG8uICBBRkFJQ1QgaXQgZXZlbiBkaWRuJ3QgZXhpc3QgZWl0aGVyIHdo
ZW4gUFZfRU9JDQp3YXMgaW5pdGlhbGx5IGFkZGVkIGluIGNvbW1pdCBhZTdhMmEzZmI2ZjhiICgi
S1ZNOiBob3N0IHNpZGUgZm9yIGVvaQ0Kb3B0aW1pemF0aW9uIikuDQoNCkkgdGhpbmsgaXQncyBh
IHR5cG8gd2hpY2ggd2FzIGludHJvZHVjZWQgYnkgdGhhdCBjb21taXQsIGFuZCBteSBiZXN0IGd1
ZXNzaW5nIGlzDQp0aGUgY29ycmVjdCBvbmUgc2hvdWxkIGJlIGFwaWNfc3luY19wdl9lb2lfZnJv
bV9ndWVzdCgpLg0KDQpCdHcsIHRoZSBjb21tZW50IGlzbid0IGVhc3kgdG8gdW5kZXJzdGFuZCBl
aXRoZXIgSU1ITy4gIE1heWJlIGp1c3QgZGVsZXRlIGl0IChpbg0KYW5vdGhlciBwYXRjaCBwZXJo
YXBzLCBpZiBpdCdzIHdvcnRoKT8NCg==
