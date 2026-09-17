Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F973BBFB3
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680799; cv=fail; b=UKdLoet0FrvxSZXBTc7FHWi90GN5FfyRQFleq+M/M3HmUabkvrjXOuZgfplZJzU1hWtHkE3j8ZcA058+SXCY5lxrUSqO0Lae5Iy9qu5++B+Mu2eFkwt5x0Lh066DI0p56BvfYAlfCsrrRP/pvTkh7n222tf+EdqA0SudKLWZcBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680799; c=relaxed/simple;
	bh=IV3cDTE/kQbNLJIsXRmTNLEIYoevDrPjn8jnvYi0xcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrENLz4pNw1xaJ+MpvRjLKu2sKrXdD46fIGxoweHy+/E8fHJPR3XSlj3gUl3kXMhL0ScF8g20vDg7PWZpMaaWggDNPIMnqJDJx3VsalZg7VHcI1/NjmTGR5Xljb+ddndFqNFJ6pQ403CNIiNSlwIQA/Me5t4c249WEiQM8xgHA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS8rzuIS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS8rzuIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789680797; x=1821216797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IV3cDTE/kQbNLJIsXRmTNLEIYoevDrPjn8jnvYi0xcU=;
  b=FS8rzuISZnOhpGAOcz6wBc6Kp3hA5nc96vzHuenvy+MG2mpXbDZRY/gv
   k1LmdvMWALq9VuyO0hUC6XHJoiXQ2820sam8A6X1NlWiF8Uj5sEZJurTf
   xHNrHngFMfYEu6aeJc9vrq73aL5idzJFmAk3YpiIl2Z60oSwZMLhM4ekx
   9Bpzlkc26Zvwf7gr3kggr0TxOhufX0LDmH2J/srkVKDP9xtjvD1OVadfJ
   aSEJeYijCXXpRwICZ58oF5kTEs+VGsAPcBVU1GkkI2zKZwWBUXiLMo8A8
   kdvuKOQQFaEbX2zy3gPdj2OnJFk82f+y7FT/ctMULtpX/qHpMXgovGq6v
   w==;
X-CSE-ConnectionGUID: nIuQVpM2RciHVWrEUTwc8A==
X-CSE-MsgGUID: EgQrsgsQThudeLv54voFqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115683998"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115683998"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 14:33:17 -0700
X-CSE-ConnectionGUID: aYS9ifFYRfmGQMKljo5ijw==
X-CSE-MsgGUID: GC7E6BpkRA6YuuKXIegymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297518595"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 14:32:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 14:32:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 14:32:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 14:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4PKVBbPEdTaq/YnjGKEuU2lknPVTKJoG5HUFKu/QcdIgcKmDa3L6e+Tu1R/5ZjupuppL76btdticke8kh/PWFyERJtZStU2uRqZbTjMwdD60hmdGyRYKrlIAzaODy3jiDHMwR5gQwAtavTbzPhNeOLDUXEJoH6gzCeW90QpJtHmzfmLMnB9+fpraHMcGabRuvUi/83XO3X/zXgvfUrie2gbKzpkUlwx2WfekIpGDJ+J80tuAwehFUPCfnMr3Fc1J4eAXycWFMC9clhAIyADQO7ehfjP1VbwKowRvBeiIJfEuRk9DarGCjkxUj1iqcdEocunCE5CRZYGsAZHlkFr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV3cDTE/kQbNLJIsXRmTNLEIYoevDrPjn8jnvYi0xcU=;
 b=hnjZ1O+ZJ39wo25lNITw9DZ9/6tV/M5Y1bWK0IZLVp356CP4VNK+xiyE51UHsFtJe3MTyzlpJ5bX1+ly7lbJCyhf5BcJEZSU/SKwSJklJEdNNxK98HOzJZZ+d28BucigYYwQ5aM81R3RDfuzm8YAXQxrrLaO/sk0U6+1QqiFnTaY/pEGI+h7mCbZK4aHQu7Vl77SAStyQ+0wsr+sDxSdLmBnOVWs92MYUp+TRbTZQENEZGdOaYHRXVb6UyoelglEaL7/3vxkFa59OeUs9XPwUM++KyRTlr3e4oXcMS4ZoNDd8PnbzcAZKwyKVo/Njid7nduRHoNJw4peHTSKqKl9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DM3PPF68472F2DC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 21:32:32 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 21:32:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafIA=
Date: Thu, 17 Sep 2026 21:32:32 +0000
Message-ID: <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
	 <aqrZUZtSZ-YItclT@google.com>
	 <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
	 <aqrtprn5YaMijVdZ@google.com>
	 <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
	 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
	 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
	 <aqvtG90zWq6SkU8L@google.com>
	 <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
	 <aqxGN2Zc8sOl2RKx@google.com>
In-Reply-To: <aqxGN2Zc8sOl2RKx@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DM3PPF68472F2DC:EE_
x-ms-office365-filtering-correlation-id: 1098d850-640e-4998-a9ab-08df15032eb0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|3023799007|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: uqwa6+iKxmx/nS7NMtvJmr5PF1q5c+B9yRQIBhy8eqm8nHAS1o42ltdNdL1wzfVy2L2N1mZ5yIlQfrZqfXxFRZO+CMN8n/EWH0irW1Cxlv4ZqXGzx7t/DEUgKpU0Fd+AOUVYGZggF0QUngFTL+706h3pC94YphhyTmkjPdrIYmHqcdzspPmkFaGBXP/1FV1CSvdVy8+EL/TPRyE62hjD/m6OZwm+c0y1KryDrSm+jJ5vziBZcfE7Ucp3Qp2iUZ+kMxkfnk3KO3I7iiBLxU152Lt47TR1BUYaaDzS1g3kIZuc3+3NxLmEFmkaJPDUbvtPwPGLUvqi0Q1H02beVf0bWvQ81Y3Kdu30DnWsCwW2Atg5wki1gVExQoY8NdDy4roVw1Crom4r2gSgUfxs3N65gluPKhUe8N1PyQ33eSGgtYyq1DN+u+O5MNDDIID8zrI1yHx0hWV5Mhav/fh7QEiCdrSXJfeeGdR885SlgCgYUDkRwn4fDgiDvY1zA5YbkEWeURoJKfH7fNz/WZ0S1kbabN74jiqFAWSXvqz6P7ZNm3EFe5hNl/33nFrUoMWoYK9gwUhwZ37kOt10JNwplov3bNERQIPv5IpmNmzGPPjvCnjBtOqfQLrrtnCFIZo4ogr/B/4uIMlQJjV3DTvv2byUOX8NBufj/+bZ2tTS9E8pMjhkyb028cb3yWliVTx8F3NbvsbadKvwU7ua5wZV4YQLayn+0Pq23WrClyAaZkWdDC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(3023799007)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRPcm5mR2RiWnBQTjZqS1RNK0tGNC9HZHBZUlJLNFI3cldjZitRYmNUUU9w?=
 =?utf-8?B?Zkd5WGVBRWo1L0NyZFMrUENRdGgxZWRDd3ZETzhoSjA2UXlkZGM4cFBPM080?=
 =?utf-8?B?WDRDSDF1R0pYRFFkT0Y1WWk3WHpQZ3ZicUNEV0NaUFo5aHBibGpaWncxSnJo?=
 =?utf-8?B?L3NXMkRlejRsNGp5Si9qUU9tQzV3cFpWOEpQdndIaWlzYTBTb1pzdkIwRm0r?=
 =?utf-8?B?OVRjVUswOHlsUHVoSjVXMmtkR1pZclZYemRMcmxWc2owTjBFZjVVeEFCUHFu?=
 =?utf-8?B?TEJzRTF5d2FDZGIwMHpmTlJ4cFdqSUU2NFZ5THZsSzVZc0F0NS9vakV5K1Qy?=
 =?utf-8?B?ZFdBY1JMVWZ0ZGFBalJpWHVZazlLaXZLN3M3OTgzT3VmbXlIYU5IOHFyYTZR?=
 =?utf-8?B?MisrNW8yc1dML0hoUWdkRjg3aDdZaENITmFqR3dReHNnSkJKWlZGZ09yd0NH?=
 =?utf-8?B?RTBmd0NRQ0l4cjFjMk9SaUhZZVpya1BUaEp2N01PQk1XL1cxVzkvNnlCQ3Jn?=
 =?utf-8?B?OTRUck5CNGVxUFB6d0VtdkdXWEp5b0VKdWlTNTZYYmVybEtRam4xZllqZHdM?=
 =?utf-8?B?ZkFJQnk3cmExOWd4WWtBYTdUeTdwMWhVLzlmZURpZ29ZS3J6Z09EaTZtZk1w?=
 =?utf-8?B?aVh1dnVYdng5Z1lvTllhRnJuaFJXZVN5YzNMMzJXcnBHQndOLzdmYXhDVFdN?=
 =?utf-8?B?ZEM0Q0FpU0J4KzViTmtwa0t3WDQwdkRPQUM2bi9sRmE5TWorUEF1RGtYUnM1?=
 =?utf-8?B?VFk2elRabUlNeHhnbnNmUDFqY01ZVHI3WWh0S085SWRRRUZ3dFBvWDFpR0M4?=
 =?utf-8?B?aFc0b3hUV0hzWmYyUVFnalM0MG5Cc011L290OFJxSHNwOFFKWStWVlpHVlE4?=
 =?utf-8?B?Zlh3UDJxdXpWTS9idU5zQi91aEtrTlRzZ2JWSWprSnl4YXBzbGMzbXZaV1A0?=
 =?utf-8?B?djhJanpNYWtTaDdMY0ZseXRhSEhuQ0pUUEpIK1ZjUjl4MTZmaFBpY1Fvdlor?=
 =?utf-8?B?QjU3cFpkWmVVcE5NLzE1SWw1OWtJQWxESUpXa0lNUXRYTW1tL2NSazlOc3Z6?=
 =?utf-8?B?Z1B5aGxNZG1hOWJueUFPVnVBb1p4VFluNlloTVBJVy9EZUpxL3VRN2FXU3dK?=
 =?utf-8?B?QVhMQ3ZoNmlDcGFYNGZ0VzVUR1Ixb2hXWks1TEVGU3A4VE9zTlpvREgvMHkw?=
 =?utf-8?B?Yi9BeVVHUENIOFRJamNqU1RWbi9QQlRUSkJHNXQrTTlRZDhXaW9tczd2Sm0z?=
 =?utf-8?B?M09qUUxzd2ZDVU5oZExwUVhZbVZzRFdNOXllMVJpQXhKenFvOURUaWhNUWNV?=
 =?utf-8?B?bElkZ29BbmNuWmJvckdRR01uNUFWVXBYZEJYQ1VCWFhKQnA3ZTdIL2FyMjZF?=
 =?utf-8?B?RTQrcjUxYStGTzFwZDY3UTQ3VDFMeU9qMjlaNGNKREhOVnB0SkJPSFpyR0ww?=
 =?utf-8?B?a0hOc3E5MTFSejQ3ZGdkSlBGSEt4d2ZqQWFIRmFuNmtwVC81MUNldDE1RG1w?=
 =?utf-8?B?K1Yyd1lEelFUVXc0TTNYSVoyUVFEdms2d2E3aFUrcWM4TllLdk8rUENqMlBJ?=
 =?utf-8?B?cG9MbjJSKy9vUngxMTVETElyWHZDUytIZmlaN2RqQ2k1U09LQTZJUFZZaklI?=
 =?utf-8?B?VktTeVNXMUV2UXJXdHp4S2kyUmhYZTJpeVFOTHQwZVVSTVBOY3MrMW9KQm1m?=
 =?utf-8?B?cEc4STJKMi80RW5OTHBKVGUycE9yN0dvNzVQSDJOWE4rN21LS2cwaVVhQjMw?=
 =?utf-8?B?Z245MWNWWHJIQ0N3RHRxblJvRkJvVnkrNnM3M0hUbno1OXZHZzQ1Y2U2S0tr?=
 =?utf-8?B?bUFONW5GR0w4WTJMdEhxOTJTR3VCM3JSRzQzaUluOFZ4L0pwYTNvdlNIY2ZN?=
 =?utf-8?B?YkNTNGtIOTVzQ0o4czB4MlY5Z1ZoT2J5Mkpra0Y1UXMzRXJybHdOdElkd1hv?=
 =?utf-8?B?QVRGSjZhTnF4Uk8wWHhBSmRIcEU1VHpqZTVJbjB5cXlOS1RPTnJSYlpyTC85?=
 =?utf-8?B?M21jU2U0dlEzOForOURoaWhoaUpsaTNzaDZIVi9VQm5kb0kyQUh3eFBRSVlG?=
 =?utf-8?B?OXpDSjJ5K293RjRiYVlBVlBNSDZMNjAxV280dWpmbTA0d2R3enBRVVRuS1Rl?=
 =?utf-8?B?SmF0VHhOQVNqYlVvUUVuTTNKcVB4cnpQWUgyU0Jjd0NDWFFBeEJWM2VlZ2xP?=
 =?utf-8?B?MG5GOGtBNGxhZ0grdzJEZ2F3TlRPbEFXWUNLaUJpRFBCaWFxU2lvcFBHTUJz?=
 =?utf-8?B?NTNUSk1iSCtxdUNXV0pHb1pCcms4RklmYS8rVUE2bnNESUhObFA3d29wNHgv?=
 =?utf-8?B?aEJhbTlTaGZDTHZMbmFlMk4wSHVIelRaRFZDUGlPYmp3Kzh0OENLQUluSC85?=
 =?utf-8?Q?zMAcMnmOAhYNJfAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C70EAAA4904F43B9054A7E053B6DA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0wUjUk3k99prpaXJzHXUpqyQKd8gUrq6+itFvaHh/adQnKD9Mcy+mZeV0ktjR5QktdQ9SiwlfpvCse+cEys9C3Ad+l8N8ZroYcmK/Et2xTxn21369QFJ6k36EEH+boaASZnJuzySUYyG/BUvYS+4+qxk1HaOGeQHyp3wSQcRApdzEq3ug0HLav7UeeYN79OQ7w5aHVHyjHlPcA5i2Wxoiz6azM4hrP5n/xTXFVCsggxWns2IfJQl9ge9XJmJTvO4Xfn/ZcSdkU9NFQBGGFv+3ezA1VcAtkP1HW4s6YlqTbR56+e5BydwG871FceNGaaMhA1irKuRMKb6YoxtDU+oWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1098d850-640e-4998-a9ab-08df15032eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 21:32:32.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSwAE3z1CnJeCk7HiVqRax8Q9PLnUig0G1DH3lnasVtjxV5j00aDURUbOGsawNSkb0xxKvk8VpIZhVePgbtGKNsqs53kezmC3Fr9ZhChdR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF68472F2DC
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDEyOjU3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IExldCdzIHRha2UgYSBzdGVwIGJhY2sgaGVyZS4gVGhlcmUgaXMgYW4gZXhpc3Rp
bmcgYXR0ZXN0YXRpb24gZmxvdyB0aGF0IHdhcw0KPiA+IGRlc2lnbmVkIGFyb3VuZCBzb21lIGxp
bWl0YXRpb25zIHRoYXQgYXJlIGNoYW5naW5nIChzcGVjaWZpY2FsbHkgd2hldGhlciB0aGUNCj4g
PiBxdW90ZXIgaGFzIGtub3dsZWRnZSBvZiB0aGUgVEQpLiBUaGUgY3VycmVudCBob3N0IHNpZGUg
cXVvdGUgZGlzY3Vzc2lvbiAoS1ZNDQo+ID4gaW9jdGwpIGlzIGJhc2ljYWxseSBhIHN0cmFpZ2h0
IGZvcndhcmQgZXZvbHV0aW9uIG9mIHRoZSBleGlzdGluZyBkZXNpZ24sDQo+ID4gZXZlbiB0aG91
Z2ggdGhlIGxpbWl0YXRpb25zIGFyZSBnZXR0aW5nIHJlbW92ZWQuDQo+ID4gDQo+ID4gWW91IGFz
a2VkIHdoZXRoZXIgd2UgY291bGQgZG8gYSByZS1kZXNpZ24gdGhhdCBtYWtlcyBtb3JlIHNlbnNl
IGluIHRoZQ0KPiA+IGNvbnRleHQgb2YgdGhlIGxhY2sgb2YgdGhhdCBvbGQgbGltaXRhdGlvbi4g
QXQgdGhhdCBwb2ludCB3ZSBhcmUgZmFjZWQgd2l0aA0KPiA+IHRoZSBhZ2Utb2xkIHF1ZXN0aW9u
OiBob3cgZmFyIGludG8gdGhlIGZ1enp5IGZ1dHVyZSBzaG91bGQgd2UgZGVzaWduIGFyb3VuZD8N
Cj4gDQo+IE5vdyBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGUgKmN1cnJlbnQqIHBs
YW4gaXMuDQoNClRoZSBsYXN0IExpbnV4IGRlc2lnbiBmb3IgYSBob3N0LWJhc2VkIFREWCBESUNF
IEFQSSwgbWVhbmluZyB0aGUgdGhpbmcgd2Ugd2VyZQ0KcHJlcHBpbmcgZm9yIHRoZSBuZXh0IERJ
Q0UgcG9zdGluZyBiZWZvcmUgZ2V0dGluZyBpbnRvIHRoaXMgVERHIGFuYWx5c2lzOg0KIC0gTGVh
dmUgdGhlIGV4aXN0aW5nIHJlcG9ydCBpbiB0aGUgZ3Vlc3QgYXMgaXMuDQogLSBVdGlsaXplIHRo
ZSBleGlzdGluZyBxdW90ZSBHSENJIGNhbGwgZnJvbSB0aGUgZ3Vlc3QgdG8gcGFzcyB0aGUgb2xk
IHJlcG9ydCwNCndoaWNoIGdvZXMgdGhyb3VnaCBLVk0gdG8gdXNlcnNwYWNlLg0KIC0gQWRkIGEg
bmV3IFZNIHNjb3BlZCBpb2N0bCB0byBLVk0gdG8gY2FsbCBpbnRvIHRoZSBUREguUVVPVEUuR0VU
LiBUaGlzIGdldHMNCnRoZSBxdW90ZSBhbmQgcGFzc2VzIGl0IGJhY2sgdG8gdXNlcnNwYWNlLiBU
aGVuIHVzZXJzcGFjZSB1c2VzIHRoZSBleGlzdGluZyBHSENJDQptZWNoYW5pc21zIHRvIG5vdGlm
eSB0aGUgZ3Vlc3QgdGhhdCBpdCBpcyByZWFkeS4NCg0KPiANCj4gPiBUaGUgbmVhcmVzdCB0ZXJt
IHRoaW5nIGlzIGEgU1cgYmFzZWQgZmxvdyB3aGVyZSB3b3JrIGhhcHBlbnMgb24gdGhlIENQVS4g
QnV0DQo+ID4gdGhlIGV4YWN0IGFtb3VudCBvZiB0aW1lIGlzIG5vdCBrbm93IHlldC4gUGV0ZXIg
Z2F2ZSBhIGJhbGxwYXJrLg0KPiANCj4gV2h5IGFyZSB3ZSBldmVuIGRpc2N1c3NpbmcgdGhpcz/C
oCBJIGFtIHNvIGNvbmZ1c2VkLsKgIEkgdGhvdWdodCB0aGVyZSB3ZXJlIHR3bw0KPiBvcHRpb25z
OiBTR1ggYW5kIFMzTS7CoCBOb3cgYWxsIG9mIGEgc3VkZGVuIHRoZXJlJ3MgYSB0aGlyZCAibGV0
J3MgZG8gaW5zYW5lDQo+IHRoaW5ncyBpbiBzb2Z0d2FyZSBpbiB0aGUgVERYIG1vZHVsZSIgb3B0
aW9uIT8hPw0KDQo/Pz8NCg0KU28gd2hlbiBJIHNhaWQ6DQogICAiSFciIGlzIHRhbGtpbmcgYWJv
dXQgdGhlIFMzTSB0aGluZy4gVGhlIHF1b3RlIG9wZXJhdGlvbiBjb3VsZCBnbyBkaXJlY3RseSB0
bw0KICAgdGhlIFMzTSB0byBnZXQgdGhlIHF1b3RlLiAoSFcgYmFzZWQpIE9yIGl0IGNvdWxkIGdl
dCBhbiBpbnRlcm1lZGlhdGUga2V5IGFuZA0KICAgZ2VuZXJhdGUgcXVvdGVzIHVzaW5nIENQVSBp
bnN0cnVjdGlvbnMuIChTVyBiYXNlZCkuIFRoaW5rIGxpa2UgYSBjcnlwdG8gbGlicmFyeQ0KICAg
aW4gdGhlIFREWCBtb2R1bGUuDQogICANCiAgIC4uLg0KDQogICBUaGUgc29mdHdhcmUgYmFzZWQg
ZmxvdyB3b3VsZCBiZSBleHBlY3RlZCB0byBmaXJzdC4gSXQgd291bGQgaW52b2x2ZSB0aGUgQ1BV
DQogICBkb2luZyBjcnlwdG8gc3R1ZmYgYXMgYWJvdmUuDQogICANCiAgIFRoZW4gYSBIVyBiYXNl
ZCBmbG93IHdoZXJlIHRoZSBjcnlwdG8gaGFwcGVucyBvbiB0aGUgbGltaXRlZCBIVyByZXNvdXJj
ZS4gVGhpcw0KICAgaXMgd2hlcmUgZnVsbCBwYXJhbGxlbGl6YXRpb24gaXMgbm90IHBvc3NpYmxl
LCBiZWNhdXNlIHRoZSBDUFUgaXMgbm90IGRvaW5nIHRoZQ0KICAgaGVhdnkgd29yay4gWW91IG1p
Z2h0IHdhbnQgdGhpcyBvbmUgaW5zdGVhZCBmb3Igc2VjdXJpdHkgcmVhc29ucy4gQnV0IHRoZSBt
YWluDQogICBwb2ludCBvZiBkaXNjdXNzaW5nIGl0IGlzIHRoYXQgeW91IGNvdWxkIGV4cGVjdCBz
b21lIHF1b3RlcyB0byB0YWtlIGEgbG9uZyB0aW1lDQogICBhbmQgc3VwcG9ydCBhIGxpbWl0ZWQg
bnVtYmVyIG9mIHBhcmFsbGVsIHF1b3Rlcy4NCiAgIA0KRGlkIHlvdSBpbnRlcnByZXQgU1cgYmFz
ZWQgZmxvdyB0byBiZSB0YWxraW5nIGFib3V0IFNHWD8gTGlrZSB0aGUgaW50ZXJtZWRpYXRlIGtl
eQ0KZ29lcyBmcm9tIFMzTSB0byBTR1g/IEhtbSwgSSBndWVzcyBJIGNvdWxkIHNlZSBpdC4gQnV0
IG5vdyBtYXliZSBpdCBtYWtlcyBzZW5zZSB3aHkNCnRoZXJlIHdvdWxkIGJlIGEgY3J5cHRvIGxp
YnJhcnkgaW4gVERYPyBBbmQgd2h5IHRvIGhhdmUgdGhlIHdob2xlIGV4dGVuc2lvbnMgdGhpbmcN
CmZvciBpbnRlcnJ1cHRpbmcgVERYIG1vZHVsZSBjb2RlPyBBbmQgd2h5IHRvIGNhcmUgYWJvdXQg
dGhlIGd1ZXN0IGhhdmluZyB2aXNpYmlsaXR5DQppbnRvIHRoZSBzYXZlIHN0YXRlIGFyZWE/DQog
ICANCkhlcmUgaXMgYSBob3BlZnVsbHkgbW9yZSBjb25jaXNlIGRlc2NyaXB0aW9uOg0KDQpIVyBt
b2RlOiBFYWNoIHF1b3RlIHJlcXVlc3QgZ29lcyB0byBTM00gZm9yIHNpZ25pbmcNClNXIG1vZGUg
KGZhc3Rlcik6IEF0IGluaXQgdGltZSwgYW4gaW50ZXJtZWRpYXRlIGtleSBpcyBnZW5lcmF0ZWQg
dXNpbmcgUzNNIGFuZA0KaXMgc3RvcmVkIHNvbWVob3cgaW4gdGhlIFREWCBtb2R1bGUuIEVhY2gg
cXVvdGUgcmVxdWVzdCB1c2VzIHRoYXQgaW50ZXJtZWRpYXRlDQprZXkgdG8gZG8gdGhlIHNpZ25p
bmcgdmlhIENQVSB3b3JrIGluIHRoZSBURFggbW9kdWxlLiBUaGUgaW5pdGlhbCBESUNFIHN1cHBv
cnQsDQptZWFuaW5nIHRoZSBmaXJzdCB0aGluZyB0aGF0IHdvdWxkIGJlIGhhcHBlbmluZyBpbnNp
ZGUgVERILlFVT1RFLkdFVCwgd2lsbCBkbw0KdGhpcyB1c2luZyB0aGUgd2hvbGUgImV4dGVuc2lv
bnMiIHRoaW5nIGRlc2NyaWJlZCBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoaXMNCnRocmVhZC4gU0dY
IGlzIG5vdCBpbnZvbHZlZC4NCg0KSXMgaXQgY2xlYXI/IEFzIGZvciBpZiBlaXRoZXIgaXMgaW5z
YW5lLCBJJ20gdG9sZCB0aGVyZSBhcmUgdXNlcnMgdGhhdCB3YW50IGJvdGgNCm1vZGVzIGZvciB2
YXJpb3VzIHJlYXNvbnMuIEkgaGF2ZSBub3Qgc3Bva2VuIHRvIHRoZW0gcGVyc29uYWxseS4gSSBk
b24ndCB0aGluaw0KUGV0ZXIgaGFzIGVpdGhlcj8gRG8geW91IHdhbnQgdG8gaGVhciBmcm9tIHRo
ZW0/DQoNCj4gDQo+ID4gQSBmdXR1cmUgdGhpbmcgaXMgYSBmbG93IHdoZXJlIFMzTSBpcyBlbmdh
Z2VkIGZvciBldmVyeSBxdW90ZS4gVGhhdCB3b3VsZCBiZQ0KPiA+IGV4cGVjdGVkIHRvIHRha2Ug
bG9uZ2VyLCBhbmQgaGF2ZSBncmVhdGVyIGxpbWl0cyBvbiBjb25jdXJyZW5jeS4gQnV0IHRoZQ0K
PiA+IGRldGFpbHMgYXJlIG5vdCBzb3J0ZWQgb24gd2hhdCBleGFjdGx5IHRoZSB1c2VyIHdpbGwg
d2FudCwgb3IgaG93IGl0IHdvdWxkDQo+ID4gYmUgaW1wbGVtZW50ZWQuDQo+ID4gDQo+ID4gSSB0
aGluayB5b3UgYXJlIG1heWJlIHdvbmRlcmluZyB3aGV0aGVyIFMzTSBjb3VsZCBiZSB1c2VkIHN1
Y2ggdGhhdCB0aGUNCj4gPiBndWVzdCBjb3VsZCB3YWl0IG9uIGEgcXVvdGUgd2hpbGUgbm90IG5l
ZWRpbmcgYW55IHNhdmVkIHN0YXRlIGFyZWE/IA0KPiANCj4gSSdtIHRyeWluZyB0byBmaWd1cmUg
b3V0IGlmICphbnkqIHBhdGggaXMgdmlhYmxlLg0KPiANCj4gQnVybmluZyAxbXMgb2YgQ1BVIHRp
bWUgdG8gZ2VuZXJhdGUgYSBxdW90ZSBpbiB1bmludGVycnVwdGlibGUgY29kZSBpcyBhIG5vbi0N
Cj4gc3RhcnRlci4gSGVsbCwgMTAwdXMgaXMgYSBub24tc3RhcnRlci4NCg0KV2hhdCBjb2RlIGlz
IHVuaW50ZXJydXB0aWJsZT8gVGhlIHdob2xlIHBvaW50IG9mIHRoZSBleHRlbnNpb25zIHRoaW5n
IGlzIHRvIG1ha2UNCnRoZSBvcGVyYXRpb25zIGJyb2FkbHkgaW50ZXJydXB0aWJsZS4NCg0KPiAN
Cj4gV2FpdGluZyAycyBmb3IgYSBxdW90ZSB0byBjb21lIGJhY2sgZnJvbSB0aGUgUzNNIGlzIGEg
bm9uLXN0YXJ0ZXIuDQoNCk5vdCBzdXJlIHdoZXJlIDJzIGlzIGNvbWluZyBmcm9tLiBCdXQgZG8g
eW91IG1lYW4gd2FpdGluZyBpbiB0aGUgZ3Vlc3Q/IE9yIHdoZXJlDQppcyB3YWl0aW5nIGEgbm9u
LXN0YXJ0ZXI/DQoNCj4gDQo+IFRoZSBudW1iZXJzIG1hdHRlciwgYW5kICpub25lKiBvZiB0aGlz
IGlzIHJldmlld2FibGUsIGV2ZW4gaW4gUkZDIGZvcm1hdCwNCj4gd2l0aG91dCBhIGNyaXNwIHVu
ZGVyc3RhbmRpbmcgb2Ygd2hhdCBsYXRlbmNpZXMgd2UgYXJlIHRhbGtpbmcgYWJvdXQuDQoNCkkg
YWdyZWUgbm90IGhhdmluZyBhIG1lYXN1cmVtZW50IG9mIHRoZSBpbml0aWFsIERJQ0UgYmVoYXZp
b3IgaXMgYSBkZXRyaW1lbnQgZm9yDQp0aGUgVERHIGRpc2N1c3Npb24uIEkgZGlkbid0IHRoaW5r
IHdlIG5lZWRlZCBpdCB0aG91Z2gsIGlmIHdlwqBsZWFuZWQgb24gdGhlDQpvcmlnaW5hbCBsb2Nr
aW5nL3NjaGVkdWxpbmcgcmVhc29ucyB0byBwcmVmZXIgYSBob3N0IGJhc2VkIHF1b3RlIGZsb3cu
DQoNClByZXZpb3VzbHkgeW91IGFza2VkIGZvciBiYWxscGFya3MgYW5kIGdvdCB0aGVtLiBTbyB3
aGF0IGRvIHlvdSBuZWVkIGV4YWN0bHk/DQpFeGFjdCBtZWFzdXJlbWVudHMgb2YgYW4gZnVsbCBU
RFggRElDRSBxdW90ZSBpbXBsZW1lbnRhdGlvbj8gSG93IG1hbnkgZnV0dXJlDQpwb3NzaWJsZSBt
b2RlcyBvZiBvcGVyYXRpb24/DQoNCg==
