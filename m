Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0021E3DDE;
	Tue, 11 Aug 2026 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408680; cv=fail; b=FqA9EDd5GCFUW4mhw/04wewzi6R1vhgL7oYlOjNbSEw6MnVot2H/HT3iPf5EFOXKzA64KyGuQHbJt+yVMg3yb+JPBdvf0YdH3m65bT6PfIqjf867y14lZ0RwclstJINvRLv9BjYUuQCnuqkxtZtemIBeOYGlojFlWIdQSqn6oeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408680; c=relaxed/simple;
	bh=zPoiPzLYFRWfzeVlZn2r0QDRJFvssjUCt83sasVov28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rg/UIDsJ9sPclanpqpGiC2LZKOEIx+EY+tX9by4RDSzqC938+xb1asqa7+4rPQ5CjldvG6j7FdkdkFM8paDdzGlVdWjOXsGQfHruThSjDmmL/ssUciQVbCF/g7Ow8tvCH517gHxKFI2UDd6nrDzpLuj8P3+GOsty7VirLNPPO/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqKp1308; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqKp1308"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786408677; x=1817944677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zPoiPzLYFRWfzeVlZn2r0QDRJFvssjUCt83sasVov28=;
  b=OqKp1308Rb9p1ZBalzmZknWE8VGwA9QzewpF85kNVfSLvxpBg9msIq3u
   L6O1/MACgBGQ5i8i9zPURhpjO7iILVlSy6YiZObjM3qNi7VLODOpFRlX8
   N03TclyUk/ORgznocgRMmwFgd5XtCQ4S3/NdbXSZYv/yO/QjQInqpyFb2
   QzdBJRylovSoeXDrFSPPHnJFDk1pHt8mVyBwEGl2ibh737YzEUUrPbZJ6
   xu2Q3P+l/BMnYaURrUxagoT2lV2gFAiC7TpB1bV7SvzpjwJ5BKj7hLuBZ
   z3wXsHm5oprPELs62ZET2mrZSg8GTcXcDxUPGlFgSRuOHoHwnqY/wQdzk
   A==;
X-CSE-ConnectionGUID: wep4rcOQS4q040ddVnMjgg==
X-CSE-MsgGUID: Qs3vtFLtRBipIeUmOtNO/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86960148"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86960148"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:37:56 -0700
X-CSE-ConnectionGUID: oqsTKFBMS8ybyMzRhrJp3Q==
X-CSE-MsgGUID: FBs84KIgSeOGCTCkCgZoZw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:37:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 17:37:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 17:37:55 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 17:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVnYEoolW/tWfXVaA3usY+pfIiatILYJ0cNgc4fW3l6rsO8E9vW3Jbe+6zXF6BRXWbTaaTjiWuWX+m0hM9e7/PkqhKQ3y2OTR/WOiSPFV42v4zN4s956WqDEuW1X1dHiFJZkyge0QAxPt6DCoIKPTX1W0nhJ2wKCN10VOWJcQGvsJ5CK2SmTwJYSNO6r5Js18neRYQdc3+TxAyCdHdEKxF6pcd4ikwKhPBFUE2pddij/BDFRn9kfLC/8yTYSPgrzbNQCkaSMhq6Ns0/d1/KONaY2DBfZ6ot5yCt1TDcJTe2//YKhk6ongEFxKAnFD8GT0WzYsWEkEfamEfOAlRSuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPoiPzLYFRWfzeVlZn2r0QDRJFvssjUCt83sasVov28=;
 b=kuXnzlsd1jIiJwm/RE/pLA2+4YsaInnQimmDVp6TdaINCCtUmd0ATz3Tx+dMqkh+arTSE+r053krDTmkmJoUwHLp9AF/HbqbCWdaTCm3TPkYYmcg0I7ZRbKJ8SkLnToUK5WDO+I+t/d15YU1vrBEOY6AXLv+K/Qnz/zGaRwLN5ABdh62cCWN0GFzM5NeZ5uSxJlJ4mZB/y+fuATtNVmv1yK0nNPFG06erDu2m/TdjrcMJPj5E8mH3CNvmkHMLevKOWKnetNJQHyjWLZ7gqrg4G/rxS7/MBcmUfrbnimmRmx36LhWMiLYbx0/DDfw6ZpK23dg6tM+q5w8VDbz1ppjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ5PPF162366726.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::813) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:37:52 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 00:37:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: TDX: Enable Notify VM exit
Thread-Topic: [PATCH v2 1/3] KVM: TDX: Enable Notify VM exit
Thread-Index: AQHdKLszo2ktuy5PZkKMMwbHSYevU7aYAdAA
Date: Tue, 11 Aug 2026 00:37:52 +0000
Message-ID: <50d1ab80de15d1542190f2f87651378ec7758360.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-2-xiaoyao.li@intel.com>
In-Reply-To: <20260810112200.2326727-2-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ5PPF162366726:EE_
x-ms-office365-filtering-correlation-id: 97695f1e-d0c5-4233-9442-08def740c724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006|38070700021|3023799007;
x-microsoft-antispam-message-info: VsdCX537A1L9fNRR+jhddlyI8raVb3a9+aw6JcVHNwsA3Xq1TS3k0CmBHbFAceKeCVJPFwWQS4kyMYOMU11J3072AUye99YOwEPTdlnFDNQcGY4HgWnfFwWL7MyhmKOV6Z36XfvMQA41PpiCo64Y1PU+MQ36UcN8CvZDsiu25HpAFH3LVjP+RCI1v6olff8Unzb0jpcBKZBCN/CYNabl5jnuR5DEx5xa9RyZoSz8EwXmj7gRGYsjjfPY7DspxKUP6ZQA7enX367eOrKrF2BQ/NHmWb68zv18Tt4YYok2yhEDLrWDN3fXtv3HlhtgkP+SJJR7TxB96REAhBTa2V0cCyK3UzhD94myRPZBz8kHmuuDY7CDhC6s7Yer6HD/KbsuwcWoGatmSBPp6UiG6xqmiwUgx1HXgKjeH6dXyQ/oEqoOyYiBhLKWWI5rez5hwOWliuSu36EFQcc/OM6vbtSLaqF9M46lWl3N8bENQ5XIpyuFY82ihJqtH9h83+o2xDwtOqa/9RRl93fGDgNLEncNp3CaBAs09M9pkGIwKxP02Bg/OJmvaQyivv0NXZ0m5HpotPWXh5A4gRbR+pjEfxqyWkcdzBMln6TPQIEruHSYYsqG2v540IRMZwQhO+oaJ+iib7tXI+Apmj9ChwgQhic+b6s4DHPkQAyVboD7HvYy4kp7idUtXjsasFOMFEsef/u9AvRaOdjslyfrhZxHYUtSCaVxLVVMKh17gBD9U41nzAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006)(38070700021)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0MwUTRxRThJUVg2MU03czNnb0hDckZWTlVwQVF3Uk5WOG9rNktPRHRiNmRB?=
 =?utf-8?B?aVh6UEJLbVNWdzVGNGtmUTVrMWd6cHFsNjJEOHgwNGZhOUlSUFZtWWZYUWFz?=
 =?utf-8?B?UjBTa1ZOdFBKUkhIV3lHa1lncFB3UTdkNGlQNUU3NGlNekd6U3YzckZOd0gz?=
 =?utf-8?B?RkxwakRLZklEbGp0bTl3TXBMSWJVb3I0VEk1WktiZzRhQ3gwbFlpbEJLUFdu?=
 =?utf-8?B?NHltL1liR3FYSlhCaGpvUEJxdys1VmViUTRuZFZzbnJZL2padEovblFsN0FM?=
 =?utf-8?B?NEpON2lvM1psYTROTG1wM3FqRVFQNm1hcmxLOUw4Z21SUDBab2VBaUhjZXpt?=
 =?utf-8?B?SGo5cldyTkRUN2JkMThpQmVmbzlSNHl6RURSNThzckdZNHdEb2lwZExzZXZQ?=
 =?utf-8?B?UGU1RXF3dzRFT2l0c1BrYkp0RVZqckY1UXk0N2txWmlBMUd1RVorejMreCt4?=
 =?utf-8?B?SWUxejhoQW5SeDlUU212UDQ1V2NETFdjWlA5OGh2U01DVWdrYllEUmVlNnd5?=
 =?utf-8?B?QkdMdHJqZmFCbUR3S1R5VWZobWVJNHhwZlBnYjFPRUtGNzhBSnZuWHhIRjh3?=
 =?utf-8?B?dUl3TXZjeHEyWWVVbDg1TVRUaGkwNmJHTnRMekFySklFTU9WNXpSTndZMGww?=
 =?utf-8?B?bXptMC94TEtDT1VKWldESTE1UkRNZmxtbDVmVFFXdDJCR0pzdEFIOWNZOFJ3?=
 =?utf-8?B?bWtBaTFqcGMyTFlyWCsrRGVLMmpRYjQ4cWFmWmVRdGpiNE45YTBkSEYvSWFw?=
 =?utf-8?B?QlZyQU05TVpPeVk0N3Yybi9TekxPaGo5cExUam1yMzUzQWd5Yk41TUxiYXE1?=
 =?utf-8?B?RjA3QnNuZElhb3pyY1NDSldnVm9VTjcwTmEyTk9iczNjM3F4aUR4aWF1UEhB?=
 =?utf-8?B?d0hpMTYxOHYxSXM5TVFrK2l5Z1FxdW11b2VBd0I4c08yd3hWZTlHZGM3RUFG?=
 =?utf-8?B?OFFkdHNKTUVpS25vbmZlbmdCN1JMTS9adVBkM2RWNm91bGtNSFRwY2Rjdk9Y?=
 =?utf-8?B?VURqcFFWYWkrUytya3BKMmI5REFhc28vLzFtWCtZRHg2YjNPTHVsZEhZbVYw?=
 =?utf-8?B?SVJjU002bXRkbU9UcVVoQWNOVFdxR1k4V1ROdXR4bGg5MlAvYzNHZFFVSHdz?=
 =?utf-8?B?ZThMVkVQRUlWZ2czUWdyUE44TU5kWDVGR1hmLzlOQTlSYS9BYis5Q1F6WG5o?=
 =?utf-8?B?TTVXc1h4Z3lFaDBUOVhUOWZ5WEhsbFgra1dyVXlONE9xVklxR0hFajR0MVN4?=
 =?utf-8?B?RlgyR0JaVkJnN00xVHV0ZzVaRVBJUnRBZzFuUTlza0dPZHk0b3llOEFTaVdy?=
 =?utf-8?B?SE00UTJqZStWZDZ2em5hQVdLNUdRQVVMRXpYeFU0WGtFZWJNRk9pWGIzblJK?=
 =?utf-8?B?b3dsVGNUNzFIaDF5L2pMRzBuWE5TSkNaWVM1ZVlXdHJFeGxyMm81dmhSYWF4?=
 =?utf-8?B?c0NhUW8zUDg4emhZTzU3QTNvUmtWNVMwOGU0MUVKdk5xWDBNTXFsaVRLVmlC?=
 =?utf-8?B?Nks3bldJQ1ZtcDRoNThDWjRsZi82cFpnYWJ5NnNhbndnN1RMbWJOa0lzZTA1?=
 =?utf-8?B?dHpyZDR1SmY2RmE1WTUrclJ1SWJHYmUrOEw4alBNRnpOZisxMUwycnl2MGpF?=
 =?utf-8?B?MTZHQmFXNmVDRGppb3RWcWd0T2l3YUxCY0tyUUQrYTdqQUFTdW1td25oa3hi?=
 =?utf-8?B?UFFPKzFmSko1TVkrRERkai9IdGNJVzlWYzJRYTZRclp0ditFVnZrNEFJM21k?=
 =?utf-8?B?Y21aUmNxSHpaSUl0R0kzRytYRjhnK29pczF4RTd5SjVYZE55SU5jSm1hd1pG?=
 =?utf-8?B?RUJmZFpEOE9RN2NkUG5RdkI0cE5RcURpbDFaTXlKdXlDRE1kNHBWVTBIZjZt?=
 =?utf-8?B?RXdVVExTZXo1djJ5SnNYZUltc0lFU0lxRS9Sclo3V2ZaV3p1L0VBOHlSMHc1?=
 =?utf-8?B?cW1aU3VUMHBRR2RBWW1UN0tkWkw1Z3BBdW9SaTFpeXJFN2M0MTZaVXBZTXo3?=
 =?utf-8?B?YkgyUEZxK0xxOGtrQ2lidjFtV2lYTHZFWEFOclRXUC8rdkR1U0hmOTJqd2Fq?=
 =?utf-8?B?RHIyclI3TmszVGFMU01ZNlRsczFTcmNhZHowNlJnTzlHVGlONFhxZ2FKbnlH?=
 =?utf-8?B?MFN4eVYyMHo4OXZzZEw4b1FNUlVvWUZXdWs3bGc3bE4wY2N4aE9YaHlGM2VN?=
 =?utf-8?B?ajBIb3JESjdqbU5qQzh4TEdVQjIwR1BLK1Nvc2JBdHNsb2hKZGtPOVAxdmFL?=
 =?utf-8?B?K2VOSjJzN0ZIbk1NcUoxb3AxbGsvOVBkeVVnR2ZTVUVVclNCSGhvZEh5eHQv?=
 =?utf-8?B?bmJvdnRsMVlUeTRNYlA0bU4zc2R1ZXlhZS9wazNETnAvTUdtQkhKSXh4ZVht?=
 =?utf-8?Q?OIdA393k7MltQ7OI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42B28C4DE6C4C458CD59657CCB3755B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DFojRaAjahGBXu1i6whT67R5ePMd7VCJcDVv/JO64mOaZSsWA+m/wl42uFQaLRMeQix7XsPmHoLsbwy/jmUF1q5hDQrkQVfMWc5mUJ3R7igQMNiTdombByPbNr9PZMfoyBfdH389bnbDnnWSEql3fpjkzhiUKqkvpLFVMPGTh3X9kT0cyJADk/JQ7C3/MKKe5p0WgIl8UrgYJ2sNuS+MF2R7+6+MgZDKcStUk+ArmrSnyNIj36YQ2Q4oKYPDR10FKfCkHoSjHgA5I/fWKpTBwpynhCHBxdqpCS9Du1MSH+N4L4hlIaIBUBdWgQaCnZPjvrckW5wSjMBqHW1sSp15iQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97695f1e-d0c5-4233-9442-08def740c724
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 00:37:52.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6PZg7WuBVNAeqvgHCrTIuwaKXqy7h9B0I1vTNh417uxCIBNk40en9Y3vNlLB1NfPd4adoAK8Vhjm83g9+9TpYb68jnK2KHsarkHKOcuBl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE5OjIxICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBF
bmFibGUgTm90aWZ5IFZNIGV4aXQgZnVuY3Rpb25hbGl0eSBmb3IgVERYIGd1ZXN0cy4NCj4gDQo+
IE5vdGlmeSBWTSBleGl0IGlzIGFuIGV4aXN0aW5nIGZlYXR1cmUgc3VwcG9ydGVkIGJ5IEtWTS7C
oCBVc2Vyc3BhY2UgY2FuDQo+IGVuYWJsZSBOb3RpZnkgVk0gZXhpdCB0aHJvdWdoIEtWTV9DQVBf
WDg2X05PVElGWV9WTUVYSVQgd2hlbiBpdCdzDQo+IHJlcG9ydGVkIGFzIHN1cHBvcnRlZC7CoCBI
b3dldmVyLCBLVk0gcmVwb3J0cyB0aGUgc3VwcG9ydCBvZiB0aGlzIENBUCBqdXN0DQo+IGJhc2Vk
IG9uIHRoZSBoYXJkd2FyZSBjYXBhYmlsaXR5IGJ1dCBkb2Vzbid0IGRpZmZlcmVudGlhdGUgYmV0
d2VlbiBWTVgNCj4gYW5kIFREWC7CoCBUaGlzIGxlYWRzIHRvIHRoZSBpc3N1ZSB0aGF0IHVzZXJz
cGFjZSBjYW4gZW5hYmxlIHRoaXMgY2FwIGZvcg0KPiBURFggZ3Vlc3RzIHdpdGhvdXQgZ2V0dGlu
ZyBhbiBlcnJvciwgYnV0IHRoZSBmZWF0dXJlIGlzIG5vdCBhY3R1YWxseQ0KPiBlbmFibGVkIGJl
Y2F1c2UgS1ZNIGRvZXNuJ3QgY2FsbCB0aGUgVERYIG1vZHVsZSBBUEkgdG8gcHJvZ3JhbSB0aGUN
Cj4gcmVsZXZhbnQgVEQgVk1DUyBmaWVsZHMuDQo+IA0KPiBFbmFibGUgTm90aWZ5IFZNIGV4aXQg
Zm9yIFREWCBndWVzdHMgYnk6DQo+IA0KPiDCoCAtIEludm9raW5nIFREWCBtb2R1bGUgQVBJIGNh
bGxzIHRvIHNldCBOT1RJRllfVk1fRVhJVElORyBhbmQgTm90aWZ5DQo+IMKgwqDCoCBXaW5kb3cg
aW4gVEQgVk1DUy7CoCBJdCdzIGRvbmUgaW4gdGR4X3ZjcHVfaW5pdCgpIHdoZXJlIG90aGVyIFRE
IFZNQ1MNCj4gwqDCoMKgIGJpdHMgYXJlIHNldC7CoCBTaW5jZSBURFggdkNQVSBjYW5ub3QgYmUg
cmVzZXQsIGl0IG9ubHkgbmVlZHMgdG8gYmUNCj4gwqDCoMKgIGNvbmZpZ3VyZWQgb25jZSB3aGVu
IGluaXRpYWxpemluZyB0aGUgVERYIHZDUFUuDQo+IA0KPiDCoCAtIEFkZGluZyBjb3JyZXNwb25k
aW5nIGV4aXQgaGFuZGxlciBmb3IgVERYIE5vdGlmeSBWTSBFeGl0Lg0KPiANCj4gTm90aWZ5IFZN
IGV4aXQgY2FuIGhhcHBlbiB3aGVuIGV4ZWN1dGluZyB0aGUgSVJFVCBpbnN0cnVjdGlvbi7CoCBJ
ZiB0aGUNCj4gSVJFVCB1bmJsb2NrcyB0aGUgTk1JIGJsb2NraW5nIHN0YXRlLCBiaXQgMTIgb2Yg
dGhlIGV4aXQgcXVhbGlmaWNhdGlvbg0KPiBpcyBzZXQuwqAgSW4gdGhpcyBjYXNlLCB0aGUgVk1N
IG5lZWRzIHRvIHJlc3RvcmUgdGhlICJibG9ja2VkIGJ5IE5NSSIgc3RhdGUNCj4gd2hlbiBpdCBk
ZWNpZGVzIHRvIHJlLWVudGVyIHRoZSBndWVzdC7CoCBGb3IgVERYLCBLVk0gY2Fubm90IG1hbmFn
ZSB0aGUNCj4gR1VFU1RfSU5URVJSVVBUSUJJTElUWV9JTkZPIGFuZCBpdCdzIFREWCBtb2R1bGUn
cyByZXNwb25zaWJpbGl0eSB0bw0KPiBoYW5kbGUgaXQuwqAgRXh0cmFjdCB0aGUgY29tbW9uIHBh
cnQgd2l0aG91dCBOTUkgYmxvY2tpbmcgaGFuZGxpbmcgaW50byBhDQo+IGhlbHBlciBpbiBjb21t
b24uaCBzbyB0aGF0IGl0IGNhbiBiZSBzaGFyZWQgYmV0d2VlbiBWTVggYW5kIFREWC4NCj4gDQo+
IE5vdGUsIEtWTSB1c2VzICJwcmUtcHJvZHVjdGlvbiIgdGVybWlub2xvZ3kgZm9yIHRoZSBmZWF0
dXJlIGZvcm1hbGx5IGNhbGxlZA0KPiBOb3RpZnkgVk0tRXhpdC7CoCBBbGwgcHVibGljIHZlcnNp
b25zIG9mIHRoZSBTRE0gcmVmZXIgdG8gdGhlIGZlYXR1cmUgYXMNCj4gSW5zdHJ1Y3Rpb24gVGlt
ZW91dC7CoCBUaGlzIHdpbGwgYmUgcmVtZWRpZWQgaW4gdGhlIG5lYXIgZnV0dXJlLCBmb3Igbm93
LA0KPiB1c2UgS1ZNJ3MgdGVybWlub2xvZ3kgZm9yIGNvbnNpc3RlbmN5Lg0KPiANCj4gTm90ZSwg
IzIsIHRoZXJlIGlzIG5vIGVudW1lcmF0aW9uIGJpdCBmb3IgTm90aWZ5IFZNIGV4aXQgYnkgVERY
IG1vZHVsZQ0KPiBiZWNhdXNlIGFsbCBURFggbW9kdWxlcyBzdXBwb3J0IGl0LCBhbmQgYWxsb3cg
dG8gc2V0IHRoZSBjb3JyZXNwb25kaW5nDQo+IFREIFZNQ1MgZmllbGRzIGFzIGxvbmcgYXMgdGhl
IGhhcmR3YXJlIHN1cHBvcnRzIHRoZSBmZWF0dXJlLg0KPiANCj4gRml4ZXM6IDE2MWQzNDYwOWY5
YiAoIktWTTogVERYOiBNYWtlIFREWCBWTSB0eXBlIHN1cHBvcnRlZCIpDQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlA
aW50ZWwuY29tPg0KDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vj
b21iZUBpbnRlbC5jb20+DQo=
