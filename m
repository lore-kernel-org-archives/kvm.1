Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE045223707;
	Tue, 14 Jul 2026 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000783; cv=fail; b=elbzieeEa1irW9ci5TuBX+rmNo5Ex0sO+5x/7iGPyUTGZwcdW/weDOAwdqOnXWb4hTeKflfT7sM/cbRK+c85nVS3JcvbhexsgWkbKB/SGViHF4TFaQCkeqzdH1sEN/LSIFiXd2QLiLLbKoVGFpe05XxgDYIOBXgidR783Qw/jpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000783; c=relaxed/simple;
	bh=YrValIXcLoyoLV/guz0LKqu69eJ3LHtgOyDMrD3lDFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSbbA4VOQowtBoNeVgzkXbaP3mHiLRuEmeJ8wTcfbNnDcfGk6eNbjGaJs4DcDa0J7SIYenokBJ8HicLYVBaRkKI0GVKDDqxSo4Z9Cfjv0uTRSJaQMwe0MvQ7rbn8YB781JhRAcCTtwDhpXqv6TIWd/s/gOBb7BTfaP0275nqXHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l56M6eu0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l56M6eu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784000782; x=1815536782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YrValIXcLoyoLV/guz0LKqu69eJ3LHtgOyDMrD3lDFg=;
  b=l56M6eu0/cE9fPhefsISUlb2hBwDJrnKGZh9rkLzzLkPHiL0VpLFGqgW
   xjonbESbioaMgGvWglpEQP/bBhJ/w5whZg8O6g99mbp+SMV/UxZEjmE61
   KiwEXuJwunP0Y739Kx58yXiAVu3g9dNS4e5U1A4vB9Mjf9xnPgGSxtzGV
   yog9BTxUAilRypk3Zii1VELVrDXisu2hNpH27JGXPOJBvdQsnsbtiGFii
   Nnab6+iozc/K9ZFQCxYXhlgKstRC55oRkBTkQPUEynOb5tTDA7+qW8iCF
   2GIzofVXouPOVTgVm/sJLFzJh7YoHEDikXu/JmNUMKpJBRrlvf9YAhugD
   Q==;
X-CSE-ConnectionGUID: 6OXbHTe3ThikKjoOvHpY/A==
X-CSE-MsgGUID: QS+Jq4BQRCG00N0GzIVQkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88437665"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88437665"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 20:46:21 -0700
X-CSE-ConnectionGUID: IkZNs8wNSvCGbMGkkMyeig==
X-CSE-MsgGUID: 504qVZ7QRw6vIhymYnVSgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285818415"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 20:46:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 20:46:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 20:46:20 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 20:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py4XKA6p2uvArgOOXAjvw8UJYyAuwOm40WCBC9iYlkh1qAT2lwHe64EYWbb94v7aa+xuVQZoCUJOj2jcU4KGckOXVXBK+ZNb9HFwp+6uc+jLDK+eMBlMmYUdrLtaVASyTgfJkLRZw+zH6W6HT243D0+JeQI4dKCNYVes/TsLI3qQW9+IQcc9XWI74QkyxqN/GE3YcajOkUJ4AlDnhaH6iYDg9kR6Fk0lhVfcC6SjwEHY1Rzw/OMoyKdHcKOd4CV76P0jU9BxVDA3jbt9USIJ0k1Wj7ZqOo1+SutKt22Aljl4s37zHPXAZCkXJy0KZW2Fbvgsp+h+uZDU7RZzW+gfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrValIXcLoyoLV/guz0LKqu69eJ3LHtgOyDMrD3lDFg=;
 b=klmI4rvlg0J9Ui8bs8DCBK1+PjMyYL83rLpwSlUoDca5Zb5SAUbXF3go2bJGY7zgQBK+/1YdxqSeA+JVlLx/v5LLO0MIZNdqG/vPJlIjhxASDHr3f3ueTxthzpjAVNd6XUEnjqD6Eu7N3KmIQtZAiwfKIjc3WBrVZLOJ4HKqLtnXogEYE6X23m3GSTIGLX+FerE9LpG/IIMeYVfBA2uHXt8iIroAHgyH9PGEYSpdeCAcraM84+HoqXNvV3LgFNeycgisLGY7ImoQxxoS84uEavLgzVeCM+6/cvzgA5ABszDemKojMB6tB1p/6ZTlomPbR94aonP90lHdvSFuysiDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Tue, 14 Jul 2026 03:46:17 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 03:46:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
Thread-Topic: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
Thread-Index: AQHdCM+cWIGqxO6+dkexRQML9xUBn7ZsdQMA
Date: Tue, 14 Jul 2026 03:46:16 +0000
Message-ID: <6d8588f8fb1b68fee59d4a0c8cfcfd7a58d25f79.camel@intel.com>
References: <20260630202828.440724-1-seanjc@google.com>
	 <20260630202828.440724-2-seanjc@google.com>
In-Reply-To: <20260630202828.440724-2-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|PH7PR11MB6029:EE_
x-ms-office365-filtering-correlation-id: df0d7edf-20d2-480e-a252-08dee15a75a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 9ozx5wO21kylqDH0IJ2PS7KvKEFS70zPRPs50UHARWfW0fqODJSsmtNt8mVybG1kWsLzut37kvBf1sRMvpK+ZwXAENp37BhLpTre6AfQ5rGjv6e/MB8fNY8Zf2iidGV6ctMXexjZpzQQhs8XQ3RoqO6df28Qnz466lMOJggXZrJ4cHFOm0RcwlxtIFNoVptFPuz3Cjh/kbM3e6PzNfcu+rnaXnnnqy5j2C2sujU8wV8gtSBRVEvM5T+uJp4K9avWbk4Iz9zA2rqvvMwstW/UB+92GGiybI6SV95vZgnJf2rb53y7Xg+uyZvxrhRCmdVaRKWpQ8apm6qoZo8gG19mGqflmd1My/9f1GZG5vgc0x4G7yStLtmAFLws7EY9ogLrlu+tpOQCKzUe/HgW1iKMglca4AC5FHoFEGtXUN/4fbB2In70mdSPiCHnyMfrZMtYZWQfl6mK6o5pfF/4LEQfkZJPTJ1YucYbOgRJSaN7hx3nwm1kRIVEDaC/XtWPd/8YxXxMX9lNTG7nPf1d7/mDdNG50eWj3qdFc7KQ9A7dYcgevR4O8Fhkh8A5fiw4lrUB6f7dBENZ7zo88/M0urMUepg8wB2tQrkY/jf0aXD72jVjfyWaWH919zKd2cX+F0uSIjCvqI+8UEfdA+PuiygeUSqnmyEsgomr2XbZULpPN6pYt5QW3jZBUsI5YW6mGRHJyBIKtDWx1yvJNnd6XGBYqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJkRWtYWEN1RjlOWEYzRzBGcEw0OWJ1QjJCcFY0T1BqOWV1UG9BaHBaR0R4?=
 =?utf-8?B?YUVINk1oOWYzcmx5cmpEa0pLdFRIdW9HOWp6cDc4UjNiQlRuTmlRT2pqMm1q?=
 =?utf-8?B?aVBzK0M5UVpKbDQ4dXRaV0duWk1OSi9sYXZ3aTA2aGtqTGlvbU9kZTNidXcy?=
 =?utf-8?B?YUsxUkhVYzFISUxSWlBOQUhZS05SNXdxS2grNi9lMm9pMEU4VXRIdzBMTFMx?=
 =?utf-8?B?eTNjZEhUcGd2d21adCtnNk9tME4vZjdWUENWYWJjYUxXQXVnY1IrM3BqMkVW?=
 =?utf-8?B?eGJHM24vU1BxeDV3dGFzVGVlSE1zS25MRWpZUlJtQXhFUVJZYmhoVzZ3cS9V?=
 =?utf-8?B?dUVscTlycytrQnczbVhsUGIxcndEWFNFcm94d2Fod3lQWTMvMHdDZlRIeDZE?=
 =?utf-8?B?OTdoUjc2c1Q0M21SYml1cmgwdkRIdWF0Vk9RLzZ4bE8ycWNvK1lNS284dG1H?=
 =?utf-8?B?S2gvUTdieW5DRTY1cjJMS3JlTThqQmVGZXlNRVJBSnpKOWZERGMyUGRNYVhF?=
 =?utf-8?B?L0l1bHhLM21yM2ZYd0lZMVJNN0hZWEpEcWpiaUI2dGpodXdSa2VEWXhyUDFs?=
 =?utf-8?B?SklaeUhZZ2FFcS9QRzIrRm1QQlUzNWxRajJCNnNMRUJ5SUcwSk9HZ2wxcW9p?=
 =?utf-8?B?ME9YWDZmY0M1bzhPTDIvRkg2bzdLQVROQ053SU9xL2dxK000d1RVdVRFVjFy?=
 =?utf-8?B?TFFoVXZvZU8vUUoyMVRSVEVDMjBmVno0UnlVUkhUWUh3ck5GbFIwMXBHYm94?=
 =?utf-8?B?d1Y0NExqYnlqSlBrNmtaek9peUN5dXpLT2VPUk4yUzEwSUEwM24raGJMaElU?=
 =?utf-8?B?cUpDNWFXdlFsSGtKREo0K1RrRzZ2V3BkWC9kdDFYN1ZTS2JJLzRraFNubHdO?=
 =?utf-8?B?T1lLVDlIT3ZReVdJd2ZpUEhlSGdqbGl2bDcxakYxT1JoTUpwejU1M24zNU15?=
 =?utf-8?B?V3NZY3NZVjdxNnFBa0ZDck1HZWVRN0Qwc1I4bWRFVjN1QjZCcVU0cjFNS0JR?=
 =?utf-8?B?RHA1aVl0SjFkc2haYk5RS0RHV2ptdjkvbHo1MDRZempFS0hZWnF2Yml5Y3Aw?=
 =?utf-8?B?QzFuR1V4bDh4SnRCRnhjRDRVeDFQSUhXd2pkNE50cTN2enBQMDVRbDliSkcx?=
 =?utf-8?B?N3JMWld6NVJHZnNWNUo2c1NVTDlVMy93c2dQOGs0U3h2ZlBkMUZzNFFONUZV?=
 =?utf-8?B?OGpBSmtBK0NTRzl3OFlKdDk0MDhQdU4vQ05OM0ZRWUIwZ0xrVVNsaUJiT3Fq?=
 =?utf-8?B?bS9uM2tJY3czMDZJK1ZDakRjcXBHMlhwRm0xUzlYSGVkcXowWndlenZsQkIv?=
 =?utf-8?B?bktWZ04vYzBKNzNxakdNbVMxZWZJTE82ZHBJRW5lV1Vlb2pNTktjLzFCRitB?=
 =?utf-8?B?THBsaUN2WVhqQmNaN1lNbGRzWS8zOUNEMHRuVHNsdkxPU3FydHU2eFMzOGFk?=
 =?utf-8?B?VFNHdEFoZ3QxdDdLRDlWdngzcFhScjBXRVlwM1J4VU5BbGQ2NzhNS01ZNk9k?=
 =?utf-8?B?Y3NIQldxWXdteXVpdi9IYTAwSkxNTWdrbDRyQUYzRHN6NVNiVzZ3cDRrRHln?=
 =?utf-8?B?aERVdkN4VkxoMHZ3MDIvMlVNMFIzalBIOTBLTlBOOWlQNXJDMHpPbk42QVFK?=
 =?utf-8?B?eFZxa0lUeFFqS1ZuZHhKZCtDeXA5NEJBWWxDdTErSnNtUDlLbGVPcG8ycDVS?=
 =?utf-8?B?V2NGSVE4ZCtMNDV0clE3VURnbXNkSEp0SE9BbjhDaGYzdUE0bk9XNC91bEdI?=
 =?utf-8?B?OThCQTk4V0JpOU81eDNtVUNHLzhLejFEckVRak5zOW9zUExWVFhkbmUyS21W?=
 =?utf-8?B?N2tCTlJkTmZwRU1Pcm9nWlJlUlljdXlRc2JyVXl3S0QxY2tQeXJjcFNzTG5a?=
 =?utf-8?B?OU9kcXFDWTkza1ZaSWxzN2lMOUJpQ0kxRTBWdGxSQldhSHF5NE5vTFBCSmN2?=
 =?utf-8?B?ZnZYa1dKK0VHeVJSZWRvK25NZlc1N3RpUTF4RUExcHdhaTNPTzltQTlYNTFD?=
 =?utf-8?B?MS9kYmZUWGlaUnAxMFFGVzRSMFZvYm1WR1ZTT2Fia3RGc1NhMC9uSTh4YVBm?=
 =?utf-8?B?ajlERHRjWDh6SnNsVGQyTlpZZzBXUzlHRGd1WG9wN3dCZ29rNEZyMEY0UUpY?=
 =?utf-8?B?U1RNaTNvbkFTbjMyTlZZNkJhcSt6SWxnaEJyYTdPaUZObkl2azMzYkl1VUVQ?=
 =?utf-8?B?YWsvbGpTMkJwMW9WanFPMC94L0R5SFhXc3ZGVlNIOEpMT2hKOUgzMVNxNktS?=
 =?utf-8?B?RURaSlpaWEo4bjh3NkhxcXZDVmJONmR2b3NmS3ZTVStDbytabnB1MlhSaERa?=
 =?utf-8?B?eXVkditTenh5azJ5WGhiU2dHdEwybXJjOFp1SjFTQ0h5OHlOd0hkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33F665B67154F247BF617C696BEC0AE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rwuggf5GnA+YHsA6VqdVvuVce7ZQEYq9JtCR7+QTQQlXVgE0n3sAWoCVLuvS2Z2Rw/d0ijT2fAFnqlT2YG0cILt0Uu+O4gzTvqwo1LHXAsVIG09RLP8MBOQvFncZsQGFaUXiLpfaD8kN2on7fCam+gZhJcjW+9mb72rVZKq10UW+xBqx2pYWgTMLk9PNZUJ4w4ZLJ48Dg6RLUSz0IEm7EeYwvq99yv1m40Ux8oXDSko8GnvSDOJlEChg7aGvM8OwyOmcvTb7hTVBafJMxuHlY36J6uwdEHvbm9aY8bvI9qlg4xj+9Gsfve5jfK02XLbKr9LDMY4C8hnMI9cvdYlKDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d7edf-20d2-480e-a252-08dee15a75a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 03:46:16.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLzuHuJSJ0eiZ3re6RagMkuBY+dMlm4R4COG7FLqRs5nAUgww/f6/pTxEzu9BtZnJfvsxBF9qaB5m4SmDGjRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com

DQo+IGJ1dCBub3cgS1ZNIGlzIG92ZXItcmVwb3J0aW5nIHN1cHBvcnQgZm9yDQo+IEtWTV9DQVBf
TkVTVEVEX1NUQVRFIGFuZCBLVk1fQ0FQX0hZUEVSVl9FTkxJR0hURU5FRF9WTUNTLg0KPiANCj4g
DQpbLi4uXQ0KDQo+IEBAIC0yMzQ2LDcgKzIzNDYsNyBAQCBpbnQga3ZtX3ZtX2lvY3RsX2NoZWNr
X2V4dGVuc2lvbihzdHJ1Y3Qga3ZtICprdm0sIGxvbmcgZXh0KQ0KPiAgCQkJciAmPSB+S1ZNX1gy
QVBJQ19FTkFCTEVfU1VQUFJFU1NfRU9JX0JST0FEQ0FTVDsNCj4gIAkJYnJlYWs7DQo+ICAJY2Fz
ZSBLVk1fQ0FQX05FU1RFRF9TVEFURToNCj4gLQkJciA9IGt2bV94ODZfb3BzLm5lc3RlZF9vcHMt
PmdldF9zdGF0ZSA/DQo+ICsJCXIgPSBrdm1feDg2X29wcy5uZXN0ZWRfb3BzLT5lbmFibGVkID8N
Cj4gIAkJCWt2bV94ODZfb3BzLm5lc3RlZF9vcHMtPmdldF9zdGF0ZShOVUxMLCBOVUxMLCAwKSA6
IDA7DQo+ICAJCWJyZWFrOw0KDQpbLi4uXQ0KDQo+ICAjaWZkZWYgQ09ORklHX0tWTV9IWVBFUlYN
Cj4gQEAgLTIzNTQsNyArMjM1NCw4IEBAIGludCBrdm1fdm1faW9jdGxfY2hlY2tfZXh0ZW5zaW9u
KHN0cnVjdCBrdm0gKmt2bSwgbG9uZyBleHQpDQo+ICAJCXIgPSBrdm1feDg2X29wcy5lbmFibGVf
bDJfdGxiX2ZsdXNoICE9IE5VTEw7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgS1ZNX0NBUF9IWVBF
UlZfRU5MSUdIVEVORURfVk1DUzoNCj4gLQkJciA9IGt2bV94ODZfb3BzLm5lc3RlZF9vcHMtPmVu
YWJsZV9ldm1jcyAhPSBOVUxMOw0KPiArCQlyID0ga3ZtX3g4Nl9vcHMubmVzdGVkX29wcy0+ZW5h
YmxlZCAmJg0KPiArCQkgICAga3ZtX3g4Nl9vcHMubmVzdGVkX29wcy0+ZW5hYmxlX2V2bWNzICE9
IE5VTEw7DQo+IA0KDQpJTUhPIGFuIGFkZGl0aW9uYWwgJ2VuYWJsZWQnIHNlZW1zIGEgYml0IHJl
ZHVuZGFudD8gIEFuZCBpdCBzZWVtcyB0aGVyZSdzIG5vDQpydWxlIHdoZXRoZXIgdGhlIGNvbW1v
biB4ODYgY29kZSBzaG91bGQgY2hlY2sgaXQgYmVmb3JlIChjaGVja2luZyBhbmQpIG1ha2luZw0K
dGhlIGNhbGwgb3Igbm90Lg0KDQpIb3cgYWJvdXQgbGV0dGluZyBWTVgvU1ZNIGNvZGUgdG8gZXhw
bGljaXRseSBjbGVhciB0aGUgZnVuY3Rpb24gcG9pbnRlciBpbg0KeHhfaGFyZHdhcmVfc2V0dXAo
KT8NCg0KUGVyaGFwcyBhcyBhbiB1bHRpbWF0ZSBnb2FsLCBJIGFtIG5vdCBzdXJlIHdoZXRoZXIg
Vk1YL1NWTSBzaG91bGQgcHJvdmlkZSBhIGFsbC0NCk5VTEwgdmVyc2lvbiBvZiBrdm1feDg2X25l
c3RlZF9vcHMgYW5kIHRoZSBrdm1fbmVzdGVkX29wc191cGRhdGUoKSBzaG91bGQgdHJlYXQNCmFs
bCBhcyBlaXRoZXIgT1BUSU9OQUwgb3IgT1BUSU9OQUxfUkVUMC4gIFRoZXJlIHdpbGwgYmUgc3Rp
bGwgY2FsbCBzaXRlcyB3aGljaA0KbmVlZHMgdG8gY2hlY2sgdGhlIHBvaW50ZXIgaXMgTlVMTCBv
ciBub3QgYW5kIHJldHVybiAtRVhYWCBidXQgSSBndWVzcyB3ZSBjYW4NCmxpdmUgd2l0aCB0aGF0
IChrdm1feDg2X29wcyBpcyBzaW1pbGFyIHRvbyBhbnl3YXkpID8NCg==
