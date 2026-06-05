Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2D42DFF5;
	Fri,  5 Jun 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646045; cv=fail; b=FNHi9+yi1qHLzKuA+8mT8sIhJiMpw9gQ3NbsXtAOl20Vp6KKA6yRjUNs5ZhCMqpHewKE6YTXCTV/JvnM4SiOVW34lasVDxm2oyJqu5fg334dFPKsBrX0K7PRfjH3F4TT0qQ6hr+/0j9lrbnW3FLBV/kI5XBY5IvTU097Uz94ah4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646045; c=relaxed/simple;
	bh=sC/XX6g/s1WYxFek9mWq/BqjKd+cm6uAlS8C3sM6IrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAk3omtzvVb//cpzPEPTfF3OTPcs0NyGwPxt2l5WdgOQ/0I0ye5dAheYC3gO7Sk0rXK52l2vanEsoJ7xHvt56IO9FjgRuXtN0pq5nLNIP4xFGUcQcy0HuxXJN0dVyQAEu8FMh+HmXHFGR8VEvWKUbUQEBlclR0rhFeXe/YlTt70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pg0OrCZV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg0OrCZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780646044; x=1812182044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sC/XX6g/s1WYxFek9mWq/BqjKd+cm6uAlS8C3sM6IrE=;
  b=Pg0OrCZV9rsymIwzzLxSXrT9zBib5+BSZjBMDzcxgg8EE15+gdHEKe/v
   2WKm5g1XfP/xcIezsD3QVaRDfmbIMezcbRok+0Bk1rENk7QuOY6qHBlhN
   Vyk4bjp6ZvrqTWoQC5hKcxzuVqkf80uRtq5jX91NyV7Y+I2rTSkkehyZT
   YT3TeGHqdx7OCy1bnHGSRrcN6LwxgF0pcHnHlEJgjNB+9xbwpAZUKuHN0
   K3p7VwmPWNe7HoV0Z/h6EoMlkc9g+n9dZhsWFUH4TqqXxBudJnx1reEv9
   ZUUrKVY/oV8qJomv0R61Tt5JYHaB8eQiVB5nuwOm18UKM7Nx4OgsCfB/Z
   g==;
X-CSE-ConnectionGUID: s4JFwSkYQd2ypJkWU447ug==
X-CSE-MsgGUID: Oip6i2cYS0K3omjLC4uSbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80616934"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="80616934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:54:03 -0700
X-CSE-ConnectionGUID: CAd7YdCyQa6TRZ2L1wk0XA==
X-CSE-MsgGUID: RxpbXUVQTuy/vQYSDvUGKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240591772"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:54:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:54:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:54:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIaCR97lBaEV8vv96PcnGXWDtZNtNFdkW6uTFFuWdV72M38gNbIQIpLvTZRq/pCO6A2u+AfafTGUvtLlz7ZFPsGiphbqubnEOnKJTot5dw+rHTy1jTVYSkf/hX7c98XzsmvFcMuVDPk+RGz9fPawC9y9EjpcLGOcwOuUQnEpXyLGXZfwo3QT5+2qiv2BOFtnOtEM1m5vJ9ve09wlbWE/SxtGkeTa65Vne30XuO5X0wlWYFhprf606Efg3X5PUblni/1rR3b+iqoIK094aybrlQYyOletJk6Rnz5Tf+bkkud0CLA4D3NdZPRFM6Plt+6kubv94Tg1pE4rZHGjhnCFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC/XX6g/s1WYxFek9mWq/BqjKd+cm6uAlS8C3sM6IrE=;
 b=D9PAdeL9zGF1GSydUH/Gqj9LaNnXR0ws1zVd/VDUe3Dy7ZijifgxPB525zDI5ZHsLfzBS2U0Yc2tRlLkA/7eQWsu1CpDRnJHgoBDVIA0WJCJtchIouYYZx6oF53ZNVfNSpobgmpPf9WepPECletNPZMuHYOeKJYC5+dO6va/s3TN8Gwo92x1mVrUu5Q1dnoiLTC9Lup6L7zgdLHfkqCTMzqyFt+WuPc5dMUJRlhagJJbWyUCKODHlBZoAo9trN4y7Vqjx9jW73WOIo7zKi5HeSfE/cAFGyBHD31EHIX8atzUsqnABcfsTAmxToYMMHWDn+4euRY+4mb3Sui3UyHSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Fri, 5 Jun 2026 07:53:59 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:53:59 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 35/40] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
Thread-Topic: [PATCH v3 35/40] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
Thread-Index: AQHc77nN58PqZlhXNE+LtKDEdCH6wrYvoXmA
Date: Fri, 5 Jun 2026 07:53:59 +0000
Message-ID: <e4443aa73d658883c657b2fa16e31893452f2770.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-36-seanjc@google.com>
In-Reply-To: <20260529222223.870923-36-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH8PR11MB6832:EE_
x-ms-office365-filtering-correlation-id: 7c85a51a-d52f-44e4-3b22-08dec2d79a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: aaiZS9EZIzBhYpVPL+NHqUBexJQiqmQTLglv0lTBPZaau2B6B5IAEuRUdN8wuQyiVFLpIZ1d4ALDZfYc5e0SSyUnnnm3UZr/rQ1mhS6pCw5VrBKMtFen7Rriq5tqFwWHdryRJqSnPddbQ5uqjGgJ2grreDu/5F4gKvD8ezKRKvi4qF2cS62FuQU7GHHBbBQA1EdDft0Pfg3ITIIsI9P1I59UB5UJtfR/k0LvZ0TU+1waIPiPk+tbooD2mFJbKDIPI02lkEsnBPtxxCE20Ks3valMo4zBXS+3KLCqofcSRVcc1ywiziSzsE/7QIt+6OI8JUYrrLeC9eQuPtFMfVsskhNNdmeE3BjCWPfk3asFCZaYB11nmm42tCUIWW50EOsNToMTi3WVJQzUuiZt5OLxsFiyd/aJVOMzqnBAp7ZDwStrKEutjymVyiT3eCLkPUDqTDZQj4/Jjmk9KRjLjHcxqP6Q1reydRbmQN9wpVmCjyKh5TX7HeqCB94pLRqTgb5qFY4o9vsaNxHePoznituaq2Sp+KjIO2W8RnfFtqwpmHop1YHjbcBkXlRf7eJQXb0f8g4P0voeyPGS09juE/IJT/+Km3x2jZh/Cyg4UOSLGRft3hlpsdj5wyOEKMcVSJaQfRHlZOQtbDAwTMHLzXydXmkQ1IkSJrVc0e4c/GkkzmPl5qgKRhJex7VeL/tXTEPauOasB6eHBqSLW/yT+cgWwVzFy29D8yAwbUYErmu3d1YO07bxUuy/P6JqNzndrwh2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1lMlJKY0w0STg0d3JPYnZwRDJEQ0lQOEI2Tm9zVjd3M0FzRWhCdnNSd0FM?=
 =?utf-8?B?SFRxSDB4clJYMGRVSW85SlorMEducnV5b2szNkR3RkFPVWZ5Q3lzcWF1Y2x3?=
 =?utf-8?B?Umdtb2JuanJsaTduVlUzak5EMzUwdzBFQzFPNUpqUnh5U1JVTkUyNi9wblBB?=
 =?utf-8?B?NXMwcXZRQ2lCMGhha0JaOW9MMWVVNlJhbUt6dmZ6VGNNRHQ4bnBQWEVNVDV6?=
 =?utf-8?B?bHdsSlJiSW4wSGpkYi95L3dBU29aZDRldkhrdlV2N2JxN1BYbkZSck5IUU5z?=
 =?utf-8?B?WnN6MXpTR3VackkzZWgzWjZsNUFnUnIzSVdrVVU4SjVZU0t2NHhCLzVOeDB4?=
 =?utf-8?B?djJIbU9sV0l3Y3VZYkRzR0Q2ZmZmTFN4REEyWUlPR2krNzFxT2RGRkE5c3BB?=
 =?utf-8?B?dlZHM3RaWm96S3FxWEtvTlYzeHkvVVYyVmRnK1VpQVRxVHZOaHkrV0NPcGp5?=
 =?utf-8?B?VVNucFRtVEhVUkVpUkFrb1RSRzUrQkZjZDFBRWhnOFJoaXJYWCtGd1V1U0c2?=
 =?utf-8?B?OVFzQWFvQ1pRK3FIelFDbGRHT1FPUVpMNU1mYWJhenJJK2M2WkFqMDRIMDJm?=
 =?utf-8?B?REhYakh4MUsrSlRTbVRyRG1saUNFY2ZDUUFQakxvNlV4YzUvVGh0cS9qWDBv?=
 =?utf-8?B?d0VrWUpubDIyNURaOEhScmhaNDdTRTFnNjZPb3owOWNjTzlEYUF2Z2FHaWZX?=
 =?utf-8?B?V1JOQ2lLSW5DWE0ydklXN3BURFdrLy9UOVBZM2NwS2FVOVMvOElBVGcvWTk3?=
 =?utf-8?B?elNrOEYxZEpPMHRHTnBwalVsdUhwRXdwRmJKT1RLemJRQmVHbmhqK1ZJTzZn?=
 =?utf-8?B?Zmt6aXBkRzVHZUdlREV0SWxVYVoxVnlLMTFYbkFhNkJpK3IyOE5aY0RRSUNi?=
 =?utf-8?B?WkdUZXdpUDBiazBOM0VWK21kZzY1QWZqSlUwTEV1VWt0d2FtZjQxV3ZRSWZ6?=
 =?utf-8?B?SjB1RExjckYxc25HZ0tMTCtlN1V2SFZwZ2hFTXNmTDRCN2NveThSOGhnOVhE?=
 =?utf-8?B?S1hjRGYwSFRGQ1BQUFhHV1ppUnZBQlQ5b2hNZ2M5WnhLd1lxcjBiMGRqcDls?=
 =?utf-8?B?L24vSnFqd3podTltemdFbGhSbmtWSGMvaG11dUdzOVdjejF2QW1LZC9CQXhr?=
 =?utf-8?B?VUFKZU43R2hOTnVZbmFsMzNocjJ1RUZESGswUjJhRGlLOURaQ0J4SldscDBU?=
 =?utf-8?B?V2ltb1hDK1VYMDcyYnZ1Q1ZBcG5FSUh1VkxiTFhxWDR5TFk4NGxpc2Mwa0x6?=
 =?utf-8?B?YjhIUkhkVGwyUEoxSCt0ZStXSWxWWFZLam1mcDI1M25wRGxvcWxlelVwdUFk?=
 =?utf-8?B?NXBiT2hNNDcwTnpGYUFsSm5qeUFERHVGZGJBTE16bkNPcWlhVWplTHBzUGIv?=
 =?utf-8?B?cXhmY2N1U2czY3FSZlpJTURYNGZQdE1SZ25GUEhGYksrNFdVZXlNYzEzeEFU?=
 =?utf-8?B?OW9LbVRJYmU5eVlUS0xvK25FcWJkeHgveDJKcHFGNkZ0aWQ4MWFsNVFDZGIr?=
 =?utf-8?B?RXFSQ1JPVU5BekZnM3JyblJRWk5JTmw1alNNSU0rKzR1YnJrVWI4YUgrbERV?=
 =?utf-8?B?cGJocWp4TW51L3hpUFIxRG5CdVVOTklRajZoVXhueGZIUzhzckFYYUtobUNv?=
 =?utf-8?B?QTlic3dFNWI5VElWUHFZUXowenFodW11VU9XOFBUWTh6WVhQMll1dFdnRGt4?=
 =?utf-8?B?Y0lkTlNnOC9hQmpEL3VjSUxqNDhNblBKUEhUMVVDd09LYm9rMDBscEZuSDlW?=
 =?utf-8?B?OFp0NkhCWCthaWJ1QUFqLzg0VHB0cCt4czU3Mm1JODFDUDJiMStQUWRhVDdG?=
 =?utf-8?B?UkhHcytMVk1GeStqTUhsdlA2aTJRWklObCt6T2JScE1rMTFWU1BOcnloc05U?=
 =?utf-8?B?K0hnTFY0NDV3NnRQek9zQ20vbTV5V2l6OHhBc3c1eVBvSE0rd3FOdm9VaFp4?=
 =?utf-8?B?SDB1Smp0NnpoZnYwQUdSRGllZ3BDVitWY0NIZWJBUkNXMVAwcG9LaE1qbWU1?=
 =?utf-8?B?ak1IYks0M2k3R1RnbGdoTWhyaWM1QnNxQ0lzbURqUFE3a2RzQUovNzhhWGhN?=
 =?utf-8?B?QXUwWVZKYUtZSk1UcmdIbnppaS9TSmc5RlBoRHd2ZmVjZ1pKeEtsN2dJSjZ2?=
 =?utf-8?B?RUVXN2hlYjZoYzZYR0VCaUxWVWFDUWhIazJFVnBycklMTytWR0o0RHFZSENt?=
 =?utf-8?B?QXZFOXJuc1VIWlhROXhOVjhUV2NlTUtCck1NTm1nVXlqa0h1WHo1b3JjdjQz?=
 =?utf-8?B?aEJvQms5VC9ZL1FHMi9UazNWbXB6ZmxXZVk0WVRVR3l6M2JTNmRIZTRhbWFk?=
 =?utf-8?B?cTJXcytjd3RGVnNNb0EwZ1VidnAvd0JwdUNxRWRpT256VFZQTnlXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B55743B261324046A3BBAC558AF94AF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: byFnfvNJLmGobZMnV1CoxwQTXrEiGfEQFi84OeIQ67CwxWaleukjll/UofWM9cL+t3LZFLbsr8QiphAAcwutzZV1Kit+UVlXDYgKaKKvUeCkeK5k4Z1McHEsCn35kwl1mZlvRvRmEc3mC2syoexQUwQt37m+/afLmVdt+UIeLFgcnnwfXX7HiMK5ydQL9UsAbFgA7v6t1oN6lCny8tlk7LqKj/tnwQcut0jUARF7B/HtU2916SWuKRf8MpbzF+EtUuhYhOAqU85v/d6Bd0DSX3dTelPl6Xktqi7cL0i2ivrVTrmuo1eDdYEBi6QgTc9wiFxT4W/czM5rJQQiX8iHgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c85a51a-d52f-44e4-3b22-08dec2d79a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:53:59.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7e412px7QnzRTC8lRV4hbzu6AyrrXxQirzefdlSsIGMbBSPUmEOWQ4uJQLuUgCZ50xpndPmDT5ScBX+h8CB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBCdXJ5IF9fa3ZtX2lycV9saW5lX3N0YXRlKCkgaW4gQ09ORklHX0tWTV9JT0FQSUM9
eSBjb2RlLCBhcyBpdCdzIG9ubHkgdXNlZA0KPiBieSBQSUMgYW5kIEkvTyBBUElDIGNvZGUuDQo+
IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
