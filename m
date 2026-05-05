Received: from smarthost4.eviden.com (smarthost4.eviden.com [80.78.11.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58838E5C8
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981157; cv=fail; b=McE5FEWuk725Exh+Anxhxp0JFpFN3axMCy8mjZ5sGEIFI6Y3dVzkLwuA32bQm1o0wKWqtDnwteE0yQRWGGJj5Zk6OJYwJxeMSqJAVn+3oTQQfjZkrC0jmsxPBmrYm1EqFKiXAC3z2APLkzDNFZErGCAHpWqaApq/iyFuOSgGnQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981157; c=relaxed/simple;
	bh=ipVF5OxKWuns6Ie3UlzRlrIxB1sBtn1cYo8y2ShgGJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/eaRHh8kA9kEAlIuGQTPReg11PqKiCd6BZRIdQgjSvn1ZyoQZ4MzXtB2eF7B5uplYg1q1YNCkWtM9CdDxPj886s4dR6XkoS3nAhaMddPhwpK7Dl+fEUloMxswrYWDXJQ9RbgZWUhmgKTMuJON0VYioQ20/OwEzdoiSmkNFP0oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=PNeKXaM/; arc=fail smtp.client-ip=80.78.11.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="PNeKXaM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1777981153; x=1809517153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ipVF5OxKWuns6Ie3UlzRlrIxB1sBtn1cYo8y2ShgGJU=;
  b=PNeKXaM/cfFFd5s1qIyWA5olFKnNnhSGteevT7rjfr48631Z6AOrW0Zq
   Jb139Q5npOcpoONUcfaTKrYBFit9fYmWvzLpjCQR0/sqRKHXAT+QSy/y9
   5QWa2HpZZk1uFSj/1QhsWEbkFByZB/w9fXDkHbqTPfqTXqWxaq0/uSAl3
   evviZyfOYOHams9uW+XlhSY0X4e3LVxK5k1XHqaSc/eCOGnYwO/EfFnE/
   gYyQJPb80FoJgJmzDKDnPyWh6YkRU4V+4hjLENkVEidHFlRrPJJNhwUte
   pj4vA42BO3zbbLEu0pZrOsGNtj0HHWfwMS2B/UbRHl2lscR/4h9NdxLLp
   A==;
X-CSE-ConnectionGUID: 8nChmbG1RwmrSfHoi+oN/g==
X-CSE-MsgGUID: XLDGi2hUQbWgZ5pNITfmzw==
IronPort-SDR: 69f9d6dd_fWfqTeb5smIGst2YfhS08zRA+9QLRFGRF5zM5VgNmwIdpVR
 wI23t3z+g702/h+rwP/5JjULCayMOFzvMgK0ZQA==
X-IronPort-AV: E=Sophos;i="6.23,217,1770591600"; 
   d="scan'208";a="49971849"
X-MGA-submission: =?us-ascii?q?MDE732I9Gu1hzncSll30VcdGjzlpiFvBMHnV5V?=
 =?us-ascii?q?am8zPWd4GmEmL0EpRfIAu/Zgi5Wg5dOPm8vXFqpXUDp/U4P6MD3PKOyQ?=
 =?us-ascii?q?uQANQMCY/9hsRMQauTXSFCIE3KrrH+i8j4/1f4Imdlh7+RcHYprSFVC6?=
 =?us-ascii?q?+GA0EaFc8I3Lo4ELChVImpYQ=3D=3D?=
Received: from mail-francecentralazon11013018.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.18])
  by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 May 2026 13:39:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1lKfZfXdfGLMawL7ldka70oRzmDNMRcwyJto9VNPz5HxfXHzkYdL0U4GY9HHT2w0TvzZROXc8jn/dJM5C4Gnt9saEzEKWRZhAjptPApAVHz3YZaHXZmry+UcDnhUdzmZMN9PCN0bMWuBqXBzzICIifTcxY6/G0jylkfEnWQlXvWm+5c2SGbNwGdE6SzFKjMkLwnPlzSvGBY3Y1y9IhDA0Y/ZqYD3FxcDKO0aLDSolgKUr18cs835DvmwrU2US7hntuaO+86pwmLXlGCgHVyDr0394o96IWwThToVZK7ZvfY9vCd4b2f5+QY9HnAQh/jPifXStoqn5aaR3u7lYzbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipVF5OxKWuns6Ie3UlzRlrIxB1sBtn1cYo8y2ShgGJU=;
 b=lBft6YapHp6OcdajrRpG58s/WbtZ3RRBTuEDM+5SXbTZ2R2rQN1ONvYumaFpwhID/pINfPIjcfDAMe6nWDWoPSzhLWu5KlGAXcpa/qI3FW9nL8brFWHhkQgpwokglxMuj7v/HxLedeAfaFRSMgNLAg6hHmvEGuhWzvrINt201Q0pCufPMydOvRoSu73pIBfe40lVSu7zzOrlxzK1vuXZ8X2WwVGFEih2O8fF4PPfkCn+W0hs2x7hgBo8mvXLWugrjSIkSdUHkHyiK927rIfj+HJSfW88MP9nRAw0ILQRgCqGob7qYSF/dIOmXun/1xc7TGygTmv/iP70mB+efK+A+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AMBPR07MB11303.eurprd07.prod.outlook.com (2603:10a6:20b:6f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:39:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:39:06 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
	<clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
CC: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: intel_iommu unit test is also failing
Thread-Topic: intel_iommu unit test is also failing
Thread-Index: AQHc3HPmLdBmXv9RqkCVNWPmcI+ykbX/OZmAgAADDoCAAAVYAIAADHSA
Date: Tue, 5 May 2026 11:39:06 +0000
Message-ID: <4521a81e37662cc0c601e2db361405e667a2416d.camel@bull.com>
References: <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
	 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
	 <afi_HNJoObF10rwz@x1.local>
	 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
	 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
	 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
	 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
	 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
	 <20260505061927-mutt-send-email-mst@kernel.org>
	 <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
	 <20260505065122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260505065122-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AMBPR07MB11303:EE_
x-ms-office365-filtering-correlation-id: 202a059f-f2dd-47d9-b3e3-08deaa9aea18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 s++urPPG4dKoRGC0vcK5BqFq9NQXxRrQtnv3fAl/9d7RD+15Xh6eo9m3KVEXtHXXwWFUVen9bHt6zwx8UBFH/2+iHK7A5V0gAVScEu3oyo9jHc2pfvYEa4lcF+7JoAFdRuhWvDSZTnoWStjzuJKbYMppr9S4CySqvmQlXg7iOsObh1D1CwtczDsjpn5yDUj4qBgmoIQ63kj2IP3yHL4kd8pQGto0CZN7hKrPqngw1R3kygW69jM1O6cuurLm/oFmAN+2iJ3LFgY1td2RFq4VKthC1hGpU+XKBBghajs0/xLT7HmkrKjQ4/1YXyQTNk28WCE5quvxhaBfEAlNF6eDtwr8Kqf0xjLUAheFJchK0EvHEhtNO5QIgS5ARuHOnpF93rCP+NNE3fatMqkGlKsOZJtvTuADjFSk9bTDLXjhbrXzRq6d6TOAOrb5L3Ic2kiES9/YHqt8gAlxaJnF2nvdD7GteVP8Cbs0izIU1CWaYqvaGEWTbIRpHh5PsdLlyY4d3Q4W0R5/T8C5jMi3rWHDLggQfYGIOuv4bxCH6P29qf6Db+ucZtXprAxwxUYaENN97GvbWUGVz+nF4qxm5JSTN6fk/Bdl5/HK/6I8vGxIuTEzEXN39DDsS+ytxzMXhQ04/9XWdtN9MGNHFx6+Ot0YShMLzYKWaovl/fL5TXMLO8i5Gad9poCIugmscBaqPoa1EX1ciOvdJxWzOnHPEdcFiLzEuQxzkhchqBYwSerz6CCuEbWt9ZNT8AEyDt/L7nY0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7602.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHpkV3MvYmVPM2JubGVJL3RJc21raEs3dnRPcGtJZlVybkQ0bnlJZjFpQjY4?=
 =?utf-8?B?aEQ0OFZUd2pXNFdUazVPdStrSFpLYmkzbG9vRFAwU2VnczVDUWpWU1pmWmxG?=
 =?utf-8?B?VmQzcE9FNUVnOTJQWHZjQ0FtZEJyTWdjdDFZbzR5a3JDaitReisxMGpaZGor?=
 =?utf-8?B?Y1pEZTFCMkhtYjhLTDJ6c1FzVXBSM2tHaTc4UXU3QTM1QjZEaHVQUXJldmo2?=
 =?utf-8?B?bHVGWjR0VUlPYUNwMUs5L1k0KzNrK0N4YjdhUi92UTZuaXpJeEZURlNPWUti?=
 =?utf-8?B?VTVWdzlXNFd0Mmd2M2orMnkwR1Z0L0ZRNS9hUlFqNTM4ZkFzcTJZYkZIWTRT?=
 =?utf-8?B?RGQrU1BtL3ZNSi84cmRnUHJwa0tEbTh5NGFHREZGWEFtTHZuQU5sMm43UFFv?=
 =?utf-8?B?bHRnY2RsTzhSYWVuVEQzaGlZb3U1SVRMUFlqc0I0WjYyWStuWFFhWnU2RmZ3?=
 =?utf-8?B?RUdHb3ZzeFNLaVkyTkQvcThsTWVUbEg3RTNTckVVdXlmait4cmVIUjAxT2pG?=
 =?utf-8?B?blYxOVZCS3NxbzhZSWorc1Bnc0pVa2N0U3FrRTdLWDZldURJdGExSDdMbjRa?=
 =?utf-8?B?aDU5enl3UWsvc3VXb0NuRTNIRVp0T01KZjVPWXdiWGRmdVpoemdFTHd2bVEx?=
 =?utf-8?B?RzF1c2pHOG1QelJLS0tlMCszdjV1WjlUMWU1aVk2K25LalVLa2w2ZzRrbTJU?=
 =?utf-8?B?WnBqVWdMTFFISzVzM0k4YUJjTnovWU9qd2I0M2xFVHBHSHVES3RJZitNQk1B?=
 =?utf-8?B?TDJRcVhnOERaQis1ZldreEkyeDdNcm80NGdNZnR3ZmtKVmgvSnhBSVJKb01l?=
 =?utf-8?B?TlYwODhBSXBlV1FYQXBiNlo4ZlQ3WGROYmJSRzNEbFArMmMva0xGUWl6Vitj?=
 =?utf-8?B?R3J2T1Fsb0lEZ2s1QTJMVFdBQjlieUNPYVNLSnI5V0hGZzFNa3BrWHl4MnFl?=
 =?utf-8?B?clQ1UWIzUFYrWSttZTlFcWxxOHN5SkREVWpTc2toNVF3c2lnQlNyY1RqN2lH?=
 =?utf-8?B?SnZrVFFRaGpockJRT2hxeW13QXJjbVBMRXpUaFFRam9QWWQ5ajU4QTVTb2Nl?=
 =?utf-8?B?UG1ELzNKYmZOSXJTeWFGOEp0TUhmQVFxZC9zU0duZ3hjNVdYVUpCQmRSbGdK?=
 =?utf-8?B?ZjJXeDBSRUFDcXZiRFdycm5kTUdOYU16TitMRjZwNytLT2o1V2NRUEtsRWww?=
 =?utf-8?B?dmVwOWF4ODBqaVZIMWdhQUoyS1lIOEkxMS81VU82YW9qdXA2a2s5ZFdkaExu?=
 =?utf-8?B?NFJQdVNQL2FpVlVhTHk4ZWFhaUVLbzFITlpPRi9LbTJMSEFSVSs3U29YVVFV?=
 =?utf-8?B?c3NLM1lCclQ4cHFCQzllVWR0Vnc2a3FVeVFnVDJxUnlnZWo5WHN4dExVa3dY?=
 =?utf-8?B?Vm1uck54QmxSdW1OY0FVTG9GeUdFZ1YzUVloZnlJdk5CTmg4REdjaXp4Z2Yy?=
 =?utf-8?B?SmFOVTV5bVREK1pRQXhGdEZ2QTRIdUVCWFFtNll2VUFnbnBNQ3phZlJvR21r?=
 =?utf-8?B?MDJYSk56MEVoRHhXQmdBYVVhMU4rMWI1RUlwdXpyS0JadkJHVUYyMFJXS0V3?=
 =?utf-8?B?TTY0c0pPUjN6NXZnUlAzTmN5S3FMdTJQbzUzSzVseWFSZVh4TDNacWdDNDMw?=
 =?utf-8?B?WU9SeG5YVHcrS0dQalhWZm85NERjTE9HUjBHcFNza1ZBb2ZsNlNIdDQxbmk2?=
 =?utf-8?B?a0ppZTQwQUZ5bjlHYThMY3ZUUm9hVnlOMXVQK3g3a1A4UnpBNS9Fb3ZMN2tG?=
 =?utf-8?B?Zldyckx6dWFBakpVVy9YeStOOGdrcFlyRXN3anNBRmNLREFCdWdBUlZaSWFw?=
 =?utf-8?B?Yk1BN05vWHorVnFMK2hmQ05ubGNtL01xczV1OS9rVmlBditiSWZKTG1ScWk4?=
 =?utf-8?B?aG81WDJIQ01NMWsycUF1SWNsTWFrWXlieWY0ZnJGYmk4aGNNY05FZmthWEdv?=
 =?utf-8?B?elpCaFJoUVdhM3pFZmxPT1M4bTZuVFJRT0EyazZRbHJBN2h0dThpT2hYKzBI?=
 =?utf-8?B?NnFabWFvbWpwVU9LUXdqVzZVNk1sLy9LNVF5VklDTVdEV0MwSzE1cEVFZGw5?=
 =?utf-8?B?M2Y3Uk9TZWZWSStWZTE3QnM5b3lvK1dYcTJvWXhHUnp1SUVFbHM5VXBmZEpL?=
 =?utf-8?B?N21DVEhzWUR3K0pWMFA5Ynh1SitPLzlTY3E3U3BLYjR3ajVxMU5HU2ZaVmJP?=
 =?utf-8?B?dGd3NHFoQ3FxNW4wdjJnQ2pHY3A2aW56RUlzdm1PSXFzNkJaMVF1M21tbHNF?=
 =?utf-8?B?N0k3d0hXdGhxNUZleTdPTGZMeldaVGs0cm1wQzRPdVNQeWJyYUNsclo3MlYw?=
 =?utf-8?B?RUhscUwwV1JBMkRKelpDYWdBY3dLK1pJVk5wU2JvdFpBSnpqMGtNQlJLV3M4?=
 =?utf-8?Q?/pxTDKr9IUGk1alHqC3IdZaorERPAUKjLdgQW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <831421475327F640BD5BA72006BD8A58@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hq/spi19nprUpyPJAHbkdbeVvivBplMQ74fpG/OHmfHsEWMw9xXDM2nlGCaTCQPtqRbNYiZcWZsgQk2rLgnbpPoQ93TuKtzNQh7WQDr1rtVL2a0Dq4ze2aY8noB7I2klgrgEErmxVynoUuD/G+S0a+Zhs3h+0tPqzgZBjamN8ar45kSAdM5/2gBpLfQ1hhysESVuSJeuDkOgqgYgrgRbxngMTw2T5GdNVJqomf8A5Q6Qh5I/kqgF9ySm3UkGJhvXt3J0xUrnkPLFu5SpEMaf7xRdkDapHGkyB2mdIcuH2nbjqnjvFxtFEv0oVxnnbtnjQ1uMZd343VbHrzCKjeYy+w==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202a059f-f2dd-47d9-b3e3-08deaa9aea18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 11:39:06.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YP0zpNGTVYjvd5MVnXjVM6gW+KwN8haNP09K6pciXxmOXRumIxcVFYKzUV1+Nbw27xY8IHcjI2St71qzc0QYtqbhboqlfz4yPNcnk592DhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11303

DQpPbiBUdWUsIDIwMjYtMDUtMDUgYXQgMDY6NTMgLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBUdWUsIE1h
eSAwNSwgMjAyNiBhdCAxMjozNDo0MVBNICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4NCj4g
PiBPbiAwNS8wNS8yMDI2IDEyLjIzLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4NCj4g
PiA+IE9uIFR1ZSwgTWF5IDA1LCAyMDI2IGF0IDExOjQ1OjE3QU0gKzAyMDAsIFRob21hcyBIdXRo
IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gT24gMDUvMDUvMjAyNiAxMS4yNywgQ2zDqW1lbnQgTUFU
SElFVS0tRFJJRiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBJIGhhZCBhIGJpdCBtb3JlIHRp
bWUgdG8gaG9vayBpbnRvIHFlbXUgdG8gY2hlY2sgdGhlIHJvb3QgY2F1c2UuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBJdCBzZWVtcyB0aGF0IHRlc3RiIGlzc3VlcyBhIHNpbmdsZSBieXRlIHJlYWQg
KG91dCBvZiB0aGUgdmFsaWQgc2l6ZSByYW5nZSksIGFzIHdlIGNhbiBzZWUgb24gdGhlIGZvbGxv
d2luZyBicmVha3BvaW50Og0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gYGBgDQo+ID4gPiA+ID4gVGhy
ZWFkIDYgIkNQVSAwL1RDRyIgaGl0IEJyZWFrcG9pbnQgMiwgbWVtb3J5X3JlZ2lvbl9kaXNwYXRj
aF9yZWFkIChtcj0weDU1ZDcyODgzY2IzMCwgYWRkcj0xNTIsIHB2YWw9MHg3ZjYyZDI1ZjQ1OTAs
IG9wPU1PX0JTV0FQLCBhdHRycz0uLi4pIGF0IC4uL3N5c3RlbS9tZW1vcnkuYzoxNDczDQo+ID4g
PiA+ID4gMTQ3MyAgICAgICB1bnNpZ25lZCBzaXplID0gbWVtb3Bfc2l6ZShvcCk7DQo+ID4gPiA+
ID4gKGdkYikgbg0KPiA+ID4gPiA+IDE0NzQgICAgICAgTWVtVHhSZXN1bHQgcjsNCj4gPiA+ID4g
PiAoZ2RiKSBwIHNpemUNCj4gPiA+ID4gPiAkMSA9IDENCj4gPiA+ID4gPiAoZ2RiKQ0KPiA+ID4g
PiA+IGBgYA0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBPdWNoISBUaGF0J3MgYW4gZXhjZWxs
ZW50IGZpbmRpbmcsIENsw6ltZW50IC4uLiBzbyBHQ0MgMTYgaXMgInNtYXJ0IiBlbm91Z2gNCj4g
PiA+ID4gdG8gc2VlIHRoYXQgd2Ugb25seSB3YW50IHRvIHRlc3QgdGhlIGxvd2VzdCBiaXQgaGVy
ZSwgc28gaXQgb3B0aW1pemVzIHRoZQ0KPiA+ID4gPiBjb2RlIHRvIGFjY2VzcyBvbmx5IG9uZSBi
eXRlIG9mIG1lbW9yeSBpbnN0ZWFkIG9mIDQgYnl0ZXMuLi4gd2hpY2ggd291bGQgYmUNCj4gPiA+
ID4gb2sgZm9yIG5vcm1hbCBtZW1vcnksIGJ1dCBub3QgZm9yIGFuIE1NSU8gcmVnaXN0ZXIgOi0v
DQo+ID4gPiA+DQo+ID4gPiA+IFVnbHkgd29yay1hcm91bmQsIHRvIGZvcmNlIEdDQyB0byByZWFk
IDMyIGJpdHM6DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9saWIvYXNtLWdlbmVyaWMv
aW8uaCBiL2xpYi9hc20tZ2VuZXJpYy9pby5oDQo+ID4gPiA+IC0tLSBhL2xpYi9hc20tZ2VuZXJp
Yy9pby5oDQo+ID4gPiA+ICsrKyBiL2xpYi9hc20tZ2VuZXJpYy9pby5oDQo+ID4gPiA+IEBAIC0z
OCw3ICszOCw5IEBAIHN0YXRpYyBpbmxpbmUgdTE2IF9fcmF3X3JlYWR3KGNvbnN0IHZvbGF0aWxl
IHZvaWQgKmFkZHIpDQo+ID4gPiA+ICAgI2lmbmRlZiBfX3Jhd19yZWFkbA0KPiA+ID4gPiAgIHN0
YXRpYyBpbmxpbmUgdTMyIF9fcmF3X3JlYWRsKGNvbnN0IHZvbGF0aWxlIHZvaWQgKmFkZHIpDQo+
ID4gPiA+ICAgew0KPiA+ID4gPiAtICAgICAgIHJldHVybiAqKGNvbnN0IHZvbGF0aWxlIHUzMiAq
KWFkZHI7DQo+ID4gPiA+ICsgICAgICAgdTMyIHZhbCA9ICooY29uc3Qgdm9sYXRpbGUgdTMyICop
YWRkcjsNCj4gPiA+ID4gKyAgICAgICBhc20gdm9sYXRpbGUgKCJcbiIgOiA6ICJyIihhZGRyKSk7
DQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIHZhbDsNCj4gPiA+ID4gICB9DQo+ID4gPiA+ICAgI2Vu
ZGlmDQo+ID4gPiA+DQo+ID4gPiA+IC4uLiBidXQgSSB3b25kZXIgd2hldGhlciB0aGlzIHNob3Vs
ZCByYXRoZXIgYmUgdHJlYXRlZCBhcyBhIGJ1ZyBpbiBHQ0MNCj4gPiA+ID4gaW5zdGVhZCwgc2lu
Y2UgaXQgc2hvdWxkIElNSE8gcmVhbGx5IG5vdCBjaGFuZ2UgdGhlIGFjY2VzcyBzaXplIGZvciBh
DQo+ID4gPiA+IHZvbGF0aWxlIG1lbW9yeSBhY2Nlc3M/DQo+ID4gPiA+DQo+ID4gPiA+ICAgVGhv
bWFzDQo+ID4gPg0KPiA+ID4NCj4gPiA+IFdvdWxkbid0IHRoaXMgYnJlYWsgbGludXggZ2VuZXJh
bGx5Pw0KPiA+ID4NCj4gPiA+ICNpZm5kZWYgX19SRUFEX09OQ0UNCj4gPiA+ICNkZWZpbmUgX19S
RUFEX09OQ0UoeCkgICgqKGNvbnN0IHZvbGF0aWxlIF9fdW5xdWFsX3NjYWxhcl90eXBlb2YoeCkg
KikmKHgpKQ0KPiA+ID4gI2VuZGlmDQo+ID4NCj4gPg0KPiA+IEkgYXNrZWQgbXlzZWxmIHRoZSB2
ZXJ5IHNhbWUgcXVlc3Rpb24sIGJ1dCBhZnRlciBnb29nbGluZyBmb3IgIkdDQyAxNiBsaW51eA0K
PiA+IGtlcm5lbCIgaXNzdWVzLCBJIGRpZCBub3QgZmluZCBhbnl0aGluZyByZWxhdGVkLi4uIHRo
ZXJlIGlzIGxpa2VseSBzb21ldGhpbmcNCj4gPiBzcGVjaWZpYyB0byBrdm0tdW5pdC10ZXN0cyBp
biBoZXJlLi4uDQo+ID4NCj4gPiAgVGhvbWFzDQo+DQo+DQo+DQo+IFRoaXMgc2VlbXMgdG8gYmUg
cGVydGluZW50Og0KPiBbaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9PcHRpbWl6
ZS1PcHRpb25zLmh0bWxdKGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvT3B0aW1p
emUtT3B0aW9ucy5odG1sKQ0KPg0KPiAtZmZ1c2Utb3BzLXdpdGgtdm9sYXRpbGUtYWNjZXNzDQo+
IEFsbG93IGxpbWl0ZWQgb3B0aW1pemF0aW9uIG9mIG9wZXJhdGlvbnMgd2l0aCB2b2xhdGlsZSBt
ZW1vcnkgYWNjZXNzIHdoZW4gZG9pbmcgc28gZG9lcyBub3QgY2hhbmdlIHRoZSBzZW1hbnRpY3Mg
b3V0bGluZWQgaW4gU2VlIFdoZW4gaXMgYSBWb2xhdGlsZSBPYmplY3QgQWNjZXNzZWQ/Lg0KPg0K
PiBUaGUgZGVmYXVsdCBpcyAtZmZ1c2Utb3BzLXdpdGgtdm9sYXRpbGUtYWNjZXNzDQo+DQo+IGlt
cGxlbWVudGVkIGhlcmU6DQo+IFtodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3dfYnVn
LmNnaT9pZD0xMjIzNDNdKGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dp
P2lkPTEyMjM0MykNCj4NCj4NCj4gVHJ5IGRpc2FibGluZz8gLWZuby1mdXNlLW9wcy13aXRoLXZv
bGF0aWxlLWFjY2Vzcw0KDQpHb29kIGd1ZXNzIE1pY2hhZWwsIHRoZSB0ZXN0IHN1aXRlIHBhc3Nl
cyB3aXRoIHRoaXMgb3B0aW9uIHNldC4NCg0KY21kDQoNCj4NCj4NCj4gLS0NCj4gTVNUDQo+DQo=
