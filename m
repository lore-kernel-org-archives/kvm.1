Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AB36CDE0;
	Tue, 31 Mar 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953277; cv=fail; b=jwqWHPZyjinNdb/znp+BoM62JH+d88nezHNdEYx7upceI912WszuO0MDjZPP4nCqyAhlUbGncgYdyPBhIZYV2eWM/xojmCQZefeurGq/UuXeJR6Emq/SS5IkzUvJp4cNsJqe39sbeuOkxkprv+ir3MHY529jRnwU1kVQ2+BvpMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953277; c=relaxed/simple;
	bh=0WKIPxIHukD2GaEKsgLWbnADhx1YSTNCUzgevEx+2lQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bc1Z9ekWnVoTQWASNE7+XiRu92PmaE+8GbmpigJr70PRs++VEnxJwOztadYlZQ5HSVF/NjI3j434nMdAgJGohacNnMCWX54JK1HrtNgL7dQbt67SQsoDotzmaxxP8bwqwfqOOUdzysJHYBRpq4JMg6gk1EnZeMfTbJr+LL6thJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAaK/Dt2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAaK/Dt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953277; x=1806489277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0WKIPxIHukD2GaEKsgLWbnADhx1YSTNCUzgevEx+2lQ=;
  b=YAaK/Dt20L6yl6W34BOSCqf+vq2pT9cItPJ8xRymO9/upnmO8mBFaTZr
   OGFGZ3uaZYpaVvAKBTiSKUj3xLiNg0Lp3itnst29RuAqDa9EqAl8haaBd
   m2ZufcI32/csU6pgLjPWrtNLN++6MYkfuTLl2x2viUarkfqfK41tC1BmD
   d2xkX0Wa7oGbMU+jSQ0Fum4GIVFl54NTVSwdeg2HTpXPnU8ZEqj9Qgp4y
   80JCMXWFIp7pUrlKsDCHc50BgvorRHplcxx6ffHckc4OEbqzvPybJRoAq
   MLUVjgE61uf8Psj9Jbj6aR8cxxFu8tIToknF/3IlmZca7rZCm88NvdHU9
   w==;
X-CSE-ConnectionGUID: a8QeDNI3TSS1AhvBjiHfCg==
X-CSE-MsgGUID: 65C7AnN6Shq5jZmVqFnTdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93545560"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93545560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:34:36 -0700
X-CSE-ConnectionGUID: X91ZYWm9RnKkfn75Ocav+w==
X-CSE-MsgGUID: HYeMX9fPQrGVMZXDAelHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="230396814"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:34:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:34:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:34:34 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaBblL6EUOh9ShrQWSgxpuhI++Krw+1fCBmA4T/8Gk3zmvdHCV8E0apMGAZb3fKFoTYRVKaXnW2oOJo4yRO1TZT4IMaIOLNDWv3j2bLZZpOthNXpj169sIGfPWlBMSM9P8TUObUB7xlSpJuGLEwUrWIyzGQhsZCmXbMveqqd92ZqvWp1PQ5WglzpaAxj2Duc4f3NiNOK3rEWJ6E9DFaGXsxoh4WmUczVYrwi6Twwb+qWgnyR34QxZcUvcJVv8VQXtHI3x4MxVTIY+/s+RZU8LV6ZsVMf3fN1qCSznC11rciGNSKDWnwOrqar/NhKj3RJfdKXISwW3YBdQ+PHwdz5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WKIPxIHukD2GaEKsgLWbnADhx1YSTNCUzgevEx+2lQ=;
 b=ZSQuU6YZjolqOn2mdKDMh/557qkj+r9Ao8aZR2eLygN05LOmWfuC9hVJlGlQd7FssAoJq/znFrX+Jbox/jrcBwQmPXft9+l7klk5r2R6tLc1ZqVGcVth4IvawyBEBxe6awdKpq5MVxEm9u3ufgYlT7lJ4p2jf5bz3jDDMFVHK8vLK3+4c+t37xonAHj7Y3niHcNrERDnvBE6L2KyVvs7HQJskng5eLQd/rZxlZ1LUKIn7TxDMXh1pOxjD2337nqdaizqF2v0nhL6SKkJDlToBHQzsu/KHdb2ibLbx9yJgv6pt7XhBeG4kMlMDnIs0RdS6ov5qYOUThDhXEfm618sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 10:34:32 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 10:34:32 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Topic: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert
 into TDX code
Thread-Index: AQHcviZaT9hdoOINrk+cMFGJgJNtlbXId5uA
Date: Tue, 31 Mar 2026 10:34:32 +0000
Message-ID: <4f36ce2e16be1f0b9edaf4fcc8becdc6b7ff02b5.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF25FF87461:EE_
x-ms-office365-filtering-correlation-id: 2829914e-1297-43a4-0e37-08de8f11188a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ftjSOyateGALNihx+5dAvwz7q9dcCV+AVbhuq1lZzFKDdLvNgoxLENl8lcm1FOvKyC3Ptu5wqlprvqp5PAvycPh8O67RWBypeUCHdgEGEDuXPMJreAGhwdDMndoQPnDPpTL6iSvA8yC1c8pumo+poU6USSqWfB/k8svIxodxIvdeSwb/FsJriXW86GssT5A/DSHt2MJsJhA7EqaJ53zMmRzBFeUYWqq80NTcZTFODAVrAMjrSyWhIctPS7rE2GbNL0JssnJgkVavretPdzLOebBVpuWqy3rQ8Yw7Nmj+ym2H6rY8ivDqicpgdEHTjK41VS3wgEUkYL0KTRPlLpK61RatZb/kJ+L7J7ZFDiycRM2d2q9WjPAkudYuXDq/Zd+SB21mR/jJya0En04l6zXQkSF+XCfe8h2qiuwrtF3udESoDsAnK2nvVz5oHNIWS1n8SrJfuI9pjNA+yOdldN4/qHBc85ChlzLCA592H897op+aQe+S7SkDxmLoSvayhDme0j/tAqgyGzmkHG6EKnDOschg4H7xh5tNK0+MCjUbwQF0cWBYC3mqgbsxxaZAV2l8IaLzIXFSLgeQgg7gT9ERovha4n9fMkc4PFBNobyLmL8/RRIFcz48y5tPPcG6OwDYjA4DcDCUQrrCARVKEX6cqN5XxvhXB750Lbn6VYR7CzJ4RS7Efuxdd0sSz+SlTsE6Rd1SZ3RomSp4aAb0mB2uE/rDvhoS/gQVIqHK+9G/6BD9snD/zHJb885pT1qOB0OogZ33PwQTBMDR8cAPgs9XXjP6XW5JPDxV1cITyBqC/7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhQYzUrOUJ6MWEyZUdnWkh4NGRxWjltaUdYZ0wxbHY5aEhWNUlKS0hacW5u?=
 =?utf-8?B?NGNNdC9keVI2YU10Zm9TMzB0aXdIZ2REcjRzcHFzRmxvdDhBSTdJYnpCUHE4?=
 =?utf-8?B?Rk00RnpyZHFhODFScGM5bzlXZU94UXNRQUVGV1U4QUYwZGVMOFZURkNOS0FI?=
 =?utf-8?B?eTZ3bWF2YWY0WjREcDhMQ3d3bXJWa3NRNHRjS05WU2RodmIyVnExaitsTzZL?=
 =?utf-8?B?MDllQUZTMjBkZTVEMkt1WUN4Zzg0eUg0Rms3NDk2V1UrenFGTDY3YkJLTG1J?=
 =?utf-8?B?OStPK3F6ZkgzUHJidzA1NTFOWC9FWVlrVVByWDNSa1VSMHdBekV2VHY4OWVm?=
 =?utf-8?B?YjZyMjJIcDh1YmN6VXRVaE15VytIN1hTNDNaSlZTZ2d6TlRwbml0dmNINmdk?=
 =?utf-8?B?K1ZZSFN3eEw0RFVkSzZBTERvWklIV2d2KzgwSEtFTkhHUllJOHBvNXB6YkpV?=
 =?utf-8?B?VkkyQXRvbFJ4QVU4QlpLWCtYYjFlUkRwVnlQTGRmWDZqWFVFZHVaQ0NYWFJP?=
 =?utf-8?B?amRvMjNOYnZkZVV5eUtodWJjOVRhSThISDFTaFRVdFpXWTJlMklibWJlaWtG?=
 =?utf-8?B?eWg0blBjSWUxWTFFa0p3V2ZxTitab0dyWUJoM3kwMFFFNkFiQUhFYzVRbHM3?=
 =?utf-8?B?dklrK21YSUNHWi9lREtmdUVFY0piZWgrM1FQb3JGcDJVSUdDaFFMaVdYcUg2?=
 =?utf-8?B?ODlhWWQ1VVNRTVQvVzM3YWE3RVVZOUJneXF2SlVObDE0QlBENTVmbDVmMGlV?=
 =?utf-8?B?VGNTWUxLSXdFbjdRWlkyeER0WVFLMHU2dmZIR2VkN1JkRGF6RG83QUdlVDl2?=
 =?utf-8?B?bnhlc204ZmRDaDBhejIwa1RWckJWcHlra2luYjIxM0xqaTk5cFJXaUFXbFNi?=
 =?utf-8?B?a1JTcit6NHR6Nnpsc2ZRcTFQcmd3anV1TnlqZUNiUFZxWCtJV3ZTeEJXT3Fp?=
 =?utf-8?B?eFlQdXZ3Qm1OdXFKU01VQzJGTnAydDFLekxJeFlsQ0xXVWdkbVlCRDFneWFB?=
 =?utf-8?B?NEtvTVptYnpXVFRqME1qQlhUcjhNVUFoa1FjSWg1OGs5UDg3aHFuUDFISURL?=
 =?utf-8?B?QkFBREp6QmZaQmNrdTV5bXV6V2VwZzBxeFNDczVGOGJUazM5L0N4d2lwYjBK?=
 =?utf-8?B?cFNQWFNZZG1BN214dm1VL2pla3lNNXlkc2tZbTZzQk5tSlNuci9LNWVIaUgx?=
 =?utf-8?B?Nlk2dzZRY3ExNDRpZ2lyMlZpMjB6OFF1MnVZTGxsalVadGk1d1BiZnNzTFFF?=
 =?utf-8?B?L1pVSElvc2xVN3oyU0NMYVpyUkdQSXNBb1JLZnJ0WHo2d1pGWWcxQXNJUW1z?=
 =?utf-8?B?TnJ5cnM1ZHd5dTh4T09EZmt6bXhwem1kejVTdFRsZDdpd21kYUN2NkRJYU5y?=
 =?utf-8?B?cmlXR1NFcEFHdVB6c0dhdzZWRjdGTGpacUdxUkhtb0g2Um8xTUVoYXVFT2V3?=
 =?utf-8?B?Q1ZEdVkwckhtRWJ0akh2MjhtWHIyalBNRWduUTAzVzlBUkhmcUVjbVNpUVVo?=
 =?utf-8?B?cnZTN25IRTFzSllqRlRRek0rYlVsVTlSV2k4NXFlLzMxblhHVEFUYVA0d0Ji?=
 =?utf-8?B?cUtybmJCcFExVzJOR29ITEY3RUprYW5tS0tENS94cDgzM1UzL0ZiZjV1SEhm?=
 =?utf-8?B?UmZLajFpT20vdjZpSW5aTk41aHV2UFN4U1FrZE15aTJVMHBBMkNvZTNoRy92?=
 =?utf-8?B?SWdtemtYQ3ZibjF5N2RkRUcxRVFENWZKcU1BcEZoWi93R2UyMStqc3ZGN29O?=
 =?utf-8?B?VlNlRGhWRVZONWVHMlhxclNJWmxVWVp3RDRvb1VDR1BXR0lnYXh3ZnJ5ZU5y?=
 =?utf-8?B?cUJNbEhsMjd5bXlWT3BkaFRKM00rcnZzRTBwUXV3UW9za1BLR04xSDBtR3R5?=
 =?utf-8?B?WnJHNFJuWjEva3BEcEh5Q00rRFBmMmFTSHpaSmpUMzN3TGk5OElRck9NWWJ2?=
 =?utf-8?B?d0VReFRjSU1tb3VRM0E2U3lya2RJWHdwc3pXNWZJeVBKOGVFdWlYY0ZrL1FG?=
 =?utf-8?B?RWJ6NVRwa29BRmwzc1VaK1hEV1dFaWNET3YrSzJOUXU4WTArVmdoYmhkaHVz?=
 =?utf-8?B?T3pwM0d3Wk10UFdwR0VpckNCRDh4NVdmWjViZGY4SnBZR1pOVCtFZ3BvdnRy?=
 =?utf-8?B?QzZ6clh0RjM0bzRtT1A2QndsQmFEUE9Jd2VxKytpVWJIN0ZkcUUxZE5oYzRz?=
 =?utf-8?B?YTRJT2NtVStKNUdYUmNadkJJRGFXVVkyb084VG5ydWlIenI0czVmWWhIRjdl?=
 =?utf-8?B?RDlSeFFDNVcxczlSUDFaSnl0MkhWakhsWmxsR09DTnBjelBlQ2orRlZFL1Jz?=
 =?utf-8?B?RXlsZ2JNWGFoanVKbWFqNEVWQ3pzMldFd0tFRG1Uc1hjUUJRL2U4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E99704B2706904D98B23390CCD5C8CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s3xvt+wpEVbHDQ685xDTz+6QWsW3mokhINWG0xGPTVgpfv/TRP9M8y+sfGpkiemIPR06HhWmSB1ehG/j/55Is6GuENzDxCroWKo+Y1HxZ1avZBtc1M0Dmzuc8Qostqk40/9GOovg52s1N+gVP58aKxuyG++2PJRffpONttPoGkJ00qNbh1vDOHRgn4h8wDCEZ+vZ3nrXK3bUvCd/UT5IeJby0L1P8bUN/DgS4bByaz3uBKoSXda6U6qmw03jZQtnt5KxTkGEOpaLpCFDjYVXj1kKdtTbBqZj9BkpStTwu0A8lIM3AeDQIyNe9mb5grG/frv1+OSa4s/592PCWg+QAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2829914e-1297-43a4-0e37-08de8f11188a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 10:34:32.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BL34MLshy8mPZyZbtM6TYW2waBNMYdNXD+E1yB7smcz+wx/x4uQFXABaHbRvrOrneSD/HvwdJrm6GtvS2RG8og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDEzOjE0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gTW92ZSB0aGUgTU1VIGxvY2tkZXAgYXNzZXJ0IGluIHNldF9leHRlcm5hbF9zcHRlX3ByZXNl
bnQoKSBpbnRvIHRoZSBURFgNCj4gc3BlY2lmaWMgb3AgYmVjYXVzZSB0aGUgYXNzZXJ0IGlzIFRE
WCBzcGVjaWZpYyBpbiBpbnRlbnRpb24uDQo+IA0KPiBUaGUgVERQIE1NVSBoYXMgbWFueSBsb2Nr
ZGVwIGFzc2VydHMgZm9yIHZhcmlvdXMgc2NlbmFyaW9zLCBhbmQgaW4gZmFjdA0KPiB0aGUgY2Fs
bGNoYWlucyB0aGF0IGFyZSB1c2VkIGZvciBURFggYWxyZWFkeSBoYXZlIGEgbG9ja2RlcCBhc3Nl
cnQgd2hpY2gNCj4gY292ZXIgdGhlIGNhc2UgaW4gc2V0X2V4dGVybmFsX3NwdGVfcHJlc2VudCgp
LsKgDQo+IA0KDQpjb3ZlciAtPiBjb3ZlcnMNCg0KPiBIb3dldmVyLCB0aGVzZSBhc3NlcnRzIGFy
ZQ0KPiBmb3IgbWFuYWdlbWVudCBvZiB0aGUgVERQIHJvb3Qgb3duZWQgYnkgS1ZNLiBJbiB0aGUN
Cj4gc2V0X2V4dGVybmFsX3NwdGVfcHJlc2VudCgpIGFzc2VydCBjYXNlLCBpdCBpcyBoZWxwaW5n
IHdpdGggYSBzY2hlbWUgdG8NCj4gYXZvaWQgY29udGVudGlvbiBpbiB0aGUgVERYIG1vZHVsZSBk
dXJpbmcgemFwIG9wZXJhdGlvbnMuIFRoYXQgaXMgdmVyeQ0KPiBURFggc3BlY2lmaWMuDQo+IA0K
PiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRvIGp1c3QgcmVtb3ZlIHRoZSBhc3NlcnQgaW4NCj4gc2V0
X2V4dGVybmFsX3NwdGVfcHJlc2VudCgpIGFuZCByZWx5IG9uIHRoZSBvdGhlciBvbmVzIGluIHRo
ZSBURFAgTU1VLiBCdXQNCj4gdGhhdCBhc3NlcnQgaXMgZm9yIGFuIGEgZGlmZmVyZW50IGludGVu
dGlvbiwgYW5kIHRvbyBmYXIgYXdheSBmcm9tIHRoZQ0KDQoiYW4gYSIgLT4gYQ0KDQo+IFNFQU1D
QUxMIHRoYXQgbmVlZHMgaXQuwqANCj4gDQoNCj4gU28gbW92ZSBqdXN0IG1vdmUgaXQgdG8gVERY
IGNvZGUuDQoNClNvIGp1c3QgbW92ZSBpdCAuLi4NCg0KDQo=
