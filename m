Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302C20DD51;
	Thu, 25 Jun 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431067; cv=fail; b=gk08EbR2y4/8MLyYHwkS3gUxUVzsQPgOTBwrsL68XO/wGoFyMGy8lHMiAoAkX6wZjXPTwDKBofh/yGOP4IsuCIMNUVKTMgP+sK5yefGOgL5K6ghEadkC6CYGZi2kvaZfsfH7clHbCcwfNLedcUUcIGYPkdOtdq4w6tvxx5bdC5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431067; c=relaxed/simple;
	bh=++PLbfQSVVoDfN3+muHQavp7HMZxOX5W2E0eIIKX/dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOdlM3fLTl4TftnSURTz3cVZckD2O9zdfNgY975OIjfvuTm6cxCj0M2ANu0TBgkL/9aW9TQuwajkaYnZCdS2x3LhvQZ84XYsAtdIiNwyGkbZ5rPlmqG3ieFMxXHmQqVwq0iJ31cbmys4gcQuoQm/Pie9bs9+vmxy+9NFR+ZSIg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFbQhPC7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFbQhPC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782431065; x=1813967065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=++PLbfQSVVoDfN3+muHQavp7HMZxOX5W2E0eIIKX/dA=;
  b=XFbQhPC7gKXjJNSBwvFkmUpXFEtoLVxjRKvuUfVIw9zfikTbbm/lq5Wl
   jnrYPwCjCshnsuLCynk7rf6WMvwmNCXxJWXWpyUes/GasmG1TiRawHKtF
   lzYm3PnifPog28drBLoalkRZr6zp07v60hDpMKknTteNSnEupOFYX7cXi
   3mE0AQ88kL5VBRN/lFVVmtsTbZFeK3XewwgOCohZg7jY1l+oQvx0xTft4
   njIXlJqWCHhX0zzOhXL/bdCvQHoZunZ8bvIBINik3vgiMJOPujvprqFHS
   X0OUVPf8RzD0PGwsjnUdUHggdfJvPehKgO11w8aI2gs6/lwMgTZVuuYTW
   Q==;
X-CSE-ConnectionGUID: ss84Rn4JTTeRXyWFPQD8vQ==
X-CSE-MsgGUID: em60VHc8T3GsWQJ/5rx8rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83103582"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="83103582"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 16:44:24 -0700
X-CSE-ConnectionGUID: tRm8jcZWS0ukIR+PN5ueFg==
X-CSE-MsgGUID: XP3lS03dRiW4gFK0gUQlRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; 
   d="scan'208";a="255583121"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 16:44:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 16:44:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 16:44:23 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 16:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0G/qVQmluv+AFE4Q+suWLAn+J5XKOxZPirrrQQTi8+twoxVr+NiG+MBhU3G/Y9W4afS3uWCewj034srQq/scC+ADIDJCEV8sMnfe2QLS1t6Z9Dt6MCQc8tunHmRTiOPkzGokQbcgcshKk5W2hvWisM8RxCk5F1mChiuv/FJEv82vuUFHo0rPZ7GljqeiuPghPoVi9G+XbbOEwtrOKuvEtEggDnwggOY4CTgzIrS9jn9MbkHHNTzUGS2d52CSnffGx2qcK3c50gOAu2raBRwrM0bNh+KmsP2RQGihX+7yDcwk42LxcPUT2Lr/ihgylaQuc/6xwIVSRGn8P3cr+VTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++PLbfQSVVoDfN3+muHQavp7HMZxOX5W2E0eIIKX/dA=;
 b=mAlv2Bi1rO2ufBTKNdAAcG+P5oJJAXmG9Ui4eY0q3ycIdhegwJhoizbM1y5XWSh/u8gMrKdYzyWmAqHO9QLAa2eqgt3EgXLdnwxNTNRhb7My3Hn4K/HlLFaT/cZTe2AdGpKiHKomP2IRIaLWB52OsyAMK2QtstFbVh+KuCduaBql4jj6UV/SC+5dWnxINz16MfNg8BP8eQYxxVeGMBavVQlghrOMAFgsBIxQiUNOHhZ8NpMkj7tg6LOnhL96+wku/Ama1APsN00+alFIE298DD1MzAOsBf0W6zoWp31lj3/7tq+ticExvFiRD6mgIVbdNozOaUWWJus/xX81KEanMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 23:44:21 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 23:44:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Topic: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Index: AQHdBCWnns3dykXXyUWZiAS1Gt6Yz7ZO4JMAgACHB4CAAIkuAA==
Date: Thu, 25 Jun 2026 23:44:20 +0000
Message-ID: <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
References: <20260624220516.3033391-1-seanjc@google.com>
		 <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
	 <aj1KP2h49GzfNHFz@google.com>
In-Reply-To: <aj1KP2h49GzfNHFz@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: a33a6509-2e5e-4a39-20ed-08ded313ade2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: dbNUNcEVoP9YbDM+lJQKnKChACOfhi53Y0Syl8gye1w+xIsaPSEatnfB10AI14CFmistAPnf7G2D4FJPSryJHUAso6u1SeXSR+1w+6clT4aOtKbUN10q33dzx7JKhzFSw7pFN4bNdr6ZynP77hY7Rzv07tvHyUNECbJ2hqOWm/GiS8BZWAH7PqGEf3FSwuymnUbK5biKGhnc5yTM7VuhFsmnM6EXu2mezfw4VINky56MSafLAKMuZY2VBB3ANh/MiBDZLQJ0+j+uFaik6IluIXd+nOJUdvafl9c2+pwvCNT38NqMRw0+PLjwmHFxGLc1gRAAVmsHjJAabWjnEJURY+WDdIGTB9z1FHUNpkZZSe05dqUWw5iCzidqM0Hq+doLcn6tS4rwQZBouEWF1gu1PRhDUL+yUkZAzr8rU8trBfDWsDy/E/y5Khf5pFk2eRsSQoaucDwuB0vx9Ao8QcOPA9N6NVaUyOD1pyV6ltNrnm6Uj6ZZHIaxF9m6yV8i23hG2W8CdNta4Z+uI3HmATHcFgOj4NnhczfmZGG4vuEUDLaiBdclt1JImpnizd2jJCVix84x6b2CIRPdu/ZUFrIylJcYMpOdiZkVYO/2gInmRWKMxfyb6X00rj8jJe3tcbDB7Bm3G7T4AFppwzWv9zoCIwE9YMRp/xI3kiOHtrFvqNA/s+YUuUBczzXSkCMLUvU70e8W86eUsK8Yv2n4SZGWC83SeKKnQMKrNhOa1BHTXvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU02NVhvWkJsTnlkZE5JUXVFRCtVajNWU1BVVFlKVXFxRExWa2FjL29YZ1k5?=
 =?utf-8?B?STlveGhqdk8zQStXVDhHR1YxTDk1YTVVQUdwQXo3Q0ZDM1Y5dDc5N1ZYSkUv?=
 =?utf-8?B?dEhkWUpyN2pTUlA0M2FrcmlERHJkY0phc01KR3pwTmJTWkkrRFlBUkFhMm5O?=
 =?utf-8?B?UkNYTVBqeGpWb2NGeTJpaERiTThWbWcwM3doOXlwajRxWTArdFdzbDFkT1RC?=
 =?utf-8?B?aWlZT1ROYXdxbXlFS3RwN2VvdklwNDc1OUd3a01PUzJjdXk4dWNYdVFaWi9k?=
 =?utf-8?B?VWM1UGVXZVpRbGppazVXZ3ZQTEhtWkpoQVVuQ3l6VWdDWUYraWhRSGh2UC9H?=
 =?utf-8?B?SW16OXNvS0VNTk8yWmxCK3ZpQ21uazRQWDljVFhjV3pKeHE4djlnQTcyWkcz?=
 =?utf-8?B?NDMyNllGRk4rTFRWbFZyYjdsWFd4TkhsblNhRStQdCtBblZpTEtmM083UWVE?=
 =?utf-8?B?cTVjZmpuWitqalkrS09ESUJWTXYyTCtWV2RVVi8wWU5oZGlLVW1mQjZGR2w2?=
 =?utf-8?B?UjM0cEhoRXArMHFDZDRLUERYc2xuaS83cnorT21EWDU3Z1lpVTVpaGovamtx?=
 =?utf-8?B?OXlGMUxrMHdCb1ZzSGhLQXJROHBKQ3MyQk4xVEIxZldXQ0pFbkYrQWdvV2M1?=
 =?utf-8?B?Njh1YnRkbHFLU1NoMGpQa2V3UXJhbG9PeXJkS1cxTTVVVWI5VG5jQUJQUEtL?=
 =?utf-8?B?OUwyZ3MycGMrZVZmN0M2eFp1NHVBcVJVZ0xNb3IvaTMxTUh6RlNUOFVORmZD?=
 =?utf-8?B?UWNhOUk0VDRZTnJnZDFQRlE3UTFIalBnbWsvTTJKNngreEVyYjZmRlZpZ2g1?=
 =?utf-8?B?d2JUQ0hvaTNTb21tbTVsOW5SUnBoK010TVBYYWsxaURmRUFmam85ZGdiVWNC?=
 =?utf-8?B?VXVyMk9nS3RUak9rcVRVT0JRSkQyNEQrbEdLUktncWVLTFhlcWlkNlExaG1t?=
 =?utf-8?B?Nkx6TG9RNkdqRk8veTFqWndSSGcwTk5PY0FRY2NJcVUybWVtMUZ2NWVrUVR3?=
 =?utf-8?B?cTVjbHJuOHUxc1h3bUNVQU9VVDU1Q3BNcDNUdnpyMmE2Nzltd004d0d3R0Fm?=
 =?utf-8?B?YzhRS0ZVdTJ6RVZTYnZUK1d2Z0hSVmxNZXZHeWVNZEpIWWhIYzdmWmJlRWwv?=
 =?utf-8?B?KzF2VDBFeCtKeVQybktHeDZZRlhnQlhwY1pBMmVZaFd2c2pwRzdTQ3R1TXVQ?=
 =?utf-8?B?TTZORjJKb0ExNmhzVTB5Z1lUK2grZU1BNExwU3Frd1RqdWc2V1V2VUVBYkx1?=
 =?utf-8?B?UFpDdUwrZXZ3dGRlYmNibGdjdW96MmUwNlVBYWdORG9za3hRSUROMWw1YkYx?=
 =?utf-8?B?bjlJUkYzQmdPZWFrM0daUHZxWVNsTDFkZTJmTU1hV2N1WWNhTG5XdWxFVVBS?=
 =?utf-8?B?ODdFRCtXa2Y4eDJtVldKY0ZyeDVJZXFBK3FlbHo5ZjVhSU5JR3hKUTduM1ZH?=
 =?utf-8?B?am5uTzdNM1JHMzVaZkdtVTBSdGhHNE93a200NDQ0V2Z3Q20vOEhXZmF3TDBB?=
 =?utf-8?B?Y1BNSlVMTUEzd0FIcytYV3phTXF3WHV6QkRzVkF1VjM1ci9tc1VvME9yQmg4?=
 =?utf-8?B?OTg3bzFEYktJME9JaHZCZG9nR2RKNm9yaUZWSVZ2VnpiN05EUDlvVXFqLzRQ?=
 =?utf-8?B?aVFyNno5eE52NlVtZ1REcGlSeGJKaWhzTVAzdkliOHFCWXpuWEJ4eHB4cUt1?=
 =?utf-8?B?RnJBQTBocjI2aTgvTjFhc21IYWpabm93RmZhTEI3bDQxWFpIcnJPRXBvOXB5?=
 =?utf-8?B?V2VvV1lwVmVtSEF6azA1Z1VhVFVRK1hBNjdEaVRJV0tIR1VKVm11Qlh4YkRh?=
 =?utf-8?B?SDNMVHRVUlJFa0UxUmNlR2dPa08zSmYrNEI5ODk4dlVjNjFTNEI3NUpsMTV1?=
 =?utf-8?B?WndOV0QyY2hyM1RGNzJKVEJwK0FrVkZEWTVIU0s0V2RrSCsrUEgxMW5QNnJP?=
 =?utf-8?B?YW1TbG4zZkw4azNvUnkzUXdWR3VEc3lFUURaZUZRRTBQT1REWU8yRUhabCtY?=
 =?utf-8?B?UUFmMzRWQlY0RitBdTVQN3Q3U2lucmhENGJyMm9BbnJRWmUwTUlCbkJ3Smg1?=
 =?utf-8?B?ekFWaVhIeWRUam5VNW9DMnllM2ZUS1oremgwQ1JHRGg1WlpWTXR1UVV0U2F0?=
 =?utf-8?B?Q1pVcmVOL1hQTklQRkVjaTdyQmlqdGNOS1lwc2REbHFOWldTRUpNci9TZzFk?=
 =?utf-8?B?bi90c0hnNi94eEt1MnlhcmozRzZORTZZTmd1RHh6czVOTWppNk5FMVFmNXlH?=
 =?utf-8?B?SklaYUlDYzBPR0t6dTA3RTZWZVNLNkVzem1IYzhnNGdQbHgySm4walI3d1Rx?=
 =?utf-8?B?WFE2RDRsZmRTeHZqTHpkK2hXZENhQ0l5b0xuWjRuaUpTeXppQ0hZUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D938310A456C0240ACEADA927EDC6776@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kfhf9y0aF8r7nx0dvEwLZvoshkBFok7uhkYDwuP1KFEwXjvTqK5yvso9RpFt5GtXVXvDh4ASCPE+IMrZ7nHsq3KbE3qimwueUiMjicjGzmcVoK5wCCo4gP3wnH2hSza5CIiVm45NgbxS9atnKJQ8VHVvPFSMCy2zPA0qFbBQLg3Yb5nz5ctNcQNjOuvbDTYZTD6cvK71j3BusVqxyuBuBdIasCvVRtQKZpmbhVI/7WHxlEe05NGKDzSaIbGnpUOW3/5VehQHaXB6cSXaOJar9cPOkfp8FWAjdvPHg3RTpUxonnc7vEkPX9egjhiDDFFE6QGDvvVXJzyZrMSQ7dfrJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a6509-2e5e-4a39-20ed-08ded313ade2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 23:44:20.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFNin7Xmce0S/HbZlJYmaYqp67XbXRksjysdrrYZmZS/X1j+sZjSmOuQZxfiGYUwpi4yyPrswOZgzM1raQXtKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDA4OjMzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIEp1biAyNSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgMjAyNi0wNi0yNCBhdCAxNTowNSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IElnbm9yZSBLVk0ncyBpbnRlcm5hbCAic2VydmljZSBwZW5kaW5nIFBWIEVPSSIgcmVx
dWVzdCBpZiB0aGUgdkNQVSBoYXMNCj4gPiA+IGRpc2FibGVkIFBWIEVPSXMgc2luY2UgdGhlIHJl
cXVlc3Qgd2FzIG1hZGUuICBBc3NlcnRpbmcgdGhhdCBQViBFT0lzIGFyZQ0KPiA+ID4gZW5hYmxl
ZCBjYW4gZmFpbCBpZiByZWFkaW5nIGd1ZXN0IG1lbW9yeSBpbiBwdl9lb2lfZ2V0X3VzZXIoKSBm
YWlscywgaS5lLg0KPiA+ID4gaWYgcHZfZW9pX3Rlc3RfYW5kX2Nscl9wZW5kaW5nKCkgYmFpbHMg
ZWFybHksICphbmQqIHRoZSB2Q1BVIGFsc28gZGlzYWJsZXMNCj4gPiA+IFBWIEVPSXMuDQo+ID4g
PiANCj4gPiA+ICAga2VybmVsIEJVRyBhdCBhcmNoL3g4Ni9rdm0vbGFwaWMuYzozMzM4IQ0KPiA+
ID4gICBPb3BzOiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUA0KPiA+ID4gICBDUFU6IDQg
VUlEOiAxMDAwIFBJRDogODkwIENvbW06IHB2X2VvaV90ZXN0IE5vdCB0YWludGVkIDcuMC4wLWQ1
ODVhYTU4OTRkOC12bSAjMzM3IFBSRUVNUFQNCj4gPiA+ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMC4wLjAgMDIvMDYvMjAxNQ0KPiA+
ID4gICBSSVA6IDAwMTA6a3ZtX2xhcGljX3N5bmNfZnJvbV92YXBpYysweDEyYi8weDE0MCBba3Zt
XQ0KPiA+ID4gICBDYWxsIFRyYWNlOg0KPiA+ID4gICAgPFRBU0s+DQo+ID4gPiAgICBrdm1fYXJj
aF92Y3B1X2lvY3RsX3J1bisweDEwNzUvMHgxYzMwIFtrdm1dDQo+ID4gPiAgICBrdm1fdmNwdV9p
b2N0bCsweDJkNS8weDk4MCBba3ZtXQ0KPiA+ID4gICAgX194NjRfc3lzX2lvY3RsKzB4OGEvMHhk
MA0KPiA+ID4gICAgZG9fc3lzY2FsbF82NCsweGI1LzB4YjQwDQo+ID4gPiAgICBlbnRyeV9TWVND
QUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Yi8weDUzDQo+ID4gPiAgICA8L1RBU0s+DQo+ID4gPiAg
IE1vZHVsZXMgbGlua2VkIGluOiBrdm1faW50ZWwga3ZtIGlycWJ5cGFzcw0KPiA+ID4gICAtLS1b
IGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGFl
N2EyYTNmYjZmOCAoIktWTTogaG9zdCBzaWRlIGZvciBlb2kgb3B0aW1pemF0aW9uIikNCj4gPiA+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gv
eDg2L2t2bS9sYXBpYy5jIHwgOCArKysrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rdm0vbGFwaWMuYyBiL2FyY2gveDg2L2t2bS9sYXBpYy5jDQo+ID4gPiBpbmRleCA2
ZjMwYmJkZGRiNWEuLjM4YmJhOWExMTE0YyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2t2
bS9sYXBpYy5jDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9rdm0vbGFwaWMuYw0KPiA+ID4gQEAgLTMz
NzEsNiArMzM3MSwxMiBAQCBzdGF0aWMgdm9pZCBhcGljX3N5bmNfcHZfZW9pX2Zyb21fZ3Vlc3Qo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiA+ID4gIAkJCQkJc3RydWN0IGt2bV9sYXBpYyAqYXBp
YykNCj4gPiA+ICB7DQo+ID4gPiAgCWludCB2ZWN0b3I7DQo+ID4gPiArDQo+ID4gPiArCWlmICh1
bmxpa2VseSghcHZfZW9pX2VuYWJsZWQodmNwdSkpKSB7DQo+ID4gPiArCQlfX2NsZWFyX2JpdChL
Vk1fQVBJQ19QVl9FT0lfUEVORElORywgJnZjcHUtPmFyY2guYXBpY19hdHRlbnRpb24pOw0KPiA+
ID4gKwkJcmV0dXJuOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gDQo+ID4gRG8geW91IHRoaW5r
IHdoZXRoZXIgaXQncyBiZXR0ZXIgdG8gZG8gdGhpcyBpbiBrdm1fbGFwaWNfc2V0X3B2X2VvaSgp
LCBpLmUuLA0KPiA+IHdoZW4gZ3Vlc3QgZGlzYWJsZXMgUFZfRU9JIGZvciB0aGlzIHZDUFU/DQo+
IA0KPiBZZXMsIGlmIHdlIHdlcmUgZG9pbmcgdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24uICBJ
IG9wdGVkIG5vdCB0byBnbyB0aGF0IHJvdXRlDQo+IGJlY2F1c2UgaXQgd291bGQgcmVxdWlyZSB3
cml0aW5nIHRvIGd1ZXN0IG1lbW9yeSB0byBwdXQgdGhlIHNoYXJlZCBmbGFnIGJhY2sgdG8NCj4g
S1ZNX1BWX0VPSV9ESVNBQkxFRCwgYXQgd2hpY2ggcG9pbnQgdGhpcyBiZWNvbWVzIGEgZ3Vlc3Qt
dmlzaWJsZSBjaGFuZ2UuICBJdCdzDQo+IHByb2JhYmx5IGZpbmU/ICBCdXQgdmVyeSwgdmVyeSwg
dGhlb3JldGljYWxseSwgYSBndWVzdCBjb3VsZCB0b2dnbGUgdGhlIGZlYXR1cmUNCj4gb24vb2Zm
IGFuZCBleHBlY3QgbWVtb3J5IHRvIHJlbWFpbiB1bmNoYW5nZWQuDQoNCk9LLiAgSSB0aG91Z2h0
IGl0J3MgT0sgdG8gbm90IHdyaXRlIGd1ZXN0IG1lbW9yeSB0byBwdXQgZmxhZyBiYWNrIHRvDQpL
Vk1fUFZfRU9JX0RJU0FCTEVELiAgR3Vlc3QgaGFzIGV4cGxpY2l0bHkgYXNrZWQgdG8gZGlzYWJs
ZSB0aGlzIGZlYXR1cmUsIHNvIGl0DQpzaG91bGRuJ3QgdXNlIHRoYXQgZmxhZyBhbnl3YXkuDQoN
Cj4gDQo+IEFuZCBJIHdhbnQgdG8gZ2V0IHJpZCBvZiB0aGUgQlVHX09OKCkgbm8gbWF0dGVyIHdo
YXQsIHNvIEkgb3B0ZWQgdG8gbGVhdmUgdGhlDQo+IFdSTVNSIHBhdGggYWxvbmUgYW5kIGdvIHdp
dGggdGhlIG1pbmltYWwgKGFsYmVpdCB1Z2x5KSBmaXguDQo+IA0KPiA+IElmIHdlIGRvIHNvLCBp
dCBzZWVtcyB3ZSBjYW4gc2F2ZSB0aGUgdW5uZWNlc3NhcnkgcHZfZW9pX3NldF9wZW5kaW5nKCkg
KHdoaWNoDQo+ID4gd3JpdGVzIGd1ZXN0IG1lbW9yeSkgY2FsbGVkIGZyb20gYXBpY19zeW5jX3B2
X2VvaV90b19ndWVzdCgpLCBvciBpdCdzIG5vdA0KPiA+IHBvc3NpYmxlIHRvIGhhcHBlbj8NCj4g
DQo+IE5vLCB0aGUgd2hvbGUgcG9pbnQgb2YgYXBpY19zeW5jX3B2X2VvaV90b19ndWVzdCgpIGlz
IHRvIGRvIHB2X2VvaV9zZXRfcGVuZGluZygpLg0KPiBUaGUgbmFtaW5nIG9mIHRoZSBmbGFncyBh
bmQgdGhlIHdheSB0aGUgY29kZSBpcyB3cml0dGVuIG9iZnVzY2F0ZXMgdGhlIGxvZ2ljIHRvDQo+
IHNvbWUgZXh0ZW50LCBidXQgd2hhdCBpdCdzIGRvaW5nIGluIHBzZXVkb2NvZGUgaXM6DQo+IA0K
PiAgICAgSUYgdkNQVSBoYXMgaW4tc2VydmljZSBJUlEgYW5kIG5vIHBlbmRpbmcgSVJRczsgVEhF
Tg0KPiAgICAgICAgIHZDUFUucHZfZW9pID0gQUNUSVZFDQo+ICAgICBGSQ0KDQpUaGlzIHBzZXVk
b2NvZGUgaXMgbXVjaCBjbGVhcmVyIHRoYW4gdGhlIGFjdHVhbCBjb2RlIDotKQ0KDQpJIHdhcyBr
aW5kYSB0aGlua2luZyB3aGV0aGVyIGl0J3MgcG9zc2libGUgdGhhdCB0aGVyZSBhcmUgdHdvIElS
UXMgd2hlbg0KdkNQVS5wdl9lb2kgaXMgYWN0aXZlIChlLmcuLCBvbmUgaW4gSVJSIGFuZCBvbmUg
aW4gSVNSLCB3aXRoIGRpZmZlcmVudCB2ZWN0b3IpLA0KYnV0IGZyb20gdGhlIGNvZGUgcmlnaHQg
aXQncyBub3QgcG9zc2libGU6DQoNCiAgICAgICAgaWYgKCFwdl9lb2lfZW5hYmxlZCh2Y3B1KSB8
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAg
IC8qIElSUiBzZXQgb3IgbWFueSBiaXRzIGluIElTUjogY291bGQgYmUgbmVzdGVkLiAqLw0KICAg
ICAgICAgICAgYXBpYy0+aXJyX3BlbmRpbmcgfHwNCgkgICAgLi4uKSkgew0KCQlyZXR1cm47DQoJ
fQ0KCXB2X2VvaV9zZXRfcGVuZGluZyhhcGljLT52Y3B1KTsNCg0KVGhlIHJlYXNvbiBiZWhpbmQg
dGhpcyBzdGlsbCBlbHVkZXMgbWUgOi0oDQoNClRoZSBDUFUgY2Fubm90IGV4ZWN1dGUgYW5vdGhl
ciB2ZWN0b3IgaW4gSVNSIHVudGlsIHRoZSBoaWdoZXN0IG9uZSBpcyBFT0ktZWQsDQpyaWdodD8N
Cg0KPiANCj4gd2hlcmUgdkNQVS5wdl9lb2kgaXMgdGhlIHNoYXJlZCBtZW1vcnkuICBUaGUgZ3Vl
c3Qgc2lkZSwgaW4gaXRzIEFQSUMgRU9JIHBhdGg6DQo+IA0KPiAgIHN0YXRpYyBub3RyYWNlIF9f
bWF5YmVfdW51c2VkIHZvaWQga3ZtX2d1ZXN0X2FwaWNfZW9pX3dyaXRlKHZvaWQpDQo+ICAgew0K
PiAJLyoqDQo+IAkgKiBUaGlzIHJlbGllcyBvbiBfX3Rlc3RfYW5kX2NsZWFyX2JpdCB0byBtb2Rp
ZnkgdGhlIG1lbW9yeQ0KPiAJICogaW4gYSB3YXkgdGhhdCBpcyBhdG9taWMgd2l0aCByZXNwZWN0
IHRvIHRoZSBsb2NhbCBDUFUuDQo+IAkgKiBUaGUgaHlwZXJ2aXNvciBvbmx5IGFjY2Vzc2VzIHRo
aXMgbWVtb3J5IGZyb20gdGhlIGxvY2FsIENQVSBzbw0KPiAJICogdGhlcmUncyBubyBuZWVkIGZv
ciBsb2NrIG9yIG1lbW9yeSBiYXJyaWVycy4NCj4gCSAqIEFuIG9wdGltaXphdGlvbiBiYXJyaWVy
IGlzIGltcGxpZWQgaW4gYXBpYyB3cml0ZS4NCj4gCSAqLw0KPiAJaWYgKF9fdGVzdF9hbmRfY2xl
YXJfYml0KEtWTV9QVl9FT0lfQklULCB0aGlzX2NwdV9wdHIoJmt2bV9hcGljX2VvaSkpKQ0KPiAJ
CXJldHVybjsNCj4gCWFwaWNfbmF0aXZlX2VvaSgpOw0KPiAgIH0NCj4gDQo+IHRoZW4gZG9lczoN
Cj4gDQo+ICAgICBJRiB2Q1BVLnB2X2VvaSAhPSBBQ1RJVkU7IFRIRU4NCj4gICAgICAgICBkbyBB
UElDIEVPSQ0KPiAgICAgRkkNCg0KWWVhaC4gIFRoYW5rcyBmb3IgdGhlIGVkdWNhdGlvbi4NCg==
