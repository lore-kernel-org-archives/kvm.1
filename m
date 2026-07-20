Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8B434E27;
	Mon, 20 Jul 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566131; cv=fail; b=qAstJhOLlZ9J2odAhvHufHP18BPl+bTW5X/z0DldvyjNNpSe/+MDGiuS8q88vBcIGcnpNuH4mUTNh7XAVg35y3cE2o2PCSVITeVV5uhAePAsO2e3r4btFyby9JZrA4Nj4O1f9U87gKokx4CpTnrJDpcPzIFdUi88ItvzJF01vGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566131; c=relaxed/simple;
	bh=3sAv/m/XhrJcmcbajxVzEgAN3ApTl+hulBG9AaS1lJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLWMCHfsi3yX/VYd89nCTp8BCnLeWR0J2cy9iaoGDPsW+QEIqempLuNlTkV7dKKESzLugf/emu6JvlkoDpqAXFM7utmVIMpK2cQIsDm0+OaAXqICidpmyNUjEKh1NqdcSXcRLESfZ8+79vljH353g0lYS+1oe+K7ZHROZRqFCK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxy5/2mh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxy5/2mh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784566129; x=1816102129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3sAv/m/XhrJcmcbajxVzEgAN3ApTl+hulBG9AaS1lJY=;
  b=mxy5/2mh0mpJiiKD0aA9mfAe4AD+5a1SLwQG/Ib7acE8xIiJYHIXssjg
   HoTco6gEvB6gv8VF38klrbTdwWfrfD20iKt+8+p8GLCj9sETR4RDnJW30
   3vjDEdJtEQnFa1Mk1HAOff2/QilHgaengXepNQR0vYwaxLQ4D1fS1i/VU
   F5pdd1Q0bNyKzlMv4pkIXHQSEG5ZPZ/h1djX8PGxuGwzIe1G36qeO3Kcd
   sP2ETAzveutJP2FxqCrvUXpsDjYBRXXbUREcYXM020oQpctcfTkDEl71Q
   0R8gpKuugQq/Gh61u+38x66VzRbVJuOnu7DMpXCgdnzzGyyhfsvrFqoig
   g==;
X-CSE-ConnectionGUID: o2fXRtqdTWuySSTynP5d9Q==
X-CSE-MsgGUID: TUK6fxccQ9CE8oo6DT11Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96664136"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96664136"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:48:48 -0700
X-CSE-ConnectionGUID: GH/sCgVPT+ynawdnmxR+CQ==
X-CSE-MsgGUID: ctbOxX5BT8uDIQN7Kc3dLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="251171517"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:48:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:48:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:48:47 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MODMqbAXp8HcCK+ikGRLps81wFkaaouTJ4v7oKWswCQvv+pfVSmQFUWh4OtPLhgZ5OKFBKdNVUDC0wXk1W4j4ZlYzu3/37wFHycJg90I0UsZzR2RSeJeF0J973u3cqaR1kcUKVKxu5WIdwdbrUV9IDuZhL95PC19re55vjo95A7/e1IpoXCt4tDHMUHVyioDPhCZo9Vvfbu4PkdObYbIxfGkjrMB8x8DVHv2jibr4bWekVP2ZqaPX7zvwsQJGisRzStUsAuY6FoQ/ofmxNns0MDxWxE1QVF+0htpdBnjzlsYxPFmi/cxAZT3SBngJJ708XkH8UNasccZ+os3JovpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sAv/m/XhrJcmcbajxVzEgAN3ApTl+hulBG9AaS1lJY=;
 b=BLu4aeVpTXufdwjwHZkD1qpJAiYpks7y0BU/PI/UoUUMcjZdyR9jhUfYu7QqxIe3uj1Lg8WXEThjgkGIhCQ1KBLAn3hLBl2Q32PDY/WRjKaSifvNeKVG04O2ux1yhNnHj6Tz2xheB+rDwf4T7YGfsWzYUhJTyuOT/muYCWJ7OMDswHvqxQ4t0J7SqjMZMsS1IxqcUW2EtJk62EAMiKa/J7fgU7sKTkveHFByoXhdC5uNApRy2O3zTkALYtl68mLeoGr+5t9gpD7ZI9bIqAau2YNTrqAfsMVnIIFGbGfD6gpPykeV4k4/YWZSK5T8edSOLU/cgEr61FBfwoNidY9SeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 16:48:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:48:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZyy64AgAPW3wA=
Date: Mon, 20 Jul 2026 16:48:41 +0000
Message-ID: <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20260718061050.E17B01F000E9@smtp.kernel.org>
In-Reply-To: <20260718061050.E17B01F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV8PR11MB8606:EE_
x-ms-office365-filtering-correlation-id: 358ee3da-8aee-4bd9-ddcb-08dee67ec16f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: 6sko4/bHOz7KGhq6mFZbTyw3na/9epKAr2E0KHuImEmP59Cei3lK90GIO1+DqZuzWVUbBsn3fedSdSBrYqmrGpSnk9CwCSu3vLsD6wBw6csskeM/8CZE59O+v9wb/3TKzRvvfj62LZyg1MyjsXNjYFO1xIVZNY8AMrwM4nejs0HCgUGq+nt9t2O+IkHigVV2iHYyLOetxUxDxKHwW6g+kD5x/XNv7Mj8mbw/z8J4D/biGI6p6LKpMC+CG2gZc5G6ceYgSdOQkNPVWVJ/3X3ohfIApKaeKQrA0TeoLOjEtgVWownYgvLdoCTDYVLbKYvVdq7r96O4iVeb7sif2LdTckt3nivSf1eOe2IVSG92QSZ/dO+GvuZ06dpxeN2a01hxY909foJZo+jFufiNJUqX9Z23hi9EIq4ebEA3O9oLBZDaHPCNYpJmUNfkWkk7+l7QxA2Vag3tDOxbdUtluUYzQlWgPn6Yfx/UJzP1TAKSkQSv8/WMOofChuWmJ3abyM9BUwD+P29ThfMhjhBIQlnUc/Ywsv1tQkHP8KVaiAYEj0NkZ0vbYadQN42HUBKwYDkAC03XcD//kEJjJi605fLBg7m12uYxFdGdS/U3Fo8SSs8jQ15iK2zbNiAYk/c2si5IZb12p202hDXskLriMq/bX4ypAnzBeQdpqVYCAOyFQTwpmX9RwLe/x+4YL35d8BHVMzQRcN5If96Ub58Hudg2M8+MinhFgDXOPWeq/gnuslc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDc5R3FMcTBVVDdLLzVucmxicHRMWG1obWZhMkltRlRWODlwaHoyTE4wRDVq?=
 =?utf-8?B?TGhyZzRDWUZaRGxiQzl4eEZGdVBOV2NvbkQyNDNJRUljSWZoYVZNNkZtTlJU?=
 =?utf-8?B?NHJTbUYzTmFpYWhTbjNYNW1ERjF4OU1zWDVyWlRmUFQ4Y1JyUGtickVYVU5P?=
 =?utf-8?B?d3hhNm5MSlN2ajhERGk3dmtOWVRybEZqZnZZWmFsNVhhZEs1Q2taMU10N0tM?=
 =?utf-8?B?eXZlYWFPaTd4SlNjS3RvMDJuK2dISmJSbDd4RTIxN0hmakZ3anlBdzNYQjFK?=
 =?utf-8?B?d2twT0M1NkU4RHdvRFB6eDlLUUluWTNJbzdpMW5iT2JIa1NIcnhxaEFGdTdz?=
 =?utf-8?B?dEt5c2JpNGtjS0dISkRuZTc5NkJCRmpSc0NKQTJiQW9GamM4ZVZHdVpDYU1W?=
 =?utf-8?B?ZXg2MXJ5TkV6NmFBbVRKTEZWVWIvNHZORHRuSXJFTkFZdDBmODQrSGNzSWR2?=
 =?utf-8?B?S0JEQnBKOUhYY04xWFRZb3F2NEZUbEpTS3g4SjFhWS9vaHJMdVVrR1lkd1RF?=
 =?utf-8?B?cHY1Rjl1cnpKTDRjeUROKy9rNGlTVkNUUXNhdGlIQitpb2lSY09seFBRNnFa?=
 =?utf-8?B?bmdMcUtNL09RYkE4UVJZckswektyVjlkQlozaWN5eFRJUHN2NEZIODdnWlV0?=
 =?utf-8?B?OGZNRmExeFdhZVZUWllzU3Q2Zk1yaVZDV0dsdHFDaXhNazBEbmZRUXZMdWRK?=
 =?utf-8?B?N0lmZEg5OEgrOEtYR3dvbDgvd0oyTHQ0VTNha2lOUENNbE5SQ0VkaEZydXZr?=
 =?utf-8?B?MjhOSzdYRldwTHdGaW90YjUxcFl0Zno3RkpqTytuck1ZbVI0d1JvcEs2c0V3?=
 =?utf-8?B?bjAxdC9oeWV1QzRLYmdqSHA3MERlS3VBU3MzYjNwZmx0TXRsZUs4bTNZS2tH?=
 =?utf-8?B?aFBjV1FncW9XL1NKakcwNWVHU3prS0lLcGVkdTNXNisyVDN1SnhIMjVhelBS?=
 =?utf-8?B?RkVtZVZRVVR5M0sydW1tRTRYSVRtYytUUmtjNnNVeEJlMmJkWVQrVW5nMHpF?=
 =?utf-8?B?Snl2TnVzMXNZRnRsU0VQUXhsQ0g0Y2RpdHFTdGpNZHVZZE5aK0Y2eWovdzdJ?=
 =?utf-8?B?c29pYUNOelg0NU9rUjNqYTFRMCthbFJ4N0QydU9TVENlWHJUKytMcnR3Nk0x?=
 =?utf-8?B?MTB3U1o2RHhiK3VCejhiNzlHNWRIM0lXQm5BOHJZdXFaczd6MUVzblluV3BW?=
 =?utf-8?B?d3REUHl5L215a0ZZMjVrdGZQS3F4aEhGd1lIZDhsVUxoTEVMVkhMTDBxeEpZ?=
 =?utf-8?B?ck42UkpRelNHem82NjhLcXBmZ0NCdENNem5ENUdzOS94cnllLzlPQkxLL0U0?=
 =?utf-8?B?ZlJRTGdFazZjelowQXJkczBPY3RpWmpiSzZsajE3WDhRRU9Od1M4YlI0Q1lO?=
 =?utf-8?B?NE1Kbkg3Vm1KMWRPQ1FoOFE0UWpzNGNtMUhqeXMvT2s2NFZ2OWRrZ1FRT0Fy?=
 =?utf-8?B?Vm4vRkpIcXAvdTFvWFpFZXppYnlSZk9TbVJnN2Y0TVp1OFVVeXIySSswS3Bz?=
 =?utf-8?B?aER0VHRwZVp6N0lqOHBxRFZxdXZLYlZaeHM2UlkwTjN4QytJL3BYZTlJY0J2?=
 =?utf-8?B?bkJYWWt3M3F6V1RYbTdhWGw1Z3BUMXpLM09FQTVzcGhwSk91ZXlKT1JRQWtJ?=
 =?utf-8?B?dUE5NmllU082d3JHbUpqbkpXT2pjb0tZNzI0Z2d3TmxhcFRGYmdnaWZELzl6?=
 =?utf-8?B?U3VXUlNiK3NjdUpib1cvQVFaOC84WWx6MTlOZHpHY1ZtMHhnQ3pzR1JrSFNW?=
 =?utf-8?B?bHRhZUpmdlZ4ZHFQOUtxMmhmc3hrdk9TVlNPSjROSnh5YkRWajRFY0JGWGVZ?=
 =?utf-8?B?bVVaVkJLQ2txWTlVeFA0U29rcy9IMnpoQVFDbW5DN0VRVVE4c0VsdkJtZzQv?=
 =?utf-8?B?cmVIU2JleDlMQ3VzTVJkSlBreTkxVWZjS0FIc3Rma3dkRVU5YWhuMXg4RnlJ?=
 =?utf-8?B?OXhxeTNVNHYxaUdGTVIyd21rZFVNRUloazNvY0d2TUxEQVBBMEY3U21SN3Uv?=
 =?utf-8?B?emxkeVcxZGt6Uzl1Mm0wUDByeC8vUEo0LzlpZWdTVVFuek1KQlUzZm13OE1y?=
 =?utf-8?B?TmtKNjV0MzVrOEhGaUorZ1BGSnI3TjhsNnZZNTdIUDYzZ2tBdDJ4RnZDNXhW?=
 =?utf-8?B?MVdZNFovQit4cU0rYWVXdmhqVW1tRGo3MEh5dHhFUWNJaWQ1R0c2eXJrVzVh?=
 =?utf-8?B?NFlZRDRWSlB1RzF5ZktKUnZ6NFQ3MWVnallzb1NROXZob3N6YjM4NUlTNytq?=
 =?utf-8?B?azNUc1NFdGJFeWQvaHBzREE2Vy9VdUwrYytZZVlYdzM1cGRZOHFTTHBwT2h2?=
 =?utf-8?B?bEZRc0dpSjdkaXR4Q1pST2JlWDNISHlyelZseHc4L0hEY3Izb1p6ajFiZlZq?=
 =?utf-8?Q?AdF+amz/GfL6SJSQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE69B0180DE5F2469246004AD339C33E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CDIR88knSqS24XucKR41HK2+5hmDgTkG87SslDP636J50zP/zuENdO/hWAtZkdA2PiIzsk90e5CETn/Vb5IVGKupm8xRtKwxkZSl5/MLnvkCi/BSaDm/aFWd5520/KETdNGC4S0Cw9HdrkAvzrxZsgkGugsBb2gJQKC1bYvRihuZMsXQ2aOreHu67qo49u9+vfe9nAqV1Ng98EEFNndZSNEgLvYVBLeBf0lLVBeJ7lpNz6bU1KHiyr+T1Mea1mdn/gX/VIZd+BOs/XSzRssjiaNka8RqWY50GzL33dnimBWUdyQl3ABRTxfVuhEKNScibveTZtH04r4jILEqf8XfgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358ee3da-8aee-4bd9-ddcb-08dee67ec16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 16:48:41.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoNiuq6Von0yeccBK7s6BezA2gOzOlQ4yYqKlQPatZRi0Xska2y6oUO2+9GdAL10DTil3wQRY9QoKwRZwg/QPFqJFQFaloE8V56hf/EMr6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTE4IGF0IDA2OjEwICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbSGlnaF0g
SW5maW5pdGUga2VybmVsIGxvb3AgaW4gYGt2bV90ZHBfbW11X21hcF9wcml2YXRlX3BmbmAgZHVl
IHRvIHBlcm1hbmVudCBQQU1UIGNhY2hlIGRlcGxldGlvbiBvbiB0cmFuc2llbnQgVERYIG1vZHVs
ZSBjb250ZW50aW9uLg0KPiAtLQ0KDQpPdXIgaW50ZXJuYWwgU2FzaGlrbyBmb3VuZCB0aGlzIHRv
by4gSXQncyBhIGZhbHNlIHBvc2l0aXZlIGFzIGEgcmVhbCBidWcuDQoNClRvZGF5IGt2bV90ZHBf
bW11X21hcF9wcml2YXRlX3BmbigpIGlzIG9ubHkgY2FsbGVkIHRkeF9nbWVtX3Bvc3RfcG9wdWxh
dGUoKQ0KZHVyaW5nIFREIHNldHVwLiBJdCBob2xkcyB0aGUgaGVhdnl3ZWlnaHQgdGR4X3ZtX3N0
YXRlX2d1YXJkIHdoaWNoIGdyYWJzIHZtLQ0KPmxvY2ssIGt2bS0+c2xvdHNfbG9jaywgYW5kIGFs
bCB2Y3B1LT5tdXRleC4gU28gdGhlcmUgc2hvdWxkIGJlIG5vIGNvbnRlbnRpb24NCnBvc3NpYmxl
Lg0KDQpBbnkgcG90ZW50aWFsIGNvbmZ1c2lvbiBpcyBub3QgbmV3IGVpdGhlciwgYmVjYXVzZSBh
IHNpbWlsYXIgdGhpbmcgY291bGQgaGFwcGVuDQp3aXRoIHRoZSBleHRlcm5hbCBwYWdlIHRhYmxl
cy4NCg0KQnV0IFlhbiBhbmQgSSB3ZXJlIGRpc2N1c3NpbmcgdGhhdCBpdCB3b3VsZCBiZSBhIGdv
b2QgY2xlYW51cCB0byBmaXggdGhpcyBhbnl3YXkNCmJlY2F1c2UgdGhlIHJlYXNvbiBpdCBpcyBu
b3QgYSBmdW5jdGlvbmFsIGlzc3VlIGlzIG5vdCBjbGVhciBmcm9tIHRoZSBjb2RlLiBGb3INCmlt
cHJvdmVkIHJlYWRhYmlsaXR5IChhbmQgcXVpZXRlciBzYXNoaWtvIHJlcG9ydHMpIHRoZSB0b3B1
cCBjYW4gaGFwcGVuIGluc2lkZQ0KdGhlIHJldHJ5IGxvb3AuIEVpdGhlciBieSBtb3ZpbmcgdGhl
IHJldHJ5IGxvb3Agb3IgbW92aW5nIHRoZSB0b3B1cC4NCg0KPiANCj4gLS0tIFBhdGNoIFs4XTog
W1BBVENIIHY3IDA4LzExXSBLVk06IFREWDogR2V0L3B1dCBQQU1UIHBhZ2VzIHdoZW4gKHVuKW1h
cHBpbmcgcHJpdmF0ZSBtZW1vcnkgLS0tDQo+IGNvbW1pdCAzNDc0ODA3ZjFjMWJjNGRlZGM3NWUy
YTc1NmI2NTI1NGM5ODZhNDFkDQo+IEF1dGhvcjogS2lyeWwgU2h1dHNlbWF1IDxrYXNAa2VybmVs
Lm9yZz4NCj4gDQo+IEtWTTogVERYOiBHZXQvcHV0IFBBTVQgcGFnZXMgd2hlbiAodW4pbWFwcGlu
ZyBwcml2YXRlIG1lbW9yeQ0KPiAgICAgDQo+IEFkZCBEeW5hbWljIFBBTVQgc3VwcG9ydCB0byBL
Vk0ncyBTLUVQVCBNTVUgYnkgImdldHRpbmciIGEgUEFNVCBwYWdlIHdoZW4NCj4gYWRkaW5nIGd1
ZXN0IG1lbW9yeSAoUEFHRS5BREQgb3IgUEFHRS5BVUcpLCBhbmQgInB1dHRpbmciIHRoZSBwYWdl
IHdoZW4NCj4gcmVtb3ZpbmcgZ3Vlc3QgbWVtb3J5IChQQUdFLlJFTU9WRSkuDQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJjaC94ODYva3ZtL3ZteC90ZHgu
Yw0KPiA+IGluZGV4IDUyOGViYjNjYjAzODkuLjA0OWRhODU1OTg4MmIgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva3ZtL3ZteC90ZHguYw0KPiA+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4
LmMNCj4gPiBAQCAtMTY3OSwxNiArMTY5MywyOCBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnRkeF9z
cHRlX3RvX3NlcHRfcHQoc3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm4sDQo+ID4gIHN0YXRpYyBp
bnQgdGR4X3NlcHRfbWFwX25vbmxlYWZfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwN
Cj4gPiAgCQkJCSAgICAgZW51bSBwZ19sZXZlbCBsZXZlbCwgdTY0IG5ld19zcHRlKQ0KPiA+ICB7
DQo+ID4gKwlzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUgPSBrdm1fZ2V0X3J1bm5pbmdfdmNwdSgpOw0K
PiA+ICAJZ3BhX3QgZ3BhID0gZ2ZuX3RvX2dwYShnZm4pOw0KPiA+ICAJdTY0IGVyciwgZW50cnks
IGxldmVsX3N0YXRlOw0KPiA+ICAJc3RydWN0IHBhZ2UgKnNlcHRfcHQ7DQo+ID4gKwlpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArCWlmIChLVk1fQlVHX09OKCF2Y3B1LCBrdm0pKQ0KPiA+ICsJCXJldHVy
biAtRUlPOw0KPiA+ICANCj4gPiAgCXNlcHRfcHQgPSB0ZHhfc3B0ZV90b19zZXB0X3B0KGt2bSwg
Z2ZuLCBuZXdfc3B0ZSwgbGV2ZWwpOw0KPiA+ICAJaWYgKCFzZXB0X3B0KQ0KPiA+ICAJCXJldHVy
biAtRUlPOw0KPiA+ICANCj4gPiArCXJldCA9IHRkeF9wYW10X2dldChwYWdlX3RvX3BmbihzZXB0
X3B0KSwgJnRvX3RkeCh2Y3B1KS0+cGFtdF9jYWNoZSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJ
CXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICAJZXJyID0gdGRoX21lbV9zZXB0X2FkZCgmdG9fa3Zt
X3RkeChrdm0pLT50ZCwgZ3BhLCBsZXZlbCwgc2VwdF9wdCwNCj4gPiAgCQkJICAgICAgICZlbnRy
eSwgJmxldmVsX3N0YXRlKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJdGR4X3BhbXRfcHV0KHBh
Z2VfdG9fcGZuKHNlcHRfcHQpKTsNCj4gPiArDQo+ID4gIAlpZiAodW5saWtlbHkodGR4X29wZXJh
bmRfYnVzeShlcnIpKSkNCj4gPiAgCQlyZXR1cm4gLUVCVVNZOw0KPiANCj4gW1NldmVyaXR5OiBI
aWdoXQ0KPiBEb2VzIHRoaXMgZXJyb3IgcGF0aCByaXNrIGNhdXNpbmcgYW4gaW5maW5pdGUgbG9v
cCBpZiB0aGUgVERYIG1vZHVsZQ0KPiBjb250ZW50aW9uIGxlYWRzIHRvIFREWF9PUEVSQU5EX0JV
U1k/DQo+IA0KPiBXaGVuIHRkaF9tZW1fc2VwdF9hZGQoKSByZXR1cm5zIFREWF9PUEVSQU5EX0JV
U1ksIHRkeF9wYW10X3B1dCgpIGZyZWVzIHRoZQ0KPiBQQU1UIHBhZ2VzIGRpcmVjdGx5IGJhY2sg
dG8gdGhlIGJ1ZGR5IGFsbG9jYXRvciwgbm90IGJhY2sgaW50byB0aGUgdkNQVSdzDQo+IFBBTVQg
Y2FjaGUuDQo+IA0KPiBJZiB0aGlzIGhhcHBlbnMgZHVyaW5nIFZNIGluaXRpYWxpemF0aW9uIGlu
IGEgcmV0cnkgbG9vcCBsaWtlDQo+IGt2bV90ZHBfbW11X21hcF9wcml2YXRlX3BmbigpLCB0aGUg
dkNQVSBtZW1vcnkgY2FjaGVzIGFyZSB0b3BwZWQgdXAgb3V0c2lkZQ0KPiBvZiB0aGUgbG9vcDoN
Cj4gDQo+ICAgICByID0gbW11X3RvcHVwX21lbW9yeV9jYWNoZXModmNwdSwgZmFsc2UpOw0KPiAg
ICAgaWYgKHIpDQo+ICAgICAgICAgcmV0dXJuIHI7DQo+IA0KPiAgICAgZG8gew0KPiAgICAgICAg
IC4uLg0KPiAgICAgICAgIHIgPSBrdm1fdGRwX21tdV9tYXAodmNwdSwgJmZhdWx0KTsNCj4gICAg
IH0gd2hpbGUgKHIgPT0gUkVUX1BGX1JFVFJZKTsNCj4gDQo+IFNpbmNlIHRoZSBQQU1UIHBhZ2Vz
IGFyZSBkaXNjYXJkZWQgcmF0aGVyIHRoYW4gcmV0dXJuZWQgdG8gdGhlIGNhY2hlLCBhIGZldw0K
PiBidXN5IHJldHJpZXMgd2lsbCBjb21wbGV0ZWx5IGVtcHR5IHRoZSB2Q1BVJ3MgUEFNVCBjYWNo
ZS4NCj4gDQo+IE9uIHRoZSBuZXh0IHJldHJ5LCB0ZHhfcGFtdF9nZXQoKSB3aWxsIHJldHVybiAt
RU5PTUVNIGJlY2F1c2UgdGhlIGNhY2hlIGlzDQo+IGVtcHR5IGFuZCBpdCBkb2VzIG5vdCBmYWxs
IGJhY2sgdG8gYWxsb2NfcGFnZSgpIHdoZW4gYSBjYWNoZSBpcyBwcm92aWRlZC4NCj4gDQo+IFRo
ZSBURFAgTU1VIGhhbmRsZXMgLUVOT01FTSBieSByZXR1cm5pbmcgUkVUX1BGX1JFVFJZLCBidXQg
YmVjYXVzZSB0aGUgY2FjaGUNCj4gaXMgbmV2ZXIgcmVwbGVuaXNoZWQgaW5zaWRlIHRoZSBsb29w
LCB0aGUgbG9vcCB3aWxsIGluZmluaXRlbHkgZmFpbCBhbmQgcmV0cnkuDQo+IA0KPiBDb3VsZCB0
aGUgUEFNVCBwYWdlcyBiZSByZXR1cm5lZCB0byB0aGUgdkNQVSBjYWNoZSBpbnN0ZWFkIG9mIHRo
ZSBidWRkeQ0KPiBhbGxvY2F0b3IgZHVyaW5nIHRyYW5zaWVudCBmYWlsdXJlcywgb3Igc2hvdWxk
IHRoZSBjYWNoZSB0b3AtdXAgYmUgbW92ZWQNCj4gaW5zaWRlIHRoZSByZXRyeSBsb29wPw0KPiAN
Cg0K
